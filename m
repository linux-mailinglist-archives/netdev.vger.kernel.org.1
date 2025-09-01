Return-Path: <netdev+bounces-218730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC70B3E1CB
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 13:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D30B1A81F7A
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 11:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBF531B10F;
	Mon,  1 Sep 2025 11:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFC0AusM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E687313E04;
	Mon,  1 Sep 2025 11:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756726736; cv=none; b=MGYYr+6+rxFYR7kBOSpphWGw3I6A4mLSSN0Ixq2BgByGyXRX7u64MqrI4+wrp8+dpmSbld1dc9/csgUFtajWOH0ZXGUZlYUUaUulHhIZL4b499N8yLwcjfwF2bdgEm/4YdFs2sznWtxkR+6QHS2vJSFxxrZLNgxMH8ovlka3ZjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756726736; c=relaxed/simple;
	bh=nXqfRaXa7TPT5UlTkSC5YunATJ2MtyWJw1kq/wkuG7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jxEcBLo97vHk8lutyMjj/GQpYjnAdUJVxnU8XIjzX5SOLgazIB1Nw2pLMVVLSTxJC/jks2J3ZNxXXvk2B7+fGuBzX7UOr0m1myyiE76ImxNhX/xOzl/du7utHR32ysuzwxW4AkioTH3ZZEylII+TYG25prIirv3EWf5wlFwXvBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFC0AusM; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3cbb3ff70a0so2609575f8f.2;
        Mon, 01 Sep 2025 04:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756726732; x=1757331532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JaBM4hbswP3CKidxpCKke/FjAwFtviAVkjfvWCq4DYs=;
        b=FFC0AusMvlAjGR6J7waQtl6xtL/8gVGWgy90eRyws5USIJgwill2ljow6rjwEY9OTz
         PzpuBEi5S246XgjCjySN7KJoB74ris2iDeHqsYwXpiu4He8uWRN4ISEoxKaPQxVokS1A
         e7EatzIF0mOlDtGvZ0wEcJ6lz2XHImJVmoPImrfpAA2lvHXfEshE8bz5YmSpJWJrew6B
         W9zk4J4aO0zghToMX9Ej9O6fpOLuR65fW+bbndOEDO2IjyqjvUG9CYrHY1lxJJJwr040
         n/4gzgBGBsVm+Hw0/5pOOBrSnkGPlkPy6CiwyEOjNw0oNP2qplnCM734JdtapMZG0AnF
         6grw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756726732; x=1757331532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JaBM4hbswP3CKidxpCKke/FjAwFtviAVkjfvWCq4DYs=;
        b=MX7NWlAPl84V235Yg/52UIM3/0aB2k5Pzds/kNUEeNOfqudEc9smQmjob9eOVc64TJ
         vj6OZt/cE7No0+TTc5xhsGJ3BlVeAez/3/GoEBKKmBNfeSt59W1d1Mpk6QlKRTWNj6I5
         KmzyL5S4FdiFM8+poOZMUZw1f8a89iFc+wrqRBO7H0o4MYKz0+vDtbFDqHgq6sCD9o//
         LkuOJJjcG+S3ZgjhYSJXCAm1/KBqywSDWxGc+gQuXNWz/bL3lvZ6xl+Bzslnrk/a1ZB1
         NAAYzOXP8n1halMNPS3+KoiDNpoPerKuUeiBJFzlKyGVJKY0mWWeoKGheWJtKKb19Ksr
         H8Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWLTMSpJ5XX5lrL+TdHVj3WHQgRyfURMC4M7z3YDhFmyZji6zLHpPasALioOrUyVm1ZaSkgyHx5VOUrOgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY20oznIYVX5bWpAzAuI6zle3hMWuCJpG7eVhNL1OLsyLRR+bL
	XA1wtsFDUgKgjNY0iAjPaB83qneGGDnNV3p1D6Tl9OBfMNoui3WwNRXgCx5NxMNTVoY=
X-Gm-Gg: ASbGnct1Q+hdPMyt5pcIUqujcGXkMOpk/PT7xrLQxB8r37oJN3otuGfwoJbv5jqX4wO
	Rm8J3cvT8XYyPajVfaWVt0VJln2P55BsSJ+U/dnfEmDcoCcdkddLOP9lykRkiLWreUiCplFJFix
	ht//7Fa034PHkP9YT7m81fzvQQFcRPQ83j9xCO2BQiTg0Sye1u71yXAYePAC+eiVgR+lpI/vhhY
	0pV6gu5DBMTHq15q30SV3BWwFAQuV1UcBD4r0/XCK9pa63AjF59jyiCDVekdNILygKcQvoWVQ2L
	61x5mambP96NNAHqOQjTnQe+yI0/0544TBJujA8eRnQ4NS3ebHB6QNYza8kJr/qwKmoOglO5185
	uokDgwX4UrpHQoIzZLVmGsFsbvfOTj2XCGWPC0c5nKkLNDQYH
X-Google-Smtp-Source: AGHT+IHeCGle5U4kgIZqlZ2Zfvsulxwq0GMBsnnbpzlqqgBwNeaOPUE2o5+0tHUyjLy64neOGeQYuQ==
X-Received: by 2002:a05:6000:2a02:b0:3d4:a64:6725 with SMTP id ffacd0b85a97d-3d40a646ab1mr3199253f8f.10.1756726731581;
        Mon, 01 Sep 2025 04:38:51 -0700 (PDT)
Received: from localhost ([45.10.155.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d690f2edf1sm4253409f8f.16.2025.09.01.04.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 04:38:51 -0700 (PDT)
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
Subject: [PATCH net-next v4 1/5] net: gro: remove is_ipv6 from napi_gro_cb
Date: Mon,  1 Sep 2025 13:38:22 +0200
Message-Id: <20250901113826.6508-2-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250901113826.6508-1-richardbgobert@gmail.com>
References: <20250901113826.6508-1-richardbgobert@gmail.com>
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


