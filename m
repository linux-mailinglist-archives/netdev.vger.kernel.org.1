Return-Path: <netdev+bounces-199774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AAAAE1C3F
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DE6E171D7A
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 13:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D8428C87D;
	Fri, 20 Jun 2025 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YnZb+oup"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1697428C855
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750426209; cv=none; b=prwlNazTH4Jhsj9werpW9xJ6DxE2D7E891ZDy68NGVt5hcMmc0qKr3Zh1ydeskNcFFJZpykFBsYjyuvvMPBWffsGyUKzY7pg4UeZa+OVoA3teg69rvb/nVYqcyaBuLPuXvNEUk+M6LwXRCLA6Ubgf7qmCTjAjiobsI69hUsMW2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750426209; c=relaxed/simple;
	bh=4n7W6qoa/siTIbpr7k96opcQbrcyI9EqykfaDZoKxUI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FnKjxHca8TF1D55KPKNeXfcSZ5KywBn7wO+KJLnF9RposjQpoZRCT2WlVr4lqxb/uOu/4sTw0Dc3Er45Iq4q51UcLAx0CUnMJSL/O2iMouWNfRlEDT2B+X5Tyrw2kHyVzoshx/bQvIKQSioot5IUpqBeD3ajm0kfhB4BTKs8Hc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YnZb+oup; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7d3cbf784acso485920585a.0
        for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 06:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750426206; x=1751031006; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bxqe+INWE7sI1m7RzvYx2G1bbeQPZHG5t+TiYYT0R08=;
        b=YnZb+oupPRxAWZptDiOZurkWXhOk5NmE0/VpcUh3qojFe3MSI0zyBdEqmoKK4C5iCP
         Z8v6LjZDRCuvAKTIgUaocimw7nr643NAS/oONgGPGqNzxkA0BaldJMgmR2uZebO6rKN5
         HE2yZtYoHP2Zhv2GtBFMtt9kl2i25JOPiMWE2Jr3GzG6Eh5PML3EJMSjvJSfd6M80XRc
         HqGa4sjFAuLHWVnhGwfD2JbQvvpb1cMZXkz93c8SfLEUuMc/Uu2dv/MVJU0XH2ON5BHo
         t/w1+tFnVftrERg5IRs3Tp0q8eWpegmJK6LUDKoX2xaFHRzmIW3FKlZe8ihsnHV4G59V
         Ayyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750426206; x=1751031006;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bxqe+INWE7sI1m7RzvYx2G1bbeQPZHG5t+TiYYT0R08=;
        b=UNCMaffsRHWEKyRAPieKXwljEA0N4uPQ3ry7jyVhQgdvBfTaDfUVle0iZKPAvbGouQ
         jkVPld34su1m88O2qNlzzRDweEXBNx40+rswTZcIeR3uKXAuOLqzzOIBnkdsyK3CvzNX
         6lHNn3FIcVlB2+neDGVLS6G6vEuYlCjQYjUbR7P8/HVD/oTq1CfiWChe13Opa53Wyam/
         7ZBg2R1CJwkGTsN34yP0GBaQIazpmi5SI6zyeXcScjbKJIgGbx44KUDfOOriXRSq/bUk
         WX5kDe1SaLhenOhc+sT7iEYkPvVV1QdqG44Momh7ztIqjM/Cy6ksIKMAI/RqMiUmojFk
         kmNw==
X-Forwarded-Encrypted: i=1; AJvYcCV/eh9yxGwLUcf01AWFSSPtJrwbeT+mEYVNegG+d0nemCp3xfp1mCwffagb6RpZ4rHDYTlfB2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJv0MsthI9UMDnJSRnqnmT1UBUmBH8sJJev1KUQ2bdPyL5byKL
	SN+sIN63NZwI/DDXJTlwEwt/wNUVMUzJK15jofaedJo69uo1/MFHJ5co604aTEAEn2coqmimzXK
	R9nOLO7VSIIuEsQ==
X-Google-Smtp-Source: AGHT+IF80p1xvoBgHbf4gdaWnnuHios9fxpKqy3OZC27Mr/1sAdDN6L3AEo+bZ1Gf6KawqhT6SB0Fxg+EM4jdw==
X-Received: from qknpw8.prod.google.com ([2002:a05:620a:63c8:b0:7ce:c274:8d6])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4114:b0:7d0:996f:9c48 with SMTP id af79cd13be357-7d3f98c9b78mr482554185a.9.1750426205910;
 Fri, 20 Jun 2025 06:30:05 -0700 (PDT)
Date: Fri, 20 Jun 2025 13:30:00 +0000
In-Reply-To: <20250620133001.4090592-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620133001.4090592-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620133001.4090592-2-edumazet@google.com>
Subject: [PATCH net-next 1/2] net: annotate races around sk->sk_uid
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Lorenzo Colitti <lorenzo@google.com>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

sk->sk_uid can be read while another thread changes its
value in sockfs_setattr().

Add sk_uid(const struct sock *sk) helper to factorize the needed
READ_ONCE() annotations, and add corresponding WRITE_ONCE()
where needed.

Fixes: 86741ec25462 ("net: core: Add a UID field to struct sock.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
---
 include/net/route.h              |  4 ++--
 include/net/sock.h               | 12 ++++++++++--
 net/ipv4/inet_connection_sock.c  |  4 ++--
 net/ipv4/ping.c                  |  2 +-
 net/ipv4/raw.c                   |  2 +-
 net/ipv4/route.c                 |  3 ++-
 net/ipv4/syncookies.c            |  3 ++-
 net/ipv4/udp.c                   |  3 ++-
 net/ipv6/af_inet6.c              |  2 +-
 net/ipv6/datagram.c              |  2 +-
 net/ipv6/inet6_connection_sock.c |  4 ++--
 net/ipv6/ping.c                  |  2 +-
 net/ipv6/raw.c                   |  2 +-
 net/ipv6/route.c                 |  4 ++--
 net/ipv6/syncookies.c            |  2 +-
 net/ipv6/tcp_ipv6.c              |  2 +-
 net/ipv6/udp.c                   |  5 +++--
 net/l2tp/l2tp_ip6.c              |  2 +-
 net/mptcp/protocol.c             |  2 +-
 net/socket.c                     |  8 +++++---
 20 files changed, 42 insertions(+), 28 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index 8e39aa822cf98601fbf98a0837e2718c07abca9a..3d3d6048ffca2b09b7e8885b04dd3f6db7a3e5cb 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -153,7 +153,7 @@ static inline void inet_sk_init_flowi4(const struct inet_sock *inet,
 			   ip_sock_rt_tos(sk), ip_sock_rt_scope(sk),
 			   sk->sk_protocol, inet_sk_flowi_flags(sk), daddr,
 			   inet->inet_saddr, inet->inet_dport,
-			   inet->inet_sport, sk->sk_uid);
+			   inet->inet_sport, sk_uid(sk));
 	security_sk_classify_flow(sk, flowi4_to_flowi_common(fl4));
 }
 
@@ -331,7 +331,7 @@ static inline void ip_route_connect_init(struct flowi4 *fl4, __be32 dst,
 
 	flowi4_init_output(fl4, oif, READ_ONCE(sk->sk_mark), ip_sock_rt_tos(sk),
 			   ip_sock_rt_scope(sk), protocol, flow_flags, dst,
-			   src, dport, sport, sk->sk_uid);
+			   src, dport, sport, sk_uid(sk));
 }
 
 static inline struct rtable *ip_route_connect(struct flowi4 *fl4, __be32 dst,
diff --git a/include/net/sock.h b/include/net/sock.h
index ca532227cbfda1eb51f67532cbbbdc79a41c98d6..fc5e6f66b00a0c0786d29c8967738e45ab673071 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2076,6 +2076,7 @@ static inline void sock_orphan(struct sock *sk)
 	sock_set_flag(sk, SOCK_DEAD);
 	sk_set_socket(sk, NULL);
 	sk->sk_wq  = NULL;
+	/* Note: sk_uid is unchanged. */
 	write_unlock_bh(&sk->sk_callback_lock);
 }
 
@@ -2086,18 +2087,25 @@ static inline void sock_graft(struct sock *sk, struct socket *parent)
 	rcu_assign_pointer(sk->sk_wq, &parent->wq);
 	parent->sk = sk;
 	sk_set_socket(sk, parent);
-	sk->sk_uid = SOCK_INODE(parent)->i_uid;
+	WRITE_ONCE(sk->sk_uid, SOCK_INODE(parent)->i_uid);
 	security_sock_graft(sk, parent);
 	write_unlock_bh(&sk->sk_callback_lock);
 }
 
 kuid_t sock_i_uid(struct sock *sk);
+
+static inline kuid_t sk_uid(const struct sock *sk)
+{
+	/* Paired with WRITE_ONCE() in sockfs_setattr() */
+	return READ_ONCE(sk->sk_uid);
+}
+
 unsigned long __sock_i_ino(struct sock *sk);
 unsigned long sock_i_ino(struct sock *sk);
 
 static inline kuid_t sock_net_uid(const struct net *net, const struct sock *sk)
 {
-	return sk ? sk->sk_uid : make_kuid(net->user_ns, 0);
+	return sk ? sk_uid(sk) : make_kuid(net->user_ns, 0);
 }
 
 static inline u32 net_tx_rndhash(void)
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 6906bedad19a13d3f62100058d6a20debbf6a88e..46750c96d08ea3ed4d6b693618dbb79d7ebfedc0 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -812,7 +812,7 @@ struct dst_entry *inet_csk_route_req(const struct sock *sk,
 			   sk->sk_protocol, inet_sk_flowi_flags(sk),
 			   (opt && opt->opt.srr) ? opt->opt.faddr : ireq->ir_rmt_addr,
 			   ireq->ir_loc_addr, ireq->ir_rmt_port,
-			   htons(ireq->ir_num), sk->sk_uid);
+			   htons(ireq->ir_num), sk_uid(sk));
 	security_req_classify_flow(req, flowi4_to_flowi_common(fl4));
 	rt = ip_route_output_flow(net, fl4, sk);
 	if (IS_ERR(rt))
@@ -849,7 +849,7 @@ struct dst_entry *inet_csk_route_child_sock(const struct sock *sk,
 			   sk->sk_protocol, inet_sk_flowi_flags(sk),
 			   (opt && opt->opt.srr) ? opt->opt.faddr : ireq->ir_rmt_addr,
 			   ireq->ir_loc_addr, ireq->ir_rmt_port,
-			   htons(ireq->ir_num), sk->sk_uid);
+			   htons(ireq->ir_num), sk_uid(sk));
 	security_req_classify_flow(req, flowi4_to_flowi_common(fl4));
 	rt = ip_route_output_flow(net, fl4, sk);
 	if (IS_ERR(rt))
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index c14baa6589c748026b49416688cbea399e6d461a..4eacaf00e2e9b7780090af4d10a9f974918282fd 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -781,7 +781,7 @@ static int ping_v4_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	flowi4_init_output(&fl4, ipc.oif, ipc.sockc.mark,
 			   ipc.tos & INET_DSCP_MASK, scope,
 			   sk->sk_protocol, inet_sk_flowi_flags(sk), faddr,
-			   saddr, 0, 0, sk->sk_uid);
+			   saddr, 0, 0, sk_uid(sk));
 
 	fl4.fl4_icmp_type = user_icmph.type;
 	fl4.fl4_icmp_code = user_icmph.code;
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 6aace4d55733e233c932db6f3e644eaf86b40411..32f942d0f944cc3e60448d9d24ab0ae2b03e73e6 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -610,7 +610,7 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 			   hdrincl ? ipc.protocol : sk->sk_protocol,
 			   inet_sk_flowi_flags(sk) |
 			    (hdrincl ? FLOWI_FLAG_KNOWN_NH : 0),
-			   daddr, saddr, 0, 0, sk->sk_uid);
+			   daddr, saddr, 0, 0, sk_uid(sk));
 
 	fl4.fl4_icmp_type = 0;
 	fl4.fl4_icmp_code = 0;
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 3ddf6bf4035790d6a19dd6e27f5ade5a6f2bb432..3ff2bd56d05010e1b8f8d65ae3808bf20313a9c8 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -556,7 +556,8 @@ static void build_sk_flow_key(struct flowi4 *fl4, const struct sock *sk)
 			   inet_test_bit(HDRINCL, sk) ?
 				IPPROTO_RAW : sk->sk_protocol,
 			   inet_sk_flowi_flags(sk),
-			   daddr, inet->inet_saddr, 0, 0, sk->sk_uid);
+			   daddr, inet->inet_saddr, 0, 0,
+			   sk_uid(sk));
 	rcu_read_unlock();
 }
 
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 5459a78b9809594e4c9e5a69dd1156a3e0cc06bc..eb0819463faed70dc6c6466043ded8efafef5150 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -454,7 +454,8 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 			   ip_sock_rt_tos(sk), ip_sock_rt_scope(sk),
 			   IPPROTO_TCP, inet_sk_flowi_flags(sk),
 			   opt->srr ? opt->faddr : ireq->ir_rmt_addr,
-			   ireq->ir_loc_addr, th->source, th->dest, sk->sk_uid);
+			   ireq->ir_loc_addr, th->source, th->dest,
+			   sk_uid(sk));
 	security_req_classify_flow(req, flowi4_to_flowi_common(&fl4));
 	rt = ip_route_output_key(net, &fl4);
 	if (IS_ERR(rt)) {
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index dde52b8050b8ca251ae13f20853c6c9512453dd0..f94bb222aa2d4919ffd60b51ed74b536fb9a218d 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1445,7 +1445,8 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		flowi4_init_output(fl4, ipc.oif, ipc.sockc.mark,
 				   ipc.tos & INET_DSCP_MASK, scope,
 				   sk->sk_protocol, flow_flags, faddr, saddr,
-				   dport, inet->inet_sport, sk->sk_uid);
+				   dport, inet->inet_sport,
+				   sk_uid(sk));
 
 		security_sk_classify_flow(sk, flowi4_to_flowi_common(fl4));
 		rt = ip_route_output_flow(net, fl4, sk);
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index acaff129678353d84efad48b5e38693d03e6034e..1992621e3f3f4b5b5c63e857b7b1c90576d3766e 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -842,7 +842,7 @@ int inet6_sk_rebuild_header(struct sock *sk)
 		fl6.flowi6_mark = sk->sk_mark;
 		fl6.fl6_dport = inet->inet_dport;
 		fl6.fl6_sport = inet->inet_sport;
-		fl6.flowi6_uid = sk->sk_uid;
+		fl6.flowi6_uid = sk_uid(sk);
 		security_sk_classify_flow(sk, flowi6_to_flowi_common(&fl6));
 
 		rcu_read_lock();
diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index fff78496803da6158d8b6e70255a56f183e26a80..83f5aa5e133ab291b46fe73eff4cb12954834340 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -53,7 +53,7 @@ static void ip6_datagram_flow_key_init(struct flowi6 *fl6,
 	fl6->fl6_dport = inet->inet_dport;
 	fl6->fl6_sport = inet->inet_sport;
 	fl6->flowlabel = ip6_make_flowinfo(np->tclass, np->flow_label);
-	fl6->flowi6_uid = sk->sk_uid;
+	fl6->flowi6_uid = sk_uid(sk);
 
 	if (!oif)
 		oif = np->sticky_pktinfo.ipi6_ifindex;
diff --git a/net/ipv6/inet6_connection_sock.c b/net/ipv6/inet6_connection_sock.c
index 8f500eaf33cfc4b3f7fa57a1fb6f8e8e01fc5af5..333e43434dd78d73f960708a327c704a185e88d3 100644
--- a/net/ipv6/inet6_connection_sock.c
+++ b/net/ipv6/inet6_connection_sock.c
@@ -45,7 +45,7 @@ struct dst_entry *inet6_csk_route_req(const struct sock *sk,
 	fl6->flowi6_mark = ireq->ir_mark;
 	fl6->fl6_dport = ireq->ir_rmt_port;
 	fl6->fl6_sport = htons(ireq->ir_num);
-	fl6->flowi6_uid = sk->sk_uid;
+	fl6->flowi6_uid = sk_uid(sk);
 	security_req_classify_flow(req, flowi6_to_flowi_common(fl6));
 
 	dst = ip6_dst_lookup_flow(sock_net(sk), sk, fl6, final_p);
@@ -79,7 +79,7 @@ static struct dst_entry *inet6_csk_route_socket(struct sock *sk,
 	fl6->flowi6_mark = sk->sk_mark;
 	fl6->fl6_sport = inet->inet_sport;
 	fl6->fl6_dport = inet->inet_dport;
-	fl6->flowi6_uid = sk->sk_uid;
+	fl6->flowi6_uid = sk_uid(sk);
 	security_sk_classify_flow(sk, flowi6_to_flowi_common(fl6));
 
 	rcu_read_lock();
diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
index 84d90dd8b3f0f7cdf7dd3336c2d7b8e5fc1eefd5..82b0492923d458213ac7a6f9316158af2191e30f 100644
--- a/net/ipv6/ping.c
+++ b/net/ipv6/ping.c
@@ -142,7 +142,7 @@ static int ping_v6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	fl6.saddr = np->saddr;
 	fl6.daddr = *daddr;
 	fl6.flowi6_mark = ipc6.sockc.mark;
-	fl6.flowi6_uid = sk->sk_uid;
+	fl6.flowi6_uid = sk_uid(sk);
 	fl6.fl6_icmp_type = user_icmph.icmp6_type;
 	fl6.fl6_icmp_code = user_icmph.icmp6_code;
 	security_sk_classify_flow(sk, flowi6_to_flowi_common(&fl6));
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index fda640ebd53f86185928cb6f4545be1cafad8698..4c3f8245c40f155f3efde0d7b8af50e0bef431c7 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -777,7 +777,7 @@ static int rawv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	memset(&fl6, 0, sizeof(fl6));
 
 	fl6.flowi6_mark = ipc6.sockc.mark;
-	fl6.flowi6_uid = sk->sk_uid;
+	fl6.flowi6_uid = sk_uid(sk);
 
 	if (sin6) {
 		if (addr_len < SIN6_LEN_RFC2133)
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index df0caffefb3824f5d962ff62f9ee96005ed9c718..d7a9b5bf30c8bd882b6e61ccf4e03e023940ad02 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3011,7 +3011,7 @@ void ip6_sk_update_pmtu(struct sk_buff *skb, struct sock *sk, __be32 mtu)
 		oif = l3mdev_master_ifindex(skb->dev);
 
 	ip6_update_pmtu(skb, sock_net(sk), mtu, oif, READ_ONCE(sk->sk_mark),
-			sk->sk_uid);
+			sk_uid(sk));
 
 	dst = __sk_dst_get(sk);
 	if (!dst || !dst->obsolete ||
@@ -3233,7 +3233,7 @@ void ip6_redirect_no_header(struct sk_buff *skb, struct net *net, int oif)
 void ip6_sk_redirect(struct sk_buff *skb, struct sock *sk)
 {
 	ip6_redirect(skb, sock_net(sk), sk->sk_bound_dev_if,
-		     READ_ONCE(sk->sk_mark), sk->sk_uid);
+		     READ_ONCE(sk->sk_mark), sk_uid(sk));
 }
 EXPORT_SYMBOL_GPL(ip6_sk_redirect);
 
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 9d83eadd308b0cb35026db0ab0216c936464cc33..f0ee1a9097716680786632dc3bf6753be32dfbb3 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -236,7 +236,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 		fl6.flowi6_mark = ireq->ir_mark;
 		fl6.fl6_dport = ireq->ir_rmt_port;
 		fl6.fl6_sport = inet_sk(sk)->inet_sport;
-		fl6.flowi6_uid = sk->sk_uid;
+		fl6.flowi6_uid = sk_uid(sk);
 		security_req_classify_flow(req, flowi6_to_flowi_common(&fl6));
 
 		dst = ip6_dst_lookup_flow(net, sk, &fl6, final_p);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index e8e68a14264991132656ddaa8dd9bb84bb586c97..f61b0396ef6b1831592c40862caabd73abd92489 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -269,7 +269,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr *uaddr,
 	fl6.fl6_sport = inet->inet_sport;
 	if (IS_ENABLED(CONFIG_IP_ROUTE_MULTIPATH) && !fl6.fl6_sport)
 		fl6.flowi6_flags = FLOWI_FLAG_ANY_SPORT;
-	fl6.flowi6_uid = sk->sk_uid;
+	fl6.flowi6_uid = sk_uid(sk);
 
 	opt = rcu_dereference_protected(np->opt, lockdep_sock_is_held(sk));
 	final_p = fl6_update_dst(&fl6, opt, &final);
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 7317f8e053f1c28aae740b087b1c68898757006e..ebb95d8bc6819f72842fd1567e73fcef4f1e0ed0 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -750,7 +750,8 @@ int __udp6_lib_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	if (type == NDISC_REDIRECT) {
 		if (tunnel) {
 			ip6_redirect(skb, sock_net(sk), inet6_iif(skb),
-				     READ_ONCE(sk->sk_mark), sk->sk_uid);
+				     READ_ONCE(sk->sk_mark),
+				     sk_uid(sk));
 		} else {
 			ip6_sk_redirect(skb, sk);
 		}
@@ -1620,7 +1621,7 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	if (!fl6->flowi6_oif)
 		fl6->flowi6_oif = np->sticky_pktinfo.ipi6_ifindex;
 
-	fl6->flowi6_uid = sk->sk_uid;
+	fl6->flowi6_uid = sk_uid(sk);
 
 	if (msg->msg_controllen) {
 		opt = &opt_space;
diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index b98d13584c81f0e2c7182b89ba4357f224a79580..ea232f338dcb65d1905f842b907d2cb8230f2f6b 100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -545,7 +545,7 @@ static int l2tp_ip6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	memset(&fl6, 0, sizeof(fl6));
 
 	fl6.flowi6_mark = READ_ONCE(sk->sk_mark);
-	fl6.flowi6_uid = sk->sk_uid;
+	fl6.flowi6_uid = sk_uid(sk);
 
 	ipcm6_init_sk(&ipc6, sk);
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index edf14c2c20622e38b697f3a291838282ef5a8ddb..e7972e633236e0451f0321ff4b0a8d1b37282d5f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3503,7 +3503,7 @@ void mptcp_sock_graft(struct sock *sk, struct socket *parent)
 	write_lock_bh(&sk->sk_callback_lock);
 	rcu_assign_pointer(sk->sk_wq, &parent->wq);
 	sk_set_socket(sk, parent);
-	sk->sk_uid = SOCK_INODE(parent)->i_uid;
+	WRITE_ONCE(sk->sk_uid, SOCK_INODE(parent)->i_uid);
 	write_unlock_bh(&sk->sk_callback_lock);
 }
 
diff --git a/net/socket.c b/net/socket.c
index 2cab805943c0718c40ddea19fb72d58a9eac18ca..682969deaed35df05666cc7711e5e29f7a445c07 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -592,10 +592,12 @@ static int sockfs_setattr(struct mnt_idmap *idmap,
 	if (!err && (iattr->ia_valid & ATTR_UID)) {
 		struct socket *sock = SOCKET_I(d_inode(dentry));
 
-		if (sock->sk)
-			sock->sk->sk_uid = iattr->ia_uid;
-		else
+		if (sock->sk) {
+			/* Paired with READ_ONCE() in sk_uid() */
+			WRITE_ONCE(sock->sk->sk_uid, iattr->ia_uid);
+		} else {
 			err = -ENOENT;
+		}
 	}
 
 	return err;
-- 
2.50.0.rc2.701.gf1e915cc24-goog


