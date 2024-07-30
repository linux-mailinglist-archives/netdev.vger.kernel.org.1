Return-Path: <netdev+bounces-114068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C31F2940DA7
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 11:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A5392854AC
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 09:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A799A19DFB4;
	Tue, 30 Jul 2024 09:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="T8RPilUX"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BB319DF98
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 09:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331754; cv=none; b=t+3F6REZp6S5cZkgVW8USW4NFMHfiI2WAPfIiW9Chj9yzO4dC+MYlVwSdNtfP/nXktNO5VuuJkoum8KB5rf++2BmI1kSU6IOsOX6peDzGeaJOUszPqo0fjKbGnE7f/5RrpwV7xA1WYA6mpwA4ai31Kzhuis9vMcqVZ+lG1LDcfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331754; c=relaxed/simple;
	bh=WpXR5Qy4QAghtkFIn0G7C/689WuroRoLCyXOwnuFDPM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=KLBGb86UyjdYGzL6QD87WHKrksJMwr4lY+c4QcuoHflLLTLvhHo4cZx48bko0f6fb12sBrOSUO2rnResmHOdp4Ews5J8vA8nxPEbOjQswkE8J7SNbVdCA+JNdH661GGYaO0VR7/2kFEqz6Q6MZCfcRRt1TUqKtNDDbOvgQTFRtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=T8RPilUX; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240730092910epoutp02274751e750c200edc5057960f5257c52~m85oNpNGD0162601626epoutp02P
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 09:29:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240730092910epoutp02274751e750c200edc5057960f5257c52~m85oNpNGD0162601626epoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1722331750;
	bh=GQpFXaNxLkdbO3Vx5ULHhn89ngOq+T1pq0YVGvndi/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T8RPilUXsDa8CfIKxSkKnESZfkK4KAWwhwfs5t+BVNlDu18RFn0FKMp0AQVZ7VDlX
	 sIK57xzDF1+YjuBijEIqoXva12zL0je/CUSeycP1MTpKnzzu470T549mkt/QUGNW5p
	 mwjhuP2LDAQu37FfH+W5+NL9LzHixkfUt3SbIVOE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240730092909epcas5p26880acd1e9d4bb41b8257277ef25d164~m85nUDU922160021600epcas5p29;
	Tue, 30 Jul 2024 09:29:09 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4WY90M464Zz4x9Px; Tue, 30 Jul
	2024 09:29:07 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4A.5E.19863.362B8A66; Tue, 30 Jul 2024 18:29:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240730092902epcas5p1520f9cac624dad29f74a92ed4c559b25~m85gjTsUz2395223952epcas5p1D;
	Tue, 30 Jul 2024 09:29:02 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240730092902epsmtrp21e5ff716fab9c027b7eddfafb28ac916~m85gh-viz2650026500epsmtrp2P;
	Tue, 30 Jul 2024 09:29:02 +0000 (GMT)
X-AuditID: b6c32a50-ef5fe70000004d97-ef-66a8b263e4a5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8E.8D.08456.E52B8A66; Tue, 30 Jul 2024 18:29:02 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
	[107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240730092858epsmtip2f9ea0d37a205dadf254df185b65ec28b~m85c_cOG72103621036epsmtip2B;
	Tue, 30 Jul 2024 09:28:58 +0000 (GMT)
From: Swathi K S <swathi.ks@samsung.com>
To: krzk@kernel.org, robh@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	conor+dt@kernel.org, richardcochran@gmail.com, mcoquelin.stm32@gmail.com,
	andrew@lunn.ch, alim.akhtar@samsung.com, linux-fsd@tesla.com
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	alexandre.torgue@foss.st.com, peppe.cavallaro@st.com, joabreu@synopsys.com,
	swathi.ks@samsung.com, rcsekar@samsung.com, ssiddha@tesla.com,
	jayati.sahu@samsung.com, pankaj.dubey@samsung.com, ravi.patel@samsung.com,
	gost.dev@samsung.com
Subject: [PATCH v4 2/4] net: stmmac: dwc-qos: Add FSD EQoS support
Date: Tue, 30 Jul 2024 14:46:46 +0530
Message-Id: <20240730091648.72322-3-swathi.ks@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240730091648.72322-1-swathi.ks@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VTfVSTVRzuvvt4Bx04rwPySoE0Dxl0gA3HuhgQKeFLcTqYfZ201s54YcDY
	djZQsyg0UePEAg3wjK9FogaBML4GsYGLXIcCJBDPEBQRPAgCnoaEJNLGRv33/J77/H7P7zz3
	XhaNvcj0ZqXIMiilTCTlMF3pLb8EbA8S6y4mca+vbUGP7hUBNF7ewkT9YyYa+snQh6HS/uN0
	VNHdx0BTVyZwZOlqw1B3zzkM3aycZ6D+/nocXW1RM5DuzjAD3Z55Hw22lzLR2X4jhnKHJxmo
	fLWWga5on0FLv98HqLJ5EUdrs80A3X7QgSPNVT0Ddf8xTUNrHXocVY5rGWixwYJHP0c2/WjB
	yKlvm3GyTTOGk1pdJqmr/ppJNp77kmzTWzFywXiNSaqbqgF52cgjp5YNNLKp0wrIJ8fKcNKq
	801w/zAtQkKJEimlHyUTyxNTZMmRnDf3CXcLwwRcXhAvHL3M8ZOJ0qlITkx8QlBsitSWC8fv
	oEiaaaMSRCoVJyQqQinPzKD8JHJVRiSHUiRKFXxFsEqUrsqUJQfLqIydPC43NMwm/CRNUjxa
	QFfcRYdNZWosGxSH5AIXFiT40HyzEeQCVxab6ABw9NQkw1H8BWCu4TFmV7GJJQBv/YZtdMw1
	9tEcIgOA6qN1mKPIweDkwiDTrmISL8LrF1tx+4EnkY3B03MD6y00opMGLeopul3lQeyCK1PD
	65hO+EOzpZBhx27ETqhpMDr9tsKa+i6aHbsQr8ALc7PrgyBR4gLNF6zAIYqB+XlmpgN7wBlz
	E+7A3tA6b3DyQlijvkZ3YAkcWylw8q/CrqFSG8+ybRcAL7U7k/GBhT116zvQCHeY98+kcx83
	qC/fwNvg6uywc+QW2FK14LQl4TfLDbgjFjWA7XVlIB/4av630AJQDbwphSo9mRKHKXhBMurQ
	fxcnlqfrwPrzD0zQg5r61WATwFjABCCLxvF0Ew5VJbHdEkWfHqGUcqEyU0qpTCDMlmABzdtL
	LLf9H1mGkMcP5/IFAgE/fIeAx9nsNptTlsgmkkUZVBpFKSjlRh/GcvHOxj7++d1UHPP0rR9s
	vWGcifU9r2z9KO3WiKm6wehxN3rh6cBidl6TpMJ15J3o6CdFFr8Dz3t1Zn32lbEn6+HeuR/2
	7khRH6rwGXjKK1ZVPGKKiNQ8qt1Xot3MfRD6wopP1ZnDvPbLKW99YA1YGZ5Q9MYbo84UBvDf
	OKZldc1l7T8apr9xhGWYPs87ePY1kWF8j6jxxN/fTW2Ke++keNfAr/1eu0+dfBsw4nr95dun
	a7YtlXyefCf7Hju7c/xZdaqLOS9n0nWt7UCRp7H59Ymo0IGHy98f/zPJcMJ1IWowLujSUMXp
	PSFfhPe+tLUmPiZVM1/rL50hDEn5j0fvC0dM0k2tAqt7hGQ/h66SiHiBNKVK9C/dbjtphwQA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRf1CLcRzHfZ8fe7bdjcfq9BinzHEJ/TrnvuLUxblH5zr/4BQxelSqNXuM
	OK5Y5yqnKdKu3/JrDYep2chipRK2/Kp2KiuN9WOoUeqOqPjv9fm835/353P34aLCSkzETZAe
	YuRSSZKYw8f0dWLvFTE6zf7Aj408ONZ3EUB7qZ4DrZ1mFN58ZEFgsTUDg2X1Fhw6GnoIaHts
	RGB98xUEdlV8waHVeoeALfocHOo+tuKwu387fPOgmAPVVhMCs1t7cVj66xYOG8rnwJHngwBW
	VH8n4MRANYDd32oIWNhiwGH9CycKJ2oMBKywl+Pw+10bETafrqq0IbRDVU3QxsJOgi7XKWid
	NotD37uSRhsNboT+anrHoXOqtIB+YgqiHT8foXRVrRvQv0+VELRbt2DLzCj+2lgmKeEwIw9Y
	t4cfX9CRi8k+wVRzSQ6SDgoCsgGPS5ErKdc9CzrJQvIhoEw9e6b7c6lhZT4+zR5U5e/PRDbg
	//UoEcqpPT01wCF9qTbN/SnBkzyHULeHa5HJAiVfoZSyeYiYdHmQ4dS4oxWbZIxcTDXapmMF
	ZAhVeNeETK/wpm7ceTyVyiPXUNddA/9OCqHyLr0G58DMcjBDC+YyMjY5LpkNkgVLmSP+rCSZ
	VUjj/PelJOvA1Df9/AygRvvN3wwQLjADiouKPQW7317dLxTESo4eY+Qpu+WKJIY1g3lcTOwl
	GBk4Gysk4ySHmESGkTHy/yrC5YnSkTBN1I81S5XqTVeP+CxcdEZfdTT9ZaiU7mh6Hj5m10fY
	VtmaY3eFb41w91reX+OMdwatO9l0uV41Emj/sOv88FDakLwuRtSU+TITvlD4ZKxOURQ1tBwf
	OnEgZUf7Tm1qkQhhvaIezH463uVcmHida3XoTO5QtWeMUcoTKc/mrfKofncAOuxtLtWFzQEF
	ZbnujnYQ2RMhK3o2v5jNc2Le2Cz/jSs5gcvb8lVhGwz6ecuCI31ro/tdr9U9heHbD3qqpGqS
	H5znkY+KJvSW/qK0GXXDLvpr39rg1JNOy7G0uC6vPuOgxpWfGD26bUXlXvJgguCXfDTrdHr7
	2IbD65eIMTZeEuSHylnJH6fS4xM8AwAA
X-CMS-MailID: 20240730092902epcas5p1520f9cac624dad29f74a92ed4c559b25
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240730092902epcas5p1520f9cac624dad29f74a92ed4c559b25
References: <20240730091648.72322-1-swathi.ks@samsung.com>
	<CGME20240730092902epcas5p1520f9cac624dad29f74a92ed4c559b25@epcas5p1.samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The FSD SoC contains two instance of the Synopsys DWC ethernet QOS IP core.
The binding that it uses is slightly different from existing ones because
of the integration (clocks, resets).

For FSD SoC, a mux switch is needed between internal and external clocks.
By default after reset internal clock is used but for receiving packets
properly, external clock is needed. Mux switch to external clock happens
only when the external clock is present.

Signed-off-by: Chandrasekar R <rcsekar@samsung.com>
Signed-off-by: Suresh Siddha <ssiddha@tesla.com>
Signed-off-by: Swathi K S <swathi.ks@samsung.com>
---
 .../stmicro/stmmac/dwmac-dwc-qos-eth.c        | 90 +++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 28 +++++-
 include/linux/stmmac.h                        |  1 +
 3 files changed, 117 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
index ec924c6c76c6..bc97b3b573b7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
@@ -20,6 +20,7 @@
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/stmmac.h>
+#include <linux/regmap.h>
 
 #include "stmmac_platform.h"
 #include "dwmac4.h"
@@ -37,6 +38,13 @@ struct tegra_eqos {
 	struct gpio_desc *reset;
 };
 
+struct fsd_eqos_plat_data {
+	const struct fsd_eqos_variant *fsd_eqos_inst_var;
+	struct clk_bulk_data *clks;
+	int num_clks;
+	struct device *dev;
+};
+
 static int dwc_eth_dwmac_config_dt(struct platform_device *pdev,
 				   struct plat_stmmacenet_data *plat_dat)
 {
@@ -265,6 +273,82 @@ static int tegra_eqos_init(struct platform_device *pdev, void *priv)
 	return 0;
 }
 
+static int dwc_eqos_rxmux_setup(void *priv, bool external)
+{
+	int i = 0;
+	struct fsd_eqos_plat_data *plat = priv;
+	struct clk *rx1 = NULL;
+	struct clk *rx2 = NULL;
+	struct clk *rx3 = NULL;
+
+	for (i = 0; i < plat->num_clks; i++) {
+		if (strcmp(plat->clks[i].id, "eqos_rxclk_mux") == 0)
+			rx1 = plat->clks[i].clk;
+		else if (strcmp(plat->clks[i].id, "eqos_phyrxclk") == 0)
+			rx2 = plat->clks[i].clk;
+		else if (strcmp(plat->clks[i].id, "dout_peric_rgmii_clk") == 0)
+			rx3 = plat->clks[i].clk;
+	}
+
+	/* doesn't support RX clock mux */
+	if (!rx1)
+		return 0;
+
+	if (external)
+		return clk_set_parent(rx1, rx2);
+	else
+		return clk_set_parent(rx1, rx3);
+}
+
+static int fsd_clks_endisable(void *priv, bool enabled)
+{
+	struct fsd_eqos_plat_data *plat = priv;
+
+	if (enabled) {
+		return clk_bulk_prepare_enable(plat->num_clks, plat->clks);
+	} else {
+		clk_bulk_disable_unprepare(plat->num_clks, plat->clks);
+		return 0;
+	}
+}
+
+static int fsd_eqos_probe(struct platform_device *pdev,
+			  struct plat_stmmacenet_data *data,
+			  struct stmmac_resources *res)
+{
+	struct fsd_eqos_plat_data *priv_plat;
+	int ret = 0;
+
+	priv_plat = devm_kzalloc(&pdev->dev, sizeof(*priv_plat), GFP_KERNEL);
+	if (!priv_plat)
+		return -ENOMEM;
+
+	priv_plat->dev = &pdev->dev;
+
+	ret = devm_clk_bulk_get_all(&pdev->dev, &priv_plat->clks);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "No clocks available\n");
+
+	priv_plat->num_clks = ret;
+
+	data->bsp_priv = priv_plat;
+	data->clks_config = fsd_clks_endisable;
+	data->rxmux_setup = dwc_eqos_rxmux_setup;
+
+	ret = fsd_clks_endisable(priv_plat, true);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Unable to enable fsd clock\n");
+
+	return 0;
+}
+
+static void fsd_eqos_remove(struct platform_device *pdev)
+{
+	struct fsd_eqos_plat_data *priv_plat = get_stmmac_bsp_priv(&pdev->dev);
+
+	fsd_clks_endisable(priv_plat, false);
+}
+
 static int tegra_eqos_probe(struct platform_device *pdev,
 			    struct plat_stmmacenet_data *data,
 			    struct stmmac_resources *res)
@@ -411,6 +495,11 @@ static const struct dwc_eth_dwmac_data tegra_eqos_data = {
 	.remove = tegra_eqos_remove,
 };
 
+static const struct dwc_eth_dwmac_data fsd_eqos_data = {
+	.probe = fsd_eqos_probe,
+	.remove = fsd_eqos_remove,
+};
+
 static int dwc_eth_dwmac_probe(struct platform_device *pdev)
 {
 	const struct dwc_eth_dwmac_data *data;
@@ -473,6 +562,7 @@ static void dwc_eth_dwmac_remove(struct platform_device *pdev)
 static const struct of_device_id dwc_eth_dwmac_match[] = {
 	{ .compatible = "snps,dwc-qos-ethernet-4.10", .data = &dwc_qos_data },
 	{ .compatible = "nvidia,tegra186-eqos", .data = &tegra_eqos_data },
+	{ .compatible = "tesla,fsd-ethqos", .data = &fsd_eqos_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, dwc_eth_dwmac_match);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 12689774d755..2ef82edec522 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4001,6 +4001,12 @@ static int __stmmac_open(struct net_device *dev,
 	netif_tx_start_all_queues(priv->dev);
 	stmmac_enable_all_dma_irq(priv);
 
+	if (priv->plat->rxmux_setup) {
+		ret = priv->plat->rxmux_setup(priv->plat->bsp_priv, true);
+		if (ret)
+			netdev_err(priv->dev, "Rxmux setup failed\n");
+	}
+
 	return 0;
 
 irq_error:
@@ -4056,7 +4062,13 @@ static void stmmac_fpe_stop_wq(struct stmmac_priv *priv)
 static int stmmac_release(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
-	u32 chan;
+	u32 chan, ret;
+
+	if (priv->plat->rxmux_setup) {
+		ret = priv->plat->rxmux_setup(priv->plat->bsp_priv, false);
+		if (ret)
+			netdev_err(priv->dev, "Rxmux setup failed\n");
+	}
 
 	if (device_may_wakeup(priv->device))
 		phylink_speed_down(priv->phylink, false);
@@ -7848,11 +7860,17 @@ int stmmac_suspend(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct stmmac_priv *priv = netdev_priv(ndev);
-	u32 chan;
+	u32 chan, ret;
 
 	if (!ndev || !netif_running(ndev))
 		return 0;
 
+	if (priv->plat->rxmux_setup) {
+		ret = priv->plat->rxmux_setup(priv->plat->bsp_priv, false);
+		if (ret)
+			netdev_err(priv->dev, "Rxmux setup failed\n");
+	}
+
 	mutex_lock(&priv->lock);
 
 	netif_device_detach(ndev);
@@ -8018,6 +8036,12 @@ int stmmac_resume(struct device *dev)
 	mutex_unlock(&priv->lock);
 	rtnl_unlock();
 
+	if (priv->plat->rxmux_setup) {
+		ret = priv->plat->rxmux_setup(priv->plat->bsp_priv, true);
+		if (ret)
+			netdev_err(priv->dev, "Rxmux setup failed\n");
+	}
+
 	netif_device_attach(ndev);
 
 	return 0;
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 84e13bd5df28..f017b818d421 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -264,6 +264,7 @@ struct plat_stmmacenet_data {
 	void (*ptp_clk_freq_config)(struct stmmac_priv *priv);
 	int (*init)(struct platform_device *pdev, void *priv);
 	void (*exit)(struct platform_device *pdev, void *priv);
+	int (*rxmux_setup)(void *priv, bool external);
 	struct mac_device_info *(*setup)(void *priv);
 	int (*clks_config)(void *priv, bool enabled);
 	int (*crosststamp)(ktime_t *device, struct system_counterval_t *system,
-- 
2.17.1


