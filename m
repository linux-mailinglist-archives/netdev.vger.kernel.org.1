Return-Path: <netdev+bounces-73735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9782A85E0F5
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 16:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85B3CB23A66
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 15:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF75F8062C;
	Wed, 21 Feb 2024 15:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="a0nv8lVA"
X-Original-To: netdev@vger.kernel.org
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61E180601
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 15:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529076; cv=none; b=Uvk+pkkdJhUcVle00vfm49CTxKOCOnxdd+o1AyG/1CImutQrYZW6N4aUKkas30Ihsqm78kwPWpY/K/qQ3BS5gb+7mgnvXQUOkpXsIBq2DeISLsMBTfp1yVLktliDfMCKK+eH7eUDYE5B4WStQYCVZMxSCHM+f0X+88Ipuc+9b6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529076; c=relaxed/simple;
	bh=04qyfxYq72gV8tXDwoZiQdRBzpTjtdo9yW9e6zoS4c8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=udVE5Pj78aEykuEsEQASfm+ZhA0+POFVw9MZUvOSObNtpixqN4WQouDCNr7soC5E1F59MXHBKiafXiL0jNj975BBMdg/1qgZIAHa5hEk0I1yLlgZ9swynhKtF4S03vg4DzZ+ntNvvIuMdRJt1I1IEMf5cxQVtIBe0P9LxAmBYBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=a0nv8lVA; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202402211524261aa742835af72755e5
        for <netdev@vger.kernel.org>;
        Wed, 21 Feb 2024 16:24:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=wb1XI1IwyIAM/Mh14P3Ympwak88zAuOvrjBWTv7l0xw=;
 b=a0nv8lVALkyNfJGca5Gu6SEnO5V7AGO7vFX+oOBdZMMKepB4c8IKbRZxPDmSsFfKCEWzkY
 78lqNLqS4tftJOdyQauwRld/fil9UfxlbI0FSE/nSduEheWbe5lbXS+Q5UT6rPREJ9AtJ4HK
 1XE7dHH7fBJ4dtMFiLmoTUQb8oCEg=;
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
	jan.kiszka@siemens.com
Subject: [PATCH net-next v3 01/10] dt-bindings: net: Add support for AM65x SR1.0 in ICSSG
Date: Wed, 21 Feb 2024 15:24:07 +0000
Message-ID: <20240221152421.112324-2-diogo.ivo@siemens.com>
In-Reply-To: <20240221152421.112324-1-diogo.ivo@siemens.com>
References: <20240221152421.112324-1-diogo.ivo@siemens.com>
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

Co-developed-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
---
Changes in v3:
 - Fixed dt_binding_check error by moving allOf

Changes in v2:
 - Removed explicit reference to SR2.0
 - Moved sr1 to the SoC name
 - Expand dma-names list and adjust min/maxItems depending on SR1.0/2.0
 .../bindings/net/ti,icssg-prueth.yaml         | 35 +++++++++++++++----
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
index 229c8f32019f..e253fa786092 100644
--- a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
+++ b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
@@ -13,14 +13,12 @@ description:
   Ethernet based on the Programmable Real-Time Unit and Industrial
   Communication Subsystem.
 
-allOf:
-  - $ref: /schemas/remoteproc/ti,pru-consumer.yaml#
-
 properties:
   compatible:
     enum:
-      - ti,am642-icssg-prueth  # for AM64x SoC family
-      - ti,am654-icssg-prueth  # for AM65x SoC family
+      - ti,am642-icssg-prueth      # for AM64x SoC family
+      - ti,am654-icssg-prueth      # for AM65x SoC family
+      - ti,am654-sr1-icssg-prueth  # for AM65x SoC family, SR1.0
 
   sram:
     $ref: /schemas/types.yaml#/definitions/phandle
@@ -28,9 +26,11 @@ properties:
       phandle to MSMC SRAM node
 
   dmas:
-    maxItems: 10
+    minItems: 10
+    maxItems: 12
 
   dma-names:
+    minItems: 10
     items:
       - const: tx0-0
       - const: tx0-1
@@ -42,6 +42,8 @@ properties:
       - const: tx1-3
       - const: rx0
       - const: rx1
+      - const: rxmgm0
+      - const: rxmgm1
 
   ti,mii-g-rt:
     $ref: /schemas/types.yaml#/definitions/phandle
@@ -132,6 +134,27 @@ required:
   - interrupts
   - interrupt-names
 
+allOf:
+  - $ref: /schemas/remoteproc/ti,pru-consumer.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,am654-sr1-icssg-prueth
+    then:
+      properties:
+        dmas:
+          minItems: 12
+        dma-names:
+          minItems: 12
+    else:
+      properties:
+        dmas:
+          maxItems: 10
+        dma-names:
+          maxItems: 10
+
 unevaluatedProperties: false
 
 examples:
-- 
2.43.2


