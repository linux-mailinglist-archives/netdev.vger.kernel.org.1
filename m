Return-Path: <netdev+bounces-207493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D88B0787C
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 16:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913F01C21DA5
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 14:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADBA2EA175;
	Wed, 16 Jul 2025 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEu0WITQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AAA291C05
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677170; cv=none; b=hg3jyONA50PNgsQOYcUDpsg9bsCwFlyW8+htSqaFjf4xp/agQIY8Aue8QLBu4Xl3Y5sMSwMEXfTVs0dey6TUeK4YjLtUXWWXVX5+O0OAbV/e91RokBwusn3XHgJABUcEiCOcErgygzNIvDbn9gGa/xmR8Mzou4YHBKJ1gEFiFyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677170; c=relaxed/simple;
	bh=eyoW4CMRfmsCXpD8myZ/nTr5JT2jDn7BaqeIA1EsmyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZalzTYAdiWS8aIntKtSUN9pWLODuABs2DWWAHHTu0I+qOf4U7uGNmvBJZGHgALzDaLiw+6PMXBmbP4hCNll18b3o6dmq+D6xdda4qm7GFvSuXpcTlj/EtNh3vwMjkJzNEQKBafb/Wa70t26KVqynQ8kwBeMnm89Mrf76oy+pGLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEu0WITQ; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e8bacc192e0so2504029276.0
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 07:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752677168; x=1753281968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xA4rElamY2Fnh1PIbu4tGVBzmQCmGU56F/FAiA8w75I=;
        b=MEu0WITQp7/5xyKtcLRW3BbWR1/RQx3Oqck0wLYy/LhwJ0sA3p9gyWaF525sAJcuaz
         HjaxvRxRwA6Z2srpT+9x/H0XzklhBTaeBNeN3zkCfVpZEP1gQDM+G4H8JO+xvzi2bu7x
         NcXMr8/M7WYmfa4YhGZb8qMQE5c+7bI8eD3xlBcc2cpVx8DJTNvu7KgYDlIfe9227ImI
         zq24UcYGU9DP8pcGynl9PkOKyUcqU5zxOiVaHsaAaBEOOgnwzDv/jag1w2W5GUFyJxLM
         usRrUJqjJbLQzgJxykQJ0KUjMLU/btWg7uV+EX7GVt62XZ9HHCB4+1rFWP8P6aPkdUQ6
         W6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677168; x=1753281968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xA4rElamY2Fnh1PIbu4tGVBzmQCmGU56F/FAiA8w75I=;
        b=kD3ng8itReBSh0JHVN0vsERJLhjsXwU9Xx6DurphTA76hO6F1zVKfwGIXqLkPAsxHO
         LrhWICTRv6KvYa6NCVtw+o7NgDkFLXOYhWdc/UFOuZOrBbu07QHBl2QSRqDNvzIYYJvK
         cg9KTg/VlNA6UarXCfFncqy/wG22MHPg/9LD7Bt7kq+WamC8uINg8zBBAZ/07HEf/+5L
         ARvNpR0d59kA8phXjTn8qkNv3M/MMc27vOFZu2+XholmnYNGQhWxpEgUA9EnMrD9cHJQ
         F9sgn4Ol9clzk1cK9yg4SBp9p2SqYLbO3cK1bXsG/kHmHKv9324GPtt0bFchfuPURa38
         BXxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUUAcO5KX8B21imwBiIrUfWMU2T83Bdd9YZmlexDguU10/VLmmirmJdXvO5iSFlMPfeoIB9aA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMXnYq6xe2mhIlg7pNA028DODImJUmFcLNc+vQ4WCum2urYA1/
	bbBAIQZLMh+Gdh9WAPVzWwZf2YoXVovBodHhBlvTC3zNneLnUdF8qCHY
X-Gm-Gg: ASbGncu5BEdX95fvBGu3SEWxvKGwfkr3ZLaCVkBnyf1LSf13HVkWcfs/4w4GAv2DHSH
	D9guAMa1fmnuLmZN7DsrxNAZwna7xMDT4uYRdCk3QnvChdHfPDnohtpiVpa6v0jk3nvivM+lhsB
	TpFFMPtHoB3mQF6FpNGl+LgpB3Tt3MEKxDMwApjEWImEuh9//p/kauS3fb+1amYoJP0BQ+DzT/b
	4Rk5gI+cNNdAxzDexa/5lmOBWnRoBszM6SGcVfrdxoMfkFNV9h+5mP2e7B51rgRaqeyN6S2Qy77
	pQ9k1EWT1/MizG+z2W+GIL7ki51+vvUiS7ixow46YwdZSCPXJTBKslK9PNukYBLwtUptVhPoF56
	z+W1Oc0JUQnPGdXBON6Rk1KRNM2OqXHo=
X-Google-Smtp-Source: AGHT+IHXD0AZ6fMEhtHl7gAP2ZdFfQPrjhYOClzEVm08rzCtCnvjj2lol/yMD7iwaQr6QEHOTbfTTA==
X-Received: by 2002:a05:6902:2d8e:b0:e84:23cf:acf3 with SMTP id 3f1490d57ef6-e8bc25137d6mr2385911276.39.1752677167525;
        Wed, 16 Jul 2025 07:46:07 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:44::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8b7afcd3f7sm4369884276.47.2025.07.16.07.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:46:06 -0700 (PDT)
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
Subject: [PATCH net-next v4 09/19] net: psp: update the TCP MSS to reflect PSP packet overhead
Date: Wed, 16 Jul 2025 07:45:30 -0700
Message-ID: <20250716144551.3646755-10-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250716144551.3646755-1-daniel.zahka@gmail.com>
References: <20250716144551.3646755-1-daniel.zahka@gmail.com>
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
index 378db5917c80..afb08ffd02b2 100644
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


