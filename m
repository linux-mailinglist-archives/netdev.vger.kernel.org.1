Return-Path: <netdev+bounces-60210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F8281E1D8
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 18:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD62F1C21083
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 17:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9701252F8B;
	Mon, 25 Dec 2023 17:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6AUScPj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB1352F81
	for <netdev@vger.kernel.org>; Mon, 25 Dec 2023 17:44:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB1AC433C7;
	Mon, 25 Dec 2023 17:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703526247;
	bh=dOvjgWBCA12bN0wb53Z1F7TPCfTvkkR6vOD9neF3KTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E6AUScPjiQqjlCV+FKNBdn41E5rA3k+Uq3BJbg+hyQAuChUHL7Q+9oncyfNHnkkyM
	 bqGTFmCMEPY/iSXBTGUD2ldfflGugxZ26maoOEYrow6GlptnbJOvjhZ9vQWGw/MuvD
	 96x390uI+mZPezsdeIdGfAekvAwZf1YrDT06WPDx94uqE/Q+Bs6MnX53JjwuTYg72A
	 O4TiAtd3BB5dUoBqUsx9/MhAV8M8fHsnIRzA6AGz0sm0mtXyEnrPF5/TudQ3Qc9XCP
	 7nDzvcVXV/bihBuwurhcADgQ5EeMi/IKsc/QrcyAJBjAbzopncSypIwlV0wGo6Dl7H
	 uXCaPZv+ERmDw==
Date: Mon, 25 Dec 2023 17:44:03 +0000
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net-next v2 10/13] bnxt_en: Refactor ntuple filter
 removal logic in bnxt_cfg_ntp_filters().
Message-ID: <20231225174403.GN5962@kernel.org>
References: <20231223042210.102485-1-michael.chan@broadcom.com>
 <20231223042210.102485-11-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231223042210.102485-11-michael.chan@broadcom.com>

On Fri, Dec 22, 2023 at 08:22:07PM -0800, Michael Chan wrote:
> Refactor the logic into a new function bnxt_del_ntp_filters().  The
> same call will be used when the user deletes an ntuple filter.
> 
> The bnxt_hwrm_cfa_ntuple_filter_free() function to call fw to free
> the ntuple filter is exported so that the ethtool logic can call it.
> 
> Reviewed-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>

...

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c

...

> @@ -14011,6 +14011,21 @@ static int bnxt_rx_flow_steer(struct net_device *dev, const struct sk_buff *skb,
>  }
>  #endif
>  
> +void bnxt_del_ntp_filter(struct bnxt *bp, struct bnxt_ntuple_filter *fltr)
> +{
> +	spin_lock_bh(&bp->ntp_fltr_lock);
> +	if (!test_and_clear_bit(BNXT_FLTR_INSERTED, &fltr->base.state)) {
> +		spin_unlock_bh(&bp->ntp_fltr_lock);
> +		return;
> +	}
> +	hlist_del_rcu(&fltr->base.hash);
> +	bp->ntp_fltr_count--;
> +	spin_unlock_bh(&bp->ntp_fltr_lock);
> +	bnxt_del_l2_filter(bp, fltr->l2_fltr);
> +	clear_bit(fltr->base.sw_id, bp->ntp_fltr_bmap);
> +	kfree_rcu(fltr, base.rcu);
> +}
> +
>  static void bnxt_cfg_ntp_filters(struct bnxt *bp)
>  {
>  	int i;
> @@ -14042,20 +14057,8 @@ static void bnxt_cfg_ntp_filters(struct bnxt *bp)
>  					set_bit(BNXT_FLTR_VALID, &fltr->base.state);
>  			}
>  
> -			if (del) {
> -				spin_lock_bh(&bp->ntp_fltr_lock);
> -				if (!test_and_clear_bit(BNXT_FLTR_INSERTED, &fltr->base.state)) {
> -					spin_unlock_bh(&bp->ntp_fltr_lock);
> -					continue;
> -				}
> -				hlist_del_rcu(&fltr->base.hash);
> -				bp->ntp_fltr_count--;
> -				spin_unlock_bh(&bp->ntp_fltr_lock);
> -				bnxt_del_l2_filter(bp, fltr->l2_fltr);
> -				synchronize_rcu();

Nice to see a use of synchronize_rcu() disappear :)

> -				clear_bit(fltr->base.sw_id, bp->ntp_fltr_bmap);
> -				kfree(fltr);
> -			}
> +			if (del)
> +				bnxt_del_ntp_filter(bp, fltr);
>  		}
>  	}
>  	if (test_and_clear_bit(BNXT_HWRM_PF_UNLOAD_SP_EVENT, &bp->sp_event))

...

