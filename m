Return-Path: <netdev+bounces-122970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB7F963507
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 00:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C45751F25B25
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 22:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D2B1AD407;
	Wed, 28 Aug 2024 22:52:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B649015A858;
	Wed, 28 Aug 2024 22:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724885535; cv=none; b=RW69nEZN6H8/u1XrzB+9CKR9EzT4renFo1QI9HWz0efDRItJdRWFOtqkAaN13zoayvmllMwQJa52zYCx+mrnGnUPEQy9DM5CUMYzJlySEB69qhdLvKsFMadcmozWR9kBO0EpV026mdnsE4GjIwf/Fvm9ya8GyEDuwgUle0qkwJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724885535; c=relaxed/simple;
	bh=ZDodd/CybnxNXihzo0/N6D1q1FP8SbjHp4PVUJCZkXg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kku6hxXwplEKehUPYY13x5z/7/zf6k52ia6oF5NDOGbY5EkhYzmBzfcE6nUS0skv3jAX28kW9w4z585YBUElJp/qNVwtfn1ENEtlGFzz+me22yg7OE/BAWYPoMV/CNGyZkEmaXmmfpgjA8CFNCZ669ml+VHSMEuNuq9h56HW4w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1sjRW9-000000000Mt-0KIO;
	Wed, 28 Aug 2024 22:51:57 +0000
Date: Wed, 28 Aug 2024 23:51:49 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Robert Marko <robimarko@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Russell King <rmk+kernel@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/2] dt-bindings: net: marvell,aquantia: add
 properties to override MDI_CFG
Message-ID: <1cdfd174d3ac541f3968dfe9bd14d5b6b28e4ac6.1724885333.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Usually the MDI pair order reversal configuration is defined by
bootstrap pin MDI_CFG. Some designs, however, require overriding the MDI
pair order and force either normal or reverse order.

Add mutually exclusive properties 'marvell,force-mdi-order-normal' and
'marvell,force-mdi-order-reverse' for that purpose.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: enforce mutually exclusive relationship of the two new properties in
    dt-schema.

 .../bindings/net/marvell,aquantia.yaml           | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/marvell,aquantia.yaml b/Documentation/devicetree/bindings/net/marvell,aquantia.yaml
index 9854fab4c4db0..03b0cff239f70 100644
--- a/Documentation/devicetree/bindings/net/marvell,aquantia.yaml
+++ b/Documentation/devicetree/bindings/net/marvell,aquantia.yaml
@@ -22,6 +22,12 @@ description: |
 
 allOf:
   - $ref: ethernet-phy.yaml#
+  - if:
+      required:
+        - marvell,force-mdi-order-normal
+    then:
+      properties:
+        marvell,force-mdi-order-reverse: false
 
 select:
   properties:
@@ -48,6 +54,16 @@ properties:
   firmware-name:
     description: specify the name of PHY firmware to load
 
+  marvell,force-mdi-order-normal:
+    type: boolean
+    description:
+      force normal order of MDI pairs, overriding MDI_CFG bootstrap pin.
+
+  marvell,force-mdi-order-reverse:
+    type: boolean
+    description:
+      force reverse order of MDI pairs, overriding MDI_CFG bootstrap pin.
+
   nvmem-cells:
     description: phandle to the firmware nvmem cell
     maxItems: 1
-- 
2.46.0

