Return-Path: <netdev+bounces-92145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A978B5963
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 15:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E347228B475
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 13:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301C36BB28;
	Mon, 29 Apr 2024 13:05:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E620C757ED
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 13:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395939; cv=none; b=d4PDd5Gnr0J5Zpd7aPerLV6hbVc/h5e0oZguK3Ysnb8RRdQ7C0BSutns0MAnsVLFOvvYmmo1cbT1Maew+Kcvs9URTVcXSL9kSlPH9dWGwNaLkzbEo+NEdxNOketmDv4svHy0u08q7MYgbC45bH6tOMe4tt2/tymvlWg0KPV3bBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395939; c=relaxed/simple;
	bh=DhIhe275/a7Hm3ihMZDnuxj3VuwFE5PaSVUOv8jWB/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r1YcR2h9fkHF9VeFg+Ja4c0rgBAX0F2ripFfLiQvcy3FDgq0hEtNNuxyQUE/VMdKAc+yd46wRdnrazdEHXBWAolQVEybyGKs3CDi+JwlKw9iNeVBn1oFKvfVGYCzbquRPxuW28VzSP2eiE/S9364uPXAi+Xc7OroRwWOyns1CR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5aed0f.dynamic.kabel-deutschland.de [95.90.237.15])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id E0E0861E5FE05;
	Mon, 29 Apr 2024 15:04:48 +0200 (CEST)
Message-ID: <a0359435-7e0f-4a48-9cc6-3db679bde1ac@molgen.mpg.de>
Date: Mon, 29 Apr 2024 15:04:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v2] ice: Fix enabling SR-IOV with Xen
To: Ross Lagerwall <ross.lagerwall@citrix.com>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Javi Merino <javi.merino@kernel.org>, intel-wired-lan@lists.osuosl.org
References: <20240429124922.2872002-1-ross.lagerwall@citrix.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240429124922.2872002-1-ross.lagerwall@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Ross,


Thank you for your patch.

Am 29.04.24 um 14:49 schrieb Ross Lagerwall:
> When the PCI functions are created, Xen is informed about them and
> caches the number of MSI-X entries each function has.  However, the
> number of MSI-X entries is not set until after the hardware has been
> configured and the VFs have been started. This prevents
> PCI-passthrough from working because Xen rejects mapping MSI-X
> interrupts to domains because it thinks the MSI-X interrupts don't
> exist.

Thank you for this great problem description. Is there any log message 
shown, you could paste, so people can find this commit when searching 
for the log message?

Do you have a minimal test case, so the maintainers can reproduce this 
to test the fix?

> Fix this by moving the call to pci_enable_sriov() later so that the
> number of MSI-X entries is set correctly in hardware by the time Xen
> reads it.

It’d be great if you could be more specific on “later”, and why this is 
the correct place.

> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
> Signed-off-by: Javi Merino <javi.merino@kernel.org>
> ---
> 
> In v2:
> * Fix cleanup on if pci_enable_sriov() fails.
> 
>   drivers/net/ethernet/intel/ice/ice_sriov.c | 23 +++++++++++++---------
>   1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index a958fcf3e6be..bc97493046a8 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -864,6 +864,8 @@ static int ice_ena_vfs(struct ice_pf *pf, u16 num_vfs)
>   	int total_vectors = pf->hw.func_caps.common_cap.num_msix_vectors;
>   	struct device *dev = ice_pf_to_dev(pf);
>   	struct ice_hw *hw = &pf->hw;
> +	struct ice_vf *vf;
> +	unsigned int bkt;
>   	int ret;
>   
>   	pf->sriov_irq_bm = bitmap_zalloc(total_vectors, GFP_KERNEL);
> @@ -877,24 +879,20 @@ static int ice_ena_vfs(struct ice_pf *pf, u16 num_vfs)
>   	set_bit(ICE_OICR_INTR_DIS, pf->state);
>   	ice_flush(hw);
>   
> -	ret = pci_enable_sriov(pf->pdev, num_vfs);
> -	if (ret)
> -		goto err_unroll_intr;
> -
>   	mutex_lock(&pf->vfs.table_lock);
>   
>   	ret = ice_set_per_vf_res(pf, num_vfs);
>   	if (ret) {
>   		dev_err(dev, "Not enough resources for %d VFs, err %d. Try with fewer number of VFs\n",
>   			num_vfs, ret);
> -		goto err_unroll_sriov;
> +		goto err_unroll_intr;
>   	}
>   
>   	ret = ice_create_vf_entries(pf, num_vfs);
>   	if (ret) {
>   		dev_err(dev, "Failed to allocate VF entries for %d VFs\n",
>   			num_vfs);
> -		goto err_unroll_sriov;
> +		goto err_unroll_intr;
>   	}
>   
>   	ice_eswitch_reserve_cp_queues(pf, num_vfs);
> @@ -905,6 +903,10 @@ static int ice_ena_vfs(struct ice_pf *pf, u16 num_vfs)
>   		goto err_unroll_vf_entries;
>   	}
>   
> +	ret = pci_enable_sriov(pf->pdev, num_vfs);
> +	if (ret)
> +		goto err_unroll_start_vfs;
> +
>   	clear_bit(ICE_VF_DIS, pf->state);
>   
>   	/* rearm global interrupts */
> @@ -915,12 +917,15 @@ static int ice_ena_vfs(struct ice_pf *pf, u16 num_vfs)
>   
>   	return 0;
>   
> +err_unroll_start_vfs:
> +	ice_for_each_vf(pf, bkt, vf) {
> +		ice_dis_vf_mappings(vf);
> +		ice_vf_vsi_release(vf);
> +	}

Why wasn’t this needed with `pci_enable_sriov()` done earlier?

>   err_unroll_vf_entries:
>   	ice_free_vf_entries(pf);
> -err_unroll_sriov:
> -	mutex_unlock(&pf->vfs.table_lock);
> -	pci_disable_sriov(pf->pdev);
>   err_unroll_intr:
> +	mutex_unlock(&pf->vfs.table_lock);
>   	/* rearm interrupts here */
>   	ice_irq_dynamic_ena(hw, NULL, NULL);
>   	clear_bit(ICE_OICR_INTR_DIS, pf->state);


Kind regards,

Paul

