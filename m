Return-Path: <netdev+bounces-227851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F44BB8C3D
	for <lists+netdev@lfdr.de>; Sat, 04 Oct 2025 11:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68DF83C7AFA
	for <lists+netdev@lfdr.de>; Sat,  4 Oct 2025 09:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB33623BCF8;
	Sat,  4 Oct 2025 09:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DY05oejQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B1321CFF6;
	Sat,  4 Oct 2025 09:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759571665; cv=none; b=Bhd1kS9CzBF3OCOQh/BhSijhVbDMzKcnzUmwuSSuc1u7H+CaOI4tOL5PgYIErzUjmmAnZXWnQVhV65nd9HPBrxAsgL59jT5jcER6zUcaELy9ytYRu21GN9ECxCzwfq5hENIQKKV9ZsBmKBVa+cbSFphtxXKEx3KFGO5051NWmnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759571665; c=relaxed/simple;
	bh=yhGB+zCXelAQFqL7octXuVGX6tQHw/zpU5lC3TtMFnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nixbAiU3hfhSvgKpIUPYtAYdT3P5PGjvwHGYUtHPOn2fzlBOfPhZFB1wAXF8/qKAV058VO5TyBgvLs8RW0N+6ackRDiO9fJiinfY+gosen/FdyVusVOp12kVI6PjvjA6P6aSyZ2D+okkH9WDkni0/dVoJ8myvuzu97folemqzos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DY05oejQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B070C4CEF1;
	Sat,  4 Oct 2025 09:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759571665;
	bh=yhGB+zCXelAQFqL7octXuVGX6tQHw/zpU5lC3TtMFnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DY05oejQySGmwNbSxCBLGTnJaKbPBg71swC4QuwmrwjFDMFRNIgaAXjDMVxgUNaPA
	 ckk5Uu0oLv+tDICdQHSomkpZbC64nFBzYWsA/brOYePw/t61idaUYCOgdgixcyMq+v
	 RlB7fIwUksRNvzoyvBrJWIriCg8ewJZ8ZrtU6dyNPWSsTBMRz1SsbE/CtsTXgrz9os
	 Cc/L3gB1VYBffnSvdAVSti2s46URN99hnxfaQxtmKfa1mbPQxU0X9veXEC6mLORqie
	 eclMUeyhOweIR77zvUMeAXe/8965P0ltYYdL1vx5Pn32TJ8qH1BIJ17OwIIskQxE4K
	 hQG/aevuJJVww==
Date: Sat, 4 Oct 2025 10:54:21 +0100
From: Simon Horman <horms@kernel.org>
To: Yeounsu Moon <yyyynoom@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dlink: use dev_kfree_skb_any instead of
 dev_kfree_skb
Message-ID: <20251004095421.GC3060232@horms.kernel.org>
References: <20251003022300.1105-1-yyyynoom@gmail.com>
 <20251003081729.GB2878334@horms.kernel.org>
 <DD8MONMKM9ZD.1PT79LGCA7U06@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DD8MONMKM9ZD.1PT79LGCA7U06@gmail.com>

On Fri, Oct 03, 2025 at 07:51:25PM +0900, Yeounsu Moon wrote:
> On Fri Oct 3, 2025 at 5:17 PM KST, Simon Horman wrote:
> > On Fri, Oct 03, 2025 at 11:23:00AM +0900, Yeounsu Moon wrote:
> >> Replace `dev_kfree_skb()` with `dev_kfree_skb_any()` in `start_xmit()`
> >> which can be called from hard irq context (netpoll) and from other
> >> contexts.
> >> 
> >> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> >> Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
> >> Tested-on: D-Link DGE-550T Rev-A3
> >
> > Hi,
> Hello, Simon!
> >
> > I am curious to know why this problem has come up now.
> This came up because I have the hardware and recently dug into the code.
> Until then, it was not considered an issue, because nobody raised it as
> such.
> > Or more to the point, why it has not come up since the cited commit
> > was made, 20 years ago.
> I think there are two combined reasons why it has not surfaced for two
> decades:
> 1. very few people actually had this device/driver in use.
> 2. The problem is difficult to reproduce: one must use `netpoll`, and at
> the same time the `link_speed` must drop to zero.
> >
> > I am also curious to know how the problem was found.
> > By inspection? Through testing? Other?
> While looking at the `dl2k.c` code, I noticed that its logic calls
> either `dev_kfree_skb()` or `dev_consume_skb_irq()` depending on
> interrupt context. That logic gave me the sense that a similar issue
> could exist elsewhere.
> >
> > ...
> And read other driver codes and commit messages, check `networking/netdevices`
> (.ndo_start_xmit), enable `netpoll` and set up  `netconsole`, read
> `net/core/netpoll.c`, read comment in `include/linux/netdevice.h`,
> add countless `printk()`s, build millions of times... and so on.

Hi Yeounsu,

Thanks for your detailed response.

I do think it would be useful to add something like this to the commit
message:

  Found by inspection.

But in any case, this patch looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>



