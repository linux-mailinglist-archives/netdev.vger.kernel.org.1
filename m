Return-Path: <netdev+bounces-145604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1259D00A3
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 20:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F32287691
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 19:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2C0195B1A;
	Sat, 16 Nov 2024 19:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gdRfOcvT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B999919149F;
	Sat, 16 Nov 2024 19:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731784998; cv=none; b=qm0rgR8XxyUhgtPbQ4aHga0FoKzZoBjNB+v3XaPyIGstZcGjv3BQimDyAcmNVZXpHl3zOVDoP3Z1h7G9lD+Ja4btD7LxB+7whU3B6Nd7Wopl/DUL942Lhn7Zmw7220sy1ldBdiAKOVLbvHj/+K6F+QuNbHgGc8qPPgFMtGzlGDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731784998; c=relaxed/simple;
	bh=yfX/6TZQ1gd9+8AMgBgNPFETIp1Fe4WBrJJhmJztd/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1qN3RWW7epoR+V2Q6vRa2nmYbLa4Pm/nwn/m/4RwJbBeowuxkKm+cjzguqrpl3v6X+URPjXM2bqFzCqSQfLFW0RVHVw+I6bD53UQ5XtyEylRM7VO648RGfoiVQ0X9bOJG80DKuEtAHoniNJMsKqe+VuY8OQUKkWsISE2TEQWs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gdRfOcvT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dn+2cDfRC1yH4NOcw8ysKYN7T3VzTAsD6jJX6tRQuE0=; b=gdRfOcvTKwxKkLKP+bQtMsvxeP
	Zcxq1PDSbPRXkd6PvRH478+Xa11lrRN3cdrqac8/EN9m0pGru+9CaGqImJwB9y2vem4kTJ9INuRjQ
	3BNTlCTAlH6WrvWOK3XO5BHaKsjGnmQlg/tFjALWn9OFuc6IOvE4cK8R+h+z/XuTo7NM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tCONh-00DXYh-Cb; Sat, 16 Nov 2024 20:22:53 +0100
Date: Sat, 16 Nov 2024 20:22:53 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Parker Newman <parker@finest.io>
Cc: Paolo Abeni <pabeni@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v1 1/1] net: stmmac: dwmac-tegra: Read iommu stream id
 from device tree
Message-ID: <bb52bdc1-df2e-493d-a58f-df3143715150@lunn.ch>
References: <cover.1731685185.git.pnewman@connecttech.com>
 <f2a14edb5761d372ec939ccbea4fb8dfd1fdab91.1731685185.git.pnewman@connecttech.com>
 <ed2ec1c2-65c7-4768-99f1-987e5fa39a54@redhat.com>
 <20241115135940.5f898781.parker@finest.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115135940.5f898781.parker@finest.io>

On Fri, Nov 15, 2024 at 01:59:40PM -0500, Parker Newman wrote:
> On Fri, 15 Nov 2024 18:17:07 +0100
> Paolo Abeni <pabeni@redhat.com> wrote:
> 
> > On 11/15/24 17:31, Parker Newman wrote:
> > > From: Parker Newman <pnewman@connecttech.com>
> > >
> > > Read the iommu stream id from device tree rather than hard coding to mgbe0.
> > > Fixes kernel panics when using mgbe controllers other than mgbe0.
> >
> > It's better to include the full Oops backtrace, possibly decoded.
> >
> 
> Will do, there are many different ones but I can add the most common.
> 
> > > Tested with Orin AGX 64GB module on Connect Tech Forge carrier board.
> >
> > Since this looks like a fix, you should include a suitable 'Fixes' tag
> > here, and specify the 'net' target tree in the subj prefix.
> >
> 
> Sorry I missed the "net" tag.
> 
> The bug has existed since dwmac-tegra.c was added. I can add a Fixes tag but
> in the past I was told they aren't needed in that situation?
> 
> > > @@ -241,6 +243,12 @@ static int tegra_mgbe_probe(struct platform_device *pdev)
> > >  	if (IS_ERR(mgbe->xpcs))
> > >  		return PTR_ERR(mgbe->xpcs);
> > >
> > > +	/* get controller's stream id from iommu property in device tree */
> > > +	if (!tegra_dev_iommu_get_stream_id(mgbe->dev, &mgbe->iommu_sid)) {
> > > +		dev_err(mgbe->dev, "failed to get iommu stream id\n");
> > > +		return -EINVAL;
> > > +	}
> >
> > I *think* it would be better to fallback (possibly with a warning or
> > notice) to the previous default value when the device tree property is
> > not available, to avoid regressions.
> >
> 
> I debated this as well... In theory the iommu must be setup for the
> mgbe controller to work anyways. Doing it this way means the worst case is
> probe() fails and you lose an ethernet port.

New DT properties are always optional. Take the example of a board
only using a single controller. It should happily work. It probably
does not have this property because it is not needed. Your change is
likely to cause a regression on such a board.

Also, is a binding patch needed?

	Andrew

