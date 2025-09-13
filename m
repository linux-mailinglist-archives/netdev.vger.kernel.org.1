Return-Path: <netdev+bounces-222762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEEBB55E77
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 06:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B3F71CC1D9A
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 04:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8832E11AA;
	Sat, 13 Sep 2025 04:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awMIp+tk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F152E0B6A
	for <netdev@vger.kernel.org>; Sat, 13 Sep 2025 04:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757739052; cv=none; b=d4SQBTIzAoi29/qxmM6hScs21IUEky5fvxs65dMedGjacMn38j6WqV9moYt3TL/Nk4wIoWkF6RSfJvIrn3ie6dPvsu2tkfyTKjgEzBb5247hUXdeEZ7P/b9hfaoNKCZf3B9RBumGu6RpsXnZR9LuLkO+WWaLkizcOHpv3F7e2Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757739052; c=relaxed/simple;
	bh=HOk54y6OqjGQzjq2mDerj8pXhvjD5hU7XhoeSO8pNzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uk4peje+mascDpqOBXT2kCbeYvRLWVlHzMRwi2o+DEzamOi06k/bdvLy6AVcOaa4Od/8DlZewrN3LP50L9E5S1BS/PqIfXq4363RiLY2BaB+OWYVDk1uueOUFTMy5u43Uiy6CH4Q0Y6w2481zt30yV4B1L3a75dlF9fa79yLQic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awMIp+tk; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-25669596955so24469865ad.0
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 21:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757739049; x=1758343849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=isdQKDzL0iCi7UVp//a5ZK7jk9WeZbzylsZwifxaWLk=;
        b=awMIp+tkyJsuTGBXQeDyWnbZUnuIMfRvsFgS6VKw7flXdY8bUrDst2wd5sVz1w9W5y
         8Khm7SaNUjRSx7Olzo6OpIb7avgv9BKKmup6ww/r9y52SDQWSz5uBAGr7SSoKHf7SbpS
         x/7Up7yYoxIGHKaWe7JvLgl/l8o1yoUEc8xQ1tFgMaZWHAx1XgnVa/Z9z9fc511uQUYM
         kwZCa7yBynNLw+KBkYlTFBWppMV4dgMj8SHRgXDnGo/HxXs76H/uMASQHSDc/jhHxAYc
         1qI/awNJE3jPwOLvoRyXCb1w+bJSVkhAdwh3Rj5aNyctsEnb/tW5JQ8VS+Yh2ZEY3KGm
         D1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757739049; x=1758343849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=isdQKDzL0iCi7UVp//a5ZK7jk9WeZbzylsZwifxaWLk=;
        b=X4IgHk7/OFEhtejC2EQJ/9UZKXFiMXuXviyrzItL8oW98yBapGMvOV8MpNFPQgyixo
         K3Qr6rVLTEW7Lowd9k/NGV1hrVqI79aWG15KxG0UxGSWHRaQ+qOUso+mdM95+AQFaLwD
         Br++BNxm6MjVIwuhGZx6QDvuO4q74Etekm0Q9bAAEoGJuwn3rij2WKbSzGjn0PfiE9Cy
         rDaYa2Gx+bpoppTHq6vXRzMr+J4g/Tmt9IFuA0Tl/JZP5oYF7qa3BeHfVSL4c/L3YCnW
         IXsESVpi2JipCuOMwcmB0uBEGDKqulBpVIKy4bgZgCI14gymT0o3DDxv8tO4SDe7F8xm
         Q98A==
X-Gm-Message-State: AOJu0YynQ0OTaDkEPA+1ojhKwfz+BRGzHsgW9IMES53mtsqVQ0NNqWah
	CyAHx6uGxFNIPonnzyyI3Fx3cam8auKqBgyRcXhmUbTexirpLUs/hNKJppvoJNxO21Q=
X-Gm-Gg: ASbGnctFlBHvu5NRVQNkrR+osab/GjCX7ED7ntK6/zg6kvjCf8c+V8SsOWPfXSaI9G2
	phW7m4zoTK5vqUpITz66/bRUc/AoJh/6iHc7bb/jo1tHAXopFnGCOI+q/yFLnmt/5as0CR9D9Yt
	FT7QXAYihlyYLulcxsK6b09I7MNXMp91ggnp/QADRvqp1qaUj9onir8HGIOJVTLg+4MuI9khKxV
	D91pNZ7xQvhhtTYe82M/oEr9vs20Wogc83iWSwFkVVV9+NPhrmptUkJg/VfCCbnHv579l1bXN1Y
	4YOFt0itFMiMWmUpBM/gpECMRny4YLvxgU9gTTdLiPyihvvDADrBSGxMByLGLQ1vq3ng1t0eqGb
	QqX21iCl7or8RmuwVpo487fsH08lcKg==
X-Google-Smtp-Source: AGHT+IGIKchvyXxLABK6VyTMeaLQRNxHbQkYh9SD6HjwQydzb/kzaB9YXIHqajNiGCv52c8thm+5bQ==
X-Received: by 2002:a17:902:d2c2:b0:248:96af:51e with SMTP id d9443c01a7336-25d27d20531mr72081065ad.45.1757739049494;
        Fri, 12 Sep 2025 21:50:49 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b20e01esm65139775ad.126.2025.09.12.21.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 21:50:49 -0700 (PDT)
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
Subject: [PATCH net-next v9 1/3] dt-bindings: net: dsa: yt921x: Add Motorcomm YT921x switch support
Date: Sat, 13 Sep 2025 12:43:59 +0800
Message-ID: <20250913044404.63641-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913044404.63641-1-mmyangfl@gmail.com>
References: <20250913044404.63641-1-mmyangfl@gmail.com>
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
2.51.0


