Return-Path: <netdev+bounces-182421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C533A88AEF
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 20:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9832A1898E66
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA4B28A1FE;
	Mon, 14 Apr 2025 18:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WKH4PPKH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672798633F;
	Mon, 14 Apr 2025 18:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744655034; cv=none; b=hX2awf5/4YsdknQd5kSlGspXBViFSJIbuJKEQPzQ6cqE4GfsM7Hvq7YVreeRY9upm8fcvdCuEc+9ucb9LZL4/9S4Z80fCFDEUbhTNu5MFzrhHvmest22ipjKLbqZUpEpvciAvZKSC8M1zHh5u5H0mew1AELwXWmytrFwWssSlpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744655034; c=relaxed/simple;
	bh=KSk3pf6yvHLBa6HbTYmMFS75XNwn1IeafE/Yu5MtkF0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LY3k2QoCgdp/a6eWvY3Zcxjvi3VeaNXIWmSsoGGyGKKVE/m94uCm1vCZAXmCRDDSu5VJyac7vVnzZakcIecqjXJC0wGcUwxuWfUEp/7hPw4TRRVBuLMfkcB2HF0toC8TDix8+IdK+4LUe/UT3DQnXFuirwrJ97bzt0NNKN9kOxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=WKH4PPKH; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744655033; x=1776191033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GcuQoyS+g/0y3EWLzFiMIl8lx+E4IYlu2kyG5duepdI=;
  b=WKH4PPKHzOoFFlH8V0OQe6WOsqOhO/71SgCV4fAztpy4m4tHzFbjOkJW
   wfYI2auzIzmlV0ugo8p1dEpHX95+Nc+YAc3CVCDlGQEgZxYrhrgEYxjta
   r/IVJF9tq1ong5ba+khLxx1fRoOuCh09fOVe95NxFa6Iu9/Z2ewnuJ1tI
   g=;
X-IronPort-AV: E=Sophos;i="6.15,212,1739836800"; 
   d="scan'208";a="191019357"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 18:23:52 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:62512]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.147:2525] with esmtp (Farcaster)
 id e3a07f74-3bc3-4e7c-ac23-d931384f29e3; Mon, 14 Apr 2025 18:23:52 +0000 (UTC)
X-Farcaster-Flow-ID: e3a07f74-3bc3-4e7c-ac23-d931384f29e3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 18:23:52 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 18:23:49 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <cratiu@nvidia.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <sdf@fomichev.me>,
	<syzbot+de1c7d68a10e3f123bdd@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [net?] general protection fault in rtnl_create_link
Date: Mon, 14 Apr 2025 11:23:27 -0700
Message-ID: <20250414182341.31191-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414111536.6d6493f1@kernel.org>
References: <20250414111536.6d6493f1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA004.ant.amazon.com (10.13.139.56) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 14 Apr 2025 11:15:36 -0700
> On Mon, 14 Apr 2025 11:01:59 -0700 Kuniyuki Iwashima wrote:
> > From: Jakub Kicinski <kuba@kernel.org>
> > Date: Mon, 14 Apr 2025 10:37:27 -0700
> > > On Sun, 13 Apr 2025 19:30:46 -0700 Kuniyuki Iwashima wrote:  
> > > > diff --git a/include/net/netdev_lock.h b/include/net/netdev_lock.h
> > > > index 5706835a660c..270e157a4a79 100644
> > > > --- a/include/net/netdev_lock.h
> > > > +++ b/include/net/netdev_lock.h
> > > > @@ -30,7 +30,8 @@ static inline bool netdev_need_ops_lock(const struct net_device *dev)
> > > >  	bool ret = dev->request_ops_lock || !!dev->queue_mgmt_ops;
> > > >  
> > > >  #if IS_ENABLED(CONFIG_NET_SHAPER)
> > > > -	ret |= !!dev->netdev_ops->net_shaper_ops;
> > > > +	if (dev->netdev_ops)
> > > > +		ret |= !!dev->netdev_ops->net_shaper_ops;
> > > >  #endif  
> > > 
> > > This is a bit surprising, we pretty much never validate if dev has ops.
> > > 
> > > I think we're guaranteed that IFF_UP will not be set if we just
> > > allocated the device, so we can remove the locks in rtnl_create_link()
> > > and to double confirm add a netdev_ops_assert_locked_or_invisible() 
> > > in netif_state_change() ?  
> > 
> > Removing the lock from NEWLINK makes sense, but my concern
> > was NETDEV_CHANGE, which will requires more caution ?
> > 
> > commit 04efcee6ef8d0f01eef495db047e7216d6e6e38f
> > Author: Stanislav Fomichev <sdf@fomichev.me>
> > Date:   Fri Apr 4 09:11:22 2025 -0700
> > 
> >     net: hold instance lock during NETDEV_CHANGE
> 
> How could we fire a notifier for a device that hasn't been initialized,
> let alone registered?

Ah, now got it.  Exactly, we won't trigger NETDEV_CHANGE in the path,
rtnl_configure_link() is the place where IFF_UP is flagged later also
under the ops lock.


> 
> I'm hoping that the _or_invisible assert in my suggestion will flag to
> future developers trying to change netif_state_change() that the device
> here may not be fully constructed.

Totally agree now.

