Return-Path: <netdev+bounces-221726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F4AB51AFC
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 17:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA200B61F88
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 14:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3AC334383;
	Wed, 10 Sep 2025 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0jjTLQlu"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AF9329F02
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757516156; cv=none; b=cuixLWDbGcyMVLMoLqgV0DfCqeHumPTfZ/1tXeB+fDqkeY9ntI+jsmQYc/qafV/oW8KY0bNTWfQOgEEEb9RfTVedYyrHR8591Ht4zmVYWfjMz2cibfySbpUgLlN67Hi8sLfBVF6Tk+nCTg3bCuUmqs/wzO+/kl0mTRWhkPMOa+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757516156; c=relaxed/simple;
	bh=Bc3e3/0ahFi9v5qz8AZyosX6PMtW/7OQTL8jvV0sdXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AcdiLF7j6DQ+tcrxAjuZxAFmRVE5Dn/pf7xee80LgwqJQivRMu0lIzM4+pO1D22mCWSBma/Bejhe4FufXJ5/mERQ/qm6fttkl5GewnYWiwuyy0TpBUn7JbAnTF8CMU6CNx/puuHVw0QXwyPy5oPhd05e57491R87E7DCrk9tvUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0jjTLQlu; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 321DDC6B3A5;
	Wed, 10 Sep 2025 14:55:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F24D2606D4;
	Wed, 10 Sep 2025 14:55:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D261C102F1CED;
	Wed, 10 Sep 2025 16:55:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757516151; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Z56JzDWKmQD/kK3e7696NE0uPkdwabDSZWVgzG00JDo=;
	b=0jjTLQluKeDkY5SA+dZQ5tGXUCW+EiG/eIerCtRfUrNfbAeHDjmqczQJIkBU5Cc2JqRC07
	YNknpkI+S+gFWIceaOkZuz8bbGMRCFoGpuPeJvF2ZemDL7RvsZAUTQOAHpBPrcnsMFZfmw
	JtIQac1SpjbVgInMug7DYhkoI4FiwY5/d2/CffCkGh7OSUCsVM9oSTImHbnFguAj4q5Liw
	kxpOCygeVJX8k/QCJH4AQtdCpaMdXD3x79rKtz0RnSGMRZOfqGMaydbZrskndXS1B4brNQ
	zDeKmWZ/G/KY/YYinjoUR/YqIJE3/hgqq/SDTYCxYX46AoelBhu46scKGUvr2g==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Wed, 10 Sep 2025 16:55:24 +0200
Subject: [PATCH net-next 1/2] dt-bindings: net: dsa: microchip: Add strap
 description
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-ksz-strap-pins-v1-1-6308bb2e139e@bootlin.com>
References: <20250910-ksz-strap-pins-v1-0-6308bb2e139e@bootlin.com>
In-Reply-To: <20250910-ksz-strap-pins-v1-0-6308bb2e139e@bootlin.com>
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

At reset, some KSZ switches use strap-based configuration. If the
required pull-ups/pull-downs are missing (by mistake or by design to
save power) the pins may float and the configuration can go wrong.

Add a strap description that can be used by the driver to drive the
strap pins during reset. It consists of a 'reset' pinmux configuration
and a set of strap GPIOs.
Since the pins used and the nature of the configuration differ from one
KSZ switch to another, GPIO names aren't used.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index eb4607460db7f32a4dffd416e44b61c2674f731e..f40a5e3cd0e4d39c809a1fb6697bc3bc64f35fec 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -37,6 +37,13 @@ properties:
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
@@ -80,6 +87,11 @@ properties:
     enum: [2000, 4000, 8000, 12000, 16000, 20000, 24000, 28000]
     default: 8000
 
+  strap-gpios:
+    description:
+      Strap pins to drive during reset. For KSZ8463, the first GPIO drives the
+      RXDO line, the second one drives the RXD1 line.
+
   interrupts:
     maxItems: 1
 

-- 
2.51.0


