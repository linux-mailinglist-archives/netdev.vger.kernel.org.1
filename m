Return-Path: <netdev+bounces-183531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A7EA90EDA
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 00:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE129447D59
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 22:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A46E24888D;
	Wed, 16 Apr 2025 22:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EGMP/Xx7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFBB2459E3
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 22:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744843708; cv=none; b=bGLeudNbLCxlIbdNQxzoiQ6v5OuKRtC0+EaUvXkRLWzQQnsSc+8Nvnz6CBOboi5DTymupllo3uFu7yZcTM4G3fLLLTX/1D9L/vk9NACP14zEhO3bzFpA8VpAlYEEs276fEU1DwW/+zTxd6fnv/eFdR6vAmOrYH5Pr+dME1WBJXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744843708; c=relaxed/simple;
	bh=159ULwvDMtPYBOoa4wD6mVkZFhP8Fodgq58ywFafh1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d9QX0o6S0hAIilrDy2+bWqnLzMfc75/+BRFWN2CX+WRlXmn5qBduLzbFNphqz0+hnT9cZJZwyctvIcLOi7goeLEzyNZa8tKMccx4RgXRomO71BwxoNItZ6JHCyhULwlWT9LoZ4qaLRaGZpmW7pwCZY6Ji3gHU//FY7zRscQ7JQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EGMP/Xx7; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2cc89c59cc0so722083fac.0
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 15:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744843705; x=1745448505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UY8JzdCLfohPOTgU54JiViTQYDrjESSExXV36Tvj0+A=;
        b=EGMP/Xx7nqV06DjLxUa7vAdJzWxjOfPAntF7yZXVTy9ZRpeSCnmqykJzbTJVMZeNjP
         vUPjlZ9mIglRV6I4Sp8/42NpTbHHxiCw8KT4gmn3+gH3gcI2s4mOSLD+IgMcy41RdUCM
         mG7IDEa8hvKsKdQVUWQLbbIg0rZi+CmLGvnB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744843705; x=1745448505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UY8JzdCLfohPOTgU54JiViTQYDrjESSExXV36Tvj0+A=;
        b=nkKofQ1vExUg9jOZEGF6v7cMtHKLBtMdRqbUOCQduk0iR08gH7UubDmGlxII67LmIA
         8q7k3p6iLBOMe5Sx0sdEAc+/xvBAXJ3j4JuAf0FQS8MsIMELtYTuWgJNVrD3xM80EDPI
         OUxa1xpo0/dRX7bB3k8A19b/TORPd8SAvIr3+T/UPEb6XxT1bUrGCCMqR8dXPSAqdMhO
         X6c7hrkf6SJHuufa9vlnCOegSjhXH9y7E2f83/wLpnMGnmAWd+eZPebg1F9a5cb9w53b
         1CHWolNH6urp0b3JWuSGqP8UDWvzqLxe6zPGMjdxNkCj5jGoC6nNYwhcbi/1IMBkEn9f
         0zMA==
X-Gm-Message-State: AOJu0YxM5hNSt5S0umwJp9rn2+yNL4qR3DUXa+Hf3QbfLCeTqQFOfM3i
	vl67YitQByP91yhIz1F+ombVeg4T6Tz6Mu/BLf9Gp+5SjmpUyMxya5QgZGwbtXPBFngf/n8Vhiq
	GgumhZ1UNxRRV1OHyfuvhgG8TpdWtB8SMvQJlNw0ONClvAKCewgL0j0Zn8nwYI90ENIcTS8qVmH
	OQ39xu4e6eVRpZ1Rw3Tt574e+tHHJvVcFTgdncNLk=
X-Gm-Gg: ASbGncvslOY0pfHZSgximE39Wjzu4EX6UrpJDwidjoQqjfromj+IQDEyvrjUtvIvaD2
	egN1R2PMZJjL1sLNL8uBjNktgjYW0fXDgZEVKucSOaJg2EygpZYjVKdhHVewbe0mjuI0G3IiHur
	pYQujQuPMR0iniMXYlJZJE2axTFyACs6kBKunHpb2/xVTXmOoTnQTl7qY6BF6u3RcCqOhtWQd2H
	2BxViM0AlGHyAmF7w0lVDG5V1EhbLNxAW+n8L8XgHP30kFd/hd4MLld7xiqVTRPvH7L5S9fGtlt
	W6wXqyfOsb8/9YZhGbwWO83SR7vXkPXo3EkuwvkeWM7hV1avg+hKJ9JREGpaux9BzGk2gvVIfeF
	cVd2UbcVrueFP4THTPA==
X-Google-Smtp-Source: AGHT+IEWpfZXf3zJgNds8sZbDBHIXFAweWSc9QBAKodlG47rxC9SQiFDkLpZZksw8SIQ/5riwzTFlA==
X-Received: by 2002:a05:6870:79f:b0:2b8:b76f:1196 with SMTP id 586e51a60fabf-2d4f2d56596mr333307fac.19.1744843705334;
        Wed, 16 Apr 2025 15:48:25 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72e73d71813sm3015956a34.26.2025.04.16.15.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 15:48:25 -0700 (PDT)
From: Justin Chen <justin.chen@broadcom.com>
To: netdev@vger.kernel.org,
	devicetree@vger.kernel.org
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
Subject: [PATCH net-next 3/5] net: bcmasp: Remove support for asp-v2.0
Date: Wed, 16 Apr 2025 15:48:13 -0700
Message-Id: <20250416224815.2863862-4-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250416224815.2863862-1-justin.chen@broadcom.com>
References: <20250416224815.2863862-1-justin.chen@broadcom.com>
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
 drivers/net/ethernet/broadcom/asp2/bcmasp.c   | 98 ++-----------------
 drivers/net/ethernet/broadcom/asp2/bcmasp.h   | 45 ++-------
 .../ethernet/broadcom/asp2/bcmasp_ethtool.c   | 21 +---
 .../net/ethernet/broadcom/asp2/bcmasp_intf.c  |  2 +-
 .../ethernet/broadcom/asp2/bcmasp_intf_defs.h |  3 +-
 5 files changed, 23 insertions(+), 146 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index a68fab1b05f0..b00e24e871a2 100644
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
@@ -1220,60 +1178,23 @@ static void bcmasp_eee_fixup(struct bcmasp_intf *intf, bool en)
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
+	.eee_fixup = NULL;
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
@@ -1281,9 +1202,8 @@ static const struct of_device_id bcmasp_of_match[] = {
 MODULE_DEVICE_TABLE(of, bcmasp_of_match);
 
 static const struct of_device_id bcmasp_mdio_of_match[] = {
-	{ .compatible = "brcm,asp-v2.2-mdio", },
 	{ .compatible = "brcm,asp-v2.1-mdio", },
-	{ .compatible = "brcm,asp-v2.0-mdio", },
+	{ .compatible = "brcm,asp-v2.2-mdio", },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, bcmasp_mdio_of_match);
@@ -1387,7 +1307,7 @@ static int bcmasp_probe(struct platform_device *pdev)
 	}
 
 	/* Check and enable WoL */
-	priv->init_wol(priv);
+	bcmasp_init_wol(priv);
 
 	/* Drop the clock reference count now and let ndo_open()/ndo_close()
 	 * manage it for us from now on.
@@ -1404,7 +1324,7 @@ static int bcmasp_probe(struct platform_device *pdev)
 		if (ret) {
 			netdev_err(intf->ndev,
 				   "failed to register net_device: %d\n", ret);
-			priv->destroy_wol(priv);
+			bcmasp_wol_irq_destroy(priv);
 			bcmasp_remove_intfs(priv);
 			goto of_put_exit;
 		}
@@ -1425,7 +1345,7 @@ static void bcmasp_remove(struct platform_device *pdev)
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


