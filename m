Return-Path: <netdev+bounces-223013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78414B578A8
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 13:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0B1D16BF07
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 11:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCBB2FC007;
	Mon, 15 Sep 2025 11:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbXMyGZs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A312FD7D7
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 11:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757936447; cv=none; b=Mng7DE1NYWs89cYJLXiaAvLJ+aaykFhvuqDjyDgZu0SZj//R+vmZVkTdCZcVMGi9Pw2OkZV89SltnBPUwfIjISl6dR5j9vWrbAGtvLVszMPd4vYLRB4mcFRcv9sYJ2BV4Lnp05HJJF7eWUynNcNK4BKCUmZqSsdFH1pyOExe3hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757936447; c=relaxed/simple;
	bh=jY+pUy3kBJwFzbCPyETA5Zsp5XhOgceDU1qzIwyTQQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HjgIf92X7bmzEh9kiB/FyTSReMQrCsEi8oJQP0b+Z5mMmICpGmqAeDbl6RuytDvIihc5pi3PsmA3dN5llRRNQQP8IZHK6TOlu+k9F9HAdzEgxC4rkBqQF65gM3tMJWUBRZLjA9JqxWksS+e8xRniOBnzfb6mGOdZMljG6mo3STE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbXMyGZs; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3e4b5aee522so2461323f8f.1
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 04:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757936444; x=1758541244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u72Um79V9re5ZHDgqOQkBEh3WxfHhzUFF1gdhHx0vU8=;
        b=fbXMyGZsrsV0xIA71jMP0I83hcZNesLmYP00dtadSjJMbYaUvEGPrP4Y52BmF/asAL
         Dikpl4u+as0H6fWVDcgwYtx94u7YEmV5ZkG43DkXUJYxu6uu+uOrkzWTT0Zlzv7FplJW
         MYD0fPtiRHPGq7jxRAOAJ63j7kTgw6sDsNWHG/W1DJ8ZHO9fldLgdt8R0m0kb4I4fW+U
         hwS/icP2pnPsppeNQjd4see1hWPl2DZQJTGP732pVq4JMzsf+aKaTQySSWL1a2ApRNPF
         02CzNSI2RSPDN8z5fgzpeK0voOCgBUUq5iX5nCTbE200HJSxBRlMqwCh1E+e0Hd1cXwb
         NPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757936444; x=1758541244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u72Um79V9re5ZHDgqOQkBEh3WxfHhzUFF1gdhHx0vU8=;
        b=kLW2PSqY7WyI8rk/lFuWAdHwG8PHcLCIv/Dt+0jZbXTQWVQSIRWk+41EXNsYk97uK9
         E/45FdooNLHgqXhHyPCatJKAbav+DfBAn6fDD6eeuYbjbt9OyhHxnI6Kp/EVszInabMk
         l1RDlvBqqXgEoLOKisDEUrsy7UfA1b0WAsAxZyBFLKhnrICf4EkbXRumAkKA5MLsbJmf
         KFPowMWosZzqbf1/qhObvN5HrEXTDI6VrHvZF8veLSt8Aa/4bBoxqxMXtbTBXc+1/fLS
         ph0H99srgMSkv34Hnf800PJo/QXl75BfnEPdYSp3VU2iCq0JJhCtjWE5J/VNtPxfIS1i
         CTLQ==
X-Gm-Message-State: AOJu0YwzDYvwwqHLflTEFPrEKaqeInpFOLljxEb98sQjKrbQ8sKD0xXM
	pEkAkh5+RJHJCGZw+ZIY5BG0wzf9cGotAT8mp/j1wkrNORKZsnxFCe5ZtCje0A==
X-Gm-Gg: ASbGncvfHnegvsasXygGlLOSzB1FhtF5YAnGSX1q0CpNxRTvJ6HT6pi0WLNtOW10jgV
	itpD/d8PHz9kbxQxXwQ+Ki1dYNe7EeDqV6rZZivG2Vxv4t4KKla+ecbL6zu14kDXTwTNcPyUG11
	SWh0OojXQDocUZVAndbYr0suS7vFSIfBUOYe2UGGri0qg+1nfx/Vk/2Hc4AFvfSSJzV6QalTbnn
	7UcGC4fblT9Tf7fORN02Mp0jHJfMajQv+gftvSZiPTx/3itmVXs6QYqpJWjuGKaNWRoALkXn5X9
	Ic5JvHPlvDoWhfqvjXLwxu9jpwekW0qZhzGK6AQB54AUKBYzkSyD9KtPJiCtYTiezGV9qyMnju6
	Ro5ZY9lIN4gGjh/V8htuku8/qChRnZd+Arg==
X-Google-Smtp-Source: AGHT+IGpIAfhEWKviy6ghsA1Oo3PFra/49ftGsD+pneSeFbYGHiRKmO1SKhfzhhcCROEejBqjwMaNw==
X-Received: by 2002:a05:6000:2313:b0:3ea:6680:8fa1 with SMTP id ffacd0b85a97d-3ea66809518mr3649315f8f.12.1757936443405;
        Mon, 15 Sep 2025 04:40:43 -0700 (PDT)
Received: from localhost ([45.10.155.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ea21a6e4basm5604532f8f.11.2025.09.15.04.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 04:40:43 -0700 (PDT)
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
	Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v5 1/5] net: gro: remove is_ipv6 from napi_gro_cb
Date: Mon, 15 Sep 2025 13:39:29 +0200
Message-Id: <20250915113933.3293-2-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250915113933.3293-1-richardbgobert@gmail.com>
References: <20250915113933.3293-1-richardbgobert@gmail.com>
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
so using sk->sk_family is reliable. In IPv6-FOU, cfg->ipv6_v6only is
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


