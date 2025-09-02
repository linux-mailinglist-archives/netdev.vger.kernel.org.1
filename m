Return-Path: <netdev+bounces-219068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EBDB3F9C0
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 11:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F5F1164A82
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 09:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557222EA738;
	Tue,  2 Sep 2025 09:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ycTw6eUy"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D26F2E9EC1;
	Tue,  2 Sep 2025 09:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756804125; cv=none; b=UZ+0kTWq6nhqNwnYS3Gu/06LXxTSkzsUlmwvl6W27WQyulexxcbX7n7ZXSvG1VA99aeVaQGWfcdkU+2cqD+mNREIN80i4b48SuPz7QVEaA3BESJmFAlBthAPMbOoFfOwOHCBYmsDQGAuMLNmHXFhdREndD28aCfggTTBvAb1y7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756804125; c=relaxed/simple;
	bh=kyQFTx98tC24dTOZYa1lY1ArgSMKDfbMRwXbfxfRlMA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fh8ELhxm9Chc921bTBZp0Yv0kI1Gkd3+ny6HF1hD0BgUfvB8QR7wB69UffCe4AfovxScEzzAly/QFHaXDj8Xn120+Z9IftMt3JO3D02C/XvmbUuHdqSaZNg1V+MSulq++PMwKN9UBYbTe3rj/IxRX37vfuYPjI8XPRxh+sCWVHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ycTw6eUy; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58297rtT2987826;
	Tue, 2 Sep 2025 04:07:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756804073;
	bh=OxLiY9VXwmW64brotYTwmn0HZmpUyP4jQLvqjXxfH1s=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ycTw6eUyDwd9cRZQkw8mSlrcUh76XL7nT5H29Uznigoe+EA3bxRLnYvvm12jaM3o7
	 1JJSzJTnpcBgoKfAbeEeviSaqrIfuD+KcsC7vqSDrGisfUdWTQ/rEHjxkOim1phG8j
	 mbLoMHlbA2n2Fv0zbIuq0wbCfTHoXOCFNjqpsLGU=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58297rbQ2729543
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 2 Sep 2025 04:07:53 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 2
 Sep 2025 04:07:51 -0500
Received: from fllvem-mr08.itg.ti.com (10.64.41.88) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 2 Sep 2025 04:07:51 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvem-mr08.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58297p561001497;
	Tue, 2 Sep 2025 04:07:51 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 58297ofC020820;
	Tue, 2 Sep 2025 04:07:51 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu
 Poirier <mathieu.poirier@linaro.org>,
        Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Nishanth Menon <nm@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>,
        Mengyuan Lou <mengyuanlou@net-swift.com>,
        MD
 Danish Anwar <danishanwar@ti.com>, Xin Guo <guoxin09@huawei.com>,
        Lei Wei
	<quic_leiwei@quicinc.com>, Lee Trager <lee@trager.us>,
        Michael Ellerman
	<mpe@ellerman.id.au>, Fan Gong <gongfan1@huawei.com>,
        Lorenzo Bianconi
	<lorenzo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lukas
 Bulwahn <lukas.bulwahn@redhat.com>,
        Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>,
        Suman Anna <s-anna@ti.com>
CC: Tero Kristo <kristo@kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>
Subject: [PATCH net-next v2 1/8] dt-bindings: net: ti,rpmsg-eth: Add DT binding for RPMSG ETH
Date: Tue, 2 Sep 2025 14:37:39 +0530
Message-ID: <20250902090746.3221225-2-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902090746.3221225-1-danishanwar@ti.com>
References: <20250902090746.3221225-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add device tree binding documentation for Texas Instruments RPMsg Ethernet
channels. This binding describes the shared memory communication interface
between host processor and a remote processor for Ethernet packet exchange.

The binding defines the required 'memory-region' property that references
the dedicated shared memory area used for exchanging Ethernet packets
between processors.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 .../devicetree/bindings/net/ti,rpmsg-eth.yaml | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/ti,rpmsg-eth.yaml

diff --git a/Documentation/devicetree/bindings/net/ti,rpmsg-eth.yaml b/Documentation/devicetree/bindings/net/ti,rpmsg-eth.yaml
new file mode 100644
index 000000000000..1c86d5c020b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/ti,rpmsg-eth.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/ti,rpmsg-eth.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments RPMsg channel nodes for Ethernet communication
+
+description: |
+  RPMsg Ethernet subnode represents the communication interface between host
+  processor and a remote processor.
+
+maintainers:
+  - MD Danish Anwar <danishanwar@ti.com>
+
+properties:
+  memory-region:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      Phandle to the shared memory region used for communication between the
+      host processor and the remote processor.
+      This shared memory region is used to exchange Ethernet packets.
+
+required:
+  - memory-region
+
+additionalProperties: false
+
+examples:
+  - |
+    main_r5fss0_core0 {
+        mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
+        memory-region = <&main_r5fss0_core0_dma_memory_region>,
+                        <&main_r5fss0_core0_memory_region>;
+        rpmsg-eth {
+            memory-region = <&main_r5fss0_core0_memory_region_shm>;
+        };
+    };
-- 
2.34.1


