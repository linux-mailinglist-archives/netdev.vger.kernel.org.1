Return-Path: <netdev+bounces-158563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 942DCA127F8
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 16:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A942B167503
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 15:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CA1158853;
	Wed, 15 Jan 2025 15:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qUziXKPe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1249724A7C4
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 15:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736956644; cv=none; b=NELh2YoF2wdv+85Kmv99dcf33OIhhLoXQ3IvmT/9qlaXDMs19JAjWEfed/b8egFOAiiZxlJe2M4ZJBo7ojG/h9aAFLOJIy0XCA+TKYn0ATO/S+4+cLFRQz3uY8pqkZYHWHOCvXQSBVP2l0W2LLUACOqcfciMHLZ1kmx14qcqEIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736956644; c=relaxed/simple;
	bh=4K5iuLi9Oww5iBq9E9lVYD/mJIp+vcJ0S6I9wtS4zO4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eR+HqSLE8Pi5zFzy+cs0QVEzO4an2sj2qy5B8Lin5xuUtzzW76qqQa7ix5LMr6FH++EHddB3dNT3Hk3nyhZVlCxyTNWNTNBteHT6dNfDIE5WcgcGXo4gwszFbhPPoAbg4UBN+LsOP2fXGRWxEA988eGcwrCArbJAQdFt2HuaM2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qUziXKPe; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2f550d28f7dso12006102a91.3
        for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 07:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736956640; x=1737561440; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GY/eLTMwFygpCGLuUylolQxE6lHzOYjPesAebdqlUvo=;
        b=qUziXKPegf4SV8Bz9CQ/ZJQuYnUwZYpXx4a/01vEa0AQ74bidabuv/oMfvSNSOctFZ
         d++jCpd/ntwp2apo8WtwLGEptJOKM3WkeUfuaxDq7XUsrtvfD4paV+hLr42AFl+kEZJw
         7+67RA8n2doeO4rkniG90woW3SliMBtvb/gYelIJc1yJZAeIimkcm/QFBn0l0UmVW0oy
         sSIQ/JBIfqusHcwgSXmbIyl2Oo8z4hWAGEZQvB4rhLWOG0kGP0X2Bl4Y3+sI7FrhHY7h
         JJfAC0igr7BlLnshoRXOWrXYbuydL8IXgOVDO5TKll7RcjEamXMj85ZxvbZL3wJR/IRZ
         tPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736956640; x=1737561440;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GY/eLTMwFygpCGLuUylolQxE6lHzOYjPesAebdqlUvo=;
        b=TKWXGj6il2MeKmQuC2Ew1KUzLZIBcLoeGDgG+/WxziZ2k1d2oW7lbW0pS9A+yi4Ftc
         XogGAuYSj7/PP+fA1av1jKOq7ZpijLK5WfG/28qDnQC64vRLO0/sxesvBvfFhA9AbGy4
         3Vu6Mim0dIhIuueG/Xl8kRay1c4UDwKyFsvoUvQJiG6IrKrzAb4cD8rDIH6Qvu2fp/87
         2OC8CtyVVNoa/oZzy/uptTYFDnqkudqHxu3Ytz+/fmIphqKPhsNLqks5/NHANK1bRmzT
         9eJEEPIJUhD7nuVS7u7gCsSuM/rQWezV5mF5wjCUk1p/chOiaNAHxyZYKs6oaAm6q9KF
         nGoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXttYtsACtVbCytxfK2eHUjAGTHJzg1rq9ar7f0Aw0X9vzWT4mfRfJ3zUrhqNjXUJ3MLo2sx9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkK45uIR2tNKegJjivIlGXBCMC5XLjGvqa1AC8DXgeyXmKuqrO
	VEYtHZQ6FHK2bzc2yKzLP9dJiKPIXCzJ/DFKb8LDpNM9pGk+2tWV2d+ijpML04V9q/FRFfIafg=
	=
X-Google-Smtp-Source: AGHT+IHeAkLPqhlui/uuf/Bo/T1ubIRlwf/Z7KJe3nt98jP1LQ9VzE70GAHZs5ahVs+WyDQfyPVZpOO+Eg==
X-Received: from pjb13.prod.google.com ([2002:a17:90b:2f0d:b0:2ea:5084:5297])
 (user=jrife job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d00b:b0:2ea:4578:46d8
 with SMTP id 98e67ed59e1d1-2f548eb9e19mr43674170a91.9.1736956640448; Wed, 15
 Jan 2025 07:57:20 -0800 (PST)
Date: Wed, 15 Jan 2025 15:57:12 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250115155714.3786269-1-jrife@google.com>
Subject: [PATCH RESEND v3 net-next] wireguard: allowedips: Add
 WGALLOWEDIP_F_REMOVE_ME flag
From: Jordan Rife <jrife@google.com>
To: wireguard@lists.zx2c4.com, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Jordan Rife <jrife@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

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

v2->v3
------
* Revert WG_GENL_VERSION back to 1.
* Rename _remove() to remove_node().
* Remove unnecessary !peer guard from remove().
* Adjust line length for calls to wg_allowedips_(remove|insert)_v(4|6).
* Fix punctuation inside uapi docs for WGALLOWEDIP_A_FLAGS.
* Get rid of remove-ip program and use wg instead in selftests.
* Use NLA_POLICY_MASK for WGALLOWEDIP_A_FLAGS validation.

v1->v2
------
* Fixed some Sparse warnings.

Link: https://lore.kernel.org/netdev/20240905200551.4099064-1-jrife@google.com/
Signed-off-by: Jordan Rife <jrife@google.com>
---
 drivers/net/wireguard/allowedips.c          | 106 ++++++++++++++------
 drivers/net/wireguard/allowedips.h          |   4 +
 drivers/net/wireguard/netlink.c             |  37 ++++---
 drivers/net/wireguard/selftest/allowedips.c |  48 +++++++++
 include/uapi/linux/wireguard.h              |   9 ++
 tools/testing/selftests/wireguard/netns.sh  |  32 ++++++
 6 files changed, 193 insertions(+), 43 deletions(-)

diff --git a/drivers/net/wireguard/allowedips.c b/drivers/net/wireguard/allowedips.c
index 4b8528206cc8..dcf068ba2881 100644
--- a/drivers/net/wireguard/allowedips.c
+++ b/drivers/net/wireguard/allowedips.c
@@ -249,6 +249,56 @@ static int add(struct allowedips_node __rcu **trie, u8 bits, const u8 *key,
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
+	free_parent = !rcu_access_pointer(node->bit[0]) &&
+			!rcu_access_pointer(node->bit[1]) &&
+			(node->parent_bit_packed & 3) <= 1 &&
+			!rcu_access_pointer(parent->peer);
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
+	if (!rcu_access_pointer(*trie) ||
+	    !node_placement(*trie, key, cidr, bits, &node, lock) ||
+	    peer != rcu_access_pointer(node->peer))
+		return 0;
+
+	remove_node(node, lock);
+
+	return 0;
+}
+
 void wg_allowedips_init(struct allowedips *table)
 {
 	table->root4 = table->root6 = NULL;
@@ -300,44 +350,38 @@ int wg_allowedips_insert_v6(struct allowedips *table, const struct in6_addr *ip,
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
index f7055180ba4a..386f65042072 100644
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
index 3d1f64ff2e12..dc51223a1d3a 100644
--- a/drivers/net/wireguard/selftest/allowedips.c
+++ b/drivers/net/wireguard/selftest/allowedips.c
@@ -461,6 +461,10 @@ static __init struct wg_peer *init_peer(void)
 	wg_allowedips_insert_v##version(&t, ip##version(ipa, ipb, ipc, ipd), \
 					cidr, mem, &mutex)
 
+#define remove(version, mem, ipa, ipb, ipc, ipd, cidr)                      \
+	wg_allowedips_remove_v##version(&t, ip##version(ipa, ipb, ipc, ipd), \
+					cidr, mem, &mutex)
+
 #define maybe_fail() do {                                               \
 		++i;                                                    \
 		if (!_s) {                                              \
@@ -586,6 +590,50 @@ bool __init wg_allowedips_selftest(void)
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
index 405ff262ca93..853922c895cd 100755
--- a/tools/testing/selftests/wireguard/netns.sh
+++ b/tools/testing/selftests/wireguard/netns.sh
@@ -610,6 +610,38 @@ n0 wg set wg0 peer "$pub2" allowed-ips "$allowedips"
 } < <(n0 wg show wg0 allowed-ips)
 ip0 link del wg0
 
+# Test IP removal
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
+pub1_hex=$(echo "$pub1" | base64 -d | xxd -p -c 50)
+n0 wg set wg0 peer "$pub1" allowed-ips -192.168.0.1/32,-192.168.0.20/32,-192.168.0.100/32,-abcd::1/128,-abcd::20/128,-abcd::100/128
+n0 wg show wg0 allowed-ips
+{
+	read -r pub allowedips
+	[[ $pub == "$pub1" ]]
+	i=0
+	for ip in $allowedips; do
+		[[ "$ip" != "192.168.0.1" ]]
+		[[ "$ip" != "192.168.0.20" ]]
+		[[ "$ip" != "192.168.0.100" ]]
+		[[ "$ip" != "abcd::1" ]]
+		[[ "$ip" != "abcd::20" ]]
+		[[ "$ip" != "abcd::100" ]]
+		((++i))
+	done
+	((i == 388))
+} < <(n0 wg show wg0 allowed-ips)
+ip0 link del wg0
+
 ! n0 wg show doesnotexist || false
 
 ip0 link add wg0 type wireguard
-- 
2.47.0.338.g60cca15819-goog


