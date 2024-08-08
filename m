Return-Path: <netdev+bounces-116759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6430194B9DE
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FB8A1C21E0D
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 09:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022D5189909;
	Thu,  8 Aug 2024 09:40:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8F5183CCB;
	Thu,  8 Aug 2024 09:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723110041; cv=none; b=shqu06kY3vCt+paEMybUeGJqE5bg3FgFVWeNEDG3ylhpw408MHeg47bUDovAYKauGyBlJBroTl0F+xQcaPbnJLSKmTfqUgJj189nYHPIqFgYht1xGfC7y49x2vJjzpAoAJcfURchGQZA1sO4a2dpE/mTsUduVObmMntp6IC4D9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723110041; c=relaxed/simple;
	bh=DnD+bf00OH0YLBL5a97bzqdxIHbvB01ieBaBHoYDaDs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=pFu8wYsV8Ntca4BHtxbJm38wGLtw0BDcXW+tV2r5QTCB7D//MnfPD7J639UTi6F9LBgpVqUZb/aeRckgvSoLurJ1Lc2uCFr78T/DlFLCE+5cMVrySmJd/6dMVVw8jp2u88vVMk3P7FEplgKsZFNdn1muRgHSeIfNIuPkceu7F18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 400ec0cc556a11efa216b1d71e6e1362-20240808
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:934d2e13-3322-467b-8e92-d9d2f04e3270,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:d28ba388d435b4aa5ab101143f72f30a,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,URL:0
	,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 400ec0cc556a11efa216b1d71e6e1362-20240808
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <zhangxiangqian@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 358713568; Thu, 08 Aug 2024 17:40:30 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id F24EC16002084;
	Thu,  8 Aug 2024 17:40:29 +0800 (CST)
X-ns-mid: postfix-66B4928C-8721841160
Received: from localhost.localdomain (unknown [172.25.83.26])
	by node4.com.cn (NSMail) with ESMTPA id B59D116002084;
	Thu,  8 Aug 2024 09:40:27 +0000 (UTC)
From: zhangxiangqian <zhangxiangqian@kylinos.cn>
To: oliver@neukum.org
Cc: davem@davemloft.net,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangxiangqian <zhangxiangqian@kylinos.cn>
Subject: [PATCH] net: usb: cdc_ether: don't spew notifications
Date: Thu,  8 Aug 2024 17:39:45 +0800
Message-Id: <1723109985-11996-1-git-send-email-zhangxiangqian@kylinos.cn>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The usbnet_link_change function is not called, if the link has not changed.

...
[16913.807393][ 3] cdc_ether 1-2:2.0 enx00e0995fd1ac: kevent 12 may have been dropped
[16913.822266][ 2] cdc_ether 1-2:2.0 enx00e0995fd1ac: kevent 12 may have been dropped
[16913.826296][ 2] cdc_ether 1-2:2.0 enx00e0995fd1ac: kevent 11 may have been dropped
...

kevent 11 is scheduled too frequently and may affect other event schedules.

Signed-off-by: zhangxiangqian <zhangxiangqian@kylinos.cn>
---
 drivers/net/usb/cdc_ether.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
index 6d61052..a646923 100644
--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -418,7 +418,8 @@ void usbnet_cdc_status(struct usbnet *dev, struct urb *urb)
 	case USB_CDC_NOTIFY_NETWORK_CONNECTION:
 		netif_dbg(dev, timer, dev->net, "CDC: carrier %s\n",
 			  event->wValue ? "on" : "off");
-		usbnet_link_change(dev, !!event->wValue, 0);
+		if (netif_carrier_ok(dev->net) != !!event->wValue)
+			usbnet_link_change(dev, !!event->wValue, 0);
 		break;
 	case USB_CDC_NOTIFY_SPEED_CHANGE:	/* tx/rx rates */
 		netif_dbg(dev, timer, dev->net, "CDC: speed change (len %d)\n",
-- 
2.7.4


