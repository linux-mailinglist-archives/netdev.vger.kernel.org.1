Return-Path: <netdev+bounces-191120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E4AABA226
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 19:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D708188A12F
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 17:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE53D27464E;
	Fri, 16 May 2025 17:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="LTABf63y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302BC272E69
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 17:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747417489; cv=none; b=ZzKtxmzQIlSaqVh11Twwi9cvOcQHkvjXBw4PJRxf7MUf+Y4qKsAWuD7ZJ3jOgHwzHZFIjAnyeYhRXNZhHjSsBkaF6jCn62vYFgxL9n50csXlrQyGFTHwpO7/X+sVOJtStg6ecQIIETKuHlr8GWRNO2jqG67vp+a5E2UcTvhcJcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747417489; c=relaxed/simple;
	bh=e7Gnfj4M1LWkoinHP5YUb6VVDRTw5ARwL424EfYYzbQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k9sfSuRg4yrQddTMUeBKMQWLThbUQ9eIBsM+IxpSrciCJuvS788i/MDiOaDxSnro11ILIBSBtjMzaQ6Yqo39OX7e4JPQnzb7+3pGbT7wWALBDsM6KMimQfswhCFegBm6y0rUOBW18Bc5uT4+H7+R8oo0JUBofjlrWmJCbHsZPGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=LTABf63y; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747417489; x=1778953489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PSvA8wf7hhiihWDhLdgV3K7zKIlswqoFfMtC1oKBAhs=;
  b=LTABf63yque1LzyvFAjUyNbwzXAN9qFOO3L6L+cbyyofT4ctzbpeUB/l
   Lp0Xy4JYd8ss+N3v+l8zUpyHIUTFSwwNjTxLqhToBO+j0vhROosLB9FB2
   sM5W1jjAhXfD18cv7bLe5anagN8RaYV1ieUIdWhCcFGsXsf5DYN1cY+dM
   zACK2mQHOywizksrj+3A0swtChfIX6R2M6IhoMuXqtw8YBRmnARtA73zk
   2FLyBgFAH96IA0gOpu6EEk5TFCG1qzlNktPbzOsvrufMrjP5q0Oyey/JP
   tx2LVO7Ov0pBVhV0EK1wtqY7ao6rtp8IBESzOtKnLnUf0J/qwEFa6GCiZ
   w==;
X-IronPort-AV: E=Sophos;i="6.15,294,1739836800"; 
   d="scan'208";a="50819124"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 17:44:46 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:2848]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.122:2525] with esmtp (Farcaster)
 id 34c6c81e-e9f2-4b22-aa3b-0b67ac37f00b; Fri, 16 May 2025 17:44:45 +0000 (UTC)
X-Farcaster-Flow-ID: 34c6c81e-e9f2-4b22-aa3b-0b67ac37f00b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 16 May 2025 17:44:45 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.194.153) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 16 May 2025 17:44:43 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [TEST]  net/bind_wildcard flakiness
Date: Fri, 16 May 2025 10:44:31 -0700
Message-ID: <20250516174435.70447-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250516100542.67c276ec@kernel.org>
References: <20250516100542.67c276ec@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB001.ant.amazon.com (10.13.139.132) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 16 May 2025 10:05:42 -0700
> Hi!
> 
> The bind_wildcard used to be rock solid, no flakes in last 1000 runs,
> but then around the time Eric posted his Rx optimizations we hit one
> flake, and now we hit another:

Thanks for the report.

The test only calls bind() so I guess it's not related to the RX
optimisation series.


> 
> List:
> https://netdev.bots.linux.dev/contest.html?test=bind-wildcard&executor=vmksft-net&pass=0
> 
> Outputs:
> https://netdev-3.bots.linux.dev/vmksft-net/results/122022/14-bind-wildcard/stdout
> https://netdev-3.bots.linux.dev/vmksft-net/results/123463/14-bind-wildcard/stdout
> 
> One does:
> 
> # 0.21 [+0.00] # bind_wildcard.c:768:reuseaddr:Expected ret (-1) == 0 (0)
> # 0.21 [+0.00] # reuseaddr: Test terminated by assertion
> # 0.21 [+0.00] #          FAIL  bind_wildcard.v6_any_only_v6_v4mapped_any.reuseaddr
> 
> The other:
> 
> # 0.25 [+0.00] # bind_wildcard.c:775:plain:Expected ret (-1) == 0 (0)
> # 0.25 [+0.00] # plain: Test terminated by assertion
> # 0.25 [+0.00] #          FAIL  bind_wildcard.v6_local_v6_v4mapped_any.plain

This is weird because both cases failed when bind() should succeed.

Will try to reproduce on my end.


> 
> 
> The only change on the infra side is that I increased disk IO cap,
> so the builds are now faster.

