Return-Path: <netdev+bounces-295885-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mx4rO2z0ImrZfgEAu9opvQ
	(envelope-from <netdev+bounces-295885-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 18:08:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E80A76499BA
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 18:08:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=G2LIbeMo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295885-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295885-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5FC5130151BC
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 15:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7528337B41C;
	Fri,  5 Jun 2026 15:50:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A650937B023
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 15:50:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780674640; cv=none; b=eC/OXWHLHrEdqEo6ztpOoDO6eVQDz9a/PnIB8jA9peMaY5Fq3fzqFmN4osh7TtbnbwhIOQIrQ41r+1gxwEl7y59Us4WISIfnlPa5hOmIGVDgMqoX0yo4bJfTmMTCfJum9Sp9+iNTNaC9iIl3CRx7CGDBJJ1ssA92COxukkik218=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780674640; c=relaxed/simple;
	bh=K2iR71Lz8pyajEU/oWkyuGMme6cKtNn6NZu0FGdrXqE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uXKZlcBTu5dzgw3QDZc775+mPtazZnUh3kIwDHMuX7aPqrbQrVT0F39tdPrvPGSlOMkkWAmn6p98c0/85BNUQncWabdokZoFUDK9gMOZnHWMM+cZA5NEpL7u54kQyFY/q2DTE1r3PRc5lohz97ATu8B/mawZ2xT8S7LEY1qoQRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G2LIbeMo; arc=none smtp.client-ip=209.85.219.74
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8ccd3213beaso42907306d6.0
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 08:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780674637; x=1781279437; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=opaO9Qy6PeHB1XuGQ1+OrP44QuAg4byUbrfbSy2Rp+s=;
        b=G2LIbeMoFGU18/2W/gDFNUqfLII9ivaY8K4LeCV8cZ+LsTtfutZbE2pzJQ4PRiezuy
         j5grDw4buulazCSoHUSmn962MNowp6RCuewRbxPfyApRJIHXKjXgwQpGQnpTA4oO3CJ2
         jJ6ajSNqL/FAEGRa2IeMYf+jRL99w0X4Zu8ZoMVVAy7r81L1coZa/8ZzU/SFjLL48+MT
         dlO8/G/tlFvh9nQPakrvnof9+1S5/HKObkFO1KXcxTUvJRF2gEiRt4Nqj//uVqLNAJbd
         nkXCwEZL6lOhYPr6urJkshrQQJC7RYa0r6w4znCis/oz3XQ7mXnXy+nipJrhgrvjC6D7
         /PWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780674637; x=1781279437;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=opaO9Qy6PeHB1XuGQ1+OrP44QuAg4byUbrfbSy2Rp+s=;
        b=OmgI1Ihkkpt6VoKlntHQpm9YIHSK8U1UcJOtxcR7yMiHYRh4zyU1X1d5+xXmC/KPJy
         FwX1WJG8eyhFE8/qcxG+S3H907GsNflNo9SXbBn+Zu4Wt8ySb35mkmuQ1dKkbUsm6Lho
         3q9oCM103dYIaBVsEQx7PaRuMsBacKHeOFGWbQg/RueJBK/HvPrcRf8H08tHKkKG27fz
         qbNm2H/6T1rKleVTaySJL+fhzVP5+KzBXTKSa7+eGcHm6Svkz2/fi9U4LmBb9ArNvTsr
         8IaL7q7AjZA31TD6fi1RY5+YHBogAPX4hNNj8HvvrogXhDfbiXlPwxJDopWsKKW0L4YI
         /0wA==
X-Forwarded-Encrypted: i=1; AFNElJ9q/SULUTj3Mlpyowk1jpNlw9Fedvi1606uf0DeByjOZclDliaGbAaDMXowtoi5R3zRzgSY/Is=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6PZ5iImQYfYrgSmQJcLvgU9jbb6xDLfwSaAMpPooSt1Igdnrh
	fb4+tD+Yf7Aj5aw76/pld30TKV0Iky7Ur/9wnEguxOrOvvU3ZRaaObt9LLRiC79Ffzz4BGnW0GS
	UDOggAGVzYUGsGw==
X-Received: from qvbne16.prod.google.com ([2002:a05:6214:4250:b0:8cc:eb71:e396])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a0c:e98f:0:b0:8ca:2413:607a with SMTP id 6a1803df08f44-8cee5fe51ecmr50364946d6.5.1780674637343;
 Fri, 05 Jun 2026 08:50:37 -0700 (PDT)
Date: Fri,  5 Jun 2026 15:50:34 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605155034.3844105-1-edumazet@google.com>
Subject: [PATCH net-next] bonding: no longer rely on RTNL in bond_fill_info()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Jay Vosburgh <jv@jvosburgh.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295885-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:jv@jvosburgh.net,m:andrew+netdev@lunn.ch,m:ericdumazet@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com,jvosburgh.net,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lunn.ch:email,jvosburgh.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E80A76499BA

Add READ_ONCE()/WRITE_ONCE() annotations on port->is_enabled.
While this field is written under bond->mode_lock protection,
is is read without this lock being held.

Change bond_fill_info() to acquire RCU and use READ_ONCE()
to read bond->params fields that can be updated concurrently
from sysfs/procfs/rtnetlink.

Add const qualifiers to bond_uses_primary(), __agg_active_ports(),
bond_option_active_slave_get_rcu(), bond_3ad_get_active_agg_info(),
__bond_3ad_get_active_agg_info() helpers.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jay Vosburgh <jv@jvosburgh.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
---
 drivers/net/bonding/bond_3ad.c     | 18 +++---
 drivers/net/bonding/bond_netlink.c | 90 ++++++++++++++++--------------
 drivers/net/bonding/bond_options.c |  4 +-
 include/net/bond_3ad.h             |  4 +-
 include/net/bonding.h              |  8 +--
 5 files changed, 65 insertions(+), 59 deletions(-)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 985ef66dc3331e89458c9951a222d140c2275fb9..090b13b1e83ae31c9dbca6ed92a7a62dfa17ed80 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -745,14 +745,14 @@ static void __set_agg_ports_ready(struct aggregator *aggregator, int val)
 	}
 }
 
-static int __agg_active_ports(struct aggregator *agg)
+static int __agg_active_ports(const struct aggregator *agg)
 {
-	struct port *port;
+	const struct port *port;
 	int active = 0;
 
 	for (port = agg->lag_ports; port;
 	     port = port->next_port_in_aggregator) {
-		if (port->is_enabled)
+		if (READ_ONCE(port->is_enabled))
 			active++;
 	}
 
@@ -2782,11 +2782,11 @@ void bond_3ad_handle_link_change(struct slave *slave, char link)
 	 * some of he adaptors(ce1000.lan) report.
 	 */
 	if (link == BOND_LINK_UP) {
-		port->is_enabled = true;
+		WRITE_ONCE(port->is_enabled, true);
 		ad_update_actor_keys(port, false);
 	} else {
 		/* link has failed */
-		port->is_enabled = false;
+		WRITE_ONCE(port->is_enabled, false);
 		ad_update_actor_keys(port, true);
 	}
 	agg = __get_first_agg(port);
@@ -2857,13 +2857,13 @@ int bond_3ad_set_carrier(struct bonding *bond)
  * Returns:   0 on success
  *          < 0 on error
  */
-int __bond_3ad_get_active_agg_info(struct bonding *bond,
+int __bond_3ad_get_active_agg_info(const struct bonding *bond,
 				   struct ad_info *ad_info)
 {
-	struct aggregator *aggregator = NULL, *tmp;
+	const struct aggregator *aggregator = NULL, *tmp;
+	const struct port *port;
 	struct list_head *iter;
 	struct slave *slave;
-	struct port *port;
 
 	bond_for_each_slave_rcu(bond, slave, iter) {
 		port = &(SLAVE_AD_INFO(slave)->port);
@@ -2886,7 +2886,7 @@ int __bond_3ad_get_active_agg_info(struct bonding *bond,
 	return 0;
 }
 
-int bond_3ad_get_active_agg_info(struct bonding *bond, struct ad_info *ad_info)
+int bond_3ad_get_active_agg_info(const struct bonding *bond, struct ad_info *ad_info)
 {
 	int ret;
 
diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index 90365d3f7ebff7f762b4cb10303a3dd3fdd49cc6..2d5558434c64ee5e1ef5144eae9287614cc16ac7 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -674,47 +674,45 @@ static size_t bond_get_size(const struct net_device *bond_dev)
 		0;
 }
 
-static int bond_option_active_slave_get_ifindex(struct bonding *bond)
+static int bond_option_active_slave_get_ifindex_rcu(const struct bonding *bond)
 {
 	const struct net_device *slave;
-	int ifindex;
 
-	rcu_read_lock();
 	slave = bond_option_active_slave_get_rcu(bond);
-	ifindex = slave ? slave->ifindex : 0;
-	rcu_read_unlock();
-	return ifindex;
+	return slave ? slave->ifindex : 0;
 }
 
 static int bond_fill_info(struct sk_buff *skb,
 			  const struct net_device *bond_dev)
 {
-	struct bonding *bond = netdev_priv(bond_dev);
-	unsigned int packets_per_slave;
-	int ifindex, i, targets_added;
+	const struct bonding *bond = netdev_priv(bond_dev);
+	int ifindex, i, targets_added, miimon, mode;
+	const struct slave *primary;
 	struct nlattr *targets;
-	struct slave *primary;
 
-	if (nla_put_u8(skb, IFLA_BOND_MODE, BOND_MODE(bond)))
+	rcu_read_lock();
+	mode = READ_ONCE(bond->params.mode);
+	if (nla_put_u8(skb, IFLA_BOND_MODE, mode))
 		goto nla_put_failure;
 
-	ifindex = bond_option_active_slave_get_ifindex(bond);
+	ifindex = bond_option_active_slave_get_ifindex_rcu(bond);
 	if (ifindex && nla_put_u32(skb, IFLA_BOND_ACTIVE_SLAVE, ifindex))
 		goto nla_put_failure;
 
-	if (nla_put_u32(skb, IFLA_BOND_MIIMON, bond->params.miimon))
+	miimon = READ_ONCE(bond->params.miimon);
+	if (nla_put_u32(skb, IFLA_BOND_MIIMON, miimon))
 		goto nla_put_failure;
 
 	if (nla_put_u32(skb, IFLA_BOND_UPDELAY,
-			bond->params.updelay * bond->params.miimon))
+			READ_ONCE(bond->params.updelay) * miimon))
 		goto nla_put_failure;
 
 	if (nla_put_u32(skb, IFLA_BOND_DOWNDELAY,
-			bond->params.downdelay * bond->params.miimon))
+			READ_ONCE(bond->params.downdelay) * miimon))
 		goto nla_put_failure;
 
 	if (nla_put_u32(skb, IFLA_BOND_PEER_NOTIF_DELAY,
-			bond->params.peer_notif_delay * bond->params.miimon))
+			READ_ONCE(bond->params.peer_notif_delay) * miimon))
 		goto nla_put_failure;
 
 	if (nla_put_u8(skb, IFLA_BOND_USE_CARRIER, 1))
@@ -729,8 +727,10 @@ static int bond_fill_info(struct sk_buff *skb,
 
 	targets_added = 0;
 	for (i = 0; i < BOND_MAX_ARP_TARGETS; i++) {
-		if (bond->params.arp_targets[i]) {
-			if (nla_put_be32(skb, i, bond->params.arp_targets[i]))
+		__be32 t = READ_ONCE(bond->params.arp_targets[i]);
+
+		if (t) {
+			if (nla_put_be32(skb, i, t))
 				goto nla_put_failure;
 			targets_added = 1;
 		}
@@ -741,11 +741,12 @@ static int bond_fill_info(struct sk_buff *skb,
 	else
 		nla_nest_cancel(skb, targets);
 
-	if (nla_put_u32(skb, IFLA_BOND_ARP_VALIDATE, bond->params.arp_validate))
+	if (nla_put_u32(skb, IFLA_BOND_ARP_VALIDATE,
+			READ_ONCE(bond->params.arp_validate)))
 		goto nla_put_failure;
 
 	if (nla_put_u32(skb, IFLA_BOND_ARP_ALL_TARGETS,
-			bond->params.arp_all_targets))
+			READ_ONCE(bond->params.arp_all_targets)))
 		goto nla_put_failure;
 
 #if IS_ENABLED(CONFIG_IPV6)
@@ -755,6 +756,9 @@ static int bond_fill_info(struct sk_buff *skb,
 
 	targets_added = 0;
 	for (i = 0; i < BOND_MAX_NS_TARGETS; i++) {
+		/* Note: IPv6 addresses can not be read in an atomic READ_ONCE() yet.
+		 * We accept this minor race for the moment.
+		 */
 		if (!ipv6_addr_any(&bond->params.ns_targets[i])) {
 			if (nla_put_in6_addr(skb, i, &bond->params.ns_targets[i]))
 				goto nla_put_failure;
@@ -768,93 +772,93 @@ static int bond_fill_info(struct sk_buff *skb,
 		nla_nest_cancel(skb, targets);
 #endif
 
-	primary = rtnl_dereference(bond->primary_slave);
+	primary = rcu_dereference(bond->primary_slave);
 	if (primary &&
 	    nla_put_u32(skb, IFLA_BOND_PRIMARY, primary->dev->ifindex))
 		goto nla_put_failure;
 
 	if (nla_put_u8(skb, IFLA_BOND_PRIMARY_RESELECT,
-		       bond->params.primary_reselect))
+		       READ_ONCE(bond->params.primary_reselect)))
 		goto nla_put_failure;
 
 	if (nla_put_u8(skb, IFLA_BOND_FAIL_OVER_MAC,
-		       bond->params.fail_over_mac))
+		       READ_ONCE(bond->params.fail_over_mac)))
 		goto nla_put_failure;
 
 	if (nla_put_u8(skb, IFLA_BOND_XMIT_HASH_POLICY,
-		       bond->params.xmit_policy))
+		       READ_ONCE(bond->params.xmit_policy)))
 		goto nla_put_failure;
 
 	if (nla_put_u32(skb, IFLA_BOND_RESEND_IGMP,
-			bond->params.resend_igmp))
+			READ_ONCE(bond->params.resend_igmp)))
 		goto nla_put_failure;
 
 	if (nla_put_u8(skb, IFLA_BOND_NUM_PEER_NOTIF,
-		       bond->params.num_peer_notif))
+		       READ_ONCE(bond->params.num_peer_notif)))
 		goto nla_put_failure;
 
 	if (nla_put_u8(skb, IFLA_BOND_ALL_SLAVES_ACTIVE,
-		       bond->params.all_slaves_active))
+		       READ_ONCE(bond->params.all_slaves_active)))
 		goto nla_put_failure;
 
 	if (nla_put_u32(skb, IFLA_BOND_MIN_LINKS,
-			bond->params.min_links))
+			READ_ONCE(bond->params.min_links)))
 		goto nla_put_failure;
 
 	if (nla_put_u32(skb, IFLA_BOND_LP_INTERVAL,
-			bond->params.lp_interval))
+			READ_ONCE(bond->params.lp_interval)))
 		goto nla_put_failure;
 
-	packets_per_slave = bond->params.packets_per_slave;
 	if (nla_put_u32(skb, IFLA_BOND_PACKETS_PER_SLAVE,
-			packets_per_slave))
+			READ_ONCE(bond->params.packets_per_slave)))
 		goto nla_put_failure;
 
 	if (nla_put_u8(skb, IFLA_BOND_AD_LACP_ACTIVE,
-		       bond->params.lacp_active))
+		       READ_ONCE(bond->params.lacp_active)))
 		goto nla_put_failure;
 
 	if (nla_put_u8(skb, IFLA_BOND_AD_LACP_RATE,
-		       bond->params.lacp_fast))
+		       READ_ONCE(bond->params.lacp_fast)))
 		goto nla_put_failure;
 
 	if (nla_put_u8(skb, IFLA_BOND_AD_SELECT,
-		       bond->params.ad_select))
+		       READ_ONCE(bond->params.ad_select)))
 		goto nla_put_failure;
 
 	if (nla_put_u8(skb, IFLA_BOND_TLB_DYNAMIC_LB,
-		       bond->params.tlb_dynamic_lb))
+		       READ_ONCE(bond->params.tlb_dynamic_lb)))
 		goto nla_put_failure;
 
 	if (nla_put_u8(skb, IFLA_BOND_MISSED_MAX,
-		       bond->params.missed_max))
+		       READ_ONCE(bond->params.missed_max)))
 		goto nla_put_failure;
 
 	if (nla_put_u8(skb, IFLA_BOND_COUPLED_CONTROL,
-		       bond->params.coupled_control))
+		       READ_ONCE(bond->params.coupled_control)))
 		goto nla_put_failure;
 
 	if (nla_put_u8(skb, IFLA_BOND_BROADCAST_NEIGH,
-		       bond->params.broadcast_neighbor))
+		       READ_ONCE(bond->params.broadcast_neighbor)))
 		goto nla_put_failure;
 
-	if (BOND_MODE(bond) == BOND_MODE_8023AD) {
+	if (mode == BOND_MODE_8023AD) {
 		struct ad_info info;
 
 		if (capable(CAP_NET_ADMIN)) {
 			if (nla_put_u16(skb, IFLA_BOND_AD_ACTOR_SYS_PRIO,
-					bond->params.ad_actor_sys_prio))
+					READ_ONCE(bond->params.ad_actor_sys_prio)))
 				goto nla_put_failure;
 
 			if (nla_put_u16(skb, IFLA_BOND_AD_USER_PORT_KEY,
-					bond->params.ad_user_port_key))
+					READ_ONCE(bond->params.ad_user_port_key)))
 				goto nla_put_failure;
 
+			/* Small race here, this is a minor trade off. */
 			if (nla_put(skb, IFLA_BOND_AD_ACTOR_SYSTEM,
 				    ETH_ALEN, &bond->params.ad_actor_system))
 				goto nla_put_failure;
 		}
-		if (!bond_3ad_get_active_agg_info(bond, &info)) {
+		if (!__bond_3ad_get_active_agg_info(bond, &info)) {
 			struct nlattr *nest;
 
 			nest = nla_nest_start_noflag(skb, IFLA_BOND_AD_INFO);
@@ -882,9 +886,11 @@ static int bond_fill_info(struct sk_buff *skb,
 		}
 	}
 
+	rcu_read_unlock();
 	return 0;
 
 nla_put_failure:
+	rcu_read_unlock();
 	return -EMSGSIZE;
 }
 
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 5095ac3dad2cd924ff548343c7c1afe3e57e3065..501cfb72369dfc7f70a59862631642dd834e268e 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -925,7 +925,7 @@ static int bond_option_mode_set(struct bonding *bond,
 	 * enabled in 8023ad mode. Therefore, only clear broadcast_neighbor
 	 * to 0.
 	 */
-	bond->params.broadcast_neighbor = 0;
+	WRITE_ONCE(bond->params.broadcast_neighbor, 0);
 
 	if (bond->dev->reg_state == NETREG_REGISTERED) {
 		bool update = false;
@@ -1900,7 +1900,7 @@ static int bond_option_broadcast_neigh_set(struct bonding *bond,
 	if (bond->params.broadcast_neighbor == newval->value)
 		return 0;
 
-	bond->params.broadcast_neighbor = newval->value;
+	WRITE_ONCE(bond->params.broadcast_neighbor, newval->value);
 	if (bond->dev->flags & IFF_UP) {
 		if (bond->params.broadcast_neighbor)
 			static_branch_inc(&bond_bcast_neigh_enabled);
diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
index 05572c19e14b7ae97d497cc9c5d97d4314eab295..ef667dff297294dc78d98701aae10c31ef09df3f 100644
--- a/include/net/bond_3ad.h
+++ b/include/net/bond_3ad.h
@@ -302,8 +302,8 @@ void bond_3ad_state_machine_handler(struct work_struct *);
 void bond_3ad_initiate_agg_selection(struct bonding *bond, int timeout);
 void bond_3ad_adapter_speed_duplex_changed(struct slave *slave);
 void bond_3ad_handle_link_change(struct slave *slave, char link);
-int  bond_3ad_get_active_agg_info(struct bonding *bond, struct ad_info *ad_info);
-int  __bond_3ad_get_active_agg_info(struct bonding *bond,
+int  bond_3ad_get_active_agg_info(const struct bonding *bond, struct ad_info *ad_info);
+int  __bond_3ad_get_active_agg_info(const struct bonding *bond,
 				    struct ad_info *ad_info);
 int bond_3ad_lacpdu_recv(const struct sk_buff *skb, struct bonding *bond,
 			 struct slave *slave);
diff --git a/include/net/bonding.h b/include/net/bonding.h
index edd1942dcd736d3601e799dfbc9aeb8da0835902..f464ff163357637661500a6172902e5bb7401031 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -344,14 +344,14 @@ static inline bool bond_mode_uses_primary(int mode)
 	       mode == BOND_MODE_ALB;
 }
 
-static inline bool bond_uses_primary(struct bonding *bond)
+static inline bool bond_uses_primary(const struct bonding *bond)
 {
 	return bond_mode_uses_primary(BOND_MODE(bond));
 }
 
-static inline struct net_device *bond_option_active_slave_get_rcu(struct bonding *bond)
+static inline struct net_device *bond_option_active_slave_get_rcu(const struct bonding *bond)
 {
-	struct slave *slave = rcu_dereference_rtnl(bond->curr_active_slave);
+	const struct slave *slave = rcu_dereference_rtnl(bond->curr_active_slave);
 
 	return bond_uses_primary(bond) && slave ? slave->dev : NULL;
 }
@@ -702,7 +702,7 @@ void bond_setup(struct net_device *bond_dev);
 unsigned int bond_get_num_tx_queues(void);
 int bond_netlink_init(void);
 void bond_netlink_fini(void);
-struct net_device *bond_option_active_slave_get_rcu(struct bonding *bond);
+struct net_device *bond_option_active_slave_get_rcu(const struct bonding *bond);
 const char *bond_slave_link_status(s8 link);
 struct bond_vlan_tag *bond_verify_device_path(struct net_device *start_dev,
 					      struct net_device *end_dev,
-- 
2.54.0.1032.g2f8565e1d1-goog


