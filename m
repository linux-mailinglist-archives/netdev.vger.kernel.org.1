Return-Path: <netdev+bounces-222984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF07B576F6
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 12:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 093D33B73E3
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 10:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363C32FE07B;
	Mon, 15 Sep 2025 10:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axDCDjJ0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A62E2FF147
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 10:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933165; cv=none; b=l0ySROpq4IHl7A0gZqGjXj9Wy3RHwadm38tgT8PMB0isx6WFTb9efJkKRReAB/YFt2DI2TsUqRr7BRxptBUEKFO+wwj7v2LJwbZdb7EZFlR8Dz9veZ9uFen3s0Reu6wSBgY8XadhrCM65c5mgT2MGoFVFNamSHron8SnQD1n72E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933165; c=relaxed/simple;
	bh=713ajadFd4F/Cc3GrDLPLKiLlHqRtKfSRnBjZWa0frE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jEqz2KXWFxizB9H9IPTdWyoXD/jTehGD9AajB3dtKQdo2AWQOOKkyToTqPeGOA4ZoAOfEpdY5fjENlLZGFnBOeL0CkZaLZawWgOBlpeFOaa1kaiPVvSwE5bkMfonkNTFvwK7UdVrY7TY+A2RJFkA4YwwcyFEHsRTzhPglMBfEMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axDCDjJ0; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45f2b062b86so7930065e9.1
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 03:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757933162; x=1758537962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4UfTitWr0/SY0YFizPV9dalGTR12rbqo6S3iSVpAJc=;
        b=axDCDjJ0YmcivZuiTOtO0AKrzvFm6MDKk4CFNklOx2eyywA39Bp8rdNRuSrOakP5V2
         Qx8asgL7FPYvDPV7EHJK+G3XJB6FiHyupB178LuEGrTE8nqn/Ma12aY3UHcjEO68aYUq
         YbKyGzC1ZxiJJYH4o4KXas/KAyfmIWCyv1D4Pm9Qfc88RD7RSjGLKfIDTtjlBkqkKi1g
         zqHkJSJetMm+mEASJxMKz77qIqjKcrMUEiObFaA1UCEwBuiz0JDTxXgnN62/R1aFtXBt
         QieWB4PX81GK/uwEJ0Oq5Cq4mFsGFr+6J9lO7R2uJzIQQBOmG8Not10TaR5wrmk2VQmd
         eipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757933162; x=1758537962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J4UfTitWr0/SY0YFizPV9dalGTR12rbqo6S3iSVpAJc=;
        b=ktHHgWwN+1Dd4v0VeAss4QARFcOs+pm7EaqGX1fYr2F5J+KBFe2oKWhbFM2lzi3Fjp
         yg4WLLvj1EGZtS01o/SWQU/i0JFkLincfVfiO+jKeAWzAdHNBMn30RsGPOu8pmvKfW95
         7MmFJ/my+fqoMewjfaexRvcFqdTiNZfZu5gmbKiQ9Ay/V8U+S3+coMpa1kCBXB+N6/mu
         Dp+XBUa8cZNMqCeIm1Xap9mLFhqQnB7A3IwDFLAfpZF53xyoXPpiO0A0TDIlXiZf6Q6c
         Q0xmW+xlLS5rAtv2EmKK1G1EgnDJM28V/Kmx8DONZ1nREHvvZo5f1cicvKMjbf6oFU2Y
         Ws8w==
X-Forwarded-Encrypted: i=1; AJvYcCWkjgZF8ZMMaJk0yeXgBHWl6dCi5QLaPkmKC34wyylAYLzLRyQlD0VAie8AZsEZ69OqUcxFB0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx/k6w2yXvQAOIODuq3qUVU430pNIyjiY0WGvN64SjzbbBvNFu
	AhISfK0xdjEBhN2E+j9/cvoTNhiBsMVjjyqsGWC2cBFoR/tAIL3TPwDO
X-Gm-Gg: ASbGncuQ0MYJ4Aj/hADqUbnEEdvLIqb/whIk8EbfMECgzNOZc1lSyBxLbQfZnxwe0rS
	FGv6bTb5zK7D7DTVl1F4EAhveIb42vPn1ZBHL0jw7lEuFLY70nXtmyYl9M2JW+fXIIpolP92xJj
	O+otf3+cYR74zpvW8OphPFlqAaGU/srhUJPCWXSBRgpCtwTpEwlUHBTWpUcCMC6rhkkYQIb/kTs
	j+wPi3xv2Fuh3troRTvdvCjPMNqYPrEa12lHUIQ7CK2x85bB++xduve4SgjoDOVRx0Mkz286tB8
	zX959qySX8+KHdjanYO9HCOl6S68EcyCyD9hHsIOHETJC9GjCCp8Jm+ia9+pTBtbznRx4cjcsbl
	akIQ1vexgQ2zcSzMGYjwanjSi3GJCge8o1y5FMoiK7LCxoAgmDK2oUTW9qDUi4rdDp84pTLg=
X-Google-Smtp-Source: AGHT+IEXNZcoVd0GzgGmN5xy38B0YlKF6tMdJTyKwSotC55HsiTkVEoFjPfwlkbgqGZKHOIXVx84vA==
X-Received: by 2002:a05:600c:220f:b0:45d:d9ab:b86d with SMTP id 5b1f17b1804b1-45f211feea1mr95031475e9.31.1757933162216;
        Mon, 15 Sep 2025 03:46:02 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45f2acbeee0sm67163365e9.0.2025.09.15.03.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:46:01 -0700 (PDT)
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
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH v18 3/8] dt-bindings: mfd: Document support for Airoha AN8855 Switch SoC
Date: Mon, 15 Sep 2025 12:45:39 +0200
Message-ID: <20250915104545.1742-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915104545.1742-1-ansuelsmth@gmail.com>
References: <20250915104545.1742-1-ansuelsmth@gmail.com>
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
 .../bindings/mfd/airoha,an8855.yaml           | 173 ++++++++++++++++++
 1 file changed, 173 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/airoha,an8855.yaml

diff --git a/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml b/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
new file mode 100644
index 000000000000..647d6d4c4c6f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
@@ -0,0 +1,173 @@
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
+  reset-gpios: true
+
+  efuse:
+    type: object
+    $ref: /schemas/nvmem/airoha,an8855-efuse.yaml
+    description: EFUSE exposed by the Airoha AN8855 SoC
+
+  ethernet-switch:
+    type: object
+    $ref: /schemas/net/dsa/airoha,an8855-switch.yaml
+    description: Switch exposed by the Airoha AN8855 SoC
+
+  mdio:
+    $ref: /schemas/net/mdio.yaml#
+    description: MDIO exposed by the Airoha AN8855 SoC
+
+required:
+  - compatible
+  - reg
+  - mdio
+  - ethernet-switch
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
+            reset-gpios = <&pio 39 0>;
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
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                internal_phy1: ethernet-phy@1 {
+                  compatible = "ethernet-phy-idc0ff.0410",
+                               "ethernet-phy-ieee802.3-c22";
+                  reg = <1>;
+
+                  nvmem-cells = <&shift_sel_port0_tx_a>,
+                      <&shift_sel_port0_tx_b>,
+                      <&shift_sel_port0_tx_c>,
+                      <&shift_sel_port0_tx_d>;
+                  nvmem-cell-names = "tx_a", "tx_b", "tx_c", "tx_d";
+                };
+
+                internal_phy2: ethernet-phy@2 {
+                  compatible = "ethernet-phy-idc0ff.0410",
+                               "ethernet-phy-ieee802.3-c22";
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
-- 
2.51.0


