Return-Path: <netdev+bounces-169284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D99A43324
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 03:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EF80168971
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 02:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD0314830F;
	Tue, 25 Feb 2025 02:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VMp/m9Ag"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BD113C9B8;
	Tue, 25 Feb 2025 02:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740450986; cv=none; b=diCgcyJ7vXIwlG0i2p50gEctlUdyZ7HC5JKh+y9ZEh7FQH1kTnq6X51gObzS9RKRsWz9HXt1g5/mXAApWpbOzCHDc3TiLGhBPWlzrQ8Y6/qJ6jYLAb4XA6z7cA+UFrADyfmhhWQOT/5M+EFqmGaY7LcPURVtvCJHUHCZEmQAsyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740450986; c=relaxed/simple;
	bh=BCGQGMljga26411sT5xP4jNnIMcUcH9wHX8obGdlcoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AV8DnSZb0uOHLM//Q6DrJcVYg637UvBpQ5Du8/xJFSh7M+XusGLNxYVYdwf8edn7W1L8Z7BbwFPjjJzqYkYV11H/B/ChEpOp9mE5iCDNrnuDcLdMuoNIhVHk5m5BggA1+ll5dm2keqMvrVQ2RJ4tv21zLACoxgi/aLwA5g4myCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VMp/m9Ag; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740450984; x=1771986984;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BCGQGMljga26411sT5xP4jNnIMcUcH9wHX8obGdlcoA=;
  b=VMp/m9AgYiBP3wuDioRwBiQ4YcSSrlDDpRipNvIS75O9TwBDOGwfToyk
   0HgOCPhhmy4DoLuG6Xp0aJ+whAq4hWZHspQLK1yGH7G7DzXxyUMQgjPtH
   dTTFs9az8ASPzOFt9xOorQkBgjNsJ4Qnbb48+UDsrKE2yvdN/cm5HxDk2
   F4KFZHmoYI7s6GP0Y4pD7y/pPzT19OOiz+TG+SPqyQ20gZlWPTLRHxqwK
   1to9p1lh221nHl/fevpaKOQmt+7js8XxRsM3/BqVkEXHe0ueMplBEhptI
   vnJfuWHZi798RTUdcCbqP/rwtJnsb+VsEp/EyigYd6Ja6709anodlHAcN
   A==;
X-CSE-ConnectionGUID: tjLyQ6vNSomKiJ/g/Xfzgg==
X-CSE-MsgGUID: oJawWvqiT0GcW4iaYGApQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="40427843"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="40427843"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 18:36:23 -0800
X-CSE-ConnectionGUID: iahtX+s+TBylmQ62GnhRlQ==
X-CSE-MsgGUID: zXweUOBFQV6DheV6xB0S7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120351003"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 24 Feb 2025 18:36:21 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tmknz-0009fD-1D;
	Tue, 25 Feb 2025 02:36:19 +0000
Date: Tue, 25 Feb 2025 10:35:23 +0800
From: kernel test robot <lkp@intel.com>
To: Cindy Lu <lulu@redhat.com>, jasowang@redhat.com, mst@redhat.com,
	michael.christie@oracle.com, sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v6 3/6] vhost: Add the cgroup related function
Message-ID: <202502251038.6UlCIMJy-lkp@intel.com>
References: <20250223154042.556001-4-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250223154042.556001-4-lulu@redhat.com>

Hi Cindy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.14-rc3]
[also build test WARNING on linus/master next-20250224]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cindy-Lu/vhost-Add-a-new-parameter-in-vhost_dev-to-allow-user-select-kthread/20250223-234405
base:   v6.14-rc3
patch link:    https://lore.kernel.org/r/20250223154042.556001-4-lulu%40redhat.com
patch subject: [PATCH v6 3/6] vhost: Add the cgroup related function
config: x86_64-buildonly-randconfig-002-20250224 (https://download.01.org/0day-ci/archive/20250225/202502251038.6UlCIMJy-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250225/202502251038.6UlCIMJy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502251038.6UlCIMJy-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/vhost/vhost.c:275: warning: Function parameter or struct member 'ignore_attachment' not described in '__vhost_worker_flush'


vim +275 drivers/vhost/vhost.c

0921dddcb589803 Mike Christie 2023-06-26  266  
228a27cf78afc63 Mike Christie 2023-06-26  267  /**
ba704ff4e142fd3 Mike Christie 2024-03-15  268   * __vhost_worker_flush - flush a worker
228a27cf78afc63 Mike Christie 2023-06-26  269   * @worker: worker to flush
228a27cf78afc63 Mike Christie 2023-06-26  270   *
ba704ff4e142fd3 Mike Christie 2024-03-15  271   * The worker's flush_mutex must be held.
228a27cf78afc63 Mike Christie 2023-06-26  272   */
84e88426e3bc18f Cindy Lu      2025-02-23  273  static void __vhost_worker_flush(struct vhost_worker *worker,
84e88426e3bc18f Cindy Lu      2025-02-23  274  				 bool ignore_attachment)
a6fc04739be7cd8 Mike Christie 2023-06-26 @275  {
228a27cf78afc63 Mike Christie 2023-06-26  276  	struct vhost_flush_struct flush;
228a27cf78afc63 Mike Christie 2023-06-26  277  
84e88426e3bc18f Cindy Lu      2025-02-23  278  	if ((!ignore_attachment && !worker->attachment_cnt) || worker->killed)
ba704ff4e142fd3 Mike Christie 2024-03-15  279  		return;
ba704ff4e142fd3 Mike Christie 2024-03-15  280  
228a27cf78afc63 Mike Christie 2023-06-26  281  	init_completion(&flush.wait_event);
228a27cf78afc63 Mike Christie 2023-06-26  282  	vhost_work_init(&flush.work, vhost_flush_work);
228a27cf78afc63 Mike Christie 2023-06-26  283  
228a27cf78afc63 Mike Christie 2023-06-26  284  	vhost_worker_queue(worker, &flush.work);
ba704ff4e142fd3 Mike Christie 2024-03-15  285  	/*
ba704ff4e142fd3 Mike Christie 2024-03-15  286  	 * Drop mutex in case our worker is killed and it needs to take the
ba704ff4e142fd3 Mike Christie 2024-03-15  287  	 * mutex to force cleanup.
ba704ff4e142fd3 Mike Christie 2024-03-15  288  	 */
ba704ff4e142fd3 Mike Christie 2024-03-15  289  	mutex_unlock(&worker->mutex);
228a27cf78afc63 Mike Christie 2023-06-26  290  	wait_for_completion(&flush.wait_event);
ba704ff4e142fd3 Mike Christie 2024-03-15  291  	mutex_lock(&worker->mutex);
ba704ff4e142fd3 Mike Christie 2024-03-15  292  }
ba704ff4e142fd3 Mike Christie 2024-03-15  293  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

