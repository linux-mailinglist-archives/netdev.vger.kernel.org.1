Return-Path: <netdev+bounces-95268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0278C1CB5
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 05:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D7EA28185A
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 03:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88AD149DFD;
	Fri, 10 May 2024 03:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KryGL4h4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73BF149DF9
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 03:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715310289; cv=none; b=BB60RBjzaGLysO7fg2k7JnSlBz3BbhHpO76PDFtxgaqWoHbxYnTMx/TBaU9470iTvyBp3lt3787qiOEp+Udvnum16FvMPfOphg2J9xLWx5xeAuuBxUyroQ2qqdoNGhj7bDHGmonEM+jfSj6NT/JZy+aYlESeX0P/AJKu9VJ/tO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715310289; c=relaxed/simple;
	bh=qwX0S2IPTpnyMYSHB94y9FA9s2Cuw6juQRT9ywUW/uM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKjkPgW8pF3B6qruX1XSU1agw2wAKiqihthbcCn5NwSLRAPcPS3nJaTpl51HNRYEpuIDU/EewblKCd0TUqzl4TbjUdWtojUhqhmxXf+yipTqiPGmNIBfM17x4Lu9HboAokxlxfXGPcW2sMGKAgcV9obc0eBbxAoL3h+F4qM29gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KryGL4h4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5338C4AF08;
	Fri, 10 May 2024 03:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715310289;
	bh=qwX0S2IPTpnyMYSHB94y9FA9s2Cuw6juQRT9ywUW/uM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KryGL4h4EBf43dCXkP/84gSeqrEKXuPwuCWoLI8SQLRT0fsDLsctGU3F+rvgJdAwU
	 2Q55k0//NNSLoKClrlHha47c2mGt+Y4d14t+hek20yEULany3mTzjZsquhR9Gxeb1O
	 GQLoP4ZUhSy4vRJ2Y3++cVjJWY4wK6Nx45nyfBYj5SHEJdr3zOle+KhEyFBW00R4NM
	 Zn47DkCEPKKmuAN9HdX/VwGkezMELzSH3xsnhqz5NciL8ZzVY9djGqQ6bxZH616Ug8
	 kaV2dG1TDiFIqE7kJfGZJjk51+GhUaEQJbh+STxrNJiduezDzo3hP3uqbvTEGMr6Mo
	 EwGPUjvNTHKqw==
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	borisp@nvidia.com,
	gal@nvidia.com,
	cratiu@nvidia.com,
	rrameshbabu@nvidia.com,
	steffen.klassert@secunet.com,
	tariqt@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 07/15] net: psp: update the TCP MSS to reflect PSP packet overhead
Date: Thu,  9 May 2024 20:04:27 -0700
Message-ID: <20240510030435.120935-8-kuba@kernel.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240510030435.120935-1-kuba@kernel.org>
References: <20240510030435.120935-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PSP eats 32B of header space. Adjust MSS appropriately.

We can either modify tcp_mtu_to_mss() / tcp_mss_to_mtu()
or reuse icsk_ext_hdr_len. The former option is more TCP
specific and has runtime overhead. The latter is a bit
of a hack as PSP is not an ext_hdr. If one squints hard
enough, UDP encap is just a more practical version of
IPv6 exthdr, so go with the latter. Happy to change.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/psp/functions.h | 12 ++++++++++++
 include/net/psp/types.h     |  3 +++
 net/ipv4/tcp_ipv4.c         |  4 ++--
 net/ipv6/ipv6_sockglue.c    |  6 +++++-
 net/ipv6/tcp_ipv6.c         | 12 ++++++------
 net/psp/psp_sock.c          |  5 +++++
 6 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/include/net/psp/functions.h b/include/net/psp/functions.h
index ad81322dd4ed..be4f78dec425 100644
--- a/include/net/psp/functions.h
+++ b/include/net/psp/functions.h
@@ -90,6 +90,13 @@ static inline struct psp_assoc *psp_skb_get_assoc_rcu(struct sk_buff *skb)
 		return NULL;
 	return rcu_dereference(skb->sk->psp_assoc);
 }
+
+static inline unsigned int psp_sk_overhead(const struct sock *sk)
+{
+	bool has_psp = rcu_access_pointer(sk->psp_assoc);
+
+	return has_psp ? PSP_HDR_SIZE + PSP_TRL_SIZE : 0;
+}
 #else
 static inline void psp_sk_assoc_free(struct sock *sk) { }
 static inline void
@@ -127,6 +134,11 @@ static inline struct psp_assoc *psp_skb_get_assoc_rcu(struct sk_buff *skb)
 {
 	return NULL;
 }
+
+static inline unsigned int psp_sk_overhead(const struct sock *sk)
+{
+	return 0;
+}
 #endif
 
 static inline unsigned long
diff --git a/include/net/psp/types.h b/include/net/psp/types.h
index e39abf10c03c..aad836c1c2ca 100644
--- a/include/net/psp/types.h
+++ b/include/net/psp/types.h
@@ -95,6 +95,9 @@ struct psp_dev_caps {
 #define PSP_V1_KEY	32
 #define PSP_MAX_KEY	32
 
+#define PSP_HDR_SIZE	16	/* We don't support optional fields, yet */
+#define PSP_TRL_SIZE	16	/* AES-GCM/GMAC trailer size */
+
 struct psp_skb_ext {
 	__be32 spi;
 	/* generation and version are 8b but we don't want holes */
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 9539c4a7b55d..2a602cf51009 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -279,9 +279,9 @@ int tcp_v4_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	inet->inet_dport = usin->sin_port;
 	sk_daddr_set(sk, daddr);
 
-	inet_csk(sk)->icsk_ext_hdr_len = 0;
+	inet_csk(sk)->icsk_ext_hdr_len = psp_sk_overhead(sk);
 	if (inet_opt)
-		inet_csk(sk)->icsk_ext_hdr_len = inet_opt->opt.optlen;
+		inet_csk(sk)->icsk_ext_hdr_len += inet_opt->opt.optlen;
 
 	tp->rx_opt.mss_clamp = TCP_MSS_DEFAULT;
 
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index d4c28ec1bc51..b4505bbb9e2c 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -49,6 +49,7 @@
 #include <net/xfrm.h>
 #include <net/compat.h>
 #include <net/seg6.h>
+#include <net/psp.h>
 
 #include <linux/uaccess.h>
 
@@ -107,7 +108,10 @@ struct ipv6_txoptions *ipv6_update_options(struct sock *sk,
 		    !((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)) &&
 		    inet_sk(sk)->inet_daddr != LOOPBACK4_IPV6) {
 			struct inet_connection_sock *icsk = inet_csk(sk);
-			icsk->icsk_ext_hdr_len = opt->opt_flen + opt->opt_nflen;
+
+			icsk->icsk_ext_hdr_len =
+				psp_sk_overhead(sk) +
+				opt->opt_flen + opt->opt_nflen;
 			icsk->icsk_sync_mss(sk, icsk->icsk_pmtu_cookie);
 		}
 	}
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 6991464511c3..c67700fc49a1 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -299,10 +299,10 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr *uaddr,
 	sk->sk_gso_type = SKB_GSO_TCPV6;
 	ip6_dst_store(sk, dst, NULL, NULL);
 
-	icsk->icsk_ext_hdr_len = 0;
+	icsk->icsk_ext_hdr_len = psp_sk_overhead(sk);
 	if (opt)
-		icsk->icsk_ext_hdr_len = opt->opt_flen +
-					 opt->opt_nflen;
+		icsk->icsk_ext_hdr_len += opt->opt_flen +
+					  opt->opt_nflen;
 
 	tp->rx_opt.mss_clamp = IPV6_MIN_MTU - sizeof(struct tcphdr) - sizeof(struct ipv6hdr);
 
@@ -1500,10 +1500,10 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 		opt = ipv6_dup_options(newsk, opt);
 		RCU_INIT_POINTER(newnp->opt, opt);
 	}
-	inet_csk(newsk)->icsk_ext_hdr_len = 0;
+	inet_csk(newsk)->icsk_ext_hdr_len = psp_sk_overhead(sk);
 	if (opt)
-		inet_csk(newsk)->icsk_ext_hdr_len = opt->opt_nflen +
-						    opt->opt_flen;
+		inet_csk(newsk)->icsk_ext_hdr_len += opt->opt_nflen +
+						     opt->opt_flen;
 
 	tcp_ca_openreq_child(newsk, dst);
 
diff --git a/net/psp/psp_sock.c b/net/psp/psp_sock.c
index 42b881e681b9..bcef042cb8a5 100644
--- a/net/psp/psp_sock.c
+++ b/net/psp/psp_sock.c
@@ -170,6 +170,7 @@ int psp_sock_assoc_set_tx(struct sock *sk, struct psp_dev *psd,
 			  u32 version, struct psp_key_parsed *key,
 			  struct netlink_ext_ack *extack)
 {
+	struct inet_connection_sock *icsk;
 	struct psp_assoc *pas, *dummy;
 	int err;
 
@@ -220,6 +221,10 @@ int psp_sock_assoc_set_tx(struct sock *sk, struct psp_dev *psd,
 
 	WRITE_ONCE(sk->sk_validate_xmit_skb, psp_validate_xmit);
 
+	icsk = inet_csk(sk);
+	icsk->icsk_ext_hdr_len += psp_sk_overhead(sk);
+	icsk->icsk_sync_mss(sk, icsk->icsk_pmtu_cookie);
+
 exit_free_dummy:
 	kfree(dummy);
 exit_clear_rx:
-- 
2.45.0


