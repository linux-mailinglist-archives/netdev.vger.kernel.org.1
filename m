Return-Path: <netdev+bounces-175058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0458A62F5E
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 16:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC3F33B959F
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 15:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D692046B0;
	Sat, 15 Mar 2025 15:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGMyB9pf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495BD202C58;
	Sat, 15 Mar 2025 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742053485; cv=none; b=ufXHHPN8ZQevkOVP4INx6Pz9PXfgXloML3pM2IhOsgo6ZFm0wFH1Mw4C0JULZjbJFDjNI4ofyFLiz7Wyb1aQ+w+PQSR28zlIuufXLl8VmoFP0/UVS2rOHJz+0Ox60lXpoNMa5pdoQE+XRLSTUDo86W31uVZefe29HHJ0yYA4lVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742053485; c=relaxed/simple;
	bh=qg2mTYzg7HIE7lMEvfsJOl5J/DhQkXww70M2Had8BVg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uL4rTUciKTMLRmDD3FHECumwYYbgYbq9iPWbPSs8iQ6gxtxXLUxa4S2+FvdrHjW3SeR5QcLCSES/HQtzT5PAX2wj6GYvvO+trFWqDqep7YXBCATqcENnsvgZKi78rg3SRNNWoFLi5sx99RgoER34RSe9Km3dOR/Y3NU/+J60VLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGMyB9pf; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-391342fc0b5so2521347f8f.3;
        Sat, 15 Mar 2025 08:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742053481; x=1742658281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=okDifKvdAt9bOzQUyi7HcNUDD0Vs7iNNXK17iMvuX8c=;
        b=mGMyB9pf9sN4AcO7ptRXq8M24kARr6v/YhznnncnT+UX++g4zFNkydEZZ8DtrO8yzd
         KLtaEb4IMTGC2ARFrLfWU/I9PLNOYXZFPWJ4FV/qv1HU8c3NK23ITApe3bO5GmCeMh4E
         NgX4jUU3x3oh0vvXQpktkYfIbOjZhVi2x0/QfC8CcTZVPgupQOrHvSOo0k6ss7ActK5B
         tCiH209YrYaESQuMhxwM7hTY/xV2+YDIElu0KUQG72JHZpgADDFR37MDdtgH7siDn5Hm
         BK9dqU4LS3wyXCkOKNzYvUu1nxIr/P9jFUksOklCcTLATCz4q+1O7RgcGLZRWb8YQDCH
         9wLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742053481; x=1742658281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=okDifKvdAt9bOzQUyi7HcNUDD0Vs7iNNXK17iMvuX8c=;
        b=XKLMM/sCC+2koddzLbKMTBorWwmHPBTpDkDn1nAdwrp967/LExsm++jidMNsTLuTD4
         5c6/bOIWA70FjL2WWdWpgXmzWeFhGrGMCv2n9WLjgDgvzBGyFEZBed/i4MEij5XRDbMI
         S12+IQ67nJmqnyiScwiTTbC5HF0jvy3EG61uCR7OAHTLot+ZSsa5Hzoc91ka7gJpMunw
         0zdodKDM8LIEVNDj6FEX5PZyTICYS/WMJJQaJtatnU551bFkoRsjlkNj6dy4myab4Lao
         5WQJetz7SwKVWOSaeIfcvfERwvc4ZSwM8rRUSET111zUGlqV0qL9P7au0n4UMlSZkPlR
         dGgw==
X-Forwarded-Encrypted: i=1; AJvYcCUPYoIYxFg5+yw3aLi5zFDLloh/mIyKtwrqMZrCTSYhzSXt4PNh+DVRgGn6wNQ01m06sve1q6IvdNvtri8i@vger.kernel.org, AJvYcCV8b3LFB+UjCSoTVy/xSLg6nWXMbNIL5tU5tGvRcHyoLYOamRm5J7hK1nF4Oue29o3P+XzLzwf9@vger.kernel.org, AJvYcCXXYodIIS3rxKApMzuGXIsVs7HpZ+UIpb2EaCcMU/7smAQwk7m1zrQcIlNVMBdwFyoqqZszl7q6/iVF@vger.kernel.org
X-Gm-Message-State: AOJu0YyWNcNhAUVxxvYfZI7njms1rYqotqvwnGMOvtECw536HwRii206
	HXM56mmtME1P84FS2OKEVnKfnyprZ4e5bX55IQauH8y1RNfYrLNA
X-Gm-Gg: ASbGncvJAGwz29Iy47KcVVzwwHfvhVwv81ko7eHD3C3ObYIGSPWEmSx+jMkIX6elh6t
	yt1ZUZoJMPVZwF72QVsaLpT1OhTXpCYyCnGPAI8cFL2my8i/X+Cj26xRg2NAhkXuwIooLbr0pqb
	vX+sc2gRHKqwHGUzvliarkM8Je9M/evpE2MZkTatBysGy+gkUx8O4xwYxcPIDtq+P9f5VEoC9+f
	Iw4jR7V9tbPXdXYsJivAZtDTqh298/Ug2ZwWitvIlFWYViap4J0OSMgyaWLo97nfFCBXZA3UP5n
	RuRUiF1aGF1z5/Dj2i5mSxDfrhbKwQjCrj0yl93idf8GbkvXSsRop56LFZI1kvmr3xymmsj+E8L
	2zGzMaz9vldW4DQ==
X-Google-Smtp-Source: AGHT+IH0OLRKrXpJrRaoJd0L3/pG0iIlC1HdRZdErik/X4m/88HEG/SGXSmlbLE3Y1ZZpFL0dkO6yQ==
X-Received: by 2002:a05:6000:1567:b0:391:2f2f:828 with SMTP id ffacd0b85a97d-3971ee443f8mr9152016f8f.29.1742053481230;
        Sat, 15 Mar 2025 08:44:41 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d1fe0636dsm53464195e9.11.2025.03.15.08.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 08:44:40 -0700 (PDT)
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
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: [net-next PATCH v13 01/14] dt-bindings: nvmem: Document support for Airoha AN8855 Switch EFUSE
Date: Sat, 15 Mar 2025 16:43:41 +0100
Message-ID: <20250315154407.26304-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250315154407.26304-1-ansuelsmth@gmail.com>
References: <20250315154407.26304-1-ansuelsmth@gmail.com>
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
 MAINTAINERS                                   |   8 ++
 2 files changed, 131 insertions(+)
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
diff --git a/MAINTAINERS b/MAINTAINERS
index ffbcd072fb14..576fa7eb7b55 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -719,6 +719,14 @@ S:	Supported
 F:	fs/aio.c
 F:	include/linux/*aio*.h
 
+AIROHA DSA DRIVER
+M:	Christian Marangi <ansuelsmth@gmail.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
+
 AIROHA ETHERNET DRIVER
 M:	Lorenzo Bianconi <lorenzo@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.48.1


