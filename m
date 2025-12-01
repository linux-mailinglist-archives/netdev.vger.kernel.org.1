Return-Path: <netdev+bounces-242967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D4DC97897
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 14:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3281A3A4431
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 13:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1787315786;
	Mon,  1 Dec 2025 13:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a1CDymLC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B263230DD34
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 13:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764594507; cv=none; b=eO7GcemkCg9isy2gC8Duc5iqOga8eV7eplhXQtYhzfb+zchQS1jVO9GBZbDANG979m4SON65DxIoC68dwtQm/9UArWumHTPva4w6xVfvHzjW/yHtgMdmCX0ZbKIspSPl5vJ5lpGPL2y6glc0Ci8Z0H9C5/g2D5iMXwgXCrLmYEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764594507; c=relaxed/simple;
	bh=OR6PY99hsBq/5UZpP155y1I6x0Ibvpn6y5wNtbOwygg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABm2dRc5NQnU05W+YLPVntNJQYec8Z9t08SqAvRPJh1UE5q5nt/BV6OznYjHIRbfSRCsoxOabD7JisB6h/fy0Wi4gymvfS3rtJh+ztcdIvjcbWUt/1R/Hzb261RF+2OFAti3VoWzMnC35n98OvqPNVMBzoEw/sU5ZUMaYNtV0aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a1CDymLC; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b735e278fa1so83413366b.0
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 05:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764594504; x=1765199304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LgBCaTCV//Rn+e5Ee17YCnaLfz3jOXD1AdP/EJu9El8=;
        b=a1CDymLCSQer1aAt4ghhpHqUi7XH/A8La4bwjJYP6QZb7uPAJbA4xxc5OcjPhQiRDQ
         QOji2OJeakz/W1TuODatdi0DuTvmRR6HUcOdR3E/0fm91RG/AcWLf+z8OaCzMrm3qvg5
         k+KWjmmYVH8qwvxemVECFKRkyELJxyJ/dL82xfDocnvpIRPEdh902C/ZINksKUeCGE3H
         dpEYCnfWh5VlpYyNvbXRnfadJjYjISxtE6K1FLM8ZjMtAzdsr1f35xKpFohSjJZpIlqT
         dO10S3Xk0K0lQFGy/ek2XkSbpJGrWkwLMBexLOz2vaa4S7DzXnI0vTcDlOW9uoUhqM4J
         Y24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764594504; x=1765199304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LgBCaTCV//Rn+e5Ee17YCnaLfz3jOXD1AdP/EJu9El8=;
        b=GZwBdBtFSO11oDAwKTPhM3Rj8BPHEKcPnxhhzoQWjD8LrW2gvKrxMC+PIDe5zIX3a2
         +9sszCU0Q6EqCYpExdXABHqG7gnR5jmvKKTajq7+10T8X6wZMjz19cDzRaKFiGWAacvy
         qkZAmNWRejB8xVzW5aDyDH0qn+ClzAcer2FBh00ZyS5AX5/Bwm9mw7dBbiNKvzvknTq2
         D4Z6/f/Eq5D4cbROu0drKN9fN+UqQuPvia9unlgtKtu9zT5bFMd807wiEF9FpPwJG+5D
         AG8L+pm5yuAxFqiN/RyZE9rfQU6NFX+riEhsfH42Je6akOHNZLTNzFTDHgQ80SdxRvAB
         n//g==
X-Forwarded-Encrypted: i=1; AJvYcCWBRpnV8YNgjLqTOnHHThRRtYpup1Ka8oqBOPrVFjKAvWQ8Zby7y8HJQOXCa05TADdSOQlyVR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxbqnUCEFArhaKjGdD7qWxgpmvOTTgwpJeveL6b1ArWm92aa4p
	BuZWQSsCK2CldiQhJ3FKZl5XeANzmcOXnJFNPo/cGuiCiSyrzd/ZQC1hocVRWHmi8DI=
X-Gm-Gg: ASbGnctSog9Ag6NOQH9rIxGlfJVm88sbIlLXXCOdc3sSou3KHvRz8hRKUNWaAzv4RP/
	SfPuQ+A10xVQ5j1hgB6T+6XFCkwRDDLHvdcupROSpaCn13XfgaJ9tiVmTWxouc+xbsB3I3yXrcu
	Dlr8/9DfMgTo3coUZDr3Xrc5ftRdhxmiJOwQxyyilj8zhB0n2iKNeor/O9h0dJjOiaDqgKxp8ba
	s1efX5MLf61L/F9vMdzcsGhlcFZnOvBN7Ep/3UT1MpYdTzh6/85Z6vqMWdewgUVfQRoj3KxJkhe
	Ww571FLrRoA4pKFW1noHpSsFho2v6mZv7UcXV9B+VgiUvrVkQUx2N9Pw/z7CNqodgh4vIRPq5+H
	kgoTdQQsBosMBYjr1BWgrGeybeJOOvRHR6w/UM7G6yAdEwZkzYBVrNsulf4XeYG+29YKrr3NGRS
	hlYWOCyQ8cz7s7PGiJ
X-Google-Smtp-Source: AGHT+IHy1zdsI4FJOvPH+ImtRkIFvBBnlJmdvObrk1mNXIvYLiipKTmpgEyhKmFkKGd/qTfSabPc2w==
X-Received: by 2002:a17:907:2d12:b0:b4b:dd7e:65f2 with SMTP id a640c23a62f3a-b76c546d9d3mr3021007766b.5.1764594503849;
        Mon, 01 Dec 2025 05:08:23 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b76f519e23esm1251235666b.23.2025.12.01.05.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 05:08:23 -0800 (PST)
Date: Mon, 1 Dec 2025 16:08:20 +0300
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
	linaro-s32@linaro.org
Subject: [PATCH 1/4] net: stmmac: s32: use the syscon interface
 PHY_INTF_SEL_RGMII
Message-ID: <6275e666a7ef78bd4c758d3f7f6fb6f30407393e.1764592300.git.dan.carpenter@linaro.org>
References: <cover.1764592300.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1764592300.git.dan.carpenter@linaro.org>

On the s32 chipset the GMAC_0_CTRL_STS register is in GPR region.
Originally, accessing this register was done in a sort of ad-hoc way,
but we want to use the syscon interface to do it.

This is a little bit uglier because we to maintain backwards compatibility
to the old device trees so we have to support both ways to access this
register.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 .../net/ethernet/stmicro/stmmac/dwmac-s32.c   | 23 +++++++++++++++----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
index 5a485ee98fa7..20de761b7d28 100644
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
+		regmap_write(gmac->sts_regmap, gmac->sts_offset, PHY_INTF_SEL_RGMII);
 
 	dev_dbg(gmac->dev, "PHY mode set to %s\n", phy_modes(*gmac->intf_mode));
 
@@ -125,10 +132,16 @@ static int s32_dwmac_probe(struct platform_device *pdev)
 				     "dt configuration failed\n");
 
 	/* PHY interface mode control reg */
-	gmac->ctrl_sts = devm_platform_get_and_ioremap_resource(pdev, 1, NULL);
-	if (IS_ERR(gmac->ctrl_sts))
-		return dev_err_probe(dev, PTR_ERR(gmac->ctrl_sts),
-				     "S32CC config region is missing\n");
+	gmac->sts_regmap = syscon_regmap_lookup_by_phandle_args(dev->of_node,
+					"phy-sel", 1, &gmac->sts_offset);
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


