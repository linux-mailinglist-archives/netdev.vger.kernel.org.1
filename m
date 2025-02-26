Return-Path: <netdev+bounces-169753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF8CA45900
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 09:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E2733A0F7A
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 08:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB96B24DFFC;
	Wed, 26 Feb 2025 08:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orbstack.dev header.i=@orbstack.dev header.b="ScDO44vn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B67924DFEC
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 08:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740559968; cv=none; b=hFbm0WusQYCCeshzX0Q9nH7wRNz7WrbC+jmjDHhWLCCnOsTQa8DQRrDZN3HNju0hSXUHER27KKtKdDloERUMGC05rCKlFpjgomXz0sSSePZ8Y+cPsU/X2/I+KIO4clewSbEyII5FtxF6NM9Ol7pTgktgJiZBRJz/N6TlKfDMbLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740559968; c=relaxed/simple;
	bh=WhBjwiDPvzA2J3MRTXehQXn6xz5waK1mG59taYN0bmo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mGr+0vhGdvYlbaC7LZFJU0WloJ1XQqSAvSKokhEtPJqC8ClR8VA6CU3/TthjvOGyDp7z4GedOAMhavkw36Qfap/2c237sH4xzcCviqjMfPN00FPRGfDAjpZpCv9dFNinQOa52pF7n+9O/gNLqjZGk8EWyPurEX+497PMCOSZ8Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=orbstack.dev; spf=pass smtp.mailfrom=orbstack.dev; dkim=pass (2048-bit key) header.d=orbstack.dev header.i=@orbstack.dev header.b=ScDO44vn; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=orbstack.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orbstack.dev
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22339936bbfso975245ad.1
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 00:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=orbstack.dev; s=google; t=1740559964; x=1741164764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=J/evB7uf2d+D96aiq40k7urUc7qUnnEsGdStCHDhXYg=;
        b=ScDO44vnQea39rNw2M0elW+VUJ+YRRHlPSiobioucIm20FsSYXtc9Pz4OA1HHQFH54
         ePBTy4rTy1B+FbLq3J0JZJ9gg/UcGuM/CfpW1GFgZ13S5nTjvN6iX9oh2hBs2PQu2aAN
         yRruCsoe7M62+D+2aS1pd9HIC3qS6VqTYRtoQFH7yODoX+oLPUu/q3IHv9MLQU2yI/SQ
         3hUFDSviOOvrnnzPABsuiw5oiNNyjDfII3Qpb9g7+SmvIxcqpMmDktxnu2j9r1Q7EfXS
         P7mw5dF262O9jFqj2dGLyAv0/XmHaG5nvwqfAqrl3nr7Qx3bOe85qdBRwWaiHQBuQG4M
         YeuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740559964; x=1741164764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J/evB7uf2d+D96aiq40k7urUc7qUnnEsGdStCHDhXYg=;
        b=VcEFnucU6cRnAjrPqnPoIiqnQw9Z/lXxU+V4pJ2o1Z0yhKzgLHX5xam3pr8jIJAHYq
         SVP28SiWxIjcQz1HLOUDiXOJHyqWCSwGwR4oZpU4JCvRbzacWn2Yw7o3SEr0jCdOOokw
         fn/QjPA6w/hpjlkjMgn1TJD2BEFjHuKwnmHYD6xYUAmE7cn4+UQXC9eCAw75wP9QmlMY
         tL6HMZ0OGty6a1GjKQjPzGVAgko7ISKtCGZNVUVjOCBX+Cgr9TSWFoQ8C8/xWNgBoBrQ
         XQWmfz4iv5Hi/UTH+5bhiXOej7RxjWT1tRi9NzFxWv/3ETH9YgPOL67jAhJSvM2HT1II
         zXRg==
X-Forwarded-Encrypted: i=1; AJvYcCUeBh3R6vbZvcEZus93ZXvrySEebWAgKivcvIcwfIy5XKzspyYS8qca0ziWGa1+4clHEVbpmR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvePCR0mnI0h+ZowkaNve6BGgK5132/3OrPEVurudKNtlU0ogV
	A7Cqz13TseSp7eJgltWNZ/R++4yYzbYHJ1J1Y/vE9RtXgbaeZ3F01OApCXCpDFA=
X-Gm-Gg: ASbGncthcYjdbKvnh/DBdl9IcDlKYNByhqPYuvjDBJphOe3lcxZF7L+5nYL3VFcQT+8
	jxF4cou1HkIw4TXRF3HKSkWUOVsTzQDvPrqgD5cjuq1XhBCgrAk4A45/494j/pX/ADQA2HnWAeG
	XEiQJn5Pf8jDiwYrd6kc7P/xb68TzROLqMcPfBrfFy1mOL1Sj6Ctmox7e2N0FMWbAx5CDpmQPHM
	VJe1AHuqmfHX3xONnXIoV38tHWRt5cBRiin5QU2Rr7ZMrZUTbtO3f1SZBQ7MXYk2tcNA6Srmyuc
	D/5yQy/xg4Smul2VbOIi9qXV82hqV4aldrw=
X-Google-Smtp-Source: AGHT+IE+xqqgeYMr7ghCdbEjkF6yqw+n7eC3jV64oYYrQQdw6SHriJ93xizUlVpjhB2h6xp6qZdq9A==
X-Received: by 2002:a17:903:2f43:b0:215:89a0:416f with SMTP id d9443c01a7336-2219ffc2dcbmr302987615ad.30.1740559964574;
        Wed, 26 Feb 2025 00:52:44 -0800 (PST)
Received: from debian.. ([68.65.164.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a0a6006sm26944675ad.179.2025.02.26.00.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 00:52:44 -0800 (PST)
From: Danny Lin <danny@orbstack.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Danny Lin <danny@orbstack.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: fully namespace net.core.{r,w}mem_{default,max} sysctls
Date: Wed, 26 Feb 2025 00:52:27 -0800
Message-ID: <20250226085229.7882-1-danny@orbstack.dev>
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
 include/net/netns/core.h        |  5 +++++
 include/net/sock.h              |  6 ------
 net/core/net_namespace.c        | 21 +++++++++++++++++++++
 net/core/sock.c                 | 16 ++++------------
 net/core/sysctl_net_core.c      | 17 +++++------------
 net/ipv4/ip_output.c            |  2 +-
 net/ipv4/tcp_output.c           |  2 +-
 net/netfilter/ipvs/ip_vs_sync.c |  4 ++--
 8 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/include/net/netns/core.h b/include/net/netns/core.h
index 78214f1b43a2..d943d980403f 100644
--- a/include/net/netns/core.h
+++ b/include/net/netns/core.h
@@ -16,6 +16,11 @@ struct netns_core {
 	int	sysctl_optmem_max;
 	u8	sysctl_txrehash;
 
+	u32 sysctl_wmem_max;
+	u32 sysctl_rmem_max;
+	u32 sysctl_wmem_default;
+	u32 sysctl_rmem_default;
+
 #ifdef CONFIG_PROC_FS
 	struct prot_inuse __percpu *prot_inuse;
 #endif
diff --git a/include/net/sock.h b/include/net/sock.h
index fa055cf1785e..11f8c51ca1f7 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2818,14 +2818,8 @@ void sk_get_meminfo(const struct sock *sk, u32 *meminfo);
 #define SK_WMEM_MAX		(_SK_MEM_OVERHEAD * _SK_MEM_PACKETS)
 #define SK_RMEM_MAX		(_SK_MEM_OVERHEAD * _SK_MEM_PACKETS)
 
-extern __u32 sysctl_wmem_max;
-extern __u32 sysctl_rmem_max;
-
 extern int sysctl_tstamp_allow_data;
 
-extern __u32 sysctl_wmem_default;
-extern __u32 sysctl_rmem_default;
-
 #define SKB_FRAG_PAGE_ORDER	get_order(32768)
 DECLARE_STATIC_KEY_FALSE(net_high_order_alloc_disable_key);
 
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 70fea7c1a4b0..092500975bd3 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -317,6 +317,27 @@ static __net_init void preinit_net_sysctl(struct net *net)
 	 */
 	net->core.sysctl_optmem_max = 128 * 1024;
 	net->core.sysctl_txrehash = SOCK_TXREHASH_ENABLED;
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
index b4985f011bc5..771b1ee0a299 100644
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
 int sysctl_tstamp_allow_data __read_mostly = 1;
 
 DEFINE_STATIC_KEY_FALSE(memalloc_socks_key);
@@ -1322,7 +1314,7 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		 * play 'guess the biggest size' games. RCVBUF/SNDBUF
 		 * are treated in BSD as hints
 		 */
-		val = min_t(u32, val, READ_ONCE(sysctl_wmem_max));
+		val = min_t(u32, val, READ_ONCE(sock_net(sk)->core.sysctl_wmem_max));
 set_sndbuf:
 		/* Ensure val * 2 fits into an int, to prevent max_t()
 		 * from treating it as a negative value.
@@ -1354,7 +1346,7 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		 * play 'guess the biggest size' games. RCVBUF/SNDBUF
 		 * are treated in BSD as hints
 		 */
-		__sock_set_rcvbuf(sk, min_t(u32, val, READ_ONCE(sysctl_rmem_max)));
+		__sock_set_rcvbuf(sk, min_t(u32, val, READ_ONCE(sock_net(sk)->core.sysctl_rmem_max)));
 		break;
 
 	case SO_RCVBUFFORCE:
@@ -3545,8 +3537,8 @@ void sock_init_data_uid(struct socket *sock, struct sock *sk, kuid_t uid)
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
index 5dd54a813398..e2bd79189f42 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -668,12 +668,9 @@ static struct ctl_table netns_core_table[] = {
 		.extra2		= SYSCTL_ONE,
 		.proc_handler	= proc_dou8vec_minmax,
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
@@ -681,7 +678,7 @@ static struct ctl_table netns_core_table[] = {
 	},
 	{
 		.procname	= "rmem_max",
-		.data		= &sysctl_rmem_max,
+		.data		= &init_net.core.sysctl_rmem_max,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
@@ -689,7 +686,7 @@ static struct ctl_table netns_core_table[] = {
 	},
 	{
 		.procname	= "wmem_default",
-		.data		= &sysctl_wmem_default,
+		.data		= &init_net.core.sysctl_wmem_default,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
@@ -697,12 +694,13 @@ static struct ctl_table netns_core_table[] = {
 	},
 	{
 		.procname	= "rmem_default",
-		.data		= &sysctl_rmem_default,
+		.data		= &init_net.core.sysctl_rmem_default,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &min_rcvbuf,
 	},
+	// dummy line to cause merge conflict if this changes
 };
 
 static int __init fb_tunnels_only_for_init_net_sysctl_setup(char *str)
@@ -731,13 +729,8 @@ static __net_init int sysctl_core_net_init(struct net *net)
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
index 49811c9281d4..d7c906164674 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1637,7 +1637,7 @@ void ip_send_unicast_reply(struct sock *sk, struct sk_buff *skb,
 
 	sk->sk_protocol = ip_hdr(skb)->protocol;
 	sk->sk_bound_dev_if = arg->bound_dev_if;
-	sk->sk_sndbuf = READ_ONCE(sysctl_wmem_default);
+	sk->sk_sndbuf = READ_ONCE(net->core.sysctl_wmem_default);
 	ipc.sockc.mark = fl4.flowi4_mark;
 	err = ip_append_data(sk, &fl4, ip_reply_glue_bits, arg->iov->iov_base,
 			     len, 0, &ipc, &rt, MSG_DONTWAIT);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 6d5387811c32..08af982d8f03 100644
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
-- 
2.47.2


