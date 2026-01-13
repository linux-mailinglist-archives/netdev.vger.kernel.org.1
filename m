Return-Path: <netdev+bounces-249459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1914ED1957E
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 15:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E37483010536
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 14:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F80339282A;
	Tue, 13 Jan 2026 14:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RACydkqG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6443B35CB73
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 14:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768313620; cv=none; b=K2nwqqM4NbsiPkvU7KSD4RCY390qCWbO3t+t61y6+Zt6Ea0scq2HZMn6Evpuwmv9+CfIK5AwL5OeaEfKax9i1N0+etUf8XK3gXVchFCaO79gEXPFTJjDdDXcVsjhcBuOVOZY4zuSNjQx2/9MzIiKX4vuj9Vygg6Vx6dLLF2gHf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768313620; c=relaxed/simple;
	bh=aFzpFhk4WB8ER8iXc03ENFWqRvSrvcCN7LPdyY+0lyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibOdhfBujPcLD/LijMBein5/mwk3U2W2xDFiN8VuinBw8FBuJmrk45qYtOack5TOKL72J3Hm1vOyO5xFMPKOTu6ChyDBnlUVzEebja3xXhsbk1xYurelMaH63UaMNMEjpMvBeBc+3qPxV91CxD5Pf4fkDYXzEfADlyE/Kn9553E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RACydkqG; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47edffe5540so3017235e9.0
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 06:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768313617; x=1768918417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TyN9CjZVHq/sRLIyiaBUmdg0t2143/50j9chMJQ/vMY=;
        b=RACydkqGmghNkeVTNjbbYrR7NdCRfVsICyPuW16Jyo/ax5eFZaO+IbTt2XsFB3uvC3
         rdVcjBwUg+vVcZKoTXUn0jVeRa2tpgx1bmHAudZsD3b4nc+Dx1nbpbYdb2i5PCOmRRQn
         L64Ct6wWfOFpG3yI22pBx6fSPghxe0bNiuWCibc/Cp53IP15zGls2RGn2/vJWhf9BI48
         mBm9UEJwx++6GkgJdXwnaiDF13QqTbD3aWwZL0KXIPv7lLUXrWh0/oklmY6j+9HgJ6Bc
         TGxhV0mxdpLFQsv9PJmEb/0CbM20dz1naN75NiimNK1EQaOlvgcTEPtPhVvGhdCKb9Xo
         D7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768313617; x=1768918417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TyN9CjZVHq/sRLIyiaBUmdg0t2143/50j9chMJQ/vMY=;
        b=pfUxw3T2nkCCJvM14qe130PB/5ie6xYoXvVd021kbyxX+wmqSd8f5X6x/2naFBaB5T
         ER49LycX5pS2GmWJOvVm3GeA0/owu3jdn9BWSC3jqM/kvzBKe8Arf3Jm2OlOHd8+CpgT
         wEVtlUYBLMZKTWiAoPubyqImFCq+rWolFAZQchBSMmY52w6xbBDqYNZf+pr6XZ4vrS/P
         2cGk2HdRpUDDlu5gM/hhtC1jmCu6Xba/twE65GIMKxTPEihUvoraQt9qcVlcn4STiZmM
         iTEh5xWmC10yaG6JR9Kd57snTMrR9mPz75Gar8mj6wpXzTSp8r2PEd1biJwO/iI5vg3A
         BVnw==
X-Forwarded-Encrypted: i=1; AJvYcCV4xlZGYn4nEdK7CVJr+GWkcKo1NPs5zhqC7booLIShVQSJItge6+uOE9vUn37CcMFno9iMbQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YypFrW7j4TCYpM5k8Gwfrm6mB8uvapF+LAeF/uva7xttix4pkU2
	p7xFy9RiF5al59QQxJK3EKvpAvyTaSwz8T9n0f/klaQK6FTyl3EEddDiCIKBM+7TMv8=
X-Gm-Gg: AY/fxX4+dO2WT/ugPLGO0FGuXkp/fhc+V5Gaof6EjkktOVhf0ytD314oQDsqdN7vDGq
	Ha2Jjeu7iv/rdMrGfQ7T1oo/ZY86RMyxlSloXmoToaShgbXo38zCtFcK2KkB5lkR3/h6AY6LmMz
	/4GE6ZqNEB4FnJ7xnd4y01LP+HulLw679Ww1Yvaxc7d6m+Wven5olj1CwgniBG70H32acW+yuPS
	8gkNpbmf3oIBRDwXquH98qSsB3wTbI2o5b8SfBKUUqQAGBizBdKDZwjLP/RUkXCn9FwTlVMG+J3
	mgex4m4U0mBxy23ihIBxZWTDsdZbMZwjlOvj4/B0MYVfZq9yCr9tcF0BMwp3fRBuV5pXqOwVuEe
	Q+wrOpHEp6PII4ilclsp7H8xpP24kMsphYCJOXy+DaD7kNVx6UeF9/0HwXZvtoqB9esQtal0inc
	KlQumMR6bSFCHRdUwT
X-Google-Smtp-Source: AGHT+IEV6roObAcijlx4iVb9hdZfVlmXIQUK0U2XACejoOBJ5fxJJv4g1ZBGNz5KDAWxxOTyVwwC4Q==
X-Received: by 2002:a05:600c:45ce:b0:47d:264e:b371 with SMTP id 5b1f17b1804b1-47d84b30d79mr233877785e9.18.1768313616542;
        Tue, 13 Jan 2026 06:13:36 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47edb26792fsm33518525e9.14.2026.01.13.06.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 06:13:36 -0800 (PST)
Date: Tue, 13 Jan 2026 17:13:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jan Petrous <jan.petrous@oss.nxp.com>, Frank Li <Frank.li@nxp.com>
Cc: s32@nxp.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linaro-s32@linaro.org, imx@lists.linux.dev
Subject: [PATCH v3 1/3] net: stmmac: s32: use a syscon for
 S32_PHY_INTF_SEL_RGMII
Message-ID: <30e6a67514e97e798905872e2907b5b005ff2292.1768311583.git.dan.carpenter@linaro.org>
References: <cover.1768311583.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768311583.git.dan.carpenter@linaro.org>

On the s32 chipsets the GMAC_0_CTRL_STS register is in GPR region.
Originally, accessing this register was done in a sort of ad-hoc way,
but we want to use the syscon interface to do it.

This is a little bit ugly because we have to maintain backwards
compatibility to the old device trees so we have to support both ways
to access this register.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v3: Unchanged
v2: Fix forward porting bug.  s/PHY_INTF_SEL_RGMII/S32_PHY_INTF_SEL_RGMII/
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


