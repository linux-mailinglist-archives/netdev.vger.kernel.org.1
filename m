Return-Path: <netdev+bounces-147445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B2E9D98D4
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 14:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA152283D83
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 13:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63BB1D0E26;
	Tue, 26 Nov 2024 13:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IvPnTxHO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE631CEE96;
	Tue, 26 Nov 2024 13:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732628918; cv=none; b=XOV1kw7if2D4dM+mBBm3z+zqAOgP4sZmhqJv2GA25DuMCWjjt2UeyXDG3GOW2r6q0i+ZEoFjlKTRjn+7ST4KQ4VN+Qo+73DjW9KQffwZt7svTxAjp8NWFsqxkh1HNCSfjBu2Fs4qFp0jMK5FIxuf7kb5FZhgrdqGc9iK9Z4KGNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732628918; c=relaxed/simple;
	bh=ZKAvOwXr3qv93aa+cn8GDQk5NMxPHbHgo7mMdqPthRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmEDgayj0wVBGl3LQjOK+/c4GaO+wvRRIQp/YTadeLzzbXVXRRy8p9P9wG2YwdKuskAmeACydtbH7Tk2AXgAsxhUG+l6LMs6YlysgaRMfbI/Bj+5JWfKgiawPUCGWe792rltH0nqdDp3OwzgvQ/gRQynGiyoJtq4ibz630Riil0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IvPnTxHO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=amZclqVZR4wTjHpzUyfdqRGzrVfZK9pbXNx6aTcQ9OY=; b=IvPnTxHOFuDkabpNSUxQ2IoWcs
	9jLgd0ZMP4nYd1iWsIF5xNNdsgATmuiYiOUNKuUmmd+AiS1MwL1wSWWBcdxCqL8GteUjng7Bla0lv
	nZoKOVyJgsHO1V8kgzPzMMT6zOSKaUdemh79NFcHk4xVYjV3zqY5H5gs0EDjMCcp7Ek8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tFvvP-00EWFb-Qx; Tue, 26 Nov 2024 14:48:19 +0100
Date: Tue, 26 Nov 2024 14:48:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Frank Sae <Frank.Sae@motor-comm.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com, hua.sun@motor-comm.com
Subject: Re: [PATCH net-next v2 05/21] motorcomm:yt6801: Implement the
 fxgmac_start function
Message-ID: <fde04f06-df39-41a8-8f74-036e315e9a8b@lunn.ch>
References: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
 <20241120105625.22508-6-Frank.Sae@motor-comm.com>
 <95675880-1b93-4916-beee-e5feb6531009@lunn.ch>
 <ba24293a-77b1-4106-84d2-81ff343fc90f@motor-comm.com>
 <82e1860b-cbbf-4c82-9f1b-bf4a283e3585@lunn.ch>
 <43341290-15e3-4784-9b69-7f3f13f34e01@motor-comm.com>
 <a48d76ac-db08-46d5-9528-f046a7b541dc@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a48d76ac-db08-46d5-9528-f046a7b541dc@motor-comm.com>

On Tue, Nov 26, 2024 at 05:28:08PM +0800, Frank Sae wrote:
> 
> 
> On 2024/11/26 11:15, Frank Sae wrote:
> > Hi Andrew,
> > 
> > On 2024/11/25 22:18, Andrew Lunn wrote:
> >>>> RGMII is unusual, you normally want RGMII_ID. Where are the 2ns delays
> >>>> added?
> >>>>
> >>>
> >>> Yes, you are right. PHY_INTERFACE_MODE_RGMII should be PHY_INTERFACE_MODE_RGMII_ID.
> >>> YT6801 NIC integrated with YT8531S phy, and the 2ns delays added in the phy driver.
> >>> https://elixir.bootlin.com/linux/v6.12/source/drivers/net/phy/motorcomm.c#L895
> >>
> >> But if you pass PHY_INTERFACE_MODE_RGMII to the PHY it is not adding
> >> the 2ns delay. So how does this work now?
> > 
> > I'm sorry. Maybe PHY_INTERFACE_MODE_RGMII is enough.
> > YT6801 is a pcie NIC chip that integrates one yt8531s phy.
> > Therefore, a delay of 2ns is unnecessary, as the hardware has
> >  already ensured this.
> 
> YT6801 looks like that:
> 
>                       ||                      
>   ********************++**********************
>   *            | PCIE Endpoint |             *
>   *            +---------------+             *
>   *                | GMAC |                  *
>   *                +--++--+      YT6801      *
>   *                  |**|                    *
>   *         GMII --> |**| <-- MDIO           *
>   *                 +-++--+                  *
>   *                 | PHY |                  *
>   *                 +--++-+                  *
>   *********************||*********************
> 
> yt8531s phy driver not support GMII.

Is it really GMII? If so, add GMII to the yt8531 driver.

Often this is described as PHY_INTERFACE_MODE_INTERNAL, meaning it
does not matter what is being used between the MAC and the PHY, it is
internal to the SoC. You might want to add that to the PHY driver.

	Andrew

