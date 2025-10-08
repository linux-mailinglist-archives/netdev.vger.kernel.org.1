Return-Path: <netdev+bounces-228172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDE2BC3CA6
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 10:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 723E33524EE
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 08:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2302F3C30;
	Wed,  8 Oct 2025 08:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="PQfNId0a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62992BD5A8
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 08:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759911488; cv=none; b=ae8Vyl27R3MVt6pHL0znD7cYVPntysitx4qOsrWLCXhDp/9mZSBGyEO4wqH6SrGqmUi3IZ/rYenhZlqC7C6Trvr7jrplIaWy6tLdF+UQ+Nn/7BC24vC4OwIcdIS0155pPvvmKpyL7UbWPv2oaCFgKexZnBEN0rmHJiwrH+eWjP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759911488; c=relaxed/simple;
	bh=BwfCoBnPTT5rX7Sdj59SJNV0iReosQyMrWaTx8NgluA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q3/h9bTjKhZbLXUFxFq7xD9iFZj3XhGraWsNd57auqDxWMGFvgXD4nPNJn07WuT+cP3aEa9bJc4jmbwGDjovWjF0NJwQgsOZyMoI0ef5n8Wocmt5SLTYVP5154mlm+bBwAy7NgGM06ngE9giHpuEr4myGWuaMs/g4d0AlsT+AKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=PQfNId0a; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso6313269f8f.2
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 01:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759911484; x=1760516284; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ul8GBU+O+XdLER6XCbhZBXCxZuiNlzEAtMGpu/p1y6Q=;
        b=PQfNId0ad5TjsZXOKmCnl66HLeqk70xhfxU9WLVx6/lRD0MVgUKHete2K8yihTLraE
         gV8+TrFNpgGr6a2jdk/fCiUSiRY0WKyQEstgHzSdYte0ZGIEqU/7upS8Y0psGVmokeDM
         /lxeFZqQOIFjHIkFac6R1OBx1ek625aaC1KXrjJ5Kk/+JTHBidnQk9kJpplG98zEDkZJ
         29lPWEKdPlTtl6r6Zq90/oVdoOiM+MuajZ8kFCtJC45oWm0M30+0ZJgsyxIgIx/S2KZ7
         STAC+0iJuZMv7ZSM3ES81BZXCt5ji6AcTj9b61Xk+/3po2p6o9YI5lPU/aARxc7u1vmx
         PmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759911484; x=1760516284;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ul8GBU+O+XdLER6XCbhZBXCxZuiNlzEAtMGpu/p1y6Q=;
        b=HMxX2wJ5SApDkSJL//mFoZ+U7GmEM+Yjqh4mdSHF4NCZDuy2pJ4CL0mmL18dIOftSV
         eJaGcHrDQdWW6zXMYZN3RdsEfCvfHSePTMMCjOIcOHclystyELnnFEW4mNI2M7hjiN0F
         NMpZCneEZozUWBSwh/GhX3vpbvOWjCF7ylNeeQZEycojI/XsVsHJ6F2gHEB2zO2ar4ds
         ffb0X1n+41Ya8jHASdHGNR6r3DD5lSQjG2FbbM81I+fX4oLdJGizeoMXcrG5csHpYfLk
         K8Z1DKIwvGEPx//JDbHdgx7lOq3G521ISfkl6bHDQqDbjbJ2aXQCaZRko9DkTLh7jfZr
         eOGw==
X-Forwarded-Encrypted: i=1; AJvYcCXobKW6B9pzbTyIZkeJLz8QOIZmLSlhO4hpSItBDSIK0J5ufyCJqQOHOWoin/2CqOxwByzFrF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOkYOtXWMCf03eG+UFmqf5tMsSQ1ETBZdiyKMmZ5rCc5MR5J2F
	nXSoP9GKlVqOU0IBTGQR7MgdjcnyfLnk+PYQ3OJ1x4tCUoVSjetnkf+BNDIrz5lUSx8MlkGCJqr
	dPYfhpGA=
X-Gm-Gg: ASbGncv4UvfabHhLgc+vJ8jc47XD2RluuO8oR/fJTv/IBvXpgOVUGp8iuGEM5U7ZlSP
	TUI4Y5zEuGnnqSunVAstJ3SBmb7xINak8aMyOLqi+XkO3HGUXVetE8TkdgyRs2b6JxDyHntMeis
	sKjUa6B7e93ImH/kyYI+DOBMJXWUiZuiX7oFAGlrRE3BgXbhqQ62ly9HzdcJC4rPpf9w6ZuYwoR
	mQ43YorTePxlllovd5wFHCwAOnkSGVK5Hq/c/PhXihkiyIDY4JZyRMk94WS7i36NVjNxSHqHhZT
	948n11XF1f34pdrCkY1bhlfEweh81+Mvybm0C17cjOav5v2HIJRXRLzSrBQoFklU+W+TJQKWTXK
	/+UyQEcLkuRY5QGBFEWWRhYrjSoyiJ3V3Z/bDs1cprx8zxUtc8qro
X-Google-Smtp-Source: AGHT+IE6ZMyLcsBN0V50RlzjIFoIQLk9iOg6oRiNR5JvPii+uUuTFdHwXGEV0hlJlVRQnaGtVLEXhw==
X-Received: by 2002:a05:6000:60f:b0:425:7589:2737 with SMTP id ffacd0b85a97d-4266e8d8e67mr1317470f8f.43.1759911484416;
        Wed, 08 Oct 2025 01:18:04 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:286d:ff1d:8b7c:4328])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e97f0sm28498943f8f.27.2025.10.08.01.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 01:18:03 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 08 Oct 2025 10:17:49 +0200
Subject: [PATCH v2 2/8] net: stmmac: qcom-ethqos: use generic device
 properties
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-qcom-sa8255p-emac-v2-2-92bc29309fce@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2902;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=D247/I9k9+jdDafl4QuGSA0//M+k597SsL92RQwFhvk=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo5h413esbXqnjuND12yudzI6EY/1g9lJi/uRCy
 Uuv9fCwSSOJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaOYeNQAKCRARpy6gFHHX
 cpxRD/9UQQ6GsDEhCf2230he2y8bhcrw003wd+e+aOxvP1HQjx2HrvP/Zh1enLCAxqMlTE4Ipiq
 c+UtF6BPiuYKaa62kQx3y8twflIjh1bFOgQCKz0b8Kps5yLsS7lZwX1dSRrIvMCWPxrXJtqXWvx
 HNlULSdJR8x9p8IXMGHCG5rEOSi6Mgo9FsIq0rqbVBwUeX06kOe7pA2ssdvbr44P5KecfrBfnwK
 a6/o5AK8MjJZjOLhhyzuigM92jp4W/KA/qFSEgdRcOP9mSlCaRvV5F0Ibraq6o8b8UZGPWo6HQs
 N11vvaBgINRZNs155aKWFaBuUYy9WM+GJ9+gp8PtR9GGZ/cCVnyar2uf+ZyUemeaa75LyHTuqCZ
 BfuXXMZdAxRjPRtMqdz+nd/RHj/S7/0PCafuZj/nWKgKOTBTFDZvj5UlWbGpHugfFbBcqB9OP5w
 IeemlR06TcuY1gdnoz7/WzHAnC5K8ELWdnDyB+7SU9+S3M0ViN23lM3k/xzPL2sOGQWpPzMi5Py
 rx9bsW3PeEHqilRbhNJ/9AplrkCZwL6BuYoXS3FrGwy1etNxuHiZolqfer5Vg5O2ygobzIdlUus
 qVJQusAqdj1Man4KZInD244TGspt8J5sVbVbs7DkDIQjueXTsaHiO0+OVRoK1yx9pnFfWxVj6cG
 M/aKIqen9XWrJOA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

In order to drop the dependency on CONFIG_OF, convert all device property
getters from OF-specific to generic device properties and stop pulling
in any linux/of.h symbols.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig             | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 9507131875b2ca05fedcab95a3bb4c7f8e8810fc..7734acc6f1dd669ffec622812f48d355c507fc32 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -125,7 +125,7 @@ config DWMAC_MESON
 config DWMAC_QCOM_ETHQOS
 	tristate "Qualcomm ETHQOS support"
 	default ARCH_QCOM
-	depends on OF && (ARCH_QCOM || COMPILE_TEST)
+	depends on ARCH_QCOM || COMPILE_TEST
 	help
 	  Support for the Qualcomm ETHQOS core.
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index d8fd4d8f6ced76cbe198f3d3443084daee151b04..aa4715bc0b3e7ebb8534f6456c29991d2ab3f917 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2018-19, Linaro Limited
 
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
 #include <linux/of_net.h>
 #include <linux/platform_device.h>
 #include <linux/phy.h>
@@ -764,7 +764,6 @@ static void ethqos_ptp_clk_freq_config(struct stmmac_priv *priv)
 
 static int qcom_ethqos_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
 	const struct ethqos_emac_driver_data *data;
 	struct plat_stmmacenet_data *plat_dat;
 	struct stmmac_resources stmmac_res;
@@ -815,7 +814,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 
 	ethqos->mac_base = stmmac_res.addr;
 
-	data = of_device_get_match_data(dev);
+	data = device_get_match_data(dev);
 	ethqos->por = data->por;
 	ethqos->num_por = data->num_por;
 	ethqos->rgmii_config_loopback_en = data->rgmii_config_loopback_en;
@@ -852,9 +851,9 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	if (ethqos->has_emac_ge_3)
 		plat_dat->dwmac4_addrs = &data->dwmac4_addrs;
 	plat_dat->pmt = 1;
-	if (of_property_read_bool(np, "snps,tso"))
+	if (device_property_present(dev, "snps,tso"))
 		plat_dat->flags |= STMMAC_FLAG_TSO_EN;
-	if (of_device_is_compatible(np, "qcom,qcs404-ethqos"))
+	if (device_is_compatible(dev, "qcom,qcs404-ethqos"))
 		plat_dat->flags |= STMMAC_FLAG_RX_CLK_RUNS_IN_LPI;
 	if (data->has_integrated_pcs)
 		plat_dat->flags |= STMMAC_FLAG_HAS_INTEGRATED_PCS;

-- 
2.48.1


