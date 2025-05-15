Return-Path: <netdev+bounces-190700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60323AB84E2
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 13:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F0F49E6995
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 11:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989CF29AAE6;
	Thu, 15 May 2025 11:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fb9bHI/a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C60A298259;
	Thu, 15 May 2025 11:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747308482; cv=none; b=Trvndj7eAXC4PQ3nk6fWUnMXtbKq85jt2qsQqSBP5YMk3TXtAVXd2P0iiP7UsupMKv5G3/t+jrKT59I/YAojyUAF39589yrPTPO/HuLQMcyNj18FzLrS7+w2/2afa62Kc+unG5CCpkwRoHbId7imWqspd3FTPnTGrHfIgvIk5Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747308482; c=relaxed/simple;
	bh=2yGKARmPcHbfZzyzn2WTevDsYdGxrPhfxSpFQ/v7kks=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YSwhrk0WgLWj9vPXQNkU5BLKMFEHu4/mBtU/e7IauZURVvYY2B+SSczLL02DhNtxYosZSaqc36SfibForwxouoWFdVM6jYL+p2BVN2kNohrjwp/vib7PFndGAHdTMYMgh4yvywYbMcQWwTuOe9upeG6DnWzIQpVh5EUIq8gJd38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fb9bHI/a; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so6600795e9.0;
        Thu, 15 May 2025 04:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747308479; x=1747913279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1+WJq3/QRM5Ozd7Q8cMybi3PuINc6tP7bYwsOpEjVlw=;
        b=Fb9bHI/a3YFhd9M+a0CPBNA8gCYQ7/xr0K2YiXEwosKllQYWjaZTEh3l6+DhKjKYfA
         31GEAxJ2zwX9YI1cmXNT5Ix1LhUrV9/sAGwM27jISMculv5qbfc8CdpJpxJvQJ757zPI
         5o3azLj0aeVBvNIENc9J9pvOvXlVpBlFHcyOtQvPFBwJRERSG+JdU3kuTs0KNkq1g3Ur
         nAO5CtQdIsLNrhUCia3KqC9FAapNu8vLR9pUTGbhrxditx5/Le6XC4D5VNdD1aplJq59
         rwW/2gpvwoaVipiuJ6dVPMOCt45kphbr7qDy6wAKC/qZ1f5/UA5Djk35fTjDXFYzILPo
         6wPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747308479; x=1747913279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+WJq3/QRM5Ozd7Q8cMybi3PuINc6tP7bYwsOpEjVlw=;
        b=g4X7NQjqhHk7nh9wicqPvuG8JRVmacmjKy0DidO593sr3FrCKIAEnG6LDKCk80scrB
         r7W2YjvxtAWc/ZhRaoFdqWMvRjK4jGUxuvmDz9o0N8iwFjXkL0GklOe7cKvECe3waHxh
         7kiR0NWgpCRBEW1aku/Sw9m4ED2O890vMWkVMbMms2BL1oVJC83uWJHhxQg7lHfEsJOe
         3fmkftPrNAvFLxta3KY/xt9uebzi7xFdWEZSCnvlsDFABS5PTPASBH2uERWL7GNtpin5
         Amd9KlN/mpoMl6xOh+Din6ePN8ueKKmL9Y/hr6BMBLhuvuREhWIz6rSZkBYbpVmUBaF0
         w7/A==
X-Forwarded-Encrypted: i=1; AJvYcCUW7JuCno86EN1PVxMNDmVOAQTce2lqocWhUF6MmWdpLEb0QxzVO+31Zd34wYdOLGAWBJVy4ToP@vger.kernel.org, AJvYcCUssJFkevIxT4I1Z9AsD4eC3c+s0y/53oiClZFRt2Xzbp2zOq+d3CVQ8UDJpJy9qtdWahJB0A1Km4dwaASJS4g=@vger.kernel.org, AJvYcCVchSA+qb14W+4SPr7Nj0i4hVg+jTJEs0q4EWfVKOz8OJ3Z9Bw6+bxqW97yKHJhr8kbGa17YHQMkfv/@vger.kernel.org, AJvYcCXQBe/9fZyXJE1p/wiegZxkywJ6Zm0pUDV82B3/SkrI+TgSqjJBaYPE4EJ5eZim8womkFLpdQzLcKMmHIQo@vger.kernel.org
X-Gm-Message-State: AOJu0YxTJ9ggAVLoZKFZ3j0raQW3MXg0gCfW35yN9W7c66yu2XgNz+4g
	I2LvdvZqHlnNpJNHLBblzz2Plzq1nIMb/Pr/ZWUx7uGrsqOWYPqr
X-Gm-Gg: ASbGncuK7LGviGT5k1c6rbTrSG4VgSl/6SiNWsufKrflzojMlk2LPuj2M12D+0fzqXr
	3uksG6yz+RobqzjRKobPvIZteJRP2LX2xaH19ti6gCGLFEnrnMmj9Hg6dfUSuWkilc8owbw+vuk
	wA8LaOkvvyhXiBG+Ho2awqSMcOScwI4m3UHu62wuvDbI0gOMwJc5iBsbFXwYOg6YafS/KHCACYj
	SUHTmFLGWaUsiKND3B7y/ok9JR/io2as7vjRYS2UOyswGBD7tlNrlcM/fljtxxpUbm6sW+5M86Y
	rkDk/CXAqO5wJEjZ1ER3NhpXoDr6iYw6ZIhznkgb2S/LsSv6jAQz4kCsbqX1bQ6MBWfxxpz0a59
	RwQ5kNpQPqv3vJX/QLEL6
X-Google-Smtp-Source: AGHT+IExcK82jKxo24nkvH3fj6ItqCMIFxIANB3oCcnlMYsmxHVCEAnjgch1T++hTRvL6NWxfc+PNA==
X-Received: by 2002:a05:600c:154a:b0:440:54ef:dfdc with SMTP id 5b1f17b1804b1-442f96e671dmr17127525e9.8.1747308478584;
        Thu, 15 May 2025 04:27:58 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442f39517f7sm64497795e9.20.2025.05.15.04.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 04:27:58 -0700 (PDT)
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
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Trevor Gross <tmgross@umich.edu>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Michael Klein <michael@fossekall.de>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [net-next PATCH v10 6/7] dt-bindings: net: Document support for Aeonsemi PHYs
Date: Thu, 15 May 2025 13:27:11 +0200
Message-ID: <20250515112721.19323-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250515112721.19323-1-ansuelsmth@gmail.com>
References: <20250515112721.19323-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Aeonsemi PHYs and the requirement of a firmware to correctly work.
Also document the max number of LEDs supported and what PHY ID expose
when no firmware is loaded.

Supported PHYs AS21011JB1, AS21011PB1, AS21010JB1, AS21010PB1,
AS21511JB1, AS21511PB1, AS21510JB1, AS21510PB1, AS21210JB1,
AS21210PB1 that all register with the PHY ID 0x7500 0x9410 on C45
registers before the firmware is loaded.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/net/aeonsemi,as21xxx.yaml        | 122 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml

diff --git a/Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml b/Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml
new file mode 100644
index 000000000000..69eb29dc4d7b
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml
@@ -0,0 +1,122 @@
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
+  0x7500 0x7500 or 0x7500 0x9410 on C45 registers.
+
+  This can be done and is implemented by OEM in 2 different way:
+    - Attached SPI flash directly to the PHY with the firmware. The PHY
+      will self load the firmware in the presence of this configuration.
+    - Manually provided firmware loaded from a file in the filesystem.
+
+  Each PHY can support up to 5 LEDs.
+
+  AS2xxx PHY Name logic:
+
+  AS21x1xxB1
+      ^ ^^
+      | |J: Supports SyncE/PTP
+      | |P: No SyncE/PTP support
+      | 1: Supports 2nd Serdes
+      | 2: Not 2nd Serdes support
+      0: 10G, 5G, 2.5G
+      5: 5G, 2.5G
+      2: 2.5G
+
+allOf:
+  - $ref: ethernet-phy.yaml#
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - ethernet-phy-id7500.9410
+          - ethernet-phy-id7500.9402
+          - ethernet-phy-id7500.9412
+          - ethernet-phy-id7500.9422
+          - ethernet-phy-id7500.9432
+          - ethernet-phy-id7500.9442
+          - ethernet-phy-id7500.9452
+          - ethernet-phy-id7500.9462
+          - ethernet-phy-id7500.9472
+          - ethernet-phy-id7500.9482
+          - ethernet-phy-id7500.9492
+  required:
+    - compatible
+
+properties:
+  reg:
+    maxItems: 1
+
+  firmware-name:
+    description: specify the name of PHY firmware to load
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: ethernet-phy-id7500.9410
+then:
+  required:
+    - firmware-name
+else:
+  properties:
+    firmware-name: false
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
+            compatible = "ethernet-phy-id7500.9410",
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
index 6cc52e99c1f8..d11038a90113 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -650,6 +650,7 @@ AEONSEMI PHY DRIVER
 M:	Christian Marangi <ansuelsmth@gmail.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml
 F:	drivers/net/phy/as21xxx.c
 
 AF8133J THREE-AXIS MAGNETOMETER DRIVER
-- 
2.48.1


