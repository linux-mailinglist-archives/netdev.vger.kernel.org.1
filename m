Return-Path: <netdev+bounces-168007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CC6A3D21D
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 08:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5935416A7FE
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 07:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1281E9B09;
	Thu, 20 Feb 2025 07:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="B50vyntq"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1791E9916
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 07:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740036143; cv=none; b=jMEDRw8gV5gfQGY+SV8FRD4bjOAQKnUyxc0SdpxRiTFajPXzSk5sKeS1nbjdCB0s9tXiQzKaLTYJ8EbZemvFglOoPs4gsnQ0rxBY/ad9tOyMDT9TfoMUhmYLDE0t3ghVc9xrlCwlII0bIaUu53k97/raK1+2VSDwXePFY5/LO/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740036143; c=relaxed/simple;
	bh=r1iGZ3ZCMqNEqxUQX7mMzJEzTkiUGMTBbkaulz0nvgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=qHp39PMtj7WaroN7+4J0JAKx8JfvuYb4+4G8kyRRkOo/CX8PWnIw7qMNBWHDgIR39jAK/pdZbi0KZnY85k6PWqh7sge94Ip/e7YGCZi08nKHJPF+YfTjHaMR6w8x/PUiTMkpbYM1cncgTAkO4MABC3vFfh+VPweOH0CPa1x479k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=B50vyntq; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250220072219epoutp01a2b4d267697dc25e72ed497dcf621a47~l2aZO6kd11739417394epoutp01R
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 07:22:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250220072219epoutp01a2b4d267697dc25e72ed497dcf621a47~l2aZO6kd11739417394epoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740036139;
	bh=VosXjbK9hgCnWe/dUqqI+OCmClOYizovvRAwqgJ17+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B50vyntqJ4OE0IwRn9/Mmk8Em53hD18OlgKhWRQVz6zIOvF+asJ7CPg1+ITwhNmpz
	 bJZEjY1DZRzeb54qKWChF1CSN1rR8BT2tELoa5sNaOl/ZcEudo+FVIRSo0H7zDoext
	 aWXXDDL9298ylBd8CkaD/rSjIHf9AjzGlibZggxo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250220072218epcas5p3fc7ee5d0a3010456fb638d960ede238d~l2aYgbmB_1640116401epcas5p3G;
	Thu, 20 Feb 2025 07:22:18 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Yz4TN3ZDsz4x9Q1; Thu, 20 Feb
	2025 07:22:16 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	76.DA.20052.828D6B76; Thu, 20 Feb 2025 16:22:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250220044132epcas5p305e4ed7ed1c84f9800299c2091ea0790~l0OBJU5K50967409674epcas5p30;
	Thu, 20 Feb 2025 04:41:32 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250220044132epsmtrp1ba3b75104fbe2e8a9edb8b730e14fd19~l0OBIY3pU1731817318epsmtrp1F;
	Thu, 20 Feb 2025 04:41:32 +0000 (GMT)
X-AuditID: b6c32a49-3fffd70000004e54-00-67b6d8289d9b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	F5.3E.33707.C72B6B76; Thu, 20 Feb 2025 13:41:32 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250220044129epsmtip1080e8366a6271e78c49953e1cc002298~l0N_ZBEgv1683716837epsmtip1q;
	Thu, 20 Feb 2025 04:41:29 +0000 (GMT)
From: Swathi K S <swathi.ks@samsung.com>
To: krzk+dt@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	conor+dt@kernel.org, richardcochran@gmail.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: rmk+kernel@armlinux.org.uk, swathi.ks@samsung.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	pankaj.dubey@samsung.com, ravi.patel@samsung.com, gost.dev@samsung.com
Subject: [PATCH v7 2/2] net: stmmac: dwc-qos: Add FSD EQoS support
Date: Thu, 20 Feb 2025 10:07:12 +0530
Message-Id: <20250220043712.31966-3-swathi.ks@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250220043712.31966-1-swathi.ks@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBJsWRmVeSWpSXmKPExsWy7bCmlq7GjW3pBt8OSFr8fDmN0WL5gx2s
	Fmv2nmOymHO+hcVi/pFzrBZPjz1it7h5YCeTxctZ99gsLmzrY7XY9Pgaq8XlXXPYLLquPWG1
	mPd3LavFsQViFt9Ov2G0WLT1C7vFww972C2OnHnBbHGpfyKTxf89O9gtvmy8ye4g6nH52kVm
	jy0rbzJ5PO3fyu6xc9Zddo8Fm0o9Nq3qZPPYvKTeY+eOz0we7/ddZfPo27KK0ePgPkOPz5vk
	Aniism0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgH5V
	UihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgYmQIV
	JmRnPH65m6WgX6ji+MfLTA2MXfxdjJwcEgImEq+uLWbtYuTiEBLYzSjRPOctlPOJUaLxajcT
	nLP67XJmmJaXs+4zQiR2Mko8WfaSGcL5wihx52U3I0gVm4CGxPUV29lBEiICvxglPkw6DVbF
	LLCcSeL0gytgs4QFnCTuH74B1sEioCqx63szC4jNK2Al8fH2ASaIffISqzccAKvnFLCWWLHn
	F9huCYE7HBJ/Pn2CKnKROPxrFRuELSzx6vgWdghbSuJlfxuUHS+xuu8qC4SdIXH310SoenuJ
	A1fmAMU5gK7TlFi/Sx8iLCsx9dQ6sPHMAnwSvb+fQK3ildgxD8ZWlvj7+hrUSEmJbUvfQ63y
	kJi37gkLJFj6GCXuT1jLOIFRbhbCigWMjKsYJVMLinPTU4tNCwzzUsvhEZecn7uJEZyktTx3
	MN598EHvECMTB+MhRgkOZiUR3rb6LelCvCmJlVWpRfnxRaU5qcWHGE2BATiRWUo0OR+YJ/JK
	4g1NLA1MzMzMTCyNzQyVxHmbd7akCwmkJ5akZqemFqQWwfQxcXBKNTAFCBWsWhhceG1r2dlD
	fjcib8vpCrMt5/KQ9xZ174jj138bENh3+KjI0gx/1W9LCtotrq6KMmJunKny2uHV732PqjnX
	G+gsXW208Jcsc/2s6ncTjx04vohvy91t9j/6SqRbph/v5sv4c/2OyDSvGX5N748LaLf/DT7D
	w5NyMvlXYP8ypy79tcuDteImN+7Pi6p/b3NgXs6XXK/Nrot1TvL1sh9nfli28pnelPuHJyvy
	HGg+tnd/1nW+Fr5fQafa59Vs2PPl6bFNW36tPRZ7O3HjypO5Ti7Pdad5hFZ+9BX/rssisS99
	X5+HlIrKQtXS2xUrOP/M33vTJiS1pTJsKsOaVk/buYx3rNhZS0J78tYrsRRnJBpqMRcVJwIA
	6LStElsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsWy7bCSnG7Npm3pBm9uqFv8fDmN0WL5gx2s
	Fmv2nmOymHO+hcVi/pFzrBZPjz1it7h5YCeTxctZ99gsLmzrY7XY9Pgaq8XlXXPYLLquPWG1
	mPd3LavFsQViFt9Ov2G0WLT1C7vFww972C2OnHnBbHGpfyKTxf89O9gtvmy8ye4g6nH52kVm
	jy0rbzJ5PO3fyu6xc9Zddo8Fm0o9Nq3qZPPYvKTeY+eOz0we7/ddZfPo27KK0ePgPkOPz5vk
	AniiuGxSUnMyy1KL9O0SuDIev9zNUtAvVHH842WmBsYu/i5GTg4JAROJl7PuM3YxcnEICWxn
	lPh25hwTREJS4lPzVFYIW1hi5b/n7BBFnxgljt6/wg6SYBPQkLi+YjtYQkSgg0liz9STzCAO
	s8BGJoljlzaDVQkLOEncP3yDEcRmEVCV2PW9mQXE5hWwkvh4+wDUOnmJ1RsOMIPYnALWEiv2
	/AKq5wBaZyUxu8F1AiPfAkaGVYyiqQXFuem5yQWGesWJucWleel6yfm5mxjBsaMVtINx2fq/
	eocYmTgYDzFKcDArifC21W9JF+JNSaysSi3Kjy8qzUktPsQozcGiJM6rnNOZIiSQnliSmp2a
	WpBaBJNl4uCUamCK0N8vfvSN+eUdpycnB/menSBrscNoxxcduft3pRa4XIuaobUmu1WalbNU
	/ZuX6vW4b/PFPVP8tON2vX6ptP9HiPQFkUc/O9cqVb3QP9O8/fiJ/s6AHIUl6lOvVXV9Lz4Q
	Lfn0jtqMf6aHpDa8tZu97PoZOc/Zuzuq1hivck59rj5X9JiSgd/+qplcKo9feYu4L/26ZOYR
	t8If0ml3FDaLhqhI/3z8OML47q31zI15XyNY+Q+WSBose5+RcUqxqebKbLXUjntdFVmBs54Y
	aewS6FK6dJCtqlHoydcNLV/mls5U+vff4mTusZkby38/dYvzC0wQ/lPIdNwhcrOABCu/8Z6p
	H37ZaE7K2+Bh9qRHiaU4I9FQi7moOBEA8feWCwwDAAA=
X-CMS-MailID: 20250220044132epcas5p305e4ed7ed1c84f9800299c2091ea0790
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250220044132epcas5p305e4ed7ed1c84f9800299c2091ea0790
References: <20250220043712.31966-1-swathi.ks@samsung.com>
	<CGME20250220044132epcas5p305e4ed7ed1c84f9800299c2091ea0790@epcas5p3.samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The FSD SoC contains two instance of the Synopsys DWC ethernet QOS IP core.
The binding that it uses is slightly different from existing ones because
of the integration (clocks, resets).

Signed-off-by: Swathi K S <swathi.ks@samsung.com>
---
 .../stmicro/stmmac/dwmac-dwc-qos-eth.c        | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
index 1fadb8ba1d2f..22a263664f0a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
@@ -307,6 +307,29 @@ static void tegra_eqos_remove(struct platform_device *pdev)
 	gpiod_set_value(eqos->reset, 1);
 }
 
+static int fsd_eqos_probe(struct platform_device *pdev,
+			  struct plat_stmmacenet_data *data,
+			  struct stmmac_resources *res)
+{
+	struct clk *clk_rx1 = NULL;
+	struct clk *clk_rx2 = NULL;
+
+	for (int i = 0; i < data->num_clks; i++) {
+		if (strcmp(data->clks[i].id, "slave_bus") == 0)
+			data->stmmac_clk = data->clks[i].clk;
+		else if (strcmp(data->clks[i].id, "eqos_rxclk_mux") == 0)
+			clk_rx1 = data->clks[i].clk;
+		else if (strcmp(data->clks[i].id, "eqos_phyrxclk") == 0)
+			clk_rx2 = data->clks[i].clk;
+	}
+
+	/* Eth0 RX clock doesn't support MUX */
+	if (clk_rx1)
+		clk_set_parent(clk_rx1, clk_rx2);
+
+	return 0;
+}
+
 struct dwc_eth_dwmac_data {
 	int (*probe)(struct platform_device *pdev,
 		     struct plat_stmmacenet_data *data,
@@ -323,6 +346,10 @@ static const struct dwc_eth_dwmac_data tegra_eqos_data = {
 	.remove = tegra_eqos_remove,
 };
 
+static const struct dwc_eth_dwmac_data fsd_eqos_data = {
+	.probe = fsd_eqos_probe,
+};
+
 static int dwc_eth_dwmac_probe(struct platform_device *pdev)
 {
 	const struct dwc_eth_dwmac_data *data;
@@ -401,6 +428,7 @@ static void dwc_eth_dwmac_remove(struct platform_device *pdev)
 static const struct of_device_id dwc_eth_dwmac_match[] = {
 	{ .compatible = "snps,dwc-qos-ethernet-4.10", .data = &dwc_qos_data },
 	{ .compatible = "nvidia,tegra186-eqos", .data = &tegra_eqos_data },
+	{ .compatible = "tesla,fsd-ethqos", .data = &fsd_eqos_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, dwc_eth_dwmac_match);
-- 
2.17.1


