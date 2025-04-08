Return-Path: <netdev+bounces-180125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 632C9A7FA6F
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D4A17AB9A7
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0688B26773B;
	Tue,  8 Apr 2025 09:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yo4EuAqb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75402673BF;
	Tue,  8 Apr 2025 09:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744105942; cv=none; b=jgpR9zk9AuVkEXN02udVsscSOW2v5X5eiAXpAbX4hSB+LLZwJxtQkyOx9yphDV9PQyxdiAhoLA+rJuzSD3xzcKlMSAtT8+6QBm3fzCgCTHqGAeNcUIwJnMMuAXzh/lMSEK0T/We63OpXc1xcK8TGGWIk2l780m4PQXVtgny4ApI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744105942; c=relaxed/simple;
	bh=KBBfT0IDiw8oE0igR/jcFd9xnP51A70PMzQ4/5lb2bc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1HALAa39EcY0hmKp0fBT25wXu7mRZS/MEff7rBEjDrbXBcYME4LNZAQviFxg11R7rzgnbH+k+aG9T7+eEU89V4pqWsVc9RY/uh3euqEttS5vYjtsWxDDbaoRl5NygLtAwcCn5kd3Pe3BgN+PzRMpm9U0V2HMJbIwQxvQP6cyc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yo4EuAqb; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3995ff6b066so2905110f8f.3;
        Tue, 08 Apr 2025 02:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744105939; x=1744710739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ExLehqKRvcjfnLv7M/oInDmYXs2lxlBzas9u/z/Ge4c=;
        b=Yo4EuAqbJ90P9zloFuywiag1c5TbAh3DSbfQqY9J05lkpGWqXgSCtXs3vKkhzPjAhm
         MZBkCJUSiWYGz5hfynwChRMGDk/DOCrFvdwpuFjOIk5lvFroYicQhpPcrw1cGLWmrT8I
         S/B8z0cBn3F37JxFLFt0JpDPuEQtjN/IwTSTXpZDpWNadduQeWUre7iY/BCVXGjJRRbX
         3FR+ny0Od6HNM63XPIS2/WynMowidmiwDWg9csCVyQ2ONZfFH5NwttyZxCEDcwAYLJbt
         EKeTxAOuycDqV1tJbxlqY0qvK/8mZW2XnDVe657w+S1dUETsW93sLrS5JFwEEFtlIa6W
         NPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744105939; x=1744710739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExLehqKRvcjfnLv7M/oInDmYXs2lxlBzas9u/z/Ge4c=;
        b=kejmEWLGR09AmI8F38bFghnHHXvyBuUQM4WIxdSGpmeo8OlwmPeyxORqUJcvECCgk5
         2zOaubNDCWxzFR+jyaXs1TTIAzGdnMbXtXdyTTNQVfGCA3C4KGsAc3Xek3WQ0y9RLqJv
         KMpBFpYIzPS21DbiccE7GtUTabOTmZEsSbiQ8E7Xzu6aP+g0BbJtqUcsCSxXydP7AGkX
         4w0I9RqeJF+SgSrYARbCKCx2o1qT3ZfofXR2/BCsvpn4Xopp/vnm9jQIdSOMsj8TdnGv
         gxbpjK4TUtPKiUGFlZ+Nv7PIXJAR/sBQFvAqmhvDAa7yOvsfxyhkjygad1YLtWvff42H
         QEAg==
X-Forwarded-Encrypted: i=1; AJvYcCWEWSHyIXvJ1jezWqZeFalfwI9NH65Qup9ryYXwzkBb9Pluh3Q4Q1qI/jE73uKveeut5GkijQr1rgMzrwxF@vger.kernel.org, AJvYcCWQmdNJEI5Rp/ydQ67XXNznPeeUpwEJAamTS0x5Otxz/3FFS+94wK6xHW8WTxFYlR0k5xX5Sfi1@vger.kernel.org, AJvYcCWwp0OwC7zsqBGXsy8b+4tPX4eUtMXvjXOCOWUTbGa05acMfxWi7SYpapDQJtMp8z4RZFA6pINTy/F1@vger.kernel.org
X-Gm-Message-State: AOJu0YxPJXBKBoKrAH8S7JOgR74Z3enQ+HZ3Is2J6n/O0+C6+LeDfCq+
	psEu3XWY9F/EaTsnRGSFZZqSO4/2m2Un1GLiqu2DfbBHa4TnPSDn
X-Gm-Gg: ASbGncu63ZRDuSA9C6Y0rNLWpQvqITK35b7GRNN1gAsbmZW8olbPNpKyGIzP385RY/E
	vLiK0PyLfxdP8E/I28vWX0ilqjk9bnJrGBnEMOay4u4oZN2/iTE6mq/ggLHPPF/T6GNswPPbBBe
	LVvt133olqJb45yVgb2WW8ET7AZVAOl2DNyGDJ9wDD8afyCPC0dMi0fT1oDYC0kQE0CkCnRyf4r
	D161qfx62qgLfPUtlT11NED+ClQPx+Q+oUMPUE9UfpJiM5WtYYpTswwDQoVRZy8QLZiduXC3rLN
	Clll/rv+8d6q3facqXg4Y2fbMrZZhqdAAqboSBwqYllY3W0k1sRV02GK51oPNwCKs2Nn/jMstfI
	9BiSmnjsL9+kckA==
X-Google-Smtp-Source: AGHT+IEQt71C0WsDeq8ESBHPrPvVXdso8be2LsvN0wOnaKBlrYDbH31KpmHG4v2carb+cHa3zLh90Q==
X-Received: by 2002:a5d:5f43:0:b0:39c:dfb:9e8e with SMTP id ffacd0b85a97d-39cb3575ca3mr12127734f8f.8.1744105938882;
        Tue, 08 Apr 2025 02:52:18 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39c3020dacfsm14493310f8f.72.2025.04.08.02.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 02:52:18 -0700 (PDT)
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
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
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
	linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: [net-next PATCH v14 05/16] dt-bindings: mfd: Document support for Airoha AN8855 Switch SoC
Date: Tue,  8 Apr 2025 11:51:12 +0200
Message-ID: <20250408095139.51659-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250408095139.51659-1-ansuelsmth@gmail.com>
References: <20250408095139.51659-1-ansuelsmth@gmail.com>
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
2.48.1


