Return-Path: <netdev+bounces-243650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2D1CA4BA6
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 18:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 041743001573
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 17:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0927F2EF677;
	Thu,  4 Dec 2025 17:15:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from 18.mo550.mail-out.ovh.net (18.mo550.mail-out.ovh.net [46.105.35.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A336229C321
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.35.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764868509; cv=none; b=Dl3Q5Jztj6pPiIDsZ5MBhwathVQLWpXYzGb5OaIDyyVGcu11HXhzErdDAzt2JTTb2E8cv5FBkGpoOhy7NDOhGLhYXXe9Nm1c8KlG0KgZXcGuxzBlfPcRTq7hv2fROZBIo3+TcOETSb+5uiTCJ6pXItmsGcBoY3uMsA03wvgWtvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764868509; c=relaxed/simple;
	bh=YgsFnZuDSq0GL2hrNLtRnqJd46AcXwGsEsQYq7gDQkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=crqss2yn5w1p9IoveQQQ62abJTJH5JkGRew98XzbQ0irWE4C3UpG37wZTT8N1HWF5Yght76vcLsWCfKdRE9VHACpk1qHOoekqbX8rZdk18XRLufXpo0OYArBZbsCYFlunUvS9pqaY3rZRyhWFn+B52SbAKNryuX6mAZX02mcEzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bp.renesas.com; spf=fail smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=46.105.35.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=bp.renesas.com
Received: from director10.ghost.mail-out.ovh.net (unknown [10.110.37.167])
	by mo550.mail-out.ovh.net (Postfix) with ESMTP id 4dMgDY1zwzz6WTT
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 16:38:21 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-m4nfg (unknown [10.111.174.111])
	by director10.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 04E91C0F78;
	Thu,  4 Dec 2025 16:38:18 +0000 (UTC)
Received: from labcsmart.com ([37.59.142.114])
	by ghost-submission-7d8d68f679-m4nfg with ESMTPSA
	id naCeNve4MWmh+AYArq+dVg:T3
	(envelope-from <john.madieu.xa@bp.renesas.com>); Thu, 04 Dec 2025 16:38:18 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-114S008793e570e-a212-4f79-af68-c8066b7fc938,
                    E90FA267686E4F2ED65044873A5FD8D85CF2A6B0) smtp.auth=john.madieu@labcsmart.com
X-OVh-ClientIp:141.94.163.193
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be
Cc: biju.das.jz@bp.renesas.com,
	claudiu.beznea@tuxon.dev,
	linux@armlinux.org.uk,
	magnus.damm@gmail.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [PATCH net-next 2/3] dt-bindings: net: renesas-gbeth: Add port-id property
Date: Thu,  4 Dec 2025 16:37:28 +0000
Message-Id: <20251204163729.3036329-3-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251204163729.3036329-1-john.madieu.xa@bp.renesas.com>
References: <20251204163729.3036329-1-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13329247523704702341
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTEu+nYVGdKAM5Z4fRCahVsKa2293LslcWxb1bPv0VwvKAw4M2lzxFwSiYWyoi8P91kaARVtqRb0TEZugqk151vG6gIa0T8/eMLyQlgXgekuNCovF3oUZXA+1rwXo63BkqJASKkP5gU8IoA87wcA/TO0Ph+fl/DQpe69I3zCmGsjyVbncOpBygjWz8/Yy7gMkNUFW8dDXP8zvg68QKUY6qwmiiy37NULBWsnm3XricYEgaSBjtLZmBDTkXW6nxmK8G0J4ei9hx77c7C+ADH2hdZ/e74/zgW2UTxkZiq5jopASfj1bfSDjAZfY4mQzOW2NNYEGlMaSoN0BD7KB3j9+Yx8GE8zVZP6pFQfZLx+koU74jQOfx1yJBvLbSymvZ4wXLd9oNiOe9TSs+BJ+dgcMcJK1kL6jYPQRl9LWtN2nBRLIygYd8mElHWeKarWkP2XEMPZG8foFpDLOpQnh0u5+c7oCySo9eVOtxOyYJa3RpEYGbdvgh49Snk/Hj2eqGb3faleAJs8TaOyQPwzdzZ5DY2y6o33mSgk0HowwP42CjWNlFd3XInen29yBKU/g5CMyJukvizAzoTZEnCRis9zeNxf44vtGFk1qJ2hShhlwGGelby//PwcX/fmXS8nuez0hsqiBn+oZ2eCImgqGy/+BpWMt+ZyXk1oOIeBYQ16QwMbQw

Add optional port-id property to identify ethernet ports on RZ/V2H
SoCs. The hardware doesn't provide unique identification registers
for multiple ethernet instances, so this property allows explicit
port identification from the device tree.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 .../bindings/net/renesas,rzv2h-gbeth.yaml     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml b/Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml
index bd53ab300f500..bb59c6a925d3f 100644
--- a/Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml
+++ b/Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml
@@ -117,6 +117,23 @@ properties:
           - description: AXI power-on system reset
           - description: AHB reset
 
+  renesas,port-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Optional unique port identifier for this ethernet interface.
+      Used for physical port identification (phys_port_id, phys_port_name).
+      If not specified, the ethernet alias index is used as fallback.
+    minimum: 0
+    maximum: 255
+
+  renesas,port-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Optional custom name for the physical port. Used by
+      ndo_get_phys_port_name() for interface naming.
+      If not specified, "p<N>" format is used where N is the port-id
+      or ethernet alias index.
+
   pcs-handle:
     description:
       phandle pointing to a PCS sub-node compatible with
@@ -230,6 +247,8 @@ examples:
         snps,txpbl = <32>;
         snps,rxpbl = <32>;
         phy-handle = <&phy0>;
+        renesas,port-id = <0>;
+        renesas,port-name = "mgmt";
 
         stmmac_axi_setup: stmmac-axi-config {
             snps,lpi_en;
-- 
2.25.1


