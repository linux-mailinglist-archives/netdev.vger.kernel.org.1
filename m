Return-Path: <netdev+bounces-273755-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEdjFgI5zGn7RQYAu9opvQ
	(envelope-from <netdev+bounces-273755-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:13:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 95046371782
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E41AA30595AD
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 21:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB0044B66B;
	Tue, 31 Mar 2026 21:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TM4HuM63"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688874418F5;
	Tue, 31 Mar 2026 21:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991300; cv=none; b=gzwuxzMWSdSk1LbyFFSHXp6AqhFaQ8HDylZrkL5Hw5x8/w8d9z79yAVdB7PsKWcC9ED/rxHsrjvNU7c1+KoDlxXttFLG7PTOHvYRajV4IGTDfXOgqu1FW5XdqtqCvFrR0W7bl0yE02p1fGbBcCEecoeHxxSz7/34fnTzwfRNKKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991300; c=relaxed/simple;
	bh=1Oj5omGci71indBriEpLAFg8hmTiCPWzaYmtTnbdZTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+BnXQ1TpE7Mew8q7YbrYkVU2MIUixXz1nJYf46ScJoR+t3Ml6Dywk+nwT7+HQFLZ3ylaxtN9UxoPl+DEXuRV8kkPhZYdYZAce29SeYWwMwiCWIGWEdD+Q7p0XAC0MTYI8iVfQ2aDUBitVdMubpU3pOjek8ITVjQW95I+VzZnNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TM4HuM63; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F76C19423;
	Tue, 31 Mar 2026 21:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774991300;
	bh=1Oj5omGci71indBriEpLAFg8hmTiCPWzaYmtTnbdZTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TM4HuM63pPcDAGJgmArIoyGy8v6sJocPS0ZlCFsjGhtJPrxx1jS4KhWWQmpCWSKRW
	 VePywgzCDiDq5SoQoNyNM8K+AtnpHM99YnzCm30/MC5qNbn6sHx4Zsxunm1q6aXtbI
	 EPl9AFjLWKuCfhTER72JWJIi/k8Ct8TkTgtpxFvWEdRhFBSCKMkpMQlWToddHV2Qdf
	 6i7t5tRvp8S85fKv4/vjU3DmddhfUN0g0BIvd6jgYbNz3JvPKzBrF7907llcaUVX88
	 UkB1XRDdz/TbMzfh8UzGqroJ8pjBh5bMw6KyEbEJlWLfVxuvnTbNiIig/yYpmWQ/hL
	 xbEEJVsRxMVSg==
From: hawk@kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	hawk@kernel.org,
	ivan@cloudflare.com,
	kernel-team@cloudflare.com
Subject: [RFC PATCH net-next 3/4] ipv4: convert inet_addr_lst to rhltable for dynamic resizing
Date: Tue, 31 Mar 2026 23:07:38 +0200
Message-ID: <20260331210739.3998753-4-hawk@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331210739.3998753-1-hawk@kernel.org>
References: <20260331210739.3998753-1-hawk@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273755-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,cloudflare.com:email]
X-Rspamd-Queue-Id: 95046371782
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jesper Dangaard Brouer <hawk@kernel.org>

The per-netns IPv4 local address hash table (inet_addr_lst) is a
fixed-size hlist with 256 buckets (IN4_ADDR_HSIZE). On hosts with many
addresses -- e.g. ~700 on Cloudflare edge nodes -- the average chain
length reaches ~2.8, making inet_lookup_ifaddr_rcu() visible in perf
profiles on the unconnected UDP sendmsg path via __ip_dev_find().

Replace the fixed hlist with an rhltable (resizable hash linked table)
that grows and shrinks automatically as addresses are added or removed.

The rhl variant is needed because the same IP can exist on multiple
interfaces. A plain rhashtable would reject the second insert with
-EEXIST, and removing one interface's address would silently drop the
other from the table. All current callers only need first-match
semantics, which rhltable_lookup() provides.

The rhashtable_params are tuned for this use case:

 - No explicit .hashfn: with key_len = sizeof(__be32), the default
   path calls jhash2(key, 1, seed) which the compiler fully inlines.

 - .obj_cmpfn: a direct __be32 comparison replacing the generic
   memcmp() in the default rhashtable_compare(). The compiler inlines
   this to a single cmp instruction.

 - .min_size = 32: most network namespaces only have loopback, so 32
   buckets (256 bytes) is sufficient and saves memory compared to the
   old fixed 256-bucket table (2048 bytes per netns).

With these settings, objdump confirms zero indirect calls and zero
function calls to hashfn or cmpfn in the lookup path.

The check_lifetime() work function previously iterated all hash buckets
directly. Convert it to walk for_each_netdev -> in_dev->ifa_list, which
is the natural way to enumerate all addresses and avoids coupling the
lifetime logic to hash table internals.

The rhltable serves as a lookup cache for __ip_dev_find(). If
rhltable_insert() fails (e.g. -ENOMEM during table resize), the address
remains on in_dev->ifa_list and lookups fall back to the slower but
always-correct fib_table_lookup() path. A pr_warn is emitted on insert
failure for diagnostics. On remove, -ENOENT is tolerated since the
preceding insert may have failed.

Reported-by: Ivan Babrou <ivan@cloudflare.com>
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 include/linux/inetdevice.h |   3 +-
 include/net/ip.h           |   5 --
 include/net/netns/ipv4.h   |   4 +-
 net/ipv4/Kconfig           |  16 ----
 net/ipv4/devinet.c         | 149 +++++++++++++++++++++----------------
 5 files changed, 88 insertions(+), 89 deletions(-)

diff --git a/include/linux/inetdevice.h b/include/linux/inetdevice.h
index dccbeb25f701..e2f7a2f721c9 100644
--- a/include/linux/inetdevice.h
+++ b/include/linux/inetdevice.h
@@ -13,6 +13,7 @@
 #include <linux/sysctl.h>
 #include <linux/rtnetlink.h>
 #include <linux/refcount.h>
+#include <linux/rhashtable-types.h>
 
 struct ipv4_devconf {
 	void	*sysctl;
@@ -141,7 +142,7 @@ static inline void ipv4_devconf_setall(struct in_device *in_dev)
 							  ARP_EVICT_NOCARRIER)
 
 struct in_ifaddr {
-	struct hlist_node	addr_lst;
+	struct rhlist_head	addr_lst;
 	struct in_ifaddr	__rcu *ifa_next;
 	struct in_device	*ifa_dev;
 	struct rcu_head		rcu_head;
diff --git a/include/net/ip.h b/include/net/ip.h
index f39a3787fedd..03932ec93d67 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -705,11 +705,6 @@ static inline unsigned int ipv4_addr_hash(__be32 ip)
 	return (__force unsigned int) ip;
 }
 
-static inline u32 __ipv4_addr_hash(const __be32 ip, const u32 initval)
-{
-	return jhash_1word((__force u32)ip, initval);
-}
-
 static inline u32 ipv4_portaddr_hash(const struct net *net,
 				     __be32 saddr,
 				     unsigned int port)
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 80ccd4dda8e0..f956ea1b23ca 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -11,11 +11,11 @@
 #include <linux/rcupdate.h>
 #include <linux/seqlock.h>
 #include <linux/siphash.h>
+#include <linux/rhashtable-types.h>
 
 struct ctl_table_header;
 struct ipv4_devconf;
 struct fib_rules_ops;
-struct hlist_head;
 struct fib_table;
 struct sock;
 struct local_ports {
@@ -296,7 +296,7 @@ struct netns_ipv4 {
 
 	atomic_t	rt_genid;
 	siphash_key_t	ip_id_key;
-	struct hlist_head	*inet_addr_lst;
+	struct rhltable		inet_addr_lst;
 	struct delayed_work	addr_chk_work;
 };
 
diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
index 3c5e5e74b3e4..df922f9f5289 100644
--- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -402,22 +402,6 @@ config INET_IPCOMP
 
 	  If unsure, say Y.
 
-config INET_ADDR_HASH_BUCKETS
-	int "IPv4 address hash table size" if EXPERT
-	range 64 16384
-	default 256
-	help
-	  Number of hash buckets for looking up local IPv4 addresses,
-	  e.g. during route output to validate the source address via
-	  __ip_dev_find().  Rounded up to the nearest power of 2.
-
-	  Hosts with many IPv4 addresses benefit from a larger table to reduce
-	  hash chain lengths. This is particularly relevant when sending using
-	  unconnected UDP sockets.
-
-	  The default of 256 is fine for most systems.  A value of 1024
-	  suits hosts with ~500+ addresses.
-
 config INET_TABLE_PERTURB_ORDER
 	int "INET: Source port perturbation table size (as power of 2)" if EXPERT
 	default 16
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 9e3da06fb618..a02a31d68b2f 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -49,6 +49,7 @@
 #include "igmp_internal.h"
 #include <linux/slab.h>
 #include <linux/hash.h>
+#include <linux/rhashtable.h>
 #ifdef CONFIG_SYSCTL
 #include <linux/sysctl.h>
 #endif
@@ -108,28 +109,45 @@ static const struct nla_policy ifa_ipv4_policy[IFA_MAX+1] = {
 	[IFA_PROTO]		= { .type = NLA_U8 },
 };
 
-#define IN4_ADDR_HSIZE_SHIFT	order_base_2(CONFIG_INET_ADDR_HASH_BUCKETS)
-#define IN4_ADDR_HSIZE		(1U << IN4_ADDR_HSIZE_SHIFT)
-
-static u32 inet_addr_hash(const struct net *net, __be32 addr)
+static int inet_addr_cmpfn(struct rhashtable_compare_arg *arg, const void *obj)
 {
-	u32 val = __ipv4_addr_hash(addr, net_hash_mix(net));
+	const struct in_ifaddr *ifa = obj;
+	const __be32 *key = arg->key;
 
-	return hash_32(val, IN4_ADDR_HSIZE_SHIFT);
+	return *key != ifa->ifa_local;
 }
 
+static const struct rhashtable_params inet_addr_rht_params = {
+	.head_offset	= offsetof(struct in_ifaddr, addr_lst),
+	.key_offset	= offsetof(struct in_ifaddr, ifa_local),
+	.key_len	= sizeof(__be32),
+	.min_size	= 32,
+	.obj_cmpfn	= inet_addr_cmpfn,
+	.automatic_shrinking = true,
+};
+
 static void inet_hash_insert(struct net *net, struct in_ifaddr *ifa)
 {
-	u32 hash = inet_addr_hash(net, ifa->ifa_local);
+	int err;
 
 	ASSERT_RTNL();
-	hlist_add_head_rcu(&ifa->addr_lst, &net->ipv4.inet_addr_lst[hash]);
+	err = rhltable_insert(&net->ipv4.inet_addr_lst, &ifa->addr_lst,
+			      inet_addr_rht_params);
+	/* Non-fatal: lookups fall back to fib_table_lookup() */
+	if (unlikely(err))
+		pr_warn("%s() failed for %pI4: %d\n",
+			__func__, &ifa->ifa_local, err);
 }
 
-static void inet_hash_remove(struct in_ifaddr *ifa)
+static void inet_hash_remove(struct net *net, struct in_ifaddr *ifa)
 {
+	int err;
+
 	ASSERT_RTNL();
-	hlist_del_init_rcu(&ifa->addr_lst);
+	err = rhltable_remove(&net->ipv4.inet_addr_lst, &ifa->addr_lst,
+			      inet_addr_rht_params);
+	/* -ENOENT is fine: insert may have failed earlier (e.g. -ENOMEM) */
+	WARN_ON_ONCE(err && err != -ENOENT);
 }
 
 /**
@@ -173,12 +191,12 @@ EXPORT_SYMBOL(__ip_dev_find);
 /* called under RCU lock */
 struct in_ifaddr *inet_lookup_ifaddr_rcu(struct net *net, __be32 addr)
 {
-	u32 hash = inet_addr_hash(net, addr);
-	struct in_ifaddr *ifa;
+	struct rhlist_head *rhl;
 
-	hlist_for_each_entry_rcu(ifa, &net->ipv4.inet_addr_lst[hash], addr_lst)
-		if (ifa->ifa_local == addr)
-			return ifa;
+	rhl = rhltable_lookup(&net->ipv4.inet_addr_lst, &addr,
+			      inet_addr_rht_params);
+	if (rhl)
+		return container_of(rhl, struct in_ifaddr, addr_lst);
 
 	return NULL;
 }
@@ -216,7 +234,7 @@ static struct in_ifaddr *inet_alloc_ifa(struct in_device *in_dev)
 	in_dev_hold(in_dev);
 	ifa->ifa_dev = in_dev;
 
-	INIT_HLIST_NODE(&ifa->addr_lst);
+	memset(&ifa->addr_lst, 0, sizeof(ifa->addr_lst));
 
 	return ifa;
 }
@@ -405,7 +423,7 @@ static void __inet_del_ifa(struct in_device *in_dev,
 			}
 
 			if (!do_promote) {
-				inet_hash_remove(ifa);
+				inet_hash_remove(dev_net(in_dev->dev), ifa);
 				*ifap1 = ifa->ifa_next;
 
 				rtmsg_ifa(RTM_DELADDR, ifa, nlh, portid);
@@ -434,7 +452,7 @@ static void __inet_del_ifa(struct in_device *in_dev,
 	/* 2. Unlink it */
 
 	*ifap = ifa1->ifa_next;
-	inet_hash_remove(ifa1);
+	inet_hash_remove(dev_net(in_dev->dev), ifa1);
 
 	/* 3. Announce address deletion */
 
@@ -709,21 +727,24 @@ static int inet_rtm_deladdr(struct sk_buff *skb, struct nlmsghdr *nlh,
 static void check_lifetime(struct work_struct *work)
 {
 	unsigned long now, next, next_sec, next_sched;
+	bool change_needed = false;
+	struct in_device *in_dev;
+	struct net_device *dev;
 	struct in_ifaddr *ifa;
-	struct hlist_node *n;
 	struct net *net;
-	int i;
 
 	net = container_of(to_delayed_work(work), struct net, ipv4.addr_chk_work);
 	now = jiffies;
 	next = round_jiffies_up(now + ADDR_CHECK_FREQUENCY);
 
-	for (i = 0; i < IN4_ADDR_HSIZE; i++) {
-		struct hlist_head *head = &net->ipv4.inet_addr_lst[i];
-		bool change_needed = false;
+	rcu_read_lock();
+	for_each_netdev_rcu(net, dev) {
+		in_dev = __in_dev_get_rcu(dev);
+		if (!in_dev)
+			continue;
 
-		rcu_read_lock();
-		hlist_for_each_entry_rcu(ifa, head, addr_lst) {
+		for (ifa = rcu_dereference(in_dev->ifa_list); ifa;
+		     ifa = rcu_dereference(ifa->ifa_next)) {
 			unsigned long age, tstamp;
 			u32 preferred_lft;
 			u32 valid_lft;
@@ -757,43 +778,47 @@ static void check_lifetime(struct work_struct *work)
 				next = tstamp + preferred_lft * HZ;
 			}
 		}
-		rcu_read_unlock();
-		if (!change_needed)
-			continue;
+	}
+	rcu_read_unlock();
 
+	if (change_needed) {
 		rtnl_net_lock(net);
-		hlist_for_each_entry_safe(ifa, n, head, addr_lst) {
-			unsigned long age;
+		for_each_netdev(net, dev) {
+			struct in_ifaddr __rcu **ifap;
 
-			if (ifa->ifa_flags & IFA_F_PERMANENT)
+			in_dev = __in_dev_get_rtnl_net(dev);
+			if (!in_dev)
 				continue;
 
-			/* We try to batch several events at once. */
-			age = (now - ifa->ifa_tstamp +
-			       ADDRCONF_TIMER_FUZZ_MINUS) / HZ;
+			ifap = &in_dev->ifa_list;
+			ifa = rtnl_net_dereference(net, *ifap);
+			while (ifa) {
+				unsigned long age;
 
-			if (ifa->ifa_valid_lft != INFINITY_LIFE_TIME &&
-			    age >= ifa->ifa_valid_lft) {
-				struct in_ifaddr __rcu **ifap;
-				struct in_ifaddr *tmp;
-
-				ifap = &ifa->ifa_dev->ifa_list;
-				tmp = rtnl_net_dereference(net, *ifap);
-				while (tmp) {
-					if (tmp == ifa) {
-						inet_del_ifa(ifa->ifa_dev,
-							     ifap, 1);
-						break;
-					}
-					ifap = &tmp->ifa_next;
-					tmp = rtnl_net_dereference(net, *ifap);
+				if (ifa->ifa_flags & IFA_F_PERMANENT) {
+					ifap = &ifa->ifa_next;
+					ifa = rtnl_net_dereference(net, *ifap);
+					continue;
 				}
-			} else if (ifa->ifa_preferred_lft !=
-				   INFINITY_LIFE_TIME &&
-				   age >= ifa->ifa_preferred_lft &&
-				   !(ifa->ifa_flags & IFA_F_DEPRECATED)) {
-				ifa->ifa_flags |= IFA_F_DEPRECATED;
-				rtmsg_ifa(RTM_NEWADDR, ifa, NULL, 0);
+
+				/* We try to batch several events at once. */
+				age = (now - ifa->ifa_tstamp +
+				       ADDRCONF_TIMER_FUZZ_MINUS) / HZ;
+
+				if (ifa->ifa_valid_lft != INFINITY_LIFE_TIME &&
+				    age >= ifa->ifa_valid_lft) {
+					inet_del_ifa(in_dev, ifap, 1);
+					ifa = rtnl_net_dereference(net, *ifap);
+					continue;
+				} else if (ifa->ifa_preferred_lft !=
+					   INFINITY_LIFE_TIME &&
+					   age >= ifa->ifa_preferred_lft &&
+					   !(ifa->ifa_flags & IFA_F_DEPRECATED)) {
+					ifa->ifa_flags |= IFA_F_DEPRECATED;
+					rtmsg_ifa(RTM_NEWADDR, ifa, NULL, 0);
+				}
+				ifap = &ifa->ifa_next;
+				ifa = rtnl_net_dereference(net, *ifap);
 			}
 		}
 		rtnl_net_unlock(net);
@@ -2786,12 +2811,9 @@ static __net_init int devinet_init_net(struct net *net)
 #endif
 	struct ipv4_devconf *all, *dflt;
 	int err;
-	int i;
 
-	err = -ENOMEM;
-	net->ipv4.inet_addr_lst = kmalloc_objs(struct hlist_head,
-					       IN4_ADDR_HSIZE);
-	if (!net->ipv4.inet_addr_lst)
+	err = rhltable_init(&net->ipv4.inet_addr_lst, &inet_addr_rht_params);
+	if (err)
 		goto err_alloc_hash;
 
 	all = kmemdup(&ipv4_devconf, sizeof(ipv4_devconf), GFP_KERNEL);
@@ -2854,9 +2876,6 @@ static __net_init int devinet_init_net(struct net *net)
 	net->ipv4.forw_hdr = forw_hdr;
 #endif
 
-	for (i = 0; i < IN4_ADDR_HSIZE; i++)
-		INIT_HLIST_HEAD(&net->ipv4.inet_addr_lst[i]);
-
 	INIT_DEFERRABLE_WORK(&net->ipv4.addr_chk_work, check_lifetime);
 
 	net->ipv4.devconf_all = all;
@@ -2876,7 +2895,7 @@ static __net_init int devinet_init_net(struct net *net)
 err_alloc_dflt:
 	kfree(all);
 err_alloc_all:
-	kfree(net->ipv4.inet_addr_lst);
+	rhltable_destroy(&net->ipv4.inet_addr_lst);
 err_alloc_hash:
 	return err;
 }
@@ -2900,7 +2919,7 @@ static __net_exit void devinet_exit_net(struct net *net)
 #endif
 	kfree(net->ipv4.devconf_dflt);
 	kfree(net->ipv4.devconf_all);
-	kfree(net->ipv4.inet_addr_lst);
+	rhltable_destroy(&net->ipv4.inet_addr_lst);
 }
 
 static __net_initdata struct pernet_operations devinet_ops = {
-- 
2.43.0


