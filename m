Return-Path: <netdev+bounces-228175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7B2BC3CCD
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 10:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 997563528D7
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 08:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEF32F6160;
	Wed,  8 Oct 2025 08:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="lVz7wwNC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB88E2F5A2C
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 08:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759911495; cv=none; b=l6oB6V5wzy14aAlntmedlNpyzXY4o5n5CkEBBFr9BubsWKXdohRjbUuzGb6AVIUixqPtTVZ1tsRr9Hm/NeXvcYrs6mfqFJzeTx/LcdIdGQbHvEFMIZ4uY3AAp33lHzub8aUxYcfGMQCP/0TSZGGZd5miBhnRR3EqNGZvIi4y9kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759911495; c=relaxed/simple;
	bh=TO9nsTt0YPxpWytCVH7ZJjGxn2Z4plKkUXJnF32G1IE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rKtk/vByQ4i3GYdcIwcrWPPP/tTLq4rAzS/0Lxm1cugM3Mz8E/7xvRvM9BnruCXGJ3M7u6KpDiM70H/X3O/FFotlZgT/JDp2oXJK/xQdwIANU3PE4UEPD86kwIFm8ZTBTsl9ERaXuSWmQru2MQHkQM+IdLBMlD902GQpGa+Q+YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=lVz7wwNC; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42568669606so3897437f8f.2
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 01:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759911491; x=1760516291; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K5ZbnZbGKkG8LBPBH3Ir29b+fdJ02lrKRlpbmxW9/T8=;
        b=lVz7wwNCmV4aq8tRumqCGo46eHXQJLDoq/mxCkXOWELb3SntbwGqaLscoQxUR9pduV
         gnAllMFvcUnlS4lLEZC+LZROBRWSscHkP3J3m9pUZreXBSw+xFECg+/A0wL0DgbHFFg5
         WovNxQkZUHMGHyjXX+8syeUUP/nfBn30vZOp7tFkFnPf0P9wdkr3pg6NvB0kYy3EKTYr
         0zeQ9UAdzceX3oH+lQvvbV2ZEQjzilYgO8RldP3mojEuwuTVfoxW2qwWgUrFSDZlJtCS
         KX+uYqe/sRm3YsaruPY5wHeRCKp6cjGeUNuPKbBOmoNjrfKBT/E1ZVb5XdBFN43xGur0
         VvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759911491; x=1760516291;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5ZbnZbGKkG8LBPBH3Ir29b+fdJ02lrKRlpbmxW9/T8=;
        b=KWWp/kjArujfM1Ad+7rQvk0YrJJbfXfpt+uAPP3izMQGA9im6Bk44Osei3JzmWK11X
         FTE3yhbLuNBvhvZ3H7ZXuilEbXpARdvP87Yu4MdDW3U9conoO6uRHyBNPDlniknRmwg+
         qSJnwzYJR2MydVs389P3ld68ANPBwQd7rNBOVObXb54UqiuyluNR0VotvSxI7KjPuhJb
         tkbmd3/nOFnl5DmfHjqrBBu18RK1ZreEX+MSCL8RJabS+acE3sR02NlIJFyp3N8t8zLh
         l7Ptnqcz9vjR0/88FAgSPqhtq39n+PFJMwqG9qVY92lyHa0kYi1e25tMaYl6zl6C5C1S
         565g==
X-Forwarded-Encrypted: i=1; AJvYcCXRv+O/7eZ45ZcvcqKAVjtwPFteLwHyRPwljQ//jACphZqJZdWxe3HoG4ERkHek0n9snSRJXew=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYC55gQNLfWEWX4VsnoUNjLLxjJ0LUCTLSUTVK5s0lEnyXUU+5
	kk0IBnmj2Cn75lRpOQ8gJ5pmidW+sLhm0AHabByXwWgorSpH9pPMIQ2DOvjWW6qZM2nH9lHdfm/
	wOFY6gZI=
X-Gm-Gg: ASbGncv8gGLnUlQ7XeWIPu7V3YClnYz95u7gIrWZBvnLfzKEKl5sQyFwpIX5xQCOQm8
	xBKOf18u4vG2KRGYhYonXAPn/n8D9SlNGrUmBUw4nte/6TNJyuWBNsWXm/7oQRTqWO7ypG6sUNB
	0az/YQIkgoubZvIj3NuOB4FI9emg0gYITx0GrX+Mo3z0SAksrnLKaIggU9+8cFwySgCQl85EYiu
	xBW+VkfpGIwzSIZ821JLLyiPV9mWSw/AvvPyl66BRlSUOXvN1mlaGfEdQVsGiwin+21Pz/F7NfH
	Uf2ofUgM+dh4ZSuUYzINOWyNT6nW239BtRBsxTtB0P9elDTH8BUySEJnvLV4iHe6QgcUALvwYqj
	U65maoeGeHNUhZuE5gc/lUjhjHmfYNiJFU8Scfbs4Aw==
X-Google-Smtp-Source: AGHT+IHkwtqy2vb9uxT6M7LtlQU6zwCjb9IR5rIG74fXz3TalugvLB02SuzmrQY3nea1fwBLGELWhQ==
X-Received: by 2002:a05:6000:1845:b0:425:8bc2:9c43 with SMTP id ffacd0b85a97d-42666ac4502mr1491294f8f.1.1759911490600;
        Wed, 08 Oct 2025 01:18:10 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:286d:ff1d:8b7c:4328])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e97f0sm28498943f8f.27.2025.10.08.01.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 01:18:09 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 08 Oct 2025 10:17:52 +0200
Subject: [PATCH v2 5/8] net: stmmac: qcom-ethqos: split power management
 fields into a separate structure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-qcom-sa8255p-emac-v2-5-92bc29309fce@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3478;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=QXDtZJBSeiuTqR9NRW8KT3qs59BPygxIGrInXJc2Y/o=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo5h42Xak+xMy0XGVbg60nsHByk/5QWfRt+MQk2
 tRZVAmURSeJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaOYeNgAKCRARpy6gFHHX
 ci7yD/9T88d234rhjtNAnU5hIUiy2KPa1vwStmh6rzlpiBEAYQWJ7n0qtpVAahYHWOUDFfpCxbX
 qwsLaWX2pQdosbU2lkFdffA5lYMtlXOH6J6GUvcdj0SWTSPeHuhvGaoQjr7rMYT7wVScdfK/f0T
 Q1CKPK/+i7nlZ2XpFhFSHcPcHMwzGmSe7yNtxWyMhmTZEv8xPu9N45yE6Rkw1f4qtdQujoBZ/wk
 ViGxpFT6K2MmqD7NkTEgzs6EwNBhKII+UCC0hlGskAB5N8PiTaE4r7rPLvA/B79t2fjd2o6Gdqm
 kD1Qhk73OktYQEiw64TAkceahph3P7g2PKW5p8whO3jVBKsjKRnG8RPhrtkPoV/muXooK+UnYXv
 mmYJvnC8pUx3BXZGy0PMtyN8HuSK05GDhscy0T/HJaRGcw9bpg777ge6XlAfW1BxNTP8nVndOD2
 C63+OilZ0jPj8BKIQyY88Mudny2/zvh9bu44+UKEa54IJUn5ZuGUZDWUHhFH3Qcgs7Ha3ampG1u
 g/o2E0tK5wZcBSN0d0YwtACEOcKuLIBBakebxgraxUV5tByTHxwOPcMoVU2nHMyVfZM5riUXQgJ
 klzu9ahNp03ITcGbo5/lCY3N3M4bAkCKevXvcNQXc+oXsr/KMNhSmNINpCoZrlbCTLyp/r4mwsi
 fNcmzHN7Zq/n+Zg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Now that we have a separate wrapper for device match data, let's extend
this structure with a pointer to the structure containing fields related
to power-management only. This is done because a device may have the
same device settings but different power management mode (e.g.: firmware
vs manual).

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c   | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index dcee5c161c01124ea6bf36ceaeca4cc8ca29c5d5..d4ddf1c5c1bca2ae1fc5ec38a4ac244e1677482e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -95,15 +95,19 @@ struct ethqos_emac_driver_data {
 	unsigned int num_por;
 	bool rgmii_config_loopback_en;
 	bool has_emac_ge_3;
-	const char *link_clk_name;
 	bool has_integrated_pcs;
 	u32 dma_addr_width;
 	struct dwmac4_addrs dwmac4_addrs;
 	bool needs_sgmii_loopback;
 };
 
+struct ethqos_emac_pm_data {
+	const char *link_clk_name;
+};
+
 struct ethqos_emac_match_data {
 	const struct ethqos_emac_driver_data *drv_data;
+	const struct ethqos_emac_pm_data *pm_data;
 };
 
 struct qcom_ethqos {
@@ -297,7 +301,6 @@ static const struct ethqos_emac_driver_data emac_v4_0_0_data = {
 	.num_por = ARRAY_SIZE(emac_v4_0_0_por),
 	.rgmii_config_loopback_en = false,
 	.has_emac_ge_3 = true,
-	.link_clk_name = "phyaux",
 	.has_integrated_pcs = true,
 	.needs_sgmii_loopback = true,
 	.dma_addr_width = 36,
@@ -319,8 +322,13 @@ static const struct ethqos_emac_driver_data emac_v4_0_0_data = {
 	},
 };
 
+static const struct ethqos_emac_pm_data emac_sa8775p_pm_data = {
+	.link_clk_name = "phyaux",
+};
+
 static const struct ethqos_emac_match_data emac_sa8775p_data = {
 	.drv_data = &emac_v4_0_0_data,
+	.pm_data = &emac_sa8775p_pm_data,
 };
 
 static int ethqos_dll_configure(struct qcom_ethqos *ethqos)
@@ -787,11 +795,13 @@ static void ethqos_ptp_clk_freq_config(struct stmmac_priv *priv)
 static int qcom_ethqos_probe(struct platform_device *pdev)
 {
 	const struct ethqos_emac_driver_data *drv_data;
+	const struct ethqos_emac_pm_data *pm_data;
 	const struct ethqos_emac_match_data *data;
 	struct plat_stmmacenet_data *plat_dat;
 	struct stmmac_resources stmmac_res;
 	struct device *dev = &pdev->dev;
 	struct qcom_ethqos *ethqos;
+	const char *clk_name;
 	int ret, i;
 
 	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
@@ -839,6 +849,9 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 
 	data = device_get_match_data(dev);
 	drv_data = data->drv_data;
+	pm_data = data->pm_data;
+	clk_name = pm_data && pm_data->link_clk_name ?
+				pm_data->link_clk_name : "rgmii";
 
 	ethqos->por = drv_data->por;
 	ethqos->num_por = drv_data->num_por;
@@ -846,7 +859,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	ethqos->has_emac_ge_3 = drv_data->has_emac_ge_3;
 	ethqos->needs_sgmii_loopback = drv_data->needs_sgmii_loopback;
 
-	ethqos->link_clk = devm_clk_get(dev, drv_data->link_clk_name ?: "rgmii");
+	ethqos->link_clk = devm_clk_get(dev, clk_name);
 	if (IS_ERR(ethqos->link_clk))
 		return dev_err_probe(dev, PTR_ERR(ethqos->link_clk),
 				     "Failed to get link_clk\n");

-- 
2.48.1


