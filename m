Return-Path: <netdev+bounces-221009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C217B49E30
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 02:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD7241BC5E7A
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 00:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB34224AF9;
	Tue,  9 Sep 2025 00:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHxzsHyT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C59F21E0BE;
	Tue,  9 Sep 2025 00:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757378641; cv=none; b=lJDxURyy6lr/zDsFYTiBQK66RUaThZMLRZavIrNHlj59T0lOPk04Xyx+V2wLt6kOCMxB43QIlhseSrbD0ZheNQnVHAq/UkYYXCg0RPzMy69hyGCka+EdjnxJerg2aOVii1V3s8ldqSEp+ZJHicZaZZa9CGztd+dfvnowXcAhukQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757378641; c=relaxed/simple;
	bh=MZ6PxAvurXG1uH1QIJpzbJ63J+I3jr0ROI56K6VM/XA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFyjlSNMQyWtJmM3bNu9pRZo04ujgMxBSnqHVL72JorWdGDNu80eJZ1Z49H7/CeXo1M2sTfQzTzeOcc7AEQ+taT6GFflXVGb+LrHxXqE0b78TfUNTIvtnD/p3va2UriCTQtz4yyrduEQSg002Cl4naU1ufrmXe9LBChtIZvuTok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHxzsHyT; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45cb6180b60so31565355e9.0;
        Mon, 08 Sep 2025 17:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757378638; x=1757983438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S1Rt7Xhagla/1sOuAXTb1PZ0PCjuu0lMg8zPkfBBc8c=;
        b=DHxzsHyTAs8KfwRcRS6ZnOlbL9UtBnUzZ/aupttdh1EdSVbPzg1HWzvxNlFLcGJlAD
         LG1jkgiK6vpDnY8KFxyVTxdXG3RAuEigos3BXixPgmppuZkWLikcCPJxH/NZZxXElIq5
         8o8CFqmlHb+eU7QHYACyhqxtFLyExhNQxT1FunBfTzittjMmo1L8+WfH939m1WVL0z6c
         g8GiCjSXaGEQWWphrLh/2egrHLCwcaZWPV5sJ66WqMcZdD2//ylTwOJzbx8OWC+//3V1
         9wktQcFaUTY+cQ1BP7sWvwZCoRIuUY0PpnqwGvy7XXzcjIvDYs8LGZWfy0rfJUBr1f8U
         bcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757378638; x=1757983438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1Rt7Xhagla/1sOuAXTb1PZ0PCjuu0lMg8zPkfBBc8c=;
        b=jHSMm/3xDomx7ISFFO0+kX+Z/OC5S4BRKpV1kv5eTv8LnL3CC4RxEMlidRHJJQGvqc
         9bSISuPPG+arMpKzxACzm+14ZusovjvuBnEjD5iDWFbn6wWQdKFzAX5IRyvFf3o8Lt07
         1XeRaWsAa0d11kGwJru9OP1QLFIRLTzqTWRne8qSLM3NhLgVWg4t6EPY0w5HHgHzAMDC
         /zmGeA4SWBVnPqGWnA7yQ9e2c6cFQiTtqT34i+7fkAWIIQSfqqmGazyZLO7JjJxtvX2P
         dQEDGjjwMTOd1N4L9rlxeONDPM0fRFYmVChxZAJ8DREqoKPg9ktK6QAUIbZTCZZwbMls
         rMCg==
X-Forwarded-Encrypted: i=1; AJvYcCU9+GGk7mcwGDhCCybV9cFKusfvCZxYPt6xy9744xcQ/BPgGRX8U2v1eRRthoT/hGUjA7kW9rE6i+e7AKTi@vger.kernel.org, AJvYcCW92mLSmhMMf/jPoxdFutnUq2Rrt8uV2lpymEdKzjU9+0tXgwspHCfjA4HFPssndh01GRQXZxjWN5zZ@vger.kernel.org, AJvYcCXubpi2ZnFS/7ragWPA4xLI+jJXRFoTis6nDXm4iIdelYMz8QNKp/XL2jQ4wuFDz5flRYznO2nx@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5hIaoJY0a3jjAEbs2YKXKr39HtkfcwbTQ2cQ53c0imZbKhvBc
	F7A1VorWgV9YvrJH6oSrxkHq0sRAm7nBuquvvfXKT40rmL6pwP3Q5uiI
X-Gm-Gg: ASbGncsACjqFpmrUdRsLuyD73rig7GReGCLAneeEHucclwqPlwE3Rt1YjfzjoLq//81
	DmByUZKE3NXcoKFsCgLLhghdWiSq2SYFWdNOTh6tNdj3OZs0TSFWAi2F0RFTtY9IUMs8ET4iInc
	M5NofaD8ORcubsl4HJ1ICVfB6h+jtkW3Z4HFBB7bC+F7XpbXSZ8mPsh5z/g340NIfFCx9+4y3Xl
	DaKXzmKmVJHVXx7HukIL7lg4jF4+iKlJEbtyWGKE/z+hOcIiPWClS44/00xTom2xhSEm7/aWWMP
	6xlPQ0EUbbTIMPaAqEmEUzzf2KLEepkDR0DqzovhV8u3N9bKaoUWnZ3f26CgqZBogqvyUFdABfl
	7UNkhvBwKblp36wtXSiLLiluCFqocjTG3mBs0bqvfZJ6f6hLPmzX/J0uWz9i6gZEqA6t9fps=
X-Google-Smtp-Source: AGHT+IH4fR25pWBi+Eso5eUx8LzkAeJgMnV5or5n/TPST37oWJJmARJzYxZ4bt16tKNwwHA9njw+KA==
X-Received: by 2002:a05:600c:4513:b0:45c:b5bb:7b51 with SMTP id 5b1f17b1804b1-45dddeef994mr102260215e9.30.1757378638283;
        Mon, 08 Sep 2025 17:43:58 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45decf8759esm13526385e9.23.2025.09.08.17.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 17:43:57 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Simon Horman <horms@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH v16 03/10] dt-bindings: net: Document support for AN8855 Switch Internal PHY
Date: Tue,  9 Sep 2025 02:43:34 +0200
Message-ID: <20250909004343.18790-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909004343.18790-1-ansuelsmth@gmail.com>
References: <20250909004343.18790-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document support for AN8855 Switch Internal PHY.

Airoha AN8855 is a 5-port Gigabit Switch that expose the Internal
PHYs on the MDIO bus.

Each PHY might need to be calibrated to correctly work with the
use of the eFUSE provided by the Switch SoC. This can be enabled by
defining in the PHY node the NVMEM cell properties.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/net/airoha,an8855-phy.yaml       | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml

diff --git a/Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml b/Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml
new file mode 100644
index 000000000000..d2f86116badf
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/airoha,an8855-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha AN8855 Switch Internal PHY
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description: >
+  Airoha AN8855 is a 5-port Gigabit Switch that expose the Internal
+  PHYs on the MDIO bus.
+
+  Each PHY might need to be calibrated to correctly work with the
+  use of the eFUSE provided by the Switch SoC.
+
+allOf:
+  - $ref: ethernet-phy.yaml#
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - ethernet-phy-idc0ff.0410
+  required:
+    - compatible
+
+properties:
+  reg:
+    maxItems: 1
+
+  nvmem-cells:
+    items:
+      - description: phandle to SoC eFUSE tx_a
+      - description: phandle to SoC eFUSE tx_b
+      - description: phandle to SoC eFUSE tx_c
+      - description: phandle to SoC eFUSE tx_d
+
+  nvmem-cell-names:
+    items:
+      - const: tx_a
+      - const: tx_b
+      - const: tx_c
+      - const: tx_d
+
+required:
+  - compatible
+  - reg
+
+dependentRequired:
+  nvmem-cells: [ nvmem-cell-names ]
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy@1 {
+            compatible = "ethernet-phy-idc0ff.0410",
+                         "ethernet-phy-ieee802.3-c45";
+
+            reg = <1>;
+        };
+
+        ethernet-phy@2 {
+            compatible = "ethernet-phy-idc0ff.0410",
+                         "ethernet-phy-ieee802.3-c45";
+
+            reg = <2>;
+
+            nvmem-cells = <&shift_sel_port0_tx_a>,
+                          <&shift_sel_port0_tx_b>,
+                          <&shift_sel_port0_tx_c>,
+                          <&shift_sel_port0_tx_d>;
+            nvmem-cell-names = "tx_a", "tx_b", "tx_c", "tx_d";
+        };
+    };
-- 
2.51.0


