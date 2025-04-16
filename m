Return-Path: <netdev+bounces-183454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7086A90B93
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 20:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D00A3AC8C5
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7931F9F47;
	Wed, 16 Apr 2025 18:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mEav76Kc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B13910E9
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 18:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744829178; cv=none; b=gYpsBCv57UQkkD+Zu0XD8JUGRhd6YFVMXdNmke6Rt//8cMFTigPGJaGHusSuiHhJLD99/UYOdO3W2g1D2i+7vknb9HJ/Qn/uZJLV/L3rYIpakC9XlDVqPr4wQO5FprcZwtF69454VgWN75qhuUgyqazMxF+0e66SRkhD+7v3YJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744829178; c=relaxed/simple;
	bh=Jd2+OPdTGSCx+kNOej+I+Wxa/lR8qH0xt6Y/suuwGS4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n9shhamgfn42NcSvUk48tMTZagqXQRwf9o07snvXk4hcLGEcNrG0/a9ikACsw4Nw1Inhrqx5nx3ETlQDc28StbxkBUCKDoodkveTdfBzLcdf/Pl4XbIoXYevDaO2P5L0H+mAFdxWYEJyV1zrKDXH3Moe8Jrf0BOISdhkr/vD4o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=mEav76Kc; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744829177; x=1776365177;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bOhdv5UK0lXusbZrQI4pOAXYcNnV1NOLLyb89FPCtq8=;
  b=mEav76KcdB1CXVI2mA+b2e87DbOuHKmox0sC7Th5PwSAuuY3YG1mZWZV
   7js4pUGg1tJgYpx5m2JaJoIKBXDE1NhIwR126SdDdn/37H5vNKlCdrumP
   kY7gtYPFbqiqcKflSYpNMM5uPjX3FoE8rqwwnygb52/rRt/ZI/fHl1uoy
   Q=;
X-IronPort-AV: E=Sophos;i="6.15,216,1739836800"; 
   d="scan'208";a="481012462"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 18:46:13 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:4287]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.242:2525] with esmtp (Farcaster)
 id 47cf6e0c-aac8-47a3-ba89-40ca09268cf1; Wed, 16 Apr 2025 18:46:12 +0000 (UTC)
X-Farcaster-Flow-ID: 47cf6e0c-aac8-47a3-ba89-40ca09268cf1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 18:46:09 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 18:46:07 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH RESEND v2 net-next 02/14] ipv6: Get rid of RTNL for SIOCDELRT and RTM_DELROUTE.
Date: Wed, 16 Apr 2025 11:45:57 -0700
Message-ID: <20250416184559.99881-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <3e28015e-0ca0-4933-80b5-de45e3c43b11@redhat.com>
References: <3e28015e-0ca0-4933-80b5-de45e3c43b11@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC002.ant.amazon.com (10.13.139.230) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Wed, 16 Apr 2025 10:49:53 +0200
> On 4/14/25 8:14 PM, Kuniyuki Iwashima wrote:
> > Basically, removing an IPv6 route does not require RTNL because
> > the IPv6 routing tables are protected by per table lock.
> > 
> > inet6_rtm_delroute() calls nexthop_find_by_id() to check if the
> > nexthop specified by RTA_NH_ID exists.  nexthop uses rbtree and
> > the top-down walk can be safely performed under RCU.
> > 
> > ip6_route_del() already relies on RCU and the table lock, but we
> > need to extend the RCU critical section a bit more to cover
> > __ip6_del_rt().  For example, nexthop_for_each_fib6_nh() and
> > inet6_rt_notify() needs RCU.
> 
> The last statement is not clear to me. I don't see __ip6_del_rt()
> calling nexthop_for_each_fib6_nh() or inet6_rt_notify() ?!?

Thank you for review!

It's burried in the depths, and I noticed this from the v1 test result.
https://lore.kernel.org/netdev/Z91yk90LZy9yJexG@mini-arch/

inet6_rtm_delroute
 ip6_route_del
  __ip6_del_rt
   fib6_del
    fib6_del_route
     fib6_purge_rt
      nexthop_for_each_fib6_nh

inet6_rtm_delroute
 ip6_route_del
  __ip6_del_rt
   fib6_del
    fib6_del_route
     inet6_rt_notify


> 
> Also after this patch we have this chunk in ip6_route_del():
> 
> 	table = fib6_get_table(cfg->fc_nlinfo.nl_net, cfg->fc_table);
> 	if (!table)
> 		//..
> 
> 	rcu_read_lock();
> 
> which AFAICS should be safe because 'table' is freed only at netns exit
> time,

Right, and there are few other functions assuming the same thing.

addrconf_get_prefix_route()
rt6_get_route_info()

> but acquiring the rcu lock after grabbing the rcu protected struct
> is confusing. It should be good adding a comment or moving the rcu lock
> before the lookup (and dropping the RCU lock from fib6_get_table())

There are other callers of fib6_get_table(), so I'd move rcu_read_lock()
before it, and will look into them if we can drop it from fib6_get_table().


