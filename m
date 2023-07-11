Return-Path: <netdev+bounces-16832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5D774ED9D
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 14:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3101281766
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 12:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A2418B1E;
	Tue, 11 Jul 2023 12:09:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197A918AFD
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 12:09:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0BEAC433C7;
	Tue, 11 Jul 2023 12:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689077349;
	bh=0atk1H/K77+t0+qOiATihZM3kOpttjQ09aSCzasGtUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GNoo5G7Wx3jy3zUzLbF6P+kc+np7BSqcAWufGXShpeFTNGExnWGedvD6/c4wy1rN9
	 NsNa50/aWLdCT6Skuj2hbGSvXUUp3SDEbzDkHWMPxwEaMuLG2nwmBwC18vt+g6CLnR
	 +0hXBfH4rhbWWChMZKo/wkgSK0JE3qS1COeHd3m4MNewawNTgWcxbqjB3co/nVPVxS
	 t+bau4fXYSbV+pMQxP2XeXzMco/x1ZOwqowUDb+kbxBfrqsZ5vMZtgI96Idz+vzBdi
	 9FSdVndtu+w8FrDiLHGYYrQaXIi0p9R74KyFDJ6IyFX0++2dAWDUnG27MNwT/B1XEz
	 PYQRi6VVqpH7g==
Date: Tue, 11 Jul 2023 15:09:04 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Ivan Vecera <ivecera@redhat.com>, Ma Yuying <yuma@redhat.com>,
	Simon Horman <simon.horman@corigine.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: Re: [PATCH net-next 1/2] i40e: Add helper for VF inited state check
 with timeout
Message-ID: <20230711120904.GP41919@unreal>
References: <20230710164030.2821326-1-anthony.l.nguyen@intel.com>
 <20230710164030.2821326-2-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710164030.2821326-2-anthony.l.nguyen@intel.com>

On Mon, Jul 10, 2023 at 09:40:29AM -0700, Tony Nguyen wrote:
> From: Ivan Vecera <ivecera@redhat.com>
> 
> Move the check for VF inited state (with optional up-to 300ms
> timeout to separate helper i40e_check_vf_init_timeout() that
> will be used in the following commit.
> 
> Tested-by: Ma Yuying <yuma@redhat.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 47 ++++++++++++-------
>  1 file changed, 31 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index be59ba3774e1..b84b6b675fa7 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -4304,6 +4304,36 @@ static int i40e_validate_vf(struct i40e_pf *pf, int vf_id)
>  	return ret;
>  }
>  
> +/**
> + * i40e_check_vf_init_timeout
> + * @vf: the virtual function
> + *
> + * Check that the VF's initialization was successfully done and if not
> + * wait up to 300ms for its finish.
> + *
> + * Returns true when VF is initialized, false on timeout
> + **/
> +static bool i40e_check_vf_init_timeout(struct i40e_vf *vf)
> +{
> +	int i;
> +
> +	/* When the VF is resetting wait until it is done.
> +	 * It can take up to 200 milliseconds, but wait for
> +	 * up to 300 milliseconds to be safe.
> +	 */
> +	for (i = 0; i < 15; i++) {
> +		if (test_bit(I40E_VF_STATE_INIT, &vf->vf_states))
> +			return true;
> +
> +		msleep(20);
> +	}
> +
> +	dev_err(&vf->pf->pdev->dev, "VF %d still in reset. Try again.\n",
> +		vf->vf_id);

This error is not accurate in the edge case, when VF state changed to
be INIT during msleep() while i was 14.

Thanks

> +
> +	return false;
> +}
> +
>  /**
>   * i40e_ndo_set_vf_mac
>   * @netdev: network interface device structure
> @@ -4322,7 +4352,6 @@ int i40e_ndo_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
>  	int ret = 0;
>  	struct hlist_node *h;
>  	int bkt;
> -	u8 i;
>  
>  	if (test_and_set_bit(__I40E_VIRTCHNL_OP_PENDING, pf->state)) {
>  		dev_warn(&pf->pdev->dev, "Unable to configure VFs, other operation is pending.\n");
> @@ -4335,21 +4364,7 @@ int i40e_ndo_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
>  		goto error_param;
>  
>  	vf = &pf->vf[vf_id];
> -
> -	/* When the VF is resetting wait until it is done.
> -	 * It can take up to 200 milliseconds,
> -	 * but wait for up to 300 milliseconds to be safe.
> -	 * Acquire the VSI pointer only after the VF has been
> -	 * properly initialized.
> -	 */
> -	for (i = 0; i < 15; i++) {
> -		if (test_bit(I40E_VF_STATE_INIT, &vf->vf_states))
> -			break;
> -		msleep(20);
> -	}
> -	if (!test_bit(I40E_VF_STATE_INIT, &vf->vf_states)) {
> -		dev_err(&pf->pdev->dev, "VF %d still in reset. Try again.\n",
> -			vf_id);
> +	if (!i40e_check_vf_init_timeout(vf)) {
>  		ret = -EAGAIN;
>  		goto error_param;
>  	}
> -- 
> 2.38.1
> 
> 

