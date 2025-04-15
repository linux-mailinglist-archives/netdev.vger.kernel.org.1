Return-Path: <netdev+bounces-182656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BBCA89867
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDBB03AB01D
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 09:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBC328F508;
	Tue, 15 Apr 2025 09:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fp6aFH3N"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEA328E5F3;
	Tue, 15 Apr 2025 09:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744710064; cv=none; b=uLOhC+9f8Op8jwItDp0vBM9ALqh37eUs2Iapoq2jSWxwcijfkjO3AyxFT3whzUIo5E6MpdkzkKztqHfSNZH70PZHm31xR4BeCHJetFbKokjQ6cTxE87kTQpzXJ2TNhZaHz0Zo+L1Qi/rlKmdlVBcs5GdL4A9ahq/YXhtuUfREgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744710064; c=relaxed/simple;
	bh=70bZEoBDBdJu5amD+c19gKRho0A75jQlvPN/S4VEHNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8ZryYaOykN2rllf5QTVMNVZoiYbSUkhIah3Hpja8vj3vMTMtYWPub7DZrNlGprM5DXqB6DxCvyVFLS7tEOqmYvXU8ApG1t0D503gSl2D+eUIolYduUZJ+BrcVPrfOsWbeyL5Y9lmB2iexiGEtPFSBLWOLGibCQklywE8BEVlWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fp6aFH3N; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744710063; x=1776246063;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=70bZEoBDBdJu5amD+c19gKRho0A75jQlvPN/S4VEHNg=;
  b=fp6aFH3NCHksuovCuCr9dkMxgDrb3QUFns/zQby7RP8WgZqPhRTG4UBc
   iSebNJPP6uxwmAamqRj3oAhPYoZKiIBvrH4O0mwxqH6WZVvldvbJI9GlB
   rAVVunvrrJ2uhuijceRdMUjHTbPXzjboelsJW4HFcuTH+BXpzOZmQDsff
   IWOvJB3vHAlSkdsHoAYtYYWcyWJvyXVIj5RhrV3vwbfLQ0g1Y17AH61th
   UemTB1qnjpRBFcqg2O3CgYtu7mkit1Jtkx2Twnb6JCMNEgMhSQ4tCMZp5
   DP6Qm+aDui/NvNbBH5XQ270yD/EFiOzoj83OdR5LVG+XsZaPyEmaS/8HZ
   Q==;
X-CSE-ConnectionGUID: SoFdeKiqSM25InKOCFqgkw==
X-CSE-MsgGUID: aodAkcTFR9GfGAi3B/wQpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="46098084"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="46098084"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 02:39:56 -0700
X-CSE-ConnectionGUID: yyQqDLo8Rei+/IWq17FlZg==
X-CSE-MsgGUID: +fd38e0cTS6fTRwGNnjWeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="130034398"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 02:39:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u4cli-0000000CVPR-1PbB;
	Tue, 15 Apr 2025 12:39:50 +0300
Date: Tue, 15 Apr 2025 12:39:50 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] dma-mapping: avoid potential unused data compilation
 warning
Message-ID: <Z_4pZm_tQ6qmmj35@smile.fi.intel.com>
References: <CGME20250415075716eucas1p1a5343f5dec617f82f5adca300eb47485@eucas1p1.samsung.com>
 <20250415075659.428549-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415075659.428549-1-m.szyprowski@samsung.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 15, 2025 at 09:56:59AM +0200, Marek Szyprowski wrote:
> When CONFIG_NEED_DMA_MAP_STATE is not defined, dma-mapping clients might
> report unused data compilation warnings for dma_unmap_*() calls
> arguments. Redefine macros for those calls to let compiler to notice that
> it is okay when the provided arguments are not used.

Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

(GCC on default i386_defconfig with `make W=1` on v6.15-rc2)

-- 
With Best Regards,
Andy Shevchenko



