Return-Path: <netdev+bounces-226677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79265BA3F74
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 15:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA9E163EF7
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 13:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011202FB972;
	Fri, 26 Sep 2025 13:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaiofGms"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6ED2FB977
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 13:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758894754; cv=none; b=aRCtQ9BLwJfZE3ExY34QQ7kIhwaEoJBK7ZzuhwlWDJFXb+zKFPOO7usVm+FBzj41zlYIdleZxjgbmZYVAgjceZimHP6G0Gs6eDhWHrTyYSLxK4Gu8pc6uBlYV6+sbbRLHkR4DjtzokRY6DAu4h7F42OnWsxJ2WIHl68xSNed7F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758894754; c=relaxed/simple;
	bh=60sKW7i1vbbtY0FuzPNlPEuK/DTNRLiRrb1M3U5kNUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jFLwVeqr3EOF3gRF6LauuAX6fJnLLp/zWrz1pwJuRk3RGozDmOKRESskiLtXTn4aDynFJDUFeQ+FmmhJreBL0DTvuQXFTUrXSkQPWuXms9ND9N4ouvN+6/rQeflIJTKFb2ChljeHsfWpQxdaYDIwXcwVhxKc9TN0Tb5ta+VVI7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaiofGms; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33082aed31dso2335970a91.3
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 06:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758894752; x=1759499552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcC9XUY8FVCgBMwswacD7pUTLZ7aCAKIG4tpodOwdGI=;
        b=IaiofGmszXkvO6+MGSbKiGeq4zlrCwXOt4OmWc6DIW3BGQ3IGFMw2A1L4RL7N7KLHP
         yK5jDNIQ35q1Bkusc/NFDkmYKFdZSstJ9fIFImQjg4v1CIta4ndJ0XuYlI32yErd/l8B
         GV2MuYDdj+Ct8DJoWWkvBn8QvCj7y1UWA2AiNUt90Xrsb1kau6A0JZFk4/EGpJueGAV5
         CSzTkmlc3PHovuPqQpzDM5fdacvuCzQNUeT/UmHdsEL8aUOI3r11GR2aj+kSVLcqLllb
         4Sd/Xw/qF269iZa5kQce40kkcwsLmHoi1PN73PgkyBmVmLlOe3XPHWW/bDje33QRZUY4
         Putw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758894752; x=1759499552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hcC9XUY8FVCgBMwswacD7pUTLZ7aCAKIG4tpodOwdGI=;
        b=QDFmBCAcsJ5iHdpsw2KdxSMUu70zZK4oi9levMT6prkG80JAFh3HA00vx91JGnIXf2
         75Q+kUd3KNtifW7a7OVJzxcTJMK/3pRME+10FzN8S1tdG95S71uoYXvGvajGeKwVKFDg
         wZGrArB1wZazdu8NXyGafuD8y2D6Ic3TOYG9a+pT1vkcf6Tkfhdd3zqUDnmw8WzO+v4c
         eL7jsx1ojV8aT7afOt7UWytZTuFXx83CWXpB7uE/t+l113XY+RLc6kG+dX36zAmhaaCi
         OJN80/fR2QIvx/ntJyaZTZ3ozLmedvHFtm09ib7lzh7H/g8KenMr7h5oQRd5YfANbG6I
         NRqg==
X-Gm-Message-State: AOJu0YwAovgQqgANqOKmLIGhE3LQhnQG50Dennnv/Uh0R5pNElYVccrG
	pqThxs7L+FQy6VbRDGCTYL9Z/OMZ8qsz6/fBFKAyC3CxJT/DJVW+GD+uaSRt4ITXQPM=
X-Gm-Gg: ASbGncsGemUSf5DeDzurrfcBPaTN3MFmT2MmoowUCSkAJoSn/tCG/7WBr6KnasUsDJe
	MBD+wGqVs0N7V6R1HesEU2ldx68x28EjTUHuZcte71Ibk9Z+ks3klSlgsDTOaF+/KcKKtMIqkzY
	HOCyu03384yl+WWjKasoJjJ3TMYK8gQhD7yis3IPuP0EpL617A/9NTH/IuGsoMSgbzlRG6Ya6R9
	wXQYYyKvpUZa4L2dnsG20PMHCTWJB8BvwGBOgN2GFiz6UhAP9yMoW+7Zv59gTG9We4Bwqd3FDsg
	tQi0TNJaqSNLibv8VLG3O7eyJpJkTEQy4HQLfgVgeSPZulruGmFClcw/8zQjSYbRl/jPJjyoPnJ
	+rzZLqbkigdasj1vEX/3LqkjTOR4UHw==
X-Google-Smtp-Source: AGHT+IGjI8lAarGLwnIu1zdZnbmHobEpS+B+TI9t9/aikJCWjSJvKbD1IHBJ60jCwfCNehiVgq8wZQ==
X-Received: by 2002:a17:90b:4a4c:b0:32e:8c14:5d09 with SMTP id 98e67ed59e1d1-3342a23718dmr6989994a91.7.1758894752256;
        Fri, 26 Sep 2025 06:52:32 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be2338csm8997217a91.22.2025.09.26.06.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:52:31 -0700 (PDT)
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
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next v12 3/5] dt-bindings: net: dsa: yt921x: Add Motorcomm YT921x switch support
Date: Fri, 26 Sep 2025 21:50:50 +0800
Message-ID: <20250926135057.2323738-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926135057.2323738-1-mmyangfl@gmail.com>
References: <20250926135057.2323738-1-mmyangfl@gmail.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/net/dsa/motorcomm,yt921x.yaml    | 169 ++++++++++++++++++
 1 file changed, 169 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml

diff --git a/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml b/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
new file mode 100644
index 000000000000..ff03bff0be4f
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
@@ -0,0 +1,169 @@
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
+    enum: [0x0, 0x1d]
+
+  reset-gpios:
+    maxItems: 1
+
+  mdio:
+    $ref: /schemas/net/mdio.yaml#
+    unevaluatedProperties: false
+    description:
+      Internal MDIO bus for the internal GbE PHYs. PHY 0-7 are used for Port
+      0-7 respectively.
+
+  mdio-external:
+    $ref: /schemas/net/mdio.yaml#
+    unevaluatedProperties: false
+    description:
+      External MDIO bus to access external components. External PHYs for GMACs
+      (Port 8-9) are expected to be connected to the external MDIO bus in
+      vendor's reference design, but that is not a hard limitation from the
+      chip.
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: dsa.yaml#/$defs/ethernet-ports
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
+
+                sw_phy1: phy@1 {
+                    reg = <0x1>;
+                };
+
+                sw_phy2: phy@2 {
+                    reg = <0x2>;
+                };
+
+                sw_phy3: phy@3 {
+                    reg = <0x3>;
+                };
+
+                sw_phy4: phy@4 {
+                    reg = <0x4>;
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
+            ethernet-ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                ethernet-port@0 {
+                    reg = <0>;
+                    label = "lan1";
+                    phy-mode = "internal";
+                    phy-handle = <&sw_phy0>;
+                };
+
+                ethernet-port@1 {
+                    reg = <1>;
+                    label = "lan2";
+                    phy-mode = "internal";
+                    phy-handle = <&sw_phy1>;
+                };
+
+                ethernet-port@2 {
+                    reg = <2>;
+                    label = "lan3";
+                    phy-mode = "internal";
+                    phy-handle = <&sw_phy2>;
+                };
+
+                ethernet-port@3 {
+                    reg = <3>;
+                    label = "lan4";
+                    phy-mode = "internal";
+                    phy-handle = <&sw_phy3>;
+                };
+
+                ethernet-port@4 {
+                    reg = <4>;
+                    label = "lan5";
+                    phy-mode = "internal";
+                    phy-handle = <&sw_phy4>;
+                };
+
+                /* CPU port */
+                ethernet-port@8 {
+                    reg = <8>;
+                    phy-mode = "rev-sgmii";
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
+                ethernet-port@9 {
+                    reg = <9>;
+                    label = "wan";
+                    phy-mode = "rgmii-id";
+                    phy-handle = <&phy1>;
+                };
+            };
+        };
+    };
-- 
2.51.0


