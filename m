Return-Path: <netdev+bounces-295456-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eRWPF5AAImrgRQEAu9opvQ
	(envelope-from <netdev+bounces-295456-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:47:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59526643DA7
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:47:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=GCLzkc7J;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295456-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295456-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C1BD130166B3
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 22:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341683009E1;
	Thu,  4 Jun 2026 22:47:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0438F263F4A
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 22:47:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780613243; cv=none; b=H9wFbEOmiI4qzVObqHjL6Gx/k0qpefch136c2lxjPSHth6SJy0jXAkHg/y/+9bAwdnjSujBn6w6umV1DSMeHOQkYZkdk9kmk7qkORq1B3hGXMLLnn07taEdtwGvFtX68rDvwxVIjcA+sYM1DS6yrcgZg1wwKJAhJxsGA8nf6NNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780613243; c=relaxed/simple;
	bh=CrhcH43a/gYR+2K6n4AM8+cnEshLKKK2gvXOmlI2APA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RqvSpKU3yx0m/49X8mGVN229tFKzCka5+9DZpcrmw3P0iG05/E4lUu62D1sz/J1WaIOKMduWqVrHavHFk9LK5N+uZ3pKYM264o1sm9v4Hre0OhwMpevfSqv2kEB9avjhy+d/bk0trMM66Uw9ZlWrVPh/f1xDjrAPnvQmISYp/VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GCLzkc7J; arc=none smtp.client-ip=209.85.210.202
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-842b0dd8107so117939b3a.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 15:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780613241; x=1781218041; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LljQoMsrT+rI6NbScCYdrsaU31SJSEc6KDPiyq+eTCY=;
        b=GCLzkc7J6EXnBkPbxugp/PPFxoRKoyrk4sa+dQGHXLBETALukd/b2otGqr/+zcu9xg
         z7wdhLIvbqjkmFybKifB2r84ffFbezKYi2+wcCZWjwQUaCNLnmpI5+qy6RFCJJRnxxOi
         5C+Gx1jbSZjJtvkVygFCBbeuZeKfkYTta2e/u9f+NuLfPAWrtploG97JUBZ3TCbZAPDT
         mXjHoqjIUDoJ/p4jSyhOeUprk3hlNb1R8Brig5AiBBVy+u3YNYnEDWX0WsYdZ47GYru8
         ih7wyuNJ7Xk8Bd7ypQTVvc4MtCFgVwDCLmI/v6hr48MeMpKnL+XZXC9BHENGmfFuDSlb
         P2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780613241; x=1781218041;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LljQoMsrT+rI6NbScCYdrsaU31SJSEc6KDPiyq+eTCY=;
        b=A1ImI3l8ut51dwabA8cEOb+sTuWp83yW5wjQCVCQYYMZY5dL0pP4P64105hTAblOn/
         fSDJDFW8hKpmt73GiY2y3BX9KlgNu3Cp60U6d+9mjDbxCGllSbL2vwb+zg0o6qL3YrC4
         S7GA/UOLEcDVMDx752UJ+3IfdYkoza8vFbibg0Jq6kwK16IH3Pcy3LpliGbTYgqCeli/
         cWImoSJu7I+4GMIzy+/Bnc80VBJ8JVc7s50rz/8T3O9NIR9R86xZpfjwEGyH6bDxY+Fs
         wVAQ8Lppfv8MHX3ZGNujH/gqY5aQ4tWb/L5KBWt6nxMtCOC39RrpVv5JUv9BbfmNrNNc
         +ayg==
X-Forwarded-Encrypted: i=1; AFNElJ/A7n+N4i9LVfZR1FUggL/twjRjbFjeKydYsPnpzGGfevys4Qk6VyfLe9I+DkFvdeLi7PpPkI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOaCzb+jq1q9gR//xbKtYgt2+fZ/OT8mzqh/frd6WSp4x6kbOU
	vpnCF3EkLToCfnuhYw3tE40IlKc9YicaskXi9ul/4S4/o0uqRoTnxitqVSW9tI+i93YGKcXrNRy
	Rv4BtyA==
X-Received: from pfbiv2.prod.google.com ([2002:a05:6a00:66c2:b0:842:6be9:dfb1])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:bb0f:b0:842:79f5:8325
 with SMTP id d2e1a72fcca58-842b0ffc873mr640503b3a.44.1780613241015; Thu, 04
 Jun 2026 15:47:21 -0700 (PDT)
Date: Thu,  4 Jun 2026 22:46:23 +0000
In-Reply-To: <20260604224712.3209821-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604224712.3209821-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604224712.3209821-6-kuniyu@google.com>
Subject: [PATCH v3 net-next 05/15] ip6mr: Convert ip6mr_rtm_getroute() to RCU.
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
	TAGGED_FROM(0.00)[bounces-295456-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 59526643DA7

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
index 018985593b03..51ba22f59506 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1386,7 +1386,8 @@ static struct pernet_operations ip6mr_net_ops = {
 static const struct rtnl_msg_handler ip6mr_rtnl_msg_handlers[] __initconst_or_module = {
 	{.owner = THIS_MODULE, .protocol = RTNL_FAMILY_IP6MR,
 	 .msgtype = RTM_GETROUTE,
-	 .doit = ip6mr_rtm_getroute, .dumpit = ip6mr_rtm_dumproute},
+	 .doit = ip6mr_rtm_getroute, .dumpit = ip6mr_rtm_dumproute,
+	 .flags = RTNL_FLAG_DOIT_UNLOCKED},
 };
 
 int __init ip6_mr_init(void)
@@ -2710,6 +2711,8 @@ static int ip6mr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		grp = nla_get_in6_addr(tb[RTA_DST]);
 	tableid = nla_get_u32_default(tb[RTA_TABLE], 0);
 
+	rcu_read_lock();
+
 	mrt = __ip6mr_get_table(net, tableid ?: RT_TABLE_DEFAULT);
 	if (!mrt) {
 		NL_SET_ERR_MSG_MOD(extack, "MR table does not exist");
@@ -2717,10 +2720,7 @@ static int ip6mr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		goto err;
 	}
 
-	/* entries are added/deleted only under RTNL */
-	rcu_read_lock();
 	cache = ip6mr_cache_find(mrt, &src, &grp);
-	rcu_read_unlock();
 	if (!cache) {
 		NL_SET_ERR_MSG_MOD(extack, "MR cache entry not found");
 		err = -ENOENT;
@@ -2732,9 +2732,12 @@ static int ip6mr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
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
2.54.0.1032.g2f8565e1d1-goog


