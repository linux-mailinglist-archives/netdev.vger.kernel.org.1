Return-Path: <netdev+bounces-184282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C30A94375
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 14:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 611A53BFA6A
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 12:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F561D7E35;
	Sat, 19 Apr 2025 12:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j7eDTNXy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD3B18DB29;
	Sat, 19 Apr 2025 12:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745066435; cv=none; b=kGGuAYS6ozKyv2/w26YPzBjZkyrEpCfakWIqDFXDTZcuJdul7btHSQvVqEiZPPiKMA4ZG6teaXf5QkZfrdPS5qTSgOijZP4NdVtGDLst9YvG3pzKsUro8cBvBEkCrINl/U0zs/BT8Mzutb/laP2jeF/h1ctJOy9g4fbPBLsaDbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745066435; c=relaxed/simple;
	bh=ko3/xZ5n8rTOGfvBuO6DOyhWdi+6KfSS826NIgFcytg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxHYLAV+kMTQNhZml7v1bI0wgj7Lea3K1fA81E9sdXXNbj/GQQ/KBM6rZzXgJLc29XNsDV3hSwtlRDI/9Uilj4dXJ7Mcte1iYcB3J6RKxrZd7tyg7x8j4DwgsAQMT/u7UUP/Y01xLTgUde4INuzFGqnU6xdBas5mKbz1lljiYGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j7eDTNXy; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745066433; x=1776602433;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ko3/xZ5n8rTOGfvBuO6DOyhWdi+6KfSS826NIgFcytg=;
  b=j7eDTNXy9tZcs5PEJpwgOFGpfbJHqw4bzfqeMclh9maYz/gkfKZPjfnN
   zkNe8rhd8Rp/aX993BUA3xPEtpFliG+L/XqEnASwu+myF04vL4fWDq61E
   sHVq9QxRLk0wtb7keNFcUXRm77Akbd8UF5t0Vzw6NAl2FWIwXCEsFaifu
   c2570+eoIelYyDr5M6t057BBLcMQIwXWZ12bdmHICIsf36e0kvWyzmk8m
   A9eUhXwUHO73sSDgbbQR8CrT51O53AxxhM5usavaW+JX4gNHm+HNOZyIk
   0LiftieB4it5JtaKrk6hiS+Jh38oIrla/mrFjxPSY39+42tv8KX1uVFM6
   A==;
X-CSE-ConnectionGUID: APVcPJ2QSmyJzS0a1qCfqQ==
X-CSE-MsgGUID: OoAmdSmwSEilBI21uqwotA==
X-IronPort-AV: E=McAfee;i="6700,10204,11407"; a="64207854"
X-IronPort-AV: E=Sophos;i="6.15,224,1739865600"; 
   d="scan'208";a="64207854"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2025 05:40:32 -0700
X-CSE-ConnectionGUID: 6kBoi7FlSg2BzHUbGUUYUw==
X-CSE-MsgGUID: /ZjffYtDRtyM09+2iEcaqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,224,1739865600"; 
   d="scan'208";a="162373346"
Received: from lkp-server01.sh.intel.com (HELO 61e10e65ea0f) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 19 Apr 2025 05:40:28 -0700
Received: from kbuild by 61e10e65ea0f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u67Uf-0003rV-2f;
	Sat, 19 Apr 2025 12:40:25 +0000
Date: Sat, 19 Apr 2025 20:40:06 +0800
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
Message-ID: <202504192025.BlASOJSt-lkp@intel.com>
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
config: nios2-kismet-CONFIG_MFD_ZL3073X_CORE-CONFIG_MFD_ZL3073X_I2C-0-0 (https://download.01.org/0day-ci/archive/20250419/202504192025.BlASOJSt-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250419/202504192025.BlASOJSt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504192025.BlASOJSt-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for MFD_ZL3073X_CORE when selected by MFD_ZL3073X_I2C
   WARNING: unmet direct dependencies detected for MFD_ZL3073X_CORE
     Depends on [n]: HAS_IOMEM [=y] && NET [=n]
     Selected by [y]:
     - MFD_ZL3073X_I2C [=y] && HAS_IOMEM [=y] && I2C [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

