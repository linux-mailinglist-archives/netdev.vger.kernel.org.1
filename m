Return-Path: <netdev+bounces-176084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E373BA68B7D
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 12:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67457462531
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 11:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63291254AFE;
	Wed, 19 Mar 2025 11:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PEtCBNcm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A812B251788;
	Wed, 19 Mar 2025 11:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742383300; cv=none; b=uvfubVIPrcS7Om+BxvXjvZaIR68OPhhnHER5QDx1flVeO8mSfBQfqp+AAom9XtmcgjicPUJ8MF5kY0/KQDh7AWYVSmkh/c1C2jZQT4AA4U/T3R8ayylarnYjszXYvmpfDuePOe4CpvCKwdOCHYYXe/XLNTto+wdfo+mEuQpoHCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742383300; c=relaxed/simple;
	bh=dBuLEicGxFKm50wttt973rmQ6RBAXoKp/4BjVuBc+LM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCxRYZQ4MFNeOdl1510eP5o3ovkW1FpH1M1AKF4EPmN5OeoH+GBk06h/scllBZ/kWwTbN/a+XElTTprNwgdgdwwJpGF4e4XZpfWPUggH/LJAh7IA5n6+WxT9a0Xpp7Zogea1Luu/Ux9FcDMK1gw5fsMylHM/Q/A6+3f5TsHTytA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PEtCBNcm; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742383299; x=1773919299;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dBuLEicGxFKm50wttt973rmQ6RBAXoKp/4BjVuBc+LM=;
  b=PEtCBNcmaK7ixxg8im/vEwc6V1u4RVUJYOC4KqsParFLR3nSFDW8gBJr
   UEDEObcK5wg2+e7bjvdD8lkwVxklV+1ww2TbI/zE0VrVTaX13Pyl0VdCJ
   ULc0wBWvtrEmIzJGgkC/DL9p/NpNFp18B4KccmfKGOEbDDk2ZRdfHYnX8
   ApCs5/9OWib+jd/6boaPG2euNFLtKfMFqndoy/OglrJOWMMCENuOEqdVM
   CdKFw12O/ZOENgwsx9FDjSphLpqnG+Eg7e/fZin0XYNueUQw9vFGTIKFd
   WTnq8mImyF24hZlyMe3O9ogjDMdnIarbaMXJC9+CapqacHg0QdG6U2LVB
   w==;
X-CSE-ConnectionGUID: zjNVcPtDR9OJnBaAl8jwKw==
X-CSE-MsgGUID: XjvpC/FVSx64EEcnKwSEFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="54236995"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="54236995"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 04:21:38 -0700
X-CSE-ConnectionGUID: wJtAM7LfT9SqRCtEvp6fNQ==
X-CSE-MsgGUID: FTzlI9E4RmeS1KTQ0/D/2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="122506654"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 04:21:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1turUK-00000003twM-1dn8;
	Wed, 19 Mar 2025 13:21:32 +0200
Date: Wed, 19 Mar 2025 13:21:32 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net v2 1/2] net: phy: Fix formatting specifier to avoid
 potential string cuts
Message-ID: <Z9qovGEnv5Xg3xUC@smile.fi.intel.com>
References: <20250319105813.3102076-1-andriy.shevchenko@linux.intel.com>
 <20250319105813.3102076-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319105813.3102076-2-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 19, 2025 at 12:54:33PM +0200, Andy Shevchenko wrote:
> The PHY_ID_FMT is defined with '%02x' which is _minumum_ digits
> to be printed. This, in particular, may trigger GCC warning, when
> the parameter for the above mentioned specifier is bigger than
> a byte. Avoid this, by limiting the amount of digits to be printed
> to two. This is okay as the PHY maximum address is 31 and it fits.

For the curious: additional reading in the commit
46d57a7a8e33 ("docs: printk-formats: Fix hex printing of signed values").

-- 
With Best Regards,
Andy Shevchenko



