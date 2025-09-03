Return-Path: <netdev+bounces-219684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3FBB429CC
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 21:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76A1B6884B0
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 19:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442AA369342;
	Wed,  3 Sep 2025 19:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="agOSIsWI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A366636809C
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 19:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756927387; cv=none; b=hfZsXPNDF9G0YuNJBbWnuhjzJupzjwTrKs9Qcy5OakJEt6UD+75jKZ5q7s9t4827KTolIFx6RVRAir4gf5FsKdUn08RMj5NroxK9PGN70SLExF/T3P+UjiaU1GYRUKreU+TLDZnEXwI/D3NXQ0SpFxYB7zE3vwfpRkgaeXjjZYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756927387; c=relaxed/simple;
	bh=XA088yhodMv3GZY1MWvIooSa2d+edHICESp6BUVgcY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iX8zhU8MHOcy8b22a4D4JUOQ9dIzyhSc9rhcDcCEa8P9q5aulF6u2ZJT69vs8NzTKQZWDqAXxoHG3yiZmPYrQxWBoDj5BIc/urneOAk6xdOqivBOi4v4ir9fb4fk4CQgEqIxl4a7ROHcBxc+BuNX5PXCyy7jc0pajmwVg2Ljtyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=agOSIsWI; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756927386; x=1788463386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XA088yhodMv3GZY1MWvIooSa2d+edHICESp6BUVgcY0=;
  b=agOSIsWIgWbzK/kCzMpOP907s5+fU2UA+WQ+xhzr3blHYeHnBMNwY9AK
   a6aj4l+OvkRxSquvYxAdweFV4IUmlGCBbE0IQ/gTG3AuVhgcuNYJM8T/q
   lBLpHilMgZSEkAzlTQZ/tSqzGXNuum2TKQtY1KrzGmS5By9tiBvKbjE7g
   bdskQvRSiIrCwCjb8LFv5H/eaCsDq4aS1OfVhUl6do7MJbmcs703MbGY0
   ud7RzW55oH3g1MZ46gar8h/Beyu4teySqDYNdZKIvbuD04bqLPxydDlaW
   MyOV9/YMKbthzl3maAP0DS7889dgLp1k2mjQ0qRqxrGBupA2JgwZuTJWn
   w==;
X-CSE-ConnectionGUID: rZGgYKl9SLiA9sixpmjGLA==
X-CSE-MsgGUID: wO9ruMn/T7m8BhMi8jGTcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="58286207"
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="58286207"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 12:23:05 -0700
X-CSE-ConnectionGUID: VT1qezjQTjaDcds07cIUrQ==
X-CSE-MsgGUID: rf6DrBTgRBK9NZdqF1NQvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="171233845"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 12:23:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1utt4N-0000000B4Hf-1TsR;
	Wed, 03 Sep 2025 22:22:59 +0300
Date: Wed, 3 Sep 2025 22:22:59 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Simon Horman <horms@kernel.org>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alex Marginean <alexandru.marginean@nxp.com>, imx@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: enetc: Correct endianness handling in
 _enetc_rd_reg64
Message-ID: <aLiVk0QYg1VUm9tT@smile.fi.intel.com>
References: <20250624-etnetc-le-v1-1-a73a95d96e4e@kernel.org>
 <aLiVHw4WQW69A5qL@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLiVHw4WQW69A5qL@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 03, 2025 at 10:21:03PM +0300, Andy Shevchenko wrote:
> On Tue, Jun 24, 2025 at 05:35:12PM +0100, Simon Horman wrote:
> > enetc_hw.h provides two versions of _enetc_rd_reg64.
> > One which simply calls ioread64() when available.
> > And another that composes the 64-bit result from ioread32() calls.
> > 
> > In the second case the code appears to assume that each ioread32() call
> > returns a little-endian value. However both the shift and logical or
> > used to compose the return value would not work correctly on big endian
> > systems if this were the case. Moreover, this is inconsistent with the
> > first case where the return value of ioread64() is assumed to be in host
> > byte order.
> > 
> > It appears that the correct approach is for both versions to treat the
> > return value of ioread*() functions as being in host byte order. And
> > this patch corrects the ioread32()-based version to do so.
> > 
> > This is a bug but would only manifest on big endian systems
> > that make use of the ioread32-based implementation of _enetc_rd_reg64.
> > While all in-tree users of this driver are little endian and
> > make use of the ioread64-based implementation of _enetc_rd_reg64.
> > Thus, no in-tree user of this driver is affected by this bug.

...

> > @@ -507,7 +507,7 @@ static inline u64 _enetc_rd_reg64(void __iomem *reg)
> >  		tmp = ioread32(reg + 4);
> >  	} while (high != tmp);
> >  
> > -	return le64_to_cpu((__le64)high << 32 | low);
> > +	return (u64)high << 32 | low;
> >  }
> 
> Description and the visible context rings a bell like this is probably a
> reimplementation of ioread64_lo_hi().

And important to add, if the respective (-lo-hi.h) is included, ioread64()
automatically will be ioread64_lo_hi() and hence code can drop all these custom
calls, but again, I haven't looked into it for the details.

-- 
With Best Regards,
Andy Shevchenko



