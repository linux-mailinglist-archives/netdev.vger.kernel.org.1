Return-Path: <netdev+bounces-189441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E16AB2135
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 06:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C0D61BC80D7
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 04:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2A91C8611;
	Sat, 10 May 2025 04:48:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B491C5D4B
	for <netdev@vger.kernel.org>; Sat, 10 May 2025 04:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746852506; cv=none; b=jimFW31xRHYYrpLg2EgM0BD148OZiNDbGSOJjHi/Nn9ii6HTq67+es9TrujYf05WlEZ6wlnuGs7Q+/639fLpnsVylBPGXPJvuaQVDPTXqZsUV0W6mEmkEfhITZSqGcBu9aUhQuLIOvajQkFCZrHQWWf3Ml5bXHnQGibSE9uNQIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746852506; c=relaxed/simple;
	bh=i7LDU6TWvn24NipdvD/HU1nKSaTTmbwfxkkhpgHpL8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X0V8mV35jSYGwJHG5/O+mq8IiVztF5KkprJWtkMjvpjb8AaZpLXap89zyP5zhVzD687viUHRVZwytAOcP52m02dh9LABtS/WlpfdrJK8knpO9BV2HEmV1WFaIyxQLR0K6X/pSAm1farfDw/HuqXQV8mo5OGsuEA+N9Gz6yPMu9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz12t1746852323t21eb4e57
X-QQ-Originating-IP: 5m/I5XJrfSSh6bmBoe+so8iLKhl70bPWu+4061qJv00=
Received: from macbook-dev.xiaojukeji.com ( [111.201.145.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 10 May 2025 12:45:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10256398303719807046
EX-QQ-RecipientCnt: 10
From: tonghao@bamaicloud.com
To: netdev@vger.kernel.org
Cc: Tonghao Zhang <tonghao@bamaicloud.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH net-next 1/4] net: bonding: add broadcast_neighbor option for 802.3ad
Date: Sat, 10 May 2025 12:45:01 +0800
Message-Id: <20250510044504.52618-2-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20250510044504.52618-1-tonghao@bamaicloud.com>
References: <20250510044504.52618-1-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: N2dNga98lfCac4D0ZL8AM6X3bgnTrppejTIwFjWlXi1jLWUgskYbfOBb
	XKGwyLMy1r2apuWfC7KKcU4CXyjbayiEEjv5ZR4vADvsK0cEKHRFX836ylYcAyXdpedWsc5
	m7tOpkH2Mb/7q0n4QQIX+JidHBQMdabS3b7zLmDXuFpPgVdQgclJ1VRXbJkHll6ItMAiSQ6
	Tz+8SyqOjQsTjpiZx1VX4V2xt1zULpEk7CadLPZQBTFFoahPZZEjqrkzF8PK9wLOQDMKG6p
	393tzhrCwc9BHJVjxIV0bEX6hulpE4jJ3PY6gThu9/lOoxXu+dsDCOvqfDrN9lpstgyhAyb
	dUV8LVccXZCJ1N38xtXo/ZQTrTkoQl6q4ui7KwhaZERjucuXQH7D4DgTqDacwD7vn4QJ2DP
	7d5HJb9Y/CMu1L0IBIo/I6/u1OzasBzgtNkesaGhLJcZ2phxrWUh5WJW3f4wVVlAzfNey2p
	mKUvrjeh/fcKsAXf+GuUUVlvJ7GF9XFhXWu/L/+IUYbiWM6ARIYLKpjAdRNSgx5bU6tY7Ch
	bqD9FX70E+jdTGmvIInC2Pk89eWc0VLMX7U3otYZinKZxzzCn6hnqpxCRhNhMEAT13qXvMw
	4Ayd6qO0CKwP8Fo1X1iOBPsMfI9dT5xNHy7ASWZ174Yi9ByTcNnpwwU10FG+bFt+5KrKYZs
	3qwNTSIa2kGoJtz+8bGY9tNGRHrLjqT/1htC7HAfypkSkkMejPWyHNOBLnuqQyB3k4b6pF6
	35MZkyFj/zpsKDKQW917AmZFFqiP0SAWViss7Rp5d86eQYQ/ckkRKXBOMVkCbTlSsU34rRA
	DoEQ8uG/jXN/96FewSuZbUeWnAMDDVYysWBTPypfnXbji69D0ScpQSyfj5TqO2QRZQDFLl8
	S9fcvFIsBdErlVz/JeV633aQg8kRljXppG7H0B6zoTiQgZHZZbiazLiC08K1Ih0/bdBN/GG
	PMyz39iIwAvKeVLh/Ch3NYpbWj1H8efaqYncuSDYMwL2vd55f1RjDWMbHQ0ofeN90PKrbMp
	KmaPjKnq4AFXpWQfv/y+DG189k1Oo=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

From: Tonghao Zhang <tonghao@bamaicloud.com>

Stacking technology provides technical benefits but has inherent drawbacks.
For instance, switch software or system upgrades require simultaneous reboots
of all stacked switches. Additionally, stacking link failures may cause
stack splitting.

To improve network stability, non-stacking solutions have been increasingly
adopted, particularly by public cloud providers and technology companies
like Alibaba, Tencent, and Didi. The server still uses dual network cards and
dual uplinks to two switches, and the network card mode is set to
bond mode 4 (IEEE 802.3ad). As aggregation ports transmit ARP/ND data
exclusively through one physical port, both switches in non-stacking
deployments must receive server ARP/ND requests. This requires bonding driver
modifications to broadcast ARP/ND packets through all active slave links.

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
---
 Documentation/networking/bonding.rst |  5 +++
 drivers/net/bonding/bond_main.c      | 58 +++++++++++++++++++++-------
 drivers/net/bonding/bond_options.c   | 25 ++++++++++++
 drivers/net/bonding/bond_sysfs.c     | 18 +++++++++
 include/net/bond_options.h           |  1 +
 include/net/bonding.h                |  1 +
 6 files changed, 94 insertions(+), 14 deletions(-)

diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
index a4c1291d2561..0aca6e7599db 100644
--- a/Documentation/networking/bonding.rst
+++ b/Documentation/networking/bonding.rst
@@ -562,6 +562,11 @@ lacp_rate
 
 	The default is slow.
 
+broadcast_neighbor
+
+    Option specifying whether to broadcast ARP/ND packets to all
+    active slaves. The default is off (0).
+
 max_bonds
 
 	Specifies the number of bonding devices to create for this
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index d05226484c64..c54bfba10688 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5316,23 +5316,31 @@ static struct slave *bond_xdp_xmit_3ad_xor_slave_get(struct bonding *bond,
 	return slaves->arr[hash % count];
 }
 
-/* Use this Xmit function for 3AD as well as XOR modes. The current
- * usable slave array is formed in the control path. The xmit function
- * just calculates hash and sends the packet out.
- */
-static netdev_tx_t bond_3ad_xor_xmit(struct sk_buff *skb,
-				     struct net_device *dev)
+static bool bond_should_broadcast_neighbor(struct bonding *bond,
+					   struct sk_buff *skb)
 {
-	struct bonding *bond = netdev_priv(dev);
-	struct bond_up_slave *slaves;
-	struct slave *slave;
+	if (BOND_MODE(bond) != BOND_MODE_8023AD)
+		return false;
 
-	slaves = rcu_dereference(bond->usable_slaves);
-	slave = bond_xmit_3ad_xor_slave_get(bond, skb, slaves);
-	if (likely(slave))
-		return bond_dev_queue_xmit(bond, skb, slave->dev);
+	if (!bond->params.broadcast_neighbor)
+		return false;
 
-	return bond_tx_drop(dev, skb);
+	if (skb->protocol == htons(ETH_P_ARP))
+		return true;
+
+        if (skb->protocol == htons(ETH_P_IPV6) &&
+            pskb_may_pull(skb,
+                          sizeof(struct ipv6hdr) + sizeof(struct icmp6hdr))) {
+                if (ipv6_hdr(skb)->nexthdr == IPPROTO_ICMPV6) {
+                        struct icmp6hdr *icmph = icmp6_hdr(skb);
+
+                        if ((icmph->icmp6_type == NDISC_NEIGHBOUR_SOLICITATION) ||
+                            (icmph->icmp6_type == NDISC_NEIGHBOUR_ADVERTISEMENT))
+                                return true;
+                }
+        }
+
+        return false;
 }
 
 /* in broadcast mode, we send everything to all usable interfaces. */
@@ -5377,6 +5385,28 @@ static netdev_tx_t bond_xmit_broadcast(struct sk_buff *skb,
 	return NET_XMIT_DROP;
 }
 
+/* Use this Xmit function for 3AD as well as XOR modes. The current
+ * usable slave array is formed in the control path. The xmit function
+ * just calculates hash and sends the packet out.
+ */
+static netdev_tx_t bond_3ad_xor_xmit(struct sk_buff *skb,
+				     struct net_device *dev)
+{
+	struct bonding *bond = netdev_priv(dev);
+	struct bond_up_slave *slaves;
+	struct slave *slave;
+
+	if (bond_should_broadcast_neighbor(bond, skb))
+		return bond_xmit_broadcast(skb, dev);
+
+	slaves = rcu_dereference(bond->usable_slaves);
+	slave = bond_xmit_3ad_xor_slave_get(bond, skb, slaves);
+	if (likely(slave))
+		return bond_dev_queue_xmit(bond, skb, slave->dev);
+
+	return bond_tx_drop(dev, skb);
+}
+
 /*------------------------- Device initialization ---------------------------*/
 
 /* Lookup the slave that corresponds to a qid */
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 91893c29b899..38e8f03d1707 100644
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
 
@@ -1840,3 +1856,12 @@ static int bond_option_coupled_control_set(struct bonding *bond,
 	bond->params.coupled_control = newval->value;
 	return 0;
 }
+
+static int bond_option_broadcast_neigh_set(struct bonding *bond,
+					   const struct bond_opt_value *newval)
+{
+	netdev_dbg(bond->dev, "Setting broadcast_neighbor to %llu\n",
+		   newval->value);
+	bond->params.broadcast_neighbor = newval->value;
+	return 0;
+}
diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bond_sysfs.c
index 1e13bb170515..76f2a1bf57c2 100644
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
+			bond->params.broadcast_neighbor);
+
+	return sysfs_emit(buf, "%s %d\n", val->string,
+			bond->params.broadcast_neighbor);
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
index 95f67b308c19..1eafd15eaad9 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -149,6 +149,7 @@ struct bond_params {
 	struct in6_addr ns_targets[BOND_MAX_NS_TARGETS];
 #endif
 	int coupled_control;
+	int broadcast_neighbor;
 
 	/* 2 bytes of padding : see ether_addr_equal_64bits() */
 	u8 ad_actor_system[ETH_ALEN + 2];
-- 
2.34.1


