Return-Path: <netdev+bounces-216256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D911B32CC3
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 02:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47E44483DC4
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 00:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B390419066B;
	Sun, 24 Aug 2025 00:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VADLHejK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E8A18DB1F;
	Sun, 24 Aug 2025 00:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755996817; cv=none; b=OlXNJDC0LAE+HB0nyegQ9eK1TQwJaAjAgs15GMYDGqhYs2SfbXMtr4vaUDUPUzGCnvBNhqUThhsGxZSJtWfL94/k0tUmvEA3wBQKGA7C9A8HTeNJtGy5A3Eexos1dDR5trtK+UJJF/izZwvgkcy5FAvp7l9t1ErKgTa1YmUuc8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755996817; c=relaxed/simple;
	bh=pDhy36uF1Mf3tZZERBq1EkwpFtYy14BGNXa26aAZtFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cr/TOmchWNt5gwqloYO1bKLTYr4GzZTTzRdRZGjVO/yabA8jyINbDz3gl56ebJEt1c6OqgNXLT657DKhogqpudkwA4Z1/4veYmSNgQ19XCYdnn5eeAgdRHtG63FSXx9Nd8lvBd8HKHJVtzCvHBJWLGDuTFcYA1rgJlsQ7CsDWpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VADLHejK; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2468e7c7b30so5628955ad.0;
        Sat, 23 Aug 2025 17:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755996815; x=1756601615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5YnUT2+fxu2YINYTTcsPtuJGnZgxMWuZ/oDjIl3F4Y=;
        b=VADLHejKJHBJVv2CG9P/gl8ZtcWWI4Hu9uf3zuX4xYfD0+mY3JXLUjk/MqV+kuO8ae
         Y94tKZLnP7WQrlswgQ9meOu5W5CykbUZPT8jpq/6wevmug/0WOAImiVl/5KxgTPvkwgA
         LyWe+wcYxF7VwTEmgn15OEDAfSCdCvp4DGp7FDAzk1EJLxxSYyG76yeV1BjSUKH3hMvW
         Pbuao81THoqPDlDOb10Bq3J2qkDvSsqkmuIZJvBiS0XV9D7w3jbE+rVGR/9+Lm+mXONv
         vk674hSaYM55R4tD3PeASvfSlGSNETVLGv52/RoBrKXceJZFShuPomRSYz2xqcKRlpdV
         xxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755996815; x=1756601615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5YnUT2+fxu2YINYTTcsPtuJGnZgxMWuZ/oDjIl3F4Y=;
        b=OwcZXapM8Ou9RG0g2LrBrrvlkvR0pxf8yrbZq82GwyzMgiycB3VPPfsIWo56h3rkrJ
         Rbai2G8PEieV5Z0W8746+uvMOMGgPUyFJfMup2+3uqlQUerAhKDOQKRWJvsLcGthfaOz
         ZxiSAxFHlT7GhiitKMjiWxsWGP89kFRdouO9nS18tQX9g3sMqmEeHhAggc1E1oc1oGyL
         0IbR69rZWnp0bbrZL7sPAl2uNG4dsasRl45h+nyDV0f4VvUwVEGz82Oswf/b2Au1HQii
         ZA3WUde/RALVfEmS7zaf+EzknZateuJZgCi9MUCkk3gLr2NtWQcAK2CCB/k7h0NsB8gi
         QqEg==
X-Forwarded-Encrypted: i=1; AJvYcCVA78psOVNenNEalmGhQ0j0T4ZkWTRj4V5maZ8H0KmZTCcol6AOR7fDDzdhmG8EmK/mgIElTYTrzKlDrZMk@vger.kernel.org, AJvYcCXlqKv0/0rJo0Tqwc9laK7sA1OLNwyJ6MrFxa80ZuGZQXFH9mGAjJKtgAHXU+G65SLxVVOvvNBigUEL@vger.kernel.org
X-Gm-Message-State: AOJu0YwyTJXNMpYKuw2KkMJxFzf7p5AEfGXdlX9gR/OcUUrrsZWuMfDq
	xh8TBhwvrpkQsageb7wUh8Pd19MosWeo45kD2zNA+m0EY+1Ejkxly/CddnRkLAy5
X-Gm-Gg: ASbGncvwHTuE0vKxcOY9NJY3PDXwLf7YsfgkFlobiVKa8RyaGltWnFp2jOooME42+az
	UqYl+UB0ySeU+7ylGTb6awoDQHpoeXqjJJbD2q9SY89QXLmMI2zdK0zdTt9sEbpe/xB9FmMWnNa
	yZmr4ihY5T82enfGsgZXd5a/LazQzsA92XLLYtkdt2aPQUxJhR0yt3cxBBNnuK//iuCiAZiOi/m
	JndiMh9NEidJcioC6DCbytDOx8or478404qghHlvNc1ZmX4vfPzCSAHMxuuwxtKm+VzwMd6ZVbA
	WIB3Gbbfx08d0fPuK7CXN9oSb2kY3+9JqzCRgAMZcSz2J75Y6BYwDbqN1B7BveFDag8d9EGOubE
	0PnXjCzzeuXC3ktkgZaYltlGFINoe2A==
X-Google-Smtp-Source: AGHT+IEUKPOJuqe98Ob+7CdYYcQEMyRiZlhQaEW59PVH9JNdHeNoBLfvWTi2FMpD8zDPVYBsj8FliA==
X-Received: by 2002:a17:902:f685:b0:246:b243:72c5 with SMTP id d9443c01a7336-246b2437608mr5232725ad.37.1755996814927;
        Sat, 23 Aug 2025 17:53:34 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.247.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254af4c38asm3172485a91.17.2025.08.23.17.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 17:53:34 -0700 (PDT)
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
Subject: [PATCH net-next v6 1/3] dt-bindings: net: dsa: yt921x: Add Motorcomm YT921x switch support
Date: Sun, 24 Aug 2025 08:51:09 +0800
Message-ID: <20250824005116.2434998-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250824005116.2434998-1-mmyangfl@gmail.com>
References: <20250824005116.2434998-1-mmyangfl@gmail.com>
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
 .../bindings/net/dsa/motorcomm,yt921x.yaml    | 150 ++++++++++++++++++
 1 file changed, 150 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml

diff --git a/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml b/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
new file mode 100644
index 000000000000..3f625de49910
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
@@ -0,0 +1,150 @@
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


