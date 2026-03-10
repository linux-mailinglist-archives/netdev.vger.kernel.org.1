Return-Path: <netdev+bounces-266221-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OGXNGlCsGlLhgIAu9opvQ
	(envelope-from <netdev+bounces-266221-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:10:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8790025458A
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24ED1322233A
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 15:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F0039DBD6;
	Tue, 10 Mar 2026 15:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1E0gHEOA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pPs1o8Zn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1E0gHEOA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pPs1o8Zn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998052FCC0E
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 15:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773157038; cv=none; b=kE/ePoKYEeth90mLQa0BzJt+NibR4XfSQWCnwpvAMbkIm3wY0tyQzWIhBiX6v1K8meHHqv08upzTDv9keTttN9bbsJ4AJAauUXxnTrbELrxf34ndoOAoI7rr1D8kBXtj8b823n43OJvd5ERj9lH9wpKb3dCXh73k2XcrDD5WgV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773157038; c=relaxed/simple;
	bh=tXnC+mRhOEJIUco5PNvFuwhlaYt+PkjhivXPQWycwoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ms2nEIs6kuKTS2yCKdR0byJ3+5QbQ6nONpmFzKWneKE3S19yyKpNJ5rxZXCuCOseR440URJSD8/XqzNfAyRX6mM7DF69w7IafVJwewVm3kEHu6cDlnOo/MSXVPWlhjhGyp3fhjCaJETYDeM1OdEy+ML3G8tLnHUmQEtqgjc67Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1E0gHEOA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pPs1o8Zn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1E0gHEOA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pPs1o8Zn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6830C4D29A;
	Tue, 10 Mar 2026 15:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773157028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f1iETLctJVVn7vnC8f2JMVjCWG8T9RydkR7KCN5s1Vc=;
	b=1E0gHEOAPNV/xzJEzT2WI0OwQYu9vfJhrsJJ8yxVLsu9kCkQVjfNczfyw+EUreg+lOvNot
	phAqVOi2xnzUt1ZcQ2wrBBZQNzFKoxUFdVMwq3CfJSyGGp7p1hJZtuJkLhKHOD4JVnxlxR
	2SFYRANrENTVh9lcQgJI+Z07CGKumQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773157028;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f1iETLctJVVn7vnC8f2JMVjCWG8T9RydkR7KCN5s1Vc=;
	b=pPs1o8ZnD5i1sF0QRj4YLzjj0K5LerLjFuAiPMq9NMzC38axuXuPR1MeMvBWgi4URqlmUa
	5eBNfZqL+krc/1BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773157028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f1iETLctJVVn7vnC8f2JMVjCWG8T9RydkR7KCN5s1Vc=;
	b=1E0gHEOAPNV/xzJEzT2WI0OwQYu9vfJhrsJJ8yxVLsu9kCkQVjfNczfyw+EUreg+lOvNot
	phAqVOi2xnzUt1ZcQ2wrBBZQNzFKoxUFdVMwq3CfJSyGGp7p1hJZtuJkLhKHOD4JVnxlxR
	2SFYRANrENTVh9lcQgJI+Z07CGKumQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773157028;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f1iETLctJVVn7vnC8f2JMVjCWG8T9RydkR7KCN5s1Vc=;
	b=pPs1o8ZnD5i1sF0QRj4YLzjj0K5LerLjFuAiPMq9NMzC38axuXuPR1MeMvBWgi4URqlmUa
	5eBNfZqL+krc/1BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 06EBB3F519;
	Tue, 10 Mar 2026 15:37:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kN7yOaI6sGlKXwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 10 Mar 2026 15:37:06 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: rbm@suse.com,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools))
Subject: [PATCH 02/10 net-next v2] ipv6: replace IS_BUILTIN(CONFIG_IPV6) with IS_ENABLED(CONFIG_IPV6)
Date: Tue, 10 Mar 2026 16:34:25 +0100
Message-ID: <20260310153506.5181-3-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310153506.5181-1-fmancera@suse.de>
References: <20260310153506.5181-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -5.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 8790025458A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.com,suse.de,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,gmail.com,fomichev.me,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266221-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.de:dkim,suse.de:email,suse.de:mid]
X-Rspamd-Action: no action

As IPv6 is built-in only, it does not make sense to continue using
IS_BUILTIN(CONFIG_IPV6). Therefore, replace it with IS_ENABLED() when
necessary and drop it if it isn't valid anymore.

Notice that there is still one instance related to ICMPv6, as it
requires more changes it will be handle separately.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: no changes
---
 include/linux/indirect_call_wrapper.h |  2 +-
 include/net/ip6_fib.h                 |  2 +-
 net/core/filter.c                     | 14 +++++++-------
 net/ipv6/ip6_fib.c                    |  2 +-
 net/ipv6/ip6_offload.c                |  4 ++--
 net/ipv6/route.c                      |  6 +++---
 6 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/indirect_call_wrapper.h b/include/linux/indirect_call_wrapper.h
index dc272b514a01..0e4340ecd857 100644
--- a/include/linux/indirect_call_wrapper.h
+++ b/include/linux/indirect_call_wrapper.h
@@ -57,7 +57,7 @@
  * builtin, this macro simplify dealing with indirect calls with only ipv4/ipv6
  * alternatives
  */
-#if IS_BUILTIN(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_IPV6)
 #define INDIRECT_CALL_INET(f, f2, f1, ...) \
 	INDIRECT_CALL_2(f, f2, f1, __VA_ARGS__)
 #elif IS_ENABLED(CONFIG_INET)
diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index 88b0dd4d8e09..39c98c3d8ac5 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -580,7 +580,7 @@ static inline bool fib6_metric_locked(struct fib6_info *f6i, int metric)
 void fib6_info_hw_flags_set(struct net *net, struct fib6_info *f6i,
 			    bool offload, bool trap, bool offload_failed);
 
-#if IS_BUILTIN(CONFIG_IPV6) && defined(CONFIG_BPF_SYSCALL)
+#if IS_ENABLED(CONFIG_IPV6) && defined(CONFIG_BPF_SYSCALL)
 struct bpf_iter__ipv6_route {
 	__bpf_md_ptr(struct bpf_iter_meta *, meta);
 	__bpf_md_ptr(struct fib6_info *, rt);
diff --git a/net/core/filter.c b/net/core/filter.c
index a77d23fe2359..62cae2bcc562 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7584,7 +7584,7 @@ BPF_CALL_5(bpf_tcp_check_syncookie, struct sock *, sk, void *, iph, u32, iph_len
 		ret = __cookie_v4_check((struct iphdr *)iph, th);
 		break;
 
-#if IS_BUILTIN(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_IPV6)
 	case 6:
 		if (unlikely(iph_len < sizeof(struct ipv6hdr)))
 			return -EINVAL;
@@ -7654,7 +7654,7 @@ BPF_CALL_5(bpf_tcp_gen_syncookie, struct sock *, sk, void *, iph, u32, iph_len,
 		mss = tcp_v4_get_syncookie(sk, iph, th, &cookie);
 		break;
 
-#if IS_BUILTIN(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_IPV6)
 	case 6:
 		if (unlikely(iph_len < sizeof(struct ipv6hdr)))
 			return -EINVAL;
@@ -8020,7 +8020,7 @@ static const struct bpf_func_proto bpf_tcp_raw_gen_syncookie_ipv4_proto = {
 BPF_CALL_3(bpf_tcp_raw_gen_syncookie_ipv6, struct ipv6hdr *, iph,
 	   struct tcphdr *, th, u32, th_len)
 {
-#if IS_BUILTIN(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_IPV6)
 	const u16 mss_clamp = IPV6_MIN_MTU - sizeof(struct tcphdr) -
 		sizeof(struct ipv6hdr);
 	u32 cookie;
@@ -8072,7 +8072,7 @@ static const struct bpf_func_proto bpf_tcp_raw_check_syncookie_ipv4_proto = {
 BPF_CALL_2(bpf_tcp_raw_check_syncookie_ipv6, struct ipv6hdr *, iph,
 	   struct tcphdr *, th)
 {
-#if IS_BUILTIN(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_IPV6)
 	if (__cookie_v6_check(iph, th) > 0)
 		return 0;
 
@@ -11958,7 +11958,7 @@ BPF_CALL_1(bpf_skc_to_tcp_timewait_sock, struct sock *, sk)
 		return (unsigned long)sk;
 #endif
 
-#if IS_BUILTIN(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_IPV6)
 	if (sk && sk->sk_prot == &tcpv6_prot && sk->sk_state == TCP_TIME_WAIT)
 		return (unsigned long)sk;
 #endif
@@ -11981,7 +11981,7 @@ BPF_CALL_1(bpf_skc_to_tcp_request_sock, struct sock *, sk)
 		return (unsigned long)sk;
 #endif
 
-#if IS_BUILTIN(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_IPV6)
 	if (sk && sk->sk_prot == &tcpv6_prot && sk->sk_state == TCP_NEW_SYN_RECV)
 		return (unsigned long)sk;
 #endif
@@ -12244,7 +12244,7 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __sk_buff *s, struct sock *sk,
 		ops = &tcp_request_sock_ops;
 		min_mss = 536;
 		break;
-#if IS_BUILTIN(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_IPV6)
 	case htons(ETH_P_IPV6):
 		ops = &tcp6_request_sock_ops;
 		min_mss = IPV6_MIN_MTU - 60;
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index a6e58a435735..0fc6ef4a48b1 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -2763,7 +2763,7 @@ static void ipv6_route_native_seq_stop(struct seq_file *seq, void *v)
 	rcu_read_unlock();
 }
 
-#if IS_BUILTIN(CONFIG_IPV6) && defined(CONFIG_BPF_SYSCALL)
+#if IS_ENABLED(CONFIG_IPV6) && defined(CONFIG_BPF_SYSCALL)
 static int ipv6_route_prog_seq_show(struct bpf_prog *prog,
 				    struct bpf_iter_meta *meta,
 				    void *v)
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index bd7f780e37a5..d8072ad6b8c4 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -286,7 +286,7 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
 
 	if (likely(proto == IPPROTO_TCP))
 		pp = tcp6_gro_receive(head, skb);
-#if IS_BUILTIN(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_IPV6)
 	else if (likely(proto == IPPROTO_UDP))
 		pp = udp6_gro_receive(head, skb);
 #endif
@@ -346,7 +346,7 @@ INDIRECT_CALLABLE_SCOPE int ipv6_gro_complete(struct sk_buff *skb, int nhoff)
 
 	if (likely(ops == &net_hotdata.tcpv6_offload))
 		return tcp6_gro_complete(skb, nhoff);
-#if IS_BUILTIN(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_IPV6)
 	if (ops == &net_hotdata.udpv6_offload)
 		return udp6_gro_complete(skb, nhoff);
 #endif
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 08cd86f49bf9..e206777785d4 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -6826,7 +6826,7 @@ void __init ip6_route_init_special_entries(void)
   #endif
 }
 
-#if IS_BUILTIN(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_IPV6)
 #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_PROC_FS)
 DEFINE_BPF_ITER_FUNC(ipv6_route, struct bpf_iter_meta *meta, struct fib6_info *rt)
 
@@ -6921,7 +6921,7 @@ int __init ip6_route_init(void)
 	if (ret)
 		goto out_register_late_subsys;
 
-#if IS_BUILTIN(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_IPV6)
 #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_PROC_FS)
 	ret = bpf_iter_register();
 	if (ret)
@@ -6961,7 +6961,7 @@ int __init ip6_route_init(void)
 
 void ip6_route_cleanup(void)
 {
-#if IS_BUILTIN(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_IPV6)
 #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_PROC_FS)
 	bpf_iter_unregister();
 #endif
-- 
2.53.0


