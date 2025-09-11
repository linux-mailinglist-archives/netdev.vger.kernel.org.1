Return-Path: <netdev+bounces-221934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3ECB525FF
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 03:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BA911C83D55
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 01:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6F52459D1;
	Thu, 11 Sep 2025 01:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbOR1dvt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFF5243387
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 01:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757555274; cv=none; b=Qodhk8e8+D2pOBLosvFyYF81hiaXe+f0bUVkJKTq99al5RO47f88p3flHt8najfJ33kKD3utaaKN73/0Cz7bYz9+qWFArPqtE3QOI1wVxGGW6cLDrH5KmE+UzcsrQNCD6zgdzbschzYmqn+HJyXoARIkeC/bgWXQiyjWXQyFpO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757555274; c=relaxed/simple;
	bh=tAQjt3SNRLzr15bdUWBDBIOBwdErv4zTaXoex8h916w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UftzKXjP21mGGmsK7Ybt2n+VWYEztaWsZfnyk5hCvzxH0ylr9T3dp4XjwILEcMOtAKg2Ml8X1EpH1Mu39pqhlVavV1629NZ5hc87MXctb/+lhgSnPZ0DTwY56zQEdF19YA+hsjeywtKeKg/Dgn253JekNTwJPhfGPP1i2ifN3jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbOR1dvt; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d60501806so1813987b3.2
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 18:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757555272; x=1758160072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KP97gDTnW8GMG41FgNEsph/dIn6XUsyrYrO5M4Upp+M=;
        b=WbOR1dvtfH+eWPEyVhSCJm0WHd77PkKXWoubUUFp5DkKJiWppm6ZzyGhHKgEAnzZKN
         c6KVKWIm6UydL9daLFdhVOGMEACfJ1dj1cNEKfpSw7c+ntCZUNCgFi7PFQG4Ul8LIcW3
         QWQRT3FlzRZ4iJ0nrLwrmp2mgI+cehLNCt34lIYxOIqIyLuH3ra7kngPTMDugOr3USeT
         iHt0Iall+6TA4Z/a4OuSXKIZXBpAg1+rTBHeAd/+yeGQiEjdamwaj055U+zbzzhTpD7X
         OCUKG2acoYrV1o/e3AVn5AfAotKcgMQXAVBg/2N9kMcvXwOP/WiwKEfXb1Bp66CqOjt5
         MP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757555272; x=1758160072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KP97gDTnW8GMG41FgNEsph/dIn6XUsyrYrO5M4Upp+M=;
        b=lx7DUkygo0DN8TEpUrK4v/HNsIPQEE8/JodanYp7GDfrtQ79SNV0XWHywzLWsUNmhR
         WSlf6eqVYR6CKl66aIlM+TC6giC0dMYzodLC/i0AY5UNc3xF43N18kctYD79oVvoYiPg
         EXEa4sRBUc61ca6Qy2e7PUzInArY9d5Z6A50MQG3W0ftjmZA9esJraLtBVGd2w2JQWLM
         fwESENfpGBxYRthdQofzbN3MaxREwPDfEi5+jo8EOpjNBNQE2Y7nZDt02x+iK8R4Az+j
         Dhpsnnxa0ubUktlbqqN+MdvAhW/NXKfIKd3yNZ3JgfOFPUHIcyXgEZbjp9283QTsNkYY
         S5EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGNmydv3QYurwTpRozReU3zQr5X43D8wrKyHQ+AC5NGUoVSdE8JcFKfw5usQplAVpgbHWLX6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrCAXFfXYD7lA6XUzAhCKAw7jcopiBZCMk2kBlkcua7KV+5bHv
	9+iDTgKf0z+8ZOtLgEQX6XOIaLGkMpEONXMulEcrSOYmToaueoYpiAtV
X-Gm-Gg: ASbGncuYSkDxv+ZyJGJSV8B85YxyehB4Wr/WVvZ+qiHNPXIlUchvXBifxs+7yx23Mxd
	ylDTzEqQJxsK3FvKrB2qjbYPfFKllI25y+NVFwnr0G1PhxpEG3cx1Kwd7ZIfrp7Qf0M49IPuEEn
	gXNkHo5gAxE00BYfZKPVuTy9iSqzeFh8XkO5Ns3LJK2nPBmAnvzO8nrjN5aiZ0hZ3R61K9SJqOl
	1CVuNHAtIF2xxp2IZqvhQB1kXdR+G9Rl8t1aMjv1aB/z4/7BGEuoz3uGZo0W6aP15iG2/l05TLR
	hcBM8zRXY25EWJJ4166ePply1r/uHx8IWMM+LB5QU5aUKQ+z+4zKpqhJnJrJCdc7x08v+r6SeD8
	Sso2ZuLTVAuGEbef4BV11
X-Google-Smtp-Source: AGHT+IFDYqMwOsfqt03Fy7TKZ75iOe9BRD5YWTFNnzGmv/JhrUPqFWtGTD7iktTq5KjBdWL2fkQQlQ==
X-Received: by 2002:a05:690c:6910:b0:726:5cfc:be39 with SMTP id 00721157ae682-727f4d634a9mr192615747b3.27.1757555271764;
        Wed, 10 Sep 2025 18:47:51 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:58::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f76830bd2sm379247b3.20.2025.09.10.18.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 18:47:50 -0700 (PDT)
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
	Kiran Kella <kiran.kella@broadcom.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v11 09/19] net: psp: update the TCP MSS to reflect PSP packet overhead
Date: Wed, 10 Sep 2025 18:47:17 -0700
Message-ID: <20250911014735.118695-10-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250911014735.118695-1-daniel.zahka@gmail.com>
References: <20250911014735.118695-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

PSP eats 40B of header space. Adjust MSS appropriately.

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
    v6:
    - make psp_sk_overhead() add 40B of encapsulation overhead.
    v1:
    - https://lore.kernel.org/netdev/20240510030435.120935-8-kuba@kernel.org/

 include/net/psp/functions.h | 14 ++++++++++++++
 include/net/psp/types.h     |  3 +++
 net/ipv4/tcp_ipv4.c         |  4 ++--
 net/ipv6/ipv6_sockglue.c    |  6 +++++-
 net/ipv6/tcp_ipv6.c         |  6 +++---
 net/psp/psp_sock.c          |  5 +++++
 6 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/include/net/psp/functions.h b/include/net/psp/functions.h
index 0d7141230f47..183a3c9216b7 100644
--- a/include/net/psp/functions.h
+++ b/include/net/psp/functions.h
@@ -5,6 +5,7 @@
 
 #include <linux/skbuff.h>
 #include <linux/rcupdate.h>
+#include <linux/udp.h>
 #include <net/sock.h>
 #include <net/tcp.h>
 #include <net/psp/types.h>
@@ -143,6 +144,14 @@ static inline struct psp_assoc *psp_skb_get_assoc_rcu(struct sk_buff *skb)
 
 	return psp_sk_get_assoc_rcu(skb->sk);
 }
+
+static inline unsigned int psp_sk_overhead(const struct sock *sk)
+{
+	int psp_encap = sizeof(struct udphdr) + PSP_HDR_SIZE + PSP_TRL_SIZE;
+	bool has_psp = rcu_access_pointer(sk->psp_assoc);
+
+	return has_psp ? psp_encap : 0;
+}
 #else
 static inline void psp_sk_assoc_free(struct sock *sk) { }
 static inline void
@@ -182,6 +191,11 @@ static inline struct psp_assoc *psp_skb_get_assoc_rcu(struct sk_buff *skb)
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
index 0c5ce219f388..87ade27f7a11 100644
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
index c034486d4451..8fa46f25b8dc 100644
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
index 8ebccee94593..10e1fda30aa0 100644
--- a/net/psp/psp_sock.c
+++ b/net/psp/psp_sock.c
@@ -180,6 +180,7 @@ int psp_sock_assoc_set_tx(struct sock *sk, struct psp_dev *psd,
 			  u32 version, struct psp_key_parsed *key,
 			  struct netlink_ext_ack *extack)
 {
+	struct inet_connection_sock *icsk;
 	struct psp_assoc *pas, *dummy;
 	int err;
 
@@ -236,6 +237,10 @@ int psp_sock_assoc_set_tx(struct sock *sk, struct psp_dev *psd,
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
2.47.3


