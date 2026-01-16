Return-Path: <netdev+bounces-250524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 642BAD319D4
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 14:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96C1930BD369
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 13:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC13E24A05D;
	Fri, 16 Jan 2026 13:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2glFSBC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3346823E342
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 13:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768568996; cv=none; b=cO2QePrDEq/zXK09ZppBCBSHuYdgASRzqDKNK+3tkH5g2cKssKUxj4pxKqRIP1kqEq6KcabsLFWht/vicuJrrJtaCSxQuFCgPQ34S29OrqFPKzBZYfSQ178Qi9Tr8nTpLwCqPyk5cNuK0ZUf8OlRTxldI/QzR93d1d2LTl9HmGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768568996; c=relaxed/simple;
	bh=u48lLrPph6snkVCtWxdiP0fxSJZrh7K0xx0vnXuzR8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZjkJ2baX+wv9fCyh6I26tGmruxSQP+vITYdJvq1lPYUO4qH2AgXjmqqWzbGj/a1W9MnrihnQIwzM7oIXNNNbQG/tBKCcoVgWOPx6UQduRNZTTSYTC3ZJAaiMAFZn6Ty8iEYT5x4x7LuGQnH6CJD04aDKghZfKrN0GoXWPHeB/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2glFSBC; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42fb2314eb0so1606539f8f.2
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 05:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768568992; x=1769173792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xoWlJroSMIuyUgvUbwQWnOncGKBzXuVuA3FUMGnEZm4=;
        b=V2glFSBC5b3NRSt0oqZCHGOX8HYdpj2HINVElblNmcZxYcj7idGC4NGnhffn8k3DfM
         CyvrmDh0lxUV0IfHVMzydWczNMc9cA9jE9iS0KOJ56S1yvGlFPAfig2ehbCb1HOv+bqP
         smRABUZ3Y+g98D0IWhd4A8fr9XJf7DZJpbFO/qmzCW2o+LWc6Vw06m8JldomNj+pln1P
         qXTXsmGH4tv2iSlSadrG5e/6D28KLQK/b+ixBkXlq6G/aTuKE57O0DDlJYM8P0sJscQX
         zvoGtnMXkT3Yhn3qtVPHWAYj2M/j3OyRjc/RFhSNAJ5aMHToPU7EVz6XXKKsD3WMEbym
         wcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768568992; x=1769173792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xoWlJroSMIuyUgvUbwQWnOncGKBzXuVuA3FUMGnEZm4=;
        b=QrHmFfLWipCa6/C9uj43dT1KDYSbRO/jV60U776AoBoJZgDpU39lZZgG2hePNFq1TI
         WzFLUic0nFDuZWeRQkIhJ6yI2kRT1kg0asC5K3xHL3n8LdWTpi5NjIdzfwkJvv4anIA/
         kNo69Phm9UYxreuKY+mDtS3+ve2RTWGs2E/W5C1XX9+cFjkRZJE2HujOJYVfD2Zi7U1Q
         +uPf9ZJkeqDIf+32ao2yRZQHox+dBm472V5frGfZ44lX9XYQUz3QXU0lnzb2K+UotXEa
         yg2KuErx+uoXbtvtCmotK0WO19bWZ9Ci9ca5gJYfOrP5o3KqZtpCT8nA3NSzbs5p6tYU
         oMBA==
X-Gm-Message-State: AOJu0Yz5ybL7k8QyGxVnDNfdgtXsppL3Ab3Bi8u/ayWKMAif79XFgT+F
	iCODbMHPpvaUi/tYdPlUOR7LKCgy9MQ6hXoEupFpv87Yy9V4iZkWiAD5M/OlYg==
X-Gm-Gg: AY/fxX7OKahmC+FLVr1qj6vKOSeiCuhPyPxjYgx1I5rI+oCSolsBuSAX6VoSVLv1lir
	l/pB/GTKCfYCfWfOn6LajECzcBk+uIxQ0T4xd8a2taRmSZYFBwa6te8wyUVEZbkZ+JwOAqHUHzb
	qwyaPhxrLo05o854u9cXZq0AUxlx0pDd46lVSVGFnuFMXEbc2y0tijanafioV00ChtNLUtIuVns
	1PNfAeLwtXymJ/UhAOkB/K5nqcUM6OdFB2ApZnaRdR2fxCP8DpDkkBVxHEHE4dbAzaKVgwqfeMm
	akguYIuJpw5AMgJH9hAHyss2eqmo8HmqnrIpb2UpBcI/JWVj8KT6+DPSibESI9mvfPBEWLcSeBy
	ksoFUTZc5d473UlC4D2bmt1QG0YSZhjy6wxG+DlANEOh/QXIxkvJR2sBHxQ16D9aSM6IvLcBn1/
	RLJYGFJeayROtJUvDk
X-Received: by 2002:a05:6000:3110:b0:431:48f:f78f with SMTP id ffacd0b85a97d-4356996f2f0mr3074389f8f.1.1768568992229;
        Fri, 16 Jan 2026 05:09:52 -0800 (PST)
Received: from eichest-laptop.lan ([2a02:168:af72:0:7818:c5f2:e870:3d67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435699272a0sm5172610f8f.17.2026.01.16.05.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 05:09:51 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	eichest@gmail.com
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH v3 1/2] dt-bindings: net: micrel: Convert to DT schema
Date: Fri, 16 Jan 2026 14:09:11 +0100
Message-ID: <20260116130948.79558-2-eichest@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260116130948.79558-1-eichest@gmail.com>
References: <20260116130948.79558-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Convert the devicetree bindings for the Micrel PHYs and switches to DT
schema.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 .../devicetree/bindings/net/micrel.txt        |  57 --------
 .../devicetree/bindings/net/micrel.yaml       | 131 ++++++++++++++++++
 2 files changed, 131 insertions(+), 57 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/micrel.txt
 create mode 100644 Documentation/devicetree/bindings/net/micrel.yaml

diff --git a/Documentation/devicetree/bindings/net/micrel.txt b/Documentation/devicetree/bindings/net/micrel.txt
deleted file mode 100644
index 01622ce58112e..0000000000000
--- a/Documentation/devicetree/bindings/net/micrel.txt
+++ /dev/null
@@ -1,57 +0,0 @@
-Micrel PHY properties.
-
-These properties cover the base properties Micrel PHYs.
-
-Optional properties:
-
- - micrel,led-mode : LED mode value to set for PHYs with configurable LEDs.
-
-	Configure the LED mode with single value. The list of PHYs and the
-	bits that are currently supported:
-
-	KSZ8001: register 0x1e, bits 15..14
-	KSZ8041: register 0x1e, bits 15..14
-	KSZ8021: register 0x1f, bits 5..4
-	KSZ8031: register 0x1f, bits 5..4
-	KSZ8051: register 0x1f, bits 5..4
-	KSZ8081: register 0x1f, bits 5..4
-	KSZ8091: register 0x1f, bits 5..4
-	LAN8814: register EP5.0, bit 6
-
-	See the respective PHY datasheet for the mode values.
-
- - micrel,rmii-reference-clock-select-25-mhz: RMII Reference Clock Select
-						bit selects 25 MHz mode
-
-	Setting the RMII Reference Clock Select bit enables 25 MHz rather
-	than 50 MHz clock mode.
-
-	Note that this option is only needed for certain PHY revisions with a
-	non-standard, inverted function of this configuration bit.
-	Specifically, a clock reference ("rmii-ref" below) is always needed to
-	actually select a mode.
-
- - clocks, clock-names: contains clocks according to the common clock bindings.
-
-	supported clocks:
-	- KSZ8021, KSZ8031, KSZ8081, KSZ8091: "rmii-ref": The RMII reference
-	  input clock. Used to determine the XI input clock.
-
- - micrel,fiber-mode: If present the PHY is configured to operate in fiber mode
-
-	Some PHYs, such as the KSZ8041FTL variant, support fiber mode, enabled
-	by the FXEN boot strapping pin. It can't be determined from the PHY
-	registers whether the PHY is in fiber mode, so this boolean device tree
-	property can be used to describe it.
-
-	In fiber mode, auto-negotiation is disabled and the PHY can only work in
-	100base-fx (full and half duplex) modes.
-
- - coma-mode-gpios: If present the given gpio will be deasserted when the
-		    PHY is probed.
-
-	Some PHYs have a COMA mode input pin which puts the PHY into
-	isolate and power-down mode. On some boards this input is connected
-	to a GPIO of the SoC.
-
-	Supported on the LAN8814.
diff --git a/Documentation/devicetree/bindings/net/micrel.yaml b/Documentation/devicetree/bindings/net/micrel.yaml
new file mode 100644
index 0000000000000..ecc00169ef805
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/micrel.yaml
@@ -0,0 +1,131 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/micrel.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Micrel KSZ series PHYs and switches
+
+maintainers:
+  - Andrew Lunn <andrew@lunn.ch>
+  - Stefan Eichenberger <eichest@gmail.com>
+
+description:
+  The Micrel KSZ series contains different network phys and switches.
+
+properties:
+  compatible:
+    enum:
+      - ethernet-phy-id000e.7237  # KSZ8873MLL
+      - ethernet-phy-id0022.1430  # KSZ886X
+      - ethernet-phy-id0022.1435  # KSZ8863
+      - ethernet-phy-id0022.1510  # KSZ8041
+      - ethernet-phy-id0022.1537  # KSZ8041RNLI
+      - ethernet-phy-id0022.1550  # KSZ8051
+      - ethernet-phy-id0022.1555  # KSZ8021
+      - ethernet-phy-id0022.1556  # KSZ8031
+      - ethernet-phy-id0022.1560  # KSZ8081, KSZ8091
+      - ethernet-phy-id0022.1570  # KSZ8061
+      - ethernet-phy-id0022.161a  # KSZ8001
+      - ethernet-phy-id0022.1720  # KS8737
+
+  micrel,fiber-mode:
+    type: boolean
+    description: |
+      If present the PHY is configured to operate in fiber mode.
+
+      The KSZ8041FTL variant supports fiber mode, enabled by the FXEN
+      boot strapping pin. It can't be determined from the PHY registers
+      whether the PHY is in fiber mode, so this boolean device tree
+      property can be used to describe it.
+
+      In fiber mode, auto-negotiation is disabled and the PHY can only
+      work in 100base-fx (full and half duplex) modes.
+
+  micrel,led-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      LED mode value to set for PHYs with configurable LEDs.
+
+      Configure the LED mode with single value. The list of PHYs and the
+      bits that are currently supported:
+
+      KSZ8001: register 0x1e, bits 15..14
+      KSZ8041: register 0x1e, bits 15..14
+      KSZ8021: register 0x1f, bits 5..4
+      KSZ8031: register 0x1f, bits 5..4
+      KSZ8051: register 0x1f, bits 5..4
+      KSZ8081: register 0x1f, bits 5..4
+      KSZ8091: register 0x1f, bits 5..4
+
+      See the respective PHY datasheet for the mode values.
+    minimum: 0
+    maximum: 3
+
+allOf:
+  - $ref: ethernet-phy.yaml#
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: ethernet-phy-id0022.1510
+    then:
+      properties:
+        micrel,fiber-mode: false
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - ethernet-phy-id0022.1510
+                - ethernet-phy-id0022.1555
+                - ethernet-phy-id0022.1556
+                - ethernet-phy-id0022.1550
+                - ethernet-phy-id0022.1560
+                - ethernet-phy-id0022.161a
+    then:
+      properties:
+        micrel,led-mode: false
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ethernet-phy-id0022.1555
+              - ethernet-phy-id0022.1556
+              - ethernet-phy-id0022.1560
+    then:
+      properties:
+        clock-names:
+          const: rmii-ref
+          description:
+            The RMII reference input clock. Used to determine the XI input
+            clock.
+        micrel,rmii-reference-clock-select-25-mhz:
+          type: boolean
+          description: |
+            RMII Reference Clock Select bit selects 25 MHz mode
+
+            Setting the RMII Reference Clock Select bit enables 25 MHz rather
+            than 50 MHz clock mode.
+
+dependentRequired:
+  micrel,rmii-reference-clock-select-25-mhz: [ clock-names ]
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy@5 {
+            compatible = "ethernet-phy-id0022.1510";
+            reg = <5>;
+            micrel,led-mode = <2>;
+            micrel,fiber-mode;
+        };
+    };
-- 
2.51.0


