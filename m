Return-Path: <netdev+bounces-306835-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EWe/I98iUmriMQMAu9opvQ
	(envelope-from <netdev+bounces-306835-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 13:02:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 84347741577
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 13:02:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Kp7MPdQh;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306835-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-306835-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 80216300682B
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE55381EB3;
	Sat, 11 Jul 2026 11:02:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C2C284690
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 11:02:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783767770; cv=none; b=exXa4kKvhsoYSIuzrN5AQEDnkZinscrGQItFpdQoXDCDkruFXUgV5VDB8L9sxH/6vXAF7z+keFRYRdBVjrjSWjM+2zzBrNvNA7kcjjl0/U761epSBmYllAQ1njirXZ1e1fkaLjqWY0iwJJ6ow2wk1unc5sxHM7Y+jw7fGESrmLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783767770; c=relaxed/simple;
	bh=EHTpCHdZwja+uN3Dg/J4DQCi+rw6FIewOGElpjfS2sg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c8TQqI+tqZYQVo+XF/RM/7Or6rz+wwro86RaihHMHlUgXlWAd2LlKPJ0SAdradZb9yoLsNAht/rd1COqrc3czFzEOC7hEz16iWenE1Me+O0tBs9UcfCtMO99NAp2MrypKSZS9I49zA6fe0729eFMPYuhSsqlejot76oykJXlPaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kp7MPdQh; arc=none smtp.client-ip=209.85.221.52
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-475cb71a4ebso1685515f8f.0
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 04:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783767767; x=1784372567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=C8cGHLB3QT8sUHUeTZCVrftP4bgQmCTXrZx4FHEvx00=;
        b=Kp7MPdQheAJiwAi+m7hQUCOvEm9d2MELzlYdLqEuyzkKVsvkDPtkwy2dGNK+lHm4Sm
         uHWFLku85Xlf2W7Vk4WeV4BlSbaX8zsnqmkIc6KRoEKz4NGQgRRk7pnY8wHcHUDKLc5q
         JG4rTM5gdFQmIMreforRkJ5rT3NpjsqIBoSk1bUvexMfqywIJ+Cjz+XeqyRByP4BnRH+
         nhNpi7VrumiK6TXu8eD0athAxqkL1rlMaO0BXxPx/20IqpAaQGUODJ3jvQ+WirNVNls1
         lv5Yy7nfs41DLJ7NpV2RhO6tAmfU79roF7LCi3SkyMJp4p27e+WuQL38RxuD/RGId2UC
         rZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783767767; x=1784372567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C8cGHLB3QT8sUHUeTZCVrftP4bgQmCTXrZx4FHEvx00=;
        b=p5dbOKHOyLNm/HYh+4fkaOzGou3K38oPQAn91+5yhqRF7eqsZhylIAD/pqDoxZF4BV
         EgOiWQfOBZNet0QdFz4ngZy0+6tL9kgFxRcHZ2kt0/jkZxmpj79ytTKJx0P8PraYIMcR
         R6rJ9yKxrzB7KFAKcgVbxT1vky8WYs/NAHnTF1/jmt1dSIG/MDAKJ0kGvUBGmhUiVQyZ
         JuaUQ8mVg6h75YOKMB7bE6MyDV6nxgPmc4aHR3DzOaLsn1IVhMLOswVg3cynOADLNws2
         H0dp3ztwA42fpSe5Zs6/8foISqpPm8I0T4YblcOtvtfe5DOroKeNGhMEVfpDGbOF2qWz
         i3tg==
X-Forwarded-Encrypted: i=1; AHgh+Row3IwhEBs3HCObmDoj6vfjt+FL2lsvKBCC8TG8W/0zSZCtYO1DxKEyQnRUG9fsXqKzick4QjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmJc/FykqDEXQzDcECDHCxZuFCutnxUtcRYDV2ZGtc7l/AZDU1
	9MU5EZLffyD3qEfllBkpaB3Vsf/CqMF07haeiC5EgeigNErXBz/S2P6t
X-Gm-Gg: AfdE7cko6ywfRTRuYTimxeN77BjSflcynB+jh2FjABscdap0j1nv5l2JrJdG3Wr54vp
	niXzeSJzbuaIBEPD6rUi4+oqwevU/GGtjhkHOJ3nGQZxLLc+2HfukqecIwp7u7pMX8slk1R1374
	tAj/btN8pZVfwWXuM0sy8/42hbP/MdIcJ/ZQRy3TGo8g1txjePS9Q12Z9pbS85OObxHQ9bGQGh+
	+MprcfR/guyv+o+Ua65y58x9N+kuRqLI6tRWAzlmUuDgFCOZ7X1WxSgsbNdt6Dg2Swb4ZX69RjA
	SDdDrcJWNXLkhxqlB7b2MMldhZLJYSIQ8fUVwaM3hInYbe29s2evAAtY9k19zSpJPGp8jERhqkm
	bxhufi+CQHffPZKJn25Tb06jz8cwMa0xy7/VGq3OhQyyeB2jhfF9xFrZoIBfg7DDlGCcn7K77wC
	CfU0pn
X-Received: by 2002:a05:6000:607:b0:47d:ca2:6217 with SMTP id ffacd0b85a97d-47f2dcb598fmr2283679f8f.22.1783767766596;
        Sat, 11 Jul 2026 04:02:46 -0700 (PDT)
Received: from avermoal ([185.13.178.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d6da9sm67405128f8f.12.2026.07.11.04.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 04:02:46 -0700 (PDT)
From: Mikhail Lukianchikov <avermoal@gmail.com>
To: Rengarajan.S@microchip.com
Cc: avermoal@gmail.com,
	andrew+netdev@lunn.ch,
	conor+dt@kernel.org,
	davem@davemloft.net,
	devicetree@vger.kernel.org,
	edumazet@google.com,
	krzk+dt@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	robh@kernel.org
Subject: [PATCH v3] dt-bindings: net: microchip,lan78xx: convert to DT schema
Date: Sat, 11 Jul 2026 16:55:38 +0600
Message-ID: <20260711105537.11065-2-avermoal@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,kernel.org,davemloft.net,vger.kernel.org,google.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306835-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:Rengarajan.S@microchip.com,m:avermoal@gmail.com,m:andrew+netdev@lunn.ch,m:conor+dt@kernel.org,m:davem@davemloft.net,m:devicetree@vger.kernel.org,m:edumazet@google.com,m:krzk+dt@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:andrew@lunn.ch,m:conor@kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[avermoal@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avermoal@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,devicetree.org:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,microchip.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 84347741577

Convert the Microchip LAN78xx family (LAN7800, LAN7801, LAN7850) binding
documentation from plain text to DT schema.

The conversion adds proper validation for the 'microchip,led-modes'
property inside the MDIO node.

Signed-off-by: Mikhail Lukianchikov <avermoal@gmail.com>
---
Changes in v3:
 - Added $ref to ethernet-phy.yaml for PHY node to use standard PHY properties.
 - Dropped redundant PHY description and manual 'reg' property definition.
 - Dropped root node and fake compatibles in the example.

Link to v2: https://lore.kernel.org/netdev/20260709181724.24682-2-avermoal@gmail.com

 .../bindings/net/microchip,lan7800.yaml       | 96 +++++++++++++++++++
 .../bindings/net/microchip,lan78xx.txt        | 53 ----------
 MAINTAINERS                                   |  3 +-
 3 files changed, 97 insertions(+), 55 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/microchip,lan7800.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/microchip,lan78xx.txt

diff --git a/Documentation/devicetree/bindings/net/microchip,lan7800.yaml b/Documentation/devicetree/bindings/net/microchip,lan7800.yaml
new file mode 100644
index 000000000000..730999d11e8a
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/microchip,lan7800.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/microchip,lan7800.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip LAN7800/LAN7801/LAN7850 Gigabit Ethernet controller
+
+maintainers:
+  - Rengarajan Sundararajan <Rengarajan.S@microchip.com>
+
+description:
+  The LAN7800/LAN7801/LAN7850 devices are usually configured by
+  programming their OTP or with an external EEPROM, but some
+  platforms (e.g. Raspberry Pi 3 B+) have neither. The Device Tree
+  properties, if present, override the OTP and EEPROM.
+
+allOf:
+  - $ref: /schemas/usb/usb-device.yaml#
+  - $ref: /schemas/net/ethernet-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - usb424,7800
+      - usb424,7801
+      - usb424,7850
+
+  reg:
+    maxItems: 1
+    description: USB port number
+
+  local-mac-address:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    minItems: 6
+    maxItems: 6
+    description:
+      MAC address to use if not stored in OTP or EEPROM. If present,
+      overrides OTP/EEPROM.
+
+  mdio:
+    $ref: /schemas/net/mdio.yaml#
+    unevaluatedProperties: false
+
+    patternProperties:
+      "^ethernet-phy(@[0-9a-f]+)?$":
+        $ref: /schemas/net/ethernet-phy.yaml#
+        unevaluatedProperties: false
+        type: object
+
+        properties:
+          microchip,led-modes:
+            $ref: /schemas/types.yaml#/definitions/uint32-array
+            minItems: 1
+            maxItems: 4
+            description:
+              Array of LED mode values for each of up to 4 LEDs.
+              Omitted LEDs are turned off. Allowed values are defined
+              in include/dt-bindings/net/microchip-lan78xx.h.
+
+        required:
+          - reg
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/net/microchip-lan78xx.h>
+
+    usb {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet@1 {
+            compatible = "usb424,7800";
+            reg = <1>;
+            local-mac-address = [00 11 22 33 44 55];
+
+            mdio {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                ethernet-phy@1 {
+                    reg = <1>;
+                    microchip,led-modes = <
+                        LAN78XX_LINK_1000_ACTIVITY
+                        LAN78XX_LINK_10_100_ACTIVITY
+                    >;
+                };
+            };
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/net/microchip,lan78xx.txt b/Documentation/devicetree/bindings/net/microchip,lan78xx.txt
deleted file mode 100644
index 11a679530ae6..000000000000
--- a/Documentation/devicetree/bindings/net/microchip,lan78xx.txt
+++ /dev/null
@@ -1,53 +0,0 @@
-Microchip LAN78xx Gigabit Ethernet controller
-
-The LAN78XX devices are usually configured by programming their OTP or with
-an external EEPROM, but some platforms (e.g. Raspberry Pi 3 B+) have neither.
-The Device Tree properties, if present, override the OTP and EEPROM.
-
-Required properties:
-- compatible: Should be one of "usb424,7800", "usb424,7801" or "usb424,7850".
-
-The MAC address will be determined using the optional properties
-defined in ethernet.txt.
-
-Optional properties of the embedded PHY:
-- microchip,led-modes: a 0..4 element vector, with each element configuring
-  the operating mode of an LED. Omitted LEDs are turned off. Allowed values
-  are defined in "include/dt-bindings/net/microchip-lan78xx.h".
-
-Example:
-
-/* Based on the configuration for a Raspberry Pi 3 B+ */
-&usb {
-	usb-port@1 {
-		compatible = "usb424,2514";
-		reg = <1>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		usb-port@1 {
-			compatible = "usb424,2514";
-			reg = <1>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			ethernet: ethernet@1 {
-				compatible = "usb424,7800";
-				reg = <1>;
-				local-mac-address = [ 00 11 22 33 44 55 ];
-
-				mdio {
-					#address-cells = <0x1>;
-					#size-cells = <0x0>;
-					eth_phy: ethernet-phy@1 {
-						reg = <1>;
-						microchip,led-modes = <
-							LAN78XX_LINK_1000_ACTIVITY
-							LAN78XX_LINK_10_100_ACTIVITY
-						>;
-					};
-				};
-			};
-		};
-	};
-};
diff --git a/MAINTAINERS b/MAINTAINERS
index f37a81950e25..157a677a284f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27928,10 +27928,9 @@ F:	drivers/usb/isp1760/*
 USB LAN78XX ETHERNET DRIVER
 M:	Thangaraj Samynathan <Thangaraj.S@microchip.com>
 M:	Rengarajan Sundararajan <Rengarajan.S@microchip.com>
-M:	UNGLinuxDriver@microchip.com
 L:	netdev@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/net/microchip,lan78xx.txt
+F:	Documentation/devicetree/bindings/net/microchip,lan7800.yaml
 F:	drivers/net/usb/lan78xx.*
 F:	include/dt-bindings/net/microchip-lan78xx.h
 
-- 
2.52.0


