Return-Path: <netdev+bounces-171346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEE7A4C9E5
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 18:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA9793A6CE8
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 17:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC5E245023;
	Mon,  3 Mar 2025 17:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="jiPhrG9p"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2266A228CBC;
	Mon,  3 Mar 2025 17:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021561; cv=none; b=vGfvmoo3W/KZfBnaauFl5I02vgRJ9YRsST6c+X/zfbyxMjDL5FmAig0pwG8Z4vJAUCkMIV9dB4TkMiHjPHdxbNG75mzqq133rFHXi15JaXh/XbJTsqWmdp3dZtL0xyhPPBUOe1aGEAeEQJ9OfIlxJ0SsSJ9+dm124yIfx2b/lrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021561; c=relaxed/simple;
	bh=7ILFfTyvQcV4zf1p1E8Q0q3PCQe7v9wbKGH7Y/CHO9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UCwUInrZ22yPTuwT6qrWjzAUTPl38vL2Mmph7pXZZBiEkrJD6C56LCI7el+AXHn3Y8rl3oTUsxQ2HiIpiW0IXqy3WG0jjYEYECf2vxoa8ac+jz9e+Vn9ZSmwLuOsnmOTFpHPl5XWTULS5iyXL8+LeAwkUcXkzxWPtgepHD/OVvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=jiPhrG9p; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3553C443A6;
	Mon,  3 Mar 2025 17:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1741021558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SU0pPaiQvb1lVqNhzStbJ9876YWD6FfGcppYqH8L4GI=;
	b=jiPhrG9plV2tTXA+GGr8QRdrCjW6Kbgnr40ly4Zwyxb4HBc+aM94GwaF6MRSmVyDXGa4Ml
	r2esdJwkbHVeJ7AfWVppNi/Q2m1HsZX5P6VMFuUpnTzi9XDaNRAw7UneuqX9sf9V8z/M5u
	/PdARt2b0R6kojA3F1+b/GLpY7ZQtLwbcpana936+83FoArNThTM7KFoDSL//FO1NkmvAr
	Xv0vOGsS5v28z9aWBlY5ocp0cyhb/NKTE7/asKsjIK4bpg5znHs4XtT6i+L6wsjKPO6TiN
	OrVoDiRRX2hVC1ZS1W4YBYKxt+B/M1k0t3Adkc6DpoKoCNbY+Tw9sCCVuCYigQ==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Date: Mon, 03 Mar 2025 18:05:52 +0100
Subject: [PATCH 2/2] net: phy: dp83826: Add support for straps reading
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-dp83826-fixes-v1-2-6901a04f262d@yoseli.org>
References: <20250303-dp83826-fixes-v1-0-6901a04f262d@yoseli.org>
In-Reply-To: <20250303-dp83826-fixes-v1-0-6901a04f262d@yoseli.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Catalin Popescu <catalin.popescu@leica-geosystems.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741021554; l=2981;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=7ILFfTyvQcV4zf1p1E8Q0q3PCQe7v9wbKGH7Y/CHO9M=;
 b=StMuknYAVahhQOr540Ve8TMbgMLZyLFdZWrJlrMNyOmE1mPr+vn01y11ml/FifQBReEpw6283
 FmxXU97cP3FC7A3sfl7XoGosD6SN6zUUJ+A9wG2wqt+Jw4nEb+w6L3Z
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=MsMTVmoV69wLIlSkHlFoACIMVNQFyvJzvsJSQsn/kq4=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelleeijecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflvggrnhdqofhitghhvghlucfjrghuthgsohhishcuoehjvggrnhhmihgthhgvlhdrhhgruhhtsghoihhsseihohhsvghlihdrohhrgheqnecuggftrfgrthhtvghrnhepffejhfdtlefhhfehveehueetgffhfeetleeuvdduhfeggeetiedttdeuhffhleetnecukfhppedvrgdtudemvgdtrgemudeileemjedugedtmegttgelmedvieelvdemrgehfhejmeejlegvtgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudeileemjedugedtmegttgelmedvieelvdemrgehfhejmeejlegvtgdphhgvlhhopeihohhsvghlihdqhihotghtohdrhihoshgvlhhirdhorhhgpdhmrghilhhfrhhomhepjhgvrghnmhhitghhvghlrdhhrghuthgsohhisheshihoshgvlhhirdhorhhgpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesv
 hhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjvggrnhhmihgthhgvlhdrhhgruhhtsghoihhsseihohhsvghlihdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheptggrthgrlhhinhdrphhophgvshgtuheslhgvihgtrgdqghgvohhshihsthgvmhhsrdgtohhm
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

When the DP83826 is probed, read the straps, and apply the default
settings expected. The MDI-X is not yet supported, but still read the
strap.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
---
 drivers/net/phy/dp83822.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index 88c49e8fe13e20e97191cddcd0885a6e075ae326..5023f276b8818a5f7d9785fc53f77d59264ab4a4 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -197,6 +197,7 @@ struct dp83822_private {
 	bool set_gpio2_clk_out;
 	u32 gpio2_clk_out;
 	bool led_pin_enable[DP83822_MAX_LED_PINS];
+	int sor1;
 };
 
 static int dp83822_config_wol(struct phy_device *phydev,
@@ -620,6 +621,7 @@ static int dp83822_config_init(struct phy_device *phydev)
 static int dp8382x_config_rmii_mode(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
+	struct dp83822_private *dp83822 = phydev->priv;
 	const char *of_val;
 	int ret;
 
@@ -636,6 +638,17 @@ static int dp8382x_config_rmii_mode(struct phy_device *phydev)
 			ret = -EINVAL;
 		}
 
+		if (ret)
+			return ret;
+	} else {
+		if (dp83822->sor1 & BIT(5)) {
+			ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND2, MII_DP83822_RCSR,
+					       DP83822_RMII_MODE_SEL);
+		} else {
+			ret = phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2, MII_DP83822_RCSR,
+						 DP83822_RMII_MODE_SEL);
+		}
+
 		if (ret)
 			return ret;
 	}
@@ -888,6 +901,48 @@ static int dp83822_read_straps(struct phy_device *phydev)
 	return 0;
 }
 
+static int dp83826_read_straps(struct phy_device *phydev)
+{
+	struct dp83822_private *dp83822 = phydev->priv;
+	int val;
+
+	val = phy_read_mmd(phydev, MDIO_MMD_VEND2, MII_DP83822_SOR1);
+	if (val < 0)
+		return val;
+
+	phydev_dbg(phydev, "SOR1 strap register: 0x%04x\n", val);
+
+	/* Bit 10: MDIX mode */
+	if (val & BIT(10))
+		phydev_dbg(phydev, "MDIX mode enabled\n");
+
+	/* Bit 9: auto-MDIX disable */
+	if (val & BIT(9))
+		phydev_dbg(phydev, "Auto-MDIX disabled\n");
+
+	/* Bit 8: RMII */
+	if (val & BIT(8)) {
+		phydev_dbg(phydev, "RMII mode enabled\n");
+		phydev->interface = PHY_INTERFACE_MODE_RMII;
+	}
+
+	/* Bit 5: Slave mode */
+	if (val & BIT(5))
+		phydev_dbg(phydev, "RMII slave mode enabled\n");
+
+	/* Bit 0: autoneg disable */
+	if (val & BIT(0)) {
+		phydev_dbg(phydev, "Auto-negotiation disabled\n");
+		phydev->autoneg = AUTONEG_DISABLE;
+		phydev->speed = SPEED_100;
+		phydev->duplex = DUPLEX_FULL;
+	}
+
+	dp83822->sor1 = val;
+
+	return 0;
+}
+
 static int dp8382x_probe(struct phy_device *phydev)
 {
 	struct dp83822_private *dp83822;
@@ -935,6 +990,10 @@ static int dp83826_probe(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	ret = dp83826_read_straps(phydev);
+	if (ret)
+		return ret;
+
 	dp83826_of_init(phydev);
 
 	return 0;

-- 
2.39.5


