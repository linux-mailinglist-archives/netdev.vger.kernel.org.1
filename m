Return-Path: <netdev+bounces-244774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A3BCBE6E0
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 15:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FD6A3072ACF
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 14:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3386C30B536;
	Mon, 15 Dec 2025 14:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C1OQq0Cm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A070306D26
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 14:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765809721; cv=none; b=KlKVIhcVH3okiyz7lZ22QmlfAluBvXbzgal1XGByUAPf6r12xlRa1WpWBRBtbqlJ3CfOZ24yJhMWFFNT9IaOSBqFT9YLAmeuyWE29wPkBlrXVk1pCb/stsqV59SGnTR7izNqFiPMoZl8zKAEGlvZL3SPuSJgqpLtY/vYa9Uz5Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765809721; c=relaxed/simple;
	bh=RDwklFHaFNSV++/BoiPNwCn/lAhftfIyvmWeyKBJWJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOhKP7RQNVZ8p4sDIekojpsdZFs0hCubhYhiDVYqJFka2IQtVm7Ej1SgIs3KHmsvi7Md4kv9dFSCoo7NvHysOPJKodsqim8fdJz/JygqXwWCenptY0NG+Nx9zvbPkbEieWrp8oVVZVrVXf7ml/6/MsgMQkd9qK/uY/DP1Du8bPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C1OQq0Cm; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47118259fd8so35793765e9.3
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 06:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765809712; x=1766414512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vYKorhS7YGhwUqCGDk14PflDiZGeXR2MSlBlFfYQc3I=;
        b=C1OQq0Cm0Q30AhjOtueiuiYa7cqoNIBSlkQ1+GLrZFgWzfeyYklFFrwW9+eMhIflem
         YVWBCp/6XDCjkAuoDYI0qlgWvoEG4IH0bRMjhKQo6kOHDCb1kejkC8+xsJ/NPMi+pmzB
         HAXbse7clsk0crX3Pcf1x96f1HgnElc+urfX5LoSnAQrW41F3axcojMpYImb8w0QcQ9E
         vgJwOPye5OZRhqcvOOXZ1+ZJSxUQd0jGoJ0dVAAGXshuqrplEdL2+f50JRVFVXEhaSMD
         QNTCFxA9R0sS5/J+tu/Oh1ed/TlWBu1RI3+BikOM1MspJtaDkgxRWe9Zdt2YucuiKdbn
         qyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765809712; x=1766414512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYKorhS7YGhwUqCGDk14PflDiZGeXR2MSlBlFfYQc3I=;
        b=pDcz5Hun9y0cpz9NhdSZ2l77f6/t0lg4fDz9QgmJf1lz82YEilBnfsaqOJf699vtzR
         +mMG659MSOlhp4HeecdwPi4unxncVKYD/rXv5mj/5+Ze/on8+nB8345cJy1vrYsDYcpV
         q+c9Oa0IYc8CsBBtETCVHc+LMQ2kmtAincohKAP/D+XfUoxppCPf9Q4+pRD3Xi6HadMv
         YMoPBUHVRmLHofdBkughTYPC8DEPNMuYCa5etH0/JhnMzXPWqVlqqdSVRMkItnpYWNGf
         cbE5lNe+Qc4x4JIOzr1vQoeLgFuD0HxgTEWoTqRiK+OCY2dK/pV3YMbgI1zrt0P0H7e5
         2kOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvhe0puNSDIx5qf3Ze3bEK2NrF7RWFeQ2G8paGEfFS/QSXB6mRSz/i4IyOGSf8AQIUWTXDjew=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDCg8Ibv6Ix6ovAz35F1DDYareLNGUd5vux/XIR08BAls4Wyl/
	5waTvAb0jDv05tyYflr9nW1vrVGZtNDcbBAtC1/lW1uWwMrPkZpWJ0soHWCP/A/xuOI=
X-Gm-Gg: AY/fxX4XflWng4OfRYOMmQsmd0FeCA7vx0/p24fhNCMZolDKv2alL3rRI1yyuj2B5Xo
	aeLwDI38YQu6NmFyuI2znD4bTelnRH6KyV3VXE2+RpECv32cFRdRpCZ/EUBEQod6lh6TChhs1eS
	zI+phCzw/iRjSY/t+KMAONPyuEY8MPQDLn0XJyXbO1IbxEabnj9H1MoeHYMyJbE/naxRHXg7s6T
	JGsLAE1sKo1mk2dL60U8e1FClTBZSSKLeYGXEKpZsuvwIaiPZNQhI8HhV9pa6v2WQBOXS3D8awx
	TmAJvWa0wCXlmRkiDmgnToyLrqVdErBrpP3PIp0FrHNTw0nvRwmI8IJ9kXTTQdqZXrLBuglr23T
	Xx+fg4fgGuK05uMPSRlg0sOHGTzbrdBpxRwG2/NivDaKp7fD2PS5uQZtAZyOonigF4fN37SqrNU
	hzkUaJgcpF7oGLfMdM0xhJuOOtJAs=
X-Google-Smtp-Source: AGHT+IEW/XhvEhUWKukxpWXuAbDWYWTlu7iooVXodta81YuWRVJW/8nSpMCMutfNZkEu59rJRR8Kmw==
X-Received: by 2002:a05:600c:35c9:b0:479:3046:6bb3 with SMTP id 5b1f17b1804b1-47a8f906f07mr122335555e9.23.1765809711699;
        Mon, 15 Dec 2025 06:41:51 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f8d9a06sm187528625e9.10.2025.12.15.06.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:41:51 -0800 (PST)
Date: Mon, 15 Dec 2025 17:41:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jan Petrous <jan.petrous@oss.nxp.com>
Cc: s32@nxp.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linaro-s32@linaro.org
Subject: [PATCH v2 1/4] net: stmmac: s32: use a syscon for
 S32_PHY_INTF_SEL_RGMII
Message-ID: <f7ee93f0a8c6d6b9de3f2b37da9e038bfa7f290a.1765806521.git.dan.carpenter@linaro.org>
References: <cover.1765806521.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1765806521.git.dan.carpenter@linaro.org>

On the s32 chipsets the GMAC_0_CTRL_STS register is in GPR region.
Originally, accessing this register was done in a sort of ad-hoc way,
but we want to use the syscon interface to do it.

This is a little bit ugly because we have to maintain backwards
compatibility to the old device trees so we have to support both ways
to access this register.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
Fix forward porting bug.  s/PHY_INTF_SEL_RGMII/S32_PHY_INTF_SEL_RGMII/

 .../net/ethernet/stmicro/stmmac/dwmac-s32.c   | 23 +++++++++++++++----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
index 5a485ee98fa7..2e6bb41f49e1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
@@ -11,12 +11,14 @@
 #include <linux/device.h>
 #include <linux/ethtool.h>
 #include <linux/io.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of_mdio.h>
 #include <linux/of_address.h>
 #include <linux/phy.h>
 #include <linux/phylink.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/stmmac.h>
 
 #include "stmmac_platform.h"
@@ -32,6 +34,8 @@
 struct s32_priv_data {
 	void __iomem *ioaddr;
 	void __iomem *ctrl_sts;
+	struct regmap *sts_regmap;
+	unsigned int sts_offset;
 	struct device *dev;
 	phy_interface_t *intf_mode;
 	struct clk *tx_clk;
@@ -40,7 +44,10 @@ struct s32_priv_data {
 
 static int s32_gmac_write_phy_intf_select(struct s32_priv_data *gmac)
 {
-	writel(S32_PHY_INTF_SEL_RGMII, gmac->ctrl_sts);
+	if (gmac->ctrl_sts)
+		writel(S32_PHY_INTF_SEL_RGMII, gmac->ctrl_sts);
+	else
+		regmap_write(gmac->sts_regmap, gmac->sts_offset, S32_PHY_INTF_SEL_RGMII);
 
 	dev_dbg(gmac->dev, "PHY mode set to %s\n", phy_modes(*gmac->intf_mode));
 
@@ -125,10 +132,16 @@ static int s32_dwmac_probe(struct platform_device *pdev)
 				     "dt configuration failed\n");
 
 	/* PHY interface mode control reg */
-	gmac->ctrl_sts = devm_platform_get_and_ioremap_resource(pdev, 1, NULL);
-	if (IS_ERR(gmac->ctrl_sts))
-		return dev_err_probe(dev, PTR_ERR(gmac->ctrl_sts),
-				     "S32CC config region is missing\n");
+	gmac->sts_regmap = syscon_regmap_lookup_by_phandle_args(dev->of_node,
+					"nxp,phy-sel", 1, &gmac->sts_offset);
+	if (gmac->sts_regmap == ERR_PTR(-EPROBE_DEFER))
+		return PTR_ERR(gmac->sts_regmap);
+	if (IS_ERR(gmac->sts_regmap)) {
+		gmac->ctrl_sts = devm_platform_get_and_ioremap_resource(pdev, 1, NULL);
+		if (IS_ERR(gmac->ctrl_sts))
+			return dev_err_probe(dev, PTR_ERR(gmac->ctrl_sts),
+					     "S32CC config region is missing\n");
+	}
 
 	/* tx clock */
 	gmac->tx_clk = devm_clk_get(&pdev->dev, "tx");
-- 
2.51.0


