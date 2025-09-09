Return-Path: <netdev+bounces-221007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5BEB49E29
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 02:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37B811BC5CE5
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 00:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE06E21255A;
	Tue,  9 Sep 2025 00:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxQZa3gQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09A6202F65;
	Tue,  9 Sep 2025 00:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757378637; cv=none; b=D/BiJZRUftokdinbZSclYTr1ltp7gwuXDVTGxzpOttHT60RARaURCyWhZYlxtLJdiGG+azudpXEDhVeAagNg0meo7ISpMSu6eAV/RdD1rCSlVB2JkkIxmGzUo48DKSBHbylnYAkWI0C6mGqhZkygwtcSNbbEz9xVEgLuAy0VtJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757378637; c=relaxed/simple;
	bh=ZeNu6STqwss1zILjoZXafqLmKBFj/4tgVpwJERvGNfk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=St0cMvYna5sjIuQoN5wUQn3oIf8PA4PF8DGWDV4a1RzFFiTzMENSvf+OFPGfGDQa80MGVMTVOmrg+b+Cn4dqaVOBYSt3qpugJbh8ua8AonbdeMYBCymowqHDQ67o+MHFW+PJrNJd0Z9twt80c6pZhVB5p+yv9Yf1OSiIgfZIdwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxQZa3gQ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3da9ad0c1f4so3482066f8f.3;
        Mon, 08 Sep 2025 17:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757378634; x=1757983434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nmx16AlzlkksRnHkq3B5FB3VAm7yIRxWMnzYKgN7RuY=;
        b=FxQZa3gQDZcwOwcti1vJEkKrcN7DsBYwSMb50kclHbA937cmUCQMor6lMLESRWjRYG
         poYGb/AgodJnhEybnLqoXOYbsxjEtujefuvF14ppVnm9BgYur9Pq4T1sT7cQ+EDkcI1F
         FLrkR3PCHPzQ0dwBDJnr7Q72U8WJVlwlW+JEivqKnba2KzX10wIw8h1GCq5/xyQ2fGdP
         s6Lp8cmgdlzXGb5Z8pppUD2OG/qcHeyPpTmdBL5ZbFnAteIuiupj5H5vXnuEGLpdiAF8
         zmccvlH1fj9RwKpw6QmzBlPgx+uuu2xQ5RwTOvsosFLoo6aBj8s75ujOGyGZ+6cH7f+E
         5k/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757378634; x=1757983434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nmx16AlzlkksRnHkq3B5FB3VAm7yIRxWMnzYKgN7RuY=;
        b=tfl/1eC9mDfWGQyLH6XdaPU6yE9QlDsfXLjg/00Wry+pBaST9T5FlrovMJihj7KxKD
         AL3n/g1BpcScHX3AFb4ZRZXpNstGmYbrXCMG0MBEnRVmoyyHpGjqNBCcqBVgmvV5eeZQ
         yGbSjrG1mGApVRAIjZ6lFgKGPuVt/+msP4+g1FC1TBx4pDX8lsHkeIHUjF9Ju8tAhNh/
         NAw7oJhCv7JGHGvfAbzFup1stdjBGCrEg2F9ovtUy2CEMwX4MWkeGvU39TwtHSQO/CbK
         kvgesWIeflf/izsSjdHFda7iCE1Cv75VVXpHtn4zZzSSv1QeIsE1TQIROIc6Jtm1cXF+
         boRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUccjA0/hRTtkAP6EROU7Art7veRoSyiU186vcisGnPxFPpOF5Z14brku+A+ntcLn3vD77Bj0v4GbplWjX2@vger.kernel.org, AJvYcCVe0KYHS7xoAZwiJUPboXCbwuzeW0AuKwPNvVjHF2Kl7rLwFZXIvFxvFCDMBdDLa4PtJz3gogAw@vger.kernel.org, AJvYcCXpDCU3KrwO+REAPNX8vnQqKm1JSzu6W3xQF7EejWzmh9CC5ZkSg3TmY2Dd8BKE5XjzwvU+lqYqJ/kp@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/cxVTreefIPDWJacKD9pExcG7AWdZZxJx/r4SOf5EOY8F5i8g
	AggM2TFBoH5ynb5MdOAv528x0MZg4MU1XACxjQJIo9ldi5I7RugCpucjo6LNHg==
X-Gm-Gg: ASbGnctvhdmg46mxPfA2JL6AVCWZK7/sbhpLWAr10bMCFylMqa+xkH5uSCfZcgGPZJO
	TwPEdVd0nrHa1uQJUFtcoqVD+bqP8S9yRM0KUVGXrmcMm+Ue4W5AIjyu60S12KOxcmA+MS3G+Xo
	WUxAs1n9qryo3zOJnkcvug4HIvNmV0lQFHA3T/6jPgVhc+/IjnWXJRM2Bb8ul6h3mZkDR2MSols
	R1Nz0qwkM7doB9aMbXZ+3WF/ZX93hCXqPpVAGenZjN2EBdJrE8CRaFl4C94OHV3USTEKdB/GEE2
	3XpoIdwf+eBa5qr/T9SKbz2+oX82NBSz17mrUrXExyEwbbOSKzLk0cMUxQrdVm939pjSaoQ1+oL
	YyXc0D9oHJjQzT/6gqYOipSnYw+CaOA0dmQH4nFuwrFzZQzi5zsWOym+8pOSEPeZCeXv6hrcSKj
	/7k9cuRg==
X-Google-Smtp-Source: AGHT+IESx0fJHFXRG2Rri2o/ks5Z5D53jIuAyZX9MuOPL7aq0mWvBElDcU1PoycLOVAYKiiF9zyY/A==
X-Received: by 2002:a05:6000:2886:b0:3e2:e079:ab32 with SMTP id ffacd0b85a97d-3e642309dc7mr9103174f8f.7.1757378633838;
        Mon, 08 Sep 2025 17:43:53 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45decf8759esm13526385e9.23.2025.09.08.17.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 17:43:52 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Simon Horman <horms@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH v16 01/10] dt-bindings: nvmem: Document support for Airoha AN8855 Switch EFUSE
Date: Tue,  9 Sep 2025 02:43:32 +0200
Message-ID: <20250909004343.18790-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909004343.18790-1-ansuelsmth@gmail.com>
References: <20250909004343.18790-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document support for Airoha AN8855 Switch EFUSE used to calibrate
internal PHYs and store additional configuration info.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/nvmem/airoha,an8855-efuse.yaml   | 123 ++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml b/Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
new file mode 100644
index 000000000000..9802d9ea2176
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
@@ -0,0 +1,123 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/airoha,an8855-efuse.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha AN8855 Switch EFUSE
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description:
+  Airoha AN8855 EFUSE used to calibrate internal PHYs and store additional
+  configuration info.
+
+$ref: nvmem.yaml#
+
+properties:
+  compatible:
+    const: airoha,an8855-efuse
+
+  '#nvmem-cell-cells':
+    const: 0
+
+required:
+  - compatible
+  - '#nvmem-cell-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    efuse {
+        compatible = "airoha,an8855-efuse";
+
+        #nvmem-cell-cells = <0>;
+
+        nvmem-layout {
+            compatible = "fixed-layout";
+            #address-cells = <1>;
+            #size-cells = <1>;
+
+            shift_sel_port0_tx_a: shift-sel-port0-tx-a@c {
+               reg = <0xc 0x4>;
+            };
+
+            shift_sel_port0_tx_b: shift-sel-port0-tx-b@10 {
+                reg = <0x10 0x4>;
+            };
+
+            shift_sel_port0_tx_c: shift-sel-port0-tx-c@14 {
+                reg = <0x14 0x4>;
+            };
+
+            shift_sel_port0_tx_d: shift-sel-port0-tx-d@18 {
+               reg = <0x18 0x4>;
+            };
+
+            shift_sel_port1_tx_a: shift-sel-port1-tx-a@1c {
+               reg = <0x1c 0x4>;
+            };
+
+            shift_sel_port1_tx_b: shift-sel-port1-tx-b@20 {
+               reg = <0x20 0x4>;
+            };
+
+            shift_sel_port1_tx_c: shift-sel-port1-tx-c@24 {
+               reg = <0x24 0x4>;
+            };
+
+            shift_sel_port1_tx_d: shift-sel-port1-tx-d@28 {
+               reg = <0x28 0x4>;
+            };
+
+            shift_sel_port2_tx_a: shift-sel-port2-tx-a@2c {
+                reg = <0x2c 0x4>;
+            };
+
+            shift_sel_port2_tx_b: shift-sel-port2-tx-b@30 {
+                reg = <0x30 0x4>;
+            };
+
+            shift_sel_port2_tx_c: shift-sel-port2-tx-c@34 {
+                reg = <0x34 0x4>;
+            };
+
+            shift_sel_port2_tx_d: shift-sel-port2-tx-d@38 {
+                reg = <0x38 0x4>;
+            };
+
+            shift_sel_port3_tx_a: shift-sel-port3-tx-a@4c {
+                reg = <0x4c 0x4>;
+            };
+
+            shift_sel_port3_tx_b: shift-sel-port3-tx-b@50 {
+                reg = <0x50 0x4>;
+            };
+
+            shift_sel_port3_tx_c: shift-sel-port3-tx-c@54 {
+               reg = <0x54 0x4>;
+            };
+
+            shift_sel_port3_tx_d: shift-sel-port3-tx-d@58 {
+               reg = <0x58 0x4>;
+            };
+
+            shift_sel_port4_tx_a: shift-sel-port4-tx-a@5c {
+                reg = <0x5c 0x4>;
+            };
+
+            shift_sel_port4_tx_b: shift-sel-port4-tx-b@60 {
+                reg = <0x60 0x4>;
+            };
+
+            shift_sel_port4_tx_c: shift-sel-port4-tx-c@64 {
+                reg = <0x64 0x4>;
+            };
+
+            shift_sel_port4_tx_d: shift-sel-port4-tx-d@68 {
+                reg = <0x68 0x4>;
+            };
+        };
+    };
-- 
2.51.0


