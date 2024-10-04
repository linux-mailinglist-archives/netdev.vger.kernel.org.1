Return-Path: <netdev+bounces-132241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA01991143
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 23:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CCCD1C236D9
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 21:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2350F142E9F;
	Fri,  4 Oct 2024 21:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WSxCkO2V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587BC231CAC
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 21:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728076953; cv=none; b=KTVorbkZkPpTb4GCfKeJs5HFzeAIfCv2ea+TfdlDzoht6jQkNt9fNsN3hacP4vOckw5pG6i+DJumvjGU8XZaJgy4ABeAcfG9NIPu2Jywrsi+Hfh0aHfMkfzbex0lM/NlE0Y9HxRGi/KozQhuhmh+7WkVvy4i4SUP2N9a2/qi6Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728076953; c=relaxed/simple;
	bh=suKnQETI+W4UBL9cdeJ1pcVaGsu3jH1N9+ijBSqtUHI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a7Iua9IPy2djZulDv8r/d7D9znuQ3tNQko4UH5qFESdwCtQperAHuHSmFuamuELZriFAOsEev/FzkgCeXmE7D6WoDJ995XnUtyTIBIwIG8TtOaXvk9wE80zqOcvsnk7FP+yDdZBXYpMFBOO/dLbtRYGDySSkxdGVNO6zVDZ/aDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=WSxCkO2V; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728076951; x=1759612951;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QVi3OC1IaPDLEshXf7g3E971MxlqkX9yXreBXih7yuo=;
  b=WSxCkO2VPlfhxqpHN8n8wW/K4OzUldOrnhOCBQVhH+rZmTVnqlvka0oy
   VQbZvS4IP50djBPrtKA6O37YWbLyeifqhcuF7v/f6+AYPePSpMI6zXo4y
   8gnEPL6N7ApS16linprgbd2piqnzLL0xvb3QSDGTc7yEqfcOaymtqNsto
   c=;
X-IronPort-AV: E=Sophos;i="6.11,178,1725321600"; 
   d="scan'208";a="432692938"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 21:22:28 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:33937]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.158:2525] with esmtp (Farcaster)
 id e542688e-ec79-488b-ad3e-20658dfb7708; Fri, 4 Oct 2024 21:22:27 +0000 (UTC)
X-Farcaster-Flow-ID: e542688e-ec79-488b-ad3e-20658dfb7708
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 4 Oct 2024 21:22:27 +0000
Received: from 88665a182662.ant.amazon.com (10.88.184.239) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 4 Oct 2024 21:22:25 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v2 net-next 2/4] rtnetlink: Add per-netns RTNL.
Date: Fri, 4 Oct 2024 14:22:17 -0700
Message-ID: <20241004212217.73348-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANn89i+TbWXVMzzHYVWcyiO7rXnDWPMyuSK4g9=_YaX8qrC=QQ@mail.gmail.com>
References: <CANn89i+TbWXVMzzHYVWcyiO7rXnDWPMyuSK4g9=_YaX8qrC=QQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D033UWC004.ant.amazon.com (10.13.139.225) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 4 Oct 2024 22:59:32 +0200
> On Fri, Oct 4, 2024 at 10:51 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > From: Kuniyuki Iwashima <kuniyu@amazon.com>
> > Date: Fri, 4 Oct 2024 13:45:26 -0700
> > > From: Jakub Kicinski <kuba@kernel.org>
> > > Date: Fri, 4 Oct 2024 13:21:45 -0700
> > > > On Wed, 2 Oct 2024 08:12:38 -0700 Kuniyuki Iwashima wrote:
> > > > > +#ifdef CONFIG_DEBUG_NET_SMALL_RTNL
> > > > > +void __rtnl_net_lock(struct net *net);
> > > > > +void __rtnl_net_unlock(struct net *net);
> > > > > +void rtnl_net_lock(struct net *net);
> > > > > +void rtnl_net_unlock(struct net *net);
> > > > > +int rtnl_net_lock_cmp_fn(const struct lockdep_map *a, const struct lockdep_map *b);
> > > > > +#else
> > > > > +#define __rtnl_net_lock(net)
> > > > > +#define __rtnl_net_unlock(net)
> > > > > +#define rtnl_net_lock(net) rtnl_lock()
> > > > > +#define rtnl_net_unlock(net) rtnl_unlock()
> > > >
> > > > Let's make sure net is always evaluated?
> > > > At the very least make sure the preprocessor doesn't eat it completely
> > > > otherwise we may end up with config-dependent "unused variable"
> > > > warnings down the line.
> > >
> > > Sure, what comes to mind is void casting, which I guess is old-school
> > > style ?  Do you have any other idea or is this acceptable ?
> > >
> > > #define __rtnl_net_lock(net) (void)(net)
> > > #define __rtnl_net_unlock(net) (void)(net)
> > > #define rtnl_net_lock(net)    \
> > >       do {                    \
> > >               (void)(net);    \
> > >               rtnl_lock();    \
> > >       } while (0)
> > > #define rtnl_net_unlock(net)  \
> > >       do {                    \
> > >               (void)(net);    \
> > >               rtnl_unlock();  \
> > >       } while (0)
> >
> > or simply define these as static inline functions and
> > probably this is more preferable ?
> >
> > static inline void __rtnl_net_lock(struct net *net) {}
> > static inline void __rtnl_net_unlock(struct net *net) {}
> > static inline void rtnl_net_lock(struct net *net)
> > {
> >         rtnl_lock();
> > }
> > static inline void rtnl_net_unlock(struct net *net)
> > {
> >         rtnl_unlock();
> > }
> 
> static inline functions seem better to me.

Will use them.

Thanks !

