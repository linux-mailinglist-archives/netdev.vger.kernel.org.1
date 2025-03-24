Return-Path: <netdev+bounces-177201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAF9A6E3D5
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 20:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AADF3AE1A3
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 19:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563D91A2872;
	Mon, 24 Mar 2025 19:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LYwrngq6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8350719E97A;
	Mon, 24 Mar 2025 19:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742845936; cv=none; b=gHwWBsLuupBcKr1GSXWq0u3fTd4zle1xBfoqL+VX7jmUiI0i1rlAqaF3TQBbj4gIKjm8MhJJo+drkeL2hxDW2jEhs+c+fQ1lnqhhtvp0Mj9UrLkZdFQAyDENdsXx9xA8AjQiC6/Cm53nGqTiAQWar070lZjzI8ZdWhqCWt9dyOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742845936; c=relaxed/simple;
	bh=n0Y3b7HRTtpTKyBWfhkTEuUsYWA03Tme1XcvVc3hf1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tqv8+NpkPWBF0/wYPkztlX+VY1DVPyBGUWF6AfhVELbidbKnc1kx6jkwUZD8cGJSGXShcLlvwSIDRMhmahCRzNewYKsUeJpOTyeBiLv3JL3Nt+PiiZB7ehO2atUZ7BGW4iKJ+WRRN9Q7exy8kGKAKiAU/bzPXXbkgIe6UyZZe7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LYwrngq6; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742845935; x=1774381935;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n0Y3b7HRTtpTKyBWfhkTEuUsYWA03Tme1XcvVc3hf1c=;
  b=LYwrngq6CvUuziy/5dBYlPVrDrn4sVfQd5LQ/qB6vsw+1QFahBWj1Yl9
   1F5zoobNoU8sTwsQUYQss3eBrO0iPSTxpYg9ovFE1FpsLERJLZqeTYT9F
   4E7Xp/0HvN9Rdt1VpMH+sJvZZf38AVIGwvn6A2jvAlApDk7Zd70yB9bBl
   vFTTkQZNxNCd88Oh89ZW3pg1AZqlr+0o7GwTmC5P0ILD8zgwnzhw1xQGk
   bRgg2Vzfi6wCN2BWzdkOXnCVYisX1KVH7XcFgpshTaco8sDtSN6pwXRwH
   I/vms3inaNsjC/S+plBiQoHyHT6+BJR0+A3tDopi4Xf0LKTnYhxo/C9Ob
   A==;
X-CSE-ConnectionGUID: 5G0pdwb5RhyOEAqHx5L5Tw==
X-CSE-MsgGUID: HQJcK1usRpiel6DcGlw2JA==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="61596024"
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="61596024"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 12:52:13 -0700
X-CSE-ConnectionGUID: J2q0b5/NQZe3MYkt1W+HnA==
X-CSE-MsgGUID: ed+exVfURjqFNe/cQArszg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="123957514"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 12:52:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1twnqC-00000005YFF-2EwL;
	Mon, 24 Mar 2025 21:52:08 +0200
Date: Mon, 24 Mar 2025 21:52:08 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net v3 1/2] net: =?utf-8?Q?phy?=
 =?utf-8?Q?=3A_Introduce_PHY=5FID=5FSIZE_?= =?utf-8?B?4oCU?= minimum size for
 PHY ID string
Message-ID: <Z-G36MdYl2og7lxb@smile.fi.intel.com>
References: <20250324144751.1271761-1-andriy.shevchenko@linux.intel.com>
 <20250324144751.1271761-2-andriy.shevchenko@linux.intel.com>
 <Z-F07j7tlez_94aK@shell.armlinux.org.uk>
 <Z-GAzlPEVR8p5l7-@smile.fi.intel.com>
 <Z-GYh7tWq6dNDDqt@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-GYh7tWq6dNDDqt@shell.armlinux.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 24, 2025 at 05:38:15PM +0000, Russell King (Oracle) wrote:
> On Mon, Mar 24, 2025 at 05:57:02PM +0200, Andy Shevchenko wrote:
> > On Mon, Mar 24, 2025 at 03:06:22PM +0000, Russell King (Oracle) wrote:

...

> > And just a bit of offtopic, can you look at
> > 20250312194921.103004-1-andriy.shevchenko@linux.intel.com
> > and comment / apply?
> 
> That needs to go into my patch system please. Thanks.

Ah, cool, just made it to appear there.

-- 
With Best Regards,
Andy Shevchenko



