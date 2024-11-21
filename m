Return-Path: <netdev+bounces-146665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 428139D4EFA
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 15:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5D2CB27647
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 14:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EF01DFD86;
	Thu, 21 Nov 2024 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hAJJ0V5C"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9331DF749;
	Thu, 21 Nov 2024 14:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200243; cv=none; b=R6tsm3PQenauKvKn19/GpfxXtuIkUiBbM5AsCSCMCwKtEs89ZMB07WzZ2yUPdiXDyADECBqmhSqM5XN78xooOQEW5J7qVctMmZVTooAR2KWjkpi8AboMqWfqaxS0UWBgFj3M0Dx9mkRm8Xj0wwRS/IlvIqAeCIXhb7kUtTxf2bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200243; c=relaxed/simple;
	bh=RJtM4WeK5tdP2686V9W4U9y9FnQlBaytEc06Hdxl9cw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=adHo6jWc3iN97rS4+3XM3yR7S5tlEkInXvRqQnuLpKcfIpDZriyUQtP011Nowf7jWL3CMS8ydWWVCJ47pVqhug/OkTIhhy04SA0CdcYe4imbi+6NOsg2zx+wUqG1669WD6DLLbJD7MTMsPyuxZTq6eJVgm5p0OQgBpE50VUxD98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hAJJ0V5C; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B520040011;
	Thu, 21 Nov 2024 14:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732200239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jD37FPcA/oQ7xGn1KpPQBFYBDQ3WJO4x7PpFCfb9VOo=;
	b=hAJJ0V5CTFbBMb6NqiJLOhhBUHzrqgpuTXEdWcgCtAJnk3rQZanLRZUOEtLl6MRr/ayWCW
	DkKn3i/bMqUuFIimhN45ZeTVAg1xSXpbBUgjZYY/ZXXnp7lIw/mXSyrv9zYp7YLop+SR3v
	+vPpBiU/OgLesg95uSh6oGAeWCA62fCrtu/QWDwUvBqZQHpY0Kcy90B9Hg4u+1jabDdTZm
	6mbEDaTSsmcfFgyOlNW0cckLLrnpO5YEnuvStwsrCSZ30pUMoZVNxjgY6/5DolHw7g2PSR
	+fY3n7Ov6ytW9wdyk6ghoRsa4CAeeInq1qVclwNPUNjkZaE7xePMny9pkUl6aA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 21 Nov 2024 15:42:39 +0100
Subject: [PATCH RFC net-next v3 13/27] netlink: specs: Add support for PSE
 netlink notifications
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-feature_poe_port_prio-v3-13-83299fa6967c@bootlin.com>
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

Introduce support for PSE-specific netlink notifications, allowing for
the reporting of events related to c33 PSE (Power Sourcing Equipment).

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v2:
- new patch.
---
 Documentation/netlink/specs/ethtool.yaml | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 93369f0eb816..f27c76d965d9 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -1137,6 +1137,18 @@ attribute-sets:
       -
         name: downstream-sfp-name
         type: string
+  -
+    name: pse-ntf
+    attributes:
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: pse-ntf-events
+        type: nest
+        nested-attributes: bitset
+        name-prefix: ethtool-a-
 
 operations:
   enum-model: directional
@@ -1960,3 +1972,13 @@ operations:
       name: phy-ntf
       doc: Notification for change in PHY devices.
       notify: phy-get
+    -
+      name: pse-ntf
+      doc: Notification for pse events.
+
+      attribute-set: pse-ntf
+
+      event:
+        attributes:
+          - header
+          - pse-ntf-events

-- 
2.34.1


