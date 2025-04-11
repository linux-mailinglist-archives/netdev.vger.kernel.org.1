Return-Path: <netdev+bounces-181504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC77A853F4
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 08:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC6D61B8492C
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 06:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6DD27D795;
	Fri, 11 Apr 2025 06:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NSli7jp8"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1920327CCD8;
	Fri, 11 Apr 2025 06:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744351792; cv=none; b=UxiTbzbrm3SS8uKJqtgEK4LzvoSrAfS2e6pQppQItuMOjcpWUqmXBXRTGJXF2XUp6KSbbIjH/IwQI94H23OMRx/6W3xmvE4s+dhF9uT9PHeeWerJQfnNXhRf+AJuGZCOIkoMwggHBjKDiLXvqNObI8bVq//jbsALTn8kbsWaK40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744351792; c=relaxed/simple;
	bh=tPZ9ttEK046cXLZ9x7c334vYEzxMwI54L3UmfAss6+c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JIWEc5UeNoAJ56ZE+lWHDOCSr94uO+hencAQC8FAYM3oBEzAFSZtQbpooPEwCOCHD1DKCVp0Fq1pX3Bnp3+/PpHckDIUn/GrofJ5iIuYPmdYJxsgH02fREkQpUKftDDdt+hqc9jTiOGvg2syQJkjP+d7S2k70l5KDpJQctKbUPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NSli7jp8; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53B69bAd1355131
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 01:09:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744351777;
	bh=MSI8g2E+3aZMUl1QytJTkS1NIcn9yp4GO6VxdLpZRyE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=NSli7jp8osTp2WkdIItNAR/y5jAXdS6xS0dzFANf0CdIPcRnbz3X1aV7k0PyeQpJQ
	 N3k0+lMLil8Twcwc1yJFOI65pvUL6bWKU1yaQDxEFLbDAyI3deqA97quVyENSkr2is
	 PVniLKp3ls9G8L0saa50BXA1ChV5LV/1to4Wp0oI=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53B69bUd015096
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Apr 2025 01:09:37 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Apr 2025 01:09:27 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Apr 2025 01:09:26 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53B69IA0065579;
	Fri, 11 Apr 2025 01:09:23 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <rogerq@kernel.org>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH net-next 1/2] dt-bindings: net: ethernet-controller: add 5000M speed to fixed-link
Date: Fri, 11 Apr 2025 11:39:16 +0530
Message-ID: <20250411060917.633769-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250411060917.633769-1-s-vadapalli@ti.com>
References: <20250411060917.633769-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

A link speed of 5000 Mbps is a valid speed for a fixed-link mode of
operation. Hence, update the bindings to include the same.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 Documentation/devicetree/bindings/net/ethernet-controller.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index 45819b235800..61e51ea58a98 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -197,7 +197,7 @@ properties:
             description:
               Link speed.
             $ref: /schemas/types.yaml#/definitions/uint32
-            enum: [10, 100, 1000, 2500, 10000]
+            enum: [10, 100, 1000, 2500, 5000, 10000]
 
           full-duplex:
             $ref: /schemas/types.yaml#/definitions/flag
-- 
2.34.1


