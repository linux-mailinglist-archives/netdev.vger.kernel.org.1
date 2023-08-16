Return-Path: <netdev+bounces-27954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7106677DBFE
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 10:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27DBF281833
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 08:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E2EDF63;
	Wed, 16 Aug 2023 08:16:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B94F9ED
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 08:16:08 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0C294
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 01:16:06 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d6ac5db336eso3254329276.2
        for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 01:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692173766; x=1692778566;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RR5/LgCvcfgoUMKsvSJA+Ck+LBt9RczJO91a+TRiag4=;
        b=I1kMZCXi0ob0MFEYgfi8G/1ylBVwFTR8MtAPc0t7weR0AuVbEsgkIHi2Bfnav6qGRb
         ZrEodtn5F1QmB/ZDo+F56kTgPM9II2PbKBSddtdW4RMBKADY4oilCSRg9IG9QMbkdUF+
         szSHdoHAkAuAZTrtj/J3Pd6b9KlmC44sYKt+1OeVuWP7ryh2rifH1uq9a5WIoPz/kGet
         cjHhVr9qO3hlvvsLZZ+iBD8mVcAPyjyUiapdTqMyoab0a846icMMPGsUm2A0Gv2snwpW
         SH7DELy0EGNoINm3Q1Zp+ILci+CGd7/Gp/r/VwA8NYy4bTD5OQI1sbbwUZspb3LFwYh8
         5fJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692173766; x=1692778566;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RR5/LgCvcfgoUMKsvSJA+Ck+LBt9RczJO91a+TRiag4=;
        b=Bs0ENzCByXV9+0StwIo83jRp7vr7CofMpg2QcMG5BlPB6yIaOoEmpwpzPwlyurSV0+
         PjlyCc6PvHITJXzalTxv4ptMFMo9O0USzLIKL7tqv0pJdReV4ChkWICb+c4SA1MT4lJj
         ssl1d3YXH64o5I7uXUJ9jiHWIamWjATL4/viW9Bw3J/WxdfC6AZK5y1a16s9PAUygBmO
         rrAFeHgbSwR1SPbpQXEMJWeLBhWPY7cWaLBwHKIKamgfyxvX8WbvV+5efZb5RRMerP9f
         7BXFQrFipP19urZGtyxYV6fuCQBhuIghj6DcJI0hoEXahHnWpyrKnby3P8vtBd/kOMXC
         iawg==
X-Gm-Message-State: AOJu0YwD7baWED4RCKyjvT1kW9obkhBkGHADfanK3nyMA+6tfDlj30B8
	ZxVzALI0WfL40CsdHkoL1UdKxyNmWy3JCQ==
X-Google-Smtp-Source: AGHT+IHHHOYPpkpeIE4qQYZdzS69U13qculullYXldqdz5V/7lTVKQoq7RrI88+tnHiGZcVIJGZxRmWIM96uGA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1609:b0:d07:7001:495b with SMTP
 id bw9-20020a056902160900b00d077001495bmr13732ybb.11.1692173765948; Wed, 16
 Aug 2023 01:16:05 -0700 (PDT)
Date: Wed, 16 Aug 2023 08:15:41 +0000
In-Reply-To: <20230816081547.1272409-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230816081547.1272409-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230816081547.1272409-10-edumazet@google.com>
Subject: [PATCH v4 net-next 09/15] inet: move inet->transparent to inet->inet_flags
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>, Soheil Hassas Yeganeh <soheil@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

IP_TRANSPARENT socket option can now be set/read
without locking the socket.

v2: removed unused issk variable in mptcp_setsockopt_sol_ip_set_transparent()
v4: rebased after commit 3f326a821b99 ("mptcp: change the mpc check helper to return a sk")

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 include/net/inet_sock.h       |  6 +++---
 include/net/ipv6.h            |  2 +-
 include/net/route.h           |  2 +-
 include/net/tcp.h             |  2 +-
 net/ipv4/inet_diag.c          |  2 +-
 net/ipv4/inet_timewait_sock.c |  2 +-
 net/ipv4/ip_sockglue.c        | 28 +++++++++++++---------------
 net/ipv4/tcp_input.c          |  2 +-
 net/ipv4/tcp_minisocks.c      |  3 +--
 net/ipv6/ipv6_sockglue.c      |  4 ++--
 net/mptcp/sockopt.c           | 11 +++++------
 11 files changed, 30 insertions(+), 34 deletions(-)

diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index fffd34fa6a7cb92a98e29bd6b36ccf907b5e3a6d..cefd9a60dc6d8432cc685716c2e556be7a7dc2ec 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -231,7 +231,6 @@ struct inet_sock {
 	__u8			mc_ttl;
 	__u8			pmtudisc;
 	__u8			is_icsk:1,
-				transparent:1,
 				nodefrag:1;
 	__u8			bind_address_no_port:1,
 				defer_connect:1; /* Indicates that fastopen_connect is set
@@ -271,6 +270,7 @@ enum {
 	INET_FLAGS_HDRINCL	= 12,
 	INET_FLAGS_MC_LOOP	= 13,
 	INET_FLAGS_MC_ALL	= 14,
+	INET_FLAGS_TRANSPARENT	= 15,
 };
 
 /* cmsg flags for inet */
@@ -397,7 +397,7 @@ static inline __u8 inet_sk_flowi_flags(const struct sock *sk)
 {
 	__u8 flags = 0;
 
-	if (inet_sk(sk)->transparent || inet_test_bit(HDRINCL, sk))
+	if (inet_test_bit(TRANSPARENT, sk) || inet_test_bit(HDRINCL, sk))
 		flags |= FLOWI_FLAG_ANYSRC;
 	return flags;
 }
@@ -424,7 +424,7 @@ static inline bool inet_can_nonlocal_bind(struct net *net,
 {
 	return READ_ONCE(net->ipv4.sysctl_ip_nonlocal_bind) ||
 		test_bit(INET_FLAGS_FREEBIND, &inet->inet_flags) ||
-		inet->transparent;
+		test_bit(INET_FLAGS_TRANSPARENT, &inet->inet_flags);
 }
 
 static inline bool inet_addr_valid_or_nonlocal(struct net *net,
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index fd570d77588e7f7ebfe02ec88e69d0436b6425c4..d40d8238d4c2b9881dbbc17b37898a84050e401f 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -938,7 +938,7 @@ static inline bool ipv6_can_nonlocal_bind(struct net *net,
 {
 	return net->ipv6.sysctl.ip_nonlocal_bind ||
 		test_bit(INET_FLAGS_FREEBIND, &inet->inet_flags) ||
-		inet->transparent;
+		test_bit(INET_FLAGS_TRANSPARENT, &inet->inet_flags);
 }
 
 /* Sysctl settings for net ipv6.auto_flowlabels */
diff --git a/include/net/route.h b/include/net/route.h
index d9ca98d2366ff96a754682f5749037ffcdadcc8e..51a45b1887b562bfb473f9f8c50897d5d3073476 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -298,7 +298,7 @@ static inline void ip_route_connect_init(struct flowi4 *fl4, __be32 dst,
 {
 	__u8 flow_flags = 0;
 
-	if (inet_sk(sk)->transparent)
+	if (inet_test_bit(TRANSPARENT, sk))
 		flow_flags |= FLOWI_FLAG_ANYSRC;
 
 	flowi4_init_output(fl4, oif, READ_ONCE(sk->sk_mark), ip_sock_rt_tos(sk),
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 6d77c08d83b76a8bf4347bbb05dc6e808b5857d0..07b21d9a962072e4fbd3986162458e16a62abfb0 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2031,7 +2031,7 @@ static inline bool inet_sk_transparent(const struct sock *sk)
 	case TCP_NEW_SYN_RECV:
 		return inet_rsk(inet_reqsk(sk))->no_srccheck;
 	}
-	return inet_sk(sk)->transparent;
+	return inet_test_bit(TRANSPARENT, sk);
 }
 
 /* Determines whether this is a thin stream (which may suffer from
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index e009dab80c3546c5222c587531acd394f2eeff0d..45fefd2f31fd7b921d796b0317b72b8858ca9c5b 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -187,7 +187,7 @@ int inet_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
 	inet_sockopt.freebind	= inet_test_bit(FREEBIND, sk);
 	inet_sockopt.hdrincl	= inet_test_bit(HDRINCL, sk);
 	inet_sockopt.mc_loop	= inet_test_bit(MC_LOOP, sk);
-	inet_sockopt.transparent = inet->transparent;
+	inet_sockopt.transparent = inet_test_bit(TRANSPARENT, sk);
 	inet_sockopt.mc_all	= inet_test_bit(MC_ALL, sk);
 	inet_sockopt.nodefrag	= inet->nodefrag;
 	inet_sockopt.bind_address_no_port = inet->bind_address_no_port;
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 2c1b245dba8e8d1403018fb5b8caee1981ee1043..dd37a5bf6881117aafc4f2a0631979c4e3928be6 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -203,7 +203,7 @@ struct inet_timewait_sock *inet_twsk_alloc(const struct sock *sk,
 		tw->tw_reuseport    = sk->sk_reuseport;
 		tw->tw_hash	    = sk->sk_hash;
 		tw->tw_ipv6only	    = 0;
-		tw->tw_transparent  = inet->transparent;
+		tw->tw_transparent  = inet_test_bit(TRANSPARENT, sk);
 		tw->tw_prot	    = sk->sk_prot_creator;
 		atomic64_set(&tw->tw_cookie, atomic64_read(&sk->sk_cookie));
 		twsk_net_set(tw, sock_net(sk));
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 2f27c30a4eccca5d23b70851daeb5115bcc1de16..3f5323a230b3d84048838cb03d648b213bd95fab 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1005,7 +1005,16 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 			return -EINVAL;
 		inet_assign_bit(MC_ALL, sk, val);
 		return 0;
-
+	case IP_TRANSPARENT:
+		if (!!val && !sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) &&
+		    !sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN)) {
+			err = -EPERM;
+			break;
+		}
+		if (optlen < 1)
+			goto e_inval;
+		inet_assign_bit(TRANSPARENT, sk, val);
+		return 0;
 	}
 
 	err = 0;
@@ -1319,17 +1328,6 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 		err = xfrm_user_policy(sk, optname, optval, optlen);
 		break;
 
-	case IP_TRANSPARENT:
-		if (!!val && !sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) &&
-		    !sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN)) {
-			err = -EPERM;
-			break;
-		}
-		if (optlen < 1)
-			goto e_inval;
-		inet->transparent = !!val;
-		break;
-
 	case IP_MINTTL:
 		if (optlen < 1)
 			goto e_inval;
@@ -1585,6 +1583,9 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	case IP_MULTICAST_ALL:
 		val = inet_test_bit(MC_ALL, sk);
 		goto copyval;
+	case IP_TRANSPARENT:
+		val = inet_test_bit(TRANSPARENT, sk);
+		goto copyval;
 	}
 
 	if (needs_rtnl)
@@ -1735,9 +1736,6 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 		len -= msg.msg_controllen;
 		return copy_to_sockptr(optlen, &len, sizeof(int));
 	}
-	case IP_TRANSPARENT:
-		val = inet->transparent;
-		break;
 	case IP_MINTTL:
 		val = inet->min_ttl;
 		break;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index d34d52fdfdb1e0fe25c6c9a0885e581d197aa701..06fe1cf645d5a386331548484de2beb68e846404 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7000,7 +7000,7 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 
 	tmp_opt.tstamp_ok = tmp_opt.saw_tstamp;
 	tcp_openreq_init(req, &tmp_opt, skb, sk);
-	inet_rsk(req)->no_srccheck = inet_sk(sk)->transparent;
+	inet_rsk(req)->no_srccheck = inet_test_bit(TRANSPARENT, sk);
 
 	/* Note: tcp_v6_init_req() might override ir_iif for link locals */
 	inet_rsk(req)->ir_iif = inet_request_bound_dev_if(sk, skb);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 13ee12983c4293afe2ddabe282155be045a2e9b2..b98d476f1594bd8f9a70e6ff53d7f868a15997c5 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -289,9 +289,8 @@ void tcp_time_wait(struct sock *sk, int state, int timeo)
 	if (tw) {
 		struct tcp_timewait_sock *tcptw = tcp_twsk((struct sock *)tw);
 		const int rto = (icsk->icsk_rto << 2) - (icsk->icsk_rto >> 1);
-		struct inet_sock *inet = inet_sk(sk);
 
-		tw->tw_transparent	= inet->transparent;
+		tw->tw_transparent	= inet_test_bit(TRANSPARENT, sk);
 		tw->tw_mark		= sk->sk_mark;
 		tw->tw_priority		= sk->sk_priority;
 		tw->tw_rcv_wscale	= tp->rx_opt.rcv_wscale;
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 3eb38436f8d431ca37200869bfe57ec33b46bf8b..eb334122512c2a7b41dc5f6bc83aaa3c2b946a06 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -633,7 +633,7 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		if (optlen < sizeof(int))
 			goto e_inval;
 		/* we don't have a separate transparent bit for IPV6 we use the one in the IPv4 socket */
-		inet_sk(sk)->transparent = valbool;
+		inet_assign_bit(TRANSPARENT, sk, valbool);
 		retv = 0;
 		break;
 
@@ -1330,7 +1330,7 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 	}
 
 	case IPV6_TRANSPARENT:
-		val = inet_sk(sk)->transparent;
+		val = inet_test_bit(TRANSPARENT, sk);
 		break;
 
 	case IPV6_FREEBIND:
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index ffbe2f5f5b44c3aaf588eb4b8fb3e3594bf2f71c..8260202c00669fd7d2eed2f94a3c2cf225a0d89c 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -416,7 +416,8 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 			sk->sk_ipv6only = ssk->sk_ipv6only;
 			break;
 		case IPV6_TRANSPARENT:
-			inet_sk(sk)->transparent = inet_sk(ssk)->transparent;
+			inet_assign_bit(TRANSPARENT, sk,
+					inet_test_bit(TRANSPARENT, ssk));
 			break;
 		case IPV6_FREEBIND:
 			inet_assign_bit(FREEBIND, sk,
@@ -685,7 +686,6 @@ static int mptcp_setsockopt_sol_ip_set_transparent(struct mptcp_sock *msk, int o
 						   sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = (struct sock *)msk;
-	struct inet_sock *issk;
 	struct sock *ssk;
 	int err;
 
@@ -701,14 +701,13 @@ static int mptcp_setsockopt_sol_ip_set_transparent(struct mptcp_sock *msk, int o
 		return PTR_ERR(ssk);
 	}
 
-	issk = inet_sk(ssk);
-
 	switch (optname) {
 	case IP_FREEBIND:
 		inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));
 		break;
 	case IP_TRANSPARENT:
-		issk->transparent = inet_sk(sk)->transparent;
+		inet_assign_bit(TRANSPARENT, ssk,
+				inet_test_bit(TRANSPARENT, sk));
 		break;
 	default:
 		release_sock(sk);
@@ -1441,7 +1440,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	__tcp_sock_set_cork(ssk, !!msk->cork);
 	__tcp_sock_set_nodelay(ssk, !!msk->nodelay);
 
-	inet_sk(ssk)->transparent = inet_sk(sk)->transparent;
+	inet_assign_bit(TRANSPARENT, ssk, inet_test_bit(TRANSPARENT, sk));
 	inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));
 }
 
-- 
2.41.0.694.ge786442a9b-goog


