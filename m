Return-Path: <netdev+bounces-107122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBB5919ED0
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 07:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC105B25370
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 05:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CB51CD0C;
	Thu, 27 Jun 2024 05:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1C8ibX0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E791A702;
	Thu, 27 Jun 2024 05:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719466825; cv=none; b=hiHSJcbx2leXiKP3FcOhHItq9bgqrFoKRxP+/OEbT2+vcd6OHLqlq0ezcEBnLer59+kIsPifbh5Q4Njr2F5TK5l/3bqQ7WsS9dbo4+cAhGuTcsIGZuJ1d4eo+ARL501xBdMeHyR15MDnJidf2NezKBQq1a8SeUYEjpXkn4EYfpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719466825; c=relaxed/simple;
	bh=cG52z7OFLVSh3hRcZbHs+RVwsunZuZJWq3nw64oi8bA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=tGCx/qoP17OX4vlXCrl4sBUcxw82qYpvZz6581n/EZKsdqRepl9AsPXLGNXh2QquGBHXfZ6NAUtyjDaYhV+HRzP5GaCKmjKjViUcKEgbeh8uCuFfjfE5BFvF9L3d7rzlZtEMHF5vr0N1/MEVDtg4WIxF4xBwl0f0o0X/FHPNbeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1C8ibX0; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a689ad8d1f6so990759566b.2;
        Wed, 26 Jun 2024 22:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719466821; x=1720071621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bEwwpPztKOpZdSo7WcUxDYJ/5pj6Ekde9GfAMib96bM=;
        b=i1C8ibX0dI4kR15Tim8nC88UQz5LC1YhpBB9RCwpn0BEVzbOU7riP0FwS7+qn6byKz
         FGHBFIr9plsWoAv7HR5muyIl8ydX+DR3k1RmiyPExUCAMAXCLxhnClGMZjQzqdEZfce1
         B91UhtQ1x5f1auEoxYYQl666OmhxPudkm3+msOPMw5LeyCIy5ozGEIZs0MsAsw+WoLoN
         N9jkwQMDEWj0HJQ4TT0WCdvUgSBh5DRkOOCvQwAMqj/UG1pkS+b482i43aC9zgqOUC7L
         TQDEL2gq2CwhbQredh6psPyDMdC6zR4EX6mltCIgIYX4n9+BypGiTOmiC/0SPK/ZALzO
         at3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719466821; x=1720071621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bEwwpPztKOpZdSo7WcUxDYJ/5pj6Ekde9GfAMib96bM=;
        b=TsD3sfAbq8X7bkVXNHHJRXuUueS6aPXC3L1kQkzhyhnOXdQku2+0yg17sAK+X13wRE
         CEl5NBv4MOos0w5f3umi6MOtToyStjUQ3Y5SV41mSunr/IdI/uDrFW+rQGCahWidsbmH
         IvTyJ+IMqrzgxTtOqQhoDMDjwNYuCSdisYlTPJdJt4dnSatCLa/fypyUawnuFw6zaAVR
         +AX77dn6K4tKdDrYcX5akwFdSCgqb72Si2eABFDbd1PbqfH4KJhtQ4v8ILO9IGpf/UM5
         GF70jN6QlPJDCfiN1RtHWkc45ellJGLTPoNqW0TdHhMj5YWqOkrG93+c6DGp7rPjEM6i
         N1YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGkv3tnIrIwyDfFFHrdNh5YPx3lr8spprzVUK6fBsn5iw2GtXk6tt1ZNqPQvxEInvrmFKhjNRTStpZkmLc/8QRjdVPyUAsHFKo5+DKsiXuJsic2KurydzNQYgG8ed+YFrt8d3kkblcF/3XXDyiBh11uEkgiIUyGf0qWvD9lX1Lo1KTlA==
X-Gm-Message-State: AOJu0YwDqkpsQXZcYsdey6vrqV3cZEpdel7skGPJmEnTtTa9SGj2SRG1
	1zcqAjbDmlmxeQMzYaxftPRQB5yPuE6P02pqRlw3Pq0CopI5wMfv
X-Google-Smtp-Source: AGHT+IGJTzzisCNs2LoZuqnirLLGTmklhBGyKduxLjCFQSvCSMCT112XldrpxNn1SEENYWOPqBn/SA==
X-Received: by 2002:a17:907:a644:b0:a72:7c0d:8fd6 with SMTP id a640c23a62f3a-a727c0d9072mr475288066b.2.1719466821170;
        Wed, 26 Jun 2024 22:40:21 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a729d778b6fsm24551066b.98.2024.06.26.22.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 22:40:20 -0700 (PDT)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] dt-bindings: net: bluetooth: convert MT7622 Bluetooth to the json-schema
Date: Thu, 27 Jun 2024 07:40:11 +0200
Message-Id: <20240627054011.26621-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

This helps validating DTS files.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../bluetooth/mediatek,mt7622-bluetooth.yaml  | 61 +++++++++++++++++++
 .../bindings/net/mediatek-bluetooth.txt       | 36 -----------
 2 files changed, 61 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7622-bluetooth.yaml

diff --git a/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7622-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7622-bluetooth.yaml
new file mode 100644
index 000000000000..cb8ff93c93eb
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7622-bluetooth.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/bluetooth/mediatek,mt7622-bluetooth.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek SoC built-in Bluetooth
+
+description:
+  This device is a serial attached device to BTIF device and thus it must be a
+  child node of the serial node with BTIF. The dt-bindings details for BTIF
+  device can be known via Documentation/devicetree/bindings/serial/8250.yaml.
+
+maintainers:
+  - Sean Wang <sean.wang@mediatek.com>
+
+allOf:
+  - $ref: bluetooth-controller.yaml#
+
+properties:
+  compatible:
+    const: mediatek,mt7622-bluetooth
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: ref
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - clocks
+  - clock-names
+  - power-domains
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt7622-clk.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/mt7622-power.h>
+
+    serial@1100c000 {
+        compatible = "mediatek,mt7622-btif", "mediatek,mtk-btif";
+        reg = <0 0x1100c000 0 0x1000>;
+        interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_LOW>;
+        clocks = <&pericfg CLK_PERI_BTIF_PD>;
+        clock-names = "main";
+        reg-shift = <2>;
+        reg-io-width = <4>;
+
+        bluetooth {
+            compatible = "mediatek,mt7622-bluetooth";
+            power-domains = <&scpsys MT7622_POWER_DOMAIN_WB>;
+            clocks = <&clk25m>;
+            clock-names = "ref";
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/mediatek-bluetooth.txt b/Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
index 9ef5bacda8c1..988c72685cbf 100644
--- a/Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
@@ -1,39 +1,3 @@
-MediaTek SoC built-in Bluetooth Devices
-==================================
-
-This device is a serial attached device to BTIF device and thus it must be a
-child node of the serial node with BTIF. The dt-bindings details for BTIF
-device can be known via Documentation/devicetree/bindings/serial/8250.yaml.
-
-Required properties:
-
-- compatible:	Must be
-		  "mediatek,mt7622-bluetooth": for MT7622 SoC
-- clocks:	Should be the clock specifiers corresponding to the entry in
-		clock-names property.
-- clock-names:	Should contain "ref" entries.
-- power-domains: Phandle to the power domain that the device is part of
-
-Example:
-
-	btif: serial@1100c000 {
-		compatible = "mediatek,mt7622-btif",
-			     "mediatek,mtk-btif";
-		reg = <0 0x1100c000 0 0x1000>;
-		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&pericfg CLK_PERI_BTIF_PD>;
-		clock-names = "main";
-		reg-shift = <2>;
-		reg-io-width = <4>;
-
-		bluetooth {
-			compatible = "mediatek,mt7622-bluetooth";
-			power-domains = <&scpsys MT7622_POWER_DOMAIN_WB>;
-			clocks = <&clk25m>;
-			clock-names = "ref";
-		};
-	};
-
 MediaTek UART based Bluetooth Devices
 ==================================
 
-- 
2.35.3


