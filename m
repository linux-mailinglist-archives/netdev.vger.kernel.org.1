Return-Path: <netdev+bounces-188802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCB2AAEED3
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 00:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECAF14E7D93
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 22:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13880258CC1;
	Wed,  7 May 2025 22:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m2UicU4B"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3046290BC6;
	Wed,  7 May 2025 22:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746658235; cv=none; b=naVQXfyjPINqR1Y0G+posKIbfYf6xE04V42TnPDRAInxzWGtrPDGlTUN1a0NI6cxa3AnUnZGyxsUHBnwgfd2TH457b9Ksi7/Yw8yfN6BUXlV6HtK6x/AvwRV7DTiMXMiBif77aeUqAHk/IiVNVmbsRU6CO2nk1igY6XiWQups1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746658235; c=relaxed/simple;
	bh=HbnTRcGDguTJcjdl27sUoG7yg/EIj+Ic0JSwYhwH4GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNkxhbkq1EYlaRhy3gnDnjf4S8Cr0LPCCWMioUD6POgpEWOKhkIDLr7T66uWXA4OXgL8n6Zn/4WOhw/N/ys4itLulQe2zw+G6uQPMop1vil3LQqAORgrUnlLPBhY7teD9J6a6KueaZ5zzpiFarXjmvttACfeEN2dvCRUFz0KWF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m2UicU4B; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746658232; x=1778194232;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HbnTRcGDguTJcjdl27sUoG7yg/EIj+Ic0JSwYhwH4GQ=;
  b=m2UicU4BEGTwATDp1KciIPdFRtTM1ZrFEk6SoU+zuJPzJvrAJ47BzAiS
   MAZRGRaT3SrRY4WUU1f6m+QtHG5bTwioFTWHPOHJ0SGXW501EoC3yo1Kp
   7iy6OcYVE81kpy7UooYDZa3bizo/x9ELq6ymNed0d68SkRVJAorthz4Yv
   pFpTTOR5gpWH0O3wSiCrplP7vNupiWgaVc3YxjbOqQ1EI5M6Bofzz53OI
   BTOpwHeD6OBVDJzuJ9zbZUZrDbn5lI8USNttyzh+7wS0XyynF79rfQBcs
   dMDlXt8Hkxr3rdY0Or3DwcAcm4IxZflL4V8odYh9ygGxy8DNV2HOHz0gO
   g==;
X-CSE-ConnectionGUID: ujL7KngaQ6aH7ZvuG1bLXA==
X-CSE-MsgGUID: BLaT3ebLQRCCtYWROlXn5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="48286723"
X-IronPort-AV: E=Sophos;i="6.15,270,1739865600"; 
   d="scan'208";a="48286723"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 15:50:31 -0700
X-CSE-ConnectionGUID: tjSTxzmcRs+u22cpdFlg1g==
X-CSE-MsgGUID: bEjWDmubTu2agF+yhMtAEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,270,1739865600"; 
   d="scan'208";a="140867901"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 07 May 2025 15:50:28 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCnas-00097H-0K;
	Wed, 07 May 2025 22:50:26 +0000
Date: Thu, 8 May 2025 06:49:44 +0800
From: kernel test robot <lkp@intel.com>
To: Sagi Maimon <maimon.sagi@gmail.com>, jonathan.lemon@gmail.com,
	vadim.fedorenko@linux.dev, richardcochran@gmail.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Sagi Maimon <maimon.sagi@gmail.com>
Subject: Re: [PATCH v1] ptp: ocp: Limit SMA/signal/freq counts in show/store
 functions
Message-ID: <202505080859.Ke4zJAh1-lkp@intel.com>
References: <20250506080647.116702-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506080647.116702-1-maimon.sagi@gmail.com>

Hi Sagi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]
[also build test WARNING on net/main linus/master v6.15-rc5 next-20250507]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sagi-Maimon/ptp-ocp-Limit-SMA-signal-freq-counts-in-show-store-functions/20250506-161305
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250506080647.116702-1-maimon.sagi%40gmail.com
patch subject: [PATCH v1] ptp: ocp: Limit SMA/signal/freq counts in show/store functions
config: parisc-allmodconfig (https://download.01.org/0day-ci/archive/20250508/202505080859.Ke4zJAh1-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250508/202505080859.Ke4zJAh1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505080859.Ke4zJAh1-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/ptp/ptp_ocp.c: In function 'ptp_ocp_summary_show':
>> drivers/ptp/ptp_ocp.c:4052:28: warning: '%d' directive writing between 1 and 11 bytes into a region of size 5 [-Wformat-overflow=]
    4052 |         sprintf(label, "GEN%d", nr + 1);
         |                            ^~
   In function '_signal_summary_show',
       inlined from 'ptp_ocp_summary_show' at drivers/ptp/ptp_ocp.c:4215:4:
   drivers/ptp/ptp_ocp.c:4052:24: note: directive argument in the range [-2147483639, 2147483647]
    4052 |         sprintf(label, "GEN%d", nr + 1);
         |                        ^~~~~~~
   drivers/ptp/ptp_ocp.c:4052:9: note: 'sprintf' output between 5 and 15 bytes into a destination of size 8
    4052 |         sprintf(label, "GEN%d", nr + 1);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/ptp/ptp_ocp.c: In function 'ptp_ocp_summary_show':
   drivers/ptp/ptp_ocp.c:4077:29: warning: '%d' directive writing between 1 and 11 bytes into a region of size 4 [-Wformat-overflow=]
    4077 |         sprintf(label, "FREQ%d", nr + 1);
         |                             ^~
   In function '_frequency_summary_show',
       inlined from 'ptp_ocp_summary_show' at drivers/ptp/ptp_ocp.c:4219:4:
   drivers/ptp/ptp_ocp.c:4077:24: note: directive argument in the range [-2147483640, 2147483647]
    4077 |         sprintf(label, "FREQ%d", nr + 1);
         |                        ^~~~~~~~
   drivers/ptp/ptp_ocp.c:4077:9: note: 'sprintf' output between 6 and 16 bytes into a destination of size 8
    4077 |         sprintf(label, "FREQ%d", nr + 1);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +4052 drivers/ptp/ptp_ocp.c

f67bf662d2cffa2 Jonathan Lemon 2021-09-14  4041  
b325af3cfab970e Jonathan Lemon 2022-03-10  4042  static void
b325af3cfab970e Jonathan Lemon 2022-03-10  4043  _signal_summary_show(struct seq_file *s, struct ptp_ocp *bp, int nr)
b325af3cfab970e Jonathan Lemon 2022-03-10  4044  {
b325af3cfab970e Jonathan Lemon 2022-03-10  4045  	struct signal_reg __iomem *reg = bp->signal_out[nr]->mem;
b325af3cfab970e Jonathan Lemon 2022-03-10  4046  	struct ptp_ocp_signal *signal = &bp->signal[nr];
b325af3cfab970e Jonathan Lemon 2022-03-10  4047  	char label[8];
b325af3cfab970e Jonathan Lemon 2022-03-10  4048  	bool on;
b325af3cfab970e Jonathan Lemon 2022-03-10  4049  	u32 val;
b325af3cfab970e Jonathan Lemon 2022-03-10  4050  
b325af3cfab970e Jonathan Lemon 2022-03-10  4051  	on = signal->running;
05fc65f3f5e45e8 Jonathan Lemon 2022-03-15 @4052  	sprintf(label, "GEN%d", nr + 1);
b325af3cfab970e Jonathan Lemon 2022-03-10  4053  	seq_printf(s, "%7s: %s, period:%llu duty:%d%% phase:%llu pol:%d",
b325af3cfab970e Jonathan Lemon 2022-03-10  4054  		   label, on ? " ON" : "OFF",
b325af3cfab970e Jonathan Lemon 2022-03-10  4055  		   signal->period, signal->duty, signal->phase,
b325af3cfab970e Jonathan Lemon 2022-03-10  4056  		   signal->polarity);
b325af3cfab970e Jonathan Lemon 2022-03-10  4057  
b325af3cfab970e Jonathan Lemon 2022-03-10  4058  	val = ioread32(&reg->enable);
b325af3cfab970e Jonathan Lemon 2022-03-10  4059  	seq_printf(s, " [%x", val);
b325af3cfab970e Jonathan Lemon 2022-03-10  4060  	val = ioread32(&reg->status);
b325af3cfab970e Jonathan Lemon 2022-03-10  4061  	seq_printf(s, " %x]", val);
b325af3cfab970e Jonathan Lemon 2022-03-10  4062  
b325af3cfab970e Jonathan Lemon 2022-03-10  4063  	seq_printf(s, " start:%llu\n", signal->start);
b325af3cfab970e Jonathan Lemon 2022-03-10  4064  }
b325af3cfab970e Jonathan Lemon 2022-03-10  4065  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

