Return-Path: <netdev+bounces-229027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD3DBD731F
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 05:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 715A34F7B46
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 03:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773773090DC;
	Tue, 14 Oct 2025 03:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bh+ewPwA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DF5308F11
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 03:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760413023; cv=none; b=JmuLbi7/3lGFXhT77egYAKzKVjt0TQyqU2WGN/5/ZYClgi7RpZ7AfUr2F99fwqgQapGHh3CWbj98q/kwwLUBrFvG7I4h/P5xpgcUstxw4sdwrcx0reiPeLlifhzZ8J1Q9znG/kev3NdCtLPO8NcH5EIB4j0mOfhprmYEqHV8uss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760413023; c=relaxed/simple;
	bh=b6ISdhsQWDnAo4VTafE6aUOK0zWblvBU832ZglgHc1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GlysVIAT97BYKTX7M+bRJp28NewmCwZemi22aeCqUX0n1JLI55rwvUKacYlDGDG1Zlr2cUVv5weD0kECoHaAVgI7NXROM/3L7DkhyE/PrJ+bN9uN2UuPCy85u27rL0LjiRRuXPuX7tCRX6FwLffsVAfVF9xVBU8sgmrfGbchl5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bh+ewPwA; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7811a02316bso3397674b3a.3
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 20:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760413021; x=1761017821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFqmxzP975EbfL7QM6VF330m98TZjzZeICik0AHkBHU=;
        b=bh+ewPwAwtuHDJFqz7KtA3sc2w85CJdi6BouC5HY42BX2xfe1JFbrEcckCHmaHACY3
         VC4sVQs0zLEcxAYlLAiG21FnfLTTiUsOq94kBCrXr8l1l28tiK7n5wj2LahvqWbjv5gB
         Sv1ECBzsb7L8pZuTZT+HSJjxhOp+80eTkEAF+3a3Vuxm/43tg/2FHMHm6AULNtoFWeDS
         vwUQCKWQgx8FDSYjVsRNcNURFbath6oFc9ofhBmxZB969M3+Jr1JVnnwWRcb8HSzSGDx
         udVFFHGTqDropfW/EQsHLslSYTrWk15a6HwyoRVW+J+CRuZrJGpQt9cKKLszaXKN00OQ
         4L5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760413021; x=1761017821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SFqmxzP975EbfL7QM6VF330m98TZjzZeICik0AHkBHU=;
        b=OdObKVqPzwHtcufF+/xTaBPtD5oWApxvNyF/4bxIBqawgHNFjKvblTom3PWIpFUnFm
         oivH98sR8uXODkO/eqkB1xoNF3myeYPfnbpWvD3UWyUaqjTPnX1fomM4Ywy8izjzqVXU
         9U0aSn1kDO/BPlTbzEshTPvwOJWymiJuU643fOExZwv+R0wYhyqpFwRiN5TQ6yHnnkHQ
         OvF0/TOIGlrTsanYjfuRE8J2euqGWJj5co7K82XRBqIxFP2Od9JPS8CiOZcIIB6wWkON
         Erdb/A3pi14w6R5n5Gn+RxQaaXTUUZdvRkHZJgo2PEj6+Q0bRSXLKnrogwtNZrtAfvqo
         kegg==
X-Gm-Message-State: AOJu0Yzquv5EP1BfpKUhNult1qL0iNJfQ/JzodfWSYWu5uaXUAy7ZD+N
	c5s9xLQ4uVPr+WTJQHK5HRAKklxWeXXy3LjPsYV+fnhie5FI7qPCZADN0v4cWCVAWKY=
X-Gm-Gg: ASbGncvaR7E/BBzumNYehB/qVnbLXyvP5vM18Nxfng8hjync8DLEZumHQUY9c2/7FtU
	4tta7sci16nE4PgFBu3nZ59GwHUNUyO++16PF8Da/GMgTbVqbhejFtbaNObXQf+cUKUxT6XCdWT
	Fs9hxG1q2V+jeSQfmGPcZpd3uDgFp02XpqtpZ7bPh6nmhDuC+lJ/tiExSBL/t04KgXC+J6aL14a
	drEhJXAt9hS0neVoVwsmIwsS1RrJlgDJytsuw6sCOC3em+eQSo3OG3gKJVlOKE0G4YVz7hfufQG
	tvrdML/TT7O7ghacvl9sITgR6Q73vbCGSNVmkOykim6XoBvO5bI3FF4WrmPZFGWrXpA6GSsCREk
	QKDIkRFk4M3NdcXlCXGQq6iDJ6xvsAaDupqDiEYerHGxCEBG1
X-Google-Smtp-Source: AGHT+IFsRPaqZRey6OpJYdhwFuNFFCBJD3r9p2WyG0QkAxU06uwPXlj+bwct8m2hrbspXk1Qthc6oQ==
X-Received: by 2002:a05:6a00:92a2:b0:781:1784:6dad with SMTP id d2e1a72fcca58-79387c19ba5mr26833650b3a.24.1760413020669;
        Mon, 13 Oct 2025 20:37:00 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b060754sm13523825b3a.13.2025.10.13.20.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 20:37:00 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next v13 1/3] dt-bindings: net: dsa: yt921x: Add Motorcomm YT921x switch support
Date: Tue, 14 Oct 2025 11:35:45 +0800
Message-ID: <20251014033551.200692-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014033551.200692-1-mmyangfl@gmail.com>
References: <20251014033551.200692-1-mmyangfl@gmail.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/net/dsa/motorcomm,yt921x.yaml    | 167 ++++++++++++++++++
 1 file changed, 167 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml

diff --git a/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml b/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
new file mode 100644
index 000000000000..33a6552e46fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
@@ -0,0 +1,167 @@
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
+    enum: [0x0, 0x1d]
+
+  reset-gpios:
+    maxItems: 1
+
+  mdio:
+    $ref: /schemas/net/mdio.yaml#
+    unevaluatedProperties: false
+    description:
+      Internal MDIO bus for the internal GbE PHYs. PHY 0-7 are used for Port
+      0-7 respectively.
+
+  mdio-external:
+    $ref: /schemas/net/mdio.yaml#
+    unevaluatedProperties: false
+    description:
+      External MDIO bus to access external components. External PHYs for GMACs
+      (Port 8-9) are expected to be connected to the external MDIO bus in
+      vendor's reference design, but that is not a hard limitation from the
+      chip.
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: dsa.yaml#/$defs/ethernet-ports
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
+            reset-gpios = <&tlmm 39 GPIO_ACTIVE_LOW>;
+
+            mdio {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                sw_phy0: phy@0 {
+                    reg = <0x0>;
+                };
+
+                sw_phy1: phy@1 {
+                    reg = <0x1>;
+                };
+
+                sw_phy2: phy@2 {
+                    reg = <0x2>;
+                };
+
+                sw_phy3: phy@3 {
+                    reg = <0x3>;
+                };
+
+                sw_phy4: phy@4 {
+                    reg = <0x4>;
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
+            ethernet-ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                ethernet-port@0 {
+                    reg = <0>;
+                    label = "lan1";
+                    phy-mode = "internal";
+                    phy-handle = <&sw_phy0>;
+                };
+
+                ethernet-port@1 {
+                    reg = <1>;
+                    label = "lan2";
+                    phy-mode = "internal";
+                    phy-handle = <&sw_phy1>;
+                };
+
+                ethernet-port@2 {
+                    reg = <2>;
+                    label = "lan3";
+                    phy-mode = "internal";
+                    phy-handle = <&sw_phy2>;
+                };
+
+                ethernet-port@3 {
+                    reg = <3>;
+                    label = "lan4";
+                    phy-mode = "internal";
+                    phy-handle = <&sw_phy3>;
+                };
+
+                ethernet-port@4 {
+                    reg = <4>;
+                    label = "lan5";
+                    phy-mode = "internal";
+                    phy-handle = <&sw_phy4>;
+                };
+
+                /* CPU port */
+                ethernet-port@8 {
+                    reg = <8>;
+                    phy-mode = "2500base-x";
+                    ethernet = <&eth0>;
+
+                    fixed-link {
+                        speed = <2500>;
+                        full-duplex;
+                    };
+                };
+
+                /* if external phy is connected to a MAC */
+                ethernet-port@9 {
+                    reg = <9>;
+                    label = "wan";
+                    phy-mode = "rgmii-id";
+                    phy-handle = <&phy1>;
+                };
+            };
+        };
+    };
-- 
2.51.0


