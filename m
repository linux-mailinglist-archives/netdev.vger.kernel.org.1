Return-Path: <netdev+bounces-215524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66432B2EFB3
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 09:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D8201C269D4
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 07:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA792E8DEA;
	Thu, 21 Aug 2025 07:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLHA8E/i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B88227C842;
	Thu, 21 Aug 2025 07:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761466; cv=none; b=MaPbU51qJ06+PGHFhF+falecRNER2cIfFoiar14GMLEzITq0cSEngnzCrp+hIhBa8WPyX2ESurG2Em4sSYUxHJXL+KUvPVrJu+4c2GOdG99YXA/wh/wRkHWX48M66W3yBeVwJ6NRJIdrBSFs+2M43q99ELolM4O0QgOSw7JlUes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761466; c=relaxed/simple;
	bh=mxEwkzXly/Y4JNSbz8v4T2gBOi2F4x5T/wk4kmBgl2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aPGCCqBFRpoTziCOX2JH306cQOPsFugIJuYRivqRt2UgdZhsUNzkVNmHbe0wg7VwYkLouidfhyZv3ryv2Zfp9VZ23Jc0fWGBxBcHS00DwUBvNMqmvlnUeaf4XTq3DR8cHTxHWJw9TqFjTLNBV0eUu48Stu6c7VTY6dsKrKUjmDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLHA8E/i; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b9dc52c430so465258f8f.0;
        Thu, 21 Aug 2025 00:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755761463; x=1756366263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzyRYXFeRdQ0h4UzLBnS+cvLTXcS5INP1rXtO0nuLqU=;
        b=XLHA8E/iWkADN7Gn6MEIG6F1jR20XNqjjSERry1lokHjDXVaNe1dkutmWZj9YgNnhf
         B/yB4fCR/Py9alPjH7tQGsqz0FCqA1apxMT2+1P5xE1cDIatI8eMxl4WVFo9ibqPG3wK
         noDFTEfiOKvXsA0428g2aXdrQqgLifIPbjSQ+3TDbi9QPUVopLKRLMjo55+KBKLVbexk
         HbR+3/Xzzhctf5zAXr81TjbGqHeLNevDJNSj84fLaj/H6JwSzt9YlcgEQq+0g2iIxUvw
         60bWUy9lk4FT6AXbyo4fo6J9JhcHO/lS+DTTUvhdQwrqyLZXXkrUh8gdf9ome0bDQjRu
         uWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755761463; x=1756366263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mzyRYXFeRdQ0h4UzLBnS+cvLTXcS5INP1rXtO0nuLqU=;
        b=dX5rZn1lWyVlDseqLKgzGTndnlkBJ/bMTdA5cZBOUb5UTAOxVS8SphGbzcl0rjePJY
         0KlbxKsLCCIWHcDmH19C/tXLNDQwf8TDfOJVByIXzr1QP2jTWOasRlE1iQnmXs7yEd0l
         YxOatsJIqV+KJ0fEp6PL8AQz87mQM6VwaF5V2U7M/qfMG0VEHf3v/Iy2vvRpYOdNBAen
         sWkf2npagEuzhaexhRG/hOxbEdKAsSYjP9ArjAt3FXK19L81NR7U3lWuRp9veTwXODI5
         cl0BnKSremQTBCs8q9rjcIpRo1Oc7h5rRXbXUyve9JxUCHWIj5QIZka/1eeQ+7qzflAM
         TRmQ==
X-Forwarded-Encrypted: i=1; AJvYcCURPSpZcfh20rjJIgHMPdFRMBXijfbGRHiBGEHj/kihvgBULj13EszJfHVqicKDEBzNKJQGrdDUR4zwFwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiFdSInElfydokvd/VXEgtpuZ3Rv4JIxJJn2j1YDlpE3qdO3Um
	4X8UiQ4+HjE4KVX3etFQPGo4qRMnl3P0QgvrLSBmlmF8ngBlhzTgAi1YTWBIxQ==
X-Gm-Gg: ASbGncuOX8zeRAerC/d7xAsAQwnMc2s4vHuU1/bIGRKToKtQziLq06PgHu/LmUw7vW0
	uQK2P7pHVhC5DAsArGEZw9uKDEIfl8gSjxH7vsIf5wwCs+td9FC+MqecLCzgP2kJITMXTD4Wf9e
	u+bdTijiaRAMV+ojWxoqev4+1tQf4tassIUB8ydaUULXy5n/ldYFmPqQojMJZhEVq9STI/qgZYe
	Sus1RI6BwdvtIbUzV24oTnyzrzvxJLcTJRI7mL3YwP7gcVEoSMY5tOk62s82DQhP7aLp9vecTJr
	VitiTf0l4s5yvYHjQ5wfKBY+E1ZnMmN/BukP87ktbAbr1Esa/H8ASasZo00099d9Cf7AXgBpEQ2
	K/IvxbIjV9T6QqQ==
X-Google-Smtp-Source: AGHT+IGEBl7wjxkI2wLJhkjfICifRA942WZKT9F56XgLWLVwQcbb6UNIvNI/RUgioKyaEu/dJn+XdA==
X-Received: by 2002:a05:600c:19c8:b0:45b:4a98:91cf with SMTP id 5b1f17b1804b1-45b4d7f819dmr13940155e9.15.1755761462529;
        Thu, 21 Aug 2025 00:31:02 -0700 (PDT)
Received: from localhost ([45.84.137.104])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4db9fa79sm15349805e9.23.2025.08.21.00.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 00:31:02 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	leon@kernel.org,
	ecree.xilinx@gmail.com,
	dsahern@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	shuah@kernel.org,
	sdf@fomichev.me,
	aleksander.lobakin@intel.com,
	florian.fainelli@broadcom.com,
	willemdebruijn.kernel@gmail.com,
	alexander.duyck@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-net-drivers@amd.com,
	Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v3 1/5] net: gro: remove is_ipv6 from napi_gro_cb
Date: Thu, 21 Aug 2025 09:30:43 +0200
Message-Id: <20250821073047.2091-2-richardbgobert@gmail.com>
In-Reply-To: <20250821073047.2091-1-richardbgobert@gmail.com>
References: <20250821073047.2091-1-richardbgobert@gmail.com>
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

udp_sock_create always creates either a AP_INET or a AF_INET6 socket,
so using sk->sk_family is reliable. In IPv6-FOU, cfg-ipv6_v6only is
always enabled.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
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
index 3e30745e2c09..a654a06ae7fd 100644
--- a/net/ipv4/fou_core.c
+++ b/net/ipv4/fou_core.c
@@ -228,21 +228,27 @@ static int gue_udp_recv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 }
 
+static inline const struct net_offload *fou_gro_ops(const struct sock *sk,
+						    int proto)
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
index 5128e2a5b00a..683689cf4293 100644
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


