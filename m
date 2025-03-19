Return-Path: <netdev+bounces-176193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FB8A6949E
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 17:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C07478A2150
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 16:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C331B1DE2B9;
	Wed, 19 Mar 2025 16:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NMa/OjVF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DFE23CB;
	Wed, 19 Mar 2025 16:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400997; cv=none; b=bfqrpgtK2+/eUnpY3k2h2/6TnKVLUeqA6g67qEY2l1kjayP+sHldB6mZrntbjm66TbBhhXCS7GiSx8evy0irC+IDilWUs5KEf2YiT+uRR7NHI0gry+thwcaxZzX1cJGR4TNbyuRtes0sbiq/h6Bwddy+F2jT3ux3zGokdrG4FOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400997; c=relaxed/simple;
	bh=VGAR1tY2iPcoJdmpO7FPjMuoMelIZHDr5u58c6lmwNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuHn4Sis3wRuE6Wyyso99Ylv+YByZ24SMJt19fuckkrrQCyZRbx+zn9LHHQ6EU2vBpkHcMVxXjvJMHP6hLTRQUc3qLDDIX68veF6J04he5eSRmyn4OsBWseKvd4IQeoqTL4uofnqGAYHt/+HL43L+BBYMHSnru/J+szUBqSltRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NMa/OjVF; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742400996; x=1773936996;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VGAR1tY2iPcoJdmpO7FPjMuoMelIZHDr5u58c6lmwNw=;
  b=NMa/OjVFyR1N03NTAsHBs4A8SY50nEhGSdV+YMu4ohOnlQBuFNBnv5dC
   wL+8jYdChvnUvTk1CMbra7KBmYQgz4rGD5b1Ko310acxIvBnhRrkGZHwu
   mM9R7FZXM3cTlm0UxmUC3kFpnXsydweKViJKq2IR7nn9apBpefzTGFdum
   wx3C7nhttOASNuCF1AGB/LX7iggVmXTs0RuaqTrJJgWysdD3i8ByAo/L6
   lBaIa30Y6zkVx2XIg8cJNWa05NZeFKQCyE3qpaI58Zh5NV8i1qT176JmG
   rCwFC4ywUKmWs4cjIeGq3l7QYEWo8Vx5tO6dxiDglnxwpo3tfG5mGMepc
   A==;
X-CSE-ConnectionGUID: zTMKD+EVTWKg5/Ke8SII9w==
X-CSE-MsgGUID: pV1c/06/SzqakfnkMhVLxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="47251498"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="47251498"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 09:16:35 -0700
X-CSE-ConnectionGUID: g6I05fyZRDqHOF8qWFe4zg==
X-CSE-MsgGUID: jC3D2F9XS3SAnQw0IhN45A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="127777653"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 09:16:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tuw5m-00000003zRH-0sev;
	Wed, 19 Mar 2025 18:16:30 +0200
Date: Wed, 19 Mar 2025 18:16:29 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net v2 1/2] net: phy: Fix formatting specifier to avoid
 potential string cuts
Message-ID: <Z9rt3eHM6wdN-Yzg@smile.fi.intel.com>
References: <20250319105813.3102076-1-andriy.shevchenko@linux.intel.com>
 <20250319105813.3102076-2-andriy.shevchenko@linux.intel.com>
 <Z9rm6NYEQpbo4-pz@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9rm6NYEQpbo4-pz@shell.armlinux.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 19, 2025 at 03:46:48PM +0000, Russell King (Oracle) wrote:
> On Wed, Mar 19, 2025 at 12:54:33PM +0200, Andy Shevchenko wrote:

...

> > -#define PHY_ID_FMT "%s:%02x"
> > +#define PHY_ID_FMT "%s:%02hhx"
> 
> I was going to state whether it is correct to use hh with an "int"
> argument, as printf() suggests its only for use with arguments of
> type 'signed char' and 'unsigned char'. My suspicion has been

Yeah...

> It seems this is not a correct fix for the problem you report.

Apparently looks like (from the clang point of view — I compiled it with GCC).

...

Thanks for the review!

-- 
With Best Regards,
Andy Shevchenko



