Return-Path: <netdev+bounces-244471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0FDCB8528
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 09:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98433309F085
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 08:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E5E3112BA;
	Fri, 12 Dec 2025 08:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AR/Wm9I1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA311F151C
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 08:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765529230; cv=none; b=Rz8rwIZN9tgOrZEviZglPJUEvty/POe1CqFp4tYKpBiIVpTUonPygIzZLgA9HcaFtKsOQFuJmZx90x1/vT3NDaA2fGGZ8emkJ2uXL99pMDjLjb7TwS2WFsjDZrNVUx7jh7QNWLzND0NatB1uekAmt3GvScESC5b6a9ySXg0sAV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765529230; c=relaxed/simple;
	bh=kT9niDzldkUdEXAqQ4V7fQV+lBlzKuktL/berCG6HpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPn7P9MYn0+NAoQEoWHB3LOX+eCAF77CcS/fyKDgriMagZ6i6qR4a+zvDXPZcCm/ohCTA10ndtiFe05Bcf1CNUQEIkppuKDGlJpVk5vfxAMW8MoovLNqb5aNSAMGp+abBw49ARE4z1KjOi+KffbH8cnb5dR3oB/l/jdkH0qnyK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AR/Wm9I1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so8007275e9.2
        for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 00:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765529227; x=1766134027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFWk0J+01QoS2SFsYWdPzaX0fw514m/jhzGpQbZl1TY=;
        b=AR/Wm9I1iTQpieNc+IV2SsBP777+VQSW1kLbeQpd+K33wzWh5M/p6JDB9qMIWkIE/B
         m9ATdddzJha6U7J6qbtsTELGweyMm8oIMCuiRKL2V/ZTeG3xfdGjhCZx6u/4Bs3lLJHR
         W8nCkEFenjciiwfVWRDVXdZ5j6Mu8dKlZ17ecqhfkVaCiSoczFn5PAVePX+falG94ZoP
         gDveA4RSNpL0CAg/+sac6ZTDk+69Sl3c4CseUg5MyAA624jrMil5Hpkb1SFpd9oyMLhQ
         8i1QF+8LKtVRCe6hqxuV9+OAR+rCMgN1FpyAKDwKmOX54ok/jiS8zaI+F/o6i6OEoWph
         oZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765529227; x=1766134027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iFWk0J+01QoS2SFsYWdPzaX0fw514m/jhzGpQbZl1TY=;
        b=Ibh/IQspYbbsvOYF3Z5PHzIp2V3UOfdj3LMh9jraTp8ypk724od9aqsnyrpjiDRVjw
         JhhnNhZIzaVZ5zOmOcLgbFTt3eJjGrItX75MZZkdoMZDvJPqXbXmmfNwOSepkhVZNM5K
         gwEzHszAg4SlTCo2MlRN2Q5ZtBX9nMGcWB/Ev5G7naIU0f6GRbyQDi38hD0UMo9LTuB4
         RknmC0DswZYTTcDBKUujJfXdb5k+T97T+FS5Q4N9uQ9JIHb3k181944EPAttVBEY94M8
         HtlcePF6aptyCY6jS7XDfXvPJYYdRYjgJLfYQz/QmzUKMrMeJJRlMAGX2pHxykTxOfpj
         xYrg==
X-Gm-Message-State: AOJu0Yxor17qbT9Xfvn1mZwrN8jHqsNNf4vM23bdpDEF091voyY6iJr0
	wIdLCHrpR9SHD9zUcPHQlxEGhH9zFu13W1gk7KjY3d56H3WLXwrY5ITx
X-Gm-Gg: AY/fxX6sKCU7aXF75Kl8EU5MDLhETYjcy2ogg60ZcatVvbrDjw+Gj4ejw6DWdv3VjRW
	j1O/+k9aJTljuF7eRR3Pi5FzR2gjvcJRxD7YIdprOyAdekUuV96fpvk+EWcX9wx6kwIdUyobzui
	A8P4LBrYg001MorF6xsH1iViSsltoWvPD4ASO0O63ImSrL5efWhTdpsdiCjLsq/huqRXss5P4cc
	f3OMeB+FFaIuLA8KtKBL7vOJKzj/Tj53NrPkjVcDqhwVMSMTV3gjE7VrqN4WTjirhdQZTbvGJQU
	1YtngUD9IPkUHo8TMbYiHPJKQAeq/B6Tmq3+JtQRy1Q92vjiVj1N9aCZL8IwadqFwScyrM12H3v
	qraXnfggFZNp7YYCYAZh5iq1wTxOINt/Bd7aLe8gSVOGlcjezcibhOUxdR0r4pMkuRY6nAI8lXE
	527aqqR9UKvyQksxAT
X-Google-Smtp-Source: AGHT+IGoA8T3vrnZPvhKsWSMPF6PaJnRKzyphO2s4dN9M2yXDFob6KV38VoR4WNUDpJzukAQqgxZkA==
X-Received: by 2002:adf:e803:0:b0:42f:b683:b3bd with SMTP id ffacd0b85a97d-42fb683b4d6mr629257f8f.3.1765529227036;
        Fri, 12 Dec 2025 00:47:07 -0800 (PST)
Received: from eichest-laptop.lan ([2a02:168:af72:0:9f18:aff4:897a:cb50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8a09fbesm10456076f8f.0.2025.12.12.00.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 00:47:06 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	geert+renesas@glider.be,
	ben.dooks@codethink.co.uk
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	francesco.dolcini@toradex.com,
	rafael.beims@toradex.com,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH net-next v1 3/3] net: phy: micrel: Add keep-preamble-before-sfd property
Date: Fri, 12 Dec 2025 09:46:18 +0100
Message-ID: <20251212084657.29239-4-eichest@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251212084657.29239-1-eichest@gmail.com>
References: <20251212084657.29239-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Add a property to keep the preamble before the SFD is sent from the PHY
to the Ethernet controller. By default the preamble is removed, this
property allows to keep it.

This allows to workaround broken Ethernet controllers as found on the
NXP i.MX8MP. Specifically, errata ERR050694 that states:
ENET_QOS: MAC incorrectly discards the received packets when Preamble
Byte does not precede SFD or SMD.

The bit which disables this feature is not documented in the datasheet
from Micrel, but has been found by NXP and Micrel following this
discussion:
https://community.nxp.com/t5/i-MX-Processors/iMX8MP-eqos-not-working-for-10base-t/m-p/2151032

It has been tested on Verdin iMX8MP from Toradex by forcing the PHY to
10MBit. Withouth this property set, no packets are received. With this
property set, reception works fine.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 drivers/net/phy/micrel.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 05de68b9f7191..0bcc380d73653 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -101,6 +101,14 @@
 #define LAN8814_CABLE_DIAG_VCT_DATA_MASK	GENMASK(7, 0)
 #define LAN8814_PAIR_BIT_SHIFT			12
 
+/* KSZ9x31 remote loopback register */
+#define KSZ9x31_REMOTE_LOOPBACK			0x11
+/* This is an undocumented bit of the KSZ9131RNX.
+ * It was reported by NXP in cooperation with Micrel.
+ */
+#define KSZ9x31_REMOTE_LOOPBACK_KEEP_PREAMBLE	BIT(2)
+#define KSZ9x31_REMOTE_LOOPBACK_EN		BIT(8)
+
 #define LAN8814_SKUS				0xB
 
 #define LAN8814_WIRE_PAIR_MASK			0xF
@@ -455,6 +463,7 @@ struct kszphy_priv {
 	bool rmii_ref_clk_sel_val;
 	bool clk_enable;
 	bool is_ptp_available;
+	bool keep_preamble_before_sfd;
 	u64 stats[ARRAY_SIZE(kszphy_hw_stats)];
 	struct kszphy_phy_stats phy_stats;
 };
@@ -1452,6 +1461,7 @@ static int ksz9131_config_init(struct phy_device *phydev)
 		"txd2-skew-psec", "txd3-skew-psec"
 	};
 	char *control_skews[2] = {"txen-skew-psec", "rxdv-skew-psec"};
+	struct kszphy_priv *priv = phydev->priv;
 	const struct device *dev_walker;
 	int ret;
 
@@ -1500,6 +1510,17 @@ static int ksz9131_config_init(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
+	if (priv->keep_preamble_before_sfd) {
+		ret = phy_read(phydev, KSZ9x31_REMOTE_LOOPBACK);
+		if (ret < 0)
+			return ret;
+
+		ret |= KSZ9x31_REMOTE_LOOPBACK_KEEP_PREAMBLE;
+		ret = phy_write(phydev, KSZ9x31_REMOTE_LOOPBACK, ret);
+		if (ret < 0)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -2683,6 +2704,14 @@ static int kszphy_probe(struct phy_device *phydev)
 		priv->rmii_ref_clk_sel_val = true;
 	}
 
+	/* Keep the preamble before the SFD (Start Frame Delimiter). This might
+	 * be needed on some boards with a broken Ethernet controller like the
+	 * eqos used in the NXP i.MX8MP.
+	 */
+	if (phydev_id_compare(phydev, PHY_ID_KSZ9131))
+		priv->keep_preamble_before_sfd = of_property_read_bool(np,
+								       "micrel,keep-preamble-before-sfd");
+
 	return 0;
 }
 
-- 
2.51.0


