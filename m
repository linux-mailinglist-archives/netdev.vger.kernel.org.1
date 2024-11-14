Return-Path: <netdev+bounces-144970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5BD9C8E99
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 16:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8EBE2844B6
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 15:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F43A1B0F0A;
	Thu, 14 Nov 2024 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dYQZoJ8G"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5B71ABEC6;
	Thu, 14 Nov 2024 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598581; cv=none; b=UEPhstMzbLWIDhqNtfpskojrsfQ+3TgLjUtTbZ5vJ51w8BeQYps1leRIjdCVBdAEICF9NXVqH42Hv1v1R3Un/NfXyJPJsnBa/oEYZeikM2I1akam9hBUlOMVvScMuPn55VuJUijRRw1loQzODoGDmp9RM6ivqSDszRgUKpAt6fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598581; c=relaxed/simple;
	bh=D0Ihx6W6vMhkvdWBBTjBM042pgzSMrP8w8JKh+aC7Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cx+s+o0GEyaLTpctassEGqhWe4zT66Thyhjm+y2oA5dC1sIyzIbn8FR6cCoYUMWUhjZkfcIz6uEH/TUrt+aO+X8mtxFa08zMPoxfZYWOh9PAUjUuRFPM3qm+6iCQhWupxtibfEFwj2/rPPRKuwH1GD2ybNdlQYSPtBgEkT5k/PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dYQZoJ8G; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 522F21BF20C;
	Thu, 14 Nov 2024 15:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731598571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=unLNMvXwm+4Ey2QBvMpwyWlJW/nP417xwtjjmRzD8A0=;
	b=dYQZoJ8GizsCRQNeeh7mP0iuOKIpX2vWhjKhzP9R6JubF51/zwWoT/X8B5NRZJexKLoB63
	oR1xrOQgwS+A8Y3E1kzfk0LfZV1CWj/r6OVHE6e/LCMo6QxstbMcjUR93kJx9FJ053kQh8
	9ti8pcUIhV8NKnr2+3gHNjSPEBFt5oe/DX3iqnfjUuFn+57hrfrsx4R+bl1p6wBkJbACFi
	STgplV/jJP5uQkweqQIqtt0tU3tuc8QlnHn5dQbMIPLebL8kx9qkii0cBqjqURksVIpggF
	28RjUYmWhPoivm+a42rka9XyXE44yRJxVgp7bok3hAcS77xFQrEJHpcB0ku0Kw==
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
Subject: [PATCH net-next v2 06/10] net: freescale: ucc_geth: Simplify frame length check
Date: Thu, 14 Nov 2024 16:35:57 +0100
Message-ID: <20241114153603.307872-7-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114153603.307872-1-maxime.chevallier@bootlin.com>
References: <20241114153603.307872-1-maxime.chevallier@bootlin.com>
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
V2: No changes

 drivers/net/ethernet/freescale/ucc_geth.c | 21 +++------------------
 drivers/net/ethernet/freescale/ucc_geth.h |  1 -
 2 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index 42254ee64a35..7db575a1e710 100644
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


