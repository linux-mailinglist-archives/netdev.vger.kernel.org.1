Return-Path: <netdev+bounces-113931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4ED940670
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 06:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71C791C2247F
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 04:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54947167D95;
	Tue, 30 Jul 2024 04:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tBghNsaX"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD15146D6B;
	Tue, 30 Jul 2024 04:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722312702; cv=none; b=ogpSrPbcJ1CCXUGgBRaqynoqMRLC8knc/AVqfe7vDpe8ghqb+I1jGVv2L4Iz9UimCHSDvNKR1heVAx/wn0trGLJmN7powKXcU0yvN/WX9GUl+WDssuprCBTjnrD7QfyT51RTqTuzZjWt6J/Jc+3VdaqCLqf0E0+NuzZzChW8P00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722312702; c=relaxed/simple;
	bh=ix1oE/OffVQVorFZ21efqp4NnkA9rfZoTYeFIvUmgJA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X1mTIbj8sy72j2CU6QPHyHtEAFi/KwO13+pn5ozrshqE7hPVbBYqVVUGbhVLzdYsni2B48URdiasRTEvlLaFKfBJMRNqJw5v1zg+tqsyNuiygfVmxn5LYxXOYrGbxv/C3lJhNyzpzO2rp9nbnY1TlZ1BZvw3t/n5y4v5yY378Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tBghNsaX; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722312700; x=1753848700;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ix1oE/OffVQVorFZ21efqp4NnkA9rfZoTYeFIvUmgJA=;
  b=tBghNsaXYeBSARj4ED5FrTZjVr0I97JhyB+yftggV1ATC7X8YT+41hb6
   MCzqtUmxZNVpoRMZEWewR8u2vbsVhjrOmxcTb8PdBTVd14yOvHrdqI45C
   ful+azxDHH0GAM7HiwopBm9skz8eqPpVHYCCH0wbN/9bSDV28Rsh3iSJZ
   n1DkfeLLeGXWXftWCErKkaRftJ7rUpKiT4ofOHTw/bmNPgDha2hTg1nID
   vK13HpcCVnW3l0mYmX3swVrYyvaYKeUzY727M+Sifzj4q7h3ai/QAzZKb
   rurg5YwSU7pjEZh8t9zTRtubK9PmoBqehybnCnHMKhBEPo0Cxaye3nGw4
   w==;
X-CSE-ConnectionGUID: TN8nIobUQDKWwM8fkqApXw==
X-CSE-MsgGUID: nbUPqMKOR4SFIrK6ALuRmQ==
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="197261896"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jul 2024 21:11:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jul 2024 21:11:07 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jul 2024 21:10:56 -0700
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
CC: <parthiban.veerasooran@microchip.com>, <masahiroy@kernel.org>,
	<alexanderduyck@fb.com>, <krzk+dt@kernel.org>, <robh@kernel.org>,
	<rdunlap@infradead.org>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>,
	<Nicolas.Ferre@microchip.com>, <benjamin.bigler@bernformulastudent.ch>,
	<linux@bigler.io>, Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>, Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH net-next v5 14/14] dt-bindings: net: add Microchip's LAN865X 10BASE-T1S MACPHY
Date: Tue, 30 Jul 2024 09:39:06 +0530
Message-ID: <20240730040906.53779-15-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730040906.53779-1-Parthiban.Veerasooran@microchip.com>
References: <20240730040906.53779-1-Parthiban.Veerasooran@microchip.com>
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
index 000000000000..b7b755b27b78
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/microchip,lan8650.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/microchip,lan8650.yaml#
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
index 907522277010..95d62ac6e84b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14953,6 +14953,7 @@ MICROCHIP LAN8650/1 10BASE-T1S MACPHY ETHERNET DRIVER
 M:	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/microchip,lan8650.yaml
 F:	drivers/net/ethernet/microchip/lan865x/lan865x.c
 
 MICROCHIP LAN87xx/LAN937x T1 PHY DRIVER
-- 
2.34.1


