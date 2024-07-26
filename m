Return-Path: <netdev+bounces-113211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B17D993D359
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 14:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEF0D1C22EBF
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 12:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925DB17C7B2;
	Fri, 26 Jul 2024 12:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HCZT+h/E"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E8917BB1B;
	Fri, 26 Jul 2024 12:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721997686; cv=none; b=DYAe+DN1AgUaYvAvEJABooOUroGRb8jgGxtFe5+XwUskmgdA+4vDCKJAfGyOyPXpVGDEpelZjhY+AcXT/DrRZNOJifMGmSNsKZyLkBXZZvWf6+boNLb4LO2wJkqZzdqX41n2ptOFOU4646RlJ0fFjgLR2N6RLEEzzg1bLwVnxUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721997686; c=relaxed/simple;
	bh=qMjm7l05a9QIP4+huhSnew8ukzeBMO/F7jCzKtlAac8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jOkyto6gd8qK0+25GTbeRsr7s5PZRKKcp82VzxhpGdDVbbNO4zXgDKshL/0wg+yaqHj884iEzI+gV2qqz2Qlht0zmiitrosohjnplVmaWRc9lqIjLRRse8rFt64zyHjI1K1IdLvnUMrwgNwLSW5MCrcFvwJ8MPWTBUX/nLWKU8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HCZT+h/E; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721997685; x=1753533685;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qMjm7l05a9QIP4+huhSnew8ukzeBMO/F7jCzKtlAac8=;
  b=HCZT+h/EOlnbTTxkBE8CHQ5cyX/zaIHWZ/2FxPXhfWKo4I+JTN0hvwEw
   4XGiHTUj0bu81HUtXHZEVP2yXkchZ+qDAqu/iJ7e7LPVp1+aADQyN5nQq
   3OPCEkNYOczuPVZT6c7Ip6hTsXcOFEekE13cTDlzlQ081dCLXjyukYkGz
   KPtoi74Dc7FHROYXp/NAc9kNyT1gH3XMcwFXUavgVp49WBHYB7wM8zi5D
   uuls6WpKGd98d9mYPLRNOkUdVA68Xe75HIxyUofmkxCPq+jDB1kqzg4F3
   Jnk3/3okXcbNbRTuo5d94Nf38wBA8eDERCRuz/tUL9CS/6+kehcx7zLSE
   Q==;
X-CSE-ConnectionGUID: iipq+Hi7SiqaS0VFNs7ygg==
X-CSE-MsgGUID: YMmkzeYARL+vJHSRW75tMw==
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="30386984"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Jul 2024 05:41:23 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jul 2024 05:40:47 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 26 Jul 2024 05:40:38 -0700
From: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <andrew@lunn.ch>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <horatiu.vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <steen.hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>
CC: <UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>,
	<Nicolas.Ferre@microchip.com>, <benjamin.bigler@bernformulastudent.ch>,
	<linux@bigler.io>, Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>, Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH net-next v5 14/14] dt-bindings: net: add Microchip's LAN865X 10BASE-T1S MACPHY
Date: Fri, 26 Jul 2024 18:09:07 +0530
Message-ID: <20240726123907.566348-15-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240726123907.566348-1-Parthiban.Veerasooran@microchip.com>
References: <20240726123907.566348-1-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

The LAN8650/1 combines a Media Access Controller (MAC) and an Ethernet
PHY to enable 10BASE-T1S networks. The Ethernet Media Access Controller
(MAC) module implements a 10 Mbps half duplex Ethernet MAC, compatible
with the IEEE 802.3 standard and a 10BASE-T1S physical layer transceiver
integrated into the LAN8650/1. The communication between the Host and the
MAC-PHY is specified in the OPEN Alliance 10BASE-T1x MACPHY Serial
Interface (TC6).

Reviewed-by: Conor Dooley<conor.dooley@microchip.com>
Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 .../bindings/net/microchip,lan8650.yaml       | 80 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/microchip,lan8650.yaml

diff --git a/Documentation/devicetree/bindings/net/microchip,lan8650.yaml b/Documentation/devicetree/bindings/net/microchip,lan8650.yaml
new file mode 100644
index 000000000000..c4538b431f59
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/microchip,lan8650.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/microchip,lan865x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip LAN8650/1 10BASE-T1S MACPHY Ethernet Controllers
+
+maintainers:
+  - Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
+
+description:
+  The LAN8650/1 combines a Media Access Controller (MAC) and an Ethernet
+  PHY to enable 10BASE‑T1S networks. The Ethernet Media Access Controller
+  (MAC) module implements a 10 Mbps half duplex Ethernet MAC, compatible
+  with the IEEE 802.3 standard and a 10BASE-T1S physical layer transceiver
+  integrated into the LAN8650/1. The communication between the Host and
+  the MAC-PHY is specified in the OPEN Alliance 10BASE-T1x MACPHY Serial
+  Interface (TC6).
+
+allOf:
+  - $ref: /schemas/net/ethernet-controller.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: microchip,lan8650
+      - items:
+          - const: microchip,lan8651
+          - const: microchip,lan8650
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      Interrupt from MAC-PHY asserted in the event of Receive Chunks
+      Available, Transmit Chunk Credits Available and Extended Status
+      Event.
+    maxItems: 1
+
+  spi-max-frequency:
+    minimum: 15000000
+    maximum: 25000000
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - spi-max-frequency
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      ethernet@0 {
+        compatible = "microchip,lan8651", "microchip,lan8650";
+        reg = <0>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&eth0_pins>;
+        interrupt-parent = <&gpio>;
+        interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
+        local-mac-address = [04 05 06 01 02 03];
+        spi-max-frequency = <15000000>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index e7d092d9a752..ba9053b0ac77 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14904,6 +14904,7 @@ MICROCHIP LAN8650/1 10BASE-T1S MACPHY ETHERNET DRIVER
 M:	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/microchip,lan8650.yaml
 F:	drivers/net/ethernet/microchip/lan865x/lan865x.c
 
 MICROCHIP LAN87xx/LAN937x T1 PHY DRIVER
-- 
2.34.1


