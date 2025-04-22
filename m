Return-Path: <netdev+bounces-184914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1EDA97B16
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 01:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05DAA189C403
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 23:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E35E218AA3;
	Tue, 22 Apr 2025 23:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="E5yYAI42"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765EE215F63
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 23:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745365017; cv=none; b=BmI1FYLXgzlD6znsggkG38WS+0HVxpWvZSBt7PxPeXNRgJp0Zigrm5YNlWgjfIgzA70xmoASMBbiAL951BdsU85+109hnBY+M6leDJud2JYCURlTPtdw7gMajF6u20DXN2p5AieT1jRxUcjd/gVpp+fqq3p/AHEUpF3Qsjok7Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745365017; c=relaxed/simple;
	bh=eEIW2gvZgLSb7Pz8Ul1nfbdzRGlEyxB6P/HVXAYmCt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i5WpxonJqZA36UtCudh0SELUNO+0LNcwXtxdnPWhv0FkdIwOAGSUmWn6rDjNPtUmFgo+ApYHZhyr0XOllEYmG2dAlS1thFYO+0sBxfet+9jXcWQwrAVdF+8Q+PxKchcNntZ/QEfhDJOsYZK5mW12+ubY2+F/na0XKntStiurUlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=E5yYAI42; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3f9832f798aso4030557b6e.2
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 16:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745365014; x=1745969814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpLGYGRWAX8yxn3lwRIXUey0r/7dG8Epo3Aibx5Gh6E=;
        b=E5yYAI42jCkUpYCupJhFuZGzrqkj7PXoDT7hSscJoVdr7lON6OjrUYPR1NqKBq9XSS
         RgSyrtFXQ8eb9hpA5L+9zDpkswdi6wviMSss5q6CN1ny5D12vqjjdt0+PLs3zkUBJEVE
         2ZlBeErfEVfrInemHlGgTtAQF/v2P3MRpto6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745365014; x=1745969814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FpLGYGRWAX8yxn3lwRIXUey0r/7dG8Epo3Aibx5Gh6E=;
        b=kz/bPbv/WD0XBg60cPu3Krz/KGQFpef+sIwnk3dZSZdu0bj7KXAUrw1ZhB+73xZZBK
         PSDisKs7ZOuoZtfvKx3i91ycAA2Oukbmomm4y1H+cYnPZRXb9EogXGDgFGZcoYLjHxcp
         CbCUeiLLW8+b6A8vBWcTR5p0UpYLhGVDHNKmqmwMHCNfaNdWFDO1dYGgPm2VHwkSsK0i
         rx06drRpXd957xrgZsONqAyt49UGa+b+RkcTi//gBPQqdFWoZ9nVFt9ZeJYjSapQ1UYC
         coniC7dKLjN2ThHtrUOwv5C0nami1G0hRGYTagNLU/fYhnZX2WrWS+6vESL2qPKtc/iK
         kA2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXRW++TCK2t/T9VHWzbOmI1YfhwWpB/t0aJ/EqXzgtt2EXmAQ4Vvj6TaBJKAro+H+Re/s6ycJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBTTvpIfSvLMsZ21+yh/2nvy0ghzbpkmaaJ9LORuYA9ZvvXFq1
	qYjAE/D66VSzOQ/Bl1KlQ+2VdFFdbDjEj9WYgPODcv9oKQolxQA4YCQXpOHi4Q==
X-Gm-Gg: ASbGnctShba++b9zh9jeaA3c2i+Z1IWSydFGBZ768hGywAimoruJFnGmi7/4h+CJZoq
	EuaEnS5SHQYyAv6NFtYvXDyfQx0+Dv16z1TJ4tkROykl2uwJvSjo2Xk0zh8wEqFB7fjb3B7x/d/
	Jm9udY/vCnHAp59aU/iu65EeoxoErq04PraZm9l18OxnqHzRBD8Y168YOMpI5wmJ1DtQeTLQCDu
	NCfOQhNwRb9+GRhE84nTqkVGXtnbYnmWe5b4+ka1nuxnCe54MN1QLumyDC0L76fbZE+sUzYhSDN
	wvf+GDLGYDWQ3EFG1gI/XqEyPJLoqua6W3X+oPQesDDQDbm5EDsPYYa5ALIV09bFdt08a+/Jtvv
	pY3xn7DvAmiuZpt4m/w==
X-Google-Smtp-Source: AGHT+IGohkWBPIuZsHhVal0ao3RsBZgpzzLYpBStHnN+x0H6Aaosw8+zvMsufo2YtvLtaXFb+H4QMw==
X-Received: by 2002:a05:6808:8101:b0:3f6:7e4e:96fb with SMTP id 5614622812f47-401c0a810e4mr10696679b6e.17.1745365014392;
        Tue, 22 Apr 2025 16:36:54 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-401beeaf403sm2333582b6e.7.2025.04.22.16.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 16:36:54 -0700 (PDT)
From: Justin Chen <justin.chen@broadcom.com>
To: devicetree@vger.kernel.org,
	netdev@vger.kernel.org
Cc: rafal@milecki.pl,
	linux@armlinux.org.uk,
	hkallweit1@gmail.com,
	bcm-kernel-feedback-list@broadcom.com,
	opendmb@gmail.com,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	florian.fainelli@broadcom.com,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net-next v2 3/8] net: bcmasp: Remove support for asp-v2.0
Date: Tue, 22 Apr 2025 16:36:40 -0700
Message-Id: <20250422233645.1931036-4-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250422233645.1931036-1-justin.chen@broadcom.com>
References: <20250422233645.1931036-1-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SoC that supported asp-v2.0 never saw the light of day. asp-v2.0 has
quirks that makes the logic overly complicated. For example, asp-v2.0 is
the only revision that has a different wake up IRQ hook up. Remove asp-v2.0
support to make supporting future HW revisions cleaner.

Signed-off-by: Justin Chen <justin.chen@broadcom.com>
---
v2
        - Removed unneeded eee_fixup NULL init.

 drivers/net/ethernet/broadcom/asp2/bcmasp.c   | 97 ++-----------------
 drivers/net/ethernet/broadcom/asp2/bcmasp.h   | 45 ++-------
 .../ethernet/broadcom/asp2/bcmasp_ethtool.c   | 21 +---
 .../net/ethernet/broadcom/asp2/bcmasp_intf.c  |  2 +-
 .../ethernet/broadcom/asp2/bcmasp_intf_defs.h |  3 +-
 5 files changed, 22 insertions(+), 146 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index a68fab1b05f0..1eab37296608 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -141,7 +141,7 @@ void bcmasp_flush_rx_port(struct bcmasp_intf *intf)
 		return;
 	}
 
-	rx_ctrl_core_wl(priv, mask, priv->hw_info->rx_ctrl_flush);
+	rx_ctrl_core_wl(priv, mask, ASP_RX_CTRL_FLUSH);
 }
 
 static void bcmasp_netfilt_hw_en_wake(struct bcmasp_priv *priv,
@@ -1108,7 +1108,7 @@ static int bcmasp_get_and_request_irq(struct bcmasp_priv *priv, int i)
 	return irq;
 }
 
-static void bcmasp_init_wol_shared(struct bcmasp_priv *priv)
+static void bcmasp_init_wol(struct bcmasp_priv *priv)
 {
 	struct platform_device *pdev = priv->pdev;
 	struct device *dev = &pdev->dev;
@@ -1125,7 +1125,7 @@ static void bcmasp_init_wol_shared(struct bcmasp_priv *priv)
 	device_set_wakeup_capable(&pdev->dev, 1);
 }
 
-static void bcmasp_enable_wol_shared(struct bcmasp_intf *intf, bool en)
+void bcmasp_enable_wol(struct bcmasp_intf *intf, bool en)
 {
 	struct bcmasp_priv *priv = intf->parent;
 	struct device *dev = &priv->pdev->dev;
@@ -1154,54 +1154,12 @@ static void bcmasp_enable_wol_shared(struct bcmasp_intf *intf, bool en)
 	}
 }
 
-static void bcmasp_wol_irq_destroy_shared(struct bcmasp_priv *priv)
+static void bcmasp_wol_irq_destroy(struct bcmasp_priv *priv)
 {
 	if (priv->wol_irq > 0)
 		free_irq(priv->wol_irq, priv);
 }
 
-static void bcmasp_init_wol_per_intf(struct bcmasp_priv *priv)
-{
-	struct platform_device *pdev = priv->pdev;
-	struct device *dev = &pdev->dev;
-	struct bcmasp_intf *intf;
-	int irq;
-
-	list_for_each_entry(intf, &priv->intfs, list) {
-		irq = bcmasp_get_and_request_irq(priv, intf->port + 1);
-		if (irq < 0) {
-			dev_warn(dev, "Failed to init WoL irq(port %d): %d\n",
-				 intf->port, irq);
-			continue;
-		}
-
-		intf->wol_irq = irq;
-		intf->wol_irq_enabled = false;
-		device_set_wakeup_capable(&pdev->dev, 1);
-	}
-}
-
-static void bcmasp_enable_wol_per_intf(struct bcmasp_intf *intf, bool en)
-{
-	struct device *dev = &intf->parent->pdev->dev;
-
-	if (en ^ intf->wol_irq_enabled)
-		irq_set_irq_wake(intf->wol_irq, en);
-
-	intf->wol_irq_enabled = en;
-	device_set_wakeup_enable(dev, en);
-}
-
-static void bcmasp_wol_irq_destroy_per_intf(struct bcmasp_priv *priv)
-{
-	struct bcmasp_intf *intf;
-
-	list_for_each_entry(intf, &priv->intfs, list) {
-		if (intf->wol_irq > 0)
-			free_irq(intf->wol_irq, priv);
-	}
-}
-
 static void bcmasp_eee_fixup(struct bcmasp_intf *intf, bool en)
 {
 	u32 reg, phy_lpi_overwrite;
@@ -1220,60 +1178,22 @@ static void bcmasp_eee_fixup(struct bcmasp_intf *intf, bool en)
 	usleep_range(50, 100);
 }
 
-static struct bcmasp_hw_info v20_hw_info = {
-	.rx_ctrl_flush = ASP_RX_CTRL_FLUSH,
-	.umac2fb = UMAC2FB_OFFSET,
-	.rx_ctrl_fb_out_frame_count = ASP_RX_CTRL_FB_OUT_FRAME_COUNT,
-	.rx_ctrl_fb_filt_out_frame_count = ASP_RX_CTRL_FB_FILT_OUT_FRAME_COUNT,
-	.rx_ctrl_fb_rx_fifo_depth = ASP_RX_CTRL_FB_RX_FIFO_DEPTH,
-};
-
-static const struct bcmasp_plat_data v20_plat_data = {
-	.init_wol = bcmasp_init_wol_per_intf,
-	.enable_wol = bcmasp_enable_wol_per_intf,
-	.destroy_wol = bcmasp_wol_irq_destroy_per_intf,
-	.core_clock_select = bcmasp_core_clock_select_one,
-	.hw_info = &v20_hw_info,
-};
-
-static struct bcmasp_hw_info v21_hw_info = {
-	.rx_ctrl_flush = ASP_RX_CTRL_FLUSH_2_1,
-	.umac2fb = UMAC2FB_OFFSET_2_1,
-	.rx_ctrl_fb_out_frame_count = ASP_RX_CTRL_FB_OUT_FRAME_COUNT_2_1,
-	.rx_ctrl_fb_filt_out_frame_count =
-		ASP_RX_CTRL_FB_FILT_OUT_FRAME_COUNT_2_1,
-	.rx_ctrl_fb_rx_fifo_depth = ASP_RX_CTRL_FB_RX_FIFO_DEPTH_2_1,
-};
-
 static const struct bcmasp_plat_data v21_plat_data = {
-	.init_wol = bcmasp_init_wol_shared,
-	.enable_wol = bcmasp_enable_wol_shared,
-	.destroy_wol = bcmasp_wol_irq_destroy_shared,
 	.core_clock_select = bcmasp_core_clock_select_one,
-	.hw_info = &v21_hw_info,
 };
 
 static const struct bcmasp_plat_data v22_plat_data = {
-	.init_wol = bcmasp_init_wol_shared,
-	.enable_wol = bcmasp_enable_wol_shared,
-	.destroy_wol = bcmasp_wol_irq_destroy_shared,
 	.core_clock_select = bcmasp_core_clock_select_many,
-	.hw_info = &v21_hw_info,
 	.eee_fixup = bcmasp_eee_fixup,
 };
 
 static void bcmasp_set_pdata(struct bcmasp_priv *priv, const struct bcmasp_plat_data *pdata)
 {
-	priv->init_wol = pdata->init_wol;
-	priv->enable_wol = pdata->enable_wol;
-	priv->destroy_wol = pdata->destroy_wol;
 	priv->core_clock_select = pdata->core_clock_select;
 	priv->eee_fixup = pdata->eee_fixup;
-	priv->hw_info = pdata->hw_info;
 }
 
 static const struct of_device_id bcmasp_of_match[] = {
-	{ .compatible = "brcm,asp-v2.0", .data = &v20_plat_data },
 	{ .compatible = "brcm,asp-v2.1", .data = &v21_plat_data },
 	{ .compatible = "brcm,asp-v2.2", .data = &v22_plat_data },
 	{ /* sentinel */ },
@@ -1281,9 +1201,8 @@ static const struct of_device_id bcmasp_of_match[] = {
 MODULE_DEVICE_TABLE(of, bcmasp_of_match);
 
 static const struct of_device_id bcmasp_mdio_of_match[] = {
-	{ .compatible = "brcm,asp-v2.2-mdio", },
 	{ .compatible = "brcm,asp-v2.1-mdio", },
-	{ .compatible = "brcm,asp-v2.0-mdio", },
+	{ .compatible = "brcm,asp-v2.2-mdio", },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, bcmasp_mdio_of_match);
@@ -1387,7 +1306,7 @@ static int bcmasp_probe(struct platform_device *pdev)
 	}
 
 	/* Check and enable WoL */
-	priv->init_wol(priv);
+	bcmasp_init_wol(priv);
 
 	/* Drop the clock reference count now and let ndo_open()/ndo_close()
 	 * manage it for us from now on.
@@ -1404,7 +1323,7 @@ static int bcmasp_probe(struct platform_device *pdev)
 		if (ret) {
 			netdev_err(intf->ndev,
 				   "failed to register net_device: %d\n", ret);
-			priv->destroy_wol(priv);
+			bcmasp_wol_irq_destroy(priv);
 			bcmasp_remove_intfs(priv);
 			goto of_put_exit;
 		}
@@ -1425,7 +1344,7 @@ static void bcmasp_remove(struct platform_device *pdev)
 	if (!priv)
 		return;
 
-	priv->destroy_wol(priv);
+	bcmasp_wol_irq_destroy(priv);
 	bcmasp_remove_intfs(priv);
 }
 
diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.h b/drivers/net/ethernet/broadcom/asp2/bcmasp.h
index 8fc75bcedb70..6f49ebad4e99 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.h
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.h
@@ -53,22 +53,15 @@
 #define ASP_RX_CTRL_FB_0_FRAME_COUNT		0x14
 #define ASP_RX_CTRL_FB_1_FRAME_COUNT		0x18
 #define ASP_RX_CTRL_FB_8_FRAME_COUNT		0x1c
-/* asp2.1 diverges offsets here */
-/* ASP2.0 */
-#define ASP_RX_CTRL_FB_OUT_FRAME_COUNT		0x20
-#define ASP_RX_CTRL_FB_FILT_OUT_FRAME_COUNT	0x24
-#define ASP_RX_CTRL_FLUSH			0x28
-#define  ASP_CTRL_UMAC0_FLUSH_MASK		(BIT(0) | BIT(12))
-#define  ASP_CTRL_UMAC1_FLUSH_MASK		(BIT(1) | BIT(13))
-#define  ASP_CTRL_SPB_FLUSH_MASK		(BIT(8) | BIT(20))
-#define ASP_RX_CTRL_FB_RX_FIFO_DEPTH		0x30
-/* ASP2.1 */
-#define ASP_RX_CTRL_FB_9_FRAME_COUNT_2_1	0x20
-#define ASP_RX_CTRL_FB_10_FRAME_COUNT_2_1	0x24
-#define ASP_RX_CTRL_FB_OUT_FRAME_COUNT_2_1	0x28
-#define ASP_RX_CTRL_FB_FILT_OUT_FRAME_COUNT_2_1	0x2c
-#define ASP_RX_CTRL_FLUSH_2_1			0x30
-#define ASP_RX_CTRL_FB_RX_FIFO_DEPTH_2_1	0x38
+#define ASP_RX_CTRL_FB_9_FRAME_COUNT		0x20
+#define ASP_RX_CTRL_FB_10_FRAME_COUNT		0x24
+#define ASP_RX_CTRL_FB_OUT_FRAME_COUNT		0x28
+#define ASP_RX_CTRL_FB_FILT_OUT_FRAME_COUNT	0x2c
+#define ASP_RX_CTRL_FLUSH			0x30
+#define  ASP_CTRL_UMAC0_FLUSH_MASK             (BIT(0) | BIT(12))
+#define  ASP_CTRL_UMAC1_FLUSH_MASK             (BIT(1) | BIT(13))
+#define  ASP_CTRL_SPB_FLUSH_MASK               (BIT(8) | BIT(20))
+#define ASP_RX_CTRL_FB_RX_FIFO_DEPTH		0x38
 
 #define ASP_RX_FILTER_OFFSET			0x80000
 #define  ASP_RX_FILTER_BLK_CTRL			0x0
@@ -345,9 +338,6 @@ struct bcmasp_intf {
 
 	u32				wolopts;
 	u8				sopass[SOPASS_MAX];
-	/* Used if per intf wol irq */
-	int				wol_irq;
-	unsigned int			wol_irq_enabled:1;
 };
 
 #define NUM_NET_FILTERS				32
@@ -370,21 +360,9 @@ struct bcmasp_mda_filter {
 	u8		mask[ETH_ALEN];
 };
 
-struct bcmasp_hw_info {
-	u32		rx_ctrl_flush;
-	u32		umac2fb;
-	u32		rx_ctrl_fb_out_frame_count;
-	u32		rx_ctrl_fb_filt_out_frame_count;
-	u32		rx_ctrl_fb_rx_fifo_depth;
-};
-
 struct bcmasp_plat_data {
-	void (*init_wol)(struct bcmasp_priv *priv);
-	void (*enable_wol)(struct bcmasp_intf *intf, bool en);
-	void (*destroy_wol)(struct bcmasp_priv *priv);
 	void (*core_clock_select)(struct bcmasp_priv *priv, bool slow);
 	void (*eee_fixup)(struct bcmasp_intf *priv, bool en);
-	struct bcmasp_hw_info		*hw_info;
 };
 
 struct bcmasp_priv {
@@ -399,14 +377,10 @@ struct bcmasp_priv {
 	int				wol_irq;
 	unsigned long			wol_irq_enabled_mask;
 
-	void (*init_wol)(struct bcmasp_priv *priv);
-	void (*enable_wol)(struct bcmasp_intf *intf, bool en);
-	void (*destroy_wol)(struct bcmasp_priv *priv);
 	void (*core_clock_select)(struct bcmasp_priv *priv, bool slow);
 	void (*eee_fixup)(struct bcmasp_intf *intf, bool en);
 
 	void __iomem			*base;
-	struct	bcmasp_hw_info		*hw_info;
 
 	struct list_head		intfs;
 
@@ -599,4 +573,5 @@ int bcmasp_netfilt_get_all_active(struct bcmasp_intf *intf, u32 *rule_locs,
 
 void bcmasp_netfilt_suspend(struct bcmasp_intf *intf);
 
+void bcmasp_enable_wol(struct bcmasp_intf *intf, bool en);
 #endif
diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
index a537c121d3e2..991a87096e08 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
@@ -71,23 +71,6 @@ static const struct bcmasp_stats bcmasp_gstrings_stats[] = {
 
 #define BCMASP_STATS_LEN	ARRAY_SIZE(bcmasp_gstrings_stats)
 
-static u16 bcmasp_stat_fixup_offset(struct bcmasp_intf *intf,
-				    const struct bcmasp_stats *s)
-{
-	struct bcmasp_priv *priv = intf->parent;
-
-	if (!strcmp("Frames Out(Buffer)", s->stat_string))
-		return priv->hw_info->rx_ctrl_fb_out_frame_count;
-
-	if (!strcmp("Frames Out(Filters)", s->stat_string))
-		return priv->hw_info->rx_ctrl_fb_filt_out_frame_count;
-
-	if (!strcmp("RX Buffer FIFO Depth", s->stat_string))
-		return priv->hw_info->rx_ctrl_fb_rx_fifo_depth;
-
-	return s->reg_offset;
-}
-
 static int bcmasp_get_sset_count(struct net_device *dev, int string_set)
 {
 	switch (string_set) {
@@ -126,7 +109,7 @@ static void bcmasp_update_mib_counters(struct bcmasp_intf *intf)
 		char *p;
 
 		s = &bcmasp_gstrings_stats[i];
-		offset = bcmasp_stat_fixup_offset(intf, s);
+		offset = s->reg_offset;
 		switch (s->type) {
 		case BCMASP_STAT_SOFT:
 			continue;
@@ -215,7 +198,7 @@ static int bcmasp_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 		memcpy(intf->sopass, wol->sopass, sizeof(wol->sopass));
 
 	mutex_lock(&priv->wol_lock);
-	priv->enable_wol(intf, !!intf->wolopts);
+	bcmasp_enable_wol(intf, !!intf->wolopts);
 	mutex_unlock(&priv->wol_lock);
 
 	return 0;
diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index 45ec1a9214a2..01de05ec3ebc 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
@@ -1185,7 +1185,7 @@ static void bcmasp_map_res(struct bcmasp_priv *priv, struct bcmasp_intf *intf)
 {
 	/* Per port */
 	intf->res.umac = priv->base + UMC_OFFSET(intf);
-	intf->res.umac2fb = priv->base + (priv->hw_info->umac2fb +
+	intf->res.umac2fb = priv->base + (UMAC2FB_OFFSET +
 					  (intf->port * 0x4));
 	intf->res.rgmii = priv->base + RGMII_OFFSET(intf);
 
diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf_defs.h b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf_defs.h
index ad742612895f..af7418348e81 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf_defs.h
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf_defs.h
@@ -118,8 +118,7 @@
 #define  UMC_PSW_MS			0x624
 #define  UMC_PSW_LS			0x628
 
-#define UMAC2FB_OFFSET_2_1		0x9f044
-#define UMAC2FB_OFFSET			0x9f03c
+#define UMAC2FB_OFFSET			0x9f044
 #define  UMAC2FB_CFG			0x0
 #define   UMAC2FB_CFG_OPUT_EN		BIT(0)
 #define   UMAC2FB_CFG_VLAN_EN		BIT(1)
-- 
2.34.1


