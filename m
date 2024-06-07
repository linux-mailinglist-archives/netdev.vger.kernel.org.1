Return-Path: <netdev+bounces-101760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EEE900000
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 12:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D3371F214EA
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 10:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E8415B96C;
	Fri,  7 Jun 2024 09:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="AxAUXL9U"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D1D157A76;
	Fri,  7 Jun 2024 09:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717754382; cv=none; b=XzDAOCPQFujclX7Cdaesu2ctqMDzmHSL52bSTnhEWGWiDJ+36+gxI+ohOIJCoWrORWEz4uCInN/5/LHXJb3c58LnJPLITaL9Xmy4krc474Bjjxmixqe9FCAyed4tInyD/zmPNeQGxcb7ge0pCjVjJ8V7N6NBQD87DuQnAwFgtyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717754382; c=relaxed/simple;
	bh=ELHG6KXsCPxpq8rAjFOjUunqXofuwXSI9tyRIUTmPAc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AT8fKew9PbhCihNyUk0LiE3yFOUd9h9WzoMqPCvzbuE8NRI2f3SM/eejOrn31Lo9M86dgc6ZAfuv3k3ojFWHUcfEJEr7vxtLihmj6NMID//b7h/gG7mBmUq0b1cTDlWSvNpYpLb0+aYCZxoStjHwwZ2EREbrphwnSjHWC5OCZwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=AxAUXL9U; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45792a2M010983;
	Fri, 7 Jun 2024 11:59:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	MATnV0OWqMTL3XMj64kWzJNas3kxCFy5hM5TuSEEvLY=; b=AxAUXL9UMNVMZZB+
	iFEeVMIzu/Hz5WW0knPgOIhSmwGtHo7HUavf+tCtVv8jrtSBjN1t2OYOOF+Yhtbl
	r9ZMXtKx3xhdSLS+qdcMaIlb8HTi3X1QgvMCygXscbSybOXVqBpUhPa2PCH/JZSV
	T0G8gP7vPIw8RBOvw6Zm+VZj0DJ/iu1TqaY0LvSb4alf50w601I4XmwwmNjqr/je
	ZthMKFSt7lUl16jjNM+KzudH2NnNMto3GwBntJ8tklQb8qgG/oUlHQ8GIyHEn4lt
	hFvEWLGh+cpehww/+0SXDI/GsIYJ7m+DfEGKirT8VYUd/tBWji1VNL+afUTjicEk
	1zat/g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ykbv54d4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 11:59:18 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 949234004B;
	Fri,  7 Jun 2024 11:59:14 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A1417214D13;
	Fri,  7 Jun 2024 11:58:00 +0200 (CEST)
Received: from localhost (10.252.19.205) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 7 Jun
 2024 11:58:00 +0200
From: Christophe Roullier <christophe.roullier@foss.st.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark
 Brown <broonie@kernel.org>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>,
        Marek Vasut <marex@denx.de>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 01/12] dt-bindings: net: add STM32MP13 compatible in documentation for stm32
Date: Fri, 7 Jun 2024 11:57:43 +0200
Message-ID: <20240607095754.265105-2-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240607095754.265105-1-christophe.roullier@foss.st.com>
References: <20240607095754.265105-1-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_04,2024-06-06_02,2024-05-17_01

New STM32 SOC have 2 GMACs instances.
GMAC IP version is SNPS 4.20.

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 .../devicetree/bindings/net/stm32-dwmac.yaml  | 43 ++++++++++++++++---
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
index 7ccf75676b6d5..f6e5e0626a3fb 100644
--- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
@@ -22,18 +22,17 @@ select:
         enum:
           - st,stm32-dwmac
           - st,stm32mp1-dwmac
+          - st,stm32mp13-dwmac
   required:
     - compatible
 
-allOf:
-  - $ref: snps,dwmac.yaml#
-
 properties:
   compatible:
     oneOf:
       - items:
           - enum:
               - st,stm32mp1-dwmac
+              - st,stm32mp13-dwmac
           - const: snps,dwmac-4.20a
       - items:
           - enum:
@@ -75,12 +74,15 @@ properties:
   st,syscon:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     items:
-      - items:
+      - minItems: 2
+        items:
           - description: phandle to the syscon node which encompases the glue register
           - description: offset of the control register
+          - description: field to set mask in register
     description:
       Should be phandle/offset pair. The phandle to the syscon node which
-      encompases the glue register, and the offset of the control register
+      encompases the glue register, the offset of the control register and
+      the mask to set bitfield in control register
 
   st,ext-phyclk:
     description:
@@ -112,12 +114,39 @@ required:
 
 unevaluatedProperties: false
 
+allOf:
+  - $ref: snps,dwmac.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - st,stm32mp1-dwmac
+              - st,stm32-dwmac
+    then:
+      properties:
+        st,syscon:
+          items:
+            minItems: 2
+            maxItems: 2
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - st,stm32mp13-dwmac
+    then:
+      properties:
+        st,syscon:
+          items:
+            minItems: 3
+            maxItems: 3
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/clock/stm32mp1-clks.h>
-    #include <dt-bindings/reset/stm32mp1-resets.h>
-    #include <dt-bindings/mfd/stm32h7-rcc.h>
     //Example 1
      ethernet0: ethernet@5800a000 {
            compatible = "st,stm32mp1-dwmac", "snps,dwmac-4.20a";
-- 
2.25.1


