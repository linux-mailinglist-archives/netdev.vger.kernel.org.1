Return-Path: <netdev+bounces-146569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0836B9D45D9
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 03:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2EE4283B45
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 02:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940B5136358;
	Thu, 21 Nov 2024 02:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QYdK2R1H"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E1D63A9;
	Thu, 21 Nov 2024 02:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732157224; cv=none; b=cLBMGQ17mxZRuTcs42c0MO6PRd2rxjzmyo483J/eUOx2SH+ok3iaUBIe5uKJb7gWz8si2iwoAeA9UM2fgwZDdvwKcrQYwdFlpJ/xsc4cYwF1/eIdOCiRPcfCsNOmhez5LcnCf8KqfJCXwQUUZISWONA7q1zMXpnnLWfxaJ8r/5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732157224; c=relaxed/simple;
	bh=A62i+PCQPi9/pVfEwl8iAEDDlZJmY9G4trmTblRlT1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEyZ90rA5WFGsDEv7ecmQ/6TVCxU/HNG0crd/g22yZvC6cwBCojV8kh2F1kLPGQTEQuid1HnNOgmc9cTf1E6j2KvfuPak+ZWr96fi2iGfC48iO6BQqnqszCEx6xScTkeN8ydvZzGTC61OKJ4gmwNF6OpHIanMrKGLmRlTCs00CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QYdK2R1H; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732157223; x=1763693223;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A62i+PCQPi9/pVfEwl8iAEDDlZJmY9G4trmTblRlT1g=;
  b=QYdK2R1HFeA7vajtQiwaN3RAWGMvxUcSXQyj9R6qRXGKqYMVm+xE/WRW
   9KZ+ViLQ6z42/3J8mweM6Rj2RKFsYkljv7KIm6tYD45y66BX9bE3PKA8k
   JiKP9nthBor6IKJ4K2DrMxMCmT5jpt+dCiVVA4rIl/8Oz2PjmPK7Kvn5L
   jwqM3CxMTfkjPzEcMx37IOvaXUuyEZI+w903JrKUmSp4HUJ6cKbeCNlyx
   78+SCLtGY8UyFO3L6wwVAg/26U8MvqIt6FhaX160jvAGY/blYpPPVBXLh
   5lbRPbzJPDdgK5xei8/kSer7ZKhDjYJHUz0BtXdSkO8kUYNowSC5Ifzg5
   w==;
X-CSE-ConnectionGUID: 5lMjc7H3RfKw943eNKkkRw==
X-CSE-MsgGUID: w+MVOO2uTTubPJzaHoxbdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="35108362"
X-IronPort-AV: E=Sophos;i="6.12,171,1728975600"; 
   d="scan'208";a="35108362"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 18:47:02 -0800
X-CSE-ConnectionGUID: O1RbCacGTiy8VIx3JqGauQ==
X-CSE-MsgGUID: yuWeEvpKTJSjgi27k++SVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,171,1728975600"; 
   d="scan'208";a="94566387"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.109.177])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 18:47:01 -0800
Date: Wed, 20 Nov 2024 18:46:59 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v5 10/27] cxl: harden resource_contains checks to handle
 zero size resources
Message-ID: <Zz6fI-EZYdS5Uw0S@aschofie-mobl2.lan>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-11-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118164434.7551-11-alejandro.lucero-palau@amd.com>

On Mon, Nov 18, 2024 at 04:44:17PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> For a resource defined with size zero, resource_contains returns
> always true.
> 
I'm not following the premise above -

Looking at resource_contains() and the changes made below,
it seems the concern is with &cxlds->ram_res or &cxlds->pmem_res
being zero - because we already checked that the second param
'res' is not zero a few lines above.

Looking at what happens when r1 is of size 0, I don't see how
resource_contains() returns always true.

In resource_contains(r1, r2), if r1 is of size 0, r1->start == r1->end.
The func can only return true if r2 is also of size 0 and located at 
exactly r1->start. But, in this case, we are not going to get there
because we never send an r2 of size 0.

For any non-zero size r2 the func will always return false because
the size 0 r1 cannot encompass any range.

I could be misreading it all ;)

--Alison


> Add resource size check before using it.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/hdm.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 223c273c0cd1..c58d6b8f9b58 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -327,10 +327,13 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  	cxled->dpa_res = res;
>  	cxled->skip = skipped;
>  
> -	if (resource_contains(&cxlds->pmem_res, res))
> +	if (resource_size(&cxlds->pmem_res) &&
> +	    resource_contains(&cxlds->pmem_res, res)) {
>  		cxled->mode = CXL_DECODER_PMEM;
> -	else if (resource_contains(&cxlds->ram_res, res))
> +	} else if (resource_size(&cxlds->ram_res) &&
> +		   resource_contains(&cxlds->ram_res, res)) {
>  		cxled->mode = CXL_DECODER_RAM;
> +	}
>  	else {
>  		dev_warn(dev, "decoder%d.%d: %pr mixed mode not supported\n",
>  			 port->id, cxled->cxld.id, cxled->dpa_res);
> -- 
> 2.17.1
> 
> 

