Return-Path: <netdev+bounces-77143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDF68704EA
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 16:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 433F41C22563
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 15:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370CD4CDFB;
	Mon,  4 Mar 2024 15:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="WoIyjpFB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2097D4CB23
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 15:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564963; cv=none; b=pmKPQEMs/+/PYROcJhGlR5ypuQ0eKpYqssypcsoi7Uh3IoHRctr+7f91MUFWhAxqZMQ8MwzUjQtmw2ZY5zzevyBqlw2dEC6yancVxeScct6IqFK8VcBEU5GHq3IHwVZ3AkE947Rwt5YZTy7mawvffNWIwcFA9+DIXOTJMPAL7Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564963; c=relaxed/simple;
	bh=30pVzWtpExOgPCOdzu6jDnotqzCbLT/URqVln2w15lU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PifX2mzB9mWxFHoOuk4qGxTRdd+EjfGzqvXwqff61/TSZo1KFoKhAmw7qvx68T5KomuXuR4k6yqmPwLR3sKDNQlnKdFDM9QT+OLA0IeF8c9GusnohHRdXmeQ/WtWDmLdkOOz6kfukMkxgbysTkv3UMgSQRFQ08KuBkAutwrwoWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=WoIyjpFB; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a28a6cef709so752555266b.1
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 07:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709564959; x=1710169759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTbnfUF0t3xkBManGvXEIwZL+6aN7DMDPePR3e3LFZM=;
        b=WoIyjpFBJHXM0EjlYjQMYpblXSPV0cXz9dnUojI8XQh2LZb2jV8n0Ea1XxVTA0BZCN
         FZhIbtn7SSsc8RtB12+2Wdn/u2esI1QXdHfis1OKG3IbArM9dcyocNmGFK3sR0e63c8W
         VZjpQCm9GT/2jFm6BRrFAXrN/4elm2rcm2c4bUB6oWukypEQv8bd+tMq8F+weJkM/qKe
         fZDx2RXDGcqrA1L8uSwj1Kjp2A1IO4uEqBGnF+wUk8DZjfLSUHeZtTtDqo1ggT/ycQDm
         tpfU420UXouMgCI89NpvbDoPry1uQzTS38w3p/g2fzuCM9PiERfRlLSe906JsnvxmQ4C
         pYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709564959; x=1710169759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTbnfUF0t3xkBManGvXEIwZL+6aN7DMDPePR3e3LFZM=;
        b=GUXcC+I62IFIX//o2UF6K3VKNVOCbWeJ0wwRaDs08cFTEjA+iiogrFZtIHGgVQNZ2Z
         8rgKOUuBq8xuz+C8X1qwSX0UV5sibaGSsBJdlKSMKyjAOTyXe19cM25wLOfvwsLo5Gp2
         iSkFOOjUu2kg0UC+aOQZrD8q+m4eRJiYBq8kjST381wAwl4bijoVRaq7acCtVX21AxmO
         1c/F8ZaHvIJYWvuMWwqBsKCD1V8azicNrogjeS02CDn6jUEbWQWP8gYaOYII2HebOshl
         zabADsJ5F9w3sW601Pr8QT63R52zPkFbHEjByNI+kwBFX6CEMdEDBuN00JfS8HTmvb1a
         gFgw==
X-Gm-Message-State: AOJu0YwSlq4vAIAlmLzU5ARj1pdo6kYRKmAdq5RTzWfOHcn1C4smONXI
	v25xHKP+gr8DHUkLLRsUgGQa+XxRApy9BDa4e3hRVrdpv76bHfc6symIfF2vQXasckkKq2so1Mj
	r
X-Google-Smtp-Source: AGHT+IGJDGoiNQlNKd4LwaQZ2VE9Xo3TEQZ6G0aAohiKBcQoGeOJU2ptgiaxVPJvvrjFysE4YaY0Ug==
X-Received: by 2002:a17:906:ad95:b0:a45:5e47:ba51 with SMTP id la21-20020a170906ad9500b00a455e47ba51mr1461888ejb.1.1709564959046;
        Mon, 04 Mar 2024 07:09:19 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:1d25:beac:2343:34ef])
        by smtp.gmail.com with ESMTPSA id um9-20020a170906cf8900b00a44d01aff81sm2904069ejb.97.2024.03.04.07.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 07:09:18 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v2 16/22] ovpn: add support for updating local UDP endpoint
Date: Mon,  4 Mar 2024 16:09:07 +0100
Message-ID: <20240304150914.11444-17-antonio@openvpn.net>
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

In case of UDP links, the local endpoint used to communicate with a
given peer may change without a connection restart.

Add support for learning the new address in case of change.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c   |  4 ++++
 drivers/net/ovpn/peer.c | 34 ++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/peer.h |  2 ++
 3 files changed, 40 insertions(+)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index d070e2fd642f..cb2a355f8766 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -209,6 +209,10 @@ static int ovpn_decrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
 	/* note event of authenticated packet received for keepalive */
 	ovpn_peer_keepalive_recv_reset(peer);
 
+	/* update source endpoint for this peer */
+	if (peer->sock->sock->sk->sk_protocol == IPPROTO_UDP)
+		ovpn_peer_update_local_endpoint(peer, skb);
+
 	/* increment RX stats */
 	ovpn_peer_stats_increment_rx(&peer->vpn_stats, skb->len);
 
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 58ea72557d89..1fcced805399 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -601,6 +601,40 @@ struct ovpn_peer *ovpn_peer_lookup_id(struct ovpn_struct *ovpn, u32 peer_id)
 	return peer;
 }
 
+void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer, struct sk_buff *skb)
+{
+	struct ovpn_bind *bind;
+
+	rcu_read_lock();
+	bind = rcu_dereference(peer->bind);
+	if (unlikely(!bind))
+		goto unlock;
+
+	switch (skb_protocol_to_family(skb)) {
+	case AF_INET:
+		if (unlikely(bind->local.ipv4.s_addr != ip_hdr(skb)->daddr)) {
+			netdev_dbg(peer->ovpn->dev,
+				   "%s: learning local IPv4 for peer %d (%pI4 -> %pI4)\n", __func__,
+				   peer->id, &bind->local.ipv4.s_addr, &ip_hdr(skb)->daddr);
+			bind->local.ipv4.s_addr = ip_hdr(skb)->daddr;
+		}
+		break;
+	case AF_INET6:
+		if (unlikely(memcmp(&bind->local.ipv6, &ipv6_hdr(skb)->daddr,
+				    sizeof(bind->local.ipv6)))) {
+			netdev_dbg(peer->ovpn->dev,
+				   "%s: learning local IPv6 for peer %d (%pI6c -> %pI6c\n",
+				   __func__, peer->id, &bind->local.ipv6, &ipv6_hdr(skb)->daddr);
+			bind->local.ipv6 = ipv6_hdr(skb)->daddr;
+		}
+		break;
+	default:
+		break;
+	}
+unlock:
+	rcu_read_unlock();
+}
+
 static int ovpn_peer_add_mp(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
 {
 	struct sockaddr_storage sa = { 0 };
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 9e5ff9ee1c92..739560fc992a 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -165,6 +165,8 @@ struct ovpn_peer *ovpn_peer_lookup_by_dst(struct ovpn_struct *ovpn, struct sk_bu
 struct ovpn_peer *ovpn_peer_lookup_by_src(struct ovpn_struct *ovpn, struct sk_buff *skb);
 struct ovpn_peer *ovpn_peer_lookup_id(struct ovpn_struct *ovpn, u32 peer_id);
 
+void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer, struct sk_buff *skb);
+
 int ovpn_peer_reset_sockaddr(struct ovpn_peer *peer, const struct sockaddr_storage *ss,
 			     const u8 *local_ip);
 
-- 
2.43.0


