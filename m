Return-Path: <netdev+bounces-105581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90631911E14
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 10:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 452011F267AE
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 08:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9519F171E61;
	Fri, 21 Jun 2024 08:02:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262BC17164B
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 08:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956936; cv=none; b=olnIp3uWZ0/VIWCC3KkcvMp7BjKTQKbR+ufoMYUGQz78c/+Q8dygC0GNRlnqcIKy0NOQNMd0jc3dz8qPV0agDQWj/9UiEQf5KCnejXlMZpD7PzHVi4e/rIBG689JvJP+VqbhcZKDxpUBe1IDlcMfkb7y7qFOpPKyDCOtc3xzCq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956936; c=relaxed/simple;
	bh=IYfBi9B5HmX0DgY6CAmuWxOP8mU1Lghw7j5woaYY4Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pUjbPlcqsImmIk4XGMQMfiKtLGD/gXjOcRkSir1IbaFEP65a2L/bQp5Ct3b57vmIAPCEabuhi6Ax2EMk/9TscTwlJ+Ygo1HuOppO2L7W3/2oWTjAgJ22+uG0n2mgtrzP4nrMgfgdjaOHN+i4dGb1sUbehCSDj6j74mwyxTQe+98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZDn-000456-TD
	for netdev@vger.kernel.org; Fri, 21 Jun 2024 10:02:11 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZDi-003tK0-Vu
	for netdev@vger.kernel.org; Fri, 21 Jun 2024 10:02:07 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 778562EE411
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 08:02:06 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 6C5E82EE3A3;
	Fri, 21 Jun 2024 08:02:03 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 492db54d;
	Fri, 21 Jun 2024 08:02:02 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Martin Jocic <martin.jocic@kvaser.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 11/24] can: kvaser_usb: Add support for Kvaser Mini PCIe 1xCAN
Date: Fri, 21 Jun 2024 09:48:31 +0200
Message-ID: <20240621080201.305471-12-mkl@pengutronix.de>
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

Add support for Kvaser Mini PCIe 1xCAN, based on the hydra platform.

Signed-off-by: Martin Jocic <martin.jocic@kvaser.com>
Link: https://lore.kernel.org/all/20240612141946.3352364-4-martin.jocic@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/Kconfig                      | 1 +
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
index 641bbc24464a..3e1fba12c0c3 100644
--- a/drivers/net/can/usb/Kconfig
+++ b/drivers/net/can/usb/Kconfig
@@ -91,6 +91,7 @@ config CAN_KVASER_USB
 	    - Kvaser Leaf Light R v2
 	    - Kvaser Mini PCI Express HS
 	    - Kvaser Mini PCI Express 2xHS
+	    - Kvaser Mini PCIe 1xCAN
 	    - Kvaser USBcan Light 2xHS
 	    - Kvaser USBcan II HS/HS
 	    - Kvaser USBcan II HS/LS
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 1416619c94ef..6c70eb1ceb8b 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -91,6 +91,7 @@
 #define USB_LEAF_V3_PRODUCT_ID 0x0117
 #define USB_VINING_800_PRODUCT_ID 0x0119
 #define USB_USBCAN_PRO_5XCAN_PRODUCT_ID 0x011A
+#define USB_MINI_PCIE_1XCAN_PRODUCT_ID 0x011B
 
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_hydra = {
 	.quirks = KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
@@ -244,6 +245,8 @@ static const struct usb_device_id kvaser_usb_table[] = {
 		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_hydra },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_USBCAN_PRO_5XCAN_PRODUCT_ID),
 		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_hydra },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_MINI_PCIE_1XCAN_PRODUCT_ID),
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_hydra },
 	{ }
 };
 MODULE_DEVICE_TABLE(usb, kvaser_usb_table);
-- 
2.43.0



