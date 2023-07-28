Return-Path: <netdev+bounces-22170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4E376662D
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 10:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E64AC1C2183D
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 08:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE2FC8EA;
	Fri, 28 Jul 2023 07:59:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A8510949
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 07:59:09 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4F84699
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 00:58:51 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qPIMr-0008H9-UO
	for netdev@vger.kernel.org; Fri, 28 Jul 2023 09:58:33 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 8F2301FD29B
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 07:56:21 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 2B6D91FD1ED;
	Fri, 28 Jul 2023 07:56:19 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 91d2fa1b;
	Fri, 28 Jul 2023 07:56:17 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 15/21] can: gs_usb: gs_can_start_xmit(), gs_can_open(): clean up printouts in error path
Date: Fri, 28 Jul 2023 09:56:08 +0200
Message-Id: <20230728075614.1014117-16-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230728075614.1014117-1-mkl@pengutronix.de>
References: <20230728075614.1014117-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Remove unnecessary "out of memory" message from the error path of
gs_can_start_xmit() and gs_can_open().

Convert the printout in case of a failing usb_submit_urb() in
gs_can_open() from numbers to human readable error codes.

Link: https://lore.kernel.org/all/20230718-gs_usb-cleanups-v1-8-c3b9154ec605@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index e302d7d568aa..a5cab6a07002 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -741,10 +741,8 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
 		goto nomem_urb;
 
 	hf = kmalloc(dev->hf_size_tx, GFP_ATOMIC);
-	if (!hf) {
-		netdev_err(netdev, "No memory left for USB buffer\n");
+	if (!hf)
 		goto nomem_hf;
-	}
 
 	idx = txc->echo_id;
 
@@ -877,8 +875,6 @@ static int gs_can_open(struct net_device *netdev)
 			buf = kmalloc(dev->parent->hf_size_rx,
 				      GFP_KERNEL);
 			if (!buf) {
-				netdev_err(netdev,
-					   "No memory left for USB buffer\n");
 				rc = -ENOMEM;
 				goto out_usb_free_urb;
 			}
@@ -901,7 +897,8 @@ static int gs_can_open(struct net_device *netdev)
 					netif_device_detach(dev->netdev);
 
 				netdev_err(netdev,
-					   "usb_submit failed (err=%d)\n", rc);
+					   "usb_submit_urb() failed, error %pe\n",
+					   ERR_PTR(rc));
 
 				goto out_usb_unanchor_urb;
 			}
-- 
2.40.1



