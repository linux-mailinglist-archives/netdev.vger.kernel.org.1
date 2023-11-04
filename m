Return-Path: <netdev+bounces-46034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2F37E0F9E
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 14:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0BEA1C2099A
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 13:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28927199C3;
	Sat,  4 Nov 2023 13:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhFgqocT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2171945F
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 13:44:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC64C433C7;
	Sat,  4 Nov 2023 13:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699105454;
	bh=Exi3Dp1tHjuY5WnbbDcF0Tl0B0MvUo53adtNSeJJKiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KhFgqocTgMzh5//2O+R55xZID+VNPjBzSnYZ/XGKMTlO7Doys6mAyTQHVofCaS/is
	 qnJLPB+wfjaaCN5qqpJfUL+CR5PI+UO28EQuV1Fu9bRe7jAGjkZ16abpO4iS4sadHC
	 NrYBN5lnlwogjWRq7yw1FZK7mG11MJIGKypBYA2e7Qu57NW/2YtulryB5kqD3kyhIe
	 BaxJ6+9OIUWKiqlYZwSawB/t4X78Qml4sVQkBdt7w7lbtYMeqeqV3xYy1JG1ntEi1b
	 Qud8eaNS1hN2U5OtjVfS003g/lSh/V0K7vD6By6RpgdTd6hMf49x1DGl79UjrFEgjy
	 ksEgIUwkFKwnQ==
Date: Sat, 4 Nov 2023 09:43:54 -0400
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Avinash Dayanand <avinash.dayanand@intel.com>
Subject: Re: [PATCH net] i40e: Fix adding unsupported cloud filters
Message-ID: <20231104134354.GD891380@kernel.org>
References: <20231103204216.1072251-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103204216.1072251-1-ivecera@redhat.com>

+ Avinash Dayanand

On Fri, Nov 03, 2023 at 09:42:16PM +0100, Ivan Vecera wrote:
> If a VF tries to add unsupported cloud filter through virchnl
> then i40e_add_del_cloud_filter(_big_buf) returns -ENOTSUPP but
> this error code is stored in 'ret' instead of 'aq_ret' that
> is used as error code sent back to VF. In this scenario where
> one of the mentioned functions fails the value of 'aq_ret'
> is zero so the VF will incorrectly receive a 'success'.
> 
> Use 'aq_ret' to store return value and remove 'ret' local
> variable. Additionally fix the issue when filter allocation
> fails, in this case no notification is sent back to the VF.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Hi Ivan,

as a fix targeted at 'net' this probably warrants a fixes tag.
Perhaps the following is appropriate?

Fixes: e284fc280473 ("i40e: Add and delete cloud filter")

The above not withstanding, this change looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  .../net/ethernet/intel/i40e/i40e_virtchnl_pf.c   | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index 08d7edccfb8ddb..3f99eb19824527 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -3844,7 +3844,7 @@ static int i40e_vc_add_cloud_filter(struct i40e_vf *vf, u8 *msg)
>  	struct i40e_pf *pf = vf->pf;
>  	struct i40e_vsi *vsi = NULL;
>  	int aq_ret = 0;
> -	int i, ret;
> +	int i;
>  
>  	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE)) {
>  		aq_ret = -EINVAL;
> @@ -3868,8 +3868,10 @@ static int i40e_vc_add_cloud_filter(struct i40e_vf *vf, u8 *msg)
>  	}
>  
>  	cfilter = kzalloc(sizeof(*cfilter), GFP_KERNEL);
> -	if (!cfilter)
> -		return -ENOMEM;
> +	if (!cfilter) {
> +		aq_ret = -ENOMEM;
> +		goto err_out;
> +	}
>  
>  	/* parse destination mac address */
>  	for (i = 0; i < ETH_ALEN; i++)
> @@ -3917,13 +3919,13 @@ static int i40e_vc_add_cloud_filter(struct i40e_vf *vf, u8 *msg)
>  
>  	/* Adding cloud filter programmed as TC filter */
>  	if (tcf.dst_port)
> -		ret = i40e_add_del_cloud_filter_big_buf(vsi, cfilter, true);
> +		aq_ret = i40e_add_del_cloud_filter_big_buf(vsi, cfilter, true);
>  	else
> -		ret = i40e_add_del_cloud_filter(vsi, cfilter, true);
> -	if (ret) {
> +		aq_ret = i40e_add_del_cloud_filter(vsi, cfilter, true);
> +	if (aq_ret) {
>  		dev_err(&pf->pdev->dev,
>  			"VF %d: Failed to add cloud filter, err %pe aq_err %s\n",
> -			vf->vf_id, ERR_PTR(ret),
> +			vf->vf_id, ERR_PTR(aq_ret),
>  			i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
>  		goto err_free;
>  	}
> -- 
> 2.41.0
> 
> 

