Return-Path: <netdev+bounces-180308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B51A80E65
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 16:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C9A41BA80D0
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 14:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59A422CBC1;
	Tue,  8 Apr 2025 14:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TLNIgnO+"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7936E2236FC;
	Tue,  8 Apr 2025 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744122768; cv=none; b=mRUWFBOlasjOXIBKeELpispO2GYQHuLKfJp1JkUBzfiOiBT5e7e41U0yfhGHh/oZKae5oYLkP0gxdSDrLcaappM1lxrS+/eB4kKeeDruqyR+UqBGPxrRRhU55DFE+CgzWrv3vC4AVzhf/I5FRr25B8ZT9eUxujf4/vCA5DE6sik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744122768; c=relaxed/simple;
	bh=kGsXN25MF5gR2Dcb6V434fYrrb46r5vmJ176my5Zc04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j4R/9nKhJI+z1daQefC01DzVjzfbGVd/EBOd3MfbyEosccu0gr5F5KlLxJCGLHXFeSukGTqgiqu/k2pUQvbVkZVLwnRZyAsrpRl2Kg4Skqw4mtdO+SmJcyOG4wTCUB944sFmjIYahhAnQSPPYUUMyCrZu0Zfi/+SC0fdB5OMOkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TLNIgnO+; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E0659441D2;
	Tue,  8 Apr 2025 14:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744122763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D7XsMAZ/bY3AXgiHfs0mec7RZx05gzFYeVzX97wp8Gk=;
	b=TLNIgnO+Koz8/orwhQ1r15fQ5NrgGqXde794RXI6XKJ7eljhFUNLrNQVj/Krxr+JHLSWcd
	6AayUmDjLESdaEE4EGTYcu36t8XsSKKzLM6BCHJrDx8TzJHwRkVYAk77UghJw7JCO6vjU0
	QSvj51GY03Hvhx97JHIE9l4KUaug6tUmPAXfVPyldlbw6rBqhai6ReMnZk/Jv6p6PcNUfR
	1pKXg8oRtK5Hc5/6NIqxycdKB1MB1ZpdWvgGVbkTYkIc6R7v7irNrmVApwmlbPf30N0eJC
	QlXlMrhia0Q5rOVvVi415ZCili4OLsyMIVp0+Gx9CNl51v4sK/7iTUmiIWvmBQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 08 Apr 2025 16:32:17 +0200
Subject: [PATCH net-next v7 08/13] net: ethtool: Add PSE port priority
 support feature
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-feature_poe_port_prio-v7-8-9f5fc9e329cd@bootlin.com>
References: <20250408-feature_poe_port_prio-v7-0-9f5fc9e329cd@bootlin.com>
In-Reply-To: <20250408-feature_poe_port_prio-v7-0-9f5fc9e329cd@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeffeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgfdvgfektefgfefggeekudfggffhtdfffedtueetheejtddvledvvdelhedtveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvjedprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkhihlvgdrshifvghnshhonhesvghsthdrthgvtghhpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughonhgrlhgurdhhuhhnthgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehordhrvghmphgvlhesphgvnhhguhhtrhhonhhig
 idruggvpdhrtghpthhtoheplhhinhhugidqughotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

This patch expands the status information provided by ethtool for PSE c33
with current port priority and max port priority. It also adds a call to
pse_ethtool_set_prio() to configure the PSE port priority.

Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
---
Change in v6:
- Remove c33 standard reference from new netlink field in documentation.
- Remove report of budget evaluation strategy.

Change in v4:
- Remove disconnection policy features.
- Rename port priority to budget evaluation strategy.

Change in v3:
- Add disconnection policy.

Change in v2:
- Improve port priority documentation.
- Add port priority modes.
---
 Documentation/netlink/specs/ethtool.yaml       | 11 +++++++++++
 Documentation/networking/ethtool-netlink.rst   | 26 ++++++++++++++++++++++++++
 include/uapi/linux/ethtool_netlink_generated.h |  2 ++
 net/ethtool/pse-pd.c                           | 18 ++++++++++++++++++
 4 files changed, 57 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 93e470895dc1..814aa54b35b5 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -1379,6 +1379,14 @@ attribute-sets:
         name: pse-pw-d-id
         type: u32
         name-prefix: ethtool-a-
+      -
+        name: pse-prio-max
+        type: u32
+        name-prefix: ethtool-a-
+      -
+        name: pse-prio
+        type: u32
+        name-prefix: ethtool-a-
   -
     name: rss
     attr-cnt-name: __ethtool-a-rss-cnt
@@ -2200,6 +2208,8 @@ operations:
             - c33-pse-avail-pw-limit
             - c33-pse-pw-limit-ranges
             - pse-pw-d-id
+            - pse-prio-max
+            - pse-prio
       dump: *pse-get-op
     -
       name: pse-set
@@ -2214,6 +2224,7 @@ operations:
             - podl-pse-admin-control
             - c33-pse-admin-control
             - c33-pse-avail-pw-limit
+            - pse-prio
     -
       name: rss-get
       doc: Get RSS params.
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 49c9a0e79af5..efc410ae26c8 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1790,6 +1790,10 @@ Kernel response contents:
   ``ETHTOOL_A_C33_PSE_PW_LIMIT_RANGES``       nested  Supported power limit
                                                       configuration ranges.
   ``ETHTOOL_A_PSE_PW_D_ID``                      u32  Index of the PSE power domain
+  ``ETHTOOL_A_PSE_PRIO_MAX``                     u32  Priority maximum configurable
+                                                      on the PoE PSE
+  ``ETHTOOL_A_PSE_PRIO``                         u32  Priority of the PoE PSE
+                                                      currently configured
   ==========================================  ======  =============================
 
 When set, the optional ``ETHTOOL_A_PODL_PSE_ADMIN_STATE`` attribute identifies
@@ -1866,6 +1870,12 @@ equal.
 The ``ETHTOOL_A_PSE_PW_D_ID`` attribute identifies the index of PSE power
 domain.
 
+When set, the optional ``ETHTOOL_A_PSE_PRIO_MAX`` attribute identifies
+the PSE maximum priority value.
+When set, the optional ``ETHTOOL_A_PSE_PRIO`` attributes is used to
+identifies the currently configured PSE priority.
+For a description of PSE priority attributes, see ``PSE_SET``.
+
 PSE_SET
 =======
 
@@ -1879,6 +1889,8 @@ Request contents:
   ``ETHTOOL_A_C33_PSE_ADMIN_CONTROL``        u32  Control PSE Admin state
   ``ETHTOOL_A_C33_PSE_AVAIL_PWR_LIMIT``      u32  Control PoE PSE available
                                                   power limit
+  ``ETHTOOL_A_PSE_PRIO``                     u32  Control priority of the
+                                                  PoE PSE
   ======================================  ======  =============================
 
 When set, the optional ``ETHTOOL_A_PODL_PSE_ADMIN_CONTROL`` attribute is used
@@ -1901,6 +1913,20 @@ various existing products that document power consumption in watts rather than
 classes. If power limit configuration based on classes is needed, the
 conversion can be done in user space, for example by ethtool.
 
+When set, the optional ``ETHTOOL_A_PSE_PRIO`` attributes is used to
+control the PSE priority. Allowed priority value are between zero and
+the value of ``ETHTOOL_A_PSE_PRIO_MAX`` attribute.
+
+A lower value indicates a higher priority, meaning that a priority value
+of 0 corresponds to the highest port priority.
+Port priority serves two functions:
+
+ - Power-up Order: After a reset, ports are powered up in order of their
+   priority from highest to lowest. Ports with higher priority
+   (lower values) power up first.
+ - Shutdown Order: When the power budget is exceeded, ports with lower
+   priority (higher values) are turned off first.
+
 PSE_NTF
 =======
 
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index ccd7ab3bf1b1..0220cd83728a 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -634,6 +634,8 @@ enum {
 	ETHTOOL_A_C33_PSE_AVAIL_PW_LIMIT,
 	ETHTOOL_A_C33_PSE_PW_LIMIT_RANGES,
 	ETHTOOL_A_PSE_PW_D_ID,
+	ETHTOOL_A_PSE_PRIO_MAX,
+	ETHTOOL_A_PSE_PRIO,
 
 	__ETHTOOL_A_PSE_CNT,
 	ETHTOOL_A_PSE_MAX = (__ETHTOOL_A_PSE_CNT - 1)
diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index f73d4fbe82e6..44dbff8c99f8 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -112,6 +112,9 @@ static int pse_reply_size(const struct ethnl_req_info *req_base,
 		len += st->c33_pw_limit_nb_ranges *
 		       (nla_total_size(0) +
 			nla_total_size(sizeof(u32)) * 2);
+	if (st->prio_max)
+		/* _PSE_PRIO_MAX + _PSE_PRIO */
+		len += nla_total_size(sizeof(u32)) * 2;
 
 	return len;
 }
@@ -206,6 +209,11 @@ static int pse_fill_reply(struct sk_buff *skb,
 	    pse_put_pw_limit_ranges(skb, st))
 		return -EMSGSIZE;
 
+	if (st->prio_max > 0 &&
+	    (nla_put_u32(skb, ETHTOOL_A_PSE_PRIO_MAX, st->prio_max) ||
+	     nla_put_u32(skb, ETHTOOL_A_PSE_PRIO, st->prio)))
+		return -EMSGSIZE;
+
 	return 0;
 }
 
@@ -227,6 +235,7 @@ const struct nla_policy ethnl_pse_set_policy[ETHTOOL_A_PSE_MAX + 1] = {
 		NLA_POLICY_RANGE(NLA_U32, ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED,
 				 ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED),
 	[ETHTOOL_A_C33_PSE_AVAIL_PW_LIMIT] = { .type = NLA_U32 },
+	[ETHTOOL_A_PSE_PRIO] = { .type = NLA_U32 },
 };
 
 static int
@@ -275,6 +284,15 @@ ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
 	if (ret)
 		return ret;
 
+	if (tb[ETHTOOL_A_PSE_PRIO]) {
+		unsigned int prio;
+
+		prio = nla_get_u32(tb[ETHTOOL_A_PSE_PRIO]);
+		ret = pse_ethtool_set_prio(phydev->psec, info->extack, prio);
+		if (ret)
+			return ret;
+	}
+
 	if (tb[ETHTOOL_A_C33_PSE_AVAIL_PW_LIMIT]) {
 		unsigned int pw_limit;
 

-- 
2.34.1


