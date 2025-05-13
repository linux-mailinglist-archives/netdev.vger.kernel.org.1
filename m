Return-Path: <netdev+bounces-190027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D37D5AB5043
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 11:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87AA68C23B1
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 09:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A63E239E6A;
	Tue, 13 May 2025 09:49:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DF5207DFD
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 09:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747129754; cv=none; b=ND5L9dZHgm2iBWrxeQeoHy53hrbkpW25+9M/SzH/rdD+9+ZK4qx0s5VT7EPGW22MLnDaZM9mw9Rg57z89KB2pA2HPpcteKQbiqVTgxtHJhM7DKAHNuVwr7tpg3eG0Fh3Z8oyk+dUWoRAMjxy3hMonrNVfWlMS4dqwg+7L9Zqsk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747129754; c=relaxed/simple;
	bh=5u4DGQJojrWnO/uiOsqABkqMZxncC4YPsu79cS/CCRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBIKwW5AMUmBLWMxOexKd0fCKrs8PnETNvyUZljhAbBZQZVMMI0j11Gero8up4FGY76zPxWMXFCjBbBRDe5azujt5MZe8PlK0UzlF7bPrAdfIfb1Huu1CNpK7WomKbBamQjEHkQbwIUL6su2XX8uV8w7FQ3t20cg3ucDT78zox4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz4t1747129680t04042855
X-QQ-Originating-IP: Kx4O24lSIBhbqt5s1+24xEFh5kvNByeuvQ0csuzJQk8=
Received: from localhost.localdomain ( [111.202.70.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 13 May 2025 17:47:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13778884302279396959
EX-QQ-RecipientCnt: 11
From: Tonghao Zhang <tonghao@bamaicloud.com>
To: netdev@vger.kernel.org
Cc: Tonghao Zhang <tonghao@bamaicloud.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Zengbing Tu <tuzengbing@didiglobal.com>
Subject: [PATCH net-next v2 1/4] net: bonding: add broadcast_neighbor option for 802.3ad
Date: Tue, 13 May 2025 17:47:47 +0800
Message-ID: <4270C010E5516F3B+20250513094750.23387-2-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513094750.23387-1-tonghao@bamaicloud.com>
References: <20250513094750.23387-1-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: N3RV6azs5cjDY/Uawd6xp1Ty82LMpLR9LJLusF044G5H83N6SwjSddZN
	43rDUxuWrsVVkBGF/9Vyvu4qEQc+BTEXw0eVd+1KhbxdCKT9jnwCnlVDfpLQ5nVi+ESprFQ
	psGIPdozeQ8QH8qd3avDv+YbxR+NJxaJj2NSRntrksOjGKdQ2VxeOH2YV1FubpSlqwcJew0
	EmYpMTzTf7tOr+Inmg/Suv0qS5y+CFtfcoP9gyFknerxTjXlYxY/JqCUa5fcaaQjbMmJOlZ
	0ET0WFfSMDisD6LawGW9GfcVjpK1XKx+ahafSPpaEzaRQ0C/JxmP3j+uKo8/xmOaHSskkK0
	7UrSXoF2vqb7E+ceUBowOSzKJf/fpoM2WH2K1IYZGHHqWhlFBjnet779zaq8hGQ4wcX/GhX
	D1n9B4sOJ309pcv1yCoFxgMyaJbgYyeM5CVbN7N8V1+eQNzWdUgPQaULtktEyv6sr73cPHN
	cklaPFejj6G8DgkYM2ANLuFczL7WK7IEDmp2ARp7RS4STrsnp02JMGBKWBeaI9GMq70/yHQ
	Fm3GqtKGCE478rfpE1L1L6YFX3mCIrsopUOW7835K0kB/xr36CMBmvVacyHfbUSWGbG+V02
	UL4tk/kjQHp9kBsco2+4E2okrlHKQyX25qmRaEjclNLr3qrg/yXTbG1QYW7uMpWHYxwEzcH
	ylisD37sewxN5gVmcfBm0n1CKilXqI2ErrdlD7fcWfC4bTs5QHWXMYcBPwje1yieqWY/9+0
	cdh1+q4dHDRtt7oPaP5tGpbChNEsUDS5P4pihCc+1xJDNGNYkrLhW26IbQ+KorAw50iMi44
	tZ+hzhI0AJpmSMXTCpQ1Srx5JCT03DrXVxPWL+/QnoHbvI5gmA9H3OyfNSdU+imogSfN1/P
	jwJCTfqj+M7feEVibBreYZ5ULoafT83MtePF+JwWRYKC1TtWBjXRasiCWUd6787Na3CghSB
	IoBbucJneY+7YDaNEJrRBHHiuqzbZPCFC/2cF3SusRH62LlJ84R2XKGqdsYbouqitIgw=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Stacking technology is a type of technology used to expand ports on
Ethernet switches. It is widely used as a common access method in
large-scale Internet data center architectures. Years of practice
have proved that stacking technology has advantages and disadvantages
in high-reliability network architecture scenarios. For instance,
in stacking networking arch, conventional switch system upgrades
require multiple stacked devices to restart at the same time.
Therefore, it is inevitable that the business will be interrupted
for a while. It is for this reason that "no-stacking" in data centers
has become a trend. Additionally, when the stacking link connecting
the switches fails or is abnormal, the stack will split. Although it is
not common, it still happens in actual operation. The problem is that
after the split, it is equivalent to two switches with the same configuration
appearing in the network, causing network configuration conflicts and
ultimately interrupting the services carried by the stacking system.

To improve network stability, "non-stacking" solutions have been increasingly
adopted, particularly by public cloud providers and tech companies
like Alibaba, Tencent, and Didi. "non-stacking" is a method of mimicing switch
stacking that convinces a LACP peer, bonding in this case, connected to a set of
"non-stacked" switches that all of its ports are connected to a single
switch (i.e., LACP aggregator), as if those switches were stacked. This
enables the LACP peer's ports to aggregate together, and requires (a)
special switch configuration, described in the linked article, and (b)
modifications to the bonding 802.3ad (LACP) mode to send all ARP / ND
packets across all ports of the active aggregator.

  -----------     -----------
 |  switch1  |   |  switch2  |
  -----------     -----------
         ^           ^
         |           |
        ---------------
       |   bond4 lacp  |
        ---------------
         | NIC1      | NIC2
     ---------------------
    |       server        |
     ---------------------

- https://www.ruijie.com/fr-fr/support/tech-gallery/de-stack-data-center-network-architecture/

Cc: Jay Vosburgh <jv@jvosburgh.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
Signed-off-by: Zengbing Tu <tuzengbing@didiglobal.com>
---
 Documentation/networking/bonding.rst |  6 +++++
 drivers/net/bonding/bond_main.c      | 39 ++++++++++++++++++++++++++++
 drivers/net/bonding/bond_options.c   | 34 ++++++++++++++++++++++++
 drivers/net/bonding/bond_sysfs.c     | 18 +++++++++++++
 include/net/bond_options.h           |  1 +
 include/net/bonding.h                |  3 +++
 6 files changed, 101 insertions(+)

diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
index a4c1291d2561..14f7593d888d 100644
--- a/Documentation/networking/bonding.rst
+++ b/Documentation/networking/bonding.rst
@@ -562,6 +562,12 @@ lacp_rate
 
 	The default is slow.
 
+broadcast_neighbor
+
+	Option specifying whether to broadcast ARP/ND packets to all
+	active slaves.  This option has no effect in modes other than
+	802.3ad mode.  The default is off (0).
+
 max_bonds
 
 	Specifies the number of bonding devices to create for this
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index d05226484c64..8ee26ddddbc8 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -212,6 +212,9 @@ atomic_t netpoll_block_tx = ATOMIC_INIT(0);
 
 unsigned int bond_net_id __read_mostly;
 
+DEFINE_STATIC_KEY_FALSE(bond_bcast_neigh_enabled);
+EXPORT_SYMBOL_GPL(bond_bcast_neigh_enabled);
+
 static const struct flow_dissector_key flow_keys_bonding_keys[] = {
 	{
 		.key_id = FLOW_DISSECTOR_KEY_CONTROL,
@@ -4480,6 +4483,9 @@ static int bond_close(struct net_device *bond_dev)
 		bond_alb_deinitialize(bond);
 	bond->recv_probe = NULL;
 
+	if (bond->params.broadcast_neighbor)
+		static_branch_dec(&bond_bcast_neigh_enabled);
+
 	if (bond_uses_primary(bond)) {
 		rcu_read_lock();
 		slave = rcu_dereference(bond->curr_active_slave);
@@ -5316,6 +5322,35 @@ static struct slave *bond_xdp_xmit_3ad_xor_slave_get(struct bonding *bond,
 	return slaves->arr[hash % count];
 }
 
+static inline bool bond_should_broadcast_neighbor(struct sk_buff *skb,
+						  struct net_device *dev)
+{
+	struct bonding *bond = netdev_priv(dev);
+
+	if (!static_branch_unlikely(&bond_bcast_neigh_enabled))
+		return false;
+
+	if (!bond->params.broadcast_neighbor)
+		return false;
+
+	if (skb->protocol == htons(ETH_P_ARP))
+		return true;
+
+	if (skb->protocol == htons(ETH_P_IPV6) &&
+	    pskb_may_pull(skb,
+			  sizeof(struct ipv6hdr) + sizeof(struct icmp6hdr))) {
+		if (ipv6_hdr(skb)->nexthdr == IPPROTO_ICMPV6) {
+			struct icmp6hdr *icmph = icmp6_hdr(skb);
+
+			if ((icmph->icmp6_type == NDISC_NEIGHBOUR_SOLICITATION) ||
+			    (icmph->icmp6_type == NDISC_NEIGHBOUR_ADVERTISEMENT))
+				return true;
+		}
+	}
+
+	return false;
+}
+
 /* Use this Xmit function for 3AD as well as XOR modes. The current
  * usable slave array is formed in the control path. The xmit function
  * just calculates hash and sends the packet out.
@@ -5583,6 +5618,9 @@ static netdev_tx_t __bond_start_xmit(struct sk_buff *skb, struct net_device *dev
 	case BOND_MODE_ACTIVEBACKUP:
 		return bond_xmit_activebackup(skb, dev);
 	case BOND_MODE_8023AD:
+		if (bond_should_broadcast_neighbor(skb, dev))
+			return bond_xmit_broadcast(skb, dev);
+		fallthrough;
 	case BOND_MODE_XOR:
 		return bond_3ad_xor_xmit(skb, dev);
 	case BOND_MODE_BROADCAST:
@@ -6462,6 +6500,7 @@ static int __init bond_check_params(struct bond_params *params)
 	eth_zero_addr(params->ad_actor_system);
 	params->ad_user_port_key = ad_user_port_key;
 	params->coupled_control = 1;
+	params->broadcast_neighbor = 0;
 	if (packets_per_slave > 0) {
 		params->reciprocal_packets_per_slave =
 			reciprocal_value(packets_per_slave);
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 91893c29b899..dca52d93f513 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -87,6 +87,8 @@ static int bond_option_missed_max_set(struct bonding *bond,
 				      const struct bond_opt_value *newval);
 static int bond_option_coupled_control_set(struct bonding *bond,
 					   const struct bond_opt_value *newval);
+static int bond_option_broadcast_neigh_set(struct bonding *bond,
+					   const struct bond_opt_value *newval);
 
 static const struct bond_opt_value bond_mode_tbl[] = {
 	{ "balance-rr",    BOND_MODE_ROUNDROBIN,   BOND_VALFLAG_DEFAULT},
@@ -240,6 +242,12 @@ static const struct bond_opt_value bond_coupled_control_tbl[] = {
 	{ NULL,  -1, 0},
 };
 
+static const struct bond_opt_value bond_broadcast_neigh_tbl[] = {
+	{ "on",	 1, 0},
+	{ "off", 0, BOND_VALFLAG_DEFAULT},
+	{ NULL,  -1, 0}
+};
+
 static const struct bond_option bond_opts[BOND_OPT_LAST] = {
 	[BOND_OPT_MODE] = {
 		.id = BOND_OPT_MODE,
@@ -513,6 +521,14 @@ static const struct bond_option bond_opts[BOND_OPT_LAST] = {
 		.flags = BOND_OPTFLAG_IFDOWN,
 		.values = bond_coupled_control_tbl,
 		.set = bond_option_coupled_control_set,
+	},
+	[BOND_OPT_BROADCAST_NEIGH] = {
+		.id = BOND_OPT_BROADCAST_NEIGH,
+		.name = "broadcast_neighbor",
+		.desc = "Broadcast neighbor packets to all slaves",
+		.unsuppmodes = BOND_MODE_ALL_EX(BIT(BOND_MODE_8023AD)),
+		.values = bond_broadcast_neigh_tbl,
+		.set = bond_option_broadcast_neigh_set,
 	}
 };
 
@@ -1840,3 +1856,21 @@ static int bond_option_coupled_control_set(struct bonding *bond,
 	bond->params.coupled_control = newval->value;
 	return 0;
 }
+
+static int bond_option_broadcast_neigh_set(struct bonding *bond,
+					   const struct bond_opt_value *newval)
+{
+	netdev_dbg(bond->dev, "Setting broadcast_neighbor to %llu\n",
+		   newval->value);
+
+	if (bond->params.broadcast_neighbor == newval->value)
+		return 0;
+
+	bond->params.broadcast_neighbor = newval->value;
+	if (bond->params.broadcast_neighbor)
+		static_branch_inc(&bond_bcast_neigh_enabled);
+	else
+		static_branch_dec(&bond_bcast_neigh_enabled);
+
+	return 0;
+}
diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bond_sysfs.c
index 1e13bb170515..4a53850b2c68 100644
--- a/drivers/net/bonding/bond_sysfs.c
+++ b/drivers/net/bonding/bond_sysfs.c
@@ -752,6 +752,23 @@ static ssize_t bonding_show_ad_user_port_key(struct device *d,
 static DEVICE_ATTR(ad_user_port_key, 0644,
 		   bonding_show_ad_user_port_key, bonding_sysfs_store_option);
 
+static ssize_t bonding_show_broadcast_neighbor(struct device *d,
+					       struct device_attribute *attr,
+					       char *buf)
+{
+	struct bonding *bond = to_bond(d);
+	const struct bond_opt_value *val;
+
+	val = bond_opt_get_val(BOND_OPT_BROADCAST_NEIGH,
+			       bond->params.broadcast_neighbor);
+
+	return sysfs_emit(buf, "%s %d\n", val->string,
+			  bond->params.broadcast_neighbor);
+}
+
+static DEVICE_ATTR(broadcast_neighbor, 0644,
+		   bonding_show_broadcast_neighbor, bonding_sysfs_store_option);
+
 static struct attribute *per_bond_attrs[] = {
 	&dev_attr_slaves.attr,
 	&dev_attr_mode.attr,
@@ -791,6 +808,7 @@ static struct attribute *per_bond_attrs[] = {
 	&dev_attr_ad_actor_system.attr,
 	&dev_attr_ad_user_port_key.attr,
 	&dev_attr_arp_missed_max.attr,
+	&dev_attr_broadcast_neighbor.attr,
 	NULL,
 };
 
diff --git a/include/net/bond_options.h b/include/net/bond_options.h
index 18687ccf0638..022b122a9fb6 100644
--- a/include/net/bond_options.h
+++ b/include/net/bond_options.h
@@ -77,6 +77,7 @@ enum {
 	BOND_OPT_NS_TARGETS,
 	BOND_OPT_PRIO,
 	BOND_OPT_COUPLED_CONTROL,
+	BOND_OPT_BROADCAST_NEIGH,
 	BOND_OPT_LAST
 };
 
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 95f67b308c19..e06f0d63b2c1 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -115,6 +115,8 @@ static inline int is_netpoll_tx_blocked(struct net_device *dev)
 #define is_netpoll_tx_blocked(dev) (0)
 #endif
 
+DECLARE_STATIC_KEY_FALSE(bond_bcast_neigh_enabled);
+
 struct bond_params {
 	int mode;
 	int xmit_policy;
@@ -149,6 +151,7 @@ struct bond_params {
 	struct in6_addr ns_targets[BOND_MAX_NS_TARGETS];
 #endif
 	int coupled_control;
+	int broadcast_neighbor;
 
 	/* 2 bytes of padding : see ether_addr_equal_64bits() */
 	u8 ad_actor_system[ETH_ALEN + 2];
-- 
2.34.1


