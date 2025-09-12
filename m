Return-Path: <netdev+bounces-222480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F01E9B546B2
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 11:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EBE5AC045E
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 09:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B46D284694;
	Fri, 12 Sep 2025 09:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TBVpNSul"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3209627E1B1
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 09:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757668596; cv=none; b=tu24XXlZwJbrIeZUNKEiwjPcawCZkpnUHwV/husz3/IgXuxY8QtbVWxzwMMUgPf9LaknPfGp0hg20HYrlBLrM+YjsWp1BsUiAcdJhPqsoRykoogxJyvBOzUf3Q+x9cUbb/D9Wwh3KM2dFHYIF+z/P4YoT62ccpQZaL6FxaDjP9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757668596; c=relaxed/simple;
	bh=7xjaN++yI6KEPxU35tjofli5LkxLgcT962mH3BRyDXg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VbiLzT7A8IE1E+DGRfkqzyQkzA+0N003TzzZycCp8Ewi4vWGFZh2EZqlHY+BMAt+KsVvq0TVuJZpaRAG+H3xgQfyIrxKpgs0MPlEWPCeggM1iKIsAweikq5qvlf2lprs/RNiWjV5FCcaGds5Gs7VHwVV0uRJFXLp+i0mdqQY9zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TBVpNSul; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 7DDDFC8EC46;
	Fri, 12 Sep 2025 09:16:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 755A260638;
	Fri, 12 Sep 2025 09:16:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 525F1102F29DD;
	Fri, 12 Sep 2025 11:16:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757668591; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=L+6jrk72fwMKzwzZOHzEZKdBpoCdacRGXLcgPacqMIc=;
	b=TBVpNSulOChQdlcmYi2dQcLYtqA+Q+FarGn42UjJOXftDgtEDTZPRWGyii2m/rP80+EzVK
	ATqwx/Nwpw5P1madWnjfWjsm0qZvOT5BnZyVlCxDCWXXl/fz0dPv5gVwfrNMDrqod0aPmK
	9KR7P3qkezmyJz6bf5REKk+cMr3LtOSYZOXb1FBOefrCPEO93qpOfeZlpLoPuqeIPrX1Pz
	rU00wb7SQmT0fo+dbZTyEVqDNQulVyBBdMmJN+X13xg3xvkyQFDoqFSlx6cGOMhgANp3e+
	dw+BVWGo2jVFdBbO8xOztibiJk0bSMJlA1k8GunUczgq8ul8Z9C7PZiKvzfFLg==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Fri, 12 Sep 2025 11:09:13 +0200
Subject: [PATCH net-next v2 2/3] dt-bindings: net: dsa: microchip: Add
 strap description to set SPI mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-ksz-strap-pins-v2-2-6d97270c6926@bootlin.com>
References: <20250912-ksz-strap-pins-v2-0-6d97270c6926@bootlin.com>
In-Reply-To: <20250912-ksz-strap-pins-v2-0-6d97270c6926@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Pascal Eberhard <pascal.eberhard@se.com>, 
 Woojung Huh <Woojung.Huh@microchip.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

At reset, KSZ8463 uses a strap-based configuration to set SPI as
interface bus. If the required pull-ups/pull-downs are missing (by
mistake or by design to save power) the pins may float and the
configuration can go wrong preventing any communication with the switch.

Add a 'reset' pinmux state
Add a KSZ8463 specific strap description that can be used by the driver
to drive the strap pins during reset. Two GPIOs are used. Users must
describe either both of them or none of them.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 .../devicetree/bindings/net/dsa/microchip,ksz.yaml | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index db8175b4ced6d136ba97c371b68ba993637e444a..099c6b373704427755c3d8cad4b1cd930219f2f2 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -34,6 +34,13 @@ properties:
       - microchip,ksz8567
       - microchip,lan9646
 
+  pinctrl-names:
+    items:
+      - const: default
+      - const: reset
+        description:
+          Used during reset for strap configuration.
+
   reset-gpios:
     description:
       Should be a gpio specifier for a reset line.
@@ -139,6 +146,23 @@ allOf:
                     should be provided externally.
               dependencies:
                 microchip,rmii-clk-internal: [ethernet]
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: microchip,ksz8463
+    then:
+      properties:
+        strap-rxd0-gpios:
+          description:
+            RXD0 pin, used to select SPI as bus interface.
+        strap-rxd1-gpios:
+          description:
+            RXD1 pin, used to select SPI as bus interface.
+
+dependencies:
+  strap-rxd0-gpios: [ strap-rxd1-gpios ]
+  strap-rxd1-gpios: [ strap-rxd0-gpios ]
 
 unevaluatedProperties: false
 

-- 
2.51.0


