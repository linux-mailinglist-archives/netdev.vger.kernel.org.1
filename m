Return-Path: <netdev+bounces-209524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FCAB0FBAF
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 22:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB1827BB159
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 20:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891DE245022;
	Wed, 23 Jul 2025 20:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYm7uxBq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2517244684
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 20:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302932; cv=none; b=nU4An7f0Zxe6FBnw7iOHFjs0S5A19ei0wMxLbkeYiKnmQubzfplb8iDZ9N1/AVEuQuDPDTa0vbswJ90a/vAxOu7lclQLlZg3a2tPmg+6gu2eE6UNcqSMbP4xG3Oi7efjTtJvT9fjCQk2G3hLgRhspwGL3EZFIM9cM6hkKLZVXpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302932; c=relaxed/simple;
	bh=Ao8dvPVaoZX0nQYWpUM+iFO0DyTbmDYxo503467ng68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pExC7v0ogdhVpvBoSGhv0KWo8yVB3sVxuQcVvFh94yeOBqM62DSKJTiQpXfVXtd9v5R0/0cVYYjtqrqU1oPGi0pWGYDaM+KdDQjx+MSUicsMLRmGfOu/Nu2e46u0O50uXG2DwYQM+oAiXGx3VKEItv3s/3dRTfXIKEmVYpg2c6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYm7uxBq; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-70a57a8ffc3so4416507b3.0
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 13:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753302930; x=1753907730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnNk+66MYGSMMFZtjIOGGJXxbXwDCgdZsTknlUQgWpQ=;
        b=GYm7uxBqX/0X5JfyM4edNcL9PtktuaOOSTEIayaNVePKQfuIMG9lNr+JugyTj6Bvsp
         fIxrfEDAX4SCl8QgznX4Tk+vhcalVL4eZ6NRDLnCVCZwdRnlVxNCu4k0NdfdBZGiP3LS
         rOirvbzSfbfqJdNSdQq8svRufvEsPCRKvDBDB+GflNQiWWaQ81hm2ENIjYELixTK9+d0
         drB3eOOGPkcd3TwZ/gjX1cI1jKpM7DODJdnlmP01QoIT6FFgAU4YQTHm26i4lV3GEIpo
         vUhnjLOWHOGzDjunie8xNiZXjMEAuLEu+iWdi9QziFyrFBCeDSyq0pob78rvTswMWDZb
         2dWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753302930; x=1753907730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YnNk+66MYGSMMFZtjIOGGJXxbXwDCgdZsTknlUQgWpQ=;
        b=E72KXqNDtCo+flt4QRMmF0mZyUTDUkmOcoh1z+RDHifV/xTXj7q/6oQ+o20okXG4ph
         XAC8ASbnQprXuadRJSxsQvGJQOxJkOxjGyXHyq+WUNT3KWzCzuarVy5nrvfMiUYn83cA
         pIqt4pLC4iA37T0z+e62ui6JNZU0i5LbO1lVrOB7V988RvdaxPdLF4TdcEQfE8Lr3NdK
         JSEerOsmdzXr6do7VfX7CBatMttrB09omRFWZ5Hvp3dhkCTTIesDp+a5fBUhd804zjin
         KWVWkDVD93iEDtLGYzkBDyqVSxsYPSaQGHeiZf6EkgVlUXX4UN/O4813uwQaW2VxJTbg
         z5VA==
X-Forwarded-Encrypted: i=1; AJvYcCXVVCPXOQFMnAit4bdhokrdqx5+jyQoreRutCMALflhLFp/1GAMFnZNE6O1K9WeB6tEWHVVgTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0djz5MNe3/GQcq5vIGEYdAnFJYmWOZ+qtVvYVyDrris8tFgmX
	trZL5i1esOXoffAE+dyI2k7Mp0GL7HWtDc7VXKSdeHYbXjA7zO78O1hb
X-Gm-Gg: ASbGncuyRr07ygGKU5NrpTdMSevkkL7GMEGCSv96+apIaRZoQIFAo369wwrT6Q1yJCz
	k5oYLY0enn3BkohUt26afisrVHUB/dS3YjICK/uI2hbsYLPqfWQ8KzEm6/rIf4TafD8tgro3M45
	0ypY2JyMiETRMmdEq2BjR6whNv338w/QRzgRvD6OGcopP4056vbAkgX8AFPI1KChiGelqgOn3EQ
	3rBdS/exF+YrPZz9G5AtnYxjWC6ZzAiZN+ttfigRDwIP7eRodx4Q/bs52tQb04iTljeDTVJsyo6
	Xc6HlThsSxfrH0aRJbqKuzjTFWEF48tb/FjJM43MBPRtOh2KBRtnxWztOk9GRhXnhW/KEVVpsC2
	luofqR4GAvPhK4iYZiTed
X-Google-Smtp-Source: AGHT+IE212E4pmlDfnqrkwZfyG1TT5fSEXYHZmnojDCcihsKuAeDI1dGZHNzziorMU52as4RKQsWEA==
X-Received: by 2002:a05:690c:315:b0:6fb:1f78:d9ee with SMTP id 00721157ae682-719b4230755mr52343527b3.15.1753302929617;
        Wed, 23 Jul 2025 13:35:29 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5e::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719532c760dsm31386987b3.62.2025.07.23.13.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 13:35:28 -0700 (PDT)
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
Subject: [PATCH net-next v5.0 09/19] net: psp: update the TCP MSS to reflect PSP packet overhead
Date: Wed, 23 Jul 2025 13:34:40 -0700
Message-ID: <20250723203454.519540-30-daniel.zahka@gmail.com>
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


