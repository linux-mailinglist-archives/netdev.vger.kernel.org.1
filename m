Return-Path: <netdev+bounces-193213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAE3AC2F19
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 12:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E666178560
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 10:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9E11EE007;
	Sat, 24 May 2025 10:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="anf/Z1e3"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A2B1EA7EB;
	Sat, 24 May 2025 10:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748084229; cv=none; b=uXQTss7uv+X6TrpQ42wx9UC5VflRGfGQ7/TkITjxBdKRIaTbl5EHboTB63osZ9RghqUGhQluQU8Q/8jU7vOWg2GcvEkaKXiTS+s/p+OAw36VzBnRewO1+HSXsjCXE2cChiITHQvMYsiD3pXAg5C2CEWx83Sijy0rXCUrFl/DvV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748084229; c=relaxed/simple;
	bh=u4pCWT73D02B84xdcDalM6ByuETyn08cPnEzf+l8USw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k9hARBaKvHB1jS+tMFfl4DRd9JEPYkCeGJWvlsfqQ1ooOGW/2nH0A5XtH2wi5tkJbNhTif6qvEM2aBw6sC8765n1KXbnJnvzwPnj4Mphw81heo0FoT7kmG/7mjmN5saQjWZWzRRj09PgO4GgpAxM0E7Aw93F/gNZaVhYbY0uImE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=anf/Z1e3; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4CA984397A;
	Sat, 24 May 2025 10:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1748084225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yYaJke8lt2hkKTSKnlPQPC0yT0kZjHMNjxfd0bzFsKU=;
	b=anf/Z1e3D/X4SrS00skO7ZRRr4PWbkI8QT2SYvxl7rzHTJcWFW/UGncJSQ1DTCU63JLVht
	4GKSiZjoHkA9mMIONsPW6PInEtXDe9pgHcy20TJplTtOVVfbUyOQsnpP6m2kwQaoTSXBu4
	9DSSxUJgoOCH0wN40TLzW/TQRfjVjkYxECLnxnlni67VZrmGJ+4RKIac/vTPH2cu4BRddc
	4O2J2GDUzyRlY3/J0LmiDxvMk+fLQwdYpbgfTBDegAJNcLQTZEg+/KkDAd3lv6nWsQgBHx
	eduIy5/AHwHbbkPgctgAk9IGTn2eVTsy/EYI3w+Vw27/zZMMokjTIu2i4vQesw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Sat, 24 May 2025 12:56:10 +0200
Subject: [PATCH net-next v12 08/13] net: ethtool: Add PSE port priority
 support feature
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250524-feature_poe_port_prio-v12-8-d65fd61df7a7@bootlin.com>
References: <20250524-feature_poe_port_prio-v12-0-d65fd61df7a7@bootlin.com>
In-Reply-To: <20250524-feature_poe_port_prio-v12-0-d65fd61df7a7@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdduudehgeculddtuddrgeefvddrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvefgvdfgkeetgfefgfegkedugffghfdtffeftdeuteehjedtvdelvddvleehtdevnecukfhppedvrgdtudemtggsudelmeekheekjeemjedutddtmegvieegsgemtgekrggsmegvvgekmeejvgeikeenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekheekjeemjedutddtmegvieegsgemtgekrggsmegvvgekmeejvgeikedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdejpdhrtghpthhtohepkhihlhgvrdhsfigvnhhsohhnsegvshhtrdhtvggthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtp
 hhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthh
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

This patch expands the status information provided by ethtool for PSE c33
with current port priority and max port priority. It also adds a call to
pse_ethtool_set_prio() to configure the PSE port priority.

Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
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
index bb09aa4ed1ba..baf71541521e 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -1434,6 +1434,14 @@ attribute-sets:
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
@@ -2258,6 +2266,8 @@ operations:
             - c33-pse-avail-pw-limit
             - c33-pse-pw-limit-ranges
             - pse-pw-d-id
+            - pse-prio-max
+            - pse-prio
       dump: *pse-get-op
     -
       name: pse-set
@@ -2272,6 +2282,7 @@ operations:
             - podl-pse-admin-control
             - c33-pse-admin-control
             - c33-pse-avail-pw-limit
+            - pse-prio
     -
       name: rss-get
       doc: Get RSS params.
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index e9af8e58564c..e45bb555e909 100644
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
index c6a95224be25..8e5d067e7ddf 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -671,6 +671,8 @@ enum {
 	ETHTOOL_A_C33_PSE_AVAIL_PW_LIMIT,
 	ETHTOOL_A_C33_PSE_PW_LIMIT_RANGES,
 	ETHTOOL_A_PSE_PW_D_ID,
+	ETHTOOL_A_PSE_PRIO_MAX,
+	ETHTOOL_A_PSE_PRIO,
 
 	__ETHTOOL_A_PSE_CNT,
 	ETHTOOL_A_PSE_MAX = (__ETHTOOL_A_PSE_CNT - 1)
diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index 6cc0beee2882..7f57963797f1 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -111,6 +111,9 @@ static int pse_reply_size(const struct ethnl_req_info *req_base,
 		len += st->c33_pw_limit_nb_ranges *
 		       (nla_total_size(0) +
 			nla_total_size(sizeof(u32)) * 2);
+	if (st->prio_max)
+		/* _PSE_PRIO_MAX + _PSE_PRIO */
+		len += nla_total_size(sizeof(u32)) * 2;
 
 	return len;
 }
@@ -205,6 +208,11 @@ static int pse_fill_reply(struct sk_buff *skb,
 	    pse_put_pw_limit_ranges(skb, st))
 		return -EMSGSIZE;
 
+	if (st->prio_max > 0 &&
+	    (nla_put_u32(skb, ETHTOOL_A_PSE_PRIO_MAX, st->prio_max) ||
+	     nla_put_u32(skb, ETHTOOL_A_PSE_PRIO, st->prio)))
+		return -EMSGSIZE;
+
 	return 0;
 }
 
@@ -226,6 +234,7 @@ const struct nla_policy ethnl_pse_set_policy[ETHTOOL_A_PSE_MAX + 1] = {
 		NLA_POLICY_RANGE(NLA_U32, ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED,
 				 ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED),
 	[ETHTOOL_A_C33_PSE_AVAIL_PW_LIMIT] = { .type = NLA_U32 },
+	[ETHTOOL_A_PSE_PRIO] = { .type = NLA_U32 },
 };
 
 static int
@@ -274,6 +283,15 @@ ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
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
2.43.0


