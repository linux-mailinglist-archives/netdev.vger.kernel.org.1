Return-Path: <netdev+bounces-106089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C1A9148BC
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 13:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEBD7B26836
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 11:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E969213CFB6;
	Mon, 24 Jun 2024 11:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="ffWgwZqF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E6113CF85
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228613; cv=none; b=HPFmRIEbZibZGgHqjXGP0osXsfDXDD9Wf/vsGthOukRO4ADzHZea6ks6KrRFBK83FEEfBdBeW451YHJkq21eb+SBwq8nF2qOdc8AONC8h6ja0+7xCAcB0eUEOUl1apE3ipdWkv5c51JwJQGHG3I2VAIyl+bPaDJF+t6Qu9PZM1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228613; c=relaxed/simple;
	bh=xc81K2lmUXEpKD/KrKHQ4nlc1ekuYpUVgOLKTDbaeMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SyVXQAR/9vg0DF691wu62cDWTQxaC7Rdxl5y9ZDg6evx7R5JP1P0V1INbj63evmtOYI8YUo9dsKo6PmYpL6w2vu80Gmk0XuneHEcFTU4RxVDkwzSo6CfIbXfYP9c8SeXjlq5WqsVmy0ogDBn7ZEgIohV7rEM0BNvtgDCaqutQeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=ffWgwZqF; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-363bd55bcc2so3428050f8f.2
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 04:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1719228610; x=1719833410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIv4APhH6PcooNcWBlf7Aj2peMGNdlwMM8fYS58ckj0=;
        b=ffWgwZqFxryxOQwPdjtxKubUYaujPra4u51Hslu/mTCUeubjixqSZt7YYW1ej8t6O8
         ImP+2FhGvnu55Jpw+FCjKB9NscGPJP7d5+vS2+x02UuSlxCmCGfHcSWOuKC3aM884ibg
         xefJClCF33upMnGg2Q4Rv2K+sODwSHd+UW5wklPL4t434gPLDb6Vb7F2RwPPZmfbB8a1
         WGbLhKqHkrBE7SXf3HM/9U4WQyN/AVV9f6lBlV+7QkwHwq5iccqni5UgE34JBz0a832c
         8pevwsgVbjq6r+2u+0HtYEBRUmxNRZEKrgQgZnhuZj83YuWLsUN/bEyIrziZ16409PHQ
         8kLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719228610; x=1719833410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIv4APhH6PcooNcWBlf7Aj2peMGNdlwMM8fYS58ckj0=;
        b=Q3QzBaNAWSIVna3HNwrm/1/u1Lknmh5FAU78TDV45yaDzbyy5TUOkNiQh0lN5eb769
         UEGKLhiWtrMowBLeLCvKKwx4Srrvy+Cv8tUzvEXkC8hDIAmradz8pRF+lYIKm7QmKdBZ
         nygJv1/n03My81B24a6C/wdydnq6sgbdtKzRDA5vrknYXOPWw0Xk+Ll2Derx5BJoR2ay
         6anAU5YHV1MO82Iv5lJnr4M/jdxw9h0QfynT/ESK8ZeSg62wRGkws0GzvmqF2ezOWoKb
         8XoDamdm4gY3GREx0ATlnGAmcy42xc56Ii3g3/kk1dTSbVMafX/RLyp55i+3EFb0NdKR
         Otew==
X-Gm-Message-State: AOJu0Yzw0FvfiZA7dfkTf2Auv0nnkN3YRAYNbqL8hcgJ4BzorXwNll57
	LxBBlhnDxbgR4s9UlZ4Q4BFO1t+55k4YXPm/5HCCWwHP/U0cX0WlNFlGhCYoqpweNJcqJfnemBx
	o
X-Google-Smtp-Source: AGHT+IFjncQc+NNqf1mwlqiLpN+ERgt9o+EoE5kzG04LAUCMhvb+er/VY40EOmFLxHzVkwJAdigdhg==
X-Received: by 2002:a05:6000:144b:b0:366:f8e7:d898 with SMTP id ffacd0b85a97d-366f8e7d95dmr1020994f8f.50.1719228609964;
        Mon, 24 Jun 2024 04:30:09 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:2317:eae2:ae3c:f110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c7c79sm9794397f8f.96.2024.06.24.04.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 04:30:09 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	ryazanov.s.a@gmail.com,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v4 19/25] ovpn: add support for peer floating
Date: Mon, 24 Jun 2024 13:31:16 +0200
Message-ID: <20240624113122.12732-20-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240624113122.12732-1-antonio@openvpn.net>
References: <20240624113122.12732-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A peer connected via UDP may change its IP address without reconnecting
(float).

Add support for detecting and updating the new peer IP/port in case of
floating.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c   |   4 ++
 drivers/net/ovpn/peer.c | 114 ++++++++++++++++++++++++++++++++++++++--
 drivers/net/ovpn/peer.h |   2 +
 3 files changed, 117 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 9188afe0f47e..4c6a50f3f0d0 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -120,6 +120,10 @@ void ovpn_decrypt_post(struct sk_buff *skb, int ret)
 	ovpn_peer_keepalive_recv_reset(peer);
 
 	if (peer->sock->sock->sk->sk_protocol == IPPROTO_UDP) {
+		/* check if this peer changed it's IP address and update
+		 * state
+		 */
+		ovpn_peer_float(peer, skb);
 		/* update source endpoint for this peer */
 		ovpn_peer_update_local_endpoint(peer, skb);
 	}
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index ec3064438753..c07d148c52b4 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -126,6 +126,117 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
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
+				    const u8 *local_ip)
+{
+	struct ovpn_bind *bind;
+	size_t ip_len;
+
+	/* create new ovpn_bind object */
+	bind = ovpn_bind_from_sockaddr(ss);
+	if (IS_ERR(bind))
+		return PTR_ERR(bind);
+
+	if (local_ip) {
+		if (ss->ss_family == AF_INET) {
+			ip_len = sizeof(struct in_addr);
+		} else if (ss->ss_family == AF_INET6) {
+			ip_len = sizeof(struct in6_addr);
+		} else {
+			netdev_dbg(peer->ovpn->dev, "%s: invalid family for remote endpoint\n",
+				   __func__);
+			kfree(bind);
+			return -EINVAL;
+		}
+
+		memcpy(&bind->local, local_ip, ip_len);
+	}
+
+	/* set binding */
+	ovpn_bind_reset(peer, bind);
+
+	return 0;
+}
+
+#define ovpn_get_hash_head(_tbl, _key, _key_len)		\
+	(&(_tbl)[jhash(_key, _key_len, 0) % HASH_SIZE(_tbl)])	\
+
+/**
+ * ovpn_peer_float - update remote endpoint for peer
+ * @peer: peer to update the remote endpoint for
+ * @skb: incoming packet to retrieve the source address (remote) from
+ */
+void ovpn_peer_float(struct ovpn_peer *peer, struct sk_buff *skb)
+{
+	struct sockaddr_storage ss;
+	const u8 *local_ip = NULL;
+	struct sockaddr_in6 *sa6;
+	struct sockaddr_in *sa;
+	struct ovpn_bind *bind;
+	sa_family_t family;
+	size_t salen;
+
+	rcu_read_lock();
+	bind = rcu_dereference(peer->bind);
+	if (unlikely(!bind))
+		goto unlock;
+
+	if (likely(ovpn_bind_skb_src_match(bind, skb)))
+		goto unlock;
+
+	family = skb_protocol_to_family(skb);
+
+	if (bind->sa.in4.sin_family == family)
+		local_ip = (u8 *)&bind->local;
+
+	switch (family) {
+	case AF_INET:
+		sa = (struct sockaddr_in *)&ss;
+		sa->sin_family = AF_INET;
+		sa->sin_addr.s_addr = ip_hdr(skb)->saddr;
+		sa->sin_port = udp_hdr(skb)->source;
+		salen = sizeof(*sa);
+		break;
+	case AF_INET6:
+		sa6 = (struct sockaddr_in6 *)&ss;
+		sa6->sin6_family = AF_INET6;
+		sa6->sin6_addr = ipv6_hdr(skb)->saddr;
+		sa6->sin6_port = udp_hdr(skb)->source;
+		sa6->sin6_scope_id = ipv6_iface_scope_id(&ipv6_hdr(skb)->saddr,
+							 skb->skb_iif);
+		salen = sizeof(*sa6);
+		break;
+	default:
+		goto unlock;
+	}
+
+	netdev_dbg(peer->ovpn->dev, "%s: peer %d floated to %pIScp", __func__,
+		   peer->id, &ss);
+	ovpn_peer_reset_sockaddr(peer, (struct sockaddr_storage *)&ss,
+				 local_ip);
+
+	spin_lock_bh(&peer->ovpn->peers->lock);
+	/* remove old hashing */
+	hlist_del_init_rcu(&peer->hash_entry_transp_addr);
+	/* re-add with new transport address */
+	hlist_add_head_rcu(&peer->hash_entry_transp_addr,
+			   ovpn_get_hash_head(peer->ovpn->peers->by_transp_addr,
+					      &ss, salen));
+	spin_unlock_bh(&peer->ovpn->peers->lock);
+
+unlock:
+	rcu_read_unlock();
+}
+
 /**
  * ovpn_peer_timer_delete_all - killall keepalive timers
  * @peer: peer for which timers should be killed
@@ -231,9 +342,6 @@ static struct in6_addr ovpn_nexthop_from_skb6(struct sk_buff *skb)
 	return rt->rt6i_gateway;
 }
 
-#define ovpn_get_hash_head(_tbl, _key, _key_len)		\
-	(&(_tbl)[jhash(_key, _key_len, 0) % HASH_SIZE(_tbl)])	\
-
 /**
  * ovpn_peer_get_by_vpn_addr4 - retrieve peer by its VPN IPv4 address
  * @ovpn: the openvpn instance to search
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 1f12ba141d80..691cf20bd870 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -192,4 +192,6 @@ void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout);
 void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer,
 				     struct sk_buff *skb);
 
+void ovpn_peer_float(struct ovpn_peer *peer, struct sk_buff *skb);
+
 #endif /* _NET_OVPN_OVPNPEER_H_ */
-- 
2.44.2


