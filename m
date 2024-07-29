Return-Path: <netdev+bounces-113602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C350A93F425
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 13:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA5561C212B2
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 11:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8A21474A6;
	Mon, 29 Jul 2024 11:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="P+t067lk"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E9A1465AC;
	Mon, 29 Jul 2024 11:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252780; cv=none; b=YZw5rzna/O5cBJGgAyExERRWiVDvEojRBqUO6JcCF6MDg2++CL385iIc0LZESpPmF1fNWs+IDB7Cylof/NAORn6bb3C5pL1vKeQKVJ4QlYY12yYYZohhesqnnqADRLN1gz+WYmSTazTLIra1vQyakwpCk77yCKqLtm5gr5fySKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252780; c=relaxed/simple;
	bh=C/eJ2oldCk7CM6mmg1mVPEzlNezqURJcD7otGNJc+Yk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bojqaCCZQeiOkzhV8m3cV30mE+F67As8AlGyT8anNE6jq4zY5lSxaHnaY79FpgNRTi86/b0PAwXxZsypmxqSHeMqdwTFzG0u7yhFajuqXwP8eZm1DO5KtAORukPT298ceegZfrNr9qHh6qfQJIeZt0hG1uTdu92wEGyGkCkgD1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=P+t067lk; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46TBWWcw074654;
	Mon, 29 Jul 2024 06:32:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722252752;
	bh=3tH31x9G6ABuIo6tdJFVlBKDn1OeVXxNSanUJ9qJ7BI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=P+t067lkvuxA/1IFwL0itGNVKUZ6Mah+T1Sgde6W+nO/+9h8P2k2J9bLADZn6d4Mz
	 je1F9fPqWZH9IF14ENaxacoxSeYLB5sutirWlqovy1T5H6K2P+1P3feVwsRCJnSjua
	 B00L/GLMe+jxO6imA4popnSXDweSK5WEpRsJE5GY=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46TBWWvj008043
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jul 2024 06:32:32 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jul 2024 06:32:32 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jul 2024 06:32:31 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46TBWVIQ012862;
	Mon, 29 Jul 2024 06:32:31 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 46TBWVQr013177;
	Mon, 29 Jul 2024 06:32:31 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Suman Anna <s-anna@ti.com>, Sai Krishna <saikrishnag@marvell.com>,
        Jan
 Kiszka <jan.kiszka@siemens.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Diogo Ivo <diogo.ivo@siemens.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Kory Maincent <kory.maincent@bootlin.com>,
        Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Santosh
 Shilimkar <ssantosh@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Roger
 Quadros <rogerq@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>, Tero
 Kristo <kristo@kernel.org>,
        <srk@ti.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/6] dt-bindings: soc: ti: pruss: Add documentation for PA_STATS support
Date: Mon, 29 Jul 2024 17:02:21 +0530
Message-ID: <20240729113226.2905928-2-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729113226.2905928-1-danishanwar@ti.com>
References: <20240729113226.2905928-1-danishanwar@ti.com>
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


