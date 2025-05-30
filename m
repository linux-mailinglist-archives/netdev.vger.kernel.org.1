Return-Path: <netdev+bounces-194336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC02AC8BF2
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 12:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA8A1A2526C
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 10:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BEC221F30;
	Fri, 30 May 2025 10:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="d1EyAVOJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EE721D5AA
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 10:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748599989; cv=none; b=uJJrZ9UTyDYc/KNCSTG0J6/zMZnHBziY0YLRKj0gMGgMXP+2E119fnVm6W0C6oaskt1ZCm/jR/9I6gxEXEi9J5XPUTLvNoOKcx4Vwgn8EbaP3V3d1DSZ+/dY8BmzSIB934u8Nsci1hmW0VHbMEhoHydDZsRh/DnM6hfH3qnwTNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748599989; c=relaxed/simple;
	bh=GSaQC14549LsFJVGC9UYUSwNmWTw3CQqwjCT9vSU7t0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7ZFP+sOMnnALdCz4zZKbHx/c7KIqpTFcCYfv2dfYCbYGcD4GY1kSxe7yLwntS6GROdl023HKI+UYbggevQpe3GNC6qFemjR6wyuCXxVeVL2iLUSfJ9CT88HPbvf5pphxo+3DC54jT1PWowgZ9cGp9k2OO8Zm9XOi6StimAncCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=d1EyAVOJ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a36e950e41so1188406f8f.0
        for <netdev@vger.kernel.org>; Fri, 30 May 2025 03:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1748599984; x=1749204784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/koqmcU3RfrkXWeNtoH5ugoG5i3kY5EkmoL9eDNvS0=;
        b=d1EyAVOJWzWV9ZW67dT09wm0dA+0X7BFnZVGl81yOrZ8D4dARm1Vg9PVbFaoXh1q+s
         SvsNpHhLpuGg9FigLka2FcaIkoDBKEc2LhcaasNMgaDw46Vu2Npmb0QUoQZBgVVIQ8Dj
         v2z0Ob/RmgddDfkNkJHVZ7LFjMWdLr5wVQVoUlyCC9+YyKmj4YYMKs5MNCjSRrIfhQN4
         leL6YILRQ/fgEPMYI+t2Q3CgYFZDr8TUmBYTtJEzvVJef/iuJxD16IaNBBTvOsEh6Y1P
         oA8w4vHkVhj0YKWD3vVgw8oD5VGy5toHtQ3rgJGBRleQu47+BCvChqmOPMz6H5GB/q2G
         trHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748599984; x=1749204784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/koqmcU3RfrkXWeNtoH5ugoG5i3kY5EkmoL9eDNvS0=;
        b=gT4kT6MrM4IOFXXN/vyFI0h7rnpDrlgEfEVr8D4DUFH6drcixzv1Th3xmynQweeJdj
         Je7QQJ7WVQOnasVDUns0DSFpzFtEmldHbDD5kKkI/HJutCr1BSvSP6AtIDMd3lIPQZnt
         cFqM8MkWpyABx7eTyHHhClbIrVOIvmYX71cuzrpPI63r0Pj0vQGhoeR+gtoo19aKofJY
         wjiFwkSTrkidi6/UV9fDJlb7odJiGnGTf69Jfve6Bb8ZswAp/QD2tKdzYw0z1LkrkKHs
         SFGYIQfIcZDjllsn158qURzPcMiKnVdTFBqEOpjEZphNqLjaFDBoQGt3HEGl7zvQx14K
         TaHA==
X-Gm-Message-State: AOJu0YxnMqaJlZ50YEp3hOrnukrbOOouGFcfbatL292XwJU5wFgToI+7
	W7I1kdJH9O/iQi2ZyDsOZnK769VenS1DUNz6jmiBeNsxP3MaN3YBHG6joXJ9bkpe2Czw79BfnDz
	d3WhWstlPurThc0BvKVF7SYDRnB+5Iye9vyMZ/dcbJyuL89Fbf128ZAxmYdKml59U
X-Gm-Gg: ASbGncveetdt8edpCCDtcGBVNVWCLGl1hPfrCw6tFARa2hD05TOyjKQMm7PwyMDKW44
	y3k210j8XB2+K3IWdQ7+XYMATabui4eagKQWe6RY2A63eo1pdvnmiJPxYCm0Zlt8YfIPKbM0o1W
	nlObHUKGtgJ2bDNMAPvMpSTqdIQwyOdSACBgavtYiw5yFA0oy53MtXSOzko5TA8kenbkBlclUvr
	vy4TUX9rpuJOQSS5SIIn70NupcWkac/fbldAMzqC5xFf417iZqrBv85OHyf3Ly3PxJgu4VVwry0
	QHQ4XspkLH5PGCQSYDCOjc4HkhL6gm4GIUGqt7PyPC97FbnMilAd+cI5aNVHNr7M6leQkrMAyg=
	=
X-Google-Smtp-Source: AGHT+IEIRNlEdoTixWgYG6+f8cBvOZx9Nu0whBuQIrVIjmmw2acov0oulJnJYYcllAMXRyszPl9X4Q==
X-Received: by 2002:a05:6000:2284:b0:3a4:ee40:715c with SMTP id ffacd0b85a97d-3a4f7a4c57bmr2168674f8f.14.1748599984135;
        Fri, 30 May 2025 03:13:04 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:cdbd:204e:842c:3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe5b892sm4480956f8f.17.2025.05.30.03.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 03:13:03 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Oleksandr Natalenko <oleksandr@natalenko.name>,
	Qingfang Deng <dqfext@gmail.com>,
	Gert Doering <gert@greenie.muc.de>
Subject: [PATCH net 2/5] ovpn: ensure sk is still valid during cleanup
Date: Fri, 30 May 2025 12:12:51 +0200
Message-ID: <20250530101254.24044-3-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530101254.24044-1-antonio@openvpn.net>
References: <20250530101254.24044-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removing a peer while userspace attempts to close its transport
socket triggers a race condition resulting in the following
crash:

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000077: 0000 [#1] SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000003b8-0x00000000000003bf]
CPU: 12 UID: 0 PID: 162 Comm: kworker/12:1 Tainted: G           O        6.15.0-rc2-00635-g521139ac3840 #272 PREEMPT(full)
Tainted: [O]=OOT_MODULE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-20240910_120124-localhost 04/01/2014
Workqueue: events ovpn_peer_keepalive_work [ovpn]
RIP: 0010:ovpn_socket_release+0x23c/0x500 [ovpn]
Code: ea 03 80 3c 02 00 0f 85 71 02 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 64 24 18 49 8d bc 24 be 03 00 00 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 30
RSP: 0018:ffffc90000c9fb18 EFLAGS: 00010217
RAX: dffffc0000000000 RBX: ffff8881148d7940 RCX: ffffffff817787bb
RDX: 0000000000000077 RSI: 0000000000000008 RDI: 00000000000003be
RBP: ffffc90000c9fb30 R08: 0000000000000000 R09: fffffbfff0d3e840
R10: ffffffff869f4207 R11: 0000000000000000 R12: 0000000000000000
R13: ffff888115eb9300 R14: ffffc90000c9fbc8 R15: 000000000000000c
FS:  0000000000000000(0000) GS:ffff8882b0151000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f37266b6114 CR3: 00000000054a8000 CR4: 0000000000750ef0
PKRU: 55555554
Call Trace:
 <TASK>
 unlock_ovpn+0x8b/0xe0 [ovpn]
 ovpn_peer_keepalive_work+0xe3/0x540 [ovpn]
 ? ovpn_peers_free+0x780/0x780 [ovpn]
 ? lock_acquire+0x56/0x70
 ? process_one_work+0x888/0x1740
 process_one_work+0x933/0x1740
 ? pwq_dec_nr_in_flight+0x10b0/0x10b0
 ? move_linked_works+0x12d/0x2c0
 ? assign_work+0x163/0x270
 worker_thread+0x4d6/0xd90
 ? preempt_count_sub+0x4c/0x70
 ? process_one_work+0x1740/0x1740
 kthread+0x36c/0x710
 ? trace_preempt_on+0x8c/0x1e0
 ? kthread_is_per_cpu+0xc0/0xc0
 ? preempt_count_sub+0x4c/0x70
 ? _raw_spin_unlock_irq+0x36/0x60
 ? calculate_sigpending+0x7b/0xa0
 ? kthread_is_per_cpu+0xc0/0xc0
 ret_from_fork+0x3a/0x80
 ? kthread_is_per_cpu+0xc0/0xc0
 ret_from_fork_asm+0x11/0x20
 </TASK>
Modules linked in: ovpn(O)

This happens because the peer deletion operation reaches
ovpn_socket_release() while ovpn_sock->sock (struct socket *)
and its sk member (struct sock *) are still both valid.
Here synchronize_rcu() is invoked, after which ovpn_sock->sock->sk
becomes NULL, due to the concurrent socket closing triggered
from userspace.

After having invoked synchronize_rcu(), ovpn_socket_release() will
attempt dereferencing ovpn_sock->sock->sk, triggering the crash
reported above.

The reason for accessing sk is that we need to retrieve its
protocol and continue the cleanup routine accordingly.

This crash can be easily produced by running openvpn userspace in
client mode with `--keepalive 10 20`, while entirely omitting this
option on the server side.
After 20 seconds ovpn will assume the peer (server) to be dead,
will start removing it and will notify userspace. The latter will
receive the notification and close the transport socket, thus
triggering the crash.

To fix the race condition for good, we need to refactor struct ovpn_socket.
Since ovpn is always only interested in the sock->sk member (struct sock *)
we can directly hold a reference to it, raher than accessing it via
its struct socket container.

This means changing "struct socket *ovpn_socket->sock" to
"struct sock *ovpn_socket->sk".

While acquiring a reference to sk, we can increase its refcounter
without affecting the socket close()/destroy() notification
(which we rely on when userspace closes a socket we are using).

By increasing sk's refcounter we know we can dereference it
in ovpn_socket_release() without incurring in any race condition
anymore.

ovpn_socket_release() will ultimately decrease the reference
counter.

Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
Reported-by: Qingfang Deng <dqfext@gmail.com>
Closes: https://github.com/OpenVPN/ovpn-net-next/issues/1
Tested-by: Gert Doering <gert@greenie.muc.de>
Link: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31575.html
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c      |  8 ++---
 drivers/net/ovpn/netlink.c | 16 ++++-----
 drivers/net/ovpn/peer.c    |  4 +--
 drivers/net/ovpn/socket.c  | 68 +++++++++++++++++++++-----------------
 drivers/net/ovpn/socket.h  |  4 +--
 drivers/net/ovpn/tcp.c     | 65 ++++++++++++++++++------------------
 drivers/net/ovpn/tcp.h     |  3 +-
 drivers/net/ovpn/udp.c     | 34 +++++++------------
 drivers/net/ovpn/udp.h     |  4 +--
 9 files changed, 102 insertions(+), 104 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 10d8afecec55..ebf1e849506b 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -134,7 +134,7 @@ void ovpn_decrypt_post(void *data, int ret)
 
 	rcu_read_lock();
 	sock = rcu_dereference(peer->sock);
-	if (sock && sock->sock->sk->sk_protocol == IPPROTO_UDP)
+	if (sock && sock->sk->sk_protocol == IPPROTO_UDP)
 		/* check if this peer changed local or remote endpoint */
 		ovpn_peer_endpoints_update(peer, skb);
 	rcu_read_unlock();
@@ -270,12 +270,12 @@ void ovpn_encrypt_post(void *data, int ret)
 	if (unlikely(!sock))
 		goto err_unlock;
 
-	switch (sock->sock->sk->sk_protocol) {
+	switch (sock->sk->sk_protocol) {
 	case IPPROTO_UDP:
-		ovpn_udp_send_skb(peer, sock->sock, skb);
+		ovpn_udp_send_skb(peer, sock->sk, skb);
 		break;
 	case IPPROTO_TCP:
-		ovpn_tcp_send_skb(peer, sock->sock, skb);
+		ovpn_tcp_send_skb(peer, sock->sk, skb);
 		break;
 	default:
 		/* no transport configured yet */
diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index bea03913bfb1..a4ec53def46e 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -501,7 +501,7 @@ int ovpn_nl_peer_set_doit(struct sk_buff *skb, struct genl_info *info)
 	/* when using a TCP socket the remote IP is not expected */
 	rcu_read_lock();
 	sock = rcu_dereference(peer->sock);
-	if (sock && sock->sock->sk->sk_protocol == IPPROTO_TCP &&
+	if (sock && sock->sk->sk_protocol == IPPROTO_TCP &&
 	    (attrs[OVPN_A_PEER_REMOTE_IPV4] ||
 	     attrs[OVPN_A_PEER_REMOTE_IPV6])) {
 		rcu_read_unlock();
@@ -559,14 +559,14 @@ static int ovpn_nl_send_peer(struct sk_buff *skb, const struct genl_info *info,
 		goto err_unlock;
 	}
 
-	if (!net_eq(genl_info_net(info), sock_net(sock->sock->sk))) {
+	if (!net_eq(genl_info_net(info), sock_net(sock->sk))) {
 		id = peernet2id_alloc(genl_info_net(info),
-				      sock_net(sock->sock->sk),
+				      sock_net(sock->sk),
 				      GFP_ATOMIC);
 		if (nla_put_s32(skb, OVPN_A_PEER_SOCKET_NETNSID, id))
 			goto err_unlock;
 	}
-	local_port = inet_sk(sock->sock->sk)->inet_sport;
+	local_port = inet_sk(sock->sk)->inet_sport;
 	rcu_read_unlock();
 
 	if (nla_put_u32(skb, OVPN_A_PEER_ID, peer->id))
@@ -1153,8 +1153,8 @@ int ovpn_nl_peer_del_notify(struct ovpn_peer *peer)
 		ret = -EINVAL;
 		goto err_unlock;
 	}
-	genlmsg_multicast_netns(&ovpn_nl_family, sock_net(sock->sock->sk),
-				msg, 0, OVPN_NLGRP_PEERS, GFP_ATOMIC);
+	genlmsg_multicast_netns(&ovpn_nl_family, sock_net(sock->sk), msg, 0,
+				OVPN_NLGRP_PEERS, GFP_ATOMIC);
 	rcu_read_unlock();
 
 	return 0;
@@ -1218,8 +1218,8 @@ int ovpn_nl_key_swap_notify(struct ovpn_peer *peer, u8 key_id)
 		ret = -EINVAL;
 		goto err_unlock;
 	}
-	genlmsg_multicast_netns(&ovpn_nl_family, sock_net(sock->sock->sk),
-				msg, 0, OVPN_NLGRP_PEERS, GFP_ATOMIC);
+	genlmsg_multicast_netns(&ovpn_nl_family, sock_net(sock->sk), msg, 0,
+				OVPN_NLGRP_PEERS, GFP_ATOMIC);
 	rcu_read_unlock();
 
 	return 0;
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index a1fd27b9c038..4bfcab0c8652 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -1145,7 +1145,7 @@ static void ovpn_peer_release_p2p(struct ovpn_priv *ovpn, struct sock *sk,
 
 	if (sk) {
 		ovpn_sock = rcu_access_pointer(peer->sock);
-		if (!ovpn_sock || ovpn_sock->sock->sk != sk) {
+		if (!ovpn_sock || ovpn_sock->sk != sk) {
 			spin_unlock_bh(&ovpn->lock);
 			ovpn_peer_put(peer);
 			return;
@@ -1175,7 +1175,7 @@ static void ovpn_peers_release_mp(struct ovpn_priv *ovpn, struct sock *sk,
 		if (sk) {
 			rcu_read_lock();
 			ovpn_sock = rcu_dereference(peer->sock);
-			remove = ovpn_sock && ovpn_sock->sock->sk == sk;
+			remove = ovpn_sock && ovpn_sock->sk == sk;
 			rcu_read_unlock();
 		}
 
diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
index a83cbab72591..9750871ab65c 100644
--- a/drivers/net/ovpn/socket.c
+++ b/drivers/net/ovpn/socket.c
@@ -24,9 +24,9 @@ static void ovpn_socket_release_kref(struct kref *kref)
 	struct ovpn_socket *sock = container_of(kref, struct ovpn_socket,
 						refcount);
 
-	if (sock->sock->sk->sk_protocol == IPPROTO_UDP)
+	if (sock->sk->sk_protocol == IPPROTO_UDP)
 		ovpn_udp_socket_detach(sock);
-	else if (sock->sock->sk->sk_protocol == IPPROTO_TCP)
+	else if (sock->sk->sk_protocol == IPPROTO_TCP)
 		ovpn_tcp_socket_detach(sock);
 }
 
@@ -75,14 +75,6 @@ void ovpn_socket_release(struct ovpn_peer *peer)
 	if (!sock)
 		return;
 
-	/* sanity check: we should not end up here if the socket
-	 * was already closed
-	 */
-	if (!sock->sock->sk) {
-		DEBUG_NET_WARN_ON_ONCE(1);
-		return;
-	}
-
 	/* Drop the reference while holding the sock lock to avoid
 	 * concurrent ovpn_socket_new call to mess up with a partially
 	 * detached socket.
@@ -90,22 +82,24 @@ void ovpn_socket_release(struct ovpn_peer *peer)
 	 * Holding the lock ensures that a socket with refcnt 0 is fully
 	 * detached before it can be picked by a concurrent reader.
 	 */
-	lock_sock(sock->sock->sk);
+	lock_sock(sock->sk);
 	released = ovpn_socket_put(peer, sock);
-	release_sock(sock->sock->sk);
+	release_sock(sock->sk);
 
 	/* align all readers with sk_user_data being NULL */
 	synchronize_rcu();
 
 	/* following cleanup should happen with lock released */
 	if (released) {
-		if (sock->sock->sk->sk_protocol == IPPROTO_UDP) {
+		if (sock->sk->sk_protocol == IPPROTO_UDP) {
 			netdev_put(sock->ovpn->dev, &sock->dev_tracker);
-		} else if (sock->sock->sk->sk_protocol == IPPROTO_TCP) {
+		} else if (sock->sk->sk_protocol == IPPROTO_TCP) {
 			/* wait for TCP jobs to terminate */
 			ovpn_tcp_socket_wait_finish(sock);
 			ovpn_peer_put(sock->peer);
 		}
+		/* drop reference acquired in ovpn_socket_new() */
+		sock_put(sock->sk);
 		/* we can call plain kfree() because we already waited one RCU
 		 * period due to synchronize_rcu()
 		 */
@@ -118,12 +112,14 @@ static bool ovpn_socket_hold(struct ovpn_socket *sock)
 	return kref_get_unless_zero(&sock->refcount);
 }
 
-static int ovpn_socket_attach(struct ovpn_socket *sock, struct ovpn_peer *peer)
+static int ovpn_socket_attach(struct ovpn_socket *ovpn_sock,
+			      struct socket *sock,
+			      struct ovpn_peer *peer)
 {
-	if (sock->sock->sk->sk_protocol == IPPROTO_UDP)
-		return ovpn_udp_socket_attach(sock, peer->ovpn);
-	else if (sock->sock->sk->sk_protocol == IPPROTO_TCP)
-		return ovpn_tcp_socket_attach(sock, peer);
+	if (sock->sk->sk_protocol == IPPROTO_UDP)
+		return ovpn_udp_socket_attach(ovpn_sock, sock, peer->ovpn);
+	else if (sock->sk->sk_protocol == IPPROTO_TCP)
+		return ovpn_tcp_socket_attach(ovpn_sock, peer);
 
 	return -EOPNOTSUPP;
 }
@@ -138,14 +134,15 @@ static int ovpn_socket_attach(struct ovpn_socket *sock, struct ovpn_peer *peer)
 struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
 {
 	struct ovpn_socket *ovpn_sock;
+	struct sock *sk = sock->sk;
 	int ret;
 
-	lock_sock(sock->sk);
+	lock_sock(sk);
 
 	/* a TCP socket can only be owned by a single peer, therefore there
 	 * can't be any other user
 	 */
-	if (sock->sk->sk_protocol == IPPROTO_TCP && sock->sk->sk_user_data) {
+	if (sk->sk_protocol == IPPROTO_TCP && sk->sk_user_data) {
 		ovpn_sock = ERR_PTR(-EBUSY);
 		goto sock_release;
 	}
@@ -153,8 +150,8 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
 	/* a UDP socket can be shared across multiple peers, but we must make
 	 * sure it is not owned by something else
 	 */
-	if (sock->sk->sk_protocol == IPPROTO_UDP) {
-		u8 type = READ_ONCE(udp_sk(sock->sk)->encap_type);
+	if (sk->sk_protocol == IPPROTO_UDP) {
+		u8 type = READ_ONCE(udp_sk(sk)->encap_type);
 
 		/* socket owned by other encapsulation module */
 		if (type && type != UDP_ENCAP_OVPNINUDP) {
@@ -163,7 +160,7 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
 		}
 
 		rcu_read_lock();
-		ovpn_sock = rcu_dereference_sk_user_data(sock->sk);
+		ovpn_sock = rcu_dereference_sk_user_data(sk);
 		if (ovpn_sock) {
 			/* socket owned by another ovpn instance, we can't use it */
 			if (ovpn_sock->ovpn != peer->ovpn) {
@@ -200,11 +197,22 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
 		goto sock_release;
 	}
 
-	ovpn_sock->sock = sock;
+	ovpn_sock->sk = sk;
 	kref_init(&ovpn_sock->refcount);
 
-	ret = ovpn_socket_attach(ovpn_sock, peer);
+	/* the newly created ovpn_socket is holding reference to sk,
+	 * therefore we increase its refcounter.
+	 *
+	 * This ovpn_socket instance is referenced by all peers
+	 * using the same socket.
+	 *
+	 * ovpn_socket_release() will take care of dropping the reference.
+	 */
+	sock_hold(sk);
+
+	ret = ovpn_socket_attach(ovpn_sock, sock, peer);
 	if (ret < 0) {
+		sock_put(sk);
 		kfree(ovpn_sock);
 		ovpn_sock = ERR_PTR(ret);
 		goto sock_release;
@@ -213,11 +221,11 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
 	/* TCP sockets are per-peer, therefore they are linked to their unique
 	 * peer
 	 */
-	if (sock->sk->sk_protocol == IPPROTO_TCP) {
+	if (sk->sk_protocol == IPPROTO_TCP) {
 		INIT_WORK(&ovpn_sock->tcp_tx_work, ovpn_tcp_tx_work);
 		ovpn_sock->peer = peer;
 		ovpn_peer_hold(peer);
-	} else if (sock->sk->sk_protocol == IPPROTO_UDP) {
+	} else if (sk->sk_protocol == IPPROTO_UDP) {
 		/* in UDP we only link the ovpn instance since the socket is
 		 * shared among multiple peers
 		 */
@@ -226,8 +234,8 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
 			    GFP_KERNEL);
 	}
 
-	rcu_assign_sk_user_data(sock->sk, ovpn_sock);
+	rcu_assign_sk_user_data(sk, ovpn_sock);
 sock_release:
-	release_sock(sock->sk);
+	release_sock(sk);
 	return ovpn_sock;
 }
diff --git a/drivers/net/ovpn/socket.h b/drivers/net/ovpn/socket.h
index 00d856b1a5d8..4afcec71040d 100644
--- a/drivers/net/ovpn/socket.h
+++ b/drivers/net/ovpn/socket.h
@@ -22,7 +22,7 @@ struct ovpn_peer;
  * @ovpn: ovpn instance owning this socket (UDP only)
  * @dev_tracker: reference tracker for associated dev (UDP only)
  * @peer: unique peer transmitting over this socket (TCP only)
- * @sock: the low level sock object
+ * @sk: the low level sock object
  * @refcount: amount of contexts currently referencing this object
  * @work: member used to schedule release routine (it may block)
  * @tcp_tx_work: work for deferring outgoing packet processing (TCP only)
@@ -36,7 +36,7 @@ struct ovpn_socket {
 		struct ovpn_peer *peer;
 	};
 
-	struct socket *sock;
+	struct sock *sk;
 	struct kref refcount;
 	struct work_struct work;
 	struct work_struct tcp_tx_work;
diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index 7c42d84987ad..7e79aad0b043 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -186,18 +186,18 @@ static int ovpn_tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 void ovpn_tcp_socket_detach(struct ovpn_socket *ovpn_sock)
 {
 	struct ovpn_peer *peer = ovpn_sock->peer;
-	struct socket *sock = ovpn_sock->sock;
+	struct sock *sk = ovpn_sock->sk;
 
 	strp_stop(&peer->tcp.strp);
 	skb_queue_purge(&peer->tcp.user_queue);
 
 	/* restore CBs that were saved in ovpn_sock_set_tcp_cb() */
-	sock->sk->sk_data_ready = peer->tcp.sk_cb.sk_data_ready;
-	sock->sk->sk_write_space = peer->tcp.sk_cb.sk_write_space;
-	sock->sk->sk_prot = peer->tcp.sk_cb.prot;
-	sock->sk->sk_socket->ops = peer->tcp.sk_cb.ops;
+	sk->sk_data_ready = peer->tcp.sk_cb.sk_data_ready;
+	sk->sk_write_space = peer->tcp.sk_cb.sk_write_space;
+	sk->sk_prot = peer->tcp.sk_cb.prot;
+	sk->sk_socket->ops = peer->tcp.sk_cb.ops;
 
-	rcu_assign_sk_user_data(sock->sk, NULL);
+	rcu_assign_sk_user_data(sk, NULL);
 }
 
 void ovpn_tcp_socket_wait_finish(struct ovpn_socket *sock)
@@ -283,10 +283,10 @@ void ovpn_tcp_tx_work(struct work_struct *work)
 
 	sock = container_of(work, struct ovpn_socket, tcp_tx_work);
 
-	lock_sock(sock->sock->sk);
+	lock_sock(sock->sk);
 	if (sock->peer)
-		ovpn_tcp_send_sock(sock->peer, sock->sock->sk);
-	release_sock(sock->sock->sk);
+		ovpn_tcp_send_sock(sock->peer, sock->sk);
+	release_sock(sock->sk);
 }
 
 static void ovpn_tcp_send_sock_skb(struct ovpn_peer *peer, struct sock *sk,
@@ -307,15 +307,15 @@ static void ovpn_tcp_send_sock_skb(struct ovpn_peer *peer, struct sock *sk,
 	ovpn_tcp_send_sock(peer, sk);
 }
 
-void ovpn_tcp_send_skb(struct ovpn_peer *peer, struct socket *sock,
+void ovpn_tcp_send_skb(struct ovpn_peer *peer, struct sock *sk,
 		       struct sk_buff *skb)
 {
 	u16 len = skb->len;
 
 	*(__be16 *)__skb_push(skb, sizeof(u16)) = htons(len);
 
-	spin_lock_nested(&sock->sk->sk_lock.slock, OVPN_TCP_DEPTH_NESTING);
-	if (sock_owned_by_user(sock->sk)) {
+	spin_lock_nested(&sk->sk_lock.slock, OVPN_TCP_DEPTH_NESTING);
+	if (sock_owned_by_user(sk)) {
 		if (skb_queue_len(&peer->tcp.out_queue) >=
 		    READ_ONCE(net_hotdata.max_backlog)) {
 			dev_dstats_tx_dropped(peer->ovpn->dev);
@@ -324,10 +324,10 @@ void ovpn_tcp_send_skb(struct ovpn_peer *peer, struct socket *sock,
 		}
 		__skb_queue_tail(&peer->tcp.out_queue, skb);
 	} else {
-		ovpn_tcp_send_sock_skb(peer, sock->sk, skb);
+		ovpn_tcp_send_sock_skb(peer, sk, skb);
 	}
 unlock:
-	spin_unlock(&sock->sk->sk_lock.slock);
+	spin_unlock(&sk->sk_lock.slock);
 }
 
 static void ovpn_tcp_release(struct sock *sk)
@@ -474,7 +474,6 @@ static void ovpn_tcp_peer_del_work(struct work_struct *work)
 int ovpn_tcp_socket_attach(struct ovpn_socket *ovpn_sock,
 			   struct ovpn_peer *peer)
 {
-	struct socket *sock = ovpn_sock->sock;
 	struct strp_callbacks cb = {
 		.rcv_msg = ovpn_tcp_rcv,
 		.parse_msg = ovpn_tcp_parse,
@@ -482,20 +481,20 @@ int ovpn_tcp_socket_attach(struct ovpn_socket *ovpn_sock,
 	int ret;
 
 	/* make sure no pre-existing encapsulation handler exists */
-	if (sock->sk->sk_user_data)
+	if (ovpn_sock->sk->sk_user_data)
 		return -EBUSY;
 
 	/* only a fully connected socket is expected. Connection should be
 	 * handled in userspace
 	 */
-	if (sock->sk->sk_state != TCP_ESTABLISHED) {
+	if (ovpn_sock->sk->sk_state != TCP_ESTABLISHED) {
 		net_err_ratelimited("%s: provided TCP socket is not in ESTABLISHED state: %d\n",
 				    netdev_name(peer->ovpn->dev),
-				    sock->sk->sk_state);
+				    ovpn_sock->sk->sk_state);
 		return -EINVAL;
 	}
 
-	ret = strp_init(&peer->tcp.strp, sock->sk, &cb);
+	ret = strp_init(&peer->tcp.strp, ovpn_sock->sk, &cb);
 	if (ret < 0) {
 		DEBUG_NET_WARN_ON_ONCE(1);
 		return ret;
@@ -503,31 +502,31 @@ int ovpn_tcp_socket_attach(struct ovpn_socket *ovpn_sock,
 
 	INIT_WORK(&peer->tcp.defer_del_work, ovpn_tcp_peer_del_work);
 
-	__sk_dst_reset(sock->sk);
+	__sk_dst_reset(ovpn_sock->sk);
 	skb_queue_head_init(&peer->tcp.user_queue);
 	skb_queue_head_init(&peer->tcp.out_queue);
 
 	/* save current CBs so that they can be restored upon socket release */
-	peer->tcp.sk_cb.sk_data_ready = sock->sk->sk_data_ready;
-	peer->tcp.sk_cb.sk_write_space = sock->sk->sk_write_space;
-	peer->tcp.sk_cb.prot = sock->sk->sk_prot;
-	peer->tcp.sk_cb.ops = sock->sk->sk_socket->ops;
+	peer->tcp.sk_cb.sk_data_ready = ovpn_sock->sk->sk_data_ready;
+	peer->tcp.sk_cb.sk_write_space = ovpn_sock->sk->sk_write_space;
+	peer->tcp.sk_cb.prot = ovpn_sock->sk->sk_prot;
+	peer->tcp.sk_cb.ops = ovpn_sock->sk->sk_socket->ops;
 
 	/* assign our static CBs and prot/ops */
-	sock->sk->sk_data_ready = ovpn_tcp_data_ready;
-	sock->sk->sk_write_space = ovpn_tcp_write_space;
+	ovpn_sock->sk->sk_data_ready = ovpn_tcp_data_ready;
+	ovpn_sock->sk->sk_write_space = ovpn_tcp_write_space;
 
-	if (sock->sk->sk_family == AF_INET) {
-		sock->sk->sk_prot = &ovpn_tcp_prot;
-		sock->sk->sk_socket->ops = &ovpn_tcp_ops;
+	if (ovpn_sock->sk->sk_family == AF_INET) {
+		ovpn_sock->sk->sk_prot = &ovpn_tcp_prot;
+		ovpn_sock->sk->sk_socket->ops = &ovpn_tcp_ops;
 	} else {
-		sock->sk->sk_prot = &ovpn_tcp6_prot;
-		sock->sk->sk_socket->ops = &ovpn_tcp6_ops;
+		ovpn_sock->sk->sk_prot = &ovpn_tcp6_prot;
+		ovpn_sock->sk->sk_socket->ops = &ovpn_tcp6_ops;
 	}
 
 	/* avoid using task_frag */
-	sock->sk->sk_allocation = GFP_ATOMIC;
-	sock->sk->sk_use_task_frag = false;
+	ovpn_sock->sk->sk_allocation = GFP_ATOMIC;
+	ovpn_sock->sk->sk_use_task_frag = false;
 
 	/* enqueue the RX worker */
 	strp_check_rcv(&peer->tcp.strp);
diff --git a/drivers/net/ovpn/tcp.h b/drivers/net/ovpn/tcp.h
index 10aefa834cf3..a3aa3570ae5e 100644
--- a/drivers/net/ovpn/tcp.h
+++ b/drivers/net/ovpn/tcp.h
@@ -30,7 +30,8 @@ void ovpn_tcp_socket_wait_finish(struct ovpn_socket *sock);
  * Required by the OpenVPN protocol in order to extract packets from
  * the TCP stream on the receiver side.
  */
-void ovpn_tcp_send_skb(struct ovpn_peer *peer, struct socket *sock, struct sk_buff *skb);
+void ovpn_tcp_send_skb(struct ovpn_peer *peer, struct sock *sk,
+		       struct sk_buff *skb);
 void ovpn_tcp_tx_work(struct work_struct *work);
 
 #endif /* _NET_OVPN_TCP_H_ */
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 89bb50f94ddb..c99e8d72042d 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -43,7 +43,7 @@ static struct ovpn_socket *ovpn_socket_from_udp_sock(struct sock *sk)
 		return NULL;
 
 	/* make sure that sk matches our stored transport socket */
-	if (unlikely(!ovpn_sock->sock || sk != ovpn_sock->sock->sk))
+	if (unlikely(!ovpn_sock->sk || sk != ovpn_sock->sk))
 		return NULL;
 
 	return ovpn_sock;
@@ -335,32 +335,22 @@ static int ovpn_udp_output(struct ovpn_peer *peer, struct dst_cache *cache,
 /**
  * ovpn_udp_send_skb - prepare skb and send it over via UDP
  * @peer: the destination peer
- * @sock: the RCU protected peer socket
+ * @sk: peer socket
  * @skb: the packet to send
  */
-void ovpn_udp_send_skb(struct ovpn_peer *peer, struct socket *sock,
+void ovpn_udp_send_skb(struct ovpn_peer *peer, struct sock *sk,
 		       struct sk_buff *skb)
 {
-	int ret = -1;
+	int ret;
 
 	skb->dev = peer->ovpn->dev;
 	/* no checksum performed at this layer */
 	skb->ip_summed = CHECKSUM_NONE;
 
-	/* get socket info */
-	if (unlikely(!sock)) {
-		net_warn_ratelimited("%s: no sock for remote peer %u\n",
-				     netdev_name(peer->ovpn->dev), peer->id);
-		goto out;
-	}
-
 	/* crypto layer -> transport (UDP) */
-	ret = ovpn_udp_output(peer, &peer->dst_cache, sock->sk, skb);
-out:
-	if (unlikely(ret < 0)) {
+	ret = ovpn_udp_output(peer, &peer->dst_cache, sk, skb);
+	if (unlikely(ret < 0))
 		kfree_skb(skb);
-		return;
-	}
 }
 
 static void ovpn_udp_encap_destroy(struct sock *sk)
@@ -383,6 +373,7 @@ static void ovpn_udp_encap_destroy(struct sock *sk)
 /**
  * ovpn_udp_socket_attach - set udp-tunnel CBs on socket and link it to ovpn
  * @ovpn_sock: socket to configure
+ * @sock: the socket container to be passed to setup_udp_tunnel_sock()
  * @ovpn: the openvp instance to link
  *
  * After invoking this function, the sock will be controlled by ovpn so that
@@ -390,7 +381,7 @@ static void ovpn_udp_encap_destroy(struct sock *sk)
  *
  * Return: 0 on success or a negative error code otherwise
  */
-int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock,
+int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock, struct socket *sock,
 			   struct ovpn_priv *ovpn)
 {
 	struct udp_tunnel_sock_cfg cfg = {
@@ -398,17 +389,16 @@ int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock,
 		.encap_rcv = ovpn_udp_encap_recv,
 		.encap_destroy = ovpn_udp_encap_destroy,
 	};
-	struct socket *sock = ovpn_sock->sock;
 	struct ovpn_socket *old_data;
 	int ret;
 
 	/* make sure no pre-existing encapsulation handler exists */
 	rcu_read_lock();
-	old_data = rcu_dereference_sk_user_data(sock->sk);
+	old_data = rcu_dereference_sk_user_data(ovpn_sock->sk);
 	if (!old_data) {
 		/* socket is currently unused - we can take it */
 		rcu_read_unlock();
-		setup_udp_tunnel_sock(sock_net(sock->sk), sock, &cfg);
+		setup_udp_tunnel_sock(sock_net(ovpn_sock->sk), sock, &cfg);
 		return 0;
 	}
 
@@ -421,7 +411,7 @@ int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock,
 	 * Unlikely TCP, a single UDP socket can be used to talk to many remote
 	 * hosts and therefore openvpn instantiates one only for all its peers
 	 */
-	if ((READ_ONCE(udp_sk(sock->sk)->encap_type) == UDP_ENCAP_OVPNINUDP) &&
+	if ((READ_ONCE(udp_sk(ovpn_sock->sk)->encap_type) == UDP_ENCAP_OVPNINUDP) &&
 	    old_data->ovpn == ovpn) {
 		netdev_dbg(ovpn->dev,
 			   "provided socket already owned by this interface\n");
@@ -442,7 +432,7 @@ int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock,
  */
 void ovpn_udp_socket_detach(struct ovpn_socket *ovpn_sock)
 {
-	struct sock *sk = ovpn_sock->sock->sk;
+	struct sock *sk = ovpn_sock->sk;
 
 	/* Re-enable multicast loopback */
 	inet_set_bit(MC_LOOP, sk);
diff --git a/drivers/net/ovpn/udp.h b/drivers/net/ovpn/udp.h
index 9994eb6e0428..fe26fbe25c5a 100644
--- a/drivers/net/ovpn/udp.h
+++ b/drivers/net/ovpn/udp.h
@@ -15,11 +15,11 @@ struct ovpn_peer;
 struct ovpn_priv;
 struct socket;
 
-int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock,
+int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock, struct socket *sock,
 			   struct ovpn_priv *ovpn);
 void ovpn_udp_socket_detach(struct ovpn_socket *ovpn_sock);
 
-void ovpn_udp_send_skb(struct ovpn_peer *peer, struct socket *sock,
+void ovpn_udp_send_skb(struct ovpn_peer *peer, struct sock *sk,
 		       struct sk_buff *skb);
 
 #endif /* _NET_OVPN_UDP_H_ */
-- 
2.49.0


