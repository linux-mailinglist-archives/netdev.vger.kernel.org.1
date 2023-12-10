Return-Path: <netdev+bounces-55606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F68380BA6E
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 12:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEE24B209C7
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 11:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40947882A;
	Sun, 10 Dec 2023 11:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4+pgFo1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23547848A
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 11:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A27C433C8;
	Sun, 10 Dec 2023 11:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702208675;
	bh=kdBLoAjjIs/FLrxJuUWkVq0Dh/+ngOXVVslrqDTXYY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p4+pgFo1CTvbw62XVJm43KD2KFk3ccVkmULsvKIRZslSEP0Znk4r3i4mRI9BT2mAA
	 FCC2SbDVBABkTKprMHO69akdVBDYHzc1SZVOFO5Q0glpWCkwKUb/hVDPyy6kutyVBT
	 n+hcLfPUtOu2HJXx7OlEHrD90Wd2eXcb7+nMtd0lnTvUic+HPFyuEh6fZt8JpPF7F0
	 mwRNU0VzGEiDe6IfD8/0exSEjl6Il8KzcbFKs2V+V5jc4qXMEs7C4xOcdEpPynVHtC
	 t3rjzcd8MLuCOpTyZ60akmjENnyy+LVv6d7PdLg95Q42/Qi2J9IeMy8To2+K6GrW9/
	 PfGHzKLyIG9og==
Date: Sun, 10 Dec 2023 11:44:31 +0000
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
	netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Anthony Nguyen <anthony.l.nguyen@intel.com>,
	Ivan Vecera <ivecera@redhat.com>
Subject: Re: [PATCH iwl-net] ice: stop trashing VF VSI aggregator node ID
 information
Message-ID: <20231210114431.GG5817@kernel.org>
References: <20231206201905.846723-1-jacob.e.keller@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206201905.846723-1-jacob.e.keller@intel.com>

+ Ivan Vecera <ivecera@redhat.com>

On Wed, Dec 06, 2023 at 12:19:05PM -0800, Jacob Keller wrote:
> When creating new VSIs, they are assigned into an aggregator node in the
> scheduler tree. Information about which aggregator node a VSI is assigned
> into is maintained by the vsi->agg_node structure. In ice_vsi_decfg(), this
> information is being destroyed, by overwriting the valid flag and the
> agg_id field to zero.
> 
> For VF VSIs, this breaks the aggregator node configuration replay, which
> depends on this information. This results in VFs being inserted into the
> default aggregator node. The resulting configuration will have unexpected
> Tx bandwidth sharing behavior.
> 
> This was broken by commit 6624e780a577 ("ice: split ice_vsi_setup into
> smaller functions"), which added the block to reset the agg_node data.
> 
> The vsi->agg_node structure is not managed by the scheduler code, but is
> instead a wrapper around an aggregator node ID that is tracked at the VSI
> layer. Its been around for a long time, and its primary purpose was for
> handling VFs. The SR-IOV VF reset flow does not make use of the standard VSI
> rebuild/replay logic, and uses vsi->agg_node as part of its handling to
> rebuild the aggregator node configuration.
> 
> The logic for aggregator nodes stretches  back to early ice driver code from
> commit b126bd6bcd67 ("ice: create scheduler aggregator node config and move
> VSIs")
> 
> The logic in ice_vsi_decfg() which trashes the ice_agg_node data is clearly
> wrong. It destroys information that is necessary for handling VF reset,. It
> is also not the correct way to actually remove a VSI from an aggregator
> node. For that, we need to implement logic in the scheduler code. Further,
> non-VF VSIs properly replay their aggregator configuration using existing
> scheduler replay logic.
> 
> To fix the VF replay logic, remove this broken aggregator node cleanup
> logic. This is the simplest way to immediately fix this.
> 
> This ensures that VFs will have proper aggregate configuration after a
> reset. This is especially important since VFs often perform resets as part
> of their reconfiguration flows. Without fixing this, VFs will be placed in
> the default aggregator node and Tx bandwidth will not be shared in the
> expected and configured manner.
> 
> Fixes: 6624e780a577 ("ice: split ice_vsi_setup into smaller functions")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> This is the simplest fix to resolve the aggregator node problem. However, I
> think we should clean this up properly. I don't know why the VF VSIs have
> their own custom code for replaying aggregator configuration. I also think
> its odd that there is both structures to track aggregator information in
> ice_sched.c, but we use a separate structure in ice.h for the ice_vsi
> structure. I plan to investigate this and clean it up in next. However, I
> wanted to get a smaller fix out to net sooner rather than later.

Less is more, for now :)

Reviewed-by: Simon Horman <horms@kernel.org>

I've added Ivan to the CC list in case he wants to review this too.

> 
>  drivers/net/ethernet/intel/ice/ice_lib.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 4b1e56396293..de7ba87af45d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -2620,10 +2620,6 @@ void ice_vsi_decfg(struct ice_vsi *vsi)
>  	if (vsi->type == ICE_VSI_VF &&
>  	    vsi->agg_node && vsi->agg_node->valid)
>  		vsi->agg_node->num_vsis--;
> -	if (vsi->agg_node) {
> -		vsi->agg_node->valid = false;
> -		vsi->agg_node->agg_id = 0;
> -	}
>  }
>  
>  /**
> -- 
> 2.41.0
> 

