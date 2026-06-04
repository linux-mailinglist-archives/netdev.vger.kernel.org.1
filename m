Return-Path: <netdev+bounces-295453-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bDJHBNQAImrxRQEAu9opvQ
	(envelope-from <netdev+bounces-295453-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:48:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E20643DCB
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:48:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=h7xRrJtT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295453-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295453-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 158413022610
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 22:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6013259C9C;
	Thu,  4 Jun 2026 22:47:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9843430C629
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 22:47:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780613239; cv=none; b=HC8rcNy31Nhty83flXeBZJOo5411+DbdJVoL4/6Inanl+F5JbrTKnyNQYO+dp9Z16I0DAsVonT1BXdZXITeu3bZ8XYKhSIQ65UB0O7+iFLdOLXl4OdOOtxfTGZmT2XvtQPtUgDqJiCYU2WGgYBQXXw7I/xVegDSh8srvzIbrkZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780613239; c=relaxed/simple;
	bh=+4u1/QYBmIFIVLUPtKMRPHlFFaSDPELLwQ8ttgFiwGk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rJgIi/3YaLzyEZADmZsdS13rJ7twGLYt5qpYqFYG7pTvZiL98ru3snQEsHmRFqHMrtREJjurP0RRu89fehjjV0XLE4OkZjgRIgHD4kO2xN/rWof5E3Yj7mlcjjWXVULhs4cABBQTCKPre+V+oZihtrPn88u5Zfxr7aJIs1uKvec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h7xRrJtT; arc=none smtp.client-ip=209.85.214.201
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso4715695ad.3
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 15:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780613238; x=1781218038; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oK93fGF49xVUw92aR298Lg5bBEtedfFZSi+EL2kQiLc=;
        b=h7xRrJtTV9Anbc9ALmJw2hBKsV+blJUEVvxvMGxrmR+/IPrq70FOF0pd86A+AQYRdC
         dLadI3/qPkP5tak+CbK//2XujcR+I8S9yI9+W9/SF+kcLju8VWsJ2xLOeO8n+Q8PCzN4
         LIZCCo0vczsZYv/09Y1tr7Zm/LyMb0WLeyF3ciVCSs/XDJt5nZgxljq6nOXSFhTjcCFB
         IznZ5oCo+9R+PYpOtQ5ApHs/TTsG4HdWbLKFcWD9M/a0+k30w1JDr4Vcz84azolHv7bN
         4hpigFFfAI7bqETxVjF+VZurXOqUHTLbFCypVTITItjRYQsaz4OZ9DAGi5S81SGOUNFL
         geQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780613238; x=1781218038;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oK93fGF49xVUw92aR298Lg5bBEtedfFZSi+EL2kQiLc=;
        b=KvKgC1LhDmmwSE2m9jaB8M7pb0A2mEFY0/dnBTuXrUq3j3Qb1qyNpIiRdtN/RgR8oR
         1q1njEVyYjTzqFCE487jVbQ0z6HkK2071pgfZsz6SSU9+BIBxcnMGq1pKgUUV1X1kQnI
         b5PMoM4Oe6C5SPVb+EwOTZejte09ZqOKs2IxDECDSrAemR0KgPQ1wdQu958LKHccxIpZ
         MfoE80lRgObi5Z9RVkBp6L55tikSnNA9FN+VGjaEu5nP+SmpyqHLEPrTD0RxdIt6/np0
         KKU6yGN/NrIyC2jqr7l/9shJ01jT47/CJHYTXgI+c69RmA7Ne5L1df5wm2se3Wi1czEm
         8nrg==
X-Forwarded-Encrypted: i=1; AFNElJ8yJe4YBw/KAbYvU7ZNWbh3AQf5suoGkd7G8/KnTi0wtWsaiTrVheUK3O12AXMLGAp4V8jL46U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyczJE5jlzsKvL3VvJ9cQj/ksgCjU40fGl6pweRdxEZ7etcY4M5
	/xwfPXMSTnNeq1HOPz3yov0l6s5MSMeDR1qhaDkm/W8wHQpPOcVUlxZCg1cvJGsW2Q9jccXiLhu
	nYI651w==
X-Received: from plhd5.prod.google.com ([2002:a17:903:2305:b0:2bc:9110:820f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2a84:b0:2ba:4ad9:70f6
 with SMTP id d9443c01a7336-2c1e85c5022mr5881935ad.31.1780613237572; Thu, 04
 Jun 2026 15:47:17 -0700 (PDT)
Date: Thu,  4 Jun 2026 22:46:20 +0000
In-Reply-To: <20260604224712.3209821-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604224712.3209821-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604224712.3209821-3-kuniyu@google.com>
Subject: [PATCH v3 net-next 02/15] ip6mr: Annotate access to mrt->mroute_do_{pim,assert,wrvifwhole}.
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
	TAGGED_FROM(0.00)[bounces-295453-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 61E20643DCB

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
index 9d748f4c44e9..e3dd5851b879 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1778,7 +1778,7 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 			return -EINVAL;
 		if (copy_from_sockptr(&v, optval, sizeof(v)))
 			return -EFAULT;
-		mrt->mroute_do_assert = v;
+		WRITE_ONCE(mrt->mroute_do_assert, v);
 		return 0;
 	}
 
@@ -1798,9 +1798,9 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
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
@@ -1868,11 +1868,11 @@ int ip6_mroute_getsockopt(struct sock *sk, int optname, sockptr_t optval,
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
@@ -2175,20 +2175,20 @@ static void ip6_mr_forward(struct net *net, struct mr_table *mrt,
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
2.54.0.1032.g2f8565e1d1-goog


