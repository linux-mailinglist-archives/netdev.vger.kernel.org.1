Return-Path: <netdev+bounces-199034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A809AADEAF7
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 13:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32C593BAE0B
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 11:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D6E2980BF;
	Wed, 18 Jun 2025 11:55:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1868927EFE3
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 11:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750247723; cv=none; b=RbPdJctob9Rvvk9QKcA66S1iXAvKDPBUX+yMKlT5scY8fmGsrew3TTmj8ics4nB7Fpy3MGDG/ilTxt0wmO0SVFaO/gUiQNozmFyylc7YUzSrCioV8WCkw/df+7F2dl1smCP7H2UUxdMMoK0h3um+YODsW0NBGTzf51N05zluyoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750247723; c=relaxed/simple;
	bh=rV1FvSLqghXqE4qzk31QsNV3iebUOeRNk3tkWm8+jkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b7Z5Bo9FUiKm6E77BkzNMdkUIoi+yzUWOsxG0ZZvgWGljUNuvbfnyhMArdWE/eM5Ze4bNpT+YI9BV7SlA/ACT3boTlZhV5KgY0xOypgOIJmDmNbWxOZ0i7jWGqWMem188iitgvLDQfqpzqAc6dNKRKdr3XDXVIPBcnc0pOXcoGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.36] (g36.guest.molgen.mpg.de [141.14.220.36])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7646E61E64783;
	Wed, 18 Jun 2025 13:54:47 +0200 (CEST)
Message-ID: <580ed7b6-1045-4347-a88e-edbf982cb287@molgen.mpg.de>
Date: Wed, 18 Jun 2025 13:54:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: convert ice_add_prof() to
 bitmap
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen
 <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
 Jacob Keller <jacob.e.keller@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Jesse Brandeburg <jbrandeburg@cloudflare.com>
References: <20250618112925.12193-2-przemyslaw.kitszel@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250618112925.12193-2-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Przemek, dear Jesse,


Thank you for the patch.

Am 18.06.25 um 13:28 schrieb Przemek Kitszel:
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Previously the ice_add_prof() took an array of u8 and looped over it with
> for_each_set_bit(), examining each 8 bit value as a bitmap.
> This was just hard to understand and unnecessary, and was triggering
> undefined behavior sanitizers with unaligned accesses within bitmap
> fields (on our internal tools/builds). Since the @ptype being passed in
> was already declared as a bitmap, refactor this to use native types with
> the advantage of simplifying the code to use a single loop.

Any tests to verify no regressions are introduced?

> Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> CC: Jesse Brandeburg <jbrandeburg@cloudflare.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>   .../net/ethernet/intel/ice/ice_flex_pipe.h    |  7 +-
>   .../net/ethernet/intel/ice/ice_flex_pipe.c    | 78 +++++++------------
>   drivers/net/ethernet/intel/ice/ice_flow.c     |  4 +-
>   3 files changed, 34 insertions(+), 55 deletions(-)

More removed lines than added ones is always a good diff stat.

> diff --git a/drivers/net/ethernet/intel/ice/ice_flex_pipe.h b/drivers/net/ethernet/intel/ice/ice_flex_pipe.h
> index 28b0897adf32..ee5d9f9c9d53 100644
> --- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.h
> +++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.h
> @@ -39,9 +39,10 @@ bool ice_hw_ptype_ena(struct ice_hw *hw, u16 ptype);
>   
>   /* XLT2/VSI group functions */
>   int
> -ice_add_prof(struct ice_hw *hw, enum ice_block blk, u64 id, u8 ptypes[],
> -	     const struct ice_ptype_attributes *attr, u16 attr_cnt,
> -	     struct ice_fv_word *es, u16 *masks, bool symm, bool fd_swap);
> +ice_add_prof(struct ice_hw *hw, enum ice_block blk, u64 id,
> +	     unsigned long *ptypes, const struct ice_ptype_attributes *attr,
> +	     u16 attr_cnt, struct ice_fv_word *es, u16 *masks, bool symm,
> +	     bool fd_swap);
>   struct ice_prof_map *
>   ice_search_prof_id(struct ice_hw *hw, enum ice_block blk, u64 id);
>   int
> diff --git a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
> index ed95072ca6e3..363ae79a3620 100644
> --- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
> +++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
> @@ -3043,16 +3043,16 @@ ice_disable_fd_swap(struct ice_hw *hw, u8 prof_id)
>    * the ID value used here.
>    */
>   int
> -ice_add_prof(struct ice_hw *hw, enum ice_block blk, u64 id, u8 ptypes[],
> -	     const struct ice_ptype_attributes *attr, u16 attr_cnt,
> -	     struct ice_fv_word *es, u16 *masks, bool symm, bool fd_swap)
> +ice_add_prof(struct ice_hw *hw, enum ice_block blk, u64 id,
> +	     unsigned long *ptypes, const struct ice_ptype_attributes *attr,
> +	     u16 attr_cnt, struct ice_fv_word *es, u16 *masks, bool symm,
> +	     bool fd_swap)
>   {
> -	u32 bytes = DIV_ROUND_UP(ICE_FLOW_PTYPE_MAX, BITS_PER_BYTE);
>   	DECLARE_BITMAP(ptgs_used, ICE_XLT1_CNT);
>   	struct ice_prof_map *prof;
> -	u8 byte = 0;
> -	u8 prof_id;
>   	int status;
> +	u8 prof_id;
> +	u16 ptype;
>   
>   	bitmap_zero(ptgs_used, ICE_XLT1_CNT);
>   
> @@ -3102,57 +3102,35 @@ ice_add_prof(struct ice_hw *hw, enum ice_block blk, u64 id, u8 ptypes[],
>   	prof->context = 0;
>   
>   	/* build list of ptgs */
> -	while (bytes && prof->ptg_cnt < ICE_MAX_PTG_PER_PROFILE) {
> -		u8 bit;
> +	for_each_set_bit(ptype, ptypes, ICE_FLOW_PTYPE_MAX) {
> +		u8 ptg;
>   
> -		if (!ptypes[byte]) {
> -			bytes--;
> -			byte++;
> +		/* The package should place all ptypes in a non-zero
> +		 * PTG, so the following call should never fail.
> +		 */
> +		if (ice_ptg_find_ptype(hw, blk, ptype, &ptg))
>   			continue;
> -		}
>   
> -		/* Examine 8 bits per byte */
> -		for_each_set_bit(bit, (unsigned long *)&ptypes[byte],
> -				 BITS_PER_BYTE) {
> -			u16 ptype;
> -			u8 ptg;
> -
> -			ptype = byte * BITS_PER_BYTE + bit;
> -
> -			/* The package should place all ptypes in a non-zero
> -			 * PTG, so the following call should never fail.
> -			 */
> -			if (ice_ptg_find_ptype(hw, blk, ptype, &ptg))
> -				continue;
> +		/* If PTG is already added, skip and continue */
> +		if (test_bit(ptg, ptgs_used))
> +			continue;
>   
> -			/* If PTG is already added, skip and continue */
> -			if (test_bit(ptg, ptgs_used))
> -				continue;
> +		set_bit(ptg, ptgs_used);
> +		/* Check to see there are any attributes for this ptype, and
> +		 * add them if found.
> +		 */
> +		status = ice_add_prof_attrib(prof, ptg, ptype, attr, attr_cnt);
> +		if (status == -ENOSPC)
> +			break;
> +		if (status) {
> +			/* This is simple a ptype/PTG with no attribute */
> +			prof->ptg[prof->ptg_cnt] = ptg;
> +			prof->attr[prof->ptg_cnt].flags = 0;
> +			prof->attr[prof->ptg_cnt].mask = 0;
>   
> -			__set_bit(ptg, ptgs_used);
> -			/* Check to see there are any attributes for
> -			 * this PTYPE, and add them if found.
> -			 */
> -			status = ice_add_prof_attrib(prof, ptg, ptype,
> -						     attr, attr_cnt);
> -			if (status == -ENOSPC)
> +			if (++prof->ptg_cnt >= ICE_MAX_PTG_PER_PROFILE)
>   				break;
> -			if (status) {
> -				/* This is simple a PTYPE/PTG with no
> -				 * attribute
> -				 */
> -				prof->ptg[prof->ptg_cnt] = ptg;
> -				prof->attr[prof->ptg_cnt].flags = 0;
> -				prof->attr[prof->ptg_cnt].mask = 0;
> -
> -				if (++prof->ptg_cnt >=
> -				    ICE_MAX_PTG_PER_PROFILE)
> -					break;
> -			}
>   		}
> -
> -		bytes--;
> -		byte++;
>   	}
>   
>   	list_add(&prof->list, &hw->blk[blk].es.prof_map);
> diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
> index d97b751052f2..c63e43b8b110 100644
> --- a/drivers/net/ethernet/intel/ice/ice_flow.c
> +++ b/drivers/net/ethernet/intel/ice/ice_flow.c
> @@ -1421,7 +1421,7 @@ ice_flow_add_prof_sync(struct ice_hw *hw, enum ice_block blk,
>   	}
>   
>   	/* Add a HW profile for this flow profile */
> -	status = ice_add_prof(hw, blk, prof_id, (u8 *)params->ptypes,
> +	status = ice_add_prof(hw, blk, prof_id, params->ptypes,
>   			      params->attr, params->attr_cnt, params->es,
>   			      params->mask, symm, true);
>   	if (status) {
> @@ -1617,7 +1617,7 @@ ice_flow_set_parser_prof(struct ice_hw *hw, u16 dest_vsi, u16 fdir_vsi,
>   		break;
>   	}
>   
> -	status = ice_add_prof(hw, blk, id, (u8 *)prof->ptypes,
> +	status = ice_add_prof(hw, blk, id, prof->ptypes,
>   			      params->attr, params->attr_cnt,
>   			      params->es, params->mask, false, false);
>   	if (status)

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

