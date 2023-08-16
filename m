Return-Path: <netdev+bounces-28139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6819077E574
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 17:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97ECD1C21122
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 15:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F3A168A5;
	Wed, 16 Aug 2023 15:41:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148A2171A8
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 15:41:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E34BC433C8;
	Wed, 16 Aug 2023 15:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692200506;
	bh=d0jes+KrJeiWl6LJI3nrjoLh3/r6+H9lE5veVs3+NN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KEEdMxD0b9PLscPEqG8w/hUc7DEM9kbhfjd2v65dvGQMUN+FT6pldecS8L+DOR+4Z
	 ZzV1WITkzhou/COccdDVKQaO6FsfchN4yjW8OyK7ExzfS/gezDhNDxYDEBJMn1q7Ae
	 ksbxbvQUeu6h4UQSKIsYvRodgiXk/7OOBynz7rquDOboqsadS8+74KJsqnvPDBWuUx
	 ezNr+/AuEIl7IpxWAsMAWK/pgBb01lTBdpFCV4XibHAB2i9ybfqGEh/xKs62e5VKCd
	 dD8F/40VkeZ3xdz5OiYImXFWgQyIBwLKMEULzp03OXhsRAQcT8HuaOfqf8TkOhYYpO
	 13RDrc08fcksA==
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
Subject: [PATCH net-next v4 8/9] dt-bindings: net: snps,dwmac: add per channel irq support
Date: Wed, 16 Aug 2023 23:29:25 +0800
Message-Id: <20230816152926.4093-9-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230816152926.4093-1-jszhang@kernel.org>
References: <20230816152926.4093-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IP supports optional per channel interrupt, add support for this
usage case.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../devicetree/bindings/net/snps,dwmac.yaml   | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index b8d01bba6e1a..a916701474dc 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -103,15 +103,51 @@ properties:
 
   interrupts:
     minItems: 1
+    maxItems: 37
+    additionalItems: true
     items:
       - description: Combined signal for various interrupt events
       - description: The interrupt to manage the remote wake-up packet detection
       - description: The interrupt that occurs when Rx exits the LPI state
       - description: The interrupt that occurs when Safety Feature Correctible Errors happen
       - description: The interrupt that occurs when Safety Feature Uncorrectible Errors happen
+      - description: rx0 per-channel interrupt
+      - description: rx1 per-channel interrupt
+      - description: rx2 per-channel interrupt
+      - description: rx3 per-channel interrupt
+      - description: rx4 per-channel interrupt
+      - description: rx5 per-channel interrupt
+      - description: rx6 per-channel interrupt
+      - description: rx7 per-channel interrupt
+      - description: rx8 per-channel interrupt
+      - description: rx9 per-channel interrupt
+      - description: rx10 per-channel interrupt
+      - description: rx11 per-channel interrupt
+      - description: rx12 per-channel interrupt
+      - description: rx13 per-channel interrupt
+      - description: rx14 per-channel interrupt
+      - description: rx15 per-channel interrupt
+      - description: tx0 per-channel interrupt
+      - description: tx1 per-channel interrupt
+      - description: tx2 per-channel interrupt
+      - description: tx3 per-channel interrupt
+      - description: tx4 per-channel interrupt
+      - description: tx5 per-channel interrupt
+      - description: tx6 per-channel interrupt
+      - description: tx7 per-channel interrupt
+      - description: tx8 per-channel interrupt
+      - description: tx9 per-channel interrupt
+      - description: tx10 per-channel interrupt
+      - description: tx11 per-channel interrupt
+      - description: tx12 per-channel interrupt
+      - description: tx13 per-channel interrupt
+      - description: tx14 per-channel interrupt
+      - description: tx15 per-channel interrupt
 
   interrupt-names:
     minItems: 1
+    maxItems: 37
+    additionalItems: true
     items:
       - const: macirq
       - enum:
@@ -119,6 +155,38 @@ properties:
           - eth_lpi
           - sfty_ce
           - sfty_ue
+          - rx0
+          - rx1
+          - rx2
+          - rx3
+          - rx4
+          - rx5
+          - rx6
+          - rx7
+          - rx8
+          - rx9
+          - rx10
+          - rx11
+          - rx12
+          - rx13
+          - rx14
+          - rx15
+          - tx0
+          - tx1
+          - tx2
+          - tx3
+          - tx4
+          - tx5
+          - tx6
+          - tx7
+          - tx8
+          - tx9
+          - tx10
+          - tx11
+          - tx12
+          - tx13
+          - tx14
+          - tx15
 
   clocks:
     minItems: 1
-- 
2.40.1


