Return-Path: <netdev+bounces-191318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9635ABAC56
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 22:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57CF27AC884
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 20:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF59A21ABAF;
	Sat, 17 May 2025 20:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IO8zZh+Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE8E219EB6;
	Sat, 17 May 2025 20:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747512881; cv=none; b=fU4C13SdMmGi7qFcTgqirbz79K6PxPt9Y3G8JScswdZQFFc/sACtu7srakNfPFvwGH/O3U+xiZ9ws7oTRUO1seMHnqYtN/1qBQDl+ZM9gmo6+3ZgJUf4cFgaYc78RN2eMsf6ZuvrJAs9DNmaQRQnL+YK/WmprWwEVF0TSNHURVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747512881; c=relaxed/simple;
	bh=2yGKARmPcHbfZzyzn2WTevDsYdGxrPhfxSpFQ/v7kks=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bCs6vf32q+gqU2FnzXl6EG3yujw5xLx9RSCUf1//pa/eFuHQC6u6MFHw2FhB1OUhfNCiCntCcF29XihhR+/IxqQgCYSyQBAuMtnSN9dAqblZJ5jlRAzApG2awiAb6q0Y6QWu85Z9kQg18CRWChSlnwDEiySwvJvps9u/yUoRjZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IO8zZh+Z; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-442ed8a275fso38628835e9.2;
        Sat, 17 May 2025 13:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747512878; x=1748117678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1+WJq3/QRM5Ozd7Q8cMybi3PuINc6tP7bYwsOpEjVlw=;
        b=IO8zZh+ZBCx4T/i3oOkqHVlbhwKDp9TQR3TcPA//R3BtAiEj0l+gwz94or1idGXiYZ
         jAk0EySIg5dOvAtj0jIl6mzKsc91k+jcDHf/SQwTcP0Cd9oEMsc5kIlltMT7g5UBgDUD
         gBeUWizArWCmSHV9YNRUxchk372FcpiTVc/PI4LmcsfQMda/QRU4Ib2XmTTNmptNB5rP
         tDLoXs06yWSWOcyW6zeZJVmi+2uoJ7vFwtbCr2QKzPDGq0FzyE50w+Gt8g4I4zynEzZe
         x95+UpFADfegPk1pXa+zKnQIcEb6I2H45lUjT1avEBn/WgGIapaUVs3VyF29fli5MSFm
         BiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747512878; x=1748117678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+WJq3/QRM5Ozd7Q8cMybi3PuINc6tP7bYwsOpEjVlw=;
        b=nr0kXgI9RuTUGHlONfaf9biHyNcW8mDRLXBlDTFYarnj35afxqAskkBdESyEiW9KaF
         GocDKScVXd+Pp/sY3wfmosnahgcDq7tkSHOST6eoPWFQdVhmaQw+yKV41iPXD2NzDl7r
         dIc6fHzOsk53TcLmDFfiYLopWq8B+j67fIbBAzIAOksDqllPaeOo4K2FFEjaOU3jHHNK
         s4iTyjBMGsz6pUbtW9Ck6ABbGFatWslnPfuJSjE1gYPMedC/4ikAWu2+rfwnj68x95sv
         JPVgdIcaGXmXpw6m1f5eMuheNHO+M0IgrqMQFWxU8UPyZyBszhNWopuQSLVweKtIM4cr
         kQgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+CZRaswF6lVh2Impq+pt9gB2hLGONcce97fkAklRS8FqINpeqGlp/CLaeJ8Zg3DD4H5HaAkBSEuRl3VEnmaw=@vger.kernel.org, AJvYcCVSnDQvw/Sw8nseyhS9324Go9k9pcXavA3JAY08ClyrhAATFK0kGf8MADeTKxjLnWY+sOpfzgzf@vger.kernel.org, AJvYcCWlqa1FY5usYICl583nmLkBfJCxAABPzmb2+QeJMIn/LDKUy2HnqnvnOuanfhdboWzrjONCjpTw7unh@vger.kernel.org, AJvYcCXuvboBEhoi50kQkgWZG9BEecSgpurA3i9U2UkRWDdB8ij8qHXMfJ5pgci/k0QdVESW9GcotgMFyFj7k4O+@vger.kernel.org
X-Gm-Message-State: AOJu0Yyiv8K+fp+UOBDTgGjo7VyEeD8TC8HWtC8oPYinS8UcgpgmJByR
	/jGJuVdRq6vY5T/Tp5E9Omqi9+g9lUg7WnFhbdmuvUXPxIR0+aOZTD17
X-Gm-Gg: ASbGnctxNtW45TNJI+6jkJbbiXu9q76XCThZuVkqdDa9+7cX9TL1bBY6/zKFxWN/mH+
	1xjYxdizhYcqYfJGBD9pFRZ9QR0j02V5IDcsJrJMRzZjO2D3DYS0E4/XRlhcAqY8ICJgS3xo0YZ
	LUoHH3SCP7B1AsWlsZAmfhk8dZOlfDPKFSB10qmqkZbD4tGsRLnA81HEk3A6OXbUNdBi/EMtyA/
	1e7o+IjgDecVEqPFa9+kRlip6/XNqO/9wiywvHpxfkjAiUyF8fOJ7bcc2QLqAY3CRgh5I2NOJYf
	jv7QnK98nTTA8w0lb3gMTV493+8A5M19BdjB2BC9NMgq02EgDVRNin7a+0bokXv8dnDrKKrJBNZ
	R9/fOYESunCMlTF0Br45F
X-Google-Smtp-Source: AGHT+IEMYLcYs6Tqfs3/y2GsUBIqhzMkMi1qwMQIwzchu5sAPL3gwZ2+PECG9rDdW0ZYMuv/KfO3ng==
X-Received: by 2002:a05:600c:3e88:b0:43c:fbbf:7bf1 with SMTP id 5b1f17b1804b1-442fd6724bbmr85451855e9.30.1747512877584;
        Sat, 17 May 2025 13:14:37 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442fd4fdcccsm85345445e9.6.2025.05.17.13.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 13:14:37 -0700 (PDT)
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
Subject: [net-next PATCH v12 6/6] dt-bindings: net: Document support for Aeonsemi PHYs
Date: Sat, 17 May 2025 22:13:50 +0200
Message-ID: <20250517201353.5137-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250517201353.5137-1-ansuelsmth@gmail.com>
References: <20250517201353.5137-1-ansuelsmth@gmail.com>
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


