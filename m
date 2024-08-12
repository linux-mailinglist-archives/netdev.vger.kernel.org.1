Return-Path: <netdev+bounces-117657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8846494EB29
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 12:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD4591C203B5
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 10:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C06C178378;
	Mon, 12 Aug 2024 10:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vei5Jy5V"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0130170A23;
	Mon, 12 Aug 2024 10:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723458598; cv=none; b=LfjsxBEeHN+JehESmga2l20Dh5yuDCVDFT76d/olLiuoYsrQOx6nFKKxE5TkE5GdUAMcCeFy6rG5QzTJn5b21DJnwkZo/D0ZJs4pVKRNA8f21dCGHxlpG26GvkIRhBiqg4W9YixPrQFKluD2kGCRjPNLoKBevr1MJ/Xcz+9gzPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723458598; c=relaxed/simple;
	bh=0EEGnlCp1cMDeKputYwR1SWQBp8sauu+kRhvaHHOEF8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WrDPFT1wgFdL3uWjnG6mUevtozDrnAjNOekbJuG89VVYvjVbqVY46n0HyNEk3BP2Prj1qY66TR6fFr+6nmb1nuXeU3FRdneK7qDjOJoK92DGHFoaN0/xBZCpYrAa/mjOiPamzGGu7ubJg9UkfaHPlGh2RHzCRUFhbhRtmL3ygVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vei5Jy5V; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723458596; x=1754994596;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0EEGnlCp1cMDeKputYwR1SWQBp8sauu+kRhvaHHOEF8=;
  b=vei5Jy5VXvhAcjj/9HZqglMSEBsh+dn3wGYgz0wr4KdiVVcVjartPDRW
   8ceIlbyM+GBSira2nWXNL+dIHkHhw59Bg4iyTsWVCqyHVGTu73e/EV0IJ
   zClErX0+3PSKmntkYkOXmHhvj/JZMlLw6l+o8BFEjWiy1RcqbF8Y1wOcC
   t0Yr814yPGmAySsBas7OaAGid32VsosuWgxUqaq6DNkp/lvSG7xZYLMBs
   A1OaBJ0wU7TDZxx8Fdda0Gb/yZuacaaxbFg0lMolx2ZgDuyC9NeNujdav
   8HnKy2lSrSX7JGuZ6ippUmUMkUDl8hN+l3BBt4rsYBkQjopufxKvpe7TK
   g==;
X-CSE-ConnectionGUID: yDxC2bo1TwWBSqdWxPnjhA==
X-CSE-MsgGUID: r/Bsy4PkSs61khTMORDXJw==
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="30336623"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2024 03:29:55 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Aug 2024 03:29:24 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 12 Aug 2024 03:29:14 -0700
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
	<linux@bigler.io>, <markku.vorne@kempower.com>, Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>, Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH net-next v6 14/14] dt-bindings: net: add Microchip's LAN865X 10BASE-T1S MACPHY
Date: Mon, 12 Aug 2024 15:56:11 +0530
Message-ID: <20240812102611.489550-15-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812102611.489550-1-Parthiban.Veerasooran@microchip.com>
References: <20240812102611.489550-1-Parthiban.Veerasooran@microchip.com>
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

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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
index 112576ccf123..46ba756af64a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14957,6 +14957,7 @@ MICROCHIP LAN8650/1 10BASE-T1S MACPHY ETHERNET DRIVER
 M:	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/microchip,lan8650.yaml
 F:	drivers/net/ethernet/microchip/lan865x/lan865x.c
 
 MICROCHIP LAN87xx/LAN937x T1 PHY DRIVER
-- 
2.34.1


