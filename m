Return-Path: <netdev+bounces-282605-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PWqLrnA8mnktwEAu9opvQ
	(envelope-from <netdev+bounces-282605-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:38:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F51649C68A
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70498305E9ED
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 02:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE7B2BE656;
	Thu, 30 Apr 2026 02:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FJBGp7SE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99112C21F7
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 02:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777516594; cv=none; b=kdRGyEkHxungoYlyYYQNCU8osssDTE2K5K+v9C75kKf9s3sEtrNNc4F49DqKDELjWfeZLOG18x931T2E0my2kCtIBsJg9hwu1Sp0r+I/54K5CZeGG4WcBJlyG0pzeqRwyD1foDGUPayvY397G12qK+w4mE9gn9ER4Fl2CVjS180=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777516594; c=relaxed/simple;
	bh=wkTkUGn5w0x298A5D/1ipkya6hboovyUVKNvgO/cYYo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e97HC2I9SbjyPChGq89sq/9J2eFPDutl32i0T4FYNLiDds8L0AntirbaGebHfGeJvBIWfaZ239ppTazIGP4EP6gNpOm797FF+ePW0/bPG+8LdeTVAIXlrjkMkoelQpjFt/seBzWnpvaJCg/KvS74HeYahh+Kiw+gbSN0xkfEZCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FJBGp7SE; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8a275472d89so9341356d6.1
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 19:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777516592; x=1778121392; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FUbU5K6FT0AKJdqvw/ptsAYButAjGg0L1SpY29bEPPY=;
        b=FJBGp7SEGIAtTwCIVSwoEMw6d/FIHP4zxcvuR6zesQmpx8/2N1miJVgA1O+idlWbsp
         nG3UMB+90q8L0jtWWexKYtACJ5MA4Y30ijFSr5Vb/+AVitnjrk37nUmfapxsve403k/8
         MHXZjj2ExO9icCn9ogEtG7Jou7VtjE8bNLq7HPw7fmAQt3/fYnPFC+w8HWFT7Ntw00UK
         VjsEaWlXzolJQywKgqSgPZrsbQozUS/yl85HN1dEJg2jWGTIUgAbUekLK0jw9YH0tRrO
         Z74E4sjTaFFBWSKO2LSS46mjEyg3KGDh2yj0Qx+JtdIH79QNYG5AKufmw2+F5nfD7eDi
         bx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777516592; x=1778121392;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FUbU5K6FT0AKJdqvw/ptsAYButAjGg0L1SpY29bEPPY=;
        b=keOdoncawBmSb3S/C/ma3C0c6R2rxQOMUpBUIEd8vZvct7jcQhoSPmUoFE4fL9K/BU
         CxPTd0vUc8F8Ht9xzNmL+BeCdlAvzvu7BYttIhMZXLYUq8tP2aelSgfvPAeBjSKHkja2
         75vvSh0bh3Kl2fh3JZvRoRy0jusjEdNXlZZyPI3+Mv+utm1YkM9vC8vb/z0J0HYdV1mh
         ERcRZJVCTUf6dRZiN5g3QRcVE1ih39JhICyMdF+IDEl+CgYLF6r7Zx7LftZD2fE9aBzD
         mZ1AGScD8skd5gIwCEelZQ8dKjaEN2LeMygmVz4zHBLjlQxvaJjwgCNISUyRuxPiLVTP
         3OUA==
X-Forwarded-Encrypted: i=1; AFNElJ/USIMSUJC05rIlAaiB03lE5bqpZzZyqVny3Nd9RJmcT8ot6SiOMJDk6MvT6FmFZ7IT/U8EWd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoIc45TXgJbzbr7NTTTuu4OGoL6ek3bCGk+6iKGa2ah6IHJsC0
	ix7jsR2ZRpjLHE/l3VHlBOzl5M5b0hYcKbtks4XaJH3AA0e+JWujqqk7i1rxQ43EB3ZXnZcaQ8X
	0P3qIYSoDTaVYGw==
X-Received: from qvc26.prod.google.com ([2002:a05:6214:811a:b0:89c:d3b9:81a1])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:2dc9:b0:8ac:a5a0:481 with SMTP id 6a1803df08f44-8b3fe6e6914mr18607566d6.4.1777516591630;
 Wed, 29 Apr 2026 19:36:31 -0700 (PDT)
Date: Thu, 30 Apr 2026 02:36:25 +0000
In-Reply-To: <20260430023628.3216283-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260430023628.3216283-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260430023628.3216283-2-edumazet@google.com>
Subject: [PATCH v3 net-next 1/4] net/sched: propagate tc_fill_tclass() error
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 2F51649C68A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282605-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.981];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Change tc_fill_tclass() to return -EMSGSIZE when skb is too small.

Change its caller to propagate this error (instead of -EINVAL)

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_api.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index ed869a5ffc7377b7c19e66ae5fc9788e709488da..32ccd4672083aa19340520155aeba6d8b6ff546c 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1987,15 +1987,16 @@ static int tc_fill_tclass(struct sk_buff *skb, struct Qdisc *q,
 out_nlmsg_trim:
 nla_put_failure:
 	nlmsg_trim(skb, b);
-	return -1;
+	return -EMSGSIZE;
 }
 
 static int tclass_notify(struct net *net, struct sk_buff *oskb,
 			 struct nlmsghdr *n, struct Qdisc *q,
 			 unsigned long cl, int event, struct netlink_ext_ack *extack)
 {
-	struct sk_buff *skb;
 	u32 portid = oskb ? NETLINK_CB(oskb).portid : 0;
+	struct sk_buff *skb;
+	int ret;
 
 	if (!rtnl_notify_needed(net, n->nlmsg_flags, RTNLGRP_TC))
 		return 0;
@@ -2004,9 +2005,10 @@ static int tclass_notify(struct net *net, struct sk_buff *oskb,
 	if (!skb)
 		return -ENOBUFS;
 
-	if (tc_fill_tclass(skb, q, cl, portid, n->nlmsg_seq, 0, event, extack) < 0) {
+	ret = tc_fill_tclass(skb, q, cl, portid, n->nlmsg_seq, 0, event, extack);
+	if (ret < 0) {
 		kfree_skb(skb);
-		return -EINVAL;
+		return ret;
 	}
 
 	return rtnetlink_send(skb, net, portid, RTNLGRP_TC,
@@ -2017,17 +2019,19 @@ static int tclass_get_notify(struct net *net, struct sk_buff *oskb,
 			     struct nlmsghdr *n, struct Qdisc *q,
 			     unsigned long cl, struct netlink_ext_ack *extack)
 {
-	struct sk_buff *skb;
 	u32 portid = oskb ? NETLINK_CB(oskb).portid : 0;
+	struct sk_buff *skb;
+	int ret;
 
 	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
 	if (!skb)
 		return -ENOBUFS;
 
-	if (tc_fill_tclass(skb, q, cl, portid, n->nlmsg_seq, 0, RTM_NEWTCLASS,
-			   extack) < 0) {
+	ret = tc_fill_tclass(skb, q, cl, portid, n->nlmsg_seq, 0,
+			     RTM_NEWTCLASS, extack);
+	if (ret < 0) {
 		kfree_skb(skb);
-		return -EINVAL;
+		return ret;
 	}
 
 	return rtnetlink_send(skb, net, portid, RTNLGRP_TC,
@@ -2041,7 +2045,7 @@ static int tclass_del_notify(struct net *net,
 			     struct netlink_ext_ack *extack)
 {
 	u32 portid = oskb ? NETLINK_CB(oskb).portid : 0;
-	struct sk_buff *skb;
+	struct sk_buff *skb = NULL;
 	int err = 0;
 
 	if (!cops->delete)
@@ -2052,13 +2056,12 @@ static int tclass_del_notify(struct net *net,
 		if (!skb)
 			return -ENOBUFS;
 
-		if (tc_fill_tclass(skb, q, cl, portid, n->nlmsg_seq, 0,
-				   RTM_DELTCLASS, extack) < 0) {
+		err = tc_fill_tclass(skb, q, cl, portid, n->nlmsg_seq, 0,
+				     RTM_DELTCLASS, extack);
+		if (err < 0) {
 			kfree_skb(skb);
-			return -EINVAL;
+			return err;
 		}
-	} else {
-		skb = NULL;
 	}
 
 	err = cops->delete(q, cl, extack);
-- 
2.54.0.545.g6539524ca2-goog


