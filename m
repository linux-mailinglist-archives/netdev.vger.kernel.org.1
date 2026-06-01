Return-Path: <netdev+bounces-293812-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cO3ECtCkHWr5cgkAu9opvQ
	(envelope-from <netdev+bounces-293812-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 17:27:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA72621AC2
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 17:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B13C0302733B
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 15:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706203DC4BC;
	Mon,  1 Jun 2026 15:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaprHK22"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96903DA5C0
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 15:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327512; cv=none; b=frNqSV6jorzzvFNdnE1iuTwKzWX9wiEBVwz1eIu8SofATlAULs0fxvm1I1R9In/xyFb4iBwDR5jnPu0cRZU7W1OkO4k/eYAoGE0xszVfHpGIYAW8N/Yu72CIzLfJ+DbrncO4pqMmtKh2VGgxcfeScCBLorLK+btbNbeA4osiThc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327512; c=relaxed/simple;
	bh=zjoxIx46y8e3QGMsOJPRBZDqL8SBHdoXyjTLZD2h7K8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xs9tmNiXxH0mbPAUrqimte93vnGlH4pUQu/cFKK7i28YqwgnIEgXq/W+3OXmG+Ur4KzDKGpJEFVYgRnzO99A2zIS1b6q2xuP3Xnfzzz/EbSIrHaPEedH9ttzeWy7sICpLh7emkt+PhejG0wVNRa6xVjrlJjQthb7wxedtNs0RcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MaprHK22; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490388fd0dbso105704495e9.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 08:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780327505; x=1780932305; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=09FJYvxDkOz5j8LvOo37RoLQK56TcPEBDxr1UHNCmLc=;
        b=MaprHK22gVjFSxN5AIcOs9rzqZez0kYTijqpzaR4A60mDMpI+/e++oG9/FzxJ9UWpf
         kOXSdpfsl8SmI43Pe6tymS7nA6cijVFwPXFMZLoDk6BDT88HuEG9ZCovWMPmCuDrmcCt
         DhrSCK24ODk3coqZZm3X9xVSEQLbNOMcrkMhxqHG9HbTtlJ7ZPq6tNZp82M5rW+xgxXW
         Y7G0xoiGNyGaKzs4kBrYOnXfb/+ql0SdilELaawUBkJhRjCCmEoGxWXSFwi96sa5fwcf
         pIZwww9PezDMWH+3JFDpbptl92Xz90qA+sYG1xDcGJuIJaoUkp7yYXJFp5MPJXdPbbgY
         1pZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780327505; x=1780932305;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=09FJYvxDkOz5j8LvOo37RoLQK56TcPEBDxr1UHNCmLc=;
        b=rWwItiP9lXuoeapGsS6xQyM94IeVIYwaH1LJiyvXnsMMDKO+uZiRXBOo8tkcHtzt2R
         pOwiTavYf3Ibn5xvywe1rRrtBx1B7YExEKRhuGwEhbEcU2LB0RezcBjnNCKmDTpz5oEF
         umV67Gc9Q7PN6mY0EAT8feJZBlrfVuFzDBzsJDm5XZnHbZds36BRWmQc7ETEJqACNSwB
         RFHqEuNmHbMiFajHUhmPPN6ryNuwXI9FKivSkP7xGzKu7kgvv6k+lXoXV2b1DVmoKYAq
         ONzZiTrREKmA/8FknmpjANSJ6ZOQMNOaCAOZpef0kzoxso2zUnFUlMmGBuEJAInZni7w
         ILxA==
X-Forwarded-Encrypted: i=1; AFNElJ/mhlT3C6zhQLK2iqyQZ+0NZxwwFS762DnxuRXGiqnw6pEZuY2OLp3pZGbeYeJd6g/t2bMhFFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/g+5ynOcYHr3c3Ad2MmV9vyFqeCiR6j415z0XxyhKrQ+JEBTc
	z2KwSiqU/D4WjpVg/fDAQNjw+9CbUZsweRt2kHJ8+Toy7DDpVQdPuVU6
X-Gm-Gg: Acq92OHBX2DRbkEoXazKrId0OrB34D3sxBjwz2TEO/MKyPH8JCftwCxHbYv8HXBLFiy
	6LppojHF8qqF+51bcakWYweb0cWGidVSdJWODveREkDZPeN2LoklYSmtts0KVqebJOtrMpkqfRi
	6q4ovjL3L8Jl5PExRv/M9GNZ+7kFcRHx6oQJTMArHrXo+4bPBot/hdT0LSthX8W/1RQteQ1qHvD
	WfUQVhAkugupm/CfqJrE414qvLawgQ2oDSzDGAfe48XobdmDwsFazDrMivWb5HsnWcg/73AX53l
	DUZdMHAl64B+JLXKwprRuC/fBWVS595l1ep54KtF7bsrVize7VDfSRRPRYYQKB14Hxw2vqKxnPb
	0Gge+nFzC1s411UvFwYntlOsBBuX6FHq3NstGKSQlrH8HvE9GVJi1BuPBshDs/BttR7jOgh8Z7v
	9w9Oi7cNRdWFC7tBUwaKkSJ8bEHx2n2es38sl5iJwmk/YEX/8iw0sakrXhXVk5RJ3qWWEj4X5HM
	h3OBBNHvFlmSPBLkuqd
X-Received: by 2002:a05:600c:c285:b0:48e:5fb8:f80f with SMTP id 5b1f17b1804b1-490a2966ce7mr127618575e9.24.1780327505077;
        Mon, 01 Jun 2026 08:25:05 -0700 (PDT)
Received: from [127.0.1.1] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e26050sm26035e9.9.2026.06.01.08.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:25:03 -0700 (PDT)
From: Fidelio Lawson <lawson.fidelio@gmail.com>
X-Google-Original-From: Fidelio Lawson <fidelio.lawson@exotec.com>
Date: Mon, 01 Jun 2026 17:19:57 +0200
Subject: [PATCH net-next v9 3/3] net: phy: micrel: expose KSZ87xx low-loss
 cable tunables
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-ksz87xx_errata_low_loss_connections-v9-3-fdbbb15592cb@exotec.com>
References: <20260601-ksz87xx_errata_low_loss_connections-v9-0-fdbbb15592cb@exotec.com>
In-Reply-To: <20260601-ksz87xx_errata_low_loss_connections-v9-0-fdbbb15592cb@exotec.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780327500; l=3475;
 i=fidelio.lawson@exotec.com; s=20260326; h=from:subject:message-id;
 bh=zjoxIx46y8e3QGMsOJPRBZDqL8SBHdoXyjTLZD2h7K8=;
 b=PECfV7U8hmgqj7gRKVI6cAaQpYgjEmYIwY0885vRoI//497leFC4zZBFBa7NNk7YSEWw0Ioge
 axsnDEC5TN8Diz8F+OLnP5dqwMoaq+wgNM0G2VLqpGIQC0m7iBghvod
X-Developer-Key: i=fidelio.lawson@exotec.com; a=ed25519;
 pk=866eH9Bmmpjc+ctgkr5T1uXxBefZzob3tEEuiVWZ6BI=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293812-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,exotec.com:mid,exotec.com:email,nabladev.com:email]
X-Rspamd-Queue-Id: 8FA72621AC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 drivers/net/phy/micrel.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index e211a523c258..bb8f3054e257 100644
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
+static int ksz8795_set_tunable(struct phy_device *phydev,
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
@@ -6961,6 +7013,8 @@ static struct phy_driver ksphy_driver[] = {
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


