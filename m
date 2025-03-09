Return-Path: <netdev+bounces-173385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 175C5A5893A
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 00:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A70573AC7DD
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 23:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8625B221DA3;
	Sun,  9 Mar 2025 23:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="OEGpUbzl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA5622172A
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 23:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741562803; cv=none; b=cdE9HAxFTUq8xiMbibBiFHvmgE1SxQYfY9RUV0s7nj4pqimqUAZU/zfGC4kvzeyEHT2DQldMiB0WeWKYYfXTla9GpCCdkLOfwIb5f4ASF0+2Dpv6vvH3DILBlZQxQdBhSaIaqaLd9KNCxSHtnBX9kgGL3B2syySr5lXyZ68Sg+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741562803; c=relaxed/simple;
	bh=QgHqKYOvWVyGVZtvyCcc5NYc2fqYBSJeW421CpGLeBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Op7iDcCJnZv2YsJb0knR5dCDWg2CnWQIszU2nJ5NJCiJyNZWA2IVJjz9E7F8HK1IcLnQHtHLibNFXABBY8nLW+jt4KYoJ+0BHDhGjDzpSGGae12okNaUOva8zJYH/tbz9uP3vUAHsECIcC2O4EpnRI4NQb4Btj6doa3tT51iK6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=OEGpUbzl; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1741562794; bh=Fvsg997oISgjqp0W2TJFAP7RLXkppIq9T5s0bg5qC1I=;
 b=OEGpUbzlAPbIt1v7Clq3rawB4Wj464AhskZ39BxSJgIA7gvi/+bbsZidn1njpdz6t+jWwMRTc
 L5/HGvLEfsA6F3Y5UBWZjc/ysX8IHMrMPnz6OzaLtkhsm4AN78wHubmdCOH6GarZsYq8H043IDe
 iDGAiYqwjVLB7IJBDOYAm/NWTNmIfegeLWMRcyI3KdSnVnwfTgj9IiTYwn9FDi9zUyAx/cY+XBQ
 SNohx5YJZriLX/u0B21fk+y/drdmyHwPkT8VpjE4MRec8L1dMRz+d5Xdc8L2fB6kDjzNl9OzpG6
 Yd4YppQkz9X0KrqjqDtMRM5+tUbhCsy+B5qhDNYCsMWA==
X-Forward-Email-ID: 67ce23a95209992d7c670e6e
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Wu <david.wu@rock-chips.com>
Cc: Yao Zi <ziyao@disroot.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 1/5] dt-bindings: net: rockchip-dwmac: Add compatible string for RK3528
Date: Sun,  9 Mar 2025 23:26:11 +0000
Message-ID: <20250309232622.1498084-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309232622.1498084-1-jonas@kwiboo.se>
References: <20250309232622.1498084-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rockchip RK3528 has two Ethernet controllers based on Synopsys DWC
Ethernet QoS IP.

Add compatible string for the RK3528 variant.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v2:
- Restrict the minItems: 4 change to rockchip,rk3528-gmac

The enum will be extended in a future patch, Pending RK3562 and a future
RK3506 variant also only have 4 clocks.

Because snps,dwmac-4.20a is already listed in snps,dwmac.yaml adding the
rockchip,rk3528-gmac compatible did not seem necessary.
---
 .../devicetree/bindings/net/rockchip-dwmac.yaml  | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
index 8dd870f0214d..fe417c19b597 100644
--- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
@@ -24,6 +24,7 @@ select:
           - rockchip,rk3366-gmac
           - rockchip,rk3368-gmac
           - rockchip,rk3399-gmac
+          - rockchip,rk3528-gmac
           - rockchip,rk3568-gmac
           - rockchip,rk3576-gmac
           - rockchip,rk3588-gmac
@@ -49,6 +50,7 @@ properties:
               - rockchip,rv1108-gmac
       - items:
           - enum:
+              - rockchip,rk3528-gmac
               - rockchip,rk3568-gmac
               - rockchip,rk3576-gmac
               - rockchip,rk3588-gmac
@@ -56,7 +58,7 @@ properties:
           - const: snps,dwmac-4.20a
 
   clocks:
-    minItems: 5
+    minItems: 4
     maxItems: 8
 
   clock-names:
@@ -130,6 +132,18 @@ allOf:
       properties:
         rockchip,php-grf: false
 
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - rockchip,rk3528-gmac
+    then:
+      properties:
+        clocks:
+          minItems: 5
+
 unevaluatedProperties: false
 
 examples:
-- 
2.48.1


