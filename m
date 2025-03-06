Return-Path: <netdev+bounces-172636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8D8A55975
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 23:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3A0F177B20
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 22:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D39727C859;
	Thu,  6 Mar 2025 22:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="T2jiZYKM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F397327C177
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 22:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741299263; cv=none; b=hSIkJrAR5y34162Yr9+bpwN511Y2EWfsWD6VrZ80Fi7mMfr3iAqY7UCqzGCulluT5nj5ErTxFaMY5/XH1O8kc35srneCwPbiPejjfjYcXZrvMa5W7C/J/ROjmxXmSCiltzhYRhmt4R7sXIotUYx1enRbKmj/pT3CZe3x1YFoaro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741299263; c=relaxed/simple;
	bh=qgXD7sQKiXNNgzjSwcd2sCiSO0BbnuwSHU/7CWTbDAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fg5/bSOMDOAt52clBeugEFx6oL1m5LeQpdeyTpyy8SNpdCRsm4DAuvQenf+v8MuE79epkqPDrqpVyIsDmvjRshLXpBVBjH8BX/bV5ZkiFGWOkX5zWQJM6WEiKw6L+erLnX9qe1EtqIlNsxytNHBW+D7lLEZmQqcnC8dazhxE6q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=T2jiZYKM; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1741299260; bh=djmaXEsM/Omnu4PtvCIeIWrP18OoUBJglDTF0IRvmks=;
 b=T2jiZYKMSVeWsxrstAG4cCwlKk5ihcIG/L3ZnK8BrC/vlo4qDauGkJTLSizOzqwATlT6ynMrg
 +OOb+jj0CeWDJT0uy1HE72WGHndT8cm7dAawYt/4NQunJ7cBoQLbnva2FOfNaGxkzjeHy/2TwFY
 CKZykCTZBdZsxVdpCP/jz0+UfnaQy6RVEBFWHBGf2tnmWxzDhrgG3bGYB6ESFf68g3ICJfx/fig
 kCXgJ1HcbkTEuWmz8PBxcd0Kf+x31TytyVrd+wUolPxMLGk0F70OZZmJRGI+NFtGszT5Us/tqK8
 +US5tfOycVNY1pUupoZvF9ct4DX8GgxnfRsjeYL11Zug==
X-Forward-Email-ID: 67ca1e34c1763851c065bffe
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
Cc: Yao Zi <ziyao@disroot.org>,
	linux-rockchip@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 1/4] dt-bindings: net: rockchip-dwmac: Add compatible string for RK3528
Date: Thu,  6 Mar 2025 22:13:54 +0000
Message-ID: <20250306221402.1704196-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306221402.1704196-1-jonas@kwiboo.se>
References: <20250306221402.1704196-1-jonas@kwiboo.se>
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
I was not able to restrict the minItems change to only apply to the new
compatible, please advise on how to properly restrict the minItems
change if needed.

Also, because snps,dwmac-4.20a is already listed in snps,dwmac.yaml
adding the rockchip,rk3528-gmac compatible did not seem necessary.
---
 Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
index 05a5605f1b51..3c25b49bd78e 100644
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
-- 
2.48.1


