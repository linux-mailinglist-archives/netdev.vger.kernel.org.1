Return-Path: <netdev+bounces-212144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C6DB1E5DF
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 11:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 566DC7286F6
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 09:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0199926FD9F;
	Fri,  8 Aug 2025 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="JuWdI/22"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2D325EF87;
	Fri,  8 Aug 2025 09:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754646331; cv=none; b=HsCXsKfH7g0Ed8hjkYGmHHIApaQGZ/56bflU4KpxbsQSE2rZCofhSvyRCoR2tn3X+jjij+Y3H2WhNdzMFF2Jpz++jnFoULK0Ug6cD3ygjk8MoHQQ9oWJ77YOqOIU/X0PfA5w9NpjzHdC8ML4/3IIh6kpOj3vsOARlfd/ZL5GgmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754646331; c=relaxed/simple;
	bh=gJCswTbeSm0cfVQDYDQlFj9ENNDHXqLsDS5p8UVfsgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TwEPulhNjeuuWvnvzZe+Owk4DRJHTejgHyzuVXevmLit0zwnQbDBQLoPkDC0rqytTkplxlpptiUa4V3AZkopQOzlbVKLL2nfa+znP0oBFGBQjgqNOxwT+R9b7sfF9T8BEjyhTPrKBDwZ7eym8TqhR/SWjFZnW6WWJReCuF8i/Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=JuWdI/22; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id A633123CB7;
	Fri,  8 Aug 2025 11:45:28 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aQEZZtQOrJMo; Fri,  8 Aug 2025 11:45:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1754646328; bh=gJCswTbeSm0cfVQDYDQlFj9ENNDHXqLsDS5p8UVfsgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JuWdI/22rnTfj2+JDLe2ZFyQkwJTP7HMjmbYqFkH//AlUH3gEJbC7WqnExmM4Essq
	 UxFUpesshFjjPOcR5Mq6H1pkI3xd/GbzIrdN4sDqaZDMwuOq85mMIdKH+FE/Tptx9y
	 8zW68LQa3IynfDKWmRaT0BHQ2QIvMocS22ZqActTwLrUY1AJmaLsAp4/HWUBWM/p8y
	 xO27gMxq/Dj7JDyb4W+Sd5L4Ku1xsdvep3P87J0rKgxGqDBdOeueMhJaeil7Oje/I3
	 X0IjEMhbCU/yX3cSoOf9DekyJnke9GH9qBhZkK7bn1E92EGrVt4PuTrIfKOU2dnA1y
	 eGYyHIeZPGm0w==
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
Subject: [PATCH net v3 3/3] riscv: dts: thead: Add APB clocks for TH1520 GMACs
Date: Fri,  8 Aug 2025 09:36:56 +0000
Message-ID: <20250808093655.48074-5-ziyao@disroot.org>
In-Reply-To: <20250808093655.48074-2-ziyao@disroot.org>
References: <20250808093655.48074-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe perisys-apb4-hclk as the APB clock for TH1520 SoC, which is
essential for accessing GMAC glue registers.

Fixes: 7e756671a664 ("riscv: dts: thead: Add TH1520 ethernet nodes")
Signed-off-by: Yao Zi <ziyao@disroot.org>
Reviewed-by: Drew Fustini <fustini@kernel.org>
Tested-by: Drew Fustini <fustini@kernel.org>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 42724bf7e90e..03f1d7319049 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -297,8 +297,9 @@ gmac1: ethernet@ffe7060000 {
 			reg-names = "dwmac", "apb";
 			interrupts = <67 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
-			clocks = <&clk CLK_GMAC_AXI>, <&clk CLK_GMAC1>;
-			clock-names = "stmmaceth", "pclk";
+			clocks = <&clk CLK_GMAC_AXI>, <&clk CLK_GMAC1>,
+				 <&clk CLK_PERISYS_APB4_HCLK>;
+			clock-names = "stmmaceth", "pclk", "apb";
 			snps,pbl = <32>;
 			snps,fixed-burst;
 			snps,multicast-filter-bins = <64>;
@@ -319,8 +320,9 @@ gmac0: ethernet@ffe7070000 {
 			reg-names = "dwmac", "apb";
 			interrupts = <66 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
-			clocks = <&clk CLK_GMAC_AXI>, <&clk CLK_GMAC0>;
-			clock-names = "stmmaceth", "pclk";
+			clocks = <&clk CLK_GMAC_AXI>, <&clk CLK_GMAC0>,
+				 <&clk CLK_PERISYS_APB4_HCLK>;
+			clock-names = "stmmaceth", "pclk", "apb";
 			snps,pbl = <32>;
 			snps,fixed-burst;
 			snps,multicast-filter-bins = <64>;
-- 
2.50.1


