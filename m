Return-Path: <netdev+bounces-175062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA3DA62F75
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 16:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 680D4177E7C
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 15:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFD92063C4;
	Sat, 15 Mar 2025 15:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFb/1Ee3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E8A205511;
	Sat, 15 Mar 2025 15:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742053490; cv=none; b=AG9OQvmkna28gdg8AjHiP+s085/IbckTfbgy6awuTTueUz/UxxMEsKGEYWazr2TdXodx4N1LBsptYFnRIY1ZyrC6i/qziSfLt/PXqilEuhDaCYeujddKDuKgqthvZG/Fb0A3pUKcyN8NZBKCsrXjzZKEKWxnMvjKuj1okvvdiv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742053490; c=relaxed/simple;
	bh=31Fk59oC+Z8bAkoRuIhN8QN7/qYa5KHEpw6mpavkzqw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nRpVElUBtyOjmpy5ERu8E+TNKZeyP3IheoCJLdZZbghiVSpOfxmBX//fy7K4rlyhFKmteifdu/7j/5K7gQ0I5Q+bq0suRR81I6Y9QIXhp1IWyoe9ftSAmYtlO6+i4MSW2DjDisvRRzWCsvZ6Y+DAPekm0tP83P70+NVO+5f0uQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFb/1Ee3; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so3652965e9.1;
        Sat, 15 Mar 2025 08:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742053487; x=1742658287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A2bomu0aDGtFs04nywYlMbipXyb3n9cPvymFIMABLx4=;
        b=dFb/1Ee35daVBLjkKALLnvj6iiAVnN3Lu0WKfHSHLmb+CjZDH1cxabN1j/J/cfSZEX
         w+RuXe5ulobCvVvmBUS8rZBjTph+VU1wpU1yYN+xgbjTGicaed0Ls7CBa9XU4Okzd2LQ
         oe30Rzgl+FA92c93foi8E3DUTSS5y4S9+1R4oVpsMaAeLDpTK8NEw0O4astjimiuHIG9
         Tq8bWv/danvgRoYmzP5E8RqvCJR4FLFVxPyN5jU3hrJBkxrIF7DRQm+CKEpI4TrWaB1w
         8zbJ9E9ZzxZnn79FdnvEu6ZwAFA5kjJogoFb7poTJWMO4EkiqrvuSqECXneYbV+uMdt6
         Ozww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742053487; x=1742658287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2bomu0aDGtFs04nywYlMbipXyb3n9cPvymFIMABLx4=;
        b=iGB5ryhsWrUSOVe1z1FO2p6UrMUCrSFLj2KmoQSPEQoxiAdt4GyvnhFOuNiftrvssG
         pTcgIoGfKU4hzyn0ZItcGY6F/Bcx82wxpXdetofJrJVoSj5PzNWpzQ5qo0qPkVGIfAqD
         CUi8bmXjHzeheeszaK2jpZw8G5aVbjI8v6X9Uhkj8cjCPOAipSbuhwdb43oKcKsnYqK1
         sjphjcpo0Xl88Nf/YgzpZngxrXqpe5KPVIWle+9Ha3f/YVr1i4wc5mey7hfnQNUq9Mlf
         1dNQLla97BnzvKKZqsSTN88ejz48ngakrSP/M8i8CP8H9FTVDIgiAgJOeTkn1lmUzTAR
         ZEKg==
X-Forwarded-Encrypted: i=1; AJvYcCVbPQefbFL9acnqJCb2ynEiinNJNwY2YW14u2xryPz0SIo915Dr20pTgq7c9ugS8LBrRI3OhVg+7fh03z8R@vger.kernel.org, AJvYcCWdrdrV64W0KJnAdRKpTUpHVm07G8KVNEXU39B7OYvFdpE/meWhovkbRecRLVtD88UswWfya1RP6CWp@vger.kernel.org, AJvYcCXbDlTWYL1DkJNrS70nRqrNScrjm5MQB1IflHvdh2Eb/ET4+VdAx5Wu6oAAqxwjUnTW4Wj4xIAl@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi5I7jnAZQXoSdlfT4nFuE8/Boup9W5ecpkllUECt9lP2ZTEKU
	CyOx4m2MP3cFzmSfLBZrLTcE2W9Tz/Ks+fW74g3s+x+4n8ZrduDl
X-Gm-Gg: ASbGnctmf0Yc89yG3HPgxMtBEv71mufS3zfu6wyqUjAT1e39c3ueP+vZiIVEWTNVBbb
	koNS4x4FfbqF0N4DBko8dKmzVVE8eHexnU3vheuwUxdVU0M7Bjwd7nIp7rHm7y8YybthhEfvyy8
	JT3N7ha84FMa8yaK+soWulz8WTxXg7y5K3kPbsYSKU7EYrjrYFN1eHHr9YiehNGtGtEk2Xq+aGu
	QtxvPDyFKUdkkATnI6nBGhyNsA04GCmRb5zl8AUeSlD74I2K9owSlyjucJPP9PGEV+bXqM/J1Gc
	w7Rb4S/cngCxv9ys6svT9TwsJz30mJ2L7X8nNmd5Syjl3wDEVFTIuvXl1PgEy6eUzwQUgb3fZ2U
	xYxXLELq9CHvWeg==
X-Google-Smtp-Source: AGHT+IEhCyUiyhg64g12SU6KmHgYBMBD6ll/U35SvERkYFCfc0O2UiPMXs8V+ySvepc/0dICSdJ4SQ==
X-Received: by 2002:a05:600c:1c9d:b0:43d:186d:a4bf with SMTP id 5b1f17b1804b1-43d1f120201mr78301655e9.0.1742053486688;
        Sat, 15 Mar 2025 08:44:46 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d1fe0636dsm53464195e9.11.2025.03.15.08.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 08:44:46 -0700 (PDT)
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
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: [net-next PATCH v13 05/14] dt-bindings: mfd: Document support for Airoha AN8855 Switch SoC
Date: Sat, 15 Mar 2025 16:43:45 +0100
Message-ID: <20250315154407.26304-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250315154407.26304-1-ansuelsmth@gmail.com>
References: <20250315154407.26304-1-ansuelsmth@gmail.com>
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
 .../bindings/mfd/airoha,an8855.yaml           | 182 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 183 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/airoha,an8855.yaml

diff --git a/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml b/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
new file mode 100644
index 000000000000..a59a23056b3a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
@@ -0,0 +1,182 @@
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
+                internal_phy1: phy@1 {
+                  compatible = "ethernet-phy-idc0ff.0410",
+                               "ethernet-phy-ieee802.3-c45";
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
+                  compatible = "ethernet-phy-idc0ff.0410",
+                               "ethernet-phy-ieee802.3-c45";
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
index 45f4bb8deb0d..65709e47adc7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -725,6 +725,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
 F:	Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml
 F:	Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml
 F:	Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
-- 
2.48.1


