Return-Path: <netdev+bounces-201172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93237AE853D
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 15:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D32105A1ADA
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE22266EFA;
	Wed, 25 Jun 2025 13:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUiICp+n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D545E266B66
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750859544; cv=none; b=pXFy/f02vtEO7lK3HOjs9e5i//3ZBBIzSAahMj/v0IjM1rf+bVZeZ5g2hRhHT98+pFvZbNE6bXTbEzf1kAl+3/c5JRrnVWpZg1mFSezqTsdCeDUOf7Es4AoQqGES8dtbzedCcr0zyBRhNN7u1Obwlm0Y/jByn8yF0rVtF383Qks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750859544; c=relaxed/simple;
	bh=PqtZ2Wm1tUyXg2LxS3/NciejLzA3nea1lNW7SyGOya8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VaflEOMxq840zmhquTwIWm74v/6uHOp3joNakavJLMsgaiYj0qlZ8EeY2rkuo1PqWpsEHeLY64T3e+U0a6s/jdQvTmzrzHxbhzhYmhWcU4VdKD/pvl2lwMZ1EymNZttlQ0pktINnrzDmV7D7Ag66DkxZXBojlRIldyFXzBEUFP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUiICp+n; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e8601ce24c9so608079276.1
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 06:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750859542; x=1751464342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyyeSeYwJVrpugi25X85gvDEaQMJMFKayaHPKtg/UeM=;
        b=IUiICp+nv6e7NSMt6PAFeQ8jXnYsvTDsV/+6NEO+y+a5S/yPeC+Z4jNhB0VLRSbtzC
         XNoSfvpGKDtUCu8NEEQCWu5Yiu/fTSwMic+I4Ri40fgYMA2DXeazhinxJabHopC/+NOR
         INQiZH1l8UNjuVbaIhJyUjmfUhmazMgauTm/urD3I5ErQOrP81P62i/oXFj07WY+nro+
         jdJh6H9fZoobnt4mgGrJVv1/4JU07BKUuKugWcbN/tjYm47/zVgwlH7h02GfOQjddOMD
         qPSFy5y5lbvhn3DMMuCsZsCNc0SogAVsckSwrsFJUE8twQ21UorYAr6qdwqse5Tfx2LE
         LnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750859542; x=1751464342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yyyeSeYwJVrpugi25X85gvDEaQMJMFKayaHPKtg/UeM=;
        b=M8LYXduDx75bWRA/GZNEKa73CvlHXum4GXYR/0LaoNIyqlpULIJZo9sLT1XKgl8CL1
         qqcpuqQOfhZnWPXqHg6LF58pSu+EIlOqhfFllCIzCkWKf/eKkj7nuVv6asFe9+2RwMOY
         zulXoI2wGrOaH04GhfAZvd2JFOtuNTSxN6zCXXxPnhJPVMRbfTE1j4zNbGTQfRW0ybkh
         HXKJxmaQqAM7rvUebddG29p6V7/ZN2JM/VQb0/43Jmy3/pLVKF05WViXBMt9yZCasc5V
         PWHpA0roZanG/wjF9FkaGT6Focy+N3ITNMZ3qH+g9lMBGG1SmujkBt6AaHhkbXliZiO9
         9wQA==
X-Forwarded-Encrypted: i=1; AJvYcCVVoJTCMjqGWWsD9b7tXQzGKKy2efpe82CEK4HGK5IV7WBesji0DQB+aNzAhaH/uKQ17Ln5hhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHl6Te5BGFkIJrEIceDbKfDXxaf/SdmwLCTmLw3OjEhxRsdnhu
	JqttWjHhiU81b4BhVh3G2dtSciKB1WwKg+PbbUklcYLOqbJT9dvI0gLi
X-Gm-Gg: ASbGnctzn7MF+OZhASbypAOs3i0V52JF2io9dH8U841b3MGA8z9AzE0JOigejan8h7Y
	Tb6ER8JqMFtPAMpr4yzD5yqjFsTi0zgNM4YV02OyR1Uu+2lKNTcgow7iRm6u+lT4/QQcTZCLDf8
	2JwffA44SR7ENI8aHHGzlMXF3npnyewlg9QLmC/5OmjAOucbIwbsTQ7gIbokatF6mml5kdi4d8A
	XKasQXTs4TpSyoG0yj3dBgBdiDOCFz53AxPD0JcDRlFD9B/SxWa+5e7QTKCS/Anqleq29PKNivl
	fAB3+B7cC5Smd2YqdaVES5KpKba6SBUGFjOjFl3BOEuqxieFtVr8/rGxF49P
X-Google-Smtp-Source: AGHT+IEnk7/AojuR+LWUxbQmpudoeSakQQ7q8ZSI17+YqksShZj+EQYdh9eASX148Iu0C5MuqyW+Dw==
X-Received: by 2002:a05:690c:6d0a:b0:713:ff70:8588 with SMTP id 00721157ae682-71406e2ace7mr42577857b3.36.1750859541794;
        Wed, 25 Jun 2025 06:52:21 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-712c49c109bsm24712977b3.2.2025.06.25.06.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 06:52:21 -0700 (PDT)
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
Subject: [PATCH v2 09/17] net: psp: update the TCP MSS to reflect PSP packet overhead
Date: Wed, 25 Jun 2025 06:51:59 -0700
Message-ID: <20250625135210.2975231-10-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250625135210.2975231-1-daniel.zahka@gmail.com>
References: <20250625135210.2975231-1-daniel.zahka@gmail.com>
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
index f0488f29fb19..90a60817012c 100644
--- a/include/net/psp/functions.h
+++ b/include/net/psp/functions.h
@@ -128,6 +128,13 @@ static inline struct psp_assoc *psp_skb_get_assoc_rcu(struct sk_buff *skb)
 				       rcu_dereference(skb->sk->psp_assoc);
 	return pas;
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
@@ -167,6 +174,11 @@ static inline struct psp_assoc *psp_skb_get_assoc_rcu(struct sk_buff *skb)
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
index 3b7b977e62a3..5b0c2474a042 100644
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
 	u16 dev_id;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 6273e3b0885c..0183f8d6c2dc 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -291,9 +291,9 @@ int tcp_v4_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	inet->inet_dport = usin->sin_port;
 	sk_daddr_set(sk, daddr);
 
-	inet_csk(sk)->icsk_ext_hdr_len = 0;
+	inet_csk(sk)->icsk_ext_hdr_len = psp_sk_overhead(sk);
 	if (inet_opt)
-		inet_csk(sk)->icsk_ext_hdr_len = inet_opt->opt.optlen;
+		inet_csk(sk)->icsk_ext_hdr_len += inet_opt->opt.optlen;
 
 	tp->rx_opt.mss_clamp = TCP_MSS_DEFAULT;
 
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 1e225e6489ea..94b9ffd35e80 100644
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
index 033d953c0835..7fccf5c93084 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -301,10 +301,10 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr *uaddr,
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
index 9028f45a2dda..4bfd8643de4e 100644
--- a/net/psp/psp_sock.c
+++ b/net/psp/psp_sock.c
@@ -188,6 +188,7 @@ int psp_sock_assoc_set_tx(struct sock *sk, struct psp_dev *psd,
 			  u32 version, struct psp_key_parsed *key,
 			  struct netlink_ext_ack *extack)
 {
+	struct inet_connection_sock *icsk;
 	struct psp_assoc *pas, *dummy;
 	int err;
 
@@ -239,6 +240,10 @@ int psp_sock_assoc_set_tx(struct sock *sk, struct psp_dev *psd,
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


