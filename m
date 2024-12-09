Return-Path: <netdev+bounces-150370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9609E9FC6
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 20:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3BEE281B57
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 19:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08348197A7F;
	Mon,  9 Dec 2024 19:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="VyBAuZon"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39941991B6
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 19:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733773112; cv=none; b=C8GWEgilTR+bQYqVrah+g3NoBzcxSXo/PtWM59z/n2aWkstXDDvWdmar+8hkVfXrzJz7dQGvKgj+rOMlXJVC1Sh1IMnrXNfypSIVq4+IWJ6UtRer70z6W5ckyeLgfyXLIRyKDYa9ICQd75PW4KJRMRwe24iIMveTbdxVZ3Kr5QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733773112; c=relaxed/simple;
	bh=5CHrWMLRIxP7c0cWea4ZbWbyfQzs2N+HqrhrDSlKyX8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jbfCZvC+sz/Cs4ry5f7lM+KnqDyU0p2BtH6WKVYU9mE7GYGazMuN0TZ+zK+64AEBqRriunJfQOzDXXLz8tF/mIgav/7o+dCrQqn1Ct9p80Xs0ro7BvNDObi8udaM/iPHHziGcWJRnNUmYbTrSbh+09uooK+e6hr6QC1dPU0ISBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=VyBAuZon; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d122cf8dd1so7764553a12.2
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 11:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1733773109; x=1734377909; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cstJMnDOutaoiG37MzJFdrflzl7OVC4KmEkZCpPnHmk=;
        b=VyBAuZonOovVWtFwaavqPS3GB/qDznonwp0nYvM6CxVvAm3ipOYTqTdHcl/qpsfchF
         hHtCrAZ4Xz3MupWKpsek3eDX18gw69l9POFud0SnTmbI1K/9xCw6bk3WgXiO+GtySojj
         m7T2jXv5MNVauTlllKPsksEiUl6eUIm/PTxsrQyt2FcKsF89MeA0MGaKffa9Q2hgCP6Y
         VzGk5y8v8Lr4daFIRt4Ekr+aiW25tmneb58c51zhajvQ8G1SiJWeK0Y1Oh5aiMd0zp8J
         2KwicWop8Yk3ioXx/4bqHoHBySrJ0MJYvGzEttBoX25XkqQXLFIzOjPb1783EcdnzTsU
         CasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733773109; x=1734377909;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cstJMnDOutaoiG37MzJFdrflzl7OVC4KmEkZCpPnHmk=;
        b=kzd+NVVvwensFdWY++1b37C2Nb59/cOAQnUeU8TL0d7zmnos14c4GJKqQ5rNCaYTf0
         zFsmiL530OV3+c/6We8cp4ko6jlfSnzwvp/iCSQejhjEP/7Lj3bQwOJuxS9PrZOLMMsp
         Y2ZM2loA9QJRTVCz8Sx1zZw4ZQuhNuyN+iqtQ3egJ6+homlJQuuafl6ehW/BJTS68K9m
         G2utiSwsaey4H063GcgytwynKhCUiT4cetplCkPZG8S8JdM+Tnk2ghBU9JaW7d3/2wMK
         2iALsYnjOzpvJHw9ygjRRrgraDYdzIFQszhAHbJxXZ/XTpf/fPPiHEMV/d9RbXXmn4bC
         TNeA==
X-Gm-Message-State: AOJu0YysekHmjA9/2mhQ1xI73lXFwIwQjFGPhPptlmK/TxcRXmZlyipm
	E2dMo/tWu3SMX+Mpy8x+qN9+WDU1giBuwHJC84apkZ/U1sPlBoNL8/G0fIY7jCw=
X-Gm-Gg: ASbGncv9xIeTSDD+i7n5QKSIAbXTAgsLDZWb3onCLqvp6TPFg+t/I6NeceMb3BoU8Kn
	b1wZS9IqWNG1XqkPdahK06IW3rFM5BjfsDWOeoRGj2mc3c108wx6oEo6dmkUXv5Anfh8jQp1Ubg
	zWw2hCe5U9pnitpHDkiGxgqkIUOhizKpxUriqb2z46DQvNApOArAo5fn4TLeNluGuyzDNQJ6bBC
	eO6nEPkovkYfmsGk5hkpS8mS73+Txlta7Lz23Q4wK40oxU=
X-Google-Smtp-Source: AGHT+IEs0t2WFKIhxStR8J3zY+7V04z37UytXeA88km7ZSFfGsY6ZVbqkCvCf7/7C7bRJr9VyHiTbA==
X-Received: by 2002:aa7:dcc1:0:b0:5d3:ce7f:abe4 with SMTP id 4fb4d7f45d1cf-5d3ce7feb52mr12834562a12.25.1733773109055;
        Mon, 09 Dec 2024 11:38:29 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:506b:2387::38a:52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3c4a42052sm5188061a12.55.2024.12.09.11.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 11:38:27 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 09 Dec 2024 20:38:04 +0100
Subject: [PATCH net-next v2 2/2] tcp: Add sysctl to configure TIME-WAIT
 reuse delay
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-jakub-krn-909-poc-msec-tw-tstamp-v2-2-66aca0eed03e@cloudflare.com>
References: <20241209-jakub-krn-909-poc-msec-tw-tstamp-v2-0-66aca0eed03e@cloudflare.com>
In-Reply-To: <20241209-jakub-krn-909-poc-msec-tw-tstamp-v2-0-66aca0eed03e@cloudflare.com>
To: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>, 
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

Turn the reuse delay into a per-netns setting so that sysadmins can make
more aggressive assumptions about remote TCP timestamp clock frequency and
shorten the delay in order to allow connections to reincarnate faster.

Note that applications can completely bypass the TIME-WAIT delay protection
already today by locking the local port with bind() before connecting. Such
immediate connection reuse may result in PAWS failing to detect old
duplicate segments, leaving us with just the sequence number check as a
safety net.

This new configurable offers a trade off where the sysadmin can balance
between the risk of PAWS detection failing to act versus exhausting ports
by having sockets tied up in TIME-WAIT state for too long.

[1] https://lpc.events/event/16/contributions/1349/

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 Documentation/networking/ip-sysctl.rst                     | 14 ++++++++++++++
 .../networking/net_cachelines/netns_ipv4_sysctl.rst        |  1 +
 include/net/netns/ipv4.h                                   |  1 +
 net/ipv4/sysctl_net_ipv4.c                                 | 10 ++++++++++
 net/ipv4/tcp_ipv4.c                                        |  4 +++-
 5 files changed, 29 insertions(+), 1 deletion(-)

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
index 3b6ba1d16921e079d5ba08c3c0b98dccace8c370..e45222d5fc2e2a3409e2a93c78588ab6a352f2f9 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -163,7 +163,8 @@ int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
 	   and use initial timestamp retrieved from peer table.
 	 */
 	ts_recent_stamp = READ_ONCE(tcptw->tw_ts_recent_stamp);
-	reuse_thresh = READ_ONCE(tw->tw_entry_stamp) + MSEC_PER_SEC;
+	reuse_thresh = READ_ONCE(tw->tw_entry_stamp) +
+		       READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_tw_reuse_delay);
 	if (ts_recent_stamp &&
 	    (!twp || (reuse && time_after32(tcp_clock_ms(), reuse_thresh)))) {
 		/* inet_twsk_hashdance_schedule() sets sk_refcnt after putting twsk
@@ -3458,6 +3459,7 @@ static int __net_init tcp_sk_init(struct net *net)
 	net->ipv4.sysctl_tcp_fin_timeout = TCP_FIN_TIMEOUT;
 	net->ipv4.sysctl_tcp_notsent_lowat = UINT_MAX;
 	net->ipv4.sysctl_tcp_tw_reuse = 2;
+	net->ipv4.sysctl_tcp_tw_reuse_delay = 1 * MSEC_PER_SEC;
 	net->ipv4.sysctl_tcp_no_ssthresh_metrics_save = 1;
 
 	refcount_set(&net->ipv4.tcp_death_row.tw_refcount, 1);

-- 
2.43.0


