Return-Path: <netdev+bounces-69376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D33F84AE9A
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 08:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40162B22CCD
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 07:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7990B128828;
	Tue,  6 Feb 2024 07:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BauaEe6N"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8D4128825
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 07:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707203063; cv=none; b=eL5aKJBnE5iHCaJfHfAhCRdcNtBSoT+ucd1WjfaDd4HgipUpIoxSaIiBCIzBHfshwunB1tIoMQAh4+JljzCnbNon56EQDQiFYnE1sMsS5hq/ibfRrgRDrNcW0pmwXybTo+2FjRxzRbL+4crjCHPCZpXYMxSHcGaxbKfhw2L6oJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707203063; c=relaxed/simple;
	bh=Xca2Oe4tD2lxGNEnYQq5q1Svq1ZiLMXlrikTHqnXkk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxsADjnVJkGFL/3poQqjQg6tXVFdsutnNUENG0sqE6u3n6uXxQC71XQs981tm2qHtDNjlQytydQWqgK9XdWgSLRRmlIXytAwDZDJNSEIVLHywfrIcrOhKybI+nQfBkTHYkUXRnRO5Bjd4gawUUNFgOehGn42DHSFZX9vjrx9YAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BauaEe6N; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707203062; x=1738739062;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xca2Oe4tD2lxGNEnYQq5q1Svq1ZiLMXlrikTHqnXkk8=;
  b=BauaEe6Nq/906mvjJSstnB8DmJ5b3npYiV6rc7r3SC59XNAF1Oiv7M0p
   SUP8JZFdptI/hZ899qU+yyyJY4NhDHtAaECrgswrkFd67t2KVBipWomaK
   ZQoUE/xWpTKEFzykiWFwVo3MjY+7Z6Yr0MPqCwJ2HrPy03GMMQreU8kcx
   6XKg5OC57yy1hnx0rEnzqcfpLV8PE0VZoDyev3uanDRyK3WUzeA86E3Jh
   s6WzGjDuQZasofO1++id/TU46O7GQaFlX3NelbOsDukL1SFtWEegG5vew
   dwAjOh2MhZKUSaeldfWzDN01XuaonIzvyo0grkxHfBYYeGM7GnaSftDuQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="18108645"
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="18108645"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 23:04:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="920803"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 23:04:17 -0800
Date: Tue, 6 Feb 2024 08:04:08 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew.gospodarek@broadcom.com,
	pavan.chebbi@broadcom.com
Subject: Re: [PATCH net-next 02/13] bnxt_en: Add ethtool -N support for ether
 filters.
Message-ID: <ZcHZ6JgacSpGmyDQ@mev-dev>
References: <20240205223202.25341-1-michael.chan@broadcom.com>
 <20240205223202.25341-3-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205223202.25341-3-michael.chan@broadcom.com>

On Mon, Feb 05, 2024 at 02:31:51PM -0800, Michael Chan wrote:
> Add ETHTOOL_SRXCLSRLINS and ETHTOOL_SRXCLSRLDEL support for inserting
> and deleting L2 ether filter rules.  Destination MAC address and
> optional VLAN are supported for each filter entry.  This is currently
> only supported on older BCM573XX and BCM574XX chips only.
> 
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 34 +++++++++
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  3 +
>  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 69 ++++++++++++++++++-
>  3 files changed, 103 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 91ecf514b924..3cc3504181c7 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -5519,6 +5519,40 @@ static struct bnxt_l2_filter *bnxt_alloc_l2_filter(struct bnxt *bp,
>  	return fltr;
>  }
>  
> +struct bnxt_l2_filter *bnxt_alloc_new_l2_filter(struct bnxt *bp,
> +						struct bnxt_l2_key *key,
> +						u16 flags)
> +{
> +	struct bnxt_l2_filter *fltr;
> +	u32 idx;
> +	int rc;
> +
> +	idx = jhash2(&key->filter_key, BNXT_L2_KEY_SIZE, bp->hash_seed) &
> +	      BNXT_L2_FLTR_HASH_MASK;
> +	spin_lock_bh(&bp->ntp_fltr_lock);
> +	fltr = __bnxt_lookup_l2_filter(bp, key, idx);
> +	if (fltr) {
> +		fltr = ERR_PTR(-EEXIST);
> +		goto l2_filter_exit;
> +	}
> +	fltr = kzalloc(sizeof(*fltr), GFP_ATOMIC);
> +	if (!fltr) {
> +		fltr = ERR_PTR(-ENOMEM);
> +		goto l2_filter_exit;
> +	}
> +	fltr->base.flags = flags;
> +	rc = bnxt_init_l2_filter(bp, fltr, key, idx);
> +	if (rc) {
> +		spin_unlock_bh(&bp->ntp_fltr_lock);
Why filter needs to be deleted without lock? If you can change the order
it looks more natural:

+if (rc) {
+	fltr = ERR_PTR(rc);
+	goto l2_filter_del;
+}

> +		bnxt_del_l2_filter(bp, fltr);
> +		return ERR_PTR(rc);
> +	}
> +
> +l2_filter_exit:
> +	spin_unlock_bh(&bp->ntp_fltr_lock);
> +	return fltr;
> +}
> +
>  static u16 bnxt_vf_target_id(struct bnxt_pf_info *pf, u16 vf_idx)
>  {
>  #ifdef CONFIG_BNXT_SRIOV
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> index 4bd1cf01d99e..21721b8748bc 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -2646,6 +2646,9 @@ int bnxt_hwrm_func_drv_rgtr(struct bnxt *bp, unsigned long *bmap,
>  			    int bmap_size, bool async_only);
>  int bnxt_hwrm_func_drv_unrgtr(struct bnxt *bp);
>  void bnxt_del_l2_filter(struct bnxt *bp, struct bnxt_l2_filter *fltr);
> +struct bnxt_l2_filter *bnxt_alloc_new_l2_filter(struct bnxt *bp,
> +						struct bnxt_l2_key *key,
> +						u16 flags);
>  int bnxt_hwrm_l2_filter_free(struct bnxt *bp, struct bnxt_l2_filter *fltr);
>  int bnxt_hwrm_l2_filter_alloc(struct bnxt *bp, struct bnxt_l2_filter *fltr);
>  int bnxt_hwrm_cfa_ntuple_filter_free(struct bnxt *bp,
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> index 1c8610386404..2d8e847e8fdd 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> @@ -1152,6 +1152,58 @@ static int bnxt_grxclsrule(struct bnxt *bp, struct ethtool_rxnfc *cmd)
>  	return rc;
>  }
>  
> +static int bnxt_add_l2_cls_rule(struct bnxt *bp,
> +				struct ethtool_rx_flow_spec *fs)
> +{
> +	u32 ring = ethtool_get_flow_spec_ring(fs->ring_cookie);
> +	u8 vf = ethtool_get_flow_spec_ring_vf(fs->ring_cookie);
> +	struct ethhdr *h_ether = &fs->h_u.ether_spec;
> +	struct ethhdr *m_ether = &fs->m_u.ether_spec;
> +	struct bnxt_l2_filter *fltr;
> +	struct bnxt_l2_key key;
> +	u16 vnic_id;
> +	u8 flags;
> +	int rc;
> +
> +	if (BNXT_CHIP_P5_PLUS(bp))
> +		return -EOPNOTSUPP;
> +
> +	if (!is_broadcast_ether_addr(m_ether->h_dest))
> +		return -EINVAL;
> +	ether_addr_copy(key.dst_mac_addr, h_ether->h_dest);
> +	key.vlan = 0;
> +	if (fs->flow_type & FLOW_EXT) {
> +		struct ethtool_flow_ext *m_ext = &fs->m_ext;
> +		struct ethtool_flow_ext *h_ext = &fs->h_ext;
> +
> +		if (m_ext->vlan_tci != htons(0xfff) || !h_ext->vlan_tci)
> +			return -EINVAL;
> +		key.vlan = ntohs(h_ext->vlan_tci);
> +	}
> +
> +	if (vf) {
> +		flags = BNXT_ACT_FUNC_DST;
> +		vnic_id = 0xffff;
> +		vf--;
> +	} else {
> +		flags = BNXT_ACT_RING_DST;
> +		vnic_id = bp->vnic_info[ring + 1].fw_vnic_id;
> +	}
> +	fltr = bnxt_alloc_new_l2_filter(bp, &key, flags);
> +	if (IS_ERR(fltr))
> +		return PTR_ERR(fltr);
> +
> +	fltr->base.fw_vnic_id = vnic_id;
> +	fltr->base.rxq = ring;
> +	fltr->base.vf_idx = vf;
> +	rc = bnxt_hwrm_l2_filter_alloc(bp, fltr);
> +	if (rc)
> +		bnxt_del_l2_filter(bp, fltr);
> +	else
> +		fs->location = fltr->base.sw_id;
> +	return rc;
> +}
> +
>  #define IPV4_ALL_MASK		((__force __be32)~0)
>  #define L4_PORT_ALL_MASK	((__force __be16)~0)
>  
> @@ -1335,7 +1387,7 @@ static int bnxt_srxclsrlins(struct bnxt *bp, struct ethtool_rxnfc *cmd)
>  		return -EINVAL;
>  	flow_type &= ~FLOW_EXT;
>  	if (flow_type == ETHER_FLOW)
> -		rc = -EOPNOTSUPP;
> +		rc = bnxt_add_l2_cls_rule(bp, fs);
>  	else
>  		rc = bnxt_add_ntuple_cls_rule(bp, fs);
>  	return rc;
> @@ -1346,11 +1398,22 @@ static int bnxt_srxclsrldel(struct bnxt *bp, struct ethtool_rxnfc *cmd)
>  	struct ethtool_rx_flow_spec *fs = &cmd->fs;
>  	struct bnxt_filter_base *fltr_base;
>  	struct bnxt_ntuple_filter *fltr;
> +	u32 id = fs->location;
>  
>  	rcu_read_lock();
> +	fltr_base = bnxt_get_one_fltr_rcu(bp, bp->l2_fltr_hash_tbl,
> +					  BNXT_L2_FLTR_HASH_SIZE, id);
> +	if (fltr_base) {
> +		struct bnxt_l2_filter *l2_fltr;
> +
> +		l2_fltr = container_of(fltr_base, struct bnxt_l2_filter, base);
> +		rcu_read_unlock();
> +		bnxt_hwrm_l2_filter_free(bp, l2_fltr);
> +		bnxt_del_l2_filter(bp, l2_fltr);
> +		return 0;
> +	}
>  	fltr_base = bnxt_get_one_fltr_rcu(bp, bp->ntp_fltr_hash_tbl,
> -					  BNXT_NTP_FLTR_HASH_SIZE,
> -					  fs->location);
> +					  BNXT_NTP_FLTR_HASH_SIZE, id);
>  	if (!fltr_base) {
>  		rcu_read_unlock();
>  		return -ENOENT;
> -- 
> 2.30.1
> 



