Return-Path: <netdev+bounces-196746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C6AAD6298
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 00:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 861B83AB34E
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 22:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D39624A079;
	Wed, 11 Jun 2025 22:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VTBtcSJq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739F824887E
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 22:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749681649; cv=none; b=OJV1LwWYDAW9wp3x1HM9e5buwHHcAHcfogoNever2DO4VReX1+uQi4hNhDejsGAjLfEluEvRinEe33zeMuK4cDm1QPpVrqzhAUBpIc6AaPqQlD88UZVtQgD3vQDJ3FQBp+1Hv/GBSFsFtPoxJUinpn9yoYQv/txxBmNwixDrIlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749681649; c=relaxed/simple;
	bh=clL+hHukW8hOdwCbYC9qmyTSO39mKRqxJ0JAVmgRT4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4UP9YkZFaYPRXLtaU9VegREE5oWty1j6ZRGZywkvKk6G81YZcjMkTEHO7y09yrhZfSSua2S6aZiYPx/kSIAxVs25XSB+h4YOD9hFaXigPrZ174BALYfNFc7LUpjW7igpPUW76pq4PtJd8PnY3IIjwYbMDbV7aLMiRO/7+yNS5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VTBtcSJq; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749681648; x=1781217648;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=clL+hHukW8hOdwCbYC9qmyTSO39mKRqxJ0JAVmgRT4M=;
  b=VTBtcSJqDmqy2pTuF4SYbyuTBimCJcpDOVcltKlm34zWKQ/GsnnapBTR
   ILEFFbKJ15SGR/LXbrlj12A+XNjqFYxyaRhEnWg6q+6oa/MxmM06I+mdZ
   LeLRpQ9xhgYzjWPTY30CXD36qtosOjBXxxGpXLgnazuY/wGqapdu8Ldzz
   n9f1VaOcuNSYVZ3PFtbaTByuelIufr3grIeWZIdjTd77+ZkjiVet/+x9g
   XQyoXcp0kI4If83vnEVyPt2aiJ1wCVhiZI+Jvs6nbnAnQroz0bc3vgIKr
   h9411jZ98s4EY1F6fOAAmSjsRmKKIBJbuTHFvN5sIxMokCIEXcBT3qSd0
   A==;
X-CSE-ConnectionGUID: 6HN9VREsQFSET9QNHLnf3Q==
X-CSE-MsgGUID: x7EG7V4gSJChsuFpQXp8zA==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="69405161"
X-IronPort-AV: E=Sophos;i="6.16,229,1744095600"; 
   d="scan'208";a="69405161"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 15:40:44 -0700
X-CSE-ConnectionGUID: 5TGcI8TISU2TWTN2UvZkQw==
X-CSE-MsgGUID: Q8IkK4TCQJOPK1eDbmrX+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,229,1744095600"; 
   d="scan'208";a="151130052"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 11 Jun 2025 15:40:40 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uPU7a-000AuI-10;
	Wed, 11 Jun 2025 22:40:38 +0000
Date: Thu, 12 Jun 2025 06:39:41 +0800
From: kernel test robot <lkp@intel.com>
To: Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
	duanqiangwen@net-swift.com, linglingzhang@trustnetic.com,
	jiawenwu@net-swift.com, Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next 06/12] net: txgbevf: init interrupts and request
 irqs
Message-ID: <202506120658.JRvrXNTk-lkp@intel.com>
References: <20250611083559.14175-7-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611083559.14175-7-mengyuanlou@net-swift.com>

Hi Mengyuan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Mengyuan-Lou/net-libwx-add-mailbox-api-for-wangxun-vf-drivers/20250611-165134
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250611083559.14175-7-mengyuanlou%40net-swift.com
patch subject: [PATCH net-next 06/12] net: txgbevf: init interrupts and request irqs
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20250612/202506120658.JRvrXNTk-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250612/202506120658.JRvrXNTk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506120658.JRvrXNTk-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c:77:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
      77 |                 default:
         |                 ^
   drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c:77:3: note: insert 'break;' to avoid fall-through
      77 |                 default:
         |                 ^
         |                 break; 
   1 warning generated.


vim +77 drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c

    46	
    47	static void txgbevf_set_num_queues(struct wx *wx)
    48	{
    49		u32 def_q = 0, num_tcs = 0;
    50		u16 rss, queue;
    51		int ret = 0;
    52	
    53		/* Start with base case */
    54		wx->num_rx_queues = 1;
    55		wx->num_tx_queues = 1;
    56	
    57		spin_lock_bh(&wx->mbx.mbx_lock);
    58		/* fetch queue configuration from the PF */
    59		ret = wx_get_queues_vf(wx, &num_tcs, &def_q);
    60		spin_unlock_bh(&wx->mbx.mbx_lock);
    61	
    62		if (ret)
    63			return;
    64	
    65		/* we need as many queues as traffic classes */
    66		if (num_tcs > 1) {
    67			wx->num_rx_queues = num_tcs;
    68		} else {
    69			rss = min_t(u16, num_online_cpus(), TXGBEVF_MAX_RSS_NUM);
    70			queue = min_t(u16, wx->mac.max_rx_queues, wx->mac.max_tx_queues);
    71			rss = min_t(u16, queue, rss);
    72	
    73			switch (wx->vfinfo->vf_api) {
    74			case wx_mbox_api_13:
    75				wx->num_rx_queues = rss;
    76				wx->num_tx_queues = rss;
  > 77			default:
    78				break;
    79			}
    80		}
    81	}
    82	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

