Return-Path: <netdev+bounces-225524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BD1B95194
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 10:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656571904D52
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 09:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AA731FEC3;
	Tue, 23 Sep 2025 08:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SX1+kj0a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FDE31E89E
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 08:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758617967; cv=none; b=nUpowK+8tU+s2JyEvwyQbFoWkTvzEEFFa8llMYFTBnQR6my15IP6KOmR/0ZBrbqXvAi1vo4/6IjGTuOS8WKIVZCIneA3W34YzBwGdTsJDZDpKqyJ2x+pBkdcKT/LUtISL4d2wxeNifBh33DYw3YzfSpubRkixAiTnJHLV2P+JOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758617967; c=relaxed/simple;
	bh=5DFBuSdlxaCcOvy2y416jSTiEqL4AHa8+uh89xjhSCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D3Zt0X6OBbBjWXuALg+PjOGUbJ4rr4aaSncXRovfRvoeeExN6fiOJV+HBBrNd+OWcQ+TPYZizRSXS/UBwAqJ3cLMwAF2dyuLiWXdK1xAb8sr9cHVP24hX7UTL/abbZP9OEzgbmK6gGKTDNql+Wk7ESrcuyi6qOyX59DyMguJY+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SX1+kj0a; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso40063205e9.2
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 01:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758617964; x=1759222764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwLDNBiVN98UCDyIlQ/l+MZhscT3bhY9tzLzQhwCiT8=;
        b=SX1+kj0a5/O003ymovF85LFjAlWflBOG/Xv7MVTwPeZlAWJqXX6zKxqhe+HyHIFZWf
         TPDtmOHQ0qVWV1kWAWwyIziYAIauUqfPOPj+ym6LRRlb4tUW8WQcgQOUcVIIbv6ecSFW
         B3oweJXqSuxPrVkinF4dLe7YqHWXragOs5lUG1R33pt1UbFuL7XCGBdRlU7l7s72XAqb
         v5ojmDmbAqXuxB6TBCNoKhyUzekJxO/CB4AAE3phX2+TASVUxVYs5bmANWQ3ec2ljbU6
         S/ZR2RJWmRkMueTTlkfp2GGtCbAd5S+m2gvQWkf7e+3HutSV/T0QZJe9IyUUgjA4nsYC
         e4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758617964; x=1759222764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nwLDNBiVN98UCDyIlQ/l+MZhscT3bhY9tzLzQhwCiT8=;
        b=MAdTKDu4OhLRv3oYiKpJRbhAGwb8CR/4MM27AuELURZEOKHDt1tdVMWSQOTvLow0Kn
         jokVKoCZmxIWsiMjIC7YW7OkXQZ5cjFJ+TAKq2/e7GqnohO8k7KSpnLSAA7xX2mA3N7B
         iwQljHz4ZnnTHxrr6TH9kyWD27GUIFrMVUMhYh7NLPbxbJlPRk7LBMh38TiVZxXudpUj
         iP2kVzqg1/m3TfJF5sIbVwCMAS7O2xLFiDkZpQvt0BCxqLNgHXmBXm+1jsvWx4VLOBCP
         8Cn0XlJTKJsz+qN2OhHF9cGHmyh7/mS2upzI0iUlLpJPFG4BOoPiAntZKn2tECvC7Fjx
         AvpQ==
X-Gm-Message-State: AOJu0YwWyau0cZHYxilXV/qrOuztTWhXgli3bIgTwVPAIjx6f0wJp2Zs
	GgWzIrk+bi+eeLtQp5el7Kxw1YmPMiwC/+jBik+X1O8an0+lnFlE3cZyh0DBBA==
X-Gm-Gg: ASbGncv7Dp+4MfN9ZDXji5PqKbf7CfroZB5ApxGWb9oiqwNpaerhkaVdsMTXp4Shr7j
	XRbCg2mEuftO2eBk8tfVhz1YVJN6f4N8JaqndbUhUX9M/U6k1t3A0Kp9GhfGzv5KOVOqKIC0kV1
	5aHpivtoKLjjzFALJGVnKjfe4mj35gAUNuregT40i1Ywrw2zYbeAvaKq8SPrUjb3jH3wwPlN7pT
	DTxpohpIF0URVVb2Sgi+BVorHO7gH4RsDDF40quzqddlltugvqG0b/+RZAiUEg8m1byL7/u2zOJ
	nJNkzGFzwW0QG8LqXla4yQQK0BqOqiE/7iaU/a3nbOMw+jZQNLuxb9f47/5u3Unchi6rZoTEwaW
	36n9QpKzO/6FX/xW5ejFJruM=
X-Google-Smtp-Source: AGHT+IFawB3xsnjYPMJSU4q41gXyf3wTf24vfyWX18dtpwJgMnDI/Qr6U3C9d9ZpwJoYHvRq5cQY1w==
X-Received: by 2002:a05:600c:a297:b0:46e:1f92:49ab with SMTP id 5b1f17b1804b1-46e1f924b99mr6075555e9.32.1758617964116;
        Tue, 23 Sep 2025 01:59:24 -0700 (PDT)
Received: from localhost ([45.10.155.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e15d1610fsm51981555e9.7.2025.09.23.01.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 01:59:23 -0700 (PDT)
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
Subject: [PATCH net-next v8 1/5] net: gro: remove is_ipv6 from napi_gro_cb
Date: Tue, 23 Sep 2025 10:59:04 +0200
Message-Id: <20250923085908.4687-2-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250923085908.4687-1-richardbgobert@gmail.com>
References: <20250923085908.4687-1-richardbgobert@gmail.com>
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


