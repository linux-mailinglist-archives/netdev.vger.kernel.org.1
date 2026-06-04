Return-Path: <netdev+bounces-295454-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H0rcDuEAImr1RQEAu9opvQ
	(envelope-from <netdev+bounces-295454-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:49:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFE6643DD1
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:49:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=KH8xVIml;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295454-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295454-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6162303265A
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 22:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E792F7F14;
	Thu,  4 Jun 2026 22:47:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7735927587D
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 22:47:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780613240; cv=none; b=qDjiPsMMBMOXibINyzLISsaQ7fp1ntXJ5sIIUa36nIuNDpWcT2yVVjjEAJOQXsn6NNTDEY8wZSSkIIHcxAQiKrGAqUDvQUDd0ybG094nwMrGb8jTTc6sc8xsDYAXDJaEpkn7XjPp+gVhi1F8gQ+xZx8H80xQ5/9h2l01RJx5AkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780613240; c=relaxed/simple;
	bh=I7OWJrabDZZlZpDJkQZYKb99RfBvSJ9askGdvPqQKBU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KPQhRELdWXIBJgjsvNmBGkhL/AHYX7/zSsDsWL0mbLG4GLL0WYlHZm1+EXfJF9eZshH/5+/+5eYy3lzzlkDXNOQPdAFV2bCs5dODNPJuKeg/qZVSzYK1lPl8dLm7rowdbjizJup9bTGA90qp19BHygIkkaK406PycieV0nfFcIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KH8xVIml; arc=none smtp.client-ip=209.85.215.201
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c858e0cbca3so634753a12.2
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 15:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780613239; x=1781218039; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Igb1+Zts83CAiGIfN9ZRnGyRvz1fn4pw900WfwGRZs=;
        b=KH8xVIml54JazHe9LNVTQCnLPuHAJrc6cWzFBINQm9Ocmu17CFdoMgG0dQSRMrPhgp
         lMzTWm056J7h4nreQ6IYYVdClCridNUB0Mfj5byI6CTU3HxqaGOQEcN1JTgADXxQqsAH
         KFwSceWPBGjMM8PA1c5os2T40uO1xGsYHeH+bBqBTOLKtNgPkQq/WqpACQbj5U5RPTdD
         baZocPYx4OvS/aZxGLMmwVfNZVska+g6bdP6kWXAQaoqGqTg4f3Ke8mrkP74V6mVaOzE
         W+g4ZYJkl/HM+47XNXhNKct0P7e8RDWKFCqZfEQXX8i3vdOpiPP9DstvHnLcIbvZ+EXY
         T63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780613239; x=1781218039;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Igb1+Zts83CAiGIfN9ZRnGyRvz1fn4pw900WfwGRZs=;
        b=GPalaFmadIdniRdr9BzJ5cGXxS6pz0egANWtfAbsgiFxEKyw8aeX1Ek2gGb4HmGSAZ
         lOECLoNQikdBcjpYLRg2kLCm4L95OQpGOwaZu6WdMJieMpq9IvMfHqP21IAO6u0N7GL7
         puBCSyZIszxTnZcjcXwdeqcwBJFBSSEBtzjXHWA2U1+dhNBk1JB/6/Dse8u+e+52yZnJ
         PKzYPr1teg8ifVAH5Rh6wq0pTEDjJpifBn1vQFuf3Oouemo3HkwdOA2Xlsu7g3Pk8PO7
         I8MOvOwkx92KD8KUafP97pZZNybfBrfgzPOXVr4zFUWyJJvwVyPTQwIyGXu/+weCjQlq
         HxqA==
X-Forwarded-Encrypted: i=1; AFNElJ/R1dLOYkyjgYQgb3NYaB8rDojZr0RWf4UxiLoqLF3I/Jt+S8d/r3AIOROJy6+TxX4sM1ppqt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGcyHkhJ3yqFlFt2DkMh3FVHUWQsxJTivuKCXoTTS18RC/H+26
	dstWb2ZyySfrQabIatX2V7IlZ0Hr/T/78fDkucop7ZOUXzHWIOn7eo7JdTxxhVL3T9aPNGpPbiD
	h8ruZqQ==
X-Received: from pfva8.prod.google.com ([2002:a05:6a00:c88:b0:842:5989:fb63])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:c91:b0:842:4327:6cfb
 with SMTP id d2e1a72fcca58-842b0feb656mr580838b3a.46.1780613238402; Thu, 04
 Jun 2026 15:47:18 -0700 (PDT)
Date: Thu,  4 Jun 2026 22:46:21 +0000
In-Reply-To: <20260604224712.3209821-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604224712.3209821-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604224712.3209821-4-kuniyu@google.com>
Subject: [PATCH v3 net-next 03/15] ip6mr: Use MAXMIFS in mr6_msgsize().
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295454-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9AFE6643DD1

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
index e3dd5851b879..ed56c4c8fda0 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -2537,7 +2537,7 @@ static int _ip6mr_fill_mroute(struct mr_table *mrt, struct sk_buff *skb,
 				 cmd, flags);
 }
 
-static int mr6_msgsize(bool unresolved, int maxvif)
+static int mr6_msgsize(bool unresolved)
 {
 	size_t len =
 		NLMSG_ALIGN(sizeof(struct rtmsg))
@@ -2550,7 +2550,7 @@ static int mr6_msgsize(bool unresolved, int maxvif)
 		len = len
 		      + nla_total_size(4)	/* RTA_IIF */
 		      + nla_total_size(0)	/* RTA_MULTIPATH */
-		      + maxvif * NLA_ALIGN(sizeof(struct rtnexthop))
+		      + MAXMIFS * NLA_ALIGN(sizeof(struct rtnexthop))
 						/* RTA_MFC_STATS */
 		      + nla_total_size_64bit(sizeof(struct rta_mfc_stats))
 		;
@@ -2565,8 +2565,7 @@ static void mr6_netlink_event(struct mr_table *mrt, struct mfc6_cache *mfc,
 	struct sk_buff *skb;
 	int err = -ENOBUFS;
 
-	skb = nlmsg_new(mr6_msgsize(mfc->_c.mfc_parent >= MAXMIFS, mrt->maxvif),
-			GFP_ATOMIC);
+	skb = nlmsg_new(mr6_msgsize(mfc->_c.mfc_parent >= MAXMIFS), GFP_ATOMIC);
 	if (!skb)
 		goto errout;
 
@@ -2722,7 +2721,7 @@ static int ip6mr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		return -ENOENT;
 	}
 
-	skb = nlmsg_new(mr6_msgsize(false, mrt->maxvif), GFP_KERNEL);
+	skb = nlmsg_new(mr6_msgsize(false), GFP_KERNEL);
 	if (!skb)
 		return -ENOBUFS;
 
-- 
2.54.0.1032.g2f8565e1d1-goog


