Return-Path: <netdev+bounces-124050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB38A967B65
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 19:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11C33B20BD9
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 17:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63165183CAA;
	Sun,  1 Sep 2024 17:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWxp/cMA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC4018308E;
	Sun,  1 Sep 2024 17:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725210746; cv=none; b=tf5cy+Mmx18SIbB15xvyEkOn0T09A0g/w2YBQDIoBmdkf15mfYnpRrYMGj9EnXerp/8RkuqhAGAQDrJ0h3//ITtvGnijToxCiBn4vqoVxw8nKEGpuQOmK94O/PqHACg6z64JgrIjr5cTRRcUwSO1J8nDCewvC3LZsQx/PyzJva8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725210746; c=relaxed/simple;
	bh=RgV1+vFXxD1YOWUbfX+yhlkDhClujDM6WsRSO2vDLWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZboM+cS2I26UhabxnBgUWk/I63OC9j3abF4Ichv2aAC4snUw3RdNA/74gfqVhxdU3BwKQRQyZhdNX8hUq4GxDW2GreYXnwksAPi4fveb7dVUqClG6TQe2srvpu6vu8o6XUDudRjyHOixd4Qx+EcOa4e40RiWOuTEd3uiItM57A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWxp/cMA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B7EC4CEC3;
	Sun,  1 Sep 2024 17:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725210744;
	bh=RgV1+vFXxD1YOWUbfX+yhlkDhClujDM6WsRSO2vDLWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fWxp/cMA+sUFKE1I9PdLg1ey5HcEI5PaYKdjavQwnGhb/2sw5wHL1+irDSoF2nHye
	 6WV4JlST0WV3EFBrnE5U8IaV/QwTdt4oLPb4rmFpdhtT6kBIbuNKYxDrsu11awsoJD
	 4Qjbj8xdat3CqB2429nVjsqIF5jTynJLNf8xVxsrHAb5hSUpIQyDCZP2gjqRCPuuB4
	 9A31Wk7QUOuyKxU4OJ9jDKxN5itkon4MCCeC61CHae5ABVc16uii6HuAOu2aLnSIIw
	 FptLBiHsNr6ze+2Jvh6E3beO9SAtlIXCTul3txKTo2NunDCFNkOyUI34M1PN6FhRMH
	 SnP06H5PpujGA==
Date: Sun, 1 Sep 2024 18:11:50 +0100
From: Simon Horman <horms@kernel.org>
To: David Laight <David.Laight@aculab.com>
Cc: Yan Zhen <yanzhen@vivo.com>,
	"marcin.s.wojtas@gmail.com" <marcin.s.wojtas@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"opensource.kernel@vivo.com" <opensource.kernel@vivo.com>
Subject: Re: [PATCH v1] ethernet: marvell: Use min macro
Message-ID: <20240901171150.GA23170@kernel.org>
References: <20240827115848.3908369-1-yanzhen@vivo.com>
 <20240827175408.GR1368797@kernel.org>
 <20240827175745.GS1368797@kernel.org>
 <7cfe24b82098487e9b1d35f964bf652f@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cfe24b82098487e9b1d35f964bf652f@AcuMS.aculab.com>

On Sat, Aug 31, 2024 at 12:39:28PM +0000, David Laight wrote:
> From: Simon Horman
> > Sent: 27 August 2024 18:58
> > 
> > On Tue, Aug 27, 2024 at 06:54:08PM +0100, Simon Horman wrote:
> > > On Tue, Aug 27, 2024 at 07:58:48PM +0800, Yan Zhen wrote:
> > > > Using the real macro is usually more intuitive and readable,
> > > > When the original file is guaranteed to contain the minmax.h header file
> > > > and compile correctly.
> > > >
> > > > Signed-off-by: Yan Zhen <yanzhen@vivo.com>
> > > > ---
> > > >  drivers/net/ethernet/marvell/mvneta.c | 3 +--
> > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> > > > index d72b2d5f96db..415d2b9e63f9 100644
> > > > --- a/drivers/net/ethernet/marvell/mvneta.c
> > > > +++ b/drivers/net/ethernet/marvell/mvneta.c
> > > > @@ -4750,8 +4750,7 @@ mvneta_ethtool_set_ringparam(struct net_device *dev,
> > > >
> > > >  	if ((ring->rx_pending == 0) || (ring->tx_pending == 0))
> > > >  		return -EINVAL;
> > > > -	pp->rx_ring_size = ring->rx_pending < MVNETA_MAX_RXD ?
> > > > -		ring->rx_pending : MVNETA_MAX_RXD;
> > > > +	pp->rx_ring_size = min(ring->rx_pending, MVNETA_MAX_RXD);
> > >
> > > Given that the type of ring->rx_pending is __32, and MVNETA_MAX_RXD is
> > > a positive value.
> > 
> > Sorry, I hit send to soon. What I wanted to say is:
> > 
> > I think that it is appropriate to use umin() here.
> > Because:
> > 1) As I understand things, the type of MVNETA_MAX_RXD is signed,
> >    but it always holds a positive value
> > 2) ring->rx_pending is unsigned
> 
> Provided MVNETA_MAX_RXD is constant it is fine.
> umin() is only needed for signed variables that can only contain
> non-negative values.
> 
> You only need to use it is the compiler bleats...
> 
> umin(x, y) is safer than min_t(unsigned_type, x, y) because you can't
> get the type wrong.
> If will also generate better code since it never sign extends a
> 32bit value to 64bits (expensive on 32bit).

Hi David,

My understanding of umin() was a bit off - I thought it was
also relevant when one of the arguments is a constant.

Thanks for setting me straight.

