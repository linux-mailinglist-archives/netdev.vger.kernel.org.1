Return-Path: <netdev+bounces-69378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE90384AED3
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 08:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78DCDB2293D
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 07:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40C212882B;
	Tue,  6 Feb 2024 07:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KIewqL/m"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB64128828
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 07:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707203754; cv=none; b=nERLOxU4i3sIIko6MQSOBO9X9ooTSmL9t9fa+2sAQWJUNxh9P3B76vdTEqVjxUuXgWnXBzyTMX6+XL+gSA4N/X5yR7uJ/C3bdYAksVgh1kr9yrghEPgS2MP9hD3xnoyyF1hhvALB640g2IpaYg9Tj6KubVuufeTjRq2dqGzmSt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707203754; c=relaxed/simple;
	bh=flafyVSmnkvva9LgjVB1CVjfJS6L2DTlLXRzeFgj2MY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tny+/Z+hYRIPyqLlOkF9Yg8SCn6O5X27weeg5iBqOGwX9asQGX0BU57863VFHVbaWr/owCZgQHny+c/UBrlLaBSeqNVKE7x2pUISjoL+6YKH8WXix/H2tXgqJa6VRbXvZ0GJwgeQ46JQQTEZ3pgdejV9FRnJvsR/SmXIlmmhOzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KIewqL/m; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707203754; x=1738739754;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=flafyVSmnkvva9LgjVB1CVjfJS6L2DTlLXRzeFgj2MY=;
  b=KIewqL/mxeTBpgIvDyrbV1DvzxCr76pd+tCJGcBQmJh6lcQExpqybBwO
   oUlrpUnkguxG5xRogPVC+HOTBjL8mUi8YB/1dLF+AQt4R3m7HJ7IIMnqY
   5Y5xlrDFXcLDYHNTPwA5AOmjRnDsikGMzX/aXggBwvxOxUnUeLr9nFtiY
   PoGeBF8JlvjtJFsi/XnZ/uQi0DxvC7dA3uik/8BYqHsi1kAuf1M6fwvtb
   Y2SK5g/tvEgHbW+R3ZnXTSxsr1KX5w5lDsmwF5rRoNkq/mKWDvaNqceMD
   2zcXVOPMdNHK0qZnt4TnVenNxX8+8XwNXVRr9ssRGceow3GhKV49dckrJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="4566186"
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="4566186"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 23:15:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="933372747"
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="933372747"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 23:15:50 -0800
Date: Tue, 6 Feb 2024 08:15:42 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew.gospodarek@broadcom.com,
	pavan.chebbi@broadcom.com
Subject: Re: [PATCH net-next 03/13] bnxt_en: Support ethtool -n to display
 ether filters.
Message-ID: <ZcHcnmsi6OPfJ+mI@mev-dev>
References: <20240205223202.25341-1-michael.chan@broadcom.com>
 <20240205223202.25341-4-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205223202.25341-4-michael.chan@broadcom.com>

On Mon, Feb 05, 2024 at 02:31:52PM -0800, Michael Chan wrote:
> Implement ETHTOOL_GRXCLSRULE for the user defined ether filters.  Use
> the common functions to walk the L2 filter hash table.
> 
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  1 +
>  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 38 ++++++++++++++++++-
>  2 files changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 3cc3504181c7..da298f4512b5 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -5484,6 +5484,7 @@ static int bnxt_init_l2_filter(struct bnxt *bp, struct bnxt_l2_filter *fltr,
>  		if (bit_id < 0)
>  			return -ENOMEM;
>  		fltr->base.sw_id = (u16)bit_id;
> +		bp->ntp_fltr_count++;
>  	}
>  	head = &bp->l2_fltr_hash_tbl[idx];
>  	hlist_add_head_rcu(&fltr->base.hash, head);
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> index 2d8e847e8fdd..4d4dd2b231b8 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> @@ -1058,11 +1058,17 @@ static struct bnxt_filter_base *bnxt_get_one_fltr_rcu(struct bnxt *bp,
>  static int bnxt_grxclsrlall(struct bnxt *bp, struct ethtool_rxnfc *cmd,
>  			    u32 *rule_locs)
>  {
> +	u32 count;
> +
>  	cmd->data = bp->ntp_fltr_count;
>  	rcu_read_lock();
> +	count = bnxt_get_all_fltr_ids_rcu(bp, bp->l2_fltr_hash_tbl,
> +					  BNXT_L2_FLTR_HASH_SIZE, rule_locs, 0,
> +					  cmd->rule_cnt);
>  	cmd->rule_cnt = bnxt_get_all_fltr_ids_rcu(bp, bp->ntp_fltr_hash_tbl,
>  						  BNXT_NTP_FLTR_HASH_SIZE,
> -						  rule_locs, 0, cmd->rule_cnt);
> +						  rule_locs, count,
> +						  cmd->rule_cnt);
>  	rcu_read_unlock();
>  
>  	return 0;
> @@ -1081,6 +1087,36 @@ static int bnxt_grxclsrule(struct bnxt *bp, struct ethtool_rxnfc *cmd)
>  		return rc;
>  
>  	rcu_read_lock();
> +	fltr_base = bnxt_get_one_fltr_rcu(bp, bp->l2_fltr_hash_tbl,
> +					  BNXT_L2_FLTR_HASH_SIZE,
> +					  fs->location);
> +	if (fltr_base) {
> +		struct ethhdr *h_ether = &fs->h_u.ether_spec;
> +		struct ethhdr *m_ether = &fs->m_u.ether_spec;
> +		struct bnxt_l2_filter *l2_fltr;
> +		struct bnxt_l2_key *l2_key;
> +
> +		l2_fltr = container_of(fltr_base, struct bnxt_l2_filter, base);
> +		l2_key = &l2_fltr->l2_key;
> +		fs->flow_type = ETHER_FLOW;
> +		ether_addr_copy(h_ether->h_dest, l2_key->dst_mac_addr);
> +		eth_broadcast_addr(m_ether->h_dest);
> +		if (l2_key->vlan) {
> +			struct ethtool_flow_ext *m_ext = &fs->m_ext;
> +			struct ethtool_flow_ext *h_ext = &fs->h_ext;
> +
> +			fs->flow_type |= FLOW_EXT;
> +			m_ext->vlan_tci = htons(0xfff);
> +			h_ext->vlan_tci = htons(l2_key->vlan);
> +		}
> +		if (fltr_base->flags & BNXT_ACT_RING_DST)
> +			fs->ring_cookie = fltr_base->rxq;
> +		if (fltr_base->flags & BNXT_ACT_FUNC_DST)
> +			fs->ring_cookie = (u64)(fltr_base->vf_idx + 1) <<
> +					  ETHTOOL_RX_FLOW_SPEC_RING_VF_OFF;
Wonder if saving ring_cookie in fltr_base won't be cleaner, but I am not
sure if it is worth to introduce new field for only that.

> +		rcu_read_unlock();
> +		return 0;
> +	}
>  	fltr_base = bnxt_get_one_fltr_rcu(bp, bp->ntp_fltr_hash_tbl,
>  					  BNXT_NTP_FLTR_HASH_SIZE,
>  					  fs->location);

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Thanks,
Michal
> -- 
> 2.30.1
> 



