Return-Path: <netdev+bounces-210089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98329B1218F
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 18:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0179B1887F45
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 16:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D00F2EF9D1;
	Fri, 25 Jul 2025 16:13:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214F72EF676
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 16:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460020; cv=none; b=l1qAzvIYQlhkmaod7tIEgm0bC/psAXgF0/yD/IrlFsm+2SWFE0YDZJnPTkbr7IXfnhPdRgaJ4k/f46dvRPa2W7Bwg6wzyB9ZcCioWpsm3pkKCgXMznSKO7ZUfSRXv1SWN0OnjLKQngHXYgZ9RE7URxeBN7el4JHr9RRNbGjO7RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460020; c=relaxed/simple;
	bh=6IcQVZz+Xj0Wb6gJO799mpZCInect74mv1DSKMFXz4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H5BhIzu35d+sNV1d8cYhzqVKYMQYC4v5GcUAqqWOi+J4WzfagZG9Z8/X9rZj73R3l36o4bEjvWK84RqoiNElkuOuzJPYg8Ach4ugwgqIJP6fDoJ9ehZRvu+Ng15ubHF0LEGd3BIhvt4Rpov3pddl2vXfl7JJ9969HGW95x1OoWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL3B-0006dz-0w
	for netdev@vger.kernel.org; Fri, 25 Jul 2025 18:13:37 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL38-00AFYd-1f
	for netdev@vger.kernel.org;
	Fri, 25 Jul 2025 18:13:34 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 7279144988A
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 16:13:33 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 76FD244981B;
	Fri, 25 Jul 2025 16:13:30 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id faae75d2;
	Fri, 25 Jul 2025 16:13:29 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Jimmy Assarsson <extja@kvaser.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 10/27] can: kvaser_pciefd: Store the different firmware version components in a struct
Date: Fri, 25 Jul 2025 18:05:20 +0200
Message-ID: <20250725161327.4165174-11-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725161327.4165174-1-mkl@pengutronix.de>
References: <20250725161327.4165174-1-mkl@pengutronix.de>
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

From: Jimmy Assarsson <extja@kvaser.com>

Store firmware version in kvaser_pciefd_fw_version struct, specifying the
different components of the version number.
And drop debug prinout of firmware version, since later patches will expose
it via the devlink interface.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Link: https://patch.msgid.link/20250725123230.8-5-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/kvaser_pciefd.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 4bdb1132ecf9..7153b9ea0d3d 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -325,6 +325,12 @@ struct kvaser_pciefd_driver_data {
 	const struct kvaser_pciefd_dev_ops *ops;
 };
 
+struct kvaser_pciefd_fw_version {
+	u8 major;
+	u8 minor;
+	u16 build;
+};
+
 static const struct kvaser_pciefd_address_offset kvaser_pciefd_altera_address_offset = {
 	.serdes = 0x1000,
 	.pci_ien = 0x50,
@@ -437,6 +443,7 @@ struct kvaser_pciefd {
 	u32 bus_freq;
 	u32 freq;
 	u32 freq_to_ticks_div;
+	struct kvaser_pciefd_fw_version fw_version;
 };
 
 struct kvaser_pciefd_rx_packet {
@@ -1205,14 +1212,12 @@ static int kvaser_pciefd_setup_board(struct kvaser_pciefd *pcie)
 	u32 version, srb_status, build;
 
 	version = ioread32(KVASER_PCIEFD_SYSID_ADDR(pcie) + KVASER_PCIEFD_SYSID_VERSION_REG);
+	build = ioread32(KVASER_PCIEFD_SYSID_ADDR(pcie) + KVASER_PCIEFD_SYSID_BUILD_REG);
 	pcie->nr_channels = min(KVASER_PCIEFD_MAX_CAN_CHANNELS,
 				FIELD_GET(KVASER_PCIEFD_SYSID_VERSION_NR_CHAN_MASK, version));
-
-	build = ioread32(KVASER_PCIEFD_SYSID_ADDR(pcie) + KVASER_PCIEFD_SYSID_BUILD_REG);
-	dev_dbg(&pcie->pci->dev, "Version %lu.%lu.%lu\n",
-		FIELD_GET(KVASER_PCIEFD_SYSID_VERSION_MAJOR_MASK, version),
-		FIELD_GET(KVASER_PCIEFD_SYSID_VERSION_MINOR_MASK, version),
-		FIELD_GET(KVASER_PCIEFD_SYSID_BUILD_SEQ_MASK, build));
+	pcie->fw_version.major = FIELD_GET(KVASER_PCIEFD_SYSID_VERSION_MAJOR_MASK, version);
+	pcie->fw_version.minor = FIELD_GET(KVASER_PCIEFD_SYSID_VERSION_MINOR_MASK, version);
+	pcie->fw_version.build = FIELD_GET(KVASER_PCIEFD_SYSID_BUILD_SEQ_MASK, build);
 
 	srb_status = ioread32(KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_STAT_REG);
 	if (!(srb_status & KVASER_PCIEFD_SRB_STAT_DMA)) {
-- 
2.47.2



