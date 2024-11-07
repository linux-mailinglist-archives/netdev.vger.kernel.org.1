Return-Path: <netdev+bounces-142958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C85B29C0C63
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 18:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DFE01F24F4E
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2D921A6F3;
	Thu,  7 Nov 2024 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gL7HIIkf"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CD5218D61;
	Thu,  7 Nov 2024 17:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730998993; cv=none; b=k55SirDL8rgw2ijGf+QV1fS5v9V6jB6DITdy0LwRX4S+DPV2lc2LdihnJXGH9RFNnCRsK65yHFFYGMPX87z8SrXMhfogM0OjaLU3FtTXNAL0WZoaFkEx+AAr52eOf5NFaiqu45nZl2ZJ8Sy721BVBbkzG99dwHJ7ZsSmehssxBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730998993; c=relaxed/simple;
	bh=Lhs1dQTYwfDHSvY/gsp9zOmiEAnOfvfLRW0dQSh7C4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uvUzg/6Yw0bEGCQnI8YVaf7zFEr2+haghXB3NkjFil50MF+exr7GhfofTsmqjlvZO77YbEyTEJgGeb5pRGYjpH4NpU8beg0/1wG2wEeqbYHJYceXhcrPv7qqFP91pSCce2QC89zISUhJiY558625J+HQ095ulJbOHcDHtsTAceg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gL7HIIkf; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AA182240006;
	Thu,  7 Nov 2024 17:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730998989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LcmFNs2UjHF2seWXnbhiKrx6T4lA+AWcoBvcBEDQo4w=;
	b=gL7HIIkf64DmSq12+2fZFwZNq2BuXb2hWXy3wfx626EcLpbIHw2+ffkNpb6lrLaAA46qtN
	Cf88txgGVeSsJvPXfh+obTv5d7Zre8jDI99hzOzQDAVqoyz3efyAhRxnmtYKDFv5Cd4p4J
	aAmnGxxD5FSTCDTPENFiPIN8JyO2sM+wiRG+/b+qFknMj1BeyC0kZyS6UthuDm3j642vMz
	lEplHQtL7cISPkSx9K8IaLhlGe8Uv5ECbC3xa2GZP4Z+cVuSJCp87Eg2+DgVobbbCneQrP
	HhPDX+9JxyXsU8TWvIhrDZimjelafml3mAatiRIW4YYP0A5LvyBLHrf6u8RmLA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Herve Codina <herve.codina@bootlin.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH net-next 6/7] net: freescale: ucc_geth: Hardcode the preamble length to 7 bytes
Date: Thu,  7 Nov 2024 18:02:53 +0100
Message-ID: <20241107170255.1058124-7-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107170255.1058124-1-maxime.chevallier@bootlin.com>
References: <20241107170255.1058124-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

The preamble length can be configured in ucc_geth, however it just
ends-up always being configured to 7 bytes, as nothing ever changes the
default value of 7.

Make that value the default value when the MACCFG2 register gets
initialized, and remove the code to configure that value altogether.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/freescale/ucc_geth.c | 21 ---------------------
 drivers/net/ethernet/freescale/ucc_geth.h |  4 ++--
 2 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index 052f06d6f312..0ec4ea95ad6d 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -132,7 +132,6 @@ static const struct ucc_geth_info ugeth_primary_info = {
 	.transmitFlowControl = 1,
 	.maxGroupAddrInHash = 4,
 	.maxIndAddrInHash = 4,
-	.prel = 7,
 	.maxFrameLength = 1518+16, /* Add extra bytes for VLANs etc. */
 	.minFrameLength = 64,
 	.maxD1Length = 1520+16, /* Add extra bytes for VLANs etc. */
@@ -1205,18 +1204,6 @@ static int init_mac_station_addr_regs(u8 address_byte_0,
 	return 0;
 }
 
-static int init_preamble_length(u8 preamble_length,
-				u32 __iomem *maccfg2_register)
-{
-	if ((preamble_length < 3) || (preamble_length > 7))
-		return -EINVAL;
-
-	clrsetbits_be32(maccfg2_register, MACCFG2_PREL_MASK,
-			preamble_length << MACCFG2_PREL_SHIFT);
-
-	return 0;
-}
-
 static int init_rx_parameters(int reject_broadcast,
 			      int receive_short_frames,
 			      int promiscuous, u32 __iomem *upsmr_register)
@@ -1276,7 +1263,6 @@ static int adjust_enet_interface(struct ucc_geth_private *ugeth)
 	struct ucc_geth_info *ug_info;
 	struct ucc_geth __iomem *ug_regs;
 	struct ucc_fast __iomem *uf_regs;
-	int ret_val;
 	u32 upsmr, maccfg2;
 	u16 value;
 
@@ -1352,13 +1338,6 @@ static int adjust_enet_interface(struct ucc_geth_private *ugeth)
 		put_device(&tbiphy->mdio.dev);
 	}
 
-	ret_val = init_preamble_length(ug_info->prel, &ug_regs->maccfg2);
-	if (ret_val != 0) {
-		if (netif_msg_probe(ugeth))
-			pr_err("Preamble length must be between 3 and 7 inclusive\n");
-		return ret_val;
-	}
-
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/freescale/ucc_geth.h b/drivers/net/ethernet/freescale/ucc_geth.h
index 11e490398f18..42fbbdf14ff2 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.h
+++ b/drivers/net/ethernet/freescale/ucc_geth.h
@@ -921,7 +921,8 @@ struct ucc_geth_hardware_statistics {
 #define UCC_GETH_UPSMR_INIT                     UCC_GETH_UPSMR_RES1
 
 #define UCC_GETH_MACCFG1_INIT                   0
-#define UCC_GETH_MACCFG2_INIT                   (MACCFG2_RESERVED_1)
+#define UCC_GETH_MACCFG2_INIT                   (MACCFG2_RESERVED_1 | \
+						 (7 << MACCFG2_PREL_SHIFT))
 
 /* Ethernet Address Type. */
 enum enet_addr_type {
@@ -1113,7 +1114,6 @@ struct ucc_geth_info {
 	int transmitFlowControl;
 	u8 maxGroupAddrInHash;
 	u8 maxIndAddrInHash;
-	u8 prel;
 	u16 maxFrameLength;
 	u16 minFrameLength;
 	u16 maxD1Length;
-- 
2.47.0


