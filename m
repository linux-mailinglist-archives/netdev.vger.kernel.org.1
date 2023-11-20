Return-Path: <netdev+bounces-49373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3291D7F1D91
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 20:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED75C1C21240
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 19:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC9336B00;
	Mon, 20 Nov 2023 19:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtNDqL6H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9203437143
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 19:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF29EC433C8;
	Mon, 20 Nov 2023 19:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700510093;
	bh=XEk1TDYJXwWIDjwk3SpnQ/cUT188GWkL6+Wn04/gkog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PtNDqL6HP9y4ULaClwSuUXBF3X6vf/KMXw40yba1jHDzCBi6/YR2uodMUznDJT7JU
	 RSPCM58OKzY21JU2FVD+Cz0P4fec+CJ+WIIfr6P/rj/NIWKnJGWWxgawYuSOmKdHTH
	 b1BvdajzPqu575NGbhI5QMlEef02UjEZ2pBRwG5cEzydtwGXmdQwyT92LGuxoChYaO
	 eA5EhpUK4Uhwa1apgzLIbdofV/rjMkNl7GkT91HxIpXk7RrD/6DhLhU2mn2chtSXzS
	 VOq9VWYhNHPMUsek02OLZat2d/2TK2s/WvqfeydNjk0ZlgHyGYpdfq06gMbn9ru5f7
	 vfwSHma+aNjhQ==
Date: Mon, 20 Nov 2023 19:54:47 +0000
From: Simon Horman <horms@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	wojciech.drewek@intel.com, marcin.szycik@intel.com,
	piotr.raczynski@intel.com,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: Re: [PATCH net-next 13/15] ice: add VF representors one by one
Message-ID: <20231120195447.GJ245676@kernel.org>
References: <20231114181449.1290117-1-anthony.l.nguyen@intel.com>
 <20231114181449.1290117-14-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114181449.1290117-14-anthony.l.nguyen@intel.com>

On Tue, Nov 14, 2023 at 10:14:33AM -0800, Tony Nguyen wrote:
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> 
> Implement adding representors one by one. Always set switchdev
> environment when first representor is being added and clear environment
> when last one is being removed.
> 
> Basic switchdev configuration remains the same. Code related to creating
> and configuring representor was changed.
> 
> Instead of setting whole representors in one function handle only one
> representor in setup function. The same with removing representors.
> 
> Stop representors when new one is being added or removed. Stop means,
> disabling napi, stopping traffic and removing slow path rule. It is
> needed because ::q_id will change after remapping, so each representor
> will need new rule.
> 
> When representor are stopped rebuild control plane VSI with one more or
> one less queue. One more if new representor is being added, one less if
> representor is being removed.
> 
> Bridge port is removed during unregister_netdev() call on PR, so there
> is no need to call it from driver side.
> 
> After that do remap new queues to correct vector. At the end start all
> representors (napi enable, start queues, add slow path rule).
> 
> Reviewed-by: Piotr Raczynski <piotr.raczynski@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c

...

> +int
> +ice_eswitch_attach(struct ice_pf *pf, struct ice_vf *vf)
> +{
> +	struct ice_repr *repr;
> +	int change = 1;
> +	int err;
> +
> +	if (pf->eswitch_mode == DEVLINK_ESWITCH_MODE_LEGACY)
> +		return 0;
> +
> +	if (xa_empty(&pf->eswitch.reprs)) {
> +		err = ice_eswitch_enable_switchdev(pf);
> +		if (err)
> +			return err;
> +		/* Control plane VSI is created with 1 queue as default */
> +		change = 0;
> +	}
> +
> +	ice_eswitch_stop_reprs(pf);
> +
> +	repr = ice_repr_add_vf(vf);
> +	if (IS_ERR(repr))
> +		goto err_create_repr;

Hi Michal and Tony,

This branch will cause the function to return err,
but err is set to 0 here. Perhaps it should be set to PTR_ERR(repr)
instead?

Flagged by Smatch.

> +
> +	err = ice_eswitch_setup_repr(pf, repr);
> +	if (err)
> +		goto err_setup_repr;
> +
> +	err = xa_alloc(&pf->eswitch.reprs, &repr->id, repr,
> +		       XA_LIMIT(1, INT_MAX), GFP_KERNEL);
> +	if (err)
> +		goto err_xa_alloc;
> +
> +	vf->repr_id = repr->id;
> +
> +	ice_eswitch_cp_change_queues(&pf->eswitch, change);
> +	ice_eswitch_start_reprs(pf);
> +
> +	return 0;
> +
> +err_xa_alloc:
> +	ice_eswitch_release_repr(pf, repr);
> +err_setup_repr:
> +	ice_repr_rem_vf(repr);
> +err_create_repr:
> +	if (xa_empty(&pf->eswitch.reprs))
> +		ice_eswitch_disable_switchdev(pf);
> +	ice_eswitch_start_reprs(pf);
> +
> +	return err;
> +}

...

