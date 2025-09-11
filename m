Return-Path: <netdev+bounces-222141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D47B53401
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 15:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B1BD5A00C7
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 13:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1261632ED3A;
	Thu, 11 Sep 2025 13:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxmqL6cK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D73B32ED49
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598014; cv=none; b=MoynUcaifIZfU40se79kPabqnepUftYRMX55QegP88xRsb02EAS/HMsWLzBt3iw5V6sG96cXU636vslQb7Dc4FuPY2HfMi/bNwcduhkU6vB/3SOQlYYhRT8xJcXbMVhC1wtyo5xhZg5ePM8Z9bcLuUbat6EnufB9SLHvFUp7UhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598014; c=relaxed/simple;
	bh=e4mGlCMBVF9DhYf/LivGAjnSKmfeLjyoAXsOG/vFvKE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ww9DnaJJOdEvuGhmUxPYgvA8SwGqVBhwN9ggvbWflbXgw1r6juzro/tiquNFQN6TDeYb32/mWsjGLACvdStLRS9YeJ5HCwr9/J91WJ4bZ1lUfGL19XaaSZkFVHNHfkCmYZJjHpZ6vwyezDVqGPHqVOJBebUIKEYh0pNzFghRADk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxmqL6cK; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45dfb8e986aso8592245e9.0
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 06:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757598010; x=1758202810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fkqcfK5g5kwyolRjxk9xPF6Gs0633C5dadI10Wc7gbM=;
        b=QxmqL6cK0Zux2XPfSFnb5VzkXhrZgP+y06oUv6G+CbGbqQw7Okqw9JMDsQjjKa8a+T
         YoaZpr6cL+rWfObMWxWaGLYUJGK5gSHZRovh8kH50kmxyGOf3/Tee0P9aEukUwxxgV8a
         cf1u521iGxBEcwa7JNgIPRRzQBREByzkp55I6C2+Cfw15kOYvq37bWmUVD7X7SGrBeBb
         JexRarCAdiPxu5gu43A/Qkz15wMbKPydcJCo3ldphWNVCESS4Bpn5yBbkLwCvT1qEbl3
         8gcLZ9BPvoA30h/ksZiIjFTaJ00ha2g7UKOAFxHnMSnDicyVFs4netLdoVJRCvdalzf/
         a6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757598010; x=1758202810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fkqcfK5g5kwyolRjxk9xPF6Gs0633C5dadI10Wc7gbM=;
        b=OAnhN/Yq8l+I2hVNwSTLBhCHxroV+1mbv4vplJEi0pHuNq5JYhUjnh9aLw1YNKQJNK
         tnihV/g6CTNhx21nzCdtEtkgbWsDYAkSmMX94CsoDnwv4C60TCctq0CFBL37kv/4+cfN
         XkBMl91u4zmxwgbXKfZ+p0xgcsYn5i91CzqzBGbPU2RDy98smFrxiIQIInYDseHQsbo5
         CU3gATS8oQj4BMj5YGHvoGxiG0iqKzDa01uodgh75O/19GkxU7RBaNdxiQrM0Kc0t7fw
         Cpwi5TCxZoF8u+tvxlPT+37OBhJAb8UTXyPEvH5l8F86oo/3o7DrlIrFugDyABbJZEuc
         ICCA==
X-Forwarded-Encrypted: i=1; AJvYcCW/Vef5zEZfQoLqGtjG03wpnN2zkYOh5KhaTv/HD/d9Wv+P1CyGLFXwyWPqtY76OZvGu5HGK5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXuOUPIEzLuUkHnMtlZF7aZNpdVYSz4IjNVPq5O4ND5VonW3sE
	iwv/Th95KcIx3pYBFU0zrjSYOETv/XAqVOVoHXXZGZKWoU6P+P+oVAMW8TMtxQ==
X-Gm-Gg: ASbGncvZ2u83idDfClkP1qPYxUl/1g2a265vLBPVS2moXcDr2PlKvRmDec4Fjxj5GGP
	T9nkFRgOceVDEYQKsJraUKy6ypSo3M+Y+KgBq8I8qgh/siFIhkhwpCRw2EFFutvV8Uru1HPNUsC
	AIVXwA1pHFSvJFeQXy52+0h1pu3GDufiWWLd/diZEPzWRwjNR0VsgsWmsSyKxng8zV+O8dwzesc
	RPDImk4SGZtR/954u3sSdRqGCvblWOfmmPkn2DWR25/Zl1KSPBfLdEA4ZpcqlY+NdBhn++WMFEt
	QC/5rKXZPXzaMHWl8GwaZFPbyG365+fZ5tEVRytAE9BKnXHHoFxr7feEICx3YHZVf2tsKMivn5I
	7owk/6HqI16YhArtm6GQ0timcC3KVttd7CwsDL147OLHFA1rOG0x66Kvp63INDYO1QIqcfE8=
X-Google-Smtp-Source: AGHT+IEurhbsxyz+hG1AOEJ6v7+ZpKbOZsA3ll2VFQ+7hS7XM1WK7VBJbXT7MuYmuykPNpdXEUZ/yw==
X-Received: by 2002:a05:600c:5249:b0:45d:e285:c4c6 with SMTP id 5b1f17b1804b1-45de3c551f3mr150961565e9.37.1757598009703;
        Thu, 11 Sep 2025 06:40:09 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45e037d741asm23413475e9.23.2025.09.11.06.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 06:40:09 -0700 (PDT)
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
Subject: [net-next PATCH v17 3/8] dt-bindings: mfd: Document support for Airoha AN8855 Switch SoC
Date: Thu, 11 Sep 2025 15:39:18 +0200
Message-ID: <20250911133929.30874-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911133929.30874-1-ansuelsmth@gmail.com>
References: <20250911133929.30874-1-ansuelsmth@gmail.com>
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

base-commit: 04b74f665961599e807b24af28099a29d691b18c


