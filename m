Return-Path: <netdev+bounces-176982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E62EA6D250
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 23:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB813AD07A
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 22:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77CA1C84BC;
	Sun, 23 Mar 2025 22:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKXBdL3R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1936178F52;
	Sun, 23 Mar 2025 22:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742770512; cv=none; b=NfFgmjHhM90eYYBrYhGAck33Ym+3DozoqvaZLuwjajfbzojd+bwUpVQ6t1KVyKj6CrotGb+/tSNx4REPGO1IMpS+Agr0ZfHk3hkNAJ6omtvYGR7aRGGECoIK4ZXXAkWiv6UUbcBhsXDjhX/no+B2RHm7Uu0qh1LtkvkFbyBLLQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742770512; c=relaxed/simple;
	bh=GQt07esGn+aeKgll8qN0I0EbwlD3oTZ1P43ARrEgJsw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dl1Mb6t9nf46fOTAFHfngWz3mg2pgRlpwBrhwGCfEwT8d19O/9JAoTb6Mp1R1r9+D3ILG6EXe0QiP4bRHT0fiV+eWfSAbs+VPASZf4gil/NrqzoLzKwk3Z9+hoVPLbSDlCcsJAtQyX3lhJSgAUiKERbAkS8UrRFwtVhYkAiwDXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKXBdL3R; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3913b539aabso1994826f8f.2;
        Sun, 23 Mar 2025 15:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742770509; x=1743375309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oOSmuF30hQhsZshA1dM7YsZdIW4f3itq09DSiAmlklo=;
        b=mKXBdL3RDt56P+GP3felUrlM9mshbpeYjhiL5YXUsBqnMmV4kSpba0i4U31kITYFx3
         Vq/FUMLqjApkagR/dSotxx4AFmar1WLZJiG4WWqztI3PkVrS0aOpHnp5m2MRDGiiywPO
         cIOYJEFy5FgGyZnNSpjulgE2gfsrdc8yAR/E3545QNGUuxyRWmTB5Yp5ulB0yV11j165
         5rXlU2t+pOebJl73OKmsbRJOrM7dTL5h65ibodqorR+htIrKUXHUzNWczHlzWB64RDjC
         3fz0eIJYVBPXWHsj5jEoCSXxzIA8sRrXK/gfG/t4+01p2oSrxvAB3Z27EwHik1nels5D
         35gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742770509; x=1743375309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOSmuF30hQhsZshA1dM7YsZdIW4f3itq09DSiAmlklo=;
        b=vb/vMMwCiZ5ws18TViikauVuQWO+SvE2VRoaSO0FySelArl8JG6j65/r3E5MBCbV3j
         DhtJqn8Kq+hApL8Vq4c9bXeq32zu35UvKmU0g7JUllRs7LtPcJYfcli+H9wrwD//Dof1
         K1VQaBJtJkp+czd+UUMDZMi0NOFuxOyVVl1gHZIzjBI8/wHBseI9jjZB3xsPbU9OKzJe
         um84NJYxKiWEMvje2Ihxx+Q0oNW0teC7CpAv/D4CrnhCUjIjM7pOmyZ/OW+4CyoyVOtF
         vXxcI0j6g/ew+r3nuj1qjv3rvoAOAy/0odxPRC/KOr8tEbIOBorhQ3k6jvsgdyKytGq5
         IM6A==
X-Forwarded-Encrypted: i=1; AJvYcCUDbd4VNqbTx7BdADbDRZtwYTJ1b0i6xji00g72qtxRaz1eSikCd5CLRMe1K/+USmFvR5S67P5g+LDf@vger.kernel.org, AJvYcCUTs27qNzBTLPtCBAL/2t28j9jfXP8NH3XB1ZD/NdH7LhRyY9Cloo95sqBlsNclS3WbUtLWqXjXS/h8gocM@vger.kernel.org, AJvYcCVWunQysriKNb1M8Wc89TBAt9/C0UJwhL3JcpfqBPN8R5tSXKAcOqc/iomBTj6HYH5uZIDZBpPk@vger.kernel.org
X-Gm-Message-State: AOJu0YzzatFrxicKFLddxbVsTpYf4K2rL6kuulTv7zihHzkJIpbRthP8
	MIvwPRjUJMvh9ugxLoVdTO3cDgbQLRgapldCfU2iund2Szv3yDzL
X-Gm-Gg: ASbGncvKhxplvbf7BAuEHRPD+5JwkIvOmexDIZk4zEjrWoZuC4JwinZ8uu5vojRMJBL
	mfd0Cuj2WjwGHCBeA/C/co3syraIs7HDP3LnKZWC090uM1B/M49FgxllmK0B3nM5NNT0CTRCUvA
	nBYliv1t1Ysf331fR6Hx0oZJt0VyUPTj0BKR8rttoRbiLUT+oxduI54gysfeA8X9l3csd+tWYcG
	Ps2QboXqqiyixGJuLfhgpjTvHja/EKgO1aTfPpvGpnpicT11063lrMEgOFWX0JmyeAXxKEP2/GA
	gfkH/EKCYYsLUMoPmnU4AebFWUd1Z/2A8opGImNMt3JxTe1ZlEHIffGdy+Ryi/E0ZvrcHzujskw
	C9S/4zYXDG0Tw4w==
X-Google-Smtp-Source: AGHT+IHdCjK9tgTU4vMf0E2osA83T0jjCCRtAki4Zpd82WfsFJW8/gdQ06Qwo98HTGoDmbmovm1HQw==
X-Received: by 2002:a05:6000:2c2:b0:391:2df9:772d with SMTP id ffacd0b85a97d-3997f90f731mr11301315f8f.13.1742770509270;
        Sun, 23 Mar 2025 15:55:09 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3997f9a3f36sm9171129f8f.32.2025.03.23.15.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 15:55:08 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH 2/2] dt-bindings: net: Document support for Aeonsemi PHYs
Date: Sun, 23 Mar 2025 23:54:27 +0100
Message-ID: <20250323225439.32400-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250323225439.32400-1-ansuelsmth@gmail.com>
References: <20250323225439.32400-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document support for Aeonsemi PHYs and the requirement of a firmware to
correctly work. Also document the max number of LEDs supported and what
PHY ID expose when no firmware is loaded.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/net/aeonsemi,as21xxx.yaml        | 87 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml

diff --git a/Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml b/Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml
new file mode 100644
index 000000000000..0549abcd3929
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/aeonsemi,as21xxx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aeonsemi AS21XXX Ethernet PHY
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description: |
+  Aeonsemi AS21xxx Ethernet PHYs requires a firmware to be loaded to actually
+  work. The same firmware is compatible with various PHYs of the same family.
+
+  A PHY with not firmware loaded will be exposed on the MDIO bus with ID
+  0x7500 0x7500
+
+  This can be done and is implemented by OEM in 2 different way:
+    - Attached SPI flash directly to the PHY with the firmware. The PHY
+      will self load the firmware in the presence of this configuration.
+    - Manually provided firmware loaded from a file in the filesystem.
+
+  Each PHY can support up to 5 LEDs.
+
+allOf:
+  - $ref: ethernet-phy.yaml#
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - ethernet-phy-id7500.7500
+  required:
+    - compatible
+
+properties:
+  reg:
+    maxItems: 1
+
+  firmware-name:
+    description: specify the name of PHY firmware to load
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy@1f {
+            compatible = "ethernet-phy-id7500.7500",
+                         "ethernet-phy-ieee802.3-c45";
+
+            reg = <31>;
+            firmware-name = "as21x1x_fw.bin";
+
+            leds {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                led@0 {
+                    reg = <0>;
+                    color = <LED_COLOR_ID_GREEN>;
+                    function = LED_FUNCTION_LAN;
+                    function-enumerator = <0>;
+                    default-state = "keep";
+                };
+
+                led@1 {
+                    reg = <1>;
+                    color = <LED_COLOR_ID_GREEN>;
+                    function = LED_FUNCTION_LAN;
+                    function-enumerator = <1>;
+                    default-state = "keep";
+                };
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 9a2df6d221bd..59a863dd3b70 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -649,6 +649,7 @@ AEONSEMI PHY DRIVER
 M:	Christian Marangi <ansuelsmth@gmail.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml
 F:	drivers/net/phy/as21xxx.c
 
 AF8133J THREE-AXIS MAGNETOMETER DRIVER
-- 
2.48.1


