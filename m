Return-Path: <netdev+bounces-137473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD5A9A6993
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 15:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B00CB287E5
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 13:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1A51F9420;
	Mon, 21 Oct 2024 13:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDn5DfRH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AED81F8937;
	Mon, 21 Oct 2024 13:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729515765; cv=none; b=BvpB9jjl9EFRzZnTG3pTmHexwH6zfR/KL0YJGRd0P0HJRnXPK8D+UIzOZENgGNaqz7e8mFcBBxTxBLS+k1A8yy3jYQwSQq5p++SpJ1WRkQA3BWLMkJ9EJYtB5lyb5v6gIXM0zJYzm7J0QwoVJ+E2QxJQhmXxG0brf7GXpFRFGrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729515765; c=relaxed/simple;
	bh=mTWhh5YskeahCYpepWwIgALufxGc03XzJn663s8kfJI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQB+lC8ZrznOQnK+ns9AV7uZiZlmugse7b+NT/Rve8bmXqnTBsRbedbTEDohEURsiYpZfy+LF60M+X/bAkvZsHu4fXrDt2nymiKujJVtMQO49IwY5vuk+qWWNoXak7yPlJFFIlcAW3m3hi+Zv7qbGEdni5flt72Q/W3r0gmOfiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDn5DfRH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-431695fa98bso19811525e9.3;
        Mon, 21 Oct 2024 06:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729515762; x=1730120562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7KDWJEWLZJ1CVUWk2MFAM/b9RaQi8+CWSryFDS8nn9c=;
        b=GDn5DfRHP5I5KjTQBmB5/bMJ0vyPvipMbt0lxuQFJGas1MtBXEjn4acevyg2lT2xQR
         EBgDBzMVnEX/qc298aegheMiS4MIYMYFWdQQter4edCnQ20mOUJlQa+9vElEYKTO8KAd
         U4p0w0hC+y1YOCMgb0bbMY8rz25a+f4VfJ4JDNtEht40dVVpR86o6HeECNw2z4Wpc5ir
         wGflBjop/QqYePoybB/Np5dedio2UZY2044MufQkZd/G8hFvSzdkK7581+NaFb4i5xfj
         p1H5xj70o+q9ZgG+3t+//ZyUKKQaVc1GADQmvqx4oSdjxYvS+suLWNYftNPaxqFzkvgJ
         MlOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729515762; x=1730120562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7KDWJEWLZJ1CVUWk2MFAM/b9RaQi8+CWSryFDS8nn9c=;
        b=I05JrCCT47Cseq8kHAxsic2j+wkm95HpI3EJTDPzbx6FBdBD3xvM+hD8zoHkNTzAPU
         c9jsmraSG4OvLhbBRpXeX0t2bKT6YDLuifW+R/Gbo7BFBWzTLEtuCb/GDj4jd6YykDqb
         CgAE9QR+1q+RAPCPI3YyHU7O91F3MTgJ4jxiOIa1l84Y8Yd9MeBxkmzbFkw2p6Ufh20s
         aQ1vUemox7t3nRKAabTFDPNQf/JfzUkDD3A2o9T6Tu2yeXclEXgTRSoUAbEpDNxf0dgk
         RsbQHzHw4U38Nl30hg+aTMnjQQCltQiaf9vW8Xtn5sQz5jDdkN5WdUMuffIB8y+yTCDt
         xZ2A==
X-Forwarded-Encrypted: i=1; AJvYcCVif9aBZcNepbcnL17vY0+OlYAgNYwUn3WN2c2upb+Wiao3h5/jGpAsDNwRPx0UFRBcXbHi6KUvIWayZCE5@vger.kernel.org, AJvYcCW7StcuhSgswJVXRTYQjBlPJKwGtXWdx5dIuJwbQozJlbMUVARsfanH/HzHLW/5BVja91USib5F@vger.kernel.org, AJvYcCXKfwGoRD4BSD82HtaHRtJVts5TQAn1A32bWAHFigM/1GkaFnq1Lbz3SBgzxpS745ASZWvd+rx+ssHf@vger.kernel.org
X-Gm-Message-State: AOJu0YyRwe+7Hr1e5vHhHoAorFmuJO43R7Q9tG6/FOru/xEx3PMlvJZ1
	uPQeSpKa0g1tFSOSX7dgdGUeqIOaV6YlzUXsmYOuVkKbitOJbWcn
X-Google-Smtp-Source: AGHT+IGF2Q2tTuZQbVSZqD8BAKwHRLUIubueT3PHeLHDrHhpON7G/eioiMlOqDAAeIRrgx6VjgRikg==
X-Received: by 2002:a5d:5004:0:b0:374:c640:8596 with SMTP id ffacd0b85a97d-37eab7263b0mr6449258f8f.32.1729515761255;
        Mon, 21 Oct 2024 06:02:41 -0700 (PDT)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37ee0b9bcfdsm4295329f8f.103.2024.10.21.06.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 06:02:40 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
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
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next RFC PATCH 2/4] dt-bindings: net: dsa: Add Airoha AN8855 Gigabit Switch documentation
Date: Mon, 21 Oct 2024 15:01:57 +0200
Message-ID: <20241021130209.15660-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241021130209.15660-1-ansuelsmth@gmail.com>
References: <20241021130209.15660-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Airoha AN8855 5 port Gigabit Switch documentation.

The switch node requires an additional mdio node to describe each internal
PHY relative offset as the PHY address for the switch match the one for
the PHY ports. On top of internal PHY address, the switch base PHY address
is added.

Also the switch base PHY address can be configured and changed after the
first initialization. On reset, the switch PHY address is ALWAYS 1.
This can be configured with the use of "airoha,base_smi_address".

Calibration values might be stored in switch EFUSE and internal PHY
might need to be calibrated, in such case, airoha,ext_surge needs to be
enabled.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/net/dsa/airoha,an8855.yaml       | 146 ++++++++++++++++++
 1 file changed, 146 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/airoha,an8855.yaml

diff --git a/Documentation/devicetree/bindings/net/dsa/airoha,an8855.yaml b/Documentation/devicetree/bindings/net/dsa/airoha,an8855.yaml
new file mode 100644
index 000000000000..861c47df5bde
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/airoha,an8855.yaml
@@ -0,0 +1,146 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/dsa/airoha,an8855.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha AN8855 Gigabit switch
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description:
+  Airoha AN8855 is a 5-port Gigabit Switch.
+
+  The switch node requires an additional mdio node to describe each internal
+  PHY relative offset as the PHY address for the switch match the one for
+  the PHY ports. On top of internal PHY address, the switch base PHY address
+  is added.
+
+  Also the switch base PHY address can be configured and changed after the
+  first initialization. On reset, the switch PHY address is ALWAYS 1.
+
+properties:
+  compatible:
+    const: airoha,an8855
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    description:
+      GPIO to be used to reset the whole device
+    maxItems: 1
+
+  airoha,base_smi_address:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Configure and change the base switch PHY address to a new address on
+      the bus.
+      On reset, the switch PHY address is ALWAYS 1.
+    default: 1
+    maximum: 31
+
+  airoha,ext_surge:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Calibrate the internal PHY with the calibration values stored in EFUSE
+      for the r50Ohm values.
+
+  mdio:
+    $ref: /schemas/net/mdio.yaml#
+    unevaluatedProperties: false
+    description: Define the relative address of the internal PHY for each port.
+      Each reg for the PHY is relative to the switch base PHY address.
+
+$ref: dsa.yaml#
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
+        switch@1 {
+            compatible = "airoha,an8855";
+            reg = <1>;
+            reset-gpios = <&pio 39 0>;
+
+            airoha,ext_surge;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    label = "lan1";
+                    phy-mode = "internal";
+                    phy-handle = <&internal_phy0>;
+                };
+
+                port@1 {
+                    reg = <1>;
+                    label = "lan2";
+                    phy-mode = "internal";
+                    phy-handle = <&internal_phy1>;
+                };
+
+                port@2 {
+                    reg = <2>;
+                    label = "lan3";
+                    phy-mode = "internal";
+                    phy-handle = <&internal_phy2>;
+                };
+
+                port@3 {
+                    reg = <3>;
+                    label = "lan4";
+                    phy-mode = "internal";
+                    phy-handle = <&internal_phy3>;
+                };
+
+                port@5 {
+                    reg = <5>;
+                    label = "cpu";
+                    ethernet = <&gmac0>;
+                    phy-mode = "2500base-x";
+
+                    fixed-link {
+                        speed = <2500>;
+                        full-duplex;
+                        pause;
+                    };
+                };
+            };
+
+            mdio {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                internal_phy0: phy@0 {
+                    reg = <0>;
+                };
+
+                internal_phy1: phy@1 {
+                    reg = <1>;
+                };
+
+                internal_phy2: phy@2 {
+                    reg = <2>;
+                };
+
+                internal_phy3: phy@3 {
+                    reg = <3>;
+                };
+            };
+        };
+    };
-- 
2.45.2


