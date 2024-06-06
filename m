Return-Path: <netdev+bounces-101436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DFD8FE846
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F358F2852D3
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 13:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49501196447;
	Thu,  6 Jun 2024 13:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5mkjK4y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25342196456
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 13:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717682351; cv=none; b=mfS7mDOtoDxpo841Vnjeb7MGYzC76R+Hd8ox4msRyRnvtVvQsEGBkqxsd713PvrHIC+Wq/R+IdM/7JxcY5IY7/eY1piMlWb/pvlf9EHa+FDW9sM1q8mkv1eX/OajbEQtsSU7xra6EgkkeZFXJmBkUBpslSHx8s/rk7VsTGXrBYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717682351; c=relaxed/simple;
	bh=JGR9+WoyerZ7BvXcSd141t/mM9ZPFMBE6XZwWnix/is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=au464fDKbH7sxOucEtd44T/1iBysc+TBnYUl0ftiQvqvdx50y453aJTy2kMsFhyzsmnPdN2fT9GtTfDF1XTOygsQvAMi96JxXLJSy3Y/oyZ8UUnbGCfnKn8G6vhvRqmy1ba62uIHsB2AUz5Hf8UblnF31weA8gGFUgCNxwhN/wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5mkjK4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A1CC32782;
	Thu,  6 Jun 2024 13:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717682350;
	bh=JGR9+WoyerZ7BvXcSd141t/mM9ZPFMBE6XZwWnix/is=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N5mkjK4yzH7SpyxCazT8Det3I2rmI3CBHrh59vWaoxBtTJDCapEPoOOHw3Tobob1w
	 ugg01hcT5hCI9LO1K986bIwtdB/N6OMQAxtT7ZTyQ1dUT59bxfrUONqmgviDhQ0/7v
	 cfcbMjOj/su+Awsr2tThntIpBF1nww7OmvFpNoAiaGkeY1U2SLW1w2WNyisr1tXnNM
	 /q8on+RTroEhfecmTD98tudqT2x1vUR7npVNfUyn7sODAQviBN2dUO6JFGpDoS+ocJ
	 hXmhuZJK8DxEDk/g+JnAPQSuiykR+GM562rmpDnDNasd4wNisnPrZa0DMqMxPGAvBL
	 SZPMYt0OwWgsQ==
Date: Thu, 6 Jun 2024 14:59:05 +0100
From: Simon Horman <horms@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Gal Pressman <gal@nvidia.com>, Yoray Zack <yorayz@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net-next 08/15] net/mlx5e: SHAMPO, Skipping on duplicate
 flush of the same SHAMPO SKB
Message-ID: <20240606135905.GL791188@kernel.org>
References: <20240528142807.903965-1-tariqt@nvidia.com>
 <20240528142807.903965-9-tariqt@nvidia.com>
 <20240605134823.GK791188@kernel.org>
 <9957a6c3740e76c61b979038c6e984f9987bbd4c.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9957a6c3740e76c61b979038c6e984f9987bbd4c.camel@nvidia.com>

On Wed, Jun 05, 2024 at 05:55:24PM +0000, Dragos Tatulea wrote:
> On Wed, 2024-06-05 at 14:48 +0100, Simon Horman wrote:
> > On Tue, May 28, 2024 at 05:28:00PM +0300, Tariq Toukan wrote:
> > > From: Yoray Zack <yorayz@nvidia.com>
> > > 
> > > SHAMPO SKB can be flushed in mlx5e_shampo_complete_rx_cqe().
> > > If the SKB was flushed, rq->hw_gro_data->skb was also set to NULL.
> > > 
> > > We can skip on flushing the SKB in mlx5e_shampo_flush_skb
> > > if rq->hw_gro_data->skb == NULL.
> > > 
> > > Signed-off-by: Yoray Zack <yorayz@nvidia.com>
> > > Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> > > ---
> > >  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > > index 1e3a5b2afeae..3f76c33aada0 100644
> > > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > > @@ -2334,7 +2334,7 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
> > >  	}
> > >  
> > >  	mlx5e_shampo_complete_rx_cqe(rq, cqe, cqe_bcnt, *skb);
> > > -	if (flush)
> > > +	if (flush && rq->hw_gro_data->skb)
> > >  		mlx5e_shampo_flush_skb(rq, cqe, match);
> > 
> > nit: It seems awkward to reach inside rq like this
> >      when mlx5e_shampo_flush_skb already deals with the skb in question.
> > 
> We don't need to reach inside the rq, we could use *skb instead (skb is &rq-
> >hw_gro_data->skb). *skb is used often in this function.

So it is, thanks for pointing that out.

Clearly this is a pretty minor thing,
so no need to respin just because of it.

> 
> >      Would it make esnse for the NULL skb check to
> >      be moved inside mlx5e_shampo_flush_skb() ?
> > 
> 
> Thanks,
> Dragos

