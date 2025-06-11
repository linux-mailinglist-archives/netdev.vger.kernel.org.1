Return-Path: <netdev+bounces-196443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7499AD4DCE
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 10:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55BD57A9236
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 08:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B50238144;
	Wed, 11 Jun 2025 08:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2l8BlPN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D0B2367B2;
	Wed, 11 Jun 2025 08:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749629034; cv=none; b=mbws1tYx8filsZgxQKryAhfowxi2VCxmfosl1MCL+ZS4NlnPnpd8a5O2tPJFzfSQDjp4ySLfMu/LOMqZAPLv/+sBt6C4tdmcWDBaBUWjUToiizGKfHfLCkDbM799/XAfJIzRon61mP+qkdr7db76bd0NZ0WF/20mU8KWeBq7ZI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749629034; c=relaxed/simple;
	bh=aVABoyFzwx85oLCM7K97SuAwDlDMkxU4RoMkLM63GJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lq2bXKXtgjSNm8cToW83UEKQqzucq3qhJL0BniyXNFjPORcghYrW+VDhoYz6nK1FvDZI8+9myeukKqWF04bbtYOhEULCL7+ybiFRhCIQsa6iuKrsykPyWnEtbdIE7LF7x5jO6RdpsN4EbST3ARwWCu4eZVAXz0sBWjGvWTHH3Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2l8BlPN; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6f0ad744811so44641746d6.1;
        Wed, 11 Jun 2025 01:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749629031; x=1750233831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDPKzl/HokW1bKViSHJhhALGLh7FDXnYOeKnzw1e8Ss=;
        b=h2l8BlPNhGQ7XCvhH4bXOM5SHJJ3OrN+W164p/StsJeYyPCTWvbnTMSbzVFYoQxikh
         VQ7lorYnak17DT+rAO/ft1MBWsJL9twEtgJ6nL8GZJnNZb3D0r2WdUXaQp70t9xpVGp/
         ejwscssHu8GRNFuEqZpYvRRyjTThYSHG71a+xJRkBk9bwmJiGsYo+2T8T1+9A2ictK+4
         2pREfKV4AuihjcJ/KyRo0j2qEC5m5ejq7Coz+FJhXGvgec7ZU6wlFWqKcq4R4sVGqVX2
         nDnQnPCOiyyJ4sOa49MazTxTi7I9WMihsIYmKAWJc6GVxVl8Uj1aFkaxhqcM0eo05Zds
         /GOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749629031; x=1750233831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kDPKzl/HokW1bKViSHJhhALGLh7FDXnYOeKnzw1e8Ss=;
        b=oYzyuj7r9k/+WNITA3m5Tiwl8ApBuxaPP8jj9GYd4xNDNoFxLfzGItMsHw9PKjJM7n
         WuBU8ZJUuAvokcsWOH1vcD4kQffe/vA83rRLRolIafXby8nouO+d1U0InPWLRe96Fd7I
         7cLYJugK2sbRUofZAnvfuQd/4i819tVv3HXHG4o+DI11KMdOL/mePfpCJHg36Z+pIysC
         y10jrSowARbPlTMnJ62H00aQU27DPML4s3KHbtOZ7o+IfPBK1vcK8k3HQ01qNK/D0yww
         r+JEEMwWBPJaOEbKiG7DOd0nOAt1rYOkdNZHQaWX21ccRzHWLgpX2NY8XPJ4Q1WV08Jm
         VR/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9jQCusju2g/RTf/YLY8U9sqttyFkMg5JdC+8A+tMCG5eCz0G3A8H45Rz2xUjxbUP/WPCnKEBhtr80@vger.kernel.org, AJvYcCWHH3GmOS4fG9z8Q6LEJaO1ffJ7jClb1f3k3QOFodK59pVFSANQaErDau7I3kmCHCLDGfb+mZIWpOQFrYFh@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt0JP/N9v/UWynPkPtEiyb23k0j0RIvRhkagAdNed/gxPEff9P
	U0+Mj0nhPTCUyK1uNx5MjGM9+dgxbOgzvlIqcqZPUilQ1m9Vdf2C4I3A
X-Gm-Gg: ASbGnctRUnNtRs/ciT2jqWKPUphm0y2SUITd00zuuyzBy98PIMYHe4MKiqBRSGJf7E9
	uT3rnBgYn/VHWAA8zlXmJthjPTzxZgzSlMSCoaB1sOVaBS9YiGYgLV6TIpnF8MCP5nTIdgw8hcX
	DeQToSCc8IclyiqOnmSeE8ZWK5l+FRL2HULGBaf6/MKSCSoLHG/jcWQhYYGXh3+az8xK6iMqSqV
	sk8zhF0c1giP9w150QeLc6Bzp/QSOkI8dNw1C1rF08zDlX0hmJ4p+GzlNJcKEojWQ/1qcW6clkT
	M9+R+jXz0s1VNG/HbYtN725PBjni+qp6DCGsFA==
X-Google-Smtp-Source: AGHT+IGmp+EzAiX+KAE1F9bGl2MqzBQoWq5zi9NmJE6sYIlDWxZBH2JCYpju3CBjIhOcLVFq1e+owQ==
X-Received: by 2002:ad4:5cab:0:b0:6fa:c46c:6fa6 with SMTP id 6a1803df08f44-6fb2c32a9bcmr35065916d6.12.1749629031132;
        Wed, 11 Jun 2025 01:03:51 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6fb09b1ce86sm79639716d6.61.2025.06.11.01.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 01:03:50 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next 1/2] dt-bindings: net: Add Sophgo CV1800 MDIO multiplexer
Date: Wed, 11 Jun 2025 16:01:59 +0800
Message-ID: <20250611080228.1166090-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611080228.1166090-1-inochiama@gmail.com>
References: <20250611080228.1166090-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Sophgo CV1800 uses an internal MDIO bus multiplexer to handle the
internal phy and external phy. The internal phy is always on MDIO bus
address 0, and the external bus can be configured with different MDIO
address.

Add documentation and compatible string for the MDIO multiplexer on
CV1800 Series SoC.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 .../bindings/net/sophgo,cv1800b-mdio-mux.yaml | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/sophgo,cv1800b-mdio-mux.yaml

diff --git a/Documentation/devicetree/bindings/net/sophgo,cv1800b-mdio-mux.yaml b/Documentation/devicetree/bindings/net/sophgo,cv1800b-mdio-mux.yaml
new file mode 100644
index 000000000000..abe0004c8b6e
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/sophgo,cv1800b-mdio-mux.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/sophgo,cv1800b-mdio-mux.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo CV1800B MDIO bus multiplexer
+
+maintainers:
+  - Inochi Amaoto <inochiama@gmail.com>
+
+description:
+  This MDIO bus multiplexer defines buses that could be internal as well as
+  external to SoCs. The external mdio bus can be configured at different
+  bus address.
+
+allOf:
+  - $ref: mdio-mux.yaml#
+
+properties:
+  compatible:
+    const: sophgo,cv1800b-mdio-mux
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mdio@3009000 {
+      compatible = "sophgo,cv1800b-mdio-mux";
+      reg = <0x3009000 0x1000>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+      mdio-parent-bus = <&gmac0_mdio>;
+
+      mdio@0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        reg = <0>;
+      };
+    };
-- 
2.49.0


