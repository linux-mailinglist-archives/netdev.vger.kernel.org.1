Return-Path: <netdev+bounces-99889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A07E98D6DA4
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 05:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3221B23CF1
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 03:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85CCF51B;
	Sat,  1 Jun 2024 03:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dq0ZQB97"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A44AD55;
	Sat,  1 Jun 2024 03:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717211684; cv=none; b=QRMrmhQLR94S075KHR+OPbqx3wruvQpT+2Jqrlrt8gnMD5WYjA7c0Q9zPJJmkTKBJu9UGy6Eeji1J4fsN00+HgbfXTUzYvaMynQ29WpKGHw2/xeE106f/CJWkeu5O7cp0Tq5dFsWPBk9F1bK3gAEbgudALSTgw7TuO3uA32Z2hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717211684; c=relaxed/simple;
	bh=7FQyW/yioMpQHBP4xhyLZXl/Y2Ju6MhY7VJfMNnD+kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQyaAi3fXMV+LIHYA7tYn8ZjABVNXTlSjh59RabmaDRjC6F2lCLhUeg8jPeo7PRA1Zc+OUG0wEqO3awX62uuf78MzJyCjxHIi5AAgZqQFJqSZBgLvZEkUV3gL2ULmD4g9aBQ6zKr1LEJjsjnM0PQkr/+iRxswNlPo8c+ef9ch3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dq0ZQB97; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717211684; x=1748747684;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7FQyW/yioMpQHBP4xhyLZXl/Y2Ju6MhY7VJfMNnD+kE=;
  b=dq0ZQB971K/5Sm9A8k9J7NWDwXpwm4KH6vPl5m1imRFWgau3NmCCIvL+
   7NWKlxauTODd2HGvJlAnFaeRydObCM7wP6SFbJOIrfx1eWJwf7vmowXK7
   AQsGFINI/TwEhA6kz8uCE9um2Ju7kULAbhii+P5iygVzhlGYqavF9Vfza
   /FAGqy7oPmMQILy/ZXihb0FahhLGuE6qcPotFZkvnOnSin8Bjp/CH4ZTx
   Z0Y/JGcYUhLG9PVieVPyu7rZsRW0K8niAHqoIloiAIKGJGQKBdcRJVb2B
   CKvsOdbOvjJ500Q+xUpphjhj3J9k+n56e07zrgZhDrZ0hdhC2P/TJX8Qy
   A==;
X-CSE-ConnectionGUID: UXr1pl6aSJeWfnA7AzV22A==
X-CSE-MsgGUID: /IyC1BgOShuzlSWWPfVJXg==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="24431279"
X-IronPort-AV: E=Sophos;i="6.08,206,1712646000"; 
   d="scan'208";a="24431279"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 20:14:44 -0700
X-CSE-ConnectionGUID: LDZuZgfsQtmtWrGPRFQGtg==
X-CSE-MsgGUID: u+nMsEkTS6GXndRjCWf6hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,206,1712646000"; 
   d="scan'208";a="73824294"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 31 May 2024 20:14:38 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sDFCW-000IHN-0Q;
	Sat, 01 Jun 2024 03:14:36 +0000
Date: Sat, 1 Jun 2024 11:13:50 +0800
From: kernel test robot <lkp@intel.com>
To: Yojana Mallik <y-mallik@ti.com>, schnelle@linux.ibm.com,
	wsa+renesas@sang-engineering.com, diogo.ivo@siemens.com,
	rdunlap@infradead.org, horms@kernel.org, vigneshr@ti.com,
	rogerq@ti.com, danishanwar@ti.com, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, srk@ti.com,
	rogerq@kernel.org
Subject: Re: [PATCH net-next v2 2/3] net: ethernet: ti: Register the RPMsg
 driver as network device
Message-ID: <202406011038.AwLZhQpy-lkp@intel.com>
References: <20240531064006.1223417-3-y-mallik@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531064006.1223417-3-y-mallik@ti.com>

Hi Yojana,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Yojana-Mallik/net-ethernet-ti-RPMsg-based-shared-memory-ethernet-driver/20240531-144258
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240531064006.1223417-3-y-mallik%40ti.com
patch subject: [PATCH net-next v2 2/3] net: ethernet: ti: Register the RPMsg driver as network device
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240601/202406011038.AwLZhQpy-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240601/202406011038.AwLZhQpy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406011038.AwLZhQpy-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/ti/inter_core_virt_eth.c:76:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
      76 |         if (wait) {
         |             ^~~~
   drivers/net/ethernet/ti/inter_core_virt_eth.c:87:9: note: uninitialized use occurs here
      87 |         return ret;
         |                ^~~
   drivers/net/ethernet/ti/inter_core_virt_eth.c:76:2: note: remove the 'if' if its condition is always true
      76 |         if (wait) {
         |         ^~~~~~~~~
   drivers/net/ethernet/ti/inter_core_virt_eth.c:65:9: note: initialize the variable 'ret' to silence this warning
      65 |         int ret;
         |                ^
         |                 = 0
   drivers/net/ethernet/ti/inter_core_virt_eth.c:330:24: error: use of undeclared identifier 'icve_del_mc_addr'
     330 |         __dev_mc_unsync(ndev, icve_del_mc_addr);
         |                               ^
   drivers/net/ethernet/ti/inter_core_virt_eth.c:331:26: error: no member named 'mc_list' in 'struct icve_common'
     331 |         __hw_addr_init(&common->mc_list);
         |                         ~~~~~~  ^
   drivers/net/ethernet/ti/inter_core_virt_eth.c:337:28: error: no member named 'rx_mode_work' in 'struct icve_common'
     337 |         cancel_work_sync(&common->rx_mode_work);
         |                           ~~~~~~  ^
   1 warning and 3 errors generated.


vim +76 drivers/net/ethernet/ti/inter_core_virt_eth.c

    59	
    60	static int icve_create_send_request(struct icve_common *common,
    61					    enum icve_rpmsg_type rpmsg_type,
    62					    bool wait)
    63	{
    64		unsigned long flags;
    65		int ret;
    66	
    67		if (wait)
    68			reinit_completion(&common->sync_msg);
    69	
    70		spin_lock_irqsave(&common->send_msg_lock, flags);
    71		create_request(common, rpmsg_type);
    72		rpmsg_send(common->rpdev->ept, (void *)(&common->send_msg),
    73			   sizeof(common->send_msg));
    74		spin_unlock_irqrestore(&common->send_msg_lock, flags);
    75	
  > 76		if (wait) {
    77			ret = wait_for_completion_timeout(&common->sync_msg,
    78							  ICVE_REQ_TIMEOUT);
    79	
    80			if (!ret) {
    81				dev_err(common->dev, "Failed to receive response within %ld jiffies\n",
    82					ICVE_REQ_TIMEOUT);
    83				ret = -ETIMEDOUT;
    84				return ret;
    85			}
    86		}
    87		return ret;
    88	}
    89	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

