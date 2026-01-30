Return-Path: <netdev+bounces-255262-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAo9I0kefWlQQQIAu9opvQ
	(envelope-from <netdev+bounces-255262-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 22:10:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE23BEB90
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 22:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFB2F3071C6A
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 21:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419B9388876;
	Fri, 30 Jan 2026 21:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fjByS6wG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB3F389447
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 21:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769807000; cv=none; b=Q8NwnDfexwkuwKPg0CBglEJcKnzrbePH5xq5mB+4ayixRjVd0SAfhBFgXlhz8WI6YcgQKSmwbeh0sUuYSbCmmIZP41GrKBs8AMgHFDVQV+ShjkAg3gG7QtvlM2IVwfD2VZFFj0u4HRgFd9VV4R5dPGvEzvubEZA7Nxs4QYaYeIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769807000; c=relaxed/simple;
	bh=BQvsG9rp5yUOmu843TFrGtlCGUjbpqKcCmrM2R9tjvs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ct1kXptfzenRGSt/C6wev4l5hQ1nHVEtHvTLEIjZEcb3X5WkUB6h/1zQk/ebw4AOlUPJtux2dG0SlwtGh0WJO4+vE8+NrkkBFAn9q3onOMmMRu+RB7+2Jq2WFl0ZPlvQRoRGwFQXtmQq/cvlQuKqRbDmu90QQ4N5KJ7/ClhBYeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fjByS6wG; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c6deddd7f7so662909085a.3
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 13:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769806997; x=1770411797; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LGJJN2xyNvGKi6kKe0peK2vw4/rawXTvbRAM5FPw4z4=;
        b=fjByS6wGkCgHDv6ydpXB81Bmedxm7B3aGZZMNIA6GKOuqE6FfyTybBOSa3XyiBrNuu
         gyy3s1xIKGYdRlfIu+BD4vlzVHQHLS3RAQgeaqjp/X1SL8Jkmliwazpz5xbJ3S9yF3pD
         VTgzeiQz/xeM8v3ztjdSzIVavSHqbE/aLVamvVrtq27TGtIJNxDKMO8KVT/qSIYN6Uhd
         nyOUQkP2CKbu60rpDDds8gxwStPvxWnpRioSmXGEo1rZ3bMLYvt5fnX9LIkh4BGSaAkF
         oKZ7LlCB5EMIonO33pqEKwhsorqvrU5o2zmds6qfggvMu1kTGsqa1nWJjjEwxK0LRkUX
         uI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769806997; x=1770411797;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LGJJN2xyNvGKi6kKe0peK2vw4/rawXTvbRAM5FPw4z4=;
        b=o+epIgBF/Z5M2Si1qUs16Cck5TTEMHL1liZ4YeWXzwm7z81bOVIJ2sngjIVXe9OyIP
         OB+ZDs7hTjLqAQ3LSjJ/AFZEJsWhS40pkfRbP9YO1StZpbIX+HwKRwNuC82sgEQESH1Q
         rP7t1XUtocr0bNw353hso5oFmSYBZ4c1oq3xCapIcRHmGPjXomoOg+/GXwqw9bqzJfAr
         iGg8b3feO9pO5g6KtdNfMObz4ZbWY80e6V8lihUYsWb2J1PUy5gKmefKrZ1d66T+weTH
         Q7/57bEvaaRJVMzvBR2NYzk5XLgTSR4K1hMIeV1ULXWa7InlJ+THpHhTuNabFdTJg1sm
         qUvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXLhAKC3gKPIMrjCwPGElIZ4jtNSCaZ4pFl6W0CLuLRRN8wjrQujYdbk0DToSNsrr14LrhEho=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeB6HT49Uy2qb3XgqjqXhLzeWlePdBsT7I1+ogrvr2kwPYKF5E
	9uvPkt4vLfnNKzwQTuONf6GVlyEgZIfvrjxtbQtpMVj4vxfPGWe78jGf/37U4pVUaKjpEp1aBJN
	Ahwi/CzXSDHrpog==
X-Received: from qkpr14.prod.google.com ([2002:a05:620a:298e:b0:8b2:d765:51ef])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1a20:b0:8c7:115a:d0e3 with SMTP id af79cd13be357-8c9eb26fd93mr586292385a.37.1769806997453;
 Fri, 30 Jan 2026 13:03:17 -0800 (PST)
Date: Fri, 30 Jan 2026 21:03:03 +0000
In-Reply-To: <20260130210303.3888261-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260130210303.3888261-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260130210303.3888261-9-edumazet@google.com>
Subject: [PATCH net-next 8/8] ipv6: colocate inet6_cork in inet_cork_full
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255262-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1CE23BEB90
X-Rspamd-Action: no action

All inet6_cork users also use one inet_cork_full.

Reduce number of parameters and increase data locality.

This saves ~275 bytes of code on x86_64.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/ipv6.h    |  8 ------
 include/net/inet_sock.h | 10 ++++++++
 include/net/ipv6.h      |  6 ++---
 net/ipv6/ip6_output.c   | 55 ++++++++++++++++++++---------------------
 net/ipv6/raw.c          |  2 +-
 5 files changed, 40 insertions(+), 41 deletions(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 7294e4e89b797b1c45d1920686c2553e10badb81..20aae8357dd151e8c7d6972f41e77cebf1379177 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -205,13 +205,6 @@ struct ipv6_mc_socklist;
 struct ipv6_ac_socklist;
 struct ipv6_fl_socklist;
 
-struct inet6_cork {
-	struct ipv6_txoptions *opt;
-	u8 hop_limit;
-	u8 tclass;
-	u8 dontfrag:1;
-};
-
 /* struct ipv6_pinfo - ipv6 private area */
 struct ipv6_pinfo {
 	/* Used in tx path (inet6_csk_route_socket(), ip6_xmit()) */
@@ -267,7 +260,6 @@ struct ipv6_pinfo {
 
 	struct sk_buff		*pktoptions;
 	struct sk_buff		*rxpmtu;
-	struct inet6_cork	cork;
 
 	struct ipv6_mc_socklist	__rcu *ipv6_mc_list;
 	struct ipv6_ac_socklist	*ipv6_ac_list;
diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index 903b2263ec8031565990dc52b921352e6a642b1a..7cdcbed3e5cbfd1a13698942da05b9ceabf72950 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -159,6 +159,13 @@ static inline bool inet_sk_bound_dev_eq(const struct net *net,
 #endif
 }
 
+struct inet6_cork {
+	struct ipv6_txoptions *opt;
+	u8 hop_limit;
+	u8 tclass;
+	u8 dontfrag:1;
+};
+
 struct inet_cork {
 	unsigned int		flags;
 	__be32			addr;
@@ -179,6 +186,9 @@ struct inet_cork {
 struct inet_cork_full {
 	struct inet_cork	base;
 	struct flowi		fl;
+#if IS_ENABLED(CONFIG_IPV6)
+	struct inet6_cork	base6;
+#endif
 };
 
 struct ip_mc_socklist;
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index a35f0a8114c093c65d3706f53b945cb426bd212b..c27b9d7aeb7cf4611a55abc133d6aaa0d1508a47 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1107,8 +1107,7 @@ void ip6_flush_pending_frames(struct sock *sk);
 int ip6_send_skb(struct sk_buff *skb);
 
 struct sk_buff *__ip6_make_skb(struct sock *sk, struct sk_buff_head *queue,
-			       struct inet_cork_full *cork,
-			       struct inet6_cork *v6_cork);
+			       struct inet_cork_full *cork);
 struct sk_buff *ip6_make_skb(struct sock *sk,
 			     int getfrag(void *from, char *to, int offset,
 					 int len, int odd, struct sk_buff *skb),
@@ -1119,8 +1118,7 @@ struct sk_buff *ip6_make_skb(struct sock *sk,
 
 static inline struct sk_buff *ip6_finish_skb(struct sock *sk)
 {
-	return __ip6_make_skb(sk, &sk->sk_write_queue, &inet_sk(sk)->cork,
-			      &inet6_sk(sk)->cork);
+	return __ip6_make_skb(sk, &sk->sk_write_queue, &inet_sk(sk)->cork);
 }
 
 int ip6_dst_lookup(struct net *net, struct sock *sk, struct dst_entry **dst,
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index f110701d1eca1e5f763d9138a43e11e92c15412f..e622a9e086cc0a3bc775fc87a379115bcf438e77 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1353,12 +1353,13 @@ static void ip6_append_data_mtu(unsigned int *mtu,
 }
 
 static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
-			  struct inet6_cork *v6_cork, struct ipcm6_cookie *ipc6,
+			  struct ipcm6_cookie *ipc6,
 			  struct rt6_info *rt)
 {
+	struct ipv6_txoptions *nopt, *opt = ipc6->opt;
+	struct inet6_cork *v6_cork = &cork->base6;
 	struct ipv6_pinfo *np = inet6_sk(sk);
 	unsigned int mtu, frag_size;
-	struct ipv6_txoptions *nopt, *opt = ipc6->opt;
 
 	/* callers pass dst together with a reference, set it first so
 	 * ip6_cork_release() can put it down even in case of an error.
@@ -1431,17 +1432,17 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
 static int __ip6_append_data(struct sock *sk,
 			     struct sk_buff_head *queue,
 			     struct inet_cork_full *cork_full,
-			     struct inet6_cork *v6_cork,
 			     struct page_frag *pfrag,
 			     int getfrag(void *from, char *to, int offset,
 					 int len, int odd, struct sk_buff *skb),
 			     void *from, size_t length, int transhdrlen,
 			     unsigned int flags)
 {
-	struct sk_buff *skb, *skb_prev = NULL;
+	unsigned int maxfraglen, fragheaderlen, mtu, orig_mtu, pmtu;
+	struct inet6_cork *v6_cork = &cork_full->base6;
 	struct inet_cork *cork = &cork_full->base;
 	struct flowi6 *fl6 = &cork_full->fl.u.ip6;
-	unsigned int maxfraglen, fragheaderlen, mtu, orig_mtu, pmtu;
+	struct sk_buff *skb, *skb_prev = NULL;
 	struct ubuf_info *uarg = NULL;
 	int exthdrlen = 0;
 	int dst_exthdrlen = 0;
@@ -1844,7 +1845,6 @@ int ip6_append_data(struct sock *sk,
 		    struct rt6_info *rt, unsigned int flags)
 {
 	struct inet_sock *inet = inet_sk(sk);
-	struct ipv6_pinfo *np = inet6_sk(sk);
 	int exthdrlen;
 	int err;
 
@@ -1855,7 +1855,7 @@ int ip6_append_data(struct sock *sk,
 		 * setup for corking
 		 */
 		dst_hold(&rt->dst);
-		err = ip6_setup_cork(sk, &inet->cork, &np->cork,
+		err = ip6_setup_cork(sk, &inet->cork,
 				     ipc6, rt);
 		if (err)
 			return err;
@@ -1869,7 +1869,7 @@ int ip6_append_data(struct sock *sk,
 	}
 
 	return __ip6_append_data(sk, &sk->sk_write_queue, &inet->cork,
-				 &np->cork, sk_page_frag(sk), getfrag,
+				 sk_page_frag(sk), getfrag,
 				 from, length, transhdrlen, flags);
 }
 EXPORT_SYMBOL_GPL(ip6_append_data);
@@ -1882,9 +1882,10 @@ static void ip6_cork_steal_dst(struct sk_buff *skb, struct inet_cork_full *cork)
 	skb_dst_set(skb, dst);
 }
 
-static void ip6_cork_release(struct inet_cork_full *cork,
-			     struct inet6_cork *v6_cork)
+static void ip6_cork_release(struct inet_cork_full *cork)
 {
+	struct inet6_cork *v6_cork = &cork->base6;
+
 	if (unlikely(v6_cork->opt)) {
 		struct ipv6_txoptions *opt = v6_cork->opt;
 
@@ -1904,15 +1905,14 @@ static void ip6_cork_release(struct inet_cork_full *cork,
 
 struct sk_buff *__ip6_make_skb(struct sock *sk,
 			       struct sk_buff_head *queue,
-			       struct inet_cork_full *cork,
-			       struct inet6_cork *v6_cork)
+			       struct inet_cork_full *cork)
 {
 	struct sk_buff *skb, *tmp_skb;
 	struct sk_buff **tail_skb;
 	struct in6_addr *final_dst;
 	struct net *net = sock_net(sk);
 	struct ipv6hdr *hdr;
-	struct ipv6_txoptions *opt = v6_cork->opt;
+	struct ipv6_txoptions *opt;
 	struct rt6_info *rt = dst_rt6_info(cork->base.dst);
 	struct flowi6 *fl6 = &cork->fl.u.ip6;
 	unsigned char proto = fl6->flowi6_proto;
@@ -1941,6 +1941,7 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
 	__skb_pull(skb, skb_network_header_len(skb));
 
 	final_dst = &fl6->daddr;
+	opt = cork->base6.opt;
 	if (unlikely(opt)) {
 		if (opt->opt_flen)
 			proto = ipv6_push_frag_opts(skb, opt, proto);
@@ -1952,10 +1953,10 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
 	skb_reset_network_header(skb);
 	hdr = ipv6_hdr(skb);
 
-	ip6_flow_hdr(hdr, v6_cork->tclass,
+	ip6_flow_hdr(hdr, cork->base6.tclass,
 		     ip6_make_flowlabel(net, skb, fl6->flowlabel,
 					ip6_autoflowlabel(net, sk), fl6));
-	hdr->hop_limit = v6_cork->hop_limit;
+	hdr->hop_limit = cork->base6.hop_limit;
 	hdr->nexthdr = proto;
 	hdr->saddr = fl6->saddr;
 	hdr->daddr = *final_dst;
@@ -1982,7 +1983,7 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
 		ICMP6_INC_STATS(net, idev, ICMP6_MIB_OUTMSGS);
 	}
 
-	ip6_cork_release(cork, v6_cork);
+	ip6_cork_release(cork);
 out:
 	return skb;
 }
@@ -2021,8 +2022,7 @@ EXPORT_SYMBOL_GPL(ip6_push_pending_frames);
 
 static void __ip6_flush_pending_frames(struct sock *sk,
 				       struct sk_buff_head *queue,
-				       struct inet_cork_full *cork,
-				       struct inet6_cork *v6_cork)
+				       struct inet_cork_full *cork)
 {
 	struct sk_buff *skb;
 
@@ -2033,13 +2033,13 @@ static void __ip6_flush_pending_frames(struct sock *sk,
 		kfree_skb(skb);
 	}
 
-	ip6_cork_release(cork, v6_cork);
+	ip6_cork_release(cork);
 }
 
 void ip6_flush_pending_frames(struct sock *sk)
 {
 	__ip6_flush_pending_frames(sk, &sk->sk_write_queue,
-				   &inet_sk(sk)->cork, &inet6_sk(sk)->cork);
+				   &inet_sk(sk)->cork);
 }
 EXPORT_SYMBOL_GPL(ip6_flush_pending_frames);
 
@@ -2050,9 +2050,8 @@ struct sk_buff *ip6_make_skb(struct sock *sk,
 			     struct ipcm6_cookie *ipc6, struct rt6_info *rt,
 			     unsigned int flags, struct inet_cork_full *cork)
 {
-	struct inet6_cork v6_cork;
-	struct sk_buff_head queue;
 	int exthdrlen = (ipc6->opt ? ipc6->opt->opt_flen : 0);
+	struct sk_buff_head queue;
 	int err;
 
 	if (flags & MSG_PROBE) {
@@ -2065,21 +2064,21 @@ struct sk_buff *ip6_make_skb(struct sock *sk,
 	cork->base.flags = 0;
 	cork->base.addr = 0;
 	cork->base.opt = NULL;
-	v6_cork.opt = NULL;
-	err = ip6_setup_cork(sk, cork, &v6_cork, ipc6, rt);
+	cork->base6.opt = NULL;
+	err = ip6_setup_cork(sk, cork, ipc6, rt);
 	if (err) {
-		ip6_cork_release(cork, &v6_cork);
+		ip6_cork_release(cork);
 		return ERR_PTR(err);
 	}
 
-	err = __ip6_append_data(sk, &queue, cork, &v6_cork,
+	err = __ip6_append_data(sk, &queue, cork,
 				&current->task_frag, getfrag, from,
 				length + exthdrlen, transhdrlen + exthdrlen,
 				flags);
 	if (err) {
-		__ip6_flush_pending_frames(sk, &queue, cork, &v6_cork);
+		__ip6_flush_pending_frames(sk, &queue, cork);
 		return ERR_PTR(err);
 	}
 
-	return __ip6_make_skb(sk, &queue, cork, &v6_cork);
+	return __ip6_make_skb(sk, &queue, cork);
 }
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index b4cd05dba9b6d209bfb1024b7e1b0c703f906e5b..ee6beba03e9b498c8ea5b9e5834e26251f81e958 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -529,7 +529,7 @@ static int rawv6_push_pending_frames(struct sock *sk, struct flowi6 *fl6,
 
 	offset = rp->offset;
 	total_len = inet_sk(sk)->cork.base.length;
-	opt = inet6_sk(sk)->cork.opt;
+	opt = inet_sk(sk)->cork.base6.opt;
 	total_len -= opt ? opt->opt_flen : 0;
 
 	if (offset >= total_len - 1) {
-- 
2.53.0.rc1.225.gd81095ad13-goog


