Return-Path: <netdev+bounces-115220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B716945751
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 07:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A34F1B22B71
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 05:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5F220B28;
	Fri,  2 Aug 2024 05:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c13YB2Jl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41981C2BD
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 05:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722575612; cv=none; b=dbQdD418JHgUjsZNEGvsh5rtIBzng1aPtCM8qVlp+QMJU+Nr4aUFAdsfeqROJrtvvol0Wn0O3t9+DhTGpJSEY4AWOz5I1unNxmjw83LjDcJK127Xd9DM/JdrZH4ldm3oPZEKsEfPVkKTCawjjqMCtxfT7xE4o1Ebz0mMdhqM5eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722575612; c=relaxed/simple;
	bh=BJotbl272Qza6s3m8cpnta8Nu6fv7rwi61crt+cEZWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbGU9zDSY/TpHYfnTeUgsUjhevEywgAMQrrl9p5riB+mDahC5I8njKppbbcl7Rj/OGW2Anx/fC8TuflmnPsCO46Ipr3kjwXCkjTARzQndFsqjXWnKPFV/zbJeXke2AWzBDtIyEI+FKxAE9EfN6a2k/rZ17itvqqBJVr0UTqxp/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c13YB2Jl; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722575610; x=1754111610;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BJotbl272Qza6s3m8cpnta8Nu6fv7rwi61crt+cEZWs=;
  b=c13YB2JlK2LM2SwCiNsk+9oNmoG2+IjaA2/oklGVVCk+refhRd6nSfc7
   093Kux2hO0erAavozVe9jxAWEbJx0u40PLIC62A0hnQWDeKwzbRABixvb
   WoVOIbjlAx7tdESc21765AtVAjJtXZ5dLVPSl3cyqawn6Ga3GfhZ1YpDm
   aiZ1hmd11uhy3Nty1DBJAagFZj7tM8aRkFlIPk55cDtPdNA6c6vFqGVlx
   aFyuqqxcCQ1cyZOwNPRAH6hDvS6fGAPxuCKPKBzfo70CLUk5iMyHQjp2N
   aywJKPpEaLBtr2igLMRq2C32A9AvwLrVOrXUS/D1foyYR5gHw7zj/Mqu+
   g==;
X-CSE-ConnectionGUID: mdonif+DT3CbUcfLn4BnKg==
X-CSE-MsgGUID: C5BhcBBFS8+GmA4EQPko4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="12844649"
X-IronPort-AV: E=Sophos;i="6.09,256,1716274800"; 
   d="scan'208";a="12844649"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 22:13:29 -0700
X-CSE-ConnectionGUID: 8IukAjlyQhaTcRXRilISuA==
X-CSE-MsgGUID: u5OkKiL2S+6T+2cUGUv99g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,256,1716274800"; 
   d="scan'208";a="59391703"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 22:13:26 -0700
Date: Fri, 2 Aug 2024 07:11:48 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	netdev@vger.kernel.org, jiri@nvidia.com, shayd@nvidia.com,
	wojciech.drewek@intel.com, horms@kernel.org,
	sridhar.samudrala@intel.com, mateusz.polchlopek@intel.com,
	kalesh-anakkur.purayil@broadcom.com, michal.kubiak@intel.com,
	pio.raczynski@gmail.com, przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com, maciej.fijalkowski@intel.com
Subject: Re: [PATCH net-next v2 00/15][pull request] ice: support devlink
 subfunction
Message-ID: <ZqxqlP2EQiTY+JFc@mev-dev.igk.intel.com>
References: <20240731221028.965449-1-anthony.l.nguyen@intel.com>
 <ZqucmBWrGM1KWUbX@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqucmBWrGM1KWUbX@nanopsycho.orion>

On Thu, Aug 01, 2024 at 04:32:56PM +0200, Jiri Pirko wrote:
> Thu, Aug 01, 2024 at 12:10:11AM CEST, anthony.l.nguyen@intel.com wrote:
> >Michal Swiatkowski says:
> >
> >Currently ice driver does not allow creating more than one networking
> >device per physical function. The only way to have more hardware backed
> >netdev is to use SR-IOV.
> >
> >Following patchset adds support for devlink port API. For each new
> >pcisf type port, driver allocates new VSI, configures all resources
> >needed, including dynamically MSIX vectors, program rules and registers
> >new netdev.
> >
> >This series supports only one Tx/Rx queue pair per subfunction.
> >
> >Example commands:
> >devlink port add pci/0000:31:00.1 flavour pcisf pfnum 1 sfnum 1000
> >devlink port function set pci/0000:31:00.1/1 hw_addr 00:00:00:00:03:14
> >devlink port function set pci/0000:31:00.1/1 state active
> >devlink port function del pci/0000:31:00.1/1
> >
> >Make the port representor and eswitch code generic to support
> >subfunction representor type.
> >
> >VSI configuration is slightly different between VF and SF. It needs to
> >be reflected in the code.
> >---
> >v2:
> >- Add more recipients
> >
> >v1: https://lore.kernel.org/netdev/20240729223431.681842-1-anthony.l.nguyen@intel.com/
> 
> I'm confused a bit. This is certainly not v2. I replied to couple
> versions before. There is no changelog. Hard to track changes :/

You can see all changes here:
https://lore.kernel.org/netdev/20240606112503.1939759-1-michal.swiatkowski@linux.intel.com/

This is pull request from Tony, no changes between it and version from
iwl.

