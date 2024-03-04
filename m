Return-Path: <netdev+bounces-77144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 253EC8704EB
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 16:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913481F22FCB
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 15:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B784CB47;
	Mon,  4 Mar 2024 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="ME24iNtf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD584CB4A
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 15:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564964; cv=none; b=m354dULCJ/L8mp8Zw1NJbjf/dXucIoUQDp/ye0mQiY80BiTjvrAxATKe6yqI3kAhPM7R+nfa4YV6+94nMpfCrcxEGhl3vjEsqco+xOoQJ4wb/Vuu5dKpg5WGllMigohkjO3ouzJjOMEEt7NsOACAmLPcz5mvwLE1k9ntSdmPx+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564964; c=relaxed/simple;
	bh=+IWisMS4R/LaHnCtyoDMpWqVl9rd3porFMmNwDqmtcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=auymwV0lZEdCQ32fzgPkkkBsA+9EcelN66JkqzqIHJMWNXst1yDig2XUi5SyU5n1OWiGfoIFhTYUlNxS0Q4dGakms5iMi4lwHrqIZMsF+qHtj8QcmhCDz5V5vFeqFCBIAhHjMXFXKdvzYFXeZesMD719MZ0/1h5OBGB7YaEfMNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=ME24iNtf; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a456ab934eeso114170166b.0
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 07:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709564960; x=1710169760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTZKGrT0x/0loG4DpYfzahf4ReP49tkX9nc3kK9SrjI=;
        b=ME24iNtfnIdhYsLmHBGnHflVYfVvK0PIxi8i/fXWJlxbmrz4yaoDqMz00PrIDPBpl5
         K9DWj9j3q+KkK6U5uLi6/IHlaNPHZ+VMzvHH/f0S6Li2Ucg4l+xug6fMNzuvKXgg8G7Y
         uKrVuDdrhHx4YJuMS/yfaJPrsSLH7SI1AOPr4KbocdMGfnLNPo8u4IBhpC4Uz3ObFLad
         6w76g9cST0fwqgMEobEm1ANP27aV20Mx6lmo1+GQlXdn5HuER05zfdCqxW1c/vBtkp77
         Y6f1KmQbEd+l31Zbnk1lOfzt2XDQLJv+WnFaNZoDtOwK0NortHlC6Mspxh9Wkk29WhYe
         ySFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709564960; x=1710169760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fTZKGrT0x/0loG4DpYfzahf4ReP49tkX9nc3kK9SrjI=;
        b=lW27sVmCi8uLY+LCqL2dgM2GYcZbFtYNAPqwHx/iCxUuKc5/skISvGgtfDRkJaNwcx
         DL4rHl9wYCydXg+Wd2yMNQ67dT+xxq+qq3qeOsFYBPXjJL3LeRW9NPuXfH+C13mSgkyT
         viSSIX79MESaKICZlQtVbXlH1gAAo978h1wicdPCThf62TepuhYAUQ21ZC+zJnZ9Qiem
         Q0Lh17pfe57zJZ7LwTHLKjGz8gCpiULF/F/xpKMq52ZII4/UgyUVQ/qk1tz7nAG4XInI
         HzYkE8jdtZ1HxbLFYsZ28j6unkDJn64bkSf6u8SfbdyDMnmf562Gg+5ZB/j3Oswi4ob6
         5vNA==
X-Gm-Message-State: AOJu0YzqOzjNTqIjKdzgkB865wKtJlx5LIcoeythhBAnCnGbrDxI0TB9
	cWadtbHMM8NNFpltfwL3c9G2WlYXfR+LxD3AbcqEtxD5NXyaC0+qhWT50RrfYoWtA6n+eBEv5Lz
	c
X-Google-Smtp-Source: AGHT+IGBurb7soUEMVdMrLm1LNK/MRM4Xj941r/mfWljCCLPYrTMmrSYkPFrzxIzsDu5+e9NOoaaZg==
X-Received: by 2002:a17:906:f194:b0:a3e:9231:fe7e with SMTP id gs20-20020a170906f19400b00a3e9231fe7emr6724985ejb.71.1709564960377;
        Mon, 04 Mar 2024 07:09:20 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:1d25:beac:2343:34ef])
        by smtp.gmail.com with ESMTPSA id um9-20020a170906cf8900b00a44d01aff81sm2904069ejb.97.2024.03.04.07.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 07:09:20 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v2 17/22] ovpn: add support for peer floating
Date: Mon,  4 Mar 2024 16:09:08 +0100
Message-ID: <20240304150914.11444-18-antonio@openvpn.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304150914.11444-1-antonio@openvpn.net>
References: <20240304150914.11444-1-antonio@openvpn.net>
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
 drivers/net/ovpn/peer.c | 92 +++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/peer.h |  1 +
 drivers/net/ovpn/udp.c  |  3 ++
 3 files changed, 96 insertions(+)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 1fcced805399..ca5cce0a0cda 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -139,9 +139,101 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
 	return ERR_PTR(ret);
 }
 
+int ovpn_peer_reset_sockaddr(struct ovpn_peer *peer, const struct sockaddr_storage *ss,
+			     const u8 *local_ip)
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
+		sa6->sin6_scope_id = ipv6_iface_scope_id(&ipv6_hdr(skb)->saddr, skb->skb_iif);
+		salen = sizeof(*sa6);
+		break;
+	default:
+		goto unlock;
+	}
+
+	netdev_dbg(peer->ovpn->dev, "%s: peer %d floated to %pIScp", __func__, peer->id, &ss);
+	ovpn_peer_reset_sockaddr(peer, (struct sockaddr_storage *)&ss, local_ip);
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
 static void ovpn_peer_timer_delete_all(struct ovpn_peer *peer)
 {
 	del_timer_sync(&peer->keepalive_xmit);
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 739560fc992a..c0bcb3a86ecf 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -166,6 +166,7 @@ struct ovpn_peer *ovpn_peer_lookup_by_src(struct ovpn_struct *ovpn, struct sk_bu
 struct ovpn_peer *ovpn_peer_lookup_id(struct ovpn_struct *ovpn, u32 peer_id);
 
 void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer, struct sk_buff *skb);
+void ovpn_peer_float(struct ovpn_peer *peer, struct sk_buff *skb);
 
 int ovpn_peer_reset_sockaddr(struct ovpn_peer *peer, const struct sockaddr_storage *ss,
 			     const u8 *local_ip);
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index addcf55abf26..693f1f6a2c0c 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -81,6 +81,9 @@ static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 					   __func__, peer_id);
 			goto drop;
 		}
+
+		/* check if this peer changed it's IP address and update state */
+		ovpn_peer_float(peer, skb);
 	}
 
 	if (!peer) {
-- 
2.43.0


