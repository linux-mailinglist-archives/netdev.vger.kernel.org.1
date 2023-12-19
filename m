Return-Path: <netdev+bounces-59011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E36F8818F13
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 19:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83EA7B26071
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 18:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D5E37D0A;
	Tue, 19 Dec 2023 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="mP2xFYS4"
X-Original-To: netdev@vger.kernel.org
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA7839AC6
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2023121917462232d2e1ed1ce88d6229
        for <netdev@vger.kernel.org>;
        Tue, 19 Dec 2023 18:46:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=EgzouJIT0KIXhxDGv0tk0mkflLl02JFnyKbajnTvuVc=;
 b=mP2xFYS4fsAKBdLFHKzvJBeyDnzPKBSBoMiiei9+tfcV8raRTnMG5ZtGTMjT3xsMDx44s6
 Jc+aHgmkJLlffNaKsTBGshmXa6tt8AAhSFs7yodtiZ9Rk3dMRCLib6n1RU1cJHnUXq9aoLoX
 46n3/02hk5Vh9aFlPBoGIUh5TwP8M=;
From: Diogo Ivo <diogo.ivo@siemens.com>
To: danishanwar@ti.com,
	rogerq@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Diogo Ivo <diogo.ivo@siemens.com>,
	Jan Kiszka <jan.kiszka@siemens.com>
Subject: [RFC PATCH net-next 1/8] dt-bindings: net: Add support for AM65x SR1.0 in ICSSG
Date: Tue, 19 Dec 2023 17:45:39 +0000
Message-ID: <20231219174548.3481-2-diogo.ivo@siemens.com>
In-Reply-To: <20231219174548.3481-1-diogo.ivo@siemens.com>
References: <20231219174548.3481-1-diogo.ivo@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

Silicon Revision 1.0 of the AM65x came with a slightly different ICSSG
support: Only 2 PRUs per slice are available and instead 2 additional
DMA channels are used for management purposes. We have no restrictions
on specified PRUs, but the DMA channels need to be adjusted.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
---
 .../bindings/net/ti,icssg-prueth.yaml         | 62 +++++++++++++------
 1 file changed, 44 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
index 229c8f32019f..fbe51731854a 100644
--- a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
+++ b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
@@ -19,30 +19,15 @@ allOf:
 properties:
   compatible:
     enum:
-      - ti,am642-icssg-prueth  # for AM64x SoC family
-      - ti,am654-icssg-prueth  # for AM65x SoC family
+      - ti,am642-icssg-prueth      # for AM64x SoC family
+      - ti,am654-icssg-prueth      # for AM65x SoC family, SR2.x
+      - ti,am654-icssg-prueth-sr1  # for AM65x SoC family, SR1.0
 
   sram:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
       phandle to MSMC SRAM node
 
-  dmas:
-    maxItems: 10
-
-  dma-names:
-    items:
-      - const: tx0-0
-      - const: tx0-1
-      - const: tx0-2
-      - const: tx0-3
-      - const: tx1-0
-      - const: tx1-1
-      - const: tx1-2
-      - const: tx1-3
-      - const: rx0
-      - const: rx1
-
   ti,mii-g-rt:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
@@ -122,6 +107,47 @@ properties:
       - required:
           - port@1
 
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - ti,am654-icssg-prueth-sr1
+then:
+  properties:
+    dmas:
+      maxItems: 12
+    dma-names:
+      items:
+        - const: tx0-0
+        - const: tx0-1
+        - const: tx0-2
+        - const: tx0-3
+        - const: tx1-0
+        - const: tx1-1
+        - const: tx1-2
+        - const: tx1-3
+        - const: rx0
+        - const: rx1
+        - const: rxmgm0
+        - const: rxmgm1
+else:
+  properties:
+    dmas:
+      maxItems: 10
+    dma-names:
+      items:
+        - const: tx0-0
+        - const: tx0-1
+        - const: tx0-2
+        - const: tx0-3
+        - const: tx1-0
+        - const: tx1-1
+        - const: tx1-2
+        - const: tx1-3
+        - const: rx0
+        - const: rx1
+
 required:
   - compatible
   - sram
-- 
2.43.0


