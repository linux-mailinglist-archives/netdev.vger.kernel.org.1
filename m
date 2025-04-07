Return-Path: <netdev+bounces-179912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6088AA7EE24
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 22:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 916F43BEF7A
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7772561A8;
	Mon,  7 Apr 2025 19:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="M9dudo85"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAE325522E
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 19:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055257; cv=none; b=MonOguaxdkQ0OzkOD32QnjOz+afqbXWfmwB93VjKnPSVUuj8C5ypWw9Q7jtrVQy3Z6bvLkfuwSOUU/f/8GA2A3VDSMwoRaXkj9gxcIuRdWSb0OkUT4+Re9LQQw5kVcR65/6aD/ALbrkZx4wvExbXKC9h8Dx4/d80Oex9HyCkuPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055257; c=relaxed/simple;
	bh=SXG0lPHLCgEeqC7vHU1pLlERylwwih9HhOh9/5lf51c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MrA+ZP4cOtEyrsr4IYbIjW4I5N8PD2318ILuoJs/zD5wpz+wDFDo50AUX1TwMKRtv/OrUhb3WSy/WXJ+XKWeKd3AX0hgM7FUrAFCX+if33hqnjpR6PmeNmxTlT3KwlPawbH97CM3Menub3ZSLs70Hf6DndknivVN29nvwJuNVYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=M9dudo85; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39ac8e7688aso3585478f8f.2
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 12:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744055253; x=1744660053; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=obGlZcEklCpCGyPWC2POGrVhuhWgesrahYF98WJhAQE=;
        b=M9dudo85f4q1G4HX1slV4IZtyqmeGHSUhRaAhFFGYX0phyGPW5qzdt2Yn2HJ8ebqFH
         Cx6MtY7nheD0RED3dyP2NR+aeJNGp6EsDiEmbidPaFbUpt0U5b5hJ7XtuJM6QeeoPdhP
         exi3soAmVAx4TviCvu2Ejp78QJPwX4E5ptDPwfR2R7zeV8C8Kz4v/llXnV+p0adwAvZ8
         HdrjxZBNLmLeK2Mhd4RIbMdVyx+mWsTX6+1undqRb2gg3pvJKcwQlBje8ktSvbsaAosU
         Xa3ZLCsRWB9+qRBqpmDQVHa5A6dkromDOdmB7wAQK3s2UBP4gMbDCta7a5v5Go21Vxsg
         wrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744055253; x=1744660053;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=obGlZcEklCpCGyPWC2POGrVhuhWgesrahYF98WJhAQE=;
        b=jKQf55s2C1sqzXeKtXK2fbMpgxCTwa5XSmZHj1Um/hDAGIAb1TfiVb75105xna8m7R
         y+RyoDPrM0t//3tmMw7tn4fIK17VyAJCl1+C4sdMFs+mztLF1dosCBzkDcXgfm8L9ESK
         TT3glpyqglPE0sqm0hrKj9vfu52AXqFkqebQMTp8xsgwTS128yMvrjbDtLbBU66wVR7O
         4CkmXl798ElJQ+dLmWjCDAZ4Jcau8Esee2DT8dP7RvrzB4IvJxocPVZfyD2d3SiJn6hL
         LCbp+9vhuYEiFPYlDq6KLAlBusVTB/9qKT8Tn39Y7S+ypnSJuI0vlAFKqJYITw1wuU52
         TlYQ==
X-Gm-Message-State: AOJu0YyIipjc6/yWNwAjaLkih6hk8O8V45zHqImxbbydX524ohH1j5gj
	YaMwFtPI2VbwQHnUOup+b8/XnfTgz88InrgGjFXOWeJ3J9Zbjnwualkau862nYkaxvWC4DL4U9D
	ZSmFF8OOVnNDcZZKams5T5QFnYjEeVpAVXaqOZ0muOhiQtYA=
X-Gm-Gg: ASbGncv2v/GWmZxMkrG9hkmpdM4ovm/6dek1lNiSCGauaZecGojpreBXDzkSjdrijWg
	F8Ftda3qusa/gplq6TpOKijHSB1Fw2q+GKGZ/l6L+fAEkXSVDwUkqj9ny4E5Vnu22QBeWe0dP+E
	R03mdPqUz2v2nOOFMQiulDqpDMOsxmwNsPWteL9pK3Y4mVNdXh7QtdrWwS7SGZHgPpTUciNu0DB
	IjGcoG0cKX795HO0OrNzBL4SQofqFEOEwKfnKJ7ivGxP7YTZyNVz4B7/6Qutu/062KyhV4qSo7e
	LSJjIUi6EgrzDES7LhPqk8j2znEtn7DBK5sI/vvWy1bpZFkMbDQp
X-Google-Smtp-Source: AGHT+IEE17ZqXd7s4EBwNiOAbjAZM7KA6DqNTqCSKVRXKB9gBNcXuFeSffEbb0po8j5ehYWjw5OAzw==
X-Received: by 2002:a05:6000:1a8d:b0:38f:2ffc:1e99 with SMTP id ffacd0b85a97d-39d6fd022b1mr6988889f8f.49.1744055252888;
        Mon, 07 Apr 2025 12:47:32 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:fb98:cd95:3ed6:f7c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec342a3dfsm141433545e9.4.2025.04.07.12.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 12:47:32 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 07 Apr 2025 21:46:25 +0200
Subject: [PATCH net-next v25 17/23] ovpn: add support for updating local or
 remote UDP endpoint
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-b4-ovpn-v25-17-a04eae86e016@openvpn.net>
References: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
In-Reply-To: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9204; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=SXG0lPHLCgEeqC7vHU1pLlERylwwih9HhOh9/5lf51c=;
 b=owGbwMvMwMHIXfDUaoHF1XbG02pJDOlftLe6mD0SjuHs6RSZZucl5s1V4225Mtf/v4H69dzo7
 bcNZhl2MhqzMDByMMiKKbLMXH0n58cVoSf34g/8gRnEygQyhYGLUwAmEqDJ/s9qwd6tUQuFnKaf
 M3KbcVVo3qEp5wrzwkNrQllCvsU93yhz56HQNdX4D3qeG+/zT+Evb9dYXDL3BUPHvdrIxXZG8zL
 K50wxYnuu+Eom4fL9HQuME5mEG8pOBKn5brm8asZmFQ5jd+8NoqmvVlg3tRu1+vBsFtgbOD18qe
 m7aLMyg9oJN6dm3Y1yUzib3v7/6EG/7VV9ScbBmTcKkpveVP9TnXqlJWZVa0dUca1kjpv933+Pz
 Zttb/41PuqVm/FjZRC/1eG3+ZGp6lV6bgslhTQtomesYPjzUMM2vE9VX1xp3dIHs08bhx1dGdL9
 7X2iezzLJIb8DXG7NMO+fEns1rDXDzlt+uqLy/3Ni8sqAA==
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

In case of UDP links, the local or remote endpoint used to communicate
with a given peer may change without a connection restart.

Add support for learning the new address in case of change.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c   |   8 ++
 drivers/net/ovpn/peer.c | 213 +++++++++++++++++++++++++++++++++++++++++++++---
 drivers/net/ovpn/peer.h |   2 +
 3 files changed, 210 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 680c7692b09b61247da3817c18d80ddfdc2814a4..07be4edf0dda060de2ce4161e323a2c2ee40591d 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -96,6 +96,7 @@ void ovpn_decrypt_post(void *data, int ret)
 	struct ovpn_crypto_key_slot *ks;
 	unsigned int payload_offset = 0;
 	struct sk_buff *skb = data;
+	struct ovpn_socket *sock;
 	struct ovpn_peer *peer;
 	__be16 proto;
 	__be32 *pid;
@@ -131,6 +132,13 @@ void ovpn_decrypt_post(void *data, int ret)
 	/* keep track of last received authenticated packet for keepalive */
 	WRITE_ONCE(peer->last_recv, ktime_get_real_seconds());
 
+	rcu_read_lock();
+	sock = rcu_dereference(peer->sock);
+	if (sock && sock->sock->sk->sk_protocol == IPPROTO_UDP)
+		/* check if this peer changed local or remote endpoint */
+		ovpn_peer_endpoints_update(peer, skb);
+	rcu_read_unlock();
+
 	/* point to encapsulated IP packet */
 	__skb_pull(skb, payload_offset);
 
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 45e87ac155b554044388490a403f64c777d283a6..0d8b12fd5de4cd6fe15455b435c7d6807203a825 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -127,6 +127,206 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id)
 	return peer;
 }
 
+/**
+ * ovpn_peer_reset_sockaddr - recreate binding for peer
+ * @peer: peer to recreate the binding for
+ * @ss: sockaddr to use as remote endpoint for the binding
+ * @local_ip: local IP for the binding
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+static int ovpn_peer_reset_sockaddr(struct ovpn_peer *peer,
+				    const struct sockaddr_storage *ss,
+				    const void *local_ip)
+{
+	struct ovpn_bind *bind;
+	size_t ip_len;
+
+	lockdep_assert_held(&peer->lock);
+
+	/* create new ovpn_bind object */
+	bind = ovpn_bind_from_sockaddr(ss);
+	if (IS_ERR(bind))
+		return PTR_ERR(bind);
+
+	if (ss->ss_family == AF_INET) {
+		ip_len = sizeof(struct in_addr);
+	} else if (ss->ss_family == AF_INET6) {
+		ip_len = sizeof(struct in6_addr);
+	} else {
+		net_dbg_ratelimited("%s: invalid family %u for remote endpoint for peer %u\n",
+				    netdev_name(peer->ovpn->dev),
+				    ss->ss_family, peer->id);
+		kfree(bind);
+		return -EINVAL;
+	}
+
+	memcpy(&bind->local, local_ip, ip_len);
+
+	/* set binding */
+	ovpn_bind_reset(peer, bind);
+
+	return 0;
+}
+
+/* variable name __tbl2 needs to be different from __tbl1
+ * in the macro below to avoid confusing clang
+ */
+#define ovpn_get_hash_slot(_tbl, _key, _key_len) ({	\
+	typeof(_tbl) *__tbl2 = &(_tbl);			\
+	jhash(_key, _key_len, 0) % HASH_SIZE(*__tbl2);	\
+})
+
+#define ovpn_get_hash_head(_tbl, _key, _key_len) ({		\
+	typeof(_tbl) *__tbl1 = &(_tbl);				\
+	&(*__tbl1)[ovpn_get_hash_slot(*__tbl1, _key, _key_len)];\
+})
+
+/**
+ * ovpn_peer_endpoints_update - update remote or local endpoint for peer
+ * @peer: peer to update the remote endpoint for
+ * @skb: incoming packet to retrieve the source/destination address from
+ */
+void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
+{
+	struct hlist_nulls_head *nhead;
+	struct sockaddr_storage ss;
+	struct sockaddr_in6 *sa6;
+	bool reset_cache = false;
+	struct sockaddr_in *sa;
+	struct ovpn_bind *bind;
+	const void *local_ip;
+	size_t salen = 0;
+
+	spin_lock_bh(&peer->lock);
+	bind = rcu_dereference_protected(peer->bind,
+					 lockdep_is_held(&peer->lock));
+	if (unlikely(!bind))
+		goto unlock;
+
+	switch (skb->protocol) {
+	case htons(ETH_P_IP):
+		/* float check */
+		if (unlikely(!ovpn_bind_skb_src_match(bind, skb))) {
+			/* unconditionally save local endpoint in case
+			 * of float, as it may have changed as well
+			 */
+			local_ip = &ip_hdr(skb)->daddr;
+			sa = (struct sockaddr_in *)&ss;
+			sa->sin_family = AF_INET;
+			sa->sin_addr.s_addr = ip_hdr(skb)->saddr;
+			sa->sin_port = udp_hdr(skb)->source;
+			salen = sizeof(*sa);
+			reset_cache = true;
+			break;
+		}
+
+		/* if no float happened, let's double check if the local endpoint
+		 * has changed
+		 */
+		if (unlikely(bind->local.ipv4.s_addr != ip_hdr(skb)->daddr)) {
+			net_dbg_ratelimited("%s: learning local IPv4 for peer %d (%pI4 -> %pI4)\n",
+					    netdev_name(peer->ovpn->dev),
+					    peer->id, &bind->local.ipv4.s_addr,
+					    &ip_hdr(skb)->daddr);
+			bind->local.ipv4.s_addr = ip_hdr(skb)->daddr;
+			reset_cache = true;
+		}
+		break;
+	case htons(ETH_P_IPV6):
+		/* float check */
+		if (unlikely(!ovpn_bind_skb_src_match(bind, skb))) {
+			/* unconditionally save local endpoint in case
+			 * of float, as it may have changed as well
+			 */
+			local_ip = &ipv6_hdr(skb)->daddr;
+			sa6 = (struct sockaddr_in6 *)&ss;
+			sa6->sin6_family = AF_INET6;
+			sa6->sin6_addr = ipv6_hdr(skb)->saddr;
+			sa6->sin6_port = udp_hdr(skb)->source;
+			sa6->sin6_scope_id = ipv6_iface_scope_id(&ipv6_hdr(skb)->saddr,
+								 skb->skb_iif);
+			salen = sizeof(*sa6);
+			reset_cache = true;
+			break;
+		}
+
+		/* if no float happened, let's double check if the local endpoint
+		 * has changed
+		 */
+		if (unlikely(!ipv6_addr_equal(&bind->local.ipv6,
+					      &ipv6_hdr(skb)->daddr))) {
+			net_dbg_ratelimited("%s: learning local IPv6 for peer %d (%pI6c -> %pI6c\n",
+					    netdev_name(peer->ovpn->dev),
+					    peer->id, &bind->local.ipv6,
+					    &ipv6_hdr(skb)->daddr);
+			bind->local.ipv6 = ipv6_hdr(skb)->daddr;
+			reset_cache = true;
+		}
+		break;
+	default:
+		goto unlock;
+	}
+
+	if (unlikely(reset_cache))
+		dst_cache_reset(&peer->dst_cache);
+
+	/* if the peer did not float, we can bail out now */
+	if (likely(!salen))
+		goto unlock;
+
+	if (unlikely(ovpn_peer_reset_sockaddr(peer,
+					      (struct sockaddr_storage *)&ss,
+					      local_ip) < 0))
+		goto unlock;
+
+	net_dbg_ratelimited("%s: peer %d floated to %pIScp",
+			    netdev_name(peer->ovpn->dev), peer->id, &ss);
+
+	spin_unlock_bh(&peer->lock);
+
+	/* rehashing is required only in MP mode as P2P has one peer
+	 * only and thus there is no hashtable
+	 */
+	if (peer->ovpn->mode == OVPN_MODE_MP) {
+		spin_lock_bh(&peer->ovpn->lock);
+		spin_lock_bh(&peer->lock);
+		bind = rcu_dereference_protected(peer->bind,
+						 lockdep_is_held(&peer->lock));
+		if (unlikely(!bind)) {
+			spin_unlock_bh(&peer->lock);
+			spin_unlock_bh(&peer->ovpn->lock);
+			return;
+		}
+
+		/* This function may be invoked concurrently, therefore another
+		 * float may have happened in parallel: perform rehashing
+		 * using the peer->bind->remote directly as key
+		 */
+
+		switch (bind->remote.in4.sin_family) {
+		case AF_INET:
+			salen = sizeof(*sa);
+			break;
+		case AF_INET6:
+			salen = sizeof(*sa6);
+			break;
+		}
+
+		/* remove old hashing */
+		hlist_nulls_del_init_rcu(&peer->hash_entry_transp_addr);
+		/* re-add with new transport address */
+		nhead = ovpn_get_hash_head(peer->ovpn->peers->by_transp_addr,
+					   &bind->remote, salen);
+		hlist_nulls_add_head_rcu(&peer->hash_entry_transp_addr, nhead);
+		spin_unlock_bh(&peer->lock);
+		spin_unlock_bh(&peer->ovpn->lock);
+	}
+	return;
+unlock:
+	spin_unlock_bh(&peer->lock);
+}
+
 /**
  * ovpn_peer_release_rcu - RCU callback performing last peer release steps
  * @head: RCU member of the ovpn_peer
@@ -230,19 +430,6 @@ static struct in6_addr ovpn_nexthop_from_skb6(struct sk_buff *skb)
 	return rt->rt6i_gateway;
 }
 
-/* variable name __tbl2 needs to be different from __tbl1
- * in the macro below to avoid confusing clang
- */
-#define ovpn_get_hash_slot(_tbl, _key, _key_len) ({	\
-	typeof(_tbl) *__tbl2 = &(_tbl);			\
-	jhash(_key, _key_len, 0) % HASH_SIZE(*__tbl2);	\
-})
-
-#define ovpn_get_hash_head(_tbl, _key, _key_len) ({		\
-	typeof(_tbl) *__tbl1 = &(_tbl);				\
-	&(*__tbl1)[ovpn_get_hash_slot(*__tbl1, _key, _key_len)];\
-})
-
 /**
  * ovpn_peer_get_by_vpn_addr4 - retrieve peer by its VPN IPv4 address
  * @ovpn: the openvpn instance to search
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index e747c4b210642db990222986a80bb37c9a0413fe..f1288734ff100ee76b0c41ebb6dc71725ea33261 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -153,4 +153,6 @@ bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
 void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout);
 void ovpn_peer_keepalive_work(struct work_struct *work);
 
+void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb);
+
 #endif /* _NET_OVPN_OVPNPEER_H_ */

-- 
2.49.0


