Return-Path: <netdev+bounces-217913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6EFB3A64C
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 18:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F011985166
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 16:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE7A32A3F1;
	Thu, 28 Aug 2025 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWKNAUHZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1398122A4EB
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 16:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398609; cv=none; b=l4B5fdwpjulfg0zxHe0jb+Ki5k4VXIU786B9A1ULVHwC+MyhoQq60hgNTrn6waW0g3cIiMWXoG0GxY5Bn9rR78tS/Y3qasPJp0wx3e/JdN1IA2iWD3Fbh+IWLi7gX4i03w8QlC1cL2DYQ70pqfABzOYu/3UMB4PzTp8ihAZ/l/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398609; c=relaxed/simple;
	bh=DOI536vNPhx3PyG5XJVls8nlYrtL6/vFBrnEaRkQfRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hscs29lu50JOAbiuNXUbp1loMlJZ1TF7ojJpbxYzvdH43imoZ7+JuklguGlQE6dTxHJduIBx2gIX5o0SE4zT1kiXYpWOmkHsHe4AlALmVSFPi25A4znD/401mFBnWTjF0j0FEqBBJ84mJQQX+rslCgp1R42nIJD9gyB2vqRuBuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWKNAUHZ; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d603cebd9so10478637b3.1
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 09:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756398607; x=1757003407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7acRvExkTAYL+MC1kahnW0nnl0h/Cz+45cWPSyp0BtI=;
        b=QWKNAUHZsYHJ0gigG0h1HbHqg2x1wdAS5O0KGHLwj+Me0jDrDr3sz7CeXpLWhuzrlr
         HXLd8el1AoqP4Wq5LuuYYMCHooddpQpBJj8OIf0IZ7/7XOo/l8DX+R3fuCN8SQtTpyb8
         nf+DLHf11dQbcUMP+NhelvCybUTh5Dnsnxv6rYbnmbEYv/eNc6as8wplbKZXE0TP59nj
         HpkqpDh/43xQs8KYgguHc2eC01hTrOAFWAsBjoglW3q+uk7JgmOmzq0R9cFOVGxbHy/c
         EXLdYRx3SYlRLo/PdhuPObYK2MgzajwiZBaXYqMLHlDcC0jIC8QDcZjaxldmpp1qWqBb
         7HSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756398607; x=1757003407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7acRvExkTAYL+MC1kahnW0nnl0h/Cz+45cWPSyp0BtI=;
        b=LFMFRe2dSzF+zqBf7RZvfLGmfpi8xYM74s2pHoS7tPX4bYd/hW1l6Lb6UIAUjEc4UI
         by0WryaVKBCqrtQdXAcEg0cN0PHaPacy0hCkHE+35wIJxtSQUlEAe6JbquGUpcksvrkX
         wcKnU10HVL9t5vZMY5BjIlKm3qwi4pY72Txrvtw+MUd8FJT9lsmGvcVnTWgJaD2OPuhT
         v0X3oL0Am3qqajiWNXo2K+cHzJOBLAF7+Xt/tN5DIHnhoDMXHSBfQies01huZA8S06hB
         gaW5dHDEVl9y0KytClRh8L+gtqIGMdbOeyQqd21OcwwjCYp7zBZhZ2yrvFKNW1oDtitd
         JaPw==
X-Forwarded-Encrypted: i=1; AJvYcCWyYEwOyOVVDT3+dr4B07MunxpZKrtTHxZTNYRe6AAn7iD5IubfWDWAkmkDwiHNbdNptqlXmFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVsEv8AJUFLpiC9yZiJcOlc+NXo6LE/LKccMj2LArPstFzor/V
	TVM7txBmMiGOTIWDZRq/3Wd/1jQ+YnezTIyDKLuHB/CvoaXwnY8KdGR0
X-Gm-Gg: ASbGncu7n5lRadPb8S5Augpr68ZooRj9cm6MgfkmJMJdABV35Z7gSH86lxH07XaSsx3
	clUCVPJrStGtY1rqaVnoBVDtd+VKqHHhra/JVUB9JCXWlXTJ/S5GsN72du7dg32zbDOSOQxds13
	3WRDDR5au22xgGW3tdvbaN/ZaW0cvF10aEQJeLd0CBUevZUduQrrmfAFyRhWsBVkMbYNZAXckNZ
	zDjhAPvi0ENpsAQkvtzstFhjMXYB5QALfsr5AlbrYVhwm0K3sKkNoiTnkKWPnjxa2Bfq8zQ0sGB
	QQsKPYWZ11QS4Wj4V9JFigkn4bGNmayeGSmpvukJZ/V4IzZEK0Zwbl6ONZcjni9o7+FFNhFUaLT
	nLU56t50EpxPQjI/qdWtd
X-Google-Smtp-Source: AGHT+IHQQ38bNX5EJUI33HVS7AZZEqBVD/gyFxlEcGR7O6kfNKaoT2Ix+himxwOrVn0d2mrhlebUMQ==
X-Received: by 2002:a05:690c:dc1:b0:720:3cf:3bcc with SMTP id 00721157ae682-72003cf3d2bmr243551227b3.23.1756398605697;
        Thu, 28 Aug 2025 09:30:05 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:45::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-721ce5c3726sm413377b3.58.2025.08.28.09.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 09:30:05 -0700 (PDT)
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
Subject: [PATCH net-next v10 09/19] net: psp: update the TCP MSS to reflect PSP packet overhead
Date: Thu, 28 Aug 2025 09:29:35 -0700
Message-ID: <20250828162953.2707727-10-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250828162953.2707727-1-daniel.zahka@gmail.com>
References: <20250828162953.2707727-1-daniel.zahka@gmail.com>
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
index f046e33f4c87..d5f19059c9b2 100644
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
index 7a88f67820a1..da1147509cab 100644
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


