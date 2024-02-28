Return-Path: <netdev+bounces-75930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0DC86BB10
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 23:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81C6828A0E7
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 22:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0019276EE5;
	Wed, 28 Feb 2024 22:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MJpVcKSA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093617442E
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 22:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709160873; cv=none; b=R4OjlmQCeicZNWvEM4whHkrzVVZ2B5UynyYJBh6DAhaZBqxjYZ0JhqBUSMzO8QPKEr8r8JsM3KP67ohJ8oPUC8LSNbKO5OuneBGE6D+Mcky5iXwU8Zj99dh7LvlxSa0TOTkTjl/K6iXmRYvnFQ5i9M0u0Vn2FfrX0rG2+nsDSOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709160873; c=relaxed/simple;
	bh=bC2LvQzQODu87pkiGciZzfXIoGJvfBxG/cIp2ufTYoY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lPz1bCtIugpevsMmIA+BWb8iPFGWJVtFoeV2G2EmbcItdkQLyWzPY0MxFrygBAIA8Zxk5kbu8BjcNZveXMhGLD+MmWv1Ym4bEf4nIw276gb+9D+2KrErHjJGSNa03q9tIyvNUbvtSQEDw7dFWvNqs/aYPkaNT9KFUjCi9qUNW/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MJpVcKSA; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-42e89610ed8so1739361cf.3
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 14:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1709160865; x=1709765665; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rP5gxB3N/XzfGbU3HPfxW1WDLDfb1aNd3i6DVeLVh6c=;
        b=MJpVcKSArsZbBVp9Ey21FOGB5Rh2LlroVQcY7axOIJmts10VK2dncvQZvlsjPb9lyB
         UEAqZvV2JOc+LutGMSXrgI5K40vsbCzxM6yhKi/8XvgGFkR/JzySmqavLetXpPq/cYDp
         pwK5tkBVVa7kNVhg2/F6G1duqg2cL9jxq0FVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709160865; x=1709765665;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rP5gxB3N/XzfGbU3HPfxW1WDLDfb1aNd3i6DVeLVh6c=;
        b=I7NGyARoI9Le3dNeJMIV6YHOTTSsroKC/kLnVs/maoDRv8tna5zoDKIo2rmmWnUJID
         IsKrxxYDQw+/KaACGjOGYIQiJYWrEtKKT6ufhhM9IXTj7TvFEuMyP5T39c3oqEQfPFGK
         +rRYi6WJjA1duhS9gJEfKH0uhxiZOvDwHCbRzXxIzc+V/dlsA5i6v7LzuI4dVY0KT/nA
         3Utzuv2LNHJ5pdZ2B4v8DqEHlu5P7P3BWWwDsOFdebRvD709njQIRxQ5cW/pvwmRXJQI
         IMp+XjToRs/JLypcpa3wL0iuqMgvFKIDKq8VvOAf+5SpnK4fiYEFwMThoR9eIYHGGgVC
         AN1w==
X-Gm-Message-State: AOJu0Yw9Rz1B1kRnHzivj3W1exehfC51px6sXA2y8Nl8UaqN38eoDCLH
	aGycYssH5uFR4fgY9OB8gU/gQ6liGR9mTt+G18sIV0UHDewJtD0T5DTTKOMFqDqImQ3+nyZVbwG
	VO1WiPJ0xDQXqxmot7Zb8qx5sQL8Sw5qjh4kslrgmn4dKbaO6h19nLiL79f4mbyN9hl2WN/fuUR
	E8x7wbOQEHLp/adrRKrCMDXppX9QlX0HN2NTuEw0woR9OQ
X-Google-Smtp-Source: AGHT+IHEohhI9trQCiFtr6xrzgIxkpRcty9tBBZctGxBIKZMbol7k2w7tp+lWVKh+2QF+Iprkszv4w==
X-Received: by 2002:ac8:7f4a:0:b0:42e:b777:f28b with SMTP id g10-20020ac87f4a000000b0042eb777f28bmr553922qtk.12.1709160864848;
        Wed, 28 Feb 2024 14:54:24 -0800 (PST)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id b1-20020ac812c1000000b0042e3468a98csm95036qtj.4.2024.02.28.14.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 14:54:24 -0800 (PST)
From: Justin Chen <justin.chen@broadcom.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	florian.fainelli@broadcom.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	opendmb@gmail.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	rafal@milecki.pl,
	devicetree@vger.kernel.org,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net-next v3 3/6] net: bcmasp: Add support for ASP 2.2
Date: Wed, 28 Feb 2024 14:53:57 -0800
Message-Id: <20240228225400.3509156-4-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228225400.3509156-1-justin.chen@broadcom.com>
References: <20240228225400.3509156-1-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003dc7fb0612790610"

--0000000000003dc7fb0612790610
Content-Transfer-Encoding: 8bit

ASP 2.2 improves power savings during low power modes.

A new register was added to toggle to a slower clock during low
power modes.

EEE was broken for ASP 2.0/2.1. A HW workaround was added for
ASP 2.2 that requires toggling a chicken bit.

Signed-off-by: Justin Chen <justin.chen@broadcom.com>
Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp.c   | 73 +++++++++++++++++--
 drivers/net/ethernet/broadcom/asp2/bcmasp.h   | 18 ++++-
 .../net/ethernet/broadcom/asp2/bcmasp_intf.c  |  6 ++
 3 files changed, 87 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index 80245c65cc90..100c69f3307a 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -972,7 +972,26 @@ static void bcmasp_core_init(struct bcmasp_priv *priv)
 		      ASP_INTR2_CLEAR);
 }
 
-static void bcmasp_core_clock_select(struct bcmasp_priv *priv, bool slow)
+static void bcmasp_core_clock_select_many(struct bcmasp_priv *priv, bool slow)
+{
+	u32 reg;
+
+	reg = ctrl2_core_rl(priv, ASP_CTRL2_CORE_CLOCK_SELECT);
+	if (slow)
+		reg &= ~ASP_CTRL2_CORE_CLOCK_SELECT_MAIN;
+	else
+		reg |= ASP_CTRL2_CORE_CLOCK_SELECT_MAIN;
+	ctrl2_core_wl(priv, reg, ASP_CTRL2_CORE_CLOCK_SELECT);
+
+	reg = ctrl2_core_rl(priv, ASP_CTRL2_CPU_CLOCK_SELECT);
+	if (slow)
+		reg &= ~ASP_CTRL2_CPU_CLOCK_SELECT_MAIN;
+	else
+		reg |= ASP_CTRL2_CPU_CLOCK_SELECT_MAIN;
+	ctrl2_core_wl(priv, reg, ASP_CTRL2_CPU_CLOCK_SELECT);
+}
+
+static void bcmasp_core_clock_select_one(struct bcmasp_priv *priv, bool slow)
 {
 	u32 reg;
 
@@ -1166,6 +1185,24 @@ static void bcmasp_wol_irq_destroy_per_intf(struct bcmasp_priv *priv)
 	}
 }
 
+static void bcmasp_eee_fixup(struct bcmasp_intf *intf, bool en)
+{
+	u32 reg, phy_lpi_overwrite;
+
+	reg = rx_edpkt_core_rl(intf->parent, ASP_EDPKT_SPARE_REG);
+	phy_lpi_overwrite = intf->internal_phy ? ASP_EDPKT_SPARE_REG_EPHY_LPI :
+			    ASP_EDPKT_SPARE_REG_GPHY_LPI;
+
+	if (en)
+		reg |= phy_lpi_overwrite;
+	else
+		reg &= ~phy_lpi_overwrite;
+
+	rx_edpkt_core_wl(intf->parent, reg, ASP_EDPKT_SPARE_REG);
+
+	usleep_range(50, 100);
+}
+
 static struct bcmasp_hw_info v20_hw_info = {
 	.rx_ctrl_flush = ASP_RX_CTRL_FLUSH,
 	.umac2fb = UMAC2FB_OFFSET,
@@ -1178,6 +1215,7 @@ static const struct bcmasp_plat_data v20_plat_data = {
 	.init_wol = bcmasp_init_wol_per_intf,
 	.enable_wol = bcmasp_enable_wol_per_intf,
 	.destroy_wol = bcmasp_wol_irq_destroy_per_intf,
+	.core_clock_select = bcmasp_core_clock_select_one,
 	.hw_info = &v20_hw_info,
 };
 
@@ -1194,17 +1232,39 @@ static const struct bcmasp_plat_data v21_plat_data = {
 	.init_wol = bcmasp_init_wol_shared,
 	.enable_wol = bcmasp_enable_wol_shared,
 	.destroy_wol = bcmasp_wol_irq_destroy_shared,
+	.core_clock_select = bcmasp_core_clock_select_one,
 	.hw_info = &v21_hw_info,
 };
 
+static const struct bcmasp_plat_data v22_plat_data = {
+	.init_wol = bcmasp_init_wol_shared,
+	.enable_wol = bcmasp_enable_wol_shared,
+	.destroy_wol = bcmasp_wol_irq_destroy_shared,
+	.core_clock_select = bcmasp_core_clock_select_many,
+	.hw_info = &v21_hw_info,
+	.eee_fixup = bcmasp_eee_fixup,
+};
+
+static void bcmasp_set_pdata(struct bcmasp_priv *priv, const struct bcmasp_plat_data *pdata)
+{
+	priv->init_wol = pdata->init_wol;
+	priv->enable_wol = pdata->enable_wol;
+	priv->destroy_wol = pdata->destroy_wol;
+	priv->core_clock_select = pdata->core_clock_select;
+	priv->eee_fixup = pdata->eee_fixup;
+	priv->hw_info = pdata->hw_info;
+}
+
 static const struct of_device_id bcmasp_of_match[] = {
 	{ .compatible = "brcm,asp-v2.0", .data = &v20_plat_data },
 	{ .compatible = "brcm,asp-v2.1", .data = &v21_plat_data },
+	{ .compatible = "brcm,asp-v2.2", .data = &v22_plat_data },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, bcmasp_of_match);
 
 static const struct of_device_id bcmasp_mdio_of_match[] = {
+	{ .compatible = "brcm,asp-v2.2-mdio", },
 	{ .compatible = "brcm,asp-v2.1-mdio", },
 	{ .compatible = "brcm,asp-v2.0-mdio", },
 	{ /* sentinel */ },
@@ -1265,16 +1325,13 @@ static int bcmasp_probe(struct platform_device *pdev)
 	if (!pdata)
 		return dev_err_probe(dev, -EINVAL, "unable to find platform data\n");
 
-	priv->init_wol = pdata->init_wol;
-	priv->enable_wol = pdata->enable_wol;
-	priv->destroy_wol = pdata->destroy_wol;
-	priv->hw_info = pdata->hw_info;
+	bcmasp_set_pdata(priv, pdata);
 
 	/* Enable all clocks to ensure successful probing */
 	bcmasp_core_clock_set(priv, ASP_CTRL_CLOCK_CTRL_ASP_ALL_DISABLE, 0);
 
 	/* Switch to the main clock */
-	bcmasp_core_clock_select(priv, false);
+	priv->core_clock_select(priv, false);
 
 	bcmasp_intr2_mask_set_all(priv);
 	bcmasp_intr2_clear_all(priv);
@@ -1381,7 +1438,7 @@ static int __maybe_unused bcmasp_suspend(struct device *d)
 	 */
 	bcmasp_core_clock_set(priv, 0, ASP_CTRL_CLOCK_CTRL_ASP_TX_DISABLE);
 
-	bcmasp_core_clock_select(priv, true);
+	priv->core_clock_select(priv, true);
 
 	clk_disable_unprepare(priv->clk);
 
@@ -1399,7 +1456,7 @@ static int __maybe_unused bcmasp_resume(struct device *d)
 		return ret;
 
 	/* Switch to the main clock domain */
-	bcmasp_core_clock_select(priv, false);
+	priv->core_clock_select(priv, false);
 
 	/* Re-enable all clocks for re-initialization */
 	bcmasp_core_clock_set(priv, ASP_CTRL_CLOCK_CTRL_ASP_ALL_DISABLE, 0);
diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.h b/drivers/net/ethernet/broadcom/asp2/bcmasp.h
index 312bf9b6576e..61598dc070b1 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.h
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.h
@@ -33,6 +33,12 @@
 #define ASP_WAKEUP_INTR2_FILT_1			BIT(3)
 #define ASP_WAKEUP_INTR2_FW			BIT(4)
 
+#define ASP_CTRL2_OFFSET			0x2000
+#define  ASP_CTRL2_CORE_CLOCK_SELECT		0x0
+#define   ASP_CTRL2_CORE_CLOCK_SELECT_MAIN	BIT(0)
+#define  ASP_CTRL2_CPU_CLOCK_SELECT		0x4
+#define   ASP_CTRL2_CPU_CLOCK_SELECT_MAIN	BIT(0)
+
 #define ASP_TX_ANALYTICS_OFFSET			0x4c000
 #define  ASP_TX_ANALYTICS_CTRL			0x0
 
@@ -134,8 +140,11 @@ enum asp_rx_net_filter_block {
 #define ASP_EDPKT_RX_PKT_CNT			0x138
 #define ASP_EDPKT_HDR_EXTR_CNT			0x13c
 #define ASP_EDPKT_HDR_OUT_CNT			0x140
+#define ASP_EDPKT_SPARE_REG			0x174
+#define  ASP_EDPKT_SPARE_REG_EPHY_LPI		BIT(4)
+#define  ASP_EDPKT_SPARE_REG_GPHY_LPI		BIT(3)
 
-#define ASP_CTRL				0x101000
+#define ASP_CTRL_OFFSET				0x101000
 #define  ASP_CTRL_ASP_SW_INIT			0x04
 #define   ASP_CTRL_ASP_SW_INIT_ACPUSS_CORE	BIT(0)
 #define   ASP_CTRL_ASP_SW_INIT_ASP_TX		BIT(1)
@@ -372,6 +381,8 @@ struct bcmasp_plat_data {
 	void (*init_wol)(struct bcmasp_priv *priv);
 	void (*enable_wol)(struct bcmasp_intf *intf, bool en);
 	void (*destroy_wol)(struct bcmasp_priv *priv);
+	void (*core_clock_select)(struct bcmasp_priv *priv, bool slow);
+	void (*eee_fixup)(struct bcmasp_intf *priv, bool en);
 	struct bcmasp_hw_info		*hw_info;
 };
 
@@ -390,6 +401,8 @@ struct bcmasp_priv {
 	void (*init_wol)(struct bcmasp_priv *priv);
 	void (*enable_wol)(struct bcmasp_intf *intf, bool en);
 	void (*destroy_wol)(struct bcmasp_priv *priv);
+	void (*core_clock_select)(struct bcmasp_priv *priv, bool slow);
+	void (*eee_fixup)(struct bcmasp_intf *intf, bool en);
 
 	void __iomem			*base;
 	struct	bcmasp_hw_info		*hw_info;
@@ -530,7 +543,8 @@ BCMASP_CORE_IO_MACRO(rx_analytics, ASP_RX_ANALYTICS_OFFSET);
 BCMASP_CORE_IO_MACRO(rx_ctrl, ASP_RX_CTRL_OFFSET);
 BCMASP_CORE_IO_MACRO(rx_filter, ASP_RX_FILTER_OFFSET);
 BCMASP_CORE_IO_MACRO(rx_edpkt, ASP_EDPKT_OFFSET);
-BCMASP_CORE_IO_MACRO(ctrl, ASP_CTRL);
+BCMASP_CORE_IO_MACRO(ctrl, ASP_CTRL_OFFSET);
+BCMASP_CORE_IO_MACRO(ctrl2, ASP_CTRL2_OFFSET);
 
 struct bcmasp_intf *bcmasp_interface_create(struct bcmasp_priv *priv,
 					    struct device_node *ndev_dn, int i);
diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index e429876c7291..36e6fae937ea 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
@@ -1333,6 +1333,9 @@ static void bcmasp_suspend_to_wol(struct bcmasp_intf *intf)
 				     ASP_WAKEUP_INTR2_MASK_CLEAR);
 	}
 
+	if (intf->eee.eee_enabled && intf->parent->eee_fixup)
+		intf->parent->eee_fixup(intf, true);
+
 	netif_dbg(intf, wol, ndev, "entered WOL mode\n");
 }
 
@@ -1381,6 +1384,9 @@ static void bcmasp_resume_from_wol(struct bcmasp_intf *intf)
 {
 	u32 reg;
 
+	if (intf->eee.eee_enabled && intf->parent->eee_fixup)
+		intf->parent->eee_fixup(intf, false);
+
 	reg = umac_rl(intf, UMC_MPD_CTRL);
 	reg &= ~UMC_MPD_CTRL_MPD_EN;
 	umac_wl(intf, reg, UMC_MPD_CTRL);
-- 
2.34.1


--0000000000003dc7fb0612790610
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
NhTY3E+cXCB11wty89QStajwXdhGJTYEvUgvsq1h8CwJj9w/38ldAQf5WjhPmApYeJR2ewFrBMCM
4lHkdRJ6TDc9nXoEkypUfjJkJHe7Eal06tosh6JpAgMBAAGjggHZMIIB1TAOBgNVHQ8BAf8EBAMC
BaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJlLmdsb2JhbHNp
Z24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYIKwYBBQUHMAGG
NWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwME0G
A1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxz
aWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqGOGh0dHA6Ly9j
cmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3JsMCMGA1UdEQQc
MBqBGGp1c3Rpbi5jaGVuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSME
GDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUIWGeYuaTsnIada5Xx8TR3cheUbgw
DQYJKoZIhvcNAQELBQADggEBAHNQlMqQOFYPYFO71A+8t+qWMmtOdd2iGswSOvpSZ/pmGlfw8ZvY
dRTkl27m37la84AxRkiVMes14JyOZJoMh/g7fbgPlU14eBc6WQWkIA6AmNkduFWTr1pRezkjpeo6
xVmdBLM4VY1TFDYj7S8H2adPuypd62uHMY/MZi+BIUys4uAFA+N3NuUBNjcVZXYPplYxxKEuIFq6
sDL+OV16G+F9CkNMN3txsym8Nnx5WAYZb6+rBUIhMGz70V05xsHQfzvo2s7f0J1tJ5BoRlPPhL0h
VOnWA3h71u9TfSsv+PXVm3P21TfOS2uc1hbzEqyENCP4i5XQ0rv0TmPW42GZ0o4xggJtMIICaQIB
ATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhH
bG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwj8BKLXNpALfemdRAwDQYJ
YIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIEk6+546XFh4xlVMCD1bKK2jQka5emk5HPwy
LK1ByoR9MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDIyODIy
NTQyNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFl
AwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATAN
BgkqhkiG9w0BAQEFAASCAQA3uYx3n536B/m2IlX82uHx1GxGHGuuXaiRaWbDKtEyViArC7vUgmKa
SKxIiFu9mEhiw3choCdHK9oN7FjbsILc75my415DAPOHHSrn5HJgmDsgfGtpldXh1IH4fes614zV
FlELjXKr2kTJTJ3L2Y57aechx0UwD1buy2fQWkbrFQbm5dFMnCj8ywEGodGFTMzeGl4QClnyWos2
0CpHoH1dHb6HZYkZy52NuAAmivZ9b8fsu4ZGuvSqX4Z1LSUq4HHyRDfWj+uT/hiTaFkvkwB1uPoG
R52VJ++7buRSqLUFtV2phU7MG1Tp8MrawtZqiSpuvJj3KqkCW8zDPKkWdxMP
--0000000000003dc7fb0612790610--

