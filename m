Return-Path: <netdev+bounces-228176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1AEBC3CE2
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 10:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D8CC4F96D5
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 08:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386F92F619D;
	Wed,  8 Oct 2025 08:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="i3WiXKGS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FEF2F60C4
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 08:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759911497; cv=none; b=DXag/0XdWxg9Y0xQekvbtydYUL32EBxLqpr4RcajGyH7jSDDuNkHLr3l80Ih64Ztupx7agWxaeo8WI2yirjsrdRsNOWKMjEcwa40gdjAN5lyM1G+gfG6AysRHijiSSmZ6tONkEwezUa+PVdz9g0A4kLJWe5U6RWgKKz0W7X07eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759911497; c=relaxed/simple;
	bh=XIlqJOjcxzT3WhouCo/+UR8137UrPJNI5EXcordY0iE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FU7wFCVfWXMS5j2EIP+1cNCq6cANekyORwGXAtzEbMvSVV+Vrev6/dV+h0AdNhozArSjLZjgJacPaKBzYwV8rxW/uY69Ny/3ngmvCNK4OPXmEMq3lyU+6Nd3KNBf5CfJKQSE6D1HYZnUHX8ENWagOLtPaxNXUQO0Do/iWZrr+Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=i3WiXKGS; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ee15505cdeso553085f8f.0
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 01:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759911492; x=1760516292; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/vSLcjrovVRdefyPQB8K8T5zFHjp8pcBoDKJgvNVhJg=;
        b=i3WiXKGSFxh4Da+AIArtMAxN/iTauoHIPEs2Hv/Dzz99wO+g1r26BRWyfaCBgWMVjj
         WCdurnxNu0qWAAwciTY7ojtTxN01bHqw4aP/++WuCC6KhQFO5GgBulLr8+O8pba5U2Wf
         PCn9W32QGlK/r9fwDbjBer4sDWDdRk+p0LCTn6b/Lhd2CiiLZfj65jWMOIJGMRypkFPz
         kUxreMZ3wnmGOlup8aG/PMv8HG1BuLILxFKZloyBXsjTcpgB92n/w2sGbvaYCpPBoQlx
         OBPqvvtz0VNeLBtO9L1aZUBdNcaQxG4TYDLgd01yef/sUzq5tVP5/0qdMU7/DrkgYftC
         Yj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759911492; x=1760516292;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/vSLcjrovVRdefyPQB8K8T5zFHjp8pcBoDKJgvNVhJg=;
        b=MJ58v1XLbluS/YZ1qbhZ+FZ8orI8U84CMrMM+NxAjM/ntTsTEVKUwZ/KuRMFlYcRGY
         Neh23NNwOzuOY6AtF7ufuQutSiQWCtSw5LaWlM+02RgpbU4E/YfCR9cjVCvpFP6+VQ4W
         bU1l4Im3R9nYQoDR5JqgW5hxxYKjtOedbuw7WniqCLP/mqS2Lmo6WlLDueRC5yr5dVqy
         UQFHu8EcVezYb0JXpDuOo6PixPrrUaw85HzRA/TMUkczmZuogatEfLF3WuMo0OqtkuXZ
         H6f/6B3mE8Dptc3iI+FcoCj5il3US/APv0EZqT7PtTq5UKw8JwjmVj7tvm0hY2riUTKw
         pn/g==
X-Forwarded-Encrypted: i=1; AJvYcCWcvYDmEWRP9OUW6g0TLsQm5pYAgw78/RON9U3ie6Kls6/OWQ08rvysRjnKW6Ja0RO2oBo6YAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdJsAweRXeKWAGox6fq80cbiJiiAegwIkgBohGOf09O05zASrb
	BiDta0NFapshXvPt4PPCzd2js54BTCFZG/EALJl1UyEDN+e8eG3F9V2d0X7j3TjbTSp78X08sQB
	AFhW2qgw=
X-Gm-Gg: ASbGncv8CV6dT15wwDvlxMzlUhsXgqwQJnchdvmD8+eDCuLI0T8BF9GkcJlTw02dH+Y
	xRIVN7TcDKaWBdtzfEv/z5gtNy78LBJtXeDszzn6QQ6FL7xVVb8QK7MvjijJj+wM/KBpm7Rns1j
	x4FesT2Ox3DZMqq9HJu/VM19FhOX0LVOrzOluUQc5XwUmTiAEtWq3Pep/DDBHLSBmmjsiH0c4dZ
	JHe5ex6mssAPMbHXl2sMQe+PkYSuZ0R47eRouL9Spjay9wn0CkZC31Pgbd/gg8eQtSRcKXL1HiN
	wyAQT5R9VHiN1syKWXMUbkksM7XEYUVlO5jC8bOq6F/EACIJlUBb8M7xq9RM073lC8sd8XuVHWZ
	CURuG6HO5wzf5sJI+8oLGhbRlBInvk66Fld5t+GZAYA==
X-Google-Smtp-Source: AGHT+IEkLvf+ip6rnng1Q3wqUaE7YnRlE5+SKbX9ob3uGgdaQmwMgPZM1fXpO1H39fcBtRjNqboEKA==
X-Received: by 2002:a05:6000:4210:b0:3d8:3eca:a97d with SMTP id ffacd0b85a97d-42666aa6616mr1684492f8f.11.1759911491904;
        Wed, 08 Oct 2025 01:18:11 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:286d:ff1d:8b7c:4328])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e97f0sm28498943f8f.27.2025.10.08.01.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 01:18:11 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 08 Oct 2025 10:17:53 +0200
Subject: [PATCH v2 6/8] net: stmmac: qcom-ethqos: split power management
 context into a separate struct
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-qcom-sa8255p-emac-v2-6-92bc29309fce@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4943;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=72Rcv9lcaIE/fmtmW9sA3UZwGSkP3ncYbbWtrZ8FIEk=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo5h4202HoR6T5dxOtuURsXoZwH667ULKwPUQFt
 Pg5ZX90pKCJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaOYeNgAKCRARpy6gFHHX
 cvlXD/4oMQTfpDo2uPwukuQI/KQzXU/y8GklCY3xl2oO9CQHg18InhSbcIB9dCmUvObM94bmnBD
 n0J4E2ACalqEmPZUdDJ60jHvqactv0F+ntRz2qkDFYzaFexRkfXATjzFchCpRqAXvGcU5VpB1ZQ
 i2UDsHvtzVzNg4pipc7aPGvimknq7CfFFRbZMD5lRGEHGioI+XCGYUNsTNrIJykpwfaFiPmzN30
 XUb6glegwPsqra4CQ99uSKclBK47FOh7o4+VhVUZsNRaa8xa9/naZ/1JOLYU3TQh2uNXwvzJ8e5
 TNsWN0mzl3MVeoPLkD+pVZFH9CbDPGdzNeksgEEYiqgzXJSaqeCuIpB28EFp1UQrRw4uzwgBmsN
 jbhqw9LWU8l2rwBCobJtSMZSoZ50dTicEoQMhvR5ZBeBrjYSRRHB7JJKhsoy+T93Yu7C3b5qcfK
 V0ua3QeFOxf4uEUygKIu/SlgVq/j8ZVKSByJ/WkjPccIT7smJOCydOxlHoLIU85FoQ3U0jizMIv
 ZLAhuNgLcx+r7C5d0FM3sekaGOIA8J41lTbOCnz+hv+O2/W5YCciZd5IXC5LV1PcqIP6WYYE4Ib
 NMqYXy6BGOQIc7iv2vIzf+uNDjW7JbanfVIHHJT0ZM9PsfhDA24lyp1YNS35D7UXP7zU965LxpM
 eF/64jenVdSWCKg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

With match data split into general and power-management sections, let's
now do the same with runtime device data.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    | 46 ++++++++++++----------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index d4ddf1c5c1bca2ae1fc5ec38a4ac244e1677482e..1fec3aa62f0f01b29cdbc4a5887dbaa0c3c60fcd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -110,17 +110,21 @@ struct ethqos_emac_match_data {
 	const struct ethqos_emac_pm_data *pm_data;
 };
 
+struct ethqos_emac_pm_ctx {
+	struct clk *link_clk;
+	unsigned int link_clk_rate;
+	struct phy *serdes_phy;
+};
+
 struct qcom_ethqos {
 	struct platform_device *pdev;
 	void __iomem *rgmii_base;
 	void __iomem *mac_base;
 	int (*configure_func)(struct qcom_ethqos *ethqos, int speed);
 
-	unsigned int link_clk_rate;
-	struct clk *link_clk;
-	struct phy *serdes_phy;
-	int serdes_speed;
+	struct ethqos_emac_pm_ctx pm;
 	phy_interface_t phy_mode;
+	int serdes_speed;
 
 	const struct ethqos_emac_por *por;
 	unsigned int num_por;
@@ -186,9 +190,9 @@ ethqos_update_link_clk(struct qcom_ethqos *ethqos, int speed)
 
 	rate = rgmii_clock(speed);
 	if (rate > 0)
-		ethqos->link_clk_rate = rate * 2;
+		ethqos->pm.link_clk_rate = rate * 2;
 
-	clk_set_rate(ethqos->link_clk, ethqos->link_clk_rate);
+	clk_set_rate(ethqos->pm.link_clk, ethqos->pm.link_clk_rate);
 }
 
 static void
@@ -645,7 +649,7 @@ static int ethqos_configure_rgmii(struct qcom_ethqos *ethqos, int speed)
 static void ethqos_set_serdes_speed(struct qcom_ethqos *ethqos, int speed)
 {
 	if (ethqos->serdes_speed != speed) {
-		phy_set_speed(ethqos->serdes_phy, speed);
+		phy_set_speed(ethqos->pm.serdes_phy, speed);
 		ethqos->serdes_speed = speed;
 	}
 }
@@ -724,23 +728,23 @@ static int qcom_ethqos_serdes_powerup(struct net_device *ndev, void *priv)
 	struct qcom_ethqos *ethqos = priv;
 	int ret;
 
-	ret = phy_init(ethqos->serdes_phy);
+	ret = phy_init(ethqos->pm.serdes_phy);
 	if (ret)
 		return ret;
 
-	ret = phy_power_on(ethqos->serdes_phy);
+	ret = phy_power_on(ethqos->pm.serdes_phy);
 	if (ret)
 		return ret;
 
-	return phy_set_speed(ethqos->serdes_phy, ethqos->serdes_speed);
+	return phy_set_speed(ethqos->pm.serdes_phy, ethqos->serdes_speed);
 }
 
 static void qcom_ethqos_serdes_powerdown(struct net_device *ndev, void *priv)
 {
 	struct qcom_ethqos *ethqos = priv;
 
-	phy_power_off(ethqos->serdes_phy);
-	phy_exit(ethqos->serdes_phy);
+	phy_power_off(ethqos->pm.serdes_phy);
+	phy_exit(ethqos->pm.serdes_phy);
 }
 
 static int ethqos_clks_config(void *priv, bool enabled)
@@ -749,7 +753,7 @@ static int ethqos_clks_config(void *priv, bool enabled)
 	int ret = 0;
 
 	if (enabled) {
-		ret = clk_prepare_enable(ethqos->link_clk);
+		ret = clk_prepare_enable(ethqos->pm.link_clk);
 		if (ret) {
 			dev_err(&ethqos->pdev->dev, "link_clk enable failed\n");
 			return ret;
@@ -762,7 +766,7 @@ static int ethqos_clks_config(void *priv, bool enabled)
 		 */
 		ethqos_set_func_clk_en(ethqos);
 	} else {
-		clk_disable_unprepare(ethqos->link_clk);
+		clk_disable_unprepare(ethqos->pm.link_clk);
 	}
 
 	return ret;
@@ -859,9 +863,9 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	ethqos->has_emac_ge_3 = drv_data->has_emac_ge_3;
 	ethqos->needs_sgmii_loopback = drv_data->needs_sgmii_loopback;
 
-	ethqos->link_clk = devm_clk_get(dev, clk_name);
-	if (IS_ERR(ethqos->link_clk))
-		return dev_err_probe(dev, PTR_ERR(ethqos->link_clk),
+	ethqos->pm.link_clk = devm_clk_get(dev, clk_name);
+	if (IS_ERR(ethqos->pm.link_clk))
+		return dev_err_probe(dev, PTR_ERR(ethqos->pm.link_clk),
 				     "Failed to get link_clk\n");
 
 	ret = ethqos_clks_config(ethqos, true);
@@ -872,9 +876,9 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ethqos->serdes_phy = devm_phy_optional_get(dev, "serdes");
-	if (IS_ERR(ethqos->serdes_phy))
-		return dev_err_probe(dev, PTR_ERR(ethqos->serdes_phy),
+	ethqos->pm.serdes_phy = devm_phy_optional_get(dev, "serdes");
+	if (IS_ERR(ethqos->pm.serdes_phy))
+		return dev_err_probe(dev, PTR_ERR(ethqos->pm.serdes_phy),
 				     "Failed to get serdes phy\n");
 
 	ethqos->serdes_speed = SPEED_1000;
@@ -898,7 +902,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	if (drv_data->dma_addr_width)
 		plat_dat->host_dma_width = drv_data->dma_addr_width;
 
-	if (ethqos->serdes_phy) {
+	if (ethqos->pm.serdes_phy) {
 		plat_dat->serdes_powerup = qcom_ethqos_serdes_powerup;
 		plat_dat->serdes_powerdown  = qcom_ethqos_serdes_powerdown;
 	}

-- 
2.48.1


