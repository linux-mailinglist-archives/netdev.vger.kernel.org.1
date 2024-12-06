Return-Path: <netdev+bounces-149778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5D59E7664
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 17:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13BC22823B6
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 16:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2349B1CD1FB;
	Fri,  6 Dec 2024 16:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="exZj0BRs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C7120627F;
	Fri,  6 Dec 2024 16:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733503862; cv=none; b=kK2c2FH1jPYzTw3gcVgsENyBDzjUfsmUjj/PA/WcEvMRUYUgpZG08JebZOobZbguzJpWeyBHnv9DDBWMgsodBf7CBEB+QHr6QOt/e9hKSISpPLjUMufZYxQ1QPMv6kZ1+13QF5HEjV9rNcSWcpcTbTdnOtgInL5WsZtiwOTmp/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733503862; c=relaxed/simple;
	bh=qZin4s7pr/icRgVdzO97D3u6bbOWBXIsiZysGZ7DEsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tr/TsPs1YvMRvUm1wfz1/Yip2FbvjSnyvmf+eZL1VXhs6mBc1ib+19uwJhGh8f3JCPm1NBHyNNipIeoPxj9YskI+QdbVxiuE4XamTSJIzLeHHrIwNWu/3pUT0ZZM/sGVPaUzhHBDb6FjpihERC+tguI8WPXLuy6OryY7fVh7AzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=exZj0BRs; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733503861; x=1765039861;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qZin4s7pr/icRgVdzO97D3u6bbOWBXIsiZysGZ7DEsg=;
  b=exZj0BRsCUStHxK3ioP4wjJU3tmkKSJVqY4XBwe2LB3+lwNi3Y9ydVUf
   USgwbJMdI2bvZLN7n1QFViz7IjxWWb0gcC8DI/SpH8o9tbrBd7bqhUYMw
   j+fQPI2hoWSXfJFuru/tJ0b4jwRFDVlYok11BtC6zmRBw3+NciKW7DWXH
   izegpX84P25QAYf//zfFyH4T05b6oQ/NvJosE4b3KFc7b/4LyTirxAciP
   eq7V6xM8kcfxT3slcUL7tPbY8sgTQTLYd4Znyn5+AmHc4h+Xz+NzkOkly
   TCJBp8XftA2UcHVNPLgKnndHX9Wk1ViPUTXMdFTeGBUYF9xUPecrOld/k
   g==;
X-CSE-ConnectionGUID: bU0X9C2WRSaTQbPJuoSuag==
X-CSE-MsgGUID: 3wUCREvbSqSsVw9rmuvTVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="37542112"
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="37542112"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 08:51:00 -0800
X-CSE-ConnectionGUID: oRQMPDqISjKNULJpuObSSw==
X-CSE-MsgGUID: ZJirkQbVQ0Wc5urIA1B7ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="94550901"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 06 Dec 2024 08:50:54 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJbXX-00025j-31;
	Fri, 06 Dec 2024 16:50:51 +0000
Date: Sat, 7 Dec 2024 00:50:44 +0800
From: kernel test robot <lkp@intel.com>
To: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, gregkh@linuxfoundation.org
Cc: oe-kbuild-all@lists.linux.dev, shenjian15@huawei.com,
	wangpeiyang1@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, sudongming1@huawei.com,
	xujunsheng@huawei.com, shiyongbang@huawei.com, libaihan@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, shaojijie@huawei.com,
	hkelam@marvell.com
Subject: Re: [PATCH V5 net-next 1/8] debugfs: Add debugfs_create_devm_dir()
 helper
Message-ID: <202412070055.uUO1oKY8-lkp@intel.com>
References: <20241206111629.3521865-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206111629.3521865-2-shaojijie@huawei.com>

Hi Jijie,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jijie-Shao/debugfs-Add-debugfs_create_devm_dir-helper/20241206-192734
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241206111629.3521865-2-shaojijie%40huawei.com
patch subject: [PATCH V5 net-next 1/8] debugfs: Add debugfs_create_devm_dir() helper
config: x86_64-buildonly-randconfig-003-20241206 (https://download.01.org/0day-ci/archive/20241207/202412070055.uUO1oKY8-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241207/202412070055.uUO1oKY8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412070055.uUO1oKY8-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/debugfs/inode.c: In function 'debugfs_create_devm_dir':
>> fs/debugfs/inode.c:643:17: warning: ignoring return value of 'ERR_PTR' declared with attribute 'warn_unused_result' [-Wunused-result]
     643 |                 ERR_PTR(ret);
         |                 ^~~~~~~~~~~~


vim +643 fs/debugfs/inode.c

   619	
   620	/**
   621	 * debugfs_create_devm_dir - Managed debugfs_create_dir()
   622	 * @dev: Device that owns the action
   623	 * @name: a pointer to a string containing the name of the directory to
   624	 *        create.
   625	 * @parent: a pointer to the parent dentry for this file.  This should be a
   626	 *          directory dentry if set.  If this parameter is NULL, then the
   627	 *          directory will be created in the root of the debugfs filesystem.
   628	 * Managed debugfs_create_dir(). dentry will automatically be remove on
   629	 * driver detach.
   630	 */
   631	struct dentry *debugfs_create_devm_dir(struct device *dev, const char *name,
   632					       struct dentry *parent)
   633	{
   634		struct dentry *dentry;
   635		int ret;
   636	
   637		dentry = debugfs_create_dir(name, parent);
   638		if (IS_ERR(dentry))
   639			return dentry;
   640	
   641		ret = devm_add_action_or_reset(dev, debugfs_remove_devm, dentry);
   642		if (ret)
 > 643			ERR_PTR(ret);
   644	
   645		return dentry;
   646	}
   647	EXPORT_SYMBOL_GPL(debugfs_create_devm_dir);
   648	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

