Return-Path: <netdev+bounces-45381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 195E97DC6CC
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 08:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AB821C20B58
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 07:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF66D524;
	Tue, 31 Oct 2023 07:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jqAGUspu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA58D297;
	Tue, 31 Oct 2023 07:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5D7C433C8;
	Tue, 31 Oct 2023 07:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1698735614;
	bh=n7FSvkZDOHEm4+nPhmb2+a5uE4UXO7K+Etegdgo2ssY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jqAGUspuLQD8adfUT9YwhL/Z34yCBTYdUzhkG5wb4L56NW7ITyq4eS/IrJvEpUQe6
	 nI4rjwusjGGdY4j0xMbUg47O26XtMAZ9CUN6Wb7THKWZy+1mlPMZv4g9j9aLv3bSYF
	 hBIdgHi3wJ6fmtqoJnWq8Fn6k49BPd/VTrM/SS+A=
Date: Tue, 31 Oct 2023 08:00:11 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Benjamin Poirier <benjamin.poirier@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Kira <nyakov13@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
	Coiby Xu <coiby.xu@gmail.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Sven Joachim <svenjoac@gmx.de>,
	Ian Kent <raven@themaw.net>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: Revert "staging: qlge: Retire the driver"
Message-ID: <2023103125-preshow-pencil-c1e5@gregkh>
References: <20231030150400.74178-1-benjamin.poirier@gmail.com>
 <2023103001-drew-parmesan-c61a@gregkh>
 <ZT_YntDOYEdlpx5x@d3>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZT_YntDOYEdlpx5x@d3>

On Mon, Oct 30, 2023 at 12:33:55PM -0400, Benjamin Poirier wrote:
> On 2023-10-30 16:25 +0100, Greg Kroah-Hartman wrote:
> > On Tue, Oct 31, 2023 at 02:04:00AM +1100, Benjamin Poirier wrote:
> > > This reverts commit 875be090928d19ff4ae7cbaadb54707abb3befdf.
> > > 
> > > On All Hallows' Eve, fear and cower for it is the return of the undead
> > > driver.
> > > 
> > > There was a report [1] from a user of a QLE8142 device. They would like for
> > > the driver to remain in the kernel. Therefore, revert the removal of the
> > > qlge driver.
> > > 
> > > [1] https://lore.kernel.org/netdev/566c0155-4f80-43ec-be2c-2d1ad631bf25@gmail.com/
> > 
> > Who's going to maintain this?
> 
> I was planning to update the MAINTAINERS entry to
> S:	Orphan
> when moving it back to drivers/net/. Would you prefer that I do that
> change in a second patch right after the revert in staging? That would
> certainly make things clearer.

I would prefer not having orphaned code in the kernel tree.  Again, who
is going to support this?  It was dropped because there is no owner and
the company doesn't care anymore.  We can't add it back if there is no
one who will do the real-work to fix it up and get it out of staging.
Just magically moving it there isn't going to be a solution either.

> > > Reported by: Kira <nyakov13@gmail.com>
> > > Signed-off-by: Benjamin Poirier <benjamin.poirier@gmail.com>
> > > ---
> > > 
> > > Notes:
> > >     Once the removal and revert show up in the net-next tree, I plan to send a
> > >     followup patch to move the driver to drivers/net/ as discussed earlier:
> > >     https://lore.kernel.org/netdev/20231019074237.7ef255d7@kernel.org/
> > 
> > are you going to be willing to maintain this and keep it alive?
> 
> No.
> 
> > I'm all this, if you want to, but I would like it out of staging.  So
> 
> I'd like it out of staging as well. Since nobody wants to maintain it, I
> think it should be deleted. However, my understanding is that Jakub is
> willing to take it back into drivers/net/ as-is given that there is at
> least one user. Jakub, did I understand that correctly?
> 
> > how about applying this, and a follow-on one that moves it there once
> > -rc1 is out?  And it probably should be in the 'net' tree, as you don't
> > want 6.7 to come out without the driver at all, right?
> 
> Right about making sure 6.7 includes the driver. The 'net' tree is
> usually for fixes hence why I would send to net-next. So the driver
> would still be in staging for 6.7 (if you include the revert in your
> 6.7-rc1 submission) and would be back in drivers/net/ for 6.8.

Let's wait until 6.7-rc1 is out and then, if the netdev developers want
to take this on, they can revert it and move it to drivers/net/.

But right now, my tree is frozen, it's the middle of the merge window,
let's wait 2 weeks please.

thanks,

greg k-h

