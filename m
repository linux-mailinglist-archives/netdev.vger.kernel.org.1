Return-Path: <netdev+bounces-165967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21279A33D01
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 11:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC65C169616
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 10:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655FB2139C7;
	Thu, 13 Feb 2025 10:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Mi6TSQLO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF6E2135C0;
	Thu, 13 Feb 2025 10:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739443958; cv=none; b=TeL/WuPQ9ucNuejySdio6iwnHzz4q4c8T59mJyy40pW/3M4ylUznhzmXC/kHZrsxVPRiACgwv80ehy6/MlS7jr8H+cR3mpRr4XpP3zsy+N76WEQ3kkS29UwEvAVVv8AAJc2hCpFqxPeSQwJQQfP53jGUuq/Bh9SqQouD71mFc28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739443958; c=relaxed/simple;
	bh=ly+HI5iL3ovE/Qp0+AEPxYcJXgikpZNZ61yNY81pso0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=orujBMxvzzfgmBbv1JKUnk0BNSTHiW8C1AbIU+hJejMEZAHZJo9ECBRRSCuUdnJIMdZjSQt4V3S/C0+/FSNDrJjbxaDb3M526O/HS5EZE0VkdofY9wwrx8yH/7kcRCznzgtuQ4jKMn73K2qBdsYHvsbFWXUtnQefRHwTMgq6dE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Mi6TSQLO; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739443957; x=1770979957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IgkvtMvOSSagKNz50Lh9hAQXzCe7woRbEqIyJBXRz38=;
  b=Mi6TSQLOk26Z7SPnCQffJxy+SBK9oNUmxyfB4aVl6AWweJwH6bEkzsUy
   8QDIEmA1HxrnMXlowNRV3VDIeZWjEP5TgkCeFOfx4ESny/DmvnB+9A2P8
   WAvrkEFUU6t3PBlU8NGPxro4+wodN+iCyHH1EDzs/9vRCiJgV1V/EfIlp
   Q=;
X-IronPort-AV: E=Sophos;i="6.13,282,1732579200"; 
   d="scan'208";a="270834013"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 10:52:33 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:32225]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.9.187:2525] with esmtp (Farcaster)
 id 0f73d3cd-62b2-4599-a33c-974a909bd3bb; Thu, 13 Feb 2025 10:52:32 +0000 (UTC)
X-Farcaster-Flow-ID: 0f73d3cd-62b2-4599-a33c-974a909bd3bb
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 13 Feb 2025 10:52:31 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Feb 2025 10:52:26 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <leitao@debian.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <horms@kernel.org>, <kernel-team@meta.com>,
	<kuba@kernel.org>, <kuniyu@amazon.co.jp>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <ushankar@purestorage.com>
Subject: Re: [PATCH net-next v3 2/3] net: Add dev_getbyhwaddr_rtnl() helper
Date: Thu, 13 Feb 2025 19:52:17 +0900
Message-ID: <20250213105217.37429-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250213-prudent-olivine-bobcat-ffa64f@leitao>
References: <20250213-prudent-olivine-bobcat-ffa64f@leitao>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB003.ant.amazon.com (10.13.138.8) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Breno Leitao <leitao@debian.org>
Date: Thu, 13 Feb 2025 02:29:38 -0800
> Hello Kuniyuki,
> 
> On Thu, Feb 13, 2025 at 04:31:29PM +0900, Kuniyuki Iwashima wrote:
> > > Subject: [PATCH net-next v3 2/3] net: Add dev_getbyhwaddr_rtnl() helper
> > 
> > s/_rtnl//
> 
> Ack!
> 
> > looks like Uday's comment was missed due to the lore issue.
> 
> hmm, I haven't seen Uday's comment. Didn't it reach lore?

I saw the reply and my another one on lore but somehow they
were removed :)


> 
> > From: Breno Leitao <leitao@debian.org>
> > Date: Wed, 12 Feb 2025 09:47:25 -0800
> > > +/**
> > > + *	dev_getbyhwaddr - find a device by its hardware address
> > 
> > While at it, could you replace '\t' after '*' to a single '\s'
> > for all kernel-doc comment lines below ?
> > 
> > 
> > > + *	@net: the applicable net namespace
> > > + *	@type: media type of device
> > > + *	@ha: hardware address
> > > + *
> > > + *	Similar to dev_getbyhwaddr_rcu(), but the owner needs to hold
> > > + *	rtnl_lock.
> > 
> > Otherwise the text here is mis-aligned.
> 
> Sorry, what is misaligned specifically? I generated the documentation,
> and I can't see it misaligned.
> 
> This is what I see when generating the document (full log at
> https://pastebin.mozilla.org/YkotEoHh#L250,271)
> 
> 
> 	dev_getbyhwaddr_rcu(9)                                                         Kernel Hacker's Manual                                                         dev_getbyhwaddr_rcu(9)
> 
> 	NAME
> 	dev_getbyhwaddr_rcu - find a device by its hardware address
> 
> 	SYNOPSIS
> 	struct net_device * dev_getbyhwaddr_rcu (struct net *net , unsigned short type , const char *ha );
> 
> 	ARGUMENTS
> 	net         the applicable net namespace
> 
> 	type        media type of device
> 
> 	ha          hardware address
> 
> 			Search for an interface by MAC address. Returns NULL if the device is not found or a pointer to the device.  The caller must hold RCU.  The returned  device  has
                        ^^^^^^
This scentence starts from a weird position when we use '\t' after '*'.
You will see it start from the head if '\s' follows '*'.


> 			not had its ref count increased and the caller must therefore be careful about locking
> 
> 	RETURN
> 	pointer to the net_device, or NULL if not found
> 
> 	dev_getbyhwaddr(9)                                                             Kernel Hacker's Manual                                                             dev_getbyhwaddr(9)
> 
> 	NAME
> 	dev_getbyhwaddr - find a device by its hardware address
> 
> 	SYNOPSIS
> 	struct net_device * dev_getbyhwaddr (struct net *net , unsigned short type , const char *ha );
> 
> 	ARGUMENTS
> 	net         the applicable net namespace
> 
> 	type        media type of device
> 
> 	ha          hardware address
> 
> 			Similar to dev_getbyhwaddr_rcu, but the owner needs to hold rtnl_lock.
> 
> 	RETURN
> 	pointer to the net_device, or NULL if not found
> 
> 
> >   $ ./scripts/kernel-doc -man net/core/dev.c | \
> >     scripts/split-man.pl /tmp/man && \
> >     man /tmp/man/dev_getbyhwaddr.9
> > 
> > Also, the latter part should be in Context:
> > 
> > Context: rtnl_lock() must be held.
> 
> Sure. Should I do something similar for _rcu function as well?
> 
> 	Context: caller must hold rcu_read_lock

Yes, that would be nice.

https://lore.kernel.org/netdev/20250213073646.14847-1-kuniyu@amazon.com/

