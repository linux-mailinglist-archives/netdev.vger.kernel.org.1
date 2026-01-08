Return-Path: <netdev+bounces-248070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DADCD02CDA
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 13:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3FF33300EE44
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 12:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8137480944;
	Thu,  8 Jan 2026 12:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JD9rsj0q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C6E47ECE8
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 12:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767876741; cv=none; b=gmG4LayP4JZgBb6uRF7cMQ63dzk15CllYl4X+41TxvPH5giWbF0jLT/29P8q24BRwe+U02Tvv4wg61wdFQsiQlvsy5Nf2XC4f7wbjX7ivreZANJcc/bY1YFLaAFbRtIHVFg39ab8PMDQxDi2hWctFYgZ3FOBeazpOsNZu3HKPNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767876741; c=relaxed/simple;
	bh=Qa5mG+Qc0hSt/p9UZLuX1sshZ3VrGvWB0nI8WPgA/nU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iAHJV4q49/XP7uoIjUGBuc1V7lHAs+2Q0j8ddrehI2dzvMgLNVkc0aXRZBGnrbxuzcI3oXGteUcQ26YroPiU6NZ6zgkRo5nT8hS2GMgCJruCaFounuTjB4857z8xl7Mb666G0XNJUdq//h5+CCz26QDvOvqksgeSqC99LG1crCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JD9rsj0q; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47796a837c7so23520745e9.0
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 04:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767876738; x=1768481538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYYwwTN4qkvGox+J9ceAkp0yvjQzP/lN9aiyW1wExYk=;
        b=JD9rsj0qfabPa/52Ij7ZCBj5ewHi/92z9CR7hwWoWkuGw+zqrL4q+UfGNBbi1jtaHk
         b7FsnVWwXq5dK8evGZ65uW0/+mPRJrEv2NPphjvqqokRDeUuQ8IxVheNNmQBS8vx8cnR
         bZpGhTY1+V0gdTmbvUK6fWAUwYdXcR7X+XqsHatpqwFk+Wjj06cKKTAbrwSP6O2QU4ZV
         wSKGBFHFV48M71CRwYta10S0kv7DKx4gkDUuWxsNIBhPaqpqQzrn7tWk7F+ixdM/BVZO
         /kEPC6STnJoUsZ9Up81DUGzwWQP0XVNmBpWHRQhOaLCl/gm4OEQALvzgC0ca963fGqP+
         e5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767876738; x=1768481538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JYYwwTN4qkvGox+J9ceAkp0yvjQzP/lN9aiyW1wExYk=;
        b=OJvD+LYc3GPxH0hdFGkhp1Q/Bmx0hLhLhrpxPAQG5YDmMWvAju3rrVWCBOFVDvMnh/
         SfVPw2WyVGq3Br6zuHKXowhbpKsMU33P1ZT6bKElSFozarU/bJ4Sq0FM3XqAHUgmIFjL
         SqwmBMDPSW/U7bBf+xR7CU6llcIUH/VIcWwe24a7QaregxRu2GMJj978T1aiacdyW9O0
         JxnnzPm9qZ8LtchJoiljLHwKLvewTW73MW6nde8KNWnI1izXueP0DuYBGCR8u0PpLNjX
         2nGb47iEn5xZb2RoJom3rhbIsEsynNOne/2G4PYuHRewkkMXviH69u2HiSXLujNu4byv
         j/dw==
X-Gm-Message-State: AOJu0Yy+acEJY68CIYIYw0oTeF+sVBGgmHPYuy22GRaXXiXIJoCeEr6D
	4SX6zK20X83l7YkeT2OiqvQbnX8u+GQWr1wY6L7B+CAldJBB+S0vBe69
X-Gm-Gg: AY/fxX7/hF7S0ZKYQmGYZ+f8qm55zF8ezl5MPNpRW57W95RINPpa2mPw4EHwcqKVebl
	v0T6vS+b+bsuxZg6CbxwmKxxYqRJ0NlD37mZYAM2S73RkzByu4kAcY3cl89FmCc6oIqAYC0p+8v
	ygH6AQopDvQRWdrlsHrDlxTJetiR14+0lIdbelgRzoSKxsylr/rYJWqcuzDtMVP3yZRBTtcXOzA
	jNsd4G9aOxvapB8rw7wevN72O1UG8BJ3ysl7bMUzSjvxeo/SNaIQgD+Jn6+adigbQpy3ti3aum+
	kmM+MJcPSMGe/WVo9aQGPYeOQFL5MEFL7uWRCHXrCgIG6NB/RU0gKBx44fkGUdomEda2aKfA7eb
	iYfyfpeuGk59WLS4+ks9n8CEwFZ9C6mWamdOPW0weYk4IMFfux6BcmuUOTHoTIWfFVSKC5L71mh
	Dx+lvlDbD5W6+0UCpOVc7VI2HivHqnfeUddbo=
X-Google-Smtp-Source: AGHT+IFBunwczMq6hW6meI3T9+YJq6J+EivvF8bMO7S6u1azwZGaowXyxJd/ftxDMxpR6tgbXK7UMw==
X-Received: by 2002:a05:600c:5391:b0:479:3a89:121d with SMTP id 5b1f17b1804b1-47d84b614b8mr70937975e9.36.1767876737793;
        Thu, 08 Jan 2026 04:52:17 -0800 (PST)
Received: from eichest-laptop.gad.local ([2a02:168:af72:0:58d0:2e00:f578:dd87])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dacd1sm16046623f8f.4.2026.01.08.04.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 04:52:17 -0800 (PST)
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
Subject: [PATCH v2 1/2] dt-bindings: net: micrel: Convert to DT schema
Date: Thu,  8 Jan 2026 13:51:27 +0100
Message-ID: <20260108125208.29940-2-eichest@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260108125208.29940-1-eichest@gmail.com>
References: <20260108125208.29940-1-eichest@gmail.com>
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
 .../devicetree/bindings/net/micrel.yaml       | 133 ++++++++++++++++++
 2 files changed, 133 insertions(+), 57 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/micrel.txt
 create mode 100644 Documentation/devicetree/bindings/net/micrel.yaml

diff --git a/Documentation/devicetree/bindings/net/micrel.txt b/Documentation/devicetree/bindings/net/micrel.txt
deleted file mode 100644
index 01622ce58112..000000000000
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
index 000000000000..52d1b187e1d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/micrel.yaml
@@ -0,0 +1,133 @@
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
+        clocks:
+          maxItems: 1
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


