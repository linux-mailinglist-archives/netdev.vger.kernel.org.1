Return-Path: <netdev+bounces-140255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 878209B5AA6
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 05:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA5381C20F20
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 04:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669FC194151;
	Wed, 30 Oct 2024 04:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QL63DoW+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39704125DF;
	Wed, 30 Oct 2024 04:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730262181; cv=none; b=A0iRudURmVaJg+pM9h/rG620eHkgeumQrO+eHS5gn5z2CKiDQSXwgPn1a51OaCJkvYakLLqkwBnHjf91DF/LD9lDPHXK+Cr5CborfuoXWf4eMCaZOoTscQAxIEZDIYJo9ThYXGjmrVLUA/pPEZI5LB4w5YXmPfidOUkVaJVD4u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730262181; c=relaxed/simple;
	bh=lN2d8rOTEXvuOeuMB2R0cCQfgA+IvSDQZDfiL+ST9l0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lk+Axsn0+1JlhBnDztI6/Bk6VvVqIyHeGrAYnjk+TrkkmLBfni5elj2U3+JNWuypxIQfx1wtjSRY2zMCgLNV+PVyCYE5X+j3FGjfOqS/BQ+9v3ge/a8Rv3FElyAYdQQxRhR7DF9Qx1Was3ThtjkCYg5tGDJAi+yjXMJEeS9qP+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QL63DoW+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C78A0C4CEE4;
	Wed, 30 Oct 2024 04:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730262180;
	bh=lN2d8rOTEXvuOeuMB2R0cCQfgA+IvSDQZDfiL+ST9l0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=QL63DoW+6MkbGHheFMZzYsQaq23qI50VP4HYq9xuriFnVUBvvrM0A2IIqwq6CZ+Pt
	 3GfwdbjMst2302S/YoTKxvvlHD63JXuV0dMC7nfj5UdcWW7yaVZUZ3EKtEu7ieSQ12
	 CuNuAiN7I0bNYHZccV8ujJkc2KWw9XSKPZ6kRM2Hhe1vzWidEDWf2SY41J7Jp4iE+k
	 VdUmLMtNpY2b+o/wUey40FGY2OVsPNCw58ta1o2v/M1D46xz4Wqjovrk6nmmQXs0OR
	 YIhPXdRDS055wVxI8GVbuv7hFJix7MbcKpfZrxgfOsrnHVPGz+lz7vfVrS/FkwlKGq
	 aVUdm647EIs4A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FF3D7495F;
	Wed, 30 Oct 2024 04:23:00 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Wed, 30 Oct 2024 04:22:33 +0000
Subject: [PATCH] net/tcp: Add missing lockdep annotations for TCP-AO hlist
 traversals
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-tcp-ao-hlist-lockdep-annotate-v1-1-bf641a64d7c6@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIi0IWcC/x3MQQqDMBBA0avIrDsQYzHYq5Qu4jg2Q+0kJEEK4
 t2bdvn+4h9QOAsXuHUHZN6lSNSG/tIBBa9PRlmawRp77c1gsFJCHzFsUipukV4Lt6Aaq6+Mbhz
 cNBk32pWgPVLmVT7///3RPPvCOGevFH7X+k5wnl9ate2zhQAAAA==
X-Change-ID: 20241030-tcp-ao-hlist-lockdep-annotate-7637990762fc
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730262176; l=9743;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=REoYesXnOZcViXMhTpRDXKCqR3ncq7wNiulbSW1AwT0=;
 b=yMgKLLPNSxtrI65bcm6gqxYwdbKxpRuoP1KLGp/g/Pc/olGveWzUb91MuPbaoyL3oIMILIyF8
 kVcDEGJaDBJDVCSz1ecte2IbPXPv1dTM75nvm2WquSKjWB3tfkKjLQQ
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

From: Dmitry Safonov <0x7f454c46@gmail.com>

Under CONFIG_PROVE_RCU_LIST + CONFIG_RCU_EXPERT
hlist_for_each_entry_rcu() provides very helpful splats, which help
to find possible issues. I missed CONFIG_RCU_EXPERT=y in my testing
config the same as described in
a3e4bf7f9675 ("configs/debug: make sure PROVE_RCU_LIST=y takes effect").

The fix itself is trivial: add the very same lockdep annotations
as were used to dereference ao_info from the socket.

Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/netdev/20241028152645.35a8be66@kernel.org/
Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
 include/net/tcp_ao.h |  3 ++-
 net/ipv4/tcp_ao.c    | 42 +++++++++++++++++++++++-------------------
 net/ipv4/tcp_ipv4.c  |  3 ++-
 net/ipv6/tcp_ipv6.c  |  4 ++--
 4 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index 1d46460d0fefab10feefa318e4ba579a3aa1f1d0..df655ce6987d3730fea7a6ef0db09c2e27b34f21 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -183,7 +183,8 @@ int tcp_ao_hash_skb(unsigned short int family,
 		    const u8 *tkey, int hash_offset, u32 sne);
 int tcp_parse_ao(struct sock *sk, int cmd, unsigned short int family,
 		 sockptr_t optval, int optlen);
-struct tcp_ao_key *tcp_ao_established_key(struct tcp_ao_info *ao,
+struct tcp_ao_key *tcp_ao_established_key(const struct sock *sk,
+					  struct tcp_ao_info *ao,
 					  int sndid, int rcvid);
 int tcp_ao_copy_all_matching(const struct sock *sk, struct sock *newsk,
 			     struct request_sock *req, struct sk_buff *skb,
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index db6516092daf5b180fb75482fb711f226451a647..bbb8d5f0eae7d3d8887da3fa4d68e248af9060ad 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -109,12 +109,13 @@ bool tcp_ao_ignore_icmp(const struct sock *sk, int family, int type, int code)
  * it's known that the keys in ao_info are matching peer's
  * family/address/VRF/etc.
  */
-struct tcp_ao_key *tcp_ao_established_key(struct tcp_ao_info *ao,
+struct tcp_ao_key *tcp_ao_established_key(const struct sock *sk,
+					  struct tcp_ao_info *ao,
 					  int sndid, int rcvid)
 {
 	struct tcp_ao_key *key;
 
-	hlist_for_each_entry_rcu(key, &ao->head, node) {
+	hlist_for_each_entry_rcu(key, &ao->head, node, lockdep_sock_is_held(sk)) {
 		if ((sndid >= 0 && key->sndid != sndid) ||
 		    (rcvid >= 0 && key->rcvid != rcvid))
 			continue;
@@ -205,7 +206,7 @@ static struct tcp_ao_key *__tcp_ao_do_lookup(const struct sock *sk, int l3index,
 	if (!ao)
 		return NULL;
 
-	hlist_for_each_entry_rcu(key, &ao->head, node) {
+	hlist_for_each_entry_rcu(key, &ao->head, node, lockdep_sock_is_held(sk)) {
 		u8 prefixlen = min(prefix, key->prefixlen);
 
 		if (!tcp_ao_key_cmp(key, l3index, addr, prefixlen,
@@ -793,7 +794,7 @@ int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
 		if (!ao_info)
 			return -ENOENT;
 
-		*key = tcp_ao_established_key(ao_info, aoh->rnext_keyid, -1);
+		*key = tcp_ao_established_key(sk, ao_info, aoh->rnext_keyid, -1);
 		if (!*key)
 			return -ENOENT;
 		*traffic_key = snd_other_key(*key);
@@ -979,7 +980,7 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 		 */
 		key = READ_ONCE(info->rnext_key);
 		if (key->rcvid != aoh->keyid) {
-			key = tcp_ao_established_key(info, -1, aoh->keyid);
+			key = tcp_ao_established_key(sk, info, -1, aoh->keyid);
 			if (!key)
 				goto key_not_found;
 		}
@@ -1003,7 +1004,7 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 						   aoh->rnext_keyid,
 						   tcp_ao_hdr_maclen(aoh));
 			/* If the key is not found we do nothing. */
-			key = tcp_ao_established_key(info, aoh->rnext_keyid, -1);
+			key = tcp_ao_established_key(sk, info, aoh->rnext_keyid, -1);
 			if (key)
 				/* pairs with tcp_ao_del_cmd */
 				WRITE_ONCE(info->current_key, key);
@@ -1163,7 +1164,7 @@ void tcp_ao_established(struct sock *sk)
 	if (!ao)
 		return;
 
-	hlist_for_each_entry_rcu(key, &ao->head, node)
+	hlist_for_each_entry_rcu(key, &ao->head, node, lockdep_sock_is_held(sk))
 		tcp_ao_cache_traffic_keys(sk, ao, key);
 }
 
@@ -1180,7 +1181,7 @@ void tcp_ao_finish_connect(struct sock *sk, struct sk_buff *skb)
 	WRITE_ONCE(ao->risn, tcp_hdr(skb)->seq);
 	ao->rcv_sne = 0;
 
-	hlist_for_each_entry_rcu(key, &ao->head, node)
+	hlist_for_each_entry_rcu(key, &ao->head, node, lockdep_sock_is_held(sk))
 		tcp_ao_cache_traffic_keys(sk, ao, key);
 }
 
@@ -1256,14 +1257,14 @@ int tcp_ao_copy_all_matching(const struct sock *sk, struct sock *newsk,
 	key_head = rcu_dereference(hlist_first_rcu(&new_ao->head));
 	first_key = hlist_entry_safe(key_head, struct tcp_ao_key, node);
 
-	key = tcp_ao_established_key(new_ao, tcp_rsk(req)->ao_keyid, -1);
+	key = tcp_ao_established_key(req_to_sk(req), new_ao, tcp_rsk(req)->ao_keyid, -1);
 	if (key)
 		new_ao->current_key = key;
 	else
 		new_ao->current_key = first_key;
 
 	/* set rnext_key */
-	key = tcp_ao_established_key(new_ao, -1, tcp_rsk(req)->ao_rcv_next);
+	key = tcp_ao_established_key(req_to_sk(req), new_ao, -1, tcp_rsk(req)->ao_rcv_next);
 	if (key)
 		new_ao->rnext_key = key;
 	else
@@ -1857,12 +1858,12 @@ static int tcp_ao_del_cmd(struct sock *sk, unsigned short int family,
 	 * if there's any.
 	 */
 	if (cmd.set_current) {
-		new_current = tcp_ao_established_key(ao_info, cmd.current_key, -1);
+		new_current = tcp_ao_established_key(sk, ao_info, cmd.current_key, -1);
 		if (!new_current)
 			return -ENOENT;
 	}
 	if (cmd.set_rnext) {
-		new_rnext = tcp_ao_established_key(ao_info, -1, cmd.rnext);
+		new_rnext = tcp_ao_established_key(sk, ao_info, -1, cmd.rnext);
 		if (!new_rnext)
 			return -ENOENT;
 	}
@@ -1902,7 +1903,8 @@ static int tcp_ao_del_cmd(struct sock *sk, unsigned short int family,
 	 * "It is presumed that an MKT affecting a particular
 	 * connection cannot be destroyed during an active connection"
 	 */
-	hlist_for_each_entry_rcu(key, &ao_info->head, node) {
+	hlist_for_each_entry_rcu(key, &ao_info->head, node,
+				 lockdep_sock_is_held(sk)) {
 		if (cmd.sndid != key->sndid ||
 		    cmd.rcvid != key->rcvid)
 			continue;
@@ -2000,14 +2002,14 @@ static int tcp_ao_info_cmd(struct sock *sk, unsigned short int family,
 	 * if there's any.
 	 */
 	if (cmd.set_current) {
-		new_current = tcp_ao_established_key(ao_info, cmd.current_key, -1);
+		new_current = tcp_ao_established_key(sk, ao_info, cmd.current_key, -1);
 		if (!new_current) {
 			err = -ENOENT;
 			goto out;
 		}
 	}
 	if (cmd.set_rnext) {
-		new_rnext = tcp_ao_established_key(ao_info, -1, cmd.rnext);
+		new_rnext = tcp_ao_established_key(sk, ao_info, -1, cmd.rnext);
 		if (!new_rnext) {
 			err = -ENOENT;
 			goto out;
@@ -2101,7 +2103,8 @@ int tcp_v4_parse_ao(struct sock *sk, int cmd, sockptr_t optval, int optlen)
  * The layout of the fields in the user and kernel structures is expected to
  * be the same (including in the 32bit vs 64bit case).
  */
-static int tcp_ao_copy_mkts_to_user(struct tcp_ao_info *ao_info,
+static int tcp_ao_copy_mkts_to_user(const struct sock *sk,
+				    struct tcp_ao_info *ao_info,
 				    sockptr_t optval, sockptr_t optlen)
 {
 	struct tcp_ao_getsockopt opt_in, opt_out;
@@ -2229,7 +2232,8 @@ static int tcp_ao_copy_mkts_to_user(struct tcp_ao_info *ao_info,
 	/* May change in RX, while we're dumping, pre-fetch it */
 	current_key = READ_ONCE(ao_info->current_key);
 
-	hlist_for_each_entry_rcu(key, &ao_info->head, node) {
+	hlist_for_each_entry_rcu(key, &ao_info->head, node,
+				 lockdep_sock_is_held(sk)) {
 		if (opt_in.get_all)
 			goto match;
 
@@ -2309,7 +2313,7 @@ int tcp_ao_get_mkts(struct sock *sk, sockptr_t optval, sockptr_t optlen)
 	if (!ao_info)
 		return -ENOENT;
 
-	return tcp_ao_copy_mkts_to_user(ao_info, optval, optlen);
+	return tcp_ao_copy_mkts_to_user(sk, ao_info, optval, optlen);
 }
 
 int tcp_ao_get_sock_info(struct sock *sk, sockptr_t optval, sockptr_t optlen)
@@ -2396,7 +2400,7 @@ int tcp_ao_set_repair(struct sock *sk, sockptr_t optval, unsigned int optlen)
 	WRITE_ONCE(ao->snd_sne, cmd.snd_sne);
 	WRITE_ONCE(ao->rcv_sne, cmd.rcv_sne);
 
-	hlist_for_each_entry_rcu(key, &ao->head, node)
+	hlist_for_each_entry_rcu(key, &ao->head, node, lockdep_sock_is_held(sk))
 		tcp_ao_cache_traffic_keys(sk, ao, key);
 
 	return 0;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 9d3dd101ea713b14e13afe662baa49d21b3b716c..a38c8b1f44dbd95fcea08bd81e0ceaa70177ac8a 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1053,7 +1053,8 @@ static void tcp_v4_timewait_ack(struct sock *sk, struct sk_buff *skb)
 			}
 
 			if (aoh)
-				key.ao_key = tcp_ao_established_key(ao_info, aoh->rnext_keyid, -1);
+				key.ao_key = tcp_ao_established_key(sk, ao_info,
+								    aoh->rnext_keyid, -1);
 		}
 	}
 	if (key.ao_key) {
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 597920061a3a061a878bf0f7a1b03ac4898918a9..c748eeae1453342bab22f0e5cdb450b9827d2d5f 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1172,8 +1172,8 @@ static void tcp_v6_timewait_ack(struct sock *sk, struct sk_buff *skb)
 			if (tcp_parse_auth_options(tcp_hdr(skb), NULL, &aoh))
 				goto out;
 			if (aoh)
-				key.ao_key = tcp_ao_established_key(ao_info,
-						aoh->rnext_keyid, -1);
+				key.ao_key = tcp_ao_established_key(sk, ao_info,
+								    aoh->rnext_keyid, -1);
 		}
 	}
 	if (key.ao_key) {

---
base-commit: 71e0ad345163c150ea15434b37036b0678d5f6f4
change-id: 20241030-tcp-ao-hlist-lockdep-annotate-7637990762fc

Best regards,
-- 
Dmitry Safonov <0x7f454c46@gmail.com>



