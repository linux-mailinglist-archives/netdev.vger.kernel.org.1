Return-Path: <netdev+bounces-176308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8DAA69B15
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 22:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6E5886B37
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 21:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD02C21A44C;
	Wed, 19 Mar 2025 21:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="Vwhhz9km"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54D721577D
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 21:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742420679; cv=none; b=EnS4vAw5SEbjapkT35xy2O8/ErLbZiee+OyoqVWcVuodi+0+j0b+3Ri+yMKT2vlij3pS12rFW6CZLx2unf1nD53BF29ZGCRLzL5H/uMwKBx/QUb2mRq7F/u8hFF5ptf0kOkuitI9jTQ2B37F4cYLi5gvJdit4a8GDLRrb8pLhi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742420679; c=relaxed/simple;
	bh=2bmF5eETK0X62KWDwh10/XSLlS165NQb0nvYGPow2LA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpSjMcdBcvaazQ64WHvylrEgmIEAHL9oimdllQ1XVaPoWq3KrzLIvM4a0XuXrV0cBabT3XrXHEMuJGNZSrURRRLAtbmhAyaz8fpBmdlsjDpSZHerh4+WCmFQxiNKpFsLG/enWr5G6sKyo5hbvmtkyqmZVJACDIrgLxdtTFR/OoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=Vwhhz9km; arc=none smtp.client-ip=121.127.44.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1742420671; bh=go+CvYPHwP2MHqmTP00wWpMhDlSmzW68Q7BuPATSTYo=;
 b=Vwhhz9kmM++zIJIuhvHuU5Hz/0wWh5z9uNNfu8UyhTMl02DoFC1psnjZrZ0I7BKi5zSmfEMse
 BqQNbbaywMe+2hZYhPp61uS+xpnXcay1atmnkvBs8Bml6j9rJw+Zx5z84vE4kQ/oViv9t+D36ea
 dqaRGiGLGKBXfAnCM/nCCvp6EniAYTy4RdZ05Yr37IRmLJL7Gc9Rds3cFgoJNlfXP+IV9y5BE8G
 DeqFcgIc7pVAP+WEROdqsoMGQZySCzmrlxofi9pXz+XoqGUq0q72kd4L2IXVfy51z4q1qA4pXEE
 S94qBqmer7VY/GEf0EFxMea9CRSs1kVlWwAYQZkrhF+w==
X-Forward-Email-ID: 67db3abacf4d592372b993ee
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.59
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
Subject: [PATCH net-next v3 1/5] dt-bindings: net: rockchip-dwmac: Add compatible string for RK3528
Date: Wed, 19 Mar 2025 21:44:05 +0000
Message-ID: <20250319214415.3086027-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319214415.3086027-1-jonas@kwiboo.se>
References: <20250319214415.3086027-1-jonas@kwiboo.se>
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
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
Changes in v3:
- Rebase on latest net-next/main
- Collect r-b tag

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
index 63ee0cc7a8f8..0ac7c4b47d6b 100644
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
@@ -66,7 +68,7 @@ properties:
       - const: eth_wake_irq
 
   clocks:
-    minItems: 5
+    minItems: 4
     maxItems: 8
 
   clock-names:
@@ -140,6 +142,18 @@ allOf:
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
2.49.0


