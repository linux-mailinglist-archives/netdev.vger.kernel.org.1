Return-Path: <netdev+bounces-131043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1E798C70F
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 22:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 017C41C21E72
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82821CCEDA;
	Tue,  1 Oct 2024 20:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tn2WnMBh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E051CC884
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 20:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727816166; cv=none; b=rnyHXppxX9QtGkY02yR14/HKSV3qkshgFMxhWYbUOcAFnsmgDychceL1uuizNHVBR8ztz4rJOf3EZTso188yuAhIuSHSsF38mIc0W4xKqyYTIe1jEf08wLX8sE1cKqsQ+0oKYHoI5vH7s3hgNSCzlgO5Ro8bx07Dpy2I/c3vMCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727816166; c=relaxed/simple;
	bh=rspXBvhhlVjUMtHpNQLCmG/VIhe89XM82S9lE789R5w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=daUdpg/Nyl7X3tBaLMdrMAz8H1tTcQLPpxC9zq80lqh5ffGvUR3T50wAj0rl4x95krtK7k0vgeDsdo3y7ABoVwDjRiR5FXbeY0EsDHHhW/PgBrI1Ry/I4PN+SshneBlI3M7afI4wqjSYy6mun/0DkBSg0YZcGodRLTrsdEiVsH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=tn2WnMBh; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727816165; x=1759352165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iGjiUx2dNiVeicwv8geBJbRFGpQNeQh7lrzqsILfZR4=;
  b=tn2WnMBhrotwL7f0sbl3rXxroZtYYY5I39yvk8d144zp2/tgXBigU2Fv
   9iapOpNWzAyljqoNWJICw3RxaBoW1sXlrdkrRrsx6c2sbWBw6zrEbMZFv
   as0QcO7qx7YFhBCnFrZm54LGz8ntdkHUgB9zvKwe+t6CrU4ipswfUe8aj
   k=;
X-IronPort-AV: E=Sophos;i="6.11,169,1725321600"; 
   d="scan'208";a="29844263"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 20:56:02 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:33215]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.223:2525] with esmtp (Farcaster)
 id 117951e0-3259-42a6-81b8-62fbb4680dbe; Tue, 1 Oct 2024 20:56:01 +0000 (UTC)
X-Farcaster-Flow-ID: 117951e0-3259-42a6-81b8-62fbb4680dbe
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 1 Oct 2024 20:56:01 +0000
Received: from 88665a182662.ant.amazon.com.com (10.94.36.92) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 1 Oct 2024 20:55:59 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next 5/5] ipv4: Trigger check_lifetime() only when necessary.
Date: Tue, 1 Oct 2024 13:55:51 -0700
Message-ID: <20241001205551.13350-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANn89iLhKGoRgxQPm66NfMSWmjQg+Df1oUt9xt5wQnLOxXAWpQ@mail.gmail.com>
References: <CANn89iLhKGoRgxQPm66NfMSWmjQg+Df1oUt9xt5wQnLOxXAWpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Tue, 1 Oct 2024 11:27:18 +0200
> On Tue, Oct 1, 2024 at 4:51 AM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > DHCP is unlikely to be used in non-root network namespaces, and GC is
> > unnecessary in such cases.
> >
> > Let's count the number of non-permanent IPv4 addresses and schedule GC
> > only when the count is not zero.
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> 
> I find this a bit distracting honestly.
> 
> Lets focus on RTNL first, there are already a lot of reviews.

Sure, will keep this in a local post-conversion branch.

I'll post v2 with patch 1-4 + tags and Sparse warning (__force u32) fixed.

Thanks!

