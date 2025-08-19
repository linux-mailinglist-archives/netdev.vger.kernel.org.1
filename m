Return-Path: <netdev+bounces-214873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E725EB2B975
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 08:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13BE81BA52E7
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 06:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FCD26C398;
	Tue, 19 Aug 2025 06:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVkJ2x5s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416F01AF0C8;
	Tue, 19 Aug 2025 06:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755585172; cv=none; b=n0E3WaU8FQePLTrWpFq2VyXPv8t6O+QdPz7tGu/geX5AeVCgxFKZgMU666N9HXEe15+YM2bCaYEbunjztvbzDqQWVqqLlOPEAeZufnFQJ7w+/OvaKUjifsBrP7Iq5FR7kDKr7MWYR5zmRiWtf8BNvLXcda8lM/a7KEtK72MmFj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755585172; c=relaxed/simple;
	bh=arDp3ryU9yRhuo+FkoXFEHu+sjYP396linIvHkBVA8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ILHlMXA/XIaAxdjZJMlHqgdEmAGzPfs4U356ASWEh6V2NoM09+gVswkVP+z3LXe3I6abTp/5MhRlxm+hY4n4BoicVm9qg9C/mVEodUKnjXd8DCClUdrIIGnwCs/DGZDwKy0Q8nnQ1G5zJIa1ApwTDlPDauXkaZyiUpFQXq0ex9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVkJ2x5s; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45a15fd04d9so37488425e9.1;
        Mon, 18 Aug 2025 23:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755585169; x=1756189969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJOzXwjsw+va6rIlGFDKglckvIIOuznJ64OBg1nYDeI=;
        b=NVkJ2x5sw7aKV3XDzAS5EqgYGDB8iSpJAyEz1wN8XL5+4yGy87GchWdi5Ms3zRBh06
         97budWT+EhNH+9037rV54GZyLh90+Liot6Bz+XKWD4rq9wYCvNaS2ulXbW95asr9Sh78
         5Z9cmx0cTVzpa+vshyHdFEDgbIx2FhYRQGeUEAaVa1G769k6hAQMJDK1cSIxOfXXyec1
         354b+u1/Q9UDlmpmCrNAbLzKzbNr7JNg5z/v7RV63ugrFsgrZNgxbtk9pppaxgKHESK/
         ImdLmaSPb4j5kcp3pHw4qAPSSshF6hkQ4o16lfsfxMcnheTG8PzqXP8/gfmsSbmP1xAs
         roqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755585169; x=1756189969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJOzXwjsw+va6rIlGFDKglckvIIOuznJ64OBg1nYDeI=;
        b=XNFdP2WSaB9p5oxunpLSM5Muy9ZHXmv7XkjBNcHqx9dr4JHGipwcpuEwRDCFPikmKh
         cAH+tUfQe6EVDuFb/VyeawJ6YL8AEoutpaR8sJs72ScAJARcRHt+2M90s5D3+FvQuFf1
         aFpHisDbHHS/PyGRRTw/DCsTkGNqPeIkASEXeMmv9GrB+i9V8+Fis4mbqQW6Q8FPsJXH
         SwCTFs6GUR1ERu66zaTzPayryizBHQ9S2gVgB71EDYaTx5CWhgf4KS6AVnVattz+MCKe
         IWzJUm0ISkduokuiDBybGKKAfwjx3+gdzdo7NXbPRohSChHBU37IHOdPPHoMQBGBWdUZ
         IyCA==
X-Forwarded-Encrypted: i=1; AJvYcCWgcMCNmfnA3UrOcKE+uo4pC1tdoaWSeVoaENcah0VzEZ/uqY7LwBWy4nTyrxezLS27TgK021AcmG5Tg/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCD5/6ajjl9pBgcPp4DES7jSt5NhBnA7JsZEcdqHWroMrbpzOM
	hpioR47Pu6RiyQVwYFr6m/hvQcBjFgTjMDGmgF4Zf9OraKLE7LwuV7tnAz/QawRe8Dw=
X-Gm-Gg: ASbGncs/IXFVmxj14rvO7Kd6bEIQuu/t6OJR/Q+KqVu31XvAKMkzrrWgRpW+h7nDLuk
	TkQuSDZzMwVrub42Zpd9pamEWXITTTcMwWn2P3Z91+8B3llKjhmbVW9G/gxs/nTRkw1YwYlNWxc
	jQ6YgAZuCx6eKnSOzIC/pDR8DDIhZKaT3J11qBmmomF0YcD0OMaSXWAkuJDZSqcjQDu5Bj6bvd3
	VaT09f59mSlNoGG96al4qwhlu/TgloZyTzN7FtK5LkopymH2al3zHXuoZ1Ln6wpQ3BjJvum710F
	a70nSE9eRN/aldighmqoqRDuBogB+F7H0CmcOoP/mz4VazQbBfjI4IvkA9HpBBJn8XAiJDm5dSn
	lOMaKTlJ9DCN1i88A8KqoYI9F4lPqIDiv/dqsl3IbS0cGSJzpWxi+4W4=
X-Google-Smtp-Source: AGHT+IGYXFoLTEzMTPqfAvZdgN0wllJO473IdrA37DPaI+5al7xoC3sLYRQRzrjTCrIdwxDyawtkeA==
X-Received: by 2002:a05:6000:2484:b0:3b4:9ade:4e8a with SMTP id ffacd0b85a97d-3c148492064mr864750f8f.21.1755585168330;
        Mon, 18 Aug 2025 23:32:48 -0700 (PDT)
Received: from localhost ([45.10.155.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c077788b39sm2251145f8f.47.2025.08.18.23.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 23:32:48 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	shenjian15@huawei.com,
	salil.mehta@huawei.com,
	shaojijie@huawei.com,
	andrew+netdev@lunn.ch,
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
	ahmed.zaki@intel.com,
	aleksander.lobakin@intel.com,
	florian.fainelli@broadcom.com,
	willemdebruijn.kernel@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-net-drivers@amd.com,
	Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v2 1/5] net: gro: remove is_ipv6 from napi_gro_cb
Date: Tue, 19 Aug 2025 08:32:19 +0200
Message-Id: <20250819063223.5239-2-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250819063223.5239-1-richardbgobert@gmail.com>
References: <20250819063223.5239-1-richardbgobert@gmail.com>
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

Using sk->sk_family is reliable since udp_sock_create always
creates either a AF_INET or a AF_INET6 socket, and IPv6-FOU
doesn't support receiving IPv4 packets.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 include/net/gro.h      |  3 ---
 net/ipv4/fou_core.c    | 31 +++++++++++++------------------
 net/ipv4/udp_offload.c |  2 --
 net/ipv6/udp_offload.c |  2 --
 4 files changed, 13 insertions(+), 25 deletions(-)

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
index 3e30745e2c09..261ea2cf460f 100644
--- a/net/ipv4/fou_core.c
+++ b/net/ipv4/fou_core.c
@@ -228,21 +228,26 @@ static int gue_udp_recv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 }
 
+static inline const struct net_offload *fou_gro_ops(struct sock *sk, int proto)
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
@@ -254,8 +259,7 @@ static struct sk_buff *fou_gro_receive(struct sock *sk,
 	/* Flag this frame as already having an outer encap header */
 	NAPI_GRO_CB(skb)->is_fou = 1;
 
-	offloads = NAPI_GRO_CB(skb)->is_ipv6 ? inet6_offloads : inet_offloads;
-	ops = rcu_dereference(offloads[proto]);
+	ops = fou_gro_ops(sk, fou->protocol);
 	if (!ops || !ops->callbacks.gro_receive)
 		goto out;
 
@@ -268,10 +272,8 @@ static struct sk_buff *fou_gro_receive(struct sock *sk,
 static int fou_gro_complete(struct sock *sk, struct sk_buff *skb,
 			    int nhoff)
 {
-	const struct net_offload __rcu **offloads;
 	struct fou *fou = fou_from_sock(sk);
 	const struct net_offload *ops;
-	u8 proto;
 	int err;
 
 	if (!fou) {
@@ -279,10 +281,7 @@ static int fou_gro_complete(struct sock *sk, struct sk_buff *skb,
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
@@ -323,7 +322,6 @@ static struct sk_buff *gue_gro_receive(struct sock *sk,
 				       struct list_head *head,
 				       struct sk_buff *skb)
 {
-	const struct net_offload __rcu **offloads;
 	const struct net_offload *ops;
 	struct sk_buff *pp = NULL;
 	struct sk_buff *p;
@@ -450,8 +448,7 @@ static struct sk_buff *gue_gro_receive(struct sock *sk,
 	/* Flag this frame as already having an outer encap header */
 	NAPI_GRO_CB(skb)->is_fou = 1;
 
-	offloads = NAPI_GRO_CB(skb)->is_ipv6 ? inet6_offloads : inet_offloads;
-	ops = rcu_dereference(offloads[proto]);
+	ops = fou_gro_ops(sk, proto);
 	if (!ops || !ops->callbacks.gro_receive)
 		goto out;
 
@@ -467,7 +464,6 @@ static struct sk_buff *gue_gro_receive(struct sock *sk,
 static int gue_gro_complete(struct sock *sk, struct sk_buff *skb, int nhoff)
 {
 	struct guehdr *guehdr = (struct guehdr *)(skb->data + nhoff);
-	const struct net_offload __rcu **offloads;
 	const struct net_offload *ops;
 	unsigned int guehlen = 0;
 	u8 proto;
@@ -494,8 +490,7 @@ static int gue_gro_complete(struct sock *sk, struct sk_buff *skb, int nhoff)
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


