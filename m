Return-Path: <netdev+bounces-151683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D6A9F0955
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 11:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 455DB282A00
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 10:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61351B85D0;
	Fri, 13 Dec 2024 10:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDIyQqJr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952251B4145;
	Fri, 13 Dec 2024 10:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734085402; cv=none; b=s5Ime9wc1uGjvaPlXRgPMTVaZuJn/1+15nFa7mILc/NU2TJ8MslcdXvVczAXlSl46dIibXwb8WDQnVNzG/AWQNSBc9sq2zM9fgecQhEE5/7hngqGZ/DP9t7aUDAGYPEPhjxEHksk880kp5czWNZTl0Q7ZyQIWbW/68LEv+15a+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734085402; c=relaxed/simple;
	bh=lMg/86jpjaUv6HmO7pjjt4aRZVA//ABM9ivj/xqi5yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wh77c6KW4J6Him+EVKJjkeZUcHpKho/7Jk+rMMBZZ7buGUC4wTsG1exgOyPYRoQJEF6eDrks/pckUO4AEyRRseEBlVI9hTx/EoadlKQezZIUnQpgJs68jy38wJNu5RGL3npUCAeREJDdaWkCRljNfTVO/nrgnk10677qrBbrKWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDIyQqJr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD9EC4CED0;
	Fri, 13 Dec 2024 10:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734085402;
	bh=lMg/86jpjaUv6HmO7pjjt4aRZVA//ABM9ivj/xqi5yY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XDIyQqJr/301acBG7F8LHhlyU7ix7d+gWKgn/wcaqW9CIWm/GIAboBadD3dU8ej/y
	 qLhgNf3n3ixuPGWQirxO7C8aU+VvR8AOjisrk4zfcoL5JWMJAdQcJjRrWBxy1udhgl
	 hbqe7RuLKBvAw2jo4Fp0qDUffUow7yidxRCOoJKBNY9gxCzBFdlDabZWDcMx0niucq
	 ebtWM1B43aNcx3fonBJHkzItRzDbnzGjyrCMJfUJCR3aGXw/ATDhcfllDmIc0CdY66
	 /KkmlBuE72jN0JutVqgRIJuq79c829etntLACW2w3w4Af2esuw3qRYor5aTrt9jdLz
	 O7NIs8s7uWvGw==
Date: Fri, 13 Dec 2024 10:23:17 +0000
From: Simon Horman <horms@kernel.org>
To: Alejandro Lucero Palau <alucerop@amd.com>
Cc: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
	netdev@vger.kernel.org, dan.j.williams@intel.com,
	martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com
Subject: Re: [PATCH v7 24/28] cxl: add region flag for precluding a device
 memory to be used for dax
Message-ID: <20241213102317.GH2110@kernel.org>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
 <20241209185429.54054-25-alejandro.lucero-palau@amd.com>
 <20241212184404.GC2110@kernel.org>
 <1c3dc1af-a633-141b-8425-8b7f2fcbe1ca@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c3dc1af-a633-141b-8425-8b7f2fcbe1ca@amd.com>

On Fri, Dec 13, 2024 at 09:47:42AM +0000, Alejandro Lucero Palau wrote:
> 
> On 12/12/24 18:44, Simon Horman wrote:
> > On Mon, Dec 09, 2024 at 06:54:25PM +0000, alejandro.lucero-palau@amd.com wrote:
> > > From: Alejandro Lucero <alucerop@amd.com>
> > > 
> > > By definition a type2 cxl device will use the host managed memory for
> > > specific functionality, therefore it should not be available to other
> > > uses. However, a dax interface could be just good enough in some cases.
> > > 
> > > Add a flag to a cxl region for specifically state to not create a dax
> > > device. Allow a Type2 driver to set that flag at region creation time.
> > > 
> > > Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> > > Reviewed-by: Zhi Wang <zhiw@nvidia.com>
> > > ---
> > >   drivers/cxl/core/region.c | 10 +++++++++-
> > >   drivers/cxl/cxl.h         |  3 +++
> > >   drivers/cxl/cxlmem.h      |  3 ++-
> > >   include/cxl/cxl.h         |  3 ++-
> > >   4 files changed, 16 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > > index b014f2fab789..b39086356d74 100644
> > > --- a/drivers/cxl/core/region.c
> > > +++ b/drivers/cxl/core/region.c
> > > @@ -3562,7 +3562,8 @@ __construct_new_region(struct cxl_root_decoder *cxlrd,
> > >    * cxl_region driver.
> > >    */
> > >   struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> > > -				     struct cxl_endpoint_decoder *cxled)
> > > +				     struct cxl_endpoint_decoder *cxled,
> > > +				     bool no_dax)
> > nit: no_dax should be added to the Kernel doc for this function.
> 
> 
> Yes, I'll do.
> 
> 
> > 
> > Also, I think you need to squash the following patch, which updates
> > the caller to use pass the extra argument, into this patch. Or otherwise
> > rework things slightly to avoid breaking bisection.
> 
> 
> Correct. Ed raised this concern as well, and I'll change the patches order
> in v8 for avoiding the problem.

Thanks, and sorry for missing that Ed had already raised this.

Likewise, thanks for responding to my other feedback on this patchset.

