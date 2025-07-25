Return-Path: <netdev+bounces-209998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3D9B11C1B
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 12:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57421CC33E9
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 10:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA2A2E11C9;
	Fri, 25 Jul 2025 10:16:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A721EE03B
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 10:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438586; cv=none; b=J2cmVeSoTXguCxW2qqnV2nn4tLB2KZNSa4WNzs2FV/MRz89cXcISCLcraSXmg0fxm2YkkVMnDI6eD5mOVA8hmq1ukcPDNVGwERHU3H+mNw4dc0ZQDcH/eaXIfDqiy0QSqj66wB2IOkG377lBqn9QqYuRsUgnDK/AnRfsbvIsyY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438586; c=relaxed/simple;
	bh=zUQ0a5BjTIEuQurgh4R4UucIrWWW03YHYLsNEK9gRDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N1h1yuVUInf3t0CdfRc5a/LRJij7Is4Rt8YK6vJFKECvhw0Li2B6ovwTwL3FE/HxQ1BkDsg0yC/4pjyKTAYDe11vROjDgS/cGpu5x2RQ6DA8CJuRzapr09gnimMMcKvtlIq+9CjPk0/ZpovtTy/w/OTsPGHqwy1uJXnvrP+Nwt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufFTT-0006Nl-3W
	for netdev@vger.kernel.org; Fri, 25 Jul 2025 12:16:23 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufFTS-00ACaR-2w
	for netdev@vger.kernel.org;
	Fri, 25 Jul 2025 12:16:22 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 9774F4493C5
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 10:16:22 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id E565D4493B8;
	Fri, 25 Jul 2025 10:16:20 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 53182f68;
	Fri, 25 Jul 2025 10:16:19 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Stephane Grosjean <stephane.grosjean@hms-networks.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net] can: peak_usb: fix USB FD devices potential malfunction
Date: Fri, 25 Jul 2025 12:13:49 +0200
Message-ID: <20250725101619.4095105-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725101619.4095105-1-mkl@pengutronix.de>
References: <20250725101619.4095105-1-mkl@pengutronix.de>
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

From: Stephane Grosjean <stephane.grosjean@hms-networks.com>

The latest firmware versions of USB CAN FD interfaces export the EP numbers
to be used to dialog with the device via the "type" field of a response to
a vendor request structure, particularly when its value is greater than or
equal to 2.

Correct the driver's test of this field.

Fixes: 4f232482467a ("can: peak_usb: include support for a new MCU")
Signed-off-by: Stephane Grosjean <stephane.grosjean@hms-networks.com>
Link: https://patch.msgid.link/20250724081550.11694-1-stephane.grosjean@free.fr
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
[mkl: rephrase commit message]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 4d85b29a17b7..ebefc274b50a 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -49,7 +49,7 @@ struct __packed pcan_ufd_fw_info {
 	__le32	ser_no;		/* S/N */
 	__le32	flags;		/* special functions */
 
-	/* extended data when type == PCAN_USBFD_TYPE_EXT */
+	/* extended data when type >= PCAN_USBFD_TYPE_EXT */
 	u8	cmd_out_ep;	/* ep for cmd */
 	u8	cmd_in_ep;	/* ep for replies */
 	u8	data_out_ep[2];	/* ep for CANx TX */
@@ -982,10 +982,11 @@ static int pcan_usb_fd_init(struct peak_usb_device *dev)
 			dev->can.ctrlmode |= CAN_CTRLMODE_FD_NON_ISO;
 		}
 
-		/* if vendor rsp is of type 2, then it contains EP numbers to
-		 * use for cmds pipes. If not, then default EP should be used.
+		/* if vendor rsp type is greater than or equal to 2, then it
+		 * contains EP numbers to use for cmds pipes. If not, then
+		 * default EP should be used.
 		 */
-		if (fw_info->type != cpu_to_le16(PCAN_USBFD_TYPE_EXT)) {
+		if (le16_to_cpu(fw_info->type) < PCAN_USBFD_TYPE_EXT) {
 			fw_info->cmd_out_ep = PCAN_USBPRO_EP_CMDOUT;
 			fw_info->cmd_in_ep = PCAN_USBPRO_EP_CMDIN;
 		}
@@ -1018,11 +1019,11 @@ static int pcan_usb_fd_init(struct peak_usb_device *dev)
 	dev->can_channel_id =
 		le32_to_cpu(pdev->usb_if->fw_info.dev_id[dev->ctrl_idx]);
 
-	/* if vendor rsp is of type 2, then it contains EP numbers to
-	 * use for data pipes. If not, then statically defined EP are used
-	 * (see peak_usb_create_dev()).
+	/* if vendor rsp type is greater than or equal to 2, then it contains EP
+	 * numbers to use for data pipes. If not, then statically defined EP are
+	 * used (see peak_usb_create_dev()).
 	 */
-	if (fw_info->type == cpu_to_le16(PCAN_USBFD_TYPE_EXT)) {
+	if (le16_to_cpu(fw_info->type) >= PCAN_USBFD_TYPE_EXT) {
 		dev->ep_msg_in = fw_info->data_in_ep;
 		dev->ep_msg_out = fw_info->data_out_ep[dev->ctrl_idx];
 	}

base-commit: c8f13134349b4385ae739f1efe403d5d3949ef92
-- 
2.47.2



