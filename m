Return-Path: <netdev+bounces-117852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EABA94F8DB
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 23:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D131E1C21939
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 21:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3017187345;
	Mon, 12 Aug 2024 21:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4Zuf6WT7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383061581EB;
	Mon, 12 Aug 2024 21:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723497493; cv=none; b=up0Get+70Yvjjh9J8G+eto0qagd8O0HdGJKDBLnXpmzm8JGS1RVA76K/Y+E6y/ZGNYUf86O0Cfl7SGdiFX5wxtQ2jyjDpwhSKTYu/pHWRUq3GpO8uFF6Nh9wGFZOa7JtIPnx+Eufy6cKBoO9zHKr3hCf8wCNxmUHdLrJ9+1FfHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723497493; c=relaxed/simple;
	bh=Du4MiFQct/T4oHZU6i8VcTUZQaIyjAgoUyHYcIGg4So=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nklxT+rSMPgy0MWdU7dX/Pha9XXGf5Z2RGX8JjJqKX5Uh3P/H67uLeI2DkPK8adFndsRWPFFjfxgARcjTSaB5Gwz5CNatKz7MJc5+hy1CGJ/9eb8UMF1KSD1LBhGR6/AmdZtoqW5FujCPoJ7EP7QRZDkYJhzwphcFaceU3mQsm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4Zuf6WT7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0k2o1lposRITkYe4FXhTi3MePKdAOecr3M+KCZT0m7k=; b=4Zuf6WT7kbhR99JVQDmUfX8Wir
	yBhzeYonw0jF+RI3pDDUj4ggsdf3vIn3yw8LiU7QBXmZMT6tRGXJT52bZM4P3yUiCR1vDQCJAKj05
	50GlhHmefUUYJynFc7oUahmyJWGmVTB4oVU9HAsGCKiDf+mRpICNPVAjCgrrW1v4mkJY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sdcQV-004caG-KC; Mon, 12 Aug 2024 23:18:03 +0200
Date: Mon, 12 Aug 2024 23:18:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 2/2] net: xilinx: axienet: Add statistics
 support
Message-ID: <70d817a8-5ee4-4ce2-883a-9e95f15f2855@lunn.ch>
References: <20240812174118.3560730-1-sean.anderson@linux.dev>
 <20240812174118.3560730-3-sean.anderson@linux.dev>
 <e78256f2-9ad6-49e1-9cd5-02a28c92d2fc@lunn.ch>
 <f1837494-7411-463f-b9f6-fbdd09217423@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1837494-7411-463f-b9f6-fbdd09217423@linux.dev>

On Mon, Aug 12, 2024 at 04:25:16PM -0400, Sean Anderson wrote:
> On 8/12/24 16:22, Andrew Lunn wrote:
> >>  static int __axienet_device_reset(struct axienet_local *lp)
> >>  {
> >>  	u32 value;
> >>  	int ret;
> >>  
> >> +	/* Save statistics counters in case they will be reset */
> >> +	guard(mutex)(&lp->stats_lock);
> >> +	if (lp->features & XAE_FEATURE_STATS)
> >> +		axienet_stats_update(lp, true);
> > 
> > My understanding of guard() is that the mutex is held until the
> > function completes. That is much longer than you need. A
> > scoped_guard() would be better here, and it makes it clear when the
> > mutex will be released.
> 
> We have to hold it until...
> 
> >> +
> >>  	/* Reset Axi DMA. This would reset Axi Ethernet core as well. The reset
> >>  	 * process of Axi DMA takes a while to complete as all pending
> >>  	 * commands/transfers will be flushed or completed during this
> >> @@ -551,6 +595,23 @@ static int __axienet_device_reset(struct axienet_local *lp)
> >>  		return ret;
> >>  	}
> >>  
> >> +	/* Update statistics counters with new values */
> >> +	if (lp->features & XAE_FEATURE_STATS) {
> >> +		enum temac_stat stat;
> >> +
> >> +		write_seqcount_begin(&lp->hw_stats_seqcount);
> >> +		lp->reset_in_progress = false;
> >> +		for (stat = 0; stat < STAT_COUNT; stat++) {
> >> +			u32 counter =
> >> +				axienet_ior(lp, XAE_STATS_OFFSET + stat * 8);
> >> +
> >> +			lp->hw_stat_base[stat] +=
> >> +				lp->hw_last_counter[stat] - counter;
> >> +			lp->hw_last_counter[stat] = counter;
> >> +		}
> >> +		write_seqcount_end(&lp->hw_stats_seqcount);
> 
> ...here
> 
> Which is effectively the whole function. The main reason why I used guard() was to
> simplify the error return cases.

This is why i personally don't like guard. It is not clear you
intended the mutex to be held so long, and that this code actually
requires it. An explicit mutex_unlock() here would make your
intentions clear, or a scoped_guard. I can see guard avoiding some
error path bugs, but i suspect it will introduce other problems when
refactoring code and having to make guesses about what actually needs
the mutex.

	    Andrew

