Return-Path: <netdev+bounces-60203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F9981E1A5
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 17:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E095282150
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 16:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6336E1F18C;
	Mon, 25 Dec 2023 16:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kfh8zTe3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462F11DFDA
	for <netdev@vger.kernel.org>; Mon, 25 Dec 2023 16:56:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0AD3C433C8;
	Mon, 25 Dec 2023 16:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703523418;
	bh=aSPofIFQLCGsT0GZUqhO17nlXA6lwKYjn9He/PohKL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kfh8zTe3sxcUgazEnOv4PnvvPbGdZY1pigptiJyGyt3Y8OB8m0CKjszCTriDlFrsI
	 eiX7eY3ykNsiQ3x0++my/5Y7GJkucnKqU4ldqWX2jRAND2ekCBPSL/XtTgeBzWZSVq
	 wseN+e47O4tsO5yvNWKaPSlI4UAY4dYX+WQLHdwXsFr20vzjIkYz7PZg7pjLwROSIg
	 wbRj8wPRzpP+HS8jyfOH8IzSH3Cnohqg1jidrMFxmhCoJJwMNfTSob1YXiojmlZQ/y
	 1JhiS4G4l14tFUWOe0kzI1UvyfPh4YXceYABaXxvL4LhGC87UgqkDmABb5zBBbatLl
	 9hNMyotojnTeA==
Date: Mon, 25 Dec 2023 16:56:53 +0000
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net-next v2 06/13] bnxt_en: Add
 bnxt_lookup_ntp_filter_from_idx() function
Message-ID: <20231225165653.GH5962@kernel.org>
References: <20231223042210.102485-1-michael.chan@broadcom.com>
 <20231223042210.102485-7-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231223042210.102485-7-michael.chan@broadcom.com>

On Fri, Dec 22, 2023 at 08:22:03PM -0800, Michael Chan wrote:
> Add the helper function to look up the ntuple filter from the
> hash index and use it in bnxt_rx_flow_steer().  The helper function
> will also be used by user defined ntuple filters in the next
> patches.
> 
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 26 +++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index e9b382832a14..7027391316e5 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -13899,6 +13899,21 @@ static bool bnxt_fltr_match(struct bnxt_ntuple_filter *f1,
>  	return false;
>  }
>  
> +static struct bnxt_ntuple_filter *
> +bnxt_lookup_ntp_filter_from_idx(struct bnxt *bp,
> +				struct bnxt_ntuple_filter *fltr, u32 idx)
> +{
> +	struct bnxt_ntuple_filter *f;
> +	struct hlist_head *head;
> +
> +	head = &bp->ntp_fltr_hash_tbl[idx];
> +	hlist_for_each_entry_rcu(f, head, base.hash) {
> +		if (bnxt_fltr_match(f, fltr))
> +			return f;
> +	}
> +	return NULL;
> +}
> +
>  static int bnxt_rx_flow_steer(struct net_device *dev, const struct sk_buff *skb,
>  			      u16 rxq_index, u32 flow_id)
>  {
> @@ -13963,12 +13978,11 @@ static int bnxt_rx_flow_steer(struct net_device *dev, const struct sk_buff *skb,
>  	idx = bnxt_get_ntp_filter_idx(bp, fkeys, skb);
>  	head = &bp->ntp_fltr_hash_tbl[idx];
>  	rcu_read_lock();
> -	hlist_for_each_entry_rcu(fltr, head, base.hash) {
> -		if (bnxt_fltr_match(fltr, new_fltr)) {
> -			rc = fltr->base.sw_id;
> -			rcu_read_unlock();
> -			goto err_free;
> -		}
> +	fltr = bnxt_lookup_ntp_filter_from_idx(bp, new_fltr, idx);
> +	if (fltr) {
> +		rcu_read_unlock();
> +		rc = fltr->base.sw_id;

Hi Michael,

prior to this patch rc was set inside the RCU read-side critical section,
now it is outside. Is that intentional?

> +		goto err_free;
>  	}
>  	rcu_read_unlock();
>  

