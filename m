Return-Path: <netdev+bounces-181493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC3CA852E3
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 07:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F68A1BA0DBD
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 05:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6558C27CB1A;
	Fri, 11 Apr 2025 05:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jAgJ1/Af"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435D12AF04
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 05:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744348204; cv=none; b=PGJQOVq2Knz5rZcDstlh7Lc+JJpR4GhdywML9/b2BIToIADfwvQvlC2K/W0nlYd1qZINKgGp/lPxHmcvaXAtxsazf2Jhc1IH1a7Dua7gzDOAvH2FAJpUcTku5Rbr7XiFqVUWjrrrDalgs7mhCKBviFe26NotgVYhCtgdBIFMR24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744348204; c=relaxed/simple;
	bh=vehC3ir6+DUEoeBnIcaM4TgFoy1EgQz2HdFOnUoLOR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSYCi+ekgUouk5yF5G1irHTZ4WLA4vLAeV+tu1Fx6QoZ3zTrSo1qNUn/V6GS3Up34Qu6Q+gNzH2eUkz1u/MiWPGzR1Dn/eDF+8ZRUkllMiij2r4qT/FwLxxSxb432riBQ7kWUPi5GsMyrNPhq1Bf5Moh1r6ZnJwaNN9n5+Rgbf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jAgJ1/Af; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744348202; x=1775884202;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vehC3ir6+DUEoeBnIcaM4TgFoy1EgQz2HdFOnUoLOR4=;
  b=jAgJ1/AfBwo/tlmb0OHTvw7l0+DrOZdLx+Sxov9MAO+5b+hxwyf1R9ZY
   wR1W+cQ/O5kiyHLsjAnB+nj7IuW18uM3YExCsAv2zyeyi2laJwDlVdfy+
   KxHIQmKMHnzj40peySOAE4Ns9k1LJpemlgeIWMPmLWk0HBI7prnRce21M
   P/qlu9+qiqBuEvbfl/S+6L2jGtGhIIOZPq5BYaC6RyjXy5TpMip61Y3l6
   OPhueQYDY/8ZPUZjT4SmF8i4g2pfDxHO6eSy/vkuUvygs7Efklaeipxr6
   ty9WSicx+kvm6chPC9MkY9rIsi1evF8pcwA9CdEJ2tmzlCb1wRKywA+Nm
   A==;
X-CSE-ConnectionGUID: /DYP47rqTpuYdnUUMBj/+g==
X-CSE-MsgGUID: N26X50XTTYakrwttDc9eiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="63291119"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="63291119"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 22:10:01 -0700
X-CSE-ConnectionGUID: P7rnjctfTkWTewgQb+nfFA==
X-CSE-MsgGUID: cSRGpC/ET8y/s3Objjb5ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="129436869"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 22:09:59 -0700
Date: Fri, 11 Apr 2025 07:09:47 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Simon Horman <horms@kernel.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] idpf: fix potential memory
 leak on kcalloc() failure
Message-ID: <Z/ikGxzPOysJZvUh@mev-dev.igk.intel.com>
References: <20250404105421.1257835-1-michal.swiatkowski@linux.intel.com>
 <20250407104350.GA395307@horms.kernel.org>
 <bcf8dcc5-527d-41ae-95e4-3c0b6439d959@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcf8dcc5-527d-41ae-95e4-3c0b6439d959@intel.com>

On Thu, Apr 10, 2025 at 03:04:16PM -0700, Tony Nguyen wrote:
> On 4/7/2025 3:43 AM, Simon Horman wrote:
> > On Fri, Apr 04, 2025 at 12:54:21PM +0200, Michal Swiatkowski wrote:
> > > In case of failing on rss_data->rss_key allocation the function is
> > > freeing vport without freeing earlier allocated q_vector_idxs. Fix it.
> > > 
> > > Move from freeing in error branch to goto scheme.
> > > 
> > > Fixes: 95af467d9a4e ("idpf: configure resources for RX queues")
> > 
> > Hi Michal,
> > 
> > WRT leaking q_vector_indxs, that allocation is not present at
> > the commit cited above, so I think the correct Fixes tag for
> > that problem is the following, where that allocation was added:
> > 
> > Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
> 
> Patch applied. I do agree with Simon's assessment so plan to use this fixes.
> 

Thanks Tony, I also agree.

> Thanks,
> Tony
> 

