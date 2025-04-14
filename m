Return-Path: <netdev+bounces-182406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF343A88ADC
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 20:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9767B1746F3
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC19B28B50C;
	Mon, 14 Apr 2025 18:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGO+gefx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0F428466C;
	Mon, 14 Apr 2025 18:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744654538; cv=none; b=YdwZhEj0LowFLKNiPmJuUTwSTb+XGhAYcB3FjGEpoNt9PQBwpSjXUQmOeYEK2vwRs76LpJj60Uu1tM+9zUscVd5F47zsC4zj1omuFsm3/rKqGZCODL+RdxRrVqzGb6CWAuEpxM6NMsuLzguUPJMTO5qs0ydXH/HDd0FbUyQvXK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744654538; c=relaxed/simple;
	bh=PAL6Fdin15ZsYYISJz3KRiYem+ZfqDMCAM39+28DJTo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t7Tky3D9P1XpOaCHgfy3EMDH/2eSBynIw8OjoY+dpdXwS1hsiNr1C0X8OCaHYBCv77Grv/w6opL3fKBH6fqJ/t4Bpkfl/1/Ahx7svLoARafNmG4AErBeCDw3PRGzQihvvBCd97Ve/Qz9RZPbILJdsY/CLlESmGP5gAHrC+TV2vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGO+gefx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA19C4CEE5;
	Mon, 14 Apr 2025 18:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744654538;
	bh=PAL6Fdin15ZsYYISJz3KRiYem+ZfqDMCAM39+28DJTo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fGO+gefxTykAXxVmbAHAthGqtbgISn4JDy/pM0b8+8AyL3wLnIhk2GD1mIZlQm63f
	 dqZmW8HUF2e0w+jLqKhYMx0JbmmMVMbRgcG2Lp3mitSKf6m+PU0ZQswcTaa/zIViMt
	 EZXpUTpbafzYFQ7yaSS/UcUliHk40EdzjrjBsd5+kRPG5e3jmh0QacAngkkQsdWry8
	 6eA2F9LlY9+KFnLpIlytULgk8ERUdndF08myN9I1Gag1TNHA7Sfaek7nphUqu3XT53
	 Lhd3yF7zdPH5ujaFL0m7lTCu5pueZzHD090IcCaba1xiIwrACtlZ50b5KmwKvKS8cn
	 3nlTnx8u5Fjtg==
Date: Mon, 14 Apr 2025 11:15:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: <cratiu@nvidia.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <horms@kernel.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <pabeni@redhat.com>, <sdf@fomichev.me>,
 <syzbot+de1c7d68a10e3f123bdd@syzkaller.appspotmail.com>,
 <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [net?] general protection fault in rtnl_create_link
Message-ID: <20250414111536.6d6493f1@kernel.org>
In-Reply-To: <20250414180257.24176-1-kuniyu@amazon.com>
References: <20250414103727.0ea92049@kernel.org>
	<20250414180257.24176-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Apr 2025 11:01:59 -0700 Kuniyuki Iwashima wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> Date: Mon, 14 Apr 2025 10:37:27 -0700
> > On Sun, 13 Apr 2025 19:30:46 -0700 Kuniyuki Iwashima wrote:  
> > > diff --git a/include/net/netdev_lock.h b/include/net/netdev_lock.h
> > > index 5706835a660c..270e157a4a79 100644
> > > --- a/include/net/netdev_lock.h
> > > +++ b/include/net/netdev_lock.h
> > > @@ -30,7 +30,8 @@ static inline bool netdev_need_ops_lock(const struct net_device *dev)
> > >  	bool ret = dev->request_ops_lock || !!dev->queue_mgmt_ops;
> > >  
> > >  #if IS_ENABLED(CONFIG_NET_SHAPER)
> > > -	ret |= !!dev->netdev_ops->net_shaper_ops;
> > > +	if (dev->netdev_ops)
> > > +		ret |= !!dev->netdev_ops->net_shaper_ops;
> > >  #endif  
> > 
> > This is a bit surprising, we pretty much never validate if dev has ops.
> > 
> > I think we're guaranteed that IFF_UP will not be set if we just
> > allocated the device, so we can remove the locks in rtnl_create_link()
> > and to double confirm add a netdev_ops_assert_locked_or_invisible() 
> > in netif_state_change() ?  
> 
> Removing the lock from NEWLINK makes sense, but my concern
> was NETDEV_CHANGE, which will requires more caution ?
> 
> commit 04efcee6ef8d0f01eef495db047e7216d6e6e38f
> Author: Stanislav Fomichev <sdf@fomichev.me>
> Date:   Fri Apr 4 09:11:22 2025 -0700
> 
>     net: hold instance lock during NETDEV_CHANGE

How could we fire a notifier for a device that hasn't been initialized,
let alone registered?

I'm hoping that the _or_invisible assert in my suggestion will flag to
future developers trying to change netif_state_change() that the device
here may not be fully constructed.

