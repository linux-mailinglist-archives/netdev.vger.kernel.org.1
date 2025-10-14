Return-Path: <netdev+bounces-229386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D07BDBAB4
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 00:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D23C4E892B
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 22:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C095B2C15BF;
	Tue, 14 Oct 2025 22:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2X5XP593"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB54D2405FD
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 22:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760481735; cv=none; b=FX0NJD0oXL6XintGlMFg4UFZZ7OW3ZiiSmWUJO95ySpI2KKTCHMBV/tKZ9qsPlZBf45dIaRhc3KuJkBdJKZwCi5E0y+mliqd6eKWJwAkw9+MDmGcrQav9LBOEuj9gpm6JurObnwfo3VzqouBP7S4p8twhKLFW1tlgM4i72XUydQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760481735; c=relaxed/simple;
	bh=rjimzhAAGtJrpZgsLBioEASAKxUmI+YWaT7CutL/ltg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=apSdAwmcDnkEpz10b9WvOxJARSXPFyaWYvTPre2zCci/nXo4xN01pWjwzv+qSmmR9W4yEWIn4rgNxBjUGxbZU9l4J2PvMToIKeFNMVD09b7cj7BTkuvC6ImCUmKAtpxvDLjhjUekjCseca3q3EZg64En6y4NKdLsXK8yiZELC3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2X5XP593; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-339b704e2e3so11249187a91.2
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 15:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760481733; x=1761086533; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iNQlXqJfNklTiIIeOsHNpIWD4DgifQ4TjMMi9UeSRbU=;
        b=2X5XP593hYgATv3GKzXKV5j0rx+0M0gOPbwx9orKoVsCLlXl5Ep8tO1AIb9Zsmh8lT
         w/9KnfsK7eYHk2hYGx1nbMB5RWeTXifRfGMcNAqo+0k0B9F80L1tsoyG55kAgJhPHR40
         4LRzwHLq0qBcdWPWUuyNeXjQqC6tNozSo1CbGohBHMAmK/4FdaKbBwb8M8UrlS4VbUvb
         SdigwDrcFhKLzgON2MzHCa7AvinlteEPx/SEMFFW086moNQ5KNdFAdktQ6FZXWjyA8fj
         YjhfJvvJxcr+EHQ99ZR2ubaOQZ9tUdPf7nJwff9718FcldHvAascC60flHzzKI9UtPPT
         /Ljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760481733; x=1761086533;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iNQlXqJfNklTiIIeOsHNpIWD4DgifQ4TjMMi9UeSRbU=;
        b=F10dItYXt9JmskL0SuPC16SB3RKYPRNTjXtGZ6g4AEBMJ4pCNiFthsTqVDe95vrsvN
         wgYD2H8Z+sk+sbGi5himfnolbNs1KfUZagoND86ZDn/77hUtsEYMSS7XR2yaToo2sIJx
         RrW9HVMAVmyV0lOxZaNSJTEzmyUSlS8RF30Udgwq9jH4hFb+ODL0WWbYPLSM9uKevjGc
         fqtqB4V5zIxklnLFwt1LRfkdtqN8Bbwn2qsCtYwQSsk/qtM32LVOEPHN4NJk1coqSFm0
         jbnpfwXfnNjXMczWWLjUrS/SlVRLLEsGGay69ibypAEP6IurVXrcPdl89261UCl9ZycU
         z3YA==
X-Forwarded-Encrypted: i=1; AJvYcCW8VXkULsdDgEkf8tTzQkNoH2wDuteW7nwkDkaiuWOShE2gCV4CwGd2Nv5/kCH2xyjNg8Vt81A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBHBK2ACljm9Nk3IrqBR95AAlCqzaEvyv/TXGZwpq1KUKP6fO9
	Rcj26+/jApw6E05QNcoXtVJ3JULVZXP0xMax6xygMcQJuAPa9pYsM11Z7j09oRl9Dq/ubIy6EQH
	a/mHzHA==
X-Google-Smtp-Source: AGHT+IG0/xH0bF0oL7Ip6BfvfCiY5rJw16WWd5Qd+cW/XuL8k2L1JPjxlqey1pFu4CZ3AS7AaQmfYESUr8s=
X-Received: from pjnj12.prod.google.com ([2002:a17:90a:840c:b0:332:a4e1:42ec])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3a8a:b0:32e:a8b7:e9c
 with SMTP id 98e67ed59e1d1-33b5139a3aamr34804810a91.29.1760481733067; Tue, 14
 Oct 2025 15:42:13 -0700 (PDT)
Date: Tue, 14 Oct 2025 22:42:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251014224210.2964778-1-kuniyu@google.com>
Subject: [PATCH v1 net-next] ipv6: Move ipv6_fl_list from ipv6_pinfo to inet_sock.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	Neal Cardwell <ncardwell@google.com>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Xin Long <lucien.xin@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In {tcp6,udp6,raw6}_sock, struct ipv6_pinfo is always placed at
the beginning of a new cache line because

  1. __alignof__(struct tcp_sock) is 64 due to ____cacheline_aligned
     of __cacheline_group_begin(tcp_sock_write_tx)

  2. __alignof__(struct udp_sock) is 64 due to ____cacheline_aligned
     of struct numa_drop_counters

  3. in raw6_sock, struct numa_drop_counters is placed before
     struct ipv6_pinfo

.  struct ipv6_pinfo is 136 bytes, but the last cache line is
only used by ipv6_fl_list:

  $ pahole -C ipv6_pinfo vmlinux
  struct ipv6_pinfo {
  ...
  	/* --- cacheline 2 boundary (128 bytes) --- */
  	struct ipv6_fl_socklist *  ipv6_fl_list;         /*   128     8 */

  	/* size: 136, cachelines: 3, members: 23 */

Let's move ipv6_fl_list from struct ipv6_pinfo to struct inet_sock
to save a full cache line for {tcp6,udp6,raw6}_sock.

Now, struct ipv6_pinfo is 128 bytes, and {tcp6,udp6,raw6}_sock have
64 bytes less, while {tcp,udp,raw}_sock retain the same size.

Before:

  # grep -E "^(RAW|UDP[^L\-]|TCP)" /proc/slabinfo | awk '{print $1, "\t", $4}'
  RAWv6 	 1408
  UDPv6 	 1472
  TCPv6 	 2560
  RAW 		 1152
  UDP	 	 1280
  TCP 		 2368

After:

  # grep -E "^(RAW|UDP[^L\-]|TCP)" /proc/slabinfo | awk '{print $1, "\t", $4}'
  RAWv6 	 1344
  UDPv6 	 1408
  TCPv6 	 2496
  RAW 		 1152
  UDP	 	 1280
  TCP 		 2368

Also, ipv6_fl_list and inet_flags (SNDFLOW bit) are placed in the
same cache line.

  $ pahole -C inet_sock vmlinux
  ...
  	/* --- cacheline 11 boundary (704 bytes) was 56 bytes ago --- */
  	struct ipv6_pinfo *        pinet6;               /*   760     8 */
  	/* --- cacheline 12 boundary (768 bytes) --- */
  	struct ipv6_fl_socklist *  ipv6_fl_list;         /*   768     8 */
  	unsigned long              inet_flags;           /*   776     8 */

Doc churn is due to the insufficient Type column (only 1 space short).

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 .../networking/net_cachelines/inet_sock.rst   | 79 ++++++++++---------
 .../chelsio/inline_crypto/chtls/chtls_cm.c    |  4 +-
 include/linux/ipv6.h                          |  1 -
 include/net/inet_sock.h                       |  1 +
 net/ipv6/ip6_flowlabel.c                      | 44 +++++------
 net/ipv6/tcp_ipv6.c                           | 13 +--
 net/sctp/ipv6.c                               |  8 +-
 7 files changed, 76 insertions(+), 74 deletions(-)

diff --git a/Documentation/networking/net_cachelines/inet_sock.rst b/Documentation/networking/net_cachelines/inet_sock.rst
index b11bf48fa2b36..4c72a28a7012e 100644
--- a/Documentation/networking/net_cachelines/inet_sock.rst
+++ b/Documentation/networking/net_cachelines/inet_sock.rst
@@ -5,42 +5,43 @@
 inet_sock struct fast path usage breakdown
 ==========================================
 
-======================= ===================== =================== =================== ======================================================================================================
-Type                    Name                  fastpath_tx_access  fastpath_rx_access  comment
-======================= ===================== =================== =================== ======================================================================================================
-struct sock             sk                    read_mostly         read_mostly         tcp_init_buffer_space,tcp_init_transfer,tcp_finish_connect,tcp_connect,tcp_send_rcvq,tcp_send_syn_data
-struct ipv6_pinfo*      pinet6
-be16                    inet_sport            read_mostly                             __tcp_transmit_skb
-be32                    inet_daddr            read_mostly                             ip_select_ident_segs
-be32                    inet_rcv_saddr
-be16                    inet_dport            read_mostly                             __tcp_transmit_skb
-u16                     inet_num
-be32                    inet_saddr
-s16                     uc_ttl                read_mostly                             __ip_queue_xmit/ip_select_ttl
-u16                     cmsg_flags
-struct ip_options_rcu*  inet_opt              read_mostly                             __ip_queue_xmit
-u16                     inet_id               read_mostly                             ip_select_ident_segs
-u8                      tos                   read_mostly                             ip_queue_xmit
-u8                      min_ttl
-u8                      mc_ttl
-u8                      pmtudisc
-u8:1                    recverr
-u8:1                    is_icsk
-u8:1                    freebind
-u8:1                    hdrincl
-u8:1                    mc_loop
-u8:1                    transparent
-u8:1                    mc_all
-u8:1                    nodefrag
-u8:1                    bind_address_no_port
-u8:1                    recverr_rfc4884
-u8:1                    defer_connect         read_mostly                             tcp_sendmsg_fastopen
-u8                      rcv_tos
-u8                      convert_csum
-int                     uc_index
-int                     mc_index
-be32                    mc_addr
-struct ip_mc_socklist*  mc_list
-struct inet_cork_full   cork                  read_mostly                             __tcp_transmit_skb
-struct                  local_port_range
-======================= ===================== =================== =================== ======================================================================================================
+======================== ===================== =================== =================== ======================================================================================================
+Type                     Name                  fastpath_tx_access  fastpath_rx_access  comment
+======================== ===================== =================== =================== ======================================================================================================
+struct sock              sk                    read_mostly         read_mostly         tcp_init_buffer_space,tcp_init_transfer,tcp_finish_connect,tcp_connect,tcp_send_rcvq,tcp_send_syn_data
+struct ipv6_pinfo*       pinet6
+struct ipv6_fl_socklist* ipv6_fl_list          read_mostly                             tcp_v6_connect,__ip6_datagram_connect,udpv6_sendmsg,rawv6_sendmsg
+be16                     inet_sport            read_mostly                             __tcp_transmit_skb
+be32                     inet_daddr            read_mostly                             ip_select_ident_segs
+be32                     inet_rcv_saddr
+be16                     inet_dport            read_mostly                             __tcp_transmit_skb
+u16                      inet_num
+be32                     inet_saddr
+s16                      uc_ttl                read_mostly                             __ip_queue_xmit/ip_select_ttl
+u16                      cmsg_flags
+struct ip_options_rcu*   inet_opt              read_mostly                             __ip_queue_xmit
+u16                      inet_id               read_mostly                             ip_select_ident_segs
+u8                       tos                   read_mostly                             ip_queue_xmit
+u8                       min_ttl
+u8                       mc_ttl
+u8                       pmtudisc
+u8:1                     recverr
+u8:1                     is_icsk
+u8:1                     freebind
+u8:1                     hdrincl
+u8:1                     mc_loop
+u8:1                     transparent
+u8:1                     mc_all
+u8:1                     nodefrag
+u8:1                     bind_address_no_port
+u8:1                     recverr_rfc4884
+u8:1                     defer_connect         read_mostly                             tcp_sendmsg_fastopen
+u8                       rcv_tos
+u8                       convert_csum
+int                      uc_index
+int                      mc_index
+be32                     mc_addr
+struct ip_mc_socklist*   mc_list
+struct inet_cork_full    cork                  read_mostly                             __tcp_transmit_skb
+struct                   local_port_range
+======================== ===================== =================== =================== ======================================================================================================
diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
index 4ee970f3bad6e..ee0154337a9c5 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
@@ -1199,12 +1199,12 @@ static struct sock *chtls_recv_sock(struct sock *lsk,
 		struct ipv6_pinfo *newnp = inet6_sk(newsk);
 		struct ipv6_pinfo *np = inet6_sk(lsk);
 
-		inet_sk(newsk)->pinet6 = &newtcp6sk->inet6;
+		newinet->pinet6 = &newtcp6sk->inet6;
+		newinet->ipv6_fl_list = NULL;
 		memcpy(newnp, np, sizeof(struct ipv6_pinfo));
 		newsk->sk_v6_daddr = treq->ir_v6_rmt_addr;
 		newsk->sk_v6_rcv_saddr = treq->ir_v6_loc_addr;
 		inet6_sk(newsk)->saddr = treq->ir_v6_loc_addr;
-		newnp->ipv6_fl_list = NULL;
 		newnp->pktoptions = NULL;
 		newsk->sk_bound_dev_if = treq->ir_iif;
 		newinet->inet_opt = NULL;
diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 43b7bb8287388..7294e4e89b797 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -271,7 +271,6 @@ struct ipv6_pinfo {
 
 	struct ipv6_mc_socklist	__rcu *ipv6_mc_list;
 	struct ipv6_ac_socklist	*ipv6_ac_list;
-	struct ipv6_fl_socklist __rcu *ipv6_fl_list;
 };
 
 /* We currently use available bits from inet_sk(sk)->inet_flags,
diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index 1086256549faa..b6ec08072533a 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -214,6 +214,7 @@ struct inet_sock {
 	struct sock		sk;
 #if IS_ENABLED(CONFIG_IPV6)
 	struct ipv6_pinfo	*pinet6;
+	struct ipv6_fl_socklist __rcu *ipv6_fl_list;
 #endif
 	/* Socket demultiplex comparisons on incoming packets. */
 #define inet_daddr		sk.__sk_common.skc_daddr
diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index a3ff575798dda..60d0be47a9f31 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -66,8 +66,8 @@ EXPORT_SYMBOL(ipv6_flowlabel_exclusive);
 	     fl != NULL;					\
 	     fl = rcu_dereference(fl->next))
 
-#define for_each_sk_fl_rcu(np, sfl)				\
-	for (sfl = rcu_dereference(np->ipv6_fl_list);	\
+#define for_each_sk_fl_rcu(sk, sfl)				\
+	for (sfl = rcu_dereference(inet_sk(sk)->ipv6_fl_list);	\
 	     sfl != NULL;					\
 	     sfl = rcu_dereference(sfl->next))
 
@@ -262,12 +262,11 @@ static struct ip6_flowlabel *fl_intern(struct net *net,
 struct ip6_flowlabel *__fl6_sock_lookup(struct sock *sk, __be32 label)
 {
 	struct ipv6_fl_socklist *sfl;
-	struct ipv6_pinfo *np = inet6_sk(sk);
 
 	label &= IPV6_FLOWLABEL_MASK;
 
 	rcu_read_lock();
-	for_each_sk_fl_rcu(np, sfl) {
+	for_each_sk_fl_rcu(sk, sfl) {
 		struct ip6_flowlabel *fl = sfl->fl;
 
 		if (fl->label == label && atomic_inc_not_zero(&fl->users)) {
@@ -283,16 +282,16 @@ EXPORT_SYMBOL_GPL(__fl6_sock_lookup);
 
 void fl6_free_socklist(struct sock *sk)
 {
-	struct ipv6_pinfo *np = inet6_sk(sk);
+	struct inet_sock *inet = inet_sk(sk);
 	struct ipv6_fl_socklist *sfl;
 
-	if (!rcu_access_pointer(np->ipv6_fl_list))
+	if (!rcu_access_pointer(inet->ipv6_fl_list))
 		return;
 
 	spin_lock_bh(&ip6_sk_fl_lock);
-	while ((sfl = rcu_dereference_protected(np->ipv6_fl_list,
+	while ((sfl = rcu_dereference_protected(inet->ipv6_fl_list,
 						lockdep_is_held(&ip6_sk_fl_lock))) != NULL) {
-		np->ipv6_fl_list = sfl->next;
+		inet->ipv6_fl_list = sfl->next;
 		spin_unlock_bh(&ip6_sk_fl_lock);
 
 		fl_release(sfl->fl);
@@ -470,16 +469,15 @@ fl_create(struct net *net, struct sock *sk, struct in6_flowlabel_req *freq,
 
 static int mem_check(struct sock *sk)
 {
-	struct ipv6_pinfo *np = inet6_sk(sk);
-	struct ipv6_fl_socklist *sfl;
 	int room = FL_MAX_SIZE - atomic_read(&fl_size);
+	struct ipv6_fl_socklist *sfl;
 	int count = 0;
 
 	if (room > FL_MAX_SIZE - FL_MAX_PER_SOCK)
 		return 0;
 
 	rcu_read_lock();
-	for_each_sk_fl_rcu(np, sfl)
+	for_each_sk_fl_rcu(sk, sfl)
 		count++;
 	rcu_read_unlock();
 
@@ -492,13 +490,15 @@ static int mem_check(struct sock *sk)
 	return 0;
 }
 
-static inline void fl_link(struct ipv6_pinfo *np, struct ipv6_fl_socklist *sfl,
-		struct ip6_flowlabel *fl)
+static inline void fl_link(struct sock *sk, struct ipv6_fl_socklist *sfl,
+			   struct ip6_flowlabel *fl)
 {
+	struct inet_sock *inet = inet_sk(sk);
+
 	spin_lock_bh(&ip6_sk_fl_lock);
 	sfl->fl = fl;
-	sfl->next = np->ipv6_fl_list;
-	rcu_assign_pointer(np->ipv6_fl_list, sfl);
+	sfl->next = inet->ipv6_fl_list;
+	rcu_assign_pointer(inet->ipv6_fl_list, sfl);
 	spin_unlock_bh(&ip6_sk_fl_lock);
 }
 
@@ -520,7 +520,7 @@ int ipv6_flowlabel_opt_get(struct sock *sk, struct in6_flowlabel_req *freq,
 
 	rcu_read_lock();
 
-	for_each_sk_fl_rcu(np, sfl) {
+	for_each_sk_fl_rcu(sk, sfl) {
 		if (sfl->fl->label == (np->flow_label & IPV6_FLOWLABEL_MASK)) {
 			spin_lock_bh(&ip6_fl_lock);
 			freq->flr_label = sfl->fl->label;
@@ -559,7 +559,7 @@ static int ipv6_flowlabel_put(struct sock *sk, struct in6_flowlabel_req *freq)
 	}
 
 	spin_lock_bh(&ip6_sk_fl_lock);
-	for (sflp = &np->ipv6_fl_list;
+	for (sflp = &inet_sk(sk)->ipv6_fl_list;
 	     (sfl = socklist_dereference(*sflp)) != NULL;
 	     sflp = &sfl->next) {
 		if (sfl->fl->label == freq->flr_label)
@@ -579,13 +579,12 @@ static int ipv6_flowlabel_put(struct sock *sk, struct in6_flowlabel_req *freq)
 
 static int ipv6_flowlabel_renew(struct sock *sk, struct in6_flowlabel_req *freq)
 {
-	struct ipv6_pinfo *np = inet6_sk(sk);
 	struct net *net = sock_net(sk);
 	struct ipv6_fl_socklist *sfl;
 	int err;
 
 	rcu_read_lock();
-	for_each_sk_fl_rcu(np, sfl) {
+	for_each_sk_fl_rcu(sk, sfl) {
 		if (sfl->fl->label == freq->flr_label) {
 			err = fl6_renew(sfl->fl, freq->flr_linger,
 					freq->flr_expires);
@@ -614,7 +613,6 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
 {
 	struct ipv6_fl_socklist *sfl, *sfl1 = NULL;
 	struct ip6_flowlabel *fl, *fl1 = NULL;
-	struct ipv6_pinfo *np = inet6_sk(sk);
 	struct net *net = sock_net(sk);
 	int err;
 
@@ -645,7 +643,7 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
 	if (freq->flr_label) {
 		err = -EEXIST;
 		rcu_read_lock();
-		for_each_sk_fl_rcu(np, sfl) {
+		for_each_sk_fl_rcu(sk, sfl) {
 			if (sfl->fl->label == freq->flr_label) {
 				if (freq->flr_flags & IPV6_FL_F_EXCL) {
 					rcu_read_unlock();
@@ -682,7 +680,7 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
 				fl1->linger = fl->linger;
 			if ((long)(fl->expires - fl1->expires) > 0)
 				fl1->expires = fl->expires;
-			fl_link(np, sfl1, fl1);
+			fl_link(sk, sfl1, fl1);
 			fl_free(fl);
 			return 0;
 
@@ -716,7 +714,7 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
 		}
 	}
 
-	fl_link(np, sfl1, fl);
+	fl_link(sk, sfl1, fl);
 	return 0;
 done:
 	fl_free(fl);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 59c4977a811a0..6197dd4e6261c 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1386,7 +1386,9 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 		if (!newsk)
 			return NULL;
 
-		inet_sk(newsk)->pinet6 = tcp_inet6_sk(newsk);
+		newinet = inet_sk(newsk);
+		newinet->pinet6 = tcp_inet6_sk(newsk);
+		newinet->ipv6_fl_list = NULL;
 
 		newnp = tcp_inet6_sk(newsk);
 		newtp = tcp_sk(newsk);
@@ -1405,7 +1407,6 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 
 		newnp->ipv6_mc_list = NULL;
 		newnp->ipv6_ac_list = NULL;
-		newnp->ipv6_fl_list = NULL;
 		newnp->pktoptions  = NULL;
 		newnp->opt	   = NULL;
 		newnp->mcast_oif   = inet_iif(skb);
@@ -1453,10 +1454,12 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 	newsk->sk_gso_type = SKB_GSO_TCPV6;
 	inet6_sk_rx_dst_set(newsk, skb);
 
-	inet_sk(newsk)->pinet6 = tcp_inet6_sk(newsk);
+	newinet = inet_sk(newsk);
+	newinet->pinet6 = tcp_inet6_sk(newsk);
+	newinet->ipv6_fl_list = NULL;
+	newinet->inet_opt = NULL;
 
 	newtp = tcp_sk(newsk);
-	newinet = inet_sk(newsk);
 	newnp = tcp_inet6_sk(newsk);
 
 	memcpy(newnp, np, sizeof(struct ipv6_pinfo));
@@ -1469,10 +1472,8 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 
 	   First: no IPv4 options.
 	 */
-	newinet->inet_opt = NULL;
 	newnp->ipv6_mc_list = NULL;
 	newnp->ipv6_ac_list = NULL;
-	newnp->ipv6_fl_list = NULL;
 
 	/* Clone RX bits */
 	newnp->rxopt.all = np->rxopt.all;
diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index 568ff8797c393..d725b21587588 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -782,9 +782,10 @@ static struct sock *sctp_v6_create_accept_sk(struct sock *sk,
 					     struct sctp_association *asoc,
 					     bool kern)
 {
-	struct sock *newsk;
 	struct ipv6_pinfo *newnp, *np = inet6_sk(sk);
 	struct sctp6_sock *newsctp6sk;
+	struct inet_sock *newinet;
+	struct sock *newsk;
 
 	newsk = sk_alloc(sock_net(sk), PF_INET6, GFP_KERNEL, sk->sk_prot, kern);
 	if (!newsk)
@@ -796,7 +797,9 @@ static struct sock *sctp_v6_create_accept_sk(struct sock *sk,
 	sock_reset_flag(sk, SOCK_ZAPPED);
 
 	newsctp6sk = (struct sctp6_sock *)newsk;
-	inet_sk(newsk)->pinet6 = &newsctp6sk->inet6;
+	newinet = inet_sk(newsk);
+	newinet->pinet6 = &newsctp6sk->inet6;
+	newinet->ipv6_fl_list = NULL;
 
 	sctp_sk(newsk)->v4mapped = sctp_sk(sk)->v4mapped;
 
@@ -805,7 +808,6 @@ static struct sock *sctp_v6_create_accept_sk(struct sock *sk,
 	memcpy(newnp, np, sizeof(struct ipv6_pinfo));
 	newnp->ipv6_mc_list = NULL;
 	newnp->ipv6_ac_list = NULL;
-	newnp->ipv6_fl_list = NULL;
 
 	sctp_v6_copy_ip_options(sk, newsk);
 
-- 
2.51.0.788.g6d19910ace-goog


