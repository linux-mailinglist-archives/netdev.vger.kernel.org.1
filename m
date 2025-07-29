Return-Path: <netdev+bounces-210762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A430BB14B6F
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 11:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBA594E664F
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 09:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87372877F9;
	Tue, 29 Jul 2025 09:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Ok1BP9fT"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6843233140;
	Tue, 29 Jul 2025 09:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753781899; cv=none; b=jE6rhO6hm74I9toxSKhxXiMXHPMtuzf1OG6JjHHrnrxYjR1pjCtNzREhqhBwHN9oeHPrSuXo+EfF57szzSkPMgvgQ0jFfcBpwPgpGn4nBjY7MjSxxovHzwdWgi2EU44FIYw8+q4tPhjpbbaXA08t0cTQ6qT3PFypTaZ7/qgBxmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753781899; c=relaxed/simple;
	bh=dbCvNaqSs+EE66nSXH0s8xd+C/Lm0/TvIxSmIJpIbVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIoXxWOmFvaXvCEG9xi2EnzoAL46tprQWVqvdhReH4DPi4M9UT7yP9GxqW/dIkAZvHMfSVDcu9YA/wwaBg7H6ewE5FMaCywZApiiGbhbeLg3MP/4aAZ1rCG8TbCdLTsaeAcNLzlHGYiq0WtZDKlafRM7vWLHSlI5IJfkDDXePOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Ok1BP9fT; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 344BE206BD;
	Tue, 29 Jul 2025 11:38:16 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C6Wu41bWfsYT; Tue, 29 Jul 2025 11:38:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1753781895; bh=dbCvNaqSs+EE66nSXH0s8xd+C/Lm0/TvIxSmIJpIbVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ok1BP9fTsD9JNInYx6Trjr+Cazv/2Waple+MjsYgwP3J2cheZRtcdWsAEVUU4rD4o
	 ZHmsgJNA4rxK7qK/Fqk1coz34H5/kC+CtfFrLG77xCxAvHGtBabX4GqshUNtqjGU2g
	 +kFWuVnExZDqa2E2E2HB+TZcP9qUeiyOue3nZwhQZzyU8ox9QnkUSUXW0nVLAQnOYd
	 JrPFnw8mYGj5SuBQnZD8RNp50KKWP1PMn395U8PGUctd2TF3lumIeSxaEmGaNo8DXH
	 4vH/+QsXs8cCUUDzgLd6eHWoKegXy6AOXpNyCQhxNmsGAOIoFVVbY4WWTpvksC7jJh
	 8+luIuwzUdeIg==
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
Subject: [PATCH net 2/3] net: stmmac: thead: Get and enable APB clock on initialization
Date: Tue, 29 Jul 2025 09:37:33 +0000
Message-ID: <20250729093734.40132-3-ziyao@disroot.org>
In-Reply-To: <20250729093734.40132-1-ziyao@disroot.org>
References: <20250729093734.40132-1-ziyao@disroot.org>
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


