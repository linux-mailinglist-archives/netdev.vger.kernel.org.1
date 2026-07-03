Return-Path: <netdev+bounces-304306-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H2L8JxT+RmpAgQsAu9opvQ
	(envelope-from <netdev+bounces-304306-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 02:11:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1D86FD8E0
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 02:10:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=CQUP60Wh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304306-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304306-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C422F30113A6
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 00:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCCC16F27F;
	Fri,  3 Jul 2026 00:10:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4BE5478D
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 00:10:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783037417; cv=none; b=Er3IE09eBG3QTnIDsBWYdWDqlFwjrtbnV/+r3K+3f2Y/2wmYsjHrAsOA6fZ7BZRas1IsE7gzgrfccUrGzOq3c2W05f68XaQA1krLdelAnzIl+0kOYGEyq8h1AQGSk5+7W5D2lmTus4O0FgCr4Qy4A7zZdL6+ceVWbLsD1DFpq+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783037417; c=relaxed/simple;
	bh=pnJEz2QMgw9cN6VgdMZfdtWI2Yh+zoyCaCsqtMOzc/A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t3Sx7mewe0kgBO7MkIStoZEiOis4o8WU1Nhj+7qUCtP/AsfP1qQ98kgBqDhZaA79z1rG1fF1C2WlXI3iBkIMTv38WTst9OvU+UeTdsmuM1wSLOU8lkhyDwFCSvixAmVW0h3iGYvY4HYs8UIm9Jmkf8tgYdhk6akX0kOe7X5ox5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CQUP60Wh; arc=none smtp.client-ip=209.85.210.201
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-847c3a12ce8so2268531b3a.1
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 17:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783037415; x=1783642215; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iFHPOwnfS0RTxLbSafbHe36q2pu48/NBNi/jujPA5Tg=;
        b=CQUP60WhACgjvsrPBjJxQgMZDhF668tx94NHyYLK6wGN3qdD+4C0KSYlV+yeKfolHh
         89x6LqM1+Z5NZMlQEl5PApehKsj57NMkzYvfw1h3PAyyAyEdSJcnSSZerOrj3MHM64rw
         TChgtjkq3cGTeXqI1baGRvmwOKpvy8TsF1sgI1orNbtvw8MTr+fAMVGZmld8Z44dTZWp
         8ypueC+8+3CRnsFHrpOCyrWP+oA0E1nVB27VefiK1xrT+C4M5ycz8yAiLD6XogaOSFfD
         XdUkbnaZC+2q5p4waTPivmniOV1NafrPjnns8rjFqPJt2edE1b1FaNuZJHd54JSQ+ITo
         KROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783037415; x=1783642215;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iFHPOwnfS0RTxLbSafbHe36q2pu48/NBNi/jujPA5Tg=;
        b=YG9T1dtUODEcrQfZZYzp/Psk43C7ELaZK04cjb8KrbDTJT0JXhn6tg3CKtZ2f2dTpD
         YLyPEypt/x0qaTC0UaXBH/WLeF9QI09tRLSRnA19xIg+LFBIpvbQvq+83rQ3XUJArhr5
         y5AtFdo4y6MnH4PNC2cdeZ5w2+inYV4uC2/7leAm7/evKOmn/Kv9Z7Xvc3SolQB3NuiQ
         tu9K0KOSu9v8SVZuuzYM6mfPDxcctLCst+dAbKMO6MGYJczn0LYmVsSFaJzuvgW8qG+v
         p1eJfkSi6qSYmjtdj4rrTL5vnMS/YXEFzeMZmz3PJKE4dAg7Sc1uIReGn8/K8riopbmB
         6qhQ==
X-Forwarded-Encrypted: i=1; AFNElJ85A80L9QHg9VT4YBQuURr8UaeGNDpkivkoeRL3omjaVUYrHYQ2HMXRwuVaVRRfbalAHuH33L0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhzaSxE3FRLd8UT82kZupRIrrBpmaANCx2VYTvNEQmgsb3oRQx
	T0t5qSn/aa6jywiJm6nqfNs8Or9xDTMCSaA5YX8EFAaNlcjtRD9kRhzsbxRQD363vqFlXAPiB3U
	z3Asrrw==
X-Received: from pgcv24.prod.google.com ([2002:a05:6a02:5318:b0:c9a:c533:8316])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7a96:b0:3b1:a9ce:507e
 with SMTP id adf61e73a8af0-3bfed3e5ee8mr8945827637.32.1783037415246; Thu, 02
 Jul 2026 17:10:15 -0700 (PDT)
Date: Fri,  3 Jul 2026 00:09:16 +0000
In-Reply-To: <20260703001009.1572444-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260703001009.1572444-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260703001009.1572444-6-kuniyu@google.com>
Subject: [PATCH v2 net-next 05/14] net: Hold __rtnl_net_lock() in netdev_wait_allrefs_any().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304306-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B1D86FD8E0

Currently, netdev_run_todo() processes pending devices from multiple
namespaces in a batch.

To expand the per-netns RTNL coverage for NETDEV_UNREGISTER, let's
acquire __rtnl_net_lock() in netdev_wait_allrefs_any().

Note that netdev_run_todo() itself will need to be namespacified
before RTNL is removed.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/dev.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index c477c4f84ed9..48818a194fa5 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11608,8 +11608,13 @@ static struct net_device *netdev_wait_allrefs_any(struct list_head *list)
 			rtnl_lock();
 
 			/* Rebroadcast unregister notification */
-			list_for_each_entry(dev, list, todo_list)
+			list_for_each_entry(dev, list, todo_list) {
+				struct net *net = dev_net(dev);
+
+				__rtnl_net_lock(net);
 				call_netdevice_notifiers(NETDEV_UNREGISTER, dev);
+				__rtnl_net_unlock(net);
+			}
 
 			__rtnl_unlock();
 			rcu_barrier();
-- 
2.55.0.rc0.799.gd6f94ed593-goog


