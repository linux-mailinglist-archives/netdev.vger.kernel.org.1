Return-Path: <netdev+bounces-28548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 557D277FCBF
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 19:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85A3C1C21497
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 17:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D9B174C5;
	Thu, 17 Aug 2023 17:09:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F50C14F65
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 17:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2026DC433C8;
	Thu, 17 Aug 2023 17:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692292192;
	bh=aRyV6xNSnXzwR4k61lnQ+ZQcy3oDuCpZ9xSwfK+jJGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MXMO8lhnQylzgU03Kg2syfvcIqhkAKyMBJjNJJKg+Fkmvz6kLvT2YV1raUGLF1LM3
	 sZLun519nVvQF43RtwIpvoGSWB1wRTTVyUfnSfp9u4t+uUmA1AcjVrm9pQ3hRGymBx
	 bkPgxdHuiyhTMMaYqxPXZIqQ+sbxE7I0Z6JZlUpyBzeXkjnBLG6pisBaRyWydMIBQt
	 tvG3d5Q2Q3rmjQfIYoex/ARMrtWSE5y6BGUs+hQULZv6O5WoIc37MwOKmgP1vLHI9Y
	 64Ncu6uyvd5vhmL2l3hdA7soXhpFkppM3YuAn5FSV0wr13ZAnMdsAwWciqvf6XQ+uq
	 CPAcCxyy75LEg==
From: Jisheng Zhang <jszhang@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v5 6/9] dt-bindings: net: snps,dwmac: add safety irq support
Date: Fri, 18 Aug 2023 00:57:46 +0800
Message-Id: <20230817165749.672-7-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230817165749.672-1-jszhang@kernel.org>
References: <20230817165749.672-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The snps dwmac IP support safety features, and those Safety Feature
Correctible Error and Uncorrectible Error irqs may be separate irqs.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../devicetree/bindings/net/snps,dwmac.yaml         | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index ddf9522a5dc2..ee9174f77d97 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -103,17 +103,26 @@ properties:
 
   interrupts:
     minItems: 1
+    maxItems: 5
+    additionalItems: true
     items:
       - description: Combined signal for various interrupt events
       - description: The interrupt to manage the remote wake-up packet detection
       - description: The interrupt that occurs when Rx exits the LPI state
+      - description: The interrupt that occurs when Safety Feature Correctible Errors happen
+      - description: The interrupt that occurs when Safety Feature Uncorrectible Errors happen
 
   interrupt-names:
     minItems: 1
+    maxItems: 5
+    additionalItems: true
     items:
       - const: macirq
-      - enum: [eth_wake_irq, eth_lpi]
-      - const: eth_lpi
+      - enum:
+          - eth_wake_irq
+          - eth_lpi
+          - sfty_ce
+          - sfty_ue
 
   clocks:
     minItems: 1
-- 
2.40.1


