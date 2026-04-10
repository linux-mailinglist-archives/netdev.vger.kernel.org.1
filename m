Return-Path: <netdev+bounces-277578-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LYpJv1o2Wn5pQgAu9opvQ
	(envelope-from <netdev+bounces-277578-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:17:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F6A3DCCF8
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A8B5A301F3E3
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CC73AEF20;
	Fri, 10 Apr 2026 21:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Unt+tUxd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CB13B0AC2
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 21:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775855857; cv=none; b=LYjyeQCw8d1VDGFQly5+cwIHCdrYdTyVTkR0TimkVzAfQ5E8oMWxlt/APdlPGBjGkVmg8Lstf9PagTGTtBENTj6wi5jPyqmWFZLuv7Q/7dt5FS4RTkh4gmx8YoSfiLaMmCMDZ+bsDTn1CYQIGNNGC4Q4s5NBIOh1N0Q7KmAIS/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775855857; c=relaxed/simple;
	bh=ZHYAFwlvkUBswym/U2ZHJt8NB/sdlKfkuf9N1HxiqGg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I794C8rNfdGeixnSA+I6m16vaJUlS/8b7S+PAK7xNbpDzlNzu1jg9fDm9+rwzAj4PR2pU0nR2BqYjSPzCAbDD7zjTB7kxRJReG8wM7jD6gJpa9nuZ5XdNh7C6qeIf3xet2ECXLB9VIiRyyWD35n66K2vGDW4kQuHbv5td5fKtZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Unt+tUxd; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35da86144daso3132333a91.3
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 14:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775855856; x=1776460656; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pjVa9wGWD9b9YUtAi7A75dC1XWOBvY51pkpH5ygYeZs=;
        b=Unt+tUxdSWoEl0vKjF5DXHJMphurSRN3je+4X4gOX7qfSIvsAjy/ECa5JSty2CZ0/C
         9G+d1FzD9KWO9ULyD81Un6waejZNE5tI8BPceRaJyvbVZG7KJqBNvIHCKMcGtNw+DhrI
         i6tX0vExPrFKsvgP9BTJN0pjjY1DSYiDfAZ68E3yIs4eci65D5+iw20xKcVwV9k53q4G
         OZ+Y124QihhSgS9bOEadAXr8FnRZtyeUawy57FfSVC1xFbLJtjiuefFnug4V6muP3+Jd
         6HOk8vCvP1j9+D42UOnUOTEgLhSevgmhLqsww4uCNdLgl1X9z6PyGwiAKIk+0R3Jj9UH
         eSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775855856; x=1776460656;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pjVa9wGWD9b9YUtAi7A75dC1XWOBvY51pkpH5ygYeZs=;
        b=jyT1ThhtPzkXitjfUBPerJ+HO2/w9bPMIpSkw0NPYttFMBBIjiwaeS07TZSAf1/NOr
         UelZO9rfTKz7VGsCCTYfVQG6gKDjWgwinfE4gNCWnFxFHu+QLl9nqxZ3vK0m9nWb97ae
         KVa+xFYbw6+gTypGTXs3wybxRyO+1cml1VWfZHoKYDvhheS70C3bZ7bxX3RhHv/CcBOh
         WMNr3Kdb+xCjtVwCSYO5gI6ikfF0X0Fv6BkbkvhKSYU6CHr1h0scbQX9DY43lsERVAzt
         6KSCASbN3ajXyMMUpyH/W1LtZOuQUxMnFTKdmaY+yYP6CRlX9qW8UitIiVKOqPpNb14g
         0rFg==
X-Forwarded-Encrypted: i=1; AJvYcCUPz5HDW7dp8Xgu8/zg88T6ZFEM9lJSVRZ6oJ7txbrLEz8ikQRc7yYkbz8gHsuIkQ9/57i8+yY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEUFJ9igEDPhuatH7e9E7+r7VEteGDg8QbPDrvLhn8CBKXU5a+
	Co19ZDvtDjmO5/tCRONOKXzj8IQtnJ0Rbxw31olS8L8IMeZaiUN65Mvn2dRKZupE+l87ZdWrxiE
	ztjfhKA==
X-Received: from plpf16.prod.google.com ([2002:a17:903:3c50:b0:2b2:3f89:e9d2])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5343:b0:35d:9482:2233
 with SMTP id 98e67ed59e1d1-35e42845563mr4923251a91.24.1775855855636; Fri, 10
 Apr 2026 14:17:35 -0700 (PDT)
Date: Fri, 10 Apr 2026 21:16:58 +0000
In-Reply-To: <20260410211726.1668756-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260410211726.1668756-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410211726.1668756-3-kuniyu@google.com>
Subject: [PATCH v2 net-next 02/15] ip6mr: Annotate access to mrt->mroute_do_{pim,assert,wrvifwhole}.
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277578-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 25F6A3DCCF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

These fields in struct mr_table are updated in ip6_mroute_setsockopt()
under RTNL:

  * mroute_do_pim
  * mroute_do_assert (MRT6_PIM is under RTNL while MRT6_ASSERT is lockless)
  * mroute_do_wrvifwhole

However, ip6_mroute_getsockopt() does not hold RTNL and read the first
two fields locklessly, and ip6_mr_forward() reads all the three under
RCU.

Let's use WRITE_ONCE() and READ_ONCE() for them.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6mr.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 85010ff21c98..b263d3c69a5a 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1780,7 +1780,7 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 			return -EINVAL;
 		if (copy_from_sockptr(&v, optval, sizeof(v)))
 			return -EFAULT;
-		mrt->mroute_do_assert = v;
+		WRITE_ONCE(mrt->mroute_do_assert, v);
 		return 0;
 	}
 
@@ -1800,9 +1800,9 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 		rtnl_lock();
 		ret = 0;
 		if (v != mrt->mroute_do_pim) {
-			mrt->mroute_do_pim = v;
-			mrt->mroute_do_assert = v;
-			mrt->mroute_do_wrvifwhole = do_wrmifwhole;
+			WRITE_ONCE(mrt->mroute_do_pim, v);
+			WRITE_ONCE(mrt->mroute_do_assert, v);
+			WRITE_ONCE(mrt->mroute_do_wrvifwhole, do_wrmifwhole);
 		}
 		rtnl_unlock();
 		return ret;
@@ -1870,11 +1870,11 @@ int ip6_mroute_getsockopt(struct sock *sk, int optname, sockptr_t optval,
 		break;
 #ifdef CONFIG_IPV6_PIMSM_V2
 	case MRT6_PIM:
-		val = mrt->mroute_do_pim;
+		val = READ_ONCE(mrt->mroute_do_pim);
 		break;
 #endif
 	case MRT6_ASSERT:
-		val = mrt->mroute_do_assert;
+		val = READ_ONCE(mrt->mroute_do_assert);
 		break;
 	default:
 		return -ENOPROTOOPT;
@@ -2177,20 +2177,20 @@ static void ip6_mr_forward(struct net *net, struct mr_table *mrt,
 	if (rcu_access_pointer(mrt->vif_table[vif].dev) != dev) {
 		atomic_long_inc(&c->_c.mfc_un.res.wrong_if);
 
-		if (true_vifi >= 0 && mrt->mroute_do_assert &&
+		if (true_vifi >= 0 && READ_ONCE(mrt->mroute_do_assert) &&
 		    /* pimsm uses asserts, when switching from RPT to SPT,
 		       so that we cannot check that packet arrived on an oif.
 		       It is bad, but otherwise we would need to move pretty
 		       large chunk of pimd to kernel. Ough... --ANK
 		     */
-		    (mrt->mroute_do_pim ||
+		    (READ_ONCE(mrt->mroute_do_pim) ||
 		     c->_c.mfc_un.res.ttls[true_vifi] < 255) &&
 		    time_after(jiffies,
 			       c->_c.mfc_un.res.last_assert +
 			       MFC_ASSERT_THRESH)) {
 			c->_c.mfc_un.res.last_assert = jiffies;
 			ip6mr_cache_report(mrt, skb, true_vifi, MRT6MSG_WRONGMIF);
-			if (mrt->mroute_do_wrvifwhole)
+			if (READ_ONCE(mrt->mroute_do_wrvifwhole))
 				ip6mr_cache_report(mrt, skb, true_vifi,
 						   MRT6MSG_WRMIFWHOLE);
 		}
-- 
2.53.0.1213.gd9a14994de-goog


