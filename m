Return-Path: <netdev+bounces-215167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE48B2D53C
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 09:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 664A1585792
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 07:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6377B2D8DB1;
	Wed, 20 Aug 2025 07:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3GYG2zn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36D52D8DAF;
	Wed, 20 Aug 2025 07:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755676517; cv=none; b=VUFCu2rBlJ5mD6E7XiuiHfua/5QdQBrnXDgo5h3vVwLN8ElK2eug49Kdnjoqi+uAksZtMYw25Lfv4HPNk/LuJkPaGu3LBnQ9c5Kr7VJ+84I7Mry4NWkFkIvd8l/QeE1Ixg35Lzufb3gnbgqUOTho9MtyVsfK225+wQAzPnfabj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755676517; c=relaxed/simple;
	bh=HJ/O1B/g6kJsiP9Qg2vy3fMbZCzmJpuPAP1rFZBvrlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bIuaIPLiD8+8l5AmXd9vbp+5ajI6GK6gjjz71mABwUOgbX/oETDE4iOJFFzcBwTdbgkE7VuRgWQKJfhAT3SLx0efbNAQYnr5q1fG+FlkI+UB9I4MsGZjZkrrSv3uHZ6LRdachMuII55H4OdyCpO+qaQ/0MIwpP7aX1SU4OuyMk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3GYG2zn; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e2e614b84so5877790b3a.0;
        Wed, 20 Aug 2025 00:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755676515; x=1756281315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8S6V6zJFijBXsicnio2LIQReiokOX6xc51vN5CO+27E=;
        b=h3GYG2zn5kqDBxnUsq68Jfz3TnFOutfCt1MsDwNgSI93mJaSXaNffMKIwyb3LWLsdH
         dy7L8QA+HVTFXFWqFQ+H4z4xk3nrf3cLe6O18svJtiCZ6WlFPuWLptn/RKhfCmZmCv9u
         26voniyQvmdkqbg1KAZy5ZKhnHCvzkQpovExhN3QbzxxoVISuRJcNlOu787rkNbQmGNG
         XKlFNAP9snYRnR0MBqzNyc/mM9Lc64c1qe7xGo3l+aGaw5DsFKAHRwZOgNNTixRDk3Wk
         ND8yQ7AeNJimAJL/Aj8922e+DuVWdUxeLKuHXf9gdNvy05uCelJNBwOLeaauM/Mj1T32
         TJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755676515; x=1756281315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8S6V6zJFijBXsicnio2LIQReiokOX6xc51vN5CO+27E=;
        b=S4X2JZQDX3YNRTQGi+deyqoU5/gNGXQcJgXd+NxqZQVKMxjay+rj89gwi74GX07E1i
         x7VqVhPpRy3zD3goxlHktGLsj42Z8zjbjO8GWrXTBQqW+urYY3pvBISLRv4jG4fdGnfJ
         w9jv35oEU1GzAkiYvIfzMAcp6gt5xV2LlpXt9/XIS572GoysiRtmKC0lpA7Z3efXwQ4N
         pQZMGks3IWy19Z9hKTPj9vno6sPNJIQoNvXs7I2lrwhLGwKai1xVbW9rBsoKps1smv9X
         L+CJ3nNPG+TXG5QAb7RrnUEgs3QGyav26AFhNgFHat693N/S2b/7hkuj6ZyX8OqlhcrB
         NQsg==
X-Forwarded-Encrypted: i=1; AJvYcCWEjwQPHczpnLHkcraF6ifEnaESx6OcRCVuP2iQBCOIZXn3TvTTfrGkT5VLG9W6iuowWzbBeEGdGH2aqQln@vger.kernel.org, AJvYcCWpX/p6Eo5iLOqktaZwNniLtJMEPPRgjU0YxIoZ1sGM1tRtyTnEarwIUyuoyJltqpNIJ8p0k7o9YJXd@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwbm61evKZh6wIzoKrNSQGTcZ9l7CW84dDuuCJDve2WGu0q2JL
	4gyhnJhU3pbGt5HaA8dEKva3Bce5aqemQlhs7NsMqp1nR+poZS3FeN+lPmm51WEs
X-Gm-Gg: ASbGncso2FF5UmvBk+GaigbxL//q1wBAXwMZA7Y/8dy/Yq92T7n51JICFs+qF0wPgUK
	Ff/dgvLNV7bZc8veSkCUlnQQyrksxd1diRgLP/u86at2l7hiqvUF+qsqqnQJLi0V16kXwKKueqj
	uitn2cHsyBOwXqTjBS11HaZHOrFwka7oAHKTBvTBFKk3naqCbbeS0Q0vmygzQqMHKhqfBiV7hon
	4QiJaRw+jH+mAXc6XhjtoUT2WOy751JYQWcWTnCLtUZXFbj4Nttz4XZ03iZNg3rnYa45td7iygn
	j/g8ycgYl7ar8ZjJDPpmp36yIs4YMzmMzJ/lzg/3fmBUnnBC6xEp7bnI/L065JH1TkF7szLgLQN
	34XwK1eM0ZxPYLiITRQ2pKcGI//fYJw==
X-Google-Smtp-Source: AGHT+IGi0FUpOixbP/YmzrefKKWGGn5YU3sdQZgPdbNGmbnDSijwVWWH6kv9VukGRU+FWNxZvtnOpw==
X-Received: by 2002:a05:6a00:2389:b0:76e:8a4e:5278 with SMTP id d2e1a72fcca58-76e8dbc2f26mr2893623b3a.13.1755676514720;
        Wed, 20 Aug 2025 00:55:14 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d137344sm4605225b3a.42.2025.08.20.00.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 00:55:14 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next v5 1/3] dt-bindings: net: dsa: yt921x: Add Motorcomm YT921x switch support
Date: Wed, 20 Aug 2025 15:54:14 +0800
Message-ID: <20250820075420.1601068-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820075420.1601068-1-mmyangfl@gmail.com>
References: <20250820075420.1601068-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Motorcomm YT921x series is a family of Ethernet switches with up to
8 internal GbE PHYs and up to 2 GMACs.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 .../bindings/net/dsa/motorcomm,yt921x.yaml    | 150 ++++++++++++++++++
 1 file changed, 150 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml

diff --git a/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml b/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
new file mode 100644
index 000000000000..a0c8a6fd6bdc
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
@@ -0,0 +1,150 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/dsa/motorcomm,yt921x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Motorcomm YT921x Ethernet switch family
+
+maintainers:
+  - David Yang <mmyangfl@gmail.com>
+
+description: |
+  The Motorcomm YT921x series is a family of Ethernet switches with up to 8
+  internal GbE PHYs and up to 2 GMACs, including:
+
+    - YT9215S / YT9215RB / YT9215SC: 5 GbE PHYs (Port 0-4) + 2 GMACs (Port 8-9)
+    - YT9213NB: 2 GbE PHYs (Port 1/3) + 1 GMAC (Port 9)
+    - YT9214NB: 2 GbE PHYs (Port 1/3) + 2 GMACs (Port 8-9)
+    - YT9218N: 8 GbE PHYs (Port 0-7)
+    - YT9218MB: 8 GbE PHYs (Port 0-7) + 2 GMACs (Port 8-9)
+
+  Any port can be used as the CPU port.
+
+properties:
+  compatible:
+    const: motorcomm,yt9215
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  mdio:
+    $ref: /schemas/net/mdio.yaml#
+    unevaluatedProperties: false
+    description: |
+      Internal MDIO bus for the internal GbE PHYs. PHYs 0-7 are used for Port
+      0-7 respectively.
+
+  mdio-external:
+    $ref: /schemas/net/mdio.yaml#
+    unevaluatedProperties: false
+    description: |
+      External MDIO bus to access external components. External PHYs for GMACs
+      (Port 8-9) are expected to be connected to the external MDIO bus in
+      vendor's reference design, but that is not a hard limitation from the
+      chip.
+
+allOf:
+  - $ref: dsa.yaml#/$defs/ethernet-ports
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        switch@1d {
+            compatible = "motorcomm,yt9215";
+            /* default 0x1d, alternate 0x0 */
+            reg = <0x1d>;
+            reset-gpios = <&tlmm 39 GPIO_ACTIVE_LOW>;
+
+            mdio {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                sw_phy0: phy@0 {
+                    reg = <0x0>;
+                };
+            };
+
+            mdio-external {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                phy1: phy@b {
+                    reg = <0xb>;
+                };
+            };
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                /* phy-handle is optional for internal PHYs */
+                port@0 {
+                    reg = <0>;
+                    label = "lan1";
+                    phy-mode = "internal";
+                    phy-handle = <&sw_phy0>;
+                };
+
+                port@1 {
+                    reg = <1>;
+                    label = "lan2";
+                    phy-mode = "internal";
+                };
+
+                port@2 {
+                    reg = <2>;
+                    label = "lan3";
+                    phy-mode = "internal";
+                };
+
+                port@3 {
+                    reg = <3>;
+                    label = "lan4";
+                    phy-mode = "internal";
+                };
+
+                port@4 {
+                    reg = <4>;
+                    label = "lan5";
+                    phy-mode = "internal";
+                };
+
+                /* CPU port */
+                port@8 {
+                    reg = <8>;
+                    phy-mode = "sgmii";
+                    ethernet = <&eth0>;
+
+                    fixed-link {
+                        speed = <1000>;
+                        full-duplex;
+                        pause;
+                        asym-pause;
+                    };
+                };
+
+                /* if external phy is connected to a MAC */
+                port@9 {
+                    reg = <9>;
+                    label = "wan";
+                    phy-mode = "rgmii";
+                    phy-handle = <&phy1>;
+                };
+            };
+        };
+    };
-- 
2.50.1


