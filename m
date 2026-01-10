Return-Path: <netdev+bounces-248772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8026D0DFA9
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 00:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24DA630275CF
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 23:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78C5288C3D;
	Sat, 10 Jan 2026 23:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="blh0PLkk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D8E290DBB
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 23:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768089445; cv=none; b=o629pqMh22foAcrScGNLDuGTbjncqw1ax24RBNt5Hww/uHYUCDlFWZ/wQX+16R6h0XJeRDll1ir6ZLzcCjrnolgyRuJWnYDDRo7B1t6S8q7b0NjKP8A7tkzRfsmtiOiYiKVJekB6ulXnjGPC6GAbJhJt4VK8m88HdxB85eu4Tg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768089445; c=relaxed/simple;
	bh=6d0jbGJAU8YqJ1gNkbevY7vBxa94V26EUK+0BIqPUmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lW6/8VpAZGOtivJ9VdkrHgIG6VLahFSqAema0IVvxICPbIXh/8HZE3NuNkK/hiVc6U/noS+m190V5Gq5wN964Qg+w3PwMtILfAlu+sIfd5QTXvv+oPF8bcKb269/P6U7ZZfUDDP3XcwanB3bu8T9O5uEekzkdyxoAVxkahkNUZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=blh0PLkk; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64b9dfc146fso4312257a12.0
        for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 15:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1768089441; x=1768694241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gpJJOa9t1wBvlVJkNJ/5YNn0WHt1DhBf0e1N6PffLYI=;
        b=blh0PLkkftE8QP6q7KVkkHSbROckTkfi+0yBPSqs1Pe714b9CW7w5bBUCe3+6xgbGj
         wN8CPy3BXbIDPqTkATMXglD/iBKMebVZh7Z38p55SKk+a1HruxD71qYbYhQ2pBWpRcN9
         plQZ+tAPyy3df9cWIYxwVRIEXv2N7EQyCBUT9hWThuttzVmiGxmC+TaH7Nt2KKQGYD5m
         g8p0Wgz9wnEDKQVt3aeac0E+C6JBCDvv8IBg7kcT7K+DZL3c43c6qJjdbk3usWoEmJDc
         3W8w/2Px8IljIlFE6mbvSsAIA5rVFKJ5sEHNux5TYuJNJ8EwvM+bwFDqTBV6rq1sYMsm
         ORJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768089441; x=1768694241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpJJOa9t1wBvlVJkNJ/5YNn0WHt1DhBf0e1N6PffLYI=;
        b=Yz71bD3+Sbuf35g42snVTocpThP2lqwuPtnp9wh1ClBOszn12nl6TNfJ3OrvZkFZ0T
         U2lf9YQTH4m6p55puluRUkCJn2PLlnHttx0rmbQ4OnO0MS+wUInKd21CysnQ8F6dkWq4
         d0jx+uQ08bF0jdgAblyEdbMWqKKSDgrh1cKGOxHudCoDGwP9NedV1KISTfJHbCQFnJRI
         WXQbCLSpMXDo45UlFe3LDVfC/ElasakemE4BW2AwI0hqxNxNboz2Sm1pNdjuhdnYsQr6
         UCRNyu5cBvfWDRsMyRyQ/FVyd2xEsIzIEjfa2sYf+UBwQJvaJj3IKVFPb7vQLBbD4NeU
         rDhw==
X-Gm-Message-State: AOJu0YzMTonO1lyYgNaSvGJYmpeNStWofrrbcyLCbVfcOPqdUm5cT2uw
	0HfLKpQJJ+GPhCCkb2mvHTzMZiLJzSQdqb66vQEocwHcpfLFBObgaP/kzolTKQ==
X-Gm-Gg: AY/fxX7tpRal1CXDkXxj6Ri3abWmtOeRlTbO+KNWSkcYDdJJTxudvxsxobwUdHaVhg4
	u5EpYn3bKbsFlyr+gUv18+gTg6aZwp0CR2lOKXizofYXu3rY30Go0oxNvTR0bjSh6NfDPK9msqE
	BI6WKAxlfwD1NuMqCP5koHuVVyoU6ye5/reizAUUGPhaVI1bkbHBeIw792FROmgBHxnj3jM0E/C
	YlqtDfEWR2s7hvKVYdKIbf7qpxRWN5UjRPyg/U1FbOBD4dFsL+lrLDgQ1YRu6IixXhtaM0iX/+a
	aeudIdS1MhSP1ZNNELOeQj8Jbjd48VjoeBTdZzvgf8pwKGbgjGCTTlwlN7P/1gehi2rziOvtm6g
	yo1hJdoVkhDWnmo6zgQplvzgA1EYCMtjMoLIWwj5GaaJBStP5GyKqd0P5NhIIQ9oi9F5go3SbLy
	qWcXVgteu4JvrynKT3bmTuqxZEeRMeWrFWJlnr7izh4xsorghXK/iUdEx7FDvAMX8nDrwejRGRv
	n6GA0/foqHiogkIkBgAk0JoPNEPhTuOc8ZmUoH5DQ==
X-Google-Smtp-Source: AGHT+IHgGIkPHOw9/av7xXAs6nVP8o+aqKdZVjmSF3d9NRRkl/SPH1wJAmtrOHvxDrSGi5Wp7GJd3A==
X-Received: by 2002:a05:6402:3551:b0:647:94e1:800f with SMTP id 4fb4d7f45d1cf-65097b99f05mr14840498a12.8.1768089440875;
        Sat, 10 Jan 2026 15:57:20 -0800 (PST)
Received: from blackbox (dynamic-2a02-3100-af95-6f00-1e86-0bff-fe2f-57b7.310.pool.telefonica.de. [2a02:3100:af95:6f00:1e86:bff:fe2f:57b7])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf6d5absm13701228a12.33.2026.01.10.15.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 15:57:20 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH net-next v1] dt-bindings: net: Convert icplus-ip101ag to yaml format
Date: Sun, 11 Jan 2026 00:55:44 +0100
Message-ID: <20260110235544.1593197-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows for better validation of .dts.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../bindings/net/icplus,ip101ag.yaml          | 75 +++++++++++++++++++
 .../bindings/net/icplus-ip101ag.txt           | 19 -----
 2 files changed, 75 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/icplus,ip101ag.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/icplus-ip101ag.txt

diff --git a/Documentation/devicetree/bindings/net/icplus,ip101ag.yaml b/Documentation/devicetree/bindings/net/icplus,ip101ag.yaml
new file mode 100644
index 000000000000..f245516103b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/icplus,ip101ag.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/icplus,ip101ag.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: IC Plus Corp. IP101A / IP101G Ethernet PHYs
+
+maintainers:
+  - Andrew Lunn <andrew@lunn.ch>
+  - Florian Fainelli <f.fainelli@gmail.com>
+  - Martin Blumenstingl <martin.blumenstingl@googlemail.com>
+
+description: |
+  Bindings for IC Plus Corp. IP101A / IP101G Ethernet MII/RMII PHYs
+
+  There are different models of the IP101G Ethernet PHY:
+  - IP101GR (32-pin QFN package)
+  - IP101G (die only, no package)
+  - IP101GA (48-pin LQFP package)
+
+  There are different models of the IP101A Ethernet PHY (which is the
+  predecessor of the IP101G):
+  - IP101A (48-pin LQFP package)
+  - IP101AH (48-pin LQFP package)
+
+  All of them share the same PHY ID.
+
+allOf:
+  - $ref: ethernet-phy.yaml#
+
+properties:
+  compatible:
+    contains:
+      enum:
+        - ethernet-phy-id0243.0c54
+
+  icplus,select-rx-error:
+    type: boolean
+    description: |
+      Pin 21 ("RXER/INTR_32") will output the receive error status.
+      Interrupts are not routed outside the PHY in this mode.
+
+      This is only supported for IP101GR (32-pin QFN package).
+
+  icplus,select-interrupt:
+    type: boolean
+    description: |
+      Pin 21 ("RXER/INTR_32") will output the interrupt signal.
+
+      This is only supported for IP101GR (32-pin QFN package).
+
+# RXER and INTR_32 functions are mutually exclusive
+dependentSchemas:
+  icplus,select-rx-error:
+    properties:
+      icplus,select-interrupt: false
+  icplus,select-interrupt:
+    properties:
+      icplus,select-rx-error: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethphy1: ethernet-phy@1 {
+                compatible = "ethernet-phy-id0243.0c54";
+                reg = <1>;
+                icplus,select-interrupt;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/icplus-ip101ag.txt b/Documentation/devicetree/bindings/net/icplus-ip101ag.txt
deleted file mode 100644
index a784592bbb15..000000000000
--- a/Documentation/devicetree/bindings/net/icplus-ip101ag.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-IC Plus Corp. IP101A / IP101G Ethernet PHYs
-
-There are different models of the IP101G Ethernet PHY:
-- IP101GR (32-pin QFN package)
-- IP101G (die only, no package)
-- IP101GA (48-pin LQFP package)
-
-There are different models of the IP101A Ethernet PHY (which is the
-predecessor of the IP101G):
-- IP101A (48-pin LQFP package)
-- IP101AH (48-pin LQFP package)
-
-Optional properties for the IP101GR (32-pin QFN package):
-
-- icplus,select-rx-error:
-  pin 21 ("RXER/INTR_32") will output the receive error status.
-  interrupts are not routed outside the PHY in this mode.
-- icplus,select-interrupt:
-  pin 21 ("RXER/INTR_32") will output the interrupt signal.
-- 
2.52.0


