Return-Path: <netdev+bounces-83191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CE4891521
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 09:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D958B1C220AE
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 08:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231733C48E;
	Fri, 29 Mar 2024 08:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z95iwgoE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC093BBE2
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 08:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711700748; cv=none; b=sQA1mvNacxg02QNuaZ4uPlLoinfwZGk25PBZn80PibVbxknmKoUTMkK+AAlA3+eijNwJMn8Xwn3ydKf+b6u9NmyRTpXWePoXBmJmsg72NRWJo3aUmbsUVfTfbJF8t902AN6y8zq0gXq5olWU3UpaGLnOWE7nYnQO33g70JyJxjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711700748; c=relaxed/simple;
	bh=v+cbkxJzxF/YcfwnjeRh08GfHVnQ93gPGcW75G6xRTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkjBjShVQxhlCAtpL090yQJr2QhswOAuNR6Mzso/SUrvMXxd7DDjd+eIaj26peZWF673XpCDbBtmH8ic4iLRjZjTXl54XBUUwzqHiHUqFpEC5hAM4mPdtO+D5r2XHn/PFNSeVipO5zJVVejv/iEkTm6n/P50zYlLIoHW2Z+hjDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z95iwgoE; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711700746; x=1743236746;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v+cbkxJzxF/YcfwnjeRh08GfHVnQ93gPGcW75G6xRTA=;
  b=Z95iwgoEaItq/p3wzPo2irY7XLZ2OQuHhOII65hsu3D3hq4bJBjAIuS2
   5oqvjaxLQEUo7Lor9fJoTcu8HTHFL14vT7iJb34TK9gV8sMuGJsdnFgh5
   VIUl8L4aPusRbCfDsbn/aAaHBVQAfErQp8gTWX7wufwuuauz22ErahU4c
   S0sSywQVSNgYBk5GWtdYC78ZBXBHotQYnTyzEnIfuD7yWIuaIhGjSNDuc
   8qqKlggVLPJCqjaEqgweyjWlsve07bZ+yYEUOWb1jEMetLlYIdm03MLt/
   D0Fw5JAt11LocfyEhhGuXeIuGIMrcrCOK18gcV2xekkt8bjfW78HrAKgO
   A==;
X-CSE-ConnectionGUID: rwXpi1m5TpOPnCZM/jouhg==
X-CSE-MsgGUID: SJt8/nLsRTOZzFgJWFYM0A==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6748963"
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="6748963"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 01:25:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="16965983"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 01:25:44 -0700
Date: Fri, 29 Mar 2024 09:25:35 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	"Kubiak, Michal" <michal.kubiak@intel.com>
Subject: Re: [Intel-wired-lan] [iwl-net v1] ice: tc: do default match on all
 profiles
Message-ID: <ZgZ6/6/R+5EfQvbb@mev-dev>
References: <20240312105259.2450-1-michal.swiatkowski@linux.intel.com>
 <PH0PR11MB50130FD5A519919523197C7C96362@PH0PR11MB5013.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB50130FD5A519919523197C7C96362@PH0PR11MB5013.namprd11.prod.outlook.com>

On Mon, Mar 25, 2024 at 06:36:56AM +0000, Buvaneswaran, Sujai wrote:
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> > Michal Swiatkowski
> > Sent: Tuesday, March 12, 2024 4:23 PM
> > To: intel-wired-lan@lists.osuosl.org
> > Cc: netdev@vger.kernel.org; Marcin Szycik <marcin.szycik@linux.intel.com>;
> > Kubiak, Michal <michal.kubiak@intel.com>; Michal Swiatkowski
> > <michal.swiatkowski@linux.intel.com>
> > Subject: [Intel-wired-lan] [iwl-net v1] ice: tc: do default match on all profiles
> > 
> > A simple non-tunnel rule (e.g. matching only on destination MAC) in
> > hardware will be hit only if the packet isn't a tunnel. In software execution of
> > the same command, the rule will match both tunnel and non-tunnel packets.
> > 
> > Change the hardware behaviour to match tunnel and non-tunnel packets in
> > this case. Do this by considering all profiles when adding non-tunnel rule
> > (rule not added on tunnel, or not redirecting to tunnel).
> > 
> > Example command:
> > tc filter add dev pf0 ingress protocol ip flower skip_sw action mirred \
> > 	egress redirect dev pr0
> > 
> > It should match also tunneled packets, the same as command with skip_hw
> > will do in software.
> > 
> > Fixes: 9e300987d4a8 ("ice: VXLAN and Geneve TC support")
> > Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> > Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
> > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > ---
> > v1 --> v2:
> >  * fix commit message sugested by Marcin
> > ---
> >  drivers/net/ethernet/intel/ice/ice_tc_lib.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> Hi,
> 
> We are seeing error while adding HW tc rules on PF with the latest net-queue patches. This issue is blocking the validation of latest net-queue Switchdev patches.
> 
> + tc filter add dev ens5f0np0 ingress protocol ip prio 1 flower src_mac b4:96:91:9f:65:58 dst_mac 52:54:00:00:16:01 skip_sw action mirred egress redirect dev eth0
> Error: ice: Unable to add filter due to error.
> We have an error talking to the kernel
> + tc filter add dev ens5f0np0 ingress protocol ip prio 1 flower src_mac b4:96:91:9f:65:58 dst_mac 52:54:00:00:16:02 skip_sw action mirred egress redirect dev eth1
> Error: ice: Unable to add filter due to error.
> We have an error talking to the kernel

Hi,

The same command is working fine on my setup. I suspect that it isn't
related to this patch. The change is only in command validation, there
is no functional changes here that can cause error during adding filters
which previously was working fine.

Can you share more information about the setup? It was the first filter
added on the PF? Did you do sth else before checking tc?

Thanks,
Michal
> 
> Thanks,
> Sujai B

