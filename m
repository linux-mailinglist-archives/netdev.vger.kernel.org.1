Return-Path: <netdev+bounces-217356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9BAB38711
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 17:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B382A1B6770C
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 15:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C621314A76;
	Wed, 27 Aug 2025 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXEq3WyJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B9F2FABE9
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 15:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310035; cv=none; b=ZrWM/6NcTSo6qd/D+k1yJy8aVccDxgWEYQSqJkv1TkPZojXOEQGB2+WWKz+g/O/iv4v6KSO0yAOQNhODr7asq40pRkzqlzG+bfN0stvobjbCW6yhbB5eV2HNdS2hCces/do81uF2V0dTq4YHBscQBMWeFmLFo3+D9BwyxyZI41g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310035; c=relaxed/simple;
	bh=Fd6T0u/2uLvTlgLZragf+fDZDHSS5CGqbWEQoX9OVV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fFWMV9KxZn144waDuB9miP5g18k2FlPzOM6Zv5eKKi8pZVIqnFeMW6QTN+0vSoxn9icYgFdf6jaRxw84CbnuAKoiaylaDnDdeVwWXBu8aOTzAHfnq5I6sJ53hf9QeOR0mYgkIMDjp5qgPFFowKD4lqQvIGJkVM7krowaAZmlO9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXEq3WyJ; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d605c6501so61670517b3.3
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 08:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756310032; x=1756914832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8xDM3wzpeQoe6hncyGahcZRU86aSdOd+rChJYN+VuI=;
        b=TXEq3WyJ98rS0k47OVzwZuf2kyc2vj0b2j3OZokENI1wrir1NlIVdAI+1UNf8atFip
         UlX+001En/d/XFk1NxjeJkwe1G7d8/O3ywb8MV37Myj5KiGNdGGCMNe6igb1NUqjyCjt
         QTXfcvJ1Hyrs9Z599GmRueGHSUII0AHx9osGhzU48wIxZlZC7RiO2LTJGHyAPDe8ScGs
         0BugS4LOFd5Wtwhe7BR+bQYpb2ydDf6fCpzsvyaIIcJNVVrNqyU9NGT1di+zs5lGjYmF
         LWK2lQEktYdO9kHGzZTvKMRwzvs+WtcGWTDtUPqSXffYZleQiz7lSkwrq4bOP7/oCUEC
         kgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756310032; x=1756914832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8xDM3wzpeQoe6hncyGahcZRU86aSdOd+rChJYN+VuI=;
        b=qnFppOYX6/67EDQRUKOCYQ8nAQe6e3En2eVUZAG/c/3voahe2R8+b7MRF7r7BtaE03
         lg19nHt5yhkOdaLCZi2AKyQ4yNW/4fUghX5/fc63SeMi6BRRSLFPNuL6eK2gzVqlvUSd
         AMiG4A3W6b5oUtVksDYsEhBYJNjLdGrgjz9dyd1nm3oHYOpr41GHwuzsb0OUEivK07AO
         sxVgK35CAWrtP+2S8NgxefajJHmmBEtexkAvoKw3GPali1p6EHcxcqI6QZCxFB2C+N7T
         SH3/qDeEvrStGfcEwfwf2VWEQIepARwCXu1wRA/Ph4Q3d3A64fx6etz7OK7G93RHfacI
         eIHA==
X-Forwarded-Encrypted: i=1; AJvYcCXVXm9J2sNx/x6OHXQz2ETNUWqTiaO7ZGgbgH04LT/FI1H0yzrAZIFY+911i2KKzHmQvlqT3Gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQUKeHHb7r653BpeFf88fhQ/RYgIxIluMCHrPvfwMjufDjGeO4
	29Wb+3rQb+Y0x3lYI4av2p9PvbwqoxDYnJCVk8I5ZaWKTTQQwIaKTVky
X-Gm-Gg: ASbGnctCHUYFdk2ILFLurhH/T1jhf40BEyb4ybsftjZukkh15w5uYoSmRTWBNZKwj7C
	wYUqv946zS+pmSOi/Sl0pulYB3RItI1euoZo14uuflpkM1hNxm1p8kWzB3H5pYNuI4EqHEEUlUU
	8y+JhO/k50qySatTWXPoViuhe+/OZH7SmLrOV6zD6ATvsHaoHfPZNmALT/1HIqVCeIRfyKLgFcF
	6AQ+0+KDt6mWwYrDTOkC+RrO68DjHI2MwwFhjVozhGAemo48CycPbfJexUjoqWTSCPrMjWrtndu
	Bjd76zV8Ga4lw52lCv6MxfChWA1RKGBE5/9RnlhAmrvYk2ucMcY3sPhL3pHVmakN8ae0TuNww0B
	27l8c7uD88BbRNoAWJuc=
X-Google-Smtp-Source: AGHT+IFCK2Hsjfq/G3Y519NYYNPftEwLOEDu7a/NkPw9fXfio3f+8xd88ar7LHiLznh99eXcw4v/vA==
X-Received: by 2002:a05:690c:680c:b0:71c:e6ff:3236 with SMTP id 00721157ae682-71fdc560610mr229686847b3.37.1756310032352;
        Wed, 27 Aug 2025 08:53:52 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff18ae99dsm31725357b3.54.2025.08.27.08.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:53:51 -0700 (PDT)
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
Subject: [PATCH net-next v9 09/19] net: psp: update the TCP MSS to reflect PSP packet overhead
Date: Wed, 27 Aug 2025 08:53:26 -0700
Message-ID: <20250827155340.2738246-10-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250827155340.2738246-1-daniel.zahka@gmail.com>
References: <20250827155340.2738246-1-daniel.zahka@gmail.com>
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
index bf703dcf353f..958c50dad34d 100644
--- a/include/net/psp/functions.h
+++ b/include/net/psp/functions.h
@@ -5,6 +5,7 @@
 
 #include <linux/skbuff.h>
 #include <linux/rcupdate.h>
+#include <linux/udp.h>
 #include <net/sock.h>
 #include <net/tcp.h>
 #include <net/psp/types.h>
@@ -139,6 +140,14 @@ static inline struct psp_assoc *psp_skb_get_assoc_rcu(struct sk_buff *skb)
 
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
@@ -178,6 +187,11 @@ static inline struct psp_assoc *psp_skb_get_assoc_rcu(struct sk_buff *skb)
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
index 13263aaeffa5..e7562469604e 100644
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
index c25c834ba5bc..1eb6aeeb1915 100644
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
index 9b761d186e80..66abf160e16c 100644
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


