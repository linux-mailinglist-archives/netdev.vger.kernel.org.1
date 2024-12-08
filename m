Return-Path: <netdev+bounces-149934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE7C9E82DB
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 01:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 890E7281BA6
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 00:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45EF12C475;
	Sun,  8 Dec 2024 00:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eH0QEZyr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A7E82488;
	Sun,  8 Dec 2024 00:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733617315; cv=none; b=Nh2FhatyA/1Nr0vKS3E0iSqe/WZNkYZDhXdA/duTJHgx7HeepkAqKB7BWmCHtbpz0V7qvD9Az2ZRHseotpm+3u8bqQwcnczk6i8zlOdX8g1Ke5WMwYvrsfNfdyei2/qSiTtuC6a/Tb3+MafTNAeDNQUaw8CmIRGaF25h5tAgHWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733617315; c=relaxed/simple;
	bh=sl3IKm/F/G1CKl8rn4MDKRLKe0S3XRcqztvFml4jHV4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KwkXTYydbDvy+eu+kw1dp8bFDyMBrPLhvbberP0TUVJqVJWBKmrNubJmAqah6V4+mJrp/6wrOF7tcusDpYc7qwMvLcL1CJUv5jYQ2W9MZ+Fl5ydeBwrO46oAXgjkZaa5uVh/dm2VZCzHz8PHfrEgBOXdNXh/zQn4avm7TvtgZUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eH0QEZyr; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434e69857d9so5082835e9.0;
        Sat, 07 Dec 2024 16:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733617311; x=1734222111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KidHH5eUrRS26Qq2Z1EbeJ29f1SSzWyXfw9ndMX9gzw=;
        b=eH0QEZyraoOhpCiratECLEvnd+urIHjLY0fruu81ti+bCT8gyexJT3gbhc2PX17F7l
         fIsFf6fJxh6HUP+VUamWgc0kH0PMPAK+fL2Q7wdfRx6KODYT8lgqw2vwOLd+Fz6b7Z9m
         dXJkd/AtduSQN2jX0dDw3vv7nLokku5oKCtJBnneAY9MeZ5isc3gOifPyyllXqZdZAdz
         Dc5cMctnIicdPtfwuvv9dKoEKhI2l5IzCw3pBcYc6dPQtupXWqB/1ufHokwcvWCB/Tb4
         AiS3vqFxwK5cmdt8TTeIO0zPs6QGs3u7jjoCv6RHHI7bjViKEfCZ5K8H3IorppRnhTba
         RWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733617311; x=1734222111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KidHH5eUrRS26Qq2Z1EbeJ29f1SSzWyXfw9ndMX9gzw=;
        b=AhLcCbQnolXAVzjAgzBUMUCCwkokHJ0KgmSj3Boorl9r4ws03B/E5FkhoSzL/rAd7L
         QnmfJWZgCLBLcnBNtYUpdxn7bI4EixM2R//32Mi6SmvD7VFN5+hMLFFs0lF1Q0wI7Aiy
         SEUqJIMqUpklH7TuHt/b+rnPioymXjvaNTVavPlLL9cKYeI6qr8KRvStjzu9If+0ss8T
         kc5H2pTRw/MAKO9I+BPWaqwBx4gZQEqUZommevO1giYXLZdNaIw/9S1rC3K3E+yoHZsZ
         b6JDloDXaPaaJ+R37W6HAcT1OpgXDzwSBOS/p5tc8Sr+BedIE0Kssl09woLCPf/9GQ4G
         4Mow==
X-Forwarded-Encrypted: i=1; AJvYcCU/ahBP3ij21tGbUZ2gJiHyV41f6GrD2pAvXpeWA+OQS6hMbhalzKY8vaSV15bJrLa00KohFVUd1NGowlDK@vger.kernel.org, AJvYcCUHcOwXG1o+teg76URKv+y6wv/J3Quv0CfffqIMo7elUMVXvyvP3xZybCFmeFlltxnzBvKZoeZV@vger.kernel.org, AJvYcCWL4DspH8zWa0UUu17KUHgfGy+EDqCqIRJGNiCU6mXFsTdiSQnedwdvpDKHaLsoYrgu6GXaIYlwOJ0k@vger.kernel.org
X-Gm-Message-State: AOJu0YyqqEaHzjE3FzfYaTXfYGWvNKgFIkFZDBduDOt46T5joetTStWI
	TWO9tVWwHNab0QpRXwrkuV0rMgmCz3a+eF0OeY5vqexr814d9NVy
X-Gm-Gg: ASbGncsfSQwQVTP4hPv3uRh4OgE0ufcNLwtiBAj2uoqqmVkmqn/fP5RcX7vNpqVbMhw
	jRNwITwi+CnpxSXKqK0PnadaHowVVS5JUjCnj4vWda4+Neen8td5kQN9AaBipHcP9UysPG3Q9ch
	AUcxrmAO2pSWnkVV6mLDrd1A+PLupz6HHYumHR2F5J1iiMdrGyz7etFKplZHWTd4tgNSLBNCNeb
	66znG7FGgrxe7HpeKyoLotkNlo5PdOiEdJh6JH42gvcAvaAxnRM8zgjydcNGyuoyk048NH9zUCo
	h+hkoQNp/UwGUPDPiJ4=
X-Google-Smtp-Source: AGHT+IF4OGyTTXkJj4ZIw4zicje56qIvFhU/yR3H8OHLmXzA5lA1dfBzdZjEahmdHmrKDRCZhlDGGQ==
X-Received: by 2002:a05:600c:6046:b0:431:9340:77e0 with SMTP id 5b1f17b1804b1-434ddeba4ebmr57301565e9.9.1733617310820;
        Sat, 07 Dec 2024 16:21:50 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38621909644sm8719170f8f.76.2024.12.07.16.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 16:21:50 -0800 (PST)
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
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: [net-next PATCH v10 4/9] dt-bindings: mfd: Document support for Airoha AN8855 Switch SoC
Date: Sun,  8 Dec 2024 01:20:39 +0100
Message-ID: <20241208002105.18074-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241208002105.18074-1-ansuelsmth@gmail.com>
References: <20241208002105.18074-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document support for Airoha AN8855 Switch SoC. This SoC expose various
peripherals like an Ethernet Switch, a NVMEM provider and Ethernet PHYs.

It does also support i2c and timers but those are not currently
supported/used.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/mfd/airoha,an8855-mfd.yaml       | 185 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 186 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/airoha,an8855-mfd.yaml

diff --git a/Documentation/devicetree/bindings/mfd/airoha,an8855-mfd.yaml b/Documentation/devicetree/bindings/mfd/airoha,an8855-mfd.yaml
new file mode 100644
index 000000000000..5d1ed5e7a52a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/airoha,an8855-mfd.yaml
@@ -0,0 +1,185 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/airoha,an8855-mfd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha AN8855 Switch SoC
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description: >
+  Airoha AN8855 Switch is a SoC that expose various peripherals like an
+  Ethernet Switch, a NVMEM provider and Ethernet PHYs.
+
+  It does also support i2c and timers but those are not currently
+  supported/used.
+
+properties:
+  compatible:
+    const: airoha,an8855-mfd
+
+  reg:
+    minItems: 1
+    maxItems: 5
+
+  reg-names:
+    minItems: 1
+    maxItems: 5
+
+  efuse:
+    type: object
+    $ref: /schemas/nvmem/airoha,an8855-efuse.yaml
+    description:
+      EFUSE exposed by the Airoha AN8855 Switch. This child node definition
+      should follow the bindings specified in
+      Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
+
+  ethernet-switch:
+    type: object
+    $ref: /schemas/net/dsa/airoha,an8855-switch.yaml
+    description:
+      Switch exposed by the Airoha AN8855 Switch. This child node definition
+      should follow the bindings specified in
+      Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
+
+  mdio:
+    type: object
+    $ref: /schemas/net/airoha,an8855-mdio.yaml
+    description:
+      MDIO exposed by the Airoha AN8855 Switch. This child node definition
+      should follow the bindings specified in
+      Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml
+
+required:
+  - compatible
+  - reg
+  - reg-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        mfd@1 {
+            compatible = "airoha,an8855-mfd";
+            reg = <1>, <2>;
+            reg-names = "phy0", "phy1";
+
+            efuse {
+                compatible = "airoha,an8855-efuse";
+
+                #nvmem-cell-cells = <0>;
+
+                nvmem-layout {
+                    compatible = "fixed-layout";
+                    #address-cells = <1>;
+                    #size-cells = <1>;
+
+                    shift_sel_port0_tx_a: shift-sel-port0-tx-a@c {
+                       reg = <0xc 0x4>;
+                    };
+
+                    shift_sel_port0_tx_b: shift-sel-port0-tx-b@10 {
+                        reg = <0x10 0x4>;
+                    };
+
+                    shift_sel_port0_tx_c: shift-sel-port0-tx-c@14 {
+                        reg = <0x14 0x4>;
+                    };
+
+                    shift_sel_port0_tx_d: shift-sel-port0-tx-d@18 {
+                       reg = <0x18 0x4>;
+                    };
+
+                    shift_sel_port1_tx_a: shift-sel-port1-tx-a@1c {
+                        reg = <0x1c 0x4>;
+                    };
+
+                    shift_sel_port1_tx_b: shift-sel-port1-tx-b@20 {
+                        reg = <0x20 0x4>;
+                    };
+
+                    shift_sel_port1_tx_c: shift-sel-port1-tx-c@24 {
+                       reg = <0x24 0x4>;
+                    };
+
+                    shift_sel_port1_tx_d: shift-sel-port1-tx-d@28 {
+                        reg = <0x28 0x4>;
+                    };
+                };
+            };
+
+            ethernet-switch {
+                compatible = "airoha,an8855-switch";
+
+                reset-gpios = <&pio 39 0>;
+
+                airoha,ext-surge;
+
+                ports {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
+                    port@0 {
+                        reg = <0>;
+                        label = "lan1";
+                        phy-mode = "internal";
+                        phy-handle = <&internal_phy1>;
+                    };
+
+                    port@1 {
+                        reg = <1>;
+                        label = "lan2";
+                        phy-mode = "internal";
+                        phy-handle = <&internal_phy2>;
+                    };
+
+                    port@5 {
+                        reg = <5>;
+                        label = "cpu";
+                        ethernet = <&gmac0>;
+                        phy-mode = "2500base-x";
+
+                        fixed-link {
+                            speed = <2500>;
+                            full-duplex;
+                            pause;
+                        };
+                    };
+                };
+            };
+
+            mdio {
+                compatible = "airoha,an8855-mdio";
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                internal_phy1: phy@1 {
+                  reg = <1>;
+
+                  nvmem-cells = <&shift_sel_port0_tx_a>,
+                      <&shift_sel_port0_tx_b>,
+                      <&shift_sel_port0_tx_c>,
+                      <&shift_sel_port0_tx_d>;
+                  nvmem-cell-names = "tx_a", "tx_b", "tx_c", "tx_d";
+                };
+
+                internal_phy2: phy@2 {
+                  reg = <2>;
+
+                  nvmem-cells = <&shift_sel_port1_tx_a>,
+                      <&shift_sel_port1_tx_b>,
+                      <&shift_sel_port1_tx_c>,
+                      <&shift_sel_port1_tx_d>;
+                  nvmem-cell-names = "tx_a", "tx_b", "tx_c", "tx_d";
+                };
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index fd37e829fab5..f3e3f6938824 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -717,6 +717,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/airoha,an8855-mfd.yaml
 F:	Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml
 F:	Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
 F:	Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
-- 
2.45.2


