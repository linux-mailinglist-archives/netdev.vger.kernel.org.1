Return-Path: <netdev+bounces-304985-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uZMCK4WQS2psVgEAu9opvQ
	(envelope-from <netdev+bounces-304985-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 13:24:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 836FB70FCE1
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 13:24:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=UjaxE9Xi;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304985-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304985-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4819B30089B1
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 11:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDAD414A13;
	Mon,  6 Jul 2026 11:24:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CA03FE369
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 11:24:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783337085; cv=none; b=OhrBoI8iX+KyXg/n/QDhTkzsE4ialAtrV+OfvnCqhD7d/1nL0tgTivI/kYw/ghAZuH02pAL/YRfjSzWMk/MQeLnapHcHfY2S6qpxO1fL7+aKJTkNfHP9HgzGTjXVlIGTu4Vhf1lpM+8ESVqMbncFJVuIb0wGR2GERD7StVywzIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783337085; c=relaxed/simple;
	bh=1E1CkvRq4zgoyuRVYKQUN2G5DqoDNUVjSieh3Io0qlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlYa6+HBsNvrGINqoAKPErgpy8/sP+/u0Yw7ENHPtJ5aLzEWQ2+ZrSjqW/hthhkSRdciUjtb53Q6ECzI8BYEgv+XxubF+1GvVhzwxcwpM2uYJY6s1uzANBwHrPW3g/vB1DPQQ65I/yLQhERcxVzZvMKhUvvrxDhPyrKvnuHPGLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UjaxE9Xi; arc=none smtp.client-ip=209.85.128.42
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493c55d5c7aso28116455e9.1
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 04:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783337082; x=1783941882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6p8F76x4cZ/nj8Q0sQnXgqRb5F2npcETsYgFsOmIKWI=;
        b=UjaxE9Xi3sjMgZQQkPOTFfeCDmahAjmKdOB8EdsaN6RZbKIEQmsEd88F1N5FMZCTIJ
         Z7vCQmqJw1ONkjdRP4IXDVYpDPBpZl9xzQzV+CusxqnPNKVi2sgt5NvbBI+Dw8nC5rYr
         8HKAQ6nQdmE2KPVYwq2t7RJUb++wSuG9VxRApdvne42HZm+QQFw1Fbb6UMFxR//xgfEl
         kUwH3anUv6JVaPqQFtBv80J3jnEYF4VUa5mHeo0xfBqahRtS6IkfXlkv3t7yeIKpD9/T
         UhzbGO5VCspOBzKzQDPDmHXqlAx9Y88lf/02UlxM46sZPqCzZvfBzNzAyaKKlLcvgzlt
         MY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783337082; x=1783941882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6p8F76x4cZ/nj8Q0sQnXgqRb5F2npcETsYgFsOmIKWI=;
        b=R+AlID6PcM6elSQNFECQSndoT4IAr0euufa66l2XirVqjR1J+uoPFaO8vHjNxVDweL
         eo22wI8oD410QnUybJNHqHPhOhnAwZn+L9EWXVYFHtrV2ims2+o/r8ggOLB9HRKp8tdX
         5YQSW3er47tXoBq1zWlIabnNjngKNcFKlnXrqm75kNFSZOLQVgWFm28D4kUBazQ9W+fs
         hX3RTKbEX2hRHYVa6Ih+9B8kx/7ByMHAdT39SARyfuOW2IJkdVHw4U1XAnqzu3HmHjW+
         racstOwwXPCvdrwk/jTT/R0jnjY67g6TXiOaoPZEVhRC4reeIHW0OZ4muH/6fNZRIv0o
         nFZQ==
X-Gm-Message-State: AOJu0YxhU1cgfakYKY4vUgJ371R6e9Ak/d1UX24OPWhOd4gXf5Ieqd9h
	uAS+0ALVaQa2NabAWImgG378RT6Sef9G1br/AgU4n+2+Ux52ieb5cMLm
X-Gm-Gg: AfdE7cnhkDdyjW+7WZSPEvWwe8A8wpuxBz14RJeC92qRiUQ1pkro5tXpnaHD5m0gdoe
	0toSe2HohvNoSsZpqw5pCj9sRB5lkK2RuRyI0TXdUYIhtKNqxQVova75FlyzRmd6nyYpBDKDu7N
	4xo3smnJ5iQGLVHvq2LrLIcR/Xey0NzLFTwOfwKQL7hmHhD0NjGkXQBQqO8F72KU2n7NcnHrT0e
	ybcSTzbctu/KSHdn+//4D80lOe9RLB4EciYNRKRvkevcPLzD/NkmWHBWUtmWiGVV8vC4DM7Lztw
	oWGvYAq1ZciKGJcqxK3qm1xqDxrCJUXBSyfkQmTqvkWu5gUxW3VLbwnJEVjU5xElCCefyBwE1lL
	LVUOdL/ssYxzftNf1VLJmqFEb0RmtH3vJpoVdDdM3LXEL6b72C8dKlc1yxkCo705KqPsuVKfdyS
	jzor+O76ST9/QbqO0=
X-Received: by 2002:a05:600c:5296:b0:493:d741:5d72 with SMTP id 5b1f17b1804b1-493d7415e1bmr68994125e9.38.1783337081938;
        Mon, 06 Jul 2026 04:24:41 -0700 (PDT)
Received: from builder ([2001:9e8:f13c:d516:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccdab27dsm258903245e9.4.2026.07.06.04.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 04:24:41 -0700 (PDT)
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
Subject: [PATCH net-next v5 1/4] dt-bindings: net: pse-pd: add bindings for Realtek/Broadcom PSE MCU
Date: Mon,  6 Jul 2026 11:24:21 +0000
Message-ID: <20260706112425.3149226-2-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260706112425.3149226-1-jelonek.jonas@gmail.com>
References: <20260706112425.3149226-1-jelonek.jonas@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-304985-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:bjorn@mork.no,m:jelonek.jonas@gmail.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:jelonekjonas@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,makrotopia.org,mork.no,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 836FB70FCE1

Add a binding for the microcontroller (MCU) that fronts the PSE silicon
on a range of managed switches. The host talks only to the MCU, over
I2C/SMBus or UART, using a fixed message-based protocol; the PSE chips
behind it never appear on the bus.

The compatible names the MCU front-end, not a specific part. These
boards front the PSE silicon with an MCU that presents a stable
message protocol Realtek documents. The PSE chip behind it varies
- Broadcom on older boards, Realtek on newer - and is detected at
runtime; the arrangement appears to be a Realtek MCU-based PoE design
carried across those PSE-chip generations. So the 'realtek' prefix
names that front-end (Realtek's protocol and firmware), not the
general-purpose MCU silicon or the PSE chip - the google,cros-ec-*
model. The '-rtk'/'-brcm' suffix selects the Realtek or Broadcom dialect.

A single compatible per dialect covers both the I2C/SMBus and UART
attachments: the wire protocol is identical across them and the transport
is expressed by the node's parent bus, so it is not encoded in the
compatible.

Both dialects share one protocol family and one device tree contract, so
they are documented in a single binding under the one 'realtek' prefix,
with the '-rtk'/'-brcm' suffix distinguishing the dialect.

Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
---
 .../bindings/net/pse-pd/realtek,pse-mcu.yaml  | 154 ++++++++++++++++++
 1 file changed, 154 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu.yaml

diff --git a/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu.yaml b/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu.yaml
new file mode 100644
index 000000000000..d0dfae220dc1
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
+  part. The device here is the MCU: it presents a stable message protocol
+  documented by Realtek, with the PSE silicon behind it - Broadcom on
+  older boards, Realtek on newer - detected at runtime and not described
+  here. The MCU's own silicon is general-purpose and varies across
+  boards, so the 'realtek' vendor prefix names the protocol front-end
+  (following the google,cros-ec pattern); the '-rtk'/'-brcm' suffix
+  selects the Realtek or Broadcom dialect.
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
+      - realtek,pse-mcu-brcm
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
+            compatible = "realtek,pse-mcu-brcm";
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


