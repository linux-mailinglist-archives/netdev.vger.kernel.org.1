Return-Path: <netdev+bounces-109144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF950927233
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 10:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843111F2201B
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 08:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7B61AAE02;
	Thu,  4 Jul 2024 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DgPlPXr/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBF418FC7F;
	Thu,  4 Jul 2024 08:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720083278; cv=none; b=MkgHui9bp/0Frzs6ocoJooBXw40wHjBdJaIqkyKxeY0DIpZz+cOaDXceYwJycMs44X2LOnCa1xNFwkYVynwyapcODoCdNv2wfWlX3HEklJxtuamRLUlJggzB3N2d+XQyjwZftFKybPu5tLO7QVDd801T9UWiSjiVpGtktblc6wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720083278; c=relaxed/simple;
	bh=IKnR9QTiWV9KEgEIjOCLki6MYa3rl/NDnSOe4i30VNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UweUwPdS0dZCqzE3OkghK2i2ubj5jbvrJC0ZbVhyiVsUPceRqds6kTEHY0YJT38zzmLy2jnF3efsCHfTh3QK1/FeKY4xWxRZMGKSp/BKdF+iIPJr4BJgwmP7gCfbDRC/WN0o2wt9q0uidzwE5SMuEzkvO2Js+/Cje706HuTKXEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DgPlPXr/; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720083277; x=1751619277;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IKnR9QTiWV9KEgEIjOCLki6MYa3rl/NDnSOe4i30VNk=;
  b=DgPlPXr/vINyZv06camuQkMSqv8vTFC6rOB36reYan0elPHIDfeI4BAw
   4Z586SPKHjAJ/KxFBbpzsHBJ5QIihW9kFR5nf8qACcKQbQjG4spSPnnB8
   GSZzvouLI3vS6bWdJyBhg1Qi1KHz4YawGRDjBUhYAj4NgWhBUkMCNCAtK
   nqBBtCh13TkgRHWxlhZfi55XAOFHOpd/vh1A1uRXFi89BySOBflq+TSz+
   oJ1zU+OD9Bg8ltrxGEQYLf7jjgjJptIHEjL/M/+mXjQHqFLotJ8tgsmxq
   B+rP+prC3jTJS1eLzB3Koman+AdjIgxMI4Kux2EhGfSnwtH1D8DUU230p
   g==;
X-CSE-ConnectionGUID: eJxu6eawRV69qjBG5YTrjQ==
X-CSE-MsgGUID: wpr+Oh1BRL+39hIhfOVgLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="28494069"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="28494069"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 01:54:37 -0700
X-CSE-ConnectionGUID: EPHtbNjsTXenuHBIYE+azA==
X-CSE-MsgGUID: uW1VRofbR5+DHUL5Aw3ZkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="51490286"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 04 Jul 2024 01:54:33 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sPIEY-000QmG-0T;
	Thu, 04 Jul 2024 08:54:30 +0000
Date: Thu, 4 Jul 2024 16:53:35 +0800
From: kernel test robot <lkp@intel.com>
To: admiyo@os.amperecomputing.com, Sudeep Holla <sudeep.holla@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH v4 1/3] mctp pcc: Check before sending MCTP PCC response
 ACK
Message-ID: <202407041613.PPjZeDpu-lkp@intel.com>
References: <20240702225845.322234-2-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702225845.322234-2-admiyo@os.amperecomputing.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge linus/master v6.10-rc6 next-20240703]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/admiyo-os-amperecomputing-com/mctp-pcc-Check-before-sending-MCTP-PCC-response-ACK/20240703-163558
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20240702225845.322234-2-admiyo%40os.amperecomputing.com
patch subject: [PATCH v4 1/3] mctp pcc: Check before sending MCTP PCC response ACK
config: i386-randconfig-061-20240704 (https://download.01.org/0day-ci/archive/20240704/202407041613.PPjZeDpu-lkp@intel.com/config)
compiler: gcc-12 (Ubuntu 12.3.0-9ubuntu2) 12.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240704/202407041613.PPjZeDpu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407041613.PPjZeDpu-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/mailbox/pcc.c:287:44: sparse: sparse: dubious: !x & y

vim +287 drivers/mailbox/pcc.c

   272	
   273	static void check_and_ack(struct pcc_chan_info *pchan, struct mbox_chan *chan)
   274	{
   275		struct pcc_extended_type_hdr pcc_hdr;
   276	
   277		if (pchan->type != ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
   278			return;
   279		memcpy_fromio(&pcc_hdr, pchan->shmem_base_addr,
   280			      sizeof(struct pcc_extended_type_hdr));
   281		/*
   282		 * The PCC slave subspace channel needs to set the command complete bit
   283		 * and ring doorbell after processing message.
   284		 *
   285		 * The PCC master subspace channel clears chan_in_use to free channel.
   286		 */
 > 287		if (!!le32_to_cpup(&pcc_hdr.flags) & PCC_ACK_FLAG_MASK)
   288			pcc_send_data(chan, NULL);
   289	}
   290	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

