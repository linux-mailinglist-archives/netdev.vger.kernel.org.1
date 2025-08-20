Return-Path: <netdev+bounces-215226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB5AB2DB10
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 13:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47343179013
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 11:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0362E7193;
	Wed, 20 Aug 2025 11:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLg2wlWw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0205930498E
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 11:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755689494; cv=none; b=Y77zbiPCp4jRLZ71J9fky/jg2wpd4301lO9pJOFdHkbThYBKz0jwW5Wpus8AXiJ8IyP6RuceMWtU05pELNPPBYmJfDgyyfxvEeHoF51qAJUizWbiKu2iHSZwMT2Uctlt60ubfoapXzqLJlBFnYGwc+WWqcMONmD8fzXjQ327yHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755689494; c=relaxed/simple;
	bh=ZjZ+9XSRdL1NNJWECE4bR3b8xUgqec2jVVaXuyLs4mI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eucHy2UHG8l0Af94+7sG6IDIBgaKEwP+NtjIiA2aavjNZTHoypktcpEeeF1Tch8IF118lmmy/VdaVk+D37l7LnH3DHwIadLt5j0E9feyitvKkhH9Llw2eLHCRwOAseIw9R6KVbOLkNoiZ8gL4EI77ABy9zAhuAVbFNd7wOsOrwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLg2wlWw; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e934c8f9751so3498343276.2
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 04:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755689492; x=1756294292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCS3+f7av+InabTMNNCT7TnhPsUOD+ix7EtCirdhXZI=;
        b=MLg2wlWwwYa99YetjBQ1PQSdp77DKCpT667AhGiojA7GV7APoHSXBqwym7M3iZxvuW
         amKpwne+iWYiYUwbibb93MBtSfCi/7rfbsFWpynKJMMImXNnHW6+4CU1mQ90WVBfylfn
         v/QuzZIZtkpWzeSASRhnCkxTwWvhH7F/UZIAEEYGOSnDPUVtBgDShE2VRwgV691oUhJY
         DkEzESrN15ddrE5k/8SXooy9J4G5pjKqzkzVZ4E5zw/RX3O/QrbLIxEpypSA6YrON/1o
         b3rXCIIOZT0x6x7x6duo93FD+w6KeviMsLrp3C+HMtDswnTjhqwgmZ58AaQlQZ8BYBe5
         Dk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755689492; x=1756294292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCS3+f7av+InabTMNNCT7TnhPsUOD+ix7EtCirdhXZI=;
        b=AA9juVWCNOM2zwdEu0kvee5pa6RaiAToTuND7+sSfmKgKpeZNzCyKkcXzxngX5ILxn
         6XGuV2OgxqeiSneN3hrTIuAneBtj3M3nbvBJgdqi/vw4IYdPK5IqSlAZwNDtnXS8Y4GF
         6EZdFC65Dbc3XBtgg149p90iYHA+hwFz4kXQEZb+fj4djCO95kUQllhPZUnPluHqamfK
         /R8w3/WezLzw5lvBWJaF/46YGEEuV6ce2SnpaT3y/IBcyOgoh9BvvPmMBD8YaPw0s5TQ
         yBuAGShmI06xMcXQlCL0IM34CSMxBXQ/myEUODwbKQ5CV+GnrcHiZFFhcZqBF89YfbgH
         F/xg==
X-Forwarded-Encrypted: i=1; AJvYcCVulE2R7HshtHeYldSCc96u7pJnYOULd77t0GcKSqQLIyyLaMFJcYm73vCS0KLwJjb7+SyguXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRnd3coEHUd8/qp5138HlO/BejG1tQ7cOvDMmIRJdstopFvcPm
	pm3ZXV11w0+1ZGjArkeQZnH7l7uwOrLNdSOwNYktek0rc8wj9JqrSHRd
X-Gm-Gg: ASbGncvaQXk2T+AkTkSjGT1lFN2J25FzXAQge+ODwh0Bhb9NiBE2DQHVblaf7ftHEiq
	Lym6YrWfL3ayQo4LhRmO3ZpCEFISKxI+huUk4+8ok6p5Zw5HE2p9CS9mNoYDGdh0oNRxgU+3g4t
	m3Pvjz8WVoznyuqmhF6ws4c36hMm1McFy/MvjYDMcVooj7jj6xYFSnCi2YRhpJ7sWWiKyazRANb
	pDbsn5f4F/5kl01cAUGUw32zNh3ko/jsbndZtFVS4+VgX5m9Y3ysowx0nxpGGz64gH6nXRHoJYA
	YAEIePD0COqESMh4AvL5qSy+mUVuyiP2s1khoMV/0F/c5KbeESUOhvVuqyGSlihDs+AKGfYiMsl
	Ec6/OlLwXUh/pArbGKnfo
X-Google-Smtp-Source: AGHT+IG+kjYaVCkN86BEF5EIx0J8IHBEscNxbZo3TpII1MdQE2Te/8sTGmwxijKDEM2mur9pKBXusQ==
X-Received: by 2002:a05:690c:998e:b0:71c:44eb:fae9 with SMTP id 00721157ae682-71fb30cfbecmr27081587b3.4.1755689491766;
        Wed, 20 Aug 2025 04:31:31 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:44::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6e05bf0asm35901667b3.54.2025.08.20.04.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 04:31:31 -0700 (PDT)
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
Subject: [PATCH net-next v7 09/19] net: psp: update the TCP MSS to reflect PSP packet overhead
Date: Wed, 20 Aug 2025 04:31:07 -0700
Message-ID: <20250820113120.992829-10-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250820113120.992829-1-daniel.zahka@gmail.com>
References: <20250820113120.992829-1-daniel.zahka@gmail.com>
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


