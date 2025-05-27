Return-Path: <netdev+bounces-193664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6637CAC5041
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 15:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BDB517DEDF
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 13:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAC0277032;
	Tue, 27 May 2025 13:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="DjgTz0Lq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B92275864
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 13:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748353979; cv=none; b=IakKgJFrNh1MfxKuAfb3JTzpYpkJAvXzVOnF6CECiuVICUQN7PfOtfm3XLQEVJ+2maRlMGD7sm1hT3/oaN6gHNOzDqpFSE6nRwVqZo9QdlJ5OtCo4WWX9pOyuSakQoTTAj4Cpy/L9LPQV1MyBoyPKwJjWYQ7DzQX/gcGVa4gz64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748353979; c=relaxed/simple;
	bh=M7Aa5pf05ney6vVW6YRDefTSSzEoFGCw7nfj8KAbVgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mKHUI2y3JSpiVSkeKj82bEI6CdFKGJSM93v9sEl4zFtHXwtgLa3E+czoNlS6AF/qnY59Dqw6Cj/N3hkdNdxUW3iaOar4COBBV4hRhBCbnurPAxBsSTF1SCDlxlb/RpKjxzDS/1sLHwSO0ydRy3YlkYfTMAU+BkK0w17fE1iMV1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=DjgTz0Lq; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a36efcadb8so3317761f8f.0
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 06:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1748353974; x=1748958774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UeULaEivexSZPzsUqv8VWrshH6FRHpOrVGAwYgrieVw=;
        b=DjgTz0LqLfgreu6AMUmTO4pL4RyuaO4EmDH7Lzf7OzgZrTAXCp+W0N73bUlooeuOFT
         6PRiyaI7zdXaABSNmueYIRKsAvcHuhIppVu7/qwev8deKfwRMUj9pwNGGzEe4yDg5OPY
         5JFwTXHhvGJZ9nSp+xgUwmVODzHhQ5okLmrbRZLfRt1+5R8b6wjfPkUYMbv1URVxfCyB
         6+fFqlV8pwTkBcRmdr2lxitABonzQN4SAPA0PMiK58/hMJCB1ogQx2e2M8JCBWw9FSot
         jyYnAhfj7iOG/BY2aVXA+e5qeiWCCZxwmr0EZs6gnQuTQM7MVk2OCNNrnmD4AN1vVAl1
         IAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748353974; x=1748958774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UeULaEivexSZPzsUqv8VWrshH6FRHpOrVGAwYgrieVw=;
        b=V0R/DO1XMgWhQ/OjXVt6DoYvXBnbTs6J/iFtyGnyvHBNpFg1XXASHdUI1HdHS3I5XY
         V/VlfP+71wAC+p1RGHRfynrXRWRGxbvt1B9MpJK0pheN8xa2uhLjEiRHcJXji/x3vI0p
         8HNYTMsDED8+JXzE/6NXHBYMppHRwL3/DL9a41E+l8bmf8PpCXx7qU/11YW5D7+oVZq9
         O61/o7h//z7newJksi9WTBTRypeBCOEiubYDvK+2XBjBCU9B+3HHpqtYEtK2VV7zmFA1
         nk+OeLqE2+LE/TGyc9CVZeQxqHfKkUHyVe9pwFsCyJspKyfHUTlDNydJ/miZ6Q4+9Nfs
         ouig==
X-Gm-Message-State: AOJu0Yxm7o1bp/U1ts3onWF5Xu+ehPU9Ef67x+1/5j7NPKJTUCO9u0Ab
	lfiJbOb44P41wQdWLrPb7etri4DL7dLhx5Ll6zJNzX58O4sm4NQ1Q66Kfti8JSmuL/WrdoF0zCL
	Z/ALBnhJnTgRQTRS5cJlPHNzq8V9DbZNudio3rxTXgcDOFSBxMCV2a5Ga+i3XK0My
X-Gm-Gg: ASbGncus76wSNAaKLzajGzHZi9R1eSgY6MshF2BrXRbcN5kK5kkIVI93MkTHRRNwMJd
	DnwXWHB+b3ThQWQ2EN6udusDrclaB0t1f0nd7ybDnOlQcBQS4MeaTWnA2kSVEvkEnO5JP+1OI+6
	Y1LghWQ1+L6UlJ1WLjA/uYnxW9ALLY2uU6RgqnjspxRsKc3azYvud5PY3x1F45lR1VPQiy1DCTo
	itfR/bmu2v8SQ1XcwgzAfB2vOsN8JqVBaTGd5jpF4hwyEb3Ztt0iP0xOX/cYH0gS3SkFV2EJHyM
	B2ZChleIOgua5v3w1MJDm3J/daf/uxWCQk5oHRl9knJZp4fcp/mU5VvHy6pH0+kBeteaFh6TJF0
	=
X-Google-Smtp-Source: AGHT+IG7DEYX07ihxG0UcYxivnwWygZa4fdAiQ1G+DTFW7zo0qr3o8mmANDWhdaJHgoJjzamb6Ce5w==
X-Received: by 2002:adf:f0cc:0:b0:3a4:d02e:84ac with SMTP id ffacd0b85a97d-3a4d02e8731mr7660584f8f.13.1748353973754;
        Tue, 27 May 2025 06:52:53 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:5803:da07:1aab:70cb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4db284261sm5387719f8f.67.2025.05.27.06.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 06:52:53 -0700 (PDT)
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
Subject: [PATCH net-next 2/4] ovpn: ensure sk is still valid during cleanup
Date: Tue, 27 May 2025 15:46:18 +0200
Message-ID: <20250527134625.15216-3-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527134625.15216-1-antonio@openvpn.net>
References: <20250527134625.15216-1-antonio@openvpn.net>
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
 drivers/net/ovpn/netlink.c | 25 ++++++++------
 drivers/net/ovpn/peer.c    |  4 +--
 drivers/net/ovpn/socket.c  | 68 +++++++++++++++++++++-----------------
 drivers/net/ovpn/socket.h  |  4 +--
 drivers/net/ovpn/tcp.c     | 65 ++++++++++++++++++------------------
 drivers/net/ovpn/tcp.h     |  3 +-
 drivers/net/ovpn/udp.c     | 34 +++++++------------
 drivers/net/ovpn/udp.h     |  4 +--
 9 files changed, 109 insertions(+), 106 deletions(-)

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
index bea03913bfb1..1dd7e763c168 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -423,9 +423,14 @@ int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
 	ovpn_sock = ovpn_socket_new(sock, peer);
 	/* at this point we unconditionally drop the reference to the socket:
 	 * - in case of error, the socket has to be dropped
-	 * - if case of success, the socket is configured and let
+	 * - if case of success, the socket is configured and we let
 	 *   userspace own the reference, so that the latter can
-	 *   trigger the final close()
+	 *   trigger the final close().
+	 *
+	 * NOTE: at this point ovpn_socket_new() has acquired a reference
+	 * to sock->sk. That's needed especially to avoid race conditions
+	 * during cleanup, where sock may still be alive, but sock->sk may be
+	 * getting released concurrently.
 	 */
 	sockfd_put(sock);
 	if (IS_ERR(ovpn_sock)) {
@@ -501,7 +506,7 @@ int ovpn_nl_peer_set_doit(struct sk_buff *skb, struct genl_info *info)
 	/* when using a TCP socket the remote IP is not expected */
 	rcu_read_lock();
 	sock = rcu_dereference(peer->sock);
-	if (sock && sock->sock->sk->sk_protocol == IPPROTO_TCP &&
+	if (sock && sock->sk->sk_protocol == IPPROTO_TCP &&
 	    (attrs[OVPN_A_PEER_REMOTE_IPV4] ||
 	     attrs[OVPN_A_PEER_REMOTE_IPV6])) {
 		rcu_read_unlock();
@@ -559,14 +564,14 @@ static int ovpn_nl_send_peer(struct sk_buff *skb, const struct genl_info *info,
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
@@ -1153,8 +1158,8 @@ int ovpn_nl_peer_del_notify(struct ovpn_peer *peer)
 		ret = -EINVAL;
 		goto err_unlock;
 	}
-	genlmsg_multicast_netns(&ovpn_nl_family, sock_net(sock->sock->sk),
-				msg, 0, OVPN_NLGRP_PEERS, GFP_ATOMIC);
+	genlmsg_multicast_netns(&ovpn_nl_family, sock_net(sock->sk), msg, 0,
+				OVPN_NLGRP_PEERS, GFP_ATOMIC);
 	rcu_read_unlock();
 
 	return 0;
@@ -1218,8 +1223,8 @@ int ovpn_nl_key_swap_notify(struct ovpn_peer *peer, u8 key_id)
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
index a83cbab72591..8c8c4f270f0d 100644
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
@@ -192,19 +189,30 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
 		rcu_read_unlock();
 	}
 
+	/* increase sk refcounter as we'll store a reference in
+	 * ovpn_socket.
+	 * ovpn_socket_release() will decrement the refcounter.
+	 */
+	if (!refcount_inc_not_zero(&sk->sk_refcnt)) {
+		ovpn_sock = ERR_PTR(-ENOTSOCK);
+		goto sock_release;
+	}
+
 	/* socket is not owned: attach to this ovpn instance */
 
 	ovpn_sock = kzalloc(sizeof(*ovpn_sock), GFP_KERNEL);
 	if (!ovpn_sock) {
+		sock_put(sk);
 		ovpn_sock = ERR_PTR(-ENOMEM);
 		goto sock_release;
 	}
 
-	ovpn_sock->sock = sock;
+	ovpn_sock->sk = sk;
 	kref_init(&ovpn_sock->refcount);
 
-	ret = ovpn_socket_attach(ovpn_sock, peer);
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
index c8a81c4d6489..b4fbebad8f45 100644
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
@@ -442,5 +432,5 @@ int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock,
  */
 void ovpn_udp_socket_detach(struct ovpn_socket *ovpn_sock)
 {
-	cleanup_udp_tunnel_sock(ovpn_sock->sock->sk);
+	cleanup_udp_tunnel_sock(ovpn_sock->sk);
 }
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


