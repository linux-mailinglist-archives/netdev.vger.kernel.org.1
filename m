Return-Path: <netdev+bounces-144354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 357249C6C62
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 11:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7D2A28BCB2
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 10:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E641FB895;
	Wed, 13 Nov 2024 10:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="UnSxlqbc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7A11FBC85
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 10:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731492467; cv=none; b=XPYNQlPO7Rjq1kBTL8VPNlCtjEvoBZm734+CWAEITOne1mWlQmhW2TKuF0V8sKAyZOBACtk2HgdjfpO2lTSCrv3mcVUeCqWK6OmGDYTZ5XOEwRO4sh+xzPYfO7FL80xWST/pmA6Y9z6zzjZAbKoin1O49HTFE53OkXESAHAUgSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731492467; c=relaxed/simple;
	bh=2Dd9MJrbvfn3iBa9MjCc87XVVMynLmWbf+pMYQtQ+N8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pzMpyGrEXHUz5zxFugxzGN+cl5f4R081x9VvRMDTn/2W3sHZ+fGeDBpf+1zo5hcdBVdxkKjuvyPY5H4sn0YyV/hM607Cznp2pI2PPt1SUfigUDwb6i0ocvhNPdeh+Kqc1iT/qI+Hdht228U4gRT0t3oQHR11cs6BdRjRYNqIxWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=UnSxlqbc; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9a0c7abaa6so862606566b.2
        for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 02:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1731492463; x=1732097263; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aSlxB19YJO8xt936wecAE4P2Sab0s89QlyjcV+GkNfE=;
        b=UnSxlqbc2mm5l9ah3mj3FOEj21nQORHDQs21MWeAksjSmcUo9KL5qDgWnHrqsuQ/Ch
         f8CcTVw3khPZvAdtSfLjpYvhmoosz+wmOJVf4e7w20tD5gWBewtTJWHleBA+zkeeSzXA
         b4MM68shIXeH0rbHqM0xic0ulbpx6krHkI1ZD+ZqjycsB+BWNhGJ4aw4oC/HVF03BEcU
         yR+gdGyL9n5N6761JqYwssOlmmvtAI25Qia6ragvy/Iwhs39Ts05mikYHqLfZEUYFeYm
         L0hUv06I4QYxgXGJLwLIaAeTY4cUQoXXpxLQNBDhn9rUlTlKHCcKtMxKRiOOwEaDpn2Z
         LX1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731492463; x=1732097263;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aSlxB19YJO8xt936wecAE4P2Sab0s89QlyjcV+GkNfE=;
        b=FheVOqoY/OQnzcHVTyTmwbyF08ejoF235mz24MHgRau4o9V4jNCSqDTGUwb3SE0/0R
         ySCGnd4LB4GtBnsQl0WAeG2G+8AAZXkDOhCXhpkNkSYdZDZolbNcpgSEdlLafUZMf8wU
         VoOVAsX5Uk0vAxh4fabL7RehNZCzzlOTyg1FeWqnxppuC9pCc0P6UoZu1hr8Ok1/Ae5h
         6uZ1ZBRvHuAk8nMLpvRze31Q/vwTU893HMpiSx2T7PFckiPkzyUipfxqo3YvAFftJS40
         yVfp7HtkHGQ9vdEx92X+eK2wiWsZ2CmVidn7Sdoc22OTz4pXiyTpuLhczxmFHo3APWim
         JWdQ==
X-Gm-Message-State: AOJu0YymLyEZQ3MrLuU2WEtSc2cS994/X2nRcXXbUupnvbOFmJ+S9A3u
	+Zee5bx79mcwdlRx8dvdlUHRSyW6Nk+hHADx95IXOtzVroDWqDuzkLo0oUaK+28=
X-Google-Smtp-Source: AGHT+IGYHFIxCEr29qMddSkGDNc3/M3bDaVdc3VAuEgNnJTNSE1EIAM5hKbVTSow69ghoNshnJ79Ew==
X-Received: by 2002:a17:907:9688:b0:a9a:ea4:2834 with SMTP id a640c23a62f3a-a9eeff38820mr1860347066b.33.1731492462630;
        Wed, 13 Nov 2024 02:07:42 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:506b:2dc::49:c0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a4c0dbsm860250166b.66.2024.11.13.02.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 02:07:41 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 13 Nov 2024 11:06:43 +0100
Subject: [PATCH RFC net-next v2 2/2] tcp: Add sysctl to configure TIME-WAIT
 reuse delay
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-jakub-krn-909-poc-msec-tw-tstamp-v2-2-b0a335247304@cloudflare.com>
References: <20241113-jakub-krn-909-poc-msec-tw-tstamp-v2-0-b0a335247304@cloudflare.com>
In-Reply-To: <20241113-jakub-krn-909-poc-msec-tw-tstamp-v2-0-b0a335247304@cloudflare.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, 
 Jason Xing <kerneljasonxing@gmail.com>, 
 Adrien Vasseur <avasseur@cloudflare.com>, 
 Lee Valentine <lvalentine@cloudflare.com>, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-355e8

Today we have a hardcoded delay of 1 sec before a TIME-WAIT socket can be
reused by reopening a connection. This is a safe choice based on an
assumption that the other TCP timestamp clock frequency, which is unknown
to us, may be as low as 1 Hz (RFC 7323, section 5.4).

However, this means that in the presence of short lived connections with an
RTT of couple of milliseconds, the time during which a 4-tuple is blocked
from reuse can be orders of magnitude longer that the connection lifetime.
Combined with a reduced pool of ephemeral ports, when using
IP_LOCAL_PORT_RANGE to share an egress IP address between hosts [1], the
long TIME-WAIT reuse delay can lead to port exhaustion, where all available
4-tuples are tied up in TIME-WAIT state.

Make the reuse delay configurable so that sysadmins can make more
aggressive assumptions about remote TCP timestamp clock frequency and
shorten the delay in order to allow connections to reincarnate faster.

Note that applications can completely bypass the TIME-WAIT delay protection
already today by locking the local port with bind() before connecting. Such
immediate connection reuse may result in PAWS failing to detect old
duplicate segments, leaving us with just the sequence number check as a
safety net.

This new configurable offers a trade off where the sysadmin can balance
between the risk of PAWS detection failures versus exhausting ports by
having sockets tied up in TIME-WAIT state for too long.

[1] https://lpc.events/event/16/contributions/1349/

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 Documentation/networking/ip-sysctl.rst                     | 14 ++++++++++++++
 .../networking/net_cachelines/netns_ipv4_sysctl.rst        |  1 +
 include/net/netns/ipv4.h                                   |  1 +
 include/net/tcp.h                                          |  1 +
 net/ipv4/sysctl_net_ipv4.c                                 | 10 ++++++++++
 net/ipv4/tcp_ipv4.c                                        |  5 ++++-
 6 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index eacf8983e2307476895a8def7363375f2af36d9d..2f2b00295836be80e1da11370022ca083d7d1eb2 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -1000,6 +1000,20 @@ tcp_tw_reuse - INTEGER
 
 	Default: 2
 
+tcp_tw_reuse_delay - UNSIGNED INTEGER
+        The delay in milliseconds before a TIME-WAIT socket can be reused by a
+        new connection, if TIME-WAIT socket reuse is enabled. The actual reuse
+        threshold is within [N, N+1] range, where N is the requested delay in
+        milliseconds, to ensure the delay interval is never shorter than the
+        configured value.
+
+        This setting contains an assumption about the other TCP timestamp clock
+        tick interval. It should not be set to a value lower than the peer's
+        clock tick for PAWS (Protection Against Wrapped Sequence numbers)
+        mechanism work correctly for the reused connection.
+
+        Default: 1000 (milliseconds)
+
 tcp_window_scaling - BOOLEAN
 	Enable window scaling as defined in RFC1323.
 
diff --git a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
index 629da6dc6d746ce8058cfbe2215d33d55ca4c19d..de0263302f16dd815593671c4f75a93ed6f7cac4 100644
--- a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
+++ b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
@@ -79,6 +79,7 @@ u8                              sysctl_tcp_retries1
 u8                              sysctl_tcp_retries2
 u8                              sysctl_tcp_orphan_retries
 u8                              sysctl_tcp_tw_reuse                                                                  timewait_sock_ops
+unsigned_int                    sysctl_tcp_tw_reuse_delay                                                            timewait_sock_ops
 int                             sysctl_tcp_fin_timeout                                                               TCP_LAST_ACK/tcp_rcv_state_process
 unsigned_int                    sysctl_tcp_notsent_lowat                     read_mostly                             tcp_notsent_lowat/tcp_stream_memory_free
 u8                              sysctl_tcp_sack                                                                      tcp_syn_options
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 3c014170e0012818db36d4a7a327025e3fa00dd1..46452da352061007d19d00fdacddd25bbe56444d 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -175,6 +175,7 @@ struct netns_ipv4 {
 	u8 sysctl_tcp_retries2;
 	u8 sysctl_tcp_orphan_retries;
 	u8 sysctl_tcp_tw_reuse;
+	unsigned int sysctl_tcp_tw_reuse_delay;
 	int sysctl_tcp_fin_timeout;
 	u8 sysctl_tcp_sack;
 	u8 sysctl_tcp_window_scaling;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index e9b37b76e894bb8d6715bbea4006d9157085cf5c..e1119f0a476b5cc2396af669bb28f91ac654d7b2 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -185,6 +185,7 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
 					 * timestamps. It must be less than
 					 * minimal timewait lifetime.
 					 */
+
 /*
  *	TCP option
  */
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index a79b2a52ce01e6c1a1257ba31c17ac2f51ba19ec..42cb5dc9cb245c26f9a38f8c8c4b26b1adddca39 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -45,6 +45,7 @@ static unsigned int tcp_child_ehash_entries_max = 16 * 1024 * 1024;
 static unsigned int udp_child_hash_entries_max = UDP_HTABLE_SIZE_MAX;
 static int tcp_plb_max_rounds = 31;
 static int tcp_plb_max_cong_thresh = 256;
+static unsigned int tcp_tw_reuse_delay_max = TCP_PAWS_MSL * MSEC_PER_SEC;
 
 /* obsolete */
 static int sysctl_tcp_low_latency __read_mostly;
@@ -1065,6 +1066,15 @@ static struct ctl_table ipv4_net_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_TWO,
 	},
+	{
+		.procname	= "tcp_tw_reuse_delay",
+		.data		= &init_net.ipv4.sysctl_tcp_tw_reuse_delay,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_douintvec_minmax,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= &tcp_tw_reuse_delay_max,
+	},
 	{
 		.procname	= "tcp_max_syn_backlog",
 		.data		= &init_net.ipv4.sysctl_max_syn_backlog,
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 501e9265b6ebab475ae0a957175286fb153918e6..40ef91cb3eb511cc19bb96c6fd648cf8f8175655 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -120,6 +120,7 @@ int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
 	const struct tcp_timewait_sock *tcptw = tcp_twsk(sktw);
 	struct tcp_sock *tp = tcp_sk(sk);
 	u32 ts_recent_stamp;
+	u32 reuse_delay;
 
 	if (READ_ONCE(tw->tw_substate) == TCP_FIN_WAIT2)
 		reuse = 0;
@@ -162,9 +163,10 @@ int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
 	   and use initial timestamp retrieved from peer table.
 	 */
 	ts_recent_stamp = READ_ONCE(tcptw->tw_ts_recent_stamp);
+	reuse_delay = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_tw_reuse_delay);
 	if (ts_recent_stamp &&
 	    (!twp || (reuse && time_after32(tcp_clock_ms(),
-					    ts_recent_stamp + MSEC_PER_SEC)))) {
+					    ts_recent_stamp + reuse_delay)))) {
 		/* inet_twsk_hashdance_schedule() sets sk_refcnt after putting twsk
 		 * and releasing the bucket lock.
 		 */
@@ -3457,6 +3459,7 @@ static int __net_init tcp_sk_init(struct net *net)
 	net->ipv4.sysctl_tcp_fin_timeout = TCP_FIN_TIMEOUT;
 	net->ipv4.sysctl_tcp_notsent_lowat = UINT_MAX;
 	net->ipv4.sysctl_tcp_tw_reuse = 2;
+	net->ipv4.sysctl_tcp_tw_reuse_delay = 1 * MSEC_PER_SEC;
 	net->ipv4.sysctl_tcp_no_ssthresh_metrics_save = 1;
 
 	refcount_set(&net->ipv4.tcp_death_row.tw_refcount, 1);

-- 
2.43.0


