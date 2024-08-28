Return-Path: <netdev+bounces-122910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1361963113
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 21:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6E111C23142
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 19:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463CF1AC42A;
	Wed, 28 Aug 2024 19:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ru+N3SM4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB301ABED9
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 19:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724874007; cv=none; b=WGFgXUf2yqmHtejWEFwRZBXb3XgGIKgWoRl9c5FjJU7KJQsktLq1yDhXRUmHQDUV9RUE+C9kXJE0Qd8MGecO6gUwmI3f0mymjIQW1NEarq4a0FmLhTGYbmgUGQozbDF5D15NO7NcndvStcqdONPpU1kugZLsL2E6zHUQ1uQ8DVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724874007; c=relaxed/simple;
	bh=/Fagkc88yvf+mzgoZOdN4OODilS0pVIwZfFHIJeQGlg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DFgTDWHYrYoTBpZuJGmcxzLpq1c2+IwmBEXppneUxHmRc0JoDGQjXiZuAk5OHS8SLWidAKiyngWgsHpLw7UtXQg3MKvLJjmCvWa5ZwwouMDYYqxYfig6dHaDe5f+CCmYxWxY/3rpU1wv+0T5vj5sRlUUz9M4T0+TOw66/2GfJK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ru+N3SM4; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1166ecfacdso13529105276.1
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 12:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724874004; x=1725478804; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hnGTAwAwAMONJUUTElVDKjIz/0uRa2UwvFi6w8r2FGU=;
        b=ru+N3SM4rCpzhAsRu+1zAUBYDUXaejQmozEP7xSB3oyQRQB85FckMft6TZK99nkaFT
         GlN1Re9uyi+JgUHoLPuatQ1DjZi3dt/026psNbIhwmm5db1L4rcIncwPYNhmW5dzd9Xh
         yuxQuuFPxSMjK5oU8Oavlmc9gcqa1aQMRaBOmXOds6RdF/CbiLyivJl2Fyvw9Pw+p4tz
         3XD6E4LUUChlK9UkDxSRIZ2+2pkooU9/K1Z2zI2gUcZ/62d7MGwqQLfmFLjew+3dos68
         TUdnngHRUuQtoatq6LtT8XZyGB6uHd6hgE1KNj1FAzrlE2V0gogNTsD1fF4CyKA026kC
         cuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724874004; x=1725478804;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hnGTAwAwAMONJUUTElVDKjIz/0uRa2UwvFi6w8r2FGU=;
        b=PbxkRkaPuffHzkBEgedWGnsbzYF56wt/t9fV8fHGDrAinQYSYujKvdTw4XHTwaRCx2
         umf/mi1OO22LYCVfuvMmPeLOoZEhKF7c5490ht+LL+nlOf7PMDuI98kkr4iuTXy7gz99
         9HNVqJGyvzT3Ng0VjaphWfMsKPYYFu/7ES0F3H8GyYoZnS0qUDS1X3A/ugOav6SCFaEq
         R2UR7KyRC9sAg9G7yp8Brj2WVQxodPeK51cJeAhq0f5gdKjFRqrFtK9gnssoAFw/Y5cA
         0/Niu3kyr3g1IWDLk4stgFLvqAme4A8CeaXonThdRvKc3cigQ3ynj0JC3jUMPmKr1BTb
         WmuA==
X-Forwarded-Encrypted: i=1; AJvYcCU6qA17A2rxW+5OR8IAZS4k8Dvn2zytdUqffQAFBKxezBvgTFOvICTf2LPwwffsF4hhERVWt0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd+3QCRSkLKoCYkchDTLLb4QEOEHfryV9KU+Ei9+JNE9ANGj87
	f2+eRSGk3uNQCvJk0slijR9vEpMHj7aTLSjgftMbF4i5BJ1oJPfhGHsMikwEKiaNhtbiLLWetCl
	gbqZ4S6z8rQ==
X-Google-Smtp-Source: AGHT+IH578InXDkOfXJShd40g0W1FsKPRiEIauwIRDzRQvZho43R5IPKlozbSILEJZ1HxYJ+FuVgOQrzJieH/Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:870d:0:b0:e11:7039:ff92 with SMTP id
 3f1490d57ef6-e1a5af17fa7mr542276.11.1724874004345; Wed, 28 Aug 2024 12:40:04
 -0700 (PDT)
Date: Wed, 28 Aug 2024 19:39:48 +0000
In-Reply-To: <20240828193948.2692476-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240828193948.2692476-1-edumazet@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240828193948.2692476-4-edumazet@google.com>
Subject: [PATCH net-next 3/3] icmp: icmp_msgs_per_sec and icmp_msgs_burst
 sysctls become per netns
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Willy Tarreau <w@1wt.eu>, Keyu Man <keyu.man@email.ucr.edu>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Previous patch made ICMP rate limits per netns, it makes sense
to allow each netns to change the associated sysctl.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/ip.h           |  3 ---
 include/net/netns/ipv4.h   |  2 ++
 net/ipv4/icmp.c            |  9 ++++-----
 net/ipv4/sysctl_net_ipv4.c | 32 ++++++++++++++++----------------
 4 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index d3bca4e83979f681c4931e9ff62db5941a059c11..1ee472fa8b373e85907146f9a3f29ecc98e2e55b 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -797,9 +797,6 @@ static inline void ip_cmsg_recv(struct msghdr *msg, struct sk_buff *skb)
 bool icmp_global_allow(struct net *net);
 void icmp_global_consume(struct net *net);
 
-extern int sysctl_icmp_msgs_per_sec;
-extern int sysctl_icmp_msgs_burst;
-
 #ifdef CONFIG_PROC_FS
 int ip_misc_proc_init(void);
 #endif
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 54fe7c079fffb285b7a8a069f3d57f9440a6655a..276f622f3516871c438be27bafe61c039445b335 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -122,6 +122,8 @@ struct netns_ipv4 {
 	u8 sysctl_icmp_errors_use_inbound_ifaddr;
 	int sysctl_icmp_ratelimit;
 	int sysctl_icmp_ratemask;
+	int sysctl_icmp_msgs_per_sec;
+	int sysctl_icmp_msgs_burst;
 	atomic_t icmp_global_credit;
 	u32 icmp_global_stamp;
 	u32 ip_rt_min_pmtu;
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 8ad3139a00fb8c5cb8f28f92d125ef83d9e840c3..1f5d6f01ee9ef7a1b32a6619837176de16bd4389 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -220,9 +220,6 @@ static inline void icmp_xmit_unlock(struct sock *sk)
 	spin_unlock(&sk->sk_lock.slock);
 }
 
-int sysctl_icmp_msgs_per_sec __read_mostly = 1000;
-int sysctl_icmp_msgs_burst __read_mostly = 50;
-
 /**
  * icmp_global_allow - Are we allowed to send one more ICMP message ?
  *
@@ -248,14 +245,14 @@ bool icmp_global_allow(struct net *net)
 	if (delta < HZ / 50)
 		return false;
 
-	incr = READ_ONCE(sysctl_icmp_msgs_per_sec) * delta / HZ;
+	incr = READ_ONCE(net->ipv4.sysctl_icmp_msgs_per_sec) * delta / HZ;
 	if (!incr)
 		return false;
 
 	if (cmpxchg(&net->ipv4.icmp_global_stamp, oldstamp, now) == oldstamp) {
 		old = atomic_read(&net->ipv4.icmp_global_credit);
 		do {
-			new = min(old + incr, READ_ONCE(sysctl_icmp_msgs_burst));
+			new = min(old + incr, READ_ONCE(net->ipv4.sysctl_icmp_msgs_burst));
 		} while (!atomic_try_cmpxchg(&net->ipv4.icmp_global_credit, &old, new));
 	}
 	return true;
@@ -1491,6 +1488,8 @@ static int __net_init icmp_sk_init(struct net *net)
 	net->ipv4.sysctl_icmp_ratelimit = 1 * HZ;
 	net->ipv4.sysctl_icmp_ratemask = 0x1818;
 	net->ipv4.sysctl_icmp_errors_use_inbound_ifaddr = 0;
+	net->ipv4.sysctl_icmp_msgs_per_sec = 1000;
+	net->ipv4.sysctl_icmp_msgs_burst = 50;
 
 	return 0;
 }
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 4af0c234d8d763f430608d60f38eff8a6d9935b4..a79b2a52ce01e6c1a1257ba31c17ac2f51ba19ec 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -600,22 +600,6 @@ static struct ctl_table ipv4_table[] = {
 		.mode		= 0444,
 		.proc_handler   = proc_tcp_available_ulp,
 	},
-	{
-		.procname	= "icmp_msgs_per_sec",
-		.data		= &sysctl_icmp_msgs_per_sec,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-	},
-	{
-		.procname	= "icmp_msgs_burst",
-		.data		= &sysctl_icmp_msgs_burst,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-	},
 	{
 		.procname	= "udp_mem",
 		.data		= &sysctl_udp_mem,
@@ -701,6 +685,22 @@ static struct ctl_table ipv4_net_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec
 	},
+	{
+		.procname	= "icmp_msgs_per_sec",
+		.data		= &init_net.ipv4.sysctl_icmp_msgs_per_sec,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+	},
+	{
+		.procname	= "icmp_msgs_burst",
+		.data		= &init_net.ipv4.sysctl_icmp_msgs_burst,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+	},
 	{
 		.procname	= "ping_group_range",
 		.data		= &init_net.ipv4.ping_group_range.range,
-- 
2.46.0.295.g3b9ea8a38a-goog


