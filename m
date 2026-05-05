Return-Path: <netdev+bounces-284356-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oD3GOLzX+WmbEgMAu9opvQ
	(envelope-from <netdev+bounces-284356-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 13:42:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AB37E4CCDDD
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 13:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 56B76301FF23
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 11:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3588B3939B2;
	Tue,  5 May 2026 11:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVh3PKLl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783A0387369
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 11:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777981340; cv=none; b=QVaizIMfTWLtp9nELAhu30y+MD3Erd9H5wQ+aXDuiE7HcG0VVDeSQfG/iAe8FalvWhU7jl0dGoq+GCGdZfUmWm3z2i/mnEGFr4Cp0W9MzsvsSGilksocgJtAF+wt/yZ7C2uPH2H9A1EAvHPVtGoK1cZzKSDa4kA/ujmCjftBefs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777981340; c=relaxed/simple;
	bh=gOC5G/MjEcU+cjPbczT1n5fBRi/QDZzNd3idAG37qfk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M7PXeB7sYPvuoCXj35XQxv2Py3WGYGgemwp0ubbnNv2mDMyWE154waGKKQhHG8bIaKILolVw9lnw/8Ji5L/mSzNuSKJZPdx4IPhvujPJNas/wPH7dVSornTcSs4kuAT5n2L21oF4AZ+dZYZgDJfwmACGkeXaVQNl5NIFLQm0lsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVh3PKLl; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso38729345e9.0
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 04:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777981337; x=1778586137; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1/sImLCWBGmuwdARQysC0FgKop+Arozoc5YO1W6z3wo=;
        b=KVh3PKLlWT9M/LE21UuCio2PDX04lU9WAKY211FB3I8+kJnWD6xKe0hlclFsDeN7/X
         guPkyStcSpgw5W2g8Pb+xIbichAYfsFz2+0MoxUVl99ak/6Eu9BVZ9952gTaFOSbm5xg
         Vc+IFYRgyG3g+bEJZIFU1mpoT5Ow4k663CUQiCUT3xVvXHy73384oHwLwTGg77yZ9fvt
         Q5sEKRgPc99Ge69mlZqlGe++Sb4fuOrBvo/Y7oTHJ/RyYLOt9RIKvkxoJOF6pyZ4OxRY
         z0zTaTDzu5S5YHXunVfRo5xACWfhknDwe2NBYgvMobXMjtIkiCxzbCgpFHRI5+fQqi8/
         nycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777981337; x=1778586137;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1/sImLCWBGmuwdARQysC0FgKop+Arozoc5YO1W6z3wo=;
        b=qWDNutK1q+xneA5CCcT7U4U7IVzaai5Lezplszk1avKG8BvY/YvJW0YpXvZqCtPCNX
         6QmZSf2VzDQx5EuERT6P1/rdzSUKUN2soNLbUxwSWmPVI4uXV2IDMcmASEp9VIO0obhH
         q/4+1ADxEVpIuBdKJmRI1nBF4JoCbJBS9ktMxnLURoj3Nx2YaVNvvlVUpTi8AxppPxAA
         ZigkFJMBPlspSHMghgbN0P2OUaSqk8ism7sOkXC8rmO/dX6Z2opTHRG0vgKMjuFx67Q1
         5GyqFFYu2bia7OwrudZKtaQfP+54Rot5rW8QYmHakknnblcKy3msd7dgiw8qif+UYBfx
         sDJg==
X-Forwarded-Encrypted: i=1; AFNElJ+vkXYqSwRY64NMSzrojSxFucL8Gn/PjXd6uvlLTsNxfGG5lshKKuaNlaqx4/AmD2jG255Fo4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE/x4gH9kE5KRknHNsaO2v6W/RdCiDjsNggoZWzDGhTdRTQsUJ
	sl7p88LmAEYnoxjXQUR5CG0GYKiUxTHOkbIAnZUJZzPv26FjXWCth5mI
X-Gm-Gg: AeBDieteSst24XxFcY/uFiMP6lPf5ZCHXSIFD/BTnFdIZA3k69fAEow03v/RMi6RX/7
	GXQAIGxem/ze0Iium/JKib3xEkg4GU5TA83nHR8QHRkFVNv/K0TzN3idtqTlY9pwG/HW8ksvN+2
	9J9ksPZO5buoNjiYcNKRaOXQfGjL9hbeV34lwW6e1dwvWGP/rpMJ1ShI2aEeHmQCcv3hwcINl0l
	0pW/LoBaghHDAh8Pr04Xe2fcDZW0LhIdCligAiPrbPYkYdZ1DbXmV813jvZ+1ldhfqXb6AlYyWF
	VLBDax7uNbEqVzTRocDPJs+VeONF5CmeLaDqW+shh8Sy52GOD/lhgGCt6CbjFB3dqnXhGgMLf8V
	7zS8PS3ZssyU2ufxs9KlvRhWBunCtuCy0qdWZTuHY1r9c2RIXHDjG8BZfARIZQmaGCeph45/JOc
	BEslu37n5IXqsrVVqKjAMGvM/msct4Baj80mDuF/d8j7Mb2D91wHiJ0yDL2gqfU1O5aKpopLzAc
	iLHWIykNex9/OhEt+1+HBHKWm7kJmAT
X-Received: by 2002:a05:600c:6388:b0:488:b239:77ec with SMTP id 5b1f17b1804b1-48a98895044mr194228095e9.17.1777981336733;
        Tue, 05 May 2026 04:42:16 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8434-6628-bc01-577d-da52-626d-d378.rev.sfr.net. [2a02:8434:6628:bc01:577d:da52:626d:d378])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb69698sm616575105e9.1.2026.05.05.04.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 04:42:16 -0700 (PDT)
From: Fidelio Lawson <lawson.fidelio@gmail.com>
X-Google-Original-From: Fidelio Lawson <fidelio.lawson@exotec.com>
Date: Tue, 05 May 2026 13:42:12 +0200
Subject: [PATCH v5 3/3] net: phy: micrel: expose KSZ87xx low-loss cable
 tunables
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-ksz87xx_errata_low_loss_connections-v5-3-da4002b21c42@exotec.com>
References: <20260505-ksz87xx_errata_low_loss_connections-v5-0-da4002b21c42@exotec.com>
In-Reply-To: <20260505-ksz87xx_errata_low_loss_connections-v5-0-da4002b21c42@exotec.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Marek Vasut <marex@denx.de>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Tristram Ha <Tristram.Ha@microchip.com>
Cc: Woojung Huh <Woojung.Huh@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Fidelio Lawson <fidelio.lawson@exotec.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777981333; l=3380;
 i=fidelio.lawson@exotec.com; s=20260326; h=from:subject:message-id;
 bh=gOC5G/MjEcU+cjPbczT1n5fBRi/QDZzNd3idAG37qfk=;
 b=cZ8Jo/F68xUeo70cAO7FyTm9qrPQU5bF9dqlHQLsEY/7X50J2+RNguABjp71u1s1PSvKpNdfd
 lMp8RbWbGt7B1Vl+wWpdSVQSw5H0xNenM0j4D61XJdXxNOTA6zFEXqw
X-Developer-Key: i=fidelio.lawson@exotec.com; a=ed25519;
 pk=866eH9Bmmpjc+ctgkr5T1uXxBefZzob3tEEuiVWZ6BI=
X-Rspamd-Queue-Id: AB37E4CCDDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-284356-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,exotec.com:mid,exotec.com:email]

Add support for the KSZ87xx low-loss cable PHY tunables in the Micrel
PHY driver by implementing get_tunable and set_tunable callbacks.

These callbacks expose vendor-specific PHY tunables used to control the
KSZ87xx embedded PHY receiver behavior when operating with short or
low-loss Ethernet cables. The tunables provide:

- a boolean short-cable preset applying known good settings;
- an integer LPF bandwidth control;
- an integer DSP EQ initial value control.

The Micrel PHY driver forwards these tunables via standard phy_read() /
phy_write() operations, which are virtualized by the KSZ8 DSA driver and
translated into the appropriate indirect switch register accesses.

Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
---
 drivers/net/phy/micrel.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index c6b011a9d636..1852e9bd0e01 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -287,6 +287,12 @@
 /* PHY Control 2 / PHY Control (if no PHY Control 1) */
 #define MII_KSZPHY_CTRL_2			0x1f
 #define MII_KSZPHY_CTRL				MII_KSZPHY_CTRL_2
+
+/* Vendor-specific Clause 22 register, virtualized by KSZ87xx embedded PHYs DSA driver */
+#define MII_KSZ87XX_SHORT_CABLE			0x1a
+#define MII_KSZ87XX_LPF_BW				0x1b
+#define MII_KSZ87XX_EQ_INIT				0x1c
+
 /* bitmap of PHY register to set interrupt mode */
 #define KSZ8081_CTRL2_HP_MDIX			BIT(15)
 #define KSZ8081_CTRL2_MDI_MDI_X_SELECT		BIT(14)
@@ -940,6 +946,52 @@ static int ksz8795_match_phy_device(struct phy_device *phydev,
 	return ksz8051_ksz8795_match_phy_device(phydev, false);
 }
 
+static int ksz87xx_get_tunable(struct phy_device *phydev,
+			       struct ethtool_tunable *tuna, void *data)
+{
+	int ret;
+
+	switch (tuna->id) {
+	case ETHTOOL_PHY_SHORT_CABLE_PRESET:
+		ret = phy_read(phydev, MII_KSZ87XX_SHORT_CABLE);
+		if (ret < 0)
+			return ret;
+		*(u8 *)data = ret;
+		return 0;
+	case ETHTOOL_PHY_LPF_BW:
+		ret = phy_read(phydev, MII_KSZ87XX_LPF_BW);
+		if (ret < 0)
+			return ret;
+		*(u8 *)data = ret;
+		return 0;
+	case ETHTOOL_PHY_DSP_EQ_INIT_VALUE:
+		ret = phy_read(phydev, MII_KSZ87XX_EQ_INIT);
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
+	case ETHTOOL_PHY_SHORT_CABLE_PRESET:
+		return phy_write(phydev, MII_KSZ87XX_SHORT_CABLE, val);
+	case ETHTOOL_PHY_LPF_BW:
+		return phy_write(phydev, MII_KSZ87XX_LPF_BW, val);
+	case ETHTOOL_PHY_DSP_EQ_INIT_VALUE:
+		return phy_write(phydev, MII_KSZ87XX_EQ_INIT, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static int ksz9021_load_values_from_of(struct phy_device *phydev,
 				       const struct device_node *of_node,
 				       u16 reg,
@@ -6809,6 +6861,8 @@ static struct phy_driver ksphy_driver[] = {
 	/* PHY_BASIC_FEATURES */
 	.config_init	= kszphy_config_init,
 	.match_phy_device = ksz8795_match_phy_device,
+	.get_tunable	= ksz87xx_get_tunable,
+	.set_tunable	= ksz87xx_set_tunable,
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
 }, {

-- 
2.54.0


