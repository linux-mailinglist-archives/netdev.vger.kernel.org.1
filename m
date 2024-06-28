Return-Path: <netdev+bounces-107554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9334E91B678
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 07:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49973285EBD
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 05:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F9141A87;
	Fri, 28 Jun 2024 05:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efgOpX/7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7081F249F5;
	Fri, 28 Jun 2024 05:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719553631; cv=none; b=I4iNC0Q/e9E2GxIefc0CXOHXir/fNCh6p/c0SsU/XqcJ3goQrU8DaqxaPsciIRID4QSZ9tcTg1jKIB/qSCUtAGzlT4hrnRqnp3dUqKQU9eT6ETM7KVtk78tc6b05U92pmcbVQRmaEbo/lyhlq8RNW5t5+CH6XwEnHf8BsdnR/O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719553631; c=relaxed/simple;
	bh=wVc5/CD0hpSYSQu7Zo9aWM0/k7r2uzZkd7u/JbTNpNI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bToYSt52oyJKit/4Emw8/AD/ggi2zNgu3weIyJsl8OVAMg8cl3dJHmJGHL4st2enm8AR6j9sM9ibMODGod9zco3FzhXhv8zE0IdKg0DtYDt1Z/jy9BHsZlU/CaV+kNNnDutYyJ/kxvhzDD3h+vqW+SKTGGe88P+KK5WlCNdOowQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efgOpX/7; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a724598cfe3so25904066b.1;
        Thu, 27 Jun 2024 22:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719553628; x=1720158428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J82aso9srCTwQ13NgHA3QiH1Y/m1v0Plo0MRWgzcEWw=;
        b=efgOpX/7puElIcpH1O2JvrXMTXMUZES0vOVz6EOebIXrkWfNpxG6gtipHR9EnHxubC
         KavY5Oh+KF1fsj5j4VvbAKUygLSIZkE8fQ8gzQYn5zthseJ5hxJ9WDqmF25MXOKv1qLt
         CFyhmglMe1EoGMEw+Yhi+oVh8h3Ct0sY8AplRRedWmFMuLT+0+Td/nM1+GaQYWzYxTRU
         dMVarrnTR1O7fAmgQaLtrAGW9sKld7HJEfr9Ao1StGyy8yFmq23cJ5yCck4evMcDodhT
         WMkzLJfQ+uA/cfFtxh/VfvVz10VW4AT97Md+jMY8YZHKTWIBztVZhhkgoRY/wVS8+ha4
         zvag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719553628; x=1720158428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J82aso9srCTwQ13NgHA3QiH1Y/m1v0Plo0MRWgzcEWw=;
        b=Js+NV97scMJypnWcJW3PjO4Kbs1ALf1DT7O0Zu22VAQTJMxWBLepckd7/BJXOJwi4X
         lB6KIEHFrJilMSjmUgcvRHXfGrn3gizXOgqGxU/akSUACKgOh/JRZC6RZ3eINTU+IFFh
         npDwjCE7zHlOVYe+sJ2zkkvDyIC0OEyLN9RW+9Sx6FVJbZpWnx6nr5hIdAPf8PiabNkh
         uR3/EAd3dLiDpWp0bmErSmfcWI44tSQyrpKVARyos9/MOcoGKyVH4pXUKYcgDIVDtllq
         Bwj9Q2XXtWstFq8T/gHF9eyVLPhCMxE9zA+1XO+UpFdQZ4XvDzjctCJOHOqO80ByDJj+
         YNQA==
X-Forwarded-Encrypted: i=1; AJvYcCUi/iHReRJzA9MajTE2PoGebQHP99yVIMsBWZkhWpRmaKnswMsYn5ga6XtSYvBC8HcyaFpaMjSpXOfWpKnnc4VD3GRjvJ9aNjmM9OAALLZ3jnQGOghh9k8j4nUx3p0GEC+ygFKy45ch1mp8KLm3BgdcWsDu2rFKqybSfNyfIvKiWDeErA==
X-Gm-Message-State: AOJu0Yxu11WX7llfmBXj5kWapzjmaPFbjDFc6zU7IBERZzfGPqWFjuSN
	JpC1FnyNgMVVcbrbUG8FxZaiazeSfiDpsHvSf+3i63h6rAX+MaQ+
X-Google-Smtp-Source: AGHT+IESZihvr0VfgF8QpueLxCMpYeBNN0yaK4ft/bU3+rHkwKNn0h5UqOyBqhd7yd/NxLcWzXzC+Q==
X-Received: by 2002:a17:906:a847:b0:a6f:6721:b065 with SMTP id a640c23a62f3a-a7245bb25e6mr1136984566b.32.1719553627433;
        Thu, 27 Jun 2024 22:47:07 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab0651a8sm41665766b.128.2024.06.27.22.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 22:47:06 -0700 (PDT)
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
Subject: [PATCH V2] dt-bindings: net: bluetooth: convert MT7622 Bluetooth to the json-schema
Date: Fri, 28 Jun 2024 07:46:35 +0200
Message-Id: <20240628054635.3154-1-zajec5@gmail.com>
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

This helps validating DTS files. Introduced changes:
1. Dropped serial details from example
2. Added required example include

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: Simplify example

 .../bluetooth/mediatek,mt7622-bluetooth.yaml  | 51 +++++++++++++++++++
 .../bindings/net/mediatek-bluetooth.txt       | 36 -------------
 2 files changed, 51 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7622-bluetooth.yaml

diff --git a/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7622-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7622-bluetooth.yaml
new file mode 100644
index 000000000000..3f9e69208127
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7622-bluetooth.yaml
@@ -0,0 +1,51 @@
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
+    #include <dt-bindings/power/mt7622-power.h>
+
+    serial {
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


