Return-Path: <netdev+bounces-141426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F409BADD0
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 09:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3980C1F2143B
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 08:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8574F1AAE02;
	Mon,  4 Nov 2024 08:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GjT+Bwgs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D2B189F3E;
	Mon,  4 Nov 2024 08:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730708108; cv=none; b=pG3eVgkLCmYSpVXOVjCFmRgSPpPpL53knmhBFCfebUU3JgSENP6Ah5BxTrcsYX1J4UoZWw42/LQh3nO+HuTC1zt/pzEIITve1W81dIu+ROVNUQdiLO7PXVB0dqUmYImHEuffdnU0CAheckASCtVUwIk0lwY7Uhol+I+f3CfubCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730708108; c=relaxed/simple;
	bh=hT4FCH486t3V3Qz4Rmmzls3k8/phtgySsg9h1wAxi/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bv2TkjnppI5BPtNSb6gZAxOHyur3Fw3mneK9A08nwHGH0OfPjyE/67qPDDsqiumMBiWo+0Ll2BLoSOzRVJITiN8WsY0Wf/JsI9kSrQhulBmPzMTWxbmopglbYtEFYSPPadZhhOY/d31KDAl720f9PmBLngFWnz7B8uiR/NDIdLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GjT+Bwgs; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730708107; x=1762244107;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hT4FCH486t3V3Qz4Rmmzls3k8/phtgySsg9h1wAxi/A=;
  b=GjT+BwgsPdXzH/zFL3L5h6mrGE5iYpXTSHJUuwRfqyQiP3pTYXaMLNv+
   +FHIc1J3Ec2QdFSQCd++wn4m0t6ygfbJN1KM7+EYS7nFAtnXm3+vI36iB
   3KKbF5CMh7qtk+EuCfdRGaUlwy6YJHJAAAbBsaXp3hnGqtOnvTIWTaDGJ
   pBTO/MuUn4Fj0VxfDxARKKuPRyWNV5QiAMd5YHOK66PDCWVes6VESCH5T
   VuBEV20xr41IA1J9gb927L4E6FZZguQSnUbjDpCwvc8/diAAyK8XjElu8
   ADY8KGjw+PkuWn/v92c0CEzUYkTeack/ah2WLoTLZZRUU8E97MYVKxYty
   w==;
X-CSE-ConnectionGUID: u/UKKqXiQMOL2FreRrWHcQ==
X-CSE-MsgGUID: Y5fVdlpVRiO+SLlmfieOpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="34313586"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="34313586"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 00:15:06 -0800
X-CSE-ConnectionGUID: 1ovYFQR0RfaFuhcD762Azw==
X-CSE-MsgGUID: 2zHcmJctSg2Xa6a/evKhEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="83922798"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 00:15:04 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t7sEo-0000000AyiB-1hvd;
	Mon, 04 Nov 2024 10:15:02 +0200
Date: Mon, 4 Nov 2024 10:15:02 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH net-next v1 1/1] nfc: mrvl: Don't use "proxy" headers
Message-ID: <ZyiChsS_zrHlet3E@smile.fi.intel.com>
References: <20241101083910.3362945-1-andriy.shevchenko@linux.intel.com>
 <20241103081740.7bc006c1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241103081740.7bc006c1@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Nov 03, 2024 at 08:17:40AM -0800, Jakub Kicinski wrote:
> On Fri,  1 Nov 2024 10:39:10 +0200 Andy Shevchenko wrote:
> > Subject: [PATCH net-next v1 1/1] nfc: mrvl: Don't use "proxy" headers
> 
> What is a "proxy" header?

The "proxy" header is any header that the code rely on to include other(s)
*not related* to that header headers. Hopefully, despite too many words
"header" you got the idea.

> Guessing by the two patches you posted - are you trying to get rid of
> of_gpio.h?

In this particular case:
1) I want to get rid of deprecated of_gpio.h;
2) but at the same time it *is* a "proxy" header in this case.

> > Update header inclusions to follow IWYU (Include What You Use)
> > principle.
> 
> I'm definitely on board with cleaning this up, but would prefer
> to make sure we can validate new patches against introducing
> regressions.

0-day LKP quite likely will notice any issues with this (it's quite good
at it), and so far it reported A-OK.

> Otherwise the stream of patches will be never ending.

I know, and this is pity. And there was an attempt to make clang based tool
for that, but no move forward as far as I can see. So, you are welcome to help
developing such a tool.

> What tooling do you use?

My brains and my expertise in Linux Kernel project for the dependency hell
we have in the headers.

> Is it easy to integrate into a CI system?

I don't think so.

Can we have this being applied meanwhile, please? It's a showstopper for
getting rid of of_gpio.h rather sooner than later.

-- 
With Best Regards,
Andy Shevchenko



