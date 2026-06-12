Return-Path: <netdev+bounces-298672-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8X0BFIgLLGobKQQAu9opvQ
	(envelope-from <netdev+bounces-298672-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 15:37:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7E3679E42
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 15:37:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="ZndX8/jp";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298672-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298672-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CF4423019041
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 13:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677B53EEAF4;
	Fri, 12 Jun 2026 13:30:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18F53E1D19
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 13:30:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781271008; cv=none; b=TQ06Gkiq/aysDoHu/DSWAAbOunXxHyQIJdj6TtM6Gwb5seULKeE3Vi8CwUG96Ro3pduMYQWoKc1ov18wr/TrV05UbMXjGaLAf5uxHe+xIt7FG/n4YWev9gXjBrJN/fjA+bUlY7QAyIysjEiO+8nd/fxmY2MPAbZZAZ33+99ua+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781271008; c=relaxed/simple;
	bh=Adlvqfy4/RiVofJyXdnjYaiEBf1qc1usUCMPJaHxVWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ay7tgivXo496dak+0W7u6dwB8n8LLKVv4NsiYMrq9PPgswVsTYjJbV5V9oKtQhglLrBORkKqaF7/VtMiDtLoPG8rgmX+cYWrJF/ClRGhImepM+2/PtSjMODdg6uASR+p+me4XHsGB3N99h2EGkI8AS50An/e9dW0VnsHiWbIxcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZndX8/jp; arc=none smtp.client-ip=209.85.128.44
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4921e4dd62dso819025e9.0
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 06:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781271004; x=1781875804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F03FjO4LjSiNWn1/BhvBC+hqEK9VBACUAnKsqMGfyeQ=;
        b=ZndX8/jpH4Uk5FVriV0hgXR5pi+FBCIS4DLp9bXSsHesKU/7jxG7z5aL0sr+rjQquP
         rbbsDu1tRYSmQWbikIcnyiVT0MTj1Tmq0OS7cB5176wo1TCGt5WI4/DxsJlr9UagVf1a
         UN2nk5ZG2++MunPqqb/dwqVPgLUw/cNEU+nMPEgvCpO7zTkI2EIsEZh6kh21silyvcuR
         8moQHixrQkXT1m7l6rq54gjkMVnJ5JC3m4Bddd9yfmm0Y1Q0pyeVr3oOuvzICeytb5Ns
         8UtFuVv6VIfRhD5gysnWkxzixSKDOby8fSMR4+OCzekJGiGMuqUcAXSGUp+HmskPClpS
         YlvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781271004; x=1781875804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F03FjO4LjSiNWn1/BhvBC+hqEK9VBACUAnKsqMGfyeQ=;
        b=k4nqVXHFVL2mNBECDhxUhw8hMppZVG9oONnrMrYopFzb8SFBJv9TbZXkI5KByL4pKH
         fbeqou3mTFo5OLa+HLkh9F9f7rTOW6U/MpkeOVH3gyRqfQte+7oNZIxxGwXxES+ZYcno
         FEUvyqnpyvyARYCh7geGTHqpX5FJt/UmgIie7uZVQu1dW/cSzmqo8C1FZ9zAQAVhPnHE
         c3W2Vd/7tbKbcju+oviFnwXydiw5mEH9iXZDtnzNejv735/8VAoFBWPbYgEIIaf62pnn
         lDLxnS0FeIh/uXFQNQPGuKZtZxkPs2V068BgUxAIsz9Dq5xT8q0vO4j+mf75VKDZmbeP
         a6VQ==
X-Gm-Message-State: AOJu0YyMKTZ4KhH4h7R5zZ5NbLPb2Vl6jBA6zgahvYcApgZorqkxAKRC
	4ZBbJgixKl1WxT5UDsH8lkyvknSIoh8U/TdOUjlj9B3g6RLd1s8rjAib
X-Gm-Gg: Acq92OFPbXCxNIWs5tlA/DmWunVmZATC2WzAfL25UqRYxAVhGODRw4LZaSi+yDmnZcO
	ugBx09PqD52gZuHcxd38i1Ib/oKvMQSDBKrhvFSvkvpQFaSldkE9BQU/EcsrRVMe8Jmz9lg0YoQ
	mdsGrYwY6wB3xZP70fpfRZppbXahnc5NArv2w8gZ+2TmAdBXl+OSFt6uLBj01s8MFmWl0T2sijQ
	92SsLu0zJQ6KLOd9T5wQfY7udkJVQl9sh9faFRVlTzmIaFD0wA0F5r5aah6bzBazelHEtq0L9EZ
	9Ya9nuHcmJz8+tQiv1Gw+eob/lrv2YxdRuxprNVxdvAw8PG8kVKC5YuJ32PXM7XZ83DnnsAypt6
	HyPSNp9XW3C5IK+Ncu/CTv0w5c7TLVeus3LIczxUd/l69H56rMV1SIc+DxkMOUq1wX39zrj+bpg
	x2wDO77LwapBZ3ZhEcb8pMTZWNJg==
X-Received: by 2002:a05:600c:3542:b0:490:b4a8:e031 with SMTP id 5b1f17b1804b1-490ec480e65mr32033545e9.4.1781271003902;
        Fri, 12 Jun 2026 06:30:03 -0700 (PDT)
Received: from builder ([2001:9e8:f11c:fd16:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e2cf582bsm166811555e9.10.2026.06.12.06.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:30:03 -0700 (PDT)
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
Subject: [PATCH net-next v2 1/2] dt-bindings: net: pse-pd: add bindings for Realtek/Broadcom PSE MCU
Date: Fri, 12 Jun 2026 13:29:41 +0000
Message-ID: <20260612132944.460646-2-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260612132944.460646-1-jelonek.jonas@gmail.com>
References: <20260612132944.460646-1-jelonek.jonas@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-298672-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:bjorn@mork.no,m:jelonek.jonas@gmail.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:jelonekjonas@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,makrotopia.org,mork.no,gmail.com];
	FORGED_SENDER(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D7E3679E42

Add a binding for the microcontroller (MCU) that fronts the PSE silicon
on a range of managed switches. The host talks only to the MCU, over
I2C/SMBus or UART, using a fixed message-based protocol; the PSE chips
behind it never appear on the bus.

The compatible identifies the PSE-MCU protocol dialect
(realtek,pse-mcu-rtk or realtek,pse-mcu-bcm), not a specific part: the
node describes the MCU - whose silicon is a general-purpose
microcontroller that varies across boards - and the 'realtek' vendor
prefix reflects the platform these MCUs are found on (Realtek-based PoE
switches), following the google,cros-ec-* pattern rather than naming the
MCU silicon. The '-rtk'/'-bcm' suffix selects the Realtek or Broadcom
dialect within that one family. The specific PSE chip is detected at
runtime and is not described here.

A single compatible per dialect covers both the I2C/SMBus and UART
attachments: the wire protocol is identical across them and the transport
is expressed by the node's parent bus, so it is not encoded in the
compatible.

Both dialects share one protocol family and one device tree contract, so
they are documented in a single binding under one vendor prefix. The
'realtek' prefix is used because this MCU front-end is found almost
exclusively on Realtek-based switches; the Broadcom dialect is expressed
as the realtek,pse-mcu-bcm compatible within the same family.

Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
---
 .../bindings/net/pse-pd/realtek,pse-mcu.yaml  | 154 ++++++++++++++++++
 1 file changed, 154 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu.yaml

diff --git a/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu.yaml b/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu.yaml
new file mode 100644
index 000000000000..2fb729dcb41f
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu.yaml
@@ -0,0 +1,154 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/pse-pd/realtek,pse-mcu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek/Broadcom PSE MCU
+
+maintainers:
+  - Jonas Jelonek <jelonek.jonas@gmail.com>
+
+description: |
+  Microcontroller (MCU) that fronts the PSE hardware on switches using
+  Realtek (RTL8238B, RTL8239, RTL8239C) or Broadcom (BCM59111, BCM59121)
+  PSE chips. The MCU exposes a small message-based protocol over either
+  I2C/SMBus or UART; the actual PSE silicon is not accessed directly. The
+  Realtek and Broadcom variants share this device tree contract but use
+  different protocol opcodes, selected by the compatible.
+
+  The compatible identifies the PSE-MCU protocol dialect, not a specific
+  part. The device described here is the MCU, whose own silicon varies
+  across boards and is incidental to the protocol. The MCU is not
+  made by Realtek or Broadcom; the 'realtek' vendor prefix reflects the
+  platform these MCUs are found on (Realtek-based PoE switches) and the
+  '-rtk'/'-bcm' suffix selects the Realtek or Broadcom protocol dialect.
+  The specific PSE chip behind the MCU is not described in the device
+  tree either; it is detected at runtime by querying the MCU.
+
+  A single compatible per dialect covers both the I2C/SMBus and UART
+  attachments: the wire protocol is identical across them and the
+  transport is already expressed by the node's parent bus, so it is not
+  encoded in the compatible. Transport-specific properties differ
+  accordingly - the I2C attachment carries 'reg' (and, for Realtek,
+  'realtek,i2c-protocol'), while the UART attachment carries the serial
+  peripheral properties such as 'current-speed'.
+
+properties:
+  compatible:
+    enum:
+      - realtek,pse-mcu-rtk
+      - realtek,pse-mcu-bcm
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
+  realtek,i2c-protocol:
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [ i2c, smbus ]
+    description: |
+      Wire framing the MCU firmware expects on the I2C bus. "smbus" means
+      reads carry a leading command byte (0x00) and a repeated start; "i2c"
+      means bare 12-byte writes and reads with no command prefix. Only
+      applies to the Realtek I2C attachment.
+
+required:
+  - compatible
+
+allOf:
+  - $ref: pse-controller.yaml#
+  - $ref: /schemas/serial/serial-peripheral-props.yaml#
+  # The I2C attachment (identified by 'reg') cannot carry serial bus props.
+  - if:
+      required: [reg]
+    then:
+      properties:
+        current-speed: false
+        max-speed: false
+  # 'realtek,i2c-protocol' is meaningful only for the Realtek I2C attachment;
+  # the Broadcom variant and any UART attachment must not carry it.
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: realtek,pse-mcu-rtk
+      required: [reg]
+    then:
+      required:
+        - realtek,i2c-protocol
+    else:
+      properties:
+        "realtek,i2c-protocol": false
+
+unevaluatedProperties: false
+
+examples:
+  # Realtek PSE chip, I2C attachment (SMBus framing).
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-pse@20 {
+            compatible = "realtek,pse-mcu-rtk";
+            reg = <0x20>;
+            realtek,i2c-protocol = "smbus";
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
+  # Broadcom PSE chip, I2C attachment.
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-pse@20 {
+            compatible = "realtek,pse-mcu-bcm";
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
+  # Realtek PSE chip, UART attachment.
+  - |
+    serial {
+        ethernet-pse {
+            compatible = "realtek,pse-mcu-rtk";
+            current-speed = <115200>;
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


