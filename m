Return-Path: <netdev+bounces-214688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3CCB2AE14
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 18:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A663B189DBCD
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 16:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79AC341ACF;
	Mon, 18 Aug 2025 16:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgX15/Td"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B24341ACA;
	Mon, 18 Aug 2025 16:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755534302; cv=none; b=E7fVt1lp4P41e0O/g62tkTWxhUfqFn6lwLRSOAK++nr8ApLYYhiI2OsOTLArjU7DYh8UQm6to+WYQsZ/La3UAzf4l+gQ41WmviddWMccoLpyKs5/X/0Ts/pnt9V5b5sH8NMH7ZIlMAwyeR1xKJvwDFdZ0oeWI6+sZ0TMx0AonL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755534302; c=relaxed/simple;
	bh=p4j3Ou574AU4uAyAt7viVlhxOh0VN43JLswj/0H1h5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l7NTQU9aQRtLQklDQFdoThlLy28hCrig/AjPvKAuac6zhU/0wMi1jY+xFvTZqub4+4LpjPW3ROPIQsEFpiFLoC46anTonj0MxLNP5pjINQ0TFC9670rwMcMCvAQ+scQkeel3Owcj10T8+aFiSjrW2QosRAMDflSo251xOT7jWHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgX15/Td; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32326e69f1dso4637974a91.3;
        Mon, 18 Aug 2025 09:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755534300; x=1756139100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Ge9KOIgT9v/HW+b2A4O5K3vAeuQPryFMDoukKS/jK4=;
        b=XgX15/TdxQgdCAO7h4fb/AAhWnUWLEQSXn4dQc26bnatt824S1/JfDVmqoNDpY1ybT
         4ug+06FfjlDYX9Rmrtgqk6/0Uben0BXHO1l1TUiF1LcYPeptlhYvOCdWObsDcDy05pJV
         /BKLPM3LNz8ke/T1y/M+ebRTF9UfEkevnZjFH9DRwcmVW1LrTfk5o4KwMFBTRrmUhY2G
         DLAfIcwQkR67ta/KLsqlOF+CIUJ5pzSzabEG+9T2lHxUQ1exkiZE1aIthEp+hdvTKgB7
         DTRHb0hTwA2svdRAKJP5JOsZtEOTGMGgCJwc6eKPbhen6eT8sLAYvo0bCiYPKhXNX+b4
         xjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755534300; x=1756139100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Ge9KOIgT9v/HW+b2A4O5K3vAeuQPryFMDoukKS/jK4=;
        b=mLwhI89sRbGk7V5rlWDS4Q6A70EGu25XzSUCU7MF1fPRmzowI5XZ/djCBRIcbVh6gt
         oDRuEdVEgLyY4mYHWeZky/N9slbL/JcMdOi0ErSEzLx+paJUwe5V2l0Q4TfxpBKCdNvB
         MKd7q8z6wMX2FmJ4sM2TFxps6az2PjDNIYyESSEVe7F/2MggkyzhG5wygAHl++Me4B6B
         thyopM0CDDYZqgiqe1fOicF28OYRpQI30TQyfwQTKUJ3ucfckCS7kF2CumrqNja+NzU6
         ApLE0RgSG2iAfydlyEVBEORpKOc4LUHGsBKcBJLIlJK/WdqIOOnY3Me/o4ih+MqjTrlW
         Oi9w==
X-Forwarded-Encrypted: i=1; AJvYcCVyOTuzS/buafFBPBgB4VDjJS1GzesXc7ARNwJh0xDpkYWVy4Z58FnblrnhmwMCsoPSGZybh1/XCDcV@vger.kernel.org, AJvYcCWKBfaKGH8RV7Gu0KV+epNFH7D3TyfVV7lu73SNPp6eLpCpqIsV1wbofolJ3FaeWeUTBglxwlh0rOFNgA4J@vger.kernel.org
X-Gm-Message-State: AOJu0YyITJNX+puz6xMRCFPmZmObza37tAG7f3pSI1ZZsdKUo+ChTxzZ
	WYlje9d4YAjg5EEU4fPZ632SGDD1eiWLsy3zpHJCAwjwfwe8iCecK+4aRxSyyqMc
X-Gm-Gg: ASbGnctIzMAxxOWA9L6zeCcBTggac9UMYisIMqLu+kKEHxwMElgD9HTyZjOmkj5yEMb
	/lJbdpwbdd2WpEdBdPsE7G5A1iHRWOM3yJ8idx4XKKLmYoEYzEok8MwSQbq2InIL+1xN+BXyqDV
	jIp8xTkbyDI3xMjmIKKRO/4EU1UAD8KE33UBbuu1quRs0AkNjCISdNCH/8+WACy5UDQcRawPy0z
	ZX9SZL5MNb1y3XBgv8m9ZWy5zUvzGR3eow3DmbV0bUAxVZcVnPK6yI/oxC12srYyhmtPBjXWVoV
	5CyabaIcIXYE08qdCmE4IgfJvbMwvxblAmdLb8Suvr61zTDYBOWJRdtnFWgc0iqGsGmm5KLK1nL
	hkSJdEyHevywDnuUUf9ta95gFbtLzEN2z0kaluvZf
X-Google-Smtp-Source: AGHT+IHWTR7mRCzj+s7OF0H4VLcMq2ZFlhQCU50bBw6ACOkNQ6b4ohMQHRDpARRwG09mGsv5I2G6PA==
X-Received: by 2002:a17:90a:dfcd:b0:311:f684:d3cd with SMTP id 98e67ed59e1d1-32341ec4721mr18253744a91.12.1755534300039;
        Mon, 18 Aug 2025 09:25:00 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3237e400e8dsm382656a91.22.2025.08.18.09.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 09:24:59 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next v4 1/3] dt-bindings: net: dsa: yt921x: Add Motorcomm YT921x switch support
Date: Tue, 19 Aug 2025 00:24:40 +0800
Message-ID: <20250818162445.1317670-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818162445.1317670-1-mmyangfl@gmail.com>
References: <20250818162445.1317670-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Motorcomm YT921x series is a family of Ethernet switches with up to
8 internal GbE PHYs and up to 2 GMACs.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 .../bindings/net/dsa/motorcomm,yt921x.yaml    | 162 ++++++++++++++++++
 1 file changed, 162 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml

diff --git a/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml b/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
new file mode 100644
index 000000000000..f7c05eaf0038
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
@@ -0,0 +1,162 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/dsa/motorcomm,yt921x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Motorcomm YT921x Ethernet switch family
+
+maintainers:
+  - David Yang <mmyangfl@gmail.com>
+
+description: |
+  The Motorcomm YT921x series is a family of Ethernet switches with up to 8
+  internal GbE PHYs and up to 2 GMACs, including:
+
+    - YT9215S / YT9215RB / YT9215SC: 5 GbE PHYs (Port 0-4) + 2 GMACs (Port 8-9)
+    - YT9213NB: 2 GbE PHYs (Port 1/3) + 1 GMAC (Port 9)
+    - YT9214NB: 2 GbE PHYs (Port 1/3) + 2 GMACs (Port 8-9)
+    - YT9218N: 8 GbE PHYs (Port 0-7)
+    - YT9218MB: 8 GbE PHYs (Port 0-7) + 2 GMACs (Port 8-9)
+
+  Any port can be used as the CPU port.
+
+properties:
+  compatible:
+    const: motorcomm,yt9215
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  motorcomm,switch-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Value selected by Pin SWITCH_ID_1 / SWITCH_ID_0.
+
+      Up to 4 chips can share the same MII port ('reg' in DT) by giving
+      different SWITCH_ID values. The default value should work if only one chip
+      is present.
+    enum: [0, 1, 2, 3]
+    default: 0
+
+  mdio:
+    $ref: /schemas/net/mdio.yaml#
+    unevaluatedProperties: false
+    description: |
+      Internal MDIO bus for the internal GbE PHYs. PHYs 0-7 are used for Port
+      0-7 respectively.
+
+  mdio-external:
+    $ref: /schemas/net/mdio.yaml#
+    unevaluatedProperties: false
+    description: |
+      External MDIO bus to access external components. External PHYs for GMACs
+      (Port 8-9) are expected to be connected to the external MDIO bus in
+      vendor's reference design, but that is not a hard limitation from the
+      chip.
+
+allOf:
+  - $ref: dsa.yaml#/$defs/ethernet-ports
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        switch@1d {
+            compatible = "motorcomm,yt9215";
+            /* default 0x1d, alternate 0x0 */
+            reg = <0x1d>;
+            motorcomm,switch-id = <0>;
+            reset-gpios = <&tlmm 39 GPIO_ACTIVE_LOW>;
+
+            mdio {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                sw_phy0: phy@0 {
+                    reg = <0x0>;
+                };
+            };
+
+            mdio-external {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                phy1: phy@b {
+                    reg = <0xb>;
+                };
+            };
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                /* phy-handle is optional for internal PHYs */
+                port@0 {
+                    reg = <0>;
+                    label = "lan1";
+                    phy-mode = "internal";
+                    phy-handle = <&sw_phy0>;
+                };
+
+                port@1 {
+                    reg = <1>;
+                    label = "lan2";
+                    phy-mode = "internal";
+                };
+
+                port@2 {
+                    reg = <2>;
+                    label = "lan3";
+                    phy-mode = "internal";
+                };
+
+                port@3 {
+                    reg = <3>;
+                    label = "lan4";
+                    phy-mode = "internal";
+                };
+
+                port@4 {
+                    reg = <4>;
+                    label = "lan5";
+                    phy-mode = "internal";
+                };
+
+                /* CPU port */
+                port@8 {
+                    reg = <8>;
+                    phy-mode = "sgmii";
+                    ethernet = <&eth0>;
+
+                    fixed-link {
+                        speed = <1000>;
+                        full-duplex;
+                        pause;
+                        asym-pause;
+                    };
+                };
+
+                /* if external phy is connected to a MAC */
+                port@9 {
+                    reg = <9>;
+                    label = "wan";
+                    phy-mode = "rgmii";
+                    phy-handle = <&phy1>;
+                };
+            };
+        };
+    };
-- 
2.50.1


