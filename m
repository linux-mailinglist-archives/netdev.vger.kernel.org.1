Return-Path: <netdev+bounces-132146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 696119908E8
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 18:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 941321C21E3F
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9FE1C75E4;
	Fri,  4 Oct 2024 16:18:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738761C3035;
	Fri,  4 Oct 2024 16:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728058698; cv=none; b=hBHhgqPuK++RpxJymbPT7FOWXl0e9cF8ZK05uwC2KpzvAuY1rkwctT5Gs7fQ4lGXq0GZKdmLu78D/u4lVnX6BkXm7+oKpLhr1cpMcMiluRCmzjKywmCWPTP/EqGjRPnjzev5/QTySMLwbeU9oVV74j23jce4f7w6zNYPaVBY0jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728058698; c=relaxed/simple;
	bh=tg54zVJkCpaGH9QDsrjwnfhNzcDAbD9Y4IGZQT8vNBY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q4/+JCkfvbiwWhtHbtEFyYGgOXZn74vF/8qr1j2xld+YKsvf3mc8wiHvZ2W0x0NOXM4CSNitb3j3M0hOmKbGsOh8MdzfVf0s7V5OwYsWdnGP9mQGriwWwvswnremofWYPv+xSRSoliYwMFt1zMnVFxiUfaqp1qsr0cC0WxG+7+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1swl0L-000000008ST-19Cy;
	Fri, 04 Oct 2024 16:18:09 +0000
Date: Fri, 4 Oct 2024 17:18:05 +0100
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
	Daniel Golle <daniel@makrotopia.org>,
	Robert Marko <robimarko@gmail.com>,
	=?utf-8?B?UGF3ZcWC?= Owoc <frut3k7@gmail.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 1/2] dt-bindings: net: marvell,aquantia: add
 property to override MDI_CFG
Message-ID: <7ccf25d6d7859f1ce9983c81a2051cfdfb0e0a99.1728058550.git.daniel@makrotopia.org>
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

Add property 'marvell,mdi-cfg-order' to allow forcing either normal or
reverse order of the MDI pairs.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v3: use integer enum instead of two properties as suggested
v2: enforce mutually exclusive relationship of the two new properties in
    dt-schema.

 Documentation/devicetree/bindings/net/marvell,aquantia.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/marvell,aquantia.yaml b/Documentation/devicetree/bindings/net/marvell,aquantia.yaml
index 9854fab4c4db..f269615126d8 100644
--- a/Documentation/devicetree/bindings/net/marvell,aquantia.yaml
+++ b/Documentation/devicetree/bindings/net/marvell,aquantia.yaml
@@ -48,6 +48,12 @@ properties:
   firmware-name:
     description: specify the name of PHY firmware to load
 
+  marvell,mdi-cfg-order:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+    description:
+      force normal (0) or reverse (1) order of MDI pairs, overriding MDI_CFG bootstrap pin.
+
   nvmem-cells:
     description: phandle to the firmware nvmem cell
     maxItems: 1
-- 
2.46.2

