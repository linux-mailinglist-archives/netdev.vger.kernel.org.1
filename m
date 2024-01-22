Return-Path: <netdev+bounces-64666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F91836356
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 13:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F6911F21BC5
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 12:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726F638392;
	Mon, 22 Jan 2024 12:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K5yJbjiM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF373C68A
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 12:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705926992; cv=none; b=hj6PnzNn26+FJevIoklfrT1BHFL669fOMgQiiOKg7drJeM829EZN0r9JEXdJpMRI+xpwoJFctqrM09SH5JVKznYijN3YedBfiCf/Z8QZ0iRf4Z3Gh0eZhSBkdIzdjaVHXhMCbACXh2XKxCKuVEQV6VmzAec1+LPjHGfvnB3A/4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705926992; c=relaxed/simple;
	bh=FonPDTkq8bm+MzOhIHp03CNgxfktHG90NHq3K6u9+R8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pm/6T4Xtb9FPb8G3gM03GgNsv12qPosUiyuw9zdTeSybdFVRX03YCHs/fF4e+uk5C+i9vx6SnPqIQJx/TGhPcTtTKeawIu/pMHU3JOguYI514KCZAbfvZww5c36tJh4gvBQvr4MpJXcJePdLDwDlJ+CIV5GwYjSKZcq8t/qVAsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K5yJbjiM; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705926990; x=1737462990;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FonPDTkq8bm+MzOhIHp03CNgxfktHG90NHq3K6u9+R8=;
  b=K5yJbjiMoe8G5tIlrvexuyZzl4uOT+v3M15OiAjxMa+bGZGRK70eFLcd
   gy0LLNcwqYMqQJOHkaQv4cSWx4kHrToy0D3OLSeKZs1gqdqHh/aG3EoFR
   xZ4jxUQUFvS3HVFG2cInbIOKLP215hWQDj+/zq2VlfbBJhEcmK0B/UIg/
   64+uCMB8uhAwOW0ynjASKNXKqRr+tqiIQ0yFW6E3TQOMt2qNF7Lt70pAw
   iDa5Sp5MrP7TMbMAoFNtKlX0O6HA3uuYPrUHsqyrhhzrYUd5w0CtfqBqQ
   LQvInW2qymXmsRaNASSWFw6d1UyCZsI8l3btG8K/H/y3EttEdwPpxlKH7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="8569488"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="8569488"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 04:36:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="19973510"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.237.140.122]) ([10.237.140.122])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 04:36:28 -0800
Message-ID: <324a30c2-c4a0-487e-bad9-9977c6e503ba@linux.intel.com>
Date: Mon, 22 Jan 2024 13:36:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: Add check for lport
 extraction to LAG init
Content-Language: en-US
To: Dave Ertman <david.m.ertman@intel.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20240119211517.127142-1-david.m.ertman@intel.com>
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20240119211517.127142-1-david.m.ertman@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 19.01.2024 22:15, Dave Ertman wrote:
> To fully support initializing the LAG support code, a DDP package that
> extracts the logical port from the metadata is required.  If such a
> package is not present, there could be difficulties in supporting some
> bond types.
> 
> Add a check into the initialization flow that will bypass the new paths
> if any of the support pieces are missing.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>

> Fixes: df006dd4b1dc ("ice: Add initial support framework for LAG")
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lag.c | 25 ++++++++++++++++++++++--
>  drivers/net/ethernet/intel/ice/ice_lag.h |  3 +++
>  2 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
> index 2a25323105e5..467372d541d2 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lag.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lag.c
> @@ -151,6 +151,27 @@ ice_lag_find_hw_by_lport(struct ice_lag *lag, u8 lport)
>  	return NULL;
>  }
>  
> +/**
> + * ice_pkg_has_lport_extract - check if lport extraction supported
> + * @hw: HW struct
> + */
> +static bool ice_pkg_has_lport_extract(struct ice_hw *hw)
> +{
> +	int i;
> +
> +	for (i = 0; i < hw->blk[ICE_BLK_SW].es.count; i++) {
> +		u16 offset;
> +		u8 fv_prot;
> +
> +		ice_find_prot_off(hw, ICE_BLK_SW, ICE_SW_DEFAULT_PROFILE, i,
> +				  &fv_prot, &offset);
> +		if (fv_prot == ICE_FV_PROT_MDID &&
> +		    offset == ICE_LP_EXT_BUF_OFFSET)
> +			return true;
> +	}
> +	return false;
> +}
> +
>  /**
>   * ice_lag_find_primary - returns pointer to primary interfaces lag struct
>   * @lag: local interfaces lag struct
> @@ -1206,7 +1227,7 @@ static void ice_lag_del_prune_list(struct ice_lag *lag, struct ice_pf *event_pf)
>  }
>  
>  /**
> - * ice_lag_init_feature_support_flag - Check for NVM support for LAG
> + * ice_lag_init_feature_support_flag - Check for package and NVM support for LAG
>   * @pf: PF struct
>   */
>  static void ice_lag_init_feature_support_flag(struct ice_pf *pf)
> @@ -1219,7 +1240,7 @@ static void ice_lag_init_feature_support_flag(struct ice_pf *pf)
>  	else
>  		ice_clear_feature_support(pf, ICE_F_ROCE_LAG);
>  
> -	if (caps->sriov_lag)
> +	if (caps->sriov_lag && ice_pkg_has_lport_extract(&pf->hw))
>  		ice_set_feature_support(pf, ICE_F_SRIOV_LAG);
>  	else
>  		ice_clear_feature_support(pf, ICE_F_SRIOV_LAG);
> diff --git a/drivers/net/ethernet/intel/ice/ice_lag.h b/drivers/net/ethernet/intel/ice/ice_lag.h
> index ede833dfa658..183b38792ef2 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lag.h
> +++ b/drivers/net/ethernet/intel/ice/ice_lag.h
> @@ -17,6 +17,9 @@ enum ice_lag_role {
>  #define ICE_LAG_INVALID_PORT 0xFF
>  
>  #define ICE_LAG_RESET_RETRIES		5
> +#define ICE_SW_DEFAULT_PROFILE		0
> +#define ICE_FV_PROT_MDID		255
> +#define ICE_LP_EXT_BUF_OFFSET		32
>  
>  struct ice_pf;
>  struct ice_vf;

