Return-Path: <netdev+bounces-194225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFDDAC7F7F
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 16:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDE8B1BC53CF
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 14:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFAF211497;
	Thu, 29 May 2025 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="W51aC/y+"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3C81C8603
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 14:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748527346; cv=none; b=cn6myWbWho8R5MZY7/QBXD0q7Jid8qIDTxe8/AZv4GWanyHMMrtaE7FB+od6k8BbTuDCK+APa26O9mv9TAjjO3IUmn3Ww0H9Z0yludb2naCNyDLthzdp5chk4t4z3xWmElkaw5kF9yqDbjTQTgyBSIRXHX4n7EyER2xnDQvfs5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748527346; c=relaxed/simple;
	bh=vGRXf0maFs9Ro2S//GRb+Lum6CnZm0r1JvoS56f1RHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=pj6Ggzu2jcyE0E/RQOfNCm8LykV1j/L29WDKEVZT6Uq7eVOBnVFtG1rN3xHhgpkxFyM6PQSTXty5M2bnb0265XP+r0nku4WaBBaWorchmedNnVA1kV6NBA8cMGf4YzPtgq6E45hdpvqxSjaib+uNQ8Iikh1tSA2zCXWHmFN0pkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=W51aC/y+; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250529140222epoutp01c688ff05133d0c3c29bb8f52e5673dea~EBFqZ6I8L2443924439epoutp01m
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 14:02:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250529140222epoutp01c688ff05133d0c3c29bb8f52e5673dea~EBFqZ6I8L2443924439epoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748527342;
	bh=8WKsU5t0kQKXkzewEHojQ9MYlM5Y7vAzte+OeClSGAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W51aC/y+cJ4EoecuuSBv5PGVeGuE+XyI41+h/mS1ivi6Hs6CaTiNK3Z0yZd5p0aS1
	 L8OSaqdJNrsH8Cb6OwFKXE6r5EkT7zZZcoUNVA0rlbvFYRH3kmkRu8Fd01R1E75PgU
	 dJRveyeipTnnoAjM+Rfp5zPUOFbvqOyDlJKh5dpg=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250529140221epcas5p4a57a87fcc503824fc6ebaed013f40015~EBFpPpTKn2669026690epcas5p4b;
	Thu, 29 May 2025 14:02:21 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.177]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4b7Sjl3dG1z6B9m9; Thu, 29 May
	2025 14:02:19 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250529111715epcas5p19a63894e2556d2c8005845e01f67c783~D_1fbc3201682116821epcas5p13;
	Thu, 29 May 2025 11:17:15 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250529111715epsmtrp28367756d56f54d104a4adb8502953868~D_1falGMf2212422124epsmtrp2i;
	Thu, 29 May 2025 11:17:15 +0000 (GMT)
X-AuditID: b6c32a29-566fe7000000223e-8e-6838423a0ae5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	23.3F.08766.A3248386; Thu, 29 May 2025 20:17:14 +0900 (KST)
Received: from bose.samsungds.net (unknown [107.108.83.9]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250529111712epsmtip1c3473e86dd73fe7f2cb4a048b21fa309~D_1cifmF32102821028epsmtip1F;
	Thu, 29 May 2025 11:17:11 +0000 (GMT)
From: Raghav Sharma <raghav.s@samsung.com>
To: krzk@kernel.org, s.nawrocki@samsung.com, cw00.choi@samsung.com,
	alim.akhtar@samsung.com, mturquette@baylibre.com, sboyd@kernel.org,
	robh@kernel.org, conor+dt@kernel.org, richardcochran@gmail.com,
	sunyeal.hong@samsung.com, shin.son@samsung.com
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	chandan.vn@samsung.com, karthik.sun@samsung.com, dev.tailor@samsung.com,
	Raghav Sharma <raghav.s@samsung.com>
Subject: [PATCH v3 3/4] clk: samsung: exynosautov920: add block hsi2 clock
 support
Date: Thu, 29 May 2025 16:56:39 +0530
Message-Id: <20250529112640.1646740-4-raghav.s@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250529112640.1646740-1-raghav.s@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42LZdlhJTtfKySLDoO2DhcWDedvYLCZ8ibBY
	s/cck8X1L89ZLe7tWMZuMf/IOVaLxhlvmCzOn9/AbrHp8TVWi48991gtLu+aw2Yx4/w+JouL
	p1wtji0Qs/i+8g6jxZEzL5gt/u/ZwW5x+E07q8W/axtZLCYfX8tq0bRsPZODqMf7G63sHjtn
	3WX32LSqk81j85J6j74tqxg9Pm+SC2CL4rJJSc3JLEst0rdL4Mq4vug8W8F85YqJX1tYGhiP
	yHYxcnBICJhInG2S7GLk4hAS2M0ocfjMIbYuRk6guITEvv+/GSFsYYmV/56zQxS9ZZTYfKqF
	BSTBJqAlcWX7OzaQhIhAF5PEuX+vWEAcZoGdTBJtj7exg1QJCwRJ7Js8nxXEZhFQlbj99AQT
	yGpeAWuJ4wc1IDbIS+w/eJYZxOYUsJG4e/M52AIhoJKP28+AxXkFBCVOznwCFmcGqm/eOpt5
	AqPALCSpWUhSCxiZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBEeZluYOxu2rPugd
	YmTiYDzEKMHBrCTC22RvliHEm5JYWZValB9fVJqTWnyIUZqDRUmcV/xFb4qQQHpiSWp2ampB
	ahFMlomDU6qBSfZSSKLVjfSHqky3WJg0jsXIRkqXSJy4zNbwv+/En/SiGVe3rXh+VO2QVaeq
	mCfvX6/S5q/ZkvIX2CoeLFok3f+JZc8cCw+TfR9VpnwX6mKZmMes/XPWwpdZN2/ILU8VXB2t
	LzTdaNE0n6p12v5267d9Ys4sWHzMwejBxaJKrTVCjlp5Jmxn98u2tfhvlhae+sZdfp6weut1
	oW3pB3N2R77XlHZ+3u/4SlSUzXdKa2tGwTu2V7FPbBSn/H3Lf8rh2772Jv7YZ9NMuMpmhwp2
	HzlW/nGhdXiK0N3Gx4rBdRyH/KMsk9sVc6VWHeCqdZRR7Dr6vSxedKOw1OF6gZIW8wurzppV
	la3+tsa65LkSS3FGoqEWc1FxIgBs+bx7IQMAAA==
X-CMS-MailID: 20250529111715epcas5p19a63894e2556d2c8005845e01f67c783
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-543,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250529111715epcas5p19a63894e2556d2c8005845e01f67c783
References: <20250529112640.1646740-1-raghav.s@samsung.com>
	<CGME20250529111715epcas5p19a63894e2556d2c8005845e01f67c783@epcas5p1.samsung.com>

Register compatible and cmu_info data to support clocks.
CMU_HSI2, this provides clocks for HSI2 block

Signed-off-by: Raghav Sharma <raghav.s@samsung.com>
---
 drivers/clk/samsung/clk-exynosautov920.c | 72 ++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynosautov920.c b/drivers/clk/samsung/clk-exynosautov920.c
index da4afe8ac2ab..572b6ace14ac 100644
--- a/drivers/clk/samsung/clk-exynosautov920.c
+++ b/drivers/clk/samsung/clk-exynosautov920.c
@@ -26,6 +26,7 @@
 #define CLKS_NR_MISC			(CLK_DOUT_MISC_OSC_DIV2 + 1)
 #define CLKS_NR_HSI0			(CLK_DOUT_HSI0_PCIE_APB + 1)
 #define CLKS_NR_HSI1			(CLK_MOUT_HSI1_USBDRD + 1)
+#define CLKS_NR_HSI2			(CLK_DOUT_HSI2_ETHERNET_PTP + 1)
 
 /* ---- CMU_TOP ------------------------------------------------------------ */
 
@@ -1752,6 +1753,74 @@ static const struct samsung_cmu_info hsi1_cmu_info __initconst = {
 	.clk_name		= "noc",
 };
 
+/* ---- CMU_HSI2 --------------------------------------------------------- */
+
+/* Register Offset definitions for CMU_HSI2 (0x16b00000) */
+#define PLL_LOCKTIME_PLL_ETH                    0x0
+#define PLL_CON3_PLL_ETH			0x10c
+#define PLL_CON0_MUX_CLKCMU_HSI2_ETHERNET_USER  0x600
+#define PLL_CON0_MUX_CLKCMU_HSI2_NOC_UFS_USER   0x610
+#define PLL_CON0_MUX_CLKCMU_HSI2_UFS_EMBD_USER  0x630
+#define CLK_CON_MUX_MUX_CLK_HSI2_ETHERNET       0x1000
+#define CLK_CON_DIV_DIV_CLK_HSI2_ETHERNET       0x1800
+#define CLK_CON_DIV_DIV_CLK_HSI2_ETHERNET_PTP   0x1804
+
+static const unsigned long hsi2_clk_regs[] __initconst = {
+	PLL_LOCKTIME_PLL_ETH,
+	PLL_CON3_PLL_ETH,
+	PLL_CON0_MUX_CLKCMU_HSI2_ETHERNET_USER,
+	PLL_CON0_MUX_CLKCMU_HSI2_NOC_UFS_USER,
+	PLL_CON0_MUX_CLKCMU_HSI2_UFS_EMBD_USER,
+	CLK_CON_MUX_MUX_CLK_HSI2_ETHERNET,
+	CLK_CON_DIV_DIV_CLK_HSI2_ETHERNET,
+	CLK_CON_DIV_DIV_CLK_HSI2_ETHERNET_PTP,
+};
+
+static const struct samsung_pll_clock hsi2_pll_clks[] __initconst = {
+	/* CMU_HSI2_PLL */
+	PLL(pll_531x, FOUT_PLL_ETH, "fout_pll_eth", "oscclk",
+	    PLL_LOCKTIME_PLL_ETH, PLL_CON3_PLL_ETH, NULL),
+};
+
+/* List of parent clocks for Muxes in CMU_HSI2 */
+PNAME(mout_clkcmu_hsi2_noc_ufs_user_p) = { "oscclk", "dout_clkcmu_hsi2_noc_ufs" };
+PNAME(mout_clkcmu_hsi2_ufs_embd_user_p) = { "oscclk", "dout_clkcmu_hsi2_ufs_embd" };
+PNAME(mout_hsi2_ethernet_p) = { "fout_pll_eth", "mout_clkcmu_hsi2_ethernet_user" };
+PNAME(mout_clkcmu_hsi2_ethernet_user_p) = { "oscclk", "dout_clkcmu_hsi2_ethernet" };
+
+static const struct samsung_mux_clock hsi2_mux_clks[] __initconst = {
+	MUX(CLK_MOUT_HSI2_NOC_UFS_USER, "mout_clkcmu_hsi2_noc_ufs_user",
+	    mout_clkcmu_hsi2_noc_ufs_user_p, PLL_CON0_MUX_CLKCMU_HSI2_NOC_UFS_USER, 4, 1),
+	MUX(CLK_MOUT_HSI2_UFS_EMBD_USER, "mout_clkcmu_hsi2_ufs_embd_user",
+	    mout_clkcmu_hsi2_ufs_embd_user_p, PLL_CON0_MUX_CLKCMU_HSI2_UFS_EMBD_USER, 4, 1),
+	MUX(CLK_MOUT_HSI2_ETHERNET, "mout_hsi2_ethernet",
+	    mout_hsi2_ethernet_p, CLK_CON_MUX_MUX_CLK_HSI2_ETHERNET, 0, 1),
+	MUX(CLK_MOUT_HSI2_ETHERNET_USER, "mout_clkcmu_hsi2_ethernet_user",
+	    mout_clkcmu_hsi2_ethernet_user_p, PLL_CON0_MUX_CLKCMU_HSI2_ETHERNET_USER, 4, 1),
+};
+
+static const struct samsung_div_clock hsi2_div_clks[] __initconst = {
+	DIV(CLK_DOUT_HSI2_ETHERNET, "dout_hsi2_ethernet",
+	    "mout_hsi2_ethernet", CLK_CON_DIV_DIV_CLK_HSI2_ETHERNET,
+	    0, 4),
+	DIV(CLK_DOUT_HSI2_ETHERNET_PTP, "dout_hsi2_ethernet_ptp",
+	    "mout_hsi2_ethernet", CLK_CON_DIV_DIV_CLK_HSI2_ETHERNET_PTP,
+	    0, 4),
+};
+
+static const struct samsung_cmu_info hsi2_cmu_info __initconst = {
+	.pll_clks               = hsi2_pll_clks,
+	.nr_pll_clks            = ARRAY_SIZE(hsi2_pll_clks),
+	.mux_clks               = hsi2_mux_clks,
+	.nr_mux_clks            = ARRAY_SIZE(hsi2_mux_clks),
+	.div_clks               = hsi2_div_clks,
+	.nr_div_clks            = ARRAY_SIZE(hsi2_div_clks),
+	.nr_clk_ids             = CLKS_NR_HSI2,
+	.clk_regs               = hsi2_clk_regs,
+	.nr_clk_regs            = ARRAY_SIZE(hsi2_clk_regs),
+	.clk_name               = "noc",
+};
+
 static int __init exynosautov920_cmu_probe(struct platform_device *pdev)
 {
 	const struct samsung_cmu_info *info;
@@ -1779,6 +1848,9 @@ static const struct of_device_id exynosautov920_cmu_of_match[] = {
 	}, {
 		.compatible = "samsung,exynosautov920-cmu-hsi1",
 		.data = &hsi1_cmu_info,
+	}, {
+		.compatible = "samsung,exynosautov920-cmu-hsi2",
+		.data = &hsi2_cmu_info,
 	},
 	{ }
 };
-- 
2.34.1


