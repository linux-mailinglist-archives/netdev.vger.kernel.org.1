Return-Path: <netdev+bounces-161573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA94DA2273C
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 01:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38C82188654E
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 00:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF78A4689;
	Thu, 30 Jan 2025 00:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="OJKgWa3A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5EFEBE
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 00:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738197154; cv=none; b=qMVRBUrb5+S8tsio5qU13f9eoM2VLwy5dnm/E58ua9IsYO3Yo0DMv/YGgNordSdny0uBIKmDDIyT0aeu1QOItcbwv5xHKZ/cYJYu6tsQDkhdlLGfXi9LQaEGZtheDHT/8RPY0G5CTZUuroFL9ehOItKzzr33hS9YUcveT1wywIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738197154; c=relaxed/simple;
	bh=uI06xLhHzV0pl2JhsCZue+dSx8MXABSOgoIr/AP7OPw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CXI/2elME7PJqLDi1gKnFFq18UghbwoE+Xi5h5Cu/elNlFengpXoauyhkW6icqHOMoA71WxIcyhBhJaizZGwmsf1Cv7x8n23D+JhsCoxRLAUo8w7NNxBcQF4yEIrEyatYRD3btIoiw22wat9K2szqCodKZPPuzGqKuWiDoNq1Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=OJKgWa3A; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738197154; x=1769733154;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xvAala6b5T0+i+dHbM4WchSrERDL4oU+/9qWLpPJWDc=;
  b=OJKgWa3A1GHCYdeojy+5dQC3ZVGslMXj6k6D23354oL8VbGANDerNjZz
   xw9KTdfGf44Xsvtv8ZByluKeVSDGM+0waNnCTomJN5WAg7yVKZ2/k5P56
   Eh3ALEJvdOS94Ft+6J4WAwIPmnE3Z/o8ULqVcVlrWnAQgbv9OZODhXUCM
   I=;
X-IronPort-AV: E=Sophos;i="6.13,244,1732579200"; 
   d="scan'208";a="462617673"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 00:32:30 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:46771]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.242:2525] with esmtp (Farcaster)
 id 64dc052b-c841-4a3f-8696-063bf31030b6; Thu, 30 Jan 2025 00:32:29 +0000 (UTC)
X-Farcaster-Flow-ID: 64dc052b-c841-4a3f-8696-063bf31030b6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 30 Jan 2025 00:32:28 +0000
Received: from 6c7e67bfbae3.amazon.com (10.88.186.76) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 30 Jan 2025 00:32:26 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <ychemla@nvidia.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next 4/4] net: Hold rtnl_net_lock() in (un)?register_netdevice_notifier_dev_net().
Date: Wed, 29 Jan 2025 16:32:18 -0800
Message-ID: <20250130003218.69951-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <049d3a80-1b51-4796-83df-efb80f3b3107@nvidia.com>
References: <049d3a80-1b51-4796-83df-efb80f3b3107@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D038UWC002.ant.amazon.com (10.13.139.238) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Yael Chemla <ychemla@nvidia.com>
Date: Wed, 29 Jan 2025 18:21:23 +0200
> On 28/01/2025 1:26, Kuniyuki Iwashima wrote:
> > From: Yael Chemla <ychemla@nvidia.com>
> > Date: Mon, 20 Jan 2025 20:55:07 +0200
> >>>>> diff --git a/net/core/dev.c b/net/core/dev.c
> >>>>> index f6c6559e2548..a0dd34463901 100644
> >>>>> --- a/net/core/dev.c
> >>>>> +++ b/net/core/dev.c
> >>>>> @@ -1943,15 +1943,17 @@ int register_netdevice_notifier_dev_net(struct net_device *dev,
> >>>>>     					struct notifier_block *nb,
> >>>>>     					struct netdev_net_notifier *nn)
> >>>>>     {
> >>>>> +	struct net *net = dev_net(dev);
> >>>>
> >>>> it seems to happen since the net pointer is acquired here without a lock.
> >>>> Note that KASAN issue is not triggered when executing with rtnl_lock()
> >>>> taken before this line. and our kernel .config expands
> >>>> rtnl_net_lock(net) to rtnl_lock() (CONFIG_DEBUG_NET_SMALL_RTNL is not set).
> >>>
> >>> It sounds like the device was being moved to another netns while
> >>> unregister_netdevice_notifier_dev_net() was called.
> >>>
> >>> Could you check if dev_net() is changed before/after rtnl_lock() in
> >>>
> >>>     * register_netdevice_notifier_dev_net()
> >>>     * unregister_netdevice_notifier_dev_net()
> >>>
> >>> ?
> >>
> >> When checking dev_net before and after taking the lock the issue won’t
> >> reproduce.
> >> note that when issue reproduce we arrive to
> >> unregister_netdevice_notifier_dev_net with an invalid net pointer
> >> (verified it with prints of its value, and it's not the same consistent
> >> value as is throughout rest of the test).
> > 
> > Does an invalid net pointer means a dead netns pointer ?
> > dev_net() and dev_net_set() use rcu_dereference() and rcu_assign_pointer(),
> > so I guess it should not be an invalid address at least.
> > 
> I logged several values at the entrance of 
> unregister_netdevice_notifier_dev_net when issue reproduced:
> 1) fields of net->ns (struct ns_common):
> count: the namespace refcount is 0 (i.e. net->ns.count, used 
> refcount_read to read it).

This indicates here we race with cleanup_net().

> 
> inum: the value doesn't appear to be garbage but differ from its 
> constant value throughout the test.
> 
> 2) net pointer (struct net): value differ from its constant value 
> observed during the rest of the test.
> 
> hope this helps and please let me know if more info is needed.
> 
> > 
> >> we suspect the issue related to the async ns deletion.
> > 
> > I think async netns change would trigger the issue too.
> > 
> > Could you try this patch ?
> > 
> 
> I tested your patch and issue won't reproduce with it 
> (CONFIG_DEBUG_NET_SMALL_RTNL is not set in my config).
> 
> Tested-by: Yael Chemla <ychemla@nvidia.com>

Thanks for testing !

Will post the fix officially.

