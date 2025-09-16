Return-Path: <netdev+bounces-223603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B07B59AD5
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D85F31B273E5
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA24350D54;
	Tue, 16 Sep 2025 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKrgdUXk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF334350D4D
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 14:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034137; cv=none; b=O6UNmo2NHyMXoB4zLA3e0zljhKpVsSU/Yzj21E7xzT7OtyIsLfXIOIxMJjDMWrIKpoLd5wGgp5cO9WWf8OZM7RpLNwyXPbZOUb+QIIezSVRXA/JfB9JrTb4Jpd3QPO1CFbXd3JxEY8eYtxCBqjdepXp5sCt2uJK5GyeoQ//bgf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034137; c=relaxed/simple;
	bh=5DFBuSdlxaCcOvy2y416jSTiEqL4AHa8+uh89xjhSCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BZ93DOGDJKIVqHXeLqW6u6sA+/hD8aNlTNwdmCQPvK2GxTdVcR1waeOnNWAMvX+2kINCD9NwoPCcVgYBXim8AE3NKbwHk00BVxYYtaE9/NArquHdDUHzSiSkoji3NgznM1/u5T6xkRZUxd6LqNRY37aNDWxYKxDQanTtYWKuMJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKrgdUXk; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3c46686d1e6so3862341f8f.3
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 07:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758034134; x=1758638934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwLDNBiVN98UCDyIlQ/l+MZhscT3bhY9tzLzQhwCiT8=;
        b=cKrgdUXk+sbR6enw6/IL1fN3TMASiLsY9VrIXhNh24TdsS7F1Fh9yJj1zslRJUWQ2t
         E8InQi4UMbzdXnD9o9tHCW98LLQZWQHYTPCjYDukiYyNU+wO3yu870RGHif8cz0pXF4G
         nENdWAoTWT7gBSfj4JjJKOJZU+rDPSOFuTgD6wF7sNV1eNDJCGIrTB1q8KHeXCqnAdLS
         OrN/2FwMO0Bipv0Umep0j/JhwkUkr108PG2ivy57xtZhX6XzziXMxu2ZoVMKZH6+5HL+
         rkTgig+/wD0ffSOFraf+uMZ9lXhiY4VVnzt7lI3g58LTwDwdaCq/8fmD47S5stZ5PKZB
         wPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758034134; x=1758638934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nwLDNBiVN98UCDyIlQ/l+MZhscT3bhY9tzLzQhwCiT8=;
        b=evSJT5XJeEdg1kJApTrBflQpt+fv9hI9bFtO7ckO/8b8XHh1TEjNR2TM2zV5kIdQY3
         +ln/kHl0zntI2OxMlHw+IotP0yndrONyUpU7Z27UQxGZQpWMjXbj0dIP+H7Pch2vvXkv
         g6IlZ/Ok5/efpyhZOmuWIXY/MNpofG8xJb8M8laSmAxvhTxRADjA7XPXbHXbRj5lbDSe
         YclxUbo0cI06gFXdalZVNNn/1OlprXomThrRQO/Oj1PcRUNqrlWbUTJpR+JabeV78bzn
         ehKoZa250WJC5wQCgmnlvbvw8IFqJ0+9Lj7LhIGu/wi6/70XNwpWlDxyrNs1/hP1wuH6
         XRwA==
X-Gm-Message-State: AOJu0YyhJUK/tdTbgnbFV/mH/jXsWccq63yPquC8awyR3b42cVlsX95S
	rgmwpjpY6F4BVIry5izC6QcoC0t/qux2bD82gaFfrfwa83u+ybZTuA8whAt+PA==
X-Gm-Gg: ASbGncsThAfVRiymoEhhY4lUA4GvSpwzR467cdOsIovr7fSn/J3mjb5+zo8wr/duzhe
	gYRRnD1TAtm0/WoLYcdVrdN8FT9/VUgEDAGWms1HoG/ac3kV7yZZ4lByufyWEm+S+PaYvpFyNdB
	oTWLnelqdtdWxn14Hn8ec1CKTngyl11Wmor7z5OMksRzm+GOpqGswNHgBb8Uaznb0NMshqsNXU+
	/FTQaZaPTF4G0zQNUossoFJtaBPFRsR/vxF7MgRaCsh5/bZ9SoKpfOz6mrqtE6yrwp56WhHLxEV
	zAr6NpcGsQavyEXbHi8uvk8RXDMsGy0bKkqfx96GfXk4gpJsXhrAgBxSPykL6vFMpGrBEdpBRcq
	Q1w/RF3rPKvFYIfUVh4lsrktt8qgjq7DEEw==
X-Google-Smtp-Source: AGHT+IHMZUDMbOWsWpqh/e41woRC0crzmoX/URxSA0zpdw+P5ipokAbwJBvsiKBVGdIlEJC6cgi+xg==
X-Received: by 2002:a05:6000:420f:b0:3cd:edee:c7f1 with SMTP id ffacd0b85a97d-3e765a3d7d3mr16074714f8f.56.1758034133988;
        Tue, 16 Sep 2025 07:48:53 -0700 (PDT)
Received: from localhost ([45.10.155.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd43csm21784014f8f.29.2025.09.16.07.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:48:53 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: netdev@vger.kernel.org,
	pabeni@redhat.com,
	ecree.xilinx@gmail.com,
	willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	corbet@lwn.net,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	leon@kernel.org,
	dsahern@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	shuah@kernel.org,
	sdf@fomichev.me,
	aleksander.lobakin@intel.com,
	florian.fainelli@broadcom.com,
	alexander.duyck@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-net-drivers@amd.com,
	Richard Gobert <richardbgobert@gmail.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v6 1/5] net: gro: remove is_ipv6 from napi_gro_cb
Date: Tue, 16 Sep 2025 16:48:37 +0200
Message-Id: <20250916144841.4884-2-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250916144841.4884-1-richardbgobert@gmail.com>
References: <20250916144841.4884-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove is_ipv6 from napi_gro_cb and use sk->sk_family instead.
This frees up space for another ip_fixedid bit that will be added
in the next commit.

udp_sock_create always creates either a AF_INET or a AF_INET6 socket,
so using sk->sk_family is reliable. In IPv6-FOU, cfg->ipv6_v6only is
always enabled.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 include/net/gro.h      |  3 ---
 net/ipv4/fou_core.c    | 32 ++++++++++++++------------------
 net/ipv4/udp_offload.c |  2 --
 net/ipv6/udp_offload.c |  2 --
 4 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index a0fca7ac6e7e..87c68007f949 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -71,9 +71,6 @@ struct napi_gro_cb {
 		/* Free the skb? */
 		u8	free:2;
 
-		/* Used in foo-over-udp, set in udp[46]_gro_receive */
-		u8	is_ipv6:1;
-
 		/* Used in GRE, set in fou/gue_gro_receive */
 		u8	is_fou:1;
 
diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
index 3e30745e2c09..3970b6b7ace5 100644
--- a/net/ipv4/fou_core.c
+++ b/net/ipv4/fou_core.c
@@ -228,21 +228,27 @@ static int gue_udp_recv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 }
 
+static const struct net_offload *fou_gro_ops(const struct sock *sk,
+					     int proto)
+{
+	const struct net_offload __rcu **offloads;
+
+	/* FOU doesn't allow IPv4 on IPv6 sockets. */
+	offloads = sk->sk_family == AF_INET6 ? inet6_offloads : inet_offloads;
+	return rcu_dereference(offloads[proto]);
+}
+
 static struct sk_buff *fou_gro_receive(struct sock *sk,
 				       struct list_head *head,
 				       struct sk_buff *skb)
 {
-	const struct net_offload __rcu **offloads;
 	struct fou *fou = fou_from_sock(sk);
 	const struct net_offload *ops;
 	struct sk_buff *pp = NULL;
-	u8 proto;
 
 	if (!fou)
 		goto out;
 
-	proto = fou->protocol;
-
 	/* We can clear the encap_mark for FOU as we are essentially doing
 	 * one of two possible things.  We are either adding an L4 tunnel
 	 * header to the outer L3 tunnel header, or we are simply
@@ -254,8 +260,7 @@ static struct sk_buff *fou_gro_receive(struct sock *sk,
 	/* Flag this frame as already having an outer encap header */
 	NAPI_GRO_CB(skb)->is_fou = 1;
 
-	offloads = NAPI_GRO_CB(skb)->is_ipv6 ? inet6_offloads : inet_offloads;
-	ops = rcu_dereference(offloads[proto]);
+	ops = fou_gro_ops(sk, fou->protocol);
 	if (!ops || !ops->callbacks.gro_receive)
 		goto out;
 
@@ -268,10 +273,8 @@ static struct sk_buff *fou_gro_receive(struct sock *sk,
 static int fou_gro_complete(struct sock *sk, struct sk_buff *skb,
 			    int nhoff)
 {
-	const struct net_offload __rcu **offloads;
 	struct fou *fou = fou_from_sock(sk);
 	const struct net_offload *ops;
-	u8 proto;
 	int err;
 
 	if (!fou) {
@@ -279,10 +282,7 @@ static int fou_gro_complete(struct sock *sk, struct sk_buff *skb,
 		goto out;
 	}
 
-	proto = fou->protocol;
-
-	offloads = NAPI_GRO_CB(skb)->is_ipv6 ? inet6_offloads : inet_offloads;
-	ops = rcu_dereference(offloads[proto]);
+	ops = fou_gro_ops(sk, fou->protocol);
 	if (WARN_ON(!ops || !ops->callbacks.gro_complete)) {
 		err = -ENOSYS;
 		goto out;
@@ -323,7 +323,6 @@ static struct sk_buff *gue_gro_receive(struct sock *sk,
 				       struct list_head *head,
 				       struct sk_buff *skb)
 {
-	const struct net_offload __rcu **offloads;
 	const struct net_offload *ops;
 	struct sk_buff *pp = NULL;
 	struct sk_buff *p;
@@ -450,8 +449,7 @@ static struct sk_buff *gue_gro_receive(struct sock *sk,
 	/* Flag this frame as already having an outer encap header */
 	NAPI_GRO_CB(skb)->is_fou = 1;
 
-	offloads = NAPI_GRO_CB(skb)->is_ipv6 ? inet6_offloads : inet_offloads;
-	ops = rcu_dereference(offloads[proto]);
+	ops = fou_gro_ops(sk, proto);
 	if (!ops || !ops->callbacks.gro_receive)
 		goto out;
 
@@ -467,7 +465,6 @@ static struct sk_buff *gue_gro_receive(struct sock *sk,
 static int gue_gro_complete(struct sock *sk, struct sk_buff *skb, int nhoff)
 {
 	struct guehdr *guehdr = (struct guehdr *)(skb->data + nhoff);
-	const struct net_offload __rcu **offloads;
 	const struct net_offload *ops;
 	unsigned int guehlen = 0;
 	u8 proto;
@@ -494,8 +491,7 @@ static int gue_gro_complete(struct sock *sk, struct sk_buff *skb, int nhoff)
 		return err;
 	}
 
-	offloads = NAPI_GRO_CB(skb)->is_ipv6 ? inet6_offloads : inet_offloads;
-	ops = rcu_dereference(offloads[proto]);
+	ops = fou_gro_ops(sk, proto);
 	if (WARN_ON(!ops || !ops->callbacks.gro_complete))
 		goto out;
 
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index b1f3fd302e9d..19d0b5b09ffa 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -891,8 +891,6 @@ struct sk_buff *udp4_gro_receive(struct list_head *head, struct sk_buff *skb)
 		skb_gro_checksum_try_convert(skb, IPPROTO_UDP,
 					     inet_gro_compute_pseudo);
 skip:
-	NAPI_GRO_CB(skb)->is_ipv6 = 0;
-
 	if (static_branch_unlikely(&udp_encap_needed_key))
 		sk = udp4_gro_lookup_skb(skb, uh->source, uh->dest);
 
diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index d8445ac1b2e4..046f13b1d77a 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -154,8 +154,6 @@ struct sk_buff *udp6_gro_receive(struct list_head *head, struct sk_buff *skb)
 					     ip6_gro_compute_pseudo);
 
 skip:
-	NAPI_GRO_CB(skb)->is_ipv6 = 1;
-
 	if (static_branch_unlikely(&udpv6_encap_needed_key))
 		sk = udp6_gro_lookup_skb(skb, uh->source, uh->dest);
 
-- 
2.36.1


