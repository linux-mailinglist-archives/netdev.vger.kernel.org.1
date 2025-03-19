Return-Path: <netdev+bounces-176091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E263A68B75
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 12:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACA3E7A7D9A
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 11:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B97202981;
	Wed, 19 Mar 2025 11:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GN8/EY1V"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525B720FA98;
	Wed, 19 Mar 2025 11:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742383600; cv=none; b=HmU0b64LsE9WIHSp2+O2Nk2s7Bl9TojBzsWZiGtWHNN+wNHwhDJmg5bOLrXP4jtOsOu9OWNWednNA2BB5zsQXjdagTXiqrrBeMqMljw3JkpGb1W/LziQXKOMs8KLkZ9gp1UNa7SU0xYOMLfz3CGo6cNsi5YpR4s2+P6nbbE7vwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742383600; c=relaxed/simple;
	bh=dB9GCEMLNY6VMaee3n8EoNxVkjMyPXpZt6YLWfdnLQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFGbqBJu0vL8xaB7J11xnWQxwwGwZnFcGr9WzZxe6J1rzfQrTOsWdVQZg9I0pbAwp1qsnjIg8pOc4U0PTFbhFKeX6K46G0q6HhALw01x26ojjTJVpYO2l6+vIJw4V+KXDYQkEjlP2NZaBXZGEZWICQYjtaduAbCUto0rdOZ95RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GN8/EY1V; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742383599; x=1773919599;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=dB9GCEMLNY6VMaee3n8EoNxVkjMyPXpZt6YLWfdnLQQ=;
  b=GN8/EY1VFjhrmBcdbTpJAacEJMC6c8AxwgPSA6MnIycYaI7BLsrIQUC9
   AmYAMSZhjlqdHUxPieydqnutrgaq1/lc3HB7jtKcdIVSXaidHdpOk5UXj
   2NyhBMK77kOb0Rkh/AzSO6RWXQ8NX9BrbjbGpBLZLwCnFZu++TJ/3OQXv
   hgJTtO5yrIAcUWXtHg9/ZQXYN1LUwGVVd/TE/IZl9rqJHvrfYQpNs8qcK
   qjPgDIK6qUWhaqYBLUz5rbgvaJKPZwX031kea+kP6Lu47j4vVmcbyN9kb
   6mHxwlWMRvtK7KVGstlbwOf0h5EOJQgPZ8w80j0/hAmHQJypBY7rNL3xg
   A==;
X-CSE-ConnectionGUID: DNmoPdL+ShuKA8eew5sN9w==
X-CSE-MsgGUID: MIOMydv8RFCFctqx5gQEFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="31147064"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="31147064"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 04:26:38 -0700
X-CSE-ConnectionGUID: saX4j4ygQWaGvpXF2MKosw==
X-CSE-MsgGUID: GfhqXt5gScmLU4psj6a7aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="122313057"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 04:26:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1turZB-00000003u04-18HZ;
	Wed, 19 Mar 2025 13:26:33 +0200
Date: Wed, 19 Mar 2025 13:26:32 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net v2 2/2] net: usb: asix: ax88772: Increase phy_name
 size
Message-ID: <Z9qp6F26PbNczz9R@smile.fi.intel.com>
References: <20250319105813.3102076-1-andriy.shevchenko@linux.intel.com>
 <20250319105813.3102076-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250319105813.3102076-3-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 19, 2025 at 12:54:34PM +0200, Andy Shevchenko wrote:
> GCC compiler (Debian 14.2.0-17) is not happy about printing
> into a short buffer (when build with `make W=1`):
> 
>  drivers/net/usb/ax88172a.c: In function ‘ax88172a_reset’:
>  include/linux/phy.h:312:20: error: ‘%s’ directive output may be truncated writing up to 60 bytes into a region of size 20 [-Werror=format-truncation=]
> 
> Indeed, the buffer size is chosen based on some assumptions, while
> in general the assigned name might not fit. Increase the buffer to
> cover maximum length of the parameters. With that, change snprintf()
> to use sizeof() instead of hard coded number.

...

>  	if (ret < 0)
>  		goto free;
> -
> +	if (ret >= PHY_MAX_ADDR) {
> +		netdev_err(dev->net, "Invalid PHY ID %x\n", ret);
> +		return -ENODEV;

Oh, I was blindly put what had been suggested, needs a fix, but I will wait for
other comments if any before issuing a v3.

> +	}

-- 
With Best Regards,
Andy Shevchenko



