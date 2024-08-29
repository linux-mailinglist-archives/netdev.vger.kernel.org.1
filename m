Return-Path: <netdev+bounces-123336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E019648F2
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 16:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89FEF1C22E5A
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 14:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594ED1B14FF;
	Thu, 29 Aug 2024 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p7avtr9t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43E71B1418
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 14:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942813; cv=none; b=q+lYmd3466usWyweoM4VmM62Nb46R0DXjpUkycxw5pWpu/E5sBhBbUVtnuj3VWv8kMbQ5eEYuafbFTLFkhiNN7V8X6lwlnXKORYhuCVDhCzeqoG2bCzGg/Me7ImCgAbQebwz5DHlJKppN1eFOCiItHP+eZLjcUeOyZTRCKEqBB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942813; c=relaxed/simple;
	bh=4OE2aGBgG2nZ7aIpfhhwLjWANwH7jOqUo5bpUyTU3rQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FC9d0b0ngi2wmSaIXOfhn5MAOQRDOste83PP5N9GBOwBh+Cz+RkWVDUFhzpGZsjjRkphWnM7IVR6wtPG+2I+sMIFvK8+hd3Z9PPDRdSMhZjNRe/g8CB2QZMyj3GANK9VpJ72q1Do84bvOXTchxxU0dtRQaMEoSd+/KUTrTvXnXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p7avtr9t; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1166ecfacdso1383223276.1
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 07:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724942811; x=1725547611; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ySiNPSOW6cMUAhrPmgMi6C/tYAcCH+NJfoKW7cgN0cA=;
        b=p7avtr9tWv4zsCOw7ohVVYLVDfCwMMbGreieGlc4T3/C5MD7YOcWszb647mzutylP0
         DGRLnSPwk3m4NUOHwPNsagW3bCBpfjLwwpwzHeRwJAabMKPorBxstLiNYqC1Aas6rtDe
         nLlxXfYhEx0aBQp5Sjte36IUcKPbboageVXBj9XrT+rfohlHunQj3MSel1MhgArBeeCa
         u2nGXOXI/yduq1yHDfgPzRLcuURmlKirmyz/Agj+IQnmH3Gg56l/Lmdo24qjbJOvMgPw
         0K35AHQD0QPbzVX+7sQGtlmO4vsCcD1O5zYEpJyn8bl1aU99LkwoVhcxumczSncUE0t7
         81QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724942811; x=1725547611;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ySiNPSOW6cMUAhrPmgMi6C/tYAcCH+NJfoKW7cgN0cA=;
        b=md3gLYP7rAQOMWpwXaVWN1P5OHpk2I5baPbEOlkgpaPsx9O+cNnkU6OVrQXjTXt2X2
         edW4s03vYz9AR1swbYBqPZytPtnAAElx7oMPjxGKNhrBpM9zzoI3vG26Xhl6NrR8IVtP
         zO/luVGTHjruzcp0N1o2bB0sb3wKe0CfCKCJC+qIQ5AeiLavOcXkM5t2/Uw1uQYO37ch
         ZEXKjEPZh/Im59RMaRhbloS66w/S4z94nkKf/3Owc3JL4txLNfJoYBPPwo9wvNR0ZZwJ
         xeuZacLLbR2fXkkSi0ogEeRfhYF01lkytU/HouP0OKU6gqPGHxKEKR41hSYaCEOEnz1+
         ZkOA==
X-Forwarded-Encrypted: i=1; AJvYcCVeScUZBVdtMdMhvE5/lg58flRqOhSfDoAdE3cKMONksInAJZFqMbiWbrN4nz/qLKA6oBvc+CM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzezfOEI9mHrUiFi+WgzMvf8wjAgXfJ3M/4CBRELb7sOLgCGEU2
	mcGXri38wO1MNcPrjblirlb9uUTXhGPPcwD5RdG6QXgB9cFSbVSRtvbXknIxOhbdx/qupaQz4v1
	fx4Csuwj5Aw==
X-Google-Smtp-Source: AGHT+IEZtSb9paxuNqGsZ4wCM7Ec2erg4Qnd3tx7UBrbQC6MRGSNED1oLMVZN/Yk1hYHWOzJTR4m0lXPe7W0gQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:b205:0:b0:e0b:ab63:b9c7 with SMTP id
 3f1490d57ef6-e1a5ae0a289mr5002276.7.1724942810396; Thu, 29 Aug 2024 07:46:50
 -0700 (PDT)
Date: Thu, 29 Aug 2024 14:46:41 +0000
In-Reply-To: <20240829144641.3880376-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240829144641.3880376-1-edumazet@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240829144641.3880376-4-edumazet@google.com>
Subject: [PATCH v2 net-next 3/3] icmp: icmp_msgs_per_sec and icmp_msgs_burst
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
Reviewed-by: David Ahern <dsahern@kernel.org>
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
index 2e1d81dbdbb6fe93ea53398bbe3b3627b35852b0..1ed88883e1f2579c875f4e0769789dc2e0c6e15a 100644
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
  * @net: network namespace
@@ -249,14 +246,14 @@ bool icmp_global_allow(struct net *net)
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
@@ -1492,6 +1489,8 @@ static int __net_init icmp_sk_init(struct net *net)
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


