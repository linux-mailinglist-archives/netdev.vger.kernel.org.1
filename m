Return-Path: <netdev+bounces-171079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94534A4B61C
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 03:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFF3B1696FB
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 02:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2075D13B284;
	Mon,  3 Mar 2025 02:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ng57cnXk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B7D14AD20
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 02:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740968873; cv=none; b=SV4RCgTgec4/wEJdSimow7DxDpXdbWDRRo1pp5jBHz+OYuUZEqSLr/AjH4GXk41OnsLvCClyFNPqJiVGXEuYS0FIOBUPnIHq6w+Agb8lv4oz3q4Ep7l4969hKhIq98Pb/Kcd3YD7sdSU8P1eYtmn8PEU4bTGt8Z22r3QaeVA1/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740968873; c=relaxed/simple;
	bh=+yaRIRHwJhYD80ovU3oLHy/7gA+I7If+Tf09MlnOGsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOz7iE2D5Mt91FqHigXonhhfdFngGdPzyKbTCiKrYPehfe7MVuJbyH2c6Gf8Zdr34ZLGek2vjXFw5BmBmOSyduRcwkS6oHPOa5iGCpxe+r+qk+4jd20R94DqJEBh3sJbvHej+NXcZ7TXnDO6u+rmv6SR60wilfuugsGF9vdC6KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ng57cnXk; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740968872; x=1772504872;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+yaRIRHwJhYD80ovU3oLHy/7gA+I7If+Tf09MlnOGsY=;
  b=Ng57cnXkWjd5OIHs5bdagTHvli0sv+pqFWkSDrn6B4t0lBzT8NJh/p9O
   RMiQvG1sRxFawQdB5ublclZxXk39esnpOFtvmj/hpEQfRXv3E0DLeM3U3
   hCS3YfWrCnca+6AT9TU92sh+fDI5ChtzZB+EC+BQodeVQzWVoIegsA9on
   TnEAcgGH1NjYpmXzdF6KAg72XM4UDhZs2HxWzCQVhRChnkmt3UgspREAq
   f5lJ/3Nv4LOLmUsibBAkIDK9Bkui5tsHWPYTo77bV/JHfeiL+lv/HtMpy
   G852AlQjp0mRc67oC/McJTFBVBxbp3ThEs7DXlNvmVhxfUkaT4Yoq73n6
   Q==;
X-CSE-ConnectionGUID: jRJP7QjqQnqV7ozt/tpGjw==
X-CSE-MsgGUID: DZ+DK+ngR6OP85dDx9YgLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="42021536"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="42021536"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 18:27:51 -0800
X-CSE-ConnectionGUID: RH2BbcC4ScmT23C5Uvymig==
X-CSE-MsgGUID: iW+f1ZttQMCM6AwXUt/Sqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,328,1732608000"; 
   d="scan'208";a="117871253"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 02 Mar 2025 18:27:48 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tovWz-000Hpj-23;
	Mon, 03 Mar 2025 02:27:45 +0000
Date: Mon, 3 Mar 2025 10:27:30 +0800
From: kernel test robot <lkp@intel.com>
To: Saeed Mahameed <saeed@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>
Subject: Re: [PATCH net-next 04/14] net/mlx5: Implement devlink enable_sriov
 parameter
Message-ID: <202503030926.KNBxmdVW-lkp@intel.com>
References: <20250228021227.871993-5-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228021227.871993-5-saeed@kernel.org>

Hi Saeed,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Saeed-Mahameed/devlink-define-enum-for-attr-types-of-dynamic-attributes/20250228-101818
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250228021227.871993-5-saeed%40kernel.org
patch subject: [PATCH net-next 04/14] net/mlx5: Implement devlink enable_sriov parameter
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503030926.KNBxmdVW-lkp@intel.com/

includecheck warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/mellanox/mlx5/core/devlink.c: lib/nv_param.h is included more than once.

vim +11 drivers/net/ethernet/mellanox/mlx5/core/devlink.c

     5	
     6	#include "mlx5_core.h"
     7	#include "fw_reset.h"
     8	#include "fs_core.h"
     9	#include "eswitch.h"
    10	#include "esw/qos.h"
  > 11	#include "lib/nv_param.h"
    12	#include "sf/dev/dev.h"
    13	#include "sf/sf.h"
  > 14	#include "lib/nv_param.h"
    15	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

