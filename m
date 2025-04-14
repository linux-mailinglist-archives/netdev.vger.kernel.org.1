Return-Path: <netdev+bounces-182101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E5AA87D14
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 12:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4B01887C51
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 10:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33B2265601;
	Mon, 14 Apr 2025 10:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I9HEknF6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4569825F7BB;
	Mon, 14 Apr 2025 10:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744625324; cv=none; b=Tz5hOGzXxZRM/+obSMbtZhvvhhSxTRBygpoV7a+DKCM6XzsH2qG91/+gw/MrKjafAVIagDytO+mSDfCEEBNDQpb09boQ0aYo95V2swpQNJkLJpr+2sYnL6IR81jsg8DHP4Q41IlTCGEap8tXrh873EbJBtTKRWoLxzFJHIZA418=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744625324; c=relaxed/simple;
	bh=MrR3zw2lw8uRpfgnFdyEiW4r4y3mal3xQyzKs1wyVP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p95FSKwJgUbsikahAOqclhk073yh1U/LkIQsLM5QqFrKdj3dOmcKA2AYJm/Y3rpGM4nHyJjX4Vj57tSaXyFN3oiUn5V+2nbOmgnfY7JGmYUjJgLAKhDWEmmIaArusxL7M/fDr1HoKTlcHQzJMGuOD3vElqw6H2r4zz/5LJ+g/CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I9HEknF6; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744625323; x=1776161323;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MrR3zw2lw8uRpfgnFdyEiW4r4y3mal3xQyzKs1wyVP4=;
  b=I9HEknF6TxQKPo3Q3hfu1c5WhAW207o2mSKxEZ21SL1yf1Fu3d7EFV/H
   YWims3JxWP6Z9b1y8eHoatZ0RpWfMhqteIbFgge0jHMENtSttCZFvIhRE
   B45PtkZ0ZnTowkLuqjAHfmQYtLyIHKO6PkV9Y2OHaN1C+9txkAGCPLAKh
   iulZWXv4fbrOTDMlvNVIm/BNryG/oJuDgoxw8fR4R48groY1rQmNoUMKr
   u3tf35FkRcMyPzUg9m0wqefSHJduSjwyV1TlFUcKNvn3D2NvjewxXaWn7
   arU8XF1Nm7Im9aT+VoAlxurAu+XaMngLLtVBq9XT+thUBbpGiptHzbq8J
   w==;
X-CSE-ConnectionGUID: m3r3rJzeRI2l1hF53XOXwg==
X-CSE-MsgGUID: e9G8LXxpS0G8ny1v8Ap5/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="57077410"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="57077410"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 03:08:42 -0700
X-CSE-ConnectionGUID: c7plomItRhCXTkGVSRliWw==
X-CSE-MsgGUID: K8wOgtPYTQ+FiRs5U5pxaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="130754476"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 03:08:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u4Gk0-0000000CCeQ-3p4I;
	Mon, 14 Apr 2025 13:08:36 +0300
Date: Mon, 14 Apr 2025 13:08:36 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christoph Hellwig <hch@lst.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rasesh Mody <rmody@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net v1 1/1] bnx2: Fix unused data compilation warning
Message-ID: <Z_zepIheW2zKq0yg@smile.fi.intel.com>
References: <20250303172114.6004ef32@kernel.org>
 <Z8bcaR9MS7dk8Q0p@smile.fi.intel.com>
 <5ec0a2cc-e5f6-42dd-992c-79b1a0c1b9f5@redhat.com>
 <Z8bq6XJGJNbycmJ9@smile.fi.intel.com>
 <Z8cC_xMScZ9rq47q@smile.fi.intel.com>
 <20250304083524.3fe2ced4@kernel.org>
 <CGME20250305100010eucas1p1986206542bc353300aee7ac8d421807f@eucas1p1.samsung.com>
 <Z8ggoUoKpSPPcs5S@smile.fi.intel.com>
 <067bd072-eb3f-451a-b1c4-59eae777cf00@samsung.com>
 <Z9G0QU5Ew3FusrJH@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9G0QU5Ew3FusrJH@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 12, 2025 at 06:20:17PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 11, 2025 at 01:51:21PM +0100, Marek Szyprowski wrote:
> > On 05.03.2025 11:00, Andy Shevchenko wrote:
> > > On Tue, Mar 04, 2025 at 08:35:24AM -0800, Jakub Kicinski wrote:
> > >> On Tue, 4 Mar 2025 15:41:19 +0200 Andy Shevchenko wrote:

...

> > >> I meant something more like (untested):
> > > We are starving for the comment from the DMA mapping people.
> > 
> > I'm really sorry for this delay. Just got back to the everyday stuff 
> > after spending a week in bed recovering from flu...
> 
> Oh, I hope you feel much better now!
> 
> ...
> 
> > >>   #define DEFINE_DMA_UNMAP_ADDR(ADDR_NAME)
> > >>   #define DEFINE_DMA_UNMAP_LEN(LEN_NAME)
> > >> -#define dma_unmap_addr(PTR, ADDR_NAME)           (0)
> > >> -#define dma_unmap_addr_set(PTR, ADDR_NAME, VAL)  do { } while (0)
> > >> -#define dma_unmap_len(PTR, LEN_NAME)             (0)
> > >> -#define dma_unmap_len_set(PTR, LEN_NAME, VAL)    do { } while (0)
> > >> +#define dma_unmap_addr(PTR, ADDR_NAME)           ({ typeof(PTR) __p __maybe_unused = PTR; 0; )}
> > >> +#define dma_unmap_addr_set(PTR, ADDR_NAME, VAL)  do { typeof(PTR) __p __maybe_unused = PTR; } while (0)
> > >> +#define dma_unmap_len(PTR, LEN_NAME)             ({ typeof(PTR) __p __maybe_unused = PTR; 0; )}
> > >> +#define dma_unmap_len_set(PTR, LEN_NAME, VAL)    do { typeof(PTR) __p __maybe_unused = PTR; } while (0)
> 
> > >> I just don't know how much code out there depends on PTR not
> > >> existing if !CONFIG_NEED_DMA_MAP_STATE
> > > Brief checking shows that only drivers/net/ethernet/chelsio/* comes
> > > with ifdeffery, the rest most likely will fail in the same way
> > > (note, overwhelming majority of the users is under the network realm):
> > 
> > Frankly speaking I wasn't aware of this API till now.
> > 
> > If got it right the above proposal should work fine. The addr/len names 
> > can be optimized out, but the pointer to the container should exist.
> 
> Thanks for the reply, would you or Jakub will to send a formal patch?
> I can test it on my configuration and build.

Any news here? The problem still persist AFAICT.

-- 
With Best Regards,
Andy Shevchenko



