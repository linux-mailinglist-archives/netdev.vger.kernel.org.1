Return-Path: <netdev+bounces-172609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5178A55863
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 22:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D2CA3A9515
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 21:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D98276046;
	Thu,  6 Mar 2025 21:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="zdvLcJx8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F0926FDBF
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 21:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741295408; cv=none; b=uOMXPsyWfFa+Kewl2QmEoA/92r+FhnwaKMiRFnxaAZBnBiCUrLq4kr8C0a5svkgjzZDpG1RcVY2xOGaHi6QA+Hoo5qTrH8Nb2QzrDzU3zqL8Aq91UO29XRLoyzQXXOnE2da1jDYVWxWwIoJDYTA6oZjHlqWiNE8LoAUiH7iU7+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741295408; c=relaxed/simple;
	bh=PZ5qH9yvGt5eTfj8OElDpoP9yqBuUcoT9cDMPNjfalc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KmzbC/jd0/3wyQnsqKA7ZtHnPyd7H39ucWBDscWk2UawiQI3CnV/CsWK/ZDK7LX9O9ojxvqyxexQzkgiX0AEVwHCUerOxh8ucZv5m6AnWViu7ijGx7cu3F0VNrbVuXexZ7R7G3m0C8+LhQ5a0v/+iSlY2w7CDsdO+pqVvGMC5eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=zdvLcJx8; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1741295406; bh=6VW3CJR3YgKXxnut+qsI9aD1jITQWnOV71qJ1GMseJA=;
 b=zdvLcJx8xtLTfH3IaXN+5wRmMaMaxjaq/HRLWPQVqI2Ns0y3acLE8ok2mTRMe/uoGV8IeM8fa
 iu7C/uya8GsGrik7K8PqYAVCK9vbcX2wCwiTI/8xSgjLthZKavmTYF3AL+tIh3RLl45PXw+gxs/
 CEz2bFhh6g2XQb0SugfBdUr1d02cvdjJScjIsDIzsUByerqiWG8x1XiHZAc9+R2ZAPnJSaWm88s
 t0e5jTkU0O+y/CQ3eDYVBInuAnf5EnrBW7IdDvhDsx4yxDhc4LSwl7SLUfAHuaBPFdtPOF4vfW9
 yZXQPv3b2o3eKteGp15l0g+vL3eejQmIm1MVhfrDXqyA==
X-Forward-Email-ID: 67ca0f28ad3e70e1cd99d807
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
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
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 1/2] dt-bindings: net: rockchip-dwmac: Require rockchip,grf and rockchip,php-grf
Date: Thu,  6 Mar 2025 21:09:45 +0000
Message-ID: <20250306210950.1686713-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306210950.1686713-1-jonas@kwiboo.se>
References: <20250306210950.1686713-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All Rockchip GMAC variants require writing to GRF to configure e.g.
interface mode and MAC rx/tx delay.

Change binding to require rockchip,grf and rockchip,php-grf to reflect
that GRF (and PHP-GRF for RK3576/RK3588) control part of GMAC.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
---
 .../devicetree/bindings/net/rockchip-dwmac.yaml | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
index f8a576611d6c..05a5605f1b51 100644
--- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
@@ -32,9 +32,6 @@ select:
   required:
     - compatible
 
-allOf:
-  - $ref: snps,dwmac.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -114,6 +111,20 @@ required:
   - compatible
   - clocks
   - clock-names
+  - rockchip,grf
+
+allOf:
+  - $ref: snps,dwmac.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rockchip,rk3576-gmac
+              - rockchip,rk3588-gmac
+    then:
+      required:
+        - rockchip,php-grf
 
 unevaluatedProperties: false
 
-- 
2.48.1


