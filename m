Return-Path: <netdev+bounces-203454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D10BAF5FA3
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 19:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 235B54A45CB
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 17:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AB4303DE5;
	Wed,  2 Jul 2025 17:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ufv+4I05"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A0D303DE2
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 17:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751476420; cv=none; b=D7EeKmspBfQH3/vDPg9LDCJmxoJxHTbXGSKO+/LGdeLGpxTTFG0Lb+qaTY6PHpcq+dZmgDjjIl/35OnEIoRAT/XkRUj4BvbHJYH9MFgtxlN7Fr3jqum+fXD7BtfGHAb/I0BvE+9WPnuyx2P3Ohz2NBydMMYx9V1CoXgPpSj3V7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751476420; c=relaxed/simple;
	bh=x6JlzrKpUjKTueKkKDyBvjdyQSmbmeURipHW90/oLJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RINOwwgNLzb6W0llMD+FbWcsAODgv2eYe+fjQJCCh751EZhvGxDrkhN4K9QyvX7n0a7llqUBDSdsjr2Sb+ZfDJwTmGOMnQtDsYXM2jfQ5x1E6TRmCLtPjaXryAbXA0rkvTb8HwNrp5bfCnKSXdZAA6+okF/2cvVD5o0MAofLufQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ufv+4I05; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e82278e3889so4652309276.2
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 10:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751476418; x=1752081218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzM+sRT074CrbUn7VelUyGD5XZr/JdEu9XdwGa5mMWo=;
        b=Ufv+4I05VAVN5w0M+5HDq9/V5bYcNPSe3Kd0kb0Nlj5kLai9jWExn99ywGh6Wa1Z6+
         Ys9fU3RaFMQDuOvOsvB9TCsz9lg9bttBFZ5pbpXtVzl/lvc2otpKXgpxbgEhY6Z1BEZj
         Pl9xsDICC4cvGgUruVEAmr/L6Msbqhy0xjcL+W1bSWd87u8Gxa/qIHtJi7nS6Qaeq+3R
         uHi/hlfiEzCgu41IYkmeOqjov0puiYeKctVFb+dIP4ZTC+5doNW/ueIwYDBFR0D6iHSB
         3np/8qxB7pgSd9g67OARmkX2g8dfjy3WfLGooGkyKUjqP05krRBP8qaJkttoAFAwZnVi
         k+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751476418; x=1752081218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzM+sRT074CrbUn7VelUyGD5XZr/JdEu9XdwGa5mMWo=;
        b=DMyDsOEhqu+KWvSMvGpSWeAYKr7SCj5l9K/ezXPSi76sukEbjo32oXuBZCCLeHDDBC
         fewAOuUJGCJqDvdm7LHAK6xNlNWeoHJ1lcduu0G08GrMpx4cnz8Ld068nu+GoOSew7Hy
         FU8yoFarI8mtHrwAuVcerUaAOP+nNSR4x8tlpo33WU6RrLytZnwRjq9LFDm26fUqsJYI
         EwVxKi9KCai6l6Rz2bc1nSKGALPI/J9IgQ7T8i0oyySVNXbK3KpEgD/kfOq7voLKWRzo
         5tLueT5a3rY3R4HS8O73lsaYUaKgtEElY8VYI07ax13Vu7f8qiPfBPkpWDe/i1o2niPF
         Y3ow==
X-Forwarded-Encrypted: i=1; AJvYcCUJHEhoE4rl3WEQTv8PknxZ33RKQYxlG0mhzuucqx3hk8i/odqbUPY7exvzNryKzpodCmhxcyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYvb/IssM9jYw7d5qTqb3BsfqvnljMm9d5VN6X1Xz6PV1kb3Uq
	RTQBTawPf9hXiRD65q69OOzzvP0wzuK8ACZCdkFrx4f6Tfjf8RwRk0cm
X-Gm-Gg: ASbGncvPXHozYUPGpng1NfEkp77C7aCrObyueB8irrxYVIms6AqeyXJD+e2qdti6lFU
	MvqHqTx4BjgZ5kvsV/CxhCNoLhEiMVGGEio5rjdiT42vym9c9f9WuFH3nuzoBJEGhi+5ClvmUtI
	lg435/bovXWBF4O5nRHe00PqVXhTUYEclLhXBA8mv1sD2cQQVYQCmAQtkdCXkluGuSbx0Ju9haD
	vilgxzBUvZ0Nu1yvPgCmXJBKBzCSw3Vynq3cYKV5Wr1I0iw3or7iNFgAKUc/PVM9S9L/6Xn/9x1
	XavTv9ZSjVdJoRqVZcVpTMM8JPw9sZ2krLpE2TwC3IPX3fz+RhscP91ECV5S
X-Google-Smtp-Source: AGHT+IHh42Z9KBXww/WvqLvYv/wN2ECobDXdD8v1KUxzuYRvPawOI9lxo7O1XWarl7N5hbGCwv4GlQ==
X-Received: by 2002:a05:690c:4802:b0:715:969:ce31 with SMTP id 00721157ae682-7164d5d36ecmr52699387b3.35.1751476417797;
        Wed, 02 Jul 2025 10:13:37 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:74::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71515cb7f97sm25365847b3.103.2025.07.02.10.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 10:13:37 -0700 (PDT)
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
Subject: [PATCH v3 09/19] net: psp: update the TCP MSS to reflect PSP packet overhead
Date: Wed,  2 Jul 2025 10:13:14 -0700
Message-ID: <20250702171326.3265825-10-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250702171326.3265825-1-daniel.zahka@gmail.com>
References: <20250702171326.3265825-1-daniel.zahka@gmail.com>
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
index 442fed11ebe4..1b414692504b 100644
--- a/include/net/psp/functions.h
+++ b/include/net/psp/functions.h
@@ -138,6 +138,13 @@ static inline struct psp_assoc *psp_skb_get_assoc_rcu(struct sk_buff *skb)
 
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
@@ -177,6 +184,11 @@ static inline struct psp_assoc *psp_skb_get_assoc_rcu(struct sk_buff *skb)
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
index 0f290e6dca2b..6286cf31a3ed 100644
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
index b1ab44ddb487..c34f7266457f 100644
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
index 9fa20bcc5e30..f97441935d12 100644
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


