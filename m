Return-Path: <netdev+bounces-297157-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PikFDmBEKGpWBQMAu9opvQ
	(envelope-from <netdev+bounces-297157-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:50:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6DE6629C7
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:50:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="f/uItbS9";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297157-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-297157-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C1FD317B1AB
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 16:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8F73EA94C;
	Tue,  9 Jun 2026 16:20:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AFF3EE1E4
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 16:20:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022016; cv=none; b=cb5BAG1S584gCZgES+yY15poDkVV04Z5fTobdbJJChnh/EfBJGvscQwPMHkIQPAA85TR8R3vXWZtPC5XFzpYzgurrb7m/+zY0QJ2AG7LgQfMsZKJRBp9ux3yXo4TDLmZOpjANZ7z5Dw/XltE/I/EZQ7ul+9/5GrcztJ1Cxlgkgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022016; c=relaxed/simple;
	bh=1Bg3HIc+ul+IspMj6051G4PzpB0IZb8XCU6ZrH5Ac1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M23e88+i7RiBAlBvetcYeqGSK522a/K6CsV3cGzgxNCJGnfl78rD96W5qq0mO5Ndkn1jU6kOWrtFRPx7pJSvwgwBlKGNrEJbIy91QPI+Z7NLrSRv36ZLpu2/gvpnkdwccW6G9TgYN7+1Vy6DC6sx4oHl+NeU/HKCPxvg21YX1vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/uItbS9; arc=none smtp.client-ip=209.85.128.48
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490cdae130cso16171665e9.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 09:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781022013; x=1781626813; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ky91/+dXFXBr1oY6G2Cx8JO9XPTiajugIHZP2YcNqRA=;
        b=f/uItbS96P4HYPMPmbPzXG7h95yUzY6GYRJb1H/qlzPs+VuDOyVeNkBpFcJSEi3AL3
         Tw13uNSk47RNNjB8jwz6DSvHBCE22X9QlbsDlvFP1HhcsqwBt1VDeTCdUq8t/OwwhcfT
         wA/B004rdqoaEpi7Qg1e/vc8U0TYVVzZetPVPlToFAYdsOhEsxa8cj0EpGT9uMZc7k14
         dDJoJfS2noOoeym/gzzUZ2LO6H4Dsj+vORS6HxLyTigxfAmCjzb70SeGE4RDGh4sSUej
         DY3PNk01jYawTh8ezO0AjdnF4cPsaQb36ThMZhMaMsEKuIltgCghdA33Yugb+sC6NcbI
         As8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781022013; x=1781626813;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ky91/+dXFXBr1oY6G2Cx8JO9XPTiajugIHZP2YcNqRA=;
        b=KIdo7dUz29EpZxvPym1D14h27C/O3dwl61EJMGPqUM7o92hMd3LHDb38FiV5l9DeLw
         J11PMUSdwAxvFzgXazLjZbW93KDZNvCAYfG++pbITIbipDY7Uu1ZfzMeomrvWE4qK9W2
         eUmSFHLOVoBiDgMGn+na0S8jnzpOPAA1//K0W9pbCs4UDz63FvJjEsvGPXNRc8+V5nq0
         9Nx+EbNeZFVmSPTIDOrWduK1kDocBvVTo3+M5R/RmWs9k8nH2Do8guCfntZM+D4gHMHL
         2pP+ALNraZEA1q84ucsEg166Kqqw82LmpmCNpr+NCPNzitG75wwNpEZUgicxleP6mzcw
         OEDg==
X-Forwarded-Encrypted: i=1; AFNElJ8r0vS+xjLGRiOJ9SVwTtZS+7bDFLFFtvmol60E6LhewzSjE26r+sxIP+mnIOXkK4FP/O1jW8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVH5TiLyOZtUGq9r+QxKtWZz8moM1b6oBrOPgv20c32UKL7IOR
	RrrfwLQU0N7T501gXuzIJ+Axdo/7mpYM20QMHljs7z+2LtFM7Nyf8A82
X-Gm-Gg: Acq92OFEwSY1pLj2x5rHBR09DaiMRCofxHKkqEB7pZBAIxW0qmVZe5CuUAyk7H49QIi
	GvS3KHNvYnoEu3bEHgZiU8VFgSbI2OR5RrnaWXRBDKZ8EgfuUGp9hF4bqj5oKE/LcjCQpXLwzTT
	MyHiVvEkDaVw5oZO2HjAKSBl5N/U82m1WTYhoXsiEPhSQewh/CfseC4wrQeyMu4Ip/u2zgHJVB8
	nAYoFkjJYmoXMD3/LXgLzJzSGik3/CstSdK9H5rFU6IfYcmCLCrtM4mBvJoms1QO1CbYKw1EWhx
	zVlUFtBG12algg5qC+oiJ42LWMjJKoTLn5QhkAjYZj/jkJfN2/hR2DGgu2q1nL5eu00CIedkYua
	0o+zer8eeeuauH8pAwgEedR/8yJNqv5oGIgoB49gHqosho82bg7ppWqY/NaVd+LwjoDunUmz011
	V+6QAv2i0jHCh801K147BdFyRlFCwjf16D9QJIfpAbTEwcftl53Vt4DQYEvWW4IjEfgtJqx3jnW
	zRv4PBJN30qHv6757+x
X-Received: by 2002:a05:600c:1908:b0:490:b5d0:598f with SMTP id 5b1f17b1804b1-490c25b5f6cmr350476095e9.13.1781022013221;
        Tue, 09 Jun 2026 09:20:13 -0700 (PDT)
Received: from [127.0.1.1] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc391aaasm569116365e9.1.2026.06.09.09.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:20:12 -0700 (PDT)
From: Fidelio Lawson <lawson.fidelio@gmail.com>
X-Google-Original-From: Fidelio Lawson <fidelio.lawson@exotec.com>
Date: Tue, 09 Jun 2026 18:19:57 +0200
Subject: [PATCH net-next v10 3/3] net: phy: micrel: expose KSZ87xx low-loss
 cable tunables
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-ksz87xx_errata_low_loss_connections-v10-3-9ba4418cf3db@exotec.com>
References: <20260609-ksz87xx_errata_low_loss_connections-v10-0-9ba4418cf3db@exotec.com>
In-Reply-To: <20260609-ksz87xx_errata_low_loss_connections-v10-0-9ba4418cf3db@exotec.com>
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
 linux-kernel@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>, 
 Fidelio Lawson <fidelio.lawson@exotec.com>, 
 Marek Vasut <marex@nabladev.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781022010; l=3643;
 i=fidelio.lawson@exotec.com; s=20260326; h=from:subject:message-id;
 bh=1Bg3HIc+ul+IspMj6051G4PzpB0IZb8XCU6ZrH5Ac1Q=;
 b=gcBJd0pbSowT/2sK4Orvuh8Oyi1LRIS0wtGAyBpM9DbpnSAC1YG6ehm2i9farh2sDcWg0bGCt
 kEjBLYheW9QDvHUD5Bl75OHkUJ6hdV4ZaYEj06ypr3WTUPbcHxD90kT
X-Developer-Key: i=fidelio.lawson@exotec.com; a=ed25519;
 pk=866eH9Bmmpjc+ctgkr5T1uXxBefZzob3tEEuiVWZ6BI=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS(0.00)[m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:marex@denx.de,m:maxime.chevallier@bootlin.com,m:horms@kernel.org,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:Tristram.Ha@microchip.com,m:Woojung.Huh@microchip.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nb@tipi-net.de,m:fidelio.lawson@exotec.com,m:marex@nabladev.com,s:lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297157-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,tipi-net.de:email,nabladev.com:email,vger.kernel.org:from_smtp,exotec.com:mid,exotec.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A6DE6629C7

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

Reviewed-by: Marek Vasut <marex@nabladev.com>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
---
 drivers/net/phy/micrel.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index e211a523c258..55df5efcfc86 100644
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
@@ -940,6 +946,59 @@ static int ksz8795_match_phy_device(struct phy_device *phydev,
 	return ksz8051_ksz8795_match_phy_device(phydev, false);
 }
 
+static int ksz8795_get_tunable(struct phy_device *phydev,
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
+		*(u32 *)data = ret & 0xff;
+		return 0;
+	case ETHTOOL_PHY_DSP_EQ_INIT_VALUE:
+		ret = phy_read(phydev, MII_KSZ87XX_EQ_INIT);
+		if (ret < 0)
+			return ret;
+		*(u32 *)data = ret & 0xff;
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int ksz8795_set_tunable(struct phy_device *phydev,
+			       struct ethtool_tunable *tuna, const void *data)
+{
+	u32 val;
+
+	switch (tuna->id) {
+	case ETHTOOL_PHY_SHORT_CABLE_PRESET:
+		return phy_write(phydev, MII_KSZ87XX_SHORT_CABLE,
+				 *(const u8 *)data);
+	case ETHTOOL_PHY_LPF_BW:
+		val = *(const u32 *)data;
+		if (val > 0xff)
+			return -EINVAL;
+		return phy_write(phydev, MII_KSZ87XX_LPF_BW, (u8)val);
+	case ETHTOOL_PHY_DSP_EQ_INIT_VALUE:
+		val = *(const u32 *)data;
+		if (val > 0xff)
+			return -EINVAL;
+		return phy_write(phydev, MII_KSZ87XX_EQ_INIT, (u8)val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static int ksz9021_load_values_from_of(struct phy_device *phydev,
 				       const struct device_node *of_node,
 				       u16 reg,
@@ -6961,6 +7020,8 @@ static struct phy_driver ksphy_driver[] = {
 	/* PHY_BASIC_FEATURES */
 	.config_init	= kszphy_config_init,
 	.match_phy_device = ksz8795_match_phy_device,
+	.get_tunable	= ksz8795_get_tunable,
+	.set_tunable	= ksz8795_set_tunable,
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
 }, {

-- 
2.54.0


