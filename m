Return-Path: <netdev+bounces-18537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F6A7578F9
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 12:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA2F228114E
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 10:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF2DFBEC;
	Tue, 18 Jul 2023 10:10:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC6DC8D8
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 10:10:14 +0000 (UTC)
X-Greylist: delayed 144 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 18 Jul 2023 03:10:12 PDT
Received: from mail3-162.sinamail.sina.com.cn (mail3-162.sinamail.sina.com.cn [202.108.3.162])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA59E8
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 03:10:11 -0700 (PDT)
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([112.97.60.189])
	by sina.com (172.16.97.27) with ESMTP
	id 64B6646E000160DD; Tue, 18 Jul 2023 18:07:45 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 296715786923
From: Hillf Danton <hdanton@sina.com>
To: Maxime Jayat <maxime.jayat@mobile-devices.fr>
Cc: Michal Sojka <michal.sojka@cvut.cz>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dae R. Jeong" <threeearcat@gmail.com>,
	Hillf Danton <hdanton@sina.com>
Subject: Re: can: isotp: epoll breaks isotp_sendmsg
Date: Tue, 18 Jul 2023 18:07:33 +0800
Message-Id: <20230718100733.189-1-hdanton@sina.com>
In-Reply-To: <11328958-453f-447f-9af8-3b5824dfb041@munic.io>
References: <11328958-453f-447f-9af8-3b5824dfb041@munic.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30 2023, Maxime Jayat wrote:
> Hi,
>
> There is something not clear happening with the non-blocking behavior
> of ISO-TP sockets in the TX path, but more importantly, using epoll now
> completely breaks isotp_sendmsg.
> I believe it is related to
> 79e19fa79c ("can: isotp: isotp_ops: fix poll() to not report false 
> EPOLLOUT events"),
> but actually is probably deeper than that.
>
> I don't completely understand what is exactly going on, so I am sharing
> the problem I face:
>
> With an ISO-TP socket in non-blocking mode, using epoll seems to make
> isotp_sendmsg always return -EAGAIN.

Problem 1.

>
> By reverting 79e19fa79c, I get better results but still incorrect:

[...]

> It is then possible to write on the socket but the write is blocking,
> which is not the expected behavior for a non-blocking socket.

Problem 2.

My two cents with the two problems addressed.

--- x/net/can/isotp.c
+++ y/net/can/isotp.c
@@ -954,21 +954,18 @@ static int isotp_sendmsg(struct socket *
 	if (!so->bound || so->tx.state == ISOTP_SHUTDOWN)
 		return -EADDRNOTAVAIL;
 
-wait_free_buffer:
 	/* we do not support multiple buffers - for now */
-	if (wq_has_sleeper(&so->wait) && (msg->msg_flags & MSG_DONTWAIT))
-		return -EAGAIN;
-
-	/* wait for complete transmission of current pdu */
-	err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
-	if (err)
-		goto err_event_drop;
-
-	if (cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SENDING) != ISOTP_IDLE) {
+	while (cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SENDING) != ISOTP_IDLE) {
 		if (so->tx.state == ISOTP_SHUTDOWN)
 			return -EADDRNOTAVAIL;
 
-		goto wait_free_buffer;
+		if (msg->msg_flags & MSG_DONTWAIT)
+			return -EAGAIN;
+
+		/* wait for complete transmission of current pdu */
+		err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
+		if (err)
+			return err;
 	}
 
 	/* PDU size > default => try max_pdu_size */
--

