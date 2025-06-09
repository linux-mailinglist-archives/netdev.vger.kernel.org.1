Return-Path: <netdev+bounces-195840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4EEAD2707
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 21:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 442D53B0CD9
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 19:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FA521C19A;
	Mon,  9 Jun 2025 19:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKjJuHq5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62651DDC2A
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 19:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749498812; cv=none; b=lFNOxmQ/8dfQPzMppTeecQxuBplRAZy3pZugAzu9IMq9GXQDaEfWuNF/ixFGT7AzvzA+1WcLlLY4OG4en4FjWBjN5HP2xBFJwuucOvR8JPbFMQ4Dxikhx1OB0Nv+5aDYEOSmdYisWM7mWzYzwvB2RP2L0Pvch19aDsFystWx+Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749498812; c=relaxed/simple;
	bh=4PDY3uKcBIDYYVrV6n5xlhWJKM6fgS0beHRtwK15gUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=edjmlAob9Ql0OBu5ZOny4Q88RWZjrBVl1MnOoKTq9Gkvve98X7g83gQXkQltU+/REGpI29kbWxb9+Z9eQTKhun8avdkLpH7UTgb+I1jpykte5iKLs7Z2lxhrbKoVWL6V21Y+Os5DW60rheOg55XhvrV+m10C6xqn94U1YCVQGUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKjJuHq5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0907AC4CEEB;
	Mon,  9 Jun 2025 19:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749498812;
	bh=4PDY3uKcBIDYYVrV6n5xlhWJKM6fgS0beHRtwK15gUQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DKjJuHq5y82Koj4aCenfu2X99Vv7UsgTxhpxCk3v6nJIMOo3OO8S4EhQJJLIjmkks
	 dx5r7WPaDT+wBWAVDDT9HlBI6wCxbxZ+seQ1FUgzzURIgAMGAtyK0sg3IrzPofiKOv
	 5diqEPFzQXNEEqFvKRCOPVQ7qUDvxxkYXVgMp7+so2f5oQ5Mv7PtrEjMyY3u4153eo
	 ZImkQnBuijNyt19AALDlFF/12rLbUMGCLDraw4Ul49xTHv7ru+AdIq/DvZC8wfc3ln
	 E8UVIN1oN3HkTcILLhlrG023P2DVvSeqaaahj83B+bq5ULoTnXCNbGg0Ln6GxjIGU0
	 WXgahh193Ewaw==
Date: Mon, 9 Jun 2025 12:53:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [RFC net-next 0/6] net: ethtool: support including Flow Label
 in the flow hash for RSS
Message-ID: <20250609125331.38602f42@kernel.org>
In-Reply-To: <c7f7a711-cbe0-4003-bdbe-f4db041e90d0@lunn.ch>
References: <20250609173442.1745856-1-kuba@kernel.org>
	<1eca3a2d-aad2-4aac-854e-1370aba5b225@lunn.ch>
	<20250609115825.19deb467@kernel.org>
	<c7f7a711-cbe0-4003-bdbe-f4db041e90d0@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Jun 2025 21:30:53 +0200 Andrew Lunn wrote:
> On Mon, Jun 09, 2025 at 11:58:25AM -0700, Jakub Kicinski wrote:
> > On Mon, 9 Jun 2025 20:26:14 +0200 Andrew Lunn wrote:  
> > > It took me a while to get there, i wondered why you are extending the
> > > IOCTL code, rather than netlink. But netlink ethtool does not appear
> > > to support ops->set_rxnfc() calls.
> > > 
> > > Rather than extend the deprecated ioctl i think the first patch in the
> > > series should add set_rxnfc() to netlink ethtool.  
> > 
> > I suppose the fact we added at least 2 features to this API since 
> > the netlink conversion will not convince you otherwise? (input_xfrm
> > with all of its options, and GTP flow types and hashing)  
> 
> Not really. We should of asked that the first patch in those series
> added the netlink code. Why did we bother adding netlink, if we are
> going to keep extending the IOCTL interface?

The RSS settings and NFC need to be rethought, that's why it wasn't
migrated. But I can pop just the hash fields into the RSS_GET that 
we already added (and add the corresponding SET part).

The config and creation of RSS contexts should diverge from what 
the ioctl do. The IOCTL takes an indirection table of a fixed size,
but modern NICs will increasingly need to allocate the RSS table
dynamically, based on the size. As such user space preparing the table
for us is really counter productive.

The flow filters are a whole different can of warms. We had been
pushing for TC migration over the last decade, which I don't think
really happened. More recently we were trying to convince Jamal that
his P4TC work would really best fit as a netlink replacement for flow
filters. IDK where we landed, I'd really not touch that with a 10 ft
pole.

So yeah, this is not a simple "why did nobody convert this IOCTL struct
to netlink yet" problem. But as I said I think we can push the hash
config into the RSS_GET / RSS_SET..

