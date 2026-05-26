Return-Path: <netdev+bounces-291592-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIjdETleFWp7UgcAu9opvQ
	(envelope-from <netdev+bounces-291592-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:47:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD17D5D2A1E
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F683301691B
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 08:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1323CF03E;
	Tue, 26 May 2026 08:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="S4unqwyB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f98.google.com (mail-ed1-f98.google.com [209.85.208.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21C03CC7F1
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 08:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779784869; cv=none; b=dnjJnU1Wav27CMifM+EvmttNcpfbFUW3Z4GJ40kGDGhOHk3w2VUM6ucGdicxSU2azCFBZrbNlWxWNV8SPzonwP/GwcMtgySQleiYd/UsZKPRIlOLGjYKdOYkESUzIzvOhTCmYSGK6UkEtGQWnuDohex3BmXlC0Fvh1hDozlv9os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779784869; c=relaxed/simple;
	bh=GYuXJ9Vm/28VjZptSyEhd4FK0xpmqCRLQ4fXTv4e8lQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FA1P2lOjpexONjpm8bwg01SBVcvEcGv+Mc13L4TIOmPa062U1qkGqhm2R27h/gU9VtIm6+1X8QvWmtHb0wZ/PDs+Cy8xexrqxeSO+0COMx8erFBk7UYogx72lf62ORh0LX9vlXe3o0pgY/Ofp/SS0nSVE5kAEz7qkqXId3B0b3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=S4unqwyB; arc=none smtp.client-ip=209.85.208.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ed1-f98.google.com with SMTP id 4fb4d7f45d1cf-689be822f34so2490967a12.0
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 01:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1779784865; x=1780389665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxdcVFB303ZcJhJcZZi3mhOGTJFkYPO8SnYV/NSnmlY=;
        b=S4unqwyB5wE0VhbwM6P42i3xfxY6P3tann6ltLM+OQmrlSOHwc7qlZfwG6Lixdpgy+
         crrpILOpqUYTI8d8R57us3YxYESCgZjL16KIfgXfG4uZPMwwkwWNK5yUkYkWbCc65WDU
         uLnlnpBUNFa5NT0n3d3hsKKkfZKNw6BsSZeHZg16hjQJbcgK7Nmg9pyFgCe1dA4U/AQY
         ntBjvC4eC50taUEFZjzbUdxVE23Ybow10DXzVj1HwI8IdZXNgAgbFO2mCquNhsCQ/oP8
         0CzKd3yO8JEq0GnVL7CfENol8K3+QzPsCGfW7/P9tAptbH5sWuz3/DEYprTOy0rM0zhR
         /7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779784865; x=1780389665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AxdcVFB303ZcJhJcZZi3mhOGTJFkYPO8SnYV/NSnmlY=;
        b=ak81rQ8Bhx5GF2t2ePXzXHJEPecF9eaJOd8fFYgADI9gB2SWjUB04Xh624OKfGQq6Y
         DqY394dtIufjxkBj5WJLBs2kEut9kptQ96u4OyZGGpZm6gy7i7EJIS08YxbYud14pPrM
         5xEqDzvc3OUvXvrGvLhmSaG68d2oxE36UXG0nIZkNqfx7o55gZ04sokY9dR9fvmz8vss
         LlwfwJoYI73Nprtv1FRSPCYHKYiVbscN0tQVzdw992h1s5cXtdyo6ks336lWTHhuS1dS
         t616Rk+JVRcqPNhijHMZo5ubQQuh6IbSMqKJgcMWWgr1k6vR46UaIVUZnn0MsNYXHmpM
         zg1g==
X-Gm-Message-State: AOJu0YzTQjqpDbYDAqcKAsRZ7o9Ek8lXoRqIa/FYoaklaT0F7krLQAe8
	ZZC3+ApL0aTnpC5x/LEJcO9gJ7MSjdIGLru2H04GEH9hERwtZcI7Vg5+CCdWJbLDGBw7LxttrpV
	Ff5cPiWmkWp28nejdsDfv6qMQ/I9nR488jS5W
X-Gm-Gg: Acq92OEaTeDV+Orggx0N/wKWUcUOekfP07naS45wVGUJQHJffNN1NOdpqZ9RqvMPFr9
	0GmIJkrX1f+GgdLp+hYW3pKqYINfTMwi8NqyKQnANLJq/Pyruna8f8DOWsG4O+HS2XxjHc7xwOp
	5yEvK90BQaLKsMPIOA4s4nYd9Y00tBYSaNI+yFIBHGu2twbHaxpWF6zdW3onC+viNfEZ1CiYqjD
	Y/qxZZ0RurHoaqQkonFrJfiq6u32v8hP/NiebA7WD1goUSBsyCtQgEdM8hTjSWLMdbzyXkmBPDW
	7/0rXR8aR4yDw7t4i/XHprNC2gTssbYi9+++2dtE/C4AUt7XdFuPTsNRkwXtXVMWkcSM3U3OMjI
	WjoZEz/sWveyP0rbRSR/wjqsywjR8pDJrHmfnXWpumAGDYIhN6bURuIk6GQKJ1X4=
X-Received: by 2002:a05:6402:158c:b0:687:50d3:d9e0 with SMTP id 4fb4d7f45d1cf-6889cc3f224mr9335989a12.20.1779784865344;
        Tue, 26 May 2026 01:41:05 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 4fb4d7f45d1cf-688b997cc99sm548523a12.1.2026.05.26.01.41.05;
        Tue, 26 May 2026 01:41:05 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id 2FBB9124B0;
	Tue, 26 May 2026 10:41:05 +0200 (CEST)
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
Subject: [PATCH net v7 3/6] bonding: 3ad: add lacp_strict configuration knob
Date: Tue, 26 May 2026 10:40:45 +0200
Message-Id: <20260526084048.1696544-4-louis.scalbert@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260526084048.1696544-1-louis.scalbert@6wind.com>
References: <20260526084048.1696544-1-louis.scalbert@6wind.com>
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
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,jvosburgh.net,google.com,kernel.org,redhat.com,greyhouse.net,vyatta.com,gmail.com,6wind.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-291592-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: BD17D5D2A1E
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


