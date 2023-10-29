Return-Path: <netdev+bounces-45037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 267517DAAAE
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 05:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88D37B20EA4
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 04:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CAF17F4;
	Sun, 29 Oct 2023 04:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IvJciyui"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBBE15A4;
	Sun, 29 Oct 2023 04:27:23 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10762CC;
	Sat, 28 Oct 2023 21:27:22 -0700 (PDT)
Received: from localhost (unknown [188.24.143.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id ABAB56607333;
	Sun, 29 Oct 2023 04:27:20 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1698553640;
	bh=PlB2C/4GvlsigVQBPsB7o3BhZ4Nod/EAPxHc0U5Br04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IvJciyuiLEiU0mjm3j5yU+9wBhoTihTYs0be1p8pK5cxDFlWmQguAHTD2J84d5A8a
	 37Diph3gwxxywFpXLbIng8xYQtWM2gHKEawZiMGZQPDaF2mbR3PRjpTGiU2i2sPsba
	 fq3dMmfbJkv11ahyXvyL/lc8Jqtki9KOiylNSjOhoP1q6PLl0o0wd0GKlY7eu1hsHw
	 aazZuCpabGuw7t4cjMv9sHOfiJI4djx1UtAhYOpaKfrPlWQ3T6mfZgOvO2Iqdp9iIk
	 4Sk9dansjJNzr4CTm+r0j4fjCCHsdgqwIEqBJyiBvXdJqWBDQ6gfnDb4hd9uMdeT27
	 FMS6lhywrubBg==
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Samin Guo <samin.guo@starfivetech.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v2 01/12] dt-bindings: net: snps,dwmac: Allow exclusive usage of ahb reset
Date: Sun, 29 Oct 2023 06:27:01 +0200
Message-ID: <20231029042712.520010-2-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
References: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Synopsys DesignWare MAC found on the StarFive JH7100 SoC requires
just the 'ahb' reset name, but the binding allows selecting it only in
conjunction with 'stmmaceth'.

Fix the issue by permitting exclusive usage of the 'ahb' reset name.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 5c2769dc689a..a4d7172ea701 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -146,7 +146,7 @@ properties:
   reset-names:
     minItems: 1
     items:
-      - const: stmmaceth
+      - enum: [stmmaceth, ahb]
       - const: ahb
 
   power-domains:
-- 
2.42.0


