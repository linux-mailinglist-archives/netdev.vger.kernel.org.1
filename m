Return-Path: <netdev+bounces-177357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3608EA6FB2A
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 13:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7518E174988
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 12:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C382571AE;
	Tue, 25 Mar 2025 12:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orbstack.dev header.i=@orbstack.dev header.b="LvR8AKHU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649E22571AC
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 12:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905078; cv=none; b=MN6zOmQaBJBRHZVo9hbxBHtT9cPqDBGMWlu/HQA9PIxZdVhiMJgMjed+GgJaWuY/KV3vbPoxzQjA7mqm6bsCfyhRY/E15XTPd82mLK9EKHeDChy/FaPunrVg5T9K8Z4v1RAb31RhkO/4qeStvdjrh6Soywajtnl5oRg2wSQcJFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905078; c=relaxed/simple;
	bh=ybBxi4WQcURKoE4BxCGqK8VSt1MHM5Lsow1LinLQwcs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=D6rU/hJlpeg0Fjg5L6WJWQJ+PYLUop+s0JfOkfRJhCDZO90xjAhtLX6A7P5TcH29ErTAx52ZBVl+OpAC3TrlsB5RPql2Ub11/DrC//3CG8sHlaF6XoyGEtlGK4G/ezSKHXXWtYHHib6r9Px64m1qntJ29udiafv0xfJeer38TkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=orbstack.dev; spf=pass smtp.mailfrom=orbstack.dev; dkim=pass (2048-bit key) header.d=orbstack.dev header.i=@orbstack.dev header.b=LvR8AKHU; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=orbstack.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orbstack.dev
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22401f4d35aso113014935ad.2
        for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 05:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=orbstack.dev; s=google; t=1742905075; x=1743509875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ag0uHziDOMxcedxURrdSLZ+7TR1r0QSkH/f14RF03UI=;
        b=LvR8AKHULQZLQ+K8YgraiK+jfgudXpyPmlUSeOVnhktwBWzmwFFidKjebHr8OmIut2
         uh2a8XkCfM6pWv+AEESft+ejpVfpt2B6nkfiKeWG4FM9D4BFhky59PXE2wyOggD1swTd
         da4wwUslXhXCq9xiDsaglt3hhxb2+57yOdjGsBcy7jEVdDzTEvYR0Funx7hcZI7LIIv8
         4n8yfDnvghcT3UHtF1BXAzJG0J43Bz5zjc7r88Pgw6c9ZuHIAdL+UEKllrytwgQTM+7d
         AVkf++B41BaAMFTzotQBnLfpUVRRc5XG3gAndn1HDNix/VdUZKHiUywWr22Gm0ZMybTf
         zS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742905075; x=1743509875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ag0uHziDOMxcedxURrdSLZ+7TR1r0QSkH/f14RF03UI=;
        b=WYQJB/rNo3WiQIj1ztwjSip0WFEHmzACox5zukGJJcHMcWrYM4zMVwM8TT5+ztlv10
         AbojqFSeDIBCOHcgThfPGqraXpL1X+COOLzSfBQX902PuQi7qK8Strita2U6+tjg+y5t
         kbhn0nl6Mx4/QmC3iz4+oGMsl45Z6WiF5veBOZdr4VI7KPrYuV9St8A9oNqqPoRAy2kJ
         mjkrqOWr/Cf7B0JnDvGf6xCz91YwkJ6F7XcX/6gTkpBDPCjiscRHDBPxSZsvCX2aGnB/
         q4hIPrknaNkn4HwkT/i3WxTtzq5QHReKI8aZz7p/Aa57wHRCWCeN8gXeSG/TyTdpB9G/
         wHvg==
X-Forwarded-Encrypted: i=1; AJvYcCVSBRoQr44sonLuh2BGn28dIdX2AOXX8zuR+Tkb1Rx8Vb3PZwevvM319r3qO8jfrKuL7ka4bUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpNW0Y0+437KFeE3JNoCDObvF9FE9XPCzsnMxm9V5ntLqHS3Rb
	33VykEkROEkGE21lGsYTpUg4bLqG0IvOZ9hvEqx29h/Hx/rgq6X3JKBGstvgInU=
X-Gm-Gg: ASbGncudccWc430crkyiyycR8MPtZeLNRK15f77Lv2cXm75uMP7oCripOOCNJkgOyJM
	tvgJdg62JC6gRHxomT/Ki7Or6enOXoBPCIqO1+MK+MLhZuNIrAHdtgJo7KYGDcXX3o6lT6pBpKV
	a+WLptRlXwyQTwGD5xdGLe+wYR5AsOX6i1NQNPUYDy6pwmJPlinLxsgXioNeuIEmOzQGPynTqnY
	t0NNqWU50Fs0T+3r+aYyMeKuM/n2i4WqNeHcq7jxb6KQijGhmD9acw54UmBQU+qJqVtA1Nh0aJM
	DDnWz7nC6AOkvFbjwZDquVDZVpidaDAsjPF/P5xrr4KifyCP
X-Google-Smtp-Source: AGHT+IGBEROC9LwfVluDcJ1ldvUULQj+FL1dzyRB0E5diW93dVj83d6ug/a42wlQE8EVJ+A2LnbK7w==
X-Received: by 2002:aa7:88c9:0:b0:730:7600:aeab with SMTP id d2e1a72fcca58-739059c5da7mr26790456b3a.13.1742905075272;
        Tue, 25 Mar 2025 05:17:55 -0700 (PDT)
Received: from debian.. ([136.24.187.18])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a284888bsm8900204a12.46.2025.03.25.05.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 05:17:54 -0700 (PDT)
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
Date: Tue, 25 Mar 2025 05:17:33 -0700
Message-ID: <20250325121745.8061-1-danny@orbstack.dev>
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


