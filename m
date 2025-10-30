Return-Path: <netdev+bounces-234306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C973C1F353
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 10:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3839D1883BC9
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 09:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29512F6938;
	Thu, 30 Oct 2025 09:11:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7B234028F
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 09:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815466; cv=none; b=uX8/L0FwaXogMmjomRl8+p98Jvo3DGCDRRWiRP90QaDeC1lhBaHpcT9AzD6AC71W8wO5Ii80+p5N6HOShJeaLiEWtX/EKG5+ZVG04Wy89/yUzbvZehSvYtkXJXQAKOfksa+d/KUMQ069JfCi8VLEOyuOJ62/pZLcY5xD1Go2ct0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815466; c=relaxed/simple;
	bh=2GCYXMJf6XPS1BgQ7qpJDnX2pZP7wclhlffp9a8z5Jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n1jVLA4vy2Ve1TktJsLubdwJwhWCSaZpjoxCgxAXrzSMNiGp1KW+v434yILoc4XvJZvUI2ILEop6c7STWcpGkzZMqySJMTUET1z7uQkc5T23d4T0E9h8J4GzTINcDZ7QVpAv7LGilNj84bhTUw59aGYVKcYFNXtUQfIwoiGxBWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.5] (ip5f5af134.dynamic.kabel-deutschland.de [95.90.241.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 58A29617C4FA1;
	Thu, 30 Oct 2025 10:10:38 +0100 (CET)
Message-ID: <370cf4f0-c0a8-480a-939d-33c75961e587@molgen.mpg.de>
Date: Thu, 30 Oct 2025 10:10:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v3] ice: use netif_get_num_default_rss_queues()
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 aleksander.lobakin@intel.com, przemyslaw.kitszel@intel.com,
 jacob.e.keller@intel.com, Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20251030083053.2166525-1-michal.swiatkowski@linux.intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251030083053.2166525-1-michal.swiatkowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Michal,


Thank you for your patch. For the summary, I’d add:

ice: Use netif_get_num_default_rss_queues() to decrease queue number

Am 30.10.25 um 09:30 schrieb Michal Swiatkowski:
> On some high-core systems (like AMD EPYC Bergamo, Intel Clearwater
> Forest) loading ice driver with default values can lead to queue/irq
> exhaustion. It will result in no additional resources for SR-IOV.

Could you please elaborate how to make the queue/irq exhaustion visible?

> In most cases there is no performance reason for more than half
> num_cpus(). Limit the default value to it using generic
> netif_get_num_default_rss_queues().
> 
> Still, using ethtool the number of queues can be changed up to
> num_online_cpus(). It can be done by calling:
> $ethtool -L ethX combined $(nproc)
> 
> This change affects only the default queue amount.

How would you judge the regression potential, that means for people 
where the defaults work good enough, and the queue number is reduced now?


Kind regards,

Paul


> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
> v2 --> v3:
>   * use $(nproc) in command example in commit message
> 
> v1 --> v2:
>   * Follow Olek's comment and switch from custom limiting to the generic
>     netif_...() function.
>   * Add more info in commit message (Paul)
>   * Dropping RB tags, as it is different patch now
> ---
>   drivers/net/ethernet/intel/ice/ice_irq.c |  5 +++--
>   drivers/net/ethernet/intel/ice/ice_lib.c | 12 ++++++++----
>   2 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_irq.c b/drivers/net/ethernet/intel/ice/ice_irq.c
> index 30801fd375f0..1d9b2d646474 100644
> --- a/drivers/net/ethernet/intel/ice/ice_irq.c
> +++ b/drivers/net/ethernet/intel/ice/ice_irq.c
> @@ -106,9 +106,10 @@ static struct ice_irq_entry *ice_get_irq_res(struct ice_pf *pf,
>   #define ICE_RDMA_AEQ_MSIX 1
>   static int ice_get_default_msix_amount(struct ice_pf *pf)
>   {
> -	return ICE_MIN_LAN_OICR_MSIX + num_online_cpus() +
> +	return ICE_MIN_LAN_OICR_MSIX + netif_get_num_default_rss_queues() +
>   	       (test_bit(ICE_FLAG_FD_ENA, pf->flags) ? ICE_FDIR_MSIX : 0) +
> -	       (ice_is_rdma_ena(pf) ? num_online_cpus() + ICE_RDMA_AEQ_MSIX : 0);
> +	       (ice_is_rdma_ena(pf) ? netif_get_num_default_rss_queues() +
> +				      ICE_RDMA_AEQ_MSIX : 0);
>   }
>   
>   /**
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index bac481e8140d..e366d089bef9 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -159,12 +159,14 @@ static void ice_vsi_set_num_desc(struct ice_vsi *vsi)
>   
>   static u16 ice_get_rxq_count(struct ice_pf *pf)
>   {
> -	return min(ice_get_avail_rxq_count(pf), num_online_cpus());
> +	return min(ice_get_avail_rxq_count(pf),
> +		   netif_get_num_default_rss_queues());
>   }
>   
>   static u16 ice_get_txq_count(struct ice_pf *pf)
>   {
> -	return min(ice_get_avail_txq_count(pf), num_online_cpus());
> +	return min(ice_get_avail_txq_count(pf),
> +		   netif_get_num_default_rss_queues());
>   }
>   
>   /**
> @@ -907,13 +909,15 @@ static void ice_vsi_set_rss_params(struct ice_vsi *vsi)
>   		if (vsi->type == ICE_VSI_CHNL)
>   			vsi->rss_size = min_t(u16, vsi->num_rxq, max_rss_size);
>   		else
> -			vsi->rss_size = min_t(u16, num_online_cpus(),
> +			vsi->rss_size = min_t(u16,
> +					      netif_get_num_default_rss_queues(),
>   					      max_rss_size);
>   		vsi->rss_lut_type = ICE_LUT_PF;
>   		break;
>   	case ICE_VSI_SF:
>   		vsi->rss_table_size = ICE_LUT_VSI_SIZE;
> -		vsi->rss_size = min_t(u16, num_online_cpus(), max_rss_size);
> +		vsi->rss_size = min_t(u16, netif_get_num_default_rss_queues(),
> +				      max_rss_size);
>   		vsi->rss_lut_type = ICE_LUT_VSI;
>   		break;
>   	case ICE_VSI_VF:


