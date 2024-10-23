Return-Path: <netdev+bounces-138424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5D59AD747
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 00:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2FAA1C225C2
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 22:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A305D20012B;
	Wed, 23 Oct 2024 22:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="t9VWY4tq"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E211FF7CB;
	Wed, 23 Oct 2024 22:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729720980; cv=none; b=PDjCrYxGmk2jz7A4kpfrR9B6nWYUxy9UcONRaLkBK67ilVkwoHMD4QAQAk1pCZOQKDQcSJ1B8LU43bn9qwWDmSmK3OdO1igw0qF2s1/OKS8PWi721ABxIbqZ7p6qsIu6JWnlXXRC4SW4/s/cM8rT1oXk6rwpsa3c8JuZ1+U/tUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729720980; c=relaxed/simple;
	bh=/G4iL7GD2FU5sXjacp+RgfYPneZqqpBcs/+YCXekj9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=sJCLsM9wWbRLnszVAH//bejIzoigKT13ExT67tHUJx7mT6Oj52ihb52LHDR6EOEChd3l3fEVaGoUW0QRrDrSzcQW3Iqx/aCb1hq3yHSruBfCOmzBFRkFuUtfyL+r0Wq24Jd/OXFk28siyCxipp3shewV0Iad8JFuSq8xyTnM7GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=t9VWY4tq; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729720978; x=1761256978;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=/G4iL7GD2FU5sXjacp+RgfYPneZqqpBcs/+YCXekj9Y=;
  b=t9VWY4tqNwwDyQlPZOmW5sXdXa6HFg4xyoe5o9kA0UHyuuH0H+Vaxqge
   4j004HF2N5F884gJFA9uinCNLKqVZ3n8CfR474TtS1nrrsgcN56YjnIrk
   BpIS4MNeaNXcL1GdO+z4Y5+Kfsd6q31sekwTkWak9rMTBLD167iORIpVG
   DKG27F4z9G5/iuuufKJDvC5aB5TBGByLPJQS187mQQgFHHwDPc4nYyKsM
   c1LeqipRh0s2qLUXmsK3oSaXlNCpIajaTuP0u/0GvsnwK6R0g3tGN+8py
   J3nZTMBBX6Jooi0bC8u9gpfsPxCBApbknFt+uTN9DtQYOyF9BC+n/EFQJ
   w==;
X-CSE-ConnectionGUID: oMPErp9qRFmiMc0P9W4Bgw==
X-CSE-MsgGUID: nRk5MY7RTc+EYXbl9Nc51w==
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="264507059"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2024 15:02:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 23 Oct 2024 15:02:33 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 23 Oct 2024 15:02:29 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 24 Oct 2024 00:01:32 +0200
Subject: [PATCH net-next v2 13/15] dt-bindings: net: add compatible strings
 for lan969x targets
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241024-sparx5-lan969x-switch-driver-2-v2-13-a0b5fae88a0f@microchip.com>
References: <20241024-sparx5-lan969x-switch-driver-2-v2-0-a0b5fae88a0f@microchip.com>
In-Reply-To: <20241024-sparx5-lan969x-switch-driver-2-v2-0-a0b5fae88a0f@microchip.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	<horatiu.vultur@microchip.com>, <jensemil.schulzostergaard@microchip.com>,
	<Parthiban.Veerasooran@microchip.com>, <Raju.Lakkaraju@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <jacob.e.keller@intel.com>,
	<ast@fiberby.net>, <maxime.chevallier@bootlin.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Steen Hegelund
	<steen.hegelund@microchip.com>, <devicetree@vger.kernel.org>
X-Mailer: b4 0.14-dev

Add compatible strings for the twelve different lan969x targets that we
support. Either a sparx5-switch or lan9691-switch compatible string
provided on their own, or any lan969x-switch compatible string with a
fallback to lan9691-switch.

Also, add myself as a maintainer.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../bindings/net/microchip,sparx5-switch.yaml        | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
index fcafef8d5a33..dedfad526666 100644
--- a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
+++ b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
@@ -9,6 +9,7 @@ title: Microchip Sparx5 Ethernet switch controller
 maintainers:
   - Steen Hegelund <steen.hegelund@microchip.com>
   - Lars Povlsen <lars.povlsen@microchip.com>
+  - Daniel Machon <daniel.machon@microchip.com>
 
 description: |
   The SparX-5 Enterprise Ethernet switch family provides a rich set of
@@ -34,7 +35,24 @@ properties:
     pattern: "^switch@[0-9a-f]+$"
 
   compatible:
-    const: microchip,sparx5-switch
+    oneOf:
+      - enum:
+          - microchip,lan9691-switch
+          - microchip,sparx5-switch
+      - items:
+          - enum:
+              - microchip,lan969c-switch
+              - microchip,lan969b-switch
+              - microchip,lan969a-switch
+              - microchip,lan9699-switch
+              - microchip,lan9698-switch
+              - microchip,lan9697-switch
+              - microchip,lan9696-switch
+              - microchip,lan9695-switch
+              - microchip,lan9694-switch
+              - microchip,lan9693-switch
+              - microchip,lan9692-switch
+          - const: microchip,lan9691-switch
 
   reg:
     items:

-- 
2.34.1


