Return-Path: <netdev+bounces-140492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCEF9B6A01
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 18:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0F28B20F06
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 17:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9154922AD8E;
	Wed, 30 Oct 2024 16:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PAHTytHD"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197672296FB;
	Wed, 30 Oct 2024 16:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730307258; cv=none; b=q3NQtmCr3H7Cz7wPXoPTixuNkC24t5sO4IB1xFPZfbjchMTCQqdF+PwT1ED/ntHR67itRKFIkxgVPeeucVLUrFKam8r1PExmz/nzlKa44YEUpt7EfuvDA3g6Fx4xHg9YfTqZ2m1CLrWlQBm6JAqUkQ6M53xAzbDfpV3J1GqJWVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730307258; c=relaxed/simple;
	bh=qX+YkhDlPG//wL/JH9DiVb0gpnB3cmnkUkvSYjhEkoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k4w7Dm6I/myHGUhqNfsvZKVKNR2t/bimfTnsG8CyOZ7N3iD66dkatFktB5P7MmOwdHfij7om8q2Gdwes7GG2O4lK+ovq6TRoAz+UEv3kW5MYaVfpAoyoxH8IoJSQOKhpC0YuseLX0iirPnpcNfBE7TPwVR1Iu6FqYN3uucktv88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PAHTytHD; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1E2E7C000F;
	Wed, 30 Oct 2024 16:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730307253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1THR6bEa4LkLlafXsbuPr+6IzTBnW5zq/DBbHrAtWpE=;
	b=PAHTytHD1g4mccSWs8mgYgd77IiXsLljhYXFDJzgtNo3W077wFvA1l3H20kTFX7y9vDxiY
	LezGhmZAhsg21/iRkcO2D9WW6ho1+wmgxGS7qTf58anyUuWwjkDFuPaqP1573dfFnWeZj6
	GuLtoEjtnxQNvbITh1nJ/55et0YOh6IWB3rx/AyEAxOgwHTZ8F4l2XH56PxMj+WyaDp/ze
	u9y858X53yifrwH7ALGuzz45XYdY+Zeels65BAn7Y77Ce0ivmVqhN+H63+ykSqJXeXeOLG
	3ktwwYvzEHWr1xGnkMbABmkrV8znOWFbPjqmGfuoxfIAb2C7LxvvtppdXq8xsw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 30 Oct 2024 17:53:18 +0100
Subject: [PATCH RFC net-next v2 16/18] net: ethtool: Add PSE new port
 priority support feature
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241030-feature_poe_port_prio-v2-16-9559622ee47a@bootlin.com>
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

This patch expands the status information provided by ethtool for PSE c33
with current port priority and max port priority. It also adds a call to
pse_ethtool_set_prio() and pse_ethtool_set_prio_mode() to configure the PSE
port priority and its mode.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v2:
- Improve port priority documentation.
- Add port priority modes.
---
 Documentation/networking/ethtool-netlink.rst | 63 ++++++++++++++++++++++++++++
 include/uapi/linux/ethtool_netlink.h         |  4 ++
 net/ethtool/pse-pd.c                         | 36 ++++++++++++++++
 3 files changed, 103 insertions(+)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 3573543ae5ad..5bb090455620 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1768,6 +1768,13 @@ Kernel response contents:
                                                       configuration ranges.
   ``ETHTOOL_A_PSE_ID``                           u32  Index of the PSE
   ``ETHTOOL_A_PSE_PW_D_ID``                      u32  Index of the PSE power domain
+  ``ETHTOOL_A_C33_PSE_PRIO_SUPP_MODES``          u32  priority modes supported
+  ``ETHTOOL_A_C33_PSE_PRIO_MODE``                u32  priority mode of the PSE
+                                                      currently configured
+  ``ETHTOOL_A_C33_PSE_PRIO_MAX``                 u32  priority maximum configurable
+                                                      on the PoE PSE
+  ``ETHTOOL_A_C33_PSE_PRIO``                     u32  priority of the PoE PSE
+                                                      currently configured
   ==========================================  ======  =============================
 
 When set, the optional ``ETHTOOL_A_PODL_PSE_ADMIN_STATE`` attribute identifies
@@ -1847,6 +1854,18 @@ controller.
 The ``ETHTOOL_A_PSE_PW_D_ID`` attribute identifies the index of PSE power
 domain.
 
+When set, the optional ``ETHTOOL_A_C33_PSE_PRIO_SUPP_MODES`` attribute
+identifies the priority mode supported by the C33 PSE.
+When set, the optional ``ETHTOOL_A_C33_PSE_PRIO_MODE`` attributes is used to
+identifies the currently configured C33 PSE priority mode.
+For a description of C33 PSE priority modes, see ``PSE_SET``.
+
+When set, the optional ``ETHTOOL_A_C33_PSE_PRIO_MAX`` attribute identifies
+the C33 PSE maximum priority value.
+When set, the optional ``ETHTOOL_A_C33_PSE_PRIO`` attributes is used to
+identifies the currently configured C33 PSE priority.
+For a description of C33 PSE priority attributes, see ``PSE_SET``.
+
 PSE_SET
 =======
 
@@ -1860,6 +1879,10 @@ Request contents:
   ``ETHTOOL_A_C33_PSE_ADMIN_CONTROL``        u32  Control PSE Admin state
   ``ETHTOOL_A_C33_PSE_AVAIL_PWR_LIMIT``      u32  Control PoE PSE available
                                                   power limit
+  ``ETHTOOL_A_C33_PSE_PRIO_MODE``            u32  Control priority mode of the
+                                                  PoE PSE
+  ``ETHTOOL_A_C33_PSE_PRIO``                 u32  Control priority of the
+                                                  PoE PSE
   ======================================  ======  =============================
 
 When set, the optional ``ETHTOOL_A_PODL_PSE_ADMIN_CONTROL`` attribute is used
@@ -1882,6 +1905,46 @@ various existing products that document power consumption in watts rather than
 classes. If power limit configuration based on classes is needed, the
 conversion can be done in user space, for example by ethtool.
 
+When set, the optional ``ETHTOOL_A_C33_PSE_PRIO_MODE`` attributes is used to
+control the C33 PSE priority mode. The available mode are:
+
+1. Static Method:
+
+   This method involves distributing power based on PD classification. It’s
+   straightforward and stable, with the PSE core keeping track of the budget
+   and subtracting the power requested by each PD’s class.
+
+   Advantages: Every PD gets its promised power at any time, which guarantees
+   reliability.
+
+   Disadvantages: PD classification steps are large, meaning devices request
+   much more power than they actually need. As a result, the power supply may
+   only operate at, say, 50% capacity, which is inefficient and wastes money.
+
+2. Dynamic Method:
+
+   This method monitors the current consumption per port and subtracts it from
+   the available power budget. When the budget is exceeded, lower-priority
+   ports are shut down. This method is managed by the PSE controller itself.
+
+   Advantages: This method optimizes resource utilization, saving costs.
+
+   Disadvantages: Low-priority devices may experience instability.
+
+When set, the optional ``ETHTOOL_A_C33_PSE_PRIO`` attributes is used to
+control the C33 PSE priority. Allowed priority value are between zero
+and the value of ``ETHTOOL_A_C33_PSE_PRIO_MAX`` attribute.
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
 RSS_GET
 =======
 
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 47784a165e8b..aaeb8a6eecee 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -973,6 +973,10 @@ enum {
 	ETHTOOL_A_C33_PSE_PW_LIMIT_RANGES,	/* nest - _C33_PSE_PW_LIMIT_* */
 	ETHTOOL_A_PSE_ID,			/* u32 */
 	ETHTOOL_A_PSE_PW_D_ID,			/* u32 */
+	ETHTOOL_A_C33_PSE_PRIO_SUPP_MODES,	/* u32 */
+	ETHTOOL_A_C33_PSE_PRIO_MODE,		/* u32 */
+	ETHTOOL_A_C33_PSE_PRIO_MAX,		/* u32 */
+	ETHTOOL_A_C33_PSE_PRIO,			/* u32 */
 
 	/* add new constants above here */
 	__ETHTOOL_A_PSE_CNT,
diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index 1288e8a2c3a7..13ba7534c833 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -112,6 +112,12 @@ static int pse_reply_size(const struct ethnl_req_info *req_base,
 		len += st->c33_pw_limit_nb_ranges *
 		       (nla_total_size(0) +
 			nla_total_size(sizeof(u32)) * 2);
+	if (st->c33_prio_mode)
+		/* _C33_PSE_PRIO_MODE */
+		len += nla_total_size(sizeof(u32));
+	if (st->c33_prio_max)
+		/* _C33_PSE_PRIO_MAX + _C33_PSE_PRIO */
+		len += nla_total_size(sizeof(u32)) * 2;
 
 	return len;
 }
@@ -209,6 +215,15 @@ static int pse_fill_reply(struct sk_buff *skb,
 	    pse_put_pw_limit_ranges(skb, st))
 		return -EMSGSIZE;
 
+	if (st->c33_prio_mode > 0 &&
+	    nla_put_u32(skb, ETHTOOL_A_C33_PSE_PRIO_MODE, st->c33_prio_mode))
+		return -EMSGSIZE;
+
+	if (st->c33_prio_max > 0 &&
+	    (nla_put_u32(skb, ETHTOOL_A_C33_PSE_PRIO_MAX, st->c33_prio_max) ||
+	     nla_put_u32(skb, ETHTOOL_A_C33_PSE_PRIO, st->c33_prio)))
+		return -EMSGSIZE;
+
 	return 0;
 }
 
@@ -230,6 +245,8 @@ const struct nla_policy ethnl_pse_set_policy[ETHTOOL_A_PSE_MAX + 1] = {
 		NLA_POLICY_RANGE(NLA_U32, ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED,
 				 ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED),
 	[ETHTOOL_A_C33_PSE_AVAIL_PW_LIMIT] = { .type = NLA_U32 },
+	[ETHTOOL_A_C33_PSE_PRIO_MODE] = { .type = NLA_U32 },
+	[ETHTOOL_A_C33_PSE_PRIO] = { .type = NLA_U32 },
 };
 
 static int
@@ -278,6 +295,25 @@ ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
 	if (ret)
 		return ret;
 
+	if (tb[ETHTOOL_A_C33_PSE_PRIO_MODE]) {
+		unsigned int prio_mode;
+
+		prio_mode = nla_get_u32(tb[ETHTOOL_A_C33_PSE_PRIO_MODE]);
+		ret = pse_ethtool_set_prio_mode(phydev->psec, info->extack,
+						prio_mode);
+		if (ret)
+			return ret;
+	}
+
+	if (tb[ETHTOOL_A_C33_PSE_PRIO]) {
+		unsigned int prio;
+
+		prio = nla_get_u32(tb[ETHTOOL_A_C33_PSE_PRIO]);
+		ret = pse_ethtool_set_prio(phydev->psec, info->extack, prio);
+		if (ret)
+			return ret;
+	}
+
 	if (tb[ETHTOOL_A_C33_PSE_AVAIL_PW_LIMIT]) {
 		unsigned int pw_limit;
 

-- 
2.34.1


