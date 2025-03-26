Return-Path: <netdev+bounces-177652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE55A70E36
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 01:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FFE33B3382
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 00:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3C674BE1;
	Wed, 26 Mar 2025 00:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeFV1VD+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BCD2AD02;
	Wed, 26 Mar 2025 00:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742948688; cv=none; b=N//toXVx7KSfyVBwNGjTArObpZqtH22M8o0snnHjpGPi7QNGXHxdYlnX0fZVe0vD5HtRMx3idQ3ReQ3njmoZOzjgArE5SQ9kdhqio9sc/e/nAm53c245KaJHGs9xvF+mIyYGvi49BxyhLyOsB8zxPJ26AK8uBl4uxMSdU8ncsrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742948688; c=relaxed/simple;
	bh=aaP5jjL1QpF5Nj21o9Xb0lF9G3T0YoMhm8JsQ1WNWVU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fpq7B7szOuqLI2ADodukfV4VlWos9uvFXhhwW5/4UI8Bz7/AJTCalpvq/7twckZyxNAceOhz9cQyF2FtQkNVj1/7HjHOoqC18JF0SuyB8fPqrenaSY9EFBLhZ85ZWsU1uD2Y6bXxmHUmxOPqkbHnkxcytwJkfnaMB6d86xu9cDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UeFV1VD+; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39133f709f5so3320189f8f.0;
        Tue, 25 Mar 2025 17:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742948684; x=1743553484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7GVOqH2dtb9yz9XSZOrN5yDH4kiqYTHV4lLBUZDoMkU=;
        b=UeFV1VD+0kyALjz6pU6+N7aU6p9Myc4mrEvFtNzOxlGcpzw0W6+ZIbnEegZl7O1VNC
         QT/u+U9fVIt/5mHuNOGqwWG7tX7hSpzd+Yem6defiPL2gJGEzXQ7tKyFmy9UXSAa8Jf+
         5IVC/9kCHWoO8PQZhPwqVDS0+RP/warQ5B6eaRfQ1mP5JqhSR9Z8ZE5qDYGTP911YHJO
         Y785SDJwhr5YkdNWnry+5UtFLY9G7itO0D9a56akrqoVCtiI4QgIHc59AcSQGYAx5hjZ
         c+7x4zVSSnaEYMy+WWL3FWzkbr3OjvYMMYptUaD8q3kAhGnRxgIaZahazFKilLOtogNU
         AtOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742948684; x=1743553484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GVOqH2dtb9yz9XSZOrN5yDH4kiqYTHV4lLBUZDoMkU=;
        b=RoB7k7YFQp/5knSC32Dh50zviYAx22cG5TENgCliG1rhrleMGVbpB+5wQNh3TkCrKy
         7wy9AFa8e6/7LJGxSw+l9WgcgdI7yioa1z0MhTEx9gb+NkPtQPeb2MGUIvRwapHz8yRi
         NwTXZtQuqbfW9J7ZXi0Lj6V2ucRWjdGO+OkDlXbU4hpBt6F2+A72KGUlnx0CYIH+rMAd
         7hEPDdVdTOLv+rWORhHkL29H9sSLvNENPlWOK4RwtTvll8eq6Svxk0OeOkdpaBW/+iSd
         VbzK22CvG1b8sq/m7RBlHadlMQuHex0Dil+6q9vKoJagwupe1z/wAev4lAWpcFB9txJm
         qGQw==
X-Forwarded-Encrypted: i=1; AJvYcCULBiJYvEL5FNwJH87TjxNiCJYBmcTopOZVrs8LsOG5PBYeuqh0MzDMDlN+NYkT2e9fWqGd/RxA@vger.kernel.org, AJvYcCUqaVc/X46K43jMoT+22+SPjYuE2ZtWRScRkckqxNflKAvr3CE0cH0LA72WCM+K7K9K4SyEVFcM90dj@vger.kernel.org, AJvYcCVq0WHKhrnpjJFOGEP5wk6yy+bqzb4y2JOtSl2+cwAK7Payhxd9hOTxKHef7ovlBv1iMwUOHuou4UNKB8MT@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf0RnbWN+Zj2Qk81H0xaTPIuB6f2buH9tGHq0RHZ/TXKcGCdgD
	SECsraAju8S6DUqce48UDCUZaxfwRyB253TAzaBVltRCFD99RVWR
X-Gm-Gg: ASbGncuhoBCGCH2z4EsVCNLcIu5WUtEg7u6c5lKIny0h+Kuwy/SN8RYjfrBuwaJeHsB
	l88qWUKM6F5nNxUCWA9gt/O7MPsVzqeBnXmiQtRtLruRBn6KYcj5ahql18rI2et+Erv5EENquxL
	haqej5zlKNSzNhEBIladqwbt0MnHvD1o6+zVr9UI/OW/nrxLwr8O1nkrrJ/7z2/om/dQ17XF1f/
	XrVpfg+E5FncRkEQNwpRqNMtslBhvywkZObj9cLgjOxuQ3UtquRu7HAMjP9dI2eQDtbOF/GRB62
	qs9iUDOQRWu1fsnqr2u2l7b+RbkvsLWWRxw6hKaabfG1e1wkWr/MckewnjAkSRyyKIanNhI61el
	hb7Ey4MsI309lQw==
X-Google-Smtp-Source: AGHT+IFMZuYyHiG+kuQo5ASsKYd6qEZye9NJuU1S/BTl3/N4zFNkuG3JpLEKST1/WUmjYHSFdLYfng==
X-Received: by 2002:a05:6000:188e:b0:391:20ef:62d6 with SMTP id ffacd0b85a97d-3997f8ef0f4mr17111653f8f.11.1742948684421;
        Tue, 25 Mar 2025 17:24:44 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39acb5d0c33sm1881990f8f.26.2025.03.25.17.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 17:24:44 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next RFC PATCH v2 3/3] dt-bindings: net: Document support for Aeonsemi PHYs
Date: Wed, 26 Mar 2025 01:23:59 +0100
Message-ID: <20250326002404.25530-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250326002404.25530-1-ansuelsmth@gmail.com>
References: <20250326002404.25530-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document support for Aeonsemi PHYs and the requirement of a firmware to
correctly work. Also document the max number of LEDs supported and what
PHY ID expose when no firmware is loaded.

Supported PHYs AS21011JB1, AS21011PB1, AS21010JB1, AS21010PB1,
AS21511JB1, AS21511PB1, AS21510JB1, AS21510PB1, AS21210JB1,
AS21210PB1 that all register with the PHY ID 0x7500 0x9410 on C45
registers before the firmware is loaded.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/net/aeonsemi,as21xxx.yaml        | 122 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml

diff --git a/Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml b/Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml
new file mode 100644
index 000000000000..69eb29dc4d7b
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml
@@ -0,0 +1,122 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/aeonsemi,as21xxx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aeonsemi AS21XXX Ethernet PHY
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description: |
+  Aeonsemi AS21xxx Ethernet PHYs requires a firmware to be loaded to actually
+  work. The same firmware is compatible with various PHYs of the same family.
+
+  A PHY with not firmware loaded will be exposed on the MDIO bus with ID
+  0x7500 0x7500 or 0x7500 0x9410 on C45 registers.
+
+  This can be done and is implemented by OEM in 2 different way:
+    - Attached SPI flash directly to the PHY with the firmware. The PHY
+      will self load the firmware in the presence of this configuration.
+    - Manually provided firmware loaded from a file in the filesystem.
+
+  Each PHY can support up to 5 LEDs.
+
+  AS2xxx PHY Name logic:
+
+  AS21x1xxB1
+      ^ ^^
+      | |J: Supports SyncE/PTP
+      | |P: No SyncE/PTP support
+      | 1: Supports 2nd Serdes
+      | 2: Not 2nd Serdes support
+      0: 10G, 5G, 2.5G
+      5: 5G, 2.5G
+      2: 2.5G
+
+allOf:
+  - $ref: ethernet-phy.yaml#
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - ethernet-phy-id7500.9410
+          - ethernet-phy-id7500.9402
+          - ethernet-phy-id7500.9412
+          - ethernet-phy-id7500.9422
+          - ethernet-phy-id7500.9432
+          - ethernet-phy-id7500.9442
+          - ethernet-phy-id7500.9452
+          - ethernet-phy-id7500.9462
+          - ethernet-phy-id7500.9472
+          - ethernet-phy-id7500.9482
+          - ethernet-phy-id7500.9492
+  required:
+    - compatible
+
+properties:
+  reg:
+    maxItems: 1
+
+  firmware-name:
+    description: specify the name of PHY firmware to load
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: ethernet-phy-id7500.9410
+then:
+  required:
+    - firmware-name
+else:
+  properties:
+    firmware-name: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy@1f {
+            compatible = "ethernet-phy-id7500.9410",
+                         "ethernet-phy-ieee802.3-c45";
+
+            reg = <31>;
+            firmware-name = "as21x1x_fw.bin";
+
+            leds {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                led@0 {
+                    reg = <0>;
+                    color = <LED_COLOR_ID_GREEN>;
+                    function = LED_FUNCTION_LAN;
+                    function-enumerator = <0>;
+                    default-state = "keep";
+                };
+
+                led@1 {
+                    reg = <1>;
+                    color = <LED_COLOR_ID_GREEN>;
+                    function = LED_FUNCTION_LAN;
+                    function-enumerator = <1>;
+                    default-state = "keep";
+                };
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 9a2df6d221bd..59a863dd3b70 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -649,6 +649,7 @@ AEONSEMI PHY DRIVER
 M:	Christian Marangi <ansuelsmth@gmail.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml
 F:	drivers/net/phy/as21xxx.c
 
 AF8133J THREE-AXIS MAGNETOMETER DRIVER
-- 
2.48.1


