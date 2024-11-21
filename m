Return-Path: <netdev+bounces-146719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FDF9D5466
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 22:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0004B21194
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 21:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5641D04A0;
	Thu, 21 Nov 2024 21:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mbQsejGl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4891CD1EE;
	Thu, 21 Nov 2024 21:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732222809; cv=none; b=LT5gn5SCoD/KmcCCBV7tTQ6OrattDWkGym3f0R2RsrXHhQVETcwUh3baDBjrh5LvI7A7Cvtl2+OHkM/5LGlV1DqtusIpi/dBJ3HYW1yrZsJvz5iGsF9lTFIlM+HCw+PSk/WGQd6dSZRU40M85oCnMORRX7H3qisCW0nW+yVMBPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732222809; c=relaxed/simple;
	bh=qoyTnOLbEeTjyk3jTZOKwZXe5VnuMNsNCLAG2H2TfC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozNyul7va9ugr0oXHMy9LisYx0vID7d6s4rVWuxyFeH6i40rxjceLu51+09OiVV36n95US21a+fCuXjKxy+jIG8QDTR9EBhOKiOmMDoO9lLfHaRsQ2nHeRXyNPYPZHxQfq531stGSqhNBFmR5KIpo8S6TWkBoLZrBlvMI0acuco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mbQsejGl; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732222809; x=1763758809;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=qoyTnOLbEeTjyk3jTZOKwZXe5VnuMNsNCLAG2H2TfC0=;
  b=mbQsejGlGE/Ek16axcOWjEMBIg9XBHvGpskKCCkPZlPcinTPFrm8hj5P
   8Q1+4RGd63XmdpbekbGnoQI58kDpEW4cc214AA/LElUgR3FKvM7YmzIVv
   fp8PxeGhwmkgiq3Kx0l270NQUSY0KJKAl+5qaXa32SnCLSQsXkUYOJ7Hx
   yS8ZWAxCLmnjWSFrdmuyhtPauFtdHrUAm2CkioDtGsXShLMv80egfHP0Y
   7xkdjIoACPSc+gvRiRwOr1MXe/c+QJCIldp9lru4amKV80aw6XE5JKWyW
   w+VxaUs6P82lSvGXrm4MMiM8mq98aA6m2MTsNE2Pk2uAtH9j2ExN15Sta
   A==;
X-CSE-ConnectionGUID: PZvET3pdT/2jBcIltyTowQ==
X-CSE-MsgGUID: /mLNRPpgTLWrGicXbp4FcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32509592"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="32509592"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 13:00:08 -0800
X-CSE-ConnectionGUID: 6ZqywhfGQ5SsXpS8vQAkTA==
X-CSE-MsgGUID: aivsU0qfRWCvwkOJLTwjhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="121323404"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.109.253])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 13:00:06 -0800
Date: Thu, 21 Nov 2024 13:00:05 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
Cc: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
	netdev@vger.kernel.org, dan.j.williams@intel.com,
	martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Subject: Re: [PATCH v5 10/27] cxl: harden resource_contains checks to handle
 zero size resources
Message-ID: <Zz-fVWhTOFG4Nek-@aschofie-mobl2.lan>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-11-alejandro.lucero-palau@amd.com>
 <Zz6fI-EZYdS5Uw0S@aschofie-mobl2.lan>
 <67a1ded1-c572-efe0-6ba3-d21f5c667aa8@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67a1ded1-c572-efe0-6ba3-d21f5c667aa8@amd.com>

On Thu, Nov 21, 2024 at 09:22:33AM +0000, Alejandro Lucero Palau wrote:
> 
> On 11/21/24 02:46, Alison Schofield wrote:
> > On Mon, Nov 18, 2024 at 04:44:17PM +0000, alejandro.lucero-palau@amd.com wrote:
> > > From: Alejandro Lucero <alucerop@amd.com>
> > > 
> > > For a resource defined with size zero, resource_contains returns
> > > always true.
> > > 
> > I'm not following the premise above -
> > 
> > Looking at resource_contains() and the changes made below,
> > it seems the concern is with &cxlds->ram_res or &cxlds->pmem_res
> > being zero - because we already checked that the second param
> > 'res' is not zero a few lines above.
> > 
> > Looking at what happens when r1 is of size 0, I don't see how
> > resource_contains() returns always true.
> > 
> > In resource_contains(r1, r2), if r1 is of size 0, r1->start == r1->end.
> > The func can only return true if r2 is also of size 0 and located at
> > exactly r1->start. But, in this case, we are not going to get there
> > because we never send an r2 of size 0.
> > 
> > For any non-zero size r2 the func will always return false because
> > the size 0 r1 cannot encompass any range.
> > 
> > I could be misreading it all ;)
> 
> 
> The key is to know how a resource with size 0 is initialized, what can be
> understood looking at DEFINE_RES_NAMED macro. The end field is set as  size
> - 1.
> 
> With unsigned variables, as it is the case here, it means to have a resource
> as big as possible ... if you do not check first the size is not 0.
> 
> The pmem resource is explicitly initialized inside cxl_accel_state_create in
> the previous patch, so it has:
> 
> pmem_res->start = 0, pmem_res.end = 0xffffffffffffffff
> 
> the resource checked against is defined with, for example, a 256MB size:
> 
> res.start =0, res.end = 0xfffffff
> 
> 
> if you then use resource_contains(pmem_res, res), that implies always true,
> whatever the res range defined.
> 
> 
> All this confused me as well when facing it initially. I hope this
> explanation makes sense.
> 

Thanks for the explanation! I'm wondering if we are leaving a trap for the next
developer.

resource_contains() seems to have intended that a check for IORESOURCE_UNSET
would take care of the zero size case:

(5edb93b89f6c resource: Add resource_contains)

and it would if folks used _UNSET. Some check r1->start before calling
resource_contains().

One option would be to use _UNSET in this case, but that only covers us here,
and doesn't remove the trap ;)

How about hardening resource_contains():

ie: make resource_contains() return false if either res empty

 /* True iff r1 completely contains r2 */
 static inline bool resource_contains(const struct resource *r1, const struct resource *r2)
 {
+       if (!resource_size(r1) || !resource_size(r2))
+               return false;
        if (resource_type(r1) != resource_type(r2))
                return false;
        if (r1->flags & IORESOURCE_UNSET || r2->flags & IORESOURCE_UNSET)
		return false;
	return r1->start <= r2->start && r1->end >= r2->end;
}

-- Alison

> > 
> > --Alison
> > 
> > 
> > > Add resource size check before using it.
> > > 
> > > Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> > > ---
> > >   drivers/cxl/core/hdm.c | 7 +++++--
> > >   1 file changed, 5 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > > index 223c273c0cd1..c58d6b8f9b58 100644
> > > --- a/drivers/cxl/core/hdm.c
> > > +++ b/drivers/cxl/core/hdm.c
> > > @@ -327,10 +327,13 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> > >   	cxled->dpa_res = res;
> > >   	cxled->skip = skipped;
> > > -	if (resource_contains(&cxlds->pmem_res, res))
> > > +	if (resource_size(&cxlds->pmem_res) &&
> > > +	    resource_contains(&cxlds->pmem_res, res)) {
> > >   		cxled->mode = CXL_DECODER_PMEM;
> > > -	else if (resource_contains(&cxlds->ram_res, res))
> > > +	} else if (resource_size(&cxlds->ram_res) &&
> > > +		   resource_contains(&cxlds->ram_res, res)) {
> > >   		cxled->mode = CXL_DECODER_RAM;
> > > +	}
> > >   	else {
> > >   		dev_warn(dev, "decoder%d.%d: %pr mixed mode not supported\n",
> > >   			 port->id, cxled->cxld.id, cxled->dpa_res);
> > > -- 
> > > 2.17.1
> > > 
> > > 

