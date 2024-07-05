Return-Path: <netdev+bounces-109482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A817892899B
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 15:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 413AAB21AF5
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 13:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E12815D5C4;
	Fri,  5 Jul 2024 13:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bbCqdP5v"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDCC15A856;
	Fri,  5 Jul 2024 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720186044; cv=none; b=BlxGr26Rp8fySOpyba20nKfkwS1o+2rEiYjQ9BYZ2FCIfncTfu0H+8Eon5hYl3277XVSNiL2AEm+naIfEbEU0Eh5GLUeWLw7jGzqM66q8nVQf2+TjwSP71wKAYcesX2iz8BVn59ZUF5lxFHq1JWdcOMQ9DeKk7/roARMBvfUBVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720186044; c=relaxed/simple;
	bh=UvytSadW8cLd5y8V8o4rOoI8GBII6X9rA34w6AVgosg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+cLO8jiDgtUUUYmXKQUhtCh9eu0l18Z5kTY5vEM/uHEkshg2XmQQxbmOh53Xr5GFqIayRp3JbNBpWs4fyUwOX4EdXrbx0wI42jX6y/7JfrUPIpGtCrJE5Tj6YVjYkaN/1TjnOEGuJ97zaGAw0OjWAimZ+L1GQJXuSvMdt3zYVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bbCqdP5v; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 26C431C0005;
	Fri,  5 Jul 2024 13:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720186041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rl64jal9Q5dVqZMxUX/L7AHYOwNAuSrVdhJAw2Cp7Cs=;
	b=bbCqdP5vYKHMaUhr3ipD59wTfL3oTSWTeD2/ce9u2m+SBtt14G/aHlq1Z5Xz8ktKeULT89
	r25S79gbLI33GSTpc1kupc0hSLwKA3sa94JstdfuMtnSrSXbbzsxCA4bpssnlpKvqZXtny
	2hLWI2EdzN19NF+9LaynF4RBJgR61IQ6Ydp7EbIDSoIq2R9ZNxpbeyH4UfKiWgiCHvC89s
	R4qC7AU/9uvA3c487tgwLDqUsvILr+Urp7mIje1DEcjUwPVyn55nzVs15HF3mTwFqmydzS
	oS6EDmV+NiY32gB3e5UsNUxq9oNvpZL/9AVoYnsLCMSLejuO2VC7zrfXNvXW1A==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Nathan Chancellor <nathan@kernel.org>,
	Antoine Tenart <atenart@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH net-next v16 08/14] netlink: specs: add ethnl PHY_GET command set
Date: Fri,  5 Jul 2024 15:26:59 +0200
Message-ID: <20240705132706.13588-9-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240705132706.13588-1-maxime.chevallier@bootlin.com>
References: <20240705132706.13588-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

The PHY_GET command, supporting both DUMP and GET operations, is used to
retrieve the list of PHYs connected to a netdevice, and get topology
information to know where exactly it sits on the physical link.

Add the netlink specs corresponding to that command.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 Documentation/netlink/specs/ethtool.yaml | 55 ++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 4ca7c5b8c504..7760ff67dafd 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -24,6 +24,11 @@ definitions:
     name: module-fw-flash-status
     type: enum
     entries: [ started, in_progress, completed, error ]
+  -
+    name: phy-upstream-type
+    enum-name:
+    type: enum
+    entries: [ mac, phy ]
 
 attribute-sets:
   -
@@ -1037,6 +1042,35 @@ attribute-sets:
       -
         name: total
         type: uint
+  -
+    name: phy
+    attributes:
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: index
+        type: u32
+      -
+        name: drvname
+        type: string
+      -
+        name: name
+        type: string
+      -
+        name: upstream-type
+        type: u32
+        enum: phy-upstream-type
+      -
+        name: upstream-index
+        type: u32
+      -
+        name: upstream-sfp-name
+        type: string
+      -
+        name: downstream-sfp-name
+        type: string
 
 operations:
   enum-model: directional
@@ -1822,3 +1856,24 @@ operations:
           - status-msg
           - done
           - total
+    -
+      name: phy-get
+      doc: Get PHY devices attached to an interface
+
+      attribute-set: phy
+
+      do: &phy-get-op
+        request:
+          attributes:
+            - header
+        reply:
+          attributes:
+            - header
+            - index
+            - drvname
+            - name
+            - upstream-type
+            - upstream-index
+            - upstream-sfp-name
+            - downstream-sfp-name
+      dump: *phy-get-op
-- 
2.45.1


