Return-Path: <netdev+bounces-163979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E6AA2C382
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 052553AB831
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 13:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFAF1F4191;
	Fri,  7 Feb 2025 13:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oEBsrlUq"
X-Original-To: netdev@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9CD1F4174
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 13:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738934897; cv=none; b=utTRNMxzd4zysfgt27Vr+BCo15DykW9V+I2HfEK3Gc7QN/8BrajQmz1xdz1Nx5khDY60bUr95c5+7Ci9YcnNrmPGf6ibdqOyaLdoovaYO+UeIZTHc3CgaxnGCiZvRvhHFQJeiStzaU7CDzdG4SDb1KXCEICRjwJcI2BevgXDK6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738934897; c=relaxed/simple;
	bh=6L+nvDqOKHipKDklchE5gvYs7yrF4MnPXIblT4Xz2kU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:References; b=Avi1k2u/NI7d2ok9FeoXvolksqHvMknKCgceO+cibq+Juj0XB6w6kkCY+NxM4vcbyMRJyjnFU0IxXZeNH5in1AteuiHikPjJVSz5IzSgY1ILT3IuzBPxIh8bisAHtxcCQapcFMeW9fcY/Je2uq/FA+AogG0h1a/uBKreFzJgA9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=oEBsrlUq; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250207132808epoutp03840cda6adf2775ed778c357a4c5ffdbd~h8BFG_c-y2597425974epoutp036
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 13:28:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250207132808epoutp03840cda6adf2775ed778c357a4c5ffdbd~h8BFG_c-y2597425974epoutp036
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738934888;
	bh=GDXBQ3YjlyKVtpnmdKwmtp6KHF6POFf/d36tshBTNEE=;
	h=From:To:Cc:Subject:Date:References:From;
	b=oEBsrlUq5Hu5eQiI4EMlECD9sSrZkgC81wHP3VrYtpPcwgm0fU78S5H7CIiic7RD+
	 XoEo3y9yl/ijeVkNhoRr63dp7gemY3xr8f0MrQHGkuGbPjZSlu6d+9GqLXP9GYLBhz
	 746KSoz2NDxCdGKHoG0SvXNoKsBWwaUxeeNe+kVc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250207132806epcas5p4b4f54c279da9003fdb3f63c06d791798~h8BDkNQ_j2256922569epcas5p4K;
	Fri,  7 Feb 2025 13:28:06 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4YqFCT1ny0z4x9Pq; Fri,  7 Feb
	2025 13:28:05 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	40.D8.19710.56A06A76; Fri,  7 Feb 2025 22:28:05 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250207122130epcas5p1857043fa03e7356dc8783f43a95716ef~h7G5v_e2G2035920359epcas5p1S;
	Fri,  7 Feb 2025 12:21:30 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250207122130epsmtrp2971b42370dd5d292e9f31c79b272da6c~h7G5uh7qS0761607616epsmtrp2F;
	Fri,  7 Feb 2025 12:21:30 +0000 (GMT)
X-AuditID: b6c32a44-36bdd70000004cfe-1d-67a60a654420
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	47.01.23488.9CAF5A76; Fri,  7 Feb 2025 21:21:30 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250207122125epsmtip10738e7a8f8d8a553c0e5ef9b385df5a0~h7G1jRiUZ3169031690epsmtip1f;
	Fri,  7 Feb 2025 12:21:25 +0000 (GMT)
From: Swathi K S <swathi.ks@samsung.com>
To: krzk@kernel.org, robh@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	conor+dt@kernel.org, richardcochran@gmail.com, treding@nvidia.com,
	Jisheng.Zhang@synaptics.com, ajayg@nvidia.com, Joao.Pinto@synopsys.com,
	mcoquelin.stm32@gmail.com, andrew@lunn.ch, linux-fsd@tesla.com
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	alexandre.torgue@foss.st.com, peppe.cavallaro@st.com, joabreu@synopsys.com,
	swathi.ks@samsung.com, ssiddha@tesla.com, xiaolei.wang@windriver.co,
	si.yanteng@linux.dev, fancer.lancer@gmail.com, halaney@redhat.com,
	pankaj.dubey@samsung.com, ravi.patel@samsung.com, gost.dev@samsung.com
Subject: [PATCH] net: stmmac: refactor clock management in EQoS driver
Date: Fri,  7 Feb 2025 17:48:49 +0530
Message-Id: <20250207121849.55815-1-swathi.ks@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0VTa0xTZxjO19PTUzCQE2DbJ4yM1S0REGzH7SuCEmHuZDLDNhccC2NNOWsb
	Stv1IoNkWQPopFEYOi7TjttkTG4iUqBAEYtiRKQoFyVY5booOJiDMRwB1lLY/j3f87zP+7x5
	v7xszC2H8GRLZGpaKRNIOSxnZnO3r28A7fyLiDtmwdFg9xoLvXxWCJDFasZQramfgfSWbCYq
	vdGPo5meSQI1nNLjaLTLyEC103kYKhytYqLHFfM4Wpm8iSGLpYFAA825OGqcGsHRxGw8GmzT
	s1CxpZOBdCPTOCpZq8NRT9mraPnOc4AqDEsE2pgzADTxRweBbvQ9xdBGRyuBRld6MFQxXoaj
	pSujBBpbdUX562YQ9SbVdGmUQc3kGQjKeN5KUGWNGqqxOodFlWsLMOrqxW8pY+sigzqTNc+i
	FjqHWVRuUzWgrnfyqJkVE0adHerHqKZri4Baz/yJiHNLSIkQ04JkWulDy4TyZIlMFMk5/HFS
	dFJIKJcXwOOjMI6PTJBKR3JiYuMCDkmkttVxfI4LpBobFSdQqTh790co5Ro17SOWq9SRHFqR
	LFUEKwJVglSVRiYKlNHqcB6X+06IrfCLFPGteiOuuBf+tW6tlKkFQ1wdcGJDMhgWjuuADjiz
	3ch2AB+t32baBTfyTwBb7kkdwjKAneYqYtuhe1aMOQQTgF1WM+54LAFomexj2atY5G744NcW
	wi54kDcZ8EHtyKYFIxcwqM8pwOxV7uQhaHzYi9sxk3wbniuoBHbsQobD0zN3mY68N2BNQ9em
	GZItTvDHqSuYQ4iBk09+ZzmwO5y91bQ1oCdcnDdt8UmwJnd4q5EYWv/J3+IPwK4hvY1n2yby
	hZfb9jpob1jQW8+wY4x0hWdWpxkO3gW2lmzjXXBtbmSr5U7YXLmwFUvBauPPLMfyEuFv1834
	98D7/P8JZQBUg520QpUqooUhCp6MTvvvq4Ty1EaweRN+Ma3gYel6oBkw2MAMIBvjeLj8UHtR
	5OaSLEjPoJXyJKVGSqvMIMS2s3zM8xWh3HZUMnUSL5jPDQ4NDQ3mB4XyOK+5ZBmzRW6kSKCm
	U2haQSu3fQy2k6eW0XbEq9+//cOarPfbK+s+AUJ9fZ6GSOw0ZSrLxCfuu8/E3xnQxAcYJK4Z
	fpcy9vhzpTsOTu/7/Kx2R9PR4yOL4+IvT1ZEvuc5ZS0fGFjmzwmrolrLe5nMy8OMHIniq/Ai
	eXp20AfqngXZoNfrSc3pB70j/vq0Nu8p/wUz0n2/bjVKGFhWsHpVRb4UPf/uwNjhk7u9/E/k
	L3TMNxa8dcrb+iKvfvbd3nlRzDcXGgXR3COGcoX2sW/IZOuh2eiiMM3903ztSEdiWoIk7W6V
	uo5+VGJ6MtStu3bsKDPT3SNMX+E1umEsDbrw0We3/z4XG7TrWF9CnHVfrtJQXLRHUTE9EWuF
	Eg5TJRbw/DClSvAvF6sVgJwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsWy7bCSnO6pX0vTDV61MltcPvyXzeLny2mM
	FufvHmK2WLP3HJPFnPMtLBbzj5xjtXh67BG7xYaOOawWNw/sZLJY86Sf2WLazeUsFvcWvWO1
	+PHoKLPF+fMb2C0ubOtjtdj0+BqrxcNX4RaXd81hs5hxfh+TRde1J6wW8/6uZbU4tkDM4tvp
	N4wWi7Z+Ybf4/3oro8XDD3vYLY6cecFs8X/PDnaLmz+OMVsserCA1eLLxpvsFrd/81lM/HeI
	0UHRY8vKm0weT/u3snvsnHWX3WPBplKPTas62TwWNkxl9ti8pN5j547PTB69ze/YPN7vu8rm
	0bdlFaPHwX2GHk9/7GX2mHTlHLPHlv2fGT3+Nc1lDxCK4rJJSc3JLEst0rdL4Mo4vm4na8FF
	q4quv/NZGhivGHQxcnJICJhIdL2cwdzFyMUhJLCbUeL9zL8sEAlJiU/NU1khbGGJlf+es0MU
	fWKUmPyqhREkwSagIXF9xXawhIjATSaJ9737wEYxC7SySFx/sQysXVjATWLnjVNgNouAqsTk
	qUvBunkFrCR6np6FWicvsXrDAeYJjDwLGBlWMUqmFhTnpucmGxYY5qWW6xUn5haX5qXrJefn
	bmIEx6yWxg7Gd9+a9A8xMnEwHmKU4GBWEuGdsmZJuhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe
	lYYR6UIC6YklqdmpqQWpRTBZJg5OqQam8vYE0VcX/vm9tM3YIfd6PU/WCu/1r4xjODWjKxkn
	KlbU11RsW3fOeVrSfJcwrkRl6f3ZfBEPHVYaL3TX9xL8dVNmsux05oIXjokPDV4yGV2ovOl9
	X8vB49YbLtbbZTftZNrY68XVGOUj5oQGM9wxkPjB+oSx61e6nq238k4LXx37o1GT359OrJYX
	2hrjlzbbN2dDcsiz2BX+Ng9Pm/XtCe9rzDL8bfHpt9nWs3N4/Lesvfg56tWFOQ1MS32lOk59
	fX78ZtjuTe9PCh5cmtjx211z0qzZ1VZ5W1nMvZK3XPRoSnzZePdjTbD9hS0b9mofXPXod1n6
	rz1ll7r6NHeYuIo/EA/mDqpRtVgzc5oSS3FGoqEWc1FxIgD//YYLSAMAAA==
X-CMS-MailID: 20250207122130epcas5p1857043fa03e7356dc8783f43a95716ef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250207122130epcas5p1857043fa03e7356dc8783f43a95716ef
References: <CGME20250207122130epcas5p1857043fa03e7356dc8783f43a95716ef@epcas5p1.samsung.com>
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
The changes are not tested in tegra and snps platforms. Requesting the
maintainers to perform the checks on their platforms.

This refactoring was suggested in the following patch as part of FSD
upstreaming activity:
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20250128102558.22459-3-swathi.ks@samsung.com/

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


