Return-Path: <netdev+bounces-142447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 439E49BF346
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 17:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 758791C21C63
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 16:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DB2205143;
	Wed,  6 Nov 2024 16:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qXtXXK0F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDD718C006
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 16:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730910785; cv=none; b=cVgHnapWBPw0kukNpx7669yM8xr3CQJ8fy1K6GOFAqrS3zkGATpZ+mHxopMVCuGRbu53JgV9dCVQQmIupiWoG4e/llUmi794Uayve3l10JlUewwx7dJ8J/s+BK7UnTUqrZHRvWl4VzK0zNzWHDRyxh7jOjSCHxZ7G988D5L7+b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730910785; c=relaxed/simple;
	bh=5AWdXOZSPS/xg2m+eifaM1R7WKHWxN5pDSIKQeS8dIM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HNOun1FOanaLuGUOEClTTSJ+t+wcrE0kFUHvCy46qgkMVXbGJzp53WVzslXCcBUIKrNKf1CkgY+fO3BjEXxN7DCtXMzBQwGJft9kpzMVHbg77CqhtBF48FBW9mnSUVW/kCNMvwbRtrszT7YNdQ5Hny+P9IxbrqlmXAB8QVKibP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=qXtXXK0F; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730910784; x=1762446784;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2tZJ3sJExkTV+eRbbFxVPyXKHqR7e/sGxqyAGaKn6E8=;
  b=qXtXXK0F7x012XSbSnCDle1BpK/D9Qy6IoPhzH2xVLt8f8aULcHxaJI1
   NwZgWwNBQ94OjzYrObvf943IU1r/Amlagh+RBywjMXb9uCb3XX3T8yPab
   KR/dSWSr8USqhPI+dH0Y1QQnGJnywbCXKgCwepsHT9gdjYom9GQ5wTvtt
   o=;
X-IronPort-AV: E=Sophos;i="6.11,263,1725321600"; 
   d="scan'208";a="446871538"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 16:33:00 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:41265]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.1.168:2525] with esmtp (Farcaster)
 id 9d71259a-1393-478a-bf73-0a7812dd6336; Wed, 6 Nov 2024 16:32:58 +0000 (UTC)
X-Farcaster-Flow-ID: 9d71259a-1393-478a-bf73-0a7812dd6336
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 6 Nov 2024 16:32:58 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 6 Nov 2024 16:32:54 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <andrew+netdev@lunn.ch>, <daniel@iogearbox.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <horms@kernel.org>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <mailhol.vincent@wanadoo.fr>,
	<mkl@pengutronix.de>, <netdev@vger.kernel.org>, <razor@blackwall.org>
Subject: Re: [PATCH v2 net-next 6/7] rtnetlink: Convert RTM_NEWLINK to per-netns RTNL.
Date: Wed, 6 Nov 2024 08:32:51 -0800
Message-ID: <20241106163251.97101-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <0ce3e4aa-a091-4d83-b3f3-222b9eaf05c5@redhat.com>
References: <0ce3e4aa-a091-4d83-b3f3-222b9eaf05c5@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC002.ant.amazon.com (10.13.139.242) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Wed, 6 Nov 2024 10:00:26 +0100
> On 11/6/24 03:24, Kuniyuki Iwashima wrote:
> > @@ -7001,7 +7021,8 @@ static struct pernet_operations rtnetlink_net_ops = {
> >  };
> >  
> >  static const struct rtnl_msg_handler rtnetlink_rtnl_msg_handlers[] __initconst = {
> > -	{.msgtype = RTM_NEWLINK, .doit = rtnl_newlink},
> > +	{.msgtype = RTM_NEWLINK, .doit = rtnl_newlink,
> > +	 .flags = RTNL_FLAG_DOIT_PERNET},
> >  	{.msgtype = RTM_DELLINK, .doit = rtnl_dellink},
> >  	{.msgtype = RTM_GETLINK, .doit = rtnl_getlink,
> >  	 .dumpit = rtnl_dump_ifinfo, .flags = RTNL_FLAG_DUMP_SPLIT_NLM_DONE},
> 
> It looks like this still causes look problems - srcu/rtnl acquired in
> both orders:
> 
> https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/847881/12-rtnetlink-sh/stderr
> 
> It looks like __rtnl_link_unregister() should release the rtnl lock
> around synchronize_srcu(). I'm unsure if would cause other problems, too.

It seems I need to unexport __rtnl_link_unregister(), add mutex for
rtnl_link_ops, and move ops deletion before down_write(&pernet_ops_rwsem)
in rtnl_link_unregister().

It would be better than releasing RTNL after rtnl_lock_unregistering_all().

> 
> Please have a self-tests run with lockdep enabled before the next iteration:
> 
> https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style
> 
> The whole test suite could be quite cumbersome, but the rtnetlink.sh
> test should give a good coverage.

Sure, sorry for the churn for other patches..

I noticed rmmod wasn't tested on my QEMU because I enabled drivers
as =y so that I need not copy .ko.  I'll run test with netdevsim
as =m at least.


> 
> Thanks.
> 
> Paolo
> 
> p.s. kudos to Jakub for the extra miles to create and maintain the CI
> infra: it's really catching up non trivial things.

+100

Thank you!

