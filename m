Return-Path: <netdev+bounces-155091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 714E9A00F94
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 22:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAEDC3A4F29
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 21:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA17A1FF7D0;
	Fri,  3 Jan 2025 21:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Wo5pEyT7"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76591FF1B2;
	Fri,  3 Jan 2025 21:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735938882; cv=none; b=pz9c+sj/Vwg8S1JQr/A174khkv3KwLbEMdGos1frn9/MJJplyPzmd/ux7s0ah4HiYqplCcZC+6SXsp2KgeTZ/VZkhGadjD03mtjr9zp77IjFIkFAz4qNqgiC0a450lkr3SZNatPh8NygpoMojvq317OYHTIvr9Sa3w4fKaIpWJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735938882; c=relaxed/simple;
	bh=We8pqe0itTArvXUt5A847EiReel9udjgms1iWea/3qw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ogcZ9UX6gDy3elMxVQfgwvzs+Ke1h0FG5qJUSMp7hmYdeVIUq47kaRMaSVggwCde+3MOAlgZZs7EXGrYaqieHykYWfY3EqwVKfXu/A6s8dOsVTedfdkitUOk23+I5RI/kLAQoYZU1EsUTKJM2gmVGO5JS9Ma/rEK7RAxB4gP+U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Wo5pEyT7; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2426AFF806;
	Fri,  3 Jan 2025 21:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735938877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4gvV3r+Z6W26eUz+xGVZR3F/DUEuKcbvgqB7wgJvqEo=;
	b=Wo5pEyT7qQH6lNxSA19Ooyga0EOFMc8TE7SZtnM7enTTUPovYuqG6unRdfa7kJ32J168HH
	ZpniCEUvJvcL3p75vMcp1u7BLFMdn8w8MOtN3ekB4/mhZq8v1+fWimCOdzdorcOGK7tqkm
	GJqMuYYjvMa6veVGf51RAQVliGV7XUu3WGJQs4++4In/X0awb1avHqdbrIMWWPmU9s1Bdl
	doNc9Lg1NqflPNN6ksuzqqqa4kSepCTtakWoTnbqLEsugJC8bTycOQoID7RdNFSmZZhHdJ
	2Et51s7Q6JFNi9A+Fa5IuQdjAIWgt+smz+62F/cve2LLA3csQvEUfG5tfDQEPw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 03 Jan 2025 22:13:12 +0100
Subject: [PATCH net-next v4 23/27] net: ethtool: Add PSE new budget
 evaluation strategy support feature
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250103-feature_poe_port_prio-v4-23-dc91a3c0c187@bootlin.com>
References: <20250103-feature_poe_port_prio-v4-0-dc91a3c0c187@bootlin.com>
In-Reply-To: <20250103-feature_poe_port_prio-v4-0-dc91a3c0c187@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 devicetree@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

This patch expands the status information provided by ethtool for PSE c33
with current port priority and max port priority. It also adds a call to
pse_ethtool_set_prio() to configure the PSE port priority.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v4:
- Remove disconnection policy features.
- Rename port priority to budget evaluation strategy.

Change in v3:
- Add disconnection policy.

Change in v2:
- Improve port priority documentation.
- Add port priority modes.
---
 Documentation/netlink/specs/ethtool.yaml       | 16 ++++++
 Documentation/networking/ethtool-netlink.rst   | 67 ++++++++++++++++++++++++++
 include/uapi/linux/ethtool_netlink_generated.h |  3 ++
 net/ethtool/pse-pd.c                           | 26 ++++++++++
 4 files changed, 112 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 686181440d58..22913f6857d9 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -1365,6 +1365,18 @@ attribute-sets:
         name: pse-pw-d-id
         type: u32
         name-prefix: ethtool-a-
+      -
+        name: pse-budget-eval-strat
+        type: u32
+        name-prefix: ethtool-a-
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
@@ -2188,6 +2200,9 @@ operations:
             - c33-pse-pw-limit-ranges
             - pse-id
             - pse-pw-d-id
+            - pse-budget-eval-strat
+            - pse-prio-max
+            - pse-prio
       dump: *pse-get-op
     -
       name: pse-set
@@ -2202,6 +2217,7 @@ operations:
             - podl-pse-admin-control
             - c33-pse-admin-control
             - c33-pse-avail-pw-limit
+            - pse-prio
     -
       name: rss-get
       doc: Get RSS params.
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 68c0cfcea127..102a173764de 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1774,6 +1774,12 @@ Kernel response contents:
                                                       configuration ranges.
   ``ETHTOOL_A_PSE_ID``                           u32  Index of the PSE
   ``ETHTOOL_A_PSE_PW_D_ID``                      u32  Index of the PSE power domain
+  ``ETHTOOL_A_C33_PSE_BUDGET_EVAL_STRAT``        u32  Budget evaluation strategy
+                                                      of the PSE
+  ``ETHTOOL_A_C33_PSE_PRIO_MAX``                 u32  Priority maximum configurable
+                                                      on the PoE PSE
+  ``ETHTOOL_A_C33_PSE_PRIO``                     u32  Priority of the PoE PSE
+                                                      currently configured
   ==========================================  ======  =============================
 
 When set, the optional ``ETHTOOL_A_PODL_PSE_ADMIN_STATE`` attribute identifies
@@ -1853,6 +1859,51 @@ controller.
 The ``ETHTOOL_A_PSE_PW_D_ID`` attribute identifies the index of PSE power
 domain.
 
+When set, the optional ``ETHTOOL_A_C33_PSE_PRIO_SUPP_MODES`` attribute
+identifies the priority mode supported by the C33 PSE.
+When set, the optional ``ETHTOOL_A_C33_PSE_BUDGET_EVAL_STRAT`` attributes is used to
+identifies the currently configured C33 PSE budget evaluation strategy.
+The available strategies are:
+
+1. Disabled:
+
+   In this mode, the port is excluded from active budget evaluation. It
+   allows the port to violate the budget and is intended primarily for testing
+   purposes.
+
+2. Static Method:
+
+   This method involves distributing power based on PD classification. It’s
+   straightforward and stable, with the PSE core keeping track of the budget
+   and subtracting the power requested by each PD’s class. This is the
+   safest option and should be used by default.
+
+   Advantages: Every PD gets its promised power at any time, which guarantees
+   reliability.
+
+   Disadvantages: PD classification steps are large, meaning devices request
+   much more power than they actually need. As a result, the power supply may
+   only operate at, say, 50% capacity, which is inefficient and wastes money.
+
+3. Dynamic Method:
+
+   This method monitors the current consumption per port and subtracts it from
+   the available power budget. When the budget is exceeded, lower-priority
+   ports are shut down. This method is managed by the PSE controller itself.
+
+   Advantages: This method optimizes resource utilization, saving costs.
+
+   Disadvantages: Low-priority devices may experience instability.
+
+.. kernel-doc:: include/uapi/linux/ethtool.h
+    :identifiers: ethtool_pse_budget_eval_strategies
+
+When set, the optional ``ETHTOOL_A_C33_PSE_PRIO_MAX`` attribute identifies
+the C33 PSE maximum priority value.
+When set, the optional ``ETHTOOL_A_C33_PSE_PRIO`` attributes is used to
+identifies the currently configured C33 PSE priority.
+For a description of PSE priority attributes, see ``PSE_SET``.
+
 PSE_SET
 =======
 
@@ -1866,6 +1917,8 @@ Request contents:
   ``ETHTOOL_A_C33_PSE_ADMIN_CONTROL``        u32  Control PSE Admin state
   ``ETHTOOL_A_C33_PSE_AVAIL_PWR_LIMIT``      u32  Control PoE PSE available
                                                   power limit
+  ``ETHTOOL_A_C33_PSE_PRIO``                 u32  Control priority of the
+                                                  PoE PSE
   ======================================  ======  =============================
 
 When set, the optional ``ETHTOOL_A_PODL_PSE_ADMIN_CONTROL`` attribute is used
@@ -1888,6 +1941,20 @@ various existing products that document power consumption in watts rather than
 classes. If power limit configuration based on classes is needed, the
 conversion can be done in user space, for example by ethtool.
 
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
 PSE_NTF
 =======
 
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index 1ec5a0838f50..120d88e245b8 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -632,6 +632,9 @@ enum {
 	ETHTOOL_A_C33_PSE_PW_LIMIT_RANGES,
 	ETHTOOL_A_PSE_ID,
 	ETHTOOL_A_PSE_PW_D_ID,
+	ETHTOOL_A_PSE_BUDGET_EVAL_STRAT,
+	ETHTOOL_A_PSE_PRIO_MAX,
+	ETHTOOL_A_PSE_PRIO,
 
 	__ETHTOOL_A_PSE_CNT,
 	ETHTOOL_A_PSE_MAX = (__ETHTOOL_A_PSE_CNT - 1)
diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index 00b97712767d..7f9a8515659a 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -113,6 +113,12 @@ static int pse_reply_size(const struct ethnl_req_info *req_base,
 		len += st->c33_pw_limit_nb_ranges *
 		       (nla_total_size(0) +
 			nla_total_size(sizeof(u32)) * 2);
+	if (st->budget_eval_strategy)
+		/* _PSE_BUDGET_EVAL_STRAT */
+		len += nla_total_size(sizeof(u32));
+	if (st->prio_max)
+		/* _PSE_PRIO_MAX + _PSE_PRIO */
+		len += nla_total_size(sizeof(u32)) * 2;
 
 	return len;
 }
@@ -210,6 +216,16 @@ static int pse_fill_reply(struct sk_buff *skb,
 	    pse_put_pw_limit_ranges(skb, st))
 		return -EMSGSIZE;
 
+	if (st->budget_eval_strategy > 0 &&
+	    nla_put_u32(skb, ETHTOOL_A_PSE_BUDGET_EVAL_STRAT,
+			st->budget_eval_strategy))
+		return -EMSGSIZE;
+
+	if (st->prio_max > 0 &&
+	    (nla_put_u32(skb, ETHTOOL_A_PSE_PRIO_MAX, st->prio_max) ||
+	     nla_put_u32(skb, ETHTOOL_A_PSE_PRIO, st->prio)))
+		return -EMSGSIZE;
+
 	return 0;
 }
 
@@ -231,6 +247,7 @@ const struct nla_policy ethnl_pse_set_policy[ETHTOOL_A_PSE_MAX + 1] = {
 		NLA_POLICY_RANGE(NLA_U32, ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED,
 				 ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED),
 	[ETHTOOL_A_C33_PSE_AVAIL_PW_LIMIT] = { .type = NLA_U32 },
+	[ETHTOOL_A_PSE_PRIO] = { .type = NLA_U32 },
 };
 
 static int
@@ -279,6 +296,15 @@ ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
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


