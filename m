Return-Path: <netdev+bounces-211315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE72B17EF5
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 11:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54C117A4A9B
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 09:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB747224256;
	Fri,  1 Aug 2025 09:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="E+xqim97"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DB514F70;
	Fri,  1 Aug 2025 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754039606; cv=none; b=kK2tMC6Xzuv4KYONRLyZ9sZapJC5TJJ9JOmT9WhCb3OLWvBl7/YLeD1Zsi8MmVstRuLXMhznXBhomtV4s+QFgUjk5XTFYu3lulNnEgN/zjUv8GGIGIGhRt1ESnpeIhtZFKavmmCCanNOAKAz3VCDUnBaVd4TuGkgczxxuwdNl9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754039606; c=relaxed/simple;
	bh=mREQxr9hxnCZLcPI7LJv8koSLrqI56N3FH8DH5s+/KY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6nfWnhY1gdYmKVcxzGiqfAcDXLFd5N8q2MkAzv4O6NnX0+ieXssqXcEsk32EQx39+xi1t4181kC5q/KF8+pfervaDVL3URZE17f2r5InoIWIdac4Cnzacjsph9V3BKlTG4b56UvWAFr/SopmsFz7sLsnXFwLcBm+OA6iTol0A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=E+xqim97; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id C3D172072F;
	Fri,  1 Aug 2025 11:13:23 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k86eVxTC7xFp; Fri,  1 Aug 2025 11:13:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1754039603; bh=mREQxr9hxnCZLcPI7LJv8koSLrqI56N3FH8DH5s+/KY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E+xqim971noDZDK5NhLGGrGS2kDOzOrPVk+EC0AwF5rpjKeRr1gZlZAoEO7wJMWen
	 //y5p8Sw/nrt2yubZGGHaSrOytF8iVPM/lZitckJY3jv9vTkpujNKYZoxLfxGTcvjl
	 FzpcuxWK7Kfx/af8caYsgjfNk+jxlVJ0vTrWlL/h/GRLtadn98xHNX91QSt4Bt5wDJ
	 JGYkG+hCX1xt6IJwMw1fzGZdfIsdApO0hga6DWukdX/kvyhKCiOTHEV1s86a0u4RrY
	 RDfsC2uR/cuUhk6a0WAPWBGgE6/+zi77fdJWxVb7xaiUP8P74rYApM80U8CGmU9Bad
	 xa7nWjw3Zyfew==
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
Subject: [PATCH net v2 2/3] net: stmmac: thead: Get and enable APB clock on initialization
Date: Fri,  1 Aug 2025 09:12:39 +0000
Message-ID: <20250801091240.46114-3-ziyao@disroot.org>
In-Reply-To: <20250801091240.46114-1-ziyao@disroot.org>
References: <20250801091240.46114-1-ziyao@disroot.org>
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

Fixes: 33a1a01e3afa ("net: stmmac: Add glue layer for T-HEAD TH1520 SoC")
Signed-off-by: Yao Zi <ziyao@disroot.org>
Reviewed-by: Drew Fustini <fustini@kernel.org>
Tested-by: Drew Fustini <fustini@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
index c72ee759aae5..95096244a846 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
@@ -211,6 +211,7 @@ static int thead_dwmac_probe(struct platform_device *pdev)
 	struct stmmac_resources stmmac_res;
 	struct plat_stmmacenet_data *plat;
 	struct thead_dwmac *dwmac;
+	struct clk *apb_clk;
 	void __iomem *apb;
 	int ret;
 
@@ -224,6 +225,11 @@ static int thead_dwmac_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(plat),
 				     "dt configuration failed\n");
 
+	apb_clk = devm_clk_get_optional_enabled(&pdev->dev, "apb");
+	if (IS_ERR(apb_clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(apb_clk),
+				     "failed to get apb clock\n");
+
 	dwmac = devm_kzalloc(&pdev->dev, sizeof(*dwmac), GFP_KERNEL);
 	if (!dwmac)
 		return -ENOMEM;
-- 
2.50.1


