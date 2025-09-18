Return-Path: <netdev+bounces-224293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 676F5B83878
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 10:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 579D117B9A9
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 08:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107CB2F6194;
	Thu, 18 Sep 2025 08:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SojZz9q4"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D4E2EDD6D;
	Thu, 18 Sep 2025 08:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758184447; cv=none; b=ElwsECMbLle4KzjE5ZwxSjCpfpLXuYofuqkp2W3ngMj34nDEwW7ZsZ1TCCPzw7XEtr8ciEN6SRfIisu0NaNakgzkrzi0N5XCQ4m9oGvOU3rCuIb566VU6cFzIgmRAcNVq2FT0GW1gaVnn/Qs2azfiPxxzSc9P9W04DYjiMCxXZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758184447; c=relaxed/simple;
	bh=z8zyOghTq87xeDNWe0HqJD0JZ/az2SAEfK9ACdH8vHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mc6gJJJ6CEOGkPqRgTu5H5lievCl+EpZ5r/yLO/KX/tDAmaax8dLXl3+UGZJGXj3LVLXXNAHGQSidNCpbZJJut2E8ugqkpmQ0cSsbXby5urZtOWne60YeGL2NrcHhnOd53Kbj54ygXNtSAcMfUoZUxubsNzPkPgoKmT/0HrF6R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SojZz9q4; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C9D90C0008A;
	Thu, 18 Sep 2025 08:33:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 610006062C;
	Thu, 18 Sep 2025 08:34:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 033F1102F1CA3;
	Thu, 18 Sep 2025 10:34:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758184443; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=tU2EkQI+mFY7LHIakOZurCgSDiSSuoFWyy5L0zuDbaU=;
	b=SojZz9q4446Z+mbslL+S2mRwCCW3NN0Un89Z3cQ0So5EX505VMbKfSvaoIOKVhF+rXu4OE
	HUXsfSpjo4R0v83sviAOPkO7Q08mCgPE6RflIpKJNC1L6cKboKhayl/snpuBFjSnkzRtEC
	6kxCJm70X2CGIOszhgA6g0oZvWYPSPk+4By3Gul0hw1WvaCPCevnX21Sv5JtZGKmSOfyMC
	Y1Flhunq+0M9deyETjOgiNo4YlfIFx2+T5tHKmrB4Ut6ZjvimCj+n2qBoHkdTARDxLhquR
	v5OLwOKzBShbbjKIFcHCLzMlhknAbxYnkPQMxYuaG1KyKZDNewdqBWdqUlAl3Q==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 18 Sep 2025 10:33:50 +0200
Subject: [PATCH net-next v3 1/3] dt-bindings: net: dsa: microchip: Group if
 clause under allOf tag
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-ksz-strap-pins-v3-1-16662e881728@bootlin.com>
References: <20250918-ksz-strap-pins-v3-0-16662e881728@bootlin.com>
In-Reply-To: <20250918-ksz-strap-pins-v3-0-16662e881728@bootlin.com>
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

Upcoming patch adds a new if/then clause. It requires to be grouped with
the already existing if/then clause under an 'allOf:' tag.

Move the if/then clause under the already existing 'allOf:' tag to
prepare next patch.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 .../devicetree/bindings/net/dsa/microchip,ksz.yaml | 68 +++++++++++-----------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index eb4607460db7f32a4dffd416e44b61c2674f731e..db8175b4ced6d136ba97c371b68ba993637e444a 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -10,9 +10,6 @@ maintainers:
   - Marek Vasut <marex@denx.de>
   - Woojung Huh <Woojung.Huh@microchip.com>
 
-allOf:
-  - $ref: /schemas/spi/spi-peripheral-props.yaml#
-
 properties:
   # See Documentation/devicetree/bindings/net/dsa/dsa.yaml for a list of additional
   # required and optional properties.
@@ -107,38 +104,41 @@ required:
   - compatible
   - reg
 
-if:
-  not:
-    properties:
-      compatible:
-        enum:
-          - microchip,ksz8863
-          - microchip,ksz8873
-then:
-  $ref: dsa.yaml#/$defs/ethernet-ports
-else:
-  patternProperties:
-    "^(ethernet-)?ports$":
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+  - if:
+      not:
+        properties:
+          compatible:
+            enum:
+              - microchip,ksz8863
+              - microchip,ksz8873
+    then:
+      $ref: dsa.yaml#/$defs/ethernet-ports
+    else:
       patternProperties:
-        "^(ethernet-)?port@[0-2]$":
-          $ref: dsa-port.yaml#
-          unevaluatedProperties: false
-          properties:
-            microchip,rmii-clk-internal:
-              $ref: /schemas/types.yaml#/definitions/flag
-              description:
-                When ksz88x3 is acting as clock provier (via REFCLKO) it
-                can select between internal and external RMII reference
-                clock. Internal reference clock means that the clock for
-                the RMII of ksz88x3 is provided by the ksz88x3 internally
-                and the REFCLKI pin is unconnected. For the external
-                reference clock, the clock needs to be fed back to ksz88x3
-                via REFCLKI.
-                If microchip,rmii-clk-internal is set, ksz88x3 will provide
-                rmii reference clock internally, otherwise reference clock
-                should be provided externally.
-          dependencies:
-            microchip,rmii-clk-internal: [ethernet]
+        "^(ethernet-)?ports$":
+          patternProperties:
+            "^(ethernet-)?port@[0-2]$":
+              $ref: dsa-port.yaml#
+              unevaluatedProperties: false
+              properties:
+                microchip,rmii-clk-internal:
+                  $ref: /schemas/types.yaml#/definitions/flag
+                  description:
+                    When ksz88x3 is acting as clock provier (via REFCLKO) it
+                    can select between internal and external RMII reference
+                    clock. Internal reference clock means that the clock for
+                    the RMII of ksz88x3 is provided by the ksz88x3 internally
+                    and the REFCLKI pin is unconnected. For the external
+                    reference clock, the clock needs to be fed back to ksz88x3
+                    via REFCLKI.
+                    If microchip,rmii-clk-internal is set, ksz88x3 will provide
+                    rmii reference clock internally, otherwise reference clock
+                    should be provided externally.
+              dependencies:
+                microchip,rmii-clk-internal: [ethernet]
 
 unevaluatedProperties: false
 

-- 
2.51.0


