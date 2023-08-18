Return-Path: <netdev+bounces-28671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88EE780395
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 03:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45694282286
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 01:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB96F65E;
	Fri, 18 Aug 2023 01:58:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C54398
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 01:58:23 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305581AE
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 18:58:22 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d66d85403f5so540676276.2
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 18:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692323901; x=1692928701;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UR1USQJU6O719ydnoedciRN+N7OIWd2UwSz37wPOIuQ=;
        b=AWe6Tw/NIIomWjOQkaS6PzSI9+a//hPRkZynEhiFqMMoVpFpnkDKhzF/LAusiGhl/O
         xBnMfUoquoqokFzAbQ34nmQSFIkTNX4Dc7VAzbNmMGgeA3Mip/0pbU8jyGebw5QHwe05
         f06tyOZGDyFzyLBO+7o+usdiPNsvjt8Yjkn7EobcWHtEGAFM4vpfNXMIrA1if6NSOZZC
         46511+0kp5TDJRf+HPrkMOdd0S4ZhqBttLtsMw50CHXebO+zhVdBAqh0R3llQkfvvYOa
         t+zt8JydYkXYN4TYckZiGFOCNqCDWcdrq5Zf5fTCggoN8F2Cl5+cPPUSsWV68+YdHKsM
         1Lsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692323901; x=1692928701;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UR1USQJU6O719ydnoedciRN+N7OIWd2UwSz37wPOIuQ=;
        b=ASWBr+UyOzRco//1SOogZNo1prdOzi1WFlmKo2Cdw4yZTUVuWWj4PIgdwqmSVvzZik
         SaaDkuUlystvDTESkHRQck2fv43TsLanKMsAb+cBISXKEdhpqVQ/pxXPvwS8czCdNgdm
         S34izoVFLpFPtig2h9Q1BhX++FxYV0HjHet2zXxKpgV5mjCPRCkfNn6GhsSEFBPUWWCS
         J6BB/27EfVOJL4caAEa2Lugi8ZUlVHRb/AyUlkO/O3LQP4MP27PRHR9CAR/aqiqk6zQx
         7HDeGmzbts8PWgBFY9JZIxqd0pWlxwCZyTx0D0yCc+P7J7iGke1Tyj7cWBY3nR6Uk+bl
         wiLw==
X-Gm-Message-State: AOJu0Yw4xN24PtsDIBkOTQ/VP5/GIYacHqw3MlEFR7Sx5RRqT6ZPN3yk
	pyBOE5YGWeD35Xga40q0jjLno6N3SSS2gg==
X-Google-Smtp-Source: AGHT+IFCAdtyBFHOW5C5acMAiEWLmeDsUQH9cQW4OIy+KK+oMFalLAezi8AIfrj8l374+KcgVAet3DE0ZsxPDw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1103:b0:d51:577e:425d with SMTP
 id o3-20020a056902110300b00d51577e425dmr20764ybu.12.1692323901487; Thu, 17
 Aug 2023 18:58:21 -0700 (PDT)
Date: Fri, 18 Aug 2023 01:58:20 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230818015820.2701595-1-edumazet@google.com>
Subject: [PATCH net] dccp: annotate data-races in dccp_poll()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We changed tcp_poll() over time, bug never updated dccp.

Note that we also could remove dccp instead of maintaining it.

Fixes: 7c657876b63c ("[DCCP]: Initial implementation")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/dccp/proto.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/net/dccp/proto.c b/net/dccp/proto.c
index 4e3266e4d7c3c4595ac7f0f8e5e48c0cc98724de..fcc5c9d64f4661774ec20e78cb007ddd47662286 100644
--- a/net/dccp/proto.c
+++ b/net/dccp/proto.c
@@ -315,11 +315,15 @@ EXPORT_SYMBOL_GPL(dccp_disconnect);
 __poll_t dccp_poll(struct file *file, struct socket *sock,
 		       poll_table *wait)
 {
-	__poll_t mask;
 	struct sock *sk = sock->sk;
+	__poll_t mask;
+	u8 shutdown;
+	int state;
 
 	sock_poll_wait(file, sock, wait);
-	if (sk->sk_state == DCCP_LISTEN)
+
+	state = inet_sk_state_load(sk);
+	if (state == DCCP_LISTEN)
 		return inet_csk_listen_poll(sk);
 
 	/* Socket is not locked. We are protected from async events
@@ -328,20 +332,21 @@ __poll_t dccp_poll(struct file *file, struct socket *sock,
 	 */
 
 	mask = 0;
-	if (sk->sk_err)
+	if (READ_ONCE(sk->sk_err))
 		mask = EPOLLERR;
+	shutdown = READ_ONCE(sk->sk_shutdown);
 
-	if (sk->sk_shutdown == SHUTDOWN_MASK || sk->sk_state == DCCP_CLOSED)
+	if (shutdown == SHUTDOWN_MASK || state == DCCP_CLOSED)
 		mask |= EPOLLHUP;
-	if (sk->sk_shutdown & RCV_SHUTDOWN)
+	if (shutdown & RCV_SHUTDOWN)
 		mask |= EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
 
 	/* Connected? */
-	if ((1 << sk->sk_state) & ~(DCCPF_REQUESTING | DCCPF_RESPOND)) {
+	if ((1 << state) & ~(DCCPF_REQUESTING | DCCPF_RESPOND)) {
 		if (atomic_read(&sk->sk_rmem_alloc) > 0)
 			mask |= EPOLLIN | EPOLLRDNORM;
 
-		if (!(sk->sk_shutdown & SEND_SHUTDOWN)) {
+		if (!(shutdown & SEND_SHUTDOWN)) {
 			if (sk_stream_is_writeable(sk)) {
 				mask |= EPOLLOUT | EPOLLWRNORM;
 			} else {  /* send SIGIO later */
@@ -359,7 +364,6 @@ __poll_t dccp_poll(struct file *file, struct socket *sock,
 	}
 	return mask;
 }
-
 EXPORT_SYMBOL_GPL(dccp_poll);
 
 int dccp_ioctl(struct sock *sk, int cmd, int *karg)
-- 
2.42.0.rc1.204.g551eb34607-goog


