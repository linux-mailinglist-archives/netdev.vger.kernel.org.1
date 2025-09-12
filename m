Return-Path: <netdev+bounces-222392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8773FB540A1
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 04:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E864C1C25828
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 02:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1742221DB0;
	Fri, 12 Sep 2025 02:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEVKSK30"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC80218AB0
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 02:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757645273; cv=none; b=j6FVl+g8NG6tJLkhX5XnlillVC5bhYlFYb2xU6EoijbPWjsbygmRfCBkq2addwHZ1t+RIiiGLcGeYMHIp3y27xg/O2xqsJgr34aapmKT86VhjHPpXpYgJw1tT5BSYG76bAsSZrLiEh4qdrx49Hdmd9ZiIfedV2/KMNpFs4vnMh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757645273; c=relaxed/simple;
	bh=oJxaNca0ovdmuYmZjer2XkXA3TvMYmaEFZFdNaFPxw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sdk4tVMqX+2gYcu6Lsq0hv9Ffx6Zfy8UgisxF5icKhXjeXfaLZ+GiKwYyMiFplyqSFrRaVVGMsB0SQpwG9R93NOnd9H86fsiYVR62AIZqx+TjqrREIfty6ZsvMcNzDp+oEmzFvRHFduuDTGjWLL0V4SeDyMn+18o+FbagmYmCuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEVKSK30; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-25634c5ebdeso12837265ad.0
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 19:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757645270; x=1758250070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxozejcHmlMrgp5l/pyBiJVMbx034MAKbgCFUAbOzIw=;
        b=dEVKSK309CHrs/AT75t/sQIuNS8RluiLjVNL7uHlTt4WZW2j4R8jgD0FBNkJmjWH+E
         f1wC7oRo+9LzCthsdoefxdnfgCJ/G3UFI4NDEEo2zenExNOXstr7oFg1fAkf1O9UQwYU
         P55fxQvgLWCeaeSr5+Gh69L8kj5+j2Bkb26vdZMnRu2UtkEC+V89t3ASPrrFHHkjdNml
         7J7vxN6mIAUZ1KX0vpAVm3YVBb+NKdGaI474ClONXUH4nykndxYIAML5aojD5VgdMe6K
         D8Ir1ZK5llLbmVOW7Q0thh4Jk8+9eKDiysRuqgvbTw6I2dIySB+R/UwuKvCD0v6sPyMB
         yaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757645270; x=1758250070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxozejcHmlMrgp5l/pyBiJVMbx034MAKbgCFUAbOzIw=;
        b=mipBKuEl4WC9iCj3y6JefJeZSfA5Nstz+lpFzR9xvJSviVgsxsZ4iR3JszmVacn7+1
         IYXPLTmoLOK1zmVfDh2ds9cVfRIYu0fOH1ud668Kt8qy2gWbNOuU9bIN0Z2g+3rmM+dA
         MjydSexlH/bHGZHZUYme/4iavelmhnom7KuTHOhPGzh8HbbvSEDQmsygk6g/qXq0qR28
         Xl/PXdxE5KDF5kXPbGND+TYVhnydklG5hXvo8VVUqjWORMK5iuWQP9Pz+cf+1dudHgjA
         lt/V5pSp/8imRykcHF19K93hNJ1iB1ZI9aRSc9NmJuflDHONpTpMUJ432PtHmzJXECyE
         Ylzg==
X-Gm-Message-State: AOJu0YxLnMEHJQYcRI2tq0Z1W/O56YWQHclx6UoUHRtp35yEk8LCIi8+
	GxA5Y1fcGqyoLDjRdJaxXXqS2ycTI2X3lXPz4I2c1aL0JsWQJTSLwtOtrsn2o9Q6PfM=
X-Gm-Gg: ASbGncsLV56FUtPleLdwlBgvSbKMcjpfyIi6uljIHdu1uieFKlgQN8kA4dDCPv8tRuB
	hkkjTKoqDunPNc4Ssn1KEywjRnH72H7YVer7vwg7GQSiPe+RZDe3NXd4BSEKPZKURousg/1XXkn
	Kqfkhq/XekcqlljB6k3hYcdMiZ9xg0+k2yWJx8MBO4uxH2FEXbpKzRR8Bn5S8GeFTAl6/9V0JTj
	Ptu+Zuk78iHSRAjp89Kr8RmykMzaTPfWzw3ixkILIEst9Ly/rz7NJ3Aq78KiwDThp023n1BklAV
	dfLbCw2ENTanYAJv/sJZWN4huEh7fqDaxxUMEpT3mRIpOUcOkzA4iDrP8MdaodjatyoDCDT8Rkx
	W/VtWvVowSyfDY0DAyF5U6AJp5jndDGkvlh+yelnPVTYZZ60zqFs=
X-Google-Smtp-Source: AGHT+IEskqrWeBktd65hhkOD1q5+PE0GWr4nmLxSIvSHqdI2VxvU2aC9ILHlNHAU98YI7hdaK2Mlaw==
X-Received: by 2002:a17:902:d542:b0:25c:25f1:542d with SMTP id d9443c01a7336-25d260792a0mr16364675ad.36.1757645270036;
        Thu, 11 Sep 2025 19:47:50 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd61eaa42sm4349827a91.5.2025.09.11.19.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 19:47:49 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next v8 1/3] dt-bindings: net: dsa: yt921x: Add Motorcomm YT921x switch support
Date: Fri, 12 Sep 2025 10:46:15 +0800
Message-ID: <20250912024620.4032846-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250912024620.4032846-1-mmyangfl@gmail.com>
References: <20250912024620.4032846-1-mmyangfl@gmail.com>
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
index 000000000000..7648aad073eb
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
2.50.1


