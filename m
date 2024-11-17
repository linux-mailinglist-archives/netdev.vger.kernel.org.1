Return-Path: <netdev+bounces-145610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A83409D01CB
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 02:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32A691F22E51
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 01:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4CB8F40;
	Sun, 17 Nov 2024 01:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JeFg3XEA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749D0322E;
	Sun, 17 Nov 2024 01:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731805653; cv=none; b=hcgJSR79D1Qe8Uud3077IL211CFBt6vXOo+76ok74lL3y140/6VH5QN8yOvrFPqZvmV5gnU4mt0KGF5bnIGMqEZvggaF09np4h3D/RmJvcVjetz2V4T7RB8zgDQqvJPO5yAmAEdk1yDhuXCm/+V1z6BjQt2LhMHxfyRa6OwRir4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731805653; c=relaxed/simple;
	bh=JV/BR3eNHRVKU3j8XzgX8gRX6PpuuohPl9LkHG/gGRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujsPh/P+IoGocuTCdVpHQJK6zrTEMKpGFZVHQRkFDAKvHEcp8zRxhZuLfqPX/JI5wcUWaP9nLOyR9hZYCtBgRMvoapavsGZtB91AA3q9c0A/BEWQpd3jMtqluG2HHcDJPXPpusqOFvuRwLdKbrpmADiMp/tIRLUUrfb4/WjsXM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JeFg3XEA; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731805652; x=1763341652;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JV/BR3eNHRVKU3j8XzgX8gRX6PpuuohPl9LkHG/gGRY=;
  b=JeFg3XEA4U7y8LvCnyCIDX20JKpWK67z7JrbtLeW8ld4k9Hr/gL50NlC
   Gy2YfXKEW/Ebkd4uuH+FSHgSPZi+aZIkChA33tYx8pPiVP8uEBYvEXKSV
   R53x2liZQ+bJENdVPbnWw84wrGgJXX8jWEIp0uB0lS97tpqkkbf9fkfSn
   26qkX8bEiho+/KD9bTIGWXS8uJfw5Swd3tPXo7k0kEnUb4PtdJl7Jvvmo
   +/8wHciPliTxTCmE3VB/akQUm3uNTN+jDCRD7xb3I/aTKdjHm/Wg7MSHs
   UXWTmbEctJTAh769KKLKB9JkeGmpm0VwNZN3RVZ8Xtx9IAsY0oE8q2P2W
   w==;
X-CSE-ConnectionGUID: v3G6t/AtQICkWMPF7RP8cQ==
X-CSE-MsgGUID: cOayezK7SwSkshSJnXQJZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11258"; a="31938738"
X-IronPort-AV: E=Sophos;i="6.12,160,1728975600"; 
   d="scan'208";a="31938738"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 17:07:31 -0800
X-CSE-ConnectionGUID: Mzgzb28tQdikaSC4nr7MAQ==
X-CSE-MsgGUID: tvoiITjZTX+0MzRQIv/SXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,160,1728975600"; 
   d="scan'208";a="88463037"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 16 Nov 2024 17:07:26 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCTl6-0001Cj-1d;
	Sun, 17 Nov 2024 01:07:24 +0000
Date: Sun, 17 Nov 2024 09:06:41 +0800
From: kernel test robot <lkp@intel.com>
To: admiyo@os.amperecomputing.com, Sudeep Holla <sudeep.holla@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH v7 1/2] mctp pcc: Check before sending MCTP PCC response
 ACK
Message-ID: <202411170849.DynEPZlM-lkp@intel.com>
References: <20241114024928.60004-2-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114024928.60004-2-admiyo@os.amperecomputing.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge linus/master v6.12-rc7 next-20241115]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/admiyo-os-amperecomputing-com/mctp-pcc-Check-before-sending-MCTP-PCC-response-ACK/20241114-105151
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20241114024928.60004-2-admiyo%40os.amperecomputing.com
patch subject: [PATCH v7 1/2] mctp pcc: Check before sending MCTP PCC response ACK
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20241117/202411170849.DynEPZlM-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241117/202411170849.DynEPZlM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411170849.DynEPZlM-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mailbox/pcc.c:115: warning: Excess struct member 'shmem_base_addr' description in 'pcc_chan_info'


vim +115 drivers/mailbox/pcc.c

800cda7b63f22b Sudeep Holla 2021-09-17   82  
80b2bdde002c52 Sudeep Holla 2021-09-17   83  /**
80b2bdde002c52 Sudeep Holla 2021-09-17   84   * struct pcc_chan_info - PCC channel specific information
80b2bdde002c52 Sudeep Holla 2021-09-17   85   *
0f2591e21b2e85 Sudeep Holla 2021-09-17   86   * @chan: PCC channel information with Shared Memory Region info
bf18123e78f4d1 Sudeep Holla 2021-09-17   87   * @db: PCC register bundle for the doorbell register
bf18123e78f4d1 Sudeep Holla 2021-09-17   88   * @plat_irq_ack: PCC register bundle for the platform interrupt acknowledge
bf18123e78f4d1 Sudeep Holla 2021-09-17   89   *	register
c45ded7e11352d Sudeep Holla 2021-09-17   90   * @cmd_complete: PCC register bundle for the command complete check register
c45ded7e11352d Sudeep Holla 2021-09-17   91   * @cmd_update: PCC register bundle for the command complete update register
c45ded7e11352d Sudeep Holla 2021-09-17   92   * @error: PCC register bundle for the error status register
7cd506129724fe Adam Young   2024-11-13   93   * @shmem_base_addr: the virtual memory address of the shared buffer
f92ae90e52bb09 Sudeep Holla 2021-09-17   94   * @plat_irq: platform interrupt
60c40b06fa6869 Huisong Li   2023-08-01   95   * @type: PCC subspace type
3db174e478cb0b Huisong Li   2023-08-01   96   * @plat_irq_flags: platform interrupt flags
3db174e478cb0b Huisong Li   2023-08-01   97   * @chan_in_use: this flag is used just to check if the interrupt needs
3db174e478cb0b Huisong Li   2023-08-01   98   *		handling when it is shared. Since only one transfer can occur
3db174e478cb0b Huisong Li   2023-08-01   99   *		at a time and mailbox takes care of locking, this flag can be
3db174e478cb0b Huisong Li   2023-08-01  100   *		accessed without a lock. Note: the type only support the
3db174e478cb0b Huisong Li   2023-08-01  101   *		communication from OSPM to Platform, like type3, use it, and
3db174e478cb0b Huisong Li   2023-08-01  102   *		other types completely ignore it.
80b2bdde002c52 Sudeep Holla 2021-09-17  103   */
80b2bdde002c52 Sudeep Holla 2021-09-17  104  struct pcc_chan_info {
0f2591e21b2e85 Sudeep Holla 2021-09-17  105  	struct pcc_mbox_chan chan;
bf18123e78f4d1 Sudeep Holla 2021-09-17  106  	struct pcc_chan_reg db;
bf18123e78f4d1 Sudeep Holla 2021-09-17  107  	struct pcc_chan_reg plat_irq_ack;
c45ded7e11352d Sudeep Holla 2021-09-17  108  	struct pcc_chan_reg cmd_complete;
c45ded7e11352d Sudeep Holla 2021-09-17  109  	struct pcc_chan_reg cmd_update;
c45ded7e11352d Sudeep Holla 2021-09-17  110  	struct pcc_chan_reg error;
f92ae90e52bb09 Sudeep Holla 2021-09-17  111  	int plat_irq;
60c40b06fa6869 Huisong Li   2023-08-01  112  	u8 type;
3db174e478cb0b Huisong Li   2023-08-01  113  	unsigned int plat_irq_flags;
3db174e478cb0b Huisong Li   2023-08-01  114  	bool chan_in_use;
80b2bdde002c52 Sudeep Holla 2021-09-17 @115  };
80b2bdde002c52 Sudeep Holla 2021-09-17  116  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

