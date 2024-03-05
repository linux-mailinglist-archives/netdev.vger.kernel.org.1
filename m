Return-Path: <netdev+bounces-77506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F23871FE4
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 14:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66FA51C25237
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 13:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DCD85931;
	Tue,  5 Mar 2024 13:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRUUlcGm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802F759B76
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 13:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709644629; cv=none; b=tNJ3if8wqxxKlIE40UevkMTtkvOmvhs+8D34Qv8A+AKHl4vRvhhFhUxhKFDFi1S77iP6FP1OULvK/HT/LVFq03J8VK/2JzI7zUABQZFbqFcsOFVf1KQlNxybAy25P6ECMsVBAi8gdHZaeEGrW3E91mYbhT00ai8F/Jd9g9KM9Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709644629; c=relaxed/simple;
	bh=Afd4CESzX64lLwTm+lUvri9E644vZeX1CCKpS8xPEF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1hP7anOOUhklDo4VtL06p75EHXWJnDOigYLS+NvVCC21XdOLzppDuDQRrVtpOhzgcjR/f+lpN05khJYdpnKn9itGquo84MXdmwkQcl3P39dYW3n0bRsXo/Npn53HKlDC7EIeR2EaDrbqCOKYHXlh+gV1SA6yrXwqjMS+tcf0Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRUUlcGm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1CB2C433F1;
	Tue,  5 Mar 2024 13:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709644629;
	bh=Afd4CESzX64lLwTm+lUvri9E644vZeX1CCKpS8xPEF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RRUUlcGmb168v4WyLzbcWG1MhrL5wqK4Yx24qoszeOafcHFVl0miNEQt6zaOtV1y/
	 uoZ5JHSKU2gB5BYGZ2IbFBKc+U0jyUMQXMyYeVsT5yAe4vD/30sWb/EHUOOPQ3nz90
	 oTs7aYmjsQJuiEg7/+34Ri9ROi55IoOcqfq2VydLvzcMIg78+s6LxuIS5MKxdOKkDh
	 k/fiZf6alwwPNMBFRq7TMOlELTBvcHXDu2qnzleEy1vbHZ1cNmB+OHmOa5wQL+lf2v
	 DaEjIAzf2VWx1v5GLYleSXHT47112nnx7v/3qZkOVdX5cQPWisFNZ7gsjmCo5P9cY9
	 hfx5xY1sqM5mQ==
Date: Tue, 5 Mar 2024 13:17:04 +0000
From: Simon Horman <horms@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Robert Elliott <elliott@hpe.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: Re: [PATCH iwl-net v1] ice: fix bug with suspend and rebuild
Message-ID: <20240305131704.GD2357@kernel.org>
References: <20240304230845.14934-1-jesse.brandeburg@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304230845.14934-1-jesse.brandeburg@intel.com>

On Mon, Mar 04, 2024 at 03:08:44PM -0800, Jesse Brandeburg wrote:
> The ice driver would previously panic during suspend. This is caused
> from the driver *only* calling the ice_vsi_free_q_vectors() function by
> itself, when it is suspending. Since commit b3e7b3a6ee92 ("ice: prevent
> NULL pointer deref during reload") the driver has zeroed out
> num_q_vectors, and only restored it in ice_vsi_cfg_def().
> 
> This further causes the ice_rebuild() function to allocate a zero length
> buffer, after which num_q_vectors is updated, and then the new value of
> num_q_vectors is used to index into the zero length buffer, which
> corrupts memory.
> 
> The fix entails making sure all the code referencing num_q_vectors only
> does so after it has been reset via ice_vsi_cfg_def().
> 
> I didn't perform a full bisect, but I was able to test against 6.1.77
> kernel and that ice driver works fine for suspend/resume with no panic,
> so sometime since then, this problem was introduced.
> 
> Also clean up an un-needed init of a local variable in the function
> being modified.
> 
> PANIC from 6.8.0-rc1:
> 
> [1026674.915596] PM: suspend exit
> [1026675.664697] ice 0000:17:00.1: PTP reset successful
> [1026675.664707] ice 0000:17:00.1: 2755 msecs passed between update to cached PHC time
> [1026675.667660] ice 0000:b1:00.0: PTP reset successful
> [1026675.675944] ice 0000:b1:00.0: 2832 msecs passed between update to cached PHC time
> [1026677.137733] ixgbe 0000:31:00.0 ens787: NIC Link is Up 1 Gbps, Flow Control: None
> [1026677.190201] BUG: kernel NULL pointer dereference, address: 0000000000000010
> [1026677.192753] ice 0000:17:00.0: PTP reset successful
> [1026677.192764] ice 0000:17:00.0: 4548 msecs passed between update to cached PHC time
> [1026677.197928] #PF: supervisor read access in kernel mode
> [1026677.197933] #PF: error_code(0x0000) - not-present page
> [1026677.197937] PGD 1557a7067 P4D 0
> [1026677.212133] ice 0000:b1:00.1: PTP reset successful
> [1026677.212143] ice 0000:b1:00.1: 4344 msecs passed between update to cached PHC time
> [1026677.212575]
> [1026677.243142] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [1026677.247918] CPU: 23 PID: 42790 Comm: kworker/23:0 Kdump: loaded Tainted: G        W          6.8.0-rc1+ #1
> [1026677.257989] Hardware name: Intel Corporation M50CYP2SBSTD/M50CYP2SBSTD, BIOS SE5C620.86B.01.01.0005.2202160810 02/16/2022
> [1026677.269367] Workqueue: ice ice_service_task [ice]
> [1026677.274592] RIP: 0010:ice_vsi_rebuild_set_coalesce+0x130/0x1e0 [ice]
> [1026677.281421] Code: 0f 84 3a ff ff ff 41 0f b7 74 ec 02 66 89 b0 22 02 00 00 81 e6 ff 1f 00 00 e8 ec fd ff ff e9 35 ff ff ff 48 8b 43 30 49 63 ed <41> 0f b7 34 24 41 83 c5 01 48 8b 3c e8 66 89 b7 aa 02 00 00 81 e6
> [1026677.300877] RSP: 0018:ff3be62a6399bcc0 EFLAGS: 00010202
> [1026677.306556] RAX: ff28691e28980828 RBX: ff28691e41099828 RCX: 0000000000188000
> [1026677.314148] RDX: 0000000000000000 RSI: 0000000000000010 RDI: ff28691e41099828
> [1026677.321730] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> [1026677.329311] R10: 0000000000000007 R11: ffffffffffffffc0 R12: 0000000000000010
> [1026677.336896] R13: 0000000000000000 R14: 0000000000000000 R15: ff28691e0eaa81a0
> [1026677.344472] FS:  0000000000000000(0000) GS:ff28693cbffc0000(0000) knlGS:0000000000000000
> [1026677.353000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [1026677.359195] CR2: 0000000000000010 CR3: 0000000128df4001 CR4: 0000000000771ef0
> [1026677.366779] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [1026677.374369] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [1026677.381952] PKRU: 55555554
> [1026677.385116] Call Trace:
> [1026677.388023]  <TASK>
> [1026677.390589]  ? __die+0x20/0x70
> [1026677.394105]  ? page_fault_oops+0x82/0x160
> [1026677.398576]  ? do_user_addr_fault+0x65/0x6a0
> [1026677.403307]  ? exc_page_fault+0x6a/0x150
> [1026677.407694]  ? asm_exc_page_fault+0x22/0x30
> [1026677.412349]  ? ice_vsi_rebuild_set_coalesce+0x130/0x1e0 [ice]
> [1026677.418614]  ice_vsi_rebuild+0x34b/0x3c0 [ice]
> [1026677.423583]  ice_vsi_rebuild_by_type+0x76/0x180 [ice]
> [1026677.429147]  ice_rebuild+0x18b/0x520 [ice]
> [1026677.433746]  ? delay_tsc+0x8f/0xc0
> [1026677.437630]  ice_do_reset+0xa3/0x190 [ice]
> [1026677.442231]  ice_service_task+0x26/0x440 [ice]
> [1026677.447180]  process_one_work+0x174/0x340
> [1026677.451669]  worker_thread+0x27e/0x390
> [1026677.455890]  ? __pfx_worker_thread+0x10/0x10
> [1026677.460627]  kthread+0xee/0x120
> [1026677.464235]  ? __pfx_kthread+0x10/0x10
> [1026677.468445]  ret_from_fork+0x2d/0x50
> [1026677.472476]  ? __pfx_kthread+0x10/0x10
> [1026677.476671]  ret_from_fork_asm+0x1b/0x30
> [1026677.481050]  </TASK>
> 
> Fixes: b3e7b3a6ee92 ("ice: prevent NULL pointer deref during reload")
> Reported-by: Robert Elliott <elliott@hpe.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 097bf8fd6bf0..0f5a92a6b1e6 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -3238,7 +3238,7 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
>  {
>  	struct ice_vsi_cfg_params params = {};
>  	struct ice_coalesce_stored *coalesce;
> -	int prev_num_q_vectors = 0;
> +	int prev_num_q_vectors;
>  	struct ice_pf *pf;
>  	int ret;
>  
> @@ -3252,13 +3252,6 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
>  	if (WARN_ON(vsi->type == ICE_VSI_VF && !vsi->vf))
>  		return -EINVAL;
>  
> -	coalesce = kcalloc(vsi->num_q_vectors,
> -			   sizeof(struct ice_coalesce_stored), GFP_KERNEL);
> -	if (!coalesce)
> -		return -ENOMEM;
> -
> -	prev_num_q_vectors = ice_vsi_rebuild_get_coalesce(vsi, coalesce);
> -
>  	ret = ice_vsi_realloc_stat_arrays(vsi);
>  	if (ret)
>  		goto err_vsi_cfg;
> @@ -3268,6 +3261,13 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
>  	if (ret)
>  		goto err_vsi_cfg;

Hi Jesse,

the label above will result in a call to kfree(coalesce).
However, coalesce is now uninitialised until the following line executes.

>  
> +	coalesce = kcalloc(vsi->num_q_vectors,
> +			   sizeof(struct ice_coalesce_stored), GFP_KERNEL);
> +	if (!coalesce)
> +		return -ENOMEM;
> +
> +	prev_num_q_vectors = ice_vsi_rebuild_get_coalesce(vsi, coalesce);
> +
>  	ret = ice_vsi_cfg_tc_lan(pf, vsi);
>  	if (ret) {
>  		if (vsi_flags & ICE_VSI_FLAG_INIT) {
> 
> base-commit: 6923134fc6b62d7909169b3ad913ab72ee04233a

-- 
pw-bot: changes-requested

