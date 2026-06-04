Return-Path: <netdev+bounces-295466-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TyUdO7QAImrnRQEAu9opvQ
	(envelope-from <netdev+bounces-295466-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:48:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF605643DBE
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:48:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=aokRzs4a;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295466-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295466-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2E0EE30225C7
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 22:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9610130C629;
	Thu,  4 Jun 2026 22:47:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41326378D96
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 22:47:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780613258; cv=none; b=fQb0IuxiY9gGAOKmQoFmm1norW5WN5yt1drUJ/RK4gXHTedGnbP9Ex3k8urQuDOEWRc7Y3ibOfP8g5KDQQH3h/4puYmQEY8ZbBn+E8mz0WdbMSymL5VWE7aR5N1lV8q2MggcD2o3KUyxD7eJsdzZ4uQ47/BwMA7Rhh92/3n0nk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780613258; c=relaxed/simple;
	bh=mZnGMPLL65HcRjsIqQjSSFBhPjFd1j5JcJecBX1WXwM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mQMUqoxCpTQMZyhBS4pErisVLxNk2VmB39X6gu7m8/q/BHpRIlJMdIJgNe9hoCLhgy4g+Dlw+f8ivGcA6f30iiOmB+Gduihq6jOMUQdrNva2UEQhEGGIRObgBANi7xY+QylVZRCSeQ9Q7gYMni++ur0x/tHAVc+ApE5HXVjvJFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aokRzs4a; arc=none smtp.client-ip=209.85.215.201
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c860544c077so412903a12.3
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 15:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780613256; x=1781218056; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BPaehixkqGDAreIZNrKXsadKilH5nfmF81fGCUQ3FS0=;
        b=aokRzs4a7xsCUT5Y0aFB2Ih/lGFz1PpSnJn7dI4NlVDgqKiriTVNN2wEp5ZfQMWj0t
         46qUv3ZjHRd58HCx83HGAjYQ2z3MQxySv0olmbfOSqIlG48Of63Q6eDkviNBx4lp3PNT
         Xdxd0l5lkaOaoM/HQm+PHMrJE+Z980Z3vKoMc+Nqcc9kCCfRUOzqbox+TBRLFjkrBQH1
         fvn6RXkPI2voPLq7nWPAJCv62E/4wslc/fWHm8yu7HqLLnIP3qzPek/utD/0OKLblsKb
         kwd893BrgCCCI/a1YzXkByDM27hc5Uw3zLyubbtsXGfOIXiV0UvPs6NKwO7PU6fUfBZh
         gEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780613256; x=1781218056;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BPaehixkqGDAreIZNrKXsadKilH5nfmF81fGCUQ3FS0=;
        b=bwYofYr5FVBJvOi53Th7kVnePAS8oyF3i2eiA8gRYT40ZdwRvLu/8az4iAFZudzZnr
         gTxuQu5ZjPwt8/L1GWiF4QeM/BpLcocaqf4j0vYCX4PtdkIloVA7qWH+F+xgttyUDYl0
         mXLT5zkvlAQBZfQnCLnXIYv/ZAAQ+vKizQhPR31n4cxHh5L/+YuyvhqHssP4eZWyTlgw
         FATouvQlrYA8EjIsIWs7CF/wQuipNnU8WPDTlCfKWUfcI44udHpd9fGe30msOq7Te2VK
         nTzM/+mNf3KIOqDP8e8iRvVjrWbKDYXiiMwGkUMrZeSNCByxa6loBPdq6LaVSwtAX6Dc
         Na7Q==
X-Forwarded-Encrypted: i=1; AFNElJ/+HCo4NEE2Yw55znhO2T0zHiYw1APxYiVwKnfM2ltS1cEJQriMotSnzfsJCWWdfhWaadzLyZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykmdmyuhi6ErDAMSUYiWTqqc83X1a7haNGpW+0L60l8kkgz4mH
	PWd5wPlmVQRaqvyq1gUWjuYhAyKsQHbnuWiKSaaAj8hsLUn8OEFU+NL4qcJp6Uk/vQL1lD8pG/H
	L1kMDog==
X-Received: from pgbcm4.prod.google.com ([2002:a05:6a02:a04:b0:c79:22b6:a344])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1409:b0:3b2:8685:1473
 with SMTP id adf61e73a8af0-3b4ccd00069mr1059039637.7.1780613256428; Thu, 04
 Jun 2026 15:47:36 -0700 (PDT)
Date: Thu,  4 Jun 2026 22:46:33 +0000
In-Reply-To: <20260604224712.3209821-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604224712.3209821-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604224712.3209821-16-kuniyu@google.com>
Subject: [PATCH v3 net-next 15/15] ip6mr: Define net->ipv6.{ip6mr_notifier_ops,ipmr_seq}
 under CONFIG_IPV6_MROUTE.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295466-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EF605643DBE

net->ipv6.ip6mr_notifier_ops and net->ipv6.ipmr_seq are used
only in net/ipv6/ip6mr.c.

Let's move these definitions under CONFIG_IPV6_MROUTE.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/netns/ipv6.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
index 668f10498c5c..ffda15318be5 100644
--- a/include/net/netns/ipv6.h
+++ b/include/net/netns/ipv6.h
@@ -112,14 +112,14 @@ struct netns_ipv6 {
 	struct list_head	mr6_tables;
 	struct fib_rules_ops	*mr6_rules_ops;
 #endif
+	struct fib_notifier_ops	*ip6mr_notifier_ops;
+	atomic_t		ipmr_seq;
 	struct mutex		mfc_mutex;
 #endif
 	atomic_t		dev_addr_genid;
 	atomic_t		fib6_sernum;
 	struct seg6_pernet_data *seg6_data;
 	struct fib_notifier_ops	*notifier_ops;
-	struct fib_notifier_ops	*ip6mr_notifier_ops;
-	atomic_t		ipmr_seq;
 	int			flowlabel_count;
 	struct {
 		struct hlist_head head;
-- 
2.54.0.1032.g2f8565e1d1-goog


