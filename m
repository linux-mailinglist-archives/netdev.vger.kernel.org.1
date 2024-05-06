Return-Path: <netdev+bounces-93574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F4F8BC559
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 03:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABEB0282279
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 01:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4EF48CCD;
	Mon,  6 May 2024 01:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="L7KJnOw3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B83481AC
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 01:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714958158; cv=none; b=R/S0MKvZ5wW3iWbaT42NcTDG1w4qLJx2tsescmFvEZo1a6xcDh2f6lgRF8Pdybzlbl8xapuuNsvQkG4NYTvTxjqdbxjIIGp4Q+kHHyZhBo64YH5oiPNksLut9FN9CGkhIx/gDI5OhJESCUO8GepiEGS0R7YWeEw09mh1cTYNUDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714958158; c=relaxed/simple;
	bh=F2sy15odYTCLMf10eUZHp+mmhcjZ06a4tALFeo4jwJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibkiKhfEuGPS9ymRirdcEnG+HNYb+gOTu46N7x5gVFg2l/94xgJ/gUcaMox0aHpay8tZSuLYVe/7VNvQ7VJK3VCtYZyFXXYatee0N/Ya+D6TKShY6whkutDyoFGwzqkAlV3UeQzmWE3in8R+JKMfhn138XdciVpeIclGwWwsxjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=L7KJnOw3; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41e82b78387so8777085e9.0
        for <netdev@vger.kernel.org>; Sun, 05 May 2024 18:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1714958155; x=1715562955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/ybIXctpv5gt/mqtPLi4Y7gd9j4LzKMFCEukiVlwiE=;
        b=L7KJnOw3/BQoEjxwCt0uU2YO13TklYwnLmFGKweBT34wb2m+KaCU57Wai45qvM5vvL
         SDy9IpjVO8xAie/P7fomvueNdDTmE94bWWLEoS6SFV3K0gQgizBSfTVhuopMldX1uM/8
         nQHA3POFJW740Sl02DyasdcCiVff7L7xCGt1fhumIUJ4dYWmIjMotO2oFImOf65c2HXc
         CzBJ+XEpmv8aEYonHXW4KkselS8fjswlIiLyShlBpZ9E3AkUBY5is+GRC0ae2tU9Qmjf
         Nal9B/9zFYWa3POGvFT+QiOy2sG8lSeQ8DTijxsIGcV3Wr/TJUUa5k2BCcN4MJCY3nfH
         b4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714958155; x=1715562955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/ybIXctpv5gt/mqtPLi4Y7gd9j4LzKMFCEukiVlwiE=;
        b=BoKce9x+HE6kfBDx1m32qvF4F6eM+voYKLxIHYJ90+7W1oHXIiluGyJygBpNWOLiGA
         ikRYnCIo2fyjIxJp36gUgt/ak8qxzij9WuXc0ZtvknNV9xpApx3CMATqT/GTusrlNW2I
         +4pdgAIYgHyQapac4owWPdbfIb61cMxqrxzUcNEWZ4CHeMemUfMjozrFnfSlgcT3hLJm
         bNj5zoZYmLdZ/uRnTNSQvTNvMkobfLBSG67oEnAJXf7BKtfOr74zn50HqZ6IUsNVJRsf
         nZWx/EO5TeyQwc0zgUcYZUq+HONAVivgs9DkSsim5dCjU7lMqjCZdqS+w8oWPpGOsQzx
         PBMQ==
X-Gm-Message-State: AOJu0YwOGIfCT7liurKABQu2413wzj0CwKnMsUJjXR0iIiWnrVjO6FQf
	fMXYRi52RJp7aVUVymrWGfUQ0Gbl0JS7pBWA8wOHxBOxFAnZ+V8ZT0d/YJJAevPHHoJN6Ku9LyA
	e
X-Google-Smtp-Source: AGHT+IFI7VMWiCDsB3vb8RFpPHQpXNSk/3qkCIax/up+jDZgPAFWBJMLOxXaMsnvXbqQ1YODc2kFDA==
X-Received: by 2002:a5d:50c2:0:b0:34c:7aa6:7121 with SMTP id f2-20020a5d50c2000000b0034c7aa67121mr5187040wrt.17.1714958155137;
        Sun, 05 May 2024 18:15:55 -0700 (PDT)
Received: from serenity.homelan.mandelbit.com ([2001:67c:2fbc:0:fbf:f0c4:769e:3936])
        by smtp.gmail.com with ESMTPSA id n8-20020adffe08000000b0034df2d0bd71sm9363621wrr.12.2024.05.05.18.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 18:15:54 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Esben Haabendal <esben@geanix.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v3 18/24] ovpn: add support for peer floating
Date: Mon,  6 May 2024 03:16:31 +0200
Message-ID: <20240506011637.27272-19-antonio@openvpn.net>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240506011637.27272-1-antonio@openvpn.net>
References: <20240506011637.27272-1-antonio@openvpn.net>
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
 drivers/net/ovpn/peer.c | 96 +++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/peer.h |  8 ++++
 drivers/net/ovpn/udp.c  |  5 +++
 3 files changed, 109 insertions(+)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index e88c2483450d..e1eee1bb1ad2 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -151,9 +151,105 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
 	return ERR_PTR(ret);
 }
 
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
 #define ovpn_peer_index(_tbl, _key, _key_len)		\
 	(jhash(_key, _key_len, 0) % HASH_SIZE(_tbl))	\
 
+void ovpn_peer_float(struct ovpn_peer *peer, struct sk_buff *skb)
+{
+	struct sockaddr_storage ss;
+	const u8 *local_ip = NULL;
+	struct sockaddr_in6 *sa6;
+	struct sockaddr_in *sa;
+	struct ovpn_bind *bind;
+	sa_family_t family;
+	size_t salen;
+	u32 index;
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
+	spin_lock_bh(&peer->ovpn->peers.lock);
+	/* remove old hashing */
+	hlist_del_init_rcu(&peer->hash_entry_transp_addr);
+	/* re-add with new transport address */
+	index = ovpn_peer_index(peer->ovpn->peers.by_transp_addr, &ss, salen);
+	hlist_add_head_rcu(&peer->hash_entry_transp_addr,
+			   &peer->ovpn->peers.by_transp_addr[index]);
+	spin_unlock_bh(&peer->ovpn->peers.lock);
+
+unlock:
+	rcu_read_unlock();
+}
+
 /**
  * ovpn_peer_timer_delete_all - killall keepalive timers
  * @peer: peer for which timers should be killed
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index df2b1c93dead..5ea35ccc2824 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -280,4 +280,12 @@ void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout);
  */
 void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer,
 				     struct sk_buff *skb);
+
+/**
+ * ovpn_peer_float - update remote endpoint for peer
+ * @peer: peer to update the remote endpoint for
+ * @skb: incoming packet to retrieve the source address (remote) from
+ */
+void ovpn_peer_float(struct ovpn_peer *peer, struct sk_buff *skb);
+
 #endif /* _NET_OVPN_OVPNPEER_H_ */
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index c2a88d26defd..151c27da7e6f 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -84,6 +84,11 @@ static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 					    __func__, peer_id);
 			goto drop;
 		}
+
+		/* check if this peer changed it's IP address and update
+		 * state
+		 */
+		ovpn_peer_float(peer, skb);
 	}
 
 	if (!peer) {
-- 
2.43.2


