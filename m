Return-Path: <netdev+bounces-306342-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fEqBBHbmT2rEpwIAu9opvQ
	(envelope-from <netdev+bounces-306342-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 20:20:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FDB73432D
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 20:20:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=cZ4z2Go0;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306342-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306342-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 409B330262D7
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 18:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C76A4DBD89;
	Thu,  9 Jul 2026 18:20:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38EF4DBD6B
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 18:20:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783621225; cv=none; b=Y627LsKjt/guCu2JQD0Ew/REUx7JzzlgBJIgzZDIEAKJdKCDBoIFDcTTUdup9UHs7ZX/Qe5SuPxZ8Jk1JESij3Q3iTkJPtzcrgzqO2DikcA0TU6v7FjsPq88NJ1D1eL4Npq7KtBvLrKaMPX0ihORI7GuOZ4xiSfEDUMM9GcHVYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783621225; c=relaxed/simple;
	bh=XYMLLDJSM4xjJT8F7RlgLCND0cDcPiqKQh/YbTNVVzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ad4Rjxe61JxMgTi3Xfnl63QvRVqwZZ62lvE7lLM4GzxaIWobr9SkBQPu1xhlG4PyDZ14hoc9sYJdxDt73uwXJEx2V99wbSq2VRhcqLo+tUHSQPQUxtDMzTHt91niGXQSPnGNcqHsucEO+4xBivpymaHzeqvujl3H7PD0dGxXeEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZ4z2Go0; arc=none smtp.client-ip=209.85.221.42
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47122683cf3so126035f8f.0
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 11:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783621222; x=1784226022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EXJuaOsCL/ERnu3SR2SjgqemJAXLgbxcgVcSbRu+n3U=;
        b=cZ4z2Go0tQusPACRos8UyUS/IRp+nsmII1BHigx/1Pj1CqgoDuroFZMh6yUxupsXX0
         TnD1cTD6cYddsQoPhNmD8Ah3Cl15ogAPrKOiLzLtOz042r78sUgFVMhoalfBuglZuKej
         W6vczmRYe2PgkgSR5hSh/71/1GMYthy65V/aKGG6xkXRKVTxhxj9VULUiUyUoDOguKcH
         3tQbSnR/TuBUnhUfEmwMHvh80feKy8m9l52xiG4ZifDRSPfh7Y85z7NAcEzvQUIBlIZr
         e148ABMFpoY5QFdGL59OcohyN4cuIj2tHuB5+KI+MzDEf7FbQDNKlpGfyCYxKDN0Rzo+
         r+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783621222; x=1784226022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EXJuaOsCL/ERnu3SR2SjgqemJAXLgbxcgVcSbRu+n3U=;
        b=DAN2LVwv8eCvhzXdnkTbR594VDorGexYHqM1k/PrfsPk4BhwUTvqN5Zhvod6kmc6Ee
         /Rlb0znQb3f0CgIqI0rT2bFl8Sxi5nVg9VpnvtH/thGf4uthD+4wqt/H0gKIBR5ipDRE
         VYp3Mm2UigW+oSKMAyIq6PMKOaq6rV4ONleyXIqByUXKeuYTfmVip/+NJSZ7xzeI5xF9
         SnWHoSTqp5BbPffz9WqWPN1nL7Gi+At87c7AOo8XHNXFFIsSPCTyzWgKhdwgMg/pnNCv
         5q5ctZy4GI6p8P9B09idgWDJZuy6F4fgxDOGn5DAGmJM8jCiRd1ttOk2IwIRfW3Znnlq
         n+YA==
X-Forwarded-Encrypted: i=1; AHgh+RogN2YOpU7uQYSCBiq8FhwRssE1UfN0ONBVA33iHF5xLjuhEjLaTP8SWivq5LzPR+OGieXYPlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoUSAwG717MAkMT3EK766ORjeLVMPXjYJ/7zbxe6gDvRGTqxYl
	9AGAuXCWAjFv9V+r4hqiiCN+Ve2jvA87IUQsFXQvG22U0kECZA2Po6se
X-Gm-Gg: AfdE7cm6SD3TbOzeGrNCGNGAkkz9jEjYjgNFxFUqEhDgxfpqyFY26T7G/pYFd4gP6C6
	/VP8uD6D3JUFcfyp5Odj1BBoMBrIwMz1irpbu7dE+xSIWCEgoapPJKLRRmF64DkhjUA4X07k0pJ
	Zeh4O3k3ONwmiEFl/Qf8IqvhVPBaCzqj7BMoYK9moey+JEBxhuQxV9uMdS8GF05JHFqglwuucOr
	8tMIq0PxxV7UZMZXwSZEUsUSpFdqHWxY3ADtopXlFV3gZpx5EI7/XwUficu56KyM4EaQIy8Z3w9
	ejfnHzM6mAvPfRZffMeBDrhZi6fFRneEUo8TsELa1oOQWBHfCz+7Rkxq2NihkSVGuL8g7iMaUuV
	FfmifCpRRsujGaErxgOOfxkd8/q9HFzNw+RZGLKhN5JsPxHnRgzLd6xnkNNraeboLuYKuhSjFCg
	jo82U=
X-Received: by 2002:a05:6000:4802:b0:47d:eabc:3e87 with SMTP id ffacd0b85a97d-47df071e561mr9489283f8f.6.1783621221859;
        Thu, 09 Jul 2026 11:20:21 -0700 (PDT)
Received: from avermoal ([185.13.179.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960b06sm52612834f8f.28.2026.07.09.11.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:20:21 -0700 (PDT)
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
Subject: [PATCH v2] dt-bindings: net: microchip,lan78xx: convert to DT schema
Date: Fri, 10 Jul 2026 00:17:25 +0600
Message-ID: <20260709181724.24682-2-avermoal@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,kernel.org,davemloft.net,vger.kernel.org,google.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306342-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:Rengarajan.S@microchip.com,m:avermoal@gmail.com,m:andrew+netdev@lunn.ch,m:conor+dt@kernel.org,m:davem@davemloft.net,m:devicetree@vger.kernel.org,m:edumazet@google.com,m:krzk+dt@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:andrew@lunn.ch,m:conor@kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[avermoal@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,microchip.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 58FDB73432D

Convert the Microchip LAN78xx family (LAN7800, LAN7801, LAN7850) binding
documentation from plain text to DT schema.

The conversion adds proper validation for the 'microchip,led-modes'
property inside the MDIO node and updates the MAINTAINERS entry.

Signed-off-by: Mikhail Lukianchikov <avermoal@gmail.com>
---
Changes in v2:
 - Rename file to microchip,lan7800.yaml.
 - Keeps only one maintainer.
 - Code style fixed.
 - Example fixed, remove usb-port@1 node.
 - Move patternProperties for PHY inside mdio node to fix validation. (suggested by sashiko-bot)

Link to v1: https://lore.kernel.org/netdev/20260707165840.107409-1-avermoal@gmail.com

 .../bindings/net/microchip,lan7800.yaml       | 105 ++++++++++++++++++
 .../bindings/net/microchip,lan78xx.txt        |  53 ---------
 MAINTAINERS                                   |   3 +-
 3 files changed, 106 insertions(+), 55 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/microchip,lan7800.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/microchip,lan78xx.txt

diff --git a/Documentation/devicetree/bindings/net/microchip,lan7800.yaml b/Documentation/devicetree/bindings/net/microchip,lan7800.yaml
new file mode 100644
index 000000000000..289980c23181
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/microchip,lan7800.yaml
@@ -0,0 +1,105 @@
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
+        type: object
+        description: |
+          PHY node for the embedded or external PHY. The PHY address is
+          given by the 'reg' property.
+
+        properties:
+          reg:
+            maxItems: 1
+            description: PHY address.
+
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
+        additionalProperties: false
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
+    / {
+        usb {
+            compatible = "usb-host";
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            ethernet@1 {
+                compatible = "usb424,7800";
+                reg = <1>;
+                local-mac-address = [00 11 22 33 44 55];
+
+                mdio {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+                    ethernet-phy@1 {
+                        reg = <1>;
+                        microchip,led-modes = <
+                            LAN78XX_LINK_1000_ACTIVITY
+                            LAN78XX_LINK_10_100_ACTIVITY
+                        >;
+                    };
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


