Return-Path: <netdev+bounces-146675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FB49D4F20
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 15:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 961021F21062
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 14:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BA81E2301;
	Thu, 21 Nov 2024 14:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BA7lBh13"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19351DDA2F;
	Thu, 21 Nov 2024 14:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200271; cv=none; b=bsUu4GH9lyyjaE4mUMi9ZF02FCCdJ3HedmizM+m2x3YpDC2y8PXRWxIeT6acftAZxvziSPLRT6ZHxW2S1HdWKk0nf7WzWH+9iJjpHYL8FY/Ur33xLQF8A5giv8QhlqUryPpE76ehszMB8UOOcegWC6r0aU00BdtiJlFXSRK0p50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200271; c=relaxed/simple;
	bh=exL8Nr6/+o176cowBQBWABHM3Mc4D55qQlnWSf3Ptac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VLfd72jp84oXI5IgrMR4zEorrkVsFfp3qo7GknSROK4q7cYFCIhItsJA4VVOvohp0t3fOWig8YNLtj0tp4Wwq+2P1y0BKC3qFsYlKYfyHiNsdMFpUBpOMqjg0DQvE0t3Ax6+Af+uFp9N9k5FnfMRz3M5b2WdY8W2KqHPBe9fJHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BA7lBh13; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 758CF4000F;
	Thu, 21 Nov 2024 14:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732200266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SypnoOdg8blA9bbWfoucUhr8Y916y7yHuW6LBJ8Fqgk=;
	b=BA7lBh13PfI/k1mvUPzi+nyAiO+4oO9ViMiW0ciRtO6OBQn9aTIUi4Hg6xJIq58RZdC8HK
	Hgpc3Pi9sBxTY2Dh70gK66a1hC2lOtFkkbSksqzbSwb/LudDC/1zkaiBVpYjzAV+e+lS/M
	4HJ4OIiieoQNZjo8TGqeP1LYXvdcliRJt4TbXjivV83ULEu01sBoZCNob8oxfqzK+3wxHa
	OlIFfnK8kRFWb4HKuIVqIIfoo2W9p/mzD7lkiXy1xj087l0ZjkMUwbmRh4YZd+JWnlaLsy
	26RH6mPNUEcthslGScxgku1AaSraaGZye0fGTMcKgK8KhVHp/egLWEgC8rYDKA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 21 Nov 2024 15:42:49 +0100
Subject: [PATCH RFC net-next v3 23/27] netlink: specs: Expand the PSE
 netlink command with newly supported features
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-feature_poe_port_prio-v3-23-83299fa6967c@bootlin.com>
References: <20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com>
In-Reply-To: <20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Expand the c33 PSE attributes with PSE id, PSE power domain id, priority
and priority max to be able to set and get the PSE Power Interface
priority.

./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do pse-get
             --json '{"header":{"dev-name":"eth1"}}'
{'c33-pse-actual-pw': 1700,
 'c33-pse-admin-state': 3,
 'c33-pse-avail-pw-limit': 97500,
 'c33-pse-prio': 2,
 'c33-pse-prio-max': 2,
 'c33-pse-pw-class': 4,
 'c33-pse-pw-d-status': 4,
 'c33-pse-pw-limit-ranges': [{'max': 18100, 'min': 15000},
                             {'max': 38000, 'min': 30000},
                             {'max': 65000, 'min': 60000},
                             {'max': 97500, 'min': 90000}],
 'header': {'dev-index': 5, 'dev-name': 'eth1'}}

./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do pse-set
             --json '{"header":{"dev-name":"eth1"},
                      "c33-pse-prio":1}'
None

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 Documentation/netlink/specs/ethtool.yaml | 37 ++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index f27c76d965d9..c089c315cc2f 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -1025,6 +1025,34 @@ attribute-sets:
         type: nest
         multi-attr: true
         nested-attributes: c33-pse-pw-limit
+      -
+        name: pse-id
+        type: u32
+        name-prefix: ethtool-a-
+      -
+        name: pse-pw-d-id
+        type: u32
+        name-prefix: ethtool-a-
+      -
+        name: c33-pse-prio-supp-modes
+        type: u32
+        name-prefix: ethtool-a-
+      -
+        name: c33-pse-prio-mode
+        type: u32
+        name-prefix: ethtool-a-
+      -
+        name: c33-pse-prio-max
+        type: u32
+        name-prefix: ethtool-a-
+      -
+        name: c33-pse-prio
+        type: u32
+        name-prefix: ethtool-a-
+      -
+        name: c33-pse-discon-pol
+        type: u32
+        name-prefix: ethtool-a-
   -
     name: rss
     attributes:
@@ -1793,6 +1821,13 @@ operations:
             - c33-pse-ext-substate
             - c33-pse-avail-pw-limit
             - c33-pse-pw-limit-ranges
+            - pse-id
+            - pse-pw-d-id
+            - c33-pse-prio-supp-modes
+            - c33-pse-prio-mode
+            - c33-pse-prio-max
+            - c33-pse-prio
+            - c33-pse-discon-pol
       dump: *pse-get-op
     -
       name: pse-set
@@ -1807,6 +1842,8 @@ operations:
             - podl-pse-admin-control
             - c33-pse-admin-control
             - c33-pse-avail-pw-limit
+            - c33-pse-prio
+            - c33-pse-discon-pol
     -
       name: rss-get
       doc: Get RSS params.

-- 
2.34.1


