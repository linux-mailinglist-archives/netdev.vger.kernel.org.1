Return-Path: <netdev+bounces-235471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EE8C31230
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 14:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 388F04E9F91
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 13:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DA02F5A16;
	Tue,  4 Nov 2025 13:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="DeLLo5xm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2AA2F3C2A
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 13:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762261755; cv=none; b=Sdk4vxMH5hnxl1sS8FnpdIKGDqgpoOZp1Fz6Y35+s4dkFiTRrwBidLSF/+Tg4qrlpSdFq98v+1ej9xWUJt7PhFzv+1VRHFRdMiG2r81g/j9W8hdWdk8JKaVdzLKUfdEIfDfl4yLZ8Ph2I4yC7j5Xy5wHhtr6ZoHtGVhKmN6cp4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762261755; c=relaxed/simple;
	bh=NBuMo3fA0T+jYUYuxAjSnoU2gctigcAN7afLM+xxwVQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n7NgoB2N1gH9OEOWgJPiDRbFc8jQQK6DJ3Ms3KgHkfcK9rwc37TovgrrkLfXkp3kW8Vo4S74CRyrRT7a1f77Pm8l8U4W9Y/Kx11jJdJT9UQNWRIwwvfDFjoBpucF3uCiAvPvVaooNYyj7o9hJR6U6NP8ll9GXYBy6h0sZN7VgV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=DeLLo5xm; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-429bcddad32so3279163f8f.3
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 05:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762261752; x=1762866552; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EeInQQFLiIKx9a2aZ0cucvmhXeQc/nRxrd1ryoO5rZk=;
        b=DeLLo5xm3OAR2rej3QloNmz9nAd9jIHTeVHP+jDZuzzNROyLeAkscZbuMojt6U951+
         JUxck4L8IsY7dur6fFmGzij1hdT0F1CgoWglVZok4QuKBU93FgLr+yOilVto6i4paSq3
         kEcW6QEI+mLK8plhwwWuIFX7JcyCtc2kJdmSiefpfn59s27BFI0ZRPi/RSnzIiUFHf2q
         2hHdT3J9uHB+fnfG0x8Eea4kTyxi6ab3C9Kk6Co0fdYgTLrsgLjVisurjo7lx2ZNJ3Ty
         8IQjMQCfZ8gzCtCNEGGTTCKs6F8nnnvYKojFYKlHqT3AeTAmXGIpahZzRhn7zUbD5xuW
         kyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762261752; x=1762866552;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EeInQQFLiIKx9a2aZ0cucvmhXeQc/nRxrd1ryoO5rZk=;
        b=v/dmIBxA8EA9G7us3SggP8oJVLlaGbt+en6ozlBak0Z9wWLZFB+x42IKC9mVdzeOLI
         nn4ZlaQzM0v0e5RqKH/7RHsVlL07EUvfJVxC4+d3VLzwqMvrp3IeiAB1yp+nkSVfjwnV
         koq1rIJbVHkzPKKRBEBB4FW/qoJieObe54245z2Bmr+Ru+LbitjW2+VX5EaPorsrAAzt
         CQ9ESkTWLe3QSsTBYfjS/1ZsJpeAJDQu2Xyru0AeTqDRzvu2FqUr2IQGMAZbuJOcxt/T
         IKE32HXivQKhtWUjuG2EJGtmk8RPD+iOOblP2ap3wgwoE7shBDCQwTkvSs2EWRX8eN5w
         +uMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb0AaXVXb5cC7dj7MGtiU9j6XJvaeM9V12Yoz/um39ekea1aElDvOmbfq9wr6702Scb93YplU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIgNQfGS0bmKY74NIHD8z+CB/xDodx8HZ0gmxaXvh55jwqL348
	XlnLfo4MQC5quemG6CcVFGClgUxe88Rp7pIlipvszx0JevsQMHWcLvkSvStgZhiV21U=
X-Gm-Gg: ASbGnctTYmz6i83NXPH1LUx2rIcLyD5vOHiJ5bX+RwphutkVuKv3z1icIF1OhocFQxH
	QN9JnHdQ6bFhhpsT0x/pZRFHkjf3QZCAUExIn8VCou03IWGHmZy35oXNyPAhE95TrPcSKMUP8L7
	8tHnrqlk/ose49XBwOPJCFpzRZX+EP5seJYrk5vW7XDWn2I0quO98GBPmamBhbZ89Meg2MXMS7L
	3B+tl5xuEVEE6eHZNPbhUhHCisNGfazttQGzq4uJj7/ZAz7SzrEBHEGpC0XpyhJoDUBEV1uGOsF
	iS+F77/rvU37ILjI7j6WI0tPaSXSPLVSHCWAdXHXJnYCfkjkD8LtK0uPxqoRO3YmGnVZXZ9JNfh
	I4niBFdnah1xLNjxjm9jEvyMPYoPT96cDtQNiE+4OW3K+dBdpDCIfrhTxfn9ARHZHvGojmw==
X-Google-Smtp-Source: AGHT+IEazXC1/4e+3C9LIKFv0ME+i45XzCYX35RlKHJ+lvSQy9CFk/4mRB0TKiPc1PmCBPTWdT7aKw==
X-Received: by 2002:a5d:5f87:0:b0:429:d565:d7b0 with SMTP id ffacd0b85a97d-429d565da79mr4914264f8f.40.1762261751551;
        Tue, 04 Nov 2025 05:09:11 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:9ea1:7ab7:4748:cae3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc18efd3sm4554431f8f.5.2025.11.04.05.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 05:09:10 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 04 Nov 2025 14:08:53 +0100
Subject: [PATCH v4 2/8] net: stmmac: qcom-ethqos: use generic device
 properties
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-qcom-sa8255p-emac-v4-2-f76660087cea@linaro.org>
References: <20251104-qcom-sa8255p-emac-v4-0-f76660087cea@linaro.org>
In-Reply-To: <20251104-qcom-sa8255p-emac-v4-0-f76660087cea@linaro.org>
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
 Jose Abreu <joabreu@synopsys.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Matthew Gerlach <matthew.gerlach@altera.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Keguang Zhang <keguang.zhang@gmail.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jan Petrous <jan.petrous@oss.nxp.com>, 
 s32@nxp.com, Romain Gantois <romain.gantois@bootlin.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Heiko Stuebner <heiko@sntech.de>, Chen Wang <unicorn_wang@outlook.com>, 
 Inochi Amaoto <inochiama@gmail.com>, Emil Renner Berthing <kernel@esmil.dk>, 
 Minda Chen <minda.chen@starfivetech.com>, Drew Fustini <fustini@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
 Shuang Liang <liangshuang@eswincomputing.com>, 
 Zhi Li <lizhi2@eswincomputing.com>, 
 Shangjuan Wei <weishangjuan@eswincomputing.com>, 
 "G. Jaya Kumaran" <vineetha.g.jaya.kumaran@intel.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, Linux Team <linux-imx@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, David Wu <david.wu@rock-chips.com>, 
 Samin Guo <samin.guo@starfivetech.com>, 
 Christophe Roullier <christophe.roullier@foss.st.com>, 
 Swathi K S <swathi.ks@samsung.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 Drew Fustini <dfustini@tenstorrent.com>, linux-sunxi@lists.linux.dev, 
 linux-amlogic@lists.infradead.org, linux-mips@vger.kernel.org, 
 imx@lists.linux.dev, linux-renesas-soc@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, sophgo@lists.linux.dev, 
 linux-riscv@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2896;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=POv+vDF2xSPchjLMqtdcREByAr5wVSRC/4xfmqCj4bM=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpCfrsfPxny4b8sz641T3T8EFvMTQx5kwO1QGOR
 8pb8GTd+BeJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQn67AAKCRARpy6gFHHX
 cnqVD/97NywmsMZe+hTiJ7jxCsNyrWnMcFO+7cIL2RPel3gou8gIXIQsX7ETeIUDtcJzTZ1KqSm
 agsydioe3Mk2/PKY0XdQxNxEpMu65rEETgcwAzTyKgoU/GZTN7LqKeqxXx3S8aUCDiwGkjQifN8
 X2v8MajyRTcRmY6D54ypAgNEnFYJkeXukrUxi75A6NLw5DrkAJXiElFKV8Tfmc35UABzpEhoqVE
 T88M2BP+jZLRswE6QrLutFh322QPaF+UjIRKHUaSw4FFBTZTy5aDvugwNG/kaGN3HopwyUXjCRf
 ErGV9fj5k1xKzd0LYxkqFzXGd+anLTeceuPdxnQBJJS1WQStSlyRM8YM9o7iyG6Vpn9AwHwPQOX
 IG1GY+EPViR2egEOTkA05k9276NPSpxVnYXxSiEq5Qbk35L4ZJDO96QF/G7uILkWr5coGWSSms/
 P4UoZRGYq4KVQ/m8Q+r5upzCzXVqfEDAyKuhITS4g84ORbRJEezl5MXDte+IYVB+qcRrWEmXjBz
 8g60W21TaM8AfbRDvZtWVjkNzCIlUv68U1HsXEpCg7dJiPHZYMpZeM6sgFYNYCONcr/XTMwTODa
 ar4PeVg5WExRCx2+/p2gUOp1THWngsIY51xRK43VP8GvryZCHp/WVW7HF7s7bCwOHAoLr0/70vM
 g1Xe3JNSs8RSY5w==
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
index 87c5bea6c2a243f3be998b2c3935bc1dc23bfe22..22d0eaab35eaffac0bca58f8625ecc5c955b6631 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -135,7 +135,7 @@ config DWMAC_MESON
 config DWMAC_QCOM_ETHQOS
 	tristate "Qualcomm ETHQOS support"
 	default ARCH_QCOM
-	depends on OF && (ARCH_QCOM || COMPILE_TEST)
+	depends on ARCH_QCOM || COMPILE_TEST
 	help
 	  Support for the Qualcomm ETHQOS core.
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 1a616a71c36ace29a74a0aa23fc8173443aa49a5..8578a2df8cf0d1d8808bcf7e7b57c93eb14c87db 100644
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
@@ -748,7 +748,6 @@ static void ethqos_ptp_clk_freq_config(struct stmmac_priv *priv)
 
 static int qcom_ethqos_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
 	const struct ethqos_emac_driver_data *data;
 	struct plat_stmmacenet_data *plat_dat;
 	struct stmmac_resources stmmac_res;
@@ -799,7 +798,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 
 	ethqos->mac_base = stmmac_res.addr;
 
-	data = of_device_get_match_data(dev);
+	data = device_get_match_data(dev);
 	ethqos->por = data->por;
 	ethqos->num_por = data->num_por;
 	ethqos->rgmii_config_loopback_en = data->rgmii_config_loopback_en;
@@ -836,9 +835,9 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	if (ethqos->has_emac_ge_3)
 		plat_dat->dwmac4_addrs = &data->dwmac4_addrs;
 	plat_dat->pmt = 1;
-	if (of_property_read_bool(np, "snps,tso"))
+	if (device_property_present(dev, "snps,tso"))
 		plat_dat->flags |= STMMAC_FLAG_TSO_EN;
-	if (of_device_is_compatible(np, "qcom,qcs404-ethqos"))
+	if (device_is_compatible(dev, "qcom,qcs404-ethqos"))
 		plat_dat->flags |= STMMAC_FLAG_RX_CLK_RUNS_IN_LPI;
 	if (data->dma_addr_width)
 		plat_dat->host_dma_width = data->dma_addr_width;

-- 
2.51.0


