Return-Path: <netdev+bounces-107589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA58991BA09
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 10:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ECBAB21311
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 08:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD7F1514CC;
	Fri, 28 Jun 2024 08:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="G9Gb9Wo2"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD8C14E2E6;
	Fri, 28 Jun 2024 08:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719563548; cv=none; b=qM9HWMkm1UtEVPmO7so7uN7NBMbBPTYPRB1OgjazVfkwl/VRHSqpVFHUYjikJePRoTR+6RZdaZybZffApGx5FkjLk0nlSyV/tJvE9CiNZIFDJ3+Hy8FchlmEE2YbiM9RitaqvMD4b6V2+q3OWscB23yA2JWg/6xVcvnUFhreNTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719563548; c=relaxed/simple;
	bh=aL5K60kyLaYT4Dy60EU0ucdDsNgnwxZmlu7fj1i/ycc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ayxMxeSyv/OYT03vyw1xK68tkQSQBwgFYctChEQ110bPrhUbYPSkLChtWj/vnLf6ooJwo3pYCNFKb/WSehzvZB6AZ0gtU15iq3JdbhUY+0Y1M5srEIWOStlH6WWb9aYzGlwRRiZmlOK3unhticbu7+yOLqWc4Ad5NzrprPGFsBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=G9Gb9Wo2; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A94714000D;
	Fri, 28 Jun 2024 08:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719563544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8tG0Gf3/ayOMX1nsiE8dmm2OLilLLfJ1kVbKcOdcWgc=;
	b=G9Gb9Wo2kxHls5K4sjfzF7LUQNIXai66n39n6ZKlePLrkKmZJtZBSm8mDSP0hRSQ8c2G0Y
	2CyMoezTd01BdT3Iv/lLR2Ty0fhrDnE4gEquJkTnfkW0NLMBYMR1G9rmOo9XrJGYzh21q8
	LS5LWZ4T8FFhqK+jwfkXY8Fg1jAkZefQSTYDK3K03UM4cD1o2zTgWO9t9doPstVCQ365GB
	XY5+rauXzdSF4CM4SDxIZKFpzFaMnV1kYF1+kQ/PrHlL8/Zc+S5j/Oy9To3px1syXsHC6X
	a6krfOSlNnsX9MBzBduIuvF7LmKkLtfVNuT2HD+cBYc11x0+/PUs6VoegCAyGA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 28 Jun 2024 10:31:59 +0200
Subject: [PATCH net-next v5 6/7] netlink: specs: Expand the PSE netlink
 command with C33 pw-limit attributes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240628-feature_poe_power_cap-v5-6-5e1375d3817a@bootlin.com>
References: <20240628-feature_poe_power_cap-v5-0-5e1375d3817a@bootlin.com>
In-Reply-To: <20240628-feature_poe_power_cap-v5-0-5e1375d3817a@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 linux-doc@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Expand the c33 PSE attributes with power limit to be able to set and get
the PSE Power Interface power limit.

./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do pse-get
             --json '{"header":{"dev-name":"eth1"}}'
{'c33-pse-actual-pw': 1700,
 'c33-pse-admin-state': 3,
 'c33-pse-avail-pw-limit': 97500,
 'c33-pse-pw-class': 4,
 'c33-pse-pw-d-status': 4,
 'c33-pse-pw-limit-ranges': [{'max': 18100, 'min': 15000},
                             {'max': 38000, 'min': 30000},
                             {'max': 65000, 'min': 60000},
                             {'max': 97500, 'min': 90000}],
 'header': {'dev-index': 5, 'dev-name': 'eth1'}}

./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do pse-set
             --json '{"header":{"dev-name":"eth1"},
                      "c33-pse-avail-pw-limit":19000}'
None

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v4:
- Add support for c33 pse power limit ranges.
---
 Documentation/netlink/specs/ethtool.yaml | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 820cff47722d..411458d97911 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -935,6 +935,15 @@ attribute-sets:
       -
         name: power-mode
         type: u8
+  -
+    name: c33-pse-pw-limit
+    attributes:
+      -
+        name: min
+        type: u32
+      -
+        name: max
+        type: u32
   -
     name: pse
     attributes:
@@ -983,6 +992,16 @@ attribute-sets:
         name: c33-pse-ext-substate
         type: u32
         name-prefix: ethtool-a-
+      -
+        name: c33-pse-avail-pw-limit
+        type: u32
+        name-prefix: ethtool-a-
+      -
+        name: c33-pse-pw-limit-ranges
+        name-prefix: ethtool-a-
+        type: nest
+        multi-attr: true
+        nested-attributes: c33-pse-pw-limit
   -
     name: rss
     attributes:
@@ -1678,6 +1697,8 @@ operations:
             - c33-pse-actual-pw
             - c33-pse-ext-state
             - c33-pse-ext-substate
+            - c33-pse-avail-pw-limit
+            - c33-pse-pw-limit-ranges
       dump: *pse-get-op
     -
       name: pse-set
@@ -1691,6 +1712,7 @@ operations:
             - header
             - podl-pse-admin-control
             - c33-pse-admin-control
+            - c33-pse-avail-pw-limit
     -
       name: rss-get
       doc: Get RSS params.

-- 
2.34.1


