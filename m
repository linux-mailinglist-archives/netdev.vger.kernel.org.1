Return-Path: <netdev+bounces-67127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FC18421E2
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 11:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D196A2962ED
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 10:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52106280D;
	Tue, 30 Jan 2024 10:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CyVxNvH0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C347E65BA9
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 10:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706611683; cv=none; b=ZUtbxQRUi3EaUEYO8E2GBTqEg8U7AmTIlUMPr11q/IF+IVYb3G1nk50/SI7StIDf8kYgRnTZo+AFqd+0xjZ/0qGIFZPRy6sqRANNe2wH9DCnEDsw8+Kq25Wm8zHFZS1b3qkZk00lGcgiKQZ9CN848vuxo+VZQBegkOivo3Yh1sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706611683; c=relaxed/simple;
	bh=5ayV37HZAa5vqSs+fvizolbsu3yLLh5lJ7gUCC3xJkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0RZbGHquurXEMY6hmzYt6ble1bBsap3M0oG1q3tNglF9Q1AEXzNhRXkD+5aB2d1tlQ1s5ng1Hf3mo9WEWYMcHfq/R92r35Ce01LtXORULhrl+Ztl2A4mMqSFsp+IheVOrDLijqyg4XdcG+kf3LHj6We+nKLlccu/ZIFs+EZkFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CyVxNvH0; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706611682; x=1738147682;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5ayV37HZAa5vqSs+fvizolbsu3yLLh5lJ7gUCC3xJkQ=;
  b=CyVxNvH0QFhzvYpz60GsSXSnC/Q9qRIIP/ZbP+g9u9H7NPtRkrfdUqrQ
   qhy/b59DYmvHbf2LXOjJdp1C+UoRkPVL819b96sX0KsIZ+IyBTzVFWXkS
   pMtpEGdH2regIi3VmiWYdox7xUWkU7zq4L251+Kf31MGflzusH9z9iEC6
   Yb7QyNaMjbt9GQZFbuDGCdUWUqDwKjQzNaK133SbLuHHjkRrYSBz5MuQt
   CXQvIIaAJcPJoLdOhbs7TMgIX0DjfyVs3Q/lBI3Ng+L58arospIPkdgcU
   H12WWawwXRtYeqSSWGoKT3I9zqDGU3jmgXjJrk03l9aQ40cBLkd2F7Rq/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="2177340"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="2177340"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 02:47:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="822152991"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="822152991"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 30 Jan 2024 02:47:54 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rUlec-0000Cu-1i;
	Tue, 30 Jan 2024 10:47:47 +0000
Date: Tue, 30 Jan 2024 18:46:15 +0800
From: kernel test robot <lkp@intel.com>
To: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com, saeedm@nvidia.com, leon@kernel.org,
	jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	rrameshbabu@nvidia.com
Subject: Re: [patch net-next 2/3] dpll: extend lock_status_get() op by status
 error and expose to user
Message-ID: <202401301831.QfsB6gZg-lkp@intel.com>
References: <20240129145916.244193-3-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129145916.244193-3-jiri@resnulli.us>

Hi Jiri,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiri-Pirko/dpll-extend-uapi-by-lock-status-error-attribute/20240129-230433
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240129145916.244193-3-jiri%40resnulli.us
patch subject: [patch net-next 2/3] dpll: extend lock_status_get() op by status error and expose to user
config: openrisc-allyesconfig (https://download.01.org/0day-ci/archive/20240130/202401301831.QfsB6gZg-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240130/202401301831.QfsB6gZg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401301831.QfsB6gZg-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/intel/ice/ice_dpll.c:505: warning: Function parameter or struct member 'status_error' not described in 'ice_dpll_lock_status_get'


vim +505 drivers/net/ethernet/intel/ice/ice_dpll.c

d7999f5ea64bb1 Arkadiusz Kubalewski 2023-09-13  485  
d7999f5ea64bb1 Arkadiusz Kubalewski 2023-09-13  486  /**
d7999f5ea64bb1 Arkadiusz Kubalewski 2023-09-13  487   * ice_dpll_lock_status_get - get dpll lock status callback
d7999f5ea64bb1 Arkadiusz Kubalewski 2023-09-13  488   * @dpll: registered dpll pointer
d7999f5ea64bb1 Arkadiusz Kubalewski 2023-09-13  489   * @dpll_priv: private data pointer passed on dpll registration
d7999f5ea64bb1 Arkadiusz Kubalewski 2023-09-13  490   * @status: on success holds dpll's lock status
d7999f5ea64bb1 Arkadiusz Kubalewski 2023-09-13  491   * @extack: error reporting
d7999f5ea64bb1 Arkadiusz Kubalewski 2023-09-13  492   *
d7999f5ea64bb1 Arkadiusz Kubalewski 2023-09-13  493   * Dpll subsystem callback, provides dpll's lock status.
d7999f5ea64bb1 Arkadiusz Kubalewski 2023-09-13  494   *
d7999f5ea64bb1 Arkadiusz Kubalewski 2023-09-13  495   * Context: Acquires pf->dplls.lock
d7999f5ea64bb1 Arkadiusz Kubalewski 2023-09-13  496   * Return:
d7999f5ea64bb1 Arkadiusz Kubalewski 2023-09-13  497   * * 0 - success
d7999f5ea64bb1 Arkadiusz Kubalewski 2023-09-13  498   * * negative - failure
d7999f5ea64bb1 Arkadiusz Kubalewski 2023-09-13  499   */
d7999f5ea64bb1 Arkadiusz Kubalewski 2023-09-13  500  static int
d7999f5ea64bb1 Arkadiusz Kubalewski 2023-09-13  501  ice_dpll_lock_status_get(const struct dpll_device *dpll, void *dpll_priv,
d7999f5ea64bb1 Arkadiusz Kubalewski 2023-09-13  502  			 enum dpll_lock_status *status,
0bbc9a9d0d8c32 Jiri Pirko           2024-01-29  503  			 enum dpll_lock_status_error *status_error,
d7999f5ea64bb1 Arkadiusz Kubalewski 2023-09-13  504  			 struct netlink_ext_ack *extack)
d7999f5ea64bb1 Arkadiusz Kubalewski 2023-09-13 @505  {
d7999f5ea64bb1 Arkadiusz Kubalewski 2023-09-13  506  	struct ice_dpll *d = dpll_priv;
d7999f5ea64bb1 Arkadiusz Kubalewski 2023-09-13  507  	struct ice_pf *pf = d->pf;
d7999f5ea64bb1 Arkadiusz Kubalewski 2023-09-13  508  
d7999f5ea64bb1 Arkadiusz Kubalewski 2023-09-13  509  	mutex_lock(&pf->dplls.lock);
d7999f5ea64bb1 Arkadiusz Kubalewski 2023-09-13  510  	*status = d->dpll_state;
d7999f5ea64bb1 Arkadiusz Kubalewski 2023-09-13  511  	mutex_unlock(&pf->dplls.lock);
d7999f5ea64bb1 Arkadiusz Kubalewski 2023-09-13  512  
d7999f5ea64bb1 Arkadiusz Kubalewski 2023-09-13  513  	return 0;
d7999f5ea64bb1 Arkadiusz Kubalewski 2023-09-13  514  }
d7999f5ea64bb1 Arkadiusz Kubalewski 2023-09-13  515  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

