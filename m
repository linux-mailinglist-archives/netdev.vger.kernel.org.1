Return-Path: <netdev+bounces-79844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B378387BBA0
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 11:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E485B1C20A40
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 10:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5676D1AE;
	Thu, 14 Mar 2024 10:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PUYSXf6s"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6342C6CDA3
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 10:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710413977; cv=none; b=HvGSAC3GRiTZ1rY3AdswV1Vz78+1QxA2J+XjTDglAmxGfyIgTVnDMpdcmjfedOpap4FB9/ZCH1Z/BJB5DFnpMXBC4a/sGHut8nYCDWXxfSiaFGU8xnBv/3MICmUfesScKjJhcSM0c8cEXPfZnO8lMmkEl6HXzRdAYE5h0cI8uE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710413977; c=relaxed/simple;
	bh=LV2n7ZJ4SfgnAUxyrx7AXuTeLXof0s93S4VFQYctrSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlZMPHUoyWlW7V5l56f0+aUqbidvIRwl8lNctAdCRRTxcia9JZcgbltK1rTZp6BSvie3LhQp0IhAm/H7TP/VAcKPGaNEMxrGWtCerkrDh1g8P9jeH9OSN/dN0kz46r8VcYpg2wSUAFzw9uXw+uJDydkXFYQNu6AwpBXUWn7ZqYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PUYSXf6s; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710413975; x=1741949975;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LV2n7ZJ4SfgnAUxyrx7AXuTeLXof0s93S4VFQYctrSM=;
  b=PUYSXf6sJHiC2UcDHh4QqLlKnWIMDhs4TNJsbnYrifEoA6fNBrpfxWlr
   Oq/FltMFOQfLb7svu4CdCtOnz6S9qQ1ulAlL7RO81eX/a3SG6qKNQWSxq
   6gjjnfwpLNqnaxa1nT/QjYSYaXHZsDxYqtJRrsmfxY6mYM6NYVIgANdT9
   PGaBkp9n0lKD3BWp7xpQWuFtVMGC1RHtLxapblQftzFqWw8Vg22rIVHcz
   HBcWjjAnkWuUbaFequ5/Gr/2KAljDmVlkAK8kWo/Extw1xdyzaQiz1q6V
   1R+yXbpCSAel15hI+hoH6pShwJ7FoL29qfEXuIqpvChfoty040/J5/35/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="30663933"
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="30663933"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 03:59:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="12267805"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 03:59:33 -0700
Date: Thu, 14 Mar 2024 11:59:23 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	marcin.szycik@intel.com, sridhar.samudrala@intel.com,
	wojciech.drewek@intel.com, pmenzel@molgen.mpg.de,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: Re: [iwl-next v2 1/2] ice: tc: check src_vsi in case of traffic from
 VF
Message-ID: <ZfLYfpsVP32uJA9P@mev-dev>
References: <20240222123956.2393-1-michal.swiatkowski@linux.intel.com>
 <20240222123956.2393-2-michal.swiatkowski@linux.intel.com>
 <20240226133448.GD13129@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226133448.GD13129@kernel.org>

On Mon, Feb 26, 2024 at 01:34:48PM +0000, Simon Horman wrote:
> On Thu, Feb 22, 2024 at 01:39:55PM +0100, Michal Swiatkowski wrote:
> > In case of traffic going from the VF (so ingress for port representor)
> > source VSI should be consider during packet classification. It is
> > needed for hardware to not match packets from different ports with
> > filters added on other port.
> > 
> > It is only for "from VF" traffic, because other traffic direction
> > doesn't have source VSI.
> > 
> > Set correct ::src_vsi in rule_info to pass it to the hardware filter.
> > 
> > For example this rule should drop only ipv4 packets from eth10, not from
> > the others VF PRs. It is needed to check source VSI in this case.
> > $tc filter add dev eth10 ingress protocol ip flower skip_sw action drop
> > 
> > Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> > Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> 
> Hi Michal,
> 
> Should this be treated as a fix: have a Fixes tag; be targeted at 'iwl'?
> 
> That notwithstanding, this look good to me.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> ...

Thanks Simon, you are right, it will go to net with correct fixes tag.

Thanks,
Michal

