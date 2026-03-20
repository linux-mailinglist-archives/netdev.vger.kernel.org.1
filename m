Return-Path: <netdev+bounces-270026-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEn8EyiZvWmR/QIAu9opvQ
	(envelope-from <netdev+bounces-270026-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:59:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FBF2DFA2C
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC5C9310A07E
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EE43D3319;
	Fri, 20 Mar 2026 18:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qgIrw0qY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fCjRyWK3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qgIrw0qY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fCjRyWK3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E9D3E8699
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 18:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774033083; cv=none; b=QfcHlmuR3SAGi6EPU/lYaUu1EBakSSiL49P4tXLNDnQZfGgZlOLOZp2e5kV0O4vNeFqimYmnjhzX9O8piIPrg9Z3Hm7BcjniXPP9lfuGQ9SvInl4X5zTmMwydh/YYjD4EOVYsIRwZWu+axERr2HvE7Bgrd+9oBUA6r1Rvxa9duM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774033083; c=relaxed/simple;
	bh=QJJhBEjRvEB7JqeTPiYyjnPkOKGOS38OE2pIdih5K9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RIJpzWOsK1rHEN0XzSPi5eS/4vv70nVgiDhhzUtWrRcoUUpWEc/91ETD1z+AzOBGK0CRWx0m5T4gr4Sy16JXIFdV9Jn3YPOi5N5pfYpYJwKzlEbMFYaBMLweYyup7GBLvt4mgp7kA4rCuEgHmrUpyaeYqNDyd5t8HSCgOdl/jXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qgIrw0qY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fCjRyWK3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qgIrw0qY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fCjRyWK3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C7D115BE11;
	Fri, 20 Mar 2026 18:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774033077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PDFsD5T6oOjFyBLLrjE6DvntXOHpM4QdDstd+4Nb+qM=;
	b=qgIrw0qY9L2y/mFUGsTpo4LB3KYEulBEzGTcauXv4sO8QAsUANPesHg8M6wycq3vHfpbFT
	vzidIZrhKBKmqfMvHYrGEdyaUujnYNsYR3uXnExCN2/VMlhaCnE1Rp82ZXAKZFhwrlOG/4
	rH85RF+VlLWW+Z8hc5jly6AOZpVus3M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774033077;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PDFsD5T6oOjFyBLLrjE6DvntXOHpM4QdDstd+4Nb+qM=;
	b=fCjRyWK3GvEIwR3oYXlkCNB3wiK89Zeqe8PIOXdfk3RqRFr/v9mfAy8+KlchN3Bd7c5JgF
	kTmR7sMEcOuKkoCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774033077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PDFsD5T6oOjFyBLLrjE6DvntXOHpM4QdDstd+4Nb+qM=;
	b=qgIrw0qY9L2y/mFUGsTpo4LB3KYEulBEzGTcauXv4sO8QAsUANPesHg8M6wycq3vHfpbFT
	vzidIZrhKBKmqfMvHYrGEdyaUujnYNsYR3uXnExCN2/VMlhaCnE1Rp82ZXAKZFhwrlOG/4
	rH85RF+VlLWW+Z8hc5jly6AOZpVus3M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774033077;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PDFsD5T6oOjFyBLLrjE6DvntXOHpM4QdDstd+4Nb+qM=;
	b=fCjRyWK3GvEIwR3oYXlkCNB3wiK89Zeqe8PIOXdfk3RqRFr/v9mfAy8+KlchN3Bd7c5JgF
	kTmR7sMEcOuKkoCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56A8842953;
	Fri, 20 Mar 2026 18:57:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UE/REbSYvWnyTgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 20 Mar 2026 18:57:56 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: Fernando Fernandez Mancera <fmancera@suse.de>,
	=?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Breno Leitao <leitao@debian.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 02/11 net-next v4] net: remove EXPORT_IPV6_MOD() and EXPORT_IPV6_MOD_GPL() macros
Date: Fri, 20 Mar 2026 19:55:54 +0100
Message-ID: <20260320185649.5411-3-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260320185649.5411-1-fmancera@suse.de>
References: <20260320185649.5411-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -5.80
X-Spam-Level: 
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.de,suse.com,davemloft.net,kernel.org,google.com,redhat.com,gmail.com,fomichev.me,nvidia.com,debian.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270026-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[23];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B9FBF2DFA2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As IPv6 is built-in only, the macro is always evaluating to an empty
one. Remove it completely from the code.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
Tested-by: Ricardo B. Marlière <rbm@suse.com>
---
 include/net/ip.h                |  8 --------
 net/core/dev.c                  |  3 ---
 net/core/hotdata.c              |  1 -
 net/core/neighbour.c            |  1 -
 net/ipv4/inet_connection_sock.c |  2 --
 net/ipv4/inet_hashtables.c      |  5 -----
 net/ipv4/inetpeer.c             |  4 ----
 net/ipv4/metrics.c              |  1 -
 net/ipv4/ping.c                 | 16 ----------------
 net/ipv4/syncookies.c           |  4 ----
 net/ipv4/tcp.c                  | 23 -----------------------
 net/ipv4/tcp_fastopen.c         |  1 -
 net/ipv4/tcp_input.c            |  7 -------
 net/ipv4/tcp_ipv4.c             | 21 ---------------------
 net/ipv4/tcp_minisocks.c        |  4 ----
 net/ipv4/tcp_output.c           |  6 ------
 net/ipv4/tcp_timer.c            |  1 -
 net/ipv4/udp.c                  | 29 -----------------------------
 net/psp/psp_sock.c              |  1 -
 19 files changed, 138 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index f39a3787fedd..7f2fe1a8401b 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -692,14 +692,6 @@ static __inline__ void inet_reset_saddr(struct sock *sk)
 
 #endif
 
-#if IS_MODULE(CONFIG_IPV6)
-#define EXPORT_IPV6_MOD(X) EXPORT_SYMBOL(X)
-#define EXPORT_IPV6_MOD_GPL(X) EXPORT_SYMBOL_GPL(X)
-#else
-#define EXPORT_IPV6_MOD(X)
-#define EXPORT_IPV6_MOD_GPL(X)
-#endif
-
 static inline unsigned int ipv4_addr_hash(__be32 ip)
 {
 	return (__force unsigned int) ip;
diff --git a/net/core/dev.c b/net/core/dev.c
index 200d44883fc1..f2c1c7007c6b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1182,7 +1182,6 @@ void netdev_copy_name(struct net_device *dev, char *name)
 		strscpy(name, dev->name, IFNAMSIZ);
 	} while (read_seqretry(&netdev_rename_lock, seq));
 }
-EXPORT_IPV6_MOD_GPL(netdev_copy_name);
 
 /**
  *	netdev_get_name - get a netdevice name, knowing its ifindex.
@@ -1312,7 +1311,6 @@ struct net_device *netdev_get_by_flags_rcu(struct net *net, netdevice_tracker *t
 
 	return NULL;
 }
-EXPORT_IPV6_MOD(netdev_get_by_flags_rcu);
 
 /**
  *	dev_valid_name - check if name is okay for network device
@@ -1838,7 +1836,6 @@ void netif_disable_lro(struct net_device *dev)
 		netdev_unlock_ops(lower_dev);
 	}
 }
-EXPORT_IPV6_MOD(netif_disable_lro);
 
 /**
  *	dev_disable_gro_hw - disable HW Generic Receive Offload on a device
diff --git a/net/core/hotdata.c b/net/core/hotdata.c
index a6db36580817..b0f51a726a3d 100644
--- a/net/core/hotdata.c
+++ b/net/core/hotdata.c
@@ -27,4 +27,3 @@ struct net_hotdata net_hotdata __cacheline_aligned = {
 EXPORT_SYMBOL(net_hotdata);
 
 struct net_aligned_data net_aligned_data;
-EXPORT_IPV6_MOD(net_aligned_data);
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index c56a4e7bf790..9e12524b67fa 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -778,7 +778,6 @@ struct pneigh_entry *pneigh_lookup(struct neigh_table *tbl,
 
 	return NULL;
 }
-EXPORT_IPV6_MOD(pneigh_lookup);
 
 int pneigh_create(struct neigh_table *tbl, struct net *net,
 		  const void *pkey, struct net_device *dev,
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 26e2e792916c..308df5bb4479 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -723,7 +723,6 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
 	arg->err = error;
 	return NULL;
 }
-EXPORT_IPV6_MOD(inet_csk_accept);
 
 /*
  * Using different timers for retransmit, delayed acks and probes
@@ -1035,7 +1034,6 @@ void inet_csk_reqsk_queue_drop_and_put(struct sock *sk, struct request_sock *req
 	inet_csk_reqsk_queue_drop(sk, req);
 	reqsk_put(req);
 }
-EXPORT_IPV6_MOD(inet_csk_reqsk_queue_drop_and_put);
 
 static void reqsk_timer_handler(struct timer_list *t)
 {
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 13310c72b0bf..3e795547b40c 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -758,7 +758,6 @@ bool inet_ehash_nolisten(struct sock *sk, struct sock *osk, bool *found_dup_sk)
 	}
 	return ok;
 }
-EXPORT_IPV6_MOD(inet_ehash_nolisten);
 
 static int inet_reuseport_add_sock(struct sock *sk,
 				   struct inet_listen_hashbucket *ilb)
@@ -826,7 +825,6 @@ int inet_hash(struct sock *sk)
 
 	return err;
 }
-EXPORT_IPV6_MOD(inet_hash);
 
 void inet_unhash(struct sock *sk)
 {
@@ -859,7 +857,6 @@ void inet_unhash(struct sock *sk)
 		spin_unlock_bh(lock);
 	}
 }
-EXPORT_IPV6_MOD(inet_unhash);
 
 static bool inet_bind2_bucket_match(const struct inet_bind2_bucket *tb,
 				    const struct net *net, unsigned short port,
@@ -1022,14 +1019,12 @@ int inet_bhash2_update_saddr(struct sock *sk, void *saddr, int family)
 {
 	return __inet_bhash2_update_saddr(sk, saddr, family, false);
 }
-EXPORT_IPV6_MOD(inet_bhash2_update_saddr);
 
 void inet_bhash2_reset_saddr(struct sock *sk)
 {
 	if (!(sk->sk_userlocks & SOCK_BINDADDR_LOCK))
 		__inet_bhash2_update_saddr(sk, NULL, 0, true);
 }
-EXPORT_IPV6_MOD(inet_bhash2_reset_saddr);
 
 /* RFC 6056 3.3.4.  Algorithm 4: Double-Hash Port Selection Algorithm
  * Note that we use 32bit integers (vs RFC 'short integers')
diff --git a/net/ipv4/inetpeer.c b/net/ipv4/inetpeer.c
index 9fa396d5f09f..d8083b9033c2 100644
--- a/net/ipv4/inetpeer.c
+++ b/net/ipv4/inetpeer.c
@@ -59,7 +59,6 @@ void inet_peer_base_init(struct inet_peer_base *bp)
 	seqlock_init(&bp->lock);
 	bp->total = 0;
 }
-EXPORT_IPV6_MOD_GPL(inet_peer_base_init);
 
 #define PEER_MAX_GC 32
 
@@ -217,7 +216,6 @@ struct inet_peer *inet_getpeer(struct inet_peer_base *base,
 
 	return p;
 }
-EXPORT_IPV6_MOD_GPL(inet_getpeer);
 
 void inet_putpeer(struct inet_peer *p)
 {
@@ -268,7 +266,6 @@ bool inet_peer_xrlim_allow(struct inet_peer *peer, int timeout)
 		WRITE_ONCE(peer->rate_tokens, token);
 	return rc;
 }
-EXPORT_IPV6_MOD(inet_peer_xrlim_allow);
 
 void inetpeer_invalidate_tree(struct inet_peer_base *base)
 {
@@ -285,4 +282,3 @@ void inetpeer_invalidate_tree(struct inet_peer_base *base)
 
 	base->total = 0;
 }
-EXPORT_IPV6_MOD(inetpeer_invalidate_tree);
diff --git a/net/ipv4/metrics.c b/net/ipv4/metrics.c
index c1463add48c4..ad40762a8b38 100644
--- a/net/ipv4/metrics.c
+++ b/net/ipv4/metrics.c
@@ -88,4 +88,3 @@ struct dst_metrics *ip_fib_metrics_init(struct nlattr *fc_mx,
 
 	return fib_metrics;
 }
-EXPORT_IPV6_MOD_GPL(ip_fib_metrics_init);
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index 92ab0e0f6f71..bda245c80893 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -56,7 +56,6 @@ struct ping_table {
 
 static struct ping_table ping_table;
 struct pingv6_ops pingv6_ops;
-EXPORT_IPV6_MOD_GPL(pingv6_ops);
 
 static inline u32 ping_hashfn(const struct net *net, u32 num, u32 mask)
 {
@@ -139,7 +138,6 @@ int ping_get_port(struct sock *sk, unsigned short ident)
 	spin_unlock(&ping_table.lock);
 	return -EADDRINUSE;
 }
-EXPORT_IPV6_MOD_GPL(ping_get_port);
 
 void ping_unhash(struct sock *sk)
 {
@@ -154,7 +152,6 @@ void ping_unhash(struct sock *sk)
 	}
 	spin_unlock(&ping_table.lock);
 }
-EXPORT_IPV6_MOD_GPL(ping_unhash);
 
 /* Called under rcu_read_lock() */
 static struct sock *ping_lookup(struct net *net, struct sk_buff *skb, u16 ident)
@@ -278,7 +275,6 @@ int ping_init_sock(struct sock *sk)
 	put_group_info(group_info);
 	return ret;
 }
-EXPORT_IPV6_MOD_GPL(ping_init_sock);
 
 void ping_close(struct sock *sk, long timeout)
 {
@@ -288,7 +284,6 @@ void ping_close(struct sock *sk, long timeout)
 
 	sk_common_release(sk);
 }
-EXPORT_IPV6_MOD_GPL(ping_close);
 
 static int ping_pre_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 			    int addr_len)
@@ -468,7 +463,6 @@ int ping_bind(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len)
 	pr_debug("ping_v4_bind -> %d\n", err);
 	return err;
 }
-EXPORT_IPV6_MOD_GPL(ping_bind);
 
 /*
  * Is this a supported type of ICMP message?
@@ -601,7 +595,6 @@ void ping_err(struct sk_buff *skb, int offset, u32 info)
 out:
 	return;
 }
-EXPORT_IPV6_MOD_GPL(ping_err);
 
 /*
  *	Copy and checksum an ICMP Echo packet from user space into a buffer
@@ -631,7 +624,6 @@ int ping_getfrag(void *from, char *to,
 
 	return 0;
 }
-EXPORT_IPV6_MOD_GPL(ping_getfrag);
 
 static int ping_v4_push_pending_frames(struct sock *sk, struct pingfakehdr *pfh,
 				       struct flowi4 *fl4)
@@ -692,7 +684,6 @@ int ping_common_sendmsg(int family, struct msghdr *msg, size_t len,
 
 	return 0;
 }
-EXPORT_IPV6_MOD_GPL(ping_common_sendmsg);
 
 static int ping_v4_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
@@ -936,7 +927,6 @@ int ping_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags)
 	pr_debug("ping_recvmsg -> %d\n", err);
 	return err;
 }
-EXPORT_IPV6_MOD_GPL(ping_recvmsg);
 
 static enum skb_drop_reason __ping_queue_rcv_skb(struct sock *sk,
 						 struct sk_buff *skb)
@@ -957,7 +947,6 @@ int ping_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
 	return __ping_queue_rcv_skb(sk, skb) ? -1 : 0;
 }
-EXPORT_IPV6_MOD_GPL(ping_queue_rcv_skb);
 
 
 /*
@@ -985,7 +974,6 @@ enum skb_drop_reason ping_rcv(struct sk_buff *skb)
 	kfree_skb_reason(skb, SKB_DROP_REASON_NO_SOCKET);
 	return SKB_DROP_REASON_NO_SOCKET;
 }
-EXPORT_IPV6_MOD_GPL(ping_rcv);
 
 struct proto ping_prot = {
 	.name =		"PING",
@@ -1007,7 +995,6 @@ struct proto ping_prot = {
 	.put_port =	ping_unhash,
 	.obj_size =	sizeof(struct inet_sock),
 };
-EXPORT_IPV6_MOD(ping_prot);
 
 #ifdef CONFIG_PROC_FS
 
@@ -1072,7 +1059,6 @@ void *ping_seq_start(struct seq_file *seq, loff_t *pos, sa_family_t family)
 
 	return *pos ? ping_get_idx(seq, *pos-1) : SEQ_START_TOKEN;
 }
-EXPORT_IPV6_MOD_GPL(ping_seq_start);
 
 static void *ping_v4_seq_start(struct seq_file *seq, loff_t *pos)
 {
@@ -1091,14 +1077,12 @@ void *ping_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	++*pos;
 	return sk;
 }
-EXPORT_IPV6_MOD_GPL(ping_seq_next);
 
 void ping_seq_stop(struct seq_file *seq, void *v)
 	__releases(ping_table.lock)
 {
 	spin_unlock(&ping_table.lock);
 }
-EXPORT_IPV6_MOD_GPL(ping_seq_stop);
 
 static void ping_v4_format_sock(struct sock *sp, struct seq_file *f,
 		int bucket)
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index fc3affd9c801..f1474598d2c8 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -223,7 +223,6 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, struct sk_buff *skb,
 
 	return NULL;
 }
-EXPORT_IPV6_MOD(tcp_get_cookie_sock);
 
 /*
  * when syncookies are in effect and tcp timestamps are enabled we stored
@@ -260,7 +259,6 @@ bool cookie_timestamp_decode(const struct net *net,
 
 	return READ_ONCE(net->ipv4.sysctl_tcp_window_scaling) != 0;
 }
-EXPORT_IPV6_MOD(cookie_timestamp_decode);
 
 static int cookie_tcp_reqsk_init(struct sock *sk, struct sk_buff *skb,
 				 struct request_sock *req)
@@ -312,7 +310,6 @@ struct request_sock *cookie_bpf_check(struct sock *sk, struct sk_buff *skb)
 
 	return req;
 }
-EXPORT_IPV6_MOD_GPL(cookie_bpf_check);
 #endif
 
 struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
@@ -353,7 +350,6 @@ struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
 
 	return req;
 }
-EXPORT_IPV6_MOD_GPL(cookie_tcp_reqsk_alloc);
 
 static struct request_sock *cookie_tcp_check(struct net *net, struct sock *sk,
 					     struct sk_buff *skb)
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 516087c622ad..bd2c3c4587e1 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -303,7 +303,6 @@ DEFINE_PER_CPU(u32, tcp_tw_isn);
 EXPORT_PER_CPU_SYMBOL_GPL(tcp_tw_isn);
 
 long sysctl_tcp_mem[3] __read_mostly;
-EXPORT_IPV6_MOD(sysctl_tcp_mem);
 
 DEFINE_PER_CPU(int, tcp_memory_per_cpu_fw_alloc);
 EXPORT_PER_CPU_SYMBOL_GPL(tcp_memory_per_cpu_fw_alloc);
@@ -317,7 +316,6 @@ EXPORT_SYMBOL(tcp_have_smc);
  * Current number of TCP sockets.
  */
 struct percpu_counter tcp_sockets_allocated ____cacheline_aligned_in_smp;
-EXPORT_IPV6_MOD(tcp_sockets_allocated);
 
 /*
  * Pressure flag: try to collapse.
@@ -341,7 +339,6 @@ void tcp_enter_memory_pressure(struct sock *sk)
 	if (!cmpxchg(&tcp_memory_pressure, 0, val))
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMEMORYPRESSURES);
 }
-EXPORT_IPV6_MOD_GPL(tcp_enter_memory_pressure);
 
 void tcp_leave_memory_pressure(struct sock *sk)
 {
@@ -354,7 +351,6 @@ void tcp_leave_memory_pressure(struct sock *sk)
 		NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPMEMORYPRESSURESCHRONO,
 			      jiffies_to_msecs(jiffies - val));
 }
-EXPORT_IPV6_MOD_GPL(tcp_leave_memory_pressure);
 
 /* Convert seconds to retransmits based on initial and max timeout */
 static u8 secs_to_retrans(int seconds, int timeout, int rto_max)
@@ -418,7 +414,6 @@ void tcp_md5_destruct_sock(struct sock *sk)
 		static_branch_slow_dec_deferred(&tcp_md5_needed);
 	}
 }
-EXPORT_IPV6_MOD_GPL(tcp_md5_destruct_sock);
 #endif
 
 /* Address-family independent initialization for a tcp_sock.
@@ -486,7 +481,6 @@ void tcp_init_sock(struct sock *sk)
 	sk_sockets_allocated_inc(sk);
 	xa_init_flags(&sk->sk_user_frags, XA_FLAGS_ALLOC1);
 }
-EXPORT_IPV6_MOD(tcp_init_sock);
 
 static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
 {
@@ -691,7 +685,6 @@ int tcp_ioctl(struct sock *sk, int cmd, int *karg)
 	*karg = answ;
 	return 0;
 }
-EXPORT_IPV6_MOD(tcp_ioctl);
 
 void tcp_mark_push(struct tcp_sock *tp, struct sk_buff *skb)
 {
@@ -908,7 +901,6 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
 
 	return ret;
 }
-EXPORT_IPV6_MOD(tcp_splice_read);
 
 /* We allow to exceed memory limits for FIN packets to expedite
  * connection tear down and (memory) recovery.
@@ -1483,7 +1475,6 @@ void tcp_splice_eof(struct socket *sock)
 	tcp_push(sk, 0, mss_now, tp->nonagle, size_goal);
 	release_sock(sk);
 }
-EXPORT_IPV6_MOD_GPL(tcp_splice_eof);
 
 /*
  *	Handle reading urgent data. BSD has very simple semantics for
@@ -1795,7 +1786,6 @@ int tcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 	}
 	return copied;
 }
-EXPORT_IPV6_MOD(tcp_read_skb);
 
 void tcp_read_done(struct sock *sk, size_t len)
 {
@@ -1840,7 +1830,6 @@ int tcp_peek_len(struct socket *sock)
 {
 	return tcp_inq(sock->sk);
 }
-EXPORT_IPV6_MOD(tcp_peek_len);
 
 /* Make sure sk_rcvbuf is big enough to satisfy SO_RCVLOWAT hint */
 int tcp_set_rcvlowat(struct sock *sk, int val)
@@ -1870,7 +1859,6 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
 	}
 	return 0;
 }
-EXPORT_IPV6_MOD(tcp_set_rcvlowat);
 
 #ifdef CONFIG_MMU
 static const struct vm_operations_struct tcp_vm_ops = {
@@ -1889,7 +1877,6 @@ int tcp_mmap(struct file *file, struct socket *sock,
 	vma->vm_ops = &tcp_vm_ops;
 	return 0;
 }
-EXPORT_IPV6_MOD(tcp_mmap);
 
 static skb_frag_t *skb_advance_to_frag(struct sk_buff *skb, u32 offset_skb,
 				       u32 *offset_frag)
@@ -2974,7 +2961,6 @@ int tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags)
 	}
 	return ret;
 }
-EXPORT_IPV6_MOD(tcp_recvmsg);
 
 void tcp_set_state(struct sock *sk, int state)
 {
@@ -3104,7 +3090,6 @@ void tcp_shutdown(struct sock *sk, int how)
 			tcp_send_fin(sk);
 	}
 }
-EXPORT_IPV6_MOD(tcp_shutdown);
 
 int tcp_orphan_count_sum(void)
 {
@@ -3617,7 +3602,6 @@ static int tcp_repair_options_est(struct sock *sk, sockptr_t optbuf,
 }
 
 DEFINE_STATIC_KEY_FALSE(tcp_tx_delay_enabled);
-EXPORT_IPV6_MOD(tcp_tx_delay_enabled);
 
 static void tcp_enable_tx_delay(struct sock *sk, int val)
 {
@@ -4202,7 +4186,6 @@ int tcp_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
 								optval, optlen);
 	return do_tcp_setsockopt(sk, level, optname, optval, optlen);
 }
-EXPORT_IPV6_MOD(tcp_setsockopt);
 
 static void tcp_get_info_chrono_stats(const struct tcp_sock *tp,
 				      struct tcp_info *info)
@@ -4865,7 +4848,6 @@ bool tcp_bpf_bypass_getsockopt(int level, int optname)
 
 	return false;
 }
-EXPORT_IPV6_MOD(tcp_bpf_bypass_getsockopt);
 
 int tcp_getsockopt(struct sock *sk, int level, int optname, char __user *optval,
 		   int __user *optlen)
@@ -4879,7 +4861,6 @@ int tcp_getsockopt(struct sock *sk, int level, int optname, char __user *optval,
 	return do_tcp_getsockopt(sk, level, optname, USER_SOCKPTR(optval),
 				 USER_SOCKPTR(optlen));
 }
-EXPORT_IPV6_MOD(tcp_getsockopt);
 
 #ifdef CONFIG_TCP_MD5SIG
 void tcp_md5_hash_skb_data(struct md5_ctx *ctx, const struct sk_buff *skb,
@@ -4910,7 +4891,6 @@ void tcp_md5_hash_skb_data(struct md5_ctx *ctx, const struct sk_buff *skb,
 	skb_walk_frags(skb, frag_iter)
 		tcp_md5_hash_skb_data(ctx, frag_iter, 0);
 }
-EXPORT_IPV6_MOD(tcp_md5_hash_skb_data);
 
 void tcp_md5_hash_key(struct md5_ctx *ctx,
 		      const struct tcp_md5sig_key *key)
@@ -4922,7 +4902,6 @@ void tcp_md5_hash_key(struct md5_ctx *ctx,
 	 */
 	data_race(({ md5_update(ctx, key->key, keylen), 0; }));
 }
-EXPORT_IPV6_MOD(tcp_md5_hash_key);
 
 /* Called with rcu_read_lock() */
 static enum skb_drop_reason
@@ -5023,7 +5002,6 @@ int tcp_do_parse_auth_options(const struct tcphdr *th,
 	}
 	return 0;
 }
-EXPORT_IPV6_MOD(tcp_do_parse_auth_options);
 #endif
 
 /* Called with rcu_read_lock() */
@@ -5092,7 +5070,6 @@ tcp_inbound_hash(struct sock *sk, const struct request_sock *req,
 	return tcp_inbound_md5_hash(sk, skb, saddr, daddr, family,
 				    l3index, md5_location);
 }
-EXPORT_IPV6_MOD_GPL(tcp_inbound_hash);
 
 void tcp_done(struct sock *sk)
 {
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 4e389d609f91..471c78be5513 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -559,7 +559,6 @@ bool tcp_fastopen_defer_connect(struct sock *sk, int *err)
 	}
 	return false;
 }
-EXPORT_IPV6_MOD(tcp_fastopen_defer_connect);
 
 /*
  * The following code block is to deal with middle box issues with TFO:
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index e6b2f4be7723..7171442c3ed7 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -814,7 +814,6 @@ void tcp_initialize_rcv_mss(struct sock *sk)
 
 	inet_csk(sk)->icsk_ack.rcv_mss = hint;
 }
-EXPORT_IPV6_MOD(tcp_initialize_rcv_mss);
 
 /* Receiver "autotuning" code.
  *
@@ -3172,7 +3171,6 @@ void tcp_simple_retransmit(struct sock *sk)
 	 */
 	tcp_non_congestion_loss_retransmit(sk);
 }
-EXPORT_IPV6_MOD(tcp_simple_retransmit);
 
 void tcp_enter_recovery(struct sock *sk, bool ece_ack)
 {
@@ -4843,7 +4841,6 @@ void tcp_done_with_error(struct sock *sk, int err)
 	if (!sock_flag(sk, SOCK_DEAD))
 		sk_error_report(sk);
 }
-EXPORT_IPV6_MOD(tcp_done_with_error);
 
 /* When we get a reset we do this. */
 void tcp_reset(struct sock *sk, struct sk_buff *skb)
@@ -6665,7 +6662,6 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 discard:
 	tcp_drop_reason(sk, skb, reason);
 }
-EXPORT_IPV6_MOD(tcp_rcv_established);
 
 void tcp_init_transfer(struct sock *sk, int bpf_op, struct sk_buff *skb)
 {
@@ -7384,7 +7380,6 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 	__kfree_skb(skb);
 	return 0;
 }
-EXPORT_IPV6_MOD(tcp_rcv_state_process);
 
 static inline void pr_drop_req(struct request_sock *req, __u16 port, int family)
 {
@@ -7582,7 +7577,6 @@ u16 tcp_get_syncookie_mss(struct request_sock_ops *rsk_ops,
 
 	return mss;
 }
-EXPORT_IPV6_MOD_GPL(tcp_get_syncookie_mss);
 
 int tcp_conn_request(struct request_sock_ops *rsk_ops,
 		     const struct tcp_request_sock_ops *af_ops,
@@ -7762,4 +7756,3 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 	tcp_listendrop(sk);
 	return 0;
 }
-EXPORT_IPV6_MOD(tcp_conn_request);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 2ea8253b737a..69ab236072e7 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -201,7 +201,6 @@ int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
 
 	return 0;
 }
-EXPORT_IPV6_MOD_GPL(tcp_twsk_unique);
 
 static int tcp_v4_pre_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 			      int addr_len)
@@ -362,7 +361,6 @@ int tcp_v4_connect(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len
 	inet->inet_dport = 0;
 	return err;
 }
-EXPORT_IPV6_MOD(tcp_v4_connect);
 
 /*
  * This routine reacts to ICMP_FRAG_NEEDED mtu indications as defined in RFC1191.
@@ -402,7 +400,6 @@ void tcp_v4_mtu_reduced(struct sock *sk)
 		tcp_simple_retransmit(sk);
 	} /* else let the usual retransmit timer handle it */
 }
-EXPORT_IPV6_MOD(tcp_v4_mtu_reduced);
 
 static void do_redirect(struct sk_buff *skb, struct sock *sk)
 {
@@ -436,7 +433,6 @@ void tcp_req_err(struct sock *sk, u32 seq, bool abort)
 	}
 	reqsk_put(req);
 }
-EXPORT_IPV6_MOD(tcp_req_err);
 
 /* TCP-LD (RFC 6069) logic */
 void tcp_ld_RTO_revert(struct sock *sk, u32 seq)
@@ -475,7 +471,6 @@ void tcp_ld_RTO_revert(struct sock *sk, u32 seq)
 		tcp_retransmit_timer(sk);
 	}
 }
-EXPORT_IPV6_MOD(tcp_ld_RTO_revert);
 
 /*
  * This routine is called by the ICMP module when it gets some
@@ -1222,7 +1217,6 @@ static void tcp_v4_reqsk_destructor(struct request_sock *req)
  */
 
 DEFINE_STATIC_KEY_DEFERRED_FALSE(tcp_md5_needed, HZ);
-EXPORT_IPV6_MOD(tcp_md5_needed);
 
 static bool better_md5_match(struct tcp_md5sig_key *old, struct tcp_md5sig_key *new)
 {
@@ -1281,7 +1275,6 @@ struct tcp_md5sig_key *__tcp_md5_do_lookup(const struct sock *sk, int l3index,
 	}
 	return best_match;
 }
-EXPORT_IPV6_MOD(__tcp_md5_do_lookup);
 
 static struct tcp_md5sig_key *tcp_md5_do_lookup_exact(const struct sock *sk,
 						      const union tcp_md5_addr *addr,
@@ -1328,7 +1321,6 @@ struct tcp_md5sig_key *tcp_v4_md5_lookup(const struct sock *sk,
 	addr = (const union tcp_md5_addr *)&addr_sk->sk_daddr;
 	return tcp_md5_do_lookup(sk, l3index, addr, AF_INET);
 }
-EXPORT_IPV6_MOD(tcp_v4_md5_lookup);
 
 static int tcp_md5sig_info_add(struct sock *sk, gfp_t gfp)
 {
@@ -1423,7 +1415,6 @@ int tcp_md5_do_add(struct sock *sk, const union tcp_md5_addr *addr,
 	return __tcp_md5_do_add(sk, addr, family, prefixlen, l3index, flags,
 				newkey, newkeylen, GFP_KERNEL);
 }
-EXPORT_IPV6_MOD(tcp_md5_do_add);
 
 int tcp_md5_key_copy(struct sock *sk, const union tcp_md5_addr *addr,
 		     int family, u8 prefixlen, int l3index,
@@ -1451,7 +1442,6 @@ int tcp_md5_key_copy(struct sock *sk, const union tcp_md5_addr *addr,
 				key->flags, key->key, key->keylen,
 				sk_gfp_mask(sk, GFP_ATOMIC));
 }
-EXPORT_IPV6_MOD(tcp_md5_key_copy);
 
 int tcp_md5_do_del(struct sock *sk, const union tcp_md5_addr *addr, int family,
 		   u8 prefixlen, int l3index, u8 flags)
@@ -1466,7 +1456,6 @@ int tcp_md5_do_del(struct sock *sk, const union tcp_md5_addr *addr, int family,
 	kfree_rcu(key, rcu);
 	return 0;
 }
-EXPORT_IPV6_MOD(tcp_md5_do_del);
 
 void tcp_clear_md5_list(struct sock *sk)
 {
@@ -1604,7 +1593,6 @@ tcp_v4_md5_hash_skb(char *md5_hash, const struct tcp_md5sig_key *key,
 	tcp_md5_hash_key(&ctx, key);
 	md5_final(&ctx, md5_hash);
 }
-EXPORT_IPV6_MOD(tcp_v4_md5_hash_skb);
 
 #endif
 
@@ -1674,7 +1662,6 @@ int tcp_v4_conn_request(struct sock *sk, struct sk_buff *skb)
 	tcp_listendrop(sk);
 	return 0;
 }
-EXPORT_IPV6_MOD(tcp_v4_conn_request);
 
 
 /*
@@ -1800,7 +1787,6 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 	tcp_done(newsk);
 	goto exit;
 }
-EXPORT_IPV6_MOD(tcp_v4_syn_recv_sock);
 
 static struct sock *tcp_v4_cookie_check(struct sock *sk, struct sk_buff *skb)
 {
@@ -2055,7 +2041,6 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 	}
 	return false;
 }
-EXPORT_IPV6_MOD(tcp_add_backlog);
 
 static void tcp_v4_restore_cb(struct sk_buff *skb)
 {
@@ -2367,7 +2352,6 @@ void inet_sk_rx_dst_set(struct sock *sk, const struct sk_buff *skb)
 		sk->sk_rx_dst_ifindex = skb->skb_iif;
 	}
 }
-EXPORT_IPV6_MOD(inet_sk_rx_dst_set);
 
 const struct inet_connection_sock_af_ops ipv4_specific = {
 	.queue_xmit	   = ip_queue_xmit,
@@ -2380,7 +2364,6 @@ const struct inet_connection_sock_af_ops ipv4_specific = {
 	.getsockopt	   = ip_getsockopt,
 	.mtu_reduced	   = tcp_v4_mtu_reduced,
 };
-EXPORT_IPV6_MOD(ipv4_specific);
 
 #if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
 static const struct tcp_sock_af_ops tcp_sock_ipv4_specific = {
@@ -2473,7 +2456,6 @@ void tcp_v4_destroy_sock(struct sock *sk)
 
 	sk_sockets_allocated_dec(sk);
 }
-EXPORT_IPV6_MOD(tcp_v4_destroy_sock);
 
 #ifdef CONFIG_PROC_FS
 /* Proc filesystem TCP sock list dumping. */
@@ -2709,7 +2691,6 @@ void *tcp_seq_start(struct seq_file *seq, loff_t *pos)
 	st->last_pos = *pos;
 	return rc;
 }
-EXPORT_IPV6_MOD(tcp_seq_start);
 
 void *tcp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
@@ -2740,7 +2721,6 @@ void *tcp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	st->last_pos = *pos;
 	return rc;
 }
-EXPORT_IPV6_MOD(tcp_seq_next);
 
 void tcp_seq_stop(struct seq_file *seq, void *v)
 {
@@ -2758,7 +2738,6 @@ void tcp_seq_stop(struct seq_file *seq, void *v)
 		break;
 	}
 }
-EXPORT_IPV6_MOD(tcp_seq_stop);
 
 static void get_openreq4(const struct request_sock *req,
 			 struct seq_file *f, int i)
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index d350d794a959..199f0b579e89 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -287,7 +287,6 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 	inet_twsk_put(tw);
 	return TCP_TW_SUCCESS;
 }
-EXPORT_IPV6_MOD(tcp_timewait_state_process);
 
 static void tcp_time_wait_init(struct sock *sk, struct tcp_timewait_sock *tcptw)
 {
@@ -523,7 +522,6 @@ void tcp_ca_openreq_child(struct sock *sk, const struct dst_entry *dst)
 
 	tcp_set_ca_state(sk, TCP_CA_Open);
 }
-EXPORT_IPV6_MOD_GPL(tcp_ca_openreq_child);
 
 static void smc_check_reset_syn_req(const struct tcp_sock *oldtp,
 				    struct request_sock *req,
@@ -976,7 +974,6 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 	}
 	return NULL;
 }
-EXPORT_IPV6_MOD(tcp_check_req);
 
 /*
  * Queue segment on the new socket if the new socket is active,
@@ -1018,4 +1015,3 @@ enum skb_drop_reason tcp_child_process(struct sock *parent, struct sock *child,
 	sock_put(child);
 	return reason;
 }
-EXPORT_IPV6_MOD(tcp_child_process);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 35c3b0ab5a0c..8e99687526a6 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -272,7 +272,6 @@ void tcp_select_initial_window(const struct sock *sk, int __space, __u32 mss,
 	WRITE_ONCE(*__window_clamp,
 		   min_t(__u32, U16_MAX << (*rcv_wscale), window_clamp));
 }
-EXPORT_IPV6_MOD(tcp_select_initial_window);
 
 /* Chose a new window to advertise, update state in tcp_sock for the
  * socket, and return result with RFC1323 scaling applied.  The return
@@ -1361,7 +1360,6 @@ void tcp_release_cb(struct sock *sk)
 	if ((flags & TCPF_ACK_DEFERRED) && inet_csk_ack_scheduled(sk))
 		tcp_send_ack(sk);
 }
-EXPORT_IPV6_MOD(tcp_release_cb);
 
 void __init tcp_tsq_work_init(void)
 {
@@ -2023,7 +2021,6 @@ int tcp_mtu_to_mss(struct sock *sk, int pmtu)
 	return __tcp_mtu_to_mss(sk, pmtu) -
 	       (tcp_sk(sk)->tcp_header_len - sizeof(struct tcphdr));
 }
-EXPORT_IPV6_MOD(tcp_mtu_to_mss);
 
 /* Inverse of above */
 int tcp_mss_to_mtu(struct sock *sk, int mss)
@@ -2096,7 +2093,6 @@ unsigned int tcp_sync_mss(struct sock *sk, u32 pmtu)
 
 	return mss_now;
 }
-EXPORT_IPV6_MOD(tcp_sync_mss);
 
 /* Compute the current effective MSS, taking SACKs and IP options,
  * and even PMTU discovery events into account.
@@ -4077,7 +4073,6 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 
 	return skb;
 }
-EXPORT_IPV6_MOD(tcp_make_synack);
 
 static void tcp_ca_dst_init(struct sock *sk, const struct dst_entry *dst)
 {
@@ -4658,4 +4653,3 @@ int tcp_rtx_synack(const struct sock *sk, struct request_sock *req)
 	}
 	return res;
 }
-EXPORT_IPV6_MOD(tcp_rtx_synack);
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 5a14a53a3c9e..ea99988795e7 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -774,7 +774,6 @@ void tcp_set_keepalive(struct sock *sk, int val)
 	else if (!val)
 		tcp_delete_keepalive_timer(sk);
 }
-EXPORT_IPV6_MOD_GPL(tcp_set_keepalive);
 
 static void tcp_keepalive_timer(struct timer_list *t)
 {
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 7e3f9fd9de19..2cc6d059b692 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -126,7 +126,6 @@
 struct udp_table udp_table __read_mostly;
 
 long sysctl_udp_mem[3] __read_mostly;
-EXPORT_IPV6_MOD(sysctl_udp_mem);
 
 DEFINE_PER_CPU(int, udp_memory_per_cpu_fw_alloc);
 EXPORT_PER_CPU_SYMBOL_GPL(udp_memory_per_cpu_fw_alloc);
@@ -349,7 +348,6 @@ int udp_lib_get_port(struct sock *sk, unsigned short snum,
 fail:
 	return error;
 }
-EXPORT_IPV6_MOD(udp_lib_get_port);
 
 static int udp_v4_get_port(struct sock *sk, unsigned short snum)
 {
@@ -415,7 +413,6 @@ u32 udp_ehashfn(const struct net *net, const __be32 laddr, const __u16 lport,
 	return __inet_ehashfn(laddr, lport, faddr, fport,
 			      udp_ehash_secret + net_hash_mix(net));
 }
-EXPORT_IPV6_MOD(udp_ehashfn);
 
 /**
  * udp4_lib_lookup1() - Simplified lookup using primary hash (destination port)
@@ -650,7 +647,6 @@ void udp_lib_hash4(struct sock *sk, u16 hash)
 
 	spin_unlock_bh(&hslot->lock);
 }
-EXPORT_IPV6_MOD(udp_lib_hash4);
 
 /* call with sock lock */
 void udp4_hash4(struct sock *sk)
@@ -666,7 +662,6 @@ void udp4_hash4(struct sock *sk)
 
 	udp_lib_hash4(sk, hash);
 }
-EXPORT_IPV6_MOD(udp4_hash4);
 #endif /* CONFIG_BASE_SMALL */
 
 /* UDP is nearly always wildcards out the wazoo, it makes no sense to try
@@ -802,11 +797,9 @@ static inline bool __udp_is_mcast_sock(struct net *net, const struct sock *sk,
 }
 
 DEFINE_STATIC_KEY_FALSE(udp_encap_needed_key);
-EXPORT_IPV6_MOD(udp_encap_needed_key);
 
 #if IS_ENABLED(CONFIG_IPV6)
 DEFINE_STATIC_KEY_FALSE(udpv6_encap_needed_key);
-EXPORT_IPV6_MOD(udpv6_encap_needed_key);
 #endif
 
 void udp_encap_enable(void)
@@ -1026,7 +1019,6 @@ void udp_flush_pending_frames(struct sock *sk)
 		ip_flush_pending_frames(sk);
 	}
 }
-EXPORT_IPV6_MOD(udp_flush_pending_frames);
 
 /**
  * 	udp4_hwcsum  -  handle outgoing HW checksumming
@@ -1204,7 +1196,6 @@ int udp_push_pending_frames(struct sock *sk)
 	WRITE_ONCE(up->pending, 0);
 	return err;
 }
-EXPORT_IPV6_MOD(udp_push_pending_frames);
 
 static int __udp_cmsg_send(struct cmsghdr *cmsg, u16 *gso_size)
 {
@@ -1241,7 +1232,6 @@ int udp_cmsg_send(struct sock *sk, struct msghdr *msg, u16 *gso_size)
 
 	return need_ip;
 }
-EXPORT_IPV6_MOD_GPL(udp_cmsg_send);
 
 int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
@@ -1532,7 +1522,6 @@ void udp_splice_eof(struct socket *sock)
 		udp_push_pending_frames(sk);
 	release_sock(sk);
 }
-EXPORT_IPV6_MOD_GPL(udp_splice_eof);
 
 #define UDP_SKB_IS_STATELESS 0x80000000
 
@@ -1647,7 +1636,6 @@ void udp_skb_destructor(struct sock *sk, struct sk_buff *skb)
 	prefetch(&skb->data);
 	udp_rmem_release(sk, udp_skb_truesize(skb), 1, false);
 }
-EXPORT_IPV6_MOD(udp_skb_destructor);
 
 /* as above, but the caller held the rx queue lock, too */
 static void udp_skb_dtor_locked(struct sock *sk, struct sk_buff *skb)
@@ -1800,7 +1788,6 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 	udp_drops_inc(sk);
 	return err;
 }
-EXPORT_IPV6_MOD_GPL(__udp_enqueue_schedule_skb);
 
 void udp_destruct_common(struct sock *sk)
 {
@@ -1817,7 +1804,6 @@ void udp_destruct_common(struct sock *sk)
 	udp_rmem_release(sk, total, 0, true);
 	kfree(up->udp_prod_queue);
 }
-EXPORT_IPV6_MOD_GPL(udp_destruct_common);
 
 static void udp_destruct_sock(struct sock *sk)
 {
@@ -1855,7 +1841,6 @@ void skb_consume_udp(struct sock *sk, struct sk_buff *skb, int len)
 		skb_release_head_state(skb);
 	__consume_stateless_skb(skb);
 }
-EXPORT_IPV6_MOD_GPL(skb_consume_udp);
 
 static struct sk_buff *__first_packet_length(struct sock *sk,
 					     struct sk_buff_head *rcvq,
@@ -1937,7 +1922,6 @@ int udp_ioctl(struct sock *sk, int cmd, int *karg)
 
 	return 0;
 }
-EXPORT_IPV6_MOD(udp_ioctl);
 
 struct sk_buff *__skb_recv_udp(struct sock *sk, unsigned int flags,
 			       int *off, int *err)
@@ -2032,7 +2016,6 @@ int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 	WARN_ON_ONCE(!skb_set_owner_sk_safe(skb, sk));
 	return recv_actor(sk, skb);
 }
-EXPORT_IPV6_MOD(udp_read_skb);
 
 /*
  * 	This should be easy, if there is something there we
@@ -2154,7 +2137,6 @@ int udp_pre_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 
 	return BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr, &addr_len);
 }
-EXPORT_IPV6_MOD(udp_pre_connect);
 
 static int udp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 		       int addr_len)
@@ -2204,7 +2186,6 @@ int udp_disconnect(struct sock *sk, int flags)
 	release_sock(sk);
 	return 0;
 }
-EXPORT_IPV6_MOD(udp_disconnect);
 
 void udp_lib_unhash(struct sock *sk)
 {
@@ -2236,7 +2217,6 @@ void udp_lib_unhash(struct sock *sk)
 		spin_unlock_bh(&hslot->lock);
 	}
 }
-EXPORT_IPV6_MOD(udp_lib_unhash);
 
 /*
  * inet_rcv_saddr was changed, we must rehash secondary hash
@@ -2306,7 +2286,6 @@ void udp_lib_rehash(struct sock *sk, u16 newhash, u16 newhash4)
 		udp_sk(sk)->udp_portaddr_hash = newhash;
 	}
 }
-EXPORT_IPV6_MOD(udp_lib_rehash);
 
 static void udp_v4_rehash(struct sock *sk)
 {
@@ -2470,7 +2449,6 @@ bool udp_sk_rx_dst_set(struct sock *sk, struct dst_entry *dst)
 	}
 	return false;
 }
-EXPORT_IPV6_MOD(udp_sk_rx_dst_set);
 
 /*
  *	Multicasts and broadcasts go to each listener.
@@ -2999,7 +2977,6 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 
 	return err;
 }
-EXPORT_IPV6_MOD(udp_lib_setsockopt);
 
 static int udp_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
 			  unsigned int optlen)
@@ -3060,7 +3037,6 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
 		return -EFAULT;
 	return 0;
 }
-EXPORT_IPV6_MOD(udp_lib_getsockopt);
 
 static int udp_getsockopt(struct sock *sk, int level, int optname,
 			  char __user *optval, int __user *optlen)
@@ -3102,7 +3078,6 @@ __poll_t udp_poll(struct file *file, struct socket *sock, poll_table *wait)
 	return mask;
 
 }
-EXPORT_IPV6_MOD(udp_poll);
 
 int udp_abort(struct sock *sk, int err)
 {
@@ -3125,7 +3100,6 @@ int udp_abort(struct sock *sk, int err)
 
 	return 0;
 }
-EXPORT_IPV6_MOD_GPL(udp_abort);
 
 struct proto udp_prot = {
 	.name			= "UDP",
@@ -3245,7 +3219,6 @@ void *udp_seq_start(struct seq_file *seq, loff_t *pos)
 
 	return *pos ? udp_get_idx(seq, *pos-1) : SEQ_START_TOKEN;
 }
-EXPORT_IPV6_MOD(udp_seq_start);
 
 void *udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
@@ -3259,7 +3232,6 @@ void *udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	++*pos;
 	return sk;
 }
-EXPORT_IPV6_MOD(udp_seq_next);
 
 void udp_seq_stop(struct seq_file *seq, void *v)
 {
@@ -3271,7 +3243,6 @@ void udp_seq_stop(struct seq_file *seq, void *v)
 	if (state->bucket <= udptable->mask)
 		spin_unlock_bh(&udptable->hash[state->bucket].lock);
 }
-EXPORT_IPV6_MOD(udp_seq_stop);
 
 /* ------------------------------------------------------------------------ */
 static void udp4_format_sock(struct sock *sp, struct seq_file *f,
diff --git a/net/psp/psp_sock.c b/net/psp/psp_sock.c
index a85b0ed88842..07dc4cf741f3 100644
--- a/net/psp/psp_sock.c
+++ b/net/psp/psp_sock.c
@@ -291,4 +291,3 @@ void psp_reply_set_decrypted(const struct sock *sk, struct sk_buff *skb)
 		skb->decrypted = 1;
 	rcu_read_unlock();
 }
-EXPORT_IPV6_MOD_GPL(psp_reply_set_decrypted);
-- 
2.53.0


