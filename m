Return-Path: <netdev+bounces-193729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1EAAC5972
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 19:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71B564C18B1
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 17:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27483283FD6;
	Tue, 27 May 2025 17:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iw3b9Nie"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ECD281512;
	Tue, 27 May 2025 17:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748368587; cv=none; b=n1KfPrBA4VMd/VOrbJsH5etiB93B7INL1fYKbjpBVFwqBJieywWACIYNc3uKZMGGCYqmpoI7eaCkzWw9RdoPSDTrawB0sKtw6VQ6ErclWNa4uQYGg6nIro21qlq9rmwuwW2WiJJ/ceFakGrfOGS5jmsB9U/yE3w8mCiRQnJiKDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748368587; c=relaxed/simple;
	bh=ysE5VQEeovJqr9bZqisHWPRj0Fb3prPMdXXWvIA1Iwg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ASu6YF+JnWDq7E9pSIxzwLO4OI1F/ksm+dUz7VfeStXTC/y8NWercjqax6LdWDV0kEEVvERGIewYVAX/0VU7mo3GyuUW2F/xzIBLTPmM1rGtswOwmL8AE/bm0OZth+wO1pN3ayh28J03rnxRT5kwUF9oSSTfJVO3ZqW7OjeOCc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iw3b9Nie; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3dd24c86779so21821185ab.1;
        Tue, 27 May 2025 10:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748368584; x=1748973384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75t1KQGtX7DtR0KwXgxMTDEvGLkyel42aN9/Vltyf4E=;
        b=Iw3b9Nie2JoZxmHvOcNo3WoQF6i3w7LILz1pxGBHuJ15zLENaXcVghKqG7TWKWZU0R
         Ja3H7gEQE2JH+KdsDcGRd9KnjhhrQBDVmwS99Qt3OWElleszuPqIdZLBIaJDYByIcWzy
         iYuRanEQMwc/xLGvCorXiTQ7pxmc8cpnFdfgTDzQ55JqzSPTsWjMZmCKJwlAZ4doxynv
         xiAPEBo0SaS01NHQWj793mZwnOegfL7d3I4pzgzc6L5p5VcNr0NknJhNV2AsTChzbuqP
         3mz90avhGjIMlqTftgskbTLnApqg8Ryt54O4I2kzDsPqNYjL69A622qGQtFiSpQgDKwz
         KCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748368584; x=1748973384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75t1KQGtX7DtR0KwXgxMTDEvGLkyel42aN9/Vltyf4E=;
        b=PgDitu8B9yBpavw5Egd16MksUacrBQtyc0QuVbbb5kUp79sCHT61ebSHTjzyvuZtNh
         Pv2q78u0VDoHLGW9NgvtOoQPuRG+zWymX/mWgzRemKKVGSdYFtVYIChjDd2WqyutCtbL
         S/316XMzGTtGUbNoGweGL2uSaMsJpIWoD5TpCcvyRTYSDCEthhNmqvhOSxPJlAcZ210l
         Vs1NtVvak5Y8UG2uOHvr7Ou35cfPHSN2ZtQDOMnVEqnaWhpwlRcQDPUIJ49masldSq7u
         rPkcIqJJnQCBKu98upvu8RpOAv0dL82vupuNVgZ89mxfUn26VZne0wcZCUa8MQ27RrTz
         rcPg==
X-Forwarded-Encrypted: i=1; AJvYcCUvDjoPI4Yeu6PwwH5tYDm7Z3rvGINGVNgwJpX1okubw6leeN+E0rXOW1Z5vsALJ+gewbLqhqRiMs7HrZ54@vger.kernel.org, AJvYcCWeuALSc6LQsQ2+7wEqInQS8rSyJFOB9qISlLzfM4YXBZomvwVLvFUgh4QTfXKH+F6pmWHcHzscCV7H@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/5kRqnZsisOMErJJmPhYOYKHo5wXVdhwKjC3E94SGfdkNS4nM
	DWhYwviB90rUrfat6eiHFPAUUotTYNMqOiE2Kqc/RaUrANXbIJCfMTf7xnET+1guKas=
X-Gm-Gg: ASbGncvIPKhYNdCVEtO1gTu9sjT9SswMJip+IMYxnCPKb2Q2nOPDQjO5amPCU4yw6ut
	fWQtzsLOuKlLymBeigWxxcgbxgpmKZ8F/ClptT7CV37/UOF0f5FpZsC+6ukf2rVAUknq3asaYcX
	mCIY486k/h/swX5LVWnNCwaotjfNpjtBtFt0UXjW9Qa7l7l6A+ZXDQzKUe0uDa7Qk/D3C60caqH
	Km9udmBoL9ZyRYCcFjj+9n4DTmZmQLyENnF9/SNmZR3bpQj+R8mrj5g8zCslvexThTRj1Ivy9zE
	M7rhUb9Pg4xBSDrHY02qLBgHU/I/EqLW8bvll5B+E3zZaM4LLE3Neom4Pc0T3MkD3ql7hPlOGBz
	RopWkIh1RrngoaxOaP/9y7oHAonutYw==
X-Google-Smtp-Source: AGHT+IEG1Ty/l3Gh00PtWxsgabl40eUie4mjzIcYjsL+B8so87NPY18sPvIj6HQRx+VZNV4Xgx4J1g==
X-Received: by 2002:a05:6e02:144d:b0:3d5:8923:faa5 with SMTP id e9e14a558f8ab-3dc9b6aa36dmr108298815ab.10.1748368584073;
        Tue, 27 May 2025 10:56:24 -0700 (PDT)
Received: from james-x399.localdomain (97-118-146-220.hlrn.qwest.net. [97.118.146.220])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dc82e014f4sm38082275ab.40.2025.05.27.10.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 10:56:23 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-sunxi@lists.linux.dev,
	James Hilliard <james.hilliard1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] dt-bindings: net: sun8i-emac: Add AC300 EMAC1 nvmem phy selection
Date: Tue, 27 May 2025 11:55:56 -0600
Message-Id: <20250527175558.2738342-3-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250527175558.2738342-1-james.hilliard1@gmail.com>
References: <20250527175558.2738342-1-james.hilliard1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Allwinner H616 EMAC1 can be connected to an copackaged AC200
or AC300 PHY depending upon the variant.

Add a new allwinner,sun50i-h616-emac1 compatible and example, support
for the allwinner,sun50i-h616-emac1 EMAC1 MAC will be added later on.

Add nvmem-cells and nvmem-cell-names properties for the ac300 efuse
based phy selection.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - fix dt_binding_check
---
 .../net/allwinner,sun8i-a83t-emac.yaml        | 75 ++++++++++++++++++-
 .../bindings/net/ethernet-controller.yaml     | 26 +++++--
 .../devicetree/bindings/net/snps,dwmac.yaml   |  2 +
 3 files changed, 94 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
index 7fe0352dff0f..3a8c31dd9ae7 100644
--- a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
+++ b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
@@ -18,6 +18,7 @@ properties:
       - const: allwinner,sun8i-r40-gmac
       - const: allwinner,sun8i-v3s-emac
       - const: allwinner,sun50i-a64-emac
+      - const: allwinner,sun50i-h616-emac1
       - items:
           - enum:
               - allwinner,sun20i-d1-emac
@@ -58,7 +59,6 @@ required:
   - clock-names
   - resets
   - reset-names
-  - phy-handle
   - phy-mode
   - syscon
 
@@ -73,6 +73,7 @@ allOf:
               - allwinner,sun8i-h3-emac
               - allwinner,sun8i-v3s-emac
               - allwinner,sun50i-a64-emac
+              - allwinner,sun50i-h616-emac1
 
     then:
       properties:
@@ -189,6 +190,42 @@ allOf:
             - mdio-parent-bus
             - mdio@1
 
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - allwinner,sun50i-h616-emac1
+
+    then:
+      required:
+        - phy-handle
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - allwinner,sun50i-h616-emac1
+
+    then:
+      properties:
+        nvmem-cells: true
+
+        nvmem-cell-names: true
+
+        phys:
+          maxItems: 2
+
+        phy-names:
+          items:
+            - const: ac200
+            - const: ac300
+
+        mdio:
+          $ref: mdio.yaml#
+
 unevaluatedProperties: false
 
 examples:
@@ -321,4 +358,40 @@ examples:
         };
     };
 
+  - |
+    ethernet@5030000 {
+        compatible = "allwinner,sun50i-h616-emac1";
+        syscon = <&syscon>;
+        reg = <0x05030000 0x10000>;
+        interrupts = <0 15 4>;
+        interrupt-names = "macirq";
+        resets = <&ccu 31>;
+        reset-names = "stmmaceth";
+        clocks = <&ccu 83>;
+        clock-names = "stmmaceth";
+        phys = <&ac200_rmii_phy>, <&ac300_rmii_phy>;
+        phy-names = "ac200", "ac300";
+        phy-mode = "rgmii";
+        nvmem-cells = <&ephy_acx00>;
+        nvmem-cell-names = "ac300";
+
+        mdio {
+            compatible = "snps,dwmac-mdio";
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            ac300_rmii_phy: ac300-ethernet-phy@0 {
+              #phy-cells = <0>;
+              compatible = "ethernet-phy-ieee802.3-c22";
+              reg = <0>;
+            };
+
+            ac200_rmii_phy: ac200-ethernet-phy@1 {
+              #phy-cells = <0>;
+              compatible = "ethernet-phy-ieee802.3-c22";
+              reg = <1>;
+            };
+        };
+    };
+
 ...
diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index a2d4c626f659..710e651851e5 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -45,14 +45,6 @@ properties:
     description:
       Specifies maximum speed in Mbit/s supported by the device.
 
-  nvmem-cells:
-    maxItems: 1
-    description:
-      Reference to an nvmem node for the MAC address
-
-  nvmem-cell-names:
-    const: mac-address
-
   phy-connection-type:
     description:
       Specifies interface type between the Ethernet device and a physical
@@ -260,6 +252,24 @@ dependencies:
   pcs-handle-names: [pcs-handle]
 
 allOf:
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - allwinner,sun50i-h616-emac1
+
+    then:
+      properties:
+        nvmem-cells:
+          maxItems: 1
+          description:
+            Reference to an nvmem node for the MAC address
+
+        nvmem-cell-names:
+          const: mac-address
+
   - if:
       properties:
         phy-mode:
diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 78b3030dc56d..a6dfed00c48f 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -56,6 +56,7 @@ properties:
         - allwinner,sun8i-r40-gmac
         - allwinner,sun8i-v3s-emac
         - allwinner,sun50i-a64-emac
+        - allwinner,sun50i-h616-emac1
         - amlogic,meson6-dwmac
         - amlogic,meson8b-dwmac
         - amlogic,meson8m2-dwmac
@@ -620,6 +621,7 @@ allOf:
                 - allwinner,sun8i-r40-gmac
                 - allwinner,sun8i-v3s-emac
                 - allwinner,sun50i-a64-emac
+                - allwinner,sun50i-h616-emac1
                 - loongson,ls2k-dwmac
                 - loongson,ls7a-dwmac
                 - ingenic,jz4775-mac
-- 
2.34.1


