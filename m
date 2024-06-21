Return-Path: <netdev+bounces-105577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31366911E0D
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 10:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51A8F1C20896
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 08:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E0017167A;
	Fri, 21 Jun 2024 08:02:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0418C171094
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 08:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956935; cv=none; b=MeA2A7nLPhbWH1opfm/oRwIkO/lMCsSf01MlXgIXGg/frkpQj27MNBNpjVnEykbzKINKOMUOG7/w6GWrK2rPxDzmoY9reSHwQWVSLb1FzL2/j+X7iskN/i00E0fvBE1sGbz7SAHKeRkGL1034jlRzc0zz7XBedAYhhzpnT5UMk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956935; c=relaxed/simple;
	bh=SuR8SJSI3koMzK//eHX5vRzmKUn3/C2V5p2wjgu632Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=js0ccc3wl3Rh0kcojQxodYbKkGn3NXPn0MSxrh2whiS5FbsfYrOwjoijIynDzdnL6acZ3WNkd8AkYFxhc6v+SOePhbTIChjUyUdMF72IavNmw2C30NLTaKii6vXQriILwyjH2ALV4CfI31lSmom/yLhCzaAiPTDYlL1NA1jnHcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZDm-00044u-Ps
	for netdev@vger.kernel.org; Fri, 21 Jun 2024 10:02:10 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZDi-003tJt-UU
	for netdev@vger.kernel.org; Fri, 21 Jun 2024 10:02:06 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 582BE2EE40F
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 08:02:06 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 3E86C2EE39D;
	Fri, 21 Jun 2024 08:02:03 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 8a6d8a2f;
	Fri, 21 Jun 2024 08:02:02 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Martin Jocic <martin.jocic@kvaser.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 09/24] can: kvaser_usb: Add support for Vining 800
Date: Fri, 21 Jun 2024 09:48:29 +0200
Message-ID: <20240621080201.305471-10-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240621080201.305471-1-mkl@pengutronix.de>
References: <20240621080201.305471-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

From: Martin Jocic <martin.jocic@kvaser.com>

Add support for Vining 800, a branded device based on the hydra
platform.

Signed-off-by: Martin Jocic <martin.jocic@kvaser.com>
Link: https://lore.kernel.org/all/20240612141946.3352364-2-martin.jocic@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/Kconfig                      | 1 +
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
index bd58c636d465..d01b46a8071a 100644
--- a/drivers/net/can/usb/Kconfig
+++ b/drivers/net/can/usb/Kconfig
@@ -117,6 +117,7 @@ config CAN_KVASER_USB
 	    - Kvaser U100S
 	    - ATI Memorator Pro 2xHS v2
 	    - ATI USBcan Pro 2xHS v2
+	    - Vining 800
 
 	  If unsure, say N.
 
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 8faf8a462c05..b828fad123b2 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -89,6 +89,7 @@
 #define USB_HYBRID_CANLIN_PRODUCT_ID 0x0115
 #define USB_HYBRID_PRO_CANLIN_PRODUCT_ID 0x0116
 #define USB_LEAF_V3_PRODUCT_ID 0x0117
+#define USB_VINING_800_PRODUCT_ID 0x0119
 
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_hydra = {
 	.quirks = KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
@@ -238,6 +239,8 @@ static const struct usb_device_id kvaser_usb_table[] = {
 		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_hydra },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_V3_PRODUCT_ID),
 		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_hydra },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_VINING_800_PRODUCT_ID),
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_hydra },
 	{ }
 };
 MODULE_DEVICE_TABLE(usb, kvaser_usb_table);
-- 
2.43.0



