Return-Path: <netdev+bounces-150209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DB79E97A2
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 14:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87DA916602D
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 13:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547D01B422E;
	Mon,  9 Dec 2024 13:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQdNX4BU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADFC1B040B;
	Mon,  9 Dec 2024 13:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733751949; cv=none; b=ekwF05IGDJ38SIQA8s49E4Y3gSrHb22Y1wRjjYun0LfCNJAO+GLGF2qXXr+i7Q1v1fT+pkwss8ELfFTUhPW2r6WZuxw52dWuKyh6zg9TngkAimD5xpKKkW4VA2SLSIYWxNLFaJ3LCIkfh+UJwgWnhSlgC2nEmeTlrqAwd0Jjjjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733751949; c=relaxed/simple;
	bh=Sq/82BQy0lA9mYmZwfJT1pAJYI4aueYwD+geAGe78NU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AT/F4YjirpJxE6FS7beEn4h+ysDm4oJswNWmDUNs0feYmY2m7E5Pg+oYxfZNlV+AMfRaomzzAsNC/wtjkQJXNfRvg37lfplyawop429SX7nt0PWZ2c0Ea6UZ5WBrwETIntAjetmSE+mmjm88P3TuOB9plbFvN6kYy0edqNMAl/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQdNX4BU; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434e3953b65so14980005e9.1;
        Mon, 09 Dec 2024 05:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733751945; x=1734356745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E5/ugt/9XE90UyHiKgp0iBuGenILsWdEY81dJF1Vh10=;
        b=JQdNX4BU7kboKhP91D/opXO+kJR+vUyrGMFk1shJvDsNAKMwZ+fB5oFaZ2spPZgoOZ
         XIiztJoLo7BTM/E0LhjZkjoPZ3Nfj4O6+OESxFNfQFo4H5r+AbeZgcgpvts00SClQUpZ
         bz3F+9LMV2/qoZeED5ejCCWqvpESgdaPhBOHMal3AxpDYQIfzWpa9Cl60BON+oo4BUXc
         41Sya347sgU8W46iVrzGvWWWM2gq8uNeqC6T2XtmaH8Khu+I+tIlMEfYPc7QDCsAFsRG
         455TGjglihH0pgUjJXNpQueQN64otY+XkSnIuoN24v9ZwhZiYRlt4NPa83f3FHmgFoUH
         K8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733751945; x=1734356745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5/ugt/9XE90UyHiKgp0iBuGenILsWdEY81dJF1Vh10=;
        b=DI9r1yMXyik+TTZQMITcScPhLYUFSzViBUeKJFuNP0LkGTZWq4zRKhcnm7N+uENaDE
         NA/BbSCGGAqSjJbI3uFx4kTW1wmn9AEKVmb528F/y3Mut8tkTdmcF95O3xTUshjGSU+O
         yTQrGSirnPUw6qGetHhzDhFnKeXZpC2X+yYiF5RWIkB9m8+Xzyv3w6EQxwd8r8+WZUF9
         QSJF6+Nqp6atoOY+SS8ogUSLHNvv+qZmMwomc7Z7p/soAP5qRuEI/upsn9H24we6I6IR
         7qGyjclFYqJdfuujTvrZpa0ZLEw7Se0MZfn1XhkA+mA6aAot96ZsUFc6lOnjnhuT8t7o
         c8Jg==
X-Forwarded-Encrypted: i=1; AJvYcCV8qLEuEcGVC/NHbvB590zi0td58JFPvwM3NmRDGu9TGE/97iWg9ZYGqQQTTSX8hYAHBLiGDcIQsz3pMOjP@vger.kernel.org, AJvYcCXKfzpAmeKwh8N2EtD15khVimnVeJxjJDn/o/RCbgSG2KLLSHIJ7Kbl+p0thtBQmUDtnXr3A/nDF1Dq@vger.kernel.org, AJvYcCXdm5KNKfxar/FUlN9tWeQg2E8r0H/SyzXaCMBoN7GkyUtY7d5tuZYhkjfmKDLYI8zTWPJSUfDJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0OyFxlI7jclVEJoYLBFe07jSr3YgswY503xGpEp6lpJt7kCq5
	2kyqW3zyGAst1XDfpbf5MLIZEoYrSTUn3ZrYSD4hPSR0bPsKBIZC
X-Gm-Gg: ASbGncvKVdUpVPKESRY+715mQFvk6C3maH8CYX8jtqOb5AWp0tT7FDScM1EiloJzLbO
	tnEU5Csv3ur0oS6KatTbn79avjMlCI1pX4ustR/qySJmurvV919+wxxO1xmPMDuPcx3aQ2o68g4
	elVEHqVoAsbKCK2r8i+50RN7LdXvSVUeEVtI1LReDSdTkrJ99D/PROedocVQg1yQ3Cy4NvyU/t+
	ucclzXifnlzqOpFf/DbjXr1Vl21s/gQIKZEg5chHqVXvlRySgDSQe3qdtcgMbKP1Xy3aB5IyMJK
	PBdRQq15ky2dshUy8K8=
X-Google-Smtp-Source: AGHT+IF/955Q0D6SrPHDdoA+/thmeKnCFK3cnvuQRnU3hcvQnrMJ24EeH75EZrWkH637CHTgU5ylrA==
X-Received: by 2002:a05:600c:4447:b0:431:5863:4240 with SMTP id 5b1f17b1804b1-434fffa2a31mr4483995e9.24.1733751945340;
        Mon, 09 Dec 2024 05:45:45 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-434f30bceadsm62705135e9.41.2024.12.09.05.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:45:44 -0800 (PST)
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
Subject: [net-next PATCH v11 4/9] dt-bindings: mfd: Document support for Airoha AN8855 Switch SoC
Date: Mon,  9 Dec 2024 14:44:21 +0100
Message-ID: <20241209134459.27110-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241209134459.27110-1-ansuelsmth@gmail.com>
References: <20241209134459.27110-1-ansuelsmth@gmail.com>
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
 .../bindings/mfd/airoha,an8855-mfd.yaml       | 178 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 179 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/airoha,an8855-mfd.yaml

diff --git a/Documentation/devicetree/bindings/mfd/airoha,an8855-mfd.yaml b/Documentation/devicetree/bindings/mfd/airoha,an8855-mfd.yaml
new file mode 100644
index 000000000000..9ad03499fabb
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/airoha,an8855-mfd.yaml
@@ -0,0 +1,178 @@
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
+        mfd@1 {
+            compatible = "airoha,an8855-mfd";
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


