Return-Path: <netdev+bounces-177177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99313A6E309
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 20:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 600FD1885628
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 19:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62ACE261370;
	Mon, 24 Mar 2025 19:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ji7C1qBi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9794189520
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 19:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742843071; cv=none; b=QLoCW/BfSZGaPsC4yWNOq+v7XH0JYBnfKL/UJ5oiDmy+g9hSd1I5uQZSiEe4nToCjV/nDxxXU2RtN+6bQQ7zIqudZnFMg4nB6yCbKqkt4JjmIq0tZ416tm92VpciITNFDrLkpDBOo+CmFtuJ0jvysZteGN31+cadn+l88PQD8Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742843071; c=relaxed/simple;
	bh=5VYu7VwiJDmiWJHxJIprjqNeni2yNWnOXlWKe5QOddU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BYow+f0/oiblYcHUO2s4u3qKccDs6BwxDSYTlmDjui0qldxcgN/AaWXC3IcLmXO8Vesue7fgr645v7wkoQNcdMzUd4++ib+5n5hBzX0iMYWXQQVO9+uDi9Kyc0T/TcBuyU1HCSCxrayu1w1zXP04E6yoWj43lGYVv4aSJfxIL+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ji7C1qBi; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742843066; x=1774379066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nDijHZLwYcqmEv52WbRGcxRucwIt0jVRk3VL6d08ggk=;
  b=ji7C1qBiMLK5pk4cWCqtlHMKH17QOaBBYPmPsqBdHIX89R/gBLERo30X
   1omqktITRG9OHq52bBY5KjsMQETbh1QY0yRK9WbnfslpozNveS5q0kplO
   nNuuq2xEHW1Km9/tnUQy5u1HdyqT+AWOUfO3RXN5/zcnscVDwOj7ZW0Vd
   A=;
X-IronPort-AV: E=Sophos;i="6.14,272,1736812800"; 
   d="scan'208";a="184728800"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 19:04:25 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:33349]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.18:2525] with esmtp (Farcaster)
 id 88793e52-e775-495d-a799-5775558b5479; Mon, 24 Mar 2025 19:04:24 +0000 (UTC)
X-Farcaster-Flow-ID: 88793e52-e775-495d-a799-5775558b5479
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 24 Mar 2025 19:04:24 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.20) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 24 Mar 2025 19:04:20 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <idosch@idosch.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<petrm@nvidia.com>
Subject: Re: [PATCH v2 net-next 0/7] nexthop: Convert RTM_{NEW,DEL}NEXTHOP to per-netns RTNL.
Date: Mon, 24 Mar 2025 12:03:49 -0700
Message-ID: <20250324190411.52096-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <Z-EnSBUR8IM70wmg@shredder>
References: <Z-EnSBUR8IM70wmg@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC001.ant.amazon.com (10.13.139.213) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Ido Schimmel <idosch@idosch.org>
Date: Mon, 24 Mar 2025 11:35:04 +0200
> On Wed, Mar 19, 2025 at 04:06:45PM -0700, Kuniyuki Iwashima wrote:
> > Patch 1 - 5 move some validation for RTM_NEWNEXTHOP so that it can be
> > called without RTNL.
> > 
> > Patch 6 & 7 converts RTM_NEWNEXTHOP and RTM_DELNEXTHOP to per-netns RTNL.
> > 
> > Note that RTM_GETNEXTHOP and RTM_GETNEXTHOPBUCKET are not touched in
> > this series.
> > 
> > rtm_get_nexthop() can be easily converted to RCU, but rtm_dump_nexthop()
> > needs more work due to the left-to-right rbtree walk, which looks prone
> > to node deletion and tree rotation without a retry mechanism.
> 
> Thanks for the series, looks good, but note that dump/get can block when
> fetching hardware statistics:

Oh thanks!

I was puzzled by the left-right rbtree iteration under RCU and wondering
if I should try harder, but converting the notifier to non-blocking one
is not worth that, and I can simply use per-netns RTNL :)


> 
> rtm_get_nexthop
>     nh_fill_node
>         nla_put_nh_group
> 	    nla_put_nh_group_stats
> 	        nh_grp_hw_stats_update
> 		    blocking_notifier_call_chain

