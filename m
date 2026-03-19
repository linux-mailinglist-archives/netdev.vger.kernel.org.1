Return-Path: <netdev+bounces-269613-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IWfLAg+vGn6vgIAu9opvQ
	(envelope-from <netdev+bounces-269613-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 19:18:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6301B2D0B89
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 19:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A19D9300D75B
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F113F23CF;
	Thu, 19 Mar 2026 18:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lr035Gvk"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025803F65FD
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 18:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773944309; cv=none; b=gEv1k/f8dnx5O8zWZ0VV9Pjn6xf5RdPPbDEK7lomkjKwuEHylprvBtKe9eArmFApiCDKJzRzTA/nM7D5yHXSDr2+iT/iGChWIf35UwxcNWfCwuuGvEYN1O57IWYmgUJDM4+luB0Y9SFoVay7ybOYkD1WrfYvNu+S4qScidPwfuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773944309; c=relaxed/simple;
	bh=D04F0zImx7hACstAggIXl/06ZXOel3GSj+gbpGmZfDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K/7jGxTQgAH1Xa+KxbEU6qz7PoYuAwztclTK16TPhrSOUPTNG01fL8UPJ5HnGDnsW0fK6ucsjBWoWHoNMPDpFjQx76aElClZhzv4mHcy9MWyanI07FBJg3T4JbDZcbiljQ2k17UVHr5NzBJWhoDRr2qAqO8zOXN4fz91OMnk89I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lr035Gvk; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773944306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0D5Llu4ZQ3owDkePI5Vqs7Ijz0RVARo9vrMsWRlAzew=;
	b=lr035Gvk0QmuAGxfcH2zY20hqbmuaAnk1JBU4UgLgvEmhiwJtnqiP6t+2OwQwdq8TR5WKG
	b76HnT+6b6KeU0TpBWbwT5QmHnv2mTuD6D7lQ9/1vzj4xjQr8YfKqbDvqlDlfllQM0eHzx
	mkJrXwoO7j9xZFd20pXsL3ewoDKHCCQ=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: netdev@vger.kernel.org
Cc: 'David Miller ' <davem@davemloft.net>,
	'Jakub Kicinski ' <kuba@kernel.org>,
	'Eric Dumazet ' <edumazet@google.com>,
	'Paolo Abeni ' <pabeni@redhat.com>,
	'Kuniyuki Iwashima ' <kuniyu@google.com>,
	Andrew Onyshchuk <oandrew@meta.com>
Subject: [PATCH net] udp: Fix wildcard bind conflict check when using hash2
Date: Thu, 19 Mar 2026 11:18:17 -0700
Message-ID: <20260319181817.1901357-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269613-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.968];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,meta.com:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 6301B2D0B89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Martin KaFai Lau <martin.lau@kernel.org>

When binding a udp_sock to a local address and port, UDP uses
two hashes (udptable->hash and udptable->hash2) for collision
detection. The current code switches to "hash2" when
hslot->count > 10.

"hash2" is keyed by local address and local port.
"hash" is keyed by local port only.

The issue can be shown in the following bind sequence (pseudo code):

bind(fd1,  "[fd00::1]:8888")
bind(fd2,  "[fd00::2]:8888")
bind(fd3,  "[fd00::3]:8888")
bind(fd4,  "[fd00::4]:8888")
bind(fd5,  "[fd00::5]:8888")
bind(fd6,  "[fd00::6]:8888")
bind(fd7,  "[fd00::7]:8888")
bind(fd8,  "[fd00::8]:8888")
bind(fd9,  "[fd00::9]:8888")
bind(fd10, "[fd00::10]:8888")

/* Correctly return -EADDRINUSE because "hash" is used
 * instead of "hash2". udp_lib_lport_inuse() detects the
 * conflict.
 */
bind(fail_fd, "[::]:8888")

/* After one more socket is bound to "[fd00::11]:8888",
 * hslot->count exceeds 10 and "hash2" is used instead.
 */
bind(fd11, "[fd00::11]:8888")
bind(fail_fd, "[::]:8888")      /* succeeds unexpectedly */

The same issue applies to the IPv4 wildcard address "0.0.0.0"
and the IPv4-mapped wildcard address "::ffff:0.0.0.0". For
example, if there are existing sockets bound to
"192.168.1.[1-11]:8888", then binding "0.0.0.0:8888" or
"[::ffff:0.0.0.0]:8888" can also miss the conflict when
hslot->count > 10.

TCP inet_csk_get_port() already has the correct check in
inet_use_bhash2_on_bind(). Rename it to
inet_use_hash2_on_bind() and move it to inet_hashtables.h
so udp.c can reuse it in this fix.

Fixes: 30fff9231fad ("udp: bind() optimisation")
Reported-by: Andrew Onyshchuk <oandrew@meta.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 include/net/inet_hashtables.h   | 14 ++++++++++++++
 net/ipv4/inet_connection_sock.c | 20 +++-----------------
 net/ipv4/udp.c                  |  2 +-
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 5a979dcab538..6d936e9f2fd3 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -264,6 +264,20 @@ inet_bhashfn_portaddr(const struct inet_hashinfo *hinfo, const struct sock *sk,
 	return &hinfo->bhash2[hash & (hinfo->bhash_size - 1)];
 }
 
+static inline bool inet_use_hash2_on_bind(const struct sock *sk)
+{
+#if IS_ENABLED(CONFIG_IPV6)
+	if (sk->sk_family == AF_INET6) {
+		if (ipv6_addr_any(&sk->sk_v6_rcv_saddr))
+			return false;
+
+		if (!ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr))
+			return true;
+	}
+#endif
+	return sk->sk_rcv_saddr != htonl(INADDR_ANY);
+}
+
 struct inet_bind_hashbucket *
 inet_bhash2_addr_any_hashbucket(const struct sock *sk, const struct net *net, int port);
 
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 5dfac6ce1110..e961936b6be7 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -154,20 +154,6 @@ bool inet_sk_get_local_port_range(const struct sock *sk, int *low, int *high)
 }
 EXPORT_SYMBOL(inet_sk_get_local_port_range);
 
-static bool inet_use_bhash2_on_bind(const struct sock *sk)
-{
-#if IS_ENABLED(CONFIG_IPV6)
-	if (sk->sk_family == AF_INET6) {
-		if (ipv6_addr_any(&sk->sk_v6_rcv_saddr))
-			return false;
-
-		if (!ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr))
-			return true;
-	}
-#endif
-	return sk->sk_rcv_saddr != htonl(INADDR_ANY);
-}
-
 static bool inet_bind_conflict(const struct sock *sk, struct sock *sk2,
 			       kuid_t uid, bool relax,
 			       bool reuseport_cb_ok, bool reuseport_ok)
@@ -259,7 +245,7 @@ static int inet_csk_bind_conflict(const struct sock *sk,
 	 * checks separately because their spinlocks have to be acquired/released
 	 * independently of each other, to prevent possible deadlocks
 	 */
-	if (inet_use_bhash2_on_bind(sk))
+	if (inet_use_hash2_on_bind(sk))
 		return tb2 && inet_bhash2_conflict(sk, tb2, uid, relax,
 						   reuseport_cb_ok, reuseport_ok);
 
@@ -376,7 +362,7 @@ inet_csk_find_open_port(const struct sock *sk, struct inet_bind_bucket **tb_ret,
 		head = &hinfo->bhash[inet_bhashfn(net, port,
 						  hinfo->bhash_size)];
 		spin_lock_bh(&head->lock);
-		if (inet_use_bhash2_on_bind(sk)) {
+		if (inet_use_hash2_on_bind(sk)) {
 			if (inet_bhash2_addr_any_conflict(sk, port, l3mdev, relax, false))
 				goto next_port;
 		}
@@ -562,7 +548,7 @@ int inet_csk_get_port(struct sock *sk, unsigned short snum)
 				check_bind_conflict = false;
 		}
 
-		if (check_bind_conflict && inet_use_bhash2_on_bind(sk)) {
+		if (check_bind_conflict && inet_use_hash2_on_bind(sk)) {
 			if (inet_bhash2_addr_any_conflict(sk, port, l3mdev, true, true))
 				goto fail_unlock;
 		}
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index b60fad393e18..cb99a3c27053 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -287,7 +287,7 @@ int udp_lib_get_port(struct sock *sk, unsigned short snum,
 	} else {
 		hslot = udp_hashslot(udptable, net, snum);
 		spin_lock_bh(&hslot->lock);
-		if (hslot->count > 10) {
+		if (inet_use_hash2_on_bind(sk) && hslot->count > 10) {
 			int exist;
 			unsigned int slot2 = udp_sk(sk)->udp_portaddr_hash ^ snum;
 
-- 
2.52.0


