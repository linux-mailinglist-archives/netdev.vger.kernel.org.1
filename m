Return-Path: <netdev+bounces-18722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8D2758609
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 22:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED2772816F6
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 20:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD734174C6;
	Tue, 18 Jul 2023 20:24:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECFE134B4
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 20:24:41 +0000 (UTC)
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC311F9
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 13:24:39 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id af79cd13be357-7656c94fc4eso766162885a.2
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 13:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689711879; x=1692303879;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6DjBns0EoBhY1+WDQX2QUHQs/gDhxUgddBrDGZH7ZTk=;
        b=RmSiCv5fF+rVQ2eL888N75mL8dC30KfNai7a1SUr12Hkt55OW2m/73egNvwidiUuBT
         R/Zcfhog3cMqj9wYyK8oY6ejmC7oeszAXbKAAeQk/doCgPtKcQcYS4AOUi027Q4fpFyM
         IB6vBaLczR18ibcpKnfWtREyMSAdcg53WEOGul4L/Y54ORnIcDdJf8wYcSjgiEzKCTpA
         G/GZVEpPO+Ah0WnreI522J+JBck6odjRRTOVwOnw39sTiM6fgLln3HIvUzCgL+B3MgXY
         3UL/6WoHDvqt/rz4s9zvJLKqaX8W99nugxqPUy1AhCL6n3ApcKcu2xakdGu0M0y7bNLY
         ZIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689711879; x=1692303879;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6DjBns0EoBhY1+WDQX2QUHQs/gDhxUgddBrDGZH7ZTk=;
        b=JqWdBHpwJbrADqTwhhHvWPNnDPsW/ljmgPgiwqTRTAwMMrQy9DThWfitAxK+v+cQHy
         hh8WeKGM+BuGCcpVqe5iPP1F+7mCFZ1NIYOb/fEFcfgjaCUScUq7rsFQBkRXP596liEH
         1bZ2zkYxTtqa1jydmOIJBgy0f3eOBRZ+SMhePRDvgvoSmtqLE7S0dwGGCnUpdiGvUSMt
         xvZBakqIr71ZU2CYZyVkE5s3748gtYBWIGcAk1iAb6DrRCa9Y+uPvR/LDl2q4Aa/cbta
         MzSaVF2ZBWKQwUcIRHzsaRNqJT/wfJVIUjh/+K64T6dzBjWvEqYEsTp0z/LJ3QU3kElQ
         kiNw==
X-Gm-Message-State: ABy/qLalqW23obWLyrxDPQO20evCBCEelyB42Bv3evCSc/tmP7uu8uQu
	98oAPN2O8V5ajClOshiRY2nIYYrQocUiYw==
X-Google-Smtp-Source: APBJJlFmhjNEBRISisYsJJlstjofpNg3vNg0Y6fiL4JgQ6NnZnt9GcNFXgDBPyuW5gRxzbruaZgueOqU1kPCrw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:620a:2906:b0:765:ada6:5733 with SMTP
 id m6-20020a05620a290600b00765ada65733mr80284qkp.10.1689711879026; Tue, 18
 Jul 2023 13:24:39 -0700 (PDT)
Date: Tue, 18 Jul 2023 20:24:37 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230718202437.1788505-1-edumazet@google.com>
Subject: [PATCH net-next] ipv6: remove hard coded limitation on ipv6_pinfo
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>, 
	Coco Li <lixiaoyan@google.com>, YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

IPv6 inet sockets are supposed to have a "struct ipv6_pinfo"
field at the end of their definition, so that inet6_sk_generic()
can derive from socket size the offset of the "struct ipv6_pinfo".

This is very fragile, and prevents adding bigger alignment
in sockets, because inet6_sk_generic() does not work
if the compiler adds padding after the ipv6_pinfo component.

We are currently working on a patch series to reorganize
TCP structures for better data locality and found issues
similar to the one fixed in commit f5d547676ca0
("tcp: fix tcp_inet6_sk() for 32bit kernels")

Alternative would be to force an alignment on "struct ipv6_pinfo",
greater or equal to __alignof__(any ipv6 sock) to ensure there is
no padding. This does not look great.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Chao Wu <wwchao@google.com>
Cc: Wei Wang <weiwan@google.com>
Cc: Coco Li <lixiaoyan@google.com>
Cc: YiFei Zhu <zhuyifei@google.com>
---
 include/linux/ipv6.h | 15 ++++-----------
 include/net/sock.h   |  1 +
 net/dccp/ipv6.c      |  1 +
 net/dccp/ipv6.h      |  4 ----
 net/ipv6/af_inet6.c  |  4 ++--
 net/ipv6/ping.c      |  1 +
 net/ipv6/raw.c       |  1 +
 net/ipv6/tcp_ipv6.c  |  1 +
 net/ipv6/udp.c       |  1 +
 net/ipv6/udplite.c   |  1 +
 net/l2tp/l2tp_ip6.c  |  4 +---
 net/mptcp/protocol.c |  1 +
 net/sctp/socket.c    |  1 +
 13 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 839247a4f48ea76b5d6daa9a54a7b87627635066..660012997f54ca12274f3c61e2ef1f42a7655ce9 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -199,14 +199,7 @@ struct inet6_cork {
 	u8 tclass;
 };
 
-/**
- * struct ipv6_pinfo - ipv6 private area
- *
- * In the struct sock hierarchy (tcp6_sock, upd6_sock, etc)
- * this _must_ be the last member, so that inet6_sk_generic
- * is able to calculate its offset from the base struct sock
- * by using the struct proto->slab_obj_size member. -acme
- */
+/* struct ipv6_pinfo - ipv6 private area */
 struct ipv6_pinfo {
 	struct in6_addr 	saddr;
 	struct in6_pktinfo	sticky_pktinfo;
@@ -306,19 +299,19 @@ struct raw6_sock {
 	__u32			offset;		/* checksum offset  */
 	struct icmp6_filter	filter;
 	__u32			ip6mr_table;
-	/* ipv6_pinfo has to be the last member of raw6_sock, see inet6_sk_generic */
+
 	struct ipv6_pinfo	inet6;
 };
 
 struct udp6_sock {
 	struct udp_sock	  udp;
-	/* ipv6_pinfo has to be the last member of udp6_sock, see inet6_sk_generic */
+
 	struct ipv6_pinfo inet6;
 };
 
 struct tcp6_sock {
 	struct tcp_sock	  tcp;
-	/* ipv6_pinfo has to be the last member of tcp6_sock, see inet6_sk_generic */
+
 	struct ipv6_pinfo inet6;
 };
 
diff --git a/include/net/sock.h b/include/net/sock.h
index 2eb916d1ff64866671a2197965eb857b47b810d9..7ae44bf866af5cd788ff10021a441d96b1f8d937 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1339,6 +1339,7 @@ struct proto {
 
 	struct kmem_cache	*slab;
 	unsigned int		obj_size;
+	unsigned int		ipv6_pinfo_offset;
 	slab_flags_t		slab_flags;
 	unsigned int		useroffset;	/* Usercopy region offset */
 	unsigned int		usersize;	/* Usercopy region size */
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index 7249ef218178743ce7936fcf2f605616a419370e..e03b5331df6d71722dd4ab0a444ada7b06958ee6 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -1056,6 +1056,7 @@ static struct proto dccp_v6_prot = {
 	.orphan_count	   = &dccp_orphan_count,
 	.max_header	   = MAX_DCCP_HEADER,
 	.obj_size	   = sizeof(struct dccp6_sock),
+	.ipv6_pinfo_offset = offsetof(struct dccp6_sock, inet6),
 	.slab_flags	   = SLAB_TYPESAFE_BY_RCU,
 	.rsk_prot	   = &dccp6_request_sock_ops,
 	.twsk_prot	   = &dccp6_timewait_sock_ops,
diff --git a/net/dccp/ipv6.h b/net/dccp/ipv6.h
index 7e4c2a3b322b51377ebf7575cfae49aeb51510a2..c5d14c48def179958207c8c3d62b83176183ef74 100644
--- a/net/dccp/ipv6.h
+++ b/net/dccp/ipv6.h
@@ -13,10 +13,6 @@
 
 struct dccp6_sock {
 	struct dccp_sock  dccp;
-	/*
-	 * ipv6_pinfo has to be the last member of dccp6_sock,
-	 * see inet6_sk_generic.
-	 */
 	struct ipv6_pinfo inet6;
 };
 
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 5d593ddc0347ebd13788b1319990f167de833d9a..9f9c4b838664a76cb4d7efbeb16056e22f12b358 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -102,9 +102,9 @@ bool ipv6_mod_enabled(void)
 }
 EXPORT_SYMBOL_GPL(ipv6_mod_enabled);
 
-static __inline__ struct ipv6_pinfo *inet6_sk_generic(struct sock *sk)
+static struct ipv6_pinfo *inet6_sk_generic(struct sock *sk)
 {
-	const int offset = sk->sk_prot->obj_size - sizeof(struct ipv6_pinfo);
+	const int offset = sk->sk_prot->ipv6_pinfo_offset;
 
 	return (struct ipv6_pinfo *)(((u8 *)sk) + offset);
 }
diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
index f804c11e2146cba9e9b8c10337341dc3fb4e0143..2a0e8bc0739831e744bcbf47c3777f793fe710ac 100644
--- a/net/ipv6/ping.c
+++ b/net/ipv6/ping.c
@@ -215,6 +215,7 @@ struct proto pingv6_prot = {
 	.get_port =	ping_get_port,
 	.put_port =	ping_unhash,
 	.obj_size =	sizeof(struct raw6_sock),
+	.ipv6_pinfo_offset = offsetof(struct raw6_sock, inet6),
 };
 EXPORT_SYMBOL_GPL(pingv6_prot);
 
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index ac1cef094c5f200d34a45eeb06f2f7356c87ad6d..0fcf1b8908079d459e2a29822a116ff7eac06b67 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -1216,6 +1216,7 @@ struct proto rawv6_prot = {
 	.hash		   = raw_hash_sk,
 	.unhash		   = raw_unhash_sk,
 	.obj_size	   = sizeof(struct raw6_sock),
+	.ipv6_pinfo_offset = offsetof(struct raw6_sock, inet6),
 	.useroffset	   = offsetof(struct raw6_sock, filter),
 	.usersize	   = sizeof_field(struct raw6_sock, filter),
 	.h.raw_hash	   = &raw_v6_hashinfo,
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 40dd92a2f4807960c7939a19adccdd1b493c30b1..c9d41c77d39392a3f1f0e5c256e379cf92fc4a9e 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -2175,6 +2175,7 @@ struct proto tcpv6_prot = {
 	.sysctl_rmem_offset	= offsetof(struct net, ipv4.sysctl_tcp_rmem),
 	.max_header		= MAX_TCP_HEADER,
 	.obj_size		= sizeof(struct tcp6_sock),
+	.ipv6_pinfo_offset = offsetof(struct tcp6_sock, inet6),
 	.slab_flags		= SLAB_TYPESAFE_BY_RCU,
 	.twsk_prot		= &tcp6_timewait_sock_ops,
 	.rsk_prot		= &tcp6_request_sock_ops,
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index b7c972aa09a75404e0edb33f0354c53702c991f8..95c75d8f73d5144a0e8b024fc42b3d78b5d4e00b 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1798,6 +1798,7 @@ struct proto udpv6_prot = {
 	.sysctl_wmem_offset     = offsetof(struct net, ipv4.sysctl_udp_wmem_min),
 	.sysctl_rmem_offset     = offsetof(struct net, ipv4.sysctl_udp_rmem_min),
 	.obj_size		= sizeof(struct udp6_sock),
+	.ipv6_pinfo_offset = offsetof(struct udp6_sock, inet6),
 	.h.udp_table		= NULL,
 	.diag_destroy		= udp_abort,
 };
diff --git a/net/ipv6/udplite.c b/net/ipv6/udplite.c
index 8e010d07917a7a0e20cce05251a1c49605bba757..267d491e970753a1bb16babb8fbe85cd67cd7062 100644
--- a/net/ipv6/udplite.c
+++ b/net/ipv6/udplite.c
@@ -67,6 +67,7 @@ struct proto udplitev6_prot = {
 	.sysctl_wmem_offset = offsetof(struct net, ipv4.sysctl_udp_wmem_min),
 	.sysctl_rmem_offset = offsetof(struct net, ipv4.sysctl_udp_rmem_min),
 	.obj_size	   = sizeof(struct udp6_sock),
+	.ipv6_pinfo_offset = offsetof(struct udp6_sock, inet6),
 	.h.udp_table	   = &udplite_table,
 };
 
diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index b1623f9c4f921791ab541ecf93695ea19addaa5a..2eee95a00c0534b69c0e5170800ff2dedda8c5bc 100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -36,9 +36,6 @@ struct l2tp_ip6_sock {
 	u32			conn_id;
 	u32			peer_conn_id;
 
-	/* ipv6_pinfo has to be the last member of l2tp_ip6_sock, see
-	 * inet6_sk_generic
-	 */
 	struct ipv6_pinfo	inet6;
 };
 
@@ -730,6 +727,7 @@ static struct proto l2tp_ip6_prot = {
 	.hash		   = l2tp_ip6_hash,
 	.unhash		   = l2tp_ip6_unhash,
 	.obj_size	   = sizeof(struct l2tp_ip6_sock),
+	.ipv6_pinfo_offset = offsetof(struct l2tp_ip6_sock, inet6),
 };
 
 static const struct proto_ops l2tp_ip6_ops = {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3613489eb6e3b0871da09f06561cc251fe2e0b80..b4d5cc0196c3d73f98c484b01a61322926da2f14 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3988,6 +3988,7 @@ int __init mptcp_proto_v6_init(void)
 	strcpy(mptcp_v6_prot.name, "MPTCPv6");
 	mptcp_v6_prot.slab = NULL;
 	mptcp_v6_prot.obj_size = sizeof(struct mptcp6_sock);
+	mptcp_v6_prot.ipv6_pinfo_offset = offsetof(struct mptcp6_sock, np),
 
 	err = proto_register(&mptcp_v6_prot, 1);
 	if (err)
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 9388d98aebc033f195e56d5295fd998996d41f7e..6e3d28aa587cdb64f7a1ac384fa28a34d4c6739c 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -9732,6 +9732,7 @@ struct proto sctpv6_prot = {
 	.unhash		= sctp_unhash,
 	.no_autobind	= true,
 	.obj_size	= sizeof(struct sctp6_sock),
+	.ipv6_pinfo_offset = offsetof(struct sctp6_sock, inet6),
 	.useroffset	= offsetof(struct sctp6_sock, sctp.subscribe),
 	.usersize	= offsetof(struct sctp6_sock, sctp.initmsg) -
 				offsetof(struct sctp6_sock, sctp.subscribe) +
-- 
2.41.0.255.g8b1d071c50-goog


