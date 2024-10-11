Return-Path: <netdev+bounces-134556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3159D99A113
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 12:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 280E41C23219
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 10:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8F5210C20;
	Fri, 11 Oct 2024 10:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDmNIIwU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0445B210C0F;
	Fri, 11 Oct 2024 10:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728641789; cv=none; b=mTaLMTJrom4iLxBaXZfMWPZzjF80fNwbEQLYxB4LcSA7PfrQxhLQH7CN1/YBrBPnYjGMyg2PcorNIpddbLZzP/i9Drp5wEIUTvL+Ftd0XUvdnVXe3gL6R9CPESKbIxWsUwp2tw3noxaltMqTCwglmzhU7ipw/F8WEaPgS4JKx9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728641789; c=relaxed/simple;
	bh=OqL0tve/win0Q01XpfcdOPbrxM8KlrftfppKY/6qiNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGFdBnEGAtfTPFbmPeAM4NShGucKIdlby6yFTgUoORYcBnBSb6NDdohmnohXznetJQOqlsqlSaboeJ2KxwYQVV6PLWApQ7Zkh8Mg4141KH0ON2bGxoaIiiTH9J/UMCfsFcKDap8wbbMvDSTQfT/+6w4xwq2+Cpgz8VGqAaTPDek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDmNIIwU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7FAC4CEC3;
	Fri, 11 Oct 2024 10:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728641787;
	bh=OqL0tve/win0Q01XpfcdOPbrxM8KlrftfppKY/6qiNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JDmNIIwUw1jgwgr5vFEXGkr1tpDkRuTQbxdLjxk5f76pXaIm+6XHqWP28oXaIl3Vu
	 BKA7j8D4GkhJZ0QwPaTSbHNhknMjxLoqt8zAqSRwzx4fFiAbQ3vsPqUPujT3X6pa6G
	 p6jnRKQoj1CAUXEiXZ0AuhYoT6FLfVcHgXjysdEFDtlFDbM9YqL2QR3TWAG/p2Cfcf
	 DWoKGaYUCYwPgTEgvCooUeysM2J/T1Alay+63wxuuk13m3DV8I5kteA28Ek/ZwE6SI
	 fC81DqgKpl0EfTrgxmh4udB385tOb9tZMC+mGUqzoUjqSNXSGppKvASm+AVL7uumHj
	 HQIrKhbdGfKDg==
Date: Fri, 11 Oct 2024 11:16:23 +0100
From: Simon Horman <horms@kernel.org>
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 3/4] ip6mr: Lock RCU before ip6mr_get_table() call
 in ip6mr_compat_ioctl()
Message-ID: <20241011101623.GF66815@kernel.org>
References: <20241010090741.1980100-2-stefan.wiehler@nokia.com>
 <20241010090741.1980100-7-stefan.wiehler@nokia.com>
 <20241010094130.GA1098236@kernel.org>
 <aa10d178-3421-4759-bac0-2b187255db6f@nokia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa10d178-3421-4759-bac0-2b187255db6f@nokia.com>

On Thu, Oct 10, 2024 at 04:43:34PM +0200, Stefan Wiehler wrote:
> >> When IPV6_MROUTE_MULTIPLE_TABLES is enabled, calls to ip6mr_get_table()
> >> must be done under RCU or RTNL lock. Copy from user space must be
> >> performed beforehand as we are not allowed to sleep under RCU lock.
> >>
> >> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
> >> Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")

...

> >> @@ -2004,11 +2020,13 @@ int ip6mr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
> >>                               return -EFAULT;
> >>                       return 0;
> >>               }
> >> -             rcu_read_unlock();
> >> -             return -EADDRNOTAVAIL;
> >> -     default:
> >> -             return -ENOIOCTLCMD;
> >> +             err = -EADDRNOTAVAIL;
> >> +             goto out;
> >>       }
> >> +
> > 
> > I think that this out label should be used consistently once rcu_read_lock
> > has been taken. With this patch applied there seems to be one case on error
> > where rcu_read_unlock() before returning, and one case where it isn't
> > (which looks like it leaks the lock).
> 
> In the remaining two return paths we need to release the RCU lock before
> calling copy_to_user(), so unfortunately we cannot use a common out label.

Ok, sure. But can you check that the code always releases the lock?

