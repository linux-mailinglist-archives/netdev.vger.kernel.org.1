Return-Path: <netdev+bounces-116121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8259492A0
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 16:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24D661F20DD2
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 14:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F150F18D642;
	Tue,  6 Aug 2024 14:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mirt+YFq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC6618D63C
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 14:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722953224; cv=none; b=e3yCwVonfjJmyR1F3hFesf/vbiU1ZZG/UIwjNdszTGkvf+fA3lwez38oJ3v/26zEuiPAew9G5AJE/z8UhtPM3nDh8naRy72mxYGLLvw2xoJ5Enx2Tm/eTkI7a53wi9XNHxrDjtzwyMWRO7KM6p+1N8qfQswL8scxsQwbWUMShH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722953224; c=relaxed/simple;
	bh=C3lr3tWkqWjRNpwTIO6l3ZCzqFh0K0pNhEqTjz0pQnY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kmzk9KwkksKCN8EMrhXpCCbXnEUYH6HZI0jtIkXfA6OQFD1L79wuOKKNMefnJgqV06xWs9ZZ/OcokeqmzNlYLiIzRcBW6A2gtncRxdwGdcENkBU02riTjQGSYLcm4Eogrf5kSqtp8VsRROLRnovjmuTad2urzALJe2FA+JP8G7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mirt+YFq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3282C4AF09;
	Tue,  6 Aug 2024 14:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722953224;
	bh=C3lr3tWkqWjRNpwTIO6l3ZCzqFh0K0pNhEqTjz0pQnY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mirt+YFqlvjx5cXSM+z5M8PTQQrKOhHuybjU7rvKC7yw9kJGGJfUw3YO4R2ehkqPo
	 Y1bpGSgPmMMo67D+0qeg8vfJkhuCIMoiuzLulAwS8XAi679qvSZsRUzLZ0D4BZCUta
	 QNq+oXo5ysBo/GgzWZZJ6KQS0ukXAfQ9xf4E6K8wwcj8Md3U3eY6Id6I3pzdC9ICfP
	 jB22K4R4MmRIspMntkASbJdqNnAbxV0gLseCdS5/Dzm5+Zi3jnTYI9dDY2hT3jjiQz
	 nfdcb75J+FCgHNb+joM2IoJqXBxH+IH4F3GlcJzLU7L61e5xcT8L0z9zWltSpHnJVd
	 rjaN6mv8MvmoA==
Date: Tue, 6 Aug 2024 07:07:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, dxu@dxuuu.xyz, przemyslaw.kitszel@intel.com,
 donald.hunter@gmail.com, gal.pressman@linux.dev, tariqt@nvidia.com,
 willemdebruijn.kernel@gmail.com, jdamato@fastly.com
Subject: Re: [PATCH net-next v2 06/12] ethtool: rss: don't report key if
 device doesn't support it
Message-ID: <20240806070702.3359e2fe@kernel.org>
In-Reply-To: <2af37636-de5d-913d-4ccf-9388f1cfbd26@gmail.com>
References: <20240803042624.970352-1-kuba@kernel.org>
	<20240803042624.970352-7-kuba@kernel.org>
	<2af37636-de5d-913d-4ccf-9388f1cfbd26@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

[found this stuck in my outgoing mail :S]

On Mon, 5 Aug 2024 15:36:28 +0100 Edward Cree wrote:
> On 03/08/2024 05:26, Jakub Kicinski wrote:
> > marvell/otx2 and mvpp2 do not support setting different
> > keys for different RSS contexts. Contexts have separate
> > indirection tables but key is shared with all other contexts.
> > This is likely fine, indirection table is the most important
> > piece.  
> 
> Since drivers that do not support this are the odd ones out,
>  would it be better to invert the sense of the flag?  Or is
>  this to make sure that driver authors who don't think/know
>  about the distinction automatically get safe behaviour?

Yes, I wanted the 0 / default / sloppy choice to be the safe one.
As annoying as it is to have to set it in most drivers, I still
prefer that to the inevitable false-negatives.

> > Don't report the key-related parameters from such drivers.
> > This prevents driver-errors, e.g. otx2 always writes
> > the main key, even when user asks to change per-context key.
> > The second reason is that without this change tracking
> > the keys by the core gets complicated. Even if the driver
> > correctly reject setting key with rss_context != 0,
> > change of the main key would have to be reflected in
> > the XArray for all additional contexts.
> > 
> > Since the additional contexts don't have their own keys
> > not including the attributes (in Netlink speak) seems
> > intuitive. ethtool CLI seems to deal with it just fine.
> > 
> > Reviewed-by: Joe Damato <jdamato@fastly.com>
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>  
> ...
> > diff --git a/drivers/net/ethernet/sfc/ef100_ethtool.c b/drivers/net/ethernet/sfc/ef100_ethtool.c
> > index 746b5314acb5..127b9d6ade6f 100644
> > --- a/drivers/net/ethernet/sfc/ef100_ethtool.c
> > +++ b/drivers/net/ethernet/sfc/ef100_ethtool.c
> > @@ -58,6 +58,7 @@ const struct ethtool_ops ef100_ethtool_ops = {
> >  
> >  	.get_rxfh_indir_size	= efx_ethtool_get_rxfh_indir_size,
> >  	.get_rxfh_key_size	= efx_ethtool_get_rxfh_key_size,
> > +	.rxfh_per_ctx_key	= 1,  
> 
> I would prefer 'true' for the sfc drivers, I think that
>  better fits the general style of our code.

Sure thing.

> >  	.rxfh_priv_size		= sizeof(struct efx_rss_context_priv),
> >  	.get_rxfh		= efx_ethtool_get_rxfh,
> >  	.set_rxfh		= efx_ethtool_set_rxfh,

> > diff --git a/drivers/net/ethernet/sfc/siena/ethtool.c b/drivers/net/ethernet/sfc/siena/ethtool.c
> > index 4c182d4edfc2..6d4e5101433a 100644
> > --- a/drivers/net/ethernet/sfc/siena/ethtool.c
> > +++ b/drivers/net/ethernet/sfc/siena/ethtool.c
> > @@ -241,6 +241,7 @@ static int efx_ethtool_get_ts_info(struct net_device *net_dev,
> >  
> >  const struct ethtool_ops efx_siena_ethtool_ops = {
> >  	.cap_rss_ctx_supported	= true,
> > +	.rxfh_per_ctx_key	= true,  
> 
> For the record, Siena hardware doesn't actually support
>  custom RSS contexts; the code is only present in the
>  driver as a holdover from when Siena and EF10 used the
>  same driver.  Trying to actually use them on Siena will
>  fail -EOPNOTSUPP.[1]
> I'll send a patch to rip it out.

Ack, will drop this chunk to avoid conflicts, then.

> >  	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
> >  				     ETHTOOL_COALESCE_USECS_IRQ |
> >  				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
> > diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> > index 55c9f613ab64..16f72a556fe9 100644
> > --- a/include/linux/ethtool.h
> > +++ b/include/linux/ethtool.h
> > @@ -731,6 +731,8 @@ struct kernel_ethtool_ts_info {
> >   *	do not have to set this bit.
> >   * @cap_rss_sym_xor_supported: indicates if the driver supports symmetric-xor
> >   *	RSS.
> > + * @rxfh_per_ctx_key: device supports setting different RSS key for each
> > + *	additional context.  
> 
> This comment should really make clear that it covers hfunc and
>  input_xfrm as well, not just the key itself.

Ack.

