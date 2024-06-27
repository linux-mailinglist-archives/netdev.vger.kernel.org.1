Return-Path: <netdev+bounces-107279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A09B91A75D
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E3C61F21666
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 13:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890CD187550;
	Thu, 27 Jun 2024 13:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="edAPVV4a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B92518C327
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 13:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719493699; cv=none; b=KnxhcHjMf2Ps40km6+BXgEtDSlgSvxjd1QPKLEYLNNwYwlJxtOc3lW1AQ0+bW4LGE3NukewtDcltNbi8FJ8ETPdKfqrQvHWKxpITz0QUjkPiWfp1x67WjRoSr9iRNNteMXiuAUgl3CLJZxc0xJuaQLPPIXfOuCDQNpWeEwpZsdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719493699; c=relaxed/simple;
	bh=xc81K2lmUXEpKD/KrKHQ4nlc1ekuYpUVgOLKTDbaeMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qq11GFC1EYK6Ah1mpM+/wk3Z+OuKeczBSzzPsfSjy2X5ZIMOHTvEWoAF9F1Jau/dtl0f54MBVvgoO1WIfR01W8fnvrLJFlXx9gR6lG/EAUKy5lqM4gNQao49Xriiu97a2aiYlW/VKC/N3vexLA8WVt46YsmOQf+16XIdvjEFKFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=edAPVV4a; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ebeefb9a7fso96852631fa.0
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 06:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1719493695; x=1720098495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIv4APhH6PcooNcWBlf7Aj2peMGNdlwMM8fYS58ckj0=;
        b=edAPVV4a0+XvAlSJ38q+cQimD2UpSiaoTUzOsoeLeRNDKAg+lFrit2vv5zENZMCTrR
         531fMiOT/KmlgTcKnDKScWVXnYoZboJRQY54hLkzNfNyio+/TLOCQgYUNekXvuJ4r+7H
         yoieWZtQt1vMh3MqjoJpGlMDkJv6JoRlCRHZlDv20w4fkYvs/QMc3Re9celVVA1/aXky
         bPMxQ/Rzy3JsORZSRxsJQyOI89odJ3ObmHKDsTUhx7HjExqUNtqYxBg3NuioPiho0diZ
         z2FR4fN+1j3yI7rmx8A09bgycDBar7BpAUITQBLgC+Zqc+q3y0VCUp56IzWw8rM9sS75
         wr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719493695; x=1720098495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIv4APhH6PcooNcWBlf7Aj2peMGNdlwMM8fYS58ckj0=;
        b=IloxFk4BtgFMFT8Npg1DTFxIrobiLhIXgiz2u4axKSNrI6A8Hb7T5l4LYNyTwZ95Vi
         vYOL9cWj/LP5Yd7pw8abY3P7UakU2gK69lxnlv396ph6sF2pzGDUpnOx7f42N7WCkdNp
         mTiU3xrWwR8TCjGuBIgDbba5dsiYUIxagVH2gsVZ0Zv5wWKjK8yNsjdQpjrNYwIhsvXV
         Ji2aOuskA0zLoypkR5FGm+Q0FdhftXG87WWSOao99CHaVg5MKBsLivevt87ArcYd55r1
         EF92+EQgKZ/Wj++yLLZLp73aWhLmm+pKuVl/3g9NApcmG4hWyKS1k85670rAL5EylKGn
         rmHA==
X-Gm-Message-State: AOJu0Yx5pgLWTSLEikeC3+JK8FYVstE47zKXgjse5/SJWdGe0gwqz35w
	7nDTeeznCpm9rs1nHKyGofmGDVsLz3VFfVIwH7pcqVrSVRmRyTRA7tUsSIOwYGZIS5PnRV4y7qr
	h
X-Google-Smtp-Source: AGHT+IFYv7hxLoIws5dL54N/O3adMwDNBzyvHm6uSPTtGdg2xbn/2lsivA1ZjmVqOCQeo3SDS91K2g==
X-Received: by 2002:a2e:3e0e:0:b0:2ec:54fb:c833 with SMTP id 38308e7fff4ca-2ec5797b042mr96672741fa.21.1719493695226;
        Thu, 27 Jun 2024 06:08:15 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:2bde:13c8:7797:f38a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42564b6583asm26177475e9.15.2024.06.27.06.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 06:08:14 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	ryazanov.s.a@gmail.com,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v5 19/25] ovpn: add support for peer floating
Date: Thu, 27 Jun 2024 15:08:37 +0200
Message-ID: <20240627130843.21042-20-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240627130843.21042-1-antonio@openvpn.net>
References: <20240627130843.21042-1-antonio@openvpn.net>
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


