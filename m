Return-Path: <netdev+bounces-286955-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BoiIGS8AmonwAEAu9opvQ
	(envelope-from <netdev+bounces-286955-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 07:36:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFC951A2C5
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 07:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 537B23041BB9
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 05:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86AC39891C;
	Tue, 12 May 2026 05:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pvum05ck"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986E438737E
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 05:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778563972; cv=none; b=aDHEKdEevUoMWYO+IVNuUUBXKtGWUqDs6oNaSpEdHObfD24MBJixhE34sPsvgUmgfdeOtH17j7GadkUQR9AVXnIJl7jgmW3vI5lxYih3Gw26DPHQBaziv/Pac+1LEZsPWdE/NxUNG//bTVsjDKn6K+TMOEqcWodQHIo5tAEIk/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778563972; c=relaxed/simple;
	bh=lx+K+0YCP54PiWyu/GiEJIZl64mAgPzGpZSUAIt8dOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+o+Y5Q9kxOuDGKLM3IO/udnQlPzLZKTSM1y7lGEyFeC2ue/7HUlwuDzEGKFdaO6xVV/Vc88dL6FvlU2iexUoV7FfQzmwbzN763wjVZOfWD7hmM6AJEozkajtpcgt0ML3HMS/cclYeFN5Kj5yYUCTjF4RmOicC+BNmlVQ+mKhvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pvum05ck; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778563971; x=1810099971;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lx+K+0YCP54PiWyu/GiEJIZl64mAgPzGpZSUAIt8dOU=;
  b=Pvum05ckXCRMF9elfGwK0jAschaT9KuZaYs713pw5b6sNEnyAFdZpZSN
   mteqLnx6lpd5csKw0gxQrwIzKMpaqhCXLTVxPrz6R3xMKlvauoss3A1zj
   C8++EqsI4/Pgv9BhVmvZgOX2MEJW0FgUcPCUm615AS1RV6hS9WF0oOZQr
   kOe7TPEBJvtZPb+2xFN5kJ+U9FPWZ88n7zWSdlcVLdv9cAONqKMFwTp24
   5XU3w+Kvyj/Toa8JQe63eTVNDdA2SCGRu2WIu1QQp58tp5xavOrXOfcST
   27R8Xmzxm+Yo1CErqqn9TTir+zahw9CdVDgDOQQqz5Fh6I4EC9QWtvqax
   w==;
X-CSE-ConnectionGUID: yJ0MMWOFSHKCZIH35Q2sjA==
X-CSE-MsgGUID: T+inO1koQQ+bTx+k++DQOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="89766954"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="89766954"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 22:32:50 -0700
X-CSE-ConnectionGUID: 6djvsQSsRwSmwlARv6CcJg==
X-CSE-MsgGUID: KttygPD5QRSCpD2Dw972PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="233352080"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 11 May 2026 22:32:47 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wMfjY-000000001dp-0Y1a;
	Tue, 12 May 2026 05:32:44 +0000
Date: Tue, 12 May 2026 13:32:29 +0800
From: kernel test robot <lkp@intel.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH net v2] ptp: ocp: fix resource freeing order
Message-ID: <202605121304.5VA5PtAi-lkp@intel.com>
References: <20260511161838.1413499-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511161838.1413499-1-vadim.fedorenko@linux.dev>
X-Rspamd-Queue-Id: EBFC951A2C5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286955-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linux.dev,gmail.com,lunn.ch,davemloft.net,redhat.com,nxp.com,armlinux.org.uk,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,kernel];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,01.org:url]
X-Rspamd-Action: no action

Hi Vadim,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Vadim-Fedorenko/ptp-ocp-fix-resource-freeing-order/20260512-061754
base:   net/main
patch link:    https://lore.kernel.org/r/20260511161838.1413499-1-vadim.fedorenko%40linux.dev
patch subject: [PATCH net v2] ptp: ocp: fix resource freeing order
config: sparc64-randconfig-002-20260512 (https://download.01.org/0day-ci/archive/20260512/202605121304.5VA5PtAi-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260512/202605121304.5VA5PtAi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605121304.5VA5PtAi-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/ptp/ptp_ocp.c: In function 'ptp_ocp_detach':
>> drivers/ptp/ptp_ocp.c:4872:39: error: expected ';' before 'if'
      ptp_ocp_ts_enable(bp->ts1, 0, false)
                                          ^
                                          ;
     if (bp->ts2)
     ~~                                    


vim +4872 drivers/ptp/ptp_ocp.c

  4860	
  4861	static void
  4862	ptp_ocp_detach(struct ptp_ocp *bp)
  4863	{
  4864		int i;
  4865	
  4866		ptp_ocp_debugfs_remove_device(bp);
  4867		ptp_ocp_detach_sysfs(bp);
  4868		ptp_ocp_attr_group_del(bp);
  4869		timer_delete_sync(&bp->watchdog);
  4870		/* Disable interrupts on all timestampers */
  4871		if (bp->ts1)
> 4872			ptp_ocp_ts_enable(bp->ts1, 0, false)
  4873		if (bp->ts2)
  4874			ptp_ocp_ts_enable(bp->ts2, 0, false)
  4875		if (bp->ts3)
  4876			ptp_ocp_ts_enable(bp->ts3, 0, false)
  4877		if (bp->ts4)
  4878			ptp_ocp_ts_enable(bp->ts4, 0, false)
  4879		if (bp->ptp)
  4880			ptp_clock_unregister(bp->ptp);
  4881		kfree(bp->ptp_info.pin_config);
  4882		ptp_ocp_unregister_ext(bp->ts0);
  4883		ptp_ocp_unregister_ext(bp->ts1);
  4884		ptp_ocp_unregister_ext(bp->ts2);
  4885		ptp_ocp_unregister_ext(bp->ts3);
  4886		ptp_ocp_unregister_ext(bp->ts4);
  4887		ptp_ocp_unregister_ext(bp->pps);
  4888		for (i = 0; i < 4; i++)
  4889			ptp_ocp_unregister_ext(bp->signal_out[i]);
  4890		for (i = 0; i < __PORT_COUNT; i++)
  4891			if (bp->port[i].line != -1)
  4892				serial8250_unregister_port(bp->port[i].line);
  4893		platform_device_unregister(bp->spi_flash);
  4894		platform_device_unregister(bp->i2c_ctrl);
  4895		if (bp->i2c_clk)
  4896			clk_hw_unregister_fixed_rate(bp->i2c_clk);
  4897		if (bp->n_irqs)
  4898			pci_free_irq_vectors(bp->pdev);
  4899		device_unregister(&bp->dev);
  4900	}
  4901	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

