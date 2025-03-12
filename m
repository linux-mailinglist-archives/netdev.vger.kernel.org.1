Return-Path: <netdev+bounces-174366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EC2A5E5DA
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 21:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F284E17C437
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 20:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6B11EFF82;
	Wed, 12 Mar 2025 20:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="UANyCwD0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F031F4265
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 20:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741812893; cv=none; b=MPh1c+ToQiNtxt1FBAPlv4Kt2UOJeOFDud1iWAp2bt/weejLcg4MfItLBxp45uqd4Jy8kg6QoBMu6q+zsahXbdzxhGJjfUisBIRqe43tsDoCZdfnN6tGwnP1cOYNq2mwsHts4spjxqAiTtgYR9CSTgijuTP8MTgSKaMbn4ciQMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741812893; c=relaxed/simple;
	bh=hWDVMOTtTG8kzSL7EXcquGSgf8JSTQqIzV4s/5vY758=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bs5WO3tufVXHKb6S/7BeoTv9UKJQ5R3Y2KqAZdKkOxGIEAX+SbUd+T2xY+iR2+gCcBdHSc+rWBWBpJ98NfIrbSBeNXzfqtI3QlHl46ut2z+7RLMC14AOaN9KMZeQ8Cfqgz0cMxHxsbeg8v7I1PVYbXleTnu4fCeRuvWKU5Qnbus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=UANyCwD0; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3913958ebf2so204841f8f.3
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 13:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741812888; x=1742417688; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/SdaijiYImbVHQ86OLZGBo8ZqPFKIkT8IkG7Vksf3us=;
        b=UANyCwD0CJQXLWt9V3E6a5Ef8MAX5h+A5HqlxRuDGuTW4Qjqg3YlfWrfu0ah079enV
         SD+y/TCt8Gy6Ni9DLb0Yx9cCVC+17yAejuabfxiVGSi17djgkaSOthugSzbjOOUliZ0m
         Jkm6LYtZzX+Q3+uBt+SbkmYqOMM8UIIfteVOTJMvJhPC1ZrTWCoYr35WHINareJ8wrZt
         +Wpld7cuAoPSokbtERrIo9PZQXnzX/948sUlXwkyevGvaZnz+ti9IJymhtErtOrRbh7j
         qK5xigBKG8A2UQ58xkeAuNry9EyWaWmT8smxXEvzcKm3BfTaWq4apOu92SvUgnk41o3k
         p9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741812888; x=1742417688;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/SdaijiYImbVHQ86OLZGBo8ZqPFKIkT8IkG7Vksf3us=;
        b=dEtsdCuq6mccrGwwY8FG04xgxogDCjZuj6MMAz+qfmUgxSKZ3y9odt3W20+3fmGHL+
         rB3TjjlHQNBMGkmCZcLlSByK0Kq13FEr6RtqMFdXuxA9VuBrvygeM07XU6O7RaOaR6ih
         IblXp7vlf4CXFwAK+wp7AsWfqpOy82EMLY7u5FWBRSOqVfbzsbn80XmpSPNdS3k2jU8b
         oyWsdIYtueORDJTzwaiCLMCTupsH2XE1dyX/8AGh2zv0fJ12CX2i3ImYLBFP3WEyNqZt
         9VAazM//lZGIkPDQaXFKxtm4YlB7ou7D6UXSn7POjd3dW2Vo4xIiURDM+tSxXa1m2vV8
         qofA==
X-Gm-Message-State: AOJu0YylT/U4G2WRGxCAElYXykzf3O0rRFHIrPzZ7DPhhi+itNa0y7WQ
	27FFrn6RkWBOf1gswnQmkNXhpxHUPb5uSwTqJu1tFmAqAy+ZoolsxLinMiBPQA0=
X-Gm-Gg: ASbGncuEBFEJb/TvmRusPoiAFj6fQQsB1WYNRtulCGHodQ4AyLMSeJpcLr6Qoo3HOIc
	9EcwVX2PHTITymAKUXbKse6tlHb8gUTXt4ewIwC9Cg24qoPNv66etGFI10qmc1FSEMjxq/sB2ah
	eUs3NSpFKtueNYELC4O1XGCk5v5rm0OhgpSzbqlCC/ivM4vsMchKfYsUZHmUpsnI5S5eNz7vOxo
	qnwyTeOsvXeyiGxb/mNRXmzHGCzrwyqkTWq5L4ClVVPWVUziPpf56qYSLJXRj20Gkavrb7JSsjy
	fu/f76rb+3cG10COhUrrDnihf4Qq+CIT0Siu9Pwd0Q==
X-Google-Smtp-Source: AGHT+IEIjZBrZLR7o1/5Uo8t96QaHtKgyrWfAk/pZSQ9bv2baUEbjrJwvtnWBw51zKuBZemh3TG56g==
X-Received: by 2002:a05:6000:4022:b0:391:31c8:ba59 with SMTP id ffacd0b85a97d-39263ceba19mr7016928f8f.4.1741812887676;
        Wed, 12 Mar 2025 13:54:47 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:a42b:bae6:6f7d:117f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c10437dsm22481393f8f.99.2025.03.12.13.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 13:54:46 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 12 Mar 2025 21:54:26 +0100
Subject: [PATCH net-next v23 17/23] ovpn: add support for updating local or
 remote UDP endpoint
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-b4-ovpn-v23-17-76066bc0a30c@openvpn.net>
References: <20250312-b4-ovpn-v23-0-76066bc0a30c@openvpn.net>
In-Reply-To: <20250312-b4-ovpn-v23-0-76066bc0a30c@openvpn.net>
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
 h=from:subject:message-id; bh=hWDVMOTtTG8kzSL7EXcquGSgf8JSTQqIzV4s/5vY758=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn0fR82Y6OxHi/b7+1T1nbDp6LDACe2q3IY1KYs
 IDKEGto77eJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ9H0fAAKCRALcOU6oDjV
 h4QgCACsGdqWUzZAYxkOv/iYkEhm8k69MxTQxOdJWKRe93ZcMLL+d7UcxkVmBkd5pgE2LIyO4DR
 PAJLo3CgcJRxPIGYXPii0Tk23y9FSM7qgRiNNlnIEhilK3w+3gDt8V8PeK8pAuMvy2D7ec37Fhv
 AGnqTrzntA+mUWElrVjy3ptEY4CWjhr/43xYV9iYSvzmsXDdrPRr1SI3sHCM/Y8s8TsGqzwZJNH
 ENm6Ey/sANukEDyvqS2WL9dzAUilIymeo0P0G4ni8VO3F6K91NO0RS/nUCRWlS6dP6lk+Gmy/Fn
 5MeZC4RUegDPtWqiQNNEvgtOLzrdCcAMM8R0/lln4g27eVDM
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
index 6ee1a40082ef637285d7f7f8183c53140583b716..5b673eae255033b9d7d6e7890a46686403d7c222 100644
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
@@ -137,6 +138,13 @@ void ovpn_decrypt_post(void *data, int ret)
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
2.48.1


