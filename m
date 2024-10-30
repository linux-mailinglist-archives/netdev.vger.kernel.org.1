Return-Path: <netdev+bounces-140482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8171F9B69E0
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 17:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB93B1F22486
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 16:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2265228040;
	Wed, 30 Oct 2024 16:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ol3mWFCy"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A200B21A6FB;
	Wed, 30 Oct 2024 16:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730307249; cv=none; b=bwmbBNdI9Ic8z3e/9PGdm2PQG7wlbmKHUQeUACnzGoFbZkPKszDLuQpmfrK9ajfF1maeFm86i9iuf0iJHo/oKYZM02NrEkSOS3Vq+EfzAZow2YhkKPr0ij6U8fKJJ5N3AUFPcv9HE9sowXpnH/FmKuwHfbKr+6dpWMHJplje0o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730307249; c=relaxed/simple;
	bh=LLcZKMd5B9Te79z3BAEZTtYb0CjBToReWDuk5TP6JAs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mp/AwtmNMlC1CIYOKZuCSNY7CZhKZmmmtMv6+qMkTxvtG4qGHXZGFwF5ZBUe4tjc9VdQuHhmZ7dSZ7mv3cuzSxRIjR6ndvNurMIniO/GDa2yCgXrpywYiud1+cmBXmLTQaimyYyc5mLt4xHhWSLPegc7Xvg4Z2U/sWYc+seIOVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ol3mWFCy; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E56D0C0011;
	Wed, 30 Oct 2024 16:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730307244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4hLFAduRWdDTP41xJjCujhm6I6wL+JgXBmoJJ0CTzww=;
	b=ol3mWFCyayVkTErFc3SZQhO6fsF1ejZZKk9jcW1W373IWwWamJ+x7ku7gzVtyvXfW19S6W
	99151XFaJfj/fJ6cM8g6KFAtbdwgOira1CZd8Gb8o72w9Ldb/7N9pBYoTEhAf/bX83sK0+
	B8IV5jHRFkkE2y0Dt6WE01vgKO/w0NV7O8RQ0wbpDMb7ROTqP8qUQBqwZmwBYY+UIKNn4j
	IJeksz5TVro4Frv1rOXzxoZVs4P7iqH1YIaN8/LDMWA0rOZFIoDHmxynRLvVWKeFBjsGhL
	atO1mfTTwqx+0BaMzX2z6A3x/EfElQWxucIh2k8DA6Hp+kJ9IYWl/izxxNJkbA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 30 Oct 2024 17:53:11 +0100
Subject: [PATCH RFC net-next v2 09/18] netlink: specs: Add support for PSE
 netlink notifications
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-feature_poe_port_prio-v2-9-9559622ee47a@bootlin.com>
References: <20241030-feature_poe_port_prio-v2-0-9559622ee47a@bootlin.com>
In-Reply-To: <20241030-feature_poe_port_prio-v2-0-9559622ee47a@bootlin.com>
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

changes in v2:
- new patch.
---
 Documentation/netlink/specs/ethtool.yaml | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 93369f0eb816..6983dea39976 100644
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
+        name: c33-pse-ntf-events
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
+          - c33-pse-ntf-events

-- 
2.34.1


