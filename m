Return-Path: <netdev+bounces-120970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E35595B4F5
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 14:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF3432888D3
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 12:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782841C9440;
	Thu, 22 Aug 2024 12:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="g72F0C8u"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1D526AF6;
	Thu, 22 Aug 2024 12:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724329638; cv=none; b=Frq6R4JnLPGzFjjyvvkgujVGo38v9EoXbVG6oFzmZN8vQ2+rBotutERpjW7LeO571XEcxaCcrHZedgUbM6HiAmVKtiuoruBTVV69avqWqpLE5vy9ppnyYLqu+DNxuik9gvPn8LzP245X8ck1aa9zNZztaFjARb55nGT4a3T44jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724329638; c=relaxed/simple;
	bh=pJGnsT4ufnxgXvyLI0saJ9chPgFEl6t9tiaz69KnKtQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f3UPb/OrP85ALNZhoSxqXUOekLn7DdREURYQcZIJEGjUqbX3M7JsdGFY/XUcBEqvLXdwuUzwgQwSSqlsxjFUSHgmH94JrP3dpK46tRGlfwZqVDwYGDxRXy6+K9XKAuiQvVSmAy0g4q3dfCurlv1p7LjH8GxvQa0NBt47ZBnOBew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=g72F0C8u; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47MCQweW065247;
	Thu, 22 Aug 2024 07:26:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724329618;
	bh=UGgTkP4g4FkuQwGSKHwfGnZt/g9Kkt4wXiZ5i7hESo0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=g72F0C8u+BD0PKzwG+4tHUGuDv5/eD3G562XaQ5SxSy/nVLfYDFwwx2qOHW9Nom5G
	 cwcCqg8x/GrJAUvGFByutOiSjgzhLiQOqu9KcC+tY3cZ63eKWbO9QzYAgVeioPElmn
	 NV9WMgCf3f4/oHnG1fc5qSAbUL3qyH2nHDKhxENU=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47MCQwVU037068
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Aug 2024 07:26:58 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Aug 2024 07:26:58 -0500
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Aug 2024 07:26:57 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47MCQvMl113293;
	Thu, 22 Aug 2024 07:26:57 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 47MCQv9q015176;
	Thu, 22 Aug 2024 07:26:57 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Suman Anna <s-anna@ti.com>, Sai Krishna <saikrishnag@marvell.com>,
        Jan
 Kiszka <jan.kiszka@siemens.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Diogo Ivo <diogo.ivo@siemens.com>,
        Kory Maincent <kory.maincent@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Roger
 Quadros <rogerq@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob
 Herring <robh@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>, Nishanth
 Menon <nm@ti.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next v7 1/2] dt-bindings: soc: ti: pruss: Add documentation for PA_STATS support
Date: Thu, 22 Aug 2024 17:56:51 +0530
Message-ID: <20240822122652.1071801-2-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822122652.1071801-1-danishanwar@ti.com>
References: <20240822122652.1071801-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add documentation for pa-stats node which is syscon regmap for
PA_STATS registers. This will be used to dump statistics maintained by
ICSSG firmware.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
Acked-by: Nishanth Menon <nm@ti.com>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 .../devicetree/bindings/soc/ti/ti,pruss.yaml  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
index c402cb2928e8..3cb1471cc6b6 100644
--- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
+++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
@@ -278,6 +278,26 @@ patternProperties:
 
     additionalProperties: false
 
+  ^pa-stats@[a-f0-9]+$:
+    description: |
+      PA-STATS sub-module represented as a SysCon. PA_STATS is a set of
+      registers where different statistics related to ICSSG, are dumped by
+      ICSSG firmware. This syscon sub-module will help the device to
+      access/read/write those statistics.
+
+    type: object
+
+    additionalProperties: false
+
+    properties:
+      compatible:
+        items:
+          - const: ti,pruss-pa-st
+          - const: syscon
+
+      reg:
+        maxItems: 1
+
   interrupt-controller@[a-f0-9]+$:
     description: |
       PRUSS INTC Node. Each PRUSS has a single interrupt controller instance
-- 
2.34.1


