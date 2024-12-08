Return-Path: <netdev+bounces-149933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB479E82DA
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 01:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBBA5166237
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 00:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDDA4D8CE;
	Sun,  8 Dec 2024 00:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJipZ1hF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5573F2B9CD;
	Sun,  8 Dec 2024 00:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733617312; cv=none; b=fV3P99JzbzL1T450dU4RphlfM3/kmYYs+YKjntByXJD2L2afhJAtLS48wXgIBa6fhST4VP5x01/HZ0zvvgqniyJOblhPFL4VGtLtuH/RKmxsrUVRKQTGil+5vn2Kp7XTOMH7kYPSYOgjNRRcMdkNgcH7WSZdECBZBEnYfxvatKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733617312; c=relaxed/simple;
	bh=n49/VEzH8sCIaV+m3bmTiDTM1PMM6Pwtn7awjnKTZkw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RX4NGUU+ytxc85zI6p/op9wKFsGI8YCX5DIMiLYjcRHkZmiFY++mtbKalhgb7pJWkuHXlj3hWkA70McufoYyqb4TlOp175bJQj8Z9oGmRYVKQvJHTLj9vRTsJUFOzBHU0Cx4EikdtUKP9iKJ1++NWdMDB8gdtSrqnBM8fcBKob0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJipZ1hF; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3862f32a33eso708890f8f.3;
        Sat, 07 Dec 2024 16:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733617309; x=1734222109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=45VmYJNhcmv3fVrk1l8qJCs1SYN4r1JhUlNDp0LuyYc=;
        b=NJipZ1hFLu+esHbN4q2cX8rSdF58y6xXQmGz8S22o+/Zf6Ya2EvfqT8aCAxIiWpPbr
         svsRjtQ/VwC8dfQxidpHjg0Oz+4xPPCtXmybOo64BVLy59OBio7cCcwcKBxjtBrjHHcS
         3PLxH8+uPfw+QEZFJ8777fJhxKo6f7RAZAOXs0VFRexXHayUQaRKJU7odFIX6f1UuGBC
         TZ2F7LFm35EL8QcFtvTE48MhIwuvzBEuIzatm6FLiVFDVj6f837xxrFSXZX37NSDYT2g
         OQ/QTvHceTRHm0Y6D/lM47i5s+YByNbeWsD42miH5doT3eCSnNNLs6WsG7E45KFJz3bm
         hUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733617309; x=1734222109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45VmYJNhcmv3fVrk1l8qJCs1SYN4r1JhUlNDp0LuyYc=;
        b=NK2IqQZUUL3Q+3xhCk3/4CxF0XAhweacSbpsY6EaLatGAL23GMPqBMyXa3PJrL/zhF
         mHVdH2TJeCAEr4UdK1Dh6uZWTp5NGPa3o0Bkz6Y5lV+bPKT7viNZZAGAnRF8KM7IC7m4
         MZF7RzKz52L9MiK9BpThrh3mIf9agnW6KDz6V7UWH4t2Ub8Pkfj2sk3ZzeQNSn58I1c5
         OPX+4RVF3J3+ucESV0ntOohJ+5o/RfgEe1p4Stv9Q1+2Q/Fo7h6ikTvZZ8YwY1XoXbCE
         9/Tj7sumFTQqgRLD4P9jzmRdoS25pI6eT9NtoE4ua4DLrqxlOwW9QRDP2FSuQ2+lA6s1
         dt1w==
X-Forwarded-Encrypted: i=1; AJvYcCUCFsQUpwNfm3VBB0Qq7ZBpLWRfUjoC0KCXrpJoCyQlFI9V+TL0dX9UM9VTelT84n8c4mJfRyeQ@vger.kernel.org, AJvYcCVQ9f1ytvANhCsS4LaUSs+Vymt9knZFegQYG2ysjR72iwitj7+YdqQnTAUoIPdUttiy9VLtduQeEX9b@vger.kernel.org, AJvYcCX542o6GI0VokAEDjHxfB8+kuxKlLxmGud9Pra1mUuRi5UeYy7c4VDOT2f2UCdGpMC+qtFiCOcppeo75JEF@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqs0taCPP8h0T/yc9AEmDKxAQiqdcA5aug6Vl6eGxCnskj79OP
	7ypGGgB7EtVEVbY2f01rBr33MwEAs37LjE/C0pqO/3ewZrEu9/iA
X-Gm-Gg: ASbGncuLcglGWaoqrryrO3Vm6mGeHV3e7jJ6YPoDzCtYba4zVty5ip76HddKzZvi9gw
	+RcpMN1iY0MZgVkWdzqp7oI9kLSAHSfU5OICR26evZeYpjipaZhNLyy0tL0DC9BJ2RJXAPR6a3d
	9Q5EcduWEu0LtkWUm6zV5zNKiBeHtA+YDmafznAa/f+RogZKH3t5LpmyQNekOixSJzlqqSBfb1f
	clBP0XMN7VlOTj16JE43xv67AT3Yas80Q/SXCjYGatcD0nPLji33L1Z7DU5NZgI/ndjddPQCVpm
	xl3Gbt+ukbrAPV9zgO0=
X-Google-Smtp-Source: AGHT+IE+s/gspwYFYg8pezeI9DQmCJfh6aF6rkLll78p+H9HlSs2z60eiD6aoDwEfVvunic3yb6nOg==
X-Received: by 2002:a5d:588b:0:b0:382:6f2:df7a with SMTP id ffacd0b85a97d-3862b37afa8mr6349809f8f.34.1733617308528;
        Sat, 07 Dec 2024 16:21:48 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38621909644sm8719170f8f.76.2024.12.07.16.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 16:21:47 -0800 (PST)
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
Subject: [net-next PATCH v10 3/9] dt-bindings: net: dsa: Document support for Airoha AN8855 DSA Switch
Date: Sun,  8 Dec 2024 01:20:38 +0100
Message-ID: <20241208002105.18074-4-ansuelsmth@gmail.com>
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

Document support for Airoha AN8855 5-port Gigabit Switch.

It does expose the 5 Internal PHYs on the MDIO bus and each port
can access the Switch register space by configurting the PHY page.

Each internal PHY might require calibration with the fused EFUSE on
the switch exposed by the Airoha AN8855 SoC NVMEM.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../net/dsa/airoha,an8855-switch.yaml         | 105 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 106 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml

diff --git a/Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml b/Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
new file mode 100644
index 000000000000..63bcbebd6a29
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/dsa/airoha,an8855-switch.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha AN8855 Gigabit Switch
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description: >
+  Airoha AN8855 is a 5-port Gigabit Switch.
+
+  It does expose the 5 Internal PHYs on the MDIO bus and each port
+  can access the Switch register space by configurting the PHY page.
+
+  Each internal PHY might require calibration with the fused EFUSE on
+  the switch exposed by the Airoha AN8855 SoC NVMEM.
+
+$ref: dsa.yaml#
+
+properties:
+  compatible:
+    const: airoha,an8855-switch
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
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    ethernet-switch {
+        compatible = "airoha,an8855-switch";
+        reset-gpios = <&pio 39 0>;
+
+        airoha,ext-surge;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                label = "lan1";
+                phy-mode = "internal";
+                phy-handle = <&internal_phy1>;
+            };
+
+            port@1 {
+                reg = <1>;
+                label = "lan2";
+                phy-mode = "internal";
+                phy-handle = <&internal_phy2>;
+            };
+
+            port@2 {
+                reg = <2>;
+                label = "lan3";
+                phy-mode = "internal";
+                phy-handle = <&internal_phy3>;
+            };
+
+            port@3 {
+                reg = <3>;
+                label = "lan4";
+                phy-mode = "internal";
+                phy-handle = <&internal_phy4>;
+            };
+
+            port@4 {
+                reg = <4>;
+                label = "wan";
+                phy-mode = "internal";
+                phy-handle = <&internal_phy5>;
+            };
+
+            port@5 {
+                reg = <5>;
+                label = "cpu";
+                ethernet = <&gmac0>;
+                phy-mode = "2500base-x";
+
+                fixed-link {
+                    speed = <2500>;
+                    full-duplex;
+                    pause;
+                };
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index e3569fe5f3de..fd37e829fab5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -718,6 +718,7 @@ L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml
+F:	Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
 F:	Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
 
 AIROHA ETHERNET DRIVER
-- 
2.45.2


