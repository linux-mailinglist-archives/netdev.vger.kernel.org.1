Return-Path: <netdev+bounces-105238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A928910398
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 14:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A9A9B20A75
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 12:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E46B1AC249;
	Thu, 20 Jun 2024 12:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W+02BoeC"
X-Original-To: netdev@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2B517BB05;
	Thu, 20 Jun 2024 12:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718884913; cv=none; b=hMB7s/IuB3BZhbpg0ALx328qK7QOGYXQ9/C7n2LgzUtuxMQ9lnu0WeoTd1EXFFtq79aIkYyCTpzDAAf6dE+/DIrVmiDKCES8PmhQ2qgAA8FeV/3F5/LlLzehHwwbBmCYePWQEvVuNRSRVyY79nQ0xWAkET6MbE7rcbgrwND5+6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718884913; c=relaxed/simple;
	bh=9PIhyYGNWcY7TPX0zsorCk5n9Xre78jAdyX8n6yC+Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVx260qXna75pPkEjNOyRw+g6dXwkDHiXfRaww/v+Jy+WPTn1wowajrtKsFYeXZLD+Y25iDiG+zmSKpXJf6yBbXoSakA/3srHngVXZO/hNIWs2UeUnMdJ7ThUGtmskpko9PL/3BCivHixtE7fEStFDDkeW8LC/Zmlax7R9++T64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=W+02BoeC; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay5-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::225])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id D6C6AC4D95;
	Thu, 20 Jun 2024 12:01:42 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPA id DCA641C0004;
	Thu, 20 Jun 2024 12:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718884895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r05TD/GVdIcSzqzhZMzXmTWGakGAMsrSYTyZGt7/JnE=;
	b=W+02BoeCD+aAjI4Cs9s8J3XbfwURr3cJ0KaW4bc3/GYF5Sqk85lX9AdL3JKvw/r1q58aKb
	idOOJcLBaeuGhyzHwspxvDrP7LI5aOdS5jU/zPHee3V1jyOLJ1bg2b+DWvdwtA0nofgX/l
	34Q5wYQMgFewb49Hm3ym16zNJCdPb4v58XHUA8Mk6nQPKr7amZ3jFxazl/f1r/RX9QzLNy
	wumG07nndD1BwwMxCXX9rIAcoTp03sFf9z27WJhczS/jS4+3M6J+UdVjK5+SjVk1yv1SBx
	79HN8QhU0tAox1nDGZwCyjkyvQ53/xQMkJDj5cx4m/UTgy+/UtTSao1aQyrQcg==
From: Herve Codina <herve.codina@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next v3 1/2] dt-bindings: net: mscc-miim: Add resets property
Date: Thu, 20 Jun 2024 14:01:24 +0200
Message-ID: <20240620120126.412323-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240620120126.412323-1-herve.codina@bootlin.com>
References: <20240620120126.412323-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Add the (optional) resets property.
The mscc-miim device is impacted by the switch reset especially when the
mscc-miim device is used as part of the LAN966x PCI device.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/net/mscc,miim.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/mscc,miim.yaml b/Documentation/devicetree/bindings/net/mscc,miim.yaml
index 5b292e7c9e46..792f26b06b06 100644
--- a/Documentation/devicetree/bindings/net/mscc,miim.yaml
+++ b/Documentation/devicetree/bindings/net/mscc,miim.yaml
@@ -38,6 +38,16 @@ properties:
 
   clock-frequency: true
 
+  resets:
+    items:
+      - description:
+          Reset shared with all blocks attached to the Switch Core Register
+          Bus (CSR) including VRAP slave.
+
+  reset-names:
+    items:
+      - const: switch
+
 required:
   - compatible
   - reg
-- 
2.45.0


