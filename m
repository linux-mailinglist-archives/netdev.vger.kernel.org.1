Return-Path: <netdev+bounces-212143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F86B1E5DC
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 11:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09929188E2B0
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 09:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28592741A3;
	Fri,  8 Aug 2025 09:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="JybmdVyl"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE85273D74;
	Fri,  8 Aug 2025 09:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754646276; cv=none; b=rvgv2FCPHqNkztWSzbxN2ykmgZmtWLipWhy+4Ql9YgcsIxdsA+ejJmKAOkMS3FrlNhlgEUs1kqDhLD4Y33XvkCIG6VJ1kzuHTIVfM9yuT1GoPfkJu8abL2AzJhvBIqxi8kxrYx07aNyLXGsw5FfhAVJlkFdEzatUDgWn0Agskz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754646276; c=relaxed/simple;
	bh=ajJkn2rR1tM7L+hlXIfE6Ac5tEpM02G6+RdV1+gRsGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XfO8529FYWPK+VtQH3O6/joCwSCViISTlBzSq6d++t0tuYJaCecyEYpCyObA0h9BdM0X8bV+ErTquxb7owmW+BKKs2sNHmeURefOwyAyTGhs8rabdu7he33+mE9tIC6852wawVM4H6Fu6v00Mq2Sn1VfxqVMKkCLtPZESFNPlGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=JybmdVyl; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id C5AD22093B;
	Fri,  8 Aug 2025 11:44:32 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pSeEIdqlRFtF; Fri,  8 Aug 2025 11:44:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1754646272; bh=ajJkn2rR1tM7L+hlXIfE6Ac5tEpM02G6+RdV1+gRsGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JybmdVylgPRleVDjovbA2Dctq0OezgzR/rAOTF3LYY4tUfpDcdZz7e/VNyoQI0YdV
	 ftwpNXkUC2/xOcLhGTCi/9Otu3cS4fLdd7QXBF+L5kgeQHaxpKOUrxdZRjNoFHxm0n
	 KJfeYKEloOAkMrFkB+s2kTf8QoMCxEZm7IJLd037ypam2RZLHPvvNmaCBZcyBVgUW8
	 1SgAZVXuUdR4RiNkPtAFH8Isw9EEt5uaxt3rNJypLtxBjnrTnWJojOQqtCv5+/2OMs
	 XfNq+/YMrpzwhz+P0fKIO2MIIzkM4yjLfPsVThzUR+ZH0RqGO2xztKv4YubZCpLAKS
	 1MWau214tA2dw==
From: Yao Zi <ziyao@disroot.org>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Jisheng Zhang <jszhang@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH net v3 2/3] net: stmmac: thead: Get and enable APB clock on initialization
Date: Fri,  8 Aug 2025 09:36:55 +0000
Message-ID: <20250808093655.48074-4-ziyao@disroot.org>
In-Reply-To: <20250808093655.48074-2-ziyao@disroot.org>
References: <20250808093655.48074-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's necessary to adjust the MAC TX clock when the linkspeed changes,
but it's noted such adjustment always fails on TH1520 SoC, and reading
back from APB glue registers that control clock generation results in
garbage, causing broken link.

With some testing, it's found a clock must be ungated for access to APB
glue registers. Without any consumer, the clock is automatically
disabled during late kernel startup. Let's get and enable it if it's
described in devicetree.

For backward compatibility with older devicetrees, probing won't fail if
the APB clock isn't found. In this case, we emit a warning since the
link will break if the speed changes.

Fixes: 33a1a01e3afa ("net: stmmac: Add glue layer for T-HEAD TH1520 SoC")
Signed-off-by: Yao Zi <ziyao@disroot.org>
Tested-by: Drew Fustini <fustini@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
index c72ee759aae5..f2946bea0bc2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
@@ -211,6 +211,7 @@ static int thead_dwmac_probe(struct platform_device *pdev)
 	struct stmmac_resources stmmac_res;
 	struct plat_stmmacenet_data *plat;
 	struct thead_dwmac *dwmac;
+	struct clk *apb_clk;
 	void __iomem *apb;
 	int ret;
 
@@ -224,6 +225,19 @@ static int thead_dwmac_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(plat),
 				     "dt configuration failed\n");
 
+	/*
+	 * The APB clock is essential for accessing glue registers. However,
+	 * old devicetrees don't describe it correctly. We continue to probe
+	 * and emit a warning if it isn't present.
+	 */
+	apb_clk = devm_clk_get_enabled(&pdev->dev, "apb");
+	if (PTR_ERR(apb_clk) == -ENOENT)
+		dev_warn(&pdev->dev,
+			 "cannot get apb clock, link may break after speed changes\n");
+	else if (IS_ERR(apb_clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(apb_clk),
+				     "failed to get apb clock\n");
+
 	dwmac = devm_kzalloc(&pdev->dev, sizeof(*dwmac), GFP_KERNEL);
 	if (!dwmac)
 		return -ENOMEM;
-- 
2.50.1


