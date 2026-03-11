Return-Path: <netdev+bounces-266470-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MF8BOMj7sGnCpQIAu9opvQ
	(envelope-from <netdev+bounces-266470-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 06:21:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 642BF25C5E1
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 06:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39EA33137614
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 05:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CAE32A3E1;
	Wed, 11 Mar 2026 05:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UaZBMbxB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3070D1DF736
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 05:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773206436; cv=none; b=fAn/GOYf91VSOUKXRlYC/YpeyEMFDQEWj9hCDfGey8bDquiXLes6Gyw90pZ4DhqB52mAsBmeoxkHuDssH5WaKtmXYazT4Bp/rdiTc+Yijp+69I8oI3JguKBdwTs5yxseiu+btCJLV+AbsMhKacIO8WoqsW6TBVWdHpVyx+3ADKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773206436; c=relaxed/simple;
	bh=U9rEzkoupMm8A41otQ7yJDhFOlcMYNFjuykdo25HCTA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j4uOCnRVlsAophdrNrNwE4VIZPRkE8tEzanRxaG2z/+xDFC4FxTa9lXbauk+8VyazpWFKBb196BqxNX20yhXhKhW92PLDPwQCsb/6R/h/JUe6OTiNq4XzTw9lVj5q84k2RuLfr1ZYud/7xbznwt7LwAs0kJfaGxBPj03TxYSQXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UaZBMbxB; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3598c05c806so9921049a91.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 22:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773206434; x=1773811234; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MPAkUiQXEbxdZvxoBa1UPbnIOmJxCLBImcNMcYsfJdo=;
        b=UaZBMbxBVRA+pKPBVVCeqXPmLbqe2DDRXUJ5rPGcz7XT06uELOkvrTlp+5+uYEOGNb
         lZ/Pjny3gndVMnU4pWfTWmDsgr3SiqvGavpUSN73DH3uMEGELawuUgb6CLBD9ivDY3uq
         cxw1LvXjOIYbH8eDryZiU1v+Nevh74EPKDdmn077687UJEcDyC+p/CHUmYd0KPTi8jSV
         s1a3RqUQaT3Eoz/A9DZcQmb1ys4s9w8IjYhnDomBBhpBk7mfIUIsddpLNC5uAuQqfx7G
         Ffstlc6+cTmi4vHCwZm+iQFwibzmtyhCpSjLs7KQh2qiNexwoxSKyhnuKnZvtD+a4SvU
         k9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773206434; x=1773811234;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MPAkUiQXEbxdZvxoBa1UPbnIOmJxCLBImcNMcYsfJdo=;
        b=tWSH1BLQRRR/LBAq2IVbVapVtLM0pcE59KuRgc11f8aC09MtoI3OdoWjJo4VNMy7u5
         OlgSdQx7qQuHdDK1V3EKIv5BctNU0TFfJZUcXxMmr/lEtAgWrASpKgn5cWR31tZuwBON
         UDMURDTfhk5tKpgz8clQi916qCwPQ8SGzlT/gcLZZxEOGjS3Z+ygcFRk39H79whHamzA
         1g6DnxYpl8HGXl2bCK/rL7gcthc9STDF7jjOyXgiu+HUXhVuSjhcYgmkGCC5G9+CLBG1
         HA8uQUX1diYaSA2FgKVxF0kU7rYc6MYhfwydDDXCM++78MDVKHcQuqBJ6hK8wnkLjZNc
         M78A==
X-Forwarded-Encrypted: i=1; AJvYcCVHwIxEuXt6lisLgszbXVhS0WC0HIwzzcrRV0QaeX8dERy6ML1iSW9X/1NQPToYSjLLGU6iG2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBnwAd7KWa4HZ5XQRGTF6OvCZezuPgJux6Kh0ybYuj94i+uJxJ
	Y/EVGT0Jihfhaedrsp0DYed7wFazfyaHl1a/ZC1EGDUan9qo/tXhgEgZwTThO2ihh/QirmDNVRB
	5IZhrVg==
X-Received: from pjl16.prod.google.com ([2002:a17:90b:2f90:b0:359:7ae5:9fdc])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4986:b0:359:9a87:85b5
 with SMTP id 98e67ed59e1d1-35a0134b71amr1370202a91.29.1773206434401; Tue, 10
 Mar 2026 22:20:34 -0700 (PDT)
Date: Wed, 11 Mar 2026 05:19:52 +0000
In-Reply-To: <20260311052020.1213705-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260311052020.1213705-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260311052020.1213705-6-kuniyu@google.com>
Subject: [PATCH v3 net-next 05/15] udp: Remove UDP-Lite SNMP stats.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 642BF25C5E1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266470-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,strlen.de,google.com,gmail.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Since UDP and UDP-Lite shared most of the code, we have had
to check the protocol every time we increment SNMP stats.

Now that the UDP-Lite paths are dead, let's remove UDP-Lite
SNMP stats.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 include/net/netns/mib.h |  5 ---
 include/net/udp.h       | 46 ++++++++++---------------
 net/ipv4/af_inet.c      |  6 ----
 net/ipv4/proc.c         | 13 -------
 net/ipv4/udp.c          | 75 ++++++++++++++++++-----------------------
 net/ipv6/af_inet6.c     |  9 ++---
 net/ipv6/proc.c         | 14 --------
 net/ipv6/udp.c          | 48 +++++++++++---------------
 8 files changed, 71 insertions(+), 145 deletions(-)

diff --git a/include/net/netns/mib.h b/include/net/netns/mib.h
index 7e373664b1e7..dce05f8e6a33 100644
--- a/include/net/netns/mib.h
+++ b/include/net/netns/mib.h
@@ -28,11 +28,6 @@ struct netns_mib {
 	DEFINE_SNMP_STAT(struct mptcp_mib, mptcp_statistics);
 #endif
 
-	DEFINE_SNMP_STAT(struct udp_mib, udplite_statistics);
-#if IS_ENABLED(CONFIG_IPV6)
-	DEFINE_SNMP_STAT(struct udp_mib, udplite_stats_in6);
-#endif
-
 	DEFINE_SNMP_STAT(struct icmp_mib, icmp_statistics);
 	DEFINE_SNMP_STAT_ATOMIC(struct icmpmsg_mib, icmpmsg_statistics);
 #if IS_ENABLED(CONFIG_IPV6)
diff --git a/include/net/udp.h b/include/net/udp.h
index 39223e2692e9..264c10607d2e 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -529,38 +529,28 @@ static inline int copy_linear_skb(struct sk_buff *skb, int len, int off,
 }
 
 /*
- * 	SNMP statistics for UDP and UDP-Lite
+ *	SNMP statistics for UDP
  */
-#define UDP_INC_STATS(net, field, is_udplite)		      do { \
-	if (unlikely(is_udplite)) SNMP_INC_STATS((net)->mib.udplite_statistics, field);	\
-	else		SNMP_INC_STATS((net)->mib.udp_statistics, field);  }  while(0)
-#define __UDP_INC_STATS(net, field, is_udplite) 	      do { \
-	if (unlikely(is_udplite)) __SNMP_INC_STATS((net)->mib.udplite_statistics, field);	\
-	else		__SNMP_INC_STATS((net)->mib.udp_statistics, field);    }  while(0)
-
-#define __UDP6_INC_STATS(net, field, is_udplite)	    do { \
-	if (unlikely(is_udplite)) __SNMP_INC_STATS((net)->mib.udplite_stats_in6, field);	\
-	else		__SNMP_INC_STATS((net)->mib.udp_stats_in6, field);  \
-} while(0)
-#define UDP6_INC_STATS(net, field, __lite)		    do { \
-	if (unlikely(__lite)) SNMP_INC_STATS((net)->mib.udplite_stats_in6, field);	\
-	else	    SNMP_INC_STATS((net)->mib.udp_stats_in6, field);      \
-} while(0)
+#define __UDP_INC_STATS(net, field)				\
+	__SNMP_INC_STATS((net)->mib.udp_statistics, field)
+#define UDP_INC_STATS(net, field)				\
+	SNMP_INC_STATS((net)->mib.udp_statistics, field)
+#define __UDP6_INC_STATS(net, field)				\
+	__SNMP_INC_STATS((net)->mib.udp_stats_in6, field)
+#define UDP6_INC_STATS(net, field)				\
+	SNMP_INC_STATS((net)->mib.udp_stats_in6, field)
 
 #if IS_ENABLED(CONFIG_IPV6)
-#define __UDPX_MIB(sk, ipv4)						\
-({									\
-	ipv4 ? (IS_UDPLITE(sk) ? sock_net(sk)->mib.udplite_statistics :	\
-				 sock_net(sk)->mib.udp_statistics) :	\
-		(IS_UDPLITE(sk) ? sock_net(sk)->mib.udplite_stats_in6 :	\
-				 sock_net(sk)->mib.udp_stats_in6);	\
-})
+#define __UDPX_MIB(sk, ipv4)					\
+	({							\
+		ipv4 ? sock_net(sk)->mib.udp_statistics :	\
+			sock_net(sk)->mib.udp_stats_in6;	\
+	})
 #else
-#define __UDPX_MIB(sk, ipv4)						\
-({									\
-	IS_UDPLITE(sk) ? sock_net(sk)->mib.udplite_statistics :		\
-			 sock_net(sk)->mib.udp_statistics;		\
-})
+#define __UDPX_MIB(sk, ipv4)					\
+	({							\
+		sock_net(sk)->mib.udp_statistics;		\
+	})
 #endif
 
 #define __UDPX_INC_STATS(sk, field) \
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 58347619003c..4a4c290e3f7e 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1727,9 +1727,6 @@ static __net_init int ipv4_mib_init_net(struct net *net)
 	net->mib.udp_statistics = alloc_percpu(struct udp_mib);
 	if (!net->mib.udp_statistics)
 		goto err_udp_mib;
-	net->mib.udplite_statistics = alloc_percpu(struct udp_mib);
-	if (!net->mib.udplite_statistics)
-		goto err_udplite_mib;
 	net->mib.icmp_statistics = alloc_percpu(struct icmp_mib);
 	if (!net->mib.icmp_statistics)
 		goto err_icmp_mib;
@@ -1743,8 +1740,6 @@ static __net_init int ipv4_mib_init_net(struct net *net)
 err_icmpmsg_mib:
 	free_percpu(net->mib.icmp_statistics);
 err_icmp_mib:
-	free_percpu(net->mib.udplite_statistics);
-err_udplite_mib:
 	free_percpu(net->mib.udp_statistics);
 err_udp_mib:
 	free_percpu(net->mib.net_statistics);
@@ -1760,7 +1755,6 @@ static __net_exit void ipv4_mib_exit_net(struct net *net)
 {
 	kfree(net->mib.icmpmsg_statistics);
 	free_percpu(net->mib.icmp_statistics);
-	free_percpu(net->mib.udplite_statistics);
 	free_percpu(net->mib.udp_statistics);
 	free_percpu(net->mib.net_statistics);
 	free_percpu(net->mib.ip_statistics);
diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index cf51f8fcf34b..bfc06d1713ec 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -444,19 +444,6 @@ static int snmp_seq_show_tcp_udp(struct seq_file *seq, void *v)
 	for (i = 0; i < udp_cnt; i++)
 		seq_printf(seq, " %lu", buff[i]);
 
-	memset(buff, 0, udp_cnt * sizeof(unsigned long));
-
-	/* the UDP and UDP-Lite MIBs are the same */
-	seq_puts(seq, "\nUdpLite:");
-	snmp_get_cpu_field_batch_cnt(buff, snmp4_udp_list,
-				     udp_cnt,
-				     net->mib.udplite_statistics);
-	for (i = 0; i < udp_cnt; i++)
-		seq_printf(seq, " %s", snmp4_udp_list[i].name);
-	seq_puts(seq, "\nUdpLite:");
-	for (i = 0; i < udp_cnt; i++)
-		seq_printf(seq, " %lu", buff[i]);
-
 	seq_putc(seq, '\n');
 	return 0;
 }
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index b3f63a5ea2a9..10082095e633 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1198,13 +1198,12 @@ static int udp_send_skb(struct sk_buff *skb, struct flowi4 *fl4,
 	if (unlikely(err)) {
 		if (err == -ENOBUFS &&
 		    !inet_test_bit(RECVERR, sk)) {
-			UDP_INC_STATS(sock_net(sk),
-				      UDP_MIB_SNDBUFERRORS, is_udplite);
+			UDP_INC_STATS(sock_net(sk), UDP_MIB_SNDBUFERRORS);
 			err = 0;
 		}
-	} else
-		UDP_INC_STATS(sock_net(sk),
-			      UDP_MIB_OUTDATAGRAMS, is_udplite);
+	} else {
+		UDP_INC_STATS(sock_net(sk), UDP_MIB_OUTDATAGRAMS);
+	}
 	return err;
 }
 
@@ -1535,10 +1534,9 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	 * things).  We could add another new stat but at least for now that
 	 * seems like overkill.
 	 */
-	if (err == -ENOBUFS || test_bit(SOCK_NOSPACE, &sk->sk_socket->flags)) {
-		UDP_INC_STATS(sock_net(sk),
-			      UDP_MIB_SNDBUFERRORS, is_udplite);
-	}
+	if (err == -ENOBUFS || test_bit(SOCK_NOSPACE, &sk->sk_socket->flags))
+		UDP_INC_STATS(sock_net(sk), UDP_MIB_SNDBUFERRORS);
+
 	return err;
 
 do_confirm:
@@ -1897,10 +1895,10 @@ static struct sk_buff *__first_packet_length(struct sock *sk,
 
 	while ((skb = skb_peek(rcvq)) != NULL) {
 		if (udp_lib_checksum_complete(skb)) {
-			__UDP_INC_STATS(sock_net(sk), UDP_MIB_CSUMERRORS,
-					IS_UDPLITE(sk));
-			__UDP_INC_STATS(sock_net(sk), UDP_MIB_INERRORS,
-					IS_UDPLITE(sk));
+			struct net *net = sock_net(sk);
+
+			__UDP_INC_STATS(net, UDP_MIB_CSUMERRORS);
+			__UDP_INC_STATS(net, UDP_MIB_INERRORS);
 			udp_drops_inc(sk);
 			__skb_unlink(skb, rcvq);
 			*total += skb->truesize;
@@ -2052,11 +2050,10 @@ int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 		return err;
 
 	if (udp_lib_checksum_complete(skb)) {
-		int is_udplite = IS_UDPLITE(sk);
 		struct net *net = sock_net(sk);
 
-		__UDP_INC_STATS(net, UDP_MIB_CSUMERRORS, is_udplite);
-		__UDP_INC_STATS(net, UDP_MIB_INERRORS, is_udplite);
+		__UDP_INC_STATS(net, UDP_MIB_CSUMERRORS);
+		__UDP_INC_STATS(net, UDP_MIB_INERRORS);
 		udp_drops_inc(sk);
 		kfree_skb_reason(skb, SKB_DROP_REASON_UDP_CSUM);
 		goto try_again;
@@ -2081,6 +2078,7 @@ int udp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags)
 	unsigned int ulen, copied;
 	int off, err, peeking = flags & MSG_PEEK;
 	int is_udplite = IS_UDPLITE(sk);
+	struct net *net = sock_net(sk);
 	bool checksum_valid = false;
 
 	if (flags & MSG_ERRQUEUE)
@@ -2128,16 +2126,14 @@ int udp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags)
 	if (unlikely(err)) {
 		if (!peeking) {
 			udp_drops_inc(sk);
-			UDP_INC_STATS(sock_net(sk),
-				      UDP_MIB_INERRORS, is_udplite);
+			UDP_INC_STATS(net, UDP_MIB_INERRORS);
 		}
 		kfree_skb(skb);
 		return err;
 	}
 
 	if (!peeking)
-		UDP_INC_STATS(sock_net(sk),
-			      UDP_MIB_INDATAGRAMS, is_udplite);
+		UDP_INC_STATS(net, UDP_MIB_INDATAGRAMS);
 
 	sock_recv_cmsgs(msg, sk, skb);
 
@@ -2170,8 +2166,8 @@ int udp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags)
 csum_copy_err:
 	if (!__sk_queue_drop_skb(sk, &udp_sk(sk)->reader_queue, skb, flags,
 				 udp_skb_destructor)) {
-		UDP_INC_STATS(sock_net(sk), UDP_MIB_CSUMERRORS, is_udplite);
-		UDP_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
+		UDP_INC_STATS(net, UDP_MIB_CSUMERRORS);
+		UDP_INC_STATS(net, UDP_MIB_INERRORS);
 	}
 	kfree_skb_reason(skb, SKB_DROP_REASON_UDP_CSUM);
 
@@ -2371,20 +2367,18 @@ static int __udp_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 
 	rc = __udp_enqueue_schedule_skb(sk, skb);
 	if (rc < 0) {
-		int is_udplite = IS_UDPLITE(sk);
+		struct net *net = sock_net(sk);
 		int drop_reason;
 
 		/* Note that an ENOMEM error is charged twice */
 		if (rc == -ENOMEM) {
-			UDP_INC_STATS(sock_net(sk), UDP_MIB_RCVBUFERRORS,
-					is_udplite);
+			UDP_INC_STATS(net, UDP_MIB_RCVBUFERRORS);
 			drop_reason = SKB_DROP_REASON_SOCKET_RCVBUFF;
 		} else {
-			UDP_INC_STATS(sock_net(sk), UDP_MIB_MEMERRORS,
-				      is_udplite);
+			UDP_INC_STATS(net, UDP_MIB_MEMERRORS);
 			drop_reason = SKB_DROP_REASON_PROTO_MEM;
 		}
-		UDP_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
+		UDP_INC_STATS(net, UDP_MIB_INERRORS);
 		trace_udp_fail_queue_rcv_skb(rc, sk, skb);
 		sk_skb_reason_drop(sk, skb, drop_reason);
 		return -1;
@@ -2405,7 +2399,7 @@ static int udp_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 {
 	enum skb_drop_reason drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct udp_sock *up = udp_sk(sk);
-	int is_udplite = IS_UDPLITE(sk);
+	struct net *net = sock_net(sk);
 
 	/*
 	 *	Charge it to the socket, dropping if the queue is full.
@@ -2442,9 +2436,7 @@ static int udp_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 
 			ret = encap_rcv(sk, skb);
 			if (ret <= 0) {
-				__UDP_INC_STATS(sock_net(sk),
-						UDP_MIB_INDATAGRAMS,
-						is_udplite);
+				__UDP_INC_STATS(net, UDP_MIB_INDATAGRAMS);
 				return -ret;
 			}
 		}
@@ -2503,9 +2495,9 @@ static int udp_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 
 csum_error:
 	drop_reason = SKB_DROP_REASON_UDP_CSUM;
-	__UDP_INC_STATS(sock_net(sk), UDP_MIB_CSUMERRORS, is_udplite);
+	__UDP_INC_STATS(net, UDP_MIB_CSUMERRORS);
 drop:
-	__UDP_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
+	__UDP_INC_STATS(net, UDP_MIB_INERRORS);
 	udp_drops_inc(sk);
 	sk_skb_reason_drop(sk, skb, drop_reason);
 	return -1;
@@ -2592,10 +2584,8 @@ static int __udp4_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 
 		if (unlikely(!nskb)) {
 			udp_drops_inc(sk);
-			__UDP_INC_STATS(net, UDP_MIB_RCVBUFERRORS,
-					IS_UDPLITE(sk));
-			__UDP_INC_STATS(net, UDP_MIB_INERRORS,
-					IS_UDPLITE(sk));
+			__UDP_INC_STATS(net, UDP_MIB_RCVBUFERRORS);
+			__UDP_INC_STATS(net, UDP_MIB_INERRORS);
 			continue;
 		}
 		if (udp_queue_rcv_skb(sk, nskb) > 0)
@@ -2613,8 +2603,7 @@ static int __udp4_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 			consume_skb(skb);
 	} else {
 		kfree_skb(skb);
-		__UDP_INC_STATS(net, UDP_MIB_IGNOREDMULTI,
-				proto == IPPROTO_UDPLITE);
+		__UDP_INC_STATS(net, UDP_MIB_IGNOREDMULTI);
 	}
 	return 0;
 }
@@ -2764,7 +2753,7 @@ static int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 		goto csum_error;
 
 	drop_reason = SKB_DROP_REASON_NO_SOCKET;
-	__UDP_INC_STATS(net, UDP_MIB_NOPORTS, proto == IPPROTO_UDPLITE);
+	__UDP_INC_STATS(net, UDP_MIB_NOPORTS);
 	icmp_send(skb, ICMP_DEST_UNREACH, ICMP_PORT_UNREACH, 0);
 
 	/*
@@ -2793,9 +2782,9 @@ static int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 			    proto == IPPROTO_UDPLITE ? "Lite" : "",
 			    &saddr, ntohs(uh->source), &daddr, ntohs(uh->dest),
 			    ulen);
-	__UDP_INC_STATS(net, UDP_MIB_CSUMERRORS, proto == IPPROTO_UDPLITE);
+	__UDP_INC_STATS(net, UDP_MIB_CSUMERRORS);
 drop:
-	__UDP_INC_STATS(net, UDP_MIB_INERRORS, proto == IPPROTO_UDPLITE);
+	__UDP_INC_STATS(net, UDP_MIB_INERRORS);
 	sk_skb_reason_drop(sk, skb, drop_reason);
 	return 0;
 }
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 9ad907a5a093..97d0bbce1720 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -894,9 +894,7 @@ static int __net_init ipv6_init_mibs(struct net *net)
 	net->mib.udp_stats_in6 = alloc_percpu(struct udp_mib);
 	if (!net->mib.udp_stats_in6)
 		return -ENOMEM;
-	net->mib.udplite_stats_in6 = alloc_percpu(struct udp_mib);
-	if (!net->mib.udplite_stats_in6)
-		goto err_udplite_mib;
+
 	net->mib.ipv6_statistics = alloc_percpu(struct ipstats_mib);
 	if (!net->mib.ipv6_statistics)
 		goto err_ip_mib;
@@ -907,10 +905,10 @@ static int __net_init ipv6_init_mibs(struct net *net)
 		u64_stats_init(&af_inet6_stats->syncp);
 	}
 
-
 	net->mib.icmpv6_statistics = alloc_percpu(struct icmpv6_mib);
 	if (!net->mib.icmpv6_statistics)
 		goto err_icmp_mib;
+
 	net->mib.icmpv6msg_statistics = kzalloc_obj(struct icmpv6msg_mib);
 	if (!net->mib.icmpv6msg_statistics)
 		goto err_icmpmsg_mib;
@@ -921,8 +919,6 @@ static int __net_init ipv6_init_mibs(struct net *net)
 err_icmp_mib:
 	free_percpu(net->mib.ipv6_statistics);
 err_ip_mib:
-	free_percpu(net->mib.udplite_stats_in6);
-err_udplite_mib:
 	free_percpu(net->mib.udp_stats_in6);
 	return -ENOMEM;
 }
@@ -930,7 +926,6 @@ static int __net_init ipv6_init_mibs(struct net *net)
 static void ipv6_cleanup_mibs(struct net *net)
 {
 	free_percpu(net->mib.udp_stats_in6);
-	free_percpu(net->mib.udplite_stats_in6);
 	free_percpu(net->mib.ipv6_statistics);
 	free_percpu(net->mib.icmpv6_statistics);
 	kfree(net->mib.icmpv6msg_statistics);
diff --git a/net/ipv6/proc.c b/net/ipv6/proc.c
index 21bfc73152f0..813013ca4e75 100644
--- a/net/ipv6/proc.c
+++ b/net/ipv6/proc.c
@@ -108,17 +108,6 @@ static const struct snmp_mib snmp6_udp6_list[] = {
 	SNMP_MIB_ITEM("Udp6MemErrors", UDP_MIB_MEMERRORS),
 };
 
-static const struct snmp_mib snmp6_udplite6_list[] = {
-	SNMP_MIB_ITEM("UdpLite6InDatagrams", UDP_MIB_INDATAGRAMS),
-	SNMP_MIB_ITEM("UdpLite6NoPorts", UDP_MIB_NOPORTS),
-	SNMP_MIB_ITEM("UdpLite6InErrors", UDP_MIB_INERRORS),
-	SNMP_MIB_ITEM("UdpLite6OutDatagrams", UDP_MIB_OUTDATAGRAMS),
-	SNMP_MIB_ITEM("UdpLite6RcvbufErrors", UDP_MIB_RCVBUFERRORS),
-	SNMP_MIB_ITEM("UdpLite6SndbufErrors", UDP_MIB_SNDBUFERRORS),
-	SNMP_MIB_ITEM("UdpLite6InCsumErrors", UDP_MIB_CSUMERRORS),
-	SNMP_MIB_ITEM("UdpLite6MemErrors", UDP_MIB_MEMERRORS),
-};
-
 static void snmp6_seq_show_icmpv6msg(struct seq_file *seq, atomic_long_t *smib)
 {
 	char name[32];
@@ -226,9 +215,6 @@ static int snmp6_seq_show(struct seq_file *seq, void *v)
 	snmp6_seq_show_item(seq, net->mib.udp_stats_in6,
 			    NULL, snmp6_udp6_list,
 			    ARRAY_SIZE(snmp6_udp6_list));
-	snmp6_seq_show_item(seq, net->mib.udplite_stats_in6,
-			    NULL, snmp6_udplite6_list,
-			    ARRAY_SIZE(snmp6_udplite6_list));
 	return 0;
 }
 
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index aa859bb0527d..07308b7156a6 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -796,20 +796,18 @@ static int __udpv6_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 
 	rc = __udp_enqueue_schedule_skb(sk, skb);
 	if (rc < 0) {
-		int is_udplite = IS_UDPLITE(sk);
 		enum skb_drop_reason drop_reason;
+		struct net *net = sock_net(sk);
 
 		/* Note that an ENOMEM error is charged twice */
 		if (rc == -ENOMEM) {
-			UDP6_INC_STATS(sock_net(sk),
-					 UDP_MIB_RCVBUFERRORS, is_udplite);
+			UDP6_INC_STATS(net, UDP_MIB_RCVBUFERRORS);
 			drop_reason = SKB_DROP_REASON_SOCKET_RCVBUFF;
 		} else {
-			UDP6_INC_STATS(sock_net(sk),
-				       UDP_MIB_MEMERRORS, is_udplite);
+			UDP6_INC_STATS(net, UDP_MIB_MEMERRORS);
 			drop_reason = SKB_DROP_REASON_PROTO_MEM;
 		}
-		UDP6_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
+		UDP6_INC_STATS(net, UDP_MIB_INERRORS);
 		trace_udp_fail_queue_rcv_skb(rc, sk, skb);
 		sk_skb_reason_drop(sk, skb, drop_reason);
 		return -1;
@@ -830,7 +828,7 @@ static int udpv6_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 {
 	enum skb_drop_reason drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct udp_sock *up = udp_sk(sk);
-	int is_udplite = IS_UDPLITE(sk);
+	struct net *net = sock_net(sk);
 
 	if (!xfrm6_policy_check(sk, XFRM_POLICY_IN, skb)) {
 		drop_reason = SKB_DROP_REASON_XFRM_POLICY;
@@ -864,9 +862,7 @@ static int udpv6_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 
 			ret = encap_rcv(sk, skb);
 			if (ret <= 0) {
-				__UDP6_INC_STATS(sock_net(sk),
-						 UDP_MIB_INDATAGRAMS,
-						 is_udplite);
+				__UDP6_INC_STATS(net, UDP_MIB_INDATAGRAMS);
 				return -ret;
 			}
 		}
@@ -909,9 +905,9 @@ static int udpv6_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 
 csum_error:
 	drop_reason = SKB_DROP_REASON_UDP_CSUM;
-	__UDP6_INC_STATS(sock_net(sk), UDP_MIB_CSUMERRORS, is_udplite);
+	__UDP6_INC_STATS(net, UDP_MIB_CSUMERRORS);
 drop:
-	__UDP6_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
+	__UDP6_INC_STATS(net, UDP_MIB_INERRORS);
 	udp_drops_inc(sk);
 	sk_skb_reason_drop(sk, skb, drop_reason);
 	return -1;
@@ -1018,10 +1014,8 @@ static int __udp6_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 		nskb = skb_clone(skb, GFP_ATOMIC);
 		if (unlikely(!nskb)) {
 			udp_drops_inc(sk);
-			__UDP6_INC_STATS(net, UDP_MIB_RCVBUFERRORS,
-					 IS_UDPLITE(sk));
-			__UDP6_INC_STATS(net, UDP_MIB_INERRORS,
-					 IS_UDPLITE(sk));
+			__UDP6_INC_STATS(net, UDP_MIB_RCVBUFERRORS);
+			__UDP6_INC_STATS(net, UDP_MIB_INERRORS);
 			continue;
 		}
 
@@ -1040,8 +1034,7 @@ static int __udp6_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 			consume_skb(skb);
 	} else {
 		kfree_skb(skb);
-		__UDP6_INC_STATS(net, UDP_MIB_IGNOREDMULTI,
-				 proto == IPPROTO_UDPLITE);
+		__UDP6_INC_STATS(net, UDP_MIB_IGNOREDMULTI);
 	}
 	return 0;
 }
@@ -1213,7 +1206,7 @@ static int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 	if (udp_lib_checksum_complete(skb))
 		goto csum_error;
 
-	__UDP6_INC_STATS(net, UDP_MIB_NOPORTS, proto == IPPROTO_UDPLITE);
+	__UDP6_INC_STATS(net, UDP_MIB_NOPORTS);
 	icmpv6_send(skb, ICMPV6_DEST_UNREACH, ICMPV6_PORT_UNREACH, 0);
 
 	sk_skb_reason_drop(sk, skb, reason);
@@ -1234,9 +1227,9 @@ static int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 csum_error:
 	if (reason == SKB_DROP_REASON_NOT_SPECIFIED)
 		reason = SKB_DROP_REASON_UDP_CSUM;
-	__UDP6_INC_STATS(net, UDP_MIB_CSUMERRORS, proto == IPPROTO_UDPLITE);
+	__UDP6_INC_STATS(net, UDP_MIB_CSUMERRORS);
 discard:
-	__UDP6_INC_STATS(net, UDP_MIB_INERRORS, proto == IPPROTO_UDPLITE);
+	__UDP6_INC_STATS(net, UDP_MIB_INERRORS);
 	sk_skb_reason_drop(sk, skb, reason);
 	return 0;
 }
@@ -1490,13 +1483,11 @@ static int udp_v6_send_skb(struct sk_buff *skb, struct flowi6 *fl6,
 	err = ip6_send_skb(skb);
 	if (unlikely(err)) {
 		if (err == -ENOBUFS && !inet6_test_bit(RECVERR6, sk)) {
-			UDP6_INC_STATS(sock_net(sk),
-				       UDP_MIB_SNDBUFERRORS, is_udplite);
+			UDP6_INC_STATS(sock_net(sk), UDP_MIB_SNDBUFERRORS);
 			err = 0;
 		}
 	} else {
-		UDP6_INC_STATS(sock_net(sk),
-			       UDP_MIB_OUTDATAGRAMS, is_udplite);
+		UDP6_INC_STATS(sock_net(sk), UDP_MIB_OUTDATAGRAMS);
 	}
 	return err;
 }
@@ -1826,10 +1817,9 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	 * things).  We could add another new stat but at least for now that
 	 * seems like overkill.
 	 */
-	if (err == -ENOBUFS || test_bit(SOCK_NOSPACE, &sk->sk_socket->flags)) {
-		UDP6_INC_STATS(sock_net(sk),
-			       UDP_MIB_SNDBUFERRORS, is_udplite);
-	}
+	if (err == -ENOBUFS || test_bit(SOCK_NOSPACE, &sk->sk_socket->flags))
+		UDP6_INC_STATS(sock_net(sk), UDP_MIB_SNDBUFERRORS);
+
 	return err;
 
 do_confirm:
-- 
2.53.0.473.g4a7958ca14-goog


