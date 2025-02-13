Return-Path: <netdev+bounces-165819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4465AA336FE
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 05:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E798E16348E
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 04:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DF42063CE;
	Thu, 13 Feb 2025 04:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HGJUUeKs"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2922D205E0B
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 04:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739421873; cv=none; b=mudCBqeB+1mEc0uUUaMgoBK5+g7tphSrGjrid7zG8kteudXG9dLmqTN/NuehOR2kJZUTmJUg2aC1qL3k1fZGobv9h78cW9+GO/jEcHK4kpOOWNKsfg+09/ox96imc8YODd+wd6z1FB19O5vtpKJv/QBNjdsfc45VoMBog+Od5B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739421873; c=relaxed/simple;
	bh=6oelQRv5vY9tqZgO91bQBN5JARJo6ydy8CdahFUmdvg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:References; b=TKcUjcuhef8tnemAC28YKGRebrEdGnjQOz/m9Qn41dkLqW89rmUl+Unt5j9DAb5e6L85M0b7K8d2fmGarwaI7PQO71/ZEiSdUVZX3TEULafbIqXpeO6hEGMvES7UgFQ9J584abefRfoZDRrZ1oL3+Os/BpMnIQvb13VxG25t8i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HGJUUeKs; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250213044429epoutp02db107db0075f2e5451b5f88ad277d861~jqvlYvy6f3171131711epoutp02m
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 04:44:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250213044429epoutp02db107db0075f2e5451b5f88ad277d861~jqvlYvy6f3171131711epoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739421869;
	bh=Nboyogv1mQ9wZ1hrsaNVtoIMK2Z9r1c3kpg7/2WbzPQ=;
	h=From:To:Cc:Subject:Date:References:From;
	b=HGJUUeKsHmp4rAktdT3l5o2Vd+O9Plax+tyGRprk985Z+TYFJdVJur5P1W+bd+CIS
	 vLqqa8sGYnjf62nJnvd51YqLMdSkoObgOstHlAD/Q8DNOj3YN1gCzXo3dJMu+g/AwW
	 /cW9xphYkxqAsjQRG0K9Vt7MHWCmNO/pB2m0XMrk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250213044428epcas5p1373a28dc7c0e465179d72bb2729747de~jqvk1aI2X1954419544epcas5p1I;
	Thu, 13 Feb 2025 04:44:28 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4YtjJV1gWlz4x9Q9; Thu, 13 Feb
	2025 04:44:26 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C6.59.19933.AA87DA76; Thu, 13 Feb 2025 13:44:26 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250213041925epcas5p4d37d50047359b923efd9fdcaf4b2f6d2~jqZszLiDZ0682606826epcas5p4e;
	Thu, 13 Feb 2025 04:19:25 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250213041925epsmtrp18442c9ee4664b9279916ab0f4d7579f9~jqZsyBTaE0828408284epsmtrp1E;
	Thu, 13 Feb 2025 04:19:25 +0000 (GMT)
X-AuditID: b6c32a4a-b87c770000004ddd-76-67ad78aa5c6d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A9.AD.18949.CC27DA76; Thu, 13 Feb 2025 13:19:24 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250213041922epsmtip258a82fe1948022b022d2ebaa50688558~jqZp4ovui0454604546epsmtip22;
	Thu, 13 Feb 2025 04:19:21 +0000 (GMT)
From: Swathi K S <swathi.ks@samsung.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: rmk+kernel@armlinux.org.uk, swathi.ks@samsung.com,
	fancer.lancer@gmail.com, krzk@kernel.org, Joao.Pinto@synopsys.com,
	treding@nvidia.com, ajayg@nvidia.com, Jisheng.Zhang@synaptics.com,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: stmmac: refactor clock management in EQoS
 driver
Date: Thu, 13 Feb 2025 09:45:59 +0530
Message-Id: <20250213041559.106111-1-swathi.ks@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0xTVxzHc+7tk6V4Uxg7YHBQJRkuhZbRcnAwzURykRmZskQMpqv0ru3o
	K72FIcsmmwSUIQwVIkgYOpABoqUCKw8FMTBg2QB5iYsLYJlDttEAouORraVl+++T3+/7Pb/H
	OYeD8wdYfhy1zkQZdXKNgOXBaLkfHCysy2hQioYquGjk/gYL/T1XAlDNlJWJygezGWi2d4aN
	zGfLmWiyqxVDJZM1DPRypgdHg4NmNhpqKWAiy5NxJhppK2ehvHEbE1VsNDBRb6UPWvnxD4Cu
	NS+z0bS9g40eFBZhaLlxko1+WfPc50OOjA/jZFPtJEbOFjazydayx2yy0pJGWurOscjbVafJ
	VusSRp4/8xeLXLg7xiILmuoAee+umLww+rPD2LkEyCXLjoRtx1OjVJRcQRkDKF2KXqHWKaMF
	8Udl+2USqUgsFEeiCEGATq6logUx7yUIY9Uax/iCgHS5Js0RSpDTtCD0nSijPs1EBaj0tCla
	QBkUGkO4IYSWa+k0nTJER5n2iEWiMIlD+GGqauybfrbhRmTG06rrjCzQEZoHuBxIhMMvrWV4
	HvDg8Il2AK89bGA5E3xiEcDnw96uxAqA39qHHCrOpqP91l5X/A6AF/OfuN3LAOb0PGI73Szi
	DTjx3feb7E1UAThz3ccpwol+DN5byWc4E15EIlzYqN0UMYggaH1+G3cyj3gbtg3PsV39vQ7r
	zV24i20caO/iuTgGjvY0uTVe8NkPW+wH5wpz3CyD9QVjDBer4OPVIpaL98Ku0XKGcxqcCIa3
	2tyr8IfFAzcxJ+OEJzy/ZsNccR60VmzxTrgxP+4+0he2VC+4S5HQYp8Ers2dgJb1Nvxr4F/2
	f4VKAOqAL2WgtUqKlhjCdNQn/91Til5rAZuPevdBK5iesod0A4wDugHk4AJvHiy5oeTzFPJT
	mZRRLzOmaSi6G0gcKyvC/V5N0Tt+hc4kE4dHisKlUml45FtSseA13pnWbCWfUMpNVCpFGSjj
	lg/jcP2yMMViL/an9YPx3+I9Xrxsn4i5mXQBnToGp0oHfperYxnzkS8CFUG2kzts9LkHlyOO
	XKpXnQh8evX97p212wI/y5+VFJs/pxIbP6o5gAkTss2XJ/y4wccOVx8q/7jvYPKlnt5pfmnU
	7Jp20KN+/kAKNzf3q4GzccyKOr3slQTOeqMks2riYRw/h9EMEvuK8WXPjPTT9JCoL6TzUPq6
	etdsi+yn6X9OLniZn4Xu0wuThQou96omKeRRZZIpYFfUYmnyYd/sL379NFNqf7erP8u7g/2m
	uml9+52gI2ua6pLk41fsq62rV7ZrcktS43LSM6KFe2ojijvj/Y/CuLAYbXNskvfF/QIGrZKL
	d+NGWv4v0onNM10EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsWy7bCSvO6ZorXpBgvv2FhcPvyXzeLny2mM
	Fssf7GC1mHO+hcXi6bFH7BYbOuawWtw8sJPJYtrN5SwWPx4dZbY4f34Du8WFbX2sFpseX2O1
	uLxrDptF17UnrBbz/q5ltTi2QMzi2+k3jBaLtn5ht3j4YQ+7xaX+iUwWXzbeZLe4/ZvPQczj
	8rWLzB5bVt5k8njav5XdY+esu+weCzaVemxa1cnmsXlJvcfOHZ+ZPHqb37F5vN93lc2jb8sq
	Ro+D+ww9Jl05B9S4/zOjx+dNcgH8UVw2Kak5mWWpRfp2CVwZV+efZC9YY1nxfMkylgbGPfpd
	jBwcEgImErvX23cxcnEICexmlLjSeJS1i5ETKC4p8al5KpQtLLHy33N2iKJPjBJnXnaygyTY
	BDQkrq/YDpYQEVjDKNFy+CgjiMMscJ1JYv7XX2wgK4QFgiSae+xBGlgEVCV2fN3MDGLzClhL
	7Lr4kh1ig7zE6g0HmCcw8ixgZFjFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREcN1pa
	Oxj3rPqgd4iRiYPxEKMEB7OSCK/EtDXpQrwpiZVVqUX58UWlOanFhxilOViUxHm/ve5NERJI
	TyxJzU5NLUgtgskycXBKNTCttmRSzT/nuM44aemLSZyN0Y3b41eIHP+18mlkIcvrS1yr1C74
	MkyY06c5cx3Hgw/Lqnrym0u4XNepHIgylDbNTP2d1pZvcfaKycX5qyU56h5IvCu5FGqzPfDG
	u+s5iZNuPlq3446eqF3se/Pnlk7/p/22f67VrblYd89rDW7vA+deKVza/CX6eNqptDgOvStL
	XP2nBc5Qv6zS9Oqi6KP/1x6bzbhUdF66wUWI6wOvuFXCq9/he0uL9adNnC/769T+YAZ5xTNH
	lCZEhfyrEt5ZrSl50VnSLK55pX8bywfv6Yfitlvvr9jHVryC8fUd3QNatr7TC8wKeOKnpFmx
	evse73j6aX/A+s4dC5jcdQOVWIozEg21mIuKEwF27ye7CgMAAA==
X-CMS-MailID: 20250213041925epcas5p4d37d50047359b923efd9fdcaf4b2f6d2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250213041925epcas5p4d37d50047359b923efd9fdcaf4b2f6d2
References: <CGME20250213041925epcas5p4d37d50047359b923efd9fdcaf4b2f6d2@epcas5p4.samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Refactor clock management in EQoS driver for code reuse and to avoid
redundancy. This way, only minimal changes are required when a new platform
is added.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Swathi K S <swathi.ks@samsung.com>
---
Changes since v1:
1. Respinning the patch including only the ML reported by get_maintainers
output
2. Adding the target tree ('net-next') in the subject prefix

 .../stmicro/stmmac/dwmac-dwc-qos-eth.c        | 131 +++++-------------
 include/linux/stmmac.h                        |   2 +
 2 files changed, 34 insertions(+), 99 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
index bd4eb187f8c6..1fadb8ba1d2f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
@@ -29,10 +29,8 @@ struct tegra_eqos {
 	void __iomem *regs;
 
 	struct reset_control *rst;
-	struct clk *clk_master;
 	struct clk *clk_slave;
 	struct clk *clk_tx;
-	struct clk *clk_rx;
 
 	struct gpio_desc *reset;
 };
@@ -123,49 +121,14 @@ static int dwc_qos_probe(struct platform_device *pdev,
 			 struct plat_stmmacenet_data *plat_dat,
 			 struct stmmac_resources *stmmac_res)
 {
-	int err;
-
-	plat_dat->stmmac_clk = devm_clk_get(&pdev->dev, "apb_pclk");
-	if (IS_ERR(plat_dat->stmmac_clk)) {
-		dev_err(&pdev->dev, "apb_pclk clock not found.\n");
-		return PTR_ERR(plat_dat->stmmac_clk);
-	}
-
-	err = clk_prepare_enable(plat_dat->stmmac_clk);
-	if (err < 0) {
-		dev_err(&pdev->dev, "failed to enable apb_pclk clock: %d\n",
-			err);
-		return err;
-	}
-
-	plat_dat->pclk = devm_clk_get(&pdev->dev, "phy_ref_clk");
-	if (IS_ERR(plat_dat->pclk)) {
-		dev_err(&pdev->dev, "phy_ref_clk clock not found.\n");
-		err = PTR_ERR(plat_dat->pclk);
-		goto disable;
-	}
-
-	err = clk_prepare_enable(plat_dat->pclk);
-	if (err < 0) {
-		dev_err(&pdev->dev, "failed to enable phy_ref clock: %d\n",
-			err);
-		goto disable;
+	for (int i = 0; i < plat_dat->num_clks; i++) {
+		if (strcmp(plat_dat->clks[i].id, "apb_pclk") == 0)
+			plat_dat->stmmac_clk = plat_dat->clks[i].clk;
+		else if (strcmp(plat_dat->clks[i].id, "phy_ref_clk") == 0)
+			plat_dat->pclk = plat_dat->clks[i].clk;
 	}
 
 	return 0;
-
-disable:
-	clk_disable_unprepare(plat_dat->stmmac_clk);
-	return err;
-}
-
-static void dwc_qos_remove(struct platform_device *pdev)
-{
-	struct net_device *ndev = platform_get_drvdata(pdev);
-	struct stmmac_priv *priv = netdev_priv(ndev);
-
-	clk_disable_unprepare(priv->plat->pclk);
-	clk_disable_unprepare(priv->plat->stmmac_clk);
 }
 
 #define SDMEMCOMPPADCTRL 0x8800
@@ -278,52 +241,19 @@ static int tegra_eqos_probe(struct platform_device *pdev,
 	if (!is_of_node(dev->fwnode))
 		goto bypass_clk_reset_gpio;
 
-	eqos->clk_master = devm_clk_get(&pdev->dev, "master_bus");
-	if (IS_ERR(eqos->clk_master)) {
-		err = PTR_ERR(eqos->clk_master);
-		goto error;
-	}
-
-	err = clk_prepare_enable(eqos->clk_master);
-	if (err < 0)
-		goto error;
-
-	eqos->clk_slave = devm_clk_get(&pdev->dev, "slave_bus");
-	if (IS_ERR(eqos->clk_slave)) {
-		err = PTR_ERR(eqos->clk_slave);
-		goto disable_master;
-	}
-
-	data->stmmac_clk = eqos->clk_slave;
-
-	err = clk_prepare_enable(eqos->clk_slave);
-	if (err < 0)
-		goto disable_master;
-
-	eqos->clk_rx = devm_clk_get(&pdev->dev, "rx");
-	if (IS_ERR(eqos->clk_rx)) {
-		err = PTR_ERR(eqos->clk_rx);
-		goto disable_slave;
-	}
-
-	err = clk_prepare_enable(eqos->clk_rx);
-	if (err < 0)
-		goto disable_slave;
-
-	eqos->clk_tx = devm_clk_get(&pdev->dev, "tx");
-	if (IS_ERR(eqos->clk_tx)) {
-		err = PTR_ERR(eqos->clk_tx);
-		goto disable_rx;
+	for (int i = 0; i < data->num_clks; i++) {
+		if (strcmp(data->clks[i].id, "slave_bus") == 0) {
+			eqos->clk_slave = data->clks[i].clk;
+			data->stmmac_clk = eqos->clk_slave;
+		} else if (strcmp(data->clks[i].id, "tx") == 0) {
+			eqos->clk_tx = data->clks[i].clk;
+		}
 	}
 
-	err = clk_prepare_enable(eqos->clk_tx);
-	if (err < 0)
-		goto disable_rx;
-
 	eqos->reset = devm_gpiod_get(&pdev->dev, "phy-reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(eqos->reset)) {
 		err = PTR_ERR(eqos->reset);
-		goto disable_tx;
+		return err;
 	}
 
 	usleep_range(2000, 4000);
@@ -365,15 +295,7 @@ static int tegra_eqos_probe(struct platform_device *pdev,
 	reset_control_assert(eqos->rst);
 reset_phy:
 	gpiod_set_value(eqos->reset, 1);
-disable_tx:
-	clk_disable_unprepare(eqos->clk_tx);
-disable_rx:
-	clk_disable_unprepare(eqos->clk_rx);
-disable_slave:
-	clk_disable_unprepare(eqos->clk_slave);
-disable_master:
-	clk_disable_unprepare(eqos->clk_master);
-error:
+
 	return err;
 }
 
@@ -383,10 +305,6 @@ static void tegra_eqos_remove(struct platform_device *pdev)
 
 	reset_control_assert(eqos->rst);
 	gpiod_set_value(eqos->reset, 1);
-	clk_disable_unprepare(eqos->clk_tx);
-	clk_disable_unprepare(eqos->clk_rx);
-	clk_disable_unprepare(eqos->clk_slave);
-	clk_disable_unprepare(eqos->clk_master);
 }
 
 struct dwc_eth_dwmac_data {
@@ -398,7 +316,6 @@ struct dwc_eth_dwmac_data {
 
 static const struct dwc_eth_dwmac_data dwc_qos_data = {
 	.probe = dwc_qos_probe,
-	.remove = dwc_qos_remove,
 };
 
 static const struct dwc_eth_dwmac_data tegra_eqos_data = {
@@ -434,9 +351,19 @@ static int dwc_eth_dwmac_probe(struct platform_device *pdev)
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
+	ret = devm_clk_bulk_get_all(&pdev->dev, &plat_dat->clks);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "Failed to retrieve all required clocks\n");
+	plat_dat->num_clks = ret;
+
+	ret = clk_bulk_prepare_enable(plat_dat->num_clks, plat_dat->clks);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to enable clocks\n");
+
 	ret = data->probe(pdev, plat_dat, &stmmac_res);
 	if (ret < 0) {
 		dev_err_probe(&pdev->dev, ret, "failed to probe subdriver\n");
+		clk_bulk_disable_unprepare(plat_dat->num_clks, plat_dat->clks);
 		return ret;
 	}
 
@@ -451,7 +378,8 @@ static int dwc_eth_dwmac_probe(struct platform_device *pdev)
 	return ret;
 
 remove:
-	data->remove(pdev);
+	if (data->remove)
+		data->remove(pdev);
 
 	return ret;
 }
@@ -459,10 +387,15 @@ static int dwc_eth_dwmac_probe(struct platform_device *pdev)
 static void dwc_eth_dwmac_remove(struct platform_device *pdev)
 {
 	const struct dwc_eth_dwmac_data *data = device_get_match_data(&pdev->dev);
+	struct plat_stmmacenet_data *plat_data = dev_get_platdata(&pdev->dev);
 
 	stmmac_dvr_remove(&pdev->dev);
 
-	data->remove(pdev);
+	if (data->remove)
+		data->remove(pdev);
+
+	if (plat_data)
+		clk_bulk_disable_unprepare(plat_data->num_clks, plat_data->clks);
 }
 
 static const struct of_device_id dwc_eth_dwmac_match[] = {
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index c9878a612e53..24422ac4e417 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -254,6 +254,8 @@ struct plat_stmmacenet_data {
 	struct clk *clk_ptp_ref;
 	unsigned long clk_ptp_rate;
 	unsigned long clk_ref_rate;
+	struct clk_bulk_data *clks;
+	int num_clks;
 	unsigned int mult_fact_100ns;
 	s32 ptp_max_adj;
 	u32 cdc_error_adj;
-- 
2.17.1


