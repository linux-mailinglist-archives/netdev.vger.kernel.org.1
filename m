Return-Path: <netdev+bounces-228174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD67BC3CB8
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 10:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7252F3527AB
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 08:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFB42F5A22;
	Wed,  8 Oct 2025 08:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="C0mXuVsF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344562F5339
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 08:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759911493; cv=none; b=H7bvSLuneje8zHqMj53gc6GvecKpV5q2NCd06VsT41N06jManEvXq0uo5T3mLEEiYhE5p0lOB9DE/1cOIHaLLTz/2PkWxy6rcxro6i9drAK97T5eRt1L4qEbCwLBg1oVR/Od2a2jCwh1DA1Q0RhhuAmUjWew6CTQXNcI5R/qNsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759911493; c=relaxed/simple;
	bh=W/Q0BE0iC0PpvIbRAV6KjcdJcBamxfsiRHWDDOKoVz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z7VaeIMSuLzOkL6yyoUmBWYD/Owqm7Ts1cQqblNOX2/ShUffeKF4hyMETiHK845fUG6VhT5LMnpfh7XYxs9nkY7matKIxgSyxeT8+Pyhv0GhedrCXyoi/g8fauj9C+1qf5FtYh5CZLH+d1Gn4DSk5N6JaMe3hQEGKLk+vzS6c5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=C0mXuVsF; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e3af7889fso43522535e9.2
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 01:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759911489; x=1760516289; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jaxsI5wjc2fZX1+u0/1MOkxyHBJYNhx76B7+LombEVg=;
        b=C0mXuVsFTnRbfdYz8HcfsnRcft2OUpKpZ/EKebSZUpC2pLrRd7aP2aJMkOXxq8Qvp4
         bSaXM1P2n6FeixxaWFYROXvD2o08yOr9slDcbTiTz7y50sN9WtnSX0cxVg4WgSr50LJf
         zvDhJQul9y+d6Mzb2e+QstlF6osMXYHQsdeALY4Lu+22E//XnCGF/WYAckS6pMQZNWqD
         Q9I9mZyDGjcvI3+p9DbBiSbpqjs1qlrKEGcrEcoMuk/ehytcxRi7GApkcJcclTk4JPU+
         HR1S0Hv+h9CdBfIAF3CU/I6ZMkWvckkMtOFmQV+fWfKTg8PnRuubBgyk5GzjzyqDlIHf
         HL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759911489; x=1760516289;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jaxsI5wjc2fZX1+u0/1MOkxyHBJYNhx76B7+LombEVg=;
        b=pXT8jPboxwCPR7bgZBu50bO9iL1rqKBB5q41w/IWxSYSIgtXdz/6IjAmelLifPk2of
         7EWEqv7ah3/8ix0N0Ol/pdU8lDCIhy1i9uQn7jwuEtAiNP6SXfMxtw3yGyYdojAfdqn8
         /sLGLN98tilpVCgQw6l1HV20/pQHB272A1atBt5As00whtAteu57a2q+Rr87wmRiwEFV
         2eHNJql5VTiv74Sq9elJH+j9G3YccJUW6pjr9QeDz6TDc6FitR5aGKmGXSnlSaNdcOIr
         WLVssupt0QP+hzJJz3f5xKF5nrAySWfB+X4k3capSqGicF+oPw3YzzMg6PnXB0q3e+gu
         KFyg==
X-Forwarded-Encrypted: i=1; AJvYcCX34H/C3wcJygUN93M5jb97knEjjoZh+Xcz9FrPf9JNxzGpaXS+vkyNSOAciGv94NUnY4hjcUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Q0WaD8gwH7zy8I3ENvH70gm2uBFXg4pA2ivihM4169pw/dAg
	ZvhgfTLVTqGqvNs3hyrhLPtlnUQSXHVfWd3m+ikcSnz//lMQTzc0nQ7GZP9k+AJg66zQoBhjB3y
	VTGEUPRw=
X-Gm-Gg: ASbGnctNUestvygRZbufGz6j5SJ5hyd5SmqbzeoUwEA8uh/SyZq7wG0Y3fPoRDSBOR0
	i1InIFIAN8M1hG5cwINt8iB+bWD/QeWDIghTEXeHj6m7HCeCwTvoI1TVhf+xtuuPWk4blhi1Avd
	4SQOPT5elyaWjiMbtyYDeO2uLZpQlKwGn5lWikUmuVxZmNr1IcBkaU0FaFKj03ha/bS+rdNBofW
	pnInGrvIdfV/Bd2OJ/1ICSR+sWjNCmOkrRt2eENvr6Sp27Q7MCwxuwr37jkWHl9xsq7mUI8ptaU
	Du+0Zi8X5xL4kGTVADDKbkuzKka0q7VBvrEATAckz6cNU13oB4GMgrKy8nMjHkqknwz6vbp5OEC
	0fLhPugy7xItQqhisJEkJsUTPtABmmaTS4pJssb3LeQ==
X-Google-Smtp-Source: AGHT+IFFI0M9udeJcMqE+CoColhQNMFY1CADDWaFh0akyB3kucjJWvoO6XySvRVTgngRa4SKqM+zxg==
X-Received: by 2002:a05:600c:4f08:b0:45b:7b54:881 with SMTP id 5b1f17b1804b1-46fa9a86307mr16468655e9.1.1759911488611;
        Wed, 08 Oct 2025 01:18:08 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:286d:ff1d:8b7c:4328])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e97f0sm28498943f8f.27.2025.10.08.01.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 01:18:07 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 08 Oct 2025 10:17:51 +0200
Subject: [PATCH v2 4/8] net: stmmac: qcom-ethqos: wrap emac driver data in
 additional structure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-qcom-sa8255p-emac-v2-4-92bc29309fce@linaro.org>
References: <20251008-qcom-sa8255p-emac-v2-0-92bc29309fce@linaro.org>
In-Reply-To: <20251008-qcom-sa8255p-emac-v2-0-92bc29309fce@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Vinod Koul <vkoul@kernel.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5758;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=sMGV2HQxeUJ7fEJpZJPTl2YIIxSzYzigYX8J2eZkPAg=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo5h41VPsOJ0Yjb5Y8MpfBiKZVcL5BNGgjgfuES
 hpZHzR6ZIOJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaOYeNQAKCRARpy6gFHHX
 cqqFD/0RsqzsZFM1K+8+vt+P8qA7yx4vp9xwXuK0+w5Vn/5uOkxlvkbMz5iBxNS1ys4T36S/8aH
 v7XeGizwnfEN09rHSJvLH/1T0Y5km6tZmqEH9cSiw2gUKmvaGAnV/BcMhdI470tvb9f0YZ4COgD
 P7oedPWAECgxSguxna3DraU3PpSg0mx3dhTX+b5493c7ICk6dqqBID2nI/O/R1NoG3ywciR6FPH
 ufh/Z/O9EGgIkfzqxS7d9XVNhfoTfbRf3nMsA0CGvCBjTr3B30K1e0ZNYy1T+K5eJgBzG3TE6nC
 p+uIQ28z5VwjEgdDaMK3xVTf7pzgZucy5hpZEFdncgGChhPc6VXMCuoMoSjYqyxrb3FBCCBSusq
 G9fTgN6aBdxtoK+IBJo+6KWE3i57DQ3mG6UmZfE6NW33/tUJiIZfGch4UAfjBIS99hlDIQ2BWp6
 TYWqmgg8CpNvvywKx+v06qVdi7f9hanEpJ49uRmaLCLZWECBUedhEoe+GqGs1KtFB9nQLlnUDQ0
 nIXVTR4LpsVCyou+L/Ld2EUdxKNt0Jzr76LIBZOWh1C7Y8OdeGhu22FCSSUX5zt2LyIWZh8nME2
 CfRjdmF3DxPT0psjb7ckYedHPNmMfkaHksRMeYqb8yzacOZD28BZMQlrhUFX0/ciIdS2sZOawAr
 Gn5B48RqsYXVgvQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

As the first step in enabling power domain support in the driver, we'll
split the device match data and runtime data structures into their
general and power-management-specific parts. To allow that: first wrap
the emac driver data in another layer which will later be expanded.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    | 53 ++++++++++++++++------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 0381026af0fd8baaefa767f7e0ef33efe41b0aa4..dcee5c161c01124ea6bf36ceaeca4cc8ca29c5d5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -102,6 +102,10 @@ struct ethqos_emac_driver_data {
 	bool needs_sgmii_loopback;
 };
 
+struct ethqos_emac_match_data {
+	const struct ethqos_emac_driver_data *drv_data;
+};
+
 struct qcom_ethqos {
 	struct platform_device *pdev;
 	void __iomem *rgmii_base;
@@ -219,6 +223,10 @@ static const struct ethqos_emac_driver_data emac_v2_3_0_data = {
 	.has_emac_ge_3 = false,
 };
 
+static const struct ethqos_emac_match_data emac_qcs404_data = {
+	.drv_data = &emac_v2_3_0_data,
+};
+
 static const struct ethqos_emac_por emac_v2_1_0_por[] = {
 	{ .offset = RGMII_IO_MACRO_CONFIG,	.value = 0x40C01343 },
 	{ .offset = SDCC_HC_REG_DLL_CONFIG,	.value = 0x2004642C },
@@ -235,6 +243,10 @@ static const struct ethqos_emac_driver_data emac_v2_1_0_data = {
 	.has_emac_ge_3 = false,
 };
 
+static const struct ethqos_emac_match_data emac_sm8150_data = {
+	.drv_data = &emac_v2_1_0_data,
+};
+
 static const struct ethqos_emac_por emac_v3_0_0_por[] = {
 	{ .offset = RGMII_IO_MACRO_CONFIG,	.value = 0x40c01343 },
 	{ .offset = SDCC_HC_REG_DLL_CONFIG,	.value = 0x2004642c },
@@ -267,6 +279,10 @@ static const struct ethqos_emac_driver_data emac_v3_0_0_data = {
 	},
 };
 
+static const struct ethqos_emac_match_data emac_sc8280xp_data = {
+	.drv_data = &emac_v3_0_0_data,
+};
+
 static const struct ethqos_emac_por emac_v4_0_0_por[] = {
 	{ .offset = RGMII_IO_MACRO_CONFIG,	.value = 0x40c01343 },
 	{ .offset = SDCC_HC_REG_DLL_CONFIG,	.value = 0x2004642c },
@@ -303,6 +319,10 @@ static const struct ethqos_emac_driver_data emac_v4_0_0_data = {
 	},
 };
 
+static const struct ethqos_emac_match_data emac_sa8775p_data = {
+	.drv_data = &emac_v4_0_0_data,
+};
+
 static int ethqos_dll_configure(struct qcom_ethqos *ethqos)
 {
 	struct device *dev = &ethqos->pdev->dev;
@@ -766,7 +786,8 @@ static void ethqos_ptp_clk_freq_config(struct stmmac_priv *priv)
 
 static int qcom_ethqos_probe(struct platform_device *pdev)
 {
-	const struct ethqos_emac_driver_data *data;
+	const struct ethqos_emac_driver_data *drv_data;
+	const struct ethqos_emac_match_data *data;
 	struct plat_stmmacenet_data *plat_dat;
 	struct stmmac_resources stmmac_res;
 	struct device *dev = &pdev->dev;
@@ -817,13 +838,15 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	ethqos->mac_base = stmmac_res.addr;
 
 	data = device_get_match_data(dev);
-	ethqos->por = data->por;
-	ethqos->num_por = data->num_por;
-	ethqos->rgmii_config_loopback_en = data->rgmii_config_loopback_en;
-	ethqos->has_emac_ge_3 = data->has_emac_ge_3;
-	ethqos->needs_sgmii_loopback = data->needs_sgmii_loopback;
+	drv_data = data->drv_data;
 
-	ethqos->link_clk = devm_clk_get(dev, data->link_clk_name ?: "rgmii");
+	ethqos->por = drv_data->por;
+	ethqos->num_por = drv_data->num_por;
+	ethqos->rgmii_config_loopback_en = drv_data->rgmii_config_loopback_en;
+	ethqos->has_emac_ge_3 = drv_data->has_emac_ge_3;
+	ethqos->needs_sgmii_loopback = drv_data->needs_sgmii_loopback;
+
+	ethqos->link_clk = devm_clk_get(dev, drv_data->link_clk_name ?: "rgmii");
 	if (IS_ERR(ethqos->link_clk))
 		return dev_err_probe(dev, PTR_ERR(ethqos->link_clk),
 				     "Failed to get link_clk\n");
@@ -851,16 +874,16 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	plat_dat->ptp_clk_freq_config = ethqos_ptp_clk_freq_config;
 	plat_dat->has_gmac4 = 1;
 	if (ethqos->has_emac_ge_3)
-		plat_dat->dwmac4_addrs = &data->dwmac4_addrs;
+		plat_dat->dwmac4_addrs = &drv_data->dwmac4_addrs;
 	plat_dat->pmt = 1;
 	if (device_property_present(dev, "snps,tso"))
 		plat_dat->flags |= STMMAC_FLAG_TSO_EN;
 	if (device_is_compatible(dev, "qcom,qcs404-ethqos"))
 		plat_dat->flags |= STMMAC_FLAG_RX_CLK_RUNS_IN_LPI;
-	if (data->has_integrated_pcs)
+	if (drv_data->has_integrated_pcs)
 		plat_dat->flags |= STMMAC_FLAG_HAS_INTEGRATED_PCS;
-	if (data->dma_addr_width)
-		plat_dat->host_dma_width = data->dma_addr_width;
+	if (drv_data->dma_addr_width)
+		plat_dat->host_dma_width = drv_data->dma_addr_width;
 
 	if (ethqos->serdes_phy) {
 		plat_dat->serdes_powerup = qcom_ethqos_serdes_powerup;
@@ -875,10 +898,10 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id qcom_ethqos_match[] = {
-	{ .compatible = "qcom,qcs404-ethqos", .data = &emac_v2_3_0_data},
-	{ .compatible = "qcom,sa8775p-ethqos", .data = &emac_v4_0_0_data},
-	{ .compatible = "qcom,sc8280xp-ethqos", .data = &emac_v3_0_0_data},
-	{ .compatible = "qcom,sm8150-ethqos", .data = &emac_v2_1_0_data},
+	{ .compatible = "qcom,qcs404-ethqos", .data = &emac_qcs404_data},
+	{ .compatible = "qcom,sa8775p-ethqos", .data = &emac_sa8775p_data},
+	{ .compatible = "qcom,sc8280xp-ethqos", .data = &emac_sc8280xp_data},
+	{ .compatible = "qcom,sm8150-ethqos", .data = &emac_sm8150_data},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qcom_ethqos_match);

-- 
2.48.1


