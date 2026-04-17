Return-Path: <netdev+bounces-279324-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNuNFDs+4mmB3wAAu9opvQ
	(envelope-from <netdev+bounces-279324-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 16:05:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CA441BDA5
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 16:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 276A4301BAFF
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 14:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEB33A63FE;
	Fri, 17 Apr 2026 14:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="ZBuB5wEO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f97.google.com (mail-lf1-f97.google.com [209.85.167.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66267398918
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 14:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776434711; cv=none; b=Brdk0FMNVzx95pGibR1o3bmQ4mSZuv/LSY3+HZFlWwSvf8BB9rFuuPlXnP1k+iL2TTm2iYPEBdY6DoEultn5WFahkLgDVTUvEiwlJcDiwb3RrMkTJTxsbFQ2A4xMewjpSq2b1b5R5hwWR1yLudFDn2BU3D49SGkVlnVYnOOWWzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776434711; c=relaxed/simple;
	bh=cEpx0Don6pMAi92D81yyzGWxajAgs2//3gz+P7snQ6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n0XtLAIeA9l+D61vn//MMH762DDMw6pOgpj0HTuxRrX8zK7WFPiSSy21n7a+YO33Xur9GYy1mCDfU8zEbqxom27V2biCq3hp93Auu3BBN2CvJhv35xsWbdqSQaZxNWlfALBYnI4pTbDeL6ZtpV1Fg4X//7j9IPdqMmIdyHgWQ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=ZBuB5wEO; arc=none smtp.client-ip=209.85.167.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lf1-f97.google.com with SMTP id 2adb3069b0e04-5a3cee3a271so827182e87.3
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 07:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1776434708; x=1777039508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QG8BKNV4TFmLYxp8HgRdfek95ugBWEzNvmV3Q6w3fF4=;
        b=ZBuB5wEOmRPeg51xY6bZPPvzTT3TdKzVxmCu0xxJNUPJWaqjZvFuMeBWuiIxWAVGi/
         NF1Tr1M/vAJkfJER4NRr/oY1IF/qy+8EX68hbkQ+dF5piWalL1mygX8vFlSHcvic5WT7
         1i1qUNRJdVM0c93nDmLjeA0YrWH7yri+k2J0zMANnnDkCcR9vexGBHZsegUrB/eDYmiB
         5zZJ3J0uOFKvqdmESfb4kCn7zSmOrU3lLg3BPw94xlkI1XbvgJnA+yMHqhM1nsjjyRry
         FOjuTmXX0lcmj4Srct8PSqmd88IfDjqgyoeCQrksYFAoDppM8QwMXP8I3e+gYiGHAbM6
         Oh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776434708; x=1777039508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QG8BKNV4TFmLYxp8HgRdfek95ugBWEzNvmV3Q6w3fF4=;
        b=N560SqeId7BZNWIv64A6I4GXSWbP4NAWpKmR0JZ6TKE26c0OkGGJYBv8nDftWmCArb
         9m91JftdnSPczXZ/oyTZS/NThPlPPJIFwFGau67SP8KB6gsdDD+5erVXs7VbzghFxCrq
         z20E/uIaT0FyIVluE6fUnTj51Lou7A94vXBON+w4UdF0Lfu/uP6JKOQqa4HAfArio/Lu
         3nCf8lmjiUGLZwyBmuTLAOpxqMS53KuIbKKZVODcwclEP0eLwQX1TnXV2kzYcHgu/byP
         NKE6j/mJcwV4jE3xBI5ZB01LHG6+n56qHjRMoV4FHG9g6HQ+uDWJfIAznIP72iaqDxy+
         RdkA==
X-Gm-Message-State: AOJu0YwdAI4aRG1u2FIJmI23cCaLR6c6U077SOp76h9l//vY3qqt+5Oa
	ht5xqKdS2Xe1Tp4vFL+UUOjlo1bioLLfPcBxe/kZRyYVC8qJzsrjUkiTwXT9slnXGvjKf6ne3Jd
	BQQsrKmBMEJ73sO075ouiXH3Ii9/3Rz885C9n
X-Gm-Gg: AeBDievhwhfPltqRSSg9lE8VOZzN7hNpy0rZskwvz0XkiHCZMpVZtCe7u0Gz9DDEVvX
	/y5nd7soHtsAu2mxYxZFD60vv+Sc4BpEADZnqeBidM18gvm/V3F4XtFXLfW5Mvuye8JA/gaCH4+
	P5SX5WFvPB21fwyVxZmbUF9ExcbPal7hx17pvvxj8was6E7NOxgdGjP987pX2WEAaBMaOosR3aF
	xAp1TRVonqygXNZSFX2/HW/IpdrdNztzPpibIztVwTUbVsrUyhTvLy6x3ykHR81q8feES2tm1Px
	i7o8cAIICBPrIhZ7gcBtQXm6cMkqwY7jNIUW3lJg4ue8By9pqvZsAO7GYPTleR4J1pQ8PFa3yQP
	W810KwodhWPmilAeqXm2ZRN0Vg7vff7yJ0VZ+c2zl0jT3HFDpREVeaMsTMAh5i8g=
X-Received: by 2002:a05:6512:3e18:b0:5a4:157:5342 with SMTP id 2adb3069b0e04-5a4172eeb07mr1029764e87.39.1776434707495;
        Fri, 17 Apr 2026 07:05:07 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 2adb3069b0e04-5a4185b10c2sm114515e87.1.2026.04.17.07.05.07;
        Fri, 17 Apr 2026 07:05:07 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id 250BB1364E;
	Fri, 17 Apr 2026 16:05:07 +0200 (CEST)
From: Louis Scalbert <louis.scalbert@6wind.com>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	andrew+netdev@lunn.ch,
	jv@jvosburgh.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	fbl@redhat.com,
	andy@greyhouse.net,
	shemminger@vyatta.com,
	maheshb@google.com,
	Louis Scalbert <louis.scalbert@6wind.com>
Subject: [PATCH net v4 1/4] bonding: 3ad: add lacp_strict configuration knob
Date: Fri, 17 Apr 2026 16:05:02 +0200
Message-Id: <20260417140505.3860237-2-louis.scalbert@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260417140505.3860237-1-louis.scalbert@6wind.com>
References: <20260417140505.3860237-1-louis.scalbert@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279324-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[6wind.com:email,6wind.com:dkim,6wind.com:mid]
X-Rspamd-Queue-Id: 38CA441BDA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When an 802.3ad (LACP) bonding interface has no slaves in the
collecting/distributing state, the bonding master still reports
carrier as up as long as at least 'min_links' slaves have carrier.

In this situation, only one slave is effectively used for TX/RX,
while traffic received on other slaves is dropped. Upper-layer
daemons therefore consider the interface operational, even though
traffic may be blackholed if the lack of LACP negotiation means
the partner is not ready to deal with traffic.

Introduce a configuration knob to control this behavior. It allows
the bonding master to assert carrier only when at least 'min_links'
slaves are in Collecting_Distributing state.

The default mode preserves the existing behavior. This patch only
introduces the knob; its behavior is implemented in the subsequent
commit.

Fixes: 655f8919d549 ("bonding: add min links parameter to 802.3ad")
Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
---
 Documentation/networking/bonding.rst | 23 +++++++++++++++++++++++
 drivers/net/bonding/bond_main.c      |  1 +
 drivers/net/bonding/bond_netlink.c   | 16 ++++++++++++++++
 drivers/net/bonding/bond_options.c   | 26 ++++++++++++++++++++++++++
 include/net/bond_options.h           |  1 +
 include/net/bonding.h                |  1 +
 include/uapi/linux/if_link.h         |  1 +
 7 files changed, 69 insertions(+)

diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
index e700bf1d095c..33ca5afafdf6 100644
--- a/Documentation/networking/bonding.rst
+++ b/Documentation/networking/bonding.rst
@@ -619,6 +619,29 @@ min_links
 	aggregator cannot be active without at least one available link,
 	setting this option to 0 or to 1 has the exact same effect.
 
+lacp_strict
+
+	Specifies the fallback behavior of a bonding when LACP negotiation
+	fails on all slave links, i.e. when no slave is in the
+	Collecting_Distributing state, while at least `min_links` link still
+	reports carrier up.
+
+	This option is only applicable to 802.3ad mode (mode 4).
+
+	Valid values are:
+
+	off or 0
+		One interface of the bond is selected to be active, in order to
+		facilitate communication with peer devices that do not implement
+		LACP.
+
+	on or 1
+		Interfaces are only permitted to be made active if they have an
+		active LACP partner and have successfully reached
+		Collecting_Distributing state.
+
+	The default value is 0 (off).
+
 mode
 
 	Specifies one of the bonding policies. The default is
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index c7baa5c4bf40..b1a446630d1d 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -6438,6 +6438,7 @@ static int __init bond_check_params(struct bond_params *params)
 	params->ad_user_port_key = ad_user_port_key;
 	params->coupled_control = 1;
 	params->broadcast_neighbor = 0;
+	params->lacp_strict = 0;
 	if (packets_per_slave > 0) {
 		params->reciprocal_packets_per_slave =
 			reciprocal_value(packets_per_slave);
diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index ea1a80e658ae..4b8207df4810 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -139,6 +139,7 @@ static const struct nla_policy bond_policy[IFLA_BOND_MAX + 1] = {
 	[IFLA_BOND_NS_IP6_TARGET]	= { .type = NLA_NESTED },
 	[IFLA_BOND_COUPLED_CONTROL]	= { .type = NLA_U8 },
 	[IFLA_BOND_BROADCAST_NEIGH]	= { .type = NLA_U8 },
+	[IFLA_BOND_LACP_STRICT]		= { .type = NLA_U8 },
 };
 
 static const struct nla_policy bond_slave_policy[IFLA_BOND_SLAVE_MAX + 1] = {
@@ -595,6 +596,16 @@ static int bond_changelink(struct net_device *bond_dev, struct nlattr *tb[],
 			return err;
 	}
 
+	if (data[IFLA_BOND_LACP_STRICT]) {
+		int fallback_mode = nla_get_u8(data[IFLA_BOND_LACP_STRICT]);
+
+		bond_opt_initval(&newval, fallback_mode);
+		err = __bond_opt_set(bond, BOND_OPT_LACP_STRICT, &newval,
+				     data[IFLA_BOND_LACP_STRICT], extack);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
@@ -667,6 +678,7 @@ static size_t bond_get_size(const struct net_device *bond_dev)
 		nla_total_size(sizeof(struct in6_addr)) * BOND_MAX_NS_TARGETS +
 		nla_total_size(sizeof(u8)) +	/* IFLA_BOND_COUPLED_CONTROL */
 		nla_total_size(sizeof(u8)) +	/* IFLA_BOND_BROADCAST_NEIGH */
+		nla_total_size(sizeof(u8)) +	/* IFLA_BOND_LACP_STRICT */
 		0;
 }
 
@@ -834,6 +846,10 @@ static int bond_fill_info(struct sk_buff *skb,
 		       bond->params.broadcast_neighbor))
 		goto nla_put_failure;
 
+	if (nla_put_u8(skb, IFLA_BOND_LACP_STRICT,
+		       bond->params.lacp_strict))
+		goto nla_put_failure;
+
 	if (BOND_MODE(bond) == BOND_MODE_8023AD) {
 		struct ad_info info;
 
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 7380cc4ee75a..d358b831df77 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -68,6 +68,8 @@ static int bond_option_lacp_active_set(struct bonding *bond,
 				       const struct bond_opt_value *newval);
 static int bond_option_lacp_rate_set(struct bonding *bond,
 				     const struct bond_opt_value *newval);
+static int bond_option_lacp_strict_set(struct bonding *bond,
+				       const struct bond_opt_value *newval);
 static int bond_option_ad_select_set(struct bonding *bond,
 				     const struct bond_opt_value *newval);
 static int bond_option_queue_id_set(struct bonding *bond,
@@ -162,6 +164,12 @@ static const struct bond_opt_value bond_lacp_rate_tbl[] = {
 	{ NULL,   -1,           0},
 };
 
+static const struct bond_opt_value bond_lacp_strict_tbl[] = {
+	{ "off", 0, BOND_VALFLAG_DEFAULT},
+	{ "on",  1, 0},
+	{ NULL, -1, 0 }
+};
+
 static const struct bond_opt_value bond_ad_select_tbl[] = {
 	{ "stable",          BOND_AD_STABLE,    BOND_VALFLAG_DEFAULT},
 	{ "bandwidth",       BOND_AD_BANDWIDTH, 0},
@@ -363,6 +371,14 @@ static const struct bond_option bond_opts[BOND_OPT_LAST] = {
 		.values = bond_lacp_rate_tbl,
 		.set = bond_option_lacp_rate_set
 	},
+	[BOND_OPT_LACP_STRICT] = {
+		.id = BOND_OPT_LACP_STRICT,
+		.name = "lacp_strict",
+		.desc = "Define the LACP fallback mode when no slaves have negotiated",
+		.unsuppmodes = BOND_MODE_ALL_EX(BIT(BOND_MODE_8023AD)),
+		.values = bond_lacp_strict_tbl,
+		.set = bond_option_lacp_strict_set
+	},
 	[BOND_OPT_MINLINKS] = {
 		.id = BOND_OPT_MINLINKS,
 		.name = "min_links",
@@ -1684,6 +1700,16 @@ static int bond_option_lacp_rate_set(struct bonding *bond,
 	return 0;
 }
 
+static int bond_option_lacp_strict_set(struct bonding *bond,
+				       const struct bond_opt_value *newval)
+{
+	netdev_dbg(bond->dev, "Setting LACP fallback to %s (%llu)\n",
+		   newval->string, newval->value);
+	bond->params.lacp_strict = newval->value;
+
+	return 0;
+}
+
 static int bond_option_ad_select_set(struct bonding *bond,
 				     const struct bond_opt_value *newval)
 {
diff --git a/include/net/bond_options.h b/include/net/bond_options.h
index e6eedf23aea1..52b966e92793 100644
--- a/include/net/bond_options.h
+++ b/include/net/bond_options.h
@@ -79,6 +79,7 @@ enum {
 	BOND_OPT_COUPLED_CONTROL,
 	BOND_OPT_BROADCAST_NEIGH,
 	BOND_OPT_ACTOR_PORT_PRIO,
+	BOND_OPT_LACP_STRICT,
 	BOND_OPT_LAST
 };
 
diff --git a/include/net/bonding.h b/include/net/bonding.h
index edd1942dcd73..2c54a36a8477 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -129,6 +129,7 @@ struct bond_params {
 	int peer_notif_delay;
 	int lacp_active;
 	int lacp_fast;
+	int lacp_strict;
 	unsigned int min_links;
 	int ad_select;
 	char primary[IFNAMSIZ];
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 79ce4bc24cba..9ef5784e78e8 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1584,6 +1584,7 @@ enum {
 	IFLA_BOND_NS_IP6_TARGET,
 	IFLA_BOND_COUPLED_CONTROL,
 	IFLA_BOND_BROADCAST_NEIGH,
+	IFLA_BOND_LACP_STRICT,
 	__IFLA_BOND_MAX,
 };
 
-- 
2.39.2


