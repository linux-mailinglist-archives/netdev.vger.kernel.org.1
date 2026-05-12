Return-Path: <netdev+bounces-287092-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOnHKOEIA2pmzwEAu9opvQ
	(envelope-from <netdev+bounces-287092-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:02:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 978B451F016
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 27D27302C0F3
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C9E38E8B0;
	Tue, 12 May 2026 10:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qurh9UKE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6693938E8CB
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 10:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778583581; cv=none; b=N4FXOx3vb6UFMS7JArWQbq9VTAU0m3dRdam/ZhTufTDtkzNbNYv1uYKmNVN6tbQbWbeQ+wnjZMmZcRF/LkjO8bAuKCadW0uRr97jcC6aRQ3Tek3q5lWse9KidbfRJH9kktKv6DPE4Nmpm6oNmv7BxfUC4S4OGOinIiaCrZUosWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778583581; c=relaxed/simple;
	bh=KCShsNDFwaVgc0g936GzfxoTB5zHdp5tRc26zVLP33U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WI2/98Py/wo/xqxtDKnZ+zB+v0u/ICJyYnL+1yOKeOPouK73INMdHhkhYpyCMe06WnSDmBBoPwSpD2CXRK/ls9+9YltQjFqQHGjjesogF05dWta/gxkfaaA1ui7SdfCRZhH1a/QDPQvosoJJLaWpMP2fyakKc3bNGE27WkQZgJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qurh9UKE; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778583580; x=1810119580;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KCShsNDFwaVgc0g936GzfxoTB5zHdp5tRc26zVLP33U=;
  b=Qurh9UKEgzBHZr3pK9gNJxS0VccyDvh+qauhvcG1lW2lc385Tsv387Ph
   Bp4eaI4eSEe5mc+Soag6XoW0hTdwSiMQxjMOOqMCOAngfIvJ/eLyzn4TM
   jV/arWdnu3VRwH0mH30HDXwVYU3D/qlBcVWUK6x3fPer6SNGjkDMQylBL
   BaxeHD/CAgSUwBGznswrwE93HeSWK5qsBFxP1rng6QxUUqU3b25Hkuw9v
   yggoTLExyQ5iubEtfcskX7lRxBn7vDB6n+jGJL7f4ubzqcPwpa7LK0MDq
   k7RQSqg5RVqpHH1tW3vywaevDS4+208oq7vxOVeYacGVPYUBiXfjsJnz6
   A==;
X-CSE-ConnectionGUID: bxOeKVwXTYqD+8zSIY7TCQ==
X-CSE-MsgGUID: R/XUwOYjRZCR5o9BY7gSqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="89792058"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="89792058"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 03:59:38 -0700
X-CSE-ConnectionGUID: RetFvmcTQSmOeRYouH+sBw==
X-CSE-MsgGUID: 46O51GTFSGq9B5iWl/uclQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="275853671"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 12 May 2026 03:59:35 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wMkpo-0000000020w-0kb3;
	Tue, 12 May 2026 10:59:32 +0000
Date: Tue, 12 May 2026 18:59:18 +0800
From: kernel test robot <lkp@intel.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH net v2] ptp: ocp: fix resource freeing order
Message-ID: <202605121813.ZVbOZfjr-lkp@intel.com>
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
X-Rspamd-Queue-Id: 978B451F016
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287092-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[linux.dev,gmail.com,lunn.ch,davemloft.net,redhat.com,nxp.com,armlinux.org.uk,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

Hi Vadim,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Vadim-Fedorenko/ptp-ocp-fix-resource-freeing-order/20260512-061754
base:   net/main
patch link:    https://lore.kernel.org/r/20260511161838.1413499-1-vadim.fedorenko%40linux.dev
patch subject: [PATCH net v2] ptp: ocp: fix resource freeing order
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20260512/202605121813.ZVbOZfjr-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260512/202605121813.ZVbOZfjr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605121813.ZVbOZfjr-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/ptp/ptp_ocp.c:4872:39: error: expected ';' after expression
                   ptp_ocp_ts_enable(bp->ts1, 0, false)
                                                       ^
                                                       ;
   drivers/ptp/ptp_ocp.c:4874:39: error: expected ';' after expression
                   ptp_ocp_ts_enable(bp->ts2, 0, false)
                                                       ^
                                                       ;
   drivers/ptp/ptp_ocp.c:4876:39: error: expected ';' after expression
                   ptp_ocp_ts_enable(bp->ts3, 0, false)
                                                       ^
                                                       ;
   drivers/ptp/ptp_ocp.c:4878:39: error: expected ';' after expression
                   ptp_ocp_ts_enable(bp->ts4, 0, false)
                                                       ^
                                                       ;
   4 errors generated.


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

