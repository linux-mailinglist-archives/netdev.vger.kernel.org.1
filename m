Return-Path: <netdev+bounces-132235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 037C79910E2
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EB4C1F22D5B
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 20:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEE6231CBD;
	Fri,  4 Oct 2024 20:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Mk2vEls8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D781ADFE5
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 20:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728075082; cv=none; b=qzDA6r54+qHIJAQBxZu7njtGGPnGwrAojcEtEo+EVhS891fBGFdrPwUtKGCgGt9Ehjxl/kgeo422fYhTAfubHVwvS30CA9oR57ONgL3jatcnEoPuH8IFj5QyW8vUYNYZbwncCFObRMWNlAv8EbEJMAI7FtG2+e9RRJKrDEO5nS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728075082; c=relaxed/simple;
	bh=vKYrBh7WcJ159Ro2ZwY6RbOl5UCt6E1rLXSjENYKdco=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bvk+Qgj1z51OBeYpA2RDGN7wdkAlHG1LFEHlAzHdLGbCsZqQ0M9AlPX08WON5ETqXdxhtpmk0XI7deYCdULohNzeoFp5sv76rYLjGehyk38CXG3ln9QTZSZ5AIlQKN9Zoag0DpvqoNc9VBp0G2vunQnMA4OJXgR0jXRSFsD8XjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Mk2vEls8; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728075081; x=1759611081;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2oTj0WdsLdx2KMt8EyFLEzLkJY01+/mj8xuPj5RXHi8=;
  b=Mk2vEls8mtV6ZE1TukP5M6Ts8K134Kwin6XXV+2EqA/u8IXM1+8wHFx5
   sNyV6uxnq73IMbgP5nu8zr0BKkJC83ISXB/PPlXi6LlkApgGgi70bjTsW
   m4orElw1W+uRQew+tnKbfniBByKqg9L/gCgHRUMHs128zdckQkXvV6FkI
   M=;
X-IronPort-AV: E=Sophos;i="6.11,178,1725321600"; 
   d="scan'208";a="373135624"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 20:51:14 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:48022]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.158:2525] with esmtp (Farcaster)
 id 9563c8fb-9eff-41ab-9bf7-5f8f46b47bd7; Fri, 4 Oct 2024 20:51:14 +0000 (UTC)
X-Farcaster-Flow-ID: 9563c8fb-9eff-41ab-9bf7-5f8f46b47bd7
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 4 Oct 2024 20:51:14 +0000
Received: from 88665a182662.ant.amazon.com (10.88.184.239) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 4 Oct 2024 20:51:12 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuniyu@amazon.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v2 net-next 2/4] rtnetlink: Add per-netns RTNL.
Date: Fri, 4 Oct 2024 13:51:04 -0700
Message-ID: <20241004205104.69430-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241004204526.68765-1-kuniyu@amazon.com>
References: <20241004204526.68765-1-kuniyu@amazon.com>
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

From: Kuniyuki Iwashima <kuniyu@amazon.com>
Date: Fri, 4 Oct 2024 13:45:26 -0700
> From: Jakub Kicinski <kuba@kernel.org>
> Date: Fri, 4 Oct 2024 13:21:45 -0700
> > On Wed, 2 Oct 2024 08:12:38 -0700 Kuniyuki Iwashima wrote:
> > > +#ifdef CONFIG_DEBUG_NET_SMALL_RTNL
> > > +void __rtnl_net_lock(struct net *net);
> > > +void __rtnl_net_unlock(struct net *net);
> > > +void rtnl_net_lock(struct net *net);
> > > +void rtnl_net_unlock(struct net *net);
> > > +int rtnl_net_lock_cmp_fn(const struct lockdep_map *a, const struct lockdep_map *b);
> > > +#else
> > > +#define __rtnl_net_lock(net)
> > > +#define __rtnl_net_unlock(net)
> > > +#define rtnl_net_lock(net) rtnl_lock()
> > > +#define rtnl_net_unlock(net) rtnl_unlock()
> > 
> > Let's make sure net is always evaluated?
> > At the very least make sure the preprocessor doesn't eat it completely
> > otherwise we may end up with config-dependent "unused variable"
> > warnings down the line.
> 
> Sure, what comes to mind is void casting, which I guess is old-school
> style ?  Do you have any other idea or is this acceptable ?
> 
> #define __rtnl_net_lock(net) (void)(net)
> #define __rtnl_net_unlock(net) (void)(net)
> #define rtnl_net_lock(net)	\
> 	do {			\
> 		(void)(net);	\
> 		rtnl_lock();	\
> 	} while (0)
> #define rtnl_net_unlock(net)	\
> 	do {			\
> 		(void)(net);	\
> 		rtnl_unlock();	\
> 	} while (0)

or simply define these as static inline functions and
probably this is more preferable ?

static inline void __rtnl_net_lock(struct net *net) {}
static inline void __rtnl_net_unlock(struct net *net) {}
static inline void rtnl_net_lock(struct net *net)
{
	rtnl_lock();
}
static inline void rtnl_net_unlock(struct net *net)
{
	rtnl_unlock();
}

