Return-Path: <netdev+bounces-79168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAACE878176
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 15:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90EAB281546
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 14:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AF73FB8E;
	Mon, 11 Mar 2024 14:15:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE8522079
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 14:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710166508; cv=none; b=QvfsW7aS9UKDXCvhrASXr6p5ZTsaBlaxS4rwsUzq84FYNcqP8jU+O2FV/MzUM+s/Bi4kKVHhDA/7aGc75PSz5RuS8bfFX1fEAOMmuh5Wn8XWH02EN0kcJ9hFm7gZN3JvTIKGpVPlXVKSpj2TfxqeYnP0IXzP813KW8B0gTUiLJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710166508; c=relaxed/simple;
	bh=srCuYwb4CnDayP2SxBrej0QAzIGBxZFoX7bJCq52ufg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H/W61DSXPKabVZWgo7BK+uhduLM58Enu8sD40v0jGNARyzhk7bEb2sI9X+V5obcuHnPgRSb9PriPeLrN0Xgoiy7Gt2GEF4u7jJv+bD322C3+XFY56eF5NeIgaagYnD4qZhYOCaEVYollu9wAeGtFAI/+TWEx7Nr3G6o1HiAwUww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3AC3761E5FE04;
	Mon, 11 Mar 2024 15:14:32 +0100 (CET)
Message-ID: <e7b69483-24d6-44a0-af00-fb796ba07dff@molgen.mpg.de>
Date: Mon, 11 Mar 2024 15:14:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] i40e: fix vf may be used
 uninitialized in this function warning
Content-Language: en-US
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org
References: <20240311112503.19768-1-aleksandr.loktionov@intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240311112503.19768-1-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Aleksandr,


Thank you for the patch.


Am 11.03.24 um 12:25 schrieb Aleksandr Loktionov:
> To fix the regression introduced by 52424f974bc5 commit, wchich causes

1.  by commit 52424f974bc5
2.  s/wchich/which/

> servers hang in very hard to reproduce conditions with resets races.

Is there a public report for this?

> Remove redundant "v" variable and iterate via single VF pointer across
> whole function instead to guarantee VF pointer validity.

Could you please elaborate how the VF pointer currently gets invalid?


Kind regards,

Paul


> Fixes: 52424f974bc5 ("i40e: Fix VF hang when reset is triggered on another VF")
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>   .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 34 +++++++++----------
>   1 file changed, 16 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index b34c717..f7c4654 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -1628,105 +1628,103 @@ bool i40e_reset_all_vfs(struct i40e_pf *pf, bool flr)
>   {
>   	struct i40e_hw *hw = &pf->hw;
>   	struct i40e_vf *vf;
> -	int i, v;
>   	u32 reg;
> +	int i;
>   
>   	/* If we don't have any VFs, then there is nothing to reset */
>   	if (!pf->num_alloc_vfs)
>   		return false;
>   
>   	/* If VFs have been disabled, there is no need to reset */
>   	if (test_and_set_bit(__I40E_VF_DISABLE, pf->state))
>   		return false;
>   
>   	/* Begin reset on all VFs at once */
> -	for (v = 0; v < pf->num_alloc_vfs; v++) {
> -		vf = &pf->vf[v];
> +	for (vf = &pf->vf[0]; vf < &pf->vf[pf->num_alloc_vfs]; ++vf) {

Shouldn’t pointer arithmetic be avoided?

>   		/* If VF is being reset no need to trigger reset again */
>   		if (!test_bit(I40E_VF_STATE_RESETTING, &vf->vf_states))
> -			i40e_trigger_vf_reset(&pf->vf[v], flr);
> +			i40e_trigger_vf_reset(vf, flr);
>   	}
>   
>   	/* HW requires some time to make sure it can flush the FIFO for a VF
>   	 * when it resets it. Poll the VPGEN_VFRSTAT register for each VF in
>   	 * sequence to make sure that it has completed. We'll keep track of
>   	 * the VFs using a simple iterator that increments once that VF has
>   	 * finished resetting.
>   	 */
> -	for (i = 0, v = 0; i < 10 && v < pf->num_alloc_vfs; i++) {
> +	for (i = 0, vf = &pf->vf[0]; i < 10 && vf < &pf->vf[pf->num_alloc_vfs]; ++i) {
>   		usleep_range(10000, 20000);
>   
>   		/* Check each VF in sequence, beginning with the VF to fail
>   		 * the previous check.
>   		 */
> -		while (v < pf->num_alloc_vfs) {
> -			vf = &pf->vf[v];
> +		while (vf < &pf->vf[pf->num_alloc_vfs]) {
>   			if (!test_bit(I40E_VF_STATE_RESETTING, &vf->vf_states)) {
>   				reg = rd32(hw, I40E_VPGEN_VFRSTAT(vf->vf_id));
>   				if (!(reg & I40E_VPGEN_VFRSTAT_VFRD_MASK))
>   					break;
>   			}
>   
>   			/* If the current VF has finished resetting, move on
>   			 * to the next VF in sequence.
>   			 */
> -			v++;
> +			++vf;
>   		}
>   	}
>   
>   	if (flr)
>   		usleep_range(10000, 20000);
>   
>   	/* Display a warning if at least one VF didn't manage to reset in
>   	 * time, but continue on with the operation.
>   	 */
> -	if (v < pf->num_alloc_vfs)
> +	if (vf < &pf->vf[pf->num_alloc_vfs])
>   		dev_err(&pf->pdev->dev, "VF reset check timeout on VF %d\n",
> -			pf->vf[v].vf_id);
> +			vf->vf_id);
>   	usleep_range(10000, 20000);
>   
>   	/* Begin disabling all the rings associated with VFs, but do not wait
>   	 * between each VF.
>   	 */
> -	for (v = 0; v < pf->num_alloc_vfs; v++) {
> +	for (vf = &pf->vf[0]; vf < &pf->vf[pf->num_alloc_vfs]; ++vf) {
>   		/* On initial reset, we don't have any queues to disable */
> -		if (pf->vf[v].lan_vsi_idx == 0)
> +		if (vf->lan_vsi_idx == 0)
>   			continue;
>   
>   		/* If VF is reset in another thread just continue */
>   		if (test_bit(I40E_VF_STATE_RESETTING, &vf->vf_states))
>   			continue;
>   
> -		i40e_vsi_stop_rings_no_wait(pf->vsi[pf->vf[v].lan_vsi_idx]);
> +		i40e_vsi_stop_rings_no_wait(pf->vsi[vf->lan_vsi_idx]);
>   	}
>   
>   	/* Now that we've notified HW to disable all of the VF rings, wait
>   	 * until they finish.
>   	 */
> -	for (v = 0; v < pf->num_alloc_vfs; v++) {
> +	for (vf = &pf->vf[0]; vf < &pf->vf[pf->num_alloc_vfs]; ++vf) {
>   		/* On initial reset, we don't have any queues to disable */
> -		if (pf->vf[v].lan_vsi_idx == 0)
> +		if (vf->lan_vsi_idx == 0)
>   			continue;
>   
>   		/* If VF is reset in another thread just continue */
>   		if (test_bit(I40E_VF_STATE_RESETTING, &vf->vf_states))
>   			continue;
>   
> -		i40e_vsi_wait_queues_disabled(pf->vsi[pf->vf[v].lan_vsi_idx]);
> +		i40e_vsi_wait_queues_disabled(pf->vsi[vf->lan_vsi_idx]);
>   	}
>   
>   	/* Hw may need up to 50ms to finish disabling the RX queues. We
>   	 * minimize the wait by delaying only once for all VFs.
>   	 */
>   	mdelay(50);
>   
>   	/* Finish the reset on each VF */
> -	for (v = 0; v < pf->num_alloc_vfs; v++) {
> +	for (vf = &pf->vf[0]; vf < &pf->vf[pf->num_alloc_vfs]; ++vf) {
>   		/* If VF is reset in another thread just continue */
>   		if (test_bit(I40E_VF_STATE_RESETTING, &vf->vf_states))
>   			continue;
>   
> -		i40e_cleanup_reset_vf(&pf->vf[v]);
> +		i40e_cleanup_reset_vf(vf);
>   	}
>   
>   	i40e_flush(hw);

