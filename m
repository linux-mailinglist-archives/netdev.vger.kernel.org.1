Return-Path: <netdev+bounces-294801-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GkFSDc1FIGopzwAAu9opvQ
	(envelope-from <netdev+bounces-294801-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 17:18:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 526F16390CA
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 17:18:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=6wind.com header.s=google header.b="gS//dVsU";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294801-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294801-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=6wind.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0AD630F7C68
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 15:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F61A39734B;
	Wed,  3 Jun 2026 15:03:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f98.google.com (mail-lf1-f98.google.com [209.85.167.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7713911C1
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 15:03:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499017; cv=none; b=KBVJv4H7s51NaDPVvqOSRJ2k8pg5+tl9Jb4D/lPTceHeb3oJyk6myxRPJolsvkRrnPw0qH7KFg2YChHe66k3tbSIbN/Qwnd2u1fSnbMerFZM5Z7nONTBPw8lhZurN+SjeMdDYoEkf25K1Y3W6nhCn8wK1UF3rEmJs+RDiZHmfNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499017; c=relaxed/simple;
	bh=cBKuZNK42FFNn13NofscQJDfMTcwOf5X/8Ha45GnJZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zd6AeHLC7UNIZmsYr44R9G3pWYJnPntd2ZovHUV/HCWaOaN4FgmlJPPQvj7xBA8Mmf687BvMl0YtzNAKmwGdFiHrmz9J0PdO8k0lpZ2AU1KJpbpdO9g0RzblNobGETNXyMcIv934i8dkOg0uwC2qJ15QutE/X8mDAn65K2zvjXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=gS//dVsU; arc=none smtp.client-ip=209.85.167.98
Received: by mail-lf1-f98.google.com with SMTP id 2adb3069b0e04-5aa68cd8dd3so4045844e87.0
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 08:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1780499013; x=1781103813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xBVM1Uqs/T5OLz+zY+IyGjR1BoC3xhsK5SaLPAfB8mE=;
        b=gS//dVsUOJhXy5hOlDlhHMgmQywif4rOq96eAgGPoTrFP9bn435e6ME0Jo36JCC9/H
         aGDrKP0zHVMmD21vNc9w7g2ShvJMCYGRDmrt4UnAXAW2sTtn8XSooM1xv9I1ev/Cl1cv
         ODcfdxFMlj5C3nFr5n/W1hADxds2eSR8wxDfCncpyWxckN5VzphMHahEJNBd5h/YqLQx
         L3l1+vpdu4CTmQ5JVDXLWW8lMc/kr+bIGQmjzomO598CJVewRjMhntYZoFQ3iXp72YyQ
         p43NTFUc0NlguR3/BNYoxCWpgjRZ3gcfu2P08BzoOLtlSYupusw0x+t0JlMg4vdu+HN/
         Tg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780499013; x=1781103813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xBVM1Uqs/T5OLz+zY+IyGjR1BoC3xhsK5SaLPAfB8mE=;
        b=WkeNgN3fXnz5lF4DGlXrViR6xtLl3uXyXINBNRhadfF5ElhU+3yzqOlGvGG4IWcBIh
         Ytl0MxHHaOGDTwqCKbZOSk6iRCJdMXDRiVaUxJPFtxgxmmcRUUOEsRDxi0LDfjotMdw6
         QLyeBsZlIJlg5mKNNG/8JOfWIsftN7q8z/7oeiw7uCb80C9lMvP4gZZPG7IyfnR8Z5iC
         QCrUAp7B0uuz7yZIraNkr5DWv0NzWDaVz1UJaWeoX3p/4hzzQvVaMs+Eyj4TERuc4r1S
         2Fj1ya8lv9maJ+AfAY5oz+6nfEUPK68lzO1aP63sN9LzJsT8RChUG/Q10x1jCV8sBecU
         Leow==
X-Gm-Message-State: AOJu0YzTADbrsR7IHblOTN5AsrBXFyocjz4nWWiFpkct2TkI3y9F8UJG
	gsMGBc/2y1b0umfXNbkaaaJnFn6xVsoiEKqqpN3heIVbilBkDYZsJGiv9HJfQ4BofZA50pLdbA2
	PGJZmFjXXVCyFUFaFk3IH0mhvSUQTSleBPxo7
X-Gm-Gg: Acq92OF9/7LrzufozV2g0gzLZIK/uEGb1qaZiu4TbrV/QQOoHEqSigKAHCZek2NI1N9
	MnBaFlkSzPjr85D6hdnvWlC8ipD5mzuQvOlaCIQ4z44m8CJbqHfQ18Qu1saAPevQxpHUa7XPm5Y
	m4gWAjM1KP7No0QJvsKwjULnrzaJT4ROImWCnNgaJXe1qDCNcwD7dDIybPWzamSxN9h1iI99X0d
	d/PQw9s4n3cWqIxHpaUiuUPISB5pplO98k/hoEfvFKjtNCmhQT7cmK6BCwwfRfpz0l1LHFDmtmU
	omu3i+6oLi3DOeS2EFqeBgxJDa7D/wyYw0DB5AIkh/5EOPX2FFj6oNfj5aMO0vN7LZL7jYHxCfI
	bba2rXAPk/elmX4Ycld3sN3gUjuRJyGCC9dxL5K6Itrp4FE1l0yL3XTLk9dHuafA=
X-Received: by 2002:a05:6512:4058:10b0:5aa:7363:8215 with SMTP id 2adb3069b0e04-5aa7c0dcce3mr1068256e87.27.1780499013570;
        Wed, 03 Jun 2026 08:03:33 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 2adb3069b0e04-5aa7b8fc304sm192404e87.16.2026.06.03.08.03.33;
        Wed, 03 Jun 2026 08:03:33 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id F368A14712;
	Wed,  3 Jun 2026 17:03:32 +0200 (CEST)
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
	horms@kernel.org,
	Louis Scalbert <louis.scalbert@6wind.com>
Subject: [PATCH net v8 3/6] bonding: 3ad: add lacp_strict configuration knob
Date: Wed,  3 Jun 2026 17:03:28 +0200
Message-Id: <20260603150331.1919611-4-louis.scalbert@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260603150331.1919611-1-louis.scalbert@6wind.com>
References: <20260603150331.1919611-1-louis.scalbert@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294801-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[lunn.ch,jvosburgh.net,google.com,kernel.org,redhat.com,greyhouse.net,vyatta.com,gmail.com,6wind.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:jv@jvosburgh.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:fbl@redhat.com,m:andy@greyhouse.net,m:shemminger@vyatta.com,m:maheshb@google.com,m:jonas.gorski@gmail.com,m:horms@kernel.org,m:louis.scalbert@6wind.com,m:andrew@lunn.ch,m:jonasgorski@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,6wind.com:mid,6wind.com:dkim,6wind.com:from_mime,6wind.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 526F16390CA

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
 Documentation/netlink/specs/rt-link.yaml |  3 +++
 Documentation/networking/bonding.rst     | 23 +++++++++++++++++++++
 drivers/net/bonding/bond_main.c          |  1 +
 drivers/net/bonding/bond_netlink.c       | 16 +++++++++++++++
 drivers/net/bonding/bond_options.c       | 26 ++++++++++++++++++++++++
 include/net/bond_options.h               |  1 +
 include/net/bonding.h                    |  1 +
 include/uapi/linux/if_link.h             |  1 +
 tools/include/uapi/linux/if_link.h       |  1 +
 9 files changed, 73 insertions(+)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index 484e0a97b653..644a8bd7b93c 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -1354,6 +1354,9 @@ attribute-sets:
       -
         name: broadcast-neigh
         type: u8
+      -
+        name: lacp-strict
+        type: u8
   -
     name: bond-ad-info-attrs
     name-prefix: ifla-bond-ad-info-
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
index 82e779f7916b..ec25b83309ec 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -6446,6 +6446,7 @@ static int __init bond_check_params(struct bond_params *params)
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
 
diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index 97a2d4411534..757ce5e9426e 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -1527,6 +1527,7 @@ enum {
 	IFLA_BOND_NS_IP6_TARGET,
 	IFLA_BOND_COUPLED_CONTROL,
 	IFLA_BOND_BROADCAST_NEIGH,
+	IFLA_BOND_LACP_STRICT,
 	__IFLA_BOND_MAX,
 };
 
-- 
2.39.2


