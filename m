Return-Path: <netdev+bounces-176182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57589A69436
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 16:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B45D81674AC
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 15:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DBE1D7999;
	Wed, 19 Mar 2025 15:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="oeGIezsX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B7A1FB3
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742399963; cv=none; b=EP+kH4sJuNssI8Q8FJV3RIfay+MTYQZ5AAmbyOGHH2pJyxWn1EH6cMZDFH8fxdcvKqZW+r+5gek9ZsQdXAUNkQ2U7+eLYyVBw0nqzorNhYR8K/dSua6yFD07xbSlUxJKjiIXajRNs9syt1IIKtNbqYtNjnkrSIYfs8m+wGtqFxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742399963; c=relaxed/simple;
	bh=ZZCXbt8B5xOrX2o5sjYnXgndpKycIvWGlW8Z4kWBSn0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r2LIkBLrcYUkPvP1D89WHb3ppaEjcvsTDCqka4Jgx0C2LoH+0kARVaDTS+NpDEefgORNeNOaBCIkNoDDZ0emAPzAIwYZo6K4PYj2KRRTlQ+1fLzEWTzNxRF+cVC/rYjs+VjxTqJhFHdoL2fFXCIdaigIIKdfQ8D2QbIwBenTqrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=oeGIezsX; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742399962; x=1773935962;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1yfk4Fng/95l4CEZWXTYHgr6RaTeUUQlZtjkcGxUrsg=;
  b=oeGIezsXhsN4SKaYMaTiz3TwZ5puD+DANQaU2Ai6gKgCBO6jVezMW+AM
   FGIoznL96n+d2oNMCu89StmEdSsD04zKqEKaU4QOp6QeUIzM28+XYFM4j
   KyqI2XDh4os4C1X6omj1wUN2oqymqdzR4by4bwGR9DOWAkIErlDsuuXkM
   k=;
X-IronPort-AV: E=Sophos;i="6.14,259,1736812800"; 
   d="scan'208";a="75780464"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 15:59:18 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:18236]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.34:2525] with esmtp (Farcaster)
 id ba51a66a-6a4d-4c3f-8ff8-44b4ad26bc2c; Wed, 19 Mar 2025 15:59:17 +0000 (UTC)
X-Farcaster-Flow-ID: ba51a66a-6a4d-4c3f-8ff8-44b4ad26bc2c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 19 Mar 2025 15:59:16 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 19 Mar 2025 15:59:13 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net-next 0/7] nexthop: Convert RTM_{NEW,DEL}NEXTHOP to per-netns RTNL.
Date: Wed, 19 Mar 2025 08:57:46 -0700
Message-ID: <20250319155904.6616-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <70ca4d5c-90c3-4a96-b47b-fbf5034c7450@redhat.com>
References: <70ca4d5c-90c3-4a96-b47b-fbf5034c7450@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB003.ant.amazon.com (10.13.139.174) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Wed, 19 Mar 2025 08:57:52 +0100
> Hi,
> 
> On 3/19/25 12:31 AM, Kuniyuki Iwashima wrote:
> > Patch 1 - 5 move some validation for RTM_NEWNEXTHOP so that it can be
> > done without RTNL.
> > 
> > Patch 6 & 7 converts RTM_NEWNEXTHOP and RTM_DELNEXTHOP to per-netns RTNL.
> > 
> > Note that RTM_GETNEXTHOP and RTM_GETNEXTHOPBUCKET are not touched in
> > this series.
> > 
> > rtm_get_nexthop() can be easily converted to RCU, but rtm_dump_nexthop()
> > needs more work due to the left-to-right rbtree walk, which looks prone
> > to node deletion and tree rotation without a retry mechanism.
> > 
> > 
> > Kuniyuki Iwashima (7):
> >   nexthop: Move nlmsg_parse() in rtm_to_nh_config() to
> >     rtm_new_nexthop().
> >   nexthop: Split nh_check_attr_group().
> >   nexthop: Move NHA_OIF validation to rtm_to_nh_config_rtnl().
> >   nexthop: Check NLM_F_REPLACE and NHA_ID in rtm_new_nexthop().
> >   nexthop: Remove redundant group len check in nexthop_create_group().
> >   nexthop: Convert RTM_NEWNEXTHOP to per-netns RTNL.
> >   nexthop: Convert RTM_DELNEXTHOP to per-netns RTNL.
> > 
> >  net/ipv4/nexthop.c | 183 +++++++++++++++++++++++++++------------------
> >  1 file changed, 112 insertions(+), 71 deletions(-)
> 
> This series is apparently causing NULL ptr deref in the nexthop.sh
> netdevsim selftests. Unfortunately, due to a transient nipa infra
> outage, a lot of stuff landed into the same batch, so I'm not 110% this
> series is the real curprit but looks like a reasonable suspect.
> 
> Kuniyuki, could you please have a look?
> 
> ---
> [    1.653896] BUG: kernel NULL pointer dereference, address:
> 0000000000000068
> [    1.653963] #PF: supervisor read access in kernel mode
> [    1.654003] #PF: error_code(0x0000) - not-present page
> [    1.654037] PGD 7828067 P4D 7828067 PUD 782a067 PMD 0
> [    1.654077] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> [    1.654119] CPU: 0 UID: 0 PID: 303 Comm: ip Not tainted
> 6.14.0-rc6-virtme #1
> [    1.654176] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> [    1.654219] RIP: 0010:rtm_new_nexthop+0x645/0x2260

Sorry, I failed to resolve conflict during the last minute rebase,
and the normal test bailed out here...

---8<---
@@ -3245,7 +3248,7 @@ static int rtm_new_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto out;
 
 	err = rtm_to_nh_config_rtnl(net, tb, extack);
-	if (!err)
+	if (err)
 		goto out;
 
 	nh = nexthop_add(net, &cfg, extack);
---8<---

The failed test case created a nexthop group with an invalid ID,
and nexthop_get() for nh by nexthop_find_by_id() assumes nh is not
NULL because it's checked in advance.

Will squash the diff above in v2.

Thanks!

