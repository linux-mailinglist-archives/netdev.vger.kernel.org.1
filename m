Return-Path: <netdev+bounces-297420-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 28F1IC7YKGohKwMAu9opvQ
	(envelope-from <netdev+bounces-297420-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 05:21:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFB86659C1
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 05:21:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=UHpmvvh4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297420-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297420-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96CEC30E5C9E
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3CB2E8B98;
	Wed, 10 Jun 2026 03:19:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6847327FB05
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 03:19:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781061592; cv=none; b=TNbYG3c+cb9ov3Mw4CdTjk6iQL9ZCDCKBuFMlt6wY6/+aaKPis8+pPvbJe2+wEQREogi/igMpsBHSYLPh5AJhqo80jHHYvlTeP2j6Fgsb/auTNZ3bthyyF7XGLYj9QPRXjQFesn1FL39C/JuaWupMYAcXo8EKSYEnDr5HO+/mss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781061592; c=relaxed/simple;
	bh=BLvBasoOhASx9IC0anhkQkTGWKng1zr4+kPCh0mGSDo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FvYwL7e+ptlvVwH5ryLsLqr2lDnJwKWEudAeEtnBdAVCOHYuYeNXxHZIUbfOoxkipNgEFvbbuuF4HN7malW/j2wAvbSj+pzOXZT9CiAaLDU3PJM3qpIKfqp73y4AmGcW258/aje5pIyuLOpdklmas8DK8Bsl7e8LgH+vmUkUNqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UHpmvvh4; arc=none smtp.client-ip=209.85.160.201
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-5177b8df670so104964271cf.2
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 20:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781061588; x=1781666388; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H1Li6grVmwLcM2nuvDzlTmOYP0XZ6VgdTcZRdVVUVgk=;
        b=UHpmvvh4nmct74DDHIgW4vzWgZbXYnlCid4BbDNrp4PKBGno3QdeL3L9lVcpyOvDsY
         L3IR8nggaKCkOFjbqSbfKX+VJLQsaMbjIFjOhaK/qYVKZp/LSevVXKc/JBaWtHbJCwZv
         Xs1g9NefI9XSD/QnigYXCplJ5DZ/Qf0To9I3rrEIfJLTWM6odhg094WMGzDgZRHAAp75
         9vn3WiVcOOtXdSFLGoJg8fY6SB5HQR+Sim9mXhv1zMi+50tNUAjdi4e/XkBdVJ0M/iPW
         C4T1EPVAVXaovwt8mZc8UoEWHcsXnav0EsXwFHz0tgi/jypPNQwDd9T8+r8O+V896OTP
         wMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781061588; x=1781666388;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H1Li6grVmwLcM2nuvDzlTmOYP0XZ6VgdTcZRdVVUVgk=;
        b=Vmkbw69XqFRX+sbE5ZlsqBj9RiFvjxuMHdKUQW1wmNtH9W00zWIAdZb6DaXE8E4lML
         tAfGpk1UeBbxXH0mRKui5ynMzVQG98Td8j36kbqTFPmyi3Hm7Tn9drq+dS17bYwkexum
         1W/Ij9i5NE2yBBH4X89MykZhKZD1VGghkEgZKXbVh5ERJC86ywSIcpFStsovh3GUcbex
         5N/vLxroY3DOdjP80xJi11UQHpDE2GFZT9+5Ej/VkCVbS6cJdlqnfMkB/SB7vZ2h+wjc
         D2QiaXJxuFZSZ63vEVFo4KewZp5B4tMWm5hZZrhsxXnle/NQmjryFWCChBei8ZhYk6hj
         VivQ==
X-Forwarded-Encrypted: i=1; AFNElJ/lgPYijGEWIyNNRpoIoVxIVjUWZZID5q7ndRj9mRMTUESo4Ka3pznmNhNa3QOsxmVULFnWDa4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1FmFKQulTCzfBolbJQVerigmCjfo1jNIMhmfV81DzOUKhSB05
	mRYi5Zi3WMuDza4dLFqejtr8KKiIfbMs58PrMWFagxN+5J4qZbWZNSL/Y9Lnmy7ZTX+ds90PQuk
	ZfvnhNNpI/OMKEA==
X-Received: from qvoj12.prod.google.com ([2002:a0c:f9cc:0:b0:8cc:efa4:d4cb])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1388:b0:516:dcbd:aab9 with SMTP id d75a77b69052e-517959fb37dmr311286781cf.16.1781061588047;
 Tue, 09 Jun 2026 20:19:48 -0700 (PDT)
Date: Wed, 10 Jun 2026 03:19:46 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610031946.466417-1-edumazet@google.com>
Subject: [PATCH v3 net-next] bonding: no longer rely on RTNL in bond_fill_info()
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297420-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CDFB86659C1

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
---
Cc: Jay Vosburgh <jv@jvosburgh.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
---
v3: Use net-next in patch title to not confuse patchwork/CI.
v2: addressed sashiko.dev feedback.

 drivers/net/bonding/bond_3ad.c     |  18 ++---
 drivers/net/bonding/bond_netlink.c | 107 ++++++++++++++++-------------
 drivers/net/bonding/bond_options.c |   6 +-
 include/net/bond_3ad.h             |   4 +-
 include/net/bonding.h              |   8 +--
 5 files changed, 78 insertions(+), 65 deletions(-)

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
index 90365d3f7ebff7f762b4cb10303a3dd3fdd49cc6..aa1725e6a37762b0386481eb012b2f6b90925427 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -674,53 +674,58 @@ static size_t bond_get_size(const struct net_device *bond_dev)
 		0;
 }
 
-static int bond_option_active_slave_get_ifindex(struct bonding *bond)
+static int bond_option_active_slave_get_ifindex_rcu(const struct bonding *bond)
 {
-	const struct net_device *slave;
-	int ifindex;
+	const struct net_device *dev = NULL;
+	const struct slave *slave;
 
-	rcu_read_lock();
-	slave = bond_option_active_slave_get_rcu(bond);
-	ifindex = slave ? slave->ifindex : 0;
-	rcu_read_unlock();
-	return ifindex;
+	slave = rcu_dereference(bond->curr_active_slave);
+	if (slave)
+		dev = slave->dev;
+	return dev ? dev->ifindex : 0;
 }
 
 static int bond_fill_info(struct sk_buff *skb,
 			  const struct net_device *bond_dev)
 {
-	struct bonding *bond = netdev_priv(bond_dev);
-	unsigned int packets_per_slave;
-	int ifindex, i, targets_added;
+	const struct bonding *bond = netdev_priv(bond_dev);
+	int i, targets_added, miimon, mode;
+	const struct slave *primary;
 	struct nlattr *targets;
-	struct slave *primary;
 
-	if (nla_put_u8(skb, IFLA_BOND_MODE, BOND_MODE(bond)))
+	rcu_read_lock();
+	mode = READ_ONCE(bond->params.mode);
+	if (nla_put_u8(skb, IFLA_BOND_MODE, mode))
 		goto nla_put_failure;
 
-	ifindex = bond_option_active_slave_get_ifindex(bond);
-	if (ifindex && nla_put_u32(skb, IFLA_BOND_ACTIVE_SLAVE, ifindex))
-		goto nla_put_failure;
+	if (bond_mode_uses_primary(mode)) {
+		int ifindex = bond_option_active_slave_get_ifindex_rcu(bond);
+
+		if (ifindex && nla_put_u32(skb, IFLA_BOND_ACTIVE_SLAVE, ifindex))
+			goto nla_put_failure;
+	}
 
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
 		goto nla_put_failure;
 
-	if (nla_put_u32(skb, IFLA_BOND_ARP_INTERVAL, bond->params.arp_interval))
+	if (nla_put_u32(skb, IFLA_BOND_ARP_INTERVAL,
+			READ_ONCE(bond->params.arp_interval)))
 		goto nla_put_failure;
 
 	targets = nla_nest_start_noflag(skb, IFLA_BOND_ARP_IP_TARGET);
@@ -729,8 +734,10 @@ static int bond_fill_info(struct sk_buff *skb,
 
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
@@ -741,11 +748,12 @@ static int bond_fill_info(struct sk_buff *skb,
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
@@ -755,6 +763,9 @@ static int bond_fill_info(struct sk_buff *skb,
 
 	targets_added = 0;
 	for (i = 0; i < BOND_MAX_NS_TARGETS; i++) {
+		/* Note: IPv6 addresses can not be read in an atomic READ_ONCE() yet.
+		 * We accept this minor race for the moment.
+		 */
 		if (!ipv6_addr_any(&bond->params.ns_targets[i])) {
 			if (nla_put_in6_addr(skb, i, &bond->params.ns_targets[i]))
 				goto nla_put_failure;
@@ -768,93 +779,93 @@ static int bond_fill_info(struct sk_buff *skb,
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
@@ -882,9 +893,11 @@ static int bond_fill_info(struct sk_buff *skb,
 		}
 	}
 
+	rcu_read_unlock();
 	return 0;
 
 nla_put_failure:
+	rcu_read_unlock();
 	return -EMSGSIZE;
 }
 
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 5095ac3dad2cd924ff548343c7c1afe3e57e3065..a70407b5fb2bbfebe49c9f242f1be81933a6a912 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -918,14 +918,14 @@ static int bond_option_mode_set(struct bonding *bond,
 
 	/* don't cache arp_validate between modes */
 	WRITE_ONCE(bond->params.arp_validate, BOND_ARP_VALIDATE_NONE);
-	bond->params.mode = newval->value;
+	WRITE_ONCE(bond->params.mode, newval->value);
 
 	/* When changing mode, the bond device is down, we may reduce
 	 * the bond_bcast_neigh_enabled in bond_close() if broadcast_neighbor
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
2.54.0.1099.g489fc7bff1-goog


