Return-Path: <netdev+bounces-306909-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p3SlDdXwUmpqVgMAu9opvQ
	(envelope-from <netdev+bounces-306909-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 03:41:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2E07436AA
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 03:41:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=A+EuM1AD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qbbTs9QB;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=A+EuM1AD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qbbTs9QB;
	dmarc=pass (policy=none) header.from=suse.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306909-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306909-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 018C2300AB14
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 01:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAA22222AC;
	Sun, 12 Jul 2026 01:41:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95D82222A9
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 01:41:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783820475; cv=none; b=EkmTepSghQ9VRxiv9RuylgW1W5WKKbbT5T7H8ZW0Xbwxa0XKuYoBPioq5ZSgoVtJ3jb4Um+int0/AcVo2Eg9vUhplJhapOEIBm58Ae8Y024VnQw9pcKcmQXklFQKo8GnYN8Qw8udG2ie89zragUgA7uhz675qxaT3Gio1YmHqaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783820475; c=relaxed/simple;
	bh=JXUGhM8e7RDFSzsptzTYjHVyIem5YpvgU3mtCVzaeUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhSKZgVdIkZU/nlIw+be0Qb4/rAdiRhbqlF8PB38Cz0Lkk46CuOpxOncAB1ALvrCht7ycPRR/j+ev2zB60ZLjScOXHVYPAd+InkeOpYDn9V2G3eeFxNm50xKZmZK3Cy7OFTZOa7bkyz+BtEKrXWifguMwYtw3gl69Dxl7gsLDmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A+EuM1AD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qbbTs9QB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A+EuM1AD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qbbTs9QB; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C903A76D55;
	Sun, 12 Jul 2026 01:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783820464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aO92+iz9epSnaU5ZJ7+pEfk+FO+s+EL964l4Wn+7eig=;
	b=A+EuM1ADZq+qqr35yJOaglfxdYUMqQ376D96+tatBc0uYjXgIuf4wzVwFDp6ty6mq7JUOp
	WI2zHz+wGm/HuWL7PZjAj9O6uBKs/aYb+thXDkQHaGgt6W0l7PTg8wM5PhbUrDiUtE5KYq
	HP/YiwCRNJN/0dQ9IylTdo+Us3KFuTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783820464;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aO92+iz9epSnaU5ZJ7+pEfk+FO+s+EL964l4Wn+7eig=;
	b=qbbTs9QBrPB59GynKYpK6lTI9palmi6GkDOiSbzoh5J5UrScyx4dcHx/15fTT7UneMVz05
	ZZNxH6YRYy+lPzAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783820464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aO92+iz9epSnaU5ZJ7+pEfk+FO+s+EL964l4Wn+7eig=;
	b=A+EuM1ADZq+qqr35yJOaglfxdYUMqQ376D96+tatBc0uYjXgIuf4wzVwFDp6ty6mq7JUOp
	WI2zHz+wGm/HuWL7PZjAj9O6uBKs/aYb+thXDkQHaGgt6W0l7PTg8wM5PhbUrDiUtE5KYq
	HP/YiwCRNJN/0dQ9IylTdo+Us3KFuTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783820464;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aO92+iz9epSnaU5ZJ7+pEfk+FO+s+EL964l4Wn+7eig=;
	b=qbbTs9QBrPB59GynKYpK6lTI9palmi6GkDOiSbzoh5J5UrScyx4dcHx/15fTT7UneMVz05
	ZZNxH6YRYy+lPzAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 925C6779B5;
	Sun, 12 Jul 2026 01:41:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QA6lIK7wUmqRegAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sun, 12 Jul 2026 01:41:02 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	idosch@nvidia.com,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Neal Cardwell <ncardwell@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Florian Westphal <fw@strlen.de>,
	Kees Cook <kees@kernel.org>,
	Richard Gobert <richardbgobert@gmail.com>,
	Gal Pressman <gal@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Alice Mikityanska <alice@isovalent.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Felix Fietkau <nbd@nbd.name>,
	Jibin Zhang <jibin.zhang@mediatek.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 06/13 RFC net-next] net: udp: split IPv4 specific logic into udp_ipv4.c
Date: Sun, 12 Jul 2026 03:39:04 +0200
Message-ID: <20260712013941.4570-7-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260712013941.4570-1-fmancera@suse.de>
References: <20260712013941.4570-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -5.30
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[38];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,nvidia.com,suse.de,iogearbox.net,gmail.com,fomichev.me,linux.dev,etsalapatis.com,cloudflare.com,strlen.de,isovalent.com,queasysnail.net,nbd.name,mediatek.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306909-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:horms@kernel.org,m:idosch@nvidia.com,m:fmancera@suse.de,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:martin.lau@linux.dev,m:ast@kernel.org,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:willemdebruijn.kernel@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:ncardwell@google.com,m:ebiggers@kernel.org,m:kuniyu@google.com,m:fw@strlen.de,m:kees@kernel.org,m:richardbgobert@gmail.com,m:gal@nvidia.com,m:dtatulea@nvidia.com,m:alice@isovalent.com,m:sd@queasysnail.net,m:nbd@nbd.name,m:jibin.zhang@mediatek.com,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:johnfastabend@gmail.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:from_mime,suse.de:email,suse.de:mid,suse.de:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BB2E07436AA

To enable compiling the INET subsystem without IPv4, UDP socket IPv4
specific functions must be isolated from the generic UDP socket
infrastructure, similar to how it is done for TCP.

This patch creates udp_ipv4.c and move all the functions for packet
matching, input/output processing, multicast and the AF_INET udp_prot
from udp.c to the new file. The Makefile is updated to compile
udp_ipv4.c only when CONFIG_IPV4 is enabled.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/core/filter.c      |    4 +
 net/ipv4/Makefile      |    2 +-
 net/ipv4/af_inet.c     |   10 +
 net/ipv4/udp.c         | 1733 ---------------------------------------
 net/ipv4/udp_bpf.c     |    6 +
 net/ipv4/udp_diag.c    |   12 +
 net/ipv4/udp_ipv4.c    | 1773 ++++++++++++++++++++++++++++++++++++++++
 net/ipv4/udp_offload.c |   10 +
 net/ipv6/udp.c         |   18 +
 9 files changed, 1834 insertions(+), 1734 deletions(-)
 create mode 100644 net/ipv4/udp_ipv4.c

diff --git a/net/core/filter.c b/net/core/filter.c
index 55c2466c32ae..1ceaae6c7f95 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7003,9 +7003,13 @@ static struct sock *sk_lookup(struct net *net, struct bpf_sock_tuple *tuple,
 					   dst4, tuple->ipv4.dport,
 					   dif, sdif, &refcounted);
 		else
+#if IS_ENABLED(CONFIG_IPV4)
 			sk = __udp4_lib_lookup(net, src4, tuple->ipv4.sport,
 					       dst4, tuple->ipv4.dport,
 					       dif, sdif, NULL);
+#else
+			sk = NULL;
+#endif
 #if IS_ENABLED(CONFIG_IPV6)
 	} else {
 		struct in6_addr *src6 = (struct in6_addr *)&tuple->ipv6.saddr;
diff --git a/net/ipv4/Makefile b/net/ipv4/Makefile
index 7ac882ec5d4f..48ef3fb3b164 100644
--- a/net/ipv4/Makefile
+++ b/net/ipv4/Makefile
@@ -13,7 +13,7 @@ obj-y     := inetpeer.o protocol.o inet_hashtables.o inet_timewait_sock.o \
 obj-$(CONFIG_IPV4) += route.o ip_input.o ip_fragment.o ip_forward.o ip_options.o \
 		      ip_sockglue.o tcp_ipv4.o datagram.o icmp.o arp.o devinet.o \
 		      igmp.o fib_notifier.o ip_output.o fib_frontend.o \
-		      fib_semantics.o fib_trie.o raw_ipv4.o
+		      fib_semantics.o fib_trie.o raw_ipv4.o udp_ipv4.o
 
 obj-$(CONFIG_NET_IP_TUNNEL) += ip_tunnel.o
 obj-$(CONFIG_SYSCTL) += sysctl_net_ipv4.o
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 863d00973eb5..6978ac0e709c 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -890,8 +890,13 @@ int inet_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		return -EAGAIN;
 
 	prot = READ_ONCE(sk->sk_prot);
+#if IS_ENABLED(CONFIG_IPV4)
 	return INDIRECT_CALL_2(prot->sendmsg, tcp_sendmsg, udp_sendmsg,
 			       sk, msg, size);
+#else
+	return INDIRECT_CALL_1(prot->sendmsg, tcp_sendmsg,
+			       sk, msg, size);
+#endif
 }
 EXPORT_SYMBOL(inet_sendmsg);
 
@@ -919,8 +924,13 @@ int inet_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 		sock_rps_record_flow(sk);
 
 	prot = READ_ONCE(sk->sk_prot);
+#if IS_ENABLED(CONFIG_IPV4)
 	return INDIRECT_CALL_2(prot->recvmsg, tcp_recvmsg, udp_recvmsg,
 			       sk, msg, size, flags);
+#else
+	return INDIRECT_CALL_1(prot->recvmsg, tcp_recvmsg,
+			       sk, msg, size, flags);
+#endif
 }
 EXPORT_SYMBOL(inet_recvmsg);
 
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 59248a59358c..b8638664fcc4 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -347,62 +347,6 @@ int udp_lib_get_port(struct sock *sk, unsigned short snum,
 	return error;
 }
 
-static int udp_v4_get_port(struct sock *sk, unsigned short snum)
-{
-	unsigned int hash2_nulladdr =
-		ipv4_portaddr_hash(sock_net(sk), htonl(INADDR_ANY), snum);
-	unsigned int hash2_partial =
-		ipv4_portaddr_hash(sock_net(sk), inet_sk(sk)->inet_rcv_saddr, 0);
-
-	/* precompute partial secondary hash */
-	udp_sk(sk)->udp_portaddr_hash = hash2_partial;
-	return udp_lib_get_port(sk, snum, hash2_nulladdr);
-}
-
-static __always_inline int
-compute_score(struct sock *sk, const struct net *net,
-	      __be32 saddr, __be16 sport, __be32 daddr,
-	      unsigned short hnum, int dif, int sdif)
-{
-	int score;
-	struct inet_sock *inet;
-	bool dev_match;
-
-	if (!net_eq(sock_net(sk), net) ||
-	    udp_sk(sk)->udp_port_hash != hnum ||
-	    ipv6_only_sock(sk))
-		return -1;
-
-	if (sk->sk_rcv_saddr != daddr)
-		return -1;
-
-	score = (sk->sk_family == PF_INET) ? 2 : 1;
-
-	inet = inet_sk(sk);
-	if (inet->inet_daddr) {
-		if (inet->inet_daddr != saddr)
-			return -1;
-		score += 4;
-	}
-
-	if (inet->inet_dport) {
-		if (inet->inet_dport != sport)
-			return -1;
-		score += 4;
-	}
-
-	dev_match = udp_sk_bound_dev_eq(net, sk->sk_bound_dev_if,
-					dif, sdif);
-	if (!dev_match)
-		return -1;
-	if (sk->sk_bound_dev_if)
-		score += 4;
-
-	if (READ_ONCE(sk->sk_incoming_cpu) == raw_smp_processor_id())
-		score++;
-	return score;
-}
-
 u32 udp_ehashfn(const struct net *net, const __be32 laddr, const __u16 lport,
 		const __be32 faddr, const __be16 fport)
 {
@@ -412,117 +356,7 @@ u32 udp_ehashfn(const struct net *net, const __be32 laddr, const __u16 lport,
 			      udp_ehash_secret + net_hash_mix(net));
 }
 
-/**
- * udp4_lib_lookup1() - Simplified lookup using primary hash (destination port)
- * @net:	Network namespace
- * @saddr:	Source address, network order
- * @sport:	Source port, network order
- * @daddr:	Destination address, network order
- * @hnum:	Destination port, host order
- * @dif:	Destination interface index
- * @sdif:	Destination bridge port index, if relevant
- * @udptable:	Set of UDP hash tables
- *
- * Simplified lookup to be used as fallback if no sockets are found due to a
- * potential race between (receive) address change, and lookup happening before
- * the rehash operation. This function ignores SO_REUSEPORT groups while scoring
- * result sockets, because if we have one, we don't need the fallback at all.
- *
- * Called under rcu_read_lock().
- *
- * Return: socket with highest matching score if any, NULL if none
- */
-static struct sock *udp4_lib_lookup1(const struct net *net,
-				     __be32 saddr, __be16 sport,
-				     __be32 daddr, unsigned int hnum,
-				     int dif, int sdif,
-				     const struct udp_table *udptable)
-{
-	unsigned int slot = udp_hashfn(net, hnum, udptable->mask);
-	struct udp_hslot *hslot = &udptable->hash[slot];
-	struct sock *sk, *result = NULL;
-	int score, badness = 0;
-
-	sk_for_each_rcu(sk, &hslot->head) {
-		score = compute_score(sk, net,
-				      saddr, sport, daddr, hnum, dif, sdif);
-		if (score > badness) {
-			result = sk;
-			badness = score;
-		}
-	}
-
-	return result;
-}
-
-/* called with rcu_read_lock() */
-static struct sock *udp4_lib_lookup2(const struct net *net,
-				     __be32 saddr, __be16 sport,
-				     __be32 daddr, unsigned int hnum,
-				     int dif, int sdif,
-				     struct udp_hslot *hslot2,
-				     struct sk_buff *skb)
-{
-	struct sock *sk, *result;
-	int score, badness;
-	bool need_rescore;
-
-	result = NULL;
-	badness = 0;
-	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
-		need_rescore = false;
-rescore:
-		score = compute_score(need_rescore ? result : sk, net, saddr,
-				      sport, daddr, hnum, dif, sdif);
-		if (score > badness) {
-			badness = score;
-
-			if (need_rescore)
-				continue;
-
-			if (sk->sk_state == TCP_ESTABLISHED) {
-				result = sk;
-				continue;
-			}
-
-			result = inet_lookup_reuseport(net, sk, skb, sizeof(struct udphdr),
-						       saddr, sport, daddr, hnum, udp_ehashfn);
-			if (!result) {
-				result = sk;
-				continue;
-			}
-
-			/* Fall back to scoring if group has connections */
-			if (!reuseport_has_conns(sk))
-				return result;
-
-			/* Reuseport logic returned an error, keep original score. */
-			if (IS_ERR(result))
-				continue;
-
-			/* compute_score is too long of a function to be
-			 * inlined twice here, and calling it uninlined
-			 * here yields measurable overhead for some
-			 * workloads. Work around it by jumping
-			 * backwards to rescore 'result'.
-			 */
-			need_rescore = true;
-			goto rescore;
-		}
-	}
-	return result;
-}
-
 #if IS_ENABLED(CONFIG_BASE_SMALL)
-static struct sock *udp4_lib_lookup4(const struct net *net,
-				     __be32 saddr, __be16 sport,
-				     __be32 daddr, unsigned int hnum,
-				     int dif, int sdif,
-				     struct udp_table *udptable)
-{
-	return NULL;
-}
-
 static void udp_rehash4(struct udp_table *udptable, struct sock *sk,
 			u16 newhash4)
 {
@@ -532,42 +366,6 @@ static void udp_unhash4(struct udp_table *udptable, struct sock *sk)
 {
 }
 #else /* !CONFIG_BASE_SMALL */
-static struct sock *udp4_lib_lookup4(const struct net *net,
-				     __be32 saddr, __be16 sport,
-				     __be32 daddr, unsigned int hnum,
-				     int dif, int sdif,
-				     struct udp_table *udptable)
-{
-	const __portpair ports = INET_COMBINED_PORTS(sport, hnum);
-	const struct hlist_nulls_node *node;
-	struct udp_hslot *hslot4;
-	unsigned int hash4, slot;
-	struct udp_sock *up;
-	struct sock *sk;
-
-	hash4 = udp_ehashfn(net, daddr, hnum, saddr, sport);
-	slot = hash4 & udptable->mask;
-	hslot4 = &udptable->hash4[slot];
-	INET_ADDR_COOKIE(acookie, saddr, daddr);
-
-begin:
-	/* SLAB_TYPESAFE_BY_RCU not used, so we don't need to touch sk_refcnt */
-	udp_lrpa_for_each_entry_rcu(up, node, &hslot4->nulls_head) {
-		sk = (struct sock *)up;
-		if (inet_match(net, sk, acookie, ports, dif, sdif))
-			return sk;
-	}
-
-	/* if the nulls value we got at the end of this lookup is not the
-	 * expected one, we must restart lookup. We probably met an item that
-	 * was moved to another chain due to rehash.
-	 */
-	if (get_nulls_value(node) != slot)
-		goto begin;
-
-	return NULL;
-}
-
 /* udp_rehash4() only checks hslot4, and hash4_cnt is not processed. */
 static void udp_rehash4(struct udp_table *udptable, struct sock *sk,
 			u16 newhash4)
@@ -645,155 +443,8 @@ void udp_lib_hash4(struct sock *sk, u16 hash)
 
 	spin_unlock_bh(&hslot->lock);
 }
-
-/* call with sock lock */
-void udp4_hash4(struct sock *sk)
-{
-	struct net *net = sock_net(sk);
-	unsigned int hash;
-
-	if (sk_unhashed(sk) || sk->sk_rcv_saddr == htonl(INADDR_ANY))
-		return;
-
-	hash = udp_ehashfn(net, sk->sk_rcv_saddr, sk->sk_num,
-			   sk->sk_daddr, sk->sk_dport);
-
-	udp_lib_hash4(sk, hash);
-}
 #endif /* CONFIG_BASE_SMALL */
 
-/* UDP is nearly always wildcards out the wazoo, it makes no sense to try
- * harder than this. -DaveM
- */
-struct sock *__udp4_lib_lookup(const struct net *net, __be32 saddr,
-			       __be16 sport, __be32 daddr, __be16 dport,
-			       int dif, int sdif, struct sk_buff *skb)
-{
-	struct udp_table *udptable = net->ipv4.udp_table;
-	unsigned short hnum = ntohs(dport);
-	struct udp_hslot *hslot2;
-	struct sock *result, *sk;
-	unsigned int hash2;
-
-	hash2 = ipv4_portaddr_hash(net, daddr, hnum);
-	hslot2 = udp_hashslot2(udptable, hash2);
-
-	if (udp_has_hash4(hslot2)) {
-		result = udp4_lib_lookup4(net, saddr, sport, daddr, hnum,
-					  dif, sdif, udptable);
-		if (result) /* udp4_lib_lookup4 return sk or NULL */
-			return result;
-	}
-
-	/* Lookup connected or non-wildcard socket */
-	result = udp4_lib_lookup2(net, saddr, sport,
-				  daddr, hnum, dif, sdif,
-				  hslot2, skb);
-	if (!IS_ERR_OR_NULL(result) && result->sk_state == TCP_ESTABLISHED)
-		goto done;
-
-	/* Lookup redirect from BPF */
-	if (static_branch_unlikely(&bpf_sk_lookup_enabled)) {
-		sk = inet_lookup_run_sk_lookup(net, IPPROTO_UDP, skb, sizeof(struct udphdr),
-					       saddr, sport, daddr, hnum, dif,
-					       udp_ehashfn);
-		if (sk) {
-			result = sk;
-			goto done;
-		}
-	}
-
-	/* Got non-wildcard socket or error on first lookup */
-	if (result)
-		goto done;
-
-	/* Lookup wildcard sockets */
-	hash2 = ipv4_portaddr_hash(net, htonl(INADDR_ANY), hnum);
-	hslot2 = udp_hashslot2(udptable, hash2);
-
-	result = udp4_lib_lookup2(net, saddr, sport,
-				  htonl(INADDR_ANY), hnum, dif, sdif,
-				  hslot2, skb);
-	if (!IS_ERR_OR_NULL(result))
-		goto done;
-
-	/* Primary hash (destination port) lookup as fallback for this race:
-	 *   1. __ip4_datagram_connect() sets sk_rcv_saddr
-	 *   2. lookup (this function): new sk_rcv_saddr, hashes not updated yet
-	 *   3. rehash operation updating _secondary and four-tuple_ hashes
-	 * The primary hash doesn't need an update after 1., so, thanks to this
-	 * further step, 1. and 3. don't need to be atomic against the lookup.
-	 */
-	result = udp4_lib_lookup1(net, saddr, sport, daddr, hnum, dif, sdif,
-				  udptable);
-
-done:
-	if (IS_ERR(result))
-		return NULL;
-	return result;
-}
-EXPORT_SYMBOL_GPL(__udp4_lib_lookup);
-
-static inline struct sock *__udp4_lib_lookup_skb(struct sk_buff *skb,
-						 __be16 sport, __be16 dport)
-{
-	const struct iphdr *iph = ip_hdr(skb);
-
-	return __udp4_lib_lookup(dev_net(skb->dev), iph->saddr, sport,
-				 iph->daddr, dport, inet_iif(skb),
-				 inet_sdif(skb), skb);
-}
-
-struct sock *udp4_lib_lookup_skb(const struct sk_buff *skb,
-				 __be16 sport, __be16 dport)
-{
-	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
-	const struct iphdr *iph = (struct iphdr *)(skb->data + offset);
-	int iif, sdif;
-
-	inet_get_iif_sdif(skb, &iif, &sdif);
-
-	return __udp4_lib_lookup(dev_net(skb->dev), iph->saddr, sport,
-				 iph->daddr, dport, iif, sdif, NULL);
-}
-
-/* Must be called under rcu_read_lock().
- * Does increment socket refcount.
- */
-#if IS_ENABLED(CONFIG_NF_TPROXY_IPV4) || IS_ENABLED(CONFIG_NF_SOCKET_IPV4)
-struct sock *udp4_lib_lookup(const struct net *net, __be32 saddr, __be16 sport,
-			     __be32 daddr, __be16 dport, int dif)
-{
-	struct sock *sk;
-
-	sk = __udp4_lib_lookup(net, saddr, sport, daddr, dport, dif, 0, NULL);
-	if (sk && !refcount_inc_not_zero(&sk->sk_refcnt))
-		sk = NULL;
-	return sk;
-}
-EXPORT_SYMBOL_GPL(udp4_lib_lookup);
-#endif
-
-static inline bool __udp_is_mcast_sock(struct net *net, const struct sock *sk,
-				       __be16 loc_port, __be32 loc_addr,
-				       __be16 rmt_port, __be32 rmt_addr,
-				       int dif, int sdif, unsigned short hnum)
-{
-	const struct inet_sock *inet = inet_sk(sk);
-
-	if (!net_eq(sock_net(sk), net) ||
-	    udp_sk(sk)->udp_port_hash != hnum ||
-	    (inet->inet_daddr && inet->inet_daddr != rmt_addr) ||
-	    (inet->inet_dport != rmt_port && inet->inet_dport) ||
-	    (inet->inet_rcv_saddr && inet->inet_rcv_saddr != loc_addr) ||
-	    ipv6_only_sock(sk) ||
-	    !udp_sk_bound_dev_eq(net, sk->sk_bound_dev_if, dif, sdif))
-		return false;
-	if (!ip_mc_sf_allow(sk, loc_addr, rmt_addr, dif, sdif))
-		return false;
-	return true;
-}
-
 DEFINE_STATIC_KEY_FALSE(udp_encap_needed_key);
 
 #if IS_ENABLED(CONFIG_IPV6)
@@ -812,198 +463,6 @@ void udp_encap_disable(void)
 }
 EXPORT_SYMBOL(udp_encap_disable);
 
-/* Handler for tunnels with arbitrary destination ports: no socket lookup, go
- * through error handlers in encapsulations looking for a match.
- */
-static int __udp4_lib_err_encap_no_sk(struct sk_buff *skb, u32 info)
-{
-	int i;
-
-	for (i = 0; i < MAX_IPTUN_ENCAP_OPS; i++) {
-		int (*handler)(struct sk_buff *skb, u32 info);
-		const struct ip_tunnel_encap_ops *encap;
-
-		encap = rcu_dereference(iptun_encaps[i]);
-		if (!encap)
-			continue;
-		handler = encap->err_handler;
-		if (handler && !handler(skb, info))
-			return 0;
-	}
-
-	return -ENOENT;
-}
-
-/* Try to match ICMP errors to UDP tunnels by looking up a socket without
- * reversing source and destination port: this will match tunnels that force the
- * same destination port on both endpoints (e.g. VXLAN, GENEVE). Note that
- * lwtunnels might actually break this assumption by being configured with
- * different destination ports on endpoints, in this case we won't be able to
- * trace ICMP messages back to them.
- *
- * If this doesn't match any socket, probe tunnels with arbitrary destination
- * ports (e.g. FoU, GUE): there, the receiving socket is useless, as the port
- * we've sent packets to won't necessarily match the local destination port.
- *
- * Then ask the tunnel implementation to match the error against a valid
- * association.
- *
- * Return an error if we can't find a match, the socket if we need further
- * processing, zero otherwise.
- */
-static struct sock *__udp4_lib_err_encap(struct net *net,
-					 const struct iphdr *iph,
-					 struct udphdr *uh,
-					 struct sock *sk,
-					 struct sk_buff *skb, u32 info)
-{
-	int (*lookup)(struct sock *sk, struct sk_buff *skb);
-	int network_offset, transport_offset;
-	struct udp_sock *up;
-
-	network_offset = skb_network_offset(skb);
-	transport_offset = skb_transport_offset(skb);
-
-	/* Network header needs to point to the outer IPv4 header inside ICMP */
-	skb_reset_network_header(skb);
-
-	/* Transport header needs to point to the UDP header */
-	skb_set_transport_header(skb, iph->ihl << 2);
-
-	if (sk) {
-		up = udp_sk(sk);
-
-		lookup = READ_ONCE(up->encap_err_lookup);
-		if (lookup && lookup(sk, skb))
-			sk = NULL;
-
-		goto out;
-	}
-
-	sk = __udp4_lib_lookup(net, iph->daddr, uh->source,
-			       iph->saddr, uh->dest, skb->dev->ifindex, 0, NULL);
-	if (sk) {
-		up = udp_sk(sk);
-
-		lookup = READ_ONCE(up->encap_err_lookup);
-		if (!lookup || lookup(sk, skb))
-			sk = NULL;
-	}
-
-out:
-	if (!sk)
-		sk = ERR_PTR(__udp4_lib_err_encap_no_sk(skb, info));
-
-	skb_set_transport_header(skb, transport_offset);
-	skb_set_network_header(skb, network_offset);
-
-	return sk;
-}
-
-/*
- * This routine is called by the ICMP module when it gets some
- * sort of error condition.  If err < 0 then the socket should
- * be closed and the error returned to the user.  If err > 0
- * it's just the icmp type << 8 | icmp code.
- * Header points to the ip header of the error packet. We move
- * on past this. Then (as it used to claim before adjustment)
- * header points to the first 8 bytes of the udp header.  We need
- * to find the appropriate port.
- */
-int udp_err(struct sk_buff *skb, u32 info)
-{
-	const struct iphdr *iph = (const struct iphdr *)skb->data;
-	const int type = icmp_hdr(skb)->type;
-	const int code = icmp_hdr(skb)->code;
-	struct net *net = dev_net(skb->dev);
-	struct inet_sock *inet;
-	bool tunnel = false;
-	struct udphdr *uh;
-	struct sock *sk;
-	int harderr;
-	int err;
-
-	uh = (struct udphdr *)(skb->data + (iph->ihl << 2));
-	sk = __udp4_lib_lookup(net, iph->daddr, uh->dest,
-			       iph->saddr, uh->source, skb->dev->ifindex,
-			       inet_sdif(skb), NULL);
-
-	if (!sk || READ_ONCE(udp_sk(sk)->encap_type)) {
-		/* No socket for error: try tunnels before discarding */
-		if (static_branch_unlikely(&udp_encap_needed_key)) {
-			sk = __udp4_lib_err_encap(net, iph, uh, sk, skb, info);
-			if (!sk)
-				return 0;
-		} else
-			sk = ERR_PTR(-ENOENT);
-
-		if (IS_ERR(sk)) {
-			__ICMP_INC_STATS(net, ICMP_MIB_INERRORS);
-			return PTR_ERR(sk);
-		}
-
-		tunnel = true;
-	}
-
-	err = 0;
-	harderr = 0;
-	inet = inet_sk(sk);
-
-	switch (type) {
-	default:
-	case ICMP_TIME_EXCEEDED:
-		err = EHOSTUNREACH;
-		break;
-	case ICMP_SOURCE_QUENCH:
-		goto out;
-	case ICMP_PARAMETERPROB:
-		err = EPROTO;
-		harderr = 1;
-		break;
-	case ICMP_DEST_UNREACH:
-		if (code == ICMP_FRAG_NEEDED) { /* Path MTU discovery */
-			ipv4_sk_update_pmtu(skb, sk, info);
-			if (READ_ONCE(inet->pmtudisc) != IP_PMTUDISC_DONT) {
-				err = EMSGSIZE;
-				harderr = 1;
-				break;
-			}
-			goto out;
-		}
-		err = EHOSTUNREACH;
-		if (code <= NR_ICMP_UNREACH) {
-			harderr = icmp_err_convert[code].fatal;
-			err = icmp_err_convert[code].errno;
-		}
-		break;
-	case ICMP_REDIRECT:
-		ipv4_sk_redirect(skb, sk);
-		goto out;
-	}
-
-	/*
-	 *      RFC1122: OK.  Passes ICMP errors back to application, as per
-	 *	4.1.3.3.
-	 */
-	if (tunnel) {
-		/* ...not for tunnels though: we don't have a sending socket */
-		if (udp_sk(sk)->encap_err_rcv)
-			udp_sk(sk)->encap_err_rcv(sk, skb, err, uh->dest, info,
-						  (u8 *)(uh+1));
-		goto out;
-	}
-	if (!inet_test_bit(RECVERR, sk)) {
-		if (!harderr || sk->sk_state != TCP_ESTABLISHED)
-			goto out;
-	} else
-		ip_icmp_error(sk, skb, err, uh->dest, info, (u8 *)(uh+1));
-
-	sk->sk_err = err;
-	sk_error_report(sk);
-out:
-	return 0;
-}
-
 /*
  * Throw away all pending data and cancel the corking. Socket is locked.
  */
@@ -1018,52 +477,6 @@ void udp_flush_pending_frames(struct sock *sk)
 	}
 }
 
-/**
- * 	udp4_hwcsum  -  handle outgoing HW checksumming
- * 	@skb: 	sk_buff containing the filled-in UDP header
- * 	        (checksum field must be zeroed out)
- *	@src:	source IP address
- *	@dst:	destination IP address
- */
-void udp4_hwcsum(struct sk_buff *skb, __be32 src, __be32 dst)
-{
-	struct udphdr *uh = udp_hdr(skb);
-	int offset = skb_transport_offset(skb);
-	int len = skb->len - offset;
-	int hlen = len;
-	__wsum csum = 0;
-
-	if (!skb_has_frag_list(skb)) {
-		/*
-		 * Only one fragment on the socket.
-		 */
-		skb->csum_start = skb_transport_header(skb) - skb->head;
-		skb->csum_offset = offsetof(struct udphdr, check);
-		uh->check = ~csum_tcpudp_magic(src, dst, len,
-					       IPPROTO_UDP, 0);
-	} else {
-		struct sk_buff *frags;
-
-		/*
-		 * HW-checksum won't work as there are two or more
-		 * fragments on the socket so that all csums of sk_buffs
-		 * should be together
-		 */
-		skb_walk_frags(skb, frags) {
-			csum = csum_add(csum, frags->csum);
-			hlen -= frags->len;
-		}
-
-		csum = skb_checksum(skb, offset, hlen, csum);
-		skb->ip_summed = CHECKSUM_NONE;
-
-		uh->check = csum_tcpudp_magic(src, dst, len, IPPROTO_UDP, csum);
-		if (uh->check == 0)
-			uh->check = CSUM_MANGLED_0;
-	}
-}
-EXPORT_SYMBOL_GPL(udp4_hwcsum);
-
 /* Function to set UDP checksum for an IPv4 UDP packet. This is intended
  * for the simple case like when setting the checksum for a UDP tunnel.
  */
@@ -1090,111 +503,6 @@ void udp_set_csum(bool nocheck, struct sk_buff *skb,
 }
 EXPORT_SYMBOL(udp_set_csum);
 
-static int udp_send_skb(struct sk_buff *skb, struct flowi4 *fl4,
-			struct inet_cork *cork)
-{
-	struct sock *sk = skb->sk;
-	int offset, len, datalen;
-	struct udphdr *uh;
-	int err;
-
-	offset = skb_transport_offset(skb);
-	len = skb->len - offset;
-	datalen = len - sizeof(*uh);
-
-	/*
-	 * Create a UDP header
-	 */
-	uh = udp_hdr(skb);
-	uh->source = inet_sk(sk)->inet_sport;
-	uh->dest = fl4->fl4_dport;
-	uh->len = htons(len);
-	uh->check = 0;
-
-	if (cork->gso_size) {
-		const int hlen = skb_network_header_len(skb) +
-				 sizeof(struct udphdr);
-
-		if (hlen + min(datalen, cork->gso_size) > cork->fragsize) {
-			kfree_skb(skb);
-			return -EMSGSIZE;
-		}
-		if (datalen > cork->gso_size * UDP_MAX_SEGMENTS) {
-			kfree_skb(skb);
-			return -EINVAL;
-		}
-		if (sk->sk_no_check_tx) {
-			kfree_skb(skb);
-			return -EINVAL;
-		}
-		if (dst_xfrm(skb_dst(skb))) {
-			kfree_skb(skb);
-			return -EIO;
-		}
-
-		if (datalen > cork->gso_size) {
-			skb_shinfo(skb)->gso_size = cork->gso_size;
-			skb_shinfo(skb)->gso_type = SKB_GSO_UDP_L4;
-			skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(datalen,
-								 cork->gso_size);
-
-			/* Don't checksum the payload, skb will get segmented */
-			goto csum_partial;
-		}
-	}
-
-	if (sk->sk_no_check_tx) {			 /* UDP csum off */
-		skb->ip_summed = CHECKSUM_NONE;
-		goto send;
-	} else if (skb->ip_summed == CHECKSUM_PARTIAL) { /* UDP hardware csum */
-csum_partial:
-		udp4_hwcsum(skb, fl4->saddr, fl4->daddr);
-		goto send;
-	}
-
-	/* add protocol-dependent pseudo-header */
-	uh->check = csum_tcpudp_magic(fl4->saddr, fl4->daddr, len,
-				      IPPROTO_UDP, udp_csum(skb));
-	if (uh->check == 0)
-		uh->check = CSUM_MANGLED_0;
-
-send:
-	err = ip_send_skb(sock_net(sk), skb);
-	if (unlikely(err)) {
-		if (err == -ENOBUFS &&
-		    !inet_test_bit(RECVERR, sk)) {
-			UDP_INC_STATS(sock_net(sk), UDP_MIB_SNDBUFERRORS);
-			err = 0;
-		}
-	} else {
-		UDP_INC_STATS(sock_net(sk), UDP_MIB_OUTDATAGRAMS);
-	}
-	return err;
-}
-
-/*
- * Push out all pending data as one UDP datagram. Socket is locked.
- */
-int udp_push_pending_frames(struct sock *sk)
-{
-	struct udp_sock  *up = udp_sk(sk);
-	struct inet_sock *inet = inet_sk(sk);
-	struct flowi4 *fl4 = &inet->cork.fl.u.ip4;
-	struct sk_buff *skb;
-	int err = 0;
-
-	skb = ip_finish_skb(sk, fl4);
-	if (!skb)
-		goto out;
-
-	err = udp_send_skb(skb, fl4, &inet->cork.base);
-
-out:
-	up->len = 0;
-	WRITE_ONCE(up->pending, 0);
-	return err;
-}
-
 static int __udp_cmsg_send(struct cmsghdr *cmsg, u16 *gso_size)
 {
 	switch (cmsg->cmsg_type) {
@@ -1231,296 +539,6 @@ int udp_cmsg_send(struct sock *sk, struct msghdr *msg, u16 *gso_size)
 	return need_ip;
 }
 
-int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
-{
-	int corkreq = udp_test_bit(CORK, sk) || msg->msg_flags & MSG_MORE;
-	DEFINE_RAW_FLEX(struct ip_options_rcu, opt_copy, opt.__data,
-			IP_OPTIONS_DATA_FIXED_SIZE);
-	DECLARE_SOCKADDR(struct sockaddr_in *, usin, msg->msg_name);
-	int ulen = len, free = 0, connected = 0;
-	struct inet_sock *inet = inet_sk(sk);
-	struct udp_sock *up = udp_sk(sk);
-	__be32 daddr, faddr, saddr;
-	struct rtable *rt = NULL;
-	struct flowi4 fl4_stack;
-	struct ipcm_cookie ipc;
-	struct sk_buff *skb;
-	struct flowi4 *fl4;
-	__be16 dport;
-	int uc_index;
-	u8 scope;
-	int err;
-
-	if (len > 0xFFFF)
-		return -EMSGSIZE;
-
-	/*
-	 *	Check the flags.
-	 */
-
-	if (msg->msg_flags & MSG_OOB) /* Mirror BSD error message compatibility */
-		return -EOPNOTSUPP;
-
-	fl4 = &inet->cork.fl.u.ip4;
-	if (READ_ONCE(up->pending)) {
-		/*
-		 * There are pending frames.
-		 * The socket lock must be held while it's corked.
-		 */
-		lock_sock(sk);
-		if (likely(up->pending)) {
-			if (unlikely(up->pending != AF_INET)) {
-				release_sock(sk);
-				return -EINVAL;
-			}
-			goto do_append_data;
-		}
-		release_sock(sk);
-	}
-	ulen += sizeof(struct udphdr);
-
-	/*
-	 *	Get and verify the address.
-	 */
-	if (usin) {
-		if (msg->msg_namelen < sizeof(*usin))
-			return -EINVAL;
-		if (usin->sin_family != AF_INET) {
-			if (usin->sin_family != AF_UNSPEC)
-				return -EAFNOSUPPORT;
-		}
-
-		daddr = usin->sin_addr.s_addr;
-		dport = usin->sin_port;
-		if (dport == 0)
-			return -EINVAL;
-	} else {
-		if (sk->sk_state != TCP_ESTABLISHED)
-			return -EDESTADDRREQ;
-		daddr = inet->inet_daddr;
-		dport = inet->inet_dport;
-		/* Open fast path for connected socket.
-		   Route will not be used, if at least one option is set.
-		 */
-		connected = 1;
-	}
-
-	ipcm_init_sk(&ipc, inet);
-	ipc.gso_size = READ_ONCE(up->gso_size);
-
-	if (msg->msg_controllen) {
-		err = udp_cmsg_send(sk, msg, &ipc.gso_size);
-		if (err > 0) {
-			err = ip_cmsg_send(sk, msg, &ipc,
-					   sk->sk_family == AF_INET6);
-			connected = 0;
-		}
-		if (unlikely(err < 0)) {
-			kfree(ipc.opt);
-			return err;
-		}
-		if (ipc.opt)
-			free = 1;
-	}
-	if (!ipc.opt) {
-		struct ip_options_rcu *inet_opt;
-
-		rcu_read_lock();
-		inet_opt = rcu_dereference(inet->inet_opt);
-		if (inet_opt) {
-			memcpy(opt_copy, inet_opt,
-			       sizeof(*inet_opt) + inet_opt->opt.optlen);
-			ipc.opt = opt_copy;
-		}
-		rcu_read_unlock();
-	}
-
-	if (cgroup_bpf_enabled(CGROUP_UDP4_SENDMSG) && !connected) {
-		err = BPF_CGROUP_RUN_PROG_UDP4_SENDMSG_LOCK(sk,
-					    (struct sockaddr *)usin,
-					    &msg->msg_namelen,
-					    &ipc.addr);
-		if (err)
-			goto out_free;
-		if (usin) {
-			if (usin->sin_port == 0) {
-				/* BPF program set invalid port. Reject it. */
-				err = -EINVAL;
-				goto out_free;
-			}
-			daddr = usin->sin_addr.s_addr;
-			dport = usin->sin_port;
-		}
-	}
-
-	saddr = ipc.addr;
-	ipc.addr = faddr = daddr;
-
-	if (ipc.opt && ipc.opt->opt.srr) {
-		if (!daddr) {
-			err = -EINVAL;
-			goto out_free;
-		}
-		faddr = ipc.opt->opt.faddr;
-		connected = 0;
-	}
-	scope = ip_sendmsg_scope(inet, &ipc, msg);
-	if (scope == RT_SCOPE_LINK)
-		connected = 0;
-
-	uc_index = READ_ONCE(inet->uc_index);
-	if (ipv4_is_multicast(daddr)) {
-		if (!ipc.oif || netif_index_is_l3_master(sock_net(sk), ipc.oif))
-			ipc.oif = READ_ONCE(inet->mc_index);
-		if (!saddr)
-			saddr = READ_ONCE(inet->mc_addr);
-		connected = 0;
-	} else if (!ipc.oif) {
-		ipc.oif = uc_index;
-	} else if (ipv4_is_lbcast(daddr) && uc_index) {
-		/* oif is set, packet is to local broadcast and
-		 * uc_index is set. oif is most likely set
-		 * by sk_bound_dev_if. If uc_index != oif check if the
-		 * oif is an L3 master and uc_index is an L3 slave.
-		 * If so, we want to allow the send using the uc_index.
-		 */
-		if (ipc.oif != uc_index &&
-		    ipc.oif == l3mdev_master_ifindex_by_index(sock_net(sk),
-							      uc_index)) {
-			ipc.oif = uc_index;
-		}
-	}
-
-	if (connected)
-		rt = dst_rtable(sk_dst_check(sk, 0));
-
-	if (!rt) {
-		struct net *net = sock_net(sk);
-		__u8 flow_flags = inet_sk_flowi_flags(sk);
-
-		fl4 = &fl4_stack;
-
-		flowi4_init_output(fl4, ipc.oif, ipc.sockc.mark,
-				   ipc.tos & INET_DSCP_MASK, scope,
-				   IPPROTO_UDP, flow_flags, faddr, saddr,
-				   dport, inet->inet_sport,
-				   sk_uid(sk));
-
-		security_sk_classify_flow(sk, flowi4_to_flowi_common(fl4));
-		rt = ip_route_output_flow(net, fl4, sk);
-		if (IS_ERR(rt)) {
-			err = PTR_ERR(rt);
-			rt = NULL;
-			if (err == -ENETUNREACH)
-				IP_INC_STATS(net, IPSTATS_MIB_OUTNOROUTES);
-			goto out;
-		}
-
-		err = -EACCES;
-		if ((rt->rt_flags & RTCF_BROADCAST) &&
-		    !sock_flag(sk, SOCK_BROADCAST))
-			goto out;
-		if (connected)
-			sk_dst_set(sk, dst_clone(&rt->dst));
-	}
-
-	if (msg->msg_flags&MSG_CONFIRM)
-		goto do_confirm;
-back_from_confirm:
-
-	saddr = fl4->saddr;
-	if (!ipc.addr)
-		daddr = ipc.addr = fl4->daddr;
-
-	/* Lockless fast path for the non-corking case. */
-	if (!corkreq) {
-		struct inet_cork cork;
-
-		skb = ip_make_skb(sk, fl4, ip_generic_getfrag, msg, ulen,
-				  sizeof(struct udphdr), &ipc, &rt,
-				  &cork, msg->msg_flags);
-		err = PTR_ERR(skb);
-		if (!IS_ERR_OR_NULL(skb))
-			err = udp_send_skb(skb, fl4, &cork);
-		goto out;
-	}
-
-	lock_sock(sk);
-	if (unlikely(up->pending)) {
-		/* The socket is already corked while preparing it. */
-		/* ... which is an evident application bug. --ANK */
-		release_sock(sk);
-
-		net_dbg_ratelimited("socket already corked\n");
-		err = -EINVAL;
-		goto out;
-	}
-	/*
-	 *	Now cork the socket to pend data.
-	 */
-	fl4 = &inet->cork.fl.u.ip4;
-	fl4->daddr = daddr;
-	fl4->saddr = saddr;
-	fl4->fl4_dport = dport;
-	fl4->fl4_sport = inet->inet_sport;
-	WRITE_ONCE(up->pending, AF_INET);
-
-do_append_data:
-	up->len += ulen;
-	err = ip_append_data(sk, fl4, ip_generic_getfrag, msg, ulen,
-			     sizeof(struct udphdr), &ipc, &rt,
-			     corkreq ? msg->msg_flags|MSG_MORE : msg->msg_flags);
-	if (err)
-		udp_flush_pending_frames(sk);
-	else if (!corkreq)
-		err = udp_push_pending_frames(sk);
-	else if (unlikely(skb_queue_empty(&sk->sk_write_queue)))
-		WRITE_ONCE(up->pending, 0);
-	release_sock(sk);
-
-out:
-	ip_rt_put(rt);
-out_free:
-	if (free)
-		kfree(ipc.opt);
-	if (!err)
-		return len;
-	/*
-	 * ENOBUFS = no kernel mem, SOCK_NOSPACE = no sndbuf space.  Reporting
-	 * ENOBUFS might not be good (it's not tunable per se), but otherwise
-	 * we don't have a good statistic (IpOutDiscards but it can be too many
-	 * things).  We could add another new stat but at least for now that
-	 * seems like overkill.
-	 */
-	if (err == -ENOBUFS || test_bit(SOCK_NOSPACE, &sk->sk_socket->flags))
-		UDP_INC_STATS(sock_net(sk), UDP_MIB_SNDBUFERRORS);
-
-	return err;
-
-do_confirm:
-	if (msg->msg_flags & MSG_PROBE)
-		dst_confirm_neigh(&rt->dst, &fl4->daddr);
-	if (!(msg->msg_flags&MSG_PROBE) || len)
-		goto back_from_confirm;
-	err = 0;
-	goto out;
-}
-EXPORT_SYMBOL(udp_sendmsg);
-
-void udp_splice_eof(struct socket *sock)
-{
-	struct sock *sk = sock->sk;
-	struct udp_sock *up = udp_sk(sk);
-
-	if (!READ_ONCE(up->pending) || udp_test_bit(CORK, sk))
-		return;
-
-	lock_sock(sk);
-	if (up->pending && !udp_test_bit(CORK, sk))
-		udp_push_pending_frames(sk);
-	release_sock(sk);
-}
-
 #define UDP_SKB_IS_STATELESS 0x80000000
 
 /* all head states (dst, sk, nf conntrack) except skb extensions are
@@ -1803,21 +821,6 @@ void udp_destruct_common(struct sock *sk)
 	kfree(up->udp_prod_queue);
 }
 
-static void udp_destruct_sock(struct sock *sk)
-{
-	udp_destruct_common(sk);
-	inet_sock_destruct(sk);
-}
-
-static int udp_init_sock(struct sock *sk)
-{
-	int res = udp_lib_init_sock(sk);
-
-	sk->sk_destruct = udp_destruct_sock;
-	set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
-	return res;
-}
-
 void skb_consume_udp(struct sock *sk, struct sk_buff *skb, int len)
 {
 	if (unlikely(READ_ONCE(udp_sk(sk)->peeking_with_offset)))
@@ -2023,114 +1026,6 @@ int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 	return recv_actor(sk, skb);
 }
 
-/*
- * 	This should be easy, if there is something there we
- * 	return it, otherwise we block.
- */
-
-INDIRECT_CALLABLE_SCOPE
-int udp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags)
-{
-	DECLARE_SOCKADDR(struct sockaddr_in *, sin, msg->msg_name);
-	int off, err, peeking = flags & MSG_PEEK;
-	struct inet_sock *inet = inet_sk(sk);
-	struct net *net = sock_net(sk);
-	bool checksum_valid = false;
-	unsigned int ulen, copied;
-	struct sk_buff *skb;
-
-	if (flags & MSG_ERRQUEUE)
-		return ip_recv_error(sk, msg, len);
-
-try_again:
-	off = sk_peek_offset(sk, flags);
-	skb = __skb_recv_udp(sk, flags, &off, &err);
-	if (!skb)
-		return err;
-
-	ulen = udp_skb_len(skb);
-	copied = len;
-	if (copied > ulen - off)
-		copied = ulen - off;
-	else if (copied < ulen)
-		msg->msg_flags |= MSG_TRUNC;
-
-	/* If checksum is needed at all, try to do it while copying the
-	 * data.  If the data is truncated, do it before the copy.
-	 */
-	if (copied < ulen || peeking) {
-		checksum_valid = udp_skb_csum_unnecessary(skb) ||
-				!__udp_lib_checksum_complete(skb);
-		if (!checksum_valid)
-			goto csum_copy_err;
-	}
-
-	if (checksum_valid || udp_skb_csum_unnecessary(skb)) {
-		if (udp_skb_is_linear(skb))
-			err = copy_linear_skb(skb, copied, off, &msg->msg_iter);
-		else
-			err = skb_copy_datagram_msg(skb, off, msg, copied);
-	} else {
-		err = skb_copy_and_csum_datagram_msg(skb, off, msg);
-
-		if (err == -EINVAL)
-			goto csum_copy_err;
-	}
-
-	if (unlikely(err)) {
-		if (!peeking) {
-			udp_drops_inc(sk);
-			UDP_INC_STATS(net, UDP_MIB_INERRORS);
-		}
-		kfree_skb(skb);
-		return err;
-	}
-
-	if (!peeking)
-		UDP_INC_STATS(net, UDP_MIB_INDATAGRAMS);
-
-	sock_recv_cmsgs(msg, sk, skb);
-
-	/* Copy the address. */
-	if (sin) {
-		sin->sin_family = AF_INET;
-		sin->sin_port = udp_hdr(skb)->source;
-		sin->sin_addr.s_addr = ip_hdr(skb)->saddr;
-		memset(sin->sin_zero, 0, sizeof(sin->sin_zero));
-		msg->msg_namelen = sizeof(*sin);
-
-		BPF_CGROUP_RUN_PROG_UDP4_RECVMSG_LOCK(sk,
-						      (struct sockaddr *)sin,
-						      &msg->msg_namelen);
-	}
-
-	if (udp_test_bit(GRO_ENABLED, sk))
-		udp_cmsg_recv(msg, sk, skb);
-
-	if (inet_cmsg_flags(inet))
-		ip_cmsg_recv_offset(msg, sk, skb, sizeof(struct udphdr), off);
-
-	err = copied;
-	if (flags & MSG_TRUNC)
-		err = ulen;
-
-	skb_consume_udp(sk, skb, peeking ? -err : err);
-	return err;
-
-csum_copy_err:
-	if (!__sk_queue_drop_skb(sk, &udp_sk(sk)->reader_queue, skb, flags,
-				 udp_skb_destructor)) {
-		UDP_INC_STATS(net, UDP_MIB_CSUMERRORS);
-		UDP_INC_STATS(net, UDP_MIB_INERRORS);
-	}
-	kfree_skb_reason(skb, SKB_DROP_REASON_UDP_CSUM);
-
-	/* starting over for a new packet, but check if we need to yield */
-	cond_resched();
-	msg->msg_flags &= ~MSG_TRUNC;
-	goto try_again;
-}
-
 int udp_pre_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 		    int addr_len)
 {
@@ -2144,19 +1039,6 @@ int udp_pre_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	return BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr, &addr_len);
 }
 
-static int udp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
-		       int addr_len)
-{
-	int res;
-
-	lock_sock(sk);
-	res = __ip4_datagram_connect(sk, uaddr, addr_len);
-	if (!res)
-		udp4_hash4(sk);
-	release_sock(sk);
-	return res;
-}
-
 int __udp_disconnect(struct sock *sk, int flags)
 {
 	struct inet_sock *inet = inet_sk(sk);
@@ -2293,155 +1175,6 @@ void udp_lib_rehash(struct sock *sk, u16 newhash, u16 newhash4)
 	}
 }
 
-static void udp_v4_rehash(struct sock *sk)
-{
-	u16 new_hash = ipv4_portaddr_hash(sock_net(sk),
-					  inet_sk(sk)->inet_rcv_saddr,
-					  inet_sk(sk)->inet_num);
-	u16 new_hash4 = udp_ehashfn(sock_net(sk),
-				    sk->sk_rcv_saddr, sk->sk_num,
-				    sk->sk_daddr, sk->sk_dport);
-
-	udp_lib_rehash(sk, new_hash, new_hash4);
-}
-
-static int __udp_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
-{
-	int rc;
-
-	if (inet_sk(sk)->inet_daddr) {
-		sock_rps_save_rxhash(sk, skb);
-		sk_mark_napi_id(sk, skb);
-		sk_incoming_cpu_update(sk);
-	} else {
-		sk_mark_napi_id_once(sk, skb);
-	}
-
-	rc = __udp_enqueue_schedule_skb(sk, skb);
-	if (rc < 0) {
-		struct net *net = sock_net(sk);
-		int drop_reason;
-
-		/* Note that an ENOMEM error is charged twice */
-		if (rc == -ENOMEM) {
-			UDP_INC_STATS(net, UDP_MIB_RCVBUFERRORS);
-			drop_reason = SKB_DROP_REASON_SOCKET_RCVBUFF;
-		} else {
-			UDP_INC_STATS(net, UDP_MIB_MEMERRORS);
-			drop_reason = SKB_DROP_REASON_PROTO_MEM;
-		}
-		UDP_INC_STATS(net, UDP_MIB_INERRORS);
-		trace_udp_fail_queue_rcv_skb(rc, sk, skb);
-		sk_skb_reason_drop(sk, skb, drop_reason);
-		return -1;
-	}
-
-	return 0;
-}
-
-/* returns:
- *  -1: error
- *   0: success
- *  >0: "udp encap" protocol resubmission
- *
- * Note that in the success and error cases, the skb is assumed to
- * have either been requeued or freed.
- */
-static int udp_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
-{
-	enum skb_drop_reason drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
-	struct udp_sock *up = udp_sk(sk);
-	struct net *net = sock_net(sk);
-
-	/*
-	 *	Charge it to the socket, dropping if the queue is full.
-	 */
-	if (!xfrm4_policy_check(sk, XFRM_POLICY_IN, skb)) {
-		drop_reason = SKB_DROP_REASON_XFRM_POLICY;
-		goto drop;
-	}
-	nf_reset_ct(skb);
-
-	if (static_branch_unlikely(&udp_encap_needed_key) &&
-	    READ_ONCE(up->encap_type)) {
-		int (*encap_rcv)(struct sock *sk, struct sk_buff *skb);
-
-		/*
-		 * This is an encapsulation socket so pass the skb to
-		 * the socket's udp_encap_rcv() hook. Otherwise, just
-		 * fall through and pass this up the UDP socket.
-		 * up->encap_rcv() returns the following value:
-		 * =0 if skb was successfully passed to the encap
-		 *    handler or was discarded by it.
-		 * >0 if skb should be passed on to UDP.
-		 * <0 if skb should be resubmitted as proto -N
-		 */
-
-		/* if we're overly short, let UDP handle it */
-		encap_rcv = READ_ONCE(up->encap_rcv);
-		if (encap_rcv) {
-			int ret;
-
-			/* Verify checksum before giving to encap */
-			if (udp_lib_checksum_complete(skb))
-				goto csum_error;
-
-			ret = encap_rcv(sk, skb);
-			if (ret <= 0) {
-				__UDP_INC_STATS(net, UDP_MIB_INDATAGRAMS);
-				return -ret;
-			}
-		}
-
-		/* FALLTHROUGH -- it's a UDP Packet */
-	}
-
-	prefetch(&sk->sk_rmem_alloc);
-	if (rcu_access_pointer(sk->sk_filter) &&
-	    udp_lib_checksum_complete(skb))
-			goto csum_error;
-
-	drop_reason = sk_filter_trim_cap(sk, skb, sizeof(struct udphdr));
-	if (drop_reason)
-		goto drop;
-
-	udp_csum_pull_header(skb);
-
-	ipv4_pktinfo_prepare(sk, skb, true);
-	return __udp_queue_rcv_skb(sk, skb);
-
-csum_error:
-	drop_reason = SKB_DROP_REASON_UDP_CSUM;
-	__UDP_INC_STATS(net, UDP_MIB_CSUMERRORS);
-drop:
-	__UDP_INC_STATS(net, UDP_MIB_INERRORS);
-	udp_drops_inc(sk);
-	sk_skb_reason_drop(sk, skb, drop_reason);
-	return -1;
-}
-
-static int udp_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
-{
-	struct sk_buff *next, *segs;
-	int ret;
-
-	if (likely(!udp_unexpected_gso(sk, skb)))
-		return udp_queue_rcv_one_skb(sk, skb);
-
-	BUILD_BUG_ON(sizeof(struct udp_skb_cb) > SKB_GSO_CB_OFFSET);
-	__skb_push(skb, -skb_mac_offset(skb));
-	segs = udp_rcv_segment(sk, skb, true);
-	skb_list_walk_safe(segs, skb, next) {
-		__skb_pull(skb, skb_transport_offset(skb));
-
-		udp_post_segment_fix_csum(skb);
-		ret = udp_queue_rcv_one_skb(sk, skb);
-		if (ret > 0)
-			ip_protocol_deliver_rcu(dev_net(skb->dev), skb, ret);
-	}
-	return 0;
-}
-
 /* For TCP sockets, sk_rx_dst is protected by socket lock
  * For UDP, we use xchg() to guard against concurrent changes.
  */
@@ -2457,399 +1190,6 @@ bool udp_sk_rx_dst_set(struct sock *sk, struct dst_entry *dst)
 	return false;
 }
 
-/*
- *	Multicasts and broadcasts go to each listener.
- *
- *	Note: called only from the BH handler context.
- */
-static int __udp4_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
-				    struct udphdr  *uh,
-				    __be32 saddr, __be32 daddr)
-{
-	struct udp_table *udptable = net->ipv4.udp_table;
-	unsigned int hash2, hash2_any, offset;
-	unsigned short hnum = ntohs(uh->dest);
-	struct sock *sk, *first = NULL;
-	int dif = skb->dev->ifindex;
-	int sdif = inet_sdif(skb);
-	struct hlist_node *node;
-	struct udp_hslot *hslot;
-	struct sk_buff *nskb;
-	bool use_hash2;
-
-	hash2_any = 0;
-	hash2 = 0;
-	hslot = udp_hashslot(udptable, net, hnum);
-	use_hash2 = hslot->count > 10;
-	offset = offsetof(typeof(*sk), sk_node);
-
-	if (use_hash2) {
-		hash2_any = ipv4_portaddr_hash(net, htonl(INADDR_ANY), hnum) &
-			    udptable->mask;
-		hash2 = ipv4_portaddr_hash(net, daddr, hnum) & udptable->mask;
-start_lookup:
-		hslot = &udptable->hash2[hash2].hslot;
-		offset = offsetof(typeof(*sk), __sk_common.skc_portaddr_node);
-	}
-
-	sk_for_each_entry_offset_rcu(sk, node, &hslot->head, offset) {
-		if (!__udp_is_mcast_sock(net, sk, uh->dest, daddr,
-					 uh->source, saddr, dif, sdif, hnum))
-			continue;
-
-		if (!first) {
-			first = sk;
-			continue;
-		}
-		nskb = skb_clone(skb, GFP_ATOMIC);
-
-		if (unlikely(!nskb)) {
-			udp_drops_inc(sk);
-			__UDP_INC_STATS(net, UDP_MIB_RCVBUFERRORS);
-			__UDP_INC_STATS(net, UDP_MIB_INERRORS);
-			continue;
-		}
-		if (udp_queue_rcv_skb(sk, nskb) > 0)
-			consume_skb(nskb);
-	}
-
-	/* Also lookup *:port if we are using hash2 and haven't done so yet. */
-	if (use_hash2 && hash2 != hash2_any) {
-		hash2 = hash2_any;
-		goto start_lookup;
-	}
-
-	if (first) {
-		if (udp_queue_rcv_skb(first, skb) > 0)
-			consume_skb(skb);
-	} else {
-		kfree_skb(skb);
-		__UDP_INC_STATS(net, UDP_MIB_IGNOREDMULTI);
-	}
-	return 0;
-}
-
-/* Initialize UDP checksum. If exited with zero value (success),
- * CHECKSUM_UNNECESSARY means, that no more checks are required.
- * Otherwise, csum completion requires checksumming packet body,
- * including udp header and folding it to skb->csum.
- */
-static inline int udp4_csum_init(struct sk_buff *skb, struct udphdr *uh)
-{
-	int err;
-
-	/* Note, we are only interested in != 0 or == 0, thus the
-	 * force to int.
-	 */
-	err = (__force int)skb_checksum_init_zero_check(skb, IPPROTO_UDP, uh->check,
-							inet_compute_pseudo);
-	if (err)
-		return err;
-
-	if (skb->ip_summed == CHECKSUM_COMPLETE && !skb->csum_valid) {
-		/* If SW calculated the value, we know it's bad */
-		if (skb->csum_complete_sw)
-			return 1;
-
-		/* HW says the value is bad. Let's validate that.
-		 * skb->csum is no longer the full packet checksum,
-		 * so don't treat it as such.
-		 */
-		skb_checksum_complete_unset(skb);
-	}
-
-	return 0;
-}
-
-/* wrapper for udp_queue_rcv_skb taking care of csum conversion and
- * return code conversion for ip layer consumption
- */
-static int udp_unicast_rcv_skb(struct sock *sk, struct sk_buff *skb,
-			       struct udphdr *uh)
-{
-	int ret;
-
-	if (inet_get_convert_csum(sk) && uh->check)
-		skb_checksum_try_convert(skb, IPPROTO_UDP, inet_compute_pseudo);
-
-	ret = udp_queue_rcv_skb(sk, skb);
-
-	/* a return value > 0 means to resubmit the input, but
-	 * it wants the return to be -protocol, or 0
-	 */
-	if (ret > 0)
-		return -ret;
-	return 0;
-}
-
-/*
- *	All we need to do is get the socket, and then do a checksum.
- */
-
-int udp_rcv(struct sk_buff *skb)
-{
-	struct rtable *rt = skb_rtable(skb);
-	struct net *net = dev_net(skb->dev);
-	struct sock *sk = NULL;
-	unsigned short ulen;
-	__be32 saddr, daddr;
-	struct udphdr *uh;
-	bool refcounted;
-	int drop_reason;
-
-	drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
-
-	/*
-	 *  Validate the packet.
-	 */
-	if (!pskb_may_pull(skb, sizeof(struct udphdr)))
-		goto drop;		/* No space for header. */
-
-	uh   = udp_hdr(skb);
-	ulen = ntohs(uh->len);
-	saddr = ip_hdr(skb)->saddr;
-	daddr = ip_hdr(skb)->daddr;
-
-	if (ulen > skb->len)
-		goto short_packet;
-
-	if (ulen < sizeof(*uh))
-		goto short_packet;
-
-	if (ulen < skb->len) {
-		if (pskb_trim_rcsum(skb, ulen))
-			goto short_packet;
-
-		uh = udp_hdr(skb);
-	}
-
-	if (udp4_csum_init(skb, uh))
-		goto csum_error;
-
-	sk = inet_steal_sock(net, skb, sizeof(struct udphdr), saddr, uh->source, daddr, uh->dest,
-			     &refcounted, udp_ehashfn);
-	if (IS_ERR(sk))
-		goto no_sk;
-
-	if (sk) {
-		struct dst_entry *dst = skb_dst(skb);
-		int ret;
-
-		if (unlikely(rcu_dereference(sk->sk_rx_dst) != dst))
-			udp_sk_rx_dst_set(sk, dst);
-
-		ret = udp_unicast_rcv_skb(sk, skb, uh);
-		if (refcounted)
-			sock_put(sk);
-		return ret;
-	}
-
-	if (rt->rt_flags & (RTCF_BROADCAST|RTCF_MULTICAST))
-		return __udp4_lib_mcast_deliver(net, skb, uh, saddr, daddr);
-
-	sk = __udp4_lib_lookup_skb(skb, uh->source, uh->dest);
-	if (sk)
-		return udp_unicast_rcv_skb(sk, skb, uh);
-no_sk:
-	if (!xfrm4_policy_check(NULL, XFRM_POLICY_IN, skb))
-		goto drop;
-	nf_reset_ct(skb);
-
-	/* No socket. Drop packet silently, if checksum is wrong */
-	if (udp_lib_checksum_complete(skb))
-		goto csum_error;
-
-	drop_reason = SKB_DROP_REASON_NO_SOCKET;
-	__UDP_INC_STATS(net, UDP_MIB_NOPORTS);
-	icmp_send(skb, ICMP_DEST_UNREACH, ICMP_PORT_UNREACH, 0);
-
-	/*
-	 * Hmm.  We got an UDP packet to a port to which we
-	 * don't wanna listen.  Ignore it.
-	 */
-	sk_skb_reason_drop(sk, skb, drop_reason);
-	return 0;
-
-short_packet:
-	drop_reason = SKB_DROP_REASON_PKT_TOO_SMALL;
-	net_dbg_ratelimited("UDP: short packet: From %pI4:%u %d/%d to %pI4:%u\n",
-			    &saddr, ntohs(uh->source),
-			    ulen, skb->len,
-			    &daddr, ntohs(uh->dest));
-	goto drop;
-
-csum_error:
-	/*
-	 * RFC1122: OK.  Discards the bad packet silently (as far as
-	 * the network is concerned, anyway) as per 4.1.3.4 (MUST).
-	 */
-	drop_reason = SKB_DROP_REASON_UDP_CSUM;
-	net_dbg_ratelimited("UDP: bad checksum. From %pI4:%u to %pI4:%u ulen %d\n",
-			    &saddr, ntohs(uh->source), &daddr, ntohs(uh->dest),
-			    ulen);
-	__UDP_INC_STATS(net, UDP_MIB_CSUMERRORS);
-drop:
-	__UDP_INC_STATS(net, UDP_MIB_INERRORS);
-	sk_skb_reason_drop(sk, skb, drop_reason);
-	return 0;
-}
-
-/* We can only early demux multicast if there is a single matching socket.
- * If more than one socket found returns NULL
- */
-static struct sock *__udp4_lib_mcast_demux_lookup(struct net *net,
-						  __be16 loc_port, __be32 loc_addr,
-						  __be16 rmt_port, __be32 rmt_addr,
-						  int dif, int sdif)
-{
-	struct udp_table *udptable = net->ipv4.udp_table;
-	unsigned short hnum = ntohs(loc_port);
-	struct sock *sk, *result;
-	struct udp_hslot *hslot;
-	unsigned int slot;
-
-	slot = udp_hashfn(net, hnum, udptable->mask);
-	hslot = &udptable->hash[slot];
-
-	/* Do not bother scanning a too big list */
-	if (hslot->count > 10)
-		return NULL;
-
-	result = NULL;
-	sk_for_each_rcu(sk, &hslot->head) {
-		if (__udp_is_mcast_sock(net, sk, loc_port, loc_addr,
-					rmt_port, rmt_addr, dif, sdif, hnum)) {
-			if (result)
-				return NULL;
-			result = sk;
-		}
-	}
-
-	return result;
-}
-
-/* For unicast we should only early demux connected sockets or we can
- * break forwarding setups.  The chains here can be long so only check
- * if the first socket is an exact match and if not move on.
- */
-static struct sock *__udp4_lib_demux_lookup(struct net *net,
-					    __be16 loc_port, __be32 loc_addr,
-					    __be16 rmt_port, __be32 rmt_addr,
-					    int dif, int sdif)
-{
-	struct udp_table *udptable = net->ipv4.udp_table;
-	INET_ADDR_COOKIE(acookie, rmt_addr, loc_addr);
-	unsigned short hnum = ntohs(loc_port);
-	struct udp_hslot *hslot2;
-	unsigned int hash2;
-	__portpair ports;
-	struct sock *sk;
-
-	hash2 = ipv4_portaddr_hash(net, loc_addr, hnum);
-	hslot2 = udp_hashslot2(udptable, hash2);
-	ports = INET_COMBINED_PORTS(rmt_port, hnum);
-
-	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
-		if (inet_match(net, sk, acookie, ports, dif, sdif))
-			return sk;
-		/* Only check first socket in chain */
-		break;
-	}
-	return NULL;
-}
-
-enum skb_drop_reason udp_v4_early_demux(struct sk_buff *skb)
-{
-	struct net *net = dev_net(skb->dev);
-	struct in_device *in_dev = NULL;
-	const struct iphdr *iph;
-	const struct udphdr *uh;
-	struct sock *sk = NULL;
-	struct dst_entry *dst;
-	int dif = skb->dev->ifindex;
-	int sdif = inet_sdif(skb);
-	int ours;
-
-	/* validate the packet */
-	if (!pskb_may_pull(skb, skb_transport_offset(skb) + sizeof(struct udphdr)))
-		return SKB_NOT_DROPPED_YET;
-
-	iph = ip_hdr(skb);
-	uh = udp_hdr(skb);
-
-	if (skb->pkt_type == PACKET_MULTICAST) {
-		in_dev = __in_dev_get_rcu(skb->dev);
-
-		if (!in_dev)
-			return SKB_NOT_DROPPED_YET;
-
-		ours = ip_check_mc_rcu(in_dev, iph->daddr, iph->saddr,
-				       iph->protocol);
-		if (!ours)
-			return SKB_NOT_DROPPED_YET;
-
-		sk = __udp4_lib_mcast_demux_lookup(net, uh->dest, iph->daddr,
-						   uh->source, iph->saddr,
-						   dif, sdif);
-	} else if (skb->pkt_type == PACKET_HOST) {
-		sk = __udp4_lib_demux_lookup(net, uh->dest, iph->daddr,
-					     uh->source, iph->saddr, dif, sdif);
-	}
-
-	if (!sk)
-		return SKB_NOT_DROPPED_YET;
-
-	skb->sk = sk;
-	DEBUG_NET_WARN_ON_ONCE(sk_is_refcounted(sk));
-	skb->destructor = sock_pfree;
-	dst = rcu_dereference(sk->sk_rx_dst);
-
-	if (dst)
-		dst = dst_check(dst, 0);
-	if (dst) {
-		u32 itag = 0;
-
-		/* set noref for now.
-		 * any place which wants to hold dst has to call
-		 * dst_hold_safe()
-		 */
-		skb_dst_set_noref(skb, dst);
-
-		/* for unconnected multicast sockets we need to validate
-		 * the source on each packet
-		 */
-		if (!inet_sk(sk)->inet_daddr && in_dev)
-			return ip_mc_validate_source(skb, iph->daddr,
-						     iph->saddr,
-						     ip4h_dscp(iph),
-						     skb->dev, in_dev, &itag);
-	}
-	return SKB_NOT_DROPPED_YET;
-}
-
-static void udp_destroy_sock(struct sock *sk)
-{
-	struct udp_sock *up = udp_sk(sk);
-	bool slow = lock_sock_fast(sk);
-
-	/* protects from races with udp_abort() */
-	sock_set_flag(sk, SOCK_DEAD);
-	udp_flush_pending_frames(sk);
-	unlock_sock_fast(sk, slow);
-	if (static_branch_unlikely(&udp_encap_needed_key)) {
-		if (up->encap_type) {
-			void (*encap_destroy)(struct sock *sk);
-			encap_destroy = READ_ONCE(up->encap_destroy);
-			if (encap_destroy)
-				encap_destroy(sk);
-		}
-		if (udp_test_bit(ENCAP_ENABLED, sk)) {
-			static_branch_dec(&udp_encap_needed_key);
-			udp_tunnel_cleanup_gro(sk);
-		}
-	}
-}
-
 typedef struct sk_buff *(*udp_gro_receive_t)(struct sock *sk,
 					     struct list_head *head,
 					     struct sk_buff *skb);
@@ -2985,16 +1325,6 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 	return err;
 }
 
-static int udp_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
-			  unsigned int optlen)
-{
-	if (level == SOL_UDP || level == SOL_SOCKET)
-		return udp_lib_setsockopt(sk, level, optname,
-					  optval, optlen,
-					  udp_push_pending_frames);
-	return ip_setsockopt(sk, level, optname, optval, optlen);
-}
-
 int udp_lib_getsockopt(struct sock *sk, int level, int optname,
 		       sockopt_t *opt)
 {
@@ -3043,34 +1373,6 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
 	return 0;
 }
 
-static int udp_getsockopt(struct sock *sk, int level, int optname,
-			  char __user *optval, int __user *optlen)
-{
-	sockopt_t opt;
-	int err;
-
-	/*
-	 * keep the old __user pointers, until ip_getsockopt() moves
-	 * to sockopt_t
-	 */
-	if (level != SOL_UDP)
-		return ip_getsockopt(sk, level, optname, optval, optlen);
-
-	err = sockopt_init_user(&opt, optval, optlen);
-	if (err)
-		return err;
-
-	err = udp_lib_getsockopt(sk, level, optname, &opt);
-	if (err)
-		return err;
-
-	/* optval was written by copy_to_iter() in udp_lib_getsockopt() */
-	if (put_user(opt.optlen, optlen))
-		return -EFAULT;
-
-	return 0;
-}
-
 /**
  * 	udp_poll - wait for a UDP event.
  *	@file: - file struct
@@ -3126,41 +1428,6 @@ int udp_abort(struct sock *sk, int err)
 	return 0;
 }
 
-struct proto udp_prot = {
-	.name			= "UDP",
-	.owner			= THIS_MODULE,
-	.close			= udp_lib_close,
-	.pre_connect		= udp_pre_connect,
-	.connect		= udp_connect,
-	.disconnect		= udp_disconnect,
-	.ioctl			= udp_ioctl,
-	.init			= udp_init_sock,
-	.destroy		= udp_destroy_sock,
-	.setsockopt		= udp_setsockopt,
-	.getsockopt		= udp_getsockopt,
-	.sendmsg		= udp_sendmsg,
-	.recvmsg		= udp_recvmsg,
-	.splice_eof		= udp_splice_eof,
-	.release_cb		= ip4_datagram_release_cb,
-	.hash			= udp_lib_hash,
-	.unhash			= udp_lib_unhash,
-	.rehash			= udp_v4_rehash,
-	.get_port		= udp_v4_get_port,
-	.put_port		= udp_lib_unhash,
-#ifdef CONFIG_BPF_SYSCALL
-	.psock_update_sk_prot	= udp_bpf_update_proto,
-#endif
-	.memory_allocated	= &net_aligned_data.udp_memory_allocated,
-	.per_cpu_fw_alloc	= &udp_memory_per_cpu_fw_alloc,
-
-	.sysctl_mem		= sysctl_udp_mem,
-	.sysctl_wmem_offset	= offsetof(struct net, ipv4.sysctl_udp_wmem_min),
-	.sysctl_rmem_offset	= offsetof(struct net, ipv4.sysctl_udp_rmem_min),
-	.obj_size		= sizeof(struct udp_sock),
-	.diag_destroy		= udp_abort,
-};
-EXPORT_SYMBOL(udp_prot);
-
 /* ------------------------------------------------------------------------ */
 #ifdef CONFIG_PROC_FS
 
diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
index ad57c4c9eaab..a8cbb8f56c73 100644
--- a/net/ipv4/udp_bpf.c
+++ b/net/ipv4/udp_bpf.c
@@ -16,7 +16,11 @@ static int sk_udp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	if (sk->sk_family == AF_INET6)
 		return udpv6_prot_saved->recvmsg(sk, msg, len, flags);
 #endif
+#if IS_ENABLED(CONFIG_IPV4)
 	return udp_prot.recvmsg(sk, msg, len, flags);
+#else
+	return -EAFNOSUPPORT;
+#endif
 }
 
 static bool udp_sk_has_data(struct sock *sk)
@@ -153,12 +157,14 @@ static void udp_bpf_check_v6_needs_rebuild(struct proto *ops)
 	}
 }
 
+#if IS_ENABLED(CONFIG_IPV4)
 static int __init udp_bpf_v4_build_proto(void)
 {
 	udp_bpf_rebuild_protos(&udp_bpf_prots[UDP_BPF_IPV4], &udp_prot);
 	return 0;
 }
 late_initcall(udp_bpf_v4_build_proto);
+#endif
 
 int udp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
 {
diff --git a/net/ipv4/udp_diag.c b/net/ipv4/udp_diag.c
index f4b24e628cf8..51f9267b7441 100644
--- a/net/ipv4/udp_diag.c
+++ b/net/ipv4/udp_diag.c
@@ -37,11 +37,15 @@ static int udp_diag_dump_one(struct netlink_callback *cb,
 
 	rcu_read_lock();
 	if (req->sdiag_family == AF_INET)
+#if IS_ENABLED(CONFIG_IPV4)
 		/* src and dst are swapped for historical reasons */
 		sk = __udp4_lib_lookup(net,
 				       req->id.idiag_src[0], req->id.idiag_sport,
 				       req->id.idiag_dst[0], req->id.idiag_dport,
 				       req->id.idiag_if, 0, NULL);
+#else
+		sk = NULL;
+#endif
 #if IS_ENABLED(CONFIG_IPV6)
 	else if (req->sdiag_family == AF_INET6)
 		sk = __udp6_lib_lookup(net,
@@ -159,18 +163,26 @@ static int udp_diag_destroy(struct sk_buff *in_skb,
 	rcu_read_lock();
 
 	if (req->sdiag_family == AF_INET)
+#if IS_ENABLED(CONFIG_IPV4)
 		sk = __udp4_lib_lookup(net,
 				       req->id.idiag_dst[0], req->id.idiag_dport,
 				       req->id.idiag_src[0], req->id.idiag_sport,
 				       req->id.idiag_if, 0, NULL);
+#else
+		sk = NULL;
+#endif
 #if IS_ENABLED(CONFIG_IPV6)
 	else if (req->sdiag_family == AF_INET6) {
 		if (ipv6_addr_v4mapped((struct in6_addr *)req->id.idiag_dst) &&
 		    ipv6_addr_v4mapped((struct in6_addr *)req->id.idiag_src))
+#if IS_ENABLED(CONFIG_IPV4)
 			sk = __udp4_lib_lookup(net,
 					       req->id.idiag_dst[3], req->id.idiag_dport,
 					       req->id.idiag_src[3], req->id.idiag_sport,
 					       req->id.idiag_if, 0, NULL);
+#else
+			sk = NULL;
+#endif
 		else
 			sk = __udp6_lib_lookup(net,
 					       (struct in6_addr *)req->id.idiag_dst,
diff --git a/net/ipv4/udp_ipv4.c b/net/ipv4/udp_ipv4.c
new file mode 100644
index 000000000000..04ec8dec547a
--- /dev/null
+++ b/net/ipv4/udp_ipv4.c
@@ -0,0 +1,1773 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * INET		An implementation of the TCP/IP protocol suite for the LINUX
+ *		operating system.  INET is implemented using the  BSD Socket
+ *		interface as the means of communication with the user level.
+ *
+ *		The User Datagram Protocol (UDP).
+ *
+ *		IPv4 specific functions
+ *
+ *		code split from:
+ *		net/ipv4/udp.c
+ *
+ *		See udp.c for author information
+ */
+
+#define pr_fmt(fmt) "UDP: " fmt
+
+#include <linux/bpf-cgroup.h>
+#include <linux/igmp.h>
+#include <linux/inetdevice.h>
+#include <linux/socket.h>
+#include <linux/types.h>
+#include <net/aligned_data.h>
+#include <net/busy_poll.h>
+#include <net/gro.h>
+#include <net/icmp.h>
+#include <net/inet_common.h>
+#include <net/inet_hashtables.h>
+#include <net/ip_tunnels.h>
+#include <net/sock_reuseport.h>
+#include <net/udp.h>
+#include <net/udp_tunnel.h>
+#include <net/xfrm.h>
+#include <trace/events/udp.h>
+
+static __always_inline int
+compute_score(struct sock *sk, const struct net *net,
+	      __be32 saddr, __be16 sport, __be32 daddr,
+	      unsigned short hnum, int dif, int sdif)
+{
+	int score;
+	struct inet_sock *inet;
+	bool dev_match;
+
+	if (!net_eq(sock_net(sk), net) ||
+	    udp_sk(sk)->udp_port_hash != hnum ||
+	    ipv6_only_sock(sk))
+		return -1;
+
+	if (sk->sk_rcv_saddr != daddr)
+		return -1;
+
+	score = (sk->sk_family == PF_INET) ? 2 : 1;
+
+	inet = inet_sk(sk);
+	if (inet->inet_daddr) {
+		if (inet->inet_daddr != saddr)
+			return -1;
+		score += 4;
+	}
+
+	if (inet->inet_dport) {
+		if (inet->inet_dport != sport)
+			return -1;
+		score += 4;
+	}
+
+	dev_match = udp_sk_bound_dev_eq(net, sk->sk_bound_dev_if,
+					dif, sdif);
+	if (!dev_match)
+		return -1;
+	if (sk->sk_bound_dev_if)
+		score += 4;
+
+	if (READ_ONCE(sk->sk_incoming_cpu) == raw_smp_processor_id())
+		score++;
+	return score;
+}
+
+/**
+ * udp4_lib_lookup1() - Simplified lookup using primary hash (destination port)
+ * @net:	Network namespace
+ * @saddr:	Source address, network order
+ * @sport:	Source port, network order
+ * @daddr:	Destination address, network order
+ * @hnum:	Destination port, host order
+ * @dif:	Destination interface index
+ * @sdif:	Destination bridge port index, if relevant
+ * @udptable:	Set of UDP hash tables
+ *
+ * Simplified lookup to be used as fallback if no sockets are found due to a
+ * potential race between (receive) address change, and lookup happening before
+ * the rehash operation. This function ignores SO_REUSEPORT groups while scoring
+ * result sockets, because if we have one, we don't need the fallback at all.
+ *
+ * Called under rcu_read_lock().
+ *
+ * Return: socket with highest matching score if any, NULL if none
+ */
+static struct sock *udp4_lib_lookup1(const struct net *net,
+				     __be32 saddr, __be16 sport,
+				     __be32 daddr, unsigned int hnum,
+				     int dif, int sdif,
+				     const struct udp_table *udptable)
+{
+	unsigned int slot = udp_hashfn(net, hnum, udptable->mask);
+	struct udp_hslot *hslot = &udptable->hash[slot];
+	struct sock *sk, *result = NULL;
+	int score, badness = 0;
+
+	sk_for_each_rcu(sk, &hslot->head) {
+		score = compute_score(sk, net,
+				      saddr, sport, daddr, hnum, dif, sdif);
+		if (score > badness) {
+			result = sk;
+			badness = score;
+		}
+	}
+
+	return result;
+}
+
+/* called with rcu_read_lock() */
+static struct sock *udp4_lib_lookup2(const struct net *net,
+				     __be32 saddr, __be16 sport,
+				     __be32 daddr, unsigned int hnum,
+				     int dif, int sdif,
+				     struct udp_hslot *hslot2,
+				     struct sk_buff *skb)
+{
+	struct sock *sk, *result;
+	int score, badness;
+	bool need_rescore;
+
+	result = NULL;
+	badness = 0;
+	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
+		need_rescore = false;
+rescore:
+		score = compute_score(need_rescore ? result : sk, net, saddr,
+				      sport, daddr, hnum, dif, sdif);
+		if (score > badness) {
+			badness = score;
+
+			if (need_rescore)
+				continue;
+
+			if (sk->sk_state == TCP_ESTABLISHED) {
+				result = sk;
+				continue;
+			}
+
+			result = inet_lookup_reuseport(net, sk, skb, sizeof(struct udphdr),
+						       saddr, sport, daddr, hnum, udp_ehashfn);
+			if (!result) {
+				result = sk;
+				continue;
+			}
+
+			/* Fall back to scoring if group has connections */
+			if (!reuseport_has_conns(sk))
+				return result;
+
+			/* Reuseport logic returned an error, keep original score. */
+			if (IS_ERR(result))
+				continue;
+
+			/* compute_score is too long of a function to be
+			 * inlined twice here, and calling it uninlined
+			 * here yields measurable overhead for some
+			 * workloads. Work around it by jumping
+			 * backwards to rescore 'result'.
+			 */
+			need_rescore = true;
+			goto rescore;
+		}
+	}
+	return result;
+}
+
+#if IS_ENABLED(CONFIG_BASE_SMALL)
+static struct sock *udp4_lib_lookup4(const struct net *net,
+				     __be32 saddr, __be16 sport,
+				     __be32 daddr, unsigned int hnum,
+				     int dif, int sdif,
+				     struct udp_table *udptable)
+{
+	return NULL;
+}
+#else /* !CONFIG_BASE_SMALL */
+static struct sock *udp4_lib_lookup4(const struct net *net,
+				     __be32 saddr, __be16 sport,
+				     __be32 daddr, unsigned int hnum,
+				     int dif, int sdif,
+				     struct udp_table *udptable)
+{
+	const __portpair ports = INET_COMBINED_PORTS(sport, hnum);
+	const struct hlist_nulls_node *node;
+	struct udp_hslot *hslot4;
+	unsigned int hash4, slot;
+	struct udp_sock *up;
+	struct sock *sk;
+
+	hash4 = udp_ehashfn(net, daddr, hnum, saddr, sport);
+	slot = hash4 & udptable->mask;
+	hslot4 = &udptable->hash4[slot];
+	INET_ADDR_COOKIE(acookie, saddr, daddr);
+
+begin:
+	/* SLAB_TYPESAFE_BY_RCU not used, so we don't need to touch sk_refcnt */
+	udp_lrpa_for_each_entry_rcu(up, node, &hslot4->nulls_head) {
+		sk = (struct sock *)up;
+		if (inet_match(net, sk, acookie, ports, dif, sdif))
+			return sk;
+	}
+
+	/* if the nulls value we got at the end of this lookup is not the
+	 * expected one, we must restart lookup. We probably met an item that
+	 * was moved to another chain due to rehash.
+	 */
+	if (get_nulls_value(node) != slot)
+		goto begin;
+
+	return NULL;
+}
+
+/* call with sock lock */
+void udp4_hash4(struct sock *sk)
+{
+	struct net *net = sock_net(sk);
+	unsigned int hash;
+
+	if (sk_unhashed(sk) || sk->sk_rcv_saddr == htonl(INADDR_ANY))
+		return;
+
+	hash = udp_ehashfn(net, sk->sk_rcv_saddr, sk->sk_num,
+			   sk->sk_daddr, sk->sk_dport);
+
+	udp_lib_hash4(sk, hash);
+}
+#endif /* CONFIG_BASE_SMALL */
+
+/* UDP is nearly always wildcards out the wazoo, it makes no sense to try
+ * harder than this. -DaveM
+ */
+struct sock *__udp4_lib_lookup(const struct net *net, __be32 saddr,
+			       __be16 sport, __be32 daddr, __be16 dport,
+			       int dif, int sdif, struct sk_buff *skb)
+{
+	struct udp_table *udptable = net->ipv4.udp_table;
+	unsigned short hnum = ntohs(dport);
+	struct udp_hslot *hslot2;
+	struct sock *result, *sk;
+	unsigned int hash2;
+
+	hash2 = ipv4_portaddr_hash(net, daddr, hnum);
+	hslot2 = udp_hashslot2(udptable, hash2);
+
+	if (udp_has_hash4(hslot2)) {
+		result = udp4_lib_lookup4(net, saddr, sport, daddr, hnum,
+					  dif, sdif, udptable);
+		if (result) /* udp4_lib_lookup4 return sk or NULL */
+			return result;
+	}
+
+	/* Lookup connected or non-wildcard socket */
+	result = udp4_lib_lookup2(net, saddr, sport,
+				  daddr, hnum, dif, sdif,
+				  hslot2, skb);
+	if (!IS_ERR_OR_NULL(result) && result->sk_state == TCP_ESTABLISHED)
+		goto done;
+
+	/* Lookup redirect from BPF */
+	if (static_branch_unlikely(&bpf_sk_lookup_enabled)) {
+		sk = inet_lookup_run_sk_lookup(net, IPPROTO_UDP, skb, sizeof(struct udphdr),
+					       saddr, sport, daddr, hnum, dif,
+					       udp_ehashfn);
+		if (sk) {
+			result = sk;
+			goto done;
+		}
+	}
+
+	/* Got non-wildcard socket or error on first lookup */
+	if (result)
+		goto done;
+
+	/* Lookup wildcard sockets */
+	hash2 = ipv4_portaddr_hash(net, htonl(INADDR_ANY), hnum);
+	hslot2 = udp_hashslot2(udptable, hash2);
+
+	result = udp4_lib_lookup2(net, saddr, sport,
+				  htonl(INADDR_ANY), hnum, dif, sdif,
+				  hslot2, skb);
+	if (!IS_ERR_OR_NULL(result))
+		goto done;
+
+	/* Primary hash (destination port) lookup as fallback for this race:
+	 *   1. __ip4_datagram_connect() sets sk_rcv_saddr
+	 *   2. lookup (this function): new sk_rcv_saddr, hashes not updated yet
+	 *   3. rehash operation updating _secondary and four-tuple_ hashes
+	 * The primary hash doesn't need an update after 1., so, thanks to this
+	 * further step, 1. and 3. don't need to be atomic against the lookup.
+	 */
+	result = udp4_lib_lookup1(net, saddr, sport, daddr, hnum, dif, sdif,
+				  udptable);
+
+done:
+	if (IS_ERR(result))
+		return NULL;
+	return result;
+}
+EXPORT_SYMBOL_GPL(__udp4_lib_lookup);
+
+static inline struct sock *__udp4_lib_lookup_skb(struct sk_buff *skb,
+						 __be16 sport, __be16 dport)
+{
+	const struct iphdr *iph = ip_hdr(skb);
+
+	return __udp4_lib_lookup(dev_net(skb->dev), iph->saddr, sport,
+				 iph->daddr, dport, inet_iif(skb),
+				 inet_sdif(skb), skb);
+}
+
+struct sock *udp4_lib_lookup_skb(const struct sk_buff *skb,
+				 __be16 sport, __be16 dport)
+{
+	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
+	const struct iphdr *iph = (struct iphdr *)(skb->data + offset);
+	int iif, sdif;
+
+	inet_get_iif_sdif(skb, &iif, &sdif);
+
+	return __udp4_lib_lookup(dev_net(skb->dev), iph->saddr, sport,
+				 iph->daddr, dport, iif, sdif, NULL);
+}
+
+/* Must be called under rcu_read_lock().
+ * Does increment socket refcount.
+ */
+#if IS_ENABLED(CONFIG_NF_TPROXY_IPV4) || IS_ENABLED(CONFIG_NF_SOCKET_IPV4)
+struct sock *udp4_lib_lookup(const struct net *net, __be32 saddr, __be16 sport,
+			     __be32 daddr, __be16 dport, int dif)
+{
+	struct sock *sk;
+
+	sk = __udp4_lib_lookup(net, saddr, sport, daddr, dport, dif, 0, NULL);
+	if (sk && !refcount_inc_not_zero(&sk->sk_refcnt))
+		sk = NULL;
+	return sk;
+}
+EXPORT_SYMBOL_GPL(udp4_lib_lookup);
+#endif
+
+static int udp_v4_get_port(struct sock *sk, unsigned short snum)
+{
+	unsigned int hash2_nulladdr =
+		ipv4_portaddr_hash(sock_net(sk), htonl(INADDR_ANY), snum);
+	unsigned int hash2_partial =
+		ipv4_portaddr_hash(sock_net(sk), inet_sk(sk)->inet_rcv_saddr, 0);
+
+	/* precompute partial secondary hash */
+	udp_sk(sk)->udp_portaddr_hash = hash2_partial;
+	return udp_lib_get_port(sk, snum, hash2_nulladdr);
+}
+
+static void udp_destruct_sock(struct sock *sk)
+{
+	udp_destruct_common(sk);
+	inet_sock_destruct(sk);
+}
+
+static int udp_init_sock(struct sock *sk)
+{
+	int res = udp_lib_init_sock(sk);
+
+	sk->sk_destruct = udp_destruct_sock;
+	set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
+	return res;
+}
+
+/**
+ * udp4_hwcsum  -  handle outgoing HW checksumming
+ * @skb: sk_buff containing the filled-in UDP header
+ *       (checksum field must be zeroed out)
+ * @src: source IP address
+ * @dst: destination IP address
+ */
+void udp4_hwcsum(struct sk_buff *skb, __be32 src, __be32 dst)
+{
+	struct udphdr *uh = udp_hdr(skb);
+	int offset = skb_transport_offset(skb);
+	int len = skb->len - offset;
+	int hlen = len;
+	__wsum csum = 0;
+
+	if (!skb_has_frag_list(skb)) {
+		/*
+		 * Only one fragment on the socket.
+		 */
+		skb->csum_start = skb_transport_header(skb) - skb->head;
+		skb->csum_offset = offsetof(struct udphdr, check);
+		uh->check = ~csum_tcpudp_magic(src, dst, len,
+					       IPPROTO_UDP, 0);
+	} else {
+		struct sk_buff *frags;
+
+		/*
+		 * HW-checksum won't work as there are two or more
+		 * fragments on the socket so that all csums of sk_buffs
+		 * should be together
+		 */
+		skb_walk_frags(skb, frags) {
+			csum = csum_add(csum, frags->csum);
+			hlen -= frags->len;
+		}
+
+		csum = skb_checksum(skb, offset, hlen, csum);
+		skb->ip_summed = CHECKSUM_NONE;
+
+		uh->check = csum_tcpudp_magic(src, dst, len, IPPROTO_UDP, csum);
+		if (uh->check == 0)
+			uh->check = CSUM_MANGLED_0;
+	}
+}
+EXPORT_SYMBOL_GPL(udp4_hwcsum);
+
+static int udp_send_skb(struct sk_buff *skb, struct flowi4 *fl4,
+			struct inet_cork *cork)
+{
+	struct sock *sk = skb->sk;
+	int offset, len, datalen;
+	struct udphdr *uh;
+	int err;
+
+	offset = skb_transport_offset(skb);
+	len = skb->len - offset;
+	datalen = len - sizeof(*uh);
+
+	/*
+	 * Create a UDP header
+	 */
+	uh = udp_hdr(skb);
+	uh->source = inet_sk(sk)->inet_sport;
+	uh->dest = fl4->fl4_dport;
+	uh->len = htons(len);
+	uh->check = 0;
+
+	if (cork->gso_size) {
+		const int hlen = skb_network_header_len(skb) +
+				 sizeof(struct udphdr);
+
+		if (hlen + min(datalen, cork->gso_size) > cork->fragsize) {
+			kfree_skb(skb);
+			return -EMSGSIZE;
+		}
+		if (datalen > cork->gso_size * UDP_MAX_SEGMENTS) {
+			kfree_skb(skb);
+			return -EINVAL;
+		}
+		if (sk->sk_no_check_tx) {
+			kfree_skb(skb);
+			return -EINVAL;
+		}
+		if (dst_xfrm(skb_dst(skb))) {
+			kfree_skb(skb);
+			return -EIO;
+		}
+
+		if (datalen > cork->gso_size) {
+			skb_shinfo(skb)->gso_size = cork->gso_size;
+			skb_shinfo(skb)->gso_type = SKB_GSO_UDP_L4;
+			skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(datalen,
+								 cork->gso_size);
+
+			/* Don't checksum the payload, skb will get segmented */
+			goto csum_partial;
+		}
+	}
+
+	if (sk->sk_no_check_tx) {			 /* UDP csum off */
+		skb->ip_summed = CHECKSUM_NONE;
+		goto send;
+	} else if (skb->ip_summed == CHECKSUM_PARTIAL) { /* UDP hardware csum */
+csum_partial:
+		udp4_hwcsum(skb, fl4->saddr, fl4->daddr);
+		goto send;
+	}
+
+	/* add protocol-dependent pseudo-header */
+	uh->check = csum_tcpudp_magic(fl4->saddr, fl4->daddr, len,
+				      IPPROTO_UDP, udp_csum(skb));
+	if (uh->check == 0)
+		uh->check = CSUM_MANGLED_0;
+
+send:
+	err = ip_send_skb(sock_net(sk), skb);
+	if (unlikely(err)) {
+		if (err == -ENOBUFS &&
+		    !inet_test_bit(RECVERR, sk)) {
+			UDP_INC_STATS(sock_net(sk), UDP_MIB_SNDBUFERRORS);
+			err = 0;
+		}
+	} else {
+		UDP_INC_STATS(sock_net(sk), UDP_MIB_OUTDATAGRAMS);
+	}
+	return err;
+}
+
+/*
+ * Push out all pending data as one UDP datagram. Socket is locked.
+ */
+int udp_push_pending_frames(struct sock *sk)
+{
+	struct udp_sock  *up = udp_sk(sk);
+	struct inet_sock *inet = inet_sk(sk);
+	struct flowi4 *fl4 = &inet->cork.fl.u.ip4;
+	struct sk_buff *skb;
+	int err = 0;
+
+	skb = ip_finish_skb(sk, fl4);
+	if (!skb)
+		goto out;
+
+	err = udp_send_skb(skb, fl4, &inet->cork.base);
+
+out:
+	up->len = 0;
+	WRITE_ONCE(up->pending, 0);
+	return err;
+}
+
+void udp_splice_eof(struct socket *sock)
+{
+	struct sock *sk = sock->sk;
+	struct udp_sock *up = udp_sk(sk);
+
+	if (!READ_ONCE(up->pending) || udp_test_bit(CORK, sk))
+		return;
+
+	lock_sock(sk);
+	if (up->pending && !udp_test_bit(CORK, sk))
+		udp_push_pending_frames(sk);
+	release_sock(sk);
+}
+
+/* Handler for tunnels with arbitrary destination ports: no socket lookup, go
+ * through error handlers in encapsulations looking for a match.
+ */
+static int __udp4_lib_err_encap_no_sk(struct sk_buff *skb, u32 info)
+{
+	int i;
+
+	for (i = 0; i < MAX_IPTUN_ENCAP_OPS; i++) {
+		int (*handler)(struct sk_buff *skb, u32 info);
+		const struct ip_tunnel_encap_ops *encap;
+
+		encap = rcu_dereference(iptun_encaps[i]);
+		if (!encap)
+			continue;
+		handler = encap->err_handler;
+		if (handler && !handler(skb, info))
+			return 0;
+	}
+
+	return -ENOENT;
+}
+
+/* Try to match ICMP errors to UDP tunnels by looking up a socket without
+ * reversing source and destination port: this will match tunnels that force the
+ * same destination port on both endpoints (e.g. VXLAN, GENEVE). Note that
+ * lwtunnels might actually break this assumption by being configured with
+ * different destination ports on endpoints, in this case we won't be able to
+ * trace ICMP messages back to them.
+ *
+ * If this doesn't match any socket, probe tunnels with arbitrary destination
+ * ports (e.g. FoU, GUE): there, the receiving socket is useless, as the port
+ * we've sent packets to won't necessarily match the local destination port.
+ *
+ * Then ask the tunnel implementation to match the error against a valid
+ * association.
+ *
+ * Return an error if we can't find a match, the socket if we need further
+ * processing, zero otherwise.
+ */
+static struct sock *__udp4_lib_err_encap(struct net *net,
+					 const struct iphdr *iph,
+					 struct udphdr *uh,
+					 struct sock *sk,
+					 struct sk_buff *skb, u32 info)
+{
+	int (*lookup)(struct sock *sk, struct sk_buff *skb);
+	int network_offset, transport_offset;
+	struct udp_sock *up;
+
+	network_offset = skb_network_offset(skb);
+	transport_offset = skb_transport_offset(skb);
+
+	/* Network header needs to point to the outer IPv4 header inside ICMP */
+	skb_reset_network_header(skb);
+
+	/* Transport header needs to point to the UDP header */
+	skb_set_transport_header(skb, iph->ihl << 2);
+
+	if (sk) {
+		up = udp_sk(sk);
+
+		lookup = READ_ONCE(up->encap_err_lookup);
+		if (lookup && lookup(sk, skb))
+			sk = NULL;
+
+		goto out;
+	}
+
+	sk = __udp4_lib_lookup(net, iph->daddr, uh->source,
+			       iph->saddr, uh->dest, skb->dev->ifindex, 0, NULL);
+	if (sk) {
+		up = udp_sk(sk);
+
+		lookup = READ_ONCE(up->encap_err_lookup);
+		if (!lookup || lookup(sk, skb))
+			sk = NULL;
+	}
+
+out:
+	if (!sk)
+		sk = ERR_PTR(__udp4_lib_err_encap_no_sk(skb, info));
+
+	skb_set_transport_header(skb, transport_offset);
+	skb_set_network_header(skb, network_offset);
+
+	return sk;
+}
+
+/*
+ * This routine is called by the ICMP module when it gets some
+ * sort of error condition.  If err < 0 then the socket should
+ * be closed and the error returned to the user.  If err > 0
+ * it's just the icmp type << 8 | icmp code.
+ * Header points to the ip header of the error packet. We move
+ * on past this. Then (as it used to claim before adjustment)
+ * header points to the first 8 bytes of the udp header.  We need
+ * to find the appropriate port.
+ */
+int udp_err(struct sk_buff *skb, u32 info)
+{
+	const struct iphdr *iph = (const struct iphdr *)skb->data;
+	const int type = icmp_hdr(skb)->type;
+	const int code = icmp_hdr(skb)->code;
+	struct net *net = dev_net(skb->dev);
+	struct inet_sock *inet;
+	bool tunnel = false;
+	struct udphdr *uh;
+	struct sock *sk;
+	int harderr;
+	int err;
+
+	uh = (struct udphdr *)(skb->data + (iph->ihl << 2));
+	sk = __udp4_lib_lookup(net, iph->daddr, uh->dest,
+			       iph->saddr, uh->source, skb->dev->ifindex,
+			       inet_sdif(skb), NULL);
+
+	if (!sk || READ_ONCE(udp_sk(sk)->encap_type)) {
+		/* No socket for error: try tunnels before discarding */
+		if (static_branch_unlikely(&udp_encap_needed_key)) {
+			sk = __udp4_lib_err_encap(net, iph, uh, sk, skb, info);
+			if (!sk)
+				return 0;
+		} else {
+			sk = ERR_PTR(-ENOENT);
+		}
+
+		if (IS_ERR(sk)) {
+			__ICMP_INC_STATS(net, ICMP_MIB_INERRORS);
+			return PTR_ERR(sk);
+		}
+
+		tunnel = true;
+	}
+
+	err = 0;
+	harderr = 0;
+	inet = inet_sk(sk);
+
+	switch (type) {
+	default:
+	case ICMP_TIME_EXCEEDED:
+		err = EHOSTUNREACH;
+		break;
+	case ICMP_SOURCE_QUENCH:
+		goto out;
+	case ICMP_PARAMETERPROB:
+		err = EPROTO;
+		harderr = 1;
+		break;
+	case ICMP_DEST_UNREACH:
+		if (code == ICMP_FRAG_NEEDED) { /* Path MTU discovery */
+			ipv4_sk_update_pmtu(skb, sk, info);
+			if (READ_ONCE(inet->pmtudisc) != IP_PMTUDISC_DONT) {
+				err = EMSGSIZE;
+				harderr = 1;
+				break;
+			}
+			goto out;
+		}
+		err = EHOSTUNREACH;
+		if (code <= NR_ICMP_UNREACH) {
+			harderr = icmp_err_convert[code].fatal;
+			err = icmp_err_convert[code].errno;
+		}
+		break;
+	case ICMP_REDIRECT:
+		ipv4_sk_redirect(skb, sk);
+		goto out;
+	}
+
+	/*
+	 *      RFC1122: OK.  Passes ICMP errors back to application, as per
+	 *	4.1.3.3.
+	 */
+	if (tunnel) {
+		/* ...not for tunnels though: we don't have a sending socket */
+		if (udp_sk(sk)->encap_err_rcv)
+			udp_sk(sk)->encap_err_rcv(sk, skb, err, uh->dest, info,
+						  (u8 *)(uh + 1));
+		goto out;
+	}
+	if (!inet_test_bit(RECVERR, sk)) {
+		if (!harderr || sk->sk_state != TCP_ESTABLISHED)
+			goto out;
+	} else {
+		ip_icmp_error(sk, skb, err, uh->dest, info, (u8 *)(uh + 1));
+	}
+
+	sk->sk_err = err;
+	sk_error_report(sk);
+out:
+	return 0;
+}
+
+static int __udp_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
+{
+	int rc;
+
+	if (inet_sk(sk)->inet_daddr) {
+		sock_rps_save_rxhash(sk, skb);
+		sk_mark_napi_id(sk, skb);
+		sk_incoming_cpu_update(sk);
+	} else {
+		sk_mark_napi_id_once(sk, skb);
+	}
+
+	rc = __udp_enqueue_schedule_skb(sk, skb);
+	if (rc < 0) {
+		struct net *net = sock_net(sk);
+		int drop_reason;
+
+		/* Note that an ENOMEM error is charged twice */
+		if (rc == -ENOMEM) {
+			UDP_INC_STATS(net, UDP_MIB_RCVBUFERRORS);
+			drop_reason = SKB_DROP_REASON_SOCKET_RCVBUFF;
+		} else {
+			UDP_INC_STATS(net, UDP_MIB_MEMERRORS);
+			drop_reason = SKB_DROP_REASON_PROTO_MEM;
+		}
+		UDP_INC_STATS(net, UDP_MIB_INERRORS);
+		trace_udp_fail_queue_rcv_skb(rc, sk, skb);
+		sk_skb_reason_drop(sk, skb, drop_reason);
+		return -1;
+	}
+
+	return 0;
+}
+
+/*
+ * 	This should be easy, if there is something there we
+ * 	return it, otherwise we block.
+ */
+
+INDIRECT_CALLABLE_SCOPE
+int udp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags)
+{
+	DECLARE_SOCKADDR(struct sockaddr_in *, sin, msg->msg_name);
+	int off, err, peeking = flags & MSG_PEEK;
+	struct inet_sock *inet = inet_sk(sk);
+	struct net *net = sock_net(sk);
+	bool checksum_valid = false;
+	unsigned int ulen, copied;
+	struct sk_buff *skb;
+
+	if (flags & MSG_ERRQUEUE)
+		return ip_recv_error(sk, msg, len);
+
+try_again:
+	off = sk_peek_offset(sk, flags);
+	skb = __skb_recv_udp(sk, flags, &off, &err);
+	if (!skb)
+		return err;
+
+	ulen = udp_skb_len(skb);
+	copied = len;
+	if (copied > ulen - off)
+		copied = ulen - off;
+	else if (copied < ulen)
+		msg->msg_flags |= MSG_TRUNC;
+
+	/* If checksum is needed at all, try to do it while copying the
+	 * data.  If the data is truncated, do it before the copy.
+	 */
+	if (copied < ulen || peeking) {
+		checksum_valid = udp_skb_csum_unnecessary(skb) ||
+				!__udp_lib_checksum_complete(skb);
+		if (!checksum_valid)
+			goto csum_copy_err;
+	}
+
+	if (checksum_valid || udp_skb_csum_unnecessary(skb)) {
+		if (udp_skb_is_linear(skb))
+			err = copy_linear_skb(skb, copied, off, &msg->msg_iter);
+		else
+			err = skb_copy_datagram_msg(skb, off, msg, copied);
+	} else {
+		err = skb_copy_and_csum_datagram_msg(skb, off, msg);
+
+		if (err == -EINVAL)
+			goto csum_copy_err;
+	}
+
+	if (unlikely(err)) {
+		if (!peeking) {
+			udp_drops_inc(sk);
+			UDP_INC_STATS(net, UDP_MIB_INERRORS);
+		}
+		kfree_skb(skb);
+		return err;
+	}
+
+	if (!peeking)
+		UDP_INC_STATS(net, UDP_MIB_INDATAGRAMS);
+
+	sock_recv_cmsgs(msg, sk, skb);
+
+	/* Copy the address. */
+	if (sin) {
+		sin->sin_family = AF_INET;
+		sin->sin_port = udp_hdr(skb)->source;
+		sin->sin_addr.s_addr = ip_hdr(skb)->saddr;
+		memset(sin->sin_zero, 0, sizeof(sin->sin_zero));
+		msg->msg_namelen = sizeof(*sin);
+
+		BPF_CGROUP_RUN_PROG_UDP4_RECVMSG_LOCK(sk,
+						      (struct sockaddr *)sin,
+						      &msg->msg_namelen);
+	}
+
+	if (udp_test_bit(GRO_ENABLED, sk))
+		udp_cmsg_recv(msg, sk, skb);
+
+	if (inet_cmsg_flags(inet))
+		ip_cmsg_recv_offset(msg, sk, skb, sizeof(struct udphdr), off);
+
+	err = copied;
+	if (flags & MSG_TRUNC)
+		err = ulen;
+
+	skb_consume_udp(sk, skb, peeking ? -err : err);
+	return err;
+
+csum_copy_err:
+	if (!__sk_queue_drop_skb(sk, &udp_sk(sk)->reader_queue, skb, flags,
+				 udp_skb_destructor)) {
+		UDP_INC_STATS(net, UDP_MIB_CSUMERRORS);
+		UDP_INC_STATS(net, UDP_MIB_INERRORS);
+	}
+	kfree_skb_reason(skb, SKB_DROP_REASON_UDP_CSUM);
+
+	/* starting over for a new packet, but check if we need to yield */
+	cond_resched();
+	msg->msg_flags &= ~MSG_TRUNC;
+	goto try_again;
+}
+
+/* Initialize UDP checksum. If exited with zero value (success),
+ * CHECKSUM_UNNECESSARY means, that no more checks are required.
+ * Otherwise, csum completion requires checksumming packet body,
+ * including udp header and folding it to skb->csum.
+ */
+static inline int udp4_csum_init(struct sk_buff *skb, struct udphdr *uh)
+{
+	int err;
+
+	/* Note, we are only interested in != 0 or == 0, thus the
+	 * force to int.
+	 */
+	err = (__force int)skb_checksum_init_zero_check(skb, IPPROTO_UDP, uh->check,
+							inet_compute_pseudo);
+	if (err)
+		return err;
+
+	if (skb->ip_summed == CHECKSUM_COMPLETE && !skb->csum_valid) {
+		/* If SW calculated the value, we know it's bad */
+		if (skb->csum_complete_sw)
+			return 1;
+
+		/* HW says the value is bad. Let's validate that.
+		 * skb->csum is no longer the full packet checksum,
+		 * so don't treat it as such.
+		 */
+		skb_checksum_complete_unset(skb);
+	}
+
+	return 0;
+}
+
+/* returns:
+ *  -1: error
+ *   0: success
+ *  >0: "udp encap" protocol resubmission
+ *
+ * Note that in the success and error cases, the skb is assumed to
+ * have either been requeued or freed.
+ */
+static int udp_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
+{
+	enum skb_drop_reason drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
+	struct udp_sock *up = udp_sk(sk);
+	struct net *net = sock_net(sk);
+
+	/*
+	 *	Charge it to the socket, dropping if the queue is full.
+	 */
+	if (!xfrm4_policy_check(sk, XFRM_POLICY_IN, skb)) {
+		drop_reason = SKB_DROP_REASON_XFRM_POLICY;
+		goto drop;
+	}
+	nf_reset_ct(skb);
+
+	if (static_branch_unlikely(&udp_encap_needed_key) &&
+	    READ_ONCE(up->encap_type)) {
+		int (*encap_rcv)(struct sock *sk, struct sk_buff *skb);
+
+		/*
+		 * This is an encapsulation socket so pass the skb to
+		 * the socket's udp_encap_rcv() hook. Otherwise, just
+		 * fall through and pass this up the UDP socket.
+		 * up->encap_rcv() returns the following value:
+		 * =0 if skb was successfully passed to the encap
+		 *    handler or was discarded by it.
+		 * >0 if skb should be passed on to UDP.
+		 * <0 if skb should be resubmitted as proto -N
+		 */
+
+		/* if we're overly short, let UDP handle it */
+		encap_rcv = READ_ONCE(up->encap_rcv);
+		if (encap_rcv) {
+			int ret;
+
+			/* Verify checksum before giving to encap */
+			if (udp_lib_checksum_complete(skb))
+				goto csum_error;
+
+			ret = encap_rcv(sk, skb);
+			if (ret <= 0) {
+				__UDP_INC_STATS(net, UDP_MIB_INDATAGRAMS);
+				return -ret;
+			}
+		}
+
+		/* FALLTHROUGH -- it's a UDP Packet */
+	}
+
+	prefetch(&sk->sk_rmem_alloc);
+	if (rcu_access_pointer(sk->sk_filter) &&
+	    udp_lib_checksum_complete(skb))
+		goto csum_error;
+
+	drop_reason = sk_filter_trim_cap(sk, skb, sizeof(struct udphdr));
+	if (drop_reason)
+		goto drop;
+
+	udp_csum_pull_header(skb);
+
+	ipv4_pktinfo_prepare(sk, skb, true);
+	return __udp_queue_rcv_skb(sk, skb);
+
+csum_error:
+	drop_reason = SKB_DROP_REASON_UDP_CSUM;
+	__UDP_INC_STATS(net, UDP_MIB_CSUMERRORS);
+drop:
+	__UDP_INC_STATS(net, UDP_MIB_INERRORS);
+	udp_drops_inc(sk);
+	sk_skb_reason_drop(sk, skb, drop_reason);
+	return -1;
+}
+
+static int udp_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
+{
+	struct sk_buff *next, *segs;
+	int ret;
+
+	if (likely(!udp_unexpected_gso(sk, skb)))
+		return udp_queue_rcv_one_skb(sk, skb);
+
+	BUILD_BUG_ON(sizeof(struct udp_skb_cb) > SKB_GSO_CB_OFFSET);
+	__skb_push(skb, -skb_mac_offset(skb));
+	segs = udp_rcv_segment(sk, skb, true);
+	skb_list_walk_safe(segs, skb, next) {
+		__skb_pull(skb, skb_transport_offset(skb));
+
+		udp_post_segment_fix_csum(skb);
+		ret = udp_queue_rcv_one_skb(sk, skb);
+		if (ret > 0)
+			ip_protocol_deliver_rcu(dev_net(skb->dev), skb, ret);
+	}
+	return 0;
+}
+
+static inline bool __udp_is_mcast_sock(struct net *net, const struct sock *sk,
+				       __be16 loc_port, __be32 loc_addr,
+				       __be16 rmt_port, __be32 rmt_addr,
+				       int dif, int sdif, unsigned short hnum)
+{
+	const struct inet_sock *inet = inet_sk(sk);
+
+	if (!net_eq(sock_net(sk), net) ||
+	    udp_sk(sk)->udp_port_hash != hnum ||
+	    (inet->inet_daddr && inet->inet_daddr != rmt_addr) ||
+	    (inet->inet_dport != rmt_port && inet->inet_dport) ||
+	    (inet->inet_rcv_saddr && inet->inet_rcv_saddr != loc_addr) ||
+	    ipv6_only_sock(sk) ||
+	    !udp_sk_bound_dev_eq(net, sk->sk_bound_dev_if, dif, sdif))
+		return false;
+	if (!ip_mc_sf_allow(sk, loc_addr, rmt_addr, dif, sdif))
+		return false;
+	return true;
+}
+
+/*
+ *	Multicasts and broadcasts go to each listener.
+ *
+ *	Note: called only from the BH handler context.
+ */
+static int __udp4_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
+				    struct udphdr  *uh,
+				    __be32 saddr, __be32 daddr)
+{
+	struct udp_table *udptable = net->ipv4.udp_table;
+	unsigned int hash2, hash2_any, offset;
+	unsigned short hnum = ntohs(uh->dest);
+	struct sock *sk, *first = NULL;
+	int dif = skb->dev->ifindex;
+	int sdif = inet_sdif(skb);
+	struct hlist_node *node;
+	struct udp_hslot *hslot;
+	struct sk_buff *nskb;
+	bool use_hash2;
+
+	hash2_any = 0;
+	hash2 = 0;
+	hslot = udp_hashslot(udptable, net, hnum);
+	use_hash2 = hslot->count > 10;
+	offset = offsetof(typeof(*sk), sk_node);
+
+	if (use_hash2) {
+		hash2_any = ipv4_portaddr_hash(net, htonl(INADDR_ANY), hnum) &
+			    udptable->mask;
+		hash2 = ipv4_portaddr_hash(net, daddr, hnum) & udptable->mask;
+start_lookup:
+		hslot = &udptable->hash2[hash2].hslot;
+		offset = offsetof(typeof(*sk), __sk_common.skc_portaddr_node);
+	}
+
+	sk_for_each_entry_offset_rcu(sk, node, &hslot->head, offset) {
+		if (!__udp_is_mcast_sock(net, sk, uh->dest, daddr,
+					 uh->source, saddr, dif, sdif, hnum))
+			continue;
+
+		if (!first) {
+			first = sk;
+			continue;
+		}
+		nskb = skb_clone(skb, GFP_ATOMIC);
+
+		if (unlikely(!nskb)) {
+			udp_drops_inc(sk);
+			__UDP_INC_STATS(net, UDP_MIB_RCVBUFERRORS);
+			__UDP_INC_STATS(net, UDP_MIB_INERRORS);
+			continue;
+		}
+		if (udp_queue_rcv_skb(sk, nskb) > 0)
+			consume_skb(nskb);
+	}
+
+	/* Also lookup *:port if we are using hash2 and haven't done so yet. */
+	if (use_hash2 && hash2 != hash2_any) {
+		hash2 = hash2_any;
+		goto start_lookup;
+	}
+
+	if (first) {
+		if (udp_queue_rcv_skb(first, skb) > 0)
+			consume_skb(skb);
+	} else {
+		kfree_skb(skb);
+		__UDP_INC_STATS(net, UDP_MIB_IGNOREDMULTI);
+	}
+	return 0;
+}
+
+/* wrapper for udp_queue_rcv_skb taking care of csum conversion and
+ * return code conversion for ip layer consumption
+ */
+static int udp_unicast_rcv_skb(struct sock *sk, struct sk_buff *skb,
+			       struct udphdr *uh)
+{
+	int ret;
+
+	if (inet_get_convert_csum(sk) && uh->check)
+		skb_checksum_try_convert(skb, IPPROTO_UDP, inet_compute_pseudo);
+
+	ret = udp_queue_rcv_skb(sk, skb);
+
+	/* a return value > 0 means to resubmit the input, but
+	 * it wants the return to be -protocol, or 0
+	 */
+	if (ret > 0)
+		return -ret;
+	return 0;
+}
+
+/*
+ *	All we need to do is get the socket, and then do a checksum.
+ */
+
+int udp_rcv(struct sk_buff *skb)
+{
+	struct rtable *rt = skb_rtable(skb);
+	struct net *net = dev_net(skb->dev);
+	struct sock *sk = NULL;
+	unsigned short ulen;
+	__be32 saddr, daddr;
+	struct udphdr *uh;
+	bool refcounted;
+	int drop_reason;
+
+	drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
+
+	/*
+	 *  Validate the packet.
+	 */
+	if (!pskb_may_pull(skb, sizeof(struct udphdr)))
+		goto drop;		/* No space for header. */
+
+	uh   = udp_hdr(skb);
+	ulen = ntohs(uh->len);
+	saddr = ip_hdr(skb)->saddr;
+	daddr = ip_hdr(skb)->daddr;
+
+	if (ulen > skb->len)
+		goto short_packet;
+
+	if (ulen < sizeof(*uh))
+		goto short_packet;
+
+	if (ulen < skb->len) {
+		if (pskb_trim_rcsum(skb, ulen))
+			goto short_packet;
+
+		uh = udp_hdr(skb);
+	}
+
+	if (udp4_csum_init(skb, uh))
+		goto csum_error;
+
+	sk = inet_steal_sock(net, skb, sizeof(struct udphdr), saddr, uh->source, daddr, uh->dest,
+			     &refcounted, udp_ehashfn);
+	if (IS_ERR(sk))
+		goto no_sk;
+
+	if (sk) {
+		struct dst_entry *dst = skb_dst(skb);
+		int ret;
+
+		if (unlikely(rcu_dereference(sk->sk_rx_dst) != dst))
+			udp_sk_rx_dst_set(sk, dst);
+
+		ret = udp_unicast_rcv_skb(sk, skb, uh);
+		if (refcounted)
+			sock_put(sk);
+		return ret;
+	}
+
+	if (rt->rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST))
+		return __udp4_lib_mcast_deliver(net, skb, uh, saddr, daddr);
+
+	sk = __udp4_lib_lookup_skb(skb, uh->source, uh->dest);
+	if (sk)
+		return udp_unicast_rcv_skb(sk, skb, uh);
+no_sk:
+	if (!xfrm4_policy_check(NULL, XFRM_POLICY_IN, skb))
+		goto drop;
+	nf_reset_ct(skb);
+
+	/* No socket. Drop packet silently, if checksum is wrong */
+	if (udp_lib_checksum_complete(skb))
+		goto csum_error;
+
+	drop_reason = SKB_DROP_REASON_NO_SOCKET;
+	__UDP_INC_STATS(net, UDP_MIB_NOPORTS);
+	icmp_send(skb, ICMP_DEST_UNREACH, ICMP_PORT_UNREACH, 0);
+
+	/*
+	 * Hmm.  We got an UDP packet to a port to which we
+	 * don't wanna listen.  Ignore it.
+	 */
+	sk_skb_reason_drop(sk, skb, drop_reason);
+	return 0;
+
+short_packet:
+	drop_reason = SKB_DROP_REASON_PKT_TOO_SMALL;
+	net_dbg_ratelimited("UDP: short packet: From %pI4:%u %d/%d to %pI4:%u\n",
+			    &saddr, ntohs(uh->source),
+			    ulen, skb->len,
+			    &daddr, ntohs(uh->dest));
+	goto drop;
+
+csum_error:
+	/*
+	 * RFC1122: OK.  Discards the bad packet silently (as far as
+	 * the network is concerned, anyway) as per 4.1.3.4 (MUST).
+	 */
+	drop_reason = SKB_DROP_REASON_UDP_CSUM;
+	net_dbg_ratelimited("UDP: bad checksum. From %pI4:%u to %pI4:%u ulen %d\n",
+			    &saddr, ntohs(uh->source), &daddr, ntohs(uh->dest),
+			    ulen);
+	__UDP_INC_STATS(net, UDP_MIB_CSUMERRORS);
+drop:
+	__UDP_INC_STATS(net, UDP_MIB_INERRORS);
+	sk_skb_reason_drop(sk, skb, drop_reason);
+	return 0;
+}
+
+int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
+{
+	int corkreq = udp_test_bit(CORK, sk) || msg->msg_flags & MSG_MORE;
+	DEFINE_RAW_FLEX(struct ip_options_rcu, opt_copy, opt.__data,
+			IP_OPTIONS_DATA_FIXED_SIZE);
+	DECLARE_SOCKADDR(struct sockaddr_in *, usin, msg->msg_name);
+	int ulen = len, free = 0, connected = 0;
+	struct inet_sock *inet = inet_sk(sk);
+	struct udp_sock *up = udp_sk(sk);
+	__be32 daddr, faddr, saddr;
+	struct rtable *rt = NULL;
+	struct flowi4 fl4_stack;
+	struct ipcm_cookie ipc;
+	struct sk_buff *skb;
+	struct flowi4 *fl4;
+	__be16 dport;
+	int uc_index;
+	u8 scope;
+	int err;
+
+	if (len > 0xFFFF)
+		return -EMSGSIZE;
+
+	/*
+	 *	Check the flags.
+	 */
+
+	if (msg->msg_flags & MSG_OOB) /* Mirror BSD error message compatibility */
+		return -EOPNOTSUPP;
+
+	fl4 = &inet->cork.fl.u.ip4;
+	if (READ_ONCE(up->pending)) {
+		/*
+		 * There are pending frames.
+		 * The socket lock must be held while it's corked.
+		 */
+		lock_sock(sk);
+		if (likely(up->pending)) {
+			if (unlikely(up->pending != AF_INET)) {
+				release_sock(sk);
+				return -EINVAL;
+			}
+			goto do_append_data;
+		}
+		release_sock(sk);
+	}
+	ulen += sizeof(struct udphdr);
+
+	/*
+	 *	Get and verify the address.
+	 */
+	if (usin) {
+		if (msg->msg_namelen < sizeof(*usin))
+			return -EINVAL;
+		if (usin->sin_family != AF_INET) {
+			if (usin->sin_family != AF_UNSPEC)
+				return -EAFNOSUPPORT;
+		}
+
+		daddr = usin->sin_addr.s_addr;
+		dport = usin->sin_port;
+		if (dport == 0)
+			return -EINVAL;
+	} else {
+		if (sk->sk_state != TCP_ESTABLISHED)
+			return -EDESTADDRREQ;
+		daddr = inet->inet_daddr;
+		dport = inet->inet_dport;
+		/* Open fast path for connected socket.
+		   Route will not be used, if at least one option is set.
+		 */
+		connected = 1;
+	}
+
+	ipcm_init_sk(&ipc, inet);
+	ipc.gso_size = READ_ONCE(up->gso_size);
+
+	if (msg->msg_controllen) {
+		err = udp_cmsg_send(sk, msg, &ipc.gso_size);
+		if (err > 0) {
+			err = ip_cmsg_send(sk, msg, &ipc,
+					   sk->sk_family == AF_INET6);
+			connected = 0;
+		}
+		if (unlikely(err < 0)) {
+			kfree(ipc.opt);
+			return err;
+		}
+		if (ipc.opt)
+			free = 1;
+	}
+	if (!ipc.opt) {
+		struct ip_options_rcu *inet_opt;
+
+		rcu_read_lock();
+		inet_opt = rcu_dereference(inet->inet_opt);
+		if (inet_opt) {
+			memcpy(opt_copy, inet_opt,
+			       sizeof(*inet_opt) + inet_opt->opt.optlen);
+			ipc.opt = opt_copy;
+		}
+		rcu_read_unlock();
+	}
+
+	if (cgroup_bpf_enabled(CGROUP_UDP4_SENDMSG) && !connected) {
+		err = BPF_CGROUP_RUN_PROG_UDP4_SENDMSG_LOCK(sk,
+					    (struct sockaddr *)usin,
+					    &msg->msg_namelen,
+					    &ipc.addr);
+		if (err)
+			goto out_free;
+		if (usin) {
+			if (usin->sin_port == 0) {
+				/* BPF program set invalid port. Reject it. */
+				err = -EINVAL;
+				goto out_free;
+			}
+			daddr = usin->sin_addr.s_addr;
+			dport = usin->sin_port;
+		}
+	}
+
+	saddr = ipc.addr;
+	ipc.addr = faddr = daddr;
+
+	if (ipc.opt && ipc.opt->opt.srr) {
+		if (!daddr) {
+			err = -EINVAL;
+			goto out_free;
+		}
+		faddr = ipc.opt->opt.faddr;
+		connected = 0;
+	}
+	scope = ip_sendmsg_scope(inet, &ipc, msg);
+	if (scope == RT_SCOPE_LINK)
+		connected = 0;
+
+	uc_index = READ_ONCE(inet->uc_index);
+	if (ipv4_is_multicast(daddr)) {
+		if (!ipc.oif || netif_index_is_l3_master(sock_net(sk), ipc.oif))
+			ipc.oif = READ_ONCE(inet->mc_index);
+		if (!saddr)
+			saddr = READ_ONCE(inet->mc_addr);
+		connected = 0;
+	} else if (!ipc.oif) {
+		ipc.oif = uc_index;
+	} else if (ipv4_is_lbcast(daddr) && uc_index) {
+		/* oif is set, packet is to local broadcast and
+		 * uc_index is set. oif is most likely set
+		 * by sk_bound_dev_if. If uc_index != oif check if the
+		 * oif is an L3 master and uc_index is an L3 slave.
+		 * If so, we want to allow the send using the uc_index.
+		 */
+		if (ipc.oif != uc_index &&
+		    ipc.oif == l3mdev_master_ifindex_by_index(sock_net(sk),
+							      uc_index)) {
+			ipc.oif = uc_index;
+		}
+	}
+
+	if (connected)
+		rt = dst_rtable(sk_dst_check(sk, 0));
+
+	if (!rt) {
+		struct net *net = sock_net(sk);
+		__u8 flow_flags = inet_sk_flowi_flags(sk);
+
+		fl4 = &fl4_stack;
+
+		flowi4_init_output(fl4, ipc.oif, ipc.sockc.mark,
+				   ipc.tos & INET_DSCP_MASK, scope,
+				   IPPROTO_UDP, flow_flags, faddr, saddr,
+				   dport, inet->inet_sport,
+				   sk_uid(sk));
+
+		security_sk_classify_flow(sk, flowi4_to_flowi_common(fl4));
+		rt = ip_route_output_flow(net, fl4, sk);
+		if (IS_ERR(rt)) {
+			err = PTR_ERR(rt);
+			rt = NULL;
+			if (err == -ENETUNREACH)
+				IP_INC_STATS(net, IPSTATS_MIB_OUTNOROUTES);
+			goto out;
+		}
+
+		err = -EACCES;
+		if ((rt->rt_flags & RTCF_BROADCAST) &&
+		    !sock_flag(sk, SOCK_BROADCAST))
+			goto out;
+		if (connected)
+			sk_dst_set(sk, dst_clone(&rt->dst));
+	}
+
+	if (msg->msg_flags & MSG_CONFIRM)
+		goto do_confirm;
+back_from_confirm:
+
+	saddr = fl4->saddr;
+	if (!ipc.addr)
+		daddr = ipc.addr = fl4->daddr;
+
+	/* Lockless fast path for the non-corking case. */
+	if (!corkreq) {
+		struct inet_cork cork;
+
+		skb = ip_make_skb(sk, fl4, ip_generic_getfrag, msg, ulen,
+				  sizeof(struct udphdr), &ipc, &rt,
+				  &cork, msg->msg_flags);
+		err = PTR_ERR(skb);
+		if (!IS_ERR_OR_NULL(skb))
+			err = udp_send_skb(skb, fl4, &cork);
+		goto out;
+	}
+
+	lock_sock(sk);
+	if (unlikely(up->pending)) {
+		/* The socket is already corked while preparing it. */
+		/* ... which is an evident application bug. --ANK */
+		release_sock(sk);
+
+		net_dbg_ratelimited("socket already corked\n");
+		err = -EINVAL;
+		goto out;
+	}
+	/*
+	 *	Now cork the socket to pend data.
+	 */
+	fl4 = &inet->cork.fl.u.ip4;
+	fl4->daddr = daddr;
+	fl4->saddr = saddr;
+	fl4->fl4_dport = dport;
+	fl4->fl4_sport = inet->inet_sport;
+	WRITE_ONCE(up->pending, AF_INET);
+
+do_append_data:
+	up->len += ulen;
+	err = ip_append_data(sk, fl4, ip_generic_getfrag, msg, ulen,
+			     sizeof(struct udphdr), &ipc, &rt,
+			     corkreq ? msg->msg_flags | MSG_MORE : msg->msg_flags);
+	if (err)
+		udp_flush_pending_frames(sk);
+	else if (!corkreq)
+		err = udp_push_pending_frames(sk);
+	else if (unlikely(skb_queue_empty(&sk->sk_write_queue)))
+		WRITE_ONCE(up->pending, 0);
+	release_sock(sk);
+
+out:
+	ip_rt_put(rt);
+out_free:
+	if (free)
+		kfree(ipc.opt);
+	if (!err)
+		return len;
+	/*
+	 * ENOBUFS = no kernel mem, SOCK_NOSPACE = no sndbuf space.  Reporting
+	 * ENOBUFS might not be good (it's not tunable per se), but otherwise
+	 * we don't have a good statistic (IpOutDiscards but it can be too many
+	 * things).  We could add another new stat but at least for now that
+	 * seems like overkill.
+	 */
+	if (err == -ENOBUFS || test_bit(SOCK_NOSPACE, &sk->sk_socket->flags))
+		UDP_INC_STATS(sock_net(sk), UDP_MIB_SNDBUFERRORS);
+
+	return err;
+
+do_confirm:
+	if (msg->msg_flags & MSG_PROBE)
+		dst_confirm_neigh(&rt->dst, &fl4->daddr);
+	if (!(msg->msg_flags & MSG_PROBE) || len)
+		goto back_from_confirm;
+	err = 0;
+	goto out;
+}
+EXPORT_SYMBOL(udp_sendmsg);
+
+static int udp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
+		       int addr_len)
+{
+	int res;
+
+	lock_sock(sk);
+	res = __ip4_datagram_connect(sk, uaddr, addr_len);
+	if (!res)
+		udp4_hash4(sk);
+	release_sock(sk);
+	return res;
+}
+
+static void udp_v4_rehash(struct sock *sk)
+{
+	u16 new_hash = ipv4_portaddr_hash(sock_net(sk),
+					  inet_sk(sk)->inet_rcv_saddr,
+					  inet_sk(sk)->inet_num);
+	u16 new_hash4 = udp_ehashfn(sock_net(sk),
+				    sk->sk_rcv_saddr, sk->sk_num,
+				    sk->sk_daddr, sk->sk_dport);
+
+	udp_lib_rehash(sk, new_hash, new_hash4);
+}
+
+static void udp_destroy_sock(struct sock *sk)
+{
+	struct udp_sock *up = udp_sk(sk);
+	bool slow = lock_sock_fast(sk);
+
+	/* protects from races with udp_abort() */
+	sock_set_flag(sk, SOCK_DEAD);
+	udp_flush_pending_frames(sk);
+	unlock_sock_fast(sk, slow);
+	if (static_branch_unlikely(&udp_encap_needed_key)) {
+		if (up->encap_type) {
+			void (*encap_destroy)(struct sock *sk);
+
+			encap_destroy = READ_ONCE(up->encap_destroy);
+			if (encap_destroy)
+				encap_destroy(sk);
+		}
+		if (udp_test_bit(ENCAP_ENABLED, sk)) {
+			static_branch_dec(&udp_encap_needed_key);
+			udp_tunnel_cleanup_gro(sk);
+		}
+	}
+}
+
+/* We can only early demux multicast if there is a single matching socket.
+ * If more than one socket found returns NULL
+ */
+static struct sock *__udp4_lib_mcast_demux_lookup(struct net *net,
+						  __be16 loc_port, __be32 loc_addr,
+						  __be16 rmt_port, __be32 rmt_addr,
+						  int dif, int sdif)
+{
+	struct udp_table *udptable = net->ipv4.udp_table;
+	unsigned short hnum = ntohs(loc_port);
+	struct sock *sk, *result;
+	struct udp_hslot *hslot;
+	unsigned int slot;
+
+	slot = udp_hashfn(net, hnum, udptable->mask);
+	hslot = &udptable->hash[slot];
+
+	/* Do not bother scanning a too big list */
+	if (hslot->count > 10)
+		return NULL;
+
+	result = NULL;
+	sk_for_each_rcu(sk, &hslot->head) {
+		if (__udp_is_mcast_sock(net, sk, loc_port, loc_addr,
+					rmt_port, rmt_addr, dif, sdif, hnum)) {
+			if (result)
+				return NULL;
+			result = sk;
+		}
+	}
+
+	return result;
+}
+
+/* For unicast we should only early demux connected sockets or we can
+ * break forwarding setups.  The chains here can be long so only check
+ * if the first socket is an exact match and if not move on.
+ */
+static struct sock *__udp4_lib_demux_lookup(struct net *net,
+					    __be16 loc_port, __be32 loc_addr,
+					    __be16 rmt_port, __be32 rmt_addr,
+					    int dif, int sdif)
+{
+	struct udp_table *udptable = net->ipv4.udp_table;
+	INET_ADDR_COOKIE(acookie, rmt_addr, loc_addr);
+	unsigned short hnum = ntohs(loc_port);
+	struct udp_hslot *hslot2;
+	unsigned int hash2;
+	__portpair ports;
+	struct sock *sk;
+
+	hash2 = ipv4_portaddr_hash(net, loc_addr, hnum);
+	hslot2 = udp_hashslot2(udptable, hash2);
+	ports = INET_COMBINED_PORTS(rmt_port, hnum);
+
+	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
+		if (inet_match(net, sk, acookie, ports, dif, sdif))
+			return sk;
+		/* Only check first socket in chain */
+		break;
+	}
+	return NULL;
+}
+
+enum skb_drop_reason udp_v4_early_demux(struct sk_buff *skb)
+{
+	struct net *net = dev_net(skb->dev);
+	struct in_device *in_dev = NULL;
+	const struct iphdr *iph;
+	const struct udphdr *uh;
+	struct sock *sk = NULL;
+	struct dst_entry *dst;
+	int dif = skb->dev->ifindex;
+	int sdif = inet_sdif(skb);
+	int ours;
+
+	/* validate the packet */
+	if (!pskb_may_pull(skb, skb_transport_offset(skb) + sizeof(struct udphdr)))
+		return SKB_NOT_DROPPED_YET;
+
+	iph = ip_hdr(skb);
+	uh = udp_hdr(skb);
+
+	if (skb->pkt_type == PACKET_MULTICAST) {
+		in_dev = __in_dev_get_rcu(skb->dev);
+
+		if (!in_dev)
+			return SKB_NOT_DROPPED_YET;
+
+		ours = ip_check_mc_rcu(in_dev, iph->daddr, iph->saddr,
+				       iph->protocol);
+		if (!ours)
+			return SKB_NOT_DROPPED_YET;
+
+		sk = __udp4_lib_mcast_demux_lookup(net, uh->dest, iph->daddr,
+						   uh->source, iph->saddr,
+						   dif, sdif);
+	} else if (skb->pkt_type == PACKET_HOST) {
+		sk = __udp4_lib_demux_lookup(net, uh->dest, iph->daddr,
+					     uh->source, iph->saddr, dif, sdif);
+	}
+
+	if (!sk)
+		return SKB_NOT_DROPPED_YET;
+
+	skb->sk = sk;
+	DEBUG_NET_WARN_ON_ONCE(sk_is_refcounted(sk));
+	skb->destructor = sock_pfree;
+	dst = rcu_dereference(sk->sk_rx_dst);
+
+	if (dst)
+		dst = dst_check(dst, 0);
+	if (dst) {
+		u32 itag = 0;
+
+		/* set noref for now.
+		 * any place which wants to hold dst has to call
+		 * dst_hold_safe()
+		 */
+		skb_dst_set_noref(skb, dst);
+
+		/* for unconnected multicast sockets we need to validate
+		 * the source on each packet
+		 */
+		if (!inet_sk(sk)->inet_daddr && in_dev)
+			return ip_mc_validate_source(skb, iph->daddr,
+						     iph->saddr,
+						     ip4h_dscp(iph),
+						     skb->dev, in_dev, &itag);
+	}
+	return SKB_NOT_DROPPED_YET;
+}
+
+static int udp_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
+			  unsigned int optlen)
+{
+	if (level == SOL_UDP || level == SOL_SOCKET)
+		return udp_lib_setsockopt(sk, level, optname,
+					  optval, optlen,
+					  udp_push_pending_frames);
+	return ip_setsockopt(sk, level, optname, optval, optlen);
+}
+
+static int udp_getsockopt(struct sock *sk, int level, int optname,
+			  char __user *optval, int __user *optlen)
+{
+	sockopt_t opt;
+	int err;
+
+	/*
+	 * keep the old __user pointers, until ip_getsockopt() moves
+	 * to sockopt_t
+	 */
+	if (level != SOL_UDP)
+		return ip_getsockopt(sk, level, optname, optval, optlen);
+
+	err = sockopt_init_user(&opt, optval, optlen);
+	if (err)
+		return err;
+
+	err = udp_lib_getsockopt(sk, level, optname, &opt);
+	if (err)
+		return err;
+
+	/* optval was written by copy_to_iter() in udp_lib_getsockopt() */
+	if (put_user(opt.optlen, optlen))
+		return -EFAULT;
+
+	return 0;
+}
+
+struct proto udp_prot = {
+	.name			= "UDP",
+	.owner			= THIS_MODULE,
+	.close			= udp_lib_close,
+	.pre_connect		= udp_pre_connect,
+	.connect		= udp_connect,
+	.disconnect		= udp_disconnect,
+	.ioctl			= udp_ioctl,
+	.init			= udp_init_sock,
+	.destroy		= udp_destroy_sock,
+	.setsockopt		= udp_setsockopt,
+	.getsockopt		= udp_getsockopt,
+	.sendmsg		= udp_sendmsg,
+	.recvmsg		= udp_recvmsg,
+	.splice_eof		= udp_splice_eof,
+	.release_cb		= ip4_datagram_release_cb,
+	.hash			= udp_lib_hash,
+	.unhash			= udp_lib_unhash,
+	.rehash			= udp_v4_rehash,
+	.get_port		= udp_v4_get_port,
+	.put_port		= udp_lib_unhash,
+#ifdef CONFIG_BPF_SYSCALL
+	.psock_update_sk_prot	= udp_bpf_update_proto,
+#endif
+	.memory_allocated	= &net_aligned_data.udp_memory_allocated,
+	.per_cpu_fw_alloc	= &udp_memory_per_cpu_fw_alloc,
+
+	.sysctl_mem		= sysctl_udp_mem,
+	.sysctl_wmem_offset	= offsetof(struct net, ipv4.sysctl_udp_wmem_min),
+	.sysctl_rmem_offset	= offsetof(struct net, ipv4.sysctl_udp_rmem_min),
+	.obj_size		= sizeof(struct udp_sock),
+	.diag_destroy		= udp_abort,
+};
+EXPORT_SYMBOL(udp_prot);
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 29651b1a0bc7..4da369df0a33 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -848,7 +848,9 @@ struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
 static struct sock *udp4_gro_lookup_skb(struct sk_buff *skb, __be16 sport,
 					__be16 dport)
 {
+#if IS_ENABLED(CONFIG_IPV4)
 	const struct iphdr *iph = skb_gro_network_header(skb);
+#endif
 	struct net *net = dev_net_rcu(skb->dev);
 	struct sock *sk;
 	int iif, sdif;
@@ -859,8 +861,12 @@ static struct sock *udp4_gro_lookup_skb(struct sk_buff *skb, __be16 sport,
 
 	inet_get_iif_sdif(skb, &iif, &sdif);
 
+#if IS_ENABLED(CONFIG_IPV4)
 	return __udp4_lib_lookup(net, iph->saddr, sport,
 				 iph->daddr, dport, iif, sdif, NULL);
+#else
+	return NULL;
+#endif
 }
 
 INDIRECT_CALLABLE_SCOPE
@@ -951,6 +957,7 @@ int udp_gro_complete(struct sk_buff *skb, int nhoff,
 
 INDIRECT_CALLABLE_SCOPE int udp4_gro_complete(struct sk_buff *skb, int nhoff)
 {
+#if IS_ENABLED(CONFIG_IPV4)
 	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
 	const struct iphdr *iph = (struct iphdr *)(skb->data + offset);
 	struct udphdr *uh = (struct udphdr *)(skb->data + nhoff);
@@ -972,6 +979,9 @@ INDIRECT_CALLABLE_SCOPE int udp4_gro_complete(struct sk_buff *skb, int nhoff)
 					  iph->daddr, 0);
 
 	return udp_gro_complete(skb, nhoff, udp4_lib_lookup_skb);
+#else
+	return -EAFNOSUPPORT;
+#endif
 }
 
 int __init udpv4_offload_init(void)
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 392e18b97045..fefaffd981a5 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -326,10 +326,12 @@ static void udp6_hash4(struct sock *sk)
 	struct net *net = sock_net(sk);
 	unsigned int hash;
 
+#if IS_ENABLED(CONFIG_IPV4)
 	if (ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr)) {
 		udp4_hash4(sk);
 		return;
 	}
+#endif
 
 	if (sk_unhashed(sk) || ipv6_addr_any(&sk->sk_v6_rcv_saddr))
 		return;
@@ -466,7 +468,9 @@ int udpv6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 {
 	int off, is_udp4, err, peeking = flags & MSG_PEEK;
 	struct ipv6_pinfo *np = inet6_sk(sk);
+#if IS_ENABLED(CONFIG_IPV4)
 	struct inet_sock *inet = inet_sk(sk);
+#endif
 	struct udp_mib __percpu *mib;
 	bool checksum_valid = false;
 	unsigned int ulen, copied;
@@ -558,9 +562,11 @@ int udpv6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		ip6_datagram_recv_common_ctl(sk, msg, skb);
 
 	if (is_udp4) {
+#if IS_ENABLED(CONFIG_IPV4)
 		if (inet_cmsg_flags(inet))
 			ip_cmsg_recv_offset(msg, sk, skb,
 					    sizeof(struct udphdr), off);
+#endif
 	} else {
 		if (np->rxopt.all)
 			ip6_datagram_recv_specific_ctl(sk, msg, skb);
@@ -1439,7 +1445,11 @@ static int udp_v6_push_pending_frames(struct sock *sk)
 	int err = 0;
 
 	if (up->pending == AF_INET)
+#if IS_ENABLED(CONFIG_IPV4)
 		return udp_push_pending_frames(sk);
+#else
+		return -EAFNOSUPPORT;
+#endif
 
 	skb = ip6_finish_skb(sk);
 	if (!skb)
@@ -1519,8 +1529,12 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 			msg->msg_name = &sin;
 			msg->msg_namelen = sizeof(sin);
 do_udp_sendmsg:
+#if IS_ENABLED(CONFIG_IPV4)
 			err = ipv6_only_sock(sk) ?
 				-ENETUNREACH : udp_sendmsg(sk, msg, len);
+#else
+			err = -ENETUNREACH;
+#endif
 			msg->msg_name = sin6;
 			msg->msg_namelen = addr_len;
 			return err;
@@ -1535,7 +1549,11 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	if (READ_ONCE(up->pending)) {
 		if (READ_ONCE(up->pending) == AF_INET)
+#if IS_ENABLED(CONFIG_IPV4)
 			return udp_sendmsg(sk, msg, len);
+#else
+			return -EAFNOSUPPORT;
+#endif
 		/*
 		 * There are pending frames.
 		 * The socket lock must be held while it's corked.
-- 
2.54.0


