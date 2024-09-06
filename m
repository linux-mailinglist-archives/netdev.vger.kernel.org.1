Return-Path: <netdev+bounces-125981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B0196F763
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 404961C22672
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1B91D1F73;
	Fri,  6 Sep 2024 14:49:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C6C1D1F75
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 14:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634171; cv=none; b=VAneG+xaRTwiM802p5WEtAS4chi7YP13ta8Ejo6vpgeJbUn/IEx0LtTQ8K2Sb0XkrQd7Tl1w5KRQ1UlxbAek+xQ57asBVA4vaaXwNpGsykfGAfRUNdOwUwl0PoxD/DPXoJ8zbV//aure7LD20hXZYMumIHLEJlDSgYU9IdHvXm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634171; c=relaxed/simple;
	bh=xVVgbrWIXaB/p99YJfW21mbOGrXIDGuVDt7LUSL8C2A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZB2xcz6bcqI5IW3WfKkzirZxou7pI3TSj2JifDZ4h5boSyGB/alE5I15MtNHezMwINO+2A2tiXAxNJOrgtBxOd8xok32XIZpk27abqAJX5iXLKfQDWN8myRrqjyLKgGF1txGN5eGpso+3NzKdrfbdLBiYp7MbT1nHDEW+AdPTIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1smaGq-0003cv-In; Fri, 06 Sep 2024 16:49:08 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1smaGo-005y8E-Qv; Fri, 06 Sep 2024 16:49:06 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1smaGo-002Tt0-2Q;
	Fri, 06 Sep 2024 16:49:06 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org
Subject: [PATCH v1] dt-bindings: net: ethernet-phy: Add forced-master/slave properties for SPE PHYs
Date: Fri,  6 Sep 2024 16:49:05 +0200
Message-Id: <20240906144905.591508-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Add two new properties, `forced-master` and `forced-slave`, to the
ethernet-phy binding. These properties are intended for Single Pair
Ethernet (1000/100/10Base-T1) PHYs, where each PHY and product may have
a predefined link role (master or slave). Typically, these roles are set
by hardware strap pins, but in some cases, device tree configuration is
necessary.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 .../devicetree/bindings/net/ethernet-phy.yaml | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index d9b62741a2259..af7a1eb6ceff6 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -158,6 +158,28 @@ properties:
       Mark the corresponding energy efficient ethernet mode as
       broken and request the ethernet to stop advertising it.

+  forced-master:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      If set, forces the PHY to operate as a master. This is used in Single Pair
+      Ethernet (1000/100/10Base-T1) where each PHY and product has a predefined
+      link role (master or slave). This property is board-specific, as the role
+      is usually configured by strap pins but can be set through the device tree
+      if needed.
+      This property is mutually exclusive with 'forced-slave'; only one of them
+      should be used.
+
+  forced-slave:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      If set, forces the PHY to operate as a slave. This is used in Single Pair
+      Ethernet (1000/100/10Base-T1) where each PHY and product has a predefined
+      link role (master or slave). This property is board-specific, as the role
+      is usually configured by strap pins but can be set through the device tree
+      if needed.
+      This property is mutually exclusive with 'forced-master'; only one of them
+      should be used.
+
   pses:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     maxItems: 1
--
2.39.2


