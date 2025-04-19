Return-Path: <netdev+bounces-184283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D939A943AE
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 16:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 471E83B495A
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 14:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3541DB366;
	Sat, 19 Apr 2025 14:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VTh3k4Bk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CF41ADC7E;
	Sat, 19 Apr 2025 14:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745071420; cv=none; b=F3jwTcvp+FEB+WkslR3ASFvS0SOCgmfxoTci94QakEQa9B6Qs73gL2+0hO9k1Sp8qN2l9FXG2YzUKk8kyLqDyYZ7tLMUOzHTWtdE8J/Yq5PscbTPv8xe1/cQj3ItCHb6Vj9PHLGb0na4silPWWt0UGSGIPp9XdR+N4NThXNFqE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745071420; c=relaxed/simple;
	bh=GAXSd6P51bCdcrlHYICGtiJPhrHgJGc7cexJ3Fvo3TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCIpyX5sV/43cQRe8ZUMCOjxrx8a4J+gkQStHaIN+HcFnueR4grVbyawHNJCZlcTW5GVwamSoVFjAuw62j80hSWzh2NEM0haiGrOsoViIenzFebKBv8eZyQ143WSXR5dF6GQMPkAKB4ZQZPuOktPLnntLPK0kOwkYr4N9DgqFYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VTh3k4Bk; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745071419; x=1776607419;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GAXSd6P51bCdcrlHYICGtiJPhrHgJGc7cexJ3Fvo3TU=;
  b=VTh3k4BkzdXC2/x1wfhYcJEcGWECOthZbaqWuUBIvdYHGxqRCgnCrjEQ
   7dzGq2Kv1jAY6yCCeoJeyvuB48s1reyBZHyVqFRliqF9V9l3Jxfymn7WG
   5tWyuDAFk/yhPMmjN0IhcMp67azDvSb9hONri2iuioZbWu8lZofTKM/2z
   VJRME7fLOBTAVxPZ2GEj2Au4rS2sdlJ+j83mlWVfj+wXHm/8a2mJwJUOG
   OhepzgkjpIsVthlucUg/86qg9AVEdgwFEJdanBi6jcZGpX8HaxbUSF7Xo
   g2Nc++phGJdOBd0tlZ+jHakF18l7ENLLfJuecx5SVYim7OB87VXP+LsHN
   A==;
X-CSE-ConnectionGUID: LyKSWrsaQDSfTcszldEitQ==
X-CSE-MsgGUID: 0BDs/wutQ8+06ar1gzj7Mg==
X-IronPort-AV: E=McAfee;i="6700,10204,11408"; a="34292407"
X-IronPort-AV: E=Sophos;i="6.15,224,1739865600"; 
   d="scan'208";a="34292407"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2025 07:03:38 -0700
X-CSE-ConnectionGUID: XdbiROmrSbmrdAVKpH0EQQ==
X-CSE-MsgGUID: vXO5A6SyQDCixNkSFvRNGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,224,1739865600"; 
   d="scan'208";a="135430196"
Received: from lkp-server01.sh.intel.com (HELO 61e10e65ea0f) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 19 Apr 2025 07:03:34 -0700
Received: from kbuild by 61e10e65ea0f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u68n5-0003uH-2q;
	Sat, 19 Apr 2025 14:03:31 +0000
Date: Sat, 19 Apr 2025 22:03:22 +0800
From: kernel test robot <lkp@intel.com>
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 04/14] mfd: zl3073x: Register itself as devlink device
Message-ID: <202504192124.BZN8TTbm-lkp@intel.com>
References: <20250409144250.206590-5-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409144250.206590-5-ivecera@redhat.com>

Hi Ivan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.15-rc2 next-20250417]
[cannot apply to lee-mfd/for-mfd-next lee-mfd/for-mfd-fixes horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ivan-Vecera/dt-bindings-dpll-Add-device-tree-bindings-for-DPLL-device-and-pin/20250409-225519
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250409144250.206590-5-ivecera%40redhat.com
patch subject: [PATCH v2 04/14] mfd: zl3073x: Register itself as devlink device
config: nios2-kismet-CONFIG_MFD_ZL3073X_CORE-CONFIG_MFD_ZL3073X_SPI-0-0 (https://download.01.org/0day-ci/archive/20250419/202504192124.BZN8TTbm-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250419/202504192124.BZN8TTbm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504192124.BZN8TTbm-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for MFD_ZL3073X_CORE when selected by MFD_ZL3073X_SPI
   WARNING: unmet direct dependencies detected for MFD_ZL3073X_CORE
     Depends on [n]: HAS_IOMEM [=y] && NET [=n]
     Selected by [y]:
     - MFD_ZL3073X_SPI [=y] && HAS_IOMEM [=y] && SPI [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

