Return-Path: <netdev+bounces-214260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A90B28AAA
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 07:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F333A1C8727A
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 05:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EDB1EBA07;
	Sat, 16 Aug 2025 05:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBoR76S0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AD71862A;
	Sat, 16 Aug 2025 05:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755321994; cv=none; b=imeIQEEx4Wg2FNRnFqKmwVHx+US7zuqZMPIEttWflfQA8YrzY+tChE74PYwv10yqhTDRDgUvgBYGMcmR0ZrFCH8fYaAj5o/7YVjHhLy+ye0KptkEmfW1pOfAIZMxf9hMsDzdOVue5kbbZmXiWO9HWQpz14SQ8w54lVzFse14ZYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755321994; c=relaxed/simple;
	bh=YmP1CgpjY8vKQ9vOA7ok6UFf9+xXv+41pI4u+6ESdPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gSMRxQn3QFrkW9Yva1vflaxpmGii5flO/WQJn/QRemKrRQP96O7JYFk4Ih2z00rM39xgvRuTp+JahL14t4xoop+Okszuw/8Z0m6k/ueJNwSO11NS2beYDDaj3ZrjucLHuq4fgfChG6EgbV1zPWwkWaPzaCNfdlYOYz9vTpwwpec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBoR76S0; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24458194d83so17992185ad.2;
        Fri, 15 Aug 2025 22:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755321991; x=1755926791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DI2xUDwUxegvJuyoRtpkKubePNbnN/R+Y255PFNpvK4=;
        b=GBoR76S0P06VUfMEjnhI/XSImsw2jr4RYPaYkQLOYT5YBhcNGOqSTBMpqwMxvrG8yo
         xz8Zrsb3PTEee21LQhunPY3gzmWd+ikjknDGH80ZzgHLWq1GOXhzCErmu+V4RfzzasAi
         yozM+CZxf9tQd7yhm6MoCyvzcrv9FftWy/uqp15BjQCWUWNBT2heXAHfwgUAO8PY3V+P
         JPlUQvj8g/ilTesJbN+7wyQbNDZo13s0PkUD1I48gcllQt/exQ93vILC5cshvpWjUT6w
         I/FdDLBljgcJqZXRuewaVv7co6NWijYQDAws5V/TmXTPRjMO66B11l4IWt/7IC6leGHu
         i85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755321991; x=1755926791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DI2xUDwUxegvJuyoRtpkKubePNbnN/R+Y255PFNpvK4=;
        b=SqlJBkcZpG7pZa+88dvc6oEOfkVSpWsPiXpYPVM+x5RLm8ROqkx/BZP0bugWvV0wMI
         6gNg8pl1w8Ylk72Kv4R0O2FfMlJ2unH6mygUcNbcr2f8KkEQvjop5Xu+soKsjg2x/1ux
         iri4IWqpVGIMx2WLcJfNoyC/CL4sa1FJyQ3VGqpRQmJ8YvYor+yzR6oyxjoGjYcRF/Jp
         3zKjo9mmc6lseIcjzTlS7RFBYdc6cvfIhikRPhKW+fZILKg/RrGcadZeO9+jMwwQuxvq
         0ZqvLSDe8Xozb/CosKi7WfJgjUbCoKQ3PKjyngcRDBtrIqXoxpMoPxMz7TvFh0PYkUDr
         N0OA==
X-Forwarded-Encrypted: i=1; AJvYcCUXwXIBoBlWle4p2SKvXzI9DcGl2WyxHkU/dmSoC9SBMpI/SH3uzoQ/zp4bX9n99Y3RlWNgZUl2Z/PMVx2/@vger.kernel.org, AJvYcCV7aKNSyx6yZ9eqSJq9j89eVUrcEEJ+dFk38RDQkqP8gaN6jUs6Z4D8NYHu5faUi8m9VP2WWltX1Tml@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo/fBW40htu7ioyRgy2vCQVFmd4OSVIp6jXnYFI+bUyLZNl4Od
	qcPsPv2a8bVBUxC9r7ZXFYail4rpD9bTmVAJtC/AEsXqt70JsGAli5+DChjNesNvNhw/Pg==
X-Gm-Gg: ASbGncv/Sp+7/IIAwLDo4d5QXuL48wdHTsi2qYlDyFHwbSShgoAwDWRbtzYBA9GD5qK
	8AwGOJc/0EZvHER7DNNFwDiNBiOz3kWn8xNFIStpr0y3roZH2oah1PeV9hdc/r7BvNaTzbrcRFi
	LShmE6VkR0bdsA++3eR7o6gjnKF5BqH1NHPqAuJnDaN7aIBIuKNO1I+0Qo79nl0pq+Toxc3E0Wq
	Ib9FYijqXdDQMzdjBCSFemNdQQejSNJtZS6alFDImyjcC4XVKmqbGIIUDeqqLHSHB7Kx7w5NsQU
	l6V/ZysGh0lzaBkpS6Ml0ngO03XDBMETTLTon1MAFFTrq00RVNy7DgcSaseAe4hKVNUVlgho28r
	WCTdkfgRdholsGXleCZ2rvy7aKMuB3A==
X-Google-Smtp-Source: AGHT+IGv0P8MVsBSKWftikcoj46n/co5VH4B8+R2CmQZ+FMrx/HHbWwmNtV9EnWx9MEWwLA/kAvPJQ==
X-Received: by 2002:a17:902:fc4c:b0:234:914b:3841 with SMTP id d9443c01a7336-2446d91628amr81058265ad.39.1755321990829;
        Fri, 15 Aug 2025 22:26:30 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([89.208.250.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446ca9d016sm27225805ad.35.2025.08.15.22.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 22:26:30 -0700 (PDT)
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
Subject: [net-next v3 1/3] dt-bindings: net: dsa: yt921x: Add Motorcomm YT921x switch support
Date: Sat, 16 Aug 2025 13:23:19 +0800
Message-ID: <20250816052323.360788-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250816052323.360788-1-mmyangfl@gmail.com>
References: <20250816052323.360788-1-mmyangfl@gmail.com>
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
 .../bindings/net/dsa/motorcomm,yt921x.yaml    | 166 ++++++++++++++++++
 1 file changed, 166 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml

diff --git a/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml b/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
new file mode 100644
index 000000000000..d93fa24e0943
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
@@ -0,0 +1,166 @@
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
+  motorcomm,switch-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      When managed via MDIO, a hard-configured switch ID to form MDIO reg addrs,
+      to distinguish between multiple devices beside phyaddr.
+    enum: [0, 1, 2, 3]
+    default: 0
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
+            motorcomm,switch-id = <0>;
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
+
+                    fixed-link {
+                        speed = <1000>;
+                        full-duplex;
+                        pause;
+                    };
+                };
+            };
+        };
+    };
-- 
2.47.2


