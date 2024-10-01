Return-Path: <netdev+bounces-131042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA26798C6FC
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 22:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25BC9283C6F
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E678A19AA6B;
	Tue,  1 Oct 2024 20:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jnwCU3Le"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22724194A43
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 20:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727815746; cv=none; b=rxGWWsnGd0Q7Ehw197PTcekMn8EBgrP3JtWDW91n/XtviAaxi+aqKkG4QFJ9Ibf9t/zZDbAKYd/Wy9qjsv5k5dyl5Ojp58H9kzpxqMIR2QWfcEtFe3qY6csFj9Wj6GxYMyJNV9Mzdpp2+Lpkc5yp90ON/46zv47ZInX9LOIgyHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727815746; c=relaxed/simple;
	bh=ulBT/j9KMlAT3xomXI/DmyZFIftVbf5+NOQN23P6TLQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YaaeBp8OI0ivYVXMUgh/BwqYMC9a2enBehqtpDxi0YsXcpP3No1MhnyHBoRdfnuzhoDxlqdD4eULJlW+JstyrOS6JTIZvo7E+K8IZvCVdThsnwz1DlkTv3UthxheNeZ7nWqrAtJxR3USjNCt1bsM4KlBqRD5auw222nHJOGiM1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=jnwCU3Le; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727815745; x=1759351745;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aufiZUo0Yv0OLYPb4zkJ+2yRaXLeNNCbe7US7hdH4RM=;
  b=jnwCU3LeFO6XgLPdNceBvH2tvSVVmIC1PVeJcKyhYazAnkEknpuOCz0P
   x60rWutALw2tcn5DaSPgIedZvpcy77ils+VeKx3nsbqpexb7Y/u1LWiF9
   RdLqhessPBx9hxoBDAUMAt6BkFcmU4V4GXPEsCsXfJEFjO7UjB7w7553T
   4=;
X-IronPort-AV: E=Sophos;i="6.11,169,1725321600"; 
   d="scan'208";a="662953861"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 20:49:01 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:51933]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.18:2525] with esmtp (Farcaster)
 id 7d169dee-6d86-41c6-be1c-542157a28984; Tue, 1 Oct 2024 20:49:00 +0000 (UTC)
X-Farcaster-Flow-ID: 7d169dee-6d86-41c6-be1c-542157a28984
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 1 Oct 2024 20:49:00 +0000
Received: from 88665a182662.ant.amazon.com.com (10.94.36.92) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 1 Oct 2024 20:48:57 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next 1/3] rtnetlink: Add per-net RTNL.
Date: Tue, 1 Oct 2024 13:48:49 -0700
Message-ID: <20241001204849.11878-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANn89i+KoYzUH+VPLdGmLABYf5y4TW0hrM4UAeQQJ9AREty0iw@mail.gmail.com>
References: <CANn89i+KoYzUH+VPLdGmLABYf5y4TW0hrM4UAeQQJ9AREty0iw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D042UWB001.ant.amazon.com (10.13.139.160) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Tue, 1 Oct 2024 14:18:39 +0200
> On Mon, Sep 30, 2024 at 10:27 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > The goal is to break RTNL down into per-net mutex.
> >
> > This patch adds per-net mutex and its helper functions, rtnl_net_lock()
> > and rtnl_net_unlock().
> >
> > rtnl_net_lock() acquires the global RTNL and per-net RTNL mutex, and
> > rtnl_net_unlock() releases them.
> >
> > We will replace 800+ rtnl_lock() instances with rtnl_net_lock() and
> > finally removes rtnl_lock() in rtnl_net_lock().
> >
> > When we need to nest per-net RTNL mutex, we will use __rtnl_net_lock(),
> > and its locking order is defined by rtnl_net_lock_cmp_fn() as follows:
> >
> >   1. init_net is first
> >   2. netns address ascending order
> >
> > Note that the conversion will be done under CONFIG_DEBUG_NET_SMALL_RTNL
> > with LOCKDEP so that we can carefully add the extra mutex without slowing
> > down RTNL operations during conversion.
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  include/linux/rtnetlink.h   | 13 +++++++++
> >  include/net/net_namespace.h |  4 +++
> >  net/Kconfig.debug           | 14 +++++++++
> >  net/core/net_namespace.c    |  6 ++++
> >  net/core/rtnetlink.c        | 58 +++++++++++++++++++++++++++++++++++++
> >  5 files changed, 95 insertions(+)
> >
> > diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
> > index a7da7dfc06a2..c4afe6c49651 100644
> > --- a/include/linux/rtnetlink.h
> > +++ b/include/linux/rtnetlink.h
> > @@ -49,6 +49,19 @@ extern bool refcount_dec_and_rtnl_lock(refcount_t *r);
> >
> >  DEFINE_LOCK_GUARD_0(rtnl, rtnl_lock(), rtnl_unlock())
> 
> We probably should revert 464eb03c4a7c ("rtnetlink: add guard for
> RTNL") because I doubt
> this will ever be used once we have a per-netns rtnl.

Agreed, and there's no user for now.
I'll include the revert in v2.

Thanks!

