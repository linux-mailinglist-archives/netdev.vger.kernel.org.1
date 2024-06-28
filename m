Return-Path: <netdev+bounces-107730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D975191C2DC
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 17:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E07A2817CC
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 15:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817D81BF329;
	Fri, 28 Jun 2024 15:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXjZRA2Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B616B1DFFB;
	Fri, 28 Jun 2024 15:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719589528; cv=none; b=pSS3J5UgmZ4K8brPWBXMxYNkQn4UHOIxU5NLOzR1H/4wY7DR3g//ePr6ITSkSvOvIuWBWltYD+xCy1ZYK7c1QI3PJ4u14IVCXuYq9YbdGkT/8ZlXrtZyWTMrD/p0OX5Qd5jr2JVunB6c7WuiRXJ4FlHDqVW7a0DsjGQluitbZvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719589528; c=relaxed/simple;
	bh=S+sJWHqWZoXrfvBmxSaHrYo7Br+7IHD8kAPP9u3CkTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IEtn0ZqevSYow8TYbSLbjSdML64Bm2eb1FWyvcDc158y7A8V03B2+cvXLahHjR2Jrc5PU2jMYjZkmMl+wPtcYpCnwbMkOdoBP64yJ8BBPrgZWHEBpguOb6sgmLZJtJ0nnMugvOjHt5JRDj2xzu13j+2KwJyFovtSYnsAmoNrNjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXjZRA2Z; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52cdb0d816bso779316e87.1;
        Fri, 28 Jun 2024 08:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719589525; x=1720194325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C5jYmtDyMsBks9HOK7YKwsTxAghw5ezyRltrHdspFHU=;
        b=QXjZRA2ZOYkmSFFnqJkGzCX2T61TtM4O4PqsggzxaDmz0s6CNmp6KTZadCLCyREYye
         TKyQJA4+0lZ4jPgvJC0/SALoEIJpSFElSBgQ1heWX+ok6renvl8P9W9vIELv4aYcIBeY
         m3AN1lyL/sF6fBhSGxog+vPTdIxBPbwXa2y4iO7kNg3StrcnMVwIDhJ6DJBOT6WrJAM/
         YiD1mCrx4L9iVZojzzW4QiEpOK6dX7sxhQJWmGGx+vPthSrEhJSFv4xs64vgCZUpTCyg
         GfAscoa8BRsTzJdDyMsZmgA1UItW5osI8cwSjpPB4olPdjVxv3pwrDemHlgYXwhOVnqL
         Ky1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719589525; x=1720194325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C5jYmtDyMsBks9HOK7YKwsTxAghw5ezyRltrHdspFHU=;
        b=rDIjAqnj9WyhWb/GeVdsHndajC7rm1gFWywyxgmmoSSoqJWaw+rtv5RYTvkkcYH3Qh
         AD/89ihWQR9QtvWrf8H9/uoNsulGeoi2FfEm9vkHlFnAHxamBOErGyHNTd/6jhZ4mGMg
         t1kJfcBNMKvwftGaw7UUZwp8NNQAZYS5icV8ZVAkT9iqifdlgW1BwALDGiG2NY40hh5I
         Av/na3VGId+komUrOBZn+SrqUahsmhkfOj5TS7rXalPVzLfRuhLbGkJ6v39tmXgV8Xpp
         ZLOfK2RjpDSeLQTpnLuWfC3pUxNRPKKhWnag3sG/+vvn6qrX/77XR6sCxMEuXDds5hhc
         A05A==
X-Forwarded-Encrypted: i=1; AJvYcCVqwzx5ltqZrpNqQtiBVyYVlPVfjNtv1gQfhZtuHET3RMXr4hUcmB3dvJI0RDxDy9wogP/ISAf3SPD2H7UBcjWaK24+n40sY7A7wOCIt+X9PWKBwmeQrE3upPZZFCs5SlCUOQhFhF7qkw==
X-Gm-Message-State: AOJu0Ywh35ENDvuPlxGL2RCCKnUjVomBVo6k1LwLRZNUWXQP/u7Td0/r
	yp+UkySHQvkUVE/orJRymT2xJpSKeuDHuf5M7ksTl66qXhq+4TKS
X-Google-Smtp-Source: AGHT+IFq7AQRfYM2GxU9KBwkSxdM7k+i3cYB+sSVbzdWG1Jpk+aL9Bk0vGy+BNtba4DsenjFUxqcmw==
X-Received: by 2002:a05:6512:e9f:b0:52c:df96:1726 with SMTP id 2adb3069b0e04-52e7b8e033bmr898324e87.1.1719589524518;
        Fri, 28 Jun 2024 08:45:24 -0700 (PDT)
Received: from localhost ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab27776sm304605e87.169.2024.06.28.08.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 08:45:24 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] dt-bindings: net: dwmac: Validate PBL for all IP-cores
Date: Fri, 28 Jun 2024 18:45:12 +0300
Message-ID: <20240628154515.8783-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Indeed the maximum DMA burst length can be programmed not only for DW
xGMACs, Allwinner EMACs and Spear SoC GMAC, but in accordance with
[1, 2, 3] for Generic DW *MAC IP-cores. Moreover the STMMAC driver parses
the property and then apply the configuration for all supported DW MAC
devices. All of that makes the property being available for all IP-cores
the bindings supports. Let's make sure the PBL-related properties are
validated for all of them by the common DW *MAC DT schema.

[1] DesignWare Cores Ethernet MAC Universal Databook, Revision 3.73a,
    October 2013, p.378.

[2] DesignWare Cores Ethernet Quality-of-Service Databook, Revision 5.10a,
    December 2017, p.1223.

[3] DesignWare Cores XGMAC - 10G Ethernet MAC Databook, Revision 2.11a,
    September 2015, p.469-473.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

The discussion where we agreed to submit this change:
Link: https://lore.kernel.org/netdev/20240625215442.190557-2-robh@kernel.org

---
 .../devicetree/bindings/net/snps,dwmac.yaml   | 80 ++++++-------------
 1 file changed, 26 insertions(+), 54 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 5a39d931e429..509086b76211 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -447,6 +447,32 @@ properties:
     description:
       Use Address-Aligned Beats
 
+  snps,pbl:
+    description:
+      Programmable Burst Length (tx and rx)
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 4, 8, 16, 32]
+
+  snps,txpbl:
+    description:
+      Tx Programmable Burst Length. If set, DMA tx will use this
+      value rather than snps,pbl.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 4, 8, 16, 32]
+
+  snps,rxpbl:
+    description:
+      Rx Programmable Burst Length. If set, DMA rx will use this
+      value rather than snps,pbl.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 4, 8, 16, 32]
+
+  snps,no-pbl-x8:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Don\'t multiply the pbl/txpbl/rxpbl values by 8. For core
+      rev < 3.50, don\'t multiply the values by 4.
+
   snps,fixed-burst:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
@@ -577,60 +603,6 @@ dependencies:
 
 allOf:
   - $ref: ethernet-controller.yaml#
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - allwinner,sun7i-a20-gmac
-              - allwinner,sun8i-a83t-emac
-              - allwinner,sun8i-h3-emac
-              - allwinner,sun8i-r40-gmac
-              - allwinner,sun8i-v3s-emac
-              - allwinner,sun50i-a64-emac
-              - ingenic,jz4775-mac
-              - ingenic,x1000-mac
-              - ingenic,x1600-mac
-              - ingenic,x1830-mac
-              - ingenic,x2000-mac
-              - qcom,sa8775p-ethqos
-              - qcom,sc8280xp-ethqos
-              - snps,dwmac-3.50a
-              - snps,dwmac-4.10a
-              - snps,dwmac-4.20a
-              - snps,dwmac-5.20
-              - snps,dwxgmac
-              - snps,dwxgmac-2.10
-              - st,spear600-gmac
-
-    then:
-      properties:
-        snps,pbl:
-          description:
-            Programmable Burst Length (tx and rx)
-          $ref: /schemas/types.yaml#/definitions/uint32
-          enum: [1, 2, 4, 8, 16, 32]
-
-        snps,txpbl:
-          description:
-            Tx Programmable Burst Length. If set, DMA tx will use this
-            value rather than snps,pbl.
-          $ref: /schemas/types.yaml#/definitions/uint32
-          enum: [1, 2, 4, 8, 16, 32]
-
-        snps,rxpbl:
-          description:
-            Rx Programmable Burst Length. If set, DMA rx will use this
-            value rather than snps,pbl.
-          $ref: /schemas/types.yaml#/definitions/uint32
-          enum: [1, 2, 4, 8, 16, 32]
-
-        snps,no-pbl-x8:
-          $ref: /schemas/types.yaml#/definitions/flag
-          description:
-            Don\'t multiply the pbl/txpbl/rxpbl values by 8. For core
-            rev < 3.50, don\'t multiply the values by 4.
-
   - if:
       properties:
         compatible:
-- 
2.43.0


