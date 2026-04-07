Return-Path: <netdev+bounces-276169-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJ5oGip21WlC6gcAu9opvQ
	(envelope-from <netdev+bounces-276169-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:24:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 040DA3B501F
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0297830D8E6B
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 21:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2691D37C91B;
	Tue,  7 Apr 2026 21:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VlxAzrk2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA4337C901
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 21:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775596816; cv=none; b=aqXisXYOn9+vgeBFDfwJPeSHdHO+MuwGCib4rXakz2HCV/yb0x9S65P38ky8+dax5l21iEHzefvmMsqm8AA0ilqja/Nih6z8izxPTwivufGSIxcXuJjKfjRrHPBBzWM5D8MP4qo6T2H69mpbmi4skR4FwoRRDzzm+HpoeSmcHOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775596816; c=relaxed/simple;
	bh=zil19A9obZ4mmb6G4IBOvLXddCnfZL7yO4m1qifNmT8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TcsF6mPqJT+WQUh0V1WBBHlUp8pgf2xkppqu5/a9C75aK/lQzpb3Thm6rJO5BIX5RH+WJBQCdGNjZ5zCaeYj0UMJ7QkTpdczlVPKIS3dGUYxoxy7SMJI+5+6nnnldR46EGCUEu9+BirkOpusr2cUu7WLykvwlTZi36xm5aNuWiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VlxAzrk2; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c76b6d4337bso2896211a12.2
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 14:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775596814; x=1776201614; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QsbP7w3//L7hj1BdLdRNNyPxAUT8H0mQ2iEY4weIP8c=;
        b=VlxAzrk2TC4Z57LJXhAxbO7YC2f+j42COwh9c4Q2XUfwbW+GK1msN6yfGBg9ylgMj5
         etaMtKwnF/AaKhtrqsbSbR+UmTNCa12V8dt1xwcpvFdbKfV7KUahp9V2kAqctlX/9I5L
         Z/TAtbS4+/tM3OxB7f9ZyRHNurzvTcMguEWjyNGNuM2HHQV3QvtUKu3UqBZ26OCYkzyI
         wg1Thcv9YQfCMrXo4bu2bJE3fvQAvl/GK/ovmpdKzH7PIh77EoHNRoKCxUqA9ijZYfZi
         qJ40ockldfrTLyaJ8LEyabNBGFHbQIUvEqNMPkMKGZpSxoZTb0e+yKif+iKlnRtL+Zky
         +rMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775596814; x=1776201614;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QsbP7w3//L7hj1BdLdRNNyPxAUT8H0mQ2iEY4weIP8c=;
        b=QuXlU2SYBhVg8jafzU9fYipc5pxqyprcxEO5lXKWSYPAzSyuyoFCUAOuEq69qmRKVr
         zxaTEVZ8QLK6Mf59Kesi+XtKcg0fGVToIUljfKjYJaoTFQUEwWKgnViZ01wb7O8IBrq1
         Q6AS8i8KPqseb0fMdP0b3+9GOLGGoxK121e0YfoEHlNXFrJtJ7lMsaf0teIpiW51ny6P
         O4P0du1xYi9RUpylnEe1oylChl1S6QDlUtMNJC8o4XfZp/MJwLHJTmw0YqCFEEtjBXBh
         g97setDZWGI8LkCI2noTMyBcvQ+f5Ddq4N3z1Xf3ZjYeEeFvAbMWYGIlxV4QJ8Bl2tkS
         TC+w==
X-Forwarded-Encrypted: i=1; AJvYcCUc89cyzl2renAL0PrZn17pkIW66ZQwQNBxDPQzDmu44F6MEdrEiVw2aPqh1YpMTYIdNN4xWPs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+lZWb10BMdUjJ8QkPK/OtjQvz7dLcxWgxHVaUWJXWwrvhoodF
	sjI9KCGrjMgyVhw6Y0nl0G/kw3HnbviHuCFs8WxBYZDWhlkZVnDuDVB7PgB7HwCLW3+ncM3tpPs
	8FZLnWA==
X-Received: from pgam11.prod.google.com ([2002:a05:6a02:2b4b:b0:c76:b975:8ad6])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a824:b0:39f:43c3:b895
 with SMTP id adf61e73a8af0-39f43c3c171mr11753976637.57.1775596813450; Tue, 07
 Apr 2026 14:20:13 -0700 (PDT)
Date: Tue,  7 Apr 2026 21:19:39 +0000
In-Reply-To: <20260407212001.2368593-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260407212001.2368593-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260407212001.2368593-7-kuniyu@google.com>
Subject: [PATCH v3 net-next 06/15] ip6mr: Convert ip6mr_rtm_getroute() to RCU.
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276169-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 040DA3B501F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ip6mr_rtm_getroute() calls __ip6mr_get_table(), ip6mr_cache_find(),
and ip6mr_fill_mroute().

Once created, struct mr_table is not freed until netns dismantle,
so it's safe under RCU.

ip6mr_cache_find() iterates mrt->mfc_hash with rhl_for_each_entry_rcu().
struct mr_mfc is freed with call_rcu(), so this is also safe under
RCU.

ip6mr_fill_mroute() calls mr_fill_mroute(), which properly uses
RCU helpers.

Let's call them under RCU and register ip6mr_rtm_getroute() with
RTNL_FLAG_DOIT_UNLOCKED.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6mr.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index db7376cbcc01..389471e740bc 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1390,7 +1390,8 @@ static struct pernet_operations ip6mr_net_ops = {
 static const struct rtnl_msg_handler ip6mr_rtnl_msg_handlers[] __initconst_or_module = {
 	{.owner = THIS_MODULE, .protocol = RTNL_FAMILY_IP6MR,
 	 .msgtype = RTM_GETROUTE,
-	 .doit = ip6mr_rtm_getroute, .dumpit = ip6mr_rtm_dumproute},
+	 .doit = ip6mr_rtm_getroute, .dumpit = ip6mr_rtm_dumproute,
+	 .flags = RTNL_FLAG_DOIT_UNLOCKED},
 };
 
 int __init ip6_mr_init(void)
@@ -2715,6 +2716,8 @@ static int ip6mr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		grp = nla_get_in6_addr(tb[RTA_DST]);
 	tableid = nla_get_u32_default(tb[RTA_TABLE], 0);
 
+	rcu_read_lock();
+
 	mrt = __ip6mr_get_table(net, tableid ?: RT_TABLE_DEFAULT);
 	if (!mrt) {
 		NL_SET_ERR_MSG_MOD(extack, "MR table does not exist");
@@ -2722,10 +2725,7 @@ static int ip6mr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		goto err;
 	}
 
-	/* entries are added/deleted only under RTNL */
-	rcu_read_lock();
 	cache = ip6mr_cache_find(mrt, &src, &grp);
-	rcu_read_unlock();
 	if (!cache) {
 		NL_SET_ERR_MSG_MOD(extack, "MR cache entry not found");
 		err = -ENOENT;
@@ -2737,9 +2737,12 @@ static int ip6mr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		goto err;
 
+	rcu_read_unlock();
+
 	return rtnl_unicast(skb, net, NETLINK_CB(in_skb).portid);
 
 err:
+	rcu_read_unlock();
 	kfree_skb(skb);
 	return err;
 }
-- 
2.53.0.1213.gd9a14994de-goog


