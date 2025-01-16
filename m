Return-Path: <netdev+bounces-158736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2C9A13194
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 03:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7C323A110E
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 02:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1207C45948;
	Thu, 16 Jan 2025 02:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="f8Xp5rc+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710E814F9FB
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 02:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736996099; cv=none; b=T/86dgMomkjm3kwMWZFkYUOtnguR+pe0T1sswok+SnpPV0kvfq3WMI7HW2IJyra+bD5fyVeAzZ8+lIjpzBrJB6OS4kvbs8H0kVoRwsNgRGWRcALTK4RE3Z1PYMjiTp6FZo5Embx7Xz+FrtHzkVI0I4OPI9kcrZruHn2zm6ObGUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736996099; c=relaxed/simple;
	bh=JA0DmeHfWf2kW0E516hUkA3wkbgZTPA79bhKfbL9oQQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mznhoAPeVnH3HokFs1J3XlcZ7WqKkWila+VT7OvOKx2D8jWPa6+hq6bF98af5CNHQbwY9CDlUVDy+KonrV3x9S++KjwFb6SWlvNmHXOAwsqopS4fErkVrbkm5MHKQvyBCiRl2/gzn789PNO+YNjTOd+bcrPc2pLnXfwozIPWiqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=f8Xp5rc+; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736996095; x=1768532095;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HunarVt3IL8PqvyN0I76Y3i/1GJm1RMYOrnNYYGbzXA=;
  b=f8Xp5rc+aQz1jI0LOzG0ePBzSpW6wYAcYMMmNBhk/lU8TaVANiWJZ4Np
   CrtuztxgJqVRx8NGkNr8a/Crui3Kg0YvNNEqGWE25O9lwWZcaKM8RJiuu
   rNTx/jsSHjCsBv8o4/tnNuSFdz/W2vsGH6jM8hU5HtVLo3uK4PnMh7iNH
   M=;
X-IronPort-AV: E=Sophos;i="6.13,208,1732579200"; 
   d="scan'208";a="486338448"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 02:54:49 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:20577]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.209:2525] with esmtp (Farcaster)
 id 272de5bf-bf43-4b03-8e8a-aa07065eeade; Thu, 16 Jan 2025 02:54:48 +0000 (UTC)
X-Farcaster-Flow-ID: 272de5bf-bf43-4b03-8e8a-aa07065eeade
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 16 Jan 2025 02:54:47 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.2.246) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 16 Jan 2025 02:54:44 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <ychemla@nvidia.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next 4/4] net: Hold rtnl_net_lock() in (un)?register_netdevice_notifier_dev_net().
Date: Thu, 16 Jan 2025 11:54:35 +0900
Message-ID: <20250116025435.85541-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <146eabfe-123c-4970-901e-e961b4c09bc3@nvidia.com>
References: <146eabfe-123c-4970-901e-e961b4c09bc3@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB004.ant.amazon.com (10.13.138.84) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Thanks for the report!

From: Yael Chemla <ychemla@nvidia.com>
Date: Thu, 16 Jan 2025 00:16:27 +0200
> we observed in our regression tests the following issue:
> 
> BUG: KASAN: slab-use-after-free in notifier_call_chain+0x22c/0x280
> kasan_report+0xbd/0xf0
> RIP: 0033:0x7f70839018b7
> kasan_save_stack+0x1c/0x40
> kasan_save_track+0x10/0x30
> __kasan_kmalloc+0x83/0x90
> kasan_save_stack+0x1c/0x40
> kasan_save_track+0x10/0x30
> kasan_save_free_info+0x37/0x50
> __kasan_slab_free+0x33/0x40
> page dumped because: kasan: bad access detected
> BUG: KASAN: slab-use-after-free in notifier_call_chain+0x222/0x280
> kasan_report+0xbd/0xf0
> RIP: 0033:0x7f70839018b7
> kasan_save_stack+0x1c/0x40
> kasan_save_track+0x10/0x30
> __kasan_kmalloc+0x83/0x90
> kasan_save_stack+0x1c/0x40
> kasan_save_track+0x10/0x30
> kasan_save_free_info+0x37/0x50
> __kasan_slab_free+0x33/0x40
> page dumped because: kasan: bad access detected
> 
> and there are many more of that kind.

Do you have any other stack traces with more callers info ?
Also can you decode the trace with ./scripts/decode_stacktrace.sh ?

> 
> it happens after applying commit 7fb1073300a2 ("net: Hold 
> rtnl_net_lock() in (un)?register_netdevice_notifier_dev_net()")
> 
> test scenario includes configuration and traffic over two namespaces 
> associated with two different VFs.

Could you elaborate more about the test scenario, especially
how each device/netns is dismantled after the test case ?

I guess the VF is moved to init_net ?

> 
> 
> On 04/01/2025 8:37, Kuniyuki Iwashima wrote:
> > (un)?register_netdevice_notifier_dev_net() hold RTNL before triggering
> > the notifier for all netdev in the netns.
> > 
> > Let's convert the RTNL to rtnl_net_lock().
> > 
> > Note that move_netdevice_notifiers_dev_net() is assumed to be (but not
> > yet) protected by per-netns RTNL of both src and dst netns; we need to
> > convert wireless and hyperv drivers that call dev_change_net_namespace().
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >   net/core/dev.c | 16 ++++++++++------
> >   1 file changed, 10 insertions(+), 6 deletions(-)
> > 
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index f6c6559e2548..a0dd34463901 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -1943,15 +1943,17 @@ int register_netdevice_notifier_dev_net(struct net_device *dev,
> >   					struct notifier_block *nb,
> >   					struct netdev_net_notifier *nn)
> >   {
> > +	struct net *net = dev_net(dev);
> 
> it seems to happen since the net pointer is acquired here without a lock.
> Note that KASAN issue is not triggered when executing with rtnl_lock() 
> taken before this line. and our kernel .config expands 
> rtnl_net_lock(net) to rtnl_lock() (CONFIG_DEBUG_NET_SMALL_RTNL is not set).

It sounds like the device was being moved to another netns while
unregister_netdevice_notifier_dev_net() was called.

Could you check if dev_net() is changed before/after rtnl_lock() in

  * register_netdevice_notifier_dev_net()
  * unregister_netdevice_notifier_dev_net()

?

