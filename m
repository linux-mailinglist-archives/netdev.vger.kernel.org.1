Return-Path: <netdev+bounces-87465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 824098A32CF
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 17:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36ED71F21A27
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 15:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26B21487EA;
	Fri, 12 Apr 2024 15:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c7MmZeNV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8506213BADA
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 15:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712936884; cv=none; b=lTxBR+i6tEptctpy5q28Fx0C/N8cb1WYTVsofAA0eQw8bJ2Ri/AQcqkPa7y1aWdinNIORl6PDsTGtdtnwrhc+/sE5S6hSEGvtpKcMPaGXrGGKScEdFL9mgDcunXMifP0mA+1BPD6fRaj5m3nYZ4tl7o4EiO5MjPqNv3Mbasvvd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712936884; c=relaxed/simple;
	bh=2iO6z02pPIAE7IQotMUXAIiCiXZP2sg6qJ25MQ8GJeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOV/SvK/n6dx4l6AvQ9Y8fX/xOZ9dYDBAe3adkLp4yJHlnqCAXjhlkiid/C02y2QpWQQhnxxFy9hyeIJyRO76xMOI1422Lv4SldB3T21dHzq4P0F/MuBMf/Btf3rVgj2CfccrKHtNRPaQJwUjoPSNdqS8j3t8dKL0/SusdueW5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c7MmZeNV; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712936884; x=1744472884;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2iO6z02pPIAE7IQotMUXAIiCiXZP2sg6qJ25MQ8GJeU=;
  b=c7MmZeNV4bFipPxvmxJGK25oOSkphu2FPN/s5hDohCJXPmu2LowXgzPh
   yLsNMS6jX4ATi3+ZW7cFGhqaysiXv2tWcSZjTHCZHn6h1i9LgqDAeHPud
   H43XbRKaryB7qOBPXYJt1cA6fltYwnbqLCQc17h6cYllo6At3O9+FvWeW
   RGraNqc2brf8+JYNfb6MuSwksfBzFN6UApoRmSpXk1TP6zI1gcjOi17sA
   SngAp6N8FkG7TRmgfbhFb15l6mhTYxUEk5fQhacmFc7K0RBMlCFSvbD7p
   2J5W4sC1FAkukGbSKrlxqvWBxbq7k0UzxNvnF2gmJ7h8M8letOW2IUROa
   A==;
X-CSE-ConnectionGUID: ubrHNHA9R/CCE3m81FiAmA==
X-CSE-MsgGUID: NRWKfODKQxKZhiDjb1Xyrw==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="8315006"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="8315006"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 08:48:03 -0700
X-CSE-ConnectionGUID: Gf7j/1d2TDWuOtTOqAoeJA==
X-CSE-MsgGUID: uunUilhLTCOgKITOlptBHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="21185576"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 08:48:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rvJ88-00000003h1x-27a3;
	Fri, 12 Apr 2024 18:47:56 +0300
Date: Fri, 12 Apr 2024 18:47:56 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Marek Vasut <marex@denx.de>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Eric Dumazet <edumazet@google.com>, Mark Brown <broonie@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v2 2/2] net: ks8851: Handle softirqs at the end of
 IRQ thread to fix hang
Message-ID: <ZhlXrDndMJDdoBH8@smile.fi.intel.com>
References: <20240405203204.82062-1-marex@denx.de>
 <20240405203204.82062-2-marex@denx.de>
 <ZhQEqizpGMrxe_wT@smile.fi.intel.com>
 <a8e28385-5b92-4149-be0c-cfce6394fbc2@denx.de>
 <20240412075220.17943537@kernel.org>
 <20240412075414.4509b75c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412075414.4509b75c@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 12, 2024 at 07:54:14AM -0700, Jakub Kicinski wrote:
> On Fri, 12 Apr 2024 07:52:20 -0700 Jakub Kicinski wrote:
> > In general, yes, trimming the bottom of the stack is good hygiene.
> 
> That sentence puts the words "bottom" and "hygiene" uncomfortably close
> together. Oh, well, it's Friday..

Oh, nice! Have a good one, and take your hygiene seriously even on Fridays!

-- 
With Best Regards,
Andy Shevchenko



