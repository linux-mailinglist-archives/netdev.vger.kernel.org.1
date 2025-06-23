Return-Path: <netdev+bounces-200369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE74AE4AF7
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 18:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8125017A816
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 16:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CB3220687;
	Mon, 23 Jun 2025 16:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwHGrypA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDACA18B0F;
	Mon, 23 Jun 2025 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750696119; cv=none; b=JiMrINj1ALXiKH/oZhQyAdd+uehnLSIGbF8C9q3eXzYOvq2nZ16g/1hvuEHq45UikUXYOxvLCPQMLPxAfk6V7QZqC2Im8m8ME8Rl31WTfdnlDxlUz5l2tFQ2zqYd+XaOMdzCJsrmT9B5s8bvDdbv/WpTEUe1d3g2nMEaGQDi9C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750696119; c=relaxed/simple;
	bh=0DOa81pP5da1DTjn3C0B3bD4iRl1Cit+BMz4BDo8ti0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UADsCESVvpdaz8PAa8S/GLl+dYk57Ncbo6c5EGWq6JT+eT0NluCI4XE8xcR8eMZChoTfgiO8JGtuMg0SRhiL9OVuK6LntQGEkfQ1kiA6eg64rH+wsGWodlZZ5qSeQWTURIOX6FKI7xO8bsP3p6l9v5WqAWvxJ70v+wDbd3wyXgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwHGrypA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1D0C4CEEA;
	Mon, 23 Jun 2025 16:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750696118;
	bh=0DOa81pP5da1DTjn3C0B3bD4iRl1Cit+BMz4BDo8ti0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CwHGrypAWG1lqX2ZDIE7+pB+AfcGvGJS8GlvA/tLf5pAwQXHdFe6KhEJsbp6RWBr3
	 5ZWp+jYOesdnmc5KduMMYcbQDaAWgrCn/jwmgWkD7I9ixwnwf38wfi1hkTwGNk1DKJ
	 Z2Rcx3PK5FaWBHiIGLRfBW83XDnX5CleV2v/MYpVueEOuD/nrHZ1R2ZdFrVJizuoeR
	 6Zdk/O+GSdSrG143NEfHjT+Lfd29cwCIbJ0tnQ3ibMyliA4Kb7hCjDg4ROcD7Qozpf
	 SWH1DwBe5BGgcwObDhgQ3VCm8wEnGB+VOnJiUf7OEAng0XOOAOn2sBwdLchbgCYqkz
	 HOuBbOdo3BxAQ==
Date: Mon, 23 Jun 2025 17:28:33 +0100
From: Simon Horman <horms@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH net-next 1/3] net: enetc: change the statistics of ring
 to unsigned long type
Message-ID: <20250623162833.GD506049@horms.kernel.org>
References: <20250620102140.2020008-1-wei.fang@nxp.com>
 <20250620102140.2020008-2-wei.fang@nxp.com>
 <20250621095245.GA71935@horms.kernel.org>
 <PAXPR04MB851070E3D67D390B7A4114F88879A@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB851070E3D67D390B7A4114F88879A@PAXPR04MB8510.eurprd04.prod.outlook.com>

On Mon, Jun 23, 2025 at 01:49:59AM +0000, Wei Fang wrote:
> > >  struct enetc_ring_stats {
> > > -	unsigned int packets;
> > > -	unsigned int bytes;
> > > -	unsigned int rx_alloc_errs;
> > > -	unsigned int xdp_drops;
> > > -	unsigned int xdp_tx;
> > > -	unsigned int xdp_tx_drops;
> > > -	unsigned int xdp_redirect;
> > > -	unsigned int xdp_redirect_failures;
> > > -	unsigned int recycles;
> > > -	unsigned int recycle_failures;
> > > -	unsigned int win_drop;
> > > +	unsigned long packets;
> > > +	unsigned long bytes;
> > > +	unsigned long rx_alloc_errs;
> > > +	unsigned long xdp_drops;
> > > +	unsigned long xdp_tx;
> > > +	unsigned long xdp_tx_drops;
> > > +	unsigned long xdp_redirect;
> > > +	unsigned long xdp_redirect_failures;
> > > +	unsigned long recycles;
> > > +	unsigned long recycle_failures;
> > > +	unsigned long win_drop;
> > >  };
> > 
> > Hi Wei fang,
> > 
> > If the desire is for an unsigned 64 bit integer, then I think either u64 or unsigned
> > long long would be good choices.
> > 
> > unsigned long may be 64bit or 32bit depending on the platform.
> 
> The use of unsigned long is to keep it consistent with the statistical
> value type in struct net_device_stats. Because some statistics in
> net_device_stats come from enetc_ring_stats.
> 
> #define NET_DEV_STAT(FIELD)			\
> 	union {					\
> 		unsigned long FIELD;		\
> 		atomic_long_t __##FIELD;	\
> 	}

Thanks, I understand. But in this case I think the patch description could
be reworded - unsigned int and unsigned long are the same thing on some
systems, and on such systems there is no overflow advantage of one over the
other.

