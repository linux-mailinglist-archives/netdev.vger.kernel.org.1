Return-Path: <netdev+bounces-20198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A21375E3C5
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 18:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E281C20A06
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 16:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA72E53BA;
	Sun, 23 Jul 2023 16:22:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9776A539F
	for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 16:22:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF1BC433C8;
	Sun, 23 Jul 2023 16:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690129362;
	bh=77r49RSSQhAozO3HusyMgOJivNEdF2Oycm6v24MDK60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LbJaNcSBqDv3TqTL9DOpOFtVQAvmOZDNAcpGCIvWPiAC2ss+7LaTuU60MqlD3oTgS
	 9zdjwsNlMnz6VUppT+/I9iJyH5BjziWnzaae2/gm//cQwmkfhqPnjGNY7KcPEq2+ZS
	 rgWhVRJaUs/QPnBKydu23WlOGcwokmagkMVqM/4YxcDEXm1irn67kRre/lpUYbbLSk
	 tSJxCz/v6imyZGVT0Hn2/ZJYVroskvzK3TxOwHQT7M8l/+t1+OW/hdKSeDmDRpgby0
	 9HcL5rXrCzFT7VhH8g3m9QOQco33FQC+fw+ReDl5VuxORDQg2D3IIj1REb9QY6L4v5
	 SnGealjZlXjLQ==
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
Subject: [PATCH net-next 09/10] dt-bindings: net: snps,dwmac: add per channel irq support
Date: Mon, 24 Jul 2023 00:10:28 +0800
Message-Id: <20230723161029.1345-10-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230723161029.1345-1-jszhang@kernel.org>
References: <20230723161029.1345-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IP supports per channel interrupt, add support for this usage case.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../devicetree/bindings/net/snps,dwmac.yaml   | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index bb80ca205d26..525210c2c06c 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -101,6 +101,11 @@ properties:
     minItems: 1
     maxItems: 2
 
+  snps,per-channel-interrupt:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Indicates that Rx and Tx complete will generate a unique interrupt for each channel
+
   interrupts:
     minItems: 1
     items:
@@ -109,6 +114,8 @@ properties:
       - description: The interrupt that occurs when Rx exits the LPI state
       - description: The interrupt that occurs when Safety Feature Correctible Errors happen
       - description: The interrupt that occurs when Safety Feature Uncorrectible Errors happen
+      - description: All of the rx per-channel interrupts
+      - description: All of the tx per-channel interrupts
 
   interrupt-names:
     minItems: 1
@@ -118,6 +125,22 @@ properties:
       - const: eth_lpi
       - const: sfty_ce_irq
       - const: sfty_ue_irq
+      - const: rx0
+      - const: rx1
+      - const: rx2
+      - const: rx3
+      - const: rx4
+      - const: rx5
+      - const: rx6
+      - const: rx7
+      - const: tx0
+      - const: tx1
+      - const: tx2
+      - const: tx3
+      - const: tx4
+      - const: tx5
+      - const: tx6
+      - const: tx7
 
   clocks:
     minItems: 1
-- 
2.40.1


