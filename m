Return-Path: <netdev+bounces-191180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5475ABA51A
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 23:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA1F21B678CE
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 21:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FE428313D;
	Fri, 16 May 2025 21:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSFfYNUF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB92E28002D;
	Fri, 16 May 2025 21:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747430676; cv=none; b=uP35FS4AiHm9suRvqL+p6pUK9EAwYTgQW478K5GIEubxaXjbTIfWG5jDYxEHUBpp4/JO/VLcPBhksckV7rr6l7pSV095rrZo6Rm+Q8Qfmgzsmh7LUwD9XYn1daZQneykwEeJS/U7jYSmxL4F1hmZyOiblC+pHPUslcmS7aZJbN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747430676; c=relaxed/simple;
	bh=2yGKARmPcHbfZzyzn2WTevDsYdGxrPhfxSpFQ/v7kks=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cRNP3TgGLSI749c1wBA2iNKilVumk4zpbOUThShbXAiwqaKLkGPYoOFxbTw64UPwNJzM5LJbbB22E4NbbpWd0Uw61/oj1mm2rVPK5/zFsOoXK6Vqu2gMmVxXzm2n3TU8KP1211J6FgvyYhCdoZnJBKyMH1u4RybmSTLWWlIB5fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSFfYNUF; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-442f9043f56so12212855e9.0;
        Fri, 16 May 2025 14:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747430673; x=1748035473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1+WJq3/QRM5Ozd7Q8cMybi3PuINc6tP7bYwsOpEjVlw=;
        b=WSFfYNUFrUP+h3u5b1KG2njzWaGXeav4Ob0MclIVj9KJzH5i3G4PvBUKqKYH6/6NOS
         BeX8UUvHsvQwdTC1QDTztAGaA/5FG1i/KpAo7lAYX+SGmepT5Vz9ilvsJy8S0h5pZQLl
         +D4x8v0APrz6l92GQVoITwXgeQLbNul4LvKl/GDsRj6CtKyIht7ojSQpiWZLhL8y6nfb
         cBe5XVkHn8rknGT3p8JZWAJ0enMkWrBwYpB+XTDwXMWif5C4w9wy3T+6LNCr2WZeUW8U
         HD5Enis1UZ7E7AMAbL3Rv5DgOY7BhIqO7GUDEXqy01nnw+OSLbLaQozzB0PaboJ+Irwt
         N4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747430673; x=1748035473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+WJq3/QRM5Ozd7Q8cMybi3PuINc6tP7bYwsOpEjVlw=;
        b=A+wtJ4/it6ft5GbO0k4QlPYgxELpdN9Rp18oXnqwf1/5q38LAplYofLtlFhkex4Nh7
         1YPDfz13Fhg/SUoAROXx136eMHJ84Xb5GhSkSIGAw4KTc3qj7HANozC7cpgCTIcD+FIK
         94+8o6nsvdrpNUtoH0bidw9Y79lQ9dfg2v07+5ByGbNYo2zvq8EIvqFquGzFewnrk/i7
         kXvGxaZoVvRFm1W5OZ7z8B4CEKtxYK0T+hpwePnDBV/2ClIPXTSc3EVPUxWv1E8JBqtR
         ydHNdrb4mL5Oe4eB97Xg/9V3vv7u/Rr/ZF/BP6i7JjuYuinz1XLRK2yEkYuteH4A0Csd
         uM9g==
X-Forwarded-Encrypted: i=1; AJvYcCUuK+tbjwmshI5cwVOzn4jAyKHmrwZZDZmXr8w0nZM6gbDHr7bMaUtP7DoZdgiMherPBNBmsxnhUXle@vger.kernel.org, AJvYcCVcWDNiUqA8SB/JHh5v3a72dhutzVvJxRuhO0tfIFMb7NB8pNM2/FbNoJ32sOI7pwDWz12kENclAALb3u61@vger.kernel.org, AJvYcCVoWVaRF/fjQlrzSVwRHZParYNmn6B4uh3Qy4X5QS/uO3clyik0901DVIOLEWVy6xJZJ5EmPCrz@vger.kernel.org, AJvYcCXmaXez8gWlcXCHVsrLIiTLEQ5fZKDeZ7+xLiRRalcWP/Ssz62A6rrqreDJ/Yz5jidKy5Fyi7/an0pE/Z3VLqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMx4Ric0AEpyami5sYkJgYwJZP+pURBMCjIqdM9mrmRBFym1Vv
	LtHg27Da0MM16j/PD8o7COmDtEW67a+VvPWN7dHiEi6FbEjP/uEktQvo
X-Gm-Gg: ASbGncuFluM3LoyIL+HyJApxAPtM43VNZSlfow5CiwG5mVwSHWD3PFK0L8BUPoaZ9q5
	QHHUblkK/AkNa0uL5ffawCIE5Ko5D4ggYhK3lEccWTsbKT6y7/RaM0LiifEDd69YyrKlkGJz2r5
	aNj2ejUcwoZiPeLw9rpckm8LzMzvhd0JUC3495thRMQ8eZwI7/5d66rWERnEacEqvrA3f7BN0ee
	NmUr+m58mLsbe8UGN156XBO/qGtyrVroE74cOlk7LeqQU9dkwj+LN281qZtfUa7CY778cEn1JtE
	nv0TJLFydNd8pP4YKqMqqTUPD8K6B5PsQoyzYyTvxqd/OUmCFJMI65t1JQ5fD+5ZF8/YIQv4XAE
	NFpA15CFkhX+sfu8HJhsb
X-Google-Smtp-Source: AGHT+IHcr0hJXxZSIZz6qjXZcY/SIsaPeJBahT3ZHLg8Otz/MEkPgdSmUHo2BlD4P8UWNOIg9pBYvw==
X-Received: by 2002:a05:6000:1445:b0:3a3:643e:2542 with SMTP id ffacd0b85a97d-3a3643e256dmr1986341f8f.26.1747430673163;
        Fri, 16 May 2025 14:24:33 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442f39e84d3sm126293555e9.32.2025.05.16.14.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 14:24:32 -0700 (PDT)
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
Subject: [net-next PATCH v11 6/6] dt-bindings: net: Document support for Aeonsemi PHYs
Date: Fri, 16 May 2025 23:23:31 +0200
Message-ID: <20250516212354.32313-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250516212354.32313-1-ansuelsmth@gmail.com>
References: <20250516212354.32313-1-ansuelsmth@gmail.com>
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


