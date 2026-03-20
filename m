Return-Path: <netdev+bounces-270033-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GK51Lb6ZvWmR/QIAu9opvQ
	(envelope-from <netdev+bounces-270033-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:02:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B50C2DFA9A
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5477306114E
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42DF32E6BD;
	Fri, 20 Mar 2026 19:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yzqD31nx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ndtw3YW4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yzqD31nx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ndtw3YW4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C306333424
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 19:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774033263; cv=none; b=adxJIxFgkCawXMk3MUkPljP37ocXfPuW6pkYoURJ9sGDGISQqC14hG7Wa9zd8HSt6IFOuuYQFmuOHeMoi1NBuyoR8C9Yq0y40XRAbRgNkY3gBZCEZrUBi1hwj7jCibN+3KWRsS4bd9F41c3FEMBmoFsvqzKPwOF84i3LzgXkiM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774033263; c=relaxed/simple;
	bh=3jvxW6pHxByhhZjqbzIAI4m52uwu49SVDXIOpG9CHI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mfjU1hw7HhFkaO//fPo0cFT5EiAO9igt2qwn83+jkDp5U6UZxRFRYkTyT07ntIIHpY9MybtV0YxX8b6we4JK/myeX3ls2Nn5SQRJSyZszsNCFYOSLJQ3+SfGiS/FIw3tJr1C4UgmummNYXVnWF2RVmJiFR3y9nozqbExtqnytO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yzqD31nx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ndtw3YW4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yzqD31nx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ndtw3YW4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BE4B04D2BD;
	Fri, 20 Mar 2026 19:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774033255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IR5SOWYKYKg38Q3ABjlVtZvwEqqeQjFfyshMXSinEo0=;
	b=yzqD31nxd7AUqE+UOFLeVvj/tDmUTSLcTc273AarBJK1t4p1xyQjZCuMPJH8kgT2wb8B3Z
	1M+/tFkC78M7KlY0feQ3K0XvpMmqfIc+s96UdDdtvianwCvx/PA42x1VkX8q5wUaD3gFiZ
	I2Vcw2uWhlHIRar04+Z0NcQWdd0Lz54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774033255;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IR5SOWYKYKg38Q3ABjlVtZvwEqqeQjFfyshMXSinEo0=;
	b=ndtw3YW45Km+vsgw9V5avM8b6OW+jY7X0kO7aylbzKYkolZpyH9Jo/wvQeIXtS78on+uEl
	+lW/NkEPHflbXuCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774033255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IR5SOWYKYKg38Q3ABjlVtZvwEqqeQjFfyshMXSinEo0=;
	b=yzqD31nxd7AUqE+UOFLeVvj/tDmUTSLcTc273AarBJK1t4p1xyQjZCuMPJH8kgT2wb8B3Z
	1M+/tFkC78M7KlY0feQ3K0XvpMmqfIc+s96UdDdtvianwCvx/PA42x1VkX8q5wUaD3gFiZ
	I2Vcw2uWhlHIRar04+Z0NcQWdd0Lz54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774033255;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IR5SOWYKYKg38Q3ABjlVtZvwEqqeQjFfyshMXSinEo0=;
	b=ndtw3YW45Km+vsgw9V5avM8b6OW+jY7X0kO7aylbzKYkolZpyH9Jo/wvQeIXtS78on+uEl
	+lW/NkEPHflbXuCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 40F7D42955;
	Fri, 20 Mar 2026 19:00:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0MeSDGaZvWnyTgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 20 Mar 2026 19:00:54 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: Fernando Fernandez Mancera <fmancera@suse.de>,
	=?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
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
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 09/11 net-next v4] bpf: remove ipv6_bpf_stub completely and use direct function calls
Date: Fri, 20 Mar 2026 19:56:03 +0100
Message-ID: <20260320185649.5411-12-fmancera@suse.de>
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
X-Spam-Score: -5.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.de,suse.com,iogearbox.net,davemloft.net,kernel.org,google.com,redhat.com,linux.dev,gmail.com,fomichev.me,nvidia.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270033-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[25];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3B50C2DFA9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As IPv6 is built-in only, the ipv6_bpf_stub can be removed completely.

Convert all ipv6_bpf_stub usage to direct function calls instead. The
fallback functions introduced previously will prevent linkage errors
when CONFIG_IPV6 is disabled.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
Tested-by: Ricardo B. Marlière <rbm@suse.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
---
 include/net/ipv6.h       |  2 ++
 include/net/ipv6_stubs.h | 21 ----------------
 net/core/filter.c        | 54 ++++++++++++++++------------------------
 net/core/lwt_bpf.c       | 10 +++++---
 net/ipv6/af_inet6.c      | 13 ++--------
 5 files changed, 33 insertions(+), 67 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index f99f273341f0..d042afe7a245 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1149,6 +1149,8 @@ void ipv6_local_rxpmtu(struct sock *sk, struct flowi6 *fl6, u32 mtu);
 void inet6_cleanup_sock(struct sock *sk);
 void inet6_sock_destruct(struct sock *sk);
 int inet6_release(struct socket *sock);
+int __inet6_bind(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len,
+		 u32 flags);
 int inet6_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int addr_len);
 int inet6_bind_sk(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len);
 int inet6_getname(struct socket *sock, struct sockaddr *uaddr,
diff --git a/include/net/ipv6_stubs.h b/include/net/ipv6_stubs.h
index 907681cecde8..dc708d9eca7a 100644
--- a/include/net/ipv6_stubs.h
+++ b/include/net/ipv6_stubs.h
@@ -77,25 +77,4 @@ struct ipv6_stub {
 			__u32 mark, struct ipv6_txoptions *opt, int tclass, u32 priority);
 };
 extern const struct ipv6_stub *ipv6_stub __read_mostly;
-
-/* A stub used by bpf helpers. Similarly ugly as ipv6_stub */
-struct ipv6_bpf_stub {
-	int (*inet6_bind)(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len,
-			  u32 flags);
-	struct sock *(*udp6_lib_lookup)(const struct net *net,
-					const struct in6_addr *saddr, __be16 sport,
-					const struct in6_addr *daddr, __be16 dport,
-					int dif, int sdif, struct sk_buff *skb);
-	int (*ipv6_setsockopt)(struct sock *sk, int level, int optname,
-			       sockptr_t optval, unsigned int optlen);
-	int (*ipv6_getsockopt)(struct sock *sk, int level, int optname,
-			       sockptr_t optval, sockptr_t optlen);
-	int (*ipv6_dev_get_saddr)(struct net *net,
-				  const struct net_device *dst_dev,
-				  const struct in6_addr *daddr,
-				  unsigned int prefs,
-				  struct in6_addr *saddr);
-};
-extern const struct ipv6_bpf_stub *ipv6_bpf_stub __read_mostly;
-
 #endif
diff --git a/net/core/filter.c b/net/core/filter.c
index c56821afaa0f..4b0c98f0d994 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -73,7 +73,6 @@
 #include <net/seg6.h>
 #include <net/seg6_local.h>
 #include <net/lwtunnel.h>
-#include <net/ipv6_stubs.h>
 #include <net/bpf_sk_storage.h>
 #include <net/transp_v6.h>
 #include <linux/btf_ids.h>
@@ -2279,7 +2278,7 @@ static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_device *dev,
 			.saddr	      = ip6h->saddr,
 		};
 
-		dst = ipv6_stub->ipv6_dst_lookup_flow(net, NULL, &fl6, NULL);
+		dst = ip6_dst_lookup_flow(net, NULL, &fl6, NULL);
 		if (IS_ERR(dst))
 			goto out_drop;
 
@@ -5577,12 +5576,12 @@ static int sol_ipv6_sockopt(struct sock *sk, int optname,
 	}
 
 	if (getopt)
-		return ipv6_bpf_stub->ipv6_getsockopt(sk, SOL_IPV6, optname,
-						      KERNEL_SOCKPTR(optval),
-						      KERNEL_SOCKPTR(optlen));
+		return do_ipv6_getsockopt(sk, SOL_IPV6, optname,
+					  KERNEL_SOCKPTR(optval),
+					  KERNEL_SOCKPTR(optlen));
 
-	return ipv6_bpf_stub->ipv6_setsockopt(sk, SOL_IPV6, optname,
-					      KERNEL_SOCKPTR(optval), *optlen);
+	return do_ipv6_setsockopt(sk, SOL_IPV6, optname,
+				  KERNEL_SOCKPTR(optval), *optlen);
 }
 
 static int __bpf_setsockopt(struct sock *sk, int level, int optname,
@@ -5981,9 +5980,6 @@ static const struct bpf_func_proto bpf_sock_ops_cb_flags_set_proto = {
 	.arg2_type	= ARG_ANYTHING,
 };
 
-const struct ipv6_bpf_stub *ipv6_bpf_stub __read_mostly;
-EXPORT_SYMBOL_GPL(ipv6_bpf_stub);
-
 BPF_CALL_3(bpf_bind, struct bpf_sock_addr_kern *, ctx, struct sockaddr *, addr,
 	   int, addr_len)
 {
@@ -6007,11 +6003,9 @@ BPF_CALL_3(bpf_bind, struct bpf_sock_addr_kern *, ctx, struct sockaddr *, addr,
 			return err;
 		if (((struct sockaddr_in6 *)addr)->sin6_port == htons(0))
 			flags |= BIND_FORCE_ADDRESS_NO_PORT;
-		/* ipv6_bpf_stub cannot be NULL, since it's called from
-		 * bpf_cgroup_inet6_connect hook and ipv6 is already loaded
-		 */
-		return ipv6_bpf_stub->inet6_bind(sk, (struct sockaddr_unsized *)addr,
-						 addr_len, flags);
+
+		return __inet6_bind(sk, (struct sockaddr_unsized *)addr,
+				    addr_len, flags);
 #endif /* CONFIG_IPV6 */
 	}
 #endif /* CONFIG_INET */
@@ -6222,7 +6216,7 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 		neigh = __ipv4_neigh_lookup_noref(dev,
 						  (__force u32)params->ipv4_dst);
 	else
-		neigh = __ipv6_neigh_lookup_noref_stub(dev, params->ipv6_dst);
+		neigh = __ipv6_neigh_lookup_noref(dev, params->ipv6_dst);
 
 	if (!neigh || !(READ_ONCE(neigh->nud_state) & NUD_VALID))
 		return BPF_FIB_LKUP_RET_NO_NEIGH;
@@ -6290,12 +6284,11 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 			params->tbid = 0;
 		}
 
-		tb = ipv6_stub->fib6_get_table(net, tbid);
+		tb = fib6_get_table(net, tbid);
 		if (unlikely(!tb))
 			return BPF_FIB_LKUP_RET_NOT_FWDED;
 
-		err = ipv6_stub->fib6_table_lookup(net, tb, oif, &fl6, &res,
-						   strict);
+		err = fib6_table_lookup(net, tb, oif, &fl6, &res, strict);
 	} else {
 		if (flags & BPF_FIB_LOOKUP_MARK)
 			fl6.flowi6_mark = params->mark;
@@ -6305,7 +6298,7 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 		fl6.flowi6_tun_key.tun_id = 0;
 		fl6.flowi6_uid = sock_net_uid(net, NULL);
 
-		err = ipv6_stub->fib6_lookup(net, oif, &fl6, &res, strict);
+		err = fib6_lookup(net, oif, &fl6, &res, strict);
 	}
 
 	if (unlikely(err || IS_ERR_OR_NULL(res.f6i) ||
@@ -6326,11 +6319,11 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 		return BPF_FIB_LKUP_RET_NOT_FWDED;
 	}
 
-	ipv6_stub->fib6_select_path(net, &res, &fl6, fl6.flowi6_oif,
-				    fl6.flowi6_oif != 0, NULL, strict);
+	fib6_select_path(net, &res, &fl6, fl6.flowi6_oif,
+			 fl6.flowi6_oif != 0, NULL, strict);
 
 	if (check_mtu) {
-		mtu = ipv6_stub->ip6_mtu_from_fib6(&res, dst, src);
+		mtu = ip6_mtu_from_fib6(&res, dst, src);
 		if (params->tot_len > mtu) {
 			params->mtu_result = mtu; /* union with tot_len */
 			return BPF_FIB_LKUP_RET_FRAG_NEEDED;
@@ -6351,9 +6344,7 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 		if (res.f6i->fib6_prefsrc.plen) {
 			*src = res.f6i->fib6_prefsrc.addr;
 		} else {
-			err = ipv6_bpf_stub->ipv6_dev_get_saddr(net, dev,
-								&fl6.daddr, 0,
-								src);
+			err = ipv6_dev_get_saddr(net, dev, &fl6.daddr, 0, src);
 			if (err)
 				return BPF_FIB_LKUP_RET_NO_SRC_ADDR;
 		}
@@ -6365,7 +6356,7 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	/* xdp and cls_bpf programs are run in RCU-bh so rcu_read_lock_bh is
 	 * not needed here.
 	 */
-	neigh = __ipv6_neigh_lookup_noref_stub(dev, dst);
+	neigh = __ipv6_neigh_lookup_noref(dev, dst);
 	if (!neigh || !(READ_ONCE(neigh->nud_state) & NUD_VALID))
 		return BPF_FIB_LKUP_RET_NO_NEIGH;
 	memcpy(params->dmac, neigh->ha, ETH_ALEN);
@@ -6900,11 +6891,10 @@ static struct sock *sk_lookup(struct net *net, struct bpf_sock_tuple *tuple,
 					    src6, tuple->ipv6.sport,
 					    dst6, ntohs(tuple->ipv6.dport),
 					    dif, sdif, &refcounted);
-		else if (likely(ipv6_bpf_stub))
-			sk = ipv6_bpf_stub->udp6_lib_lookup(net,
-							    src6, tuple->ipv6.sport,
-							    dst6, tuple->ipv6.dport,
-							    dif, sdif, NULL);
+		else if (likely(ipv6_mod_enabled()))
+			sk = __udp6_lib_lookup(net, src6, tuple->ipv6.sport,
+					       dst6, tuple->ipv6.dport,
+					       dif, sdif, NULL);
 #endif
 	}
 
diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index 9f40be0c3e71..f71ef82a5f3d 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -13,7 +13,6 @@
 #include <net/gre.h>
 #include <net/ip.h>
 #include <net/ip6_route.h>
-#include <net/ipv6_stubs.h>
 
 struct bpf_lwt_prog {
 	struct bpf_prog *prog;
@@ -103,7 +102,12 @@ static int bpf_lwt_input_reroute(struct sk_buff *skb)
 		dev_put(dev);
 	} else if (skb->protocol == htons(ETH_P_IPV6)) {
 		skb_dst_drop(skb);
-		err = ipv6_stub->ipv6_route_input(skb);
+		if (IS_ENABLED(CONFIG_IPV6)) {
+			ip6_route_input(skb);
+			err = skb_dst(skb)->error;
+		} else {
+			err = -EAFNOSUPPORT;
+		}
 	} else {
 		err = -EAFNOSUPPORT;
 	}
@@ -233,7 +237,7 @@ static int bpf_lwt_xmit_reroute(struct sk_buff *skb)
 		fl6.daddr = iph6->daddr;
 		fl6.saddr = iph6->saddr;
 
-		dst = ipv6_stub->ipv6_dst_lookup_flow(net, skb->sk, &fl6, NULL);
+		dst = ip6_dst_lookup_flow(net, skb->sk, &fl6, NULL);
 		if (IS_ERR(dst)) {
 			err = PTR_ERR(dst);
 			goto err;
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index bb29b29fdcfb..07ae6ea7743a 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -264,8 +264,8 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 	goto out;
 }
 
-static int __inet6_bind(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len,
-			u32 flags)
+int __inet6_bind(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len,
+		 u32 flags)
 {
 	struct sockaddr_in6 *addr = (struct sockaddr_in6 *)uaddr;
 	struct inet_sock *inet = inet_sk(sk);
@@ -1032,14 +1032,6 @@ static const struct ipv6_stub ipv6_stub_impl = {
 	.ip6_xmit = ip6_xmit,
 };
 
-static const struct ipv6_bpf_stub ipv6_bpf_stub_impl = {
-	.inet6_bind = __inet6_bind,
-	.udp6_lib_lookup = __udp6_lib_lookup,
-	.ipv6_setsockopt = do_ipv6_setsockopt,
-	.ipv6_getsockopt = do_ipv6_getsockopt,
-	.ipv6_dev_get_saddr = ipv6_dev_get_saddr,
-};
-
 static int __init inet6_init(void)
 {
 	struct list_head *r;
@@ -1199,7 +1191,6 @@ static int __init inet6_init(void)
 	/* ensure that ipv6 stubs are visible only after ipv6 is ready */
 	wmb();
 	ipv6_stub = &ipv6_stub_impl;
-	ipv6_bpf_stub = &ipv6_bpf_stub_impl;
 out:
 	return err;
 
-- 
2.53.0


