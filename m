Return-Path: <netdev+bounces-79845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0FC87BBAA
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 12:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFB551F2376F
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 11:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF636E616;
	Thu, 14 Mar 2024 11:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="koJoOO8d"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6A259B6C
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 11:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710414230; cv=none; b=ggX+SijITIb4DS40Bmf8v2xe+tDXvA0x4BQNlkTnFNAoyRKExq9XAxCmzUopjrWtHDkeGT0igKQKiTgZBXsx7EYAvXgA5QUAFAqJrCu+hskjFkNoqTDKDdDDKeXkl6tqhHuw9qr68PqvgWOCL4tF0sdAUKeffmhpfPa0Jsk1hlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710414230; c=relaxed/simple;
	bh=O50/8D9DlRidJxRUCY4jlU7tdjizRH8/aSa6obSpSxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKTTeRXldX2COaufEy4Pl7qsvrZBUOAxMUKpajmtOit6GMUzDUl7VWtfvL9C+AAIDZ1CqcVLmJzsrGrDgbv9AVt4IhgzGyIPVgSa3wzX6m9jAiefXMLl6DIfBL67DT7FpZKcqrbgotxXb/BWk/l/3jYHAZzOo+T4v1/eZvtGTVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=koJoOO8d; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710414228; x=1741950228;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O50/8D9DlRidJxRUCY4jlU7tdjizRH8/aSa6obSpSxU=;
  b=koJoOO8dMOnHjkJ72qsF50b3QWZAc0f2WtAX9JMfPPXKgquftKnq1Kgo
   mZ4s04dgLrcp17pMy8RhiNCAiFTQOjkDlLnBkxLFiyvgJjAkcWgIGF6DS
   4tezSnPlTDDMSyN7MjQRegM3gfSMbXVcXgFrguP4wbfxATv3TE12gnauj
   GHMmkFpVUhC+A8/vqs5l+T+a85gHnNIuXONzu1B67+egT2nBP+0pm5xpM
   ZHJjXQ1Zc4Osk3dPrBTMKBaxTkqccJyz0Vh/8bCKRZ9iRzyMTezEKfoL/
   mV/OltaO2faav4TcTtMG75io930Gx3GLLoO9unta5Loi4SNefSrz5W6uM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="5420688"
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="5420688"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 04:03:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="35382493"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 04:03:45 -0700
Date: Thu, 14 Mar 2024 12:03:41 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, marcin.szycik@intel.com,
	sridhar.samudrala@intel.com, wojciech.drewek@intel.com,
	pmenzel@molgen.mpg.de,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: Re: [iwl-next v2 2/2] ice: tc: allow ip_proto matching
Message-ID: <ZfLZjUZiQwJzJ445@mev-dev>
References: <20240222123956.2393-1-michal.swiatkowski@linux.intel.com>
 <20240222123956.2393-3-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222123956.2393-3-michal.swiatkowski@linux.intel.com>

On Thu, Feb 22, 2024 at 01:39:56PM +0100, Michal Swiatkowski wrote:
> Add new matching type for ip_proto.
> 
> Use it in the same lookup type as for TTL. In hardware it has the same
> protocol ID, but different offset.
> 
> Example command to add filter with ip_proto:
> $tc filter add dev eth10 ingress protocol ip flower ip_proto icmp \
>  skip_sw action mirred egress redirect dev eth0
> 
> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_tc_lib.c | 17 +++++++++++++++--
>  drivers/net/ethernet/intel/ice/ice_tc_lib.h |  1 +
>  2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> index 49ed5fd7db10..f7c0f62fb730 100644
> --- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> @@ -78,7 +78,8 @@ ice_tc_count_lkups(u32 flags, struct ice_tc_flower_lyr_2_4_hdrs *headers,
>  		     ICE_TC_FLWR_FIELD_DEST_IPV6 | ICE_TC_FLWR_FIELD_SRC_IPV6))
>  		lkups_cnt++;
>  
> -	if (flags & (ICE_TC_FLWR_FIELD_IP_TOS | ICE_TC_FLWR_FIELD_IP_TTL))
> +	if (flags & (ICE_TC_FLWR_FIELD_IP_TOS | ICE_TC_FLWR_FIELD_IP_TTL |
> +		     ICE_TC_FLWR_FIELD_IP_PROTO))
>  		lkups_cnt++;

There is an issue here. In case of ipv6 it shouldn't be count as there is no
support for next header in ipv6.

Example command to reproduce the problem:
tc filter add dev eth0 ingress protocol ipv6 prio 103 flower skip_sw \
	dst_mac fa:16:3e:13:e9:a1 ip_proto udp src_port 547 dst_port 546 \
	dst_ip fe80::/64 action drop

Filter won't be added because of mismatch between filled and counted
lookups.

I will send v3 with fix.

Thanks,
Michal

>  
>  	/* are L2TPv3 options specified? */
> @@ -530,7 +531,8 @@ ice_tc_fill_rules(struct ice_hw *hw, u32 flags,
>  	}
>  
>  	if (headers->l2_key.n_proto == htons(ETH_P_IP) &&
> -	    (flags & (ICE_TC_FLWR_FIELD_IP_TOS | ICE_TC_FLWR_FIELD_IP_TTL))) {
> +	    (flags & (ICE_TC_FLWR_FIELD_IP_TOS | ICE_TC_FLWR_FIELD_IP_TTL |
> +		      ICE_TC_FLWR_FIELD_IP_PROTO))) {
>  		list[i].type = ice_proto_type_from_ipv4(inner);
>  
>  		if (flags & ICE_TC_FLWR_FIELD_IP_TOS) {
> @@ -545,6 +547,13 @@ ice_tc_fill_rules(struct ice_hw *hw, u32 flags,
>  				headers->l3_mask.ttl;
>  		}
>  
> +		if (flags & ICE_TC_FLWR_FIELD_IP_PROTO) {
> +			list[i].h_u.ipv4_hdr.protocol =
> +				headers->l3_key.ip_proto;
> +			list[i].m_u.ipv4_hdr.protocol =
> +				headers->l3_mask.ip_proto;
> +		}
> +
>  		i++;
>  	}
>  
> @@ -1515,7 +1524,11 @@ ice_parse_cls_flower(struct net_device *filter_dev, struct ice_vsi *vsi,
>  
>  		headers->l2_key.n_proto = cpu_to_be16(n_proto_key);
>  		headers->l2_mask.n_proto = cpu_to_be16(n_proto_mask);
> +
> +		if (match.key->ip_proto)
> +			fltr->flags |= ICE_TC_FLWR_FIELD_IP_PROTO;
>  		headers->l3_key.ip_proto = match.key->ip_proto;
> +		headers->l3_mask.ip_proto = match.mask->ip_proto;
>  	}
>  
>  	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
> diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.h b/drivers/net/ethernet/intel/ice/ice_tc_lib.h
> index 65d387163a46..856f371d0687 100644
> --- a/drivers/net/ethernet/intel/ice/ice_tc_lib.h
> +++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.h
> @@ -34,6 +34,7 @@
>  #define ICE_TC_FLWR_FIELD_VLAN_PRIO		BIT(27)
>  #define ICE_TC_FLWR_FIELD_CVLAN_PRIO		BIT(28)
>  #define ICE_TC_FLWR_FIELD_VLAN_TPID		BIT(29)
> +#define ICE_TC_FLWR_FIELD_IP_PROTO		BIT(30)
>  
>  #define ICE_TC_FLOWER_MASK_32   0xFFFFFFFF
>  
> -- 
> 2.42.0
> 

