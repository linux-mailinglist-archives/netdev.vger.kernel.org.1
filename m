Return-Path: <netdev+bounces-115962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4C9948A1F
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 09:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED0081F24DBF
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 07:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFEF1BC9E2;
	Tue,  6 Aug 2024 07:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gZspuas8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5D816BE26
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 07:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722929315; cv=none; b=ZWDmr0PXeMx/oqliHT+eTBMP16RdQS1D9eO/1kU/pl0TO20summDx+hphRWYpnG34iWvwgREYd4AjEpMTwKH9k1+nkdVoSTb9tCoS82o5Ds9HbmH81xJLMkLBPPjhlYhLPS3uKV9e4o2xuVku7rRPyafeftD9h8uG8DH7hVOTfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722929315; c=relaxed/simple;
	bh=X5MxvYqyqa8+gt0e4dKG0jl6xjg2wgYTpRdkMjdK9BY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYFDL4RccomtC9StEmRFFgONbaWbk2m4cprQoL5njP5TN+9jr8WDiCvcvdc9dmUIBoL5xemY5KqugmlFtx24Ge8UxmhGYHkvDsLPGdWXZ71Dw0E4aGnC0rcYp8qdbIX2a+x/DEq4UibT9RdWI3YFFxjnVgSZm7TtzecGmxRswW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gZspuas8; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722929313; x=1754465313;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X5MxvYqyqa8+gt0e4dKG0jl6xjg2wgYTpRdkMjdK9BY=;
  b=gZspuas8GfFrXyjYEumWTqhpmZP8BKZCNmGMjVEiBB+1TixikbXSRv+M
   p98K0qX17jXo6c7T3Q3OjPm1PiHykMJbkfaOw7cPZiCnk6nxp6Cb/2afb
   +VbCZ6tfR4wW4jzGQATHxYk4GUhvRHQhZ05tX2WAr589P1CGBg8M2TK9/
   8TgU4GE56a5sNZlf1rhnDgnDI4b2i1vojZaBbj83KaEGI893K42ocGQ/5
   64IvtpKre8IqTq+8+YktsFD3LEwlBS219Nov61zTl0YgZiulWzOjHtV+E
   XWz1T3EAR5o2eerwVopIs3ouvHs9adu/IFFdwWe0O633pbFzc2TNj18rP
   g==;
X-CSE-ConnectionGUID: 7wqKijoTQoyWSRj7M53Yaw==
X-CSE-MsgGUID: DQV6kF//SrurlS1qcq13MQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="21105988"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="21105988"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 00:28:31 -0700
X-CSE-ConnectionGUID: XJvRG46AQ/Wpb0wEmWwNiQ==
X-CSE-MsgGUID: 02wJFl/uS5GyjAMM/nlB9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="79678735"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 06 Aug 2024 00:28:30 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbEcN-0004GK-1y;
	Tue, 06 Aug 2024 07:28:27 +0000
Date: Tue, 6 Aug 2024 15:27:04 +0800
From: kernel test robot <lkp@intel.com>
To: Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next v5 09/10] net: txgbe: add devlink and devlink
 port created
Message-ID: <202408061505.h7AJKdXp-lkp@intel.com>
References: <9203F9254D59FF19+20240804124841.71177-10-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9203F9254D59FF19+20240804124841.71177-10-mengyuanlou@net-swift.com>

Hi Mengyuan,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Mengyuan-Lou/net-libwx-Add-sriov-api-for-wangxun-nics/20240804-214836
base:   net-next/main
patch link:    https://lore.kernel.org/r/9203F9254D59FF19%2B20240804124841.71177-10-mengyuanlou%40net-swift.com
patch subject: [PATCH net-next v5 09/10] net: txgbe: add devlink and devlink port created
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20240806/202408061505.h7AJKdXp-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240806/202408061505.h7AJKdXp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408061505.h7AJKdXp-lkp@intel.com/

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
   wx_eswitch.c:(.text+0x1c): undefined reference to `devlink_priv'
   loongarch64-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_eswitch.o: in function `wx_eswitch_mode_get':
   wx_eswitch.c:(.text+0x138): undefined reference to `devlink_priv'
   loongarch64-linux-ld: drivers/net/ethernet/wangxun/txgbe/txgbe_main.o: in function `txgbe_remove':
>> txgbe_main.c:(.text+0xf4): undefined reference to `devl_port_unregister'
   loongarch64-linux-ld: drivers/net/ethernet/wangxun/txgbe/txgbe_main.o: in function `txgbe_probe':
   txgbe_main.c:(.text+0x834): undefined reference to `devl_port_unregister'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

