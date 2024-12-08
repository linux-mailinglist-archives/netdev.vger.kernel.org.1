Return-Path: <netdev+bounces-149931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E519E82D3
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 01:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D74F81884971
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 00:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251E9EEA6;
	Sun,  8 Dec 2024 00:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEW4QoaS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210651361;
	Sun,  8 Dec 2024 00:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733617307; cv=none; b=sFReShVJX+gopS7vmctEZvva/FiA8CbQWnlrGSN36PkxwItsrBdAhmFzz63hvKTKDvDwC1eikk3EeKvAJHUTqY+gONNOaIUbq0sQvxoLz9hR0bGG8ta9QADV2GCs9aAetxImK8oeNR2j15z2YdOnkNbtvrv/OcFRJudgcxL1Ue8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733617307; c=relaxed/simple;
	bh=ufjuYZgodWyMgL8tPolzg4NHI/MynPCKZW/D/mNtnNo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/lJb28ZLtUSMOp86hqkHX9UmXhnTRh54eMh01fISjUEyVBouYc16pli61YvyqdNttbsg4Os499PNP+G3a6TsxgXLeBUX3RWbzX6wn3NZITlmONPc8doNNmov6e5To2JO0PdCppbXeSPiXDTwqhHLCz3Fl8m9hy62e8qHk1xNaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEW4QoaS; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38632b8ae71so824457f8f.0;
        Sat, 07 Dec 2024 16:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733617303; x=1734222103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ijn5hxrkaTVmMCGK2s49Fof0nRp2zbU7nwPzckeCES8=;
        b=AEW4QoaSBp+kK7YlFiRqxi0iLH5Dc0bRTbkZDmSzs3UXDZ6eDotYMDp/nK0ORcrPTo
         iobdelINRG9d2O+GgGoWTcPs6exabMXNfpmP20jCyzP1+vRzFaiQDid7L03hF6DBJLm5
         5BYtstl6vhqiJPm4U6nP//jzcT4iGOrlw7yuvb4OZ5sjpdOvF66kZh/kCoTGyy4r+xu4
         J6aaDVAuBcFcGvMP92M6oNFrk5UCKwBnU58P8HQDXcVNhUUweLypPwAXOxXjOsd+9SiZ
         cf013qeGd/NURVE5oKP4uMY6nv5Uw0IZ5Y4MouHtJYiniTapZICU+4LoqzlY5gY2lXS3
         3h3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733617303; x=1734222103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ijn5hxrkaTVmMCGK2s49Fof0nRp2zbU7nwPzckeCES8=;
        b=cIiXHI0gNQI9nNEgwGRWa2cmUafEfnKCfUgNMKD8HZXUZyXLm1N0/GsDTRv02mdr4k
         2ieJTjs2LWM0JkkSD77GwwvU+g1tl8e/rf9PoRnDqhTkpe/RemAv3o6A8/NvnuF+Ud07
         j2v88YHgphzRj9h/Wp1nA/LGcW9LTqt5yHAm7Dhb10jm8r44dosk+AeKfJij36rgW0yt
         qsGNMk0z27l358ggxlx69wZIPOQIpp+VTMO1P70k3mxqXbE6Yj1rad8ZqLNkA9JwvkNB
         33fU8xfJpfxfyXPqrCBqvDGgz/W0jAmf5mnRAtaVxX+VfozSPeudLPqD0JPeqAhz5351
         rk9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUO7O166HHKS9vpXEnictlZdmShSrIooL+tVzk6Z4TOgCy//nvq+xmzjnRJN7ePz5bw9FS/803M@vger.kernel.org, AJvYcCVx+8Eybr2WudWitsTvRSAfDHpjvgshFf8RX38+d82PFPEZ+EiJV8u+8ZesCRpWf7aivsyeG7b2QIuy6yrb@vger.kernel.org, AJvYcCVyP0vptWOcQDOLdJKM3CT9QIXpSteKFZee1pnkhrgPesFg2+0u0DhZEjraGVDIAhSCINyG8uHqhZaG@vger.kernel.org
X-Gm-Message-State: AOJu0YypzhgmlNFi+khK96EAq8JMPYwFQyL+NuLxB/rrNOCZtVlR8iHL
	DpwyNXkwBoP9+Ay941Qr4elyeBy05eK9yNh3lr9aZw3drr5ZjYyzVJ3q+g==
X-Gm-Gg: ASbGnctv/hTQnYM2s7Db82s4wq0oBkR2yv7Jdd36aXCrBGEirWlNGjwhCUW2WQHOPis
	lVkhjll7kFeRQJ810Iie5P72VYBYHwXc54XdsyEbwpZQRtrdx5xqLIB1DyX4oHSvAHoXuPjjlNg
	5aYRWWJHkHNk9KDg9xti2jquBUIp0Hzyf9SVcpMaNyQNdjUOnN0clwgd7boJNDuFtqDC65p5ATt
	64mFtCEwrZxTZRCdH9DzXmopQmAkYfumkJywYIBoTGzLPht/caX6ZvK6mXCH6PPV1DU5pD4sPc/
	vNhTNWdt8VOlIrkmuz8=
X-Google-Smtp-Source: AGHT+IGGiL/FLsNBOG6vRPCUswcq+8Yc5dOijL51ipWFUFNJsZCfrAtvBpeSGrtsADSVQ5NqdZOxyw==
X-Received: by 2002:a5d:64af:0:b0:385:df6d:6fc7 with SMTP id ffacd0b85a97d-3862b36aaa4mr6007262f8f.25.1733617303105;
        Sat, 07 Dec 2024 16:21:43 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38621909644sm8719170f8f.76.2024.12.07.16.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 16:21:42 -0800 (PST)
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
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: [net-next PATCH v10 1/9] dt-bindings: nvmem: Document support for Airoha AN8855 Switch EFUSE
Date: Sun,  8 Dec 2024 01:20:36 +0100
Message-ID: <20241208002105.18074-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241208002105.18074-1-ansuelsmth@gmail.com>
References: <20241208002105.18074-1-ansuelsmth@gmail.com>
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
index 79756f2100e0..53ef66eef473 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -711,6 +711,14 @@ S:	Supported
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
2.45.2


