Return-Path: <netdev+bounces-278360-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8M/9ClQF3mlRmQkAu9opvQ
	(envelope-from <netdev+bounces-278360-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:13:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACD33F7B5E
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE4D530459ED
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DD33BED0C;
	Tue, 14 Apr 2026 09:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ant7J/HE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE913BA222
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 09:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776157982; cv=none; b=skYfhz8QQ+dNdLesd8f7aweMlMD0UmAgi4+znFxYQXNZzBkgbG9KRmpXUHBC1YJ7Z3p4rrUZsPBtrGXeBUrZN9we+5aiRzGSvyMYnjfUKuGhYNU2dGptVSoY1uRwUNa7q8EU33xiSRRmXa+8xPlX8zgtloQ8KVhuPVWjrdCxwBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776157982; c=relaxed/simple;
	bh=2vI6ognLDqNvbJVGBaJD46iIjBYSoIanjoxDpv86i8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UM+rhlxrAL0Rf3kihYR3GpQODpdN5yS/MX2tBYePKcEn0Vu84mHjFequmaQd/vGyy+FjRoPFnVZm+Nw9YUqxQsoo+rEoVVgMAKyy1pv5x0vTBft23ccaHy0fsEZScs2n7Fb6WgC4tAXZJMtp+Ul+0v2LcnjY+dmGgueyFE2MitI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ant7J/HE; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so70921805e9.0
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 02:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776157979; x=1776762779; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QOp42/ywV8i4T7a1g68YDk4e+77ZBYbSBwy2mOXtNU0=;
        b=Ant7J/HET8p9uKvVQUfr3DRxk9d+3j4kB2H2WA7Q94b8eu7mgkHNjBZBDmi8NJkCaM
         WxHxVPUHeDyZLnIC/dH8q0+ZB6w4YJe+/SFYB5SnmZND1e4DwdyaEhnHmQ4XuYAoq4hi
         K4NfmLodEEfkT/vb43U+JAqLPKgTM6jXB0iZ4vSqd/5KKHOf2Bkq6mt9S/v+Cg3hV9cI
         3XfKMTM9X9jAK6ynTlbYQlltnRzD0E0sAVAuh/Pg11sV7GFMGg5dUMEhGOlPqEgJRwhe
         mrsWmZCFj05V4dZDZg8D8UIooGXQimyfOvKQWZZrcLruXuF853RHkKHu5klqfhWBshWB
         RqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776157979; x=1776762779;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QOp42/ywV8i4T7a1g68YDk4e+77ZBYbSBwy2mOXtNU0=;
        b=oUJ4sR2RmhjFhIOBjzksnZApj9hp/uQprsqmg/IjmP9+BdtV15+ycU9laxLLwQkFLx
         X2KTcVq55eMVLohk9pwk7tOsI4ArRyAs8O7taTepC5Rc27H8LtN38nDqRtiCAEqtjFAA
         322H+0aqX36agS79k3SZV82Gx9j+pCWXuD5HpCCOsVGUWLZJmdOeW1lO7f724vvcy8IG
         iOiwgS3Z0pNYSXXlqo0i/Ql0gOgjGXak2Y432CKOThZ4HotWekux3+Xsf6QJpggBrIWN
         YH8iXXLqaGI5iNEveOmfOaKOSDL7T/AjKaW4tgTKQ3EX1c5FxcGoftFhq2CfnyPpp7ij
         vY4A==
X-Forwarded-Encrypted: i=1; AFNElJ+2323Suk3BLlxUtSEk2EjheW0RLp62oRfD78gYT3yeCmQWToSLqYPfVD4lYfKMauTusV0n4ac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9JfuZzAOZHUdTD9RVNI7r4R2ESCd+s1uG2NmBZ2DuvE0KC4IF
	qPBcH3/WKO0mBWDab70MbACbD+bmseESHfooXl64tzL+iBnxMgy/wniJ1589jYLuQaI=
X-Gm-Gg: AeBDievQg5YKzeMi0ni4dP4bWiAMqbmiQEcUfLgBIhGpjePyjTKIVAtn+r+cfMeGTg5
	dAACn4t8WMRCJ6opvAq6yGe1Z50Ut22UxVqQ8m4QMxNKP7Yah8MWz9wktI32JvSiLVBeOLx+RCc
	WxUwBQm7yrX0dDzAP2/sqeoIwJpbHaPVFJN2NxasC4q7ixuHlUJzsv0ZDjc8dnZ6cccAaXvgjj7
	peNuw5XwkcZ+dPbJA0ZiIKxNS55bA6Ifdo/3bfkQ9fOtBVl/CMfLR7fLNpcCBb//8Au9DvM0Co0
	6NtHflgS9YH+2o2iKGYjByih2HajjgGuoFf1MG36dwxBH91g1sOGDBH3Dnh+QJn/avcSAPiyJeW
	HtoIMW/HZfRP19nE2eV9eZnuZCd4Uq/X6KE2KJ5eif8agv1vrLX+dezfYsqxsORirhycI2L5V5e
	G7KewbDV3ljIlbOfe5vOrdiiDO2EepBhMJXeAas5QLYaw3y3obYyIV/0rRgTSEfYKd7x+9EsfT6
	AHrsMhXdQ==
X-Received: by 2002:a05:600c:c084:b0:485:4006:960c with SMTP id 5b1f17b1804b1-488d685b86bmr165530925e9.16.1776157979473;
        Tue, 14 Apr 2026 02:12:59 -0700 (PDT)
Received: from [127.0.1.1] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488eddba112sm37720175e9.0.2026.04.14.02.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 02:12:59 -0700 (PDT)
From: Fidelio Lawson <lawson.fidelio@gmail.com>
X-Google-Original-From: Fidelio Lawson <fidelio.lawson@exotec.com>
Date: Tue, 14 Apr 2026 11:12:36 +0200
Subject: [PATCH v3 3/3] net: phy: micrel: expose KSZ87xx low-loss erratum
 via PHY tunable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-ksz87xx_errata_low_loss_connections-v3-3-0e3838ca98c9@exotec.com>
References: <20260414-ksz87xx_errata_low_loss_connections-v3-0-0e3838ca98c9@exotec.com>
In-Reply-To: <20260414-ksz87xx_errata_low_loss_connections-v3-0-0e3838ca98c9@exotec.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Marek Vasut <marex@denx.de>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Woojung Huh <Woojung.Huh@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Fidelio Lawson <fidelio.lawson@exotec.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776157976; l=3026;
 i=fidelio.lawson@exotec.com; s=20260326; h=from:subject:message-id;
 bh=2vI6ognLDqNvbJVGBaJD46iIjBYSoIanjoxDpv86i8Y=;
 b=FP4OCvNO1ZybW4xzvNdkF5/zBzYowz+zBvp4wt3FGg6LXKDVyOeI//tDQ21+a/LHMjJOoODrL
 suZIjX1OlaCDZEecu+jz9QT7l9X9/v49Yj6V2DMUjItbPTYpuUdmRi7
X-Developer-Key: i=fidelio.lawson@exotec.com; a=ed25519;
 pk=866eH9Bmmpjc+ctgkr5T1uXxBefZzob3tEEuiVWZ6BI=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-278360-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[exotec.com:email,exotec.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7ACD33F7B5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Expose the KSZ87xx low-loss cable erratum control through the PHY
tunable interface.

KSZ87xx switches integrate embedded PHYs whose receiver analog front-end
may require specific equalizer or low-pass filter adjustments when used
with short or low-loss Ethernet cables, as described in Microchip errata
DS80000687C (Module 3).

Implement get_tunable / set_tunable callbacks in the Micrel PHY driver
for KSZ87xx devices, mapping the ETHTOOL_PHY_KSZ87XX_LOW_LOSS tunable
to a vendor-specific Clause 22 PHY register. Accesses are routed through
standard phy_read() / phy_write() operations and translated by the KSZ8
DSA driver into the appropriate internal LinkMD table updates.

The tunable uses a u8 mode selector, allowing userspace to select
between the documented equalizer and LPF bandwidth configurations.

Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
---
 drivers/net/phy/micrel.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index c6b011a9d636..7cbca6a7ed84 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -287,6 +287,11 @@
 /* PHY Control 2 / PHY Control (if no PHY Control 1) */
 #define MII_KSZPHY_CTRL_2			0x1f
 #define MII_KSZPHY_CTRL				MII_KSZPHY_CTRL_2
+
+/* Vendor-specific Clause 22 register, virtualized by KSZ87xx embedded PHYs DSA driver */
+#define MII_KSZ87XX_LOW_LOSS			0x1c
+#define KSZ87XX_LOW_LOSS_MAX			5
+
 /* bitmap of PHY register to set interrupt mode */
 #define KSZ8081_CTRL2_HP_MDIX			BIT(15)
 #define KSZ8081_CTRL2_MDI_MDI_X_SELECT		BIT(14)
@@ -940,6 +945,38 @@ static int ksz8795_match_phy_device(struct phy_device *phydev,
 	return ksz8051_ksz8795_match_phy_device(phydev, false);
 }
 
+static int ksz87xx_get_tunable(struct phy_device *phydev,
+			       struct ethtool_tunable *tuna, void *data)
+{
+	int ret;
+
+	switch (tuna->id) {
+	case ETHTOOL_PHY_KSZ87XX_LOW_LOSS:
+		ret = phy_read(phydev, MII_KSZ87XX_LOW_LOSS);
+		if (ret < 0)
+			return ret;
+		*(u8 *)data = ret;
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int ksz87xx_set_tunable(struct phy_device *phydev,
+			       struct ethtool_tunable *tuna, const void *data)
+{
+	u8 val = *(const u8 *)data;
+
+	switch (tuna->id) {
+	case ETHTOOL_PHY_KSZ87XX_LOW_LOSS:
+		if (val > KSZ87XX_LOW_LOSS_MAX)
+			return -EINVAL;
+		return phy_write(phydev, MII_KSZ87XX_LOW_LOSS, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static int ksz9021_load_values_from_of(struct phy_device *phydev,
 				       const struct device_node *of_node,
 				       u16 reg,
@@ -6809,6 +6846,8 @@ static struct phy_driver ksphy_driver[] = {
 	/* PHY_BASIC_FEATURES */
 	.config_init	= kszphy_config_init,
 	.match_phy_device = ksz8795_match_phy_device,
+	.get_tunable	= ksz87xx_get_tunable,
+	.set_tunable	= ksz87xx_set_tunable,
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
 }, {

-- 
2.53.0


