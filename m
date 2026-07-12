Return-Path: <netdev+bounces-306910-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MzYKNS7xUmp7VgMAu9opvQ
	(envelope-from <netdev+bounces-306910-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 03:43:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CAECF7436E4
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 03:43:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iF+94oZi;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="9/k9hWXt";
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iF+94oZi;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="9/k9hWXt";
	dmarc=pass (policy=none) header.from=suse.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306910-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-306910-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 49C723017C97
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 01:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58B02036E9;
	Sun, 12 Jul 2026 01:41:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F49521CA13
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 01:41:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783820483; cv=none; b=qWsaTbGvHjbTZbaM12X8f2p1z0hemFSjleQrErM9ipqwR33BM6AzJrGOhKF4ZEsEXcNqeDBdGK/88UFlMknilNmpcc0VQL8cb0bPQVR86eHqR6TrV2/H+fNrwH78VJCD0VraISQJY8CcLulGA11sCduADA4sJYmSjmtrNMlKeFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783820483; c=relaxed/simple;
	bh=C3N7YvmH/1Akw9biRSc/DjcrORc0Ti6Wza2R/l0u+rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jW2xcTm/+Guk1Lif8UJs3Levu/Fz+K/411qjDyfSi/dCz8v5Pd8AMAD8ZxknbqGA2u4k3DG27yLHz4401oyD+sxmsWttQ1exF0GplFgwC4ezEy0eQMLFLSsiC1pNk2Vu2kNo4ZaiTa3E5V4nPDRnSRX/u94dEzhxXx6/oH/IEGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iF+94oZi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9/k9hWXt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iF+94oZi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9/k9hWXt; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B8C627703C;
	Sun, 12 Jul 2026 01:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783820479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8/ggqluvTdnGD2QeMhn5tOw6uu+Pa33yEONO46C4A0Q=;
	b=iF+94oZiZo0mcyLcx1QLfQ3rxOz4b7j02eKTB2vjq4vNkdYEo6PpgkJzUAeNTi/SGhUZEB
	jUF7efH+bPld5b1yir5uWrqfHOt22zi/KKy1tCU9KsRN6e1Z6o5A12e1jLn8KK0sob7eBH
	uBzPtBP/CfMbW4Nqmk+dTlRBQ3CN64M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783820479;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8/ggqluvTdnGD2QeMhn5tOw6uu+Pa33yEONO46C4A0Q=;
	b=9/k9hWXt6vlor2Rh2/Z5FzeoEhsZhaJfQ7ms35VRk7cdbhOSK8S7KgzG8+bHJGZ5mmwkDt
	zBPkh+tfrsAIwuAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783820479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8/ggqluvTdnGD2QeMhn5tOw6uu+Pa33yEONO46C4A0Q=;
	b=iF+94oZiZo0mcyLcx1QLfQ3rxOz4b7j02eKTB2vjq4vNkdYEo6PpgkJzUAeNTi/SGhUZEB
	jUF7efH+bPld5b1yir5uWrqfHOt22zi/KKy1tCU9KsRN6e1Z6o5A12e1jLn8KK0sob7eBH
	uBzPtBP/CfMbW4Nqmk+dTlRBQ3CN64M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783820479;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8/ggqluvTdnGD2QeMhn5tOw6uu+Pa33yEONO46C4A0Q=;
	b=9/k9hWXt6vlor2Rh2/Z5FzeoEhsZhaJfQ7ms35VRk7cdbhOSK8S7KgzG8+bHJGZ5mmwkDt
	zBPkh+tfrsAIwuAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 83036779B5;
	Sun, 12 Jul 2026 01:41:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kL3qHL7wUmqRegAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sun, 12 Jul 2026 01:41:18 +0000
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
	Eric Biggers <ebiggers@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Julian Anastasov <ja@ssi.bg>,
	Florian Westphal <fw@strlen.de>,
	Yue Haibing <yuehaibing@huawei.com>,
	"yuan.gao" <yuan.gao@ucloud.cn>,
	Jeff Layton <jlayton@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 08/13 RFC net-next] net: ping: split IPv4 specific logic into ping_ipv4.c
Date: Sun, 12 Jul 2026 03:39:06 +0200
Message-ID: <20260712013941.4570-9-fmancera@suse.de>
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
X-Spam-Level: 
X-Spam-Score: -6.80
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306910-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:horms@kernel.org,m:idosch@nvidia.com,m:fmancera@suse.de,m:ebiggers@kernel.org,m:kuniyu@google.com,m:ardb@kernel.org,m:ja@ssi.bg,m:fw@strlen.de,m:yuehaibing@huawei.com,m:yuan.gao@ucloud.cn,m:jlayton@kernel.org,m:gustavoars@kernel.org,m:kees@kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.de:from_mime,suse.de:email,suse.de:mid,suse.de:dkim,vger.kernel.org:from_smtp,echo.id:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CAECF7436E4

To enable compiling INET subsystem withot IPv4, ping socket IPv4
specific functions must be isolated from the generic ping
infrastructure.

This patch creates ping_ipv4.c and move all the functions for packet
transmission, error handling and the AF_INET ping_prot definition from
ping.c to the new file. The Makefile is updated to compile ping_ipv4.c
only when CONFIG_IPV4 is enabled.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/ipv4/Makefile    |   2 +-
 net/ipv4/ping.c      | 215 +++--------------------------------------
 net/ipv4/ping_ipv4.c | 225 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 238 insertions(+), 204 deletions(-)
 create mode 100644 net/ipv4/ping_ipv4.c

diff --git a/net/ipv4/Makefile b/net/ipv4/Makefile
index 651835073a29..83c25f52eb58 100644
--- a/net/ipv4/Makefile
+++ b/net/ipv4/Makefile
@@ -14,7 +14,7 @@ obj-y     := inetpeer.o protocol.o inet_hashtables.o inet_timewait_sock.o \
 obj-$(CONFIG_IPV4) += route.o ip_input.o ip_fragment.o ip_forward.o ip_options.o \
 		      ip_sockglue.o tcp_ipv4.o datagram.o arp.o devinet.o igmp.o \
 		      fib_notifier.o ip_output.o fib_frontend.o fib_semantics.o \
-		      fib_trie.o raw_ipv4.o udp_ipv4.o icmp_ipv4.o
+		      fib_trie.o raw_ipv4.o udp_ipv4.o icmp_ipv4.o ping_ipv4.o
 
 obj-$(CONFIG_NET_IP_TUNNEL) += ip_tunnel.o
 obj-$(CONFIG_SYSCTL) += sysctl_net_ipv4.o
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index d36f1e273fde..31ee56eeac81 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -285,25 +285,13 @@ void ping_close(struct sock *sk, long timeout)
 	sk_common_release(sk);
 }
 
-static int ping_pre_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
-			    int addr_len)
-{
-	/* This check is replicated from __ip4_datagram_connect() and
-	 * intended to prevent BPF program called below from accessing bytes
-	 * that are out of the bound specified by user in addr_len.
-	 */
-	if (addr_len < sizeof(struct sockaddr_in))
-		return -EINVAL;
-
-	return BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr, &addr_len);
-}
-
 /* Checks the bind address and possibly modifies sk->sk_bound_dev_if. */
 static int ping_check_bind_addr(struct sock *sk, struct inet_sock *isk,
 				struct sockaddr_unsized *uaddr, int addr_len)
 {
 	struct net *net = sock_net(sk);
 	if (sk->sk_family == AF_INET) {
+#if IS_ENABLED(CONFIG_IPV4)
 		struct sockaddr_in *addr = (struct sockaddr_in *) uaddr;
 		u32 tb_id = RT_TABLE_LOCAL;
 		int chk_addr_ret;
@@ -331,6 +319,9 @@ static int ping_check_bind_addr(struct sock *sk, struct inet_sock *isk,
 		     !inet_can_nonlocal_bind(net, isk)))
 			return -EADDRNOTAVAIL;
 
+#else
+		return -EAFNOSUPPORT;
+#endif
 #if IS_ENABLED(CONFIG_IPV6)
 	} else if (sk->sk_family == AF_INET6) {
 		struct sockaddr_in6 *addr = (struct sockaddr_in6 *) uaddr;
@@ -528,6 +519,7 @@ void ping_err(struct sk_buff *skb, int offset, u32 info)
 	inet_sock = inet_sk(sk);
 
 	if (skb->protocol == htons(ETH_P_IP)) {
+#if IS_ENABLED(CONFIG_IPV4)
 		switch (type) {
 		default:
 		case ICMP_TIME_EXCEEDED:
@@ -565,6 +557,7 @@ void ping_err(struct sk_buff *skb, int offset, u32 info)
 			err = EREMOTEIO;
 			break;
 		}
+#endif
 #if IS_ENABLED(CONFIG_IPV6)
 	} else if (skb->protocol == htons(ETH_P_IPV6)) {
 		harderr = pingv6_ops.icmpv6_err_convert(type, code, &err);
@@ -581,8 +574,10 @@ void ping_err(struct sk_buff *skb, int offset, u32 info)
 			goto out;
 	} else {
 		if (family == AF_INET) {
+#if IS_ENABLED(CONFIG_IPV4)
 			ip_icmp_error(sk, skb, err, 0 /* no remote port */,
 				      info, (u8 *)icmph);
+#endif
 #if IS_ENABLED(CONFIG_IPV6)
 		} else if (family == AF_INET6) {
 			pingv6_ops.ipv6_icmp_error(sk, skb, err, 0,
@@ -625,21 +620,6 @@ int ping_getfrag(void *from, char *to,
 	return 0;
 }
 
-static int ping_v4_push_pending_frames(struct sock *sk, struct pingfakehdr *pfh,
-				       struct flowi4 *fl4)
-{
-	struct sk_buff *skb = skb_peek(&sk->sk_write_queue);
-
-	if (!skb)
-		return 0;
-	pfh->wcheck = csum_partial((char *)&pfh->icmph,
-		sizeof(struct icmphdr), pfh->wcheck);
-	pfh->icmph.checksum = csum_fold(pfh->wcheck);
-	memcpy(icmp_hdr(skb), &pfh->icmph, sizeof(struct icmphdr));
-	skb->ip_summed = CHECKSUM_NONE;
-	return ip_push_pending_frames(sk, fl4);
-}
-
 int ping_common_sendmsg(int family, struct msghdr *msg, size_t len,
 			void *user_icmph, size_t icmph_len)
 {
@@ -685,160 +665,6 @@ int ping_common_sendmsg(int family, struct msghdr *msg, size_t len,
 	return 0;
 }
 
-static int ping_v4_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
-{
-	DEFINE_RAW_FLEX(struct ip_options_rcu, opt_copy, opt.__data,
-			IP_OPTIONS_DATA_FIXED_SIZE);
-	struct net *net = sock_net(sk);
-	struct flowi4 fl4;
-	struct inet_sock *inet = inet_sk(sk);
-	struct ipcm_cookie ipc;
-	struct icmphdr user_icmph;
-	struct pingfakehdr pfh;
-	struct rtable *rt = NULL;
-	int free = 0;
-	__be32 saddr, daddr, faddr;
-	u8 scope;
-	int err;
-
-	pr_debug("ping_v4_sendmsg(sk=%p,sk->num=%u)\n", inet, inet->inet_num);
-
-	err = ping_common_sendmsg(AF_INET, msg, len, &user_icmph,
-				  sizeof(user_icmph));
-	if (err)
-		return err;
-
-	/*
-	 *	Get and verify the address.
-	 */
-
-	if (msg->msg_name) {
-		DECLARE_SOCKADDR(struct sockaddr_in *, usin, msg->msg_name);
-		if (msg->msg_namelen < sizeof(*usin))
-			return -EINVAL;
-		if (usin->sin_family != AF_INET)
-			return -EAFNOSUPPORT;
-		daddr = usin->sin_addr.s_addr;
-		/* no remote port */
-	} else {
-		if (sk->sk_state != TCP_ESTABLISHED)
-			return -EDESTADDRREQ;
-		daddr = inet->inet_daddr;
-		/* no remote port */
-	}
-
-	ipcm_init_sk(&ipc, inet);
-
-	if (msg->msg_controllen) {
-		err = ip_cmsg_send(sk, msg, &ipc, false);
-		if (unlikely(err)) {
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
-	saddr = ipc.addr;
-	ipc.addr = faddr = daddr;
-
-	if (ipc.opt && ipc.opt->opt.srr) {
-		if (!daddr) {
-			err = -EINVAL;
-			goto out_free;
-		}
-		faddr = ipc.opt->opt.faddr;
-	}
-	scope = ip_sendmsg_scope(inet, &ipc, msg);
-
-	if (ipv4_is_multicast(daddr)) {
-		if (!ipc.oif || netif_index_is_l3_master(sock_net(sk), ipc.oif))
-			ipc.oif = READ_ONCE(inet->mc_index);
-		if (!saddr)
-			saddr = READ_ONCE(inet->mc_addr);
-	} else if (!ipc.oif)
-		ipc.oif = READ_ONCE(inet->uc_index);
-
-	flowi4_init_output(&fl4, ipc.oif, ipc.sockc.mark,
-			   ipc.tos & INET_DSCP_MASK, scope,
-			   sk->sk_protocol, inet_sk_flowi_flags(sk), faddr,
-			   saddr, 0, 0, sk_uid(sk));
-
-	fl4.fl4_icmp_type = user_icmph.type;
-	fl4.fl4_icmp_code = user_icmph.code;
-
-	security_sk_classify_flow(sk, flowi4_to_flowi_common(&fl4));
-	rt = ip_route_output_flow(net, &fl4, sk);
-	if (IS_ERR(rt)) {
-		err = PTR_ERR(rt);
-		rt = NULL;
-		if (err == -ENETUNREACH)
-			IP_INC_STATS(net, IPSTATS_MIB_OUTNOROUTES);
-		goto out;
-	}
-
-	err = -EACCES;
-	if ((rt->rt_flags & RTCF_BROADCAST) &&
-	    !sock_flag(sk, SOCK_BROADCAST))
-		goto out;
-
-	if (msg->msg_flags & MSG_CONFIRM)
-		goto do_confirm;
-back_from_confirm:
-
-	if (!ipc.addr)
-		ipc.addr = fl4.daddr;
-
-	lock_sock(sk);
-
-	pfh.icmph.type = user_icmph.type; /* already checked */
-	pfh.icmph.code = user_icmph.code; /* ditto */
-	pfh.icmph.checksum = 0;
-	pfh.icmph.un.echo.id = inet->inet_sport;
-	pfh.icmph.un.echo.sequence = user_icmph.un.echo.sequence;
-	pfh.msg = msg;
-	pfh.wcheck = 0;
-	pfh.family = AF_INET;
-
-	err = ip_append_data(sk, &fl4, ping_getfrag, &pfh, len,
-			     sizeof(struct icmphdr), &ipc, &rt,
-			     msg->msg_flags);
-	if (err)
-		ip_flush_pending_frames(sk);
-	else
-		err = ping_v4_push_pending_frames(sk, &pfh, &fl4);
-	release_sock(sk);
-
-out:
-	ip_rt_put(rt);
-out_free:
-	if (free)
-		kfree(ipc.opt);
-	if (!err)
-		return len;
-	return err;
-
-do_confirm:
-	if (msg->msg_flags & MSG_PROBE)
-		dst_confirm_neigh(&rt->dst, &fl4.daddr);
-	if (!(msg->msg_flags & MSG_PROBE) || len)
-		goto back_from_confirm;
-	err = 0;
-	goto out;
-}
-
 int ping_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags)
 {
 	struct inet_sock *isk = inet_sk(sk);
@@ -875,6 +701,7 @@ int ping_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags)
 
 	/* Copy the address and add cmsg data. */
 	if (family == AF_INET) {
+#if IS_ENABLED(CONFIG_IPV4)
 		DECLARE_SOCKADDR(struct sockaddr_in *, sin, msg->msg_name);
 
 		if (sin) {
@@ -888,6 +715,7 @@ int ping_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags)
 		if (inet_cmsg_flags(isk))
 			ip_cmsg_recv(msg, skb);
 
+#endif
 #if IS_ENABLED(CONFIG_IPV6)
 	} else if (family == AF_INET6) {
 		struct ipv6hdr *ip6 = ipv6_hdr(skb);
@@ -911,9 +739,11 @@ int ping_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags)
 		if (skb->protocol == htons(ETH_P_IPV6) &&
 		    inet6_sk(sk)->rxopt.all)
 			pingv6_ops.ip6_datagram_recv_specific_ctl(sk, msg, skb);
+#if IS_ENABLED(CONFIG_IPV4)
 		else if (skb->protocol == htons(ETH_P_IP) &&
 			 inet_cmsg_flags(isk))
 			ip_cmsg_recv(msg, skb);
+#endif
 #endif
 	} else {
 		BUG();
@@ -976,27 +806,6 @@ enum skb_drop_reason ping_rcv(struct sk_buff *skb)
 	return SKB_DROP_REASON_NO_SOCKET;
 }
 
-struct proto ping_prot = {
-	.name =		"PING",
-	.owner =	THIS_MODULE,
-	.init =		ping_init_sock,
-	.close =	ping_close,
-	.pre_connect =	ping_pre_connect,
-	.connect =	ip4_datagram_connect,
-	.disconnect =	__udp_disconnect,
-	.setsockopt =	ip_setsockopt,
-	.getsockopt =	ip_getsockopt,
-	.sendmsg =	ping_v4_sendmsg,
-	.recvmsg =	ping_recvmsg,
-	.bind =		ping_bind,
-	.backlog_rcv =	ping_queue_rcv_skb,
-	.release_cb =	ip4_datagram_release_cb,
-	.unhash =	ping_unhash,
-	.get_port =	ping_get_port,
-	.put_port =	ping_unhash,
-	.obj_size =	sizeof(struct inet_sock),
-};
-
 #ifdef CONFIG_PROC_FS
 
 static struct sock *ping_get_first(struct seq_file *seq, int start)
diff --git a/net/ipv4/ping_ipv4.c b/net/ipv4/ping_ipv4.c
new file mode 100644
index 000000000000..09fc1d85846d
--- /dev/null
+++ b/net/ipv4/ping_ipv4.c
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * INET		An implementation of the TCP/IP protocol suite for the LINUX
+ *		operating system.  INET is implemented using the  BSD Socket
+ *		interface as the means of communication with the user level.
+ *
+ *		"Ping" sockets
+ *
+ *		IPv4 specific functions
+ *
+ *		code split from:
+ *		net/ipv4/ping.c
+ *
+ *		See ping.c for author information
+ */
+
+#include <linux/bpf-cgroup.h>
+#include <linux/in.h>
+#include <linux/socket.h>
+#include <linux/types.h>
+#include <net/ping.h>
+#include <net/udp.h>
+
+static int ping_pre_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
+			    int addr_len)
+{
+	/* This check is replicated from __ip4_datagram_connect() and
+	 * intended to prevent BPF program called below from accessing bytes
+	 * that are out of the bound specified by user in addr_len.
+	 */
+	if (addr_len < sizeof(struct sockaddr_in))
+		return -EINVAL;
+
+	return BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr, &addr_len);
+}
+
+static int ping_v4_push_pending_frames(struct sock *sk, struct pingfakehdr *pfh,
+				       struct flowi4 *fl4)
+{
+	struct sk_buff *skb = skb_peek(&sk->sk_write_queue);
+
+	if (!skb)
+		return 0;
+	pfh->wcheck = csum_partial((char *)&pfh->icmph,
+		sizeof(struct icmphdr), pfh->wcheck);
+	pfh->icmph.checksum = csum_fold(pfh->wcheck);
+	memcpy(icmp_hdr(skb), &pfh->icmph, sizeof(struct icmphdr));
+	skb->ip_summed = CHECKSUM_NONE;
+	return ip_push_pending_frames(sk, fl4);
+}
+
+static int ping_v4_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
+{
+	DEFINE_RAW_FLEX(struct ip_options_rcu, opt_copy, opt.__data,
+			IP_OPTIONS_DATA_FIXED_SIZE);
+	struct net *net = sock_net(sk);
+	struct flowi4 fl4;
+	struct inet_sock *inet = inet_sk(sk);
+	struct ipcm_cookie ipc;
+	struct icmphdr user_icmph;
+	struct pingfakehdr pfh;
+	struct rtable *rt = NULL;
+	int free = 0;
+	__be32 saddr, daddr, faddr;
+	u8 scope;
+	int err;
+
+	pr_debug("ping_v4_sendmsg(sk=%p,sk->num=%u)\n", inet, inet->inet_num);
+
+	err = ping_common_sendmsg(AF_INET, msg, len, &user_icmph,
+				  sizeof(user_icmph));
+	if (err)
+		return err;
+
+	/*
+	 *	Get and verify the address.
+	 */
+
+	if (msg->msg_name) {
+		DECLARE_SOCKADDR(struct sockaddr_in *, usin, msg->msg_name);
+		if (msg->msg_namelen < sizeof(*usin))
+			return -EINVAL;
+		if (usin->sin_family != AF_INET)
+			return -EAFNOSUPPORT;
+		daddr = usin->sin_addr.s_addr;
+		/* no remote port */
+	} else {
+		if (sk->sk_state != TCP_ESTABLISHED)
+			return -EDESTADDRREQ;
+		daddr = inet->inet_daddr;
+		/* no remote port */
+	}
+
+	ipcm_init_sk(&ipc, inet);
+
+	if (msg->msg_controllen) {
+		err = ip_cmsg_send(sk, msg, &ipc, false);
+		if (unlikely(err)) {
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
+	saddr = ipc.addr;
+	ipc.addr = faddr = daddr;
+
+	if (ipc.opt && ipc.opt->opt.srr) {
+		if (!daddr) {
+			err = -EINVAL;
+			goto out_free;
+		}
+		faddr = ipc.opt->opt.faddr;
+	}
+	scope = ip_sendmsg_scope(inet, &ipc, msg);
+
+	if (ipv4_is_multicast(daddr)) {
+		if (!ipc.oif || netif_index_is_l3_master(sock_net(sk), ipc.oif))
+			ipc.oif = READ_ONCE(inet->mc_index);
+		if (!saddr)
+			saddr = READ_ONCE(inet->mc_addr);
+	} else if (!ipc.oif)
+		ipc.oif = READ_ONCE(inet->uc_index);
+
+	flowi4_init_output(&fl4, ipc.oif, ipc.sockc.mark,
+			   ipc.tos & INET_DSCP_MASK, scope,
+			   sk->sk_protocol, inet_sk_flowi_flags(sk), faddr,
+			   saddr, 0, 0, sk_uid(sk));
+
+	fl4.fl4_icmp_type = user_icmph.type;
+	fl4.fl4_icmp_code = user_icmph.code;
+
+	security_sk_classify_flow(sk, flowi4_to_flowi_common(&fl4));
+	rt = ip_route_output_flow(net, &fl4, sk);
+	if (IS_ERR(rt)) {
+		err = PTR_ERR(rt);
+		rt = NULL;
+		if (err == -ENETUNREACH)
+			IP_INC_STATS(net, IPSTATS_MIB_OUTNOROUTES);
+		goto out;
+	}
+
+	err = -EACCES;
+	if ((rt->rt_flags & RTCF_BROADCAST) &&
+	    !sock_flag(sk, SOCK_BROADCAST))
+		goto out;
+
+	if (msg->msg_flags & MSG_CONFIRM)
+		goto do_confirm;
+back_from_confirm:
+
+	if (!ipc.addr)
+		ipc.addr = fl4.daddr;
+
+	lock_sock(sk);
+
+	pfh.icmph.type = user_icmph.type; /* already checked */
+	pfh.icmph.code = user_icmph.code; /* ditto */
+	pfh.icmph.checksum = 0;
+	pfh.icmph.un.echo.id = inet->inet_sport;
+	pfh.icmph.un.echo.sequence = user_icmph.un.echo.sequence;
+	pfh.msg = msg;
+	pfh.wcheck = 0;
+	pfh.family = AF_INET;
+
+	err = ip_append_data(sk, &fl4, ping_getfrag, &pfh, len,
+			     sizeof(struct icmphdr), &ipc, &rt,
+			     msg->msg_flags);
+	if (err)
+		ip_flush_pending_frames(sk);
+	else
+		err = ping_v4_push_pending_frames(sk, &pfh, &fl4);
+	release_sock(sk);
+
+out:
+	ip_rt_put(rt);
+out_free:
+	if (free)
+		kfree(ipc.opt);
+	if (!err)
+		return len;
+	return err;
+
+do_confirm:
+	if (msg->msg_flags & MSG_PROBE)
+		dst_confirm_neigh(&rt->dst, &fl4.daddr);
+	if (!(msg->msg_flags & MSG_PROBE) || len)
+		goto back_from_confirm;
+	err = 0;
+	goto out;
+}
+
+struct proto ping_prot = {
+	.name =		"PING",
+	.owner =	THIS_MODULE,
+	.init =		ping_init_sock,
+	.close =	ping_close,
+	.pre_connect =	ping_pre_connect,
+	.connect =	ip4_datagram_connect,
+	.disconnect =	__udp_disconnect,
+	.setsockopt =	ip_setsockopt,
+	.getsockopt =	ip_getsockopt,
+	.sendmsg =	ping_v4_sendmsg,
+	.recvmsg =	ping_recvmsg,
+	.bind =		ping_bind,
+	.backlog_rcv =	ping_queue_rcv_skb,
+	.release_cb =	ip4_datagram_release_cb,
+	.unhash =	ping_unhash,
+	.get_port =	ping_get_port,
+	.put_port =	ping_unhash,
+	.obj_size =	sizeof(struct inet_sock),
+};
-- 
2.54.0


