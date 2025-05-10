Return-Path: <netdev+bounces-189492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F07AB2591
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 00:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792234A1CAB
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 22:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CA428751D;
	Sat, 10 May 2025 22:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWcg04ID"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C4422579E;
	Sat, 10 May 2025 22:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746914801; cv=none; b=KyqJdmCn9hhLc0AFZPJl1apMJYqNt2A648AWp+UeZq1yC1ZdhupB4+H2/kGtwcyiojWgUYINrxCYuR5edGsS1dTGLZKkpdgr+EwYXlgwH79IfGuTtwwGO6/LcsjxZJ5vAgmXm83VOnFpDh2aYl7ixfzEFwH1gtcLe9cWY8JQMRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746914801; c=relaxed/simple;
	bh=p1ogddfKyDLswZD+8Lq4q/ukt2Ed9aQburf2hvVJ6Ro=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oeGY9qm9x0HczwsUq+UmqqLfC3Z8g0puplv1lDFEzFZzfdDnGT8PzpCzpsQ0MiF8zUlwqGH31+8yrtRUFA+c5fcCQAFhL6dfuLhxFmG2cMeF8lHNFO5LL5lmbOL6D/a7EIr5uR52drkDMZFO1pvFzRsdyyl1F7X9+veieCuJ7RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWcg04ID; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso35110515e9.0;
        Sat, 10 May 2025 15:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746914797; x=1747519597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uezwVFz0Zcagk+1GhVcJ7am3l2Fc5VtSdFSVCAllSAg=;
        b=lWcg04IDq3BCA1pvoTn8FYr8MjgvvRLPwU6rrMOpcsrTalnTGbUUfjmd+Uv8r6cgjL
         WcNAHn3MNgfhGEKP9E9GqwzAiGzRB/jAmgKNkJqcIabwJPkoj4BBv01c/OfXUo8NGlHk
         uine2OKT3Pc9R13FlJoKZZDv3+2wwP2s/dL/zhqXPp4N969oTQtgWOJZcau3To6ru5S1
         cb73cPYRQfoIiNT9tKJ951EIz0Lw3izDIXFaxy69KffHehj02WJYraJ1EbHafltyQ+xO
         olkp4RwGdGZDmgi1OMIXoATcaYqdBVER9VT1C1UEZcbdePydeQjKQFWnM4x6n6Ut1OVK
         VhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746914797; x=1747519597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uezwVFz0Zcagk+1GhVcJ7am3l2Fc5VtSdFSVCAllSAg=;
        b=bhyinN7kbvGTGggrSqnK04YFeemHJoBxwhD/eLUpLsMDYVgTVOFaC58Ap5MfLMJy5t
         HAM7y2nVAxdjBfp0hlN7+sOLL7vZczjgYUdpkCOVbSA/E41+0a15Y+yr6+mWqg39B4uA
         3QvF9BpC+Ih3BIYBuhicdteZwFVUNbqbBUWh09MGINYoo37Fl0j69GRaNLRnVwW5LgaD
         x7FfhaPEhR5+tT8vN5aComzc31TNGg5cbN31Z/fQQ003MFwdfsSazphbFbJ97PbsdbbP
         7Kf3QsHpU2UBcyw3vdH5xMxOPekfZjtrAcdHCqU9yyY8Gyma0i6ZCv5ukfhpD0zQklRI
         a95g==
X-Forwarded-Encrypted: i=1; AJvYcCUJo4NUQb7HlsktBh5hqIdHCnmbKpT1zZ5z3+yK/EbmGDQ1Dvkf2sOP8LewqOo3SECEiV8YLWqeQB18@vger.kernel.org, AJvYcCWMmQEFx5yjy3U3U82p4GPNB73hU8DyypAp2U2kMthMVGLS7pzaFsedFzrfQxFppZYcPQUedYl0@vger.kernel.org, AJvYcCX1qxGMU3kxOfXz/cJrceZDx9qVEOwbKZReNzFk3iWa94Wa2e/+P98qYZb1lBmOqzMdKfxI+TCd63eLXjPf@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx+GER47P0HXPyNaYtlqdP0bDxaEzJO3ysW0CqT9dVbH7zhRMg
	87GJpiaVKmQH7ArRbyWmHbztIsKA1z5wfF2IcNXWMCz1mWXaGyuH
X-Gm-Gg: ASbGncsLGOBPUtEjyIQOFXukzDstx+BHZFSXZ2iq2KPPun2x7giMiEuY30nqTlOo2S8
	qyphJaJEZwX3FeaJMKlkFEHlyVpEEeegtDC+00CYli+rd/1t1o8QLMldr0AQGVpEAE/bxCICyN+
	NcD7uPVb6i73RyfLpXvt6tTHZnhwhX6p7uL6I1sr0oFSQy6QonDedSv816bI9ioWrSB2hH0PkA8
	g5Y11v0Ti/3iPJuy+8Evh66XjU0beiQ9UBT2fAGyGwPg0YuS6jDy6YMKpb6JyUzzt+mO7TAJgUV
	USAYhWZmrJ7Gbc1M4QFavYOk56WCNG/qyNtHwi1gjfaRWS13U491aFRFM2YKvmEbChFmY8spT+s
	xWmXiib0wkaF+qTOvWrS2yT+6URNmxcQ=
X-Google-Smtp-Source: AGHT+IGP9JfMyxekVc49km65Rk0d9HbKRAhjfd1C75cL8/jzdZRAROY8vu1ehsolWNWgvvfXgjkUhw==
X-Received: by 2002:a05:6000:2ce:b0:39a:c8a8:4fdc with SMTP id ffacd0b85a97d-3a1f6437880mr6624763f8f.16.1746914797475;
        Sat, 10 May 2025 15:06:37 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a1f5a2d2e9sm7477940f8f.75.2025.05.10.15.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 15:06:36 -0700 (PDT)
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
	Sabrina Dubroca <sd@queasysnail.net>,
	Michael Klein <michael@fossekall.de>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH v8 6/6] dt-bindings: net: Document support for Aeonsemi PHYs
Date: Sun, 11 May 2025 00:05:48 +0200
Message-ID: <20250510220556.3352247-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250510220556.3352247-1-ansuelsmth@gmail.com>
References: <20250510220556.3352247-1-ansuelsmth@gmail.com>
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
index 39f66be67729..6ef492ffbaaf 100644
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


