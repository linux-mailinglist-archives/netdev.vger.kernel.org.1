Return-Path: <netdev+bounces-229899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBBFBE1F96
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 09:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F24AA4E5B01
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 07:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526E32D6E72;
	Thu, 16 Oct 2025 07:45:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2492FCBF0
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 07:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760600714; cv=none; b=AspsXqe1JtnIC5/8dGSe8K9i/OVG9ll4owLKhNf67oag4hRFHkZqxc7DbdkHNzrz+yd9yk/lOQ28W6Gtgn4BXCLbWDzcNaZ0Wcb9PYlday8u7T+phEYCeMC/JFVxclK4zekbQMYr8UTIou4JRwZh6LaJiqGcmd4RuI8yiI0054M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760600714; c=relaxed/simple;
	bh=7Rq/cFGzAixSyJpF73D7NqwQWxpESCN2Fo1RUPNHJS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kvClQ34MT8iJFfVBnPChX6KKVP3ulFuqXmKb0tEUIOUHm2jdToqCvlLec2PtgbZ8xIKFRPAFtVIob1+5Rth3T3jyaB1604YGRpQYJ42INbG1Ud47SvzcH1Vw1HMtgROMLigT8TcGt5ACrzfpnzDAf8DmpnyE2cYPPLVyfICNP6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.212] (p5dc5567b.dip0.t-ipconnect.de [93.197.86.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id A22AC6028F36A;
	Thu, 16 Oct 2025 09:44:44 +0200 (CEST)
Message-ID: <d6a90d0d-55f9-467a-b414-5ced78d12c54@molgen.mpg.de>
Date: Thu, 16 Oct 2025 09:44:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] ice: lower default
 irq/queue counts on high-core systems
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Jacob Keller <jacob.e.keller@intel.com>
References: <20251016062250.1461903-1-michal.swiatkowski@linux.intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251016062250.1461903-1-michal.swiatkowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Michal,


Thank you for the patch. I’d mention the 64 in the summary:

 > ice: lower default irq/queue counts to 64 on > 64 core systems


Am 16.10.25 um 08:22 schrieb Michal Swiatkowski:
> On some high-core systems loading ice driver with default values can
> lead to queue/irq exhaustion. It will result in no additional resources
> for SR-IOV.
> 
> In most cases there is no performance reason for more than 64 queues.
> Limit the default value to 64. Still, using ethtool the number of
> queues can be changed up to num_online_cpus().
> 
> This change affects only the default queue amount on systems with more
> than 64 cores.

Please document a specific system and steps to reproduce the issue.

Please also document how to override the value.

> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice.h     | 20 ++++++++++++++++++++
>   drivers/net/ethernet/intel/ice/ice_irq.c |  6 ++++--
>   drivers/net/ethernet/intel/ice/ice_lib.c |  8 ++++----
>   3 files changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index 3d4d8b88631b..354ec2950ff3 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -1133,4 +1133,24 @@ static inline struct ice_hw *ice_get_primary_hw(struct ice_pf *pf)
>   	else
>   		return &pf->adapter->ctrl_pf->hw;
>   }
> +
> +/**
> + * ice_capped_num_cpus - normalize the number of CPUs to a reasonable limit
> + *
> + * This function returns the number of online CPUs, but caps it at suitable
> + * default to prevent excessive resource allocation on systems with very high
> + * CPU counts.
> + *
> + * Note: suitable default is currently at 64, which is reflected in default_cpus
> + * constant. In most cases there is no much benefit for more than 64 and it is a

no*t* much

> + * power of 2 number.
> + *
> + * Return: number of online CPUs, capped at suitable default.
> + */
> +static inline u16 ice_capped_num_cpus(void)

Why not return `unsigned int` or `size_t`?

> +{
> +	const int default_cpus = 64;
> +
> +	return min(num_online_cpus(), default_cpus);
> +}
>   #endif /* _ICE_H_ */
> diff --git a/drivers/net/ethernet/intel/ice/ice_irq.c b/drivers/net/ethernet/intel/ice/ice_irq.c
> index 30801fd375f0..df4d847ca858 100644
> --- a/drivers/net/ethernet/intel/ice/ice_irq.c
> +++ b/drivers/net/ethernet/intel/ice/ice_irq.c
> @@ -106,9 +106,11 @@ static struct ice_irq_entry *ice_get_irq_res(struct ice_pf *pf,
>   #define ICE_RDMA_AEQ_MSIX 1
>   static int ice_get_default_msix_amount(struct ice_pf *pf)
>   {
> -	return ICE_MIN_LAN_OICR_MSIX + num_online_cpus() +
> +	u16 cpus = ice_capped_num_cpus();
> +
> +	return ICE_MIN_LAN_OICR_MSIX + cpus +
>   	       (test_bit(ICE_FLAG_FD_ENA, pf->flags) ? ICE_FDIR_MSIX : 0) +
> -	       (ice_is_rdma_ena(pf) ? num_online_cpus() + ICE_RDMA_AEQ_MSIX : 0);
> +	       (ice_is_rdma_ena(pf) ? cpus + ICE_RDMA_AEQ_MSIX : 0);
>   }
>   
>   /**
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index bac481e8140d..3c5f8a4b6c6d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -159,12 +159,12 @@ static void ice_vsi_set_num_desc(struct ice_vsi *vsi)
>   
>   static u16 ice_get_rxq_count(struct ice_pf *pf)
>   {
> -	return min(ice_get_avail_rxq_count(pf), num_online_cpus());
> +	return min(ice_get_avail_rxq_count(pf), ice_capped_num_cpus());
>   }
>   
>   static u16 ice_get_txq_count(struct ice_pf *pf)
>   {
> -	return min(ice_get_avail_txq_count(pf), num_online_cpus());
> +	return min(ice_get_avail_txq_count(pf), ice_capped_num_cpus());
>   }
>   
>   /**
> @@ -907,13 +907,13 @@ static void ice_vsi_set_rss_params(struct ice_vsi *vsi)
>   		if (vsi->type == ICE_VSI_CHNL)
>   			vsi->rss_size = min_t(u16, vsi->num_rxq, max_rss_size);
>   		else
> -			vsi->rss_size = min_t(u16, num_online_cpus(),
> +			vsi->rss_size = min_t(u16, ice_capped_num_cpus(),
>   					      max_rss_size);
>   		vsi->rss_lut_type = ICE_LUT_PF;
>   		break;
>   	case ICE_VSI_SF:
>   		vsi->rss_table_size = ICE_LUT_VSI_SIZE;
> -		vsi->rss_size = min_t(u16, num_online_cpus(), max_rss_size);
> +		vsi->rss_size = min_t(u16, ice_capped_num_cpus(), max_rss_size);
>   		vsi->rss_lut_type = ICE_LUT_VSI;
>   		break;
>   	case ICE_VSI_VF:

With the changes addressed, feel free to add:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

