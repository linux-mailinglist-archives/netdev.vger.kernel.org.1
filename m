Return-Path: <netdev+bounces-284942-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAc/Atxo+2miawMAu9opvQ
	(envelope-from <netdev+bounces-284942-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 18:14:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 257644DDEEC
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 18:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B46973002924
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 16:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B98E47F2EE;
	Wed,  6 May 2026 16:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="YDgt2gi+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f226.google.com (mail-lj1-f226.google.com [209.85.208.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA2D494A11
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 16:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778083922; cv=none; b=n0pK1GEqrp99utHx4ha8bB6i6w/XiEoYfp/rCLew7hru9MX0dDz3S2XHFCn9VKwoUmvmOfkcDpTGK707e1z8lCFqZKBVBKMgGFwiu5btR5eAjiPBJii0CWzFm+osrBn86vdof480DUEQUSWi0buEpgvAzSYKWLvPhxffGFfvjhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778083922; c=relaxed/simple;
	bh=w5H5H5se+iNw3RncZ3NaCSd3Cm8v/iMPlcFDsQwyDII=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TAQpl4zY3iaHn1pMTJWBIfCo+HTnyqthU4tAfZG19+5dy3turV5CjOPW4FypxUstIVe9Mxj9kE6efF+1W62/03/SCO+5wuYPZZN/0VMEXsY8ks8AQz2eyOSa57o6ODlL4GaKMAaqVihLVnvn4xTsqHoLpUN4VeyZ9jE3lv8trXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=YDgt2gi+; arc=none smtp.client-ip=209.85.208.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lj1-f226.google.com with SMTP id 38308e7fff4ca-393d07e8938so4489981fa.2
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 09:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1778083908; x=1778688708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JK9NpicNdp8Oo2+f4hW2RjNWCARjbbXxTRDC/jJkFhk=;
        b=YDgt2gi+AaPVYkpV2ilPDe3Gc1KMHqccc0EQtT6dOboIyWNJ+WvYxkyeQMJznRJwlx
         VZGCrRuz3FzRO1hiOzkxDNonUXueCUYbWoYpZaVwQuHaRBNU3GkhbjzS4xEVlfqErXvE
         sP9lWKIiF7TwQD9QTzrulSaO1nEGa90KR2mt0QtrdZp7/+pcLSndfH2dTRgNbcIDNREc
         kj93Ylwf6JD1iOqPyBxNaMcUArUNAkjs/p5wAZfi/heUpRO/Q8j16w4IPCOT2qllvpNy
         MWsOepi5STUwPjbm+Y6i+QrQK5hCQypI86ww0V3JE2ndDnqoyGtjPuPhRg2fGfO4fhVx
         37oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778083908; x=1778688708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JK9NpicNdp8Oo2+f4hW2RjNWCARjbbXxTRDC/jJkFhk=;
        b=QyeHQwk801Fb3bz5TOOEosyL69wYKQCBHvxmPOLlBfy8RbjfiCT6fFL+bqzBtBmPkS
         +ZiU2ugWG2otovQqg5mXEvdf9uCmc6vuKSlOvd7O0Y4fXzpC1/wwGIFLJhJ9QKdS1Zv+
         z0X2DHuLwPKP4cXFpi0O8vQBXlFE6neYPfu0ehSII3vhrYih1bNQ/nLnvEOrncxZA7eG
         /OIAZr0z40fXLgB1QnenCxFHbZDuOEJGi6vChthRyEQ7Yd0lTzu64X5e6eiqAHy6kS3l
         PdnKX7dz9o6m99NTNGTTR2pwCzP8PtaAejoUbTJPjQTDqK8zooJxDVYBnfqs6vj73KTX
         2qWw==
X-Gm-Message-State: AOJu0YxaZDvHOqu9qfQUqQWsz9x3IrHLp0KexA/elqZUDlW1qj8B78a6
	8i9DAGo8/h+tayzvYXh418w41Fahxq9IN/x8quk+zvcrBtTZ4Xd/xL+oWN1WkvouXuRZyJU3M6C
	K2HXMSckAyxqF5V5eRo296N/E9hXxIr8uLB92
X-Gm-Gg: AeBDievaiZmRz8/wPXhv32B53WU2QPGuRbhCq2HHsP5ktqXqn48f6DaUXko+U6pNK42
	lCWRCY/6jiWMrVT1zA6af1QdBbooNxwSfs+DM4NaMRPR65SLYbleaLoT9EaRltW0zoCLFFIedBR
	DpO03GkO79MWnTfgenUWrIhBT0yodb1I6HaoszZZVF1glqHDVkcV53kHDb2/xYwurnPGCr5T6lg
	8t3Tqy5LAkoCw6uP/HZLdv6AKVwIcHb+UL5x34l5pOfgKXDZ9OU3HZvoZs9W97V/oLqsQqzLhwB
	olIrF2ZLc0ZVpbVzM3NNgK9g+LBCpXp6dG7p50Bbs5Pf7bXmPSp271GKee0USEEce4idj3HSzyL
	3PP/YEFOiyM3HtTxfqSOMLFcpJPT0oTalRHWurOQiaN8JsGR9ou+IQlTAM/XWFWU=
X-Received: by 2002:a05:651c:4183:b0:393:cdf0:7c26 with SMTP id 38308e7fff4ca-393cdf0a1c9mr8973111fa.3.1778083908398;
        Wed, 06 May 2026 09:11:48 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 38308e7fff4ca-393611156c0sm11487821fa.1.2026.05.06.09.11.48;
        Wed, 06 May 2026 09:11:48 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id 0CE711755C;
	Wed,  6 May 2026 18:11:48 +0200 (CEST)
From: Louis Scalbert <louis.scalbert@6wind.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	jv@jvosburgh.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	fbl@redhat.com,
	andy@greyhouse.net,
	shemminger@vyatta.com,
	maheshb@google.com,
	jonas.gorski@gmail.com,
	Louis Scalbert <louis.scalbert@6wind.com>
Subject: [PATCH net v5 1/4] bonding: 3ad: add lacp_strict configuration knob
Date: Wed,  6 May 2026 18:11:41 +0200
Message-Id: <20260506161144.465485-2-louis.scalbert@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260506161144.465485-1-louis.scalbert@6wind.com>
References: <20260506161144.465485-1-louis.scalbert@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 257644DDEEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,jvosburgh.net,google.com,kernel.org,redhat.com,greyhouse.net,vyatta.com,gmail.com,6wind.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-284942-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,6wind.com:email,6wind.com:dkim,6wind.com:mid]

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
index af82a3df2c5d..47d7ce3240da 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -6440,6 +6440,7 @@ static int __init bond_check_params(struct bond_params *params)
 	params->ad_user_port_key = ad_user_port_key;
 	params->coupled_control = 1;
 	params->broadcast_neighbor = 0;
+	params->lacp_strict = 0;
 	if (packets_per_slave > 0) {
 		params->reciprocal_packets_per_slave =
 			reciprocal_value(packets_per_slave);
diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index c7d3e0602c83..08d4d0814f67 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -143,6 +143,7 @@ static const struct nla_policy bond_policy[IFLA_BOND_MAX + 1] = {
 	[IFLA_BOND_NS_IP6_TARGET]	= { .type = NLA_NESTED },
 	[IFLA_BOND_COUPLED_CONTROL]	= { .type = NLA_U8 },
 	[IFLA_BOND_BROADCAST_NEIGH]	= { .type = NLA_U8 },
+	[IFLA_BOND_LACP_STRICT]		= { .type = NLA_U8 },
 };
 
 static const struct nla_policy bond_slave_policy[IFLA_BOND_SLAVE_MAX + 1] = {
@@ -599,6 +600,16 @@ static int bond_changelink(struct net_device *bond_dev, struct nlattr *tb[],
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
 
@@ -671,6 +682,7 @@ static size_t bond_get_size(const struct net_device *bond_dev)
 		nla_total_size(sizeof(struct in6_addr)) * BOND_MAX_NS_TARGETS +
 		nla_total_size(sizeof(u8)) +	/* IFLA_BOND_COUPLED_CONTROL */
 		nla_total_size(sizeof(u8)) +	/* IFLA_BOND_BROADCAST_NEIGH */
+		nla_total_size(sizeof(u8)) +	/* IFLA_BOND_LACP_STRICT */
 		0;
 }
 
@@ -838,6 +850,10 @@ static int bond_fill_info(struct sk_buff *skb,
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


