Return-Path: <netdev+bounces-173336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E091BA58625
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 18:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA5943AD093
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 17:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7C21F8743;
	Sun,  9 Mar 2025 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPyLSBzU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA981F4CB7;
	Sun,  9 Mar 2025 17:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741541279; cv=none; b=SlM1T+KNR72K8tkLlsqcoUXFfWKoa0/eEbSE7VBcfHuP5lAtKr8j6SuXaPNF5fYGiJx4Gc5mlxC5/4faC7N+ZVnN+L8Fk4ks9TdbRLYspAak38YWtoqWMaHcA/9+qTPAd9yjudEnGormwRLJSdN8IivgB1mAdYEQxxlMoTxwDKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741541279; c=relaxed/simple;
	bh=9bY6vUzZCyenwibvnnhe2nuirbiQqqIdw7+rUQPYxMM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BEnpefbcZ171uugyeIvgao3VDWSEn1tZTSxgShv6ojqTLJs8uCWWWMx71PIJophfBanqfCm0V5FdfxmFfJefbgkmSN+4v+nJd2t4H//I97yGilI1mRgXIrOoNLgEm+u9+nzruCF/bOQJ808G78eJ3TBoIw9wscDzN0N+gsKl5KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPyLSBzU; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3912e96c8e8so1812695f8f.2;
        Sun, 09 Mar 2025 10:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741541276; x=1742146076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X7yydj1tnEV2f65Z5FfShnsABOUAALGH6EGqxdEbm+k=;
        b=HPyLSBzUT/xNlD9h5zSrPf7czdduKlgtRjqQtQFwiSVX3UwUyVnzfowjn45GzluxH7
         F8+IVErYtG/a2urAEzERdX0jbeEwpzk9FWDYONU+pSb2/Sd6d3evWGO3oCak0EdtLO0D
         cOw0X+gYAwelkJ2yTmwYx4ZorOaASPMjyHWKCJa1mb2Y2zfrBPpzjQLcCXzf1Qbq6+fk
         ypi5l31MoA0IyrSQJs86tMoiwakDWZGdp5EzUB26Sa0Rgcocx96ADbQ0yyDLYHDBwcdz
         bSf7+HQqdNVjqfoawA8DVGRljhdsOPNly2qTVaYX8tuM2NPsDZftjNI9h/ipuTfABZKl
         5dxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741541276; x=1742146076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X7yydj1tnEV2f65Z5FfShnsABOUAALGH6EGqxdEbm+k=;
        b=eJdFJyv7UFfjpnfOXqOh2SOfeC2hq+D+xopPSIeYgICi8xsgIneCeVrrbJ8Gsr/Klq
         e7Y4r/R+UuPjvRU4nEU8FuuU3biQx8tgOAmS+AN6u6ft/WbP6ixLwnmiV1FMo//xa1mF
         aFCv0A7/qfJ0vn+WVfBDFZXQCWr5z/D7xzG50hksIL3SXIVj7XdBMtB+H9XBawk6+L4K
         v+rSKtrmS30oRVofz8jw4m2K7TtQUmairbNwPOZe/3oYQjNNwStMIBVaiGuMWfUTF5ED
         AbA9FJNUlU7Gpjd6OTD05KmNttp00Q9ZdMzn2YTk5psGy1Z/LPXlMC0Mm9iuZMTDueYl
         +sug==
X-Forwarded-Encrypted: i=1; AJvYcCWB+YmKFyr6SB1MaFhJ6E+pnJiLNbCxkuUGFU2MeLQFj0wzrKceJBGm9OcLiznVMXPtQ64AffLg@vger.kernel.org, AJvYcCWCZ4HMpQny4K9CXXNDSgUqsY2HOnfQ3AW3qminmwPsCdIzyz8vd7Lr/AltTQWXM2SGLw9SSdjURW5t@vger.kernel.org, AJvYcCWpfEhim1UuUCaGRLs28Tgx2EEHe4TQBuUq2nwLk9wwnCYUs0hkBxtpy1XMWgYGA/TZpVxoZeNDAnHbMEpr@vger.kernel.org
X-Gm-Message-State: AOJu0YzmVqygJlcJg8zTY1r5D6ImQhV6IgH/ZNYcLsXSNKkDz/BycuJn
	EEm0PM8PNXOA0jWfowxEladiJVi7NZGM23mQcilWBn+Qs0uJFCkk
X-Gm-Gg: ASbGnctcShhmH+g6lAYmtW0kkO0zvlLPVnbEt2zQ7QGTWKdyJPWa5TZDXa4TTFfDfqe
	NDQ1a3RxgY1RISE693zep1Hy4jl5P8PhbzlEgwdeEVvDPpjg56NUTSX4gNhF69usYJe2eNaZh2z
	fmvkhp0qWRRyoOEzHOdz3aJfsI1EPPwMUzGVA2HcU7WWhnq/i+UyktgySItPaECEZNeJeD0IEyD
	yX+ELbiuyZ/pSCa7ak+CbGzWMWw4TI5R5FQmjFyC/EWO3UD2zsrKxT72Y0rRvkuwMCXMX4aJ6/0
	fY/MU83N9Zj3i0+qVsVHJ3mqPf6yTgT5LjjnA5EZOipdENeN1fovU+wzmOw8S1s1Pzz43f1R0A0
	z6ylIp1UeeUZ7Tw==
X-Google-Smtp-Source: AGHT+IFlZZzJ/2lDi2nazTz9VB4iFV4fxHkKIVEqMUgw2V/B7Sug+EjR09i/6XKiZaHhhniA0JfvNQ==
X-Received: by 2002:a05:6000:144d:b0:391:20ef:62d6 with SMTP id ffacd0b85a97d-39132d191c9mr6172482f8f.11.1741541275951;
        Sun, 09 Mar 2025 10:27:55 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3912bfdfddcsm12564875f8f.35.2025.03.09.10.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 10:27:55 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	upstream@airoha.com
Subject: [net-next PATCH v12 05/13] dt-bindings: mfd: Document support for Airoha AN8855 Switch SoC
Date: Sun,  9 Mar 2025 18:26:50 +0100
Message-ID: <20250309172717.9067-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309172717.9067-1-ansuelsmth@gmail.com>
References: <20250309172717.9067-1-ansuelsmth@gmail.com>
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
 .../bindings/mfd/airoha,an8855.yaml           | 186 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 187 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/airoha,an8855.yaml

diff --git a/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml b/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
new file mode 100644
index 000000000000..4853f37eb855
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
@@ -0,0 +1,186 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/airoha,an8855.yaml#
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
+    const: airoha,an8855
+
+  reg:
+    maxItems: 1
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
+        soc@1 {
+            compatible = "airoha,an8855";
+            reg = <1>;
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
+                  compatible = "ethernet-phy-idc0ff.0410",
+                               "ethernet-phy-ieee802.3-c45";
+                  reg = <1>;
+
+                  airoha,ext-surge;
+
+                  nvmem-cells = <&shift_sel_port0_tx_a>,
+                      <&shift_sel_port0_tx_b>,
+                      <&shift_sel_port0_tx_c>,
+                      <&shift_sel_port0_tx_d>;
+                  nvmem-cell-names = "tx_a", "tx_b", "tx_c", "tx_d";
+                };
+
+                internal_phy2: phy@2 {
+                  compatible = "ethernet-phy-idc0ff.0410",
+                               "ethernet-phy-ieee802.3-c45";
+                  reg = <2>;
+
+                  airoha,ext-surge;
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
index 45f4bb8deb0d..b7075425c94e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -725,6 +725,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/airoha,an8855-mfd.yaml
 F:	Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml
 F:	Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml
 F:	Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
-- 
2.48.1


