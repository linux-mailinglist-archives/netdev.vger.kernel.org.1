Return-Path: <netdev+bounces-192456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D78ABFEEE
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 23:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262AE9E477B
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 21:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFA62BD024;
	Wed, 21 May 2025 21:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="i1n02/Ol"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B7F2BCF7E
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 21:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747862848; cv=none; b=mefJlOPDbL0GeIj9snQ03pAVreIwLkcMDiyiS63m1vP1x+beSfYeNCH34weFIEGa78bhJhdNGp2esvYCo25zOJQFfOL93jYjpWzn8sh2QHz/Klt6/8HoPqGzfceMwBlCYXQoLCfjOxL8KADHPLmGoK8Ef4AexModiVJQAAEpMEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747862848; c=relaxed/simple;
	bh=REJDDlqdiwqRL0P7i5fEt7IeyK51RKD0ljk+//I3VuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKYVOe5el/0o/00XXIG8ddOso9WxeRAgUBUNuR++IelhM438X2AtzX2YGnLJ0uCLnWd9H8Q5CKvWuLfA1osZaUiJ/Md6qYQfZAYvLGQQlnqGxpaXYUe5hn8EuIDeMr77+9teeaPRBVrj81G0GRkx9FwksugFj5H8Kcy/IyS2ACI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=i1n02/Ol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7CCC4CEE4;
	Wed, 21 May 2025 21:27:27 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="i1n02/Ol"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1747862846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ataPS07lJ22k+M/p9sPbZx7xRiYBg4WzGj3HOEGsA0=;
	b=i1n02/OlWUbE3ZIPpzrxAhRoJQ7qAtm6+WZ09PV4DHb4A6VP+/Hn4i0MF9uH1wGoNU5qkl
	o5DvS9dC2FNYW1HRJo3c4q3vd/62P8mXJ219eupCNSrR5XHdX0yGJM6AQruuuHZuQ5WKbL
	ndBDtrB014+rA5gmNSHY4WMTa03K4A8=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 37379490 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 May 2025 21:27:26 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net-next 4/5] wireguard: allowedips: add WGALLOWEDIP_F_REMOVE_ME flag
Date: Wed, 21 May 2025 23:27:06 +0200
Message-ID: <20250521212707.1767879-5-Jason@zx2c4.com>
In-Reply-To: <20250521212707.1767879-1-Jason@zx2c4.com>
References: <20250521212707.1767879-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jordan Rife <jordan@jrife.io>

The current netlink API for WireGuard does not directly support removal
of allowed ips from a peer. A user can remove an allowed ip from a peer
in one of two ways:

1. By using the WGPEER_F_REPLACE_ALLOWEDIPS flag and providing a new
   list of allowed ips which omits the allowed ip that is to be removed.
2. By reassigning an allowed ip to a "dummy" peer then removing that
   peer with WGPEER_F_REMOVE_ME.

With the first approach, the driver completely rebuilds the allowed ip
list for a peer. If my current configuration is such that a peer has
allowed ips 192.168.0.2 and 192.168.0.3 and I want to remove 192.168.0.2
the actual transition looks like this.

[192.168.0.2, 192.168.0.3] <-- Initial state
[]                         <-- Step 1: Allowed ips removed for peer
[192.168.0.3]              <-- Step 2: Allowed ips added back for peer

This is true even if the allowed ip list is small and the update does
not need to be batched into multiple WG_CMD_SET_DEVICE requests, as the
removal and subsequent addition of ips is non-atomic within a single
request. Consequently, wg_allowedips_lookup_dst and
wg_allowedips_lookup_src may return NULL while reconfiguring a peer even
for packets bound for ips a user did not intend to remove leading to
unintended interruptions in connectivity. This presents in userspace as
failed calls to sendto and sendmsg for UDP sockets. In my case, I ran
netperf while repeatedly reconfiguring the allowed ips for a peer with
wg.

/usr/local/bin/netperf -H 10.102.73.72 -l 10m -t UDP_STREAM -- -R 1 -m 1024
send_data: data send error: No route to host (errno 113)
netperf: send_omni: send_data failed: No route to host

While this may not be of particular concern for environments where peers
and allowed ips are mostly static, systems like Cilium manage peers and
allowed ips in a dynamic environment where peers (i.e. Kubernetes nodes)
and allowed ips (i.e. pods running on those nodes) can frequently
change making WGPEER_F_REPLACE_ALLOWEDIPS problematic.

The second approach avoids any possible connectivity interruptions
but is hacky and less direct, requiring the creation of a temporary
peer just to dispose of an allowed ip.

Introduce a new flag called WGALLOWEDIP_F_REMOVE_ME which in the same
way that WGPEER_F_REMOVE_ME allows a user to remove a single peer from
a WireGuard device's configuration allows a user to remove an ip from a
peer's set of allowed ips. This enables incremental updates to a
device's configuration without any connectivity blips or messy
workarounds.

A corresponding patch for wg extends the existing `wg set` interface to
leverage this feature.

$ wg set wg0 peer <PUBKEY> allowed-ips +192.168.88.0/24,-192.168.0.1/32

When '+' or '-' is prepended to any ip in the list, wg clears
WGPEER_F_REPLACE_ALLOWEDIPS and sets the WGALLOWEDIP_F_REMOVE_ME flag on
any ip prefixed with '-'.

Signed-off-by: Jordan Rife <jordan@jrife.io>
[Jason: minor style nits, fixes to selftest, bump of wireguard-tools version]
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/net/wireguard/allowedips.c            | 102 ++++++++++++------
 drivers/net/wireguard/allowedips.h            |   4 +
 drivers/net/wireguard/netlink.c               |  37 ++++---
 drivers/net/wireguard/selftest/allowedips.c   |  48 +++++++++
 include/uapi/linux/wireguard.h                |   9 ++
 tools/testing/selftests/wireguard/netns.sh    |  29 +++++
 .../testing/selftests/wireguard/qemu/Makefile |   2 +-
 7 files changed, 187 insertions(+), 44 deletions(-)

diff --git a/drivers/net/wireguard/allowedips.c b/drivers/net/wireguard/allowedips.c
index 4b8528206cc8..09f7fcd7da78 100644
--- a/drivers/net/wireguard/allowedips.c
+++ b/drivers/net/wireguard/allowedips.c
@@ -249,6 +249,52 @@ static int add(struct allowedips_node __rcu **trie, u8 bits, const u8 *key,
 	return 0;
 }
 
+static void remove_node(struct allowedips_node *node, struct mutex *lock)
+{
+	struct allowedips_node *child, **parent_bit, *parent;
+	bool free_parent;
+
+	list_del_init(&node->peer_list);
+	RCU_INIT_POINTER(node->peer, NULL);
+	if (node->bit[0] && node->bit[1])
+		return;
+	child = rcu_dereference_protected(node->bit[!rcu_access_pointer(node->bit[0])],
+					  lockdep_is_held(lock));
+	if (child)
+		child->parent_bit_packed = node->parent_bit_packed;
+	parent_bit = (struct allowedips_node **)(node->parent_bit_packed & ~3UL);
+	*parent_bit = child;
+	parent = (void *)parent_bit -
+			offsetof(struct allowedips_node, bit[node->parent_bit_packed & 1]);
+	free_parent = !rcu_access_pointer(node->bit[0]) && !rcu_access_pointer(node->bit[1]) &&
+			(node->parent_bit_packed & 3) <= 1 && !rcu_access_pointer(parent->peer);
+	if (free_parent)
+		child = rcu_dereference_protected(parent->bit[!(node->parent_bit_packed & 1)],
+						  lockdep_is_held(lock));
+	call_rcu(&node->rcu, node_free_rcu);
+	if (!free_parent)
+		return;
+	if (child)
+		child->parent_bit_packed = parent->parent_bit_packed;
+	*(struct allowedips_node **)(parent->parent_bit_packed & ~3UL) = child;
+	call_rcu(&parent->rcu, node_free_rcu);
+}
+
+static int remove(struct allowedips_node __rcu **trie, u8 bits, const u8 *key,
+		  u8 cidr, struct wg_peer *peer, struct mutex *lock)
+{
+	struct allowedips_node *node;
+
+	if (unlikely(cidr > bits))
+		return -EINVAL;
+	if (!rcu_access_pointer(*trie) || !node_placement(*trie, key, cidr, bits, &node, lock) ||
+	    peer != rcu_access_pointer(node->peer))
+		return 0;
+
+	remove_node(node, lock);
+	return 0;
+}
+
 void wg_allowedips_init(struct allowedips *table)
 {
 	table->root4 = table->root6 = NULL;
@@ -300,44 +346,38 @@ int wg_allowedips_insert_v6(struct allowedips *table, const struct in6_addr *ip,
 	return add(&table->root6, 128, key, cidr, peer, lock);
 }
 
+int wg_allowedips_remove_v4(struct allowedips *table, const struct in_addr *ip,
+			    u8 cidr, struct wg_peer *peer, struct mutex *lock)
+{
+	/* Aligned so it can be passed to fls */
+	u8 key[4] __aligned(__alignof(u32));
+
+	++table->seq;
+	swap_endian(key, (const u8 *)ip, 32);
+	return remove(&table->root4, 32, key, cidr, peer, lock);
+}
+
+int wg_allowedips_remove_v6(struct allowedips *table, const struct in6_addr *ip,
+			    u8 cidr, struct wg_peer *peer, struct mutex *lock)
+{
+	/* Aligned so it can be passed to fls64 */
+	u8 key[16] __aligned(__alignof(u64));
+
+	++table->seq;
+	swap_endian(key, (const u8 *)ip, 128);
+	return remove(&table->root6, 128, key, cidr, peer, lock);
+}
+
 void wg_allowedips_remove_by_peer(struct allowedips *table,
 				  struct wg_peer *peer, struct mutex *lock)
 {
-	struct allowedips_node *node, *child, **parent_bit, *parent, *tmp;
-	bool free_parent;
+	struct allowedips_node *node, *tmp;
 
 	if (list_empty(&peer->allowedips_list))
 		return;
 	++table->seq;
-	list_for_each_entry_safe(node, tmp, &peer->allowedips_list, peer_list) {
-		list_del_init(&node->peer_list);
-		RCU_INIT_POINTER(node->peer, NULL);
-		if (node->bit[0] && node->bit[1])
-			continue;
-		child = rcu_dereference_protected(node->bit[!rcu_access_pointer(node->bit[0])],
-						  lockdep_is_held(lock));
-		if (child)
-			child->parent_bit_packed = node->parent_bit_packed;
-		parent_bit = (struct allowedips_node **)(node->parent_bit_packed & ~3UL);
-		*parent_bit = child;
-		parent = (void *)parent_bit -
-			 offsetof(struct allowedips_node, bit[node->parent_bit_packed & 1]);
-		free_parent = !rcu_access_pointer(node->bit[0]) &&
-			      !rcu_access_pointer(node->bit[1]) &&
-			      (node->parent_bit_packed & 3) <= 1 &&
-			      !rcu_access_pointer(parent->peer);
-		if (free_parent)
-			child = rcu_dereference_protected(
-					parent->bit[!(node->parent_bit_packed & 1)],
-					lockdep_is_held(lock));
-		call_rcu(&node->rcu, node_free_rcu);
-		if (!free_parent)
-			continue;
-		if (child)
-			child->parent_bit_packed = parent->parent_bit_packed;
-		*(struct allowedips_node **)(parent->parent_bit_packed & ~3UL) = child;
-		call_rcu(&parent->rcu, node_free_rcu);
-	}
+	list_for_each_entry_safe(node, tmp, &peer->allowedips_list, peer_list)
+		remove_node(node, lock);
 }
 
 int wg_allowedips_read_node(struct allowedips_node *node, u8 ip[16], u8 *cidr)
diff --git a/drivers/net/wireguard/allowedips.h b/drivers/net/wireguard/allowedips.h
index 2346c797eb4d..931958cb6e10 100644
--- a/drivers/net/wireguard/allowedips.h
+++ b/drivers/net/wireguard/allowedips.h
@@ -38,6 +38,10 @@ int wg_allowedips_insert_v4(struct allowedips *table, const struct in_addr *ip,
 			    u8 cidr, struct wg_peer *peer, struct mutex *lock);
 int wg_allowedips_insert_v6(struct allowedips *table, const struct in6_addr *ip,
 			    u8 cidr, struct wg_peer *peer, struct mutex *lock);
+int wg_allowedips_remove_v4(struct allowedips *table, const struct in_addr *ip,
+			    u8 cidr, struct wg_peer *peer, struct mutex *lock);
+int wg_allowedips_remove_v6(struct allowedips *table, const struct in6_addr *ip,
+			    u8 cidr, struct wg_peer *peer, struct mutex *lock);
 void wg_allowedips_remove_by_peer(struct allowedips *table,
 				  struct wg_peer *peer, struct mutex *lock);
 /* The ip input pointer should be __aligned(__alignof(u64))) */
diff --git a/drivers/net/wireguard/netlink.c b/drivers/net/wireguard/netlink.c
index bbb1a7fe1c57..67f962eb8b46 100644
--- a/drivers/net/wireguard/netlink.c
+++ b/drivers/net/wireguard/netlink.c
@@ -46,7 +46,8 @@ static const struct nla_policy peer_policy[WGPEER_A_MAX + 1] = {
 static const struct nla_policy allowedip_policy[WGALLOWEDIP_A_MAX + 1] = {
 	[WGALLOWEDIP_A_FAMILY]		= { .type = NLA_U16 },
 	[WGALLOWEDIP_A_IPADDR]		= NLA_POLICY_MIN_LEN(sizeof(struct in_addr)),
-	[WGALLOWEDIP_A_CIDR_MASK]	= { .type = NLA_U8 }
+	[WGALLOWEDIP_A_CIDR_MASK]	= { .type = NLA_U8 },
+	[WGALLOWEDIP_A_FLAGS]		= NLA_POLICY_MASK(NLA_U32, __WGALLOWEDIP_F_ALL),
 };
 
 static struct wg_device *lookup_interface(struct nlattr **attrs,
@@ -329,6 +330,7 @@ static int set_port(struct wg_device *wg, u16 port)
 static int set_allowedip(struct wg_peer *peer, struct nlattr **attrs)
 {
 	int ret = -EINVAL;
+	u32 flags = 0;
 	u16 family;
 	u8 cidr;
 
@@ -337,19 +339,30 @@ static int set_allowedip(struct wg_peer *peer, struct nlattr **attrs)
 		return ret;
 	family = nla_get_u16(attrs[WGALLOWEDIP_A_FAMILY]);
 	cidr = nla_get_u8(attrs[WGALLOWEDIP_A_CIDR_MASK]);
+	if (attrs[WGALLOWEDIP_A_FLAGS])
+		flags = nla_get_u32(attrs[WGALLOWEDIP_A_FLAGS]);
 
 	if (family == AF_INET && cidr <= 32 &&
-	    nla_len(attrs[WGALLOWEDIP_A_IPADDR]) == sizeof(struct in_addr))
-		ret = wg_allowedips_insert_v4(
-			&peer->device->peer_allowedips,
-			nla_data(attrs[WGALLOWEDIP_A_IPADDR]), cidr, peer,
-			&peer->device->device_update_lock);
-	else if (family == AF_INET6 && cidr <= 128 &&
-		 nla_len(attrs[WGALLOWEDIP_A_IPADDR]) == sizeof(struct in6_addr))
-		ret = wg_allowedips_insert_v6(
-			&peer->device->peer_allowedips,
-			nla_data(attrs[WGALLOWEDIP_A_IPADDR]), cidr, peer,
-			&peer->device->device_update_lock);
+	    nla_len(attrs[WGALLOWEDIP_A_IPADDR]) == sizeof(struct in_addr)) {
+		if (flags & WGALLOWEDIP_F_REMOVE_ME)
+			ret = wg_allowedips_remove_v4(&peer->device->peer_allowedips,
+						      nla_data(attrs[WGALLOWEDIP_A_IPADDR]), cidr,
+						      peer, &peer->device->device_update_lock);
+		else
+			ret = wg_allowedips_insert_v4(&peer->device->peer_allowedips,
+						      nla_data(attrs[WGALLOWEDIP_A_IPADDR]), cidr,
+						      peer, &peer->device->device_update_lock);
+	} else if (family == AF_INET6 && cidr <= 128 &&
+		   nla_len(attrs[WGALLOWEDIP_A_IPADDR]) == sizeof(struct in6_addr)) {
+		if (flags & WGALLOWEDIP_F_REMOVE_ME)
+			ret = wg_allowedips_remove_v6(&peer->device->peer_allowedips,
+						      nla_data(attrs[WGALLOWEDIP_A_IPADDR]), cidr,
+						      peer, &peer->device->device_update_lock);
+		else
+			ret = wg_allowedips_insert_v6(&peer->device->peer_allowedips,
+						      nla_data(attrs[WGALLOWEDIP_A_IPADDR]), cidr,
+						      peer, &peer->device->device_update_lock);
+	}
 
 	return ret;
 }
diff --git a/drivers/net/wireguard/selftest/allowedips.c b/drivers/net/wireguard/selftest/allowedips.c
index 25de7058701a..41837efa70cb 100644
--- a/drivers/net/wireguard/selftest/allowedips.c
+++ b/drivers/net/wireguard/selftest/allowedips.c
@@ -460,6 +460,10 @@ static __init struct wg_peer *init_peer(void)
 	wg_allowedips_insert_v##version(&t, ip##version(ipa, ipb, ipc, ipd), \
 					cidr, mem, &mutex)
 
+#define remove(version, mem, ipa, ipb, ipc, ipd, cidr)                      \
+	wg_allowedips_remove_v##version(&t, ip##version(ipa, ipb, ipc, ipd), \
+					cidr, mem, &mutex)
+
 #define maybe_fail() do {                                               \
 		++i;                                                    \
 		if (!_s) {                                              \
@@ -585,6 +589,50 @@ bool __init wg_allowedips_selftest(void)
 	test_negative(4, a, 192, 0, 0, 0);
 	test_negative(4, a, 255, 0, 0, 0);
 
+	insert(4, a, 1, 0, 0, 0, 32);
+	insert(4, a, 192, 0, 0, 0, 24);
+	insert(6, a, 0x24446801, 0x40e40800, 0xdeaebeef, 0xdefbeef, 128);
+	insert(6, a, 0x24446800, 0xf0e40800, 0xeeaebeef, 0, 98);
+	test(4, a, 1, 0, 0, 0);
+	test(4, a, 192, 0, 0, 1);
+	test(6, a, 0x24446801, 0x40e40800, 0xdeaebeef, 0xdefbeef);
+	test(6, a, 0x24446800, 0xf0e40800, 0xeeaebeef, 0x10101010);
+	/* Must be an exact match to remove */
+	remove(4, a, 192, 0, 0, 0, 32);
+	test(4, a, 192, 0, 0, 1);
+	/* NULL peer should have no effect and return 0 */
+	test_boolean(!remove(4, NULL, 192, 0, 0, 0, 24));
+	test(4, a, 192, 0, 0, 1);
+	/* different peer should have no effect and return 0 */
+	test_boolean(!remove(4, b, 192, 0, 0, 0, 24));
+	test(4, a, 192, 0, 0, 1);
+	/* invalid CIDR should have no effect and return -EINVAL */
+	test_boolean(remove(4, b, 192, 0, 0, 0, 33) == -EINVAL);
+	test(4, a, 192, 0, 0, 1);
+	remove(4, a, 192, 0, 0, 0, 24);
+	test_negative(4, a, 192, 0, 0, 1);
+	remove(4, a, 1, 0, 0, 0, 32);
+	test_negative(4, a, 1, 0, 0, 0);
+	/* Must be an exact match to remove */
+	remove(6, a, 0x24446801, 0x40e40800, 0xdeaebeef, 0xdefbeef, 96);
+	test(6, a, 0x24446801, 0x40e40800, 0xdeaebeef, 0xdefbeef);
+	/* NULL peer should have no effect and return 0 */
+	test_boolean(!remove(6, NULL, 0x24446801, 0x40e40800, 0xdeaebeef, 0xdefbeef, 128));
+	test(6, a, 0x24446801, 0x40e40800, 0xdeaebeef, 0xdefbeef);
+	/* different peer should have no effect and return 0 */
+	test_boolean(!remove(6, b, 0x24446801, 0x40e40800, 0xdeaebeef, 0xdefbeef, 128));
+	test(6, a, 0x24446801, 0x40e40800, 0xdeaebeef, 0xdefbeef);
+	/* invalid CIDR should have no effect and return -EINVAL */
+	test_boolean(remove(6, a, 0x24446801, 0x40e40800, 0xdeaebeef, 0xdefbeef, 129)  == -EINVAL);
+	test(6, a, 0x24446801, 0x40e40800, 0xdeaebeef, 0xdefbeef);
+	remove(6, a, 0x24446801, 0x40e40800, 0xdeaebeef, 0xdefbeef, 128);
+	test_negative(6, a, 0x24446801, 0x40e40800, 0xdeaebeef, 0xdefbeef);
+	/* Must match the peer to remove */
+	remove(6, b, 0x24446800, 0xf0e40800, 0xeeaebeef, 0, 98);
+	test(6, a, 0x24446800, 0xf0e40800, 0xeeaebeef, 0x10101010);
+	remove(6, a, 0x24446800, 0xf0e40800, 0xeeaebeef, 0, 98);
+	test_negative(6, a, 0x24446800, 0xf0e40800, 0xeeaebeef, 0x10101010);
+
 	wg_allowedips_free(&t, &mutex);
 	wg_allowedips_init(&t);
 	insert(4, a, 192, 168, 0, 0, 16);
diff --git a/include/uapi/linux/wireguard.h b/include/uapi/linux/wireguard.h
index ae88be14c947..8c26391196d5 100644
--- a/include/uapi/linux/wireguard.h
+++ b/include/uapi/linux/wireguard.h
@@ -101,6 +101,10 @@
  *                    WGALLOWEDIP_A_FAMILY: NLA_U16
  *                    WGALLOWEDIP_A_IPADDR: struct in_addr or struct in6_addr
  *                    WGALLOWEDIP_A_CIDR_MASK: NLA_U8
+ *                    WGALLOWEDIP_A_FLAGS: NLA_U32, WGALLOWEDIP_F_REMOVE_ME if
+ *                                         the specified IP should be removed;
+ *                                         otherwise, this IP will be added if
+ *                                         it is not already present.
  *                0: NLA_NESTED
  *                    ...
  *                0: NLA_NESTED
@@ -184,11 +188,16 @@ enum wgpeer_attribute {
 };
 #define WGPEER_A_MAX (__WGPEER_A_LAST - 1)
 
+enum wgallowedip_flag {
+	WGALLOWEDIP_F_REMOVE_ME = 1U << 0,
+	__WGALLOWEDIP_F_ALL = WGALLOWEDIP_F_REMOVE_ME
+};
 enum wgallowedip_attribute {
 	WGALLOWEDIP_A_UNSPEC,
 	WGALLOWEDIP_A_FAMILY,
 	WGALLOWEDIP_A_IPADDR,
 	WGALLOWEDIP_A_CIDR_MASK,
+	WGALLOWEDIP_A_FLAGS,
 	__WGALLOWEDIP_A_LAST
 };
 #define WGALLOWEDIP_A_MAX (__WGALLOWEDIP_A_LAST - 1)
diff --git a/tools/testing/selftests/wireguard/netns.sh b/tools/testing/selftests/wireguard/netns.sh
index 55500f901fbc..a8f550aecb35 100755
--- a/tools/testing/selftests/wireguard/netns.sh
+++ b/tools/testing/selftests/wireguard/netns.sh
@@ -611,6 +611,35 @@ n0 wg set wg0 peer "$pub2" allowed-ips "$allowedips"
 } < <(n0 wg show wg0 allowed-ips)
 ip0 link del wg0
 
+allowedips=( )
+for i in {1..197}; do
+        allowedips+=( 192.168.0.$i )
+        allowedips+=( abcd::$i )
+done
+saved_ifs="$IFS"
+IFS=,
+allowedips="${allowedips[*]}"
+IFS="$saved_ifs"
+ip0 link add wg0 type wireguard
+n0 wg set wg0 peer "$pub1" allowed-ips "$allowedips"
+n0 wg set wg0 peer "$pub1" allowed-ips -192.168.0.1/32,-192.168.0.20/32,-192.168.0.100/32,-abcd::1/128,-abcd::20/128,-abcd::100/128
+{
+	read -r pub allowedips
+	[[ $pub == "$pub1" ]]
+	i=0
+	for ip in $allowedips; do
+		[[ $ip != "192.168.0.1" ]]
+		[[ $ip != "192.168.0.20" ]]
+		[[ $ip != "192.168.0.100" ]]
+		[[ $ip != "abcd::1" ]]
+		[[ $ip != "abcd::20" ]]
+		[[ $ip != "abcd::100" ]]
+		((++i))
+	done
+	((i == 388))
+} < <(n0 wg show wg0 allowed-ips)
+ip0 link del wg0
+
 ! n0 wg show doesnotexist || false
 
 ip0 link add wg0 type wireguard
diff --git a/tools/testing/selftests/wireguard/qemu/Makefile b/tools/testing/selftests/wireguard/qemu/Makefile
index 35856b11c143..f6fbd88914ee 100644
--- a/tools/testing/selftests/wireguard/qemu/Makefile
+++ b/tools/testing/selftests/wireguard/qemu/Makefile
@@ -43,7 +43,7 @@ $(eval $(call tar_download,IPROUTE2,iproute2,5.17.0,.tar.gz,https://www.kernel.o
 $(eval $(call tar_download,IPTABLES,iptables,1.8.7,.tar.bz2,https://www.netfilter.org/projects/iptables/files/,c109c96bb04998cd44156622d36f8e04b140701ec60531a10668cfdff5e8d8f0))
 $(eval $(call tar_download,NMAP,nmap,7.92,.tgz,https://nmap.org/dist/,064183ea642dc4c12b1ab3b5358ce1cef7d2e7e11ffa2849f16d339f5b717117))
 $(eval $(call tar_download,IPUTILS,iputils,s20190709,.tar.gz,https://github.com/iputils/iputils/archive/s20190709.tar.gz/#,a15720dd741d7538dd2645f9f516d193636ae4300ff7dbc8bfca757bf166490a))
-$(eval $(call tar_download,WIREGUARD_TOOLS,wireguard-tools,1.0.20210914,.tar.xz,https://git.zx2c4.com/wireguard-tools/snapshot/,97ff31489217bb265b7ae850d3d0f335ab07d2652ba1feec88b734bc96bd05ac))
+$(eval $(call tar_download,WIREGUARD_TOOLS,wireguard-tools,1.0.20250521,.tar.xz,https://git.zx2c4.com/wireguard-tools/snapshot/,b6f2628b85b1b23cc06517ec9c74f82d52c4cdbd020f3dd2f00c972a1782950e))
 
 export CFLAGS := -O3 -pipe
 ifeq ($(HOST_ARCH),$(ARCH))
-- 
2.48.1


