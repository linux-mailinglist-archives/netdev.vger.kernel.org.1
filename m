Return-Path: <netdev+bounces-210761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 696B0B14B6B
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 11:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7696E1AA451C
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 09:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBE62877FC;
	Tue, 29 Jul 2025 09:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="YXLWxqz/"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9D3285C83;
	Tue, 29 Jul 2025 09:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753781892; cv=none; b=dqfNRYiUX9Xy0nC6EUCQyI0j2pRCGWfQE89PuptL58P6Dmr6/dV6TbqzI+/y+7MH9M2Wu6vwvvPPbKiEm2Q/fz1yHvG/1dniokfQNdEt0C6QpaL1mZQ38PeMYDU2+YMR+n1t4ysFuM3lx91kN7LSTvr4OyGhfxCyefnQByilZzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753781892; c=relaxed/simple;
	bh=KckubxbZ+pvtLSm9LYRkKrPsFoinp6cu370w3zIGmtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RbDvLvUoQ0NMZQYfkP7J3e9SXYa6Muc//ia0HuoVIJ6aoo9+eIBnA1L3JER7R1M92d6+vQEEcIZIzjkKrBVVTaS9lDTBp6sJKbmfNkJQcASJWGyzjGRjbInC6RYbAtUT8vkjDJrVrLlmuHGQHz4DVIn1T35WOyYpBe6Re3CaeU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=YXLWxqz/; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 0EF442047B;
	Tue, 29 Jul 2025 11:38:09 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id msMHQLLUizam; Tue, 29 Jul 2025 11:38:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1753781888; bh=KckubxbZ+pvtLSm9LYRkKrPsFoinp6cu370w3zIGmtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YXLWxqz/tf0VbrkuyE6TpM6Wc6BNMKRNLm//4y/sVJGdvwV4giddqf94ptF4lG07a
	 yVCMtn86CcTdR06cI3HgX1u5w4uNHWW8SErTcEymAhRkb18KLGD8/HB2Pt4yVCB/aW
	 40hWtan3L5szusC0X8X1TFYzgtFT9vnee6UvE7vzMqqi02sGMh4dN+ye0OyP3YlZb+
	 3jhBFgFHXq7lbtRhveJY2Qrnms/odgyc57B4FjrbfPNd8yBKUQ9wrtPJSIll5P3AA4
	 l9ykh3o7FozLnzmFNRitHCmCjdq0xW9USV3ssvre2Ri8nE7c7Qa+699SdYUJUuDKL9
	 bA0uNDHwjwTDA==
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
Subject: [PATCH net 1/3] dt-bindings: net: thead,th1520-gmac: Describe APB interface clock
Date: Tue, 29 Jul 2025 09:37:32 +0000
Message-ID: <20250729093734.40132-2-ziyao@disroot.org>
In-Reply-To: <20250729093734.40132-1-ziyao@disroot.org>
References: <20250729093734.40132-1-ziyao@disroot.org>
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

Though the clock is essential for operation, it's not marked as required
for now to avoid introducing new dt-binding warnings to existing dts.

Fixes: f920ce04c399 ("dt-bindings: net: Add T-HEAD dwmac support")
Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 .../devicetree/bindings/net/thead,th1520-gmac.yaml        | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml b/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
index 6d9de3303762..fea9fbc1d006 100644
--- a/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
+++ b/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
@@ -59,14 +59,18 @@ properties:
       - const: apb
 
   clocks:
+    minItems: 2
     items:
       - description: GMAC main clock
       - description: Peripheral registers interface clock
+      - description: APB glue registers interface clock
 
   clock-names:
+    minItems: 2
     items:
       - const: stmmaceth
       - const: pclk
+      - const: apb
 
   interrupts:
     items:
@@ -88,8 +92,8 @@ examples:
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


