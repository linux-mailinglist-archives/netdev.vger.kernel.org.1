Return-Path: <netdev+bounces-120300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 368FB958E16
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 20:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5E6AB21CB3
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 18:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90B01494A8;
	Tue, 20 Aug 2024 18:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcWrMyYs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15A9146D6B;
	Tue, 20 Aug 2024 18:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724178726; cv=none; b=RyCH9qm7rMLyhfAPmu3G1bqAtpB4UdQq8aRdgSZODMxgL+DoJYZiDtG3Wu7Q3Eq15LaofpoJPTfiSxN30XcW/l/C/poFkrCDVpvMnD0fT5eiB77DFoTPuvW8tH32aM1g2cP+r15bwDBiRJe/2Qq5wVzn+P75B2wlR6nCxIma9WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724178726; c=relaxed/simple;
	bh=TKArvj95GKzIUhpxrYU7tygE4hNlR5jO9uS9RfXTQF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RO6wpyePtgdfOQFDhfLFIbMczT45ZPHUFzkhjqQuOPLjIAzGG9f7xzrN9qZQDhuM1xwUaOU5+nBvxOfgbJITUJkElSlIRqXPIG1Ny0s+MGqtMFJ9wTvMv++hrz2gTjn6wUxGFMNJO/nr8WD25uC6FO/hK9vWR/MfKJVDgFsZmNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcWrMyYs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35706C4AF0B;
	Tue, 20 Aug 2024 18:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724178726;
	bh=TKArvj95GKzIUhpxrYU7tygE4hNlR5jO9uS9RfXTQF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FcWrMyYsCe+s5Uff9GVKmUw3tYDP/0mZVZHo6SNfaSymM66kHa9I5r1vzrVcLw8Hi
	 uIiKFH+Llz6X1hSyEq83cAZYSzqw9RYlsOz0EyO53qPOaFYwix5Ip/PIIS8X62O9zT
	 4NOJLctbd32dhCn+Ambvw9ERVwUaS599skt/4IX0mJxsMzhBcWYCjlHz9Kb4z4vF2v
	 vgaV9ykzAgo260xXLpO6pOb5BVFeu8M1/MImh5rAGWwz3/s5ZHF+zrTIeASZzPO7jC
	 dqywvtJhz3Y6ZXhWp9/sBDeui4EnOyndn4kO1TJdcrW1r8oRRP8GJosM/RuqkzcVd+
	 +P06HxV1hrqEA==
Date: Tue, 20 Aug 2024 19:32:02 +0100
From: Simon Horman <horms@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/1] net: dsa: mv88e6xxx: Fix out-of-bound access
Message-ID: <20240820183202.GA2898@kernel.org>
References: <20240819222641.1292308-1-Joseph.Huang@garmin.com>
 <72e02a72-ab98-4a64-99ac-769d28cfd758@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72e02a72-ab98-4a64-99ac-769d28cfd758@lunn.ch>

On Tue, Aug 20, 2024 at 12:58:05AM +0200, Andrew Lunn wrote:
> On Mon, Aug 19, 2024 at 06:26:40PM -0400, Joseph Huang wrote:
> > If an ATU violation was caused by a CPU Load operation, the SPID is 0xf,
> > which is larger than DSA_MAX_PORTS (the size of mv88e6xxx_chip.ports[]
> > array).
> 
> The 6390X datasheet says "IF SPID = 0x1f the source of the violation
> was the CPU's registers interface."
> 
> > +#define MV88E6XXX_G1_ATU_DATA_SPID_CPU				0x000f
> 
> So it seems to depend on the family.
> 
> >  
> >  /* Offset 0x0D: ATU MAC Address Register Bytes 0 & 1
> >   * Offset 0x0E: ATU MAC Address Register Bytes 2 & 3
> > diff --git a/drivers/net/dsa/mv88e6xxx/global1_atu.c b/drivers/net/dsa/mv88e6xxx/global1_atu.c
> > index ce3b3690c3c0..b6f15ae22c20 100644
> > --- a/drivers/net/dsa/mv88e6xxx/global1_atu.c
> > +++ b/drivers/net/dsa/mv88e6xxx/global1_atu.c
> > @@ -457,7 +457,8 @@ static irqreturn_t mv88e6xxx_g1_atu_prob_irq_thread_fn(int irq, void *dev_id)
> >  		trace_mv88e6xxx_atu_full_violation(chip->dev, spid,
> >  						   entry.portvec, entry.mac,
> >  						   fid);
> > -		chip->ports[spid].atu_full_violation++;
> > +		if (spid != MV88E6XXX_G1_ATU_DATA_SPID_CPU)
> > +			chip->ports[spid].atu_full_violation++;
> 
> So i think it would be better to do something like:
> 
> 		if (spid < ARRAY_SIZE(chip->ports))
> 			chip->ports[spid].atu_full_violation++;

Hi Joseph,

I am curious to know if bounds checking should also
be added to other accesses to chip->ports[spid] within this function.

