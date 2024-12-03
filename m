Return-Path: <netdev+bounces-148470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE909E1C8F
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 13:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79F35167AB7
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 12:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B8D1F428E;
	Tue,  3 Dec 2024 12:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VTeXo2Mj"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30781EF0B4;
	Tue,  3 Dec 2024 12:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733229818; cv=none; b=n9S9YDb8Z+cF3ARNi7Fvr3cvm37067qYZDy+OdQm2oR00tv8VQm39leFOU6sBSYTlT1zown0C/wHfXEPA3TlOqXfPw3YkIFkJ9IB8ho5M0/v7272Mv4nbXcd9n4v10hiQyG2Q53oirAL4hzOlmhF9vB65ANt7y5wPiIaAMyzhbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733229818; c=relaxed/simple;
	bh=43igvkxfpvS23gMxr7mNdw1yvbEsOKQFXD4DNZFMvkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SNLwKA+ddwkXvz0iNmArC0plYpV40pjS3FWOhK38MC1GU+qs1em6F8SbhJDcvFkr9KCDvQ2h3T2IxwymfNRQFG3sK1+9alyEJ4pppkCJxOteWI+j8NH0Ul0E70MUbFYFwjgBNWeFxEN8/IKPk0jrpLvw4TwqzbpCfqWxeWPDMAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VTeXo2Mj; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 11F4DE0010;
	Tue,  3 Dec 2024 12:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733229814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F1u0eeuSX4cb30X89CwQx+qR/vfxpPZBdpfTfsUK6pI=;
	b=VTeXo2MjeNeCnA0pgAtMBiOwjYEFVxDtbcCe2BCsPMaLaFqOSdUY8Wz4yogaefgoE2jgDJ
	AN1yJKClixBIIe8kvN509H3cHhd1GgJ1xV8JcReqCbmrWKYr8SBTn5ZKSXbAwvI8HXlcWB
	+0YJr92DeiSNMoZKvzaoHtV/g+8sdDmoEjXotPw3Uv0wFd75n/XIhfOd+0NagbIj6G/w1v
	JoRB1rynTzEFDF+O3Nn+ClSchRLzxjLWvDr4pNHBO9VDEli3prTi9MoBKkkSUlM5ynEh0S
	WMKQibomg5OWCuW7VTJyiYablk5g2ph2erdp09Fn+mXqNpeQlP62eiZZg6UhRA==
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
	Simon Horman <horms@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH net-next v3 07/10] net: freescale: ucc_geth: Hardcode the preamble length to 7 bytes
Date: Tue,  3 Dec 2024 13:43:18 +0100
Message-ID: <20241203124323.155866-8-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241203124323.155866-1-maxime.chevallier@bootlin.com>
References: <20241203124323.155866-1-maxime.chevallier@bootlin.com>
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

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V3: No changes

 drivers/net/ethernet/freescale/ucc_geth.c | 21 ---------------------
 drivers/net/ethernet/freescale/ucc_geth.h |  4 ++--
 2 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index 566f53e24d28..81aefe291d80 100644
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
index 2365b61c743a..dfb727327093 100644
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


