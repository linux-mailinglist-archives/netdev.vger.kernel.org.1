Return-Path: <netdev+bounces-115842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D52E0947FDF
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 19:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8858C1F2395F
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 17:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C8515DBBA;
	Mon,  5 Aug 2024 17:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iTxfj5ic"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B301591F0
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 17:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722877437; cv=none; b=qtNx3ajzlplbZLH2IAreJAGfTHMLPRKgJcnzo6QdeRwojBF9LD/2Y57rtMWVOgwpULfJygXtZqg/Q7GkmQrPCxAwnWgWwEhEvNeso+vms6TZTB/zCWZJYyAtmOb3/MU67iEXXvUCI/F0ven5yAJ3e5oR7KfUfM3PpfJoe5vH6YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722877437; c=relaxed/simple;
	bh=sICeaCwcreil7xDpX/efNjG2755GKCVEPMbcnFP5EOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FcPCgo6ddFgbjRbiWVS3ad+YH+7l7mKCwXxv0uPZPDODJweWd12jUgQ+LF6o3zReFUU+EBK60aqOI6IQUH5F93nxQTJHt3VfjFXvDAdXFKHyhJXy/crJmbvjyMgahRAun7fCZbC1gjBoM/Duj3SHeTGlmIhRNzINoRtmTW/AdrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iTxfj5ic; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722877436; x=1754413436;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sICeaCwcreil7xDpX/efNjG2755GKCVEPMbcnFP5EOk=;
  b=iTxfj5icTEGqzP9xvYVDO7OiZ3/hk4qZ10SEjsOtjSB0erUjMgjjgFNA
   Vwd5/6xgdFbmzs8K4PoCG76D+PmD8Aib1ly2DN7UFOsL0/GNrPSHjZYUE
   SfVvWVGyUpIAgsOoJm6ILCHGUFMD3tPeTIwkPGepJ/sXbkwJhmNgULg3o
   JzrK3YvCrhBGU96b4kyWH8ez5/VVTOwNnoXI1/tZOordRjrBzLXz0OS34
   +/BWvrH5RizmRA6LKDdgJdqm/96a9JqPzvlVvwrSQk6UnSOQGQ7cLoA0B
   H2rL00+A0+aBqvlE3zXFyx+Ir/6++EhxqvvetkkxUBlOZAhMXP88o8O1g
   A==;
X-CSE-ConnectionGUID: PntKv1YkR321kfhG2FHt6g==
X-CSE-MsgGUID: RPLmV3CCQW6Q+GH+nlRT6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="20668780"
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="20668780"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 10:03:55 -0700
X-CSE-ConnectionGUID: ftnxINfxT5S96FKMAwushA==
X-CSE-MsgGUID: DZyF6M1STAOXpYQuASEo8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="61185797"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 05 Aug 2024 10:03:53 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sb17f-0003Gp-0v;
	Mon, 05 Aug 2024 17:03:51 +0000
Date: Tue, 6 Aug 2024 01:03:07 +0800
From: kernel test robot <lkp@intel.com>
To: Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next v5 08/10] net: libwx: add eswitch switch api for
 devlink ops
Message-ID: <202408060023.UYl4fu6N-lkp@intel.com>
References: <5DD6E0A4F173D3D3+20240804124841.71177-9-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5DD6E0A4F173D3D3+20240804124841.71177-9-mengyuanlou@net-swift.com>

Hi Mengyuan,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Mengyuan-Lou/net-libwx-Add-sriov-api-for-wangxun-nics/20240804-214836
base:   net-next/main
patch link:    https://lore.kernel.org/r/5DD6E0A4F173D3D3%2B20240804124841.71177-9-mengyuanlou%40net-swift.com
patch subject: [PATCH net-next v5 08/10] net: libwx: add eswitch switch api for devlink ops
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20240806/202408060023.UYl4fu6N-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240806/202408060023.UYl4fu6N-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408060023.UYl4fu6N-lkp@intel.com/

All errors (new ones prefixed by >>):

   loongarch64-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_devlink.o: in function `wx_devlink_free':
   wx_devlink.c:(.text+0x58): undefined reference to `devlink_unregister'
   loongarch64-linux-ld: wx_devlink.c:(.text+0x6c): undefined reference to `devlink_free'
   loongarch64-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_devlink.o: in function `wx_devlink_create_pf_port':
   wx_devlink.c:(.text+0xa0): undefined reference to `priv_to_devlink'
   loongarch64-linux-ld: wx_devlink.c:(.text+0xfc): undefined reference to `devlink_port_attrs_set'
   loongarch64-linux-ld: wx_devlink.c:(.text+0x110): undefined reference to `devlink_port_register_with_ops'
   loongarch64-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_devlink.o: in function `wx_devlink_destroy_pf_port':
   wx_devlink.c:(.text+0x174): undefined reference to `devl_port_unregister'
   loongarch64-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_devlink.o: in function `wx_create_devlink':
   wx_devlink.c:(.text+0x2a0): undefined reference to `devlink_alloc_ns'
   loongarch64-linux-ld: wx_devlink.c:(.text+0x2d4): undefined reference to `devlink_unregister'
   loongarch64-linux-ld: wx_devlink.c:(.text+0x2dc): undefined reference to `devlink_free'
   loongarch64-linux-ld: wx_devlink.c:(.text+0x304): undefined reference to `devlink_register'
   loongarch64-linux-ld: wx_devlink.c:(.text+0x31c): undefined reference to `devlink_priv'
   loongarch64-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_devlink.o: in function `wx_devlink_create_vf_port':
   wx_devlink.c:(.text+0x354): undefined reference to `priv_to_devlink'
   loongarch64-linux-ld: wx_devlink.c:(.text+0x3d0): undefined reference to `devlink_port_attrs_set'
   loongarch64-linux-ld: wx_devlink.c:(.text+0x3e8): undefined reference to `devl_port_register_with_ops'
   loongarch64-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_devlink.o: in function `wx_devlink_destroy_vf_port':
   wx_devlink.c:(.text+0x47c): undefined reference to `devl_port_unregister'
   loongarch64-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_eswitch.o: in function `wx_eswitch_mode_set':
>> wx_eswitch.c:(.text+0x1c): undefined reference to `devlink_priv'
   loongarch64-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_eswitch.o: in function `wx_eswitch_mode_get':
   wx_eswitch.c:(.text+0x138): undefined reference to `devlink_priv'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

