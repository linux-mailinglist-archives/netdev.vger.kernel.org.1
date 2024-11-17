Return-Path: <netdev+bounces-145639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5B29D040B
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 14:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9733E1F22D07
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 13:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C65194C6C;
	Sun, 17 Nov 2024 13:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyfvlxak"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B14919342B;
	Sun, 17 Nov 2024 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731850130; cv=none; b=C9phft0MOwQgctCfZ5ro7mv2GrSTu2dBxT1vrxjhd4xxa1RGM6bM8PmWQfAMhtl1otUZ8iOVlTFmu49imkv9n13OjFyPbICzIUmP9MwIjeBDCi7HC3108niNsaVbUwYE5CmNn5GJn/d9782m3hxbkuQUu+fMf22ghYozuJRFnrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731850130; c=relaxed/simple;
	bh=GwZlCs0rDyfngSE0caElPofYG+iCYPrHRrRD7N9IuMM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qc+QrgWraODULws3cISt+veYrkh92HxirhMN+daXxtUHKdpqf8w1wTsZQpO0yMEFXTjzJkahuP/GnHobKnzUUpl6I33vMYMzPmkhKrLB970MTAMry4b7zkwugU24bV/dGu9vE1IzdNOcB4XvBiCPLZpnkOq+mtMcUbFyFUO7U4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyfvlxak; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-432d86a3085so10553745e9.2;
        Sun, 17 Nov 2024 05:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731850126; x=1732454926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UObQQxVp3PNi/U3LeYQmo0T4c/idtN7E2PfgKAA5yAg=;
        b=iyfvlxakw+Mtf5Y5ffVGCRoanQH0GJUowjVUqxhDpbODzjtPBAlY7T1fLfbKIgkYz8
         SOw8/d+up0GBishhnP1aWIyoz80Q12Bk+rjlmQL414hEdY3A7SkMJdW++Xp127+H6EQ6
         5tOFhCxyrmYSfJShju8Aaxu9KF9QmHsttMtvIxIQjH1WP3+BjU9FchGqpjjWKAKpaB88
         CIKwJAQ6FMWmqs+Lcu3ORImMO3YYR07ZdNR0Y3HPeVLoEoKzOhOJEaF8wkw17rZzVi24
         BiRo2jza796kg43KODCD7z9GdUnaT5TGdngjycWdVxsKYGY2UB/iQnbnJNEcabARPj/A
         Ej+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731850126; x=1732454926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UObQQxVp3PNi/U3LeYQmo0T4c/idtN7E2PfgKAA5yAg=;
        b=xAgWszmBESySzQmUq8LaVqbzd4E5uzmBs4s5oSBfSaPfQwnWco6Hc+yWxI5RaksohT
         o6gAaMjyGyMMMR8y6AzbkEt7KbbqcCQfXLYo4komDlel+ISjbvSOk84iSqpia8mNF4wK
         GwaNHjr5It4YdgWDwoWFUW0QqcHb0Yt5iONpyAoXGUODxwUKe1JGwIJ2/26xjA5lAbUi
         Qdaf1XTU/HYn5JnG4xXziJumNVxlqS8f/hh12zQS8Cy+MHYlxgfwUE+R28JLVKFQ1YYq
         /gdDEKUnroraHfMT4K260KtdRbS3h8WlSW8stBLM37cM6IN4bbcDf537QWX7yzWAMrXW
         HTrw==
X-Forwarded-Encrypted: i=1; AJvYcCV5hvMhPzCj67q4r7Nt3ObP8XHUbrur6g5R/KIA7RFah7qjkMZY6HiIfXrVOGC9dbR7UUlR4tHF@vger.kernel.org, AJvYcCVHBgT1zTUcHRXJBNdCr1LqPwvNH5tgnz/aC7CkcTlqSwj1QAdLiWR4+hFkO5izb9QJbCxU8x4HmtPP@vger.kernel.org, AJvYcCX1/KRu7f2ZyFDfr0/2YRbknyBtNK9gew0yZJzm+COrbRWptN3kLnPeSU8r0eK3/jXOUGWMF5i1tanmuAHK@vger.kernel.org
X-Gm-Message-State: AOJu0YzXbXju5C7YCBkAwVvJhGJfreRLbGy/oQvsc29+mOo8l6y4cuOM
	ZgWNkzzrIPGgdphtPo+Z+Qge0iJvO1EK47DnCci8m7DsUyngqbJS
X-Google-Smtp-Source: AGHT+IFc103wPuVhkIbtbhXLlRi/GDAGuTMJLqzi6wVxhvBPeIbYLmZYMnm1GCrPNUEreqwmj6gh5Q==
X-Received: by 2002:a05:6000:1562:b0:382:2a2b:f81e with SMTP id ffacd0b85a97d-3822a2bf928mr6735346f8f.51.1731850126379;
        Sun, 17 Nov 2024 05:28:46 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38229b6e2fasm6282015f8f.40.2024.11.17.05.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 05:28:46 -0800 (PST)
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
	linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: [net-next PATCH v7 2/4] dt-bindings: net: dsa: Add Airoha AN8855 Gigabit Switch documentation
Date: Sun, 17 Nov 2024 14:27:57 +0100
Message-ID: <20241117132811.67804-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241117132811.67804-1-ansuelsmth@gmail.com>
References: <20241117132811.67804-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Airoha AN8855 5 port Gigabit Switch documentation.

The switch node requires an additional mdio node to describe each internal
PHY absolute address on the bus.

Calibration values might be stored in switch EFUSE and internal PHY
might need to be calibrated, in such case, airoha,ext-surge needs to be
enabled and relative NVMEM cells needs to be defined in nvmem-layout
node.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/net/dsa/airoha,an8855.yaml       | 242 ++++++++++++++++++
 1 file changed, 242 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/airoha,an8855.yaml

diff --git a/Documentation/devicetree/bindings/net/dsa/airoha,an8855.yaml b/Documentation/devicetree/bindings/net/dsa/airoha,an8855.yaml
new file mode 100644
index 000000000000..8ea2fadbab85
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/airoha,an8855.yaml
@@ -0,0 +1,242 @@
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
+description: >
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
+  airoha,ext-surge:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Calibrate the internal PHY with the calibration values stored in EFUSE
+      for the r50Ohm values.
+
+  '#nvmem-cell-cells':
+    const: 0
+
+  nvmem-layout:
+    $ref: /schemas/nvmem/layouts/nvmem-layout.yaml
+    description:
+      NVMEM Layout for exposed EFUSE. (for example to propagate calibration
+      value for r50Ohm for internal PHYs)
+
+  mdio:
+    $ref: /schemas/net/mdio.yaml#
+    unevaluatedProperties: false
+    description:
+      Define the absolute address of the internal PHY for each port.
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
+            airoha,ext-surge;
+
+            #nvmem-cell-cells = <0>;
+
+            nvmem-layout {
+                compatible = "fixed-layout";
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                shift_sel_port0_tx_a: shift-sel-port0-tx-a@c {
+                    reg = <0xc 0x4>;
+                };
+
+                shift_sel_port0_tx_b: shift-sel-port0-tx-b@10 {
+                    reg = <0x10 0x4>;
+                };
+
+                shift_sel_port0_tx_c: shift-sel-port0-tx-c@14 {
+                    reg = <0x14 0x4>;
+                };
+
+                shift_sel_port0_tx_d: shift-sel-port0-tx-d@18 {
+                    reg = <0x18 0x4>;
+                };
+
+                shift_sel_port1_tx_a: shift-sel-port1-tx-a@1c {
+                    reg = <0x1c 0x4>;
+                };
+
+                shift_sel_port1_tx_b: shift-sel-port1-tx-b@20 {
+                    reg = <0x20 0x4>;
+                };
+
+                shift_sel_port1_tx_c: shift-sel-port1-tx-c@24 {
+                    reg = <0x24 0x4>;
+                };
+
+                shift_sel_port1_tx_d: shift-sel-port1-tx-d@28 {
+                    reg = <0x28 0x4>;
+                };
+
+                shift_sel_port2_tx_a: shift-sel-port2-tx-a@2c {
+                    reg = <0x2c 0x4>;
+                };
+
+                shift_sel_port2_tx_b: shift-sel-port2-tx-b@30 {
+                    reg = <0x30 0x4>;
+                };
+
+                shift_sel_port2_tx_c: shift-sel-port2-tx-c@34 {
+                    reg = <0x34 0x4>;
+                };
+
+                shift_sel_port2_tx_d: shift-sel-port2-tx-d@38 {
+                    reg = <0x38 0x4>;
+                };
+
+                shift_sel_port3_tx_a: shift-sel-port3-tx-a@4c {
+                    reg = <0x4c 0x4>;
+                };
+
+                shift_sel_port3_tx_b: shift-sel-port3-tx-b@50 {
+                    reg = <0x50 0x4>;
+                };
+
+                shift_sel_port3_tx_c: shift-sel-port3-tx-c@54 {
+                    reg = <0x54 0x4>;
+                };
+
+                shift_sel_port3_tx_d: shift-sel-port3-tx-d@58 {
+                    reg = <0x58 0x4>;
+                };
+            };
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    label = "lan1";
+                    phy-mode = "internal";
+                    phy-handle = <&internal_phy1>;
+                };
+
+                port@1 {
+                    reg = <1>;
+                    label = "lan2";
+                    phy-mode = "internal";
+                    phy-handle = <&internal_phy2>;
+                };
+
+                port@2 {
+                    reg = <2>;
+                    label = "lan3";
+                    phy-mode = "internal";
+                    phy-handle = <&internal_phy3>;
+                };
+
+                port@3 {
+                    reg = <3>;
+                    label = "lan4";
+                    phy-mode = "internal";
+                    phy-handle = <&internal_phy4>;
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
+                internal_phy1: phy@1 {
+                    reg = <1>;
+
+                    nvmem-cells = <&shift_sel_port0_tx_a>,
+                                  <&shift_sel_port0_tx_b>,
+                                  <&shift_sel_port0_tx_c>,
+                                  <&shift_sel_port0_tx_d>;
+                    nvmem-cell-names = "tx_a", "tx_b", "tx_c", "tx_d";
+                };
+
+                internal_phy2: phy@2 {
+                    reg = <2>;
+
+                    nvmem-cells = <&shift_sel_port1_tx_a>,
+                                  <&shift_sel_port1_tx_b>,
+                                  <&shift_sel_port1_tx_c>,
+                                  <&shift_sel_port1_tx_d>;
+                    nvmem-cell-names = "tx_a", "tx_b", "tx_c", "tx_d";
+                };
+
+                internal_phy3: phy@3 {
+                    reg = <3>;
+
+                    nvmem-cells = <&shift_sel_port2_tx_a>,
+                                  <&shift_sel_port2_tx_b>,
+                                  <&shift_sel_port2_tx_c>,
+                                  <&shift_sel_port2_tx_d>;
+                    nvmem-cell-names = "tx_a", "tx_b", "tx_c", "tx_d";
+                };
+
+                internal_phy4: phy@4 {
+                    reg = <4>;
+
+                    nvmem-cells = <&shift_sel_port3_tx_a>,
+                                  <&shift_sel_port3_tx_b>,
+                                  <&shift_sel_port3_tx_c>,
+                                  <&shift_sel_port3_tx_d>;
+                    nvmem-cell-names = "tx_a", "tx_b", "tx_c", "tx_d";
+                };
+            };
+        };
+    };
-- 
2.45.2


