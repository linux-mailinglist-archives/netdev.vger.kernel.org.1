Return-Path: <netdev+bounces-232197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1AFC026D7
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 18:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 050921AA0736
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 16:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2297D2D77ED;
	Thu, 23 Oct 2025 16:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PNP2tBpR"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD1726F2A6
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 16:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761236600; cv=none; b=hAu77fEZGKH7PykIIa36mmU6qrE/dgM2iG4kfx1t192CzRdHC9qXcj7PVk2oohAde/iMxIV1aNpb1A78rOA03TlGlhu3PQ0wGhUqOUVuEoshCeH7vAe6hh9gYP6qeRkaMP0Fdely5F1YA3GhWtzuNNiHThI1JgY+0Ws43eHTA0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761236600; c=relaxed/simple;
	bh=gGGXJOm8rvImrLi6BxMNzALgm6MsoyQKr1sLUF92SL4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D8ji4fv7q+L15Vyr6SBAB8pvYLSSOSieU8mm3rW+nAmEB5uM2+yBmcP258wsqjp5Ul+JfyyXy0fCaqwDCOhMWAL4oS9tCj2Rnl801pVfU12RRKmyHXdh9e857I+WPWOkPHBRZ8MtxoSHN66sbEgYfQXYFdvrurnosX4HQ6f3yYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PNP2tBpR; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 5D7A7C0C430;
	Thu, 23 Oct 2025 16:22:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3CCBA606DE;
	Thu, 23 Oct 2025 16:23:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 69AEF102F246C;
	Thu, 23 Oct 2025 18:23:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761236594; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=OrH5JeCuK9Xj8osuGgprmu4Yv4MHT2kxnh5YrLEqkOo=;
	b=PNP2tBpRMM8CvakDDlnBWEg92wRMjrt3Fxb7lws3hFXdSGqsf0GmdmMP9jaQdgAvlFwPfg
	KDOJ/cdQC7+Klodg5tjLNBhn9UGE8Jt4MB5oo285NPVPuiKTywVsSi6H0lp7jivTOE0iP8
	pgM2YSJUmY42HdHIv5jH/wL0auxrhhceM+5M288GgehYckb6Rg/zbai4iEuDOAXo95vKMW
	ffp7jbs9WcHn+8R9ho5ldAAa7GdjGNUh8DTEiZLPUCpaogrx68+RizMz53y/Z1SwgruA2/
	7Q9YQlZ+bco69qM4PF4+noexKq74DweK21YCSgj3eMDrm365UJAUwvmIlGhmMw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Thu, 23 Oct 2025 18:22:51 +0200
Subject: [PATCH net-next v3 1/5] dt-bindings: net: cdns,macb: add Mobileye
 EyeQ5 ethernet interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251023-macb-eyeq5-v3-1-af509422c204@bootlin.com>
References: <20251023-macb-eyeq5-v3-0-af509422c204@bootlin.com>
In-Reply-To: <20251023-macb-eyeq5-v3-0-af509422c204@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Add "cdns,eyeq5-gem" as compatible for the integrated GEM block inside
Mobileye EyeQ5 SoCs. It is different from other compatibles in two main
ways: (1) it requires a generic PHY and (2) it is better to keep TCP
Segmentation Offload (TSO) disabled.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 Documentation/devicetree/bindings/net/cdns,macb.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
index 02f14a0b72f9..ea8337846ab2 100644
--- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
+++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
@@ -57,6 +57,7 @@ properties:
           - cdns,np4-macb             # NP4 SoC devices
           - microchip,sama7g5-emac    # Microchip SAMA7G5 ethernet interface
           - microchip,sama7g5-gem     # Microchip SAMA7G5 gigabit ethernet interface
+          - mobileye,eyeq5-gem        # Mobileye EyeQ5 SoCs
           - raspberrypi,rp1-gem       # Raspberry Pi RP1 gigabit ethernet interface
           - sifive,fu540-c000-gem     # SiFive FU540-C000 SoC
 
@@ -183,6 +184,15 @@ allOf:
         reg:
           maxItems: 1
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mobileye,eyeq5-gem
+    then:
+      required:
+        - phys
+
 unevaluatedProperties: false
 
 examples:

-- 
2.51.1


