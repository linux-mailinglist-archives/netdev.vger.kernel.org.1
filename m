Return-Path: <netdev+bounces-209503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EC2B0FB95
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 22:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C8D716D3CA
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 20:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CECE239E77;
	Wed, 23 Jul 2025 20:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fC9tZC85"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4838223AB8E
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 20:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302909; cv=none; b=faYbkkP7sOJUhtfYHEoiLbL8TxG5P9wz6vL7vRjmNGxGu3qMyVkUHHf1yzEXFAC1LG4vVhX9NNww6zNUXRGspl2Dm/ed9nxkaTjOVr8buBA7wFVZzN6qOI10rWrtfm3lWEL92/bx2zt3cBbndMJO0ufSzByJsYjLQnU358PFYhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302909; c=relaxed/simple;
	bh=lAnrX/ucDz31LOLoLiiBMD4JYBQB3BE/FakIP4EtglA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FB/rOGSlD/YuZfVUw+qmM6M6NnmlcwLxKNJxXozH5FX5aS/cwl8e4o3a0saedK9tnsi4jpDKF6imaVbQo7MLg+uNFr67v/QFmoE4kEWYtQ6lrcY186dQBcs7IwOy8ij3jQ+M2tLs6eO6CFpgLJMCxs5G08tpB1PjBOODJAONQd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fC9tZC85; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7180bb37846so2980657b3.3
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 13:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753302907; x=1753907707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqn/5Ykxi2C5oLLM+e9wskTmvvrtPGjkx4HVnN37xEs=;
        b=fC9tZC85N4OiD7+Ert1oieUoqLzQk7E3t3SqRe5NsK1AG2Wed4PZ9MNZzTbEYJmsa9
         W6EinWlYpLAUiuoQhUB+CIq2YZxX0osQs24yr6AFJls6TtvthhGxrtcat7m/6lNbcN8Y
         9E0dhYar0Vuk2ppQQQ5vnz+BTqff2oSiLJTww61+rOeI4BQVuScmIYKMtiF4tYQdUZIa
         xrwwvUabegmgS0IKSoXfwVEJvT41XQO8FuEU+6oHhsg3dmPvDDjozuXxl9d/CbMYMbez
         BYKZpAO4VBGETJ5xdQQEXHIwkw9BAZhjdaW85n8uzfOwRpd0bIUOn8bVWPBe0yTmwcdT
         kLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753302907; x=1753907707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqn/5Ykxi2C5oLLM+e9wskTmvvrtPGjkx4HVnN37xEs=;
        b=vH58Pg8QaxmUuHcBfUax46Ee1t9IQVUMNBvLKoS/0KWv95XxCjsBF0Qxil8tebi2GF
         S69REAwDD7TtL8vCIHleGIIDq7biHsA99J3vvuOomZN9E6Pq+AFpsydRrUd7qEnNADOY
         r6SWlwN7sPoHRJsnOBNlXn3yliC31DamNUd2T5t6H/O7ADHHv+cVpi+fwVmtXKSeaar+
         DnS0FdeP6GX43jcM+FoI3Rbr/+BGC+EQuRrNWISYX9Ired3nRrEERYNYlbyplVS8eQSS
         iFm2YIILHATy5UMD2qH1Uo8+x3mYjiFe/vhuIGFRhgEO6IIOH2eHS/kpotnNF1r1Njjq
         nTvg==
X-Forwarded-Encrypted: i=1; AJvYcCV/qihGKhTx9e1eyor6zTQg39iDtGVE7lmiRFIRrjqC3qdP+Hyn0ukUdACmd+umnDHg9ekK/lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmOb6g6QtLxcwKaFvRRL0MH9RSSMmCSGtsLaPbksgMb98fv8Ag
	YCuFMRIVGKaBHYl2w+qeh68oISYJy3vOxsDPaiT7UWZ0zkYA+9nxV/TM
X-Gm-Gg: ASbGncvnhOLy4YFWH8K+mia3PK7p9rWuE0/3KFFcM1syRZ5BlG7hEmzIKYxqE5bXZq7
	BtUCTG6uiobjcCPB7rJLBWGlDkgtMpR1Rbj8VGJQVbAeH1bSZ5guQfIsKYWfXdlYAUnjxOk5RXD
	YRjjRcoMVXkHFYwmoV3yrSxp1QOgsv5xrh7ARYG5UiF7yHMOmx+8GJOQxyRsYleLGL8FGJ6LKZR
	kftjNf9vKUekiYwpDPXC4EnLQeNApDbI5EiH7U96LezuFXf4jYftTbLfwVo6bh70ZOPPVj1yvmn
	RbGax66+OFNR1mVf8Osp3dbbXDqA1fGpYI6SWWPy5W6N1YbwCEOKP+umoLSVM+dli1G+ySVIwEn
	FjS53p2wGcQPvMxPsWSJI
X-Google-Smtp-Source: AGHT+IFgijy+24Fxrsy1zpFD43EzG76w5YXdprZ3jducgORMRXQFVdLPm5tnCEH73yM7ExDmsnhrcQ==
X-Received: by 2002:a05:690c:2781:b0:714:271:3103 with SMTP id 00721157ae682-719b42760e2mr57549567b3.38.1753302906927;
        Wed, 23 Jul 2025 13:35:06 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71953141fb9sm31299797b3.44.2025.07.23.13.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 13:35:06 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Raed Salem <raeds@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v5 09/19] net: psp: update the TCP MSS to reflect PSP packet overhead
Date: Wed, 23 Jul 2025 13:34:20 -0700
Message-ID: <20250723203454.519540-10-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250723203454.519540-1-daniel.zahka@gmail.com>
References: <20250723203454.519540-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

PSP eats 32B of header space. Adjust MSS appropriately.

We can either modify tcp_mtu_to_mss() / tcp_mss_to_mtu()
or reuse icsk_ext_hdr_len. The former option is more TCP
specific and has runtime overhead. The latter is a bit
of a hack as PSP is not an ext_hdr. If one squints hard
enough, UDP encap is just a more practical version of
IPv6 exthdr, so go with the latter. Happy to change.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---

Notes:
    v1:
    - https://lore.kernel.org/netdev/20240510030435.120935-8-kuba@kernel.org/

 include/net/psp/functions.h | 12 ++++++++++++
 include/net/psp/types.h     |  3 +++
 net/ipv4/tcp_ipv4.c         |  4 ++--
 net/ipv6/ipv6_sockglue.c    |  6 +++++-
 net/ipv6/tcp_ipv6.c         |  6 +++---
 net/psp/psp_sock.c          |  5 +++++
 6 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/include/net/psp/functions.h b/include/net/psp/functions.h
index bf703dcf353f..17642c944620 100644
--- a/include/net/psp/functions.h
+++ b/include/net/psp/functions.h
@@ -139,6 +139,13 @@ static inline struct psp_assoc *psp_skb_get_assoc_rcu(struct sk_buff *skb)
 
 	return psp_sk_get_assoc_rcu(skb->sk);
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
@@ -178,6 +185,11 @@ static inline struct psp_assoc *psp_skb_get_assoc_rcu(struct sk_buff *skb)
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
index b0e32e7165a3..f93ad0e6c04f 100644
--- a/include/net/psp/types.h
+++ b/include/net/psp/types.h
@@ -93,6 +93,9 @@ struct psp_dev_caps {
 
 #define PSP_MAX_KEY	32
 
+#define PSP_HDR_SIZE	16	/* We don't support optional fields, yet */
+#define PSP_TRL_SIZE	16	/* AES-GCM/GMAC trailer size */
+
 struct psp_skb_ext {
 	__be32 spi;
 	u16 dev_id;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 35e2a1ce87b8..3c3e8760f89b 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -293,9 +293,9 @@ int tcp_v4_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	inet->inet_dport = usin->sin_port;
 	sk_daddr_set(sk, daddr);
 
-	inet_csk(sk)->icsk_ext_hdr_len = 0;
+	inet_csk(sk)->icsk_ext_hdr_len = psp_sk_overhead(sk);
 	if (inet_opt)
-		inet_csk(sk)->icsk_ext_hdr_len = inet_opt->opt.optlen;
+		inet_csk(sk)->icsk_ext_hdr_len += inet_opt->opt.optlen;
 
 	tp->rx_opt.mss_clamp = TCP_MSS_DEFAULT;
 
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index e66ec623972e..a61e742794f9 100644
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
index 6a89edda31c7..adf83ec25b66 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -302,10 +302,10 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr *uaddr,
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
 
diff --git a/net/psp/psp_sock.c b/net/psp/psp_sock.c
index 757fc9698f3d..7aee69ed10cd 100644
--- a/net/psp/psp_sock.c
+++ b/net/psp/psp_sock.c
@@ -180,6 +180,7 @@ int psp_sock_assoc_set_tx(struct sock *sk, struct psp_dev *psd,
 			  u32 version, struct psp_key_parsed *key,
 			  struct netlink_ext_ack *extack)
 {
+	struct inet_connection_sock *icsk;
 	struct psp_assoc *pas, *dummy;
 	int err;
 
@@ -231,6 +232,10 @@ int psp_sock_assoc_set_tx(struct sock *sk, struct psp_dev *psd,
 	tcp_write_collapse_fence(sk);
 	pas->upgrade_seq = tcp_sk(sk)->rcv_nxt;
 
+	icsk = inet_csk(sk);
+	icsk->icsk_ext_hdr_len += psp_sk_overhead(sk);
+	icsk->icsk_sync_mss(sk, icsk->icsk_pmtu_cookie);
+
 exit_free_dummy:
 	kfree(dummy);
 exit_unlock:
-- 
2.47.1


