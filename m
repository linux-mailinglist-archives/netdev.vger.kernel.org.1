Return-Path: <netdev+bounces-73302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F26885BCEE
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 14:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0B67282EA9
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 13:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A306A00B;
	Tue, 20 Feb 2024 13:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OOEhrRo6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BA76A00E
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708434880; cv=none; b=MVpqbjY1AF5DQdenb+Av4MAWa0+qZBtuyGnVddZKKwb37rXkr1ZhMm2T3zAA3P4mV5SWqEYqrpIexp1x8UP37e3JvimQRfIu8I83xmWkz+3z1j72KOLfY0kFUVXm6II767JO4ohzly5ykuQvWEOawNAojZvsf/RzS6MQjOXjPKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708434880; c=relaxed/simple;
	bh=b84dLxslkqXo24Roys3t+5b0MUHLK/hHMjWJ+oVet/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwPvhJ6/pV+usKmJZXWgBDdG29CO4J6AIJFYXw5orxYrIzWFnhVT3XtfGjbN04bV2gDcUCqiVoe7aBHYQGS8PUwTLzeTOeFBRO/XbWJ15A+dN61Y0+I1ucR1Wne9GvDB2ePeC6yPF6+6se4lTULCWSmZr3V4W8oTKgsobaKYyI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OOEhrRo6; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708434879; x=1739970879;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b84dLxslkqXo24Roys3t+5b0MUHLK/hHMjWJ+oVet/w=;
  b=OOEhrRo68i1F6GFDuIHYKcK0DkeWfXGk4aKagr6xYukDYKqvisajLro/
   fWZG9dVqpmDD8ve6SUbr9419r/rEDaA6rKVfN7DJQkYzh8j7uptEx/Mij
   PP3jRVZIT86VzL5OMADPAdJivImYL9dlFwIcqUeCGzz2uJdPGcRbIFD0k
   jwYTNJ69O4mqM50+2nBDX/lJiyjgtlsUqmCzMkXBQ5GtTkSTLoZv5uzm6
   BteiJytD2m3zjtBwRUtPYRH6oey8e1G8pKZU3YvuNC4An+i0OEsFV3g/B
   fE9tQZgOpxx1qXyudCGRcpSF5y16eITmKn+mfyBa+U/0BYIScmp4KgHBj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="13939509"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="13939509"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 05:14:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="913075734"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="913075734"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 05:14:36 -0800
Date: Tue, 20 Feb 2024 14:14:32 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: intel-wired-lan@lists.osuosl.org, wojciech.drewek@intel.com,
	marcin.szycik@intel.com, netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	sridhar.samudrala@intel.com
Subject: Re: [Intel-wired-lan] [iwl-next v1 2/2] ice: tc: allow ip_proto
 matching
Message-ID: <ZdSluDkqY1R4CMBq@mev-dev>
References: <20240220105950.6814-1-michal.swiatkowski@linux.intel.com>
 <20240220105950.6814-3-michal.swiatkowski@linux.intel.com>
 <dc03726a-d59b-47a1-b394-7a435f8aee1a@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc03726a-d59b-47a1-b394-7a435f8aee1a@molgen.mpg.de>

On Tue, Feb 20, 2024 at 01:26:34PM +0100, Paul Menzel wrote:
> Dear Michal,
> 
> 
> Thank you for the patch. Some minor nits from my side.
> 
> Am 20.02.24 um 11:59 schrieb Michal Swiatkowski:
> > Add new matching type. There is no encap version of ip_proto field.
> 
> Excuse my ignorance, I do not understand the second sentence. Is an encap
> version going to be added?
> 

No, I will rephrase it, thanks.

> > Use it in the same lookup type as for TTL. In hardware it have the same
> 
> s/have/has/
>

Will fix.

> > protocol ID, but different offset.
> > 
> > Example command to add filter with ip_proto:
> > $tc filter add dev eth10 ingress protocol ip flower ip_proto icmp \
> >   skip_sw action mirred egress redirect dev eth0
> > 
> > Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > ---
> >   drivers/net/ethernet/intel/ice/ice_tc_lib.c | 17 +++++++++++++++--
> >   drivers/net/ethernet/intel/ice/ice_tc_lib.h |  1 +
> >   2 files changed, 16 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> > index 49ed5fd7db10..f7c0f62fb730 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> > @@ -78,7 +78,8 @@ ice_tc_count_lkups(u32 flags, struct ice_tc_flower_lyr_2_4_hdrs *headers,
> >   		     ICE_TC_FLWR_FIELD_DEST_IPV6 | ICE_TC_FLWR_FIELD_SRC_IPV6))
> >   		lkups_cnt++;
> > -	if (flags & (ICE_TC_FLWR_FIELD_IP_TOS | ICE_TC_FLWR_FIELD_IP_TTL))
> > +	if (flags & (ICE_TC_FLWR_FIELD_IP_TOS | ICE_TC_FLWR_FIELD_IP_TTL |
> > +		     ICE_TC_FLWR_FIELD_IP_PROTO))
> 
> Should this be sorted? (Also below).
>

Do you mean PROTO before TOS and TTL? I like the current order, because
for ipv6 we don't have PROTO, but we have TOS and TTL, it looks better
when PROTO is as additional one here.

> >   		lkups_cnt++;
> >   	/* are L2TPv3 options specified? */
> > @@ -530,7 +531,8 @@ ice_tc_fill_rules(struct ice_hw *hw, u32 flags,
> >   	}
> >   	if (headers->l2_key.n_proto == htons(ETH_P_IP) &&
> > -	    (flags & (ICE_TC_FLWR_FIELD_IP_TOS | ICE_TC_FLWR_FIELD_IP_TTL))) {
> > +	    (flags & (ICE_TC_FLWR_FIELD_IP_TOS | ICE_TC_FLWR_FIELD_IP_TTL |
> > +		      ICE_TC_FLWR_FIELD_IP_PROTO))) {
> >   		list[i].type = ice_proto_type_from_ipv4(inner);
> >   		if (flags & ICE_TC_FLWR_FIELD_IP_TOS) {
> > @@ -545,6 +547,13 @@ ice_tc_fill_rules(struct ice_hw *hw, u32 flags,
> >   				headers->l3_mask.ttl;
> >   		}
> > +		if (flags & ICE_TC_FLWR_FIELD_IP_PROTO) {
> > +			list[i].h_u.ipv4_hdr.protocol =
> > +				headers->l3_key.ip_proto;
> > +			list[i].m_u.ipv4_hdr.protocol =
> > +				headers->l3_mask.ip_proto;
> 
> (Strange to break the line each time, but seems to be the surrounding coding
> style.)
>

Yeah, without breaking it is longer than 80.

> > +		}
> > +
> >   		i++;
> >   	}
> > @@ -1515,7 +1524,11 @@ ice_parse_cls_flower(struct net_device *filter_dev, struct ice_vsi *vsi,
> >   		headers->l2_key.n_proto = cpu_to_be16(n_proto_key);
> >   		headers->l2_mask.n_proto = cpu_to_be16(n_proto_mask);
> > +
> > +		if (match.key->ip_proto)
> > +			fltr->flags |= ICE_TC_FLWR_FIELD_IP_PROTO;
> >   		headers->l3_key.ip_proto = match.key->ip_proto;
> > +		headers->l3_mask.ip_proto = match.mask->ip_proto;
> >   	}
> >   	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
> > diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.h b/drivers/net/ethernet/intel/ice/ice_tc_lib.h
> > index 65d387163a46..856f371d0687 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_tc_lib.h
> > +++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.h
> > @@ -34,6 +34,7 @@
> >   #define ICE_TC_FLWR_FIELD_VLAN_PRIO		BIT(27)
> >   #define ICE_TC_FLWR_FIELD_CVLAN_PRIO		BIT(28)
> >   #define ICE_TC_FLWR_FIELD_VLAN_TPID		BIT(29)
> > +#define ICE_TC_FLWR_FIELD_IP_PROTO		BIT(30)
> >   #define ICE_TC_FLOWER_MASK_32   0xFFFFFFFF
> 
> 
> Kind regards,
> 
> Paul

Thanks,
Michal

