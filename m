Return-Path: <netdev+bounces-298468-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CBNnICioK2ogBgQAu9opvQ
	(envelope-from <netdev+bounces-298468-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 08:33:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1BA676EEA
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 08:33:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=KCuim6PO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298468-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298468-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 750FB3073504
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 06:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36266399017;
	Fri, 12 Jun 2026 06:32:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38243921C8
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 06:32:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781245954; cv=none; b=WgrLKMRr1uZF3rI1mJLnccawREqoEIxiSNsbJJ/D4kWAko5kJ8xELH4X0i+t83SqWH0Pt6fBhcbJaZK3FhbAo9P+VLTcEjt5iGsJ32HCvduWwemb9Z6OgL5IV9ADPw3JcpHjAl8roWzZXwf7PqUYRRW9mSI1mgNGtDIb9uHN8EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781245954; c=relaxed/simple;
	bh=ydEBbJRGqMz+qycC5MnQORG1ZqTRNs+Q9YRmTu1CVfI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c3zzqFNzr8ldCA122/KR55MeySV/3QHkzcS/p79CJE3ZxELpXRXxZSLEKbOwQynBPOiIQG1FjWJSaibnJWqKCiauyT1ZP9ZfkNhjMaY8binWrmbblUDyzQ2LCq1tz1zwt76rEQs5FOZ4OktNDbFuv6XBSqwOsGAFnItEU22c9q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KCuim6PO; arc=none smtp.client-ip=209.85.215.202
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8592a62f32so346179a12.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 23:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781245952; x=1781850752; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8KjfgZgPLmLWCOZQOLdQ5y2mCMyC3qEeRNz218gsPQ=;
        b=KCuim6PO4+Hg48YtUDrd2t+rBTAN4uzJChfPY5XXkdfpxdqujNrIn3PejG1FQzFBSH
         cJO93KTR0WPS1pJ/cdJqXneKr7pO547D/azQRMXBOcWb4wWRaZYHErqG+VIJI3DG1ZUM
         g17p20kDOUfYbBAiWYz3AeG3LGIpY7/sUgOicvl3+8h018WPEqltsm49HWu0hjKy2XXs
         lDve4cJ9HZvzhs+7OK0QTmDD/ZG5ey287CsSIH/FbbRPeyueuzn+Tx9qzhQcZKrOgMd0
         kjlvoysKVLw56MMal6OHF0kZKg7qcfT5k2gt1x5m8IWatFdJGGyMOLs66HZxruLx20AF
         yOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781245952; x=1781850752;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8KjfgZgPLmLWCOZQOLdQ5y2mCMyC3qEeRNz218gsPQ=;
        b=gOD6tTD3UFWlpJZmBXf3M/QpQ8lNcwMLbBqgtZgqSfPaG5jF7X+X5VhtTwTMPfRyqj
         FvptIyizMs+23+r8Ed4Qt6hg5FEfRJIoxhmad6mOT8/zhwloqwrpe+vrAwZNAMmNB1wW
         psZYOwTIsvpW+nyX221Mnm4z5B+NKyq9h7MMBAUrsTqKxKVU88D05T70R2KGp3NpuJx5
         JrTbQr8UdF8VCeYKdln/DmY2LMuiCNL2JKNb1Zchqq0YfmBDDI3um7SadwcCzJc5WoyP
         1hWKC6Yc6X3JPwUQ59Rj5FGgz+ZHHTDBs+NlbibsOEOZUxOpWVf2ne5tAeSvnetywNhH
         oUQA==
X-Forwarded-Encrypted: i=1; AFNElJ/cxWzVGyFN+x69jzl89wCWPK6bfxv62flVCI0VEJNeXN9fChL4EY2RGS5HC55fBRlr3fdTkDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJePLB3TiaX6jcnlJnt9EeHmIe8D3MhuUfsYoMfI1ntl3ihMPt
	Hl+q8C60u7ayHPdpwQckzWjK7/ixrlpzBNX/q85v+DNtL77mIfgvUG/d3c2R/AFgoF8w1eFoZq5
	NGaQSqQ==
X-Received: from pjbaz15.prod.google.com ([2002:a17:90b:28f:b0:36a:9fc9:2f25])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:582e:b0:36b:b1f4:e0ac
 with SMTP id 98e67ed59e1d1-37a034f522cmr1776863a91.14.1781245951969; Thu, 11
 Jun 2026 23:32:31 -0700 (PDT)
Date: Fri, 12 Jun 2026 06:32:05 +0000
In-Reply-To: <20260612063225.455191-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612063225.455191-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612063225.455191-3-kuniyu@google.com>
Subject: [PATCH v1 net-next 2/5] ipv4: fib: Call fib_proc_exit() and
 nl_fib_lookup_exit() at ->pre_exit().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298468-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A1BA676EEA

We will call ip_fib_net_exit() from ->exit_rtnl().

Since the exit callbacks are called in the following order,

  1. ->pre_exit()
  ~~~ synchronize_rcu() ~~~
  2. ->exit_rtnl()   : ip_fib_net_exit()
  3. ->exit()        : fib_proc_exit() / nl_fib_lookup_exit()
  4. ->exit_batch()  : fib4_semantics_exit()

the reverse order of fib_net_init() would get messed up.

Let's move fib_proc_exit() and nl_fib_lookup_exit() to ->pre_exit().

This is fine because procfs/netlink access from userspace cannot
occur at this point and synchronize_rcu() is not needed.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/fib_frontend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index ceeb87b13b93..3b1bd53c7357 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -1656,7 +1656,7 @@ static int __net_init fib_net_init(struct net *net)
 	goto out;
 }
 
-static void __net_exit fib_net_exit(struct net *net)
+static void __net_exit fib_net_pre_exit(struct net *net)
 {
 	fib_proc_exit(net);
 	nl_fib_lookup_exit(net);
@@ -1680,7 +1680,7 @@ static void __net_exit fib_net_exit_batch(struct list_head *net_list)
 
 static struct pernet_operations fib_net_ops = {
 	.init = fib_net_init,
-	.exit = fib_net_exit,
+	.pre_exit = fib_net_pre_exit,
 	.exit_batch = fib_net_exit_batch,
 };
 
-- 
2.54.0.1136.gdb2ca164c4-goog


