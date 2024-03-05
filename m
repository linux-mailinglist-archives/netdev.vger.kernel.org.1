Return-Path: <netdev+bounces-77477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1542871E4A
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 12:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41F781F2479F
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 11:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77D658205;
	Tue,  5 Mar 2024 11:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="e8GAVCdw"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D3B55C36
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 11:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709639518; cv=none; b=gDpc5lDUcv8xsqCHKEv5hnd0GPZiubNxmzD9m/0z/qqU5N6u8anPhPH676noP3yVIZ6OuNhVEfOkyz4hVNWfWrbUDb++GakBnvyDEtjMWkKaKYu7iTcU2ojnH+Mlkxc8OX/vwofevsGDz4XOq58ofvGYBkbv2DUpyM2hIC9FH0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709639518; c=relaxed/simple;
	bh=w+qzEi3tGJ4wUs3/f9Q0l8pBKHLjHgoevNLucjr/5L0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pqnMqE6/BFUsI5Vp4WpQ1yqen+RQiBCSstwgLKRSDpULQngnORex4/1GqzFkCjhK+pzg+ySsZuEdKCYXfF8vgjqMdb4/4DQa6KnNzJPPBdRsR6NgkQa0u46vMTV0IdZlhAdF2rawoa2UQQaRSEmLYWus12KOSuE7BR8fc3Mtd3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=e8GAVCdw; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240305114056d048d08249ddc1d9ad
        for <netdev@vger.kernel.org>;
        Tue, 05 Mar 2024 12:40:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=s8rrvI6waU1Tgjb2+GhfN3vx2WZQaQ/whDjR4cpwRzs=;
 b=e8GAVCdw/ITDBykw0QYwvRmVzwdb7WNZhLYSk2vPkRJ2tGmsUh1ShMxKLH2Ye4f+c+r+4y
 cD8trsripXuBDSUn6J21Z1nsnL07D5un9VNyXlcIHqnQh8nKuKWwkxfp2nh7KUOyfEfi/q2e
 UM5iCn2t/o/nA1k5hpClQxQJp2XbM=;
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
	jan.kiszka@siemens.com,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH net-next v4 01/10] dt-bindings: net: Add support for AM65x SR1.0 in ICSSG
Date: Tue,  5 Mar 2024 11:40:21 +0000
Message-ID: <20240305114045.388893-2-diogo.ivo@siemens.com>
In-Reply-To: <20240305114045.388893-1-diogo.ivo@siemens.com>
References: <20240305114045.388893-1-diogo.ivo@siemens.com>
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
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
---
Changes in v4: 
 - Added Reviewed-by tags from Roger and Conor

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
2.44.0


