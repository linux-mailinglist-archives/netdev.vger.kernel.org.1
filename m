Return-Path: <netdev+bounces-221010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348CFB49E33
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 02:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CD863BE7DF
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 00:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4744322F75E;
	Tue,  9 Sep 2025 00:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpjJa5MH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0962253A1;
	Tue,  9 Sep 2025 00:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757378644; cv=none; b=ohRqXsrll7lEcU/Pv24B6TXfKKVSV0NcdE9GkNWUtJdFMXqKy8Kz4641zsyvpofleSK39YizskhM7HX/UDQGmx/F/ZbFoMHdFsWCSZxDH6qJEhfr/2ILubH2n0LzX8hxOz5UJcafePGYgdWg4PZNJm3IkXu8tcm+YIyc8sHjJQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757378644; c=relaxed/simple;
	bh=0wsITGPBevt17Cf1qk8g0OcCcdtCgp2nCiaeoCcaLhk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pm5h2d85bjYTMHviL1QHP4fTApB7amwhbZpUTWEkstw3WXAp+8Gg1BrMFec/lNiULtMsdVafHTY37Bxj+JYwM0IhT5xJYR2+iDMwLCHJ7JTm+Ef9f05qnG7vHgrBoX7sA2zqxGzXgYsuU/bvTduawVjsZnsRDcwRAJIJlwimzR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpjJa5MH; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45de6490e74so14727805e9.2;
        Mon, 08 Sep 2025 17:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757378640; x=1757983440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3iIHmjNYzJfMkSB/Eez7mPIwgeGVEwQZjO1Fi3Lcdo4=;
        b=bpjJa5MHGuCeZu8xi4ayfMRVcOpN8yJg4rHDtSpGV9X6DpD/leXTlZj2GsfFXi8kCb
         HSUGXH+Bv76HmL5l7CHgmOY4+28hPZH65J4k5n43Gdcy1BI+3X6a1+IY3j+SYin7b4Cj
         BvHAXnmY4NwgrxlwmAVLsWEHrHiEJOHJ7jYrRqUBqIp/xItB+orbSiMQwcFKjLJaB/MB
         0U57pV4JpYRsiD82Vcv5EtVx5r/XeM8kAP97lIT3AXEbD2qlR/fEryovG+iqq5UJ31RA
         OITIv9JyTYrdQ/VsmF5SrLPAiVBeAdU/IJLHLiO52rRbIlnhoC1sPyK4gDyXNgQtWlhP
         Dq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757378640; x=1757983440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3iIHmjNYzJfMkSB/Eez7mPIwgeGVEwQZjO1Fi3Lcdo4=;
        b=sXt5QdZV0thnf628UnERmMMWy2l7/QyaTFnRJaNGt3o0TLsCliRH+tMT8zwJSseeTu
         FeZNUojc1hqKHdptALqGL7Npk3ClYThTNlLSonlCngfzeGqp9klNvBsQXa2D61fBQJ30
         /yH8Kl4Xf+B/unogpjUj+0D32vgTeXxJ27RGZDqaYf9fKHoVDVLocHqDD6u1mgzawtbW
         FkQH7995kQ8F7vS+WbGpv4/MQOKWTAWVpxowMgovv9oaSf7dOIpGVO+XlYcaDZvmHyz6
         BjhHa3xvtnFArfeAI8lBwxZ9zxy7rbeZbQvrRPuTiSJk/XYMEW4IKnWFwruuDvlKSZz9
         B6BA==
X-Forwarded-Encrypted: i=1; AJvYcCVtJbdn+r9mcPZ7wotcMAp7yqml6g7QoznfatgQWHWww8HBvI7Q151y5p09DhnD5Lkhe874yIZHu8IEJUGI@vger.kernel.org, AJvYcCX0o7HS9vsdR1MsaMWlqsVLWFrCHYcgZlXpydgFwCVzrxxO5eClEKY3mnDt1526Dt0wGghdGUVaopLF@vger.kernel.org, AJvYcCXlMXvrtDwAQjJzhbZgoUlhjM7cMtmRKk7ZKhN8Q3i/55HMYGSk9DXTVXd5YzeJ8gPo6C/Odsm/@vger.kernel.org
X-Gm-Message-State: AOJu0YzUo8LC8THATe96M1HamTDHxcIzjJuvALpHY1B7roD6epv+2v4m
	71ueZMp8XPNkjgpSzxaBUXW7DUufjA6ydHVP1nqLdIDZYRMXay72CXec
X-Gm-Gg: ASbGncviZdPRwF9C76zskafVIYT/DqTvwJrJpIYov/L/apCfdp8d042kgGMCTNOMGNz
	cJFSIyKLqSWRFoLvwhlqgciJlzmjx5pA31I3uqVAMO6gkUC805SI1mxTKKed3OVonA/QbIEvOyD
	nbCF7QyDbW4zoe6Sad0Aw25xQwMX9FL/U/4j3CJaF9mnsTdUSKmZIU2EUpMz2iza6SLFShW7GIA
	cBvEEEuUjbcYNKNYzsfQZCD60+Nzi2Pn3ZDyo7+JqpQDknTWez6FAg9S71DP0qLbc34nhv0f0AZ
	7DKcFQ2jkfsa7pRhI+KGCDZdeLqEtZumeR9PEnJbnDWp5/w53U0I8cKyxnDn450Xu8EbuqIGjso
	4m37XqdGqV77fw+ZSqtOzs+V7HmjPYO8OmioXQvuiofQLYkaONcGzP6JxJUVlYl1QJQwqLo5rjU
	+fHkdk3w==
X-Google-Smtp-Source: AGHT+IGdgGnrLTZnPB86nnYVcBNcEnc5DZLVAd79zsGk79rsxwDjvQnZJ5bvXWT9oXJL5L8j9ucl3w==
X-Received: by 2002:a05:600c:46cf:b0:45b:67e9:121e with SMTP id 5b1f17b1804b1-45de2b4e677mr59264045e9.14.1757378640498;
        Mon, 08 Sep 2025 17:44:00 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45decf8759esm13526385e9.23.2025.09.08.17.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 17:44:00 -0700 (PDT)
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
	Srinivas Kandagatla <srini@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Simon Horman <horms@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH v16 04/10] dt-bindings: mfd: Document support for Airoha AN8855 Switch SoC
Date: Tue,  9 Sep 2025 02:43:35 +0200
Message-ID: <20250909004343.18790-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909004343.18790-1-ansuelsmth@gmail.com>
References: <20250909004343.18790-1-ansuelsmth@gmail.com>
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
 .../bindings/mfd/airoha,an8855.yaml           | 175 ++++++++++++++++++
 1 file changed, 175 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/airoha,an8855.yaml

diff --git a/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml b/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
new file mode 100644
index 000000000000..a683db4f41d1
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
@@ -0,0 +1,175 @@
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
+    type: object
+    $ref: /schemas/net/airoha,an8855-mdio.yaml
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
+                compatible = "airoha,an8855-mdio";
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


