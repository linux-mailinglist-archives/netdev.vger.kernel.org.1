Return-Path: <netdev+bounces-264991-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SbIlIVR+q2mYdgEAu9opvQ
	(envelope-from <netdev+bounces-264991-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 02:24:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6889222955F
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 02:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70AEB301DAE3
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 01:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677472D8DA3;
	Sat,  7 Mar 2026 01:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="edDruARH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843782C0F75;
	Sat,  7 Mar 2026 01:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772846671; cv=none; b=NWgBv9FMUZ+Cfo0o396eItbGbVYkluD8JPt82uW64ifXy3hc+1DHs/V4SA4XrGGIyffI6f0klQfIlGt5JHkg2pcKpiONJYwSQfdn7EQ46CGyR47hLlKlokg30RaZN1vDIivCET5dB8vzwj+YxYPKdD3inPmGjxZOuaIZNCT8Qgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772846671; c=relaxed/simple;
	bh=ZkKxlHy2ZfpuRQh/qqsLp8wSLhvfVOpqtRbX482kiYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWB8EgctU6XXHk6zAnUoQhDGZl0m3epNyqRzQx2fILjojXCYb2H1j759JtsEYmQu1c86MpJFaDNZZSFQDZkcS1enVmj8oq8bP5Ns5lsNpqGpg1qDTt0I7fYGIh72k4bEnAsGlFKkPH9cpCUk8B20VipLPqDIv+YwvMut9gb+NVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=edDruARH; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772846669; x=1804382669;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZkKxlHy2ZfpuRQh/qqsLp8wSLhvfVOpqtRbX482kiYE=;
  b=edDruARHBfh63Tb3idq9U3JCmNRbWcu6bYZrB/1ouxu3LG0VB8tp8QeL
   mVs+CMdnt3cfJcrIBIhey6fHIFmolGgDcaopYliHHf+/2PohFJGMXNnYW
   a2ll42EvsyrnTxzTNOKZFc61kDuaHEsquqhym6l0sXY9xCT5yDysaYzJ6
   PFnA8UaATB1r6Uoq7m+5CTOlgUkU5aLAHB9kqCjbnYZaLHhVMFZX9ZnUH
   3ReZO8jWoPjvZIFmpCx6YFmGXHePHRKM6rr15Vg28n7QfDDONLrD6z3KM
   cMM2JMFbqe2x+ulcxzL4vKpdA2Jp7rIrbRkZRTcd0+SJVV5byrbs0dIbw
   g==;
X-CSE-ConnectionGUID: 5fBxaz2JSqyZaR8sS6X27w==
X-CSE-MsgGUID: WTyMcX5jQoWoR67Csczg9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="73878141"
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="73878141"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 17:24:29 -0800
X-CSE-ConnectionGUID: ImTCdRdzR2uoaAE1zvxEUQ==
X-CSE-MsgGUID: 8QoW4UlqQY6FfsGIRgf6/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="223287665"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 06 Mar 2026 17:24:27 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vygP1-000000001YP-0tpb;
	Sat, 07 Mar 2026 01:24:23 +0000
Date: Sat, 7 Mar 2026 09:24:08 +0800
From: kernel test robot <lkp@intel.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, andrew+netdev@lunn.ch,
	Raju Rangoju <Raju.Rangoju@amd.com>
Subject: Re: [PATCH net-next 1/2] amd-xgbe: Simplify powerdown/powerup paths
Message-ID: <202603070918.CSq5IR0g-lkp@intel.com>
References: <20260306121047.1231755-2-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306121047.1231755-2-Raju.Rangoju@amd.com>
X-Rspamd-Queue-Id: 6889222955F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264991-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,01.org:url]
X-Rspamd-Action: no action

Hi Raju,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Raju-Rangoju/amd-xgbe-Simplify-powerdown-powerup-paths/20260306-202410
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260306121047.1231755-2-Raju.Rangoju%40amd.com
patch subject: [PATCH net-next 1/2] amd-xgbe: Simplify powerdown/powerup paths
config: sparc-randconfig-001-20260307 (https://download.01.org/0day-ci/archive/20260307/202603070918.CSq5IR0g-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260307/202603070918.CSq5IR0g-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603070918.CSq5IR0g-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/amd/xgbe/xgbe-pci.c:379:12: warning: 'xgbe_pci_resume' defined but not used [-Wunused-function]
     379 | static int xgbe_pci_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~
>> drivers/net/ethernet/amd/xgbe/xgbe-pci.c:363:12: warning: 'xgbe_pci_suspend' defined but not used [-Wunused-function]
     363 | static int xgbe_pci_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~


vim +/xgbe_pci_resume +379 drivers/net/ethernet/amd/xgbe/xgbe-pci.c

   362	
 > 363	static int xgbe_pci_suspend(struct device *dev)
   364	{
   365		struct xgbe_prv_data *pdata = dev_get_drvdata(dev);
   366		struct net_device *netdev = pdata->netdev;
   367		int ret = 0;
   368	
   369		if (netif_running(netdev))
   370			ret = xgbe_powerdown(netdev);
   371	
   372		pdata->lpm_ctrl = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_CTRL1);
   373		pdata->lpm_ctrl |= MDIO_CTRL1_LPOWER;
   374		XMDIO_WRITE(pdata, MDIO_MMD_PCS, MDIO_CTRL1, pdata->lpm_ctrl);
   375	
   376		return ret;
   377	}
   378	
 > 379	static int xgbe_pci_resume(struct device *dev)
   380	{
   381		struct xgbe_prv_data *pdata = dev_get_drvdata(dev);
   382		struct net_device *netdev = pdata->netdev;
   383		int ret = 0;
   384	
   385		XP_IOWRITE(pdata, XP_INT_EN, 0x1fffff);
   386	
   387		pdata->lpm_ctrl &= ~MDIO_CTRL1_LPOWER;
   388		XMDIO_WRITE(pdata, MDIO_MMD_PCS, MDIO_CTRL1, pdata->lpm_ctrl);
   389	
   390		if (netif_running(netdev)) {
   391			ret = xgbe_powerup(netdev);
   392	
   393			/* Schedule a restart in case the link or phy state changed
   394			 * while we were powered down.
   395			 */
   396			schedule_work(&pdata->restart_work);
   397		}
   398	
   399		return ret;
   400	}
   401	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

