Return-Path: <netdev+bounces-276168-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DVTCCh11WlC6gcAu9opvQ
	(envelope-from <netdev+bounces-276168-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:20:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE333B4F75
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C15533007899
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 21:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6287837C925;
	Tue,  7 Apr 2026 21:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MIrJF574"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B820937C91B
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 21:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775596814; cv=none; b=GJ1w3Rnnd9hRdK/E4QPgjQn8UPYb4QTGlP72flGek49y4IsaGhVIfd7L/qA6h428B14uvrVKQlFH0MmP803XxAKYS7y3XIDI2XvaUmjhLWTg6dn6F/x2Tm/XXaUDb2wcqZRtE2EfQh2U/cj7K5SQKTDuxgobmQFvq8gpXRP6ag4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775596814; c=relaxed/simple;
	bh=VZiZZJshr5fzIZmaksZSWDX+Aoh8xaqpKUxMRN89EWM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kg0Zy5AedKH5MrqRaLuY5DdTqh3Z/IymSi0cdXjeLKCTOIjGYLvvXaHUv1lcFmdSpDCVp19lxZdUbw9U0XRmd/gE72OO98aZlh3EQb3/KGW9+4t02daf178GFjxuxxFJICDJjaQqEna4aGtE9pFo968RNAUAXKd3/AJvKvv+JB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MIrJF574; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-358df8fbd1cso6941807a91.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 14:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775596812; x=1776201612; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TtH3puGwvcJcUbuWjtp/Fl5mmCT+Qqx2YSN4nMD1XRU=;
        b=MIrJF574YvG/yONEC2xLtIGINqkZteoljXwgGB7iY+OMkzcwIHKrCqDUZntOyJu8st
         Ft5PS/1gjJsbDz4Rs52ZWikpWUZRcgfSKccoZ/cSk3Jf5babxei567PUvYs7MDQfuWEh
         H50LzIc5WqKRMM6i33Oh7B2+G/SB1nLjf2c3HWp3HzXC3zNpFhISeWhFBWw+uzdVtwFi
         b+yveEq5YCo4LkLa7BTIUw/td447U+dA6L+5/lJbrugRAZlvI+d2ZwGjgVKgSe/g6a7b
         X06lC+IzPlK7Q/0wQQMiIODj2VslGBBfSoNZjH2pvFdxSJQDWe8xw0YmiFBzcL0noiDC
         dowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775596812; x=1776201612;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TtH3puGwvcJcUbuWjtp/Fl5mmCT+Qqx2YSN4nMD1XRU=;
        b=rFmyBBR0HfqTeZ2Kq8RKnQ516neYd0ueWtVw7CNaYsxw4bypqjA7Qq1uYzXzzOI/SY
         bKbpxHk01y8CberTni7ZnhbhEPFQS4NNs0bj1wv2s2dVFBcIKVttz/rqRKLudi8ODj0Y
         S7LOxXF07KMIVGqIrJ9Fgvos+vWCO9TzD0i8jDiJL8AzQZH1Pfr7ljjM3IxUKtA2uRMA
         jExvke7UiuuEVtUhvia0qOWgw2o223IAVJ9L1cdp15wsBU+O3dVBJnw0D0wZ1kmr4uSo
         trEpuKTYSKqd9ZGphM4i2KM3zo+2hYXOFs5uB8zct2LQrwwDRHW0/zG3KY4I2rqeDDnu
         N+RA==
X-Forwarded-Encrypted: i=1; AJvYcCXxarVj+hkBbSX+OTvcCcKORKpzUe/H78cfkeLYaAe9EadkIkxey8O+oQyvqOrCed7qx6EtWy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTfG0pUBxkSiR5mP0H1z+FyZac90F3LV03Cfb4B4KoM+SyJvuF
	7uM316gFRPOjSurYtrKJ/oJjH27p1DlN4TSuGkHJVjKRxJW6HCgPkOpzz6jUzNEsQ50Kqn6ZKx/
	HEsWMcw==
X-Received: from pfbii5.prod.google.com ([2002:a05:6a00:8c85:b0:829:9475:6d7])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:430b:b0:39b:e789:7d10
 with SMTP id adf61e73a8af0-39f2f20dfc7mr19083027637.57.1775596811764; Tue, 07
 Apr 2026 14:20:11 -0700 (PDT)
Date: Tue,  7 Apr 2026 21:19:38 +0000
In-Reply-To: <20260407212001.2368593-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260407212001.2368593-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260407212001.2368593-6-kuniyu@google.com>
Subject: [PATCH v3 net-next 05/15] ip6mr: Allocate skb earlier in ip6mr_rtm_getroute().
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276168-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8CE333B4F75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We will convert ip6mr_rtm_getroute() to RCU in the following patch,
where __ip6mr_get_table() will be called under RCU.

nlmsg_new() uses GFP_KERNEL and needs to be called before holding
rcu_read_lock().

As a prep, let's move nlmsg_new() before __ip6mr_get_table().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6mr.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 4d78041276c1..db7376cbcc01 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -2705,6 +2705,10 @@ static int ip6mr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		return err;
 
+	skb = nlmsg_new(mr6_msgsize(false), GFP_KERNEL);
+	if (!skb)
+		return -ENOBUFS;
+
 	if (tb[RTA_SRC])
 		src = nla_get_in6_addr(tb[RTA_SRC]);
 	if (tb[RTA_DST])
@@ -2714,7 +2718,8 @@ static int ip6mr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	mrt = __ip6mr_get_table(net, tableid ?: RT_TABLE_DEFAULT);
 	if (!mrt) {
 		NL_SET_ERR_MSG_MOD(extack, "MR table does not exist");
-		return -ENOENT;
+		err = -ENOENT;
+		goto err;
 	}
 
 	/* entries are added/deleted only under RTNL */
@@ -2723,21 +2728,20 @@ static int ip6mr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	rcu_read_unlock();
 	if (!cache) {
 		NL_SET_ERR_MSG_MOD(extack, "MR cache entry not found");
-		return -ENOENT;
+		err = -ENOENT;
+		goto err;
 	}
 
-	skb = nlmsg_new(mr6_msgsize(false), GFP_KERNEL);
-	if (!skb)
-		return -ENOBUFS;
-
 	err = ip6mr_fill_mroute(mrt, skb, NETLINK_CB(in_skb).portid,
 				nlh->nlmsg_seq, cache, RTM_NEWROUTE, 0);
-	if (err < 0) {
-		kfree_skb(skb);
-		return err;
-	}
+	if (err < 0)
+		goto err;
 
 	return rtnl_unicast(skb, net, NETLINK_CB(in_skb).portid);
+
+err:
+	kfree_skb(skb);
+	return err;
 }
 
 static int ip6mr_rtm_dumproute(struct sk_buff *skb, struct netlink_callback *cb)
-- 
2.53.0.1213.gd9a14994de-goog


