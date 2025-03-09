Return-Path: <netdev+bounces-173334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB16A5861F
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 18:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90C953ACD30
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 17:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6391F0999;
	Sun,  9 Mar 2025 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EM4AF3o3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB43C1EF36D;
	Sun,  9 Mar 2025 17:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741541274; cv=none; b=j9QKnIrKfK+3cUO8SbUQ/tBtK1i1ZX+QtHEgaZ+OAUdhcf5SmLBwFyTVLGHQrs/WGFGBvC674oCRDAPjmQJUHknUAmlr8HSJtRG8ovX8BpAGlMLSuYr1Msd6Bm6o1VFyoafbm+Bm1/Bh4sb1k3q50tGHiTl4zZeD1VAQAM/qmBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741541274; c=relaxed/simple;
	bh=bn95Pzdh3xtpU2AX9FYj8LlfDaJHLDgvwqllYWjPzYY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ck6FBSgt3XA9bGhgbCunVy28TrR7U7bopdJDuITIV6W63FmPtrDqdHNB9ePTGs4zD7hBbtMf0Dq7Z6Kr0mIK5Jpcv9R/9rrrGWFvSdm6erBsxksILIu7YVEZVs+CtUXQ0hNcka1KOyOXCgITAJj8SfcQVc4z6ICMTbXXAPmXyqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EM4AF3o3; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso19963495e9.0;
        Sun, 09 Mar 2025 10:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741541271; x=1742146071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Ct+nLBWlOvgUgLvId9aYXXOn9pzyLYiT5kel7HrrGs=;
        b=EM4AF3o3OhYPpAsH8aneBN+HuF0lbCTZu+pxIu8PugMS2hANoZgLTqSM1EBNYNqubK
         yYXNtgK4cZcpCMsCkwKPY/qLMY7UdqHSogg/0rTe/ROlg3s1LLxGCyn0IgGefOgTwL+Q
         //X9W7lCGS/zY6jHuLcjbaBKAzPgu8Ue3syMBQUyfgylieAHfaEr2ZuQL6Br7QcIJSv+
         6zUyRkUmpAygtRoamGCWKf7dimlm4F565S/HfLTY5is2G/gSlaFb9tm4+4sPrd4+6Rsp
         NyxRqp4jCjCzeW+k3v2M/iBy9xc+gMFd7Srn/okJsEIjxZtzMDBpdEb8ru08s4ZpcxyO
         GKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741541271; x=1742146071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Ct+nLBWlOvgUgLvId9aYXXOn9pzyLYiT5kel7HrrGs=;
        b=HFC5OzRjL0Fk8zRgAVxtqi4M9idI4AEVLG2etRCPtzKYDVDJyCKJM0gTwlnXMp/EnK
         AAtmzbt/iScqDy22NJzHN4orRyjXsFD8UX06GkLEUywjOoYGqeUUqVBZyfSVEAmsydvo
         F2SyPPBNWD7MZwdH4wTsQ0kqj2xIy7QgR7t6A05IWhPt5moD36nhIn8A1uMDZYNyOtnX
         tNQVgl/yZMmsKHBjTpLZEqSfmf2pqQ3e3Tnlrm0TRPU+iZg/5tsajKx/ntb49QBeH8xs
         OMeChtABhuU8OsWaus9Imguke1TU2yJOPfUp/ymBuxCEiIxn0/TbIPETxHnIso4Q4jAr
         U7cw==
X-Forwarded-Encrypted: i=1; AJvYcCU6RI4YPmBnr5xSZ4x/bgKiUmR9hqvCKtIssVR6hUPt5PybGcaIbfGlUd2pSyXOpVwhxNOqsX4K9eEL@vger.kernel.org, AJvYcCUoqr/23yEXoAbEouVEZrZiiWjY1CD/m3L1ZUd/J84w0dzS779O5bDOHRMOkP2hDyuT5Yl5uaAC@vger.kernel.org, AJvYcCWM2kkr/CscGbOq7gMhiBZnQBa6Jv7+6gC1cVGlvaV6o/j1B8gP1sriXKkcCYwYqA5zcqk1tQSDLc+/BM8a@vger.kernel.org
X-Gm-Message-State: AOJu0YxHt/Ck+ZY00o8G8aUEQwWtF61qsUmY6pvltRvjlbj08rIwRxiw
	/3WdZNEevKkDSAxEHJgwyfRkMe8yD9Dy8FFfohyx9iJNGJpZV5rZ
X-Gm-Gg: ASbGncvvuTXHqBg0pVEKsm5QKo4yWVrBKCOjk/80ezMfXDWcalm0jT2yhlYNd5NijLm
	RiVu/97eFc63d6+G9NSCVKtYAAR3PVrY9PkQsBqKvQ16W8meByF0eqv5YPqUFAN5DEgBkiCI2cb
	AK/Y8EtcgOIa7wFUNFR+ILDriObdyIPggO3mBmIZ8n6x0tGYORodpDZDiERaWAAiQRQmC3z8/GI
	W5tU5N854KFw875xmvoDSKZ3AArZNqNG6+Gu6W1/8ijgMWE9AHknUh59IH279hvNeJJCEvgpxL+
	q9j95iBVPIz90iB60xkodH1JT4YB8fIAwta4+ZYmeKJIOBLEm9b1irZu1vcKtqRQAKp07sWxboE
	vOzMnR2Cj024RlA==
X-Google-Smtp-Source: AGHT+IE9KwI0NQaw6bpM/y6LBoMaIMedmrg0FquztdYIwmh9PZB6VNNmJkRIVYkZk60l2A3A+lIkeA==
X-Received: by 2002:a05:600c:5120:b0:43c:f85d:1245 with SMTP id 5b1f17b1804b1-43cf85d1427mr6009195e9.17.1741541270763;
        Sun, 09 Mar 2025 10:27:50 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3912bfdfddcsm12564875f8f.35.2025.03.09.10.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 10:27:50 -0700 (PDT)
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
Subject: [net-next PATCH v12 03/13] dt-bindings: net: dsa: Document support for Airoha AN8855 DSA Switch
Date: Sun,  9 Mar 2025 18:26:48 +0100
Message-ID: <20250309172717.9067-4-ansuelsmth@gmail.com>
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
index 1e8055b5e162..696ad8465ea8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -726,6 +726,7 @@ L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml
+F:	Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
 F:	Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
 
 AIROHA ETHERNET DRIVER
-- 
2.48.1


