Return-Path: <netdev+bounces-78105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A925C874120
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 21:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 211EA1F25CD1
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 20:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD111428F8;
	Wed,  6 Mar 2024 20:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFxH8RI8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C837A1428EC
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 20:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709755473; cv=none; b=IfMByT2LX4qJLtbVVBWAc4k0A3EILO9Z3PI5Y/3bjcxiC49/pUPgdNWv59fesze6bkEbgO6C8fVbfYyy+051yRy91LFbxjfGi/NJzXgpWNYQVBkmpQtFDr+HHHFLs4SD1w3mgI+oVutxCKOb/JeYbBBRf1VSLrRyX+sAkQhFtU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709755473; c=relaxed/simple;
	bh=Xh5X2Zm7c9a45kdOcFtBMuh4AQiLV1jCQ8Q5eBO4MYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpQFvN1gXcQ4ohvfErVcDFiY2ZPcLKjaviYAECIZwgdeUf7bo2lrtOtpGzE3j65Ez7ahMNJ15PUvLZEy/RHKiR99rTFJG5CBY6XFhBb2AGbBU/34LV8bkQ8Id0tBCV29jg0mbRF25MruTfkMZk0AZC4m7cHdF9AZ97lpuDj7x/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFxH8RI8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E04CC43390;
	Wed,  6 Mar 2024 20:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709755473;
	bh=Xh5X2Zm7c9a45kdOcFtBMuh4AQiLV1jCQ8Q5eBO4MYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CFxH8RI8Ll9bL6LDY7NDaf3lmx2Ue1uhkmZfJvPzUXTJF/ceVSt0KnO+k9zwcHKFt
	 lZfRinZ1f1T8lRu5/WuDovwv2kVflOeTlm4j6VXs9FtWRIFg+0c6S5ZtwVLOXHE4AG
	 lK43ha96++kKI4y4D1Uvg3qJI7anc38eE5OGkF5BP2e/q9vuwwLTkMEZ3ioqLJOZM8
	 YpbOqYvjm46YQpYFCy2xi6XDtvyn5Z8gpKoulKv/zHdhQ51E/4UamBmXgd3vbtU2AB
	 0oIvLUjZNNg5koPZsSAPDDvw2RTUUITJnW4b/Lm1e0c5EyOchIWWdFOPybewSUKX/2
	 IWSZLnNZ5UccA==
Date: Wed, 6 Mar 2024 20:04:28 +0000
From: Simon Horman <horms@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: pmenzel@molgen.mpg.de, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, Robert Elliott <elliott@hpe.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-net v2] ice: fix memory corruption bug with suspend
 and rebuild
Message-ID: <20240306200428.GG281974@kernel.org>
References: <20240305230204.448724-1-jesse.brandeburg@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305230204.448724-1-jesse.brandeburg@intel.com>

On Tue, Mar 05, 2024 at 03:02:03PM -0800, Jesse Brandeburg wrote:
> The ice driver would previously panic after suspend. This is caused
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
> v2: fix uninitialized coalesce pointer on the exit path by moving the
> kfree to the later goto (simon), reword commit message (paul)

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index fc23dbe302b4..cfc20684f25a 100644
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
> @@ -3286,8 +3286,8 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
>  
>  err_vsi_cfg_tc_lan:
>  	ice_vsi_decfg(vsi);
> -err_vsi_cfg:
>  	kfree(coalesce);
> +err_vsi_cfg:

FWIIW, I might have dropped the err_vsi_cfg label all together
and simply returned at points that previously used it.

But that would not be functionally different to what you have done.

>  	return ret;
>  }

...

