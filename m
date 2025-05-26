Return-Path: <netdev+bounces-193494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F85AC43BE
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 20:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 892A93BB462
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 18:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6904241682;
	Mon, 26 May 2025 18:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9haN8Cm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C69241131;
	Mon, 26 May 2025 18:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748284218; cv=none; b=mhS8gdog+BLBs8oKbZoSaxV7SevmHbEGH+Bk0Kl3kVCvXLDRNjH/y62jn5ZH+xIUKVNbxcroQ5Ja0Wa829YyqwvM4OyUjf+egeE2z40t/CL8IQJggei7nNl55NMJXE4ZBMjL8mwVuwnBCr910Em3E2t0FXGGfI2yr5azWTYS5EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748284218; c=relaxed/simple;
	bh=Xp7PQEwsXr/t3weISbAl8pNnnIKTP2opDnVGAv6TSHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XrWySvY5YwFPBMNz+0ri6Z0UoghjQSWKEO/onvRDE6jzXU3nfczDox0LPo42K3/Y0aK3YaewlrBnFN4rgq+VNOJzmPkZCV3QiNeD/Kanb2pZxQXdChmPqDL1QTFj7aQswd+kwMeOuHhHi7SD44Mz8ZudMiV5p1tOmj/gCIWBdAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9haN8Cm; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-86a052d7897so183351739f.0;
        Mon, 26 May 2025 11:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748284216; x=1748889016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULjqis0u87KSpipZTk1NBKJD257/ZcSGIbJ8awB7PCg=;
        b=Z9haN8CmhB3MWdtmttZi9kUAc2rFlL4rTlZjiJfaN2ewuvcuhQmBVVeQImu4l3oSUu
         k6IoAKuth0zSywV6KhcRsuXgnEAcL4Yj0Shf4Odo6t3j+4ZlSrfNA6CC2ISeP4wC7KNq
         gkFTnF7vaM5HMSGr1x63mo0b3xteD8MZX24DFvBgJebgxPp/QLc4fHaq6d/61yrQv3vZ
         CZKqrM7585TiLOnUoLVoCQMWAvLvJ5FouuN9DzmWDjCF+xSXy5kT1Hf3Kiq3Qm5z9jpD
         xCrGOE6WTV3hr+R5rcqo5EA5nj0oxpZ6RVO1gbiIC6OuJ9awKqQPPIoVPBKSjI/YI9x5
         uj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748284216; x=1748889016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ULjqis0u87KSpipZTk1NBKJD257/ZcSGIbJ8awB7PCg=;
        b=rqWuMttxuQC8UwmD3lnEzLDFSOiINDSGvKOzPrVyx+1DRVNq4RX1dwY9OBIbC4zmkX
         o3Y4xFyxIgDRalhkaLf7okQCQ7mmbHxSt6MeqZhFzimCBnRM8/VesiYgKHkoE8VGHMSN
         LYDUQZ6/GD5+cKiXKEabVcEsq5f7c4+8Cxax6tlxTYogjZOsTm2lI/71RqRIVkMFp10q
         4SDeH6bgNnCyos5VtCf4bchfamlUhMpXneMA5bskwrZ3ms9dZa7d5nfYmPFQBHV4A7dz
         gYJvXFKwLu7p30Q/4RgAgLj3gXjz+PW6tESFRjhnJt+uTs1idtHJW2OEvtH9jywhjO/o
         FRhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvVli7hI+5HLDJ6Y6TpRTTqGmxJXNkZu8j+YEuUiKIOrbRllL0KWaDxQbeoKaPNRZ5EkaxCo8K5+P+@vger.kernel.org, AJvYcCWuZyMDeanRIMmEoxc7TJ0QWm4i7CzOSd7xwEJCRvsgNYCjF+b+nYfaEJ/lJrd5AOBqErP+bIBI5B4sjmwP@vger.kernel.org
X-Gm-Message-State: AOJu0YyAZy2tVk4eyc2I6bGLX2v6ZYZhu8Z5tQgweJrqyex+XfhhQg5u
	55ryGP7WcUBvcBhiOqhmMlSYBVnrdYwB+pH6pB+/YQzxOkYWpgI6AsKiDDW/OxP8zAw=
X-Gm-Gg: ASbGncvMOLP8/JmgO/gFNl3yt3x1J2PEhqCK3nLwHcqFpaXy5fK1oiWvyyHm7/gCE7Q
	zaAKgJSY8+lbYGK20op6XNkxDtGSSsulf1fBmNOjxGjyvCZBRVuTJ/IWVoUqTF1KeYL5NrevJpf
	Z5HaM6CNnd9EnbL6iT6obStGJ1FqBw94nDGv0vOkSKgk46RZcJukxEYlofoD25wc9Uk+VspceH6
	huw1ap5hlLVeD9jWhE8fpZ8bT4iwu7n8CTurEvDPTbr1pxPM5iIcIm+jP/g7yfhbj6oTAq/LWkC
	oVdR2JFE0jduJRAaiP99kPV0L5avxcNyiPKJRR38sjSjeAl9UYThLcxBtERXgBAernvM5VoLAMe
	QokfuZc1YzsEscKjLU85m0pRyPnwe/g==
X-Google-Smtp-Source: AGHT+IHNnI4y1dgkj56msBwfJyexQj/NA4bKNpsudos+JvpD2sSrSNG4qTOxJTKBL54sr41hgUQMyw==
X-Received: by 2002:a05:6602:4a0d:b0:86a:25d5:2dbe with SMTP id ca18e2360f4ac-86cbb7dcffamr1231342039f.4.1748284215957;
        Mon, 26 May 2025 11:30:15 -0700 (PDT)
Received: from james-x399.localdomain (97-118-146-220.hlrn.qwest.net. [97.118.146.220])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-86a235bff69sm477028639f.8.2025.05.26.11.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 11:30:15 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-sunxi@lists.linux.dev,
	James Hilliard <james.hilliard1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] dt-bindings: net: sun8i-emac: Add AC300 EMAC1 nvmem phy selection
Date: Mon, 26 May 2025 12:29:36 -0600
Message-Id: <20250526182939.2593553-3-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250526182939.2593553-1-james.hilliard1@gmail.com>
References: <20250526182939.2593553-1-james.hilliard1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Allwinner H616 EMAC1 can be connected to an on-die AC200 or AC300
PHY depending upon the silicon variant.

Add a new allwinner,sun50i-h616-emac1 compatible and example, support
for the allwinner,sun50i-h616-emac1 will be added later on.

Add nvmem-cells and nvmem-cell-names properties for the ac300 efuse
based phy selection.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 .../net/allwinner,sun8i-a83t-emac.yaml        | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
index 7fe0352dff0f..b6bf1718dba1 100644
--- a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
+++ b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
@@ -18,6 +18,7 @@ properties:
       - const: allwinner,sun8i-r40-gmac
       - const: allwinner,sun8i-v3s-emac
       - const: allwinner,sun50i-a64-emac
+      - const: allwinner,sun50i-h616-emac1
       - items:
           - enum:
               - allwinner,sun20i-d1-emac
@@ -28,6 +29,14 @@ properties:
   reg:
     maxItems: 1
 
+  nvmem-cells:
+    maxItems: 1
+    description: NVMEM cell with the ac300 efuse.
+
+  nvmem-cell-names:
+    items:
+      - const: ac300
+
   interrupts:
     maxItems: 1
 
@@ -321,4 +330,37 @@ examples:
         };
     };
 
+  - |
+    ethernet@5030000 {
+        compatible = "allwinner,sun50i-h616-emac1";
+        reg = <0x05030000 0x10000>;
+        interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "macirq";
+        resets = <&ccu RST_BUS_EMAC1>;
+        reset-names = "stmmaceth";
+        clocks = <&ccu CLK_BUS_EMAC1>;
+        clock-names = "stmmaceth";
+        phys = <&ac200_rmii_phy>, <&ac300_rmii_phy>;
+        phy-names = "ac200", "ac300";
+        phy-mode = "rgmii";
+        nvmem-cells = <&ephy_acx00>;
+        nvmem-cell-names = "ac300";
+
+        mdio {
+            compatible = "snps,dwmac-mdio";
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            ac300_rmii_phy: ac300-ethernet-phy@0 {
+              compatible = "ethernet-phy-ieee802.3-c22";
+              reg = <0>;
+            };
+
+            ac200_rmii_phy: ac200-ethernet-phy@1 {
+              compatible = "ethernet-phy-ieee802.3-c22";
+              reg = <1>;
+            };
+        };
+    };
+
 ...
-- 
2.34.1


