Return-Path: <netdev+bounces-118690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BD79527CB
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 04:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF221B20FC7
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 02:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186A93D9E;
	Thu, 15 Aug 2024 02:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZGidO0dt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF1279EA
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 02:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723687375; cv=none; b=elar2pHUKVpkE3SPyHMmdkF3R/MP3ivpU+X5N/pHnS0pFSVZ2RFlXwtpsmx25qTMmAetlFnvBWkywGU+T4DXgur0aHYiciujaXn1pVQJpAqLwBRkUvGZo+AcNlNotQJCY6UUX/oVa+0TxbMR0u50OwAfU76l01JKkDdZwI+dAa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723687375; c=relaxed/simple;
	bh=Orver+EnNJ0jSVns/rYMPmvD2o3lszsUFvqDtovVU5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJlBJ1h1HFd5SIk6glCXsgKYmZCiz+aIQn8Hqzg9+i9B5I4aySF78mO5uEAGDkd7N7H7FxWRUTSRt41V9N6L/h+h7TfP5jjSUtIATmofmmXSlztkhTy6U+tzQN67TcYFphVSq1HrvsaXr9T8wdcASyPfvd5L9HjHN4A5JHPeJos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZGidO0dt; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723687372; x=1755223372;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Orver+EnNJ0jSVns/rYMPmvD2o3lszsUFvqDtovVU5Y=;
  b=ZGidO0dtt0Lsab+VydfSxvnlaaOoG1xpTWxWXIRxxn1oRMui0reeb626
   oMHbD84LmlEfmoyUqaThvb5uJ6mdyrPk9YcrE3x9C24BLuC6+wrh9p2j2
   //SyzfuUFpQEJDyyZAsYHm7An2uzqH2h+MuJkKbVOdP//p7YmkE655HPy
   fA1SUvHkn3tkR8jDvoI2wcnD8QW8gqCcOF3+9YCrvrhf5rkXWt/wn9KSS
   hfTQwzg0M2cMy02Gf4892VUzHPSIj3qLeDGGIiZmrgpoemvsxifOhzDkb
   VeB6XZR8766AHLD+bNrjfnJ5FSeUi6mA+LSO9xrbr4Z6sQr0yD5JAKBYI
   Q==;
X-CSE-ConnectionGUID: WwCFeHn/T4K/0yB31ColcA==
X-CSE-MsgGUID: dcRwJI8RSdSZXf7hUQY8Fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="33347850"
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="33347850"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 19:02:52 -0700
X-CSE-ConnectionGUID: k2MUptlCSY+NvQibRH/ijQ==
X-CSE-MsgGUID: WiVCxeSLRu6uZB0irfPwsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="59367640"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 14 Aug 2024 19:02:50 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sePp9-00034o-34;
	Thu, 15 Aug 2024 02:02:47 +0000
Date: Thu, 15 Aug 2024 10:02:32 +0800
From: kernel test robot <lkp@intel.com>
To: Cosmin Ratiu <cratiu@nvidia.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, cjubran@nvidia.com, cratiu@nvidia.com,
	tariqt@nvidia.com, saeedm@nvidia.com, yossiku@nvidia.com,
	gal@nvidia.com, jiri@nvidia.com
Subject: Re: [PATCH] devlink: Extend the devlink rate API to support rate
 management on traffic classes
Message-ID: <202408150939.GeZ6uR8S-lkp@intel.com>
References: <20240814085320.134075-2-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814085320.134075-2-cratiu@nvidia.com>

Hi Cosmin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.11-rc3 next-20240814]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cosmin-Ratiu/devlink-Extend-the-devlink-rate-API-to-support-rate-management-on-traffic-classes/20240814-232253
base:   linus/master
patch link:    https://lore.kernel.org/r/20240814085320.134075-2-cratiu%40nvidia.com
patch subject: [PATCH] devlink: Extend the devlink rate API to support rate management on traffic classes
config: arc-randconfig-001-20240815 (https://download.01.org/0day-ci/archive/20240815/202408150939.GeZ6uR8S-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240815/202408150939.GeZ6uR8S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408150939.GeZ6uR8S-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/devlink/rate.c:755: warning: Function parameter or struct member 'devlink_port' not described in 'devl_rate_traffic_class_create'
>> net/devlink/rate.c:755: warning: Function parameter or struct member 'parent' not described in 'devl_rate_traffic_class_create'
>> net/devlink/rate.c:755: warning: Excess function parameter 'devlink' description in 'devl_rate_traffic_class_create'


vim +755 net/devlink/rate.c

   744	
   745	/**
   746	 * devl_rate_traffic_class_create - create devlink rate queue
   747	 * @devlink: devlink instance
   748	 * @priv: driver private data
   749	 * @tc_id: identifier of the new traffic class
   750	 *
   751	 * Create devlink rate object of type node
   752	 */
   753	int devl_rate_traffic_class_create(struct devlink_port *devlink_port, void *priv, u16 tc_id,
   754					   struct devlink_rate *parent)
 > 755	{
   756		struct devlink *devlink = devlink_port->devlink;
   757		struct devlink_rate *devlink_rate;
   758	
   759		devl_assert_locked(devlink);
   760	
   761		devlink_rate = devlink_rate_traffic_class_get_by_id(devlink, tc_id);
   762		if (!IS_ERR(devlink_rate))
   763			return -EEXIST;
   764	
   765		devlink_rate = kzalloc(sizeof(*devlink_rate), GFP_KERNEL);
   766		if (!devlink_rate)
   767			return -ENOMEM;
   768	
   769		if (parent) {
   770			devlink_rate->parent = parent;
   771			refcount_inc(&devlink_rate->parent->refcnt);
   772		}
   773	
   774		devlink_rate->type = DEVLINK_RATE_TYPE_TRAFFIC_CLASS;
   775		devlink_rate->devlink = devlink;
   776		devlink_rate->devlink_port = devlink_port;
   777		devlink_rate->tc_id = tc_id;
   778		devlink_rate->priv = priv;
   779		list_add_tail(&devlink_rate->list, &devlink->rate_list);
   780		devlink_port->devlink_rate = devlink_rate;
   781		devlink_rate_notify(devlink_rate, DEVLINK_CMD_RATE_NEW);
   782	
   783		return 0;
   784	}
   785	EXPORT_SYMBOL_GPL(devl_rate_traffic_class_create);
   786	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

