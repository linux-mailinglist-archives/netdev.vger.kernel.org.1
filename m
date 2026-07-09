Return-Path: <netdev+bounces-306354-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yeojIk/6T2qzrQIAu9opvQ
	(envelope-from <netdev+bounces-306354-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 21:45:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA0B73526E
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 21:45:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Xt9bQ8VP;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306354-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306354-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE36C3045A8D
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 19:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD263C3BFA;
	Thu,  9 Jul 2026 19:41:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492DC3BD657
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 19:41:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783626111; cv=none; b=t2BC/tjEsX/gVCMpmKx5MdaRrmWiaGA0TJ8GebE/E4nFVu4CeoVf7G7WKZLpwRZFr2TR6drH6OH2+LncsOFe8cxT5w9g+V4aWcNjYnzvwxrjDiV6re85lhY47XjFX+kUBZ7i53QkG6/pfWp+w/k5Ym9z4STUku9tpEBg+0BFeWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783626111; c=relaxed/simple;
	bh=v8iQjLjFwyjpWmkI2tw0aBbLptc420t2mngJsBIklC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PwEDZMFO7s+g0mWjQJIwPggkjpfpbGbPq0VzH0Iwnb7ObKT1ZgvB43evagvZXhUa94HkpLMCz1TyuVdPwyRb/uY0Ij6/ugGQqrU9qcd3rE5H+EiJ48PKd5JzCVgdExCH4IXxR3LetlIeDBArqS7frjlJ8qmOuygmosSA2Fb4UsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xt9bQ8VP; arc=none smtp.client-ip=209.85.128.48
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493b77b150aso1371905e9.2
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 12:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783626108; x=1784230908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9bcu/YNEwEm0JDXBC4cIzwtBWsDRz5yLZFBz69Nysfo=;
        b=Xt9bQ8VPYeJQhU42cyBvbPZFMQBSW9MWHkOaTeeRJyNlH/QlDGy3+7t2loo9zz9u3P
         BZNp4YLOwgBaUiVkviFCifViBuKPpqPu0d9hvjoepYEAQjtqVmr/UWDrA5fIDWVw0Caq
         fuEdMD2DzluJxJwtEk4hI0DlPtn2BEziiiiO6/0sksYxp7Xd0Fg9u2/r3JdvxJnWCFCt
         INOlva5ONAka4CPAjhoGR3+kt7qofV2A5csKwa/tDUXppVjp9vjRz4YS4tXRTZYAHCfP
         p1PIm/jWehJdcjbS9LPgDkbA+sSotyGrf3Gd/x2c7K6/DNwlyhkWKoexkvNmzANvqvXb
         kR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783626108; x=1784230908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9bcu/YNEwEm0JDXBC4cIzwtBWsDRz5yLZFBz69Nysfo=;
        b=SkLfdNQhtcGYkWdaneGoefIZugEouOdiJNgO1OKXFqshUbvP52FvgOzS7mldHIIuy0
         Eqfd/6+xOtcYEw2Ad3J5Uc/57g/VpGHXoO2QIslu0KEvtJmAFJgOw54aAvUlJrouBaKz
         mN/zMLM9usadGyJ3ZG5rgbghdB5Vhac2Rhjx3txuMyff5t/Rv2Pz/5Y4Kqy1Vi09T8az
         qZ0oI8fMYHIzQNJLYAMOmHC6csatDMeTMYRfscgsh3ubUxxafq29rsKpJQlHqPkbsPbT
         DVNJ7qBc4wtHP5yFHD3w6FetJQAD4sVlQhy4Keu8mV3e0HWZSuITlDp4+EI7Bodt92yr
         /OBQ==
X-Gm-Message-State: AOJu0YyYGlvfdKkjh3353RviMjRMTjOh21FTgzb9emSdaegQIYPknLUB
	FOWrLmievs/NDkwxP8bRrIxZTAiXPiHSp9RW0ilozPG6nIPt0nEAhlmz
X-Gm-Gg: AfdE7ckPZiNp5BvLkqjaewnDHsD7PzcWjU9Aq7sEm1DKtBz1XoNtfqmomKnAammUpp1
	ebANvS+lpOMrta8SaxGTYnreLIVNZgkoAICnmZrIyaNmX/y9+xvMtLrOBwh4UCs4yTf/YiB7CbT
	MB447rnh2zkd4223f10Y5gc3Ss5XexHIAy/TN9oOTx1SzlIh/3AkuL9HoRjSFzAb9rROrbsao/8
	7vgWtKyuMaBBqIbgtv6JmlUYDF7+HRGim/fkmnC+RGwedny0frd0e9uQvTJtK/JyItH3ZTtYTYZ
	sSDcd3R/RShROR1LO4mVduyhD4nz3giM/kMsG05jQI/tBaTlD7P8u7zpLpJ0ibUdQwXlvRjAACv
	XlW8wK7jpon8sBDtluPolVj+ZN5NCTj7jZliSM8drQD8U6G7dxhoU88Q47Ry5HwRMDeWi/zW16d
	+Ngliy54JLUPVFTkA=
X-Received: by 2002:a05:600c:34c3:b0:493:bb29:af40 with SMTP id 5b1f17b1804b1-493e689b37amr96818835e9.14.1783626107507;
        Thu, 09 Jul 2026 12:41:47 -0700 (PDT)
Received: from builder ([2001:9e8:f110:7f16:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6e8844sm93126605e9.10.2026.07.09.12.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 12:41:47 -0700 (PDT)
From: Jonas Jelonek <jelonek.jonas@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Golle <daniel@makrotopia.org>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [PATCH net-next v6 1/4] dt-bindings: net: pse-pd: add bindings for Realtek PSE MCU
Date: Thu,  9 Jul 2026 19:41:20 +0000
Message-ID: <20260709194125.2784507-2-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260709194125.2784507-1-jelonek.jonas@gmail.com>
References: <20260709194125.2784507-1-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-306354-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:bjorn@mork.no,m:jelonek.jonas@gmail.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:jelonekjonas@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,makrotopia.org,mork.no,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CDA0B73526E

Add a binding for the microcontroller (MCU) that fronts the PSE silicon
on a range of managed switches. The host talks only to the MCU, over
I2C/SMBus or UART, using a fixed message-based protocol; the PSE chips
behind it never appear on the bus.

The device is the MCU together with its Realtek firmware: the firmware
and its host protocol are what the binding describes, not the
general-purpose microcontroller they run on. The PSE silicon behind the
MCU (Realtek or Broadcom) is reported by the MCU and detected at runtime,
so it is not described here - hence the 'realtek' vendor prefix.

Two protocol generations exist, both Realtek's, selected by the
compatible: gen1 on older boards (fronting Broadcom PSE silicon) and gen2,
the altered protocol used with Realtek's own PSE silicon. On an I2C
attachment the framing the MCU firmware expects is part of the compatible
as well - '-smbus' or raw '-i2c'; a UART attachment carries no framing
suffix, as the transport is given by the parent serial node.

Each board additionally carries a device-specific compatible that falls
back to one of the protocol compatibles above. Drivers bind on the
protocol compatible; the device-specific string identifies the board and
reserves a place for a future per-board quirk without having to retrofit
device trees already in the field.

Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
---
 .../bindings/net/pse-pd/realtek,pse-mcu.yaml  | 176 ++++++++++++++++++
 1 file changed, 176 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu.yaml

diff --git a/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu.yaml b/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu.yaml
new file mode 100644
index 000000000000..733306193db5
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu.yaml
@@ -0,0 +1,176 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/pse-pd/realtek,pse-mcu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek PSE MCU
+
+maintainers:
+  - Jonas Jelonek <jelonek.jonas@gmail.com>
+
+description: |
+  A microcontroller (MCU) that manages the PSE (Power Sourcing Equipment)
+  hardware on a range of managed PoE switches. The host CPU talks only to
+  this MCU - over I2C/SMBus or UART - using a small message-based protocol;
+  the PSE silicon it drives sits behind the MCU and is never accessed
+  directly. For example, on the Zyxel GS1900-10HP the SoC reaches the MCU
+  over UART, and the MCU manages the on-board PSE chip.
+
+  This binding describes the MCU together with its Realtek firmware: the
+  firmware and its host protocol, which are stable across boards. The
+  microcontroller silicon is a general-purpose part that varies, and the
+  PSE silicon behind the MCU (Realtek RTL823x/RTL8239* or Broadcom
+  BCM59xxx) is reported by the MCU and detected at runtime - neither is
+  named here.
+
+  Two protocol generations exist, both Realtek's:
+    gen1  older boards, where the MCU fronts Broadcom PSE silicon
+    gen2  the altered protocol used with Realtek's own PSE silicon
+
+  On an I2C attachment the framing the MCU firmware expects is part of the
+  compatible: '-smbus' (reads carry a leading command byte and a repeated
+  start) or '-i2c' (bare block writes and reads). A UART attachment carries
+  no framing suffix; the transport is given by the parent 'serial' node.
+
+  Each board additionally carries a device-specific compatible that falls
+  back to one of the protocol compatibles above. Drivers bind on the
+  protocol compatible; the device-specific string identifies the board and
+  reserves a place for a future per-board quirk without having to retrofit
+  device trees already in the field.
+
+properties:
+  compatible:
+    oneOf:
+      # UART
+      - items:
+          - enum:
+              - zyxel,gs1900-10hp-a1-pse
+          - const: realtek,pse-mcu-gen1
+
+      # I2C, SMBus framing
+      - items:
+          - enum:
+              - zyxel,gs1920-24hp-v2-pse
+          - const: realtek,pse-mcu-gen1-smbus
+
+      # UART
+      - items:
+          - enum:
+              - zyxel,gs1900-10hp-b1-pse
+              - zyxel,xmg1915-10ep-pse
+          - const: realtek,pse-mcu-gen2
+
+      # I2C, SMBus framing
+      - items:
+          - enum:
+              - zyxel,xs1930-12hp-pse
+          - const: realtek,pse-mcu-gen2-smbus
+
+      # I2C, raw framing
+      - items:
+          - enum:
+              - linksys,lgs328mpc-v2-pse
+          - const: realtek,pse-mcu-gen2-i2c
+
+  reg:
+    maxItems: 1
+
+  power-supply:
+    description: Regulator supplying the PoE power rail.
+
+  enable-gpios:
+    maxItems: 1
+
+required:
+  - compatible
+
+allOf:
+  - $ref: pse-controller.yaml#
+  - $ref: /schemas/serial/serial-peripheral-props.yaml#
+  # A '-smbus'/'-i2c' compatible is an I2C attachment: it has 'reg' and
+  # cannot carry serial bus properties. A bare gen compatible is a UART
+  # attachment: no 'reg', the transport comes from the parent serial node.
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - realtek,pse-mcu-gen1-smbus
+              - realtek,pse-mcu-gen2-smbus
+              - realtek,pse-mcu-gen2-i2c
+    then:
+      required:
+        - reg
+      properties:
+        current-speed: false
+        max-speed: false
+    else:
+      properties:
+        reg: false
+
+unevaluatedProperties: false
+
+examples:
+  # SMBus-framed I2C attachment
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-pse@20 {
+            compatible = "zyxel,xs1930-12hp-pse", "realtek,pse-mcu-gen2-smbus";
+            reg = <0x20>;
+
+            pse-pis {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                pse-pi@0 {
+                    reg = <0>;
+                    #pse-cells = <0>;
+                };
+            };
+        };
+    };
+
+  # Raw-I2C-framed attachment
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-pse@20 {
+            compatible = "linksys,lgs328mpc-v2-pse", "realtek,pse-mcu-gen2-i2c";
+            reg = <0x20>;
+
+            pse-pis {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                pse-pi@0 {
+                    reg = <0>;
+                    #pse-cells = <0>;
+                };
+            };
+        };
+    };
+
+  # UART attachment
+  - |
+    serial {
+        ethernet-pse {
+            compatible = "zyxel,gs1900-10hp-a1-pse", "realtek,pse-mcu-gen1";
+            current-speed = <19200>;
+
+            pse-pis {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                pse-pi@0 {
+                    reg = <0>;
+                    #pse-cells = <0>;
+                };
+            };
+        };
+    };
-- 
2.51.0


