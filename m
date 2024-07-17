Return-Path: <netdev+bounces-111844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AE4933822
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 09:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3111B1C20E72
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 07:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33E41B974;
	Wed, 17 Jul 2024 07:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Utbduj05"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDDF1BF37
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 07:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721202088; cv=none; b=o3RM9Sl11TzmNyJywEDnjW9aGwiC/rzj/3qL5SC60I6L5Hz/Bav+w3zygjfYKs+lQXGCwHtmjuBdsU/sf9BmNSJS6N7SoTKPgnwYhkx6FHyexrv6RUvA8ImRJUF05UjG6TuT2XNdJPrZsfwqi4f03XXuFxgDNdmDmPJRk9LOs+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721202088; c=relaxed/simple;
	bh=A9/oN9qCTuvFPqiAKro8vyymN0b0kPIBqa0gO5IHIeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pC26u6jSF12kdnJZvOX7nhzj1JXc4bqkxwlTzdkMT6XoEdJV4wuytjQEHN0aycWAAwZ9gWLf5H7fLHO8bd8x8C02V02SY5yrvo49o0U731FIepkLNWs/yDXzmv1naZoEH22HFoEqLSDayds88uFY0qSG8Wt9p/7Ify9/sFxtIN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Utbduj05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92E1C32782;
	Wed, 17 Jul 2024 07:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721202088;
	bh=A9/oN9qCTuvFPqiAKro8vyymN0b0kPIBqa0gO5IHIeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Utbduj053QJcw1/j97j1uWoEYEw6Kw6fRBp1imqJd2GBBVUkjvoZ/cp/zHoiQh+bX
	 7q/MPUYHO4z0yaK1hjJOloMz1pTwB6c1aN3MCX3dXZXqeXkEvSWRIaQXCIPOmUGMJI
	 O8lTL3KvBG829ju2/yZIHhsWWNvYzASfLXcI2XW5z/Mr701/io02kKadCa5ouz5MYa
	 6zeoJ3efac+pi6BnIiQwrcYxzCbXJpUPXuDp4uDU23OW7HRAVUp5jTAXAaBp1MNATw
	 xXLd5XeCxkX+Ay8IN/i+olXmaat/UaEZ8AUaFPZ7eIg/7cu9z6VAEGpQO32hyUxPTK
	 lL8ozK8T6T4rg==
Date: Wed, 17 Jul 2024 08:41:22 +0100
From: Simon Horman <horms@kernel.org>
To: Praveen Kaligineedi <pkaligineedi@google.com>
Cc: netdev@vger.kernel.org, stable@kernel.org, hramamurthy@google.com,
	jfraker@google.com, jeroendb@google.com, shailend@google.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, ziweixiao@google.com,
	willemb@google.com, Joshua Washington <joshwash@google.com>
Subject: Re: [PATCH net] gve: Fix XDP TX completion handling when counters
 overflow
Message-ID: <20240717074122.GH249423@kernel.org>
References: <20240716171041.1561142-1-pkaligineedi@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716171041.1561142-1-pkaligineedi@google.com>

On Tue, Jul 16, 2024 at 10:10:41AM -0700, Praveen Kaligineedi wrote:
> From: Joshua Washington <joshwash@google.com>
> 
> In gve_clean_xdp_done, the driver processes the TX completions based on
> a 32-bit NIC counter and a 32-bit completion counter stored in the tx
> queue.
> 
> Fix the for loop so that the counter wraparound is handled correctly.
> 
> Fixes: 75eaae158b1b ("gve: Add XDP DROP and TX support for GQI-QPL format")
> Signed-off-by: Joshua Washington <joshwash@google.com>
> Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/ethernet/google/gve/gve_tx.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/google/gve/gve_tx.c b/drivers/net/ethernet/google/gve/gve_tx.c
> index 24a64ec1073e..e7fb7d6d283d 100644
> --- a/drivers/net/ethernet/google/gve/gve_tx.c
> +++ b/drivers/net/ethernet/google/gve/gve_tx.c
> @@ -158,15 +158,16 @@ static int gve_clean_xdp_done(struct gve_priv *priv, struct gve_tx_ring *tx,
>  			      u32 to_do)
>  {
>  	struct gve_tx_buffer_state *info;
> -	u32 clean_end = tx->done + to_do;
>  	u64 pkts = 0, bytes = 0;
>  	size_t space_freed = 0;
>  	u32 xsk_complete = 0;
>  	u32 idx;
> +	int i;
>  
> -	for (; tx->done < clean_end; tx->done++) {
> +	for (i = 0; i < to_do; i++) {

I was slightly concerned that, as it is a u32, the value of to_do could
exceed the maximum value of i, which is an int.

But I see that in practice the value of to_do is bound by an int, budget,
in the call site, gve_xdp_poll. So I think we are ok.

Perhaps, as a clean up, the type of the to_do parameter of
gve_clean_xdp_done, and local variable in gve_xdp_poll() could be updated
from u32 to int. But, OTOH, perhaps that doesn't get us anywhere.

>  		idx = tx->done & tx->mask;
>  		info = &tx->info[idx];
> +		tx->done++;
>  
>  		if (unlikely(!info->xdp.size))
>  			continue;
> -- 
> 2.45.2.803.g4e1b14247a-goog
> 
> 

