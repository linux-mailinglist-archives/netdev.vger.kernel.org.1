Return-Path: <netdev+bounces-28137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2300877E572
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 17:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EB39281B5B
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 15:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C970C16400;
	Wed, 16 Aug 2023 15:41:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9489168A5
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 15:41:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3590C433C9;
	Wed, 16 Aug 2023 15:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692200498;
	bh=W7ECQIQKfvKMVwcR9VbSxLGQ7/jrBCtA74xsM15z9nY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=us4YEJrIjLgKQxbwGjwCLfE6bE3pafzZjx4+B1IVzGtfxbATVImmtgqswUEx7AX0s
	 nBevXHzge5vCXJOGA2h/yJR7uiWdyIxu1iiqE0OA04Dfm29ViYnQcnFMYOTEVCkw5h
	 4iERHf0xu2KiQGHt6LCFqt5ngziHzveSCCCNIjmKYA0cLmWf+UTxoY0uhj2ObRYLZ0
	 PK2KYD426Fczi8sfmCgrTZ0kTvoua4ijGULP5KMQHI57jJP4FsEqCsEvwtdkl/Pm3f
	 IQ+FIn8cJuYd6MC3DRtQnbye3Blvp/dE7PsloZ/xSgDj0rqRRfjXoeoLvGgr3mOWLJ
	 MboC8CXUc7GJg==
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
Subject: [PATCH net-next v4 6/9] dt-bindings: net: snps,dwmac: add safety irq support
Date: Wed, 16 Aug 2023 23:29:23 +0800
Message-Id: <20230816152926.4093-7-jszhang@kernel.org>
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

The snps dwmac IP support safety features, and those Safety Feature
Correctible Error and Uncorrectible Error irqs may be separate irqs.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index ddf9522a5dc2..b8d01bba6e1a 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -107,13 +107,18 @@ properties:
       - description: Combined signal for various interrupt events
       - description: The interrupt to manage the remote wake-up packet detection
       - description: The interrupt that occurs when Rx exits the LPI state
+      - description: The interrupt that occurs when Safety Feature Correctible Errors happen
+      - description: The interrupt that occurs when Safety Feature Uncorrectible Errors happen
 
   interrupt-names:
     minItems: 1
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


