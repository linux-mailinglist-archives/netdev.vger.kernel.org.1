Return-Path: <netdev+bounces-295367-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /hCLJnu3IWpcMQEAu9opvQ
	(envelope-from <netdev+bounces-295367-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 19:35:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1504364254A
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 19:35:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="vP5r8Iu/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295367-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295367-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE03430138A2
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 17:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9791C3A4F36;
	Thu,  4 Jun 2026 17:34:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f73.google.com (mail-vs1-f73.google.com [209.85.217.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E77C40F8D6
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 17:34:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780594457; cv=none; b=hGFpNWEchzKdRxRsZUsEJLJ0aDiR7rRwU+SsxOsiopoVVZurMfozU0sN4GXynWf34BipAw/ShLxu0HIora43MHbkIPtLfXAkjL6FGt3nv+BrUjKT9x/mpBfv+oNxIaS19fNm0hPf8IQAqfpwGTfLF3hb+ruV5L+PKTUrf4y1GmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780594457; c=relaxed/simple;
	bh=6tC+1wkf1VdbGfTG0QkQBUqZWeEfK9bZ6jgPuZLqQW4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Saw75KK3tXtfEGqmdfleSqBDe+++YxxnBs4zSJ5ajlbq0klnWmA+hZKY0EhyDFFRDWHgai/pySID5f5XcyzQL5GINB/mAZP/XnfG92AsYDKdMxFWojp3x5ZiYwBNWaR15N6SqzyFjmhdrpgphIun1B/gmO/EdwSGn1vhzfBdZK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vP5r8Iu/; arc=none smtp.client-ip=209.85.217.73
Received: by mail-vs1-f73.google.com with SMTP id ada2fe7eead31-6751c50552dso565063137.2
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 10:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780594455; x=1781199255; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OyYscCiHWrEf9Tqb4of5uAilULIbQexBcezGvW3rcyk=;
        b=vP5r8Iu/KLRqK5Vwx/AZq8JwbUURUcCj7J9c4spc9XANWPnWlVVG/nqHlcx6gxl6AT
         uYgWVtyK1BdAdnsCRH0jm/7CAaRMHFEV6I8GH7ZN3jSVlfDF3q2fPdV8VWv1xdX1UiqW
         XL87PSzPNNXwLpNi+q+LZAzkiSF1PXD1/zyu5MbaCSZ+yj3dvS+ZI51WqPwG25LhtQv6
         w5TrBQMQJUz8Kqrpf18wmduoXvrRJoCjsFHvJIq6Y8UExCR9gUJLAOiHqWAzZJHyi+d5
         qt3Bf9TQXtPFEwDkqufvdS2TyFJfV21dwvNLy8vN+Y2x0yyVo5s0RtZC7nUFC4PAeDSy
         Z9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780594455; x=1781199255;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OyYscCiHWrEf9Tqb4of5uAilULIbQexBcezGvW3rcyk=;
        b=n40DzDpSRnJuanQRALJXNQ3TQFAKYYgBeBN9wSzxm0lD1jvXzZFG4NCVHzdjjYCN6G
         gzO+ecZbMem6VytHb498oYxv4dLlurr6E0gyPKqyxsQ1WRn4+I3Un2FsDvOtQVYfuQ7z
         ZFtHNCMsrDj+EQ6xqUFMzjpVNke6kglM/gPIw6Ui74bhHQv9Yxre6PaF0bw/lhKNRE8S
         jEaCDB7l05b4XHObmtEHU9vSmGqln+aD50cVNsY3RS32d6/sxKIuNjoQLuqUcnvS28WH
         YoMrOuS5JrmEbUCLXkwmF7EV4dwOaEAbFXkYYk6StEFEWs+epdPy6wAcqRu1om/5t2aI
         Q8SA==
X-Forwarded-Encrypted: i=1; AFNElJ/y4cVUAMFCl1Gqg4Ranchhs6LsamPMSC09yYxzxEW/iOmM8akeM4CeaaHUO+KY7UftLNOTbII=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw+bqYLJarr6Xy05O01tqNC7dz38lB93T/7xvpfknX/MRHNfPX
	unF8+Cs1cZxAG4ELU0izGmo4Q3Hp/6cp4I/tR5h4dAFEMgsO4HGVf4tNpDbvZDZPAjMcNWlAVEm
	4uCE3R74cg4AMTg==
X-Received: from qvblx5.prod.google.com ([2002:a05:6214:5f05:b0:8bb:bac0:7879])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:3594:b0:607:4fde:1921 with SMTP id ada2fe7eead31-6ec490c3d34mr4611692137.24.1780594454762;
 Thu, 04 Jun 2026 10:34:14 -0700 (PDT)
Date: Thu,  4 Jun 2026 17:34:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604173413.2782008-1-edumazet@google.com>
Subject: [PATCH net-next] ipv4: remove obsolete EXPORT_SYMBOL() and EXPORT_SYMBOL_GPL()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295367-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:dsahern@kernel.org,m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1504364254A

These symbols no longer need to be exported, they are only used from
vmlinux:

- inet_send_prepare
- inet_splice_eof
- inet_sk_rebuild_header
- inet_current_timestamp
- snmp_fold_field
- snmp_get_cpu_field64
- snmp_fold_field64
- fib_nh_common_release
- fib_nh_common_init
- fib_nexthop_info
- fib_add_nexthop
- ip_build_and_send_pkt
- ipv4_sk_update_pmtu
- ipv4_sk_redirect
- rt_dst_clone

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/af_inet.c       | 7 -------
 net/ipv4/fib_semantics.c | 4 ----
 net/ipv4/ip_output.c     | 1 -
 net/ipv4/route.c         | 3 ---
 4 files changed, 15 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index cbac072633bb57fd68131904fa3eff24265696d9..32d006c1a8eedad9ede42445f6a93d47bca7fc52 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -852,7 +852,6 @@ int inet_send_prepare(struct sock *sk)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(inet_send_prepare);
 
 int inet_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 {
@@ -881,7 +880,6 @@ void inet_splice_eof(struct socket *sock)
 	if (prot->splice_eof)
 		prot->splice_eof(sock);
 }
-EXPORT_SYMBOL_GPL(inet_splice_eof);
 
 int inet_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 		 int flags)
@@ -1349,7 +1347,6 @@ int inet_sk_rebuild_header(struct sock *sk)
 
 	return err;
 }
-EXPORT_SYMBOL(inet_sk_rebuild_header);
 
 void inet_sk_set_state(struct sock *sk, int state)
 {
@@ -1579,7 +1576,6 @@ __be32 inet_current_timestamp(void)
 	/* Convert to network byte order. */
 	return htonl(msecs);
 }
-EXPORT_SYMBOL(inet_current_timestamp);
 
 int inet_recv_error(struct sock *sk, struct msghdr *msg, int len)
 {
@@ -1665,7 +1661,6 @@ unsigned long snmp_fold_field(void __percpu *mib, int offt)
 		res += snmp_get_cpu_field(mib, i, offt);
 	return res;
 }
-EXPORT_SYMBOL_GPL(snmp_fold_field);
 
 #if BITS_PER_LONG==32
 
@@ -1686,7 +1681,6 @@ u64 snmp_get_cpu_field64(void __percpu *mib, int cpu, int offt,
 
 	return v;
 }
-EXPORT_SYMBOL_GPL(snmp_get_cpu_field64);
 
 u64 snmp_fold_field64(void __percpu *mib, int offt, size_t syncp_offset)
 {
@@ -1698,7 +1692,6 @@ u64 snmp_fold_field64(void __percpu *mib, int offt, size_t syncp_offset)
 	}
 	return res;
 }
-EXPORT_SYMBOL_GPL(snmp_fold_field64);
 #endif
 
 #ifdef CONFIG_IP_MULTICAST
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 3e8fadc28798786d76cb476c88ae1d4bd5d5f427..4f3c0740dde913fcc7c747b8ffae68d3ca4a9f69 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -207,7 +207,6 @@ void fib_nh_common_release(struct fib_nh_common *nhc)
 	rt_fibinfo_free(&nhc->nhc_rth_input);
 	free_nh_exceptions(nhc);
 }
-EXPORT_SYMBOL_GPL(fib_nh_common_release);
 
 void fib_nh_release(struct net *net, struct fib_nh *fib_nh)
 {
@@ -639,7 +638,6 @@ int fib_nh_common_init(struct net *net, struct fib_nh_common *nhc,
 	nhc->nhc_pcpu_rth_output = NULL;
 	return err;
 }
-EXPORT_SYMBOL_GPL(fib_nh_common_init);
 
 int fib_nh_init(struct net *net, struct fib_nh *nh,
 		struct fib_config *cfg, int nh_weight,
@@ -1642,7 +1640,6 @@ int fib_nexthop_info(struct sk_buff *skb, const struct fib_nh_common *nhc,
 nla_put_failure:
 	return -EMSGSIZE;
 }
-EXPORT_SYMBOL_GPL(fib_nexthop_info);
 
 #if IS_ENABLED(CONFIG_IP_ROUTE_MULTIPATH) || IS_ENABLED(CONFIG_IPV6)
 int fib_add_nexthop(struct sk_buff *skb, const struct fib_nh_common *nhc,
@@ -1675,7 +1672,6 @@ int fib_add_nexthop(struct sk_buff *skb, const struct fib_nh_common *nhc,
 nla_put_failure:
 	return -EMSGSIZE;
 }
-EXPORT_SYMBOL_GPL(fib_add_nexthop);
 #endif
 
 #ifdef CONFIG_IP_ROUTE_MULTIPATH
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 5bcd73cbdb41c0d402c025cc449a9f84fd2833e0..3b4e9b8af044f19d76802abf519228ca6496e600 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -195,7 +195,6 @@ int ip_build_and_send_pkt(struct sk_buff *skb, const struct sock *sk,
 	/* Send it out. */
 	return ip_local_out(net, skb->sk, skb);
 }
-EXPORT_SYMBOL_GPL(ip_build_and_send_pkt);
 
 static int ip_finish_output2(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 3d62d45d84bda986db8b3592c0c7f5c81da3fb7e..3f3de5164d6e5854cae3ebe6fcecbac10fb63418 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1171,7 +1171,6 @@ void ipv4_sk_update_pmtu(struct sk_buff *skb, struct sock *sk, u32 mtu)
 	bh_unlock_sock(sk);
 	dst_release(odst);
 }
-EXPORT_SYMBOL_GPL(ipv4_sk_update_pmtu);
 
 void ipv4_redirect(struct sk_buff *skb, struct net *net,
 		   int oif, u8 protocol)
@@ -1203,7 +1202,6 @@ void ipv4_sk_redirect(struct sk_buff *skb, struct sock *sk)
 		ip_rt_put(rt);
 	}
 }
-EXPORT_SYMBOL_GPL(ipv4_sk_redirect);
 
 INDIRECT_CALLABLE_SCOPE struct dst_entry *ipv4_dst_check(struct dst_entry *dst,
 							 u32 cookie)
@@ -1701,7 +1699,6 @@ struct rtable *rt_dst_clone(struct net_device *dev, struct rtable *rt)
 	}
 	return new_rt;
 }
-EXPORT_SYMBOL(rt_dst_clone);
 
 /* called in rcu_read_lock() section */
 enum skb_drop_reason
-- 
2.54.0.1032.g2f8565e1d1-goog


