Return-Path: <netdev+bounces-171615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DCEA4DD46
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 13:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8166F18886F2
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 11:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B0F1FFC68;
	Tue,  4 Mar 2025 11:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jrhw20Qy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745461F150D;
	Tue,  4 Mar 2025 11:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089524; cv=none; b=pu/XRv1QvMcEgIe+wa5cBmsMx7DKZwmwRDybVA+gQgA6OJRpEb8BKe3++4hToTo+zc+GRS5UKb3MvFN/vNxJLd1MB67zvUWU5eAaGWSkp8WXCl8ppd5WCgqaA8zGIW0a7iF5cUaG7IsFpDoAW2hHutCaHqtRnqUfZp5p+RPEOeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089524; c=relaxed/simple;
	bh=zJsKIqxmW/ciJ/CGeURsPQPLty/XONLIcsf/+xtesFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPlCsvjUJrpoU4hLQkVLj3uB74ItFyqUF5LrLPIOlrf/73aOvHOsp/juZE6LUTC6QH8vrLI2BZ3ybOgDTrPtvedIdWi2zX5dmcgOJX2FsJK5lqIIhDpvf/RZ7hckkmSVhfI4e5rir+n5f838f8UmvQamn9qbyIF78lhr5/KgeCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jrhw20Qy; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741089522; x=1772625522;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zJsKIqxmW/ciJ/CGeURsPQPLty/XONLIcsf/+xtesFI=;
  b=Jrhw20Qy4jy418BWFX8mP0aq1zoIX8nWn0ukKhs1lOtWfEiZlcE7NMKI
   z6wKyj0zQpo0L1ozffD0aR9569KksYgUiI3mQSgxXrkbcDqFdouK2ibYk
   3gxS7s/CmYeJ0Thlmx4t8kG1usunLc9gZTpMAVWT0/GYGyHzu2NiPVkYJ
   X+IWf4tMhf6i5d3g3jtDkOKbkXYbw3rd/ckIA4rDpd5hEIeJtvTuqz07P
   wj2+UkuiRX1Q9+gpPLguDHK6mMKSzsJJeIBjqa5r2KSwbRRcWRPbDYPpy
   cNd9RL3eW58fxHyMaYOFfWiyn0lA0cWGiC5Aeehbu1SHKS8RrZTjnde2p
   g==;
X-CSE-ConnectionGUID: VZZiqB0KR4S+u4MVTh25jQ==
X-CSE-MsgGUID: SV2uDMq7Q96PHy5w+WBMHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="67371840"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="67371840"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 03:58:39 -0800
X-CSE-ConnectionGUID: 42inDFCaQcmVRHWLz/Mh0w==
X-CSE-MsgGUID: W8on7+kbS2mKhC1BWiOwHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="149285886"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 03:58:36 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tpQuv-0000000H7B4-2FWl;
	Tue, 04 Mar 2025 13:58:33 +0200
Date: Tue, 4 Mar 2025 13:58:33 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rasesh Mody <rmody@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net v1 1/1] bnx2: Fix unused data compilation warning
Message-ID: <Z8bq6XJGJNbycmJ9@smile.fi.intel.com>
References: <20250228100538.32029-1-andriy.shevchenko@linux.intel.com>
 <20250303172114.6004ef32@kernel.org>
 <Z8bcaR9MS7dk8Q0p@smile.fi.intel.com>
 <5ec0a2cc-e5f6-42dd-992c-79b1a0c1b9f5@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ec0a2cc-e5f6-42dd-992c-79b1a0c1b9f5@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

+ Marek/Christoph (for the clarification/commenting on the below)

On Tue, Mar 04, 2025 at 12:39:40PM +0100, Paolo Abeni wrote:
> On 3/4/25 11:56 AM, Andy Shevchenko wrote:
> > On Mon, Mar 03, 2025 at 05:21:14PM -0800, Jakub Kicinski wrote:
> >> On Fri, 28 Feb 2025 12:05:37 +0200 Andy Shevchenko wrote:
> >>> In some configuration, compilation raises warnings related to unused
> >>> data. Indeed, depending on configuration, those data can be unused.
> >>>
> >>> Mark those data as __maybe_unused to avoid compilation warnings.
> >>
> >> Will making dma_unmap_addr access the first argument instead of
> >> pre-processing down to nothing not work?
> > 
> > I looked at the implementation of those macros and I have no clue
> > how to do that in a least intrusive way. Otherwise it sounds to me
> > quite far from the scope of the small compilation error fix that
> > I presented here.

> I *think* Jakub is suggesting something alike:

I see. Perhpas we need Marek's/Christoph's opinion on this...

> ---
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index b79925b1c433..927884f10b0f 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -629,7 +629,7 @@ static inline int dma_mmap_wc(struct device *dev,
>  #else
>  #define DEFINE_DMA_UNMAP_ADDR(ADDR_NAME)
>  #define DEFINE_DMA_UNMAP_LEN(LEN_NAME)
> -#define dma_unmap_addr(PTR, ADDR_NAME)           (0)
> +#define dma_unmap_addr(PTR, ADDR_NAME)           (((PTR)->ADDR_NAME), 0)
>  #define dma_unmap_addr_set(PTR, ADDR_NAME, VAL)  do { } while (0)
>  #define dma_unmap_len(PTR, LEN_NAME)             (0)
>  #define dma_unmap_len_set(PTR, LEN_NAME, VAL)    do { } while (0)
> ---
> 
> Would that work?

I do not know. Not my area of expertise.

-- 
With Best Regards,
Andy Shevchenko



