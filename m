Return-Path: <netdev+bounces-216132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0CFB322A2
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 21:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56F03B22137
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 19:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6802D0618;
	Fri, 22 Aug 2025 19:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Eo29/47j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4091E2D1925
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 19:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755889713; cv=none; b=U7y4TsTlmgdn+YPrL7vaf2vyzog4dxHMGDoAAq2KONO5GE3q5C4GoVK7aww6VMaJB0vPUtlsrqvwGxJvdKcKQcKQKaHCbn9Z0zo/sR8EnGOcVbjFnCfByANWbSHSGaXEtD0Ye+FPLnIHU1a6+ECtFkrw6PeNLwVbg8CGyXbDvbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755889713; c=relaxed/simple;
	bh=6uc9j0lloFZaARbCFD1+7t88PnVuTrZkc85OzSe5BSU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jEzg1li/BHbQx2fqmwbbmTsPvo1WJ9roFSSIrrHfxALeYJeXTHy7rwroaDvrkKj/1rDBeBxA0o3ziLuML+jsfQxBtFL6SKq3Oys4rraLdzqGOmh7jgYtjZGSA634IRKEonwagGJgrxFQdQd62r9LMvUCGwRFaQy1rBZBaBwod+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Eo29/47j; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e2e8908fdso2154907b3a.1
        for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 12:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755889710; x=1756494510; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OkA5jedM2Oo17qJ6N2sEMCnNjHuAk3f2j8Uj7C0ur7w=;
        b=Eo29/47jmxc9NfwhM8OxSozhqU/bDa3MNtk2ZTDJ1Pz+LmWmfpCMN3BiFx5G7YjO6I
         oDwsnuhi1pN393vE6YkaVdR9Enegi8xw6aFhv+Bpdgd7ruZhTZJwiJhVMxIyGCt2OPTC
         3fCsMuKq8K6XiAo13rnbgI7GxTrlyiv7RCWHrjX0MK5VhdvjlBxKAdEzEliDyYVqiWQ+
         wEnh6EsG5rpfYJCv5QReJTJin76YTDsSXgklNHN3P7j/mPdxdpEbIcFXWcxFQH+Fa1PM
         I/ndLMzUhIkSulmU/MY43MbVsVSihMZQgeJJMl2hOC2vHPxRewSXrxVmslN/zaS2f0j/
         L1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755889710; x=1756494510;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OkA5jedM2Oo17qJ6N2sEMCnNjHuAk3f2j8Uj7C0ur7w=;
        b=o3PUAkXna7dWSaVnKnDTYvdb6QKS4cWuwJF7xGY94MscDDf/pAt3sq7cC52/wlCJPW
         OWcXAOX21/dXF2aQ8Ieht5SEwKpa45dcF+nSHIT7ER44LJ+ZbFRvkKujZFB0EqqYiena
         EZ+6rqCHFxWrmFszXwgaVjjAROoTNfAocqZTT5GF/R7tC9QKBFvXh66as3iv+koNvYJO
         tWAbdrvemsNFLPlvlvrifPanvEI4c5kH5gKVGmN5Ymy3Vi2F0bV7Vs79/QRm5tTrhacp
         1c+QKB/mJYkdJLw4Bm2/K3gto63+dlAS1pBJRmXUH5Kwsna2OKXTo2Lsv61jmKkXGC3v
         NDSw==
X-Forwarded-Encrypted: i=1; AJvYcCXcdMrJ5bq/928E/LClDoHTHHmjUsfDeBR/5+HIL+06MmtVFQXeQ8MNjJOObmVNCbC1GGZvWLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtnqwDdVqnFy7GExKQ7YtPLAskP+cjsBx/QGYMDsmxmB/j1X2L
	CLLJV23+Ih9tmJidRpbSbmeLsSvLhf0IX6SuiDU4OyU81qpjIRWMPMAzQae9Qz65WiL9K+9dySP
	6XCllqg==
X-Google-Smtp-Source: AGHT+IHkLB5aLyBgMKArM4mKBeyNuzNsmJks4EvVd0w1r48fikuuOV1GlLlt4iLgesQdVj7vAMOUWWwQ9L8=
X-Received: from pjvf11.prod.google.com ([2002:a17:90a:da8b:b0:31f:4e21:7021])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d97:b0:238:3f54:78ef
 with SMTP id adf61e73a8af0-24340d5606emr6071974637.45.1755889710549; Fri, 22
 Aug 2025 12:08:30 -0700 (PDT)
Date: Fri, 22 Aug 2025 19:07:01 +0000
In-Reply-To: <20250822190803.540788-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822190803.540788-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822190803.540788-7-kuniyu@google.com>
Subject: [PATCH v2 net-next 6/6] tcp: Move TCP-specific diag functions to tcp_diag.c.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

tcp_diag_dump() / tcp_diag_dump_one() is just a wrapper of
inet_diag_dump_icsk() / inet_diag_dump_one_icsk(), respectively.

Let's inline them in tcp_diag.c and move static callees as well.

Note that inet_sk_attr_size() is merged into tcp_diag_get_aux_size(),
and we remove inet_diag_handler.idiag_get_aux_size() accordingly.

While at it, BUG_ON() is replaced with DEBUG_NET_WARN_ON_ONCE().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/linux/inet_diag.h |  11 -
 net/ipv4/inet_diag.c      | 479 --------------------------------------
 net/ipv4/tcp_diag.c       | 460 +++++++++++++++++++++++++++++++++++-
 3 files changed, 455 insertions(+), 495 deletions(-)

diff --git a/include/linux/inet_diag.h b/include/linux/inet_diag.h
index 34de992b5bd9..30bf8f7ea62b 100644
--- a/include/linux/inet_diag.h
+++ b/include/linux/inet_diag.h
@@ -24,9 +24,6 @@ struct inet_diag_handler {
 					 bool net_admin,
 					 struct sk_buff *skb);
 
-	size_t		(*idiag_get_aux_size)(struct sock *sk,
-					      bool net_admin);
-
 	int		(*destroy)(struct sk_buff *in_skb,
 				   const struct inet_diag_req_v2 *req);
 
@@ -48,14 +45,6 @@ int inet_sk_diag_fill(struct sock *sk, struct inet_connection_sock *icsk,
 		      struct sk_buff *skb, struct netlink_callback *cb,
 		      const struct inet_diag_req_v2 *req,
 		      u16 nlmsg_flags, bool net_admin);
-void inet_diag_dump_icsk(struct sk_buff *skb,
-			 struct netlink_callback *cb,
-			 const struct inet_diag_req_v2 *r);
-int inet_diag_dump_one_icsk(struct netlink_callback *cb,
-			    const struct inet_diag_req_v2 *req);
-
-struct sock *inet_diag_find_one_icsk(struct net *net,
-				     const struct inet_diag_req_v2 *req);
 
 int inet_diag_bc_sk(const struct nlattr *_bc, struct sock *sk);
 
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index fa4175b7f202..314e26e04672 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -20,9 +20,6 @@
 #include <net/ipv6.h>
 #include <net/inet_common.h>
 #include <net/inet_connection_sock.h>
-#include <net/inet_hashtables.h>
-#include <net/inet_timewait_sock.h>
-#include <net/inet6_hashtables.h>
 #include <net/bpf_sk_storage.h>
 #include <net/netlink.h>
 
@@ -97,31 +94,6 @@ void inet_diag_msg_common_fill(struct inet_diag_msg *r, struct sock *sk)
 }
 EXPORT_SYMBOL_GPL(inet_diag_msg_common_fill);
 
-static size_t inet_sk_attr_size(struct sock *sk,
-				const struct inet_diag_req_v2 *req,
-				bool net_admin)
-{
-	const struct inet_diag_handler *handler;
-	size_t aux = 0;
-
-	rcu_read_lock();
-	handler = rcu_dereference(inet_diag_table[req->sdiag_protocol]);
-	DEBUG_NET_WARN_ON_ONCE(!handler);
-	if (handler && handler->idiag_get_aux_size)
-		aux = handler->idiag_get_aux_size(sk, net_admin);
-	rcu_read_unlock();
-
-	return	  nla_total_size(sizeof(struct tcp_info))
-		+ nla_total_size(sizeof(struct inet_diag_msg))
-		+ inet_diag_msg_attrs_size()
-		+ nla_total_size(sizeof(struct inet_diag_meminfo))
-		+ nla_total_size(SK_MEMINFO_VARS * sizeof(u32))
-		+ nla_total_size(TCP_CA_NAME_MAX)
-		+ nla_total_size(sizeof(struct tcpvegas_info))
-		+ aux
-		+ 64;
-}
-
 int inet_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
 			     struct inet_diag_msg *r, int ext,
 			     struct user_namespace *user_ns,
@@ -422,181 +394,6 @@ int inet_sk_diag_fill(struct sock *sk, struct inet_connection_sock *icsk,
 }
 EXPORT_SYMBOL_GPL(inet_sk_diag_fill);
 
-static int inet_twsk_diag_fill(struct sock *sk,
-			       struct sk_buff *skb,
-			       struct netlink_callback *cb,
-			       u16 nlmsg_flags, bool net_admin)
-{
-	struct inet_timewait_sock *tw = inet_twsk(sk);
-	struct inet_diag_msg *r;
-	struct nlmsghdr *nlh;
-	long tmo;
-
-	nlh = nlmsg_put(skb, NETLINK_CB(cb->skb).portid,
-			cb->nlh->nlmsg_seq, cb->nlh->nlmsg_type,
-			sizeof(*r), nlmsg_flags);
-	if (!nlh)
-		return -EMSGSIZE;
-
-	r = nlmsg_data(nlh);
-	BUG_ON(tw->tw_state != TCP_TIME_WAIT);
-
-	inet_diag_msg_common_fill(r, sk);
-	r->idiag_retrans      = 0;
-
-	r->idiag_state	      = READ_ONCE(tw->tw_substate);
-	r->idiag_timer	      = 3;
-	tmo = tw->tw_timer.expires - jiffies;
-	r->idiag_expires      = jiffies_delta_to_msecs(tmo);
-	r->idiag_rqueue	      = 0;
-	r->idiag_wqueue	      = 0;
-	r->idiag_uid	      = 0;
-	r->idiag_inode	      = 0;
-
-	if (net_admin && nla_put_u32(skb, INET_DIAG_MARK,
-				     tw->tw_mark)) {
-		nlmsg_cancel(skb, nlh);
-		return -EMSGSIZE;
-	}
-
-	nlmsg_end(skb, nlh);
-	return 0;
-}
-
-static int inet_req_diag_fill(struct sock *sk, struct sk_buff *skb,
-			      struct netlink_callback *cb,
-			      u16 nlmsg_flags, bool net_admin)
-{
-	struct request_sock *reqsk = inet_reqsk(sk);
-	struct inet_diag_msg *r;
-	struct nlmsghdr *nlh;
-	long tmo;
-
-	nlh = nlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
-			cb->nlh->nlmsg_type, sizeof(*r), nlmsg_flags);
-	if (!nlh)
-		return -EMSGSIZE;
-
-	r = nlmsg_data(nlh);
-	inet_diag_msg_common_fill(r, sk);
-	r->idiag_state = TCP_SYN_RECV;
-	r->idiag_timer = 1;
-	r->idiag_retrans = reqsk->num_retrans;
-
-	BUILD_BUG_ON(offsetof(struct inet_request_sock, ir_cookie) !=
-		     offsetof(struct sock, sk_cookie));
-
-	tmo = inet_reqsk(sk)->rsk_timer.expires - jiffies;
-	r->idiag_expires = jiffies_delta_to_msecs(tmo);
-	r->idiag_rqueue	= 0;
-	r->idiag_wqueue	= 0;
-	r->idiag_uid	= 0;
-	r->idiag_inode	= 0;
-
-	if (net_admin && nla_put_u32(skb, INET_DIAG_MARK,
-				     inet_rsk(reqsk)->ir_mark)) {
-		nlmsg_cancel(skb, nlh);
-		return -EMSGSIZE;
-	}
-
-	nlmsg_end(skb, nlh);
-	return 0;
-}
-
-static int sk_diag_fill(struct sock *sk, struct sk_buff *skb,
-			struct netlink_callback *cb,
-			const struct inet_diag_req_v2 *r,
-			u16 nlmsg_flags, bool net_admin)
-{
-	if (sk->sk_state == TCP_TIME_WAIT)
-		return inet_twsk_diag_fill(sk, skb, cb, nlmsg_flags, net_admin);
-
-	if (sk->sk_state == TCP_NEW_SYN_RECV)
-		return inet_req_diag_fill(sk, skb, cb, nlmsg_flags, net_admin);
-
-	return inet_sk_diag_fill(sk, inet_csk(sk), skb, cb, r, nlmsg_flags,
-				 net_admin);
-}
-
-struct sock *inet_diag_find_one_icsk(struct net *net,
-				     const struct inet_diag_req_v2 *req)
-{
-	struct sock *sk;
-
-	rcu_read_lock();
-	if (req->sdiag_family == AF_INET)
-		sk = inet_lookup(net, NULL, 0, req->id.idiag_dst[0],
-				 req->id.idiag_dport, req->id.idiag_src[0],
-				 req->id.idiag_sport, req->id.idiag_if);
-#if IS_ENABLED(CONFIG_IPV6)
-	else if (req->sdiag_family == AF_INET6) {
-		if (ipv6_addr_v4mapped((struct in6_addr *)req->id.idiag_dst) &&
-		    ipv6_addr_v4mapped((struct in6_addr *)req->id.idiag_src))
-			sk = inet_lookup(net, NULL, 0, req->id.idiag_dst[3],
-					 req->id.idiag_dport, req->id.idiag_src[3],
-					 req->id.idiag_sport, req->id.idiag_if);
-		else
-			sk = inet6_lookup(net, NULL, 0,
-					  (struct in6_addr *)req->id.idiag_dst,
-					  req->id.idiag_dport,
-					  (struct in6_addr *)req->id.idiag_src,
-					  req->id.idiag_sport,
-					  req->id.idiag_if);
-	}
-#endif
-	else {
-		rcu_read_unlock();
-		return ERR_PTR(-EINVAL);
-	}
-	rcu_read_unlock();
-	if (!sk)
-		return ERR_PTR(-ENOENT);
-
-	if (sock_diag_check_cookie(sk, req->id.idiag_cookie)) {
-		sock_gen_put(sk);
-		return ERR_PTR(-ENOENT);
-	}
-
-	return sk;
-}
-EXPORT_SYMBOL_GPL(inet_diag_find_one_icsk);
-
-int inet_diag_dump_one_icsk(struct netlink_callback *cb,
-			    const struct inet_diag_req_v2 *req)
-{
-	struct sk_buff *in_skb = cb->skb;
-	bool net_admin = netlink_net_capable(in_skb, CAP_NET_ADMIN);
-	struct net *net = sock_net(in_skb->sk);
-	struct sk_buff *rep;
-	struct sock *sk;
-	int err;
-
-	sk = inet_diag_find_one_icsk(net, req);
-	if (IS_ERR(sk))
-		return PTR_ERR(sk);
-
-	rep = nlmsg_new(inet_sk_attr_size(sk, req, net_admin), GFP_KERNEL);
-	if (!rep) {
-		err = -ENOMEM;
-		goto out;
-	}
-
-	err = sk_diag_fill(sk, rep, cb, req, 0, net_admin);
-	if (err < 0) {
-		WARN_ON(err == -EMSGSIZE);
-		nlmsg_free(rep);
-		goto out;
-	}
-	err = nlmsg_unicast(net->diag_nlsk, rep, NETLINK_CB(in_skb).portid);
-
-out:
-	if (sk)
-		sock_gen_put(sk);
-
-	return err;
-}
-EXPORT_SYMBOL_GPL(inet_diag_dump_one_icsk);
-
 static int inet_diag_cmd_exact(int cmd, struct sk_buff *in_skb,
 			       const struct nlmsghdr *nlh,
 			       int hdrlen,
@@ -990,282 +787,6 @@ static int inet_diag_bc_audit(const struct nlattr *attr,
 	return len == 0 ? 0 : -EINVAL;
 }
 
-static void twsk_build_assert(void)
-{
-	BUILD_BUG_ON(offsetof(struct inet_timewait_sock, tw_family) !=
-		     offsetof(struct sock, sk_family));
-
-	BUILD_BUG_ON(offsetof(struct inet_timewait_sock, tw_num) !=
-		     offsetof(struct inet_sock, inet_num));
-
-	BUILD_BUG_ON(offsetof(struct inet_timewait_sock, tw_dport) !=
-		     offsetof(struct inet_sock, inet_dport));
-
-	BUILD_BUG_ON(offsetof(struct inet_timewait_sock, tw_rcv_saddr) !=
-		     offsetof(struct inet_sock, inet_rcv_saddr));
-
-	BUILD_BUG_ON(offsetof(struct inet_timewait_sock, tw_daddr) !=
-		     offsetof(struct inet_sock, inet_daddr));
-
-#if IS_ENABLED(CONFIG_IPV6)
-	BUILD_BUG_ON(offsetof(struct inet_timewait_sock, tw_v6_rcv_saddr) !=
-		     offsetof(struct sock, sk_v6_rcv_saddr));
-
-	BUILD_BUG_ON(offsetof(struct inet_timewait_sock, tw_v6_daddr) !=
-		     offsetof(struct sock, sk_v6_daddr));
-#endif
-}
-
-void inet_diag_dump_icsk(struct sk_buff *skb,
-			 struct netlink_callback *cb,
-			 const struct inet_diag_req_v2 *r)
-{
-	bool net_admin = netlink_net_capable(cb->skb, CAP_NET_ADMIN);
-	struct inet_diag_dump_data *cb_data = cb->data;
-	struct net *net = sock_net(skb->sk);
-	u32 idiag_states = r->idiag_states;
-	struct inet_hashinfo *hashinfo;
-	int i, num, s_i, s_num;
-	struct nlattr *bc;
-	struct sock *sk;
-
-	hashinfo = net->ipv4.tcp_death_row.hashinfo;
-	bc = cb_data->inet_diag_nla_bc;
-	if (idiag_states & TCPF_SYN_RECV)
-		idiag_states |= TCPF_NEW_SYN_RECV;
-	s_i = cb->args[1];
-	s_num = num = cb->args[2];
-
-	if (cb->args[0] == 0) {
-		if (!(idiag_states & TCPF_LISTEN) || r->id.idiag_dport)
-			goto skip_listen_ht;
-
-		for (i = s_i; i <= hashinfo->lhash2_mask; i++) {
-			struct inet_listen_hashbucket *ilb;
-			struct hlist_nulls_node *node;
-
-			num = 0;
-			ilb = &hashinfo->lhash2[i];
-
-			if (hlist_nulls_empty(&ilb->nulls_head)) {
-				s_num = 0;
-				continue;
-			}
-			spin_lock(&ilb->lock);
-			sk_nulls_for_each(sk, node, &ilb->nulls_head) {
-				struct inet_sock *inet = inet_sk(sk);
-
-				if (!net_eq(sock_net(sk), net))
-					continue;
-
-				if (num < s_num) {
-					num++;
-					continue;
-				}
-
-				if (r->sdiag_family != AF_UNSPEC &&
-				    sk->sk_family != r->sdiag_family)
-					goto next_listen;
-
-				if (r->id.idiag_sport != inet->inet_sport &&
-				    r->id.idiag_sport)
-					goto next_listen;
-
-				if (!inet_diag_bc_sk(bc, sk))
-					goto next_listen;
-
-				if (inet_sk_diag_fill(sk, inet_csk(sk), skb,
-						      cb, r, NLM_F_MULTI,
-						      net_admin) < 0) {
-					spin_unlock(&ilb->lock);
-					goto done;
-				}
-
-next_listen:
-				++num;
-			}
-			spin_unlock(&ilb->lock);
-
-			s_num = 0;
-		}
-skip_listen_ht:
-		cb->args[0] = 1;
-		s_i = num = s_num = 0;
-	}
-
-/* Process a maximum of SKARR_SZ sockets at a time when walking hash buckets
- * with bh disabled.
- */
-#define SKARR_SZ 16
-
-	/* Dump bound but inactive (not listening, connecting, etc.) sockets */
-	if (cb->args[0] == 1) {
-		if (!(idiag_states & TCPF_BOUND_INACTIVE))
-			goto skip_bind_ht;
-
-		for (i = s_i; i < hashinfo->bhash_size; i++) {
-			struct inet_bind_hashbucket *ibb;
-			struct inet_bind2_bucket *tb2;
-			struct sock *sk_arr[SKARR_SZ];
-			int num_arr[SKARR_SZ];
-			int idx, accum, res;
-
-resume_bind_walk:
-			num = 0;
-			accum = 0;
-			ibb = &hashinfo->bhash2[i];
-
-			if (hlist_empty(&ibb->chain)) {
-				s_num = 0;
-				continue;
-			}
-			spin_lock_bh(&ibb->lock);
-			inet_bind_bucket_for_each(tb2, &ibb->chain) {
-				if (!net_eq(ib2_net(tb2), net))
-					continue;
-
-				sk_for_each_bound(sk, &tb2->owners) {
-					struct inet_sock *inet = inet_sk(sk);
-
-					if (num < s_num)
-						goto next_bind;
-
-					if (sk->sk_state != TCP_CLOSE ||
-					    !inet->inet_num)
-						goto next_bind;
-
-					if (r->sdiag_family != AF_UNSPEC &&
-					    r->sdiag_family != sk->sk_family)
-						goto next_bind;
-
-					if (!inet_diag_bc_sk(bc, sk))
-						goto next_bind;
-
-					sock_hold(sk);
-					num_arr[accum] = num;
-					sk_arr[accum] = sk;
-					if (++accum == SKARR_SZ)
-						goto pause_bind_walk;
-next_bind:
-					num++;
-				}
-			}
-pause_bind_walk:
-			spin_unlock_bh(&ibb->lock);
-
-			res = 0;
-			for (idx = 0; idx < accum; idx++) {
-				if (res >= 0) {
-					res = inet_sk_diag_fill(sk_arr[idx],
-								NULL, skb, cb,
-								r, NLM_F_MULTI,
-								net_admin);
-					if (res < 0)
-						num = num_arr[idx];
-				}
-				sock_put(sk_arr[idx]);
-			}
-			if (res < 0)
-				goto done;
-
-			cond_resched();
-
-			if (accum == SKARR_SZ) {
-				s_num = num + 1;
-				goto resume_bind_walk;
-			}
-
-			s_num = 0;
-		}
-skip_bind_ht:
-		cb->args[0] = 2;
-		s_i = num = s_num = 0;
-	}
-
-	if (!(idiag_states & ~TCPF_LISTEN))
-		goto out;
-
-	for (i = s_i; i <= hashinfo->ehash_mask; i++) {
-		struct inet_ehash_bucket *head = &hashinfo->ehash[i];
-		spinlock_t *lock = inet_ehash_lockp(hashinfo, i);
-		struct hlist_nulls_node *node;
-		struct sock *sk_arr[SKARR_SZ];
-		int num_arr[SKARR_SZ];
-		int idx, accum, res;
-
-		if (hlist_nulls_empty(&head->chain))
-			continue;
-
-		if (i > s_i)
-			s_num = 0;
-
-next_chunk:
-		num = 0;
-		accum = 0;
-		spin_lock_bh(lock);
-		sk_nulls_for_each(sk, node, &head->chain) {
-			int state;
-
-			if (!net_eq(sock_net(sk), net))
-				continue;
-			if (num < s_num)
-				goto next_normal;
-			state = (sk->sk_state == TCP_TIME_WAIT) ?
-				READ_ONCE(inet_twsk(sk)->tw_substate) : sk->sk_state;
-			if (!(idiag_states & (1 << state)))
-				goto next_normal;
-			if (r->sdiag_family != AF_UNSPEC &&
-			    sk->sk_family != r->sdiag_family)
-				goto next_normal;
-			if (r->id.idiag_sport != htons(sk->sk_num) &&
-			    r->id.idiag_sport)
-				goto next_normal;
-			if (r->id.idiag_dport != sk->sk_dport &&
-			    r->id.idiag_dport)
-				goto next_normal;
-			twsk_build_assert();
-
-			if (!inet_diag_bc_sk(bc, sk))
-				goto next_normal;
-
-			if (!refcount_inc_not_zero(&sk->sk_refcnt))
-				goto next_normal;
-
-			num_arr[accum] = num;
-			sk_arr[accum] = sk;
-			if (++accum == SKARR_SZ)
-				break;
-next_normal:
-			++num;
-		}
-		spin_unlock_bh(lock);
-		res = 0;
-		for (idx = 0; idx < accum; idx++) {
-			if (res >= 0) {
-				res = sk_diag_fill(sk_arr[idx], skb, cb, r,
-						   NLM_F_MULTI, net_admin);
-				if (res < 0)
-					num = num_arr[idx];
-			}
-			sock_gen_put(sk_arr[idx]);
-		}
-		if (res < 0)
-			break;
-		cond_resched();
-		if (accum == SKARR_SZ) {
-			s_num = num + 1;
-			goto next_chunk;
-		}
-	}
-
-done:
-	cb->args[1] = i;
-	cb->args[2] = num;
-out:
-	;
-}
-EXPORT_SYMBOL_GPL(inet_diag_dump_icsk);
-
 static int __inet_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 			    const struct inet_diag_req_v2 *r)
 {
diff --git a/net/ipv4/tcp_diag.c b/net/ipv4/tcp_diag.c
index 7cd9d032efdd..2f3a779ce7a2 100644
--- a/net/ipv4/tcp_diag.c
+++ b/net/ipv4/tcp_diag.c
@@ -12,6 +12,9 @@
 
 #include <linux/tcp.h>
 
+#include <net/inet_hashtables.h>
+#include <net/inet6_hashtables.h>
+#include <net/inet_timewait_sock.h>
 #include <net/netlink.h>
 #include <net/tcp.h>
 
@@ -174,19 +177,467 @@ static size_t tcp_diag_get_aux_size(struct sock *sk, bool net_admin)
 				size += ulp_ops->get_info_size(sk, net_admin);
 		}
 	}
-	return size;
+
+	return size
+		+ nla_total_size(sizeof(struct tcp_info))
+		+ nla_total_size(sizeof(struct inet_diag_msg))
+		+ inet_diag_msg_attrs_size()
+		+ nla_total_size(sizeof(struct inet_diag_meminfo))
+		+ nla_total_size(SK_MEMINFO_VARS * sizeof(u32))
+		+ nla_total_size(TCP_CA_NAME_MAX)
+		+ nla_total_size(sizeof(struct tcpvegas_info))
+		+ 64;
+}
+
+static int tcp_twsk_diag_fill(struct sock *sk,
+			      struct sk_buff *skb,
+			      struct netlink_callback *cb,
+			      u16 nlmsg_flags, bool net_admin)
+{
+	struct inet_timewait_sock *tw = inet_twsk(sk);
+	struct inet_diag_msg *r;
+	struct nlmsghdr *nlh;
+	long tmo;
+
+	nlh = nlmsg_put(skb, NETLINK_CB(cb->skb).portid,
+			cb->nlh->nlmsg_seq, cb->nlh->nlmsg_type,
+			sizeof(*r), nlmsg_flags);
+	if (!nlh)
+		return -EMSGSIZE;
+
+	r = nlmsg_data(nlh);
+	DEBUG_NET_WARN_ON_ONCE(tw->tw_state != TCP_TIME_WAIT);
+
+	inet_diag_msg_common_fill(r, sk);
+	r->idiag_retrans      = 0;
+
+	r->idiag_state	      = READ_ONCE(tw->tw_substate);
+	r->idiag_timer	      = 3;
+	tmo = tw->tw_timer.expires - jiffies;
+	r->idiag_expires      = jiffies_delta_to_msecs(tmo);
+	r->idiag_rqueue	      = 0;
+	r->idiag_wqueue	      = 0;
+	r->idiag_uid	      = 0;
+	r->idiag_inode	      = 0;
+
+	if (net_admin && nla_put_u32(skb, INET_DIAG_MARK,
+				     tw->tw_mark)) {
+		nlmsg_cancel(skb, nlh);
+		return -EMSGSIZE;
+	}
+
+	nlmsg_end(skb, nlh);
+	return 0;
+}
+
+static int tcp_req_diag_fill(struct sock *sk, struct sk_buff *skb,
+			     struct netlink_callback *cb,
+			     u16 nlmsg_flags, bool net_admin)
+{
+	struct request_sock *reqsk = inet_reqsk(sk);
+	struct inet_diag_msg *r;
+	struct nlmsghdr *nlh;
+	long tmo;
+
+	nlh = nlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
+			cb->nlh->nlmsg_type, sizeof(*r), nlmsg_flags);
+	if (!nlh)
+		return -EMSGSIZE;
+
+	r = nlmsg_data(nlh);
+	inet_diag_msg_common_fill(r, sk);
+	r->idiag_state = TCP_SYN_RECV;
+	r->idiag_timer = 1;
+	r->idiag_retrans = reqsk->num_retrans;
+
+	BUILD_BUG_ON(offsetof(struct inet_request_sock, ir_cookie) !=
+		     offsetof(struct sock, sk_cookie));
+
+	tmo = inet_reqsk(sk)->rsk_timer.expires - jiffies;
+	r->idiag_expires = jiffies_delta_to_msecs(tmo);
+	r->idiag_rqueue	= 0;
+	r->idiag_wqueue	= 0;
+	r->idiag_uid	= 0;
+	r->idiag_inode	= 0;
+
+	if (net_admin && nla_put_u32(skb, INET_DIAG_MARK,
+				     inet_rsk(reqsk)->ir_mark)) {
+		nlmsg_cancel(skb, nlh);
+		return -EMSGSIZE;
+	}
+
+	nlmsg_end(skb, nlh);
+	return 0;
+}
+
+static int sk_diag_fill(struct sock *sk, struct sk_buff *skb,
+			struct netlink_callback *cb,
+			const struct inet_diag_req_v2 *r,
+			u16 nlmsg_flags, bool net_admin)
+{
+	if (sk->sk_state == TCP_TIME_WAIT)
+		return tcp_twsk_diag_fill(sk, skb, cb, nlmsg_flags, net_admin);
+
+	if (sk->sk_state == TCP_NEW_SYN_RECV)
+		return tcp_req_diag_fill(sk, skb, cb, nlmsg_flags, net_admin);
+
+	return inet_sk_diag_fill(sk, inet_csk(sk), skb, cb, r, nlmsg_flags,
+				 net_admin);
+}
+
+static void twsk_build_assert(void)
+{
+	BUILD_BUG_ON(offsetof(struct inet_timewait_sock, tw_family) !=
+		     offsetof(struct sock, sk_family));
+
+	BUILD_BUG_ON(offsetof(struct inet_timewait_sock, tw_num) !=
+		     offsetof(struct inet_sock, inet_num));
+
+	BUILD_BUG_ON(offsetof(struct inet_timewait_sock, tw_dport) !=
+		     offsetof(struct inet_sock, inet_dport));
+
+	BUILD_BUG_ON(offsetof(struct inet_timewait_sock, tw_rcv_saddr) !=
+		     offsetof(struct inet_sock, inet_rcv_saddr));
+
+	BUILD_BUG_ON(offsetof(struct inet_timewait_sock, tw_daddr) !=
+		     offsetof(struct inet_sock, inet_daddr));
+
+#if IS_ENABLED(CONFIG_IPV6)
+	BUILD_BUG_ON(offsetof(struct inet_timewait_sock, tw_v6_rcv_saddr) !=
+		     offsetof(struct sock, sk_v6_rcv_saddr));
+
+	BUILD_BUG_ON(offsetof(struct inet_timewait_sock, tw_v6_daddr) !=
+		     offsetof(struct sock, sk_v6_daddr));
+#endif
 }
 
 static void tcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 			  const struct inet_diag_req_v2 *r)
 {
-	inet_diag_dump_icsk(skb, cb, r);
+	bool net_admin = netlink_net_capable(cb->skb, CAP_NET_ADMIN);
+	struct inet_diag_dump_data *cb_data = cb->data;
+	struct net *net = sock_net(skb->sk);
+	u32 idiag_states = r->idiag_states;
+	struct inet_hashinfo *hashinfo;
+	int i, num, s_i, s_num;
+	struct nlattr *bc;
+	struct sock *sk;
+
+	hashinfo = net->ipv4.tcp_death_row.hashinfo;
+	bc = cb_data->inet_diag_nla_bc;
+	if (idiag_states & TCPF_SYN_RECV)
+		idiag_states |= TCPF_NEW_SYN_RECV;
+	s_i = cb->args[1];
+	s_num = num = cb->args[2];
+
+	if (cb->args[0] == 0) {
+		if (!(idiag_states & TCPF_LISTEN) || r->id.idiag_dport)
+			goto skip_listen_ht;
+
+		for (i = s_i; i <= hashinfo->lhash2_mask; i++) {
+			struct inet_listen_hashbucket *ilb;
+			struct hlist_nulls_node *node;
+
+			num = 0;
+			ilb = &hashinfo->lhash2[i];
+
+			if (hlist_nulls_empty(&ilb->nulls_head)) {
+				s_num = 0;
+				continue;
+			}
+			spin_lock(&ilb->lock);
+			sk_nulls_for_each(sk, node, &ilb->nulls_head) {
+				struct inet_sock *inet = inet_sk(sk);
+
+				if (!net_eq(sock_net(sk), net))
+					continue;
+
+				if (num < s_num) {
+					num++;
+					continue;
+				}
+
+				if (r->sdiag_family != AF_UNSPEC &&
+				    sk->sk_family != r->sdiag_family)
+					goto next_listen;
+
+				if (r->id.idiag_sport != inet->inet_sport &&
+				    r->id.idiag_sport)
+					goto next_listen;
+
+				if (!inet_diag_bc_sk(bc, sk))
+					goto next_listen;
+
+				if (inet_sk_diag_fill(sk, inet_csk(sk), skb,
+						      cb, r, NLM_F_MULTI,
+						      net_admin) < 0) {
+					spin_unlock(&ilb->lock);
+					goto done;
+				}
+
+next_listen:
+				++num;
+			}
+			spin_unlock(&ilb->lock);
+
+			s_num = 0;
+		}
+skip_listen_ht:
+		cb->args[0] = 1;
+		s_i = num = s_num = 0;
+	}
+
+/* Process a maximum of SKARR_SZ sockets at a time when walking hash buckets
+ * with bh disabled.
+ */
+#define SKARR_SZ 16
+
+	/* Dump bound but inactive (not listening, connecting, etc.) sockets */
+	if (cb->args[0] == 1) {
+		if (!(idiag_states & TCPF_BOUND_INACTIVE))
+			goto skip_bind_ht;
+
+		for (i = s_i; i < hashinfo->bhash_size; i++) {
+			struct inet_bind_hashbucket *ibb;
+			struct inet_bind2_bucket *tb2;
+			struct sock *sk_arr[SKARR_SZ];
+			int num_arr[SKARR_SZ];
+			int idx, accum, res;
+
+resume_bind_walk:
+			num = 0;
+			accum = 0;
+			ibb = &hashinfo->bhash2[i];
+
+			if (hlist_empty(&ibb->chain)) {
+				s_num = 0;
+				continue;
+			}
+			spin_lock_bh(&ibb->lock);
+			inet_bind_bucket_for_each(tb2, &ibb->chain) {
+				if (!net_eq(ib2_net(tb2), net))
+					continue;
+
+				sk_for_each_bound(sk, &tb2->owners) {
+					struct inet_sock *inet = inet_sk(sk);
+
+					if (num < s_num)
+						goto next_bind;
+
+					if (sk->sk_state != TCP_CLOSE ||
+					    !inet->inet_num)
+						goto next_bind;
+
+					if (r->sdiag_family != AF_UNSPEC &&
+					    r->sdiag_family != sk->sk_family)
+						goto next_bind;
+
+					if (!inet_diag_bc_sk(bc, sk))
+						goto next_bind;
+
+					sock_hold(sk);
+					num_arr[accum] = num;
+					sk_arr[accum] = sk;
+					if (++accum == SKARR_SZ)
+						goto pause_bind_walk;
+next_bind:
+					num++;
+				}
+			}
+pause_bind_walk:
+			spin_unlock_bh(&ibb->lock);
+
+			res = 0;
+			for (idx = 0; idx < accum; idx++) {
+				if (res >= 0) {
+					res = inet_sk_diag_fill(sk_arr[idx],
+								NULL, skb, cb,
+								r, NLM_F_MULTI,
+								net_admin);
+					if (res < 0)
+						num = num_arr[idx];
+				}
+				sock_put(sk_arr[idx]);
+			}
+			if (res < 0)
+				goto done;
+
+			cond_resched();
+
+			if (accum == SKARR_SZ) {
+				s_num = num + 1;
+				goto resume_bind_walk;
+			}
+
+			s_num = 0;
+		}
+skip_bind_ht:
+		cb->args[0] = 2;
+		s_i = num = s_num = 0;
+	}
+
+	if (!(idiag_states & ~TCPF_LISTEN))
+		goto out;
+
+	for (i = s_i; i <= hashinfo->ehash_mask; i++) {
+		struct inet_ehash_bucket *head = &hashinfo->ehash[i];
+		spinlock_t *lock = inet_ehash_lockp(hashinfo, i);
+		struct hlist_nulls_node *node;
+		struct sock *sk_arr[SKARR_SZ];
+		int num_arr[SKARR_SZ];
+		int idx, accum, res;
+
+		if (hlist_nulls_empty(&head->chain))
+			continue;
+
+		if (i > s_i)
+			s_num = 0;
+
+next_chunk:
+		num = 0;
+		accum = 0;
+		spin_lock_bh(lock);
+		sk_nulls_for_each(sk, node, &head->chain) {
+			int state;
+
+			if (!net_eq(sock_net(sk), net))
+				continue;
+			if (num < s_num)
+				goto next_normal;
+			state = (sk->sk_state == TCP_TIME_WAIT) ?
+				READ_ONCE(inet_twsk(sk)->tw_substate) : sk->sk_state;
+			if (!(idiag_states & (1 << state)))
+				goto next_normal;
+			if (r->sdiag_family != AF_UNSPEC &&
+			    sk->sk_family != r->sdiag_family)
+				goto next_normal;
+			if (r->id.idiag_sport != htons(sk->sk_num) &&
+			    r->id.idiag_sport)
+				goto next_normal;
+			if (r->id.idiag_dport != sk->sk_dport &&
+			    r->id.idiag_dport)
+				goto next_normal;
+			twsk_build_assert();
+
+			if (!inet_diag_bc_sk(bc, sk))
+				goto next_normal;
+
+			if (!refcount_inc_not_zero(&sk->sk_refcnt))
+				goto next_normal;
+
+			num_arr[accum] = num;
+			sk_arr[accum] = sk;
+			if (++accum == SKARR_SZ)
+				break;
+next_normal:
+			++num;
+		}
+		spin_unlock_bh(lock);
+
+		res = 0;
+		for (idx = 0; idx < accum; idx++) {
+			if (res >= 0) {
+				res = sk_diag_fill(sk_arr[idx], skb, cb, r,
+						   NLM_F_MULTI, net_admin);
+				if (res < 0)
+					num = num_arr[idx];
+			}
+			sock_gen_put(sk_arr[idx]);
+		}
+		if (res < 0)
+			break;
+
+		cond_resched();
+
+		if (accum == SKARR_SZ) {
+			s_num = num + 1;
+			goto next_chunk;
+		}
+	}
+
+done:
+	cb->args[1] = i;
+	cb->args[2] = num;
+out:
+	;
+}
+
+static struct sock *tcp_diag_find_one_icsk(struct net *net,
+					   const struct inet_diag_req_v2 *req)
+{
+	struct sock *sk;
+
+	rcu_read_lock();
+	if (req->sdiag_family == AF_INET) {
+		sk = inet_lookup(net, NULL, 0, req->id.idiag_dst[0],
+				 req->id.idiag_dport, req->id.idiag_src[0],
+				 req->id.idiag_sport, req->id.idiag_if);
+#if IS_ENABLED(CONFIG_IPV6)
+	} else if (req->sdiag_family == AF_INET6) {
+		if (ipv6_addr_v4mapped((struct in6_addr *)req->id.idiag_dst) &&
+		    ipv6_addr_v4mapped((struct in6_addr *)req->id.idiag_src))
+			sk = inet_lookup(net, NULL, 0, req->id.idiag_dst[3],
+					 req->id.idiag_dport, req->id.idiag_src[3],
+					 req->id.idiag_sport, req->id.idiag_if);
+		else
+			sk = inet6_lookup(net, NULL, 0,
+					  (struct in6_addr *)req->id.idiag_dst,
+					  req->id.idiag_dport,
+					  (struct in6_addr *)req->id.idiag_src,
+					  req->id.idiag_sport,
+					  req->id.idiag_if);
+#endif
+	} else {
+		rcu_read_unlock();
+		return ERR_PTR(-EINVAL);
+	}
+	rcu_read_unlock();
+	if (!sk)
+		return ERR_PTR(-ENOENT);
+
+	if (sock_diag_check_cookie(sk, req->id.idiag_cookie)) {
+		sock_gen_put(sk);
+		return ERR_PTR(-ENOENT);
+	}
+
+	return sk;
 }
 
 static int tcp_diag_dump_one(struct netlink_callback *cb,
 			     const struct inet_diag_req_v2 *req)
 {
-	return inet_diag_dump_one_icsk(cb, req);
+	struct sk_buff *in_skb = cb->skb;
+	struct sk_buff *rep;
+	struct sock *sk;
+	struct net *net;
+	bool net_admin;
+	int err;
+
+	net = sock_net(in_skb->sk);
+	sk = tcp_diag_find_one_icsk(net, req);
+	if (IS_ERR(sk))
+		return PTR_ERR(sk);
+
+	net_admin = netlink_net_capable(in_skb, CAP_NET_ADMIN);
+	rep = nlmsg_new(tcp_diag_get_aux_size(sk, net_admin), GFP_KERNEL);
+	if (!rep) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	err = sk_diag_fill(sk, rep, cb, req, 0, net_admin);
+	if (err < 0) {
+		WARN_ON(err == -EMSGSIZE);
+		nlmsg_free(rep);
+		goto out;
+	}
+	err = nlmsg_unicast(net->diag_nlsk, rep, NETLINK_CB(in_skb).portid);
+
+out:
+	if (sk)
+		sock_gen_put(sk);
+
+	return err;
 }
 
 #ifdef CONFIG_INET_DIAG_DESTROY
@@ -197,7 +648,7 @@ static int tcp_diag_destroy(struct sk_buff *in_skb,
 	struct sock *sk;
 	int err;
 
-	sk = inet_diag_find_one_icsk(net, req);
+	sk = tcp_diag_find_one_icsk(net, req);
 	if (IS_ERR(sk))
 		return PTR_ERR(sk);
 
@@ -215,7 +666,6 @@ static const struct inet_diag_handler tcp_diag_handler = {
 	.dump_one		= tcp_diag_dump_one,
 	.idiag_get_info		= tcp_diag_get_info,
 	.idiag_get_aux		= tcp_diag_get_aux,
-	.idiag_get_aux_size	= tcp_diag_get_aux_size,
 	.idiag_type		= IPPROTO_TCP,
 	.idiag_info_size	= sizeof(struct tcp_info),
 #ifdef CONFIG_INET_DIAG_DESTROY
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


