Return-Path: <netdev+bounces-73283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA5985BBF3
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 13:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0327F1F214E7
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 12:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B560367E83;
	Tue, 20 Feb 2024 12:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B1Cit4uq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD69E67C70
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 12:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708431877; cv=none; b=dm2w8l0+rGHFHLoAc84lMydcGu2KbTLsnpM8SWXKeT8DLP9wiz2oSglsyaecE5G+EE7x6pRIzWVS3s4SsIn9oIg++NGvPEUTgSZ2V7XVRBi0zc75FALjKAARy9Nq2SlzWCGxi5pzejsFbwYE17bAQMUp6vR9C7ZJTnCBy+ZcIk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708431877; c=relaxed/simple;
	bh=dsiLJ11h741l5GbdJat1YmQ4KzPfYnGD2H8KwKTyIaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxf+Lpo6mIS/8KQWNDkJNqxvt1nw1alTDIUmRxI8CDl7d7k1ax3yQI3YVL7wlcWkccBuLiLfe0zuDoYM+2ypPiw/R7tdNe1XgP4TEmCXn3IDKhT6DTjHp5LPzhMfycTMLJvpgvYINKpmrhiBhDgMMsCehM2XAeninjDvNiRcBOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B1Cit4uq; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708431876; x=1739967876;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=dsiLJ11h741l5GbdJat1YmQ4KzPfYnGD2H8KwKTyIaQ=;
  b=B1Cit4uq/hIqf7bvIfG/6KMR7CKKHNqr6PsUNXHN/tDg5CdBiPPLG7qY
   CGQeYUzfStJSnPufePf4zYUxY2YjTH7yLhZJf3PRTbWz13qFyaJ7VreUX
   1o8WWafL7Om4gmFMtXUz+/QPRCjpTkTbfAO1lOXqAUjY3SR5Y71mqpPm2
   yKAhgKXieO9WLdiV89ysuV/lxkF3SOuhiDs+p2Aph1a77QXiOhUEqTbO6
   l82S6GxJpesX+Qo1ZjzDfyG4TaPZMfH+khrfZIVZuv9nbPQyBJvoUpYbP
   qPW5z4m945MgayaZf/m+OE3pCfhDriOqzvh73nQp76+6EbIA2mNwhghZA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="13942158"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="13942158"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 04:24:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="42258584"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 04:24:33 -0800
Date: Tue, 20 Feb 2024 13:24:29 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: wojciech.drewek@intel.com, marcin.szycik@intel.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	sridhar.samudrala@intel.com
Subject: Re: [Intel-wired-lan] [iwl-next v1 1/2] ice: tc: check src_vsi in
 case of traffic from VF
Message-ID: <ZdSZ/ZWKXidgHkAB@mev-dev>
References: <20240220105950.6814-1-michal.swiatkowski@linux.intel.com>
 <20240220105950.6814-2-michal.swiatkowski@linux.intel.com>
 <30416589-7340-4ad3-8749-bef1f82743cb@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30416589-7340-4ad3-8749-bef1f82743cb@molgen.mpg.de>

On Tue, Feb 20, 2024 at 12:23:11PM +0100, Paul Menzel wrote:
> Dear Michal,
> 
> 
> Thank you for the patch.
>

Thanks for the review.

> Am 20.02.24 um 11:59 schrieb Michal Swiatkowski:
> > In case of traffic going from the VF (so ingress for port representor)
> > there should be a check for source VSI. It is needed for hardware to not
> > match packets from different port with filters added on other port.
> 
> … from different port*s* …?
> 

Will fix it.

> > It is only for "from VF" traffic, because other traffic direction
> > doesn't have source VSI.
> 
> Do you have a test case to reproduce this?
>

I can add tc fileter call in v2. In short, any redirect from VF0 to
uplink should allow going packets only from VF0, but currently it is
also matching traffic from other VFs (like VF1, VF2, etc.)

> > Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> > Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > ---
> >   drivers/net/ethernet/intel/ice/ice_tc_lib.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> > index b890410a2bc0..49ed5fd7db10 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> > @@ -28,6 +28,8 @@ ice_tc_count_lkups(u32 flags, struct ice_tc_flower_lyr_2_4_hdrs *headers,
> >   	 * - ICE_TC_FLWR_FIELD_VLAN_TPID (present if specified)
> >   	 * - Tunnel flag (present if tunnel)
> >   	 */
> > +	if (fltr->direction == ICE_ESWITCH_FLTR_EGRESS)
> > +		lkups_cnt++;
> 
> Why does the count variable need to be incremented?
>
AS you wrote belowe it is needed to add another lookup.

> >   	if (flags & ICE_TC_FLWR_FIELD_TENANT_ID)
> >   		lkups_cnt++;
> > @@ -363,6 +365,11 @@ ice_tc_fill_rules(struct ice_hw *hw, u32 flags,
> >   	/* Always add direction metadata */
> >   	ice_rule_add_direction_metadata(&list[ICE_TC_METADATA_LKUP_IDX]);
> > +	if (tc_fltr->direction == ICE_ESWITCH_FLTR_EGRESS) {
> > +		ice_rule_add_src_vsi_metadata(&list[i]);
> > +		i++;
> > +	}
> > +
> >   	rule_info->tun_type = ice_sw_type_from_tunnel(tc_fltr->tunnel_type);
> >   	if (tc_fltr->tunnel_type != TNL_LAST) {
> >   		i = ice_tc_fill_tunnel_outer(flags, tc_fltr, list, i);
> > @@ -820,6 +827,7 @@ ice_eswitch_add_tc_fltr(struct ice_vsi *vsi, struct ice_tc_flower_fltr *fltr)
> >   	/* specify the cookie as filter_rule_id */
> >   	rule_info.fltr_rule_id = fltr->cookie;
> > +	rule_info.src_vsi = vsi->idx;
> 
> Besides the comment above being redundant (as the code does exactly that),
> the new line looks like to belong to the comment. Please excuse my
> ignorance, but the commit message only talks about adding checks and not
> overwriting the `src_vsi`. It’d be great, if you could elaborate.
>

I will rephrase commit message to mark that it is not checking in code,
but matching in hardware, thanks.

> >   	ret = ice_add_adv_rule(hw, list, lkups_cnt, &rule_info, &rule_added);
> >   	if (ret == -EEXIST) {
> 
> 
> Kind regards,
> 
> Paul

