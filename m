Return-Path: <netdev+bounces-201957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F5EAEB93D
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 15:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 010941C43F90
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7692DBF4A;
	Fri, 27 Jun 2025 13:51:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0F62D9EDE
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751032281; cv=none; b=dVEuIdsK02sFmQTFZ0D2MSnkdouI4AdOp/zPvpKuc7/+IX53kSokIZs6IE404qdSmMDpOaB+f8Bo90pjfj1JLgV/ASWoVm7X60GF9ZQFjiVGMlws+yBsFyn+ZBAfz4cTyA5BQf5+n9KoJsOmE/XqKc7wG1Jpkgw7BuJk0PI8kwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751032281; c=relaxed/simple;
	bh=+LFrNStMVrJg+3d8wxfzVVFWAI1QG1FR3C7Aipn3/Gw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BJ+hLpJEerwYhC2mU+SbhwBCTDlUfViX+doayBVfoIBUXj0zzPT5r8JTb6mjskbXuptzBpYqyGgUMqDYMxJGZn/AOMJf9042vd6P8pDAs0dBs1DLohg+ta3YXx1TfsT2YC++iheeUR1JHr60iO7355pJS4cPpi1e1V+phhJ8uTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz10t1751032253t53e1c402
X-QQ-Originating-IP: 9rOJ+EsgUKJ0Qig2oJcSzA+UreXbNlbEotTvrWNNwTY=
Received: from localhost.localdomain ( [111.202.70.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 27 Jun 2025 21:50:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2973353215254339590
EX-QQ-RecipientCnt: 15
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
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Zengbing Tu <tuzengbing@didiglobal.com>
Subject: [net-next v8 1/3] net: bonding: add broadcast_neighbor option for 802.3ad
Date: Fri, 27 Jun 2025 21:49:28 +0800
Message-Id: <84d0a044514157bb856a10b6d03a1028c4883561.1751031306.git.tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1751031306.git.tonghao@bamaicloud.com>
References: <cover.1751031306.git.tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MLbAtvpy5B1PNMMk47hj8rk3LNkXfmPce+aFKzx11A4rEFLq/PV6CVJw
	6Pnt/0FYYhd2OGIf7dAdkEhLC0OXCzSMoMyGLLRAzk8AuCiELF9568OUYO+0BYVUONJNZoy
	kh+ZQ4oaZANlvw+OfBGRNF9kMVYuNjHCQTeQitADDV2jOBZuMi8Wsb45ESotjoBYqa9JyuU
	ZfLKXM2p3+xkZXKkscpFhtjG47zeksEDB2DSRliY3SU0MG56e1uFZxRvv6oh2xhmWDAwIo9
	ah6zGlXIkEx94o5iJSKesv20IbW7bYMRi+UoYI+oHAsNT802TQ2c4DPYyBk32f4gW+IPVfV
	xXrirgNKzPQHAY302JbILiGeDk1E3Oq/dB45m5vvQG5Z9sG1gnsckDbAMhTQibgYNP8kAUc
	vJjqcjs+8YWHLtuviNbrFCQ5plHdfI/FJhBi42bKGIe7wK4u2HVCNwZlGfyrIWjnWsyI713
	dOfW/s0d98efD02dL7JpPkjUCNQ5uKBvvevDRQR0jcEnQvCtHhwUwiYtO55kQro7Ttu/2vs
	RLtRtnIwyFUD7SVUMr+2nLdT2nEY1YUa3H4MFDeo6627vIZH7R2ZHcsvRCTg1fWkJSgp435
	/WDdbNpZMapiUXudIj+AUiGtLmheeIjxCPFo7r0d9x6Dbt4XXWRP3EIfaQ8SIF8lnTJH0kJ
	1imHr5pXwdvZVPENOE7S3ZsBqIMUeRo7UgXcbwla5cEix2AcilUvrtpiz/0EBlsa+t9rbcr
	mTRUN2CW0aauJy4JxMivAXflGBHApMI/noVd01NFMSsRi5ifF3QyJl3FupOMBjoWWYFLHNr
	eYJLH3+mL6ZBzXuXvXt+Xfyf9MJJrVzkbOabTZl9bFk9kTMT4wRQhdeQa6h+WsFzRBboJlX
	AQKrqiQkTFQ91HxKqqjN+9XUUkwbtVuqow6rJfWJGkAy60eSpRD4iXJPkZn/SoSYRdzqztn
	6sJflGaADLVXe4BA8521Ljj+nmZ+kcKzpRBuOHTSJ/1ux4HZsx+Sfg85NWxErwqWgTgs=
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
after the split, it is equivalent to two switches with the same
configuration appearing in the network, causing network configuration
conflicts and ultimately interrupting the services carried by the
stacking system.

To improve network stability, "non-stacking" solutions have been
increasingly adopted, particularly by public cloud providers and
tech companies like Alibaba, Tencent, and Didi. "non-stacking" is
a method of mimicing switch stacking that convinces a LACP peer,
bonding in this case, connected to a set of "non-stacked" switches
that all of its ports are connected to a single switch
(i.e., LACP aggregator), as if those switches were stacked. This
enables the LACP peer's ports to aggregate together, and requires
(a) special switch configuration, described in the linked article,
and (b) modifications to the bonding 802.3ad (LACP) mode to send
all ARP/ND packets across all ports of the active aggregator.

Note that, with multiple aggregators, the current broadcast mode
logic will send only packets to the selected aggregator(s).

 +-----------+   +-----------+
 |  switch1  |   |  switch2  |
 +-----------+   +-----------+
         ^           ^
         |           |
      +-----------------+
      |   bond4 lacp    |
      +-----------------+
         |           |
         | NIC1      | NIC2
      +-----------------+
      |     server      |
      +-----------------+

- https://www.ruijie.com/fr-fr/support/tech-gallery/de-stack-data-center-network-architecture/

Cc: Jay Vosburgh <jv@jvosburgh.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
Signed-off-by: Zengbing Tu <tuzengbing@didiglobal.com>
---
v8: add comments info in bond_option_mode_set, explain why we only
clear broadcast_neighbor to 0.
Note that selftest will be post after I post the iproute2 patch about
this option.
---
 Documentation/networking/bonding.rst |  6 +++
 drivers/net/bonding/bond_main.c      | 66 +++++++++++++++++++++++++---
 drivers/net/bonding/bond_options.c   | 42 ++++++++++++++++++
 include/net/bond_options.h           |  1 +
 include/net/bonding.h                |  3 ++
 5 files changed, 112 insertions(+), 6 deletions(-)

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
index c4d53e8e7c15..12046ef51569 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -212,6 +212,8 @@ atomic_t netpoll_block_tx = ATOMIC_INIT(0);
 
 unsigned int bond_net_id __read_mostly;
 
+DEFINE_STATIC_KEY_FALSE(bond_bcast_neigh_enabled);
+
 static const struct flow_dissector_key flow_keys_bonding_keys[] = {
 	{
 		.key_id = FLOW_DISSECTOR_KEY_CONTROL,
@@ -4456,6 +4458,9 @@ static int bond_open(struct net_device *bond_dev)
 
 		bond_for_each_slave(bond, slave, iter)
 			dev_mc_add(slave->dev, lacpdu_mcast_addr);
+
+		if (bond->params.broadcast_neighbor)
+			static_branch_inc(&bond_bcast_neigh_enabled);
 	}
 
 	if (bond_mode_can_use_xmit_hash(bond))
@@ -4475,6 +4480,10 @@ static int bond_close(struct net_device *bond_dev)
 		bond_alb_deinitialize(bond);
 	bond->recv_probe = NULL;
 
+	if (BOND_MODE(bond) == BOND_MODE_8023AD &&
+	    bond->params.broadcast_neighbor)
+		static_branch_dec(&bond_bcast_neigh_enabled);
+
 	if (bond_uses_primary(bond)) {
 		rcu_read_lock();
 		slave = rcu_dereference(bond->curr_active_slave);
@@ -5310,6 +5319,37 @@ static struct slave *bond_xdp_xmit_3ad_xor_slave_get(struct bonding *bond,
 	return slaves->arr[hash % count];
 }
 
+static bool bond_should_broadcast_neighbor(struct sk_buff *skb,
+					   struct net_device *dev)
+{
+	struct bonding *bond = netdev_priv(dev);
+	struct {
+		struct ipv6hdr ip6;
+		struct icmp6hdr icmp6;
+	} *combined, _combined;
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
+	if (skb->protocol == htons(ETH_P_IPV6)) {
+		combined = skb_header_pointer(skb, skb_mac_header_len(skb),
+					      sizeof(_combined),
+					      &_combined);
+		if (combined && combined->ip6.nexthdr == NEXTHDR_ICMP &&
+		    (combined->icmp6.icmp6_type == NDISC_NEIGHBOUR_SOLICITATION ||
+		     combined->icmp6.icmp6_type == NDISC_NEIGHBOUR_ADVERTISEMENT))
+			return true;
+	}
+
+	return false;
+}
+
 /* Use this Xmit function for 3AD as well as XOR modes. The current
  * usable slave array is formed in the control path. The xmit function
  * just calculates hash and sends the packet out.
@@ -5329,17 +5369,27 @@ static netdev_tx_t bond_3ad_xor_xmit(struct sk_buff *skb,
 	return bond_tx_drop(dev, skb);
 }
 
-/* in broadcast mode, we send everything to all usable interfaces. */
+/* in broadcast mode, we send everything to all or usable slave interfaces.
+ * under rcu_read_lock when this function is called.
+ */
 static netdev_tx_t bond_xmit_broadcast(struct sk_buff *skb,
-				       struct net_device *bond_dev)
+				       struct net_device *bond_dev,
+				       bool all_slaves)
 {
 	struct bonding *bond = netdev_priv(bond_dev);
-	struct slave *slave = NULL;
-	struct list_head *iter;
+	struct bond_up_slave *slaves;
 	bool xmit_suc = false;
 	bool skb_used = false;
+	int slaves_count, i;
 
-	bond_for_each_slave_rcu(bond, slave, iter) {
+	if (all_slaves)
+		slaves = rcu_dereference(bond->all_slaves);
+	else
+		slaves = rcu_dereference(bond->usable_slaves);
+
+	slaves_count = slaves ? READ_ONCE(slaves->count) : 0;
+	for (i = 0; i < slaves_count; i++) {
+		struct slave *slave = slaves->arr[i];
 		struct sk_buff *skb2;
 
 		if (!(bond_slave_is_up(slave) && slave->link == BOND_LINK_UP))
@@ -5577,10 +5627,13 @@ static netdev_tx_t __bond_start_xmit(struct sk_buff *skb, struct net_device *dev
 	case BOND_MODE_ACTIVEBACKUP:
 		return bond_xmit_activebackup(skb, dev);
 	case BOND_MODE_8023AD:
+		if (bond_should_broadcast_neighbor(skb, dev))
+			return bond_xmit_broadcast(skb, dev, false);
+		fallthrough;
 	case BOND_MODE_XOR:
 		return bond_3ad_xor_xmit(skb, dev);
 	case BOND_MODE_BROADCAST:
-		return bond_xmit_broadcast(skb, dev);
+		return bond_xmit_broadcast(skb, dev, true);
 	case BOND_MODE_ALB:
 		return bond_alb_xmit(skb, dev);
 	case BOND_MODE_TLB:
@@ -6456,6 +6509,7 @@ static int __init bond_check_params(struct bond_params *params)
 	eth_zero_addr(params->ad_actor_system);
 	params->ad_user_port_key = ad_user_port_key;
 	params->coupled_control = 1;
+	params->broadcast_neighbor = 0;
 	if (packets_per_slave > 0) {
 		params->reciprocal_packets_per_slave =
 			reciprocal_value(packets_per_slave);
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 91893c29b899..1d639a3be6ba 100644
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
+	{ "off", 0, BOND_VALFLAG_DEFAULT},
+	{ "on",	 1, 0},
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
+		.desc = "Broadcast neighbor packets to all active slaves",
+		.unsuppmodes = BOND_MODE_ALL_EX(BIT(BOND_MODE_8023AD)),
+		.values = bond_broadcast_neigh_tbl,
+		.set = bond_option_broadcast_neigh_set,
 	}
 };
 
@@ -894,6 +910,13 @@ static int bond_option_mode_set(struct bonding *bond,
 	bond->params.arp_validate = BOND_ARP_VALIDATE_NONE;
 	bond->params.mode = newval->value;
 
+	/* When changing mode, the bond device is down, we may reduce
+	 * the bond_bcast_neigh_enabled in bond_close() if broadcast_neighbor
+	 * enabled in 8023ad mode. Therefore, only clear broadcast_neighbor
+	 * to 0.
+	 */
+	bond->params.broadcast_neighbor = 0;
+
 	if (bond->dev->reg_state == NETREG_REGISTERED) {
 		bool update = false;
 
@@ -1840,3 +1863,22 @@ static int bond_option_coupled_control_set(struct bonding *bond,
 	bond->params.coupled_control = newval->value;
 	return 0;
 }
+
+static int bond_option_broadcast_neigh_set(struct bonding *bond,
+					   const struct bond_opt_value *newval)
+{
+	if (bond->params.broadcast_neighbor == newval->value)
+		return 0;
+
+	bond->params.broadcast_neighbor = newval->value;
+	if (bond->dev->flags & IFF_UP) {
+		if (bond->params.broadcast_neighbor)
+			static_branch_inc(&bond_bcast_neigh_enabled);
+		else
+			static_branch_dec(&bond_bcast_neigh_enabled);
+	}
+
+	netdev_dbg(bond->dev, "Setting broadcast_neighbor to %s (%llu)\n",
+		   newval->string, newval->value);
+	return 0;
+}
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


