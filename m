Return-Path: <netdev+bounces-184082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9ABA93324
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 09:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CDDD16DA13
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 07:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413AB26B949;
	Fri, 18 Apr 2025 07:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orbstack.dev header.i=@orbstack.dev header.b="bLIfLUnQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471842116E0
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 07:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744959658; cv=none; b=MJ2rBLPDHGHkECzvOHE48/H7xxbqFNLVF4ri52URlIGGK55sNSh7o1u4fyvTHfETiDZ+hw8xWShcslRO18FYGZybpS553tdPS0an/6QNeg+6+mVIMYOLRYG0EifNyyMe9RB77iuaisSjf9Ve3RhW8Fw7b/uZdgfiEA0Z1b0YHF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744959658; c=relaxed/simple;
	bh=ybBxi4WQcURKoE4BxCGqK8VSt1MHM5Lsow1LinLQwcs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=j/op8Xut/tpMN1/6q6q6o9gYDN+AiGjvgciSfxrBAe+DAXDcArBnV5lxLWnhRGiGkp5ca4xs2XzcuiFUGxQzaGP3ck83RjPqhQrKd1Yx0FeV9OMcJlThWUH3muKrM8KhPBZ5tEOeFvN0EL9xauM4pqrnGrvOncCBTLuVPcA4kU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=orbstack.dev; spf=pass smtp.mailfrom=orbstack.dev; dkim=pass (2048-bit key) header.d=orbstack.dev header.i=@orbstack.dev header.b=bLIfLUnQ; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=orbstack.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orbstack.dev
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b03bc416962so1084479a12.0
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 00:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=orbstack.dev; s=google; t=1744959654; x=1745564454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ag0uHziDOMxcedxURrdSLZ+7TR1r0QSkH/f14RF03UI=;
        b=bLIfLUnQGqOrz2mgc1onPobAt2MPv8mPRxxVFkKI6iseXFBttbQgASC24y+fSXC3Ok
         ykVnyBxyLNWUu5YblHtM615ye/HvwPQ7bCGrnr4VLd6BA3ja0oOSGKxHLCKUvpXb9HtF
         olFU4+JFFVYuxDQFmUKovjX95uacaQxZq1IEqLIrlsBPHXJZuLHazVMAnvKkY4xe4K+4
         Y7LjDkFTiZM6kbtudzH5HnaLfe2ApVhPq/ZwS2xH5Ws0sUqocnzQmcs1H4Dukv0doBDA
         g8iuTZyB/Y+65dMC1ZWc7REi6LN6/g2eCiS7cDqNAq7WknnSI9r56q+gOj385QkxVLr6
         c4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744959654; x=1745564454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ag0uHziDOMxcedxURrdSLZ+7TR1r0QSkH/f14RF03UI=;
        b=lfqCUW/k71D0oOz8pmS9y/Fb1ynC9JDR/dNdGBsXkxo3c7tAODe88hs5ENyVGlKt2R
         9CA1ocKiOxSuDGhEiqSV5fwUIvOguwBMq0IT6QP7Jny/zSizYKc7qXjiV7YfxFtdW3+a
         yx9ZA47OWs3Gfd42zX77JoZlkOAbxzY/0vXvT1LSQ/v7SNERg9/7dcHVN+G6fXamHXsw
         Difoo2qma+AbxWGhF/GNxEj1QHA4zvi76YSa+fXCkoljoAOloQCirNRv3Pt/iHQOS29y
         PzDpLwssYCuadtjo1AdUoxN9LIDeMMLCCF7xjn81cMi2T57ikOpC0+ZBqPRQx9QcAg4D
         G+dw==
X-Forwarded-Encrypted: i=1; AJvYcCU6NyFlj7eW0P2veryTKVYeU244gjKMCjWhgI39sIDVwt7vSmL7pm17oT7MH8KFQx3tlWQKyBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmMkpDgFtWl44uNNvo7rKWg03xR9oojqUygIzvAhKDqMYJWSuv
	OHvmCH441NORHFax5qPpmWWVabLT6iTJ0ewZStLl8sCi/ScZroc8m87cvWoFQZw=
X-Gm-Gg: ASbGncv4rYCpNEwLSdlgxh5pGlUrgxzD6klVkB4shJxDamR9ZVHJteQgJ0x1fttNw7P
	iEBVGGgtsBHPK3dUBcGElslh3C9BKLqnC0/QPgmeFuHLWKu5J8v/ODdPOQKtJSjWgAFGX933k8k
	obbukORo88Sm58jg7o/8HY8flkqoOQid2i9peO+OTnbtpnLe3oMMd6EEtTl4y8h7hGFeTbilALD
	P37cLK3OsAYsg7UfIDTyo3aoRI5OPFV38axI/sZUjGqdm7jxKGRwkg5AavupgIixEdhCzXnQB4l
	rAn9ri19YEHyVgEyk8gGuAR5qin1ZhOFbCIq6P81XnAjoCVNNKUEKvI=
X-Google-Smtp-Source: AGHT+IHBYom+6rviMqXCW+6sdPcKwAXnTI933w/mVjbBQ303YyLG/DJJKVWOikqiNoclvemSFsRdng==
X-Received: by 2002:a17:90a:c887:b0:2fa:15ab:4df5 with SMTP id 98e67ed59e1d1-3087bccb042mr2391934a91.34.1744959654237;
        Fri, 18 Apr 2025 00:00:54 -0700 (PDT)
Received: from debian.. ([136.24.187.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bde283sm11080245ad.6.2025.04.18.00.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 00:00:53 -0700 (PDT)
From: Danny Lin <danny@orbstack.dev>
To: Matteo Croce <teknoraver@meta.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Danny Lin <danny@orbstack.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] net: fully namespace net.core.{r,w}mem_{default,max} sysctls
Date: Fri, 18 Apr 2025 00:00:34 -0700
Message-ID: <20250418070037.33971-1-danny@orbstack.dev>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This builds on commit 19249c0724f2 ("net: make net.core.{r,w}mem_{default,max} namespaced")
by adding support for writing the sysctls from within net namespaces,
rather than only reading the values that were set in init_net. These are
relatively commonly-used sysctls, so programs may try to set them without
knowing that they're in a container. It can be surprising for such attempts
to fail with EACCES.

Unlike other net sysctls that were converted to namespaced ones, many
systems have a sysctl.conf (or other configs) that globally write to
net.core.rmem_default on boot and expect the value to propagate to
containers, and programs running in containers may depend on the increased
buffer sizes in order to work properly. This means that namespacing the
sysctls and using the kernel default values in each new netns would break
existing workloads.

As a compromise, inherit the initial net.core.*mem_* values from the
current process' netns when creating a new netns. This is not standard
behavior for most netns sysctls, but it avoids breaking existing workloads.

Signed-off-by: Danny Lin <danny@orbstack.dev>
---
 include/net/netns/core.h                    |  5 +++++
 include/net/sock.h                          |  6 ------
 net/core/net_namespace.c                    | 21 ++++++++++++++++++
 net/core/sock.c                             | 16 ++++----------
 net/core/sysctl_net_core.c                  | 16 ++++----------
 net/ipv4/ip_output.c                        |  2 +-
 net/ipv4/tcp_output.c                       |  2 +-
 net/netfilter/ipvs/ip_vs_sync.c             |  4 ++--
 tools/testing/selftests/net/netns-sysctl.sh | 24 +++++++++++++++------
 9 files changed, 55 insertions(+), 41 deletions(-)

diff --git a/include/net/netns/core.h b/include/net/netns/core.h
index 9b36f0ff0c20..0459523602cb 100644
--- a/include/net/netns/core.h
+++ b/include/net/netns/core.h
@@ -17,6 +17,11 @@ struct netns_core {
 	u8	sysctl_txrehash;
 	u8	sysctl_tstamp_allow_data;
 
+	u32 sysctl_wmem_max;
+	u32 sysctl_rmem_max;
+	u32 sysctl_wmem_default;
+	u32 sysctl_rmem_default;
+
 #ifdef CONFIG_PROC_FS
 	struct prot_inuse __percpu *prot_inuse;
 #endif
diff --git a/include/net/sock.h b/include/net/sock.h
index 8daf1b3b12c6..7aeddba44919 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2849,12 +2849,6 @@ void sk_get_meminfo(const struct sock *sk, u32 *meminfo);
 #define SK_WMEM_MAX		(_SK_MEM_OVERHEAD * _SK_MEM_PACKETS)
 #define SK_RMEM_MAX		(_SK_MEM_OVERHEAD * _SK_MEM_PACKETS)
 
-extern __u32 sysctl_wmem_max;
-extern __u32 sysctl_rmem_max;
-
-extern __u32 sysctl_wmem_default;
-extern __u32 sysctl_rmem_default;
-
 #define SKB_FRAG_PAGE_ORDER	get_order(32768)
 DECLARE_STATIC_KEY_FALSE(net_high_order_alloc_disable_key);
 
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index b0dfdf791ece..39fe16f1ab72 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -317,6 +317,27 @@ static __net_init void preinit_net_sysctl(struct net *net)
 	net->core.sysctl_optmem_max = 128 * 1024;
 	net->core.sysctl_txrehash = SOCK_TXREHASH_ENABLED;
 	net->core.sysctl_tstamp_allow_data = 1;
+
+	/*
+	 * net.core.{r,w}mem_{default,max} used to be non-namespaced.
+	 * For backward compatibility, inherit values from the current netns
+	 * when creating a new one, so that setting them in init_net
+	 * affects new namespaces like it used to. This avoids causing
+	 * surprising performance regressions for namespaced applications
+	 * relying on tuned rmem/wmem.
+	 */
+	if (net == &init_net) {
+		net->core.sysctl_wmem_max = SK_WMEM_MAX;
+		net->core.sysctl_rmem_max = SK_RMEM_MAX;
+		net->core.sysctl_wmem_default = SK_WMEM_MAX;
+		net->core.sysctl_rmem_default = SK_RMEM_MAX;
+	} else {
+		struct net *current_net = current->nsproxy->net_ns;
+		net->core.sysctl_wmem_max = current_net->core.sysctl_wmem_max;
+		net->core.sysctl_rmem_max = current_net->core.sysctl_rmem_max;
+		net->core.sysctl_wmem_default = current_net->core.sysctl_wmem_default;
+		net->core.sysctl_rmem_default = current_net->core.sysctl_rmem_default;
+	}
 }
 
 /* init code that must occur even if setup_net() is not called. */
diff --git a/net/core/sock.c b/net/core/sock.c
index 323892066def..88694cd59abd 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -278,14 +278,6 @@ static struct lock_class_key af_wlock_keys[AF_MAX];
 static struct lock_class_key af_elock_keys[AF_MAX];
 static struct lock_class_key af_kern_callback_keys[AF_MAX];
 
-/* Run time adjustable parameters. */
-__u32 sysctl_wmem_max __read_mostly = SK_WMEM_MAX;
-EXPORT_SYMBOL(sysctl_wmem_max);
-__u32 sysctl_rmem_max __read_mostly = SK_RMEM_MAX;
-EXPORT_SYMBOL(sysctl_rmem_max);
-__u32 sysctl_wmem_default __read_mostly = SK_WMEM_MAX;
-__u32 sysctl_rmem_default __read_mostly = SK_RMEM_MAX;
-
 DEFINE_STATIC_KEY_FALSE(memalloc_socks_key);
 EXPORT_SYMBOL_GPL(memalloc_socks_key);
 
@@ -1333,7 +1325,7 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		 * play 'guess the biggest size' games. RCVBUF/SNDBUF
 		 * are treated in BSD as hints
 		 */
-		val = min_t(u32, val, READ_ONCE(sysctl_wmem_max));
+		val = min_t(u32, val, READ_ONCE(sock_net(sk)->core.sysctl_wmem_max));
 set_sndbuf:
 		/* Ensure val * 2 fits into an int, to prevent max_t()
 		 * from treating it as a negative value.
@@ -1365,7 +1357,7 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		 * play 'guess the biggest size' games. RCVBUF/SNDBUF
 		 * are treated in BSD as hints
 		 */
-		__sock_set_rcvbuf(sk, min_t(u32, val, READ_ONCE(sysctl_rmem_max)));
+		__sock_set_rcvbuf(sk, min_t(u32, val, READ_ONCE(sock_net(sk)->core.sysctl_rmem_max)));
 		break;
 
 	case SO_RCVBUFFORCE:
@@ -3618,8 +3610,8 @@ void sock_init_data_uid(struct socket *sock, struct sock *sk, kuid_t uid)
 	timer_setup(&sk->sk_timer, NULL, 0);
 
 	sk->sk_allocation	=	GFP_KERNEL;
-	sk->sk_rcvbuf		=	READ_ONCE(sysctl_rmem_default);
-	sk->sk_sndbuf		=	READ_ONCE(sysctl_wmem_default);
+	sk->sk_rcvbuf		=	READ_ONCE(sock_net(sk)->core.sysctl_rmem_default);
+	sk->sk_sndbuf		=	READ_ONCE(sock_net(sk)->core.sysctl_wmem_default);
 	sk->sk_state		=	TCP_CLOSE;
 	sk->sk_use_task_frag	=	true;
 	sk_set_socket(sk, sock);
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index c7769ee0d9c5..980f96703264 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -685,12 +685,9 @@ static struct ctl_table netns_core_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE
 	},
-	/* sysctl_core_net_init() will set the values after this
-	 * to readonly in network namespaces
-	 */
 	{
 		.procname	= "wmem_max",
-		.data		= &sysctl_wmem_max,
+		.data		= &init_net.core.sysctl_wmem_max,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
@@ -698,7 +695,7 @@ static struct ctl_table netns_core_table[] = {
 	},
 	{
 		.procname	= "rmem_max",
-		.data		= &sysctl_rmem_max,
+		.data		= &init_net.core.sysctl_rmem_max,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
@@ -706,7 +703,7 @@ static struct ctl_table netns_core_table[] = {
 	},
 	{
 		.procname	= "wmem_default",
-		.data		= &sysctl_wmem_default,
+		.data		= &init_net.core.sysctl_wmem_default,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
@@ -714,7 +711,7 @@ static struct ctl_table netns_core_table[] = {
 	},
 	{
 		.procname	= "rmem_default",
-		.data		= &sysctl_rmem_default,
+		.data		= &init_net.core.sysctl_rmem_default,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
@@ -748,13 +745,8 @@ static __net_init int sysctl_core_net_init(struct net *net)
 			goto err_dup;
 
 		for (i = 0; i < table_size; ++i) {
-			if (tbl[i].data == &sysctl_wmem_max)
-				break;
-
 			tbl[i].data += (char *)net - (char *)&init_net;
 		}
-		for (; i < table_size; ++i)
-			tbl[i].mode &= ~0222;
 	}
 
 	net->core.sysctl_hdr = register_net_sysctl_sz(net, "net/core", tbl, table_size);
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 6e18d7ec5062..7b7c5e4ea5d8 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1643,7 +1643,7 @@ void ip_send_unicast_reply(struct sock *sk, const struct sock *orig_sk,
 
 	sk->sk_protocol = ip_hdr(skb)->protocol;
 	sk->sk_bound_dev_if = arg->bound_dev_if;
-	sk->sk_sndbuf = READ_ONCE(sysctl_wmem_default);
+	sk->sk_sndbuf = READ_ONCE(net->core.sysctl_wmem_default);
 	ipc.sockc.mark = fl4.flowi4_mark;
 	err = ip_append_data(sk, &fl4, ip_reply_glue_bits, arg->iov->iov_base,
 			     len, 0, &ipc, &rt, MSG_DONTWAIT);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 9a6061017114..abc766b3936d 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -241,7 +241,7 @@ void tcp_select_initial_window(const struct sock *sk, int __space, __u32 mss,
 	if (wscale_ok) {
 		/* Set window scaling on max possible window */
 		space = max_t(u32, space, READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_rmem[2]));
-		space = max_t(u32, space, READ_ONCE(sysctl_rmem_max));
+		space = max_t(u32, space, READ_ONCE(sock_net(sk)->core.sysctl_rmem_max));
 		space = min_t(u32, space, window_clamp);
 		*rcv_wscale = clamp_t(int, ilog2(space) - 15,
 				      0, TCP_MAX_WSCALE);
diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index 3402675bf521..62f30d5c25c7 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1280,12 +1280,12 @@ static void set_sock_size(struct sock *sk, int mode, int val)
 	lock_sock(sk);
 	if (mode) {
 		val = clamp_t(int, val, (SOCK_MIN_SNDBUF + 1) / 2,
-			      READ_ONCE(sysctl_wmem_max));
+			      READ_ONCE(sock_net(sk)->core.sysctl_wmem_max));
 		sk->sk_sndbuf = val * 2;
 		sk->sk_userlocks |= SOCK_SNDBUF_LOCK;
 	} else {
 		val = clamp_t(int, val, (SOCK_MIN_RCVBUF + 1) / 2,
-			      READ_ONCE(sysctl_rmem_max));
+			      READ_ONCE(sock_net(sk)->core.sysctl_rmem_max));
 		sk->sk_rcvbuf = val * 2;
 		sk->sk_userlocks |= SOCK_RCVBUF_LOCK;
 	}
diff --git a/tools/testing/selftests/net/netns-sysctl.sh b/tools/testing/selftests/net/netns-sysctl.sh
index 45c34a3b9aae..bb6f173a28e2 100755
--- a/tools/testing/selftests/net/netns-sysctl.sh
+++ b/tools/testing/selftests/net/netns-sysctl.sh
@@ -20,21 +20,31 @@ fail() {
 setup_ns test_ns
 
 for sc in {r,w}mem_{default,max}; do
-	# check that this is writable in a netns
+	initial_value="$(sysctl -n "net.core.$sc")"
+
+	# check that this is writable in the init netns
 	[ -w "/proc/sys/net/core/$sc" ] ||
 		fail "$sc isn't writable in the init netns!"
 
-	# change the value in the host netns
+	# change the value in the init netns
 	sysctl -qw "net.core.$sc=300000" ||
 		fail "Can't write $sc in init netns!"
 
-	# check that the value is read from the init netns
-	[ "$(ip netns exec $test_ns sysctl -n "net.core.$sc")" -eq 300000 ] ||
+	# check that the value did not change in the test netns
+	[ "$(ip netns exec $test_ns sysctl -n "net.core.$sc")" -eq "$initial_value" ] ||
 		fail "Value for $sc mismatch!"
 
-	# check that this isn't writable in a netns
-	ip netns exec $test_ns [ -w "/proc/sys/net/core/$sc" ] &&
-		fail "$sc is writable in a netns!"
+	# check that this is also writable in the test netns
+	ip netns exec $test_ns [ -w "/proc/sys/net/core/$sc" ] ||
+		fail "$sc isn't writable in the test netns!"
+
+	# change the value in the test netns
+	ip netns exec $test_ns sysctl -qw "net.core.$sc=200000" ||
+		fail "Can't write $sc in test netns!"
+
+	# check that the value is read from the test netns
+	[ "$(ip netns exec $test_ns sysctl -n "net.core.$sc")" -eq 200000 ] ||
+		fail "Value for $sc mismatch!"
 done
 
 echo 'Test passed OK'
-- 
2.47.2


