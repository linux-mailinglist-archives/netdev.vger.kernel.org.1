Return-Path: <netdev+bounces-150208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAE29E979E
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 14:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E19F316542B
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 13:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF721B0419;
	Mon,  9 Dec 2024 13:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqNzbyZ7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F941ACEBD;
	Mon,  9 Dec 2024 13:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733751947; cv=none; b=jfc8L9tWLB0E0Z+2zCX8TPM2jlKyYZSFYa3Z+h2pjWQ3lK0/je0Aa37NrYj1tl7xngX/pv03GmkETEwj46NoYdhRkDq620iYr5YoWvfEHdHYmXcKiPgb4AOGb+sOTb0raMz8H9tOAASRHcsuCR3sU0/amhd1XjhpiHiOOM/HuwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733751947; c=relaxed/simple;
	bh=n49/VEzH8sCIaV+m3bmTiDTM1PMM6Pwtn7awjnKTZkw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DW+ia9rXHuL4UuIkETxGOhwxD7KMJSqTV7cVJeqi6gCnWXcEDWLVqocwGjWGpbn0G2uLpmRrrnIwAlkO4fu6kyZBV+CDajUk0OQHFi9ppL7enGVacm7nOGIyAet9rqXWB2nR2wY4U9Rh6Eqom48Pgll+W/pKDlkl8fMhFZVbCiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqNzbyZ7; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434f80457a4so5644715e9.0;
        Mon, 09 Dec 2024 05:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733751944; x=1734356744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=45VmYJNhcmv3fVrk1l8qJCs1SYN4r1JhUlNDp0LuyYc=;
        b=KqNzbyZ7Im13eXzRMAryQyrwc6eYAItOocyduPzv9i17s3NKxCSQR5puXQ84jCK87K
         FIm5HaL0JiupMO0l/NbLCYm2j0uUdZwI6onWy2U5BIzfXJTCPJksfPQQDp+nyx7gkA7m
         6cIshQxHQxzzOvG6JvH0f54WJmU+VYhPjjiky0fsOU9+5SwAmRgZa+YvctjTaWLQvJp/
         8hZQMSNBWU6ckRBmhRWuyNa2IZzl45i3xjemeYGpeVtLJId6moL7LkpgEC30WnZagTBF
         SbMqTPtkFPiCMl3dzirdZmgk2bMTEyzWMFPvaUqLv+CK7wBx2Dua5MRmFMr8r4k+gor5
         VNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733751944; x=1734356744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45VmYJNhcmv3fVrk1l8qJCs1SYN4r1JhUlNDp0LuyYc=;
        b=QBhFig9WznhVibqWecUaH8mhBMQlMFILlk+FwBGsh1wm2Q51pA6vXe/jxZc9NcBDVj
         Pg97wq6TgWQPvCQYO/7KhiAh4BXrDrs13Lm9OQXASHfQzs7KjyzyMeO+Qvjs6SOBAvgx
         0FJxQGoZ2tVAkBJtEKaKExC3sfRIvEGcOZzNpMhmGVHQL+jYpw67yDz9rUUBATBUZEwx
         u+Jpt/poiLNf2cyv8R8Ws9L3T4aHHMccOoUuH3Zsinq6ju8L2LUWXO3NhrKzJllORZLT
         rBT59PCAAon7bkeukLWaSjSLBQLBcsK8EPcndhkiRzuZtRjSNHngoiFn3Bedmemay/+e
         c7eA==
X-Forwarded-Encrypted: i=1; AJvYcCUDGDe3Y/ixRgFpy1RxQSLZhyTey/8nYln77WmJU0sqWEpAfkrnV/7VNXxcIqW4YKS58+1f4qbX@vger.kernel.org, AJvYcCWxBBY0Cnpf5r7hFd542dVGu/WhWH13kFnfWT0yR3EZkrgEUBWZc5gMmHufX5VtuHWSxa35aAMljQyMVeXo@vger.kernel.org, AJvYcCX1NEUyznhiaUVFvj5Kb1ttLOKHeHTPnZtfxwGHVlFH65LzqoSWHVXyXHOyLyd6MAE5Is8nZZMMDhsi@vger.kernel.org
X-Gm-Message-State: AOJu0Yys3IR1uRHgJT1DCjBHntajMGWjsGYrbs883iOIXLRmL96sHDo4
	uKojKNDbf/cDRGn6Nj2RCv9SEwaon844bosIuyGVZn3rkekYQvPr
X-Gm-Gg: ASbGncuvsqf7W6rQstEeUjE4k8CuU/I9KBZL2IyIFyOfGmRMSV/LGt4t72YEHiyuGyH
	viNBEISOQFNasv0UagSia6iSBABzBVCXW1ikAVqIrB4GlKLAH8NouOwuInAbee4JHr7jUMkL9+Y
	2VwHuXbNBi9JPZ8BqZID4M1J6XuvScUSKhZoubXjxkhKfwIpKHYVqvCZuwLceHumAeJj/S3JxyT
	7VKCj/2S7T8Um9ID7q+c5DoVCC9drluWM7XrmKJwUyp1FRDtLiclNqWkLkx5VJa/q/r8vLAXF9G
	qbARGZ7plXsDt4xEkpY=
X-Google-Smtp-Source: AGHT+IGr7K2BOLK5syBzNCV2a6l3Cis+RkNWHpzBtkhEyPVhCmLeJOwSZmq5GG5YBIgwWxlygHngzA==
X-Received: by 2002:a05:6000:4007:b0:385:df17:2148 with SMTP id ffacd0b85a97d-3861bf7374emr13321092f8f.20.1733751943847;
        Mon, 09 Dec 2024 05:45:43 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-434f30bceadsm62705135e9.41.2024.12.09.05.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:45:43 -0800 (PST)
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
Subject: [net-next PATCH v11 3/9] dt-bindings: net: dsa: Document support for Airoha AN8855 DSA Switch
Date: Mon,  9 Dec 2024 14:44:20 +0100
Message-ID: <20241209134459.27110-4-ansuelsmth@gmail.com>
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


