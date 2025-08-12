Return-Path: <netdev+bounces-212682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D83B219D1
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 02:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7707C1A24102
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 00:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89582D63F1;
	Tue, 12 Aug 2025 00:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioy8qfTS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301CE2D543A
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 00:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754958623; cv=none; b=M52QHh2ooUv3xQpjUcMRjcQpDpNlAYUW8MUNqIiZZ8+q8WC3hPwY7+UtnN2DDFT3kN0z2+fvrq3LGlxoPWSEyDo+M6+baVDnizx/HAQyIzL/ii5sMSs+icsDxt5gJa2BV7xFXSA1/avL12a6je3BeYneriktWpQHpERo5yU8B4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754958623; c=relaxed/simple;
	bh=ZjZ+9XSRdL1NNJWECE4bR3b8xUgqec2jVVaXuyLs4mI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLCfvMD36eV0TidCIvhtQPF4fxgXgSsTiWWTs+eOWK+5bMnwPbfoyIsgTINdgJw6ausfCem/kpCXvvBUpVwptUgOHHAQUtVvfpaSpiqZ2TLRvC7M40AHB2XJ2RC2mhno6NGT5WeKvFEsOnbN1trvExAustZ4f0qHZUt7GpVKkc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioy8qfTS; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-712be7e034cso50503057b3.0
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 17:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754958621; x=1755563421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCS3+f7av+InabTMNNCT7TnhPsUOD+ix7EtCirdhXZI=;
        b=ioy8qfTSI7hCaG/DCklA2vP/LIRjf0nO9701IuVbcPaPCOSnqpMM4waNdrzggG3XHv
         ne6abTSGpsmuqzbK25Q47wpWLksluEpvlKIY2AnZ1TzU/fMWmfCSvWQDx53MQ79nXxMl
         DwRQHyf0XygZjWJtwtaaiMZudgdHfZv5uwWcC8k63TqAewju1rt6AlhdxnE+yS4S+udZ
         EqU7G6TrsJuEXtFJ3q6T7Fd24j4kiCHk43tJ1YReGZ/mRNaRv6+SWXlGzWy4Hhye6gBl
         aYBQDrES1o/ySfqhDQBqwPVuGIZWwIIHdnSC6yRSds6yuWLr4b3UgoJ+8zoaJc+m/k+w
         s89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754958621; x=1755563421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCS3+f7av+InabTMNNCT7TnhPsUOD+ix7EtCirdhXZI=;
        b=f+oAbiqtKAjAMJb9d/PeeK99glICjMoLMpCdjHvbzuWcxIXctTtSc9MNrxBf2BtMgq
         +sejs72Sv/tSf12/U6cw0gjkvO8X7/tM7BhoffLQoyDWoczTxrTlTl7WkoS+6bI2zVYm
         RHSHzR2nY1o1NfWOG0Aq+sthSwBIIVBGL0wSD1V9JQFWuImrGyGsCAuB3P0l0bEwDTjj
         R7PcSRDiju/mYTVBEcDoA9Ccv4pCrkKae7KgX5ChNmDrAn43QTBiLw+EFqwadsw2DZ2w
         35GWdKjjcoXjCAg2h3AovcCEZfTl/TcvFTxmtj6xAjKBHTykaPECp+t8Egu9MYJTLs02
         SUig==
X-Forwarded-Encrypted: i=1; AJvYcCUJXE1//YBN9ZyG+Mp3Mssx6oXD6jVJCfTYZ2VLbkfQKIKURGUWJ61EZ1OEjiUyAVl2+fN/0fI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBdIBGGFX0sUk3wgR8E+i+GHLBKGSEaZr0Z1OkmQ8Ws2G/tguf
	JZo6Itny9MWp4mUz7X1rd4GfmEqwQaQwbfvDnDyGKVEVGeX677PQ9mxW
X-Gm-Gg: ASbGncuJBZniRX5+G6pYvEX5YPmjPQlXfvigfEq/qelRF4Y1Yl+GZxfxJaD6q51rtg4
	5NcIQFQTBHr13grUm4qpVWwON3m1EpT1TWRjf+KigJ56QAQyMRIlEXNbaujGxN7Zy8UZ3OdgWCK
	7E23YHH2VpEZyXAtpVXTmFpTfZm0MtHoTjiVtvgl3ynlX26WEEuzTtYtDukWBHK9opzORkqG+Mb
	iohMCkGATpfV6MskirISsOjmFnIWqtpQmJM1NgFKl0o//k6/V/wHd1sxpHQA+09irkYMZS+0h9N
	FKBPQ291uxTBqbsnQDUv+PQiDtOfXGAtFN9fgiBc9xzaqkPRyPL05LeuiZzd2AJAs8+/hHCiVhB
	uFEaTwRDLk4MV3gH61Lo=
X-Google-Smtp-Source: AGHT+IE1YTmfG0SY7DtnD3yC4eqGGsmDbKE65KNGVmilbZ3SesnQrCGWMt4jfZVikVGj/BMdfAiOJg==
X-Received: by 2002:a05:690c:7001:b0:71a:4325:a182 with SMTP id 00721157ae682-71c42a5c9c5mr26720457b3.24.1754958621026;
        Mon, 11 Aug 2025 17:30:21 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71c44458bc4sm2086097b3.14.2025.08.11.17.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 17:30:20 -0700 (PDT)
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
Subject: [PATCH net-next v6 09/19] net: psp: update the TCP MSS to reflect PSP packet overhead
Date: Mon, 11 Aug 2025 17:29:56 -0700
Message-ID: <20250812003009.2455540-10-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250812003009.2455540-1-daniel.zahka@gmail.com>
References: <20250812003009.2455540-1-daniel.zahka@gmail.com>
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


