Return-Path: <netdev+bounces-277579-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BJPMg9p2Wn5pQgAu9opvQ
	(envelope-from <netdev+bounces-277579-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:18:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C77E23DCD06
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1883430200F5
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5E43ACA52;
	Fri, 10 Apr 2026 21:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e5tCzm6y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344023AEF5C
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 21:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775855859; cv=none; b=mM2LM0pr99cK0lficxzfqbWRkr8l39UWeeMib9N1JjCt4e7zN1EKmA3bRQ6T4IjVnpgUyIXclpXBsgF/wR3lheP2O3C1GlRTaUpGavO2bWNN2BeAxozVyLPft6uqzjHeD4d5lmZWDTYq1B1DtiqnPydM8tF1qJ9vvdr6CgHAuzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775855859; c=relaxed/simple;
	bh=PO0Y/SuKj9iyz7ZF0sVKroB7Oo6a53PHenZ0smsOvN8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mfuxKPfuOjDa1c5sxTEf1FT+e2dvsFOjNhg+GB3hCSiF2og066AzuNjRAA8b81EKiweFOVF38XoQIx82z86RIH8rmw59K6O9RFDTNH7em94sJgroTys9RxQXCj5xHDKhf746YEqL+OZjMAcBaFs3sxy5rU+7qndhXAkclW0AHEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e5tCzm6y; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b2e06219cbso3084605ad.3
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 14:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775855857; x=1776460657; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OHERG14ojwzbzNR6OXZOZ+v7kYcok49yhfDoIjemt04=;
        b=e5tCzm6yO3Gg3VlfgEfj99dT06xoZOXb235hrhFO6zVkmcLV673QIZqdI16wfBI8eN
         pGGNI4SlZppBev2qN3ms3ym5Zqzm8Vl4th5em43b6phsgNJJbVhzJDI0DqLfufIZCSKg
         0XQPOtmUFEkiN+ZJNDYdZQb2fzxMx0Vuv1WipCt9ip2FxI0PwfSRdto1GidWiTqPtOWj
         oUQWjrDaYW1xKRb4PLcwA4MKAkEnaQ2kBIzVdn8uHxGy6+ESpspvwPmcQqDoSsAkd7Kv
         lnbuIdWmRc/wbCIy8UE0owERrD5bnBH7fH4CdK+o4VoqTbw5Ul72T7CQMS6VGVtw0Cjj
         4imQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775855857; x=1776460657;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OHERG14ojwzbzNR6OXZOZ+v7kYcok49yhfDoIjemt04=;
        b=eALdUuzfkTha4BPIectFtUxmO4OAhhWDQixdC4zEXSRLq4HSBGEpPbMjNiSDV0/1Cd
         MNBn9M3NmkTzj93b/WbEYt1FBudiaXUDkya/4157bwXRn7dRPzftiP7vQhHy7RCGnuML
         Ep/S8pEujCsS19zieRIzq/o7QewoQkByG9ZAizF76J+gXhfbnICFMuB5Y7GYTq1tBxnv
         TIxIkGQXHg76qEGN+7EdaIvc6qQxKpNZRgK0fCAGoee791g2SVDU/i4UUnJCiMVQxwZA
         K2DruJlO4RbEyuYActp7+J/lxHY85+PPdcn3JBFpu30FmT8KR6ChQS0uB8qUWDTPIpeu
         Ei0w==
X-Forwarded-Encrypted: i=1; AJvYcCVK8SwuNqVGfst4/H7KQGXZ049xZ9/aCPMw3qnnqNwnJpePylKciFNx7mX5UnSMDDW8QMScmgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPVqqIVJbi2kw0S9WrXZ+kkYEi+HZ87XkPgi18oJyre211GUYb
	dwCu5lMugn/aKoBb/2B4/dYyNVaz1dNMjagNTQs9mkaa6S5oz+otkOamMtuOKjKcAz9udoYT7ru
	sB0uf1Q==
X-Received: from plxb4.prod.google.com ([2002:a17:902:bd44:b0:2ae:cbbb:85fd])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:a506:b0:2b0:ba14:fc70
 with SMTP id d9443c01a7336-2b2d5a8d6efmr33086975ad.42.1775855857264; Fri, 10
 Apr 2026 14:17:37 -0700 (PDT)
Date: Fri, 10 Apr 2026 21:16:59 +0000
In-Reply-To: <20260410211726.1668756-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260410211726.1668756-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410211726.1668756-4-kuniyu@google.com>
Subject: [PATCH v2 net-next 03/15] ip6mr: Use MAXMIFS in mr6_msgsize().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277579-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C77E23DCD06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mr6_msgsize() calculates skb size needed for ip6mr_fill_mroute().

The size differs based on mrt->maxvif.

We will drop RTNL for ip6mr_rtm_getroute() and mrt->maxvif may
change under RCU.

To avoid -EMSGSIZE, let's calculate the size with the maximum
value of mrt->maxvif, MAXMIFS.

struct rtnexthop is 8 bytes and MAXMIFS is 32, so the maximum delta
is 256 bytes, which is small enough.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6mr.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index b263d3c69a5a..7ea572db9075 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -2539,7 +2539,7 @@ static int _ip6mr_fill_mroute(struct mr_table *mrt, struct sk_buff *skb,
 				 cmd, flags);
 }
 
-static int mr6_msgsize(bool unresolved, int maxvif)
+static int mr6_msgsize(bool unresolved)
 {
 	size_t len =
 		NLMSG_ALIGN(sizeof(struct rtmsg))
@@ -2552,7 +2552,7 @@ static int mr6_msgsize(bool unresolved, int maxvif)
 		len = len
 		      + nla_total_size(4)	/* RTA_IIF */
 		      + nla_total_size(0)	/* RTA_MULTIPATH */
-		      + maxvif * NLA_ALIGN(sizeof(struct rtnexthop))
+		      + MAXMIFS * NLA_ALIGN(sizeof(struct rtnexthop))
 						/* RTA_MFC_STATS */
 		      + nla_total_size_64bit(sizeof(struct rta_mfc_stats))
 		;
@@ -2567,8 +2567,7 @@ static void mr6_netlink_event(struct mr_table *mrt, struct mfc6_cache *mfc,
 	struct sk_buff *skb;
 	int err = -ENOBUFS;
 
-	skb = nlmsg_new(mr6_msgsize(mfc->_c.mfc_parent >= MAXMIFS, mrt->maxvif),
-			GFP_ATOMIC);
+	skb = nlmsg_new(mr6_msgsize(mfc->_c.mfc_parent >= MAXMIFS), GFP_ATOMIC);
 	if (!skb)
 		goto errout;
 
@@ -2724,7 +2723,7 @@ static int ip6mr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		return -ENOENT;
 	}
 
-	skb = nlmsg_new(mr6_msgsize(false, mrt->maxvif), GFP_KERNEL);
+	skb = nlmsg_new(mr6_msgsize(false), GFP_KERNEL);
 	if (!skb)
 		return -ENOBUFS;
 
-- 
2.53.0.1213.gd9a14994de-goog


