Return-Path: <netdev+bounces-148469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BA99E1C89
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 13:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D9F1284718
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 12:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994031F1306;
	Tue,  3 Dec 2024 12:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="H5MDgasx"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609821EB9E9;
	Tue,  3 Dec 2024 12:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733229816; cv=none; b=PYOFlS+STR9C0l7p2gfcIPgCLv/L4L64KSxZMLIrAryrXK2NZffbH8BqOvZLc8AlecvYKsKEo3cTCKSVkL2CCOoC/BZzvLvIHMOhc1ZETdhD2HP2oNoTBIgpTOQA+Tj238kLaQY1jUDb4AhbQaYNfsinvUQws4J3QoJu8rMalbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733229816; c=relaxed/simple;
	bh=11GFoMMS1/UYVP9gUtUwhQnAnI2OGZk0bZGSLAGMbf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qGZH74tdmGIDCYSRMN6dqq7lj7VpIea92DrccHjRjlGwMnxEDgDqifeJgI0fjzvSliVlw6Vwxz93t8dkooWOV3avAlNiOUq8yT3VTVHM7ubY/tycYDZtsoBX3BCF8lpQZp5ZAMzj4vy8Jlwwken8zb0YYXckEMwbhZKE0f5odN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=H5MDgasx; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0E6C5E000F;
	Tue,  3 Dec 2024 12:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733229812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S4jtv70JZFareVSA2moO66l/3Wmr2zcyshlukvQQ/Ys=;
	b=H5MDgasxrw8jk3RGKLZus1Tc+kBOTcK7GGRwwyKyEIajs6uUUQevTG3jiY8no6MbCT7vFS
	Ry88CYQxO8wtPsQ9Z+cdsUi/EZ7LlIEOIExhCsjp7TlJHUm8lUKxMToCrbIeluA6DnlzEB
	SgkiwmidSmlljMWDDb3MAjIbLfCgbqXRn/ueXXOcOqXa3jPUC5tkwebHfOn8GT8dHZoiAv
	c7GR/t9Sp1Klea5lPv13cIm/1CB51ojh6eUw40DiGm4pt9yiL1nq5Ku6+uoJzA0s9ScGKB
	FOUhD0PUKk3owfUA9uQarW9mjSDG55IdhFa7p1ktje1J9qBG5Ily21Mk6ao2+A==
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
Subject: [PATCH net-next v3 06/10] net: freescale: ucc_geth: Simplify frame length check
Date: Tue,  3 Dec 2024 13:43:17 +0100
Message-ID: <20241203124323.155866-7-maxime.chevallier@bootlin.com>
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

The frame length check is configured when the phy interface is setup.
However, it's configured according to an internal flag that is always
false. So, just make so that we disable the relevant bit in the MACCFG2
register upon accessing it for other MAC configuration operations.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V3: No changes

 drivers/net/ethernet/freescale/ucc_geth.c | 21 +++------------------
 drivers/net/ethernet/freescale/ucc_geth.h |  1 -
 2 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index 587bcbc079da..566f53e24d28 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -1205,22 +1205,6 @@ static int init_mac_station_addr_regs(u8 address_byte_0,
 	return 0;
 }
 
-static int init_check_frame_length_mode(int length_check,
-					u32 __iomem *maccfg2_register)
-{
-	u32 value = 0;
-
-	value = in_be32(maccfg2_register);
-
-	if (length_check)
-		value |= MACCFG2_LC;
-	else
-		value &= ~MACCFG2_LC;
-
-	out_be32(maccfg2_register, value);
-	return 0;
-}
-
 static int init_preamble_length(u8 preamble_length,
 				u32 __iomem *maccfg2_register)
 {
@@ -1304,6 +1288,9 @@ static int adjust_enet_interface(struct ucc_geth_private *ugeth)
 
 	/*                    Set MACCFG2                    */
 	maccfg2 = in_be32(&ug_regs->maccfg2);
+
+	/* Disable frame length check */
+	maccfg2 &= ~MACCFG2_LC;
 	maccfg2 &= ~MACCFG2_INTERFACE_MODE_MASK;
 	if ((ugeth->max_speed == SPEED_10) ||
 	    (ugeth->max_speed == SPEED_100))
@@ -1365,8 +1352,6 @@ static int adjust_enet_interface(struct ucc_geth_private *ugeth)
 		put_device(&tbiphy->mdio.dev);
 	}
 
-	init_check_frame_length_mode(ug_info->lengthCheckRx, &ug_regs->maccfg2);
-
 	ret_val = init_preamble_length(ug_info->prel, &ug_regs->maccfg2);
 	if (ret_val != 0) {
 		if (netif_msg_probe(ugeth))
diff --git a/drivers/net/ethernet/freescale/ucc_geth.h b/drivers/net/ethernet/freescale/ucc_geth.h
index 60fd804a616a..2365b61c743a 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.h
+++ b/drivers/net/ethernet/freescale/ucc_geth.h
@@ -1088,7 +1088,6 @@ struct ucc_geth_info {
 	u8 miminumInterFrameGapEnforcement;
 	u8 backToBackInterFrameGap;
 	int ipAddressAlignment;
-	int lengthCheckRx;
 	u32 mblinterval;
 	u16 nortsrbytetime;
 	u8 fracsiz;
-- 
2.47.0


