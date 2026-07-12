Return-Path: <netdev+bounces-306940-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jTgBJ9V8U2pNbQMAu9opvQ
	(envelope-from <netdev+bounces-306940-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 13:39:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B49744859
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 13:39:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=UHFgC2SH;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306940-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306940-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8952430082A2
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 11:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3C83A5E70;
	Sun, 12 Jul 2026 11:38:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77FB370D5A
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 11:38:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783856337; cv=none; b=Z0az7a+xfgHgIY0tyWD7d1o7/Hj4srLs2aFwgSPkx+Gy+n1YWMhtTeHEMkrCA8uDtjHnA3buPreM9uO0QCiHQ5TIwDWhLLdCCCEfpq928D9X5fMzwzuobfzbvb2uittQKxZyQU4trPRDlkapmzAvlngf9uKK/b1I/Xs2MmpiaMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783856337; c=relaxed/simple;
	bh=p4ux/JOtLVj+8Spq10nglexIKmCAq+as35tOKbOSNLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rFIrlGhrZ56kpN5/3zWQQUkoYQCtl30Qg3EkeHfztVJsoiUf4nA5JjSD0V32+VtO2PMYH54GFOOd2bf/h4+cfqCNuFRicJYmiqEhhJKvV2IKQYmi8qGYLut2aIX2VGSykJCGtm/12vnm+vpaxpSaNsdt/vAKu9vWmfgJkxsAPdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHFgC2SH; arc=none smtp.client-ip=209.85.128.49
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493e497643fso13856105e9.0
        for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 04:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783856334; x=1784461134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WWPMJKQKJ9jSlDsOvT4j32pSDv2XKOE/cyJYUajvG3Y=;
        b=UHFgC2SH3kUYx8zDS+G7d8whjEWgLiQbrOeYLd8Et/SD7R78m2XbmpRtuW20xMXCuX
         E4fDFE+O+4PCzStWrjADHI95/+J8YzwSEUPpJMVognLd0Rj7UbsS5RJnCqw0giaPELsf
         alU8j7Y4WQg/dnCL/IQkexQOP7lb7vZoWr92AfI7xwRVOyQnI6OFKR6Cyd4SAVePHGWk
         ithTycrvkOqG7OuqJrzm3iZMJfpuWTseynuraC3xKzCohfRE/Ia6T7TvfH1bfkeG8G6D
         xvbAsuZCtzo186aRYpGWw18H4xVCWWKyByXrr5MNRmWWsFzPCAbypL+0W9tujcb3dQH2
         pzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783856334; x=1784461134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WWPMJKQKJ9jSlDsOvT4j32pSDv2XKOE/cyJYUajvG3Y=;
        b=a05Ne6l9VbtpPc17xw4S6TnAyb4enIB6t/+1RptSMSJIBLXOaCDjJ4FcTCtQAGLZZZ
         qPeXAGnWUngSY6GDwUh0qkIOL1SZv4zABXZ/cHxzF61Bzt5kTjQvYOpfaYGh2ArvbhiI
         ZLO9izbSDwjmHPTa+hl1/mtHYFfY5ZJISwNwWKY9ZhJLhLnj1QTOSRzS/N13Mh6Ef6BF
         Y4q2trZDAjLWE6tTk2f/HU9yFqL8iwrSQY9m7qyVI2C8ibg1S/8OCCmBC+eLX8ZCFGiq
         btrB8fjhZ/BUzp9SrakTuBjFoKt4jffeGwX9en9t8Ot/1ZzvGpdg3GHpoI4jFYr0Zqhw
         004g==
X-Forwarded-Encrypted: i=1; AHgh+Rq7PLSH6S4JLb09rVPONjYhdEb4ytJ5QlJwobD/FZBGHiW5Uzh/GbJlcsX7OH/AZoBoen5TuYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQCEDiz7La8BYJRBzi8oLl0F0aWHUaiG5c3oPTG1f1xGWzcu6S
	OwsN2wjIbE5jUM8ReGGYTp1yrMs3oKk26WLoAr7MV8Gw/tbC9kTig5oj
X-Gm-Gg: AfdE7cmMvZ+aql2Bgt8l3NMxc+F/94HpkU+eOntAkvVz9Cks1TeOi84+50nfajCWJ2W
	Kgi+jraJYMc0e0Y8fVHwzrBtgkGVcjXaYZAWez4EsJyO1nDxa5UfT0g4jT9QmwxPsyxqP5FJLEm
	X3DUEAG4tRCLJsHXikT6s2iWFWG8s95yqubbwU0sXmyvaSCm00kNXy+o9ADbTBEpv0t0ZP7B77Q
	uctwZPjXHRUXEvDbNY3LLsijoRnOsa/5rhmxmWstMBOv7A4vnAqb0loPcNhOCOLRPL4lJzTrmEK
	iVi0GCd1TS8gz+ElGSTg242G7NI9X6vbT/vrO5qwabsPQPyNUFAOWn5DDApQ9BgrQ48c6Z+emQo
	8gAysM9EaBb+s8WLp9BVCPB+sx3QnwhBye8Rq9AymoaF5ez2BaSelHT5B+yTr7z5XFFOQNCPqDk
	gBcRO47A==
X-Received: by 2002:a7b:c019:0:b0:493:aab3:c09c with SMTP id 5b1f17b1804b1-493f8828e20mr33926235e9.28.1783856333825;
        Sun, 12 Jul 2026 04:38:53 -0700 (PDT)
Received: from avermoal ([185.13.178.252])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb74b3edsm329219065e9.15.2026.07.12.04.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 04:38:53 -0700 (PDT)
From: Mikhail Lukianchikov <avermoal@gmail.com>
To: Thangaraj.S@microchip.com,
	Rengarajan.S@microchip.com
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
Subject: [PATCH v4] dt-bindings: net: microchip,lan78xx: convert to DT schema
Date: Sun, 12 Jul 2026 17:38:21 +0600
Message-ID: <20260712113821.12543-1-avermoal@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,kernel.org,davemloft.net,vger.kernel.org,google.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-306940-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Thangaraj.S@microchip.com,m:Rengarajan.S@microchip.com,m:avermoal@gmail.com,m:andrew+netdev@lunn.ch,m:conor+dt@kernel.org,m:davem@davemloft.net,m:devicetree@vger.kernel.org,m:edumazet@google.com,m:krzk+dt@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:andrew@lunn.ch,m:conor@kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[avermoal@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avermoal@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E7B49744859

Convert the Microchip LAN78xx family (LAN7800, LAN7801, LAN7850) binding
documentation from plain text to DT schema.

Restoring a mistakenly deleted email in MAINTAINERS file and fixing
microchip,lan7800.yaml.

Signed-off-by: Mikhail Lukianchikov <avermoal@gmail.com>
---
Changes in v3:
  - Restoring an erroneously deleted email in a MAINTAINERS file.
  - The local-mac-address was deleted.
  - The missing email was added to the maintainers section.

Link to v3: https://lore.kernel.org/netdev/20260711105537.11065-2-avermoal@gmail.com

 .../bindings/net/microchip,lan7800.yaml       | 89 +++++++++++++++++++
 .../bindings/net/microchip,lan78xx.txt        | 53 -----------
 MAINTAINERS                                   |  2 +-
 3 files changed, 90 insertions(+), 54 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/microchip,lan7800.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/microchip,lan78xx.txt

diff --git a/Documentation/devicetree/bindings/net/microchip,lan7800.yaml b/Documentation/devicetree/bindings/net/microchip,lan7800.yaml
new file mode 100644
index 000000000000..cb3927215dfc
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/microchip,lan7800.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/microchip,lan7800.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip LAN7800/LAN7801/LAN7850 Gigabit Ethernet controller
+
+maintainers:
+  - Thangaraj Samynathan <Thangaraj.S@microchip.com>
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
index f37a81950e25..5de154167b33 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27931,7 +27931,7 @@ M:	Rengarajan Sundararajan <Rengarajan.S@microchip.com>
 M:	UNGLinuxDriver@microchip.com
 L:	netdev@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/net/microchip,lan78xx.txt
+F:	Documentation/devicetree/bindings/net/microchip,lan7800.yaml
 F:	drivers/net/usb/lan78xx.*
 F:	include/dt-bindings/net/microchip-lan78xx.h
 
-- 
2.52.0


