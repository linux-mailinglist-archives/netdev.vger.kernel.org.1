Return-Path: <netdev+bounces-178669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB71A7825E
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 20:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C994716DE4C
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 18:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDA2218E81;
	Tue,  1 Apr 2025 18:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZaBiqfOs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6117521D581
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 18:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743532605; cv=none; b=QtEegxpXGefi34x3jF+NuSzKXcG0jbfjnQhQCA4YSRZ8fOpXmtnUR0b82FaarTXggQwSf7Es44srj9EfSqNli6mbIccsuvinJvRoceRr2erMsbXNjOEMKe7yTl3QYTTWP77WSsIvXUtVP4wpR8u6Po0HpBCPx6NPYE15PZaBQJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743532605; c=relaxed/simple;
	bh=Rz+VoLdMAZz4lMAg8R2vY/3hQsTNk1kIM8k6Gap7Et4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C94PNNgIkW4s3DFXVCHekdTsznhwnPg4iljkeItBqM+oTjWPwoWHcuVrrjlCzsRr58iPXMn4IznrYdBHU5tMzcuFjlWRPWDvVPQOOBFs6G1DWgQTFslxVmxbIE5db0iJtxTuztDPv7wupVpygZ5Lyfcd8sjxk7fQz7uwVgslrcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZaBiqfOs; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743532604; x=1775068604;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tm3ijMpDpVX9BQ+H9sXAyP+ku4XHZtWzpcXNcnqwvYM=;
  b=ZaBiqfOsXCy4ekzMy7eo+8kN4gZfeAx6URWoSVnWLVm9NMWRgvl27+vd
   LvYBJwiNtg9Yffj+Kr+8cYx9lnIW2ZeImGsfn3MBBZ1RevDY2fqIJr4cQ
   t/3i1Ane5pR9S8QyXTS7RUQpPuUOtRfGRrFmbfkJB5B42LVXucjK0b1RM
   c=;
X-IronPort-AV: E=Sophos;i="6.14,294,1736812800"; 
   d="scan'208";a="6496442"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 18:36:37 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:25956]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.83:2525] with esmtp (Farcaster)
 id 6f2c2187-97a3-4645-8ff5-e3668646c36d; Tue, 1 Apr 2025 18:36:36 +0000 (UTC)
X-Farcaster-Flow-ID: 6f2c2187-97a3-4645-8ff5-e3668646c36d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 1 Apr 2025 18:36:36 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.43.60) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 1 Apr 2025 18:36:33 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <willemdebruijn.kernel@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v4 net 0/3] udp: Fix two integer overflows when sk->sk_rcvbuf is close to INT_MAX.
Date: Tue, 1 Apr 2025 11:35:41 -0700
Message-ID: <20250401183625.66095-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <67eb3e2c92fb9_395352294e1@willemb.c.googlers.com.notmuch>
References: <67eb3e2c92fb9_395352294e1@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 31 Mar 2025 21:15:24 -0400
> Jakub Kicinski wrote:
> > On Mon, 31 Mar 2025 13:31:47 -0700 Kuniyuki Iwashima wrote:
> > > > > Please do test locally if you can.  
> > > > 
> > > > Sure, will try the same tests with CI.  
> > > 
> > > Is there a way to tell NIPA to run a test in a dedicated VM ?
> > > 
> > > I see some tests succeed when executed solely but fail when
> > > executed with
> > > 
> > >   make -C tools/testing/selftests/ TARGETS=net run_tests
> > > 
> > > When combined with other tests, assuming that the global UDP usage
> > > will soon drop to 0 is not always easy... so it's defeating the
> > > purpose but I'd drop the test in v5 not to make CI unhappy.
> > 
> > Can we account for some level of system noise? Or try to dump all 
> > the sockets and count the "accounted for" in-use memory?
> > 
> > We can do various things in NIPA, but I'm not sure if it's okay 
> > for tests inside net/ should require a completely idle system.
> > If we want a completely idle system maybe user-mode Linux + kunit
> > is a better direction?
> > 
> > Willem, WDYT?
> 
> The number of tests depending on global variables like
> proto_memory_allocated is thankfully low.
> 
> kselftest/runner.sh runs RUN_IN_NETNS tests in parallel. That sounds
> the case here. Perhaps we can add a test option to force running
> without concurrent other tests?
> 
> Otherwise, the specific test drops usage from MAX to 0. And verifies
> to reach MAX before exiting its loop.

Yes, and we need to query rmem_alloc via netlink.

Also, I haven't investigated, but I saw a weird timeout, when the usage
stuck at 523914, which is smaller than INT_MAX >> PAGE_SHIFT.

Probably the test needs to check sockets' rmem_alloc to be accurate.

I'll drop the test for now and follow up in net-next.

Thanks!

