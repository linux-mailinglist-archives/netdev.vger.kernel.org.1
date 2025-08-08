Return-Path: <netdev+bounces-212142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 38047B1E5D4
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 11:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 226FF4E3F02
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 09:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0865C2737E4;
	Fri,  8 Aug 2025 09:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="cj+huHdm"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D991327147A;
	Fri,  8 Aug 2025 09:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754646267; cv=none; b=jtzXsRfyGVd3UAs+hwBd/Jp5eQdolzqPhuGG2XGWj6kFyPuDls9Xb6sXSYs0y4jt1j9p4cm/mq7XSMn9WZ/anvCmXYJ2kWG6tLrZViAOVzLklbURtQQN6vEoozSkV1su+JAMxahjPi1tGb1eQHskycxeSV9l7PBdkKsgk7T06/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754646267; c=relaxed/simple;
	bh=bvjn31etsIDthI47vSBHLCji4m9GlQ5217Yq/HieC5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oz+mYgBm7aGksmCQJ4Ipt4ZAR3ADyfu7rKJxc3QdnIQXoi/9XL60AwqGaB6pRanlVMavy00pi4blD+NVnpgH9w1NG72tz7mWocXvfsp1wTLeJg9zmqvzn1eyb9/7jV/5+Ng0LXxG+AUyEyam6nBkViWOt0aeWe18BoSqA6diQsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=cj+huHdm; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id ED81925B19;
	Fri,  8 Aug 2025 11:44:23 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lu_epiSKnSqX; Fri,  8 Aug 2025 11:44:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1754646263; bh=bvjn31etsIDthI47vSBHLCji4m9GlQ5217Yq/HieC5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cj+huHdmkhARCGiOcrZcGJSUuR3pusyK9Uv8Xv/zJgYFvsJoIyX4vxFogismahLxZ
	 18uyN6wFHzItDLknPaabQMd4cl9ag/m/eeR48DG9Gu+WhwnrvRplJsGGAArwI9Npjb
	 0+VpHXImP1Qaq7dW/bsd6VsjumQjcBHhlyiZOtwx3PxGyG8I0ebAasxbH8KHZNkJLs
	 T4pEL37ABg4guftpTvAfVJpFAGwdiph0Bs1aQ/z6BhkoCI41DfwDP6XSJsjOiC1wEl
	 Uw8d6o3WghJ4/DzlO8FbPa24twqdlbbHjJQ1yHqsQ38eJZyZvOR4ePo525tR0JE6Op
	 mIkpuGoHaaWzw==
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
	Yao Zi <ziyao@disroot.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net v3 1/3] dt-bindings: net: thead,th1520-gmac: Describe APB interface clock
Date: Fri,  8 Aug 2025 09:36:54 +0000
Message-ID: <20250808093655.48074-3-ziyao@disroot.org>
In-Reply-To: <20250808093655.48074-2-ziyao@disroot.org>
References: <20250808093655.48074-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Besides ones for GMAC core and peripheral registers, the TH1520 GMAC
requires one more clock for configuring APB glue registers. Describe
it in the binding.

Fixes: f920ce04c399 ("dt-bindings: net: Add T-HEAD dwmac support")
Signed-off-by: Yao Zi <ziyao@disroot.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Drew Fustini <fustini@kernel.org>
---
 .../devicetree/bindings/net/thead,th1520-gmac.yaml          | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml b/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
index 6d9de3303762..b3492a9aa4ef 100644
--- a/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
+++ b/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
@@ -62,11 +62,13 @@ properties:
     items:
       - description: GMAC main clock
       - description: Peripheral registers interface clock
+      - description: APB glue registers interface clock
 
   clock-names:
     items:
       - const: stmmaceth
       - const: pclk
+      - const: apb
 
   interrupts:
     items:
@@ -88,8 +90,8 @@ examples:
         compatible = "thead,th1520-gmac", "snps,dwmac-3.70a";
         reg = <0xe7070000 0x2000>, <0xec003000 0x1000>;
         reg-names = "dwmac", "apb";
-        clocks = <&clk 1>, <&clk 2>;
-        clock-names = "stmmaceth", "pclk";
+        clocks = <&clk 1>, <&clk 2>, <&clk 3>;
+        clock-names = "stmmaceth", "pclk", "apb";
         interrupts = <66>;
         interrupt-names = "macirq";
         phy-mode = "rgmii-id";
-- 
2.50.1


