Return-Path: <netdev+bounces-271517-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLhZDtzYw2mluQQAu9opvQ
	(envelope-from <netdev+bounces-271517-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:45:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BBF3251A4
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4A8832A6EAD
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 12:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3472A3D3013;
	Wed, 25 Mar 2026 12:10:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D70E3D330C
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774440647; cv=none; b=Aspd6AVIJf6rzRVN1cQZJ8TwcobP0i0jLAScc6rki0cc649QKYDI/rQv3SHy9ySSrJNEuhl/I73pwc/7FlNpOBeWLvgPqv/5HUdl99EJyqYfi75CQcMzSuqjRpjexfZrtbZAZ7CzhWZXwRSdOx9euTRHVaYSByWW7m7fSRFhik4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774440647; c=relaxed/simple;
	bh=Ten+6IkaaETQo9Udy6kslz2UwxLrOUupSZs39l8WPfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iPvF9PCtzAJ9XrADI/jo3xTE6Zp70Vco0pc+zMb5yMkNvkmVz3RYR5TDLqjMMmmbuxZJECGly3jkF4mnA/WqWc/JA1VMzsLb+5R6rs83ie2dQLQx1oqaU2xP9PYyADvqv+oMhXD9Z8PHgHPYnvnaKZf9XIMMYAOQCjr7ZYJJ+0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8413A5BCD0;
	Wed, 25 Mar 2026 12:10:40 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B6B7443BD;
	Wed, 25 Mar 2026 12:10:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MGWRC7/Qw2kbNgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 25 Mar 2026 12:10:39 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: Fernando Fernandez Mancera <fmancera@suse.de>,
	=?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>,
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
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 03/11 net-next v5] ipv6: replace IS_BUILTIN(CONFIG_IPV6) with IS_ENABLED(CONFIG_IPV6)
Date: Wed, 25 Mar 2026 13:08:44 +0100
Message-ID: <20260325120928.15848-4-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260325120928.15848-1-fmancera@suse.de>
References: <20260325120928.15848-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[suse.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[suse.de,suse.com,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,gmail.com,fomichev.me,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271517-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email,suse.de:mid,suse.com:email]
X-Rspamd-Queue-Id: 95BBF3251A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As IPv6 is built-in only, it does not make sense to continue using
IS_BUILTIN(CONFIG_IPV6). Therefore, replace it with IS_ENABLED() when
necessary and drop it if it isn't valid anymore.

Notice that there is still one instance related to ICMPv6, as it
requires more changes it will be handle separately.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
Tested-by: Ricardo B. Marlière <rbm@suse.com>
---
 include/linux/indirect_call_wrapper.h |  2 +-
 include/net/ip6_fib.h                 |  2 +-
 net/core/filter.c                     | 14 +++++++-------
 net/ipv6/ip6_fib.c                    |  2 +-
 net/ipv6/ip6_offload.c                |  4 ++--
 net/ipv6/route.c                      |  6 ------
 6 files changed, 12 insertions(+), 18 deletions(-)

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
index 2f023999f046..c56821afaa0f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7590,7 +7590,7 @@ BPF_CALL_5(bpf_tcp_check_syncookie, struct sock *, sk, void *, iph, u32, iph_len
 		ret = __cookie_v4_check((struct iphdr *)iph, th);
 		break;
 
-#if IS_BUILTIN(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_IPV6)
 	case 6:
 		if (unlikely(iph_len < sizeof(struct ipv6hdr)))
 			return -EINVAL;
@@ -7660,7 +7660,7 @@ BPF_CALL_5(bpf_tcp_gen_syncookie, struct sock *, sk, void *, iph, u32, iph_len,
 		mss = tcp_v4_get_syncookie(sk, iph, th, &cookie);
 		break;
 
-#if IS_BUILTIN(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_IPV6)
 	case 6:
 		if (unlikely(iph_len < sizeof(struct ipv6hdr)))
 			return -EINVAL;
@@ -8026,7 +8026,7 @@ static const struct bpf_func_proto bpf_tcp_raw_gen_syncookie_ipv4_proto = {
 BPF_CALL_3(bpf_tcp_raw_gen_syncookie_ipv6, struct ipv6hdr *, iph,
 	   struct tcphdr *, th, u32, th_len)
 {
-#if IS_BUILTIN(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_IPV6)
 	const u16 mss_clamp = IPV6_MIN_MTU - sizeof(struct tcphdr) -
 		sizeof(struct ipv6hdr);
 	u32 cookie;
@@ -8078,7 +8078,7 @@ static const struct bpf_func_proto bpf_tcp_raw_check_syncookie_ipv4_proto = {
 BPF_CALL_2(bpf_tcp_raw_check_syncookie_ipv6, struct ipv6hdr *, iph,
 	   struct tcphdr *, th)
 {
-#if IS_BUILTIN(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_IPV6)
 	if (__cookie_v6_check(iph, th) > 0)
 		return 0;
 
@@ -11964,7 +11964,7 @@ BPF_CALL_1(bpf_skc_to_tcp_timewait_sock, struct sock *, sk)
 		return (unsigned long)sk;
 #endif
 
-#if IS_BUILTIN(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_IPV6)
 	if (sk && sk->sk_prot == &tcpv6_prot && sk->sk_state == TCP_TIME_WAIT)
 		return (unsigned long)sk;
 #endif
@@ -11987,7 +11987,7 @@ BPF_CALL_1(bpf_skc_to_tcp_request_sock, struct sock *, sk)
 		return (unsigned long)sk;
 #endif
 
-#if IS_BUILTIN(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_IPV6)
 	if (sk && sk->sk_prot == &tcpv6_prot && sk->sk_state == TCP_NEW_SYN_RECV)
 		return (unsigned long)sk;
 #endif
@@ -12250,7 +12250,7 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __sk_buff *s, struct sock *sk,
 		ops = &tcp_request_sock_ops;
 		min_mss = 536;
 		break;
-#if IS_BUILTIN(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_IPV6)
 	case htons(ETH_P_IPV6):
 		ops = &tcp6_request_sock_ops;
 		min_mss = IPV6_MIN_MTU - 60;
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index a6e58a435735..a935004ec9df 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -2763,7 +2763,7 @@ static void ipv6_route_native_seq_stop(struct seq_file *seq, void *v)
 	rcu_read_unlock();
 }
 
-#if IS_BUILTIN(CONFIG_IPV6) && defined(CONFIG_BPF_SYSCALL)
+#if defined(CONFIG_BPF_SYSCALL)
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
index 08cd86f49bf9..781b43c54932 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -6826,7 +6826,6 @@ void __init ip6_route_init_special_entries(void)
   #endif
 }
 
-#if IS_BUILTIN(CONFIG_IPV6)
 #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_PROC_FS)
 DEFINE_BPF_ITER_FUNC(ipv6_route, struct bpf_iter_meta *meta, struct fib6_info *rt)
 
@@ -6860,7 +6859,6 @@ static void bpf_iter_unregister(void)
 	bpf_iter_unreg_target(&ipv6_route_reg_info);
 }
 #endif
-#endif
 
 static const struct rtnl_msg_handler ip6_route_rtnl_msg_handlers[] __initconst_or_module = {
 	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_NEWROUTE,
@@ -6921,12 +6919,10 @@ int __init ip6_route_init(void)
 	if (ret)
 		goto out_register_late_subsys;
 
-#if IS_BUILTIN(CONFIG_IPV6)
 #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_PROC_FS)
 	ret = bpf_iter_register();
 	if (ret)
 		goto out_register_late_subsys;
-#endif
 #endif
 
 	for_each_possible_cpu(cpu) {
@@ -6961,10 +6957,8 @@ int __init ip6_route_init(void)
 
 void ip6_route_cleanup(void)
 {
-#if IS_BUILTIN(CONFIG_IPV6)
 #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_PROC_FS)
 	bpf_iter_unregister();
-#endif
 #endif
 	unregister_netdevice_notifier(&ip6_route_dev_notifier);
 	unregister_pernet_subsys(&ip6_route_net_late_ops);
-- 
2.53.0


