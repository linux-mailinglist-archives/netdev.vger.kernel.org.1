Return-Path: <netdev+bounces-85115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00645899847
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 10:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA071282842
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 08:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D176915FA77;
	Fri,  5 Apr 2024 08:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XUAPGZVh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D859515FA9E
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 08:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712306606; cv=none; b=jMRaUpgk329SUKMSvIErVY8j5EZbNaYbv/KmeN89IUWH0Yrq7mS74bIIWlR5mkrp1Zc9B0TSC4Dk5juku+1baVP4iaIjmkr3fbv4Snf0Fr25Qi2j8UzMNNR84ZQicWfcWd/p3st41IOKAmZaOYmRRYr6DXvGp3jKL6cyidfWFu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712306606; c=relaxed/simple;
	bh=l02dn70i51wUrkwv5ZNoBFyKNpyPl0y3pIsw1ver82o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFNCtPGsKV+3CEqc+ZdGKazcSIom2e+wx1rHcH/URo10KUgdRrY347YNHSttk0aUpNKrlr1YdGWwQNryAKsfA2Cte05f+EcN9CPEQC4tGfW3idspSB21WJr7upku2e366wJDLzou9L3MwhmcvgQMz65YfGAcJC/zrvc7c3fan2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XUAPGZVh; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712306605; x=1743842605;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l02dn70i51wUrkwv5ZNoBFyKNpyPl0y3pIsw1ver82o=;
  b=XUAPGZVhxMv6OaSTXsuqnKQTg5nnO1xiBUxaMZrbjEEt2li3YP+zLlrA
   c3m4dYb6gM0mtQxZ0FUtzSTrZq3mdQ5CYshBfyAoePoUcI/N+/EPZARAG
   ZdIjN6aJmGXjy86yXGitOXq3RkXiCKJnVk3N0Bjw/1F4ICRXLQNVAMdiI
   gn8RBt70dXAOb6wZcwAEIP0kd15jhjgn8EbRF3emb6Rm25FthG8TPnSu5
   y6Cvx3c4h7m8WC+i6t8fTIgpcYG5LpdyvAlQsMECx4voMD0e5FhFvRnnR
   88wk315Kg+qBHJC3lAAC6Z7qZ6Hp7GcZC2yTtiFpUcng84+t/XvA1Fwpu
   w==;
X-CSE-ConnectionGUID: ozRbsdBXSS+A9+dgdHS1Rw==
X-CSE-MsgGUID: CKw0O/MDSE+kH0K44rw/OQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="33023481"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="33023481"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 01:43:23 -0700
X-CSE-ConnectionGUID: S3yFI09+QWGtYBRGxYV1Pw==
X-CSE-MsgGUID: TrZFISqHSPq5OKSd6pg0Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="23814485"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 01:43:21 -0700
Date: Fri, 5 Apr 2024 10:43:04 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	"Kubiak, Michal" <michal.kubiak@intel.com>
Subject: Re: [Intel-wired-lan] [iwl-net v1] ice: tc: do default match on all
 profiles
Message-ID: <Zg+5mIUtMruFRck0@mev-dev>
References: <20240312105259.2450-1-michal.swiatkowski@linux.intel.com>
 <PH0PR11MB50130FD5A519919523197C7C96362@PH0PR11MB5013.namprd11.prod.outlook.com>
 <ZgZ6/6/R+5EfQvbb@mev-dev>
 <PH0PR11MB5013EC7967F8B7694B2F5C8C963F2@PH0PR11MB5013.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB5013EC7967F8B7694B2F5C8C963F2@PH0PR11MB5013.namprd11.prod.outlook.com>

On Mon, Apr 01, 2024 at 09:28:30AM +0000, Buvaneswaran, Sujai wrote:
> > -----Original Message-----
> > From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > Sent: Friday, March 29, 2024 1:56 PM
> > To: Buvaneswaran, Sujai <sujai.buvaneswaran@intel.com>
> > Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Marcin Szycik
> > <marcin.szycik@linux.intel.com>; Kubiak, Michal <michal.kubiak@intel.com>
> > Subject: Re: [Intel-wired-lan] [iwl-net v1] ice: tc: do default match on all
> > profiles
> > 
> > On Mon, Mar 25, 2024 at 06:36:56AM +0000, Buvaneswaran, Sujai wrote:
> > > > -----Original Message-----
> > > > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > > > Of Michal Swiatkowski
> > > > Sent: Tuesday, March 12, 2024 4:23 PM
> > > > To: intel-wired-lan@lists.osuosl.org
> > > > Cc: netdev@vger.kernel.org; Marcin Szycik
> > > > <marcin.szycik@linux.intel.com>; Kubiak, Michal
> > > > <michal.kubiak@intel.com>; Michal Swiatkowski
> > > > <michal.swiatkowski@linux.intel.com>
> > > > Subject: [Intel-wired-lan] [iwl-net v1] ice: tc: do default match on
> > > > all profiles
> > > >
> > > > A simple non-tunnel rule (e.g. matching only on destination MAC) in
> > > > hardware will be hit only if the packet isn't a tunnel. In software
> > > > execution of the same command, the rule will match both tunnel and
> > non-tunnel packets.
> > > >
> > > > Change the hardware behaviour to match tunnel and non-tunnel packets
> > > > in this case. Do this by considering all profiles when adding
> > > > non-tunnel rule (rule not added on tunnel, or not redirecting to tunnel).
> > > >
> > > > Example command:
> > > > tc filter add dev pf0 ingress protocol ip flower skip_sw action mirred \
> > > > 	egress redirect dev pr0
> > > >
> > > > It should match also tunneled packets, the same as command with
> > > > skip_hw will do in software.
> > > >
> > > > Fixes: 9e300987d4a8 ("ice: VXLAN and Geneve TC support")
> > > > Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> > > > Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
> > > > Signed-off-by: Michal Swiatkowski
> > > > <michal.swiatkowski@linux.intel.com>
> > > > ---
> > > > v1 --> v2:
> > > >  * fix commit message sugested by Marcin
> > > > ---
> > > >  drivers/net/ethernet/intel/ice/ice_tc_lib.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > Hi,
> > >
> > > We are seeing error while adding HW tc rules on PF with the latest net-
> > queue patches. This issue is blocking the validation of latest net-queue
> > Switchdev patches.
> > >
> > > + tc filter add dev ens5f0np0 ingress protocol ip prio 1 flower
> > > + src_mac b4:96:91:9f:65:58 dst_mac 52:54:00:00:16:01 skip_sw action
> > > + mirred egress redirect dev eth0
> > > Error: ice: Unable to add filter due to error.
> > > We have an error talking to the kernel
> > > + tc filter add dev ens5f0np0 ingress protocol ip prio 1 flower
> > > + src_mac b4:96:91:9f:65:58 dst_mac 52:54:00:00:16:02 skip_sw action
> > > + mirred egress redirect dev eth1
> > > Error: ice: Unable to add filter due to error.
> > > We have an error talking to the kernel
> > 
> > Hi,
> > 
> > The same command is working fine on my setup. I suspect that it isn't related
> > to this patch. The change is only in command validation, there is no
> > functional changes here that can cause error during adding filters which
> > previously was working fine.
> > 
> > Can you share more information about the setup? It was the first filter added
> > on the PF? Did you do sth else before checking tc?
> 
> Hi Michal,
> I have used the setup with latest upstream dev-queue kernel and this issue is observed while adding HW tc rules on PF using
> 'Script A' from below link.
> https://edc.intel.com/content/www/us/en/design/products/ethernet/appnote-e810-eswitch-switchdev-mode-config-guide/script-a-switchdev-mode-with-linux-bridge-configuration/
> 
> This issue is reproducible on two of our setups with latest upstream kernel - 6.9.0-rc1+. Please check and let me know if more information is needed.
> 

I tried script from the link and it is working. I am aware of the
problem when the same rule is being added with different destination.
Are you sure there are no more exsisting rule before calling the script?
In the script VFs are removed, but PF qdisc isn't removed. Old rule can
exsist there. I suggest to add sth like, before adding new qdiscs:
$tc qdisc del dev $PF1 ingress

I tested on 6.9.0-rc1+ kernel.

Thanks,
Michal
> Thanks,
> Sujai B
> > 
> > Thanks,
> > Michal
> > >
> > > Thanks,
> > > Sujai B

