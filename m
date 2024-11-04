Return-Path: <netdev+bounces-141423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A925F9BADAC
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 09:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 767912813A7
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 08:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B892A19F42F;
	Mon,  4 Nov 2024 08:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H9C5FVyO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CD218C038;
	Mon,  4 Nov 2024 08:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730707670; cv=none; b=iKX+LILiSwiF3is7QrdPnPR5bz1K2hNxKfNY1cWYzc8FVEtoHUFJx9earQ+/+O+9ZNyjShW6ce8kpkWXZOWRxHuGNfEdQcBxTYUw+ZmDfs1NiQ3DlYBIyI2vK8AUEg/4xhAfJAEybaqEbC8m0WHyClNiNtB6EmreJ4ZENUK1jd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730707670; c=relaxed/simple;
	bh=EVN2V4bbSLmI7qsPcV4IxN2y4hO89i3pGgMbquzqX6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9t2am2YbdFHrjRm0kjaoFL3LUv2ICe8Ol7bDoQADkk7tQabSYH+2B5lpv/512qMy4He2cSnpmecrQcFTIjxrj2eJpXqMQuFzBe3yQdXW4Bu3eifhSF+bew9LAbifJ/xeDibuLrQAXnN48cgNgRNvWhNJ66DBMp8fEPJLjCZ0vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H9C5FVyO; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730707669; x=1762243669;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EVN2V4bbSLmI7qsPcV4IxN2y4hO89i3pGgMbquzqX6M=;
  b=H9C5FVyOQ2F4D3q6V0L5c4DLekBGf710/isnM5QyI/zQOS3jyUBVpO7h
   pfi0Fe9sfEAQh9bBLonIUlJ7OB6TzwVYkj4OLmK/q2929gO14NL/Lvwfl
   ca8fmoKUyC1EJh1d3PoRJivMx3dlMhziq+LmOeL3iSEDyoQhS6ekU26v6
   rs67yienzRxq17Begu4l1U2d7mx4ZWTtbljcjhP+Rh8cKYK/9QMMra+Iv
   N8D93xODhmz0pnW5iohWHaNTGqk6+HSHws2vVKkXF76GRKo5w2q/Gt9N5
   K90FgII5pbHr+WsF5JOaF5N5ljYi5YJyvSnQ+DWV2I0zqe3yNfj1lhfzv
   A==;
X-CSE-ConnectionGUID: tPhTL4EuQdalIaqHM+uKSw==
X-CSE-MsgGUID: +y4bCs4pSM6wk4IRkUrEYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="29819876"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="29819876"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 00:07:48 -0800
X-CSE-ConnectionGUID: L5XD7miLRYyV38vUW8BLSA==
X-CSE-MsgGUID: NVSUHHwgR4KxZpeM9CF2HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="87511484"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 00:07:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t7s7l-0000000AyaG-02Uy;
	Mon, 04 Nov 2024 10:07:45 +0200
Date: Mon, 4 Nov 2024 10:07:44 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/1] nfc: mrvl: Don't use "proxy" headers
Message-ID: <ZyiA0Hx6z4hHqwe0@smile.fi.intel.com>
References: <20241101083910.3362945-1-andriy.shevchenko@linux.intel.com>
 <2dc98d01-6353-478c-b6ad-d6eac63c53da@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dc98d01-6353-478c-b6ad-d6eac63c53da@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Nov 02, 2024 at 09:00:04AM +0100, Krzysztof Kozlowski wrote:
> On 01/11/2024 09:39, Andy Shevchenko wrote:
> > Update header inclusions to follow IWYU (Include What You Use)
> > principle.

...

> > -#include <linux/module.h>
> >  #include <linux/delay.h>
> > -#include <linux/of_gpio.h>
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/printk.h>
> 
> Do we really include printk?

Yes, we use it here.

> It's almost everywhere and pulled by kernel.h.

kernel.h shouldn't be considered at all, it's a mess which is on undergoing
cleaning up process.


> I assume you checked rest of the nfcmrvl files for similar cleanups, so
> anyway:
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thank you!

-- 
With Best Regards,
Andy Shevchenko



