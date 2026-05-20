Return-Path: <netdev+bounces-290074-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAv9EDgkDmr26QUAu9opvQ
	(envelope-from <netdev+bounces-290074-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 23:14:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E1A59A945
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 23:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C30DE32EB900
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 19:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C75340A6B;
	Wed, 20 May 2026 19:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBlLoQ4S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CFB3446CE
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 19:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779304863; cv=none; b=Txk4KwU1h1rgtorPUo3ja5N+RX7WdENwYS4PQmK1iGJNn96MZuqftHTBri0QyZWBWdCRhLzWCzwwd/1AVChypWhvgwx2G11Qp6yRwhLA47y1D2lnJTcQSxxtg41+2Con5U1fU+iZwss+Tc/oW4PXlqSIZBwsE74TcGkfIwrOPak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779304863; c=relaxed/simple;
	bh=Brhw9cLH5ylmQDDlDuI16ieR0V8mAKyLCwpMqKfdA7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VL6IJqIYG385bynPTsjCMqLp5OMjD0tu7ESvQQH3OuANjbZPcGW8+dRyuxOVsb+ATXKgP3ZTtIaqLA5drRzZ9r2xW219Pu2A/Q+kGtPDk3oAuosS34RUl5TrB8MuHgzenocaL0tmVR4fduL9H3OEv6ahTZ+ps93SkCEZkNFEeNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBlLoQ4S; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7cb345cb5bfso41155327b3.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 12:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779304861; x=1779909661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5TTDq02y3Gl4AgphCYbWKzZgUrY86RmMrga/1rglYM=;
        b=ZBlLoQ4SgWl/Zs1Y5ySFU+lPw/+FrYhRk+SgHxY1Ka/72BbbQkxPFKe/4h745K0L4k
         AAeGK9ZbUr2Wmvc2bvPJrCf30t6ai5gjpFVC8qboK8kocMB5Uf/8rshp9jJtXEO/xGbb
         Bin4HFQHDTSZjdsVZ450Hk0SaujTConmaDDGxOkRnXI5/Hn7wvsAb4YjFkEDMfYkNXRD
         qILNmjTMNjFcY2jz07tbhARoq05jKkgjXI2kg0vmVuZX3dzwEOCx89BAVpsFEcdd/8nk
         I/DY/RLHUWpZ8Tj6h+rLGJTxZbG9fyKP1gSUttiGRvlICkGZxWKGTCWKIqWSWfiOgePR
         X/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779304861; x=1779909661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p5TTDq02y3Gl4AgphCYbWKzZgUrY86RmMrga/1rglYM=;
        b=CGbWU9lhQ3aMC56Gsqqfdi89G2X2HKmZDqXoHXcZ2uBHyujsQiTh/NROOPcGwm6bIu
         DhRpy0J9Tldsadj3vYCp8vpLPWfxGfveW2XYMX9Fp8bcud7i3sz9khg/tex4LEiJL955
         zl1UdWjsQGwci2zC7LP3dC735xqcSZteAW3/sFfO9SRVS2osESjzKqGhFD/Km/CI6vTd
         tdMEofe5cWum8LSvDfdhEAxx2/Su6NCVguHrmsNggBL4gPAl18G/hnd64PfrmFxFfi5V
         SDxvMTpXk05TvRngtabq9CueWMtlVNEkcA/I/et0nhIba5C7q0+umS/hk0uztKtaRU6r
         Pcnw==
X-Forwarded-Encrypted: i=1; AFNElJ9RkY5Jjd+h1wZranN0oOCcs6neM3X7eWSZN2Kuk2FUkuAIASmxhnw4UQfJqmPze2TLjN1HJlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmaGx5SU5r5KWvfDg3UkcJp57TIFlnUJNZy7GX6p74g2IMvP3x
	MzN1Rqe6zY0PSd7XGUhUGfcKOyz7objzYWh+w7mKQoLN1A3qSTE9qiE=
X-Gm-Gg: Acq92OH4c0vG50+KpC/xWpYMfbYd7XHyerQQsvApnRX3+G12t/j8+Y2Xcc3NqOgfZSo
	DzDZz8mUA6u4hoKwRhqdgiAj3r3ERlvim0mRALOb7HwWZpiu9ZaqQFVrliqv/TK9F7suchWanbu
	dK4dcg9vLKBy4Rgw9M2M6EQ09/ZKtfmsXzt7C9KjHCaco5WW+CO3WHGg01uyJAfZV0lGOqQfKH3
	xmaRsasfIl1Iq1TffBMrO5LPw02/U5QlY2rGfWoXniTbDS2eujEP8FW9jgPYzOhBE1ja7/UNGJE
	nYt0DQ5tYvoszuTQKgvwd/ERzwcJiRzCCKpyOfQmW0l645x73fxqnuM2IdbyFI3Q1QogKAsr8Gn
	nV6uGBYaTtJvyUF7R9XKTyhJz8gdZqEzpcIrbAzd1C7OrGWRl9QMvARK/w4mjDtaOS1yY3K17To
	W+WpRRPtO+qyHzSyEiE5C13qjWMZ0BofuI98a7cs031DVqTSOlhPhP0p2s
X-Received: by 2002:a05:690c:19:b0:7bb:eaf:5101 with SMTP id 00721157ae682-7c9599a2f1emr289856297b3.16.1779304860938;
        Wed, 20 May 2026 12:21:00 -0700 (PDT)
Received: from alir-mac.sitimecorp.com ([12.1.37.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9d18dcddsm56346757b3.49.2026.05.20.12.20.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 20 May 2026 12:21:00 -0700 (PDT)
From: Ali Rouhi <rouhi.ali@gmail.com>
X-Google-Original-From: Ali Rouhi <arouhi@sitime.com>
To: jiri@resnulli.us
Cc: vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	cjubran@nvidia.com,
	Oleg.Zadorozhnyi@devoxsoftware.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ali Rouhi <arouhi@sitime.com>
Subject: [PATCH v2 net-next 2/3] dt-bindings: dpll: add SiTime SiT9531x clock generator
Date: Wed, 20 May 2026 12:19:42 -0700
Message-Id: <20260520191943.73938-3-arouhi@sitime.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20260520191943.73938-1-arouhi@sitime.com>
References: <20260520191943.73938-1-arouhi@sitime.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-290074-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rouhiali@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_PROHIBIT(0.00)[0.0.0.1:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sitime.com:mid,sitime.com:email,0.0.0.0:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,devoxsoftware.com:email,0.0.0.68:email]
X-Rspamd-Queue-Id: 89E1A59A945
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add device tree binding documentation for the SiTime SiT95316
and SiT95317 DPLL clock generators.

Co-developed-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
Signed-off-by: Ali Rouhi <arouhi@sitime.com>
---
 .../bindings/dpll/sitime,sit9531x.yaml        | 145 ++++++++++++++++++
 1 file changed, 145 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dpll/sitime,sit9531x.yaml

diff --git a/Documentation/devicetree/bindings/dpll/sitime,sit9531x.yaml b/Documentation/devicetree/bindings/dpll/sitime,sit9531x.yaml
new file mode 100644
index 000000000000..ac88f2f0b2ae
--- /dev/null
+++ b/Documentation/devicetree/bindings/dpll/sitime,sit9531x.yaml
@@ -0,0 +1,145 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dpll/sitime,sit9531x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiTime SiT9531x DPLL Clock Generator
+
+maintainers:
+  - Ali Rouhi <arouhi@sitime.com>
+
+description: |
+  SiTime SiT95316 and SiT95317 are I2C-controlled programmable clock
+  generators with integrated DPLL for synchronization applications.  Both
+  variants contain four PLLs with automatic/manual reference selection,
+  DCO frequency adjustment, and phase offset measurement via an on-chip
+  TDC (Time-to-Digital Converter).
+
+  SiT95317 provides 4 inputs and 8 outputs; SiT95316 provides
+  4 inputs and 12 outputs.
+
+properties:
+  compatible:
+    enum:
+      - sitime,sit95316
+      - sitime,sit95317
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description:
+      External crystal/oscillator feeding the chip's XIN/XO_CLK input.
+      The chip's PLL Fvco is computed relative to this reference, so the
+      driver requires a non-zero rate at probe time.
+
+  clock-names:
+    items:
+      - const: xtal
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the chip's active-low reset pin (RESETB).
+
+  interrupts:
+    maxItems: 1
+    description:
+      Interrupt from the chip's active-low INTRB output.  Asserted when
+      the device detects a status change such as lock acquisition or loss.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+allOf:
+  - $ref: /schemas/dpll/dpll-device.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    xo: xo {
+        compatible = "fixed-clock";
+        #clock-cells = <0>;
+        clock-frequency = <48000000>;
+    };
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dpll@68 {
+            compatible = "sitime,sit95317";
+            reg = <0x68>;
+            clocks = <&xo>;
+            clock-names = "xtal";
+        };
+    };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    xo2: xo2 {
+        compatible = "fixed-clock";
+        #clock-cells = <0>;
+        clock-frequency = <48000000>;
+    };
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dpll@68 {
+            compatible = "sitime,sit95316";
+            reg = <0x68>;
+            clocks = <&xo2>;
+            clock-names = "xtal";
+            reset-gpios = <&gpio 78 GPIO_ACTIVE_LOW>;
+            interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
+            dpll-types = "eec", "eec", "eec", "eec";
+
+            input-pins {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                pin@0 {
+                    reg = <0>;
+                    label = "clkin0";
+                    connection-type = "ext";
+                    supported-frequencies-hz = /bits/ 64 <10000000>;
+                };
+
+                pin@1 {
+                    reg = <1>;
+                    label = "clkin1";
+                    connection-type = "synce";
+                    supported-frequencies-hz = /bits/ 64 <156250000>;
+                };
+            };
+
+            output-pins {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                pin@0 {
+                    reg = <0>;
+                    label = "clkout0";
+                    esync-control;
+                    supported-frequencies-hz = /bits/ 64 <156250000>;
+                };
+
+                pin@1 {
+                    reg = <1>;
+                    label = "clkout1";
+                    supported-frequencies-hz = /bits/ 64 <25000000>;
+                };
+            };
+        };
+    };
+...
-- 
2.43.0


