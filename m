Return-Path: <netdev+bounces-201445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C80F9AE97BF
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 10:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96F425A0548
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5FB25C831;
	Thu, 26 Jun 2025 08:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vB5PW4mg"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F3125A34F;
	Thu, 26 Jun 2025 08:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750925535; cv=none; b=IsWEA8qFgI9NHSK4vNYUp0OwFXGxdUkatM/DoL39bGsBZ7Bc9MarvZDEjeWuIYWIVh/tBPwICI3RuAZvY5p0Bj0VtDQr22DC+SwdpOP0xYA4vOjLM6cUUuymi+D7LnaqxzW43ZgzrywWwKllifxtZcWSn+HQKNfVTwPtiVKOCdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750925535; c=relaxed/simple;
	bh=3dXVafBWOfFefTgO6M446tnYxU8YbifNcRhcTuPy+bM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btzVC1SgMHdPLz+iWTr2CPNjVW57SpvitzftfImx/AKfFe4jBKH2757FsOlsO2+yplTW/M77VMkfWMWkRs1oEGPzbdIWk76cCV9a/G4A46HNkMzAgx+Y03PhH66706MjJRTYiNEOfkMhWBh1mrsBiLNKAEq4WgDLxztXKu0X8yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vB5PW4mg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ur88+4etHFHDs/a+baqh+sIcwjleO3j1Hgj0Dd3LqoY=; b=vB5PW4mgXXYjUI9C6oNGOFXeDK
	o4aM3W6rA+jXwXIqKRHmdw2qDer5iYy9JWbhPAa4GJN4JCFZ1zP2N/2Dwub4QxJt9AyXdwmZC1oE3
	9DO0naxQyAOm4AQciEGZGRxjoPdH5ukVqcE5qOEdtr/KzSe3Z2qUIedPdhcsdIopaQl0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uUhiJ-00H173-Ok; Thu, 26 Jun 2025 10:12:07 +0200
Date: Thu, 26 Jun 2025 10:12:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: Jonas Rebmann <jre@pengutronix.de>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] net: fec: allow disable coalescing
Message-ID: <d60808b3-eb20-40ab-b952-d9cd8d8d68a7@lunn.ch>
References: <20250625-fec_deactivate_coalescing-v1-1-57a1e41a45d3@pengutronix.de>
 <PAXPR04MB8510C17E1980D456FD9F094F887AA@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8510C17E1980D456FD9F094F887AA@PAXPR04MB8510.eurprd04.prod.outlook.com>

On Thu, Jun 26, 2025 at 02:36:37AM +0000, Wei Fang wrote:
> >  static void fec_enet_itr_coal_set(struct net_device *ndev)
> >  {
> >         struct fec_enet_private *fep = netdev_priv(ndev);
> > -       int rx_itr, tx_itr;
> > +       int rx_itr = 0, tx_itr = 0;
> 
> Since you modified this line, it would be a good idea to change
> the type to u32.
> 
> > 
> > -       /* Must be greater than zero to avoid unpredictable behavior */
> > -       if (!fep->rx_time_itr || !fep->rx_pkts_itr ||
> > -           !fep->tx_time_itr || !fep->tx_pkts_itr)
> > -               return;

Hi Wei

When i see a comment like this being removed, i wounder if there is
any danger of side effects? Do you know what is being done here is
actually safe, for all the different versions of the FEC which support
coalescence?

Thanks
	Andrew

