Return-Path: <netdev+bounces-60205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCAC81E1AE
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 18:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D8CD1F21EBE
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 17:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FA241C71;
	Mon, 25 Dec 2023 17:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rr2GRVPM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD9D38DD8
	for <netdev@vger.kernel.org>; Mon, 25 Dec 2023 17:11:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0238C433C7;
	Mon, 25 Dec 2023 17:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703524289;
	bh=o4wjsOTX1T+wK4Dnjo4QSB76OX9XjJb3P5ptqc2I9EQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rr2GRVPMrbPquRck1iTjJ8HTTpeRYRHPHUwkKvJWyCWPqmBLGbHGRsjv8wfJ+ze6e
	 BsS8/N5nh5eAlhqe6o/fUO1BsUX/oavnc19jT5ubMTI3nMEhpOP8WFiVZcCmWyEuvE
	 jBPWMljcVEbBjQ2CQY5RcRldp4rngwFOCclWZOs/EjQEH3yzUq0JjAzK07Mj3h7B+4
	 ZrDmKHIyWfB1GFeawLidwsLKRpopQoj+0VXlmyvd0bnAYH65GVQixcHvJKuZzU/zBG
	 V2nuwmP+te8mpM/f8e80Ba7Rb0vxXFs9+MnGFbJz/2/+TyGvtg3ei8lTHXqqoZajwf
	 c9NiJmiuoFSEA==
Date: Mon, 25 Dec 2023 17:11:25 +0000
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net-next v2 08/13] bnxt_en: Refactor filter insertion
 logic in bnxt_rx_flow_steer().
Message-ID: <20231225171125.GJ5962@kernel.org>
References: <20231223042210.102485-1-michael.chan@broadcom.com>
 <20231223042210.102485-9-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231223042210.102485-9-michael.chan@broadcom.com>

On Fri, Dec 22, 2023 at 08:22:05PM -0800, Michael Chan wrote:
> Add a new function bnxt_insert_ntp_filter() to insert the ntuple filter
> into the hash table and other basic setup.  We'll use this function
> to insert a user defined filter from ethtool.
> 
> Also, export bnxt_lookup_ntp_filter_from_idx() and bnxt_get_ntp_filter_idx()
> for similar purposes.  All ntuple related functions are now no longer
> compiled only for CONFIG_RFS_ACCEL
> 
> Reviewed-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

...

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c

...

> @@ -13991,33 +13995,20 @@ static int bnxt_rx_flow_steer(struct net_device *dev, const struct sk_buff *skb,
>  	}
>  	rcu_read_unlock();
>  
> -	spin_lock_bh(&bp->ntp_fltr_lock);
> -	bit_id = bitmap_find_free_region(bp->ntp_fltr_bmap, BNXT_MAX_FLTR, 0);
> -	if (bit_id < 0) {
> -		spin_unlock_bh(&bp->ntp_fltr_lock);
> -		rc = -ENOMEM;
> -		goto err_free;
> -	}
> -
> -	new_fltr->base.sw_id = (u16)bit_id;
>  	new_fltr->flow_id = flow_id;
>  	new_fltr->base.rxq = rxq_index;
> -	new_fltr->base.type = BNXT_FLTR_TYPE_NTUPLE;
> -	new_fltr->base.flags = BNXT_ACT_RING_DST;
> -	hlist_add_head_rcu(&new_fltr->base.hash, head);
> -	set_bit(BNXT_FLTR_INSERTED, &new_fltr->base.state);
> -	bp->ntp_fltr_count++;
> -	spin_unlock_bh(&bp->ntp_fltr_lock);
> -
> -	bnxt_queue_sp_work(bp, BNXT_RX_NTP_FLTR_SP_EVENT);
> -
> -	return new_fltr->base.sw_id;
> +	rc = bnxt_insert_ntp_filter(bp, new_fltr, idx);
> +	if (!rc) {
> +		bnxt_queue_sp_work(bp, BNXT_RX_NTP_FLTR_SP_EVENT);
> +		return new_fltr->base.sw_id;
> +	}

Hi Michael,

FIWIW, I think the following would be a more idomatic flow.
(Completely untested!)

	rc = bnxt_insert_ntp_filter(bp, new_fltr, idx);
	if (rc)
		goto err_free;

	bnxt_queue_sp_work(bp, BNXT_RX_NTP_FLTR_SP_EVENT);

	return new_fltr->base.sw_id;

>  
>  err_free:
>  	bnxt_del_l2_filter(bp, l2_fltr);
>  	kfree(new_fltr);
>  	return rc;
>  }
> +#endif
>  
>  static void bnxt_cfg_ntp_filters(struct bnxt *bp)
>  {

...

