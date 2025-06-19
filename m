Return-Path: <netdev+bounces-199588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA180AE0DAE
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 21:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75CB73BF188
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 19:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455AB245006;
	Thu, 19 Jun 2025 19:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kFOq/gED"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4039F21FF5D
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 19:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750360840; cv=none; b=JrHna+kgJXT/2pyqggcZyZIiBOU3CJJ+8/JTsEt2HwzQQLGGdKoX4PIMHKRTsG1aAfviFETImHcUepJNa5iQa4AevnfIp8mviuX2RkW7fz8ekAwml6ff1efUHsBDwJDVj6Zy6Ql7qFiDnT73fRtHupCASpDANKk1oeJV6SoaV88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750360840; c=relaxed/simple;
	bh=pot+ohnN0ZO3Fh+TEFIfLl2YCGEG4usCNHjE1LGOsRc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DmlylZQglb7uMKug0KvSasDVLIEom21tzUwuJi8KrD9J8AmrSwx6D1eFBaR8Tq07r1ZmLpuCLkGGjlg2ggspHLK/hLIWkQtulMui5Aw2lEcfbXxQQAHjbkg/m/FrNGionekOPN5lpaRrOMqFGqsoLHRQuPPtkPYN5r+tgm+PRs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kFOq/gED; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750360837; x=1781896837;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pot+ohnN0ZO3Fh+TEFIfLl2YCGEG4usCNHjE1LGOsRc=;
  b=kFOq/gED0bkHeMUikOskpcmIqTKX35d1YCF89YF+a5IPxvdHqVaCWSTE
   6IOAB/pXa9XA07vXpgl6+SaKNL3/oCdAzzPMDYwPh1CN/jS1a5c6BbLIq
   nL9nqVW/oQ3oHj6PE6cyvu40BQvhNH+weLu68kHSYbGTC6zUPJOiUSXH2
   OYFT/wHY2O1uRIv9S70cqCzzr02gJuPbWV6ds8ip8mrsIkQpakrNgt2iH
   lQs1n87As/TCmQDU3uJxeC+ZjokIXkU38AH84gSWWZQkXa+8hcjBHrZam
   ApQq62ifP24aCUH0LTpQ7H6hUyApp65NRPd4ysLcikuK2vTF6HxYIIWnF
   w==;
X-CSE-ConnectionGUID: bi7GSeJeQQiJFqS02hAsOA==
X-CSE-MsgGUID: zypwjMJTTyGQptqLIl2zeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52701102"
X-IronPort-AV: E=Sophos;i="6.16,249,1744095600"; 
   d="scan'208";a="52701102"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 12:20:37 -0700
X-CSE-ConnectionGUID: ilE3VY5YR8ehCGUtpyrHRQ==
X-CSE-MsgGUID: fzEG4tzlSxePRFDZz5niFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,249,1744095600"; 
   d="scan'208";a="150216905"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 19 Jun 2025 12:20:35 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uSKoK-000L3G-1e;
	Thu, 19 Jun 2025 19:20:32 +0000
Date: Fri, 20 Jun 2025 03:20:02 +0800
From: kernel test robot <lkp@intel.com>
To: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [net-next:main 35/47] drivers/net/pse-pd/pse_core.c:676:23: error:
 incompatible pointer types passing 'struct net_device *' to parameter of
 type 'struct phy_device *'
Message-ID: <202506200355.TqFiYUbN-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git main
head:   afc783fa0aab9cc093fbb04871bfda406480cf8d
commit: fc0e6db30941a66e284b8516b82356f97f31061d [35/47] net: pse-pd: Add support for reporting events
config: i386-randconfig-012-20250619 (https://download.01.org/0day-ci/archive/20250620/202506200355.TqFiYUbN-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250620/202506200355.TqFiYUbN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506200355.TqFiYUbN-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/pse-pd/pse_core.c:676:23: error: incompatible pointer types passing 'struct net_device *' to parameter of type 'struct phy_device *' [-Werror,-Wincompatible-pointer-types]
     676 |                         ethnl_pse_send_ntf(netdev, notifs);
         |                                            ^~~~~~
   include/linux/ethtool_netlink.h:125:58: note: passing argument to parameter 'phydev' here
     125 | static inline void ethnl_pse_send_ntf(struct phy_device *phydev,
         |                                                          ^
   1 error generated.


vim +676 drivers/net/pse-pd/pse_core.c

   632	
   633	/**
   634	 * pse_isr - IRQ handler for PSE
   635	 * @irq: irq number
   636	 * @data: pointer to user interrupt structure
   637	 *
   638	 * Return: irqreturn_t - status of IRQ
   639	 */
   640	static irqreturn_t pse_isr(int irq, void *data)
   641	{
   642		struct pse_controller_dev *pcdev;
   643		unsigned long notifs_mask = 0;
   644		struct pse_irq_desc *desc;
   645		struct pse_irq *h = data;
   646		int ret, i;
   647	
   648		desc = &h->desc;
   649		pcdev = h->pcdev;
   650	
   651		/* Clear notifs mask */
   652		memset(h->notifs, 0, pcdev->nr_lines * sizeof(*h->notifs));
   653		mutex_lock(&pcdev->lock);
   654		ret = desc->map_event(irq, pcdev, h->notifs, &notifs_mask);
   655		mutex_unlock(&pcdev->lock);
   656		if (ret || !notifs_mask)
   657			return IRQ_NONE;
   658	
   659		for_each_set_bit(i, &notifs_mask, pcdev->nr_lines) {
   660			unsigned long notifs, rnotifs;
   661			struct net_device *netdev;
   662			struct pse_control *psec;
   663	
   664			/* Do nothing PI not described */
   665			if (!pcdev->pi[i].rdev)
   666				continue;
   667	
   668			notifs = h->notifs[i];
   669			dev_dbg(h->pcdev->dev,
   670				"Sending PSE notification EVT 0x%lx\n", notifs);
   671	
   672			psec = pse_control_find_by_id(pcdev, i);
   673			rtnl_lock();
   674			netdev = pse_control_get_netdev(psec);
   675			if (netdev)
 > 676				ethnl_pse_send_ntf(netdev, notifs);
   677			rtnl_unlock();
   678			pse_control_put(psec);
   679	
   680			rnotifs = pse_to_regulator_notifs(notifs);
   681			regulator_notifier_call_chain(pcdev->pi[i].rdev, rnotifs,
   682						      NULL);
   683		}
   684	
   685		return IRQ_HANDLED;
   686	}
   687	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

