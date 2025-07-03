Return-Path: <netdev+bounces-203610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B86AF6869
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 04:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3B745224FF
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 02:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02A4219A8D;
	Thu,  3 Jul 2025 02:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AnTNV3xY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2642F19ABDE
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 02:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751511564; cv=none; b=bpRnhQd6ToR0jTj26+i4L3o+1h2Fn0802OWjE0oVJGbVXi9M22q4E+Vh5ndGN6gO4yYgu6nU/MZKhfv8u7lwPmGYHKZPwzs82zzME7ZCIbFHCnySTBV0nccD8DckSigaVcZBF6jsKvsUz5d8y8N0lo0e0mq7rt1o2i9mp/HijFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751511564; c=relaxed/simple;
	bh=jqkrbGIblO1LWEQnHFU3lka4kBD2RxTr/WcVQOAc2q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VeMHejLeGOxHL0nZk7si/3mlBIElOBfEAZv2BV3r61Xw3iXaniw/AZZFNZ83A4ZV3jJqKgEhS4WdP1kPdzK4Fbeo7rEa2h3Z403t/lTFGQ5O+RYUXzgk6gppVeoZ3PntgT8rqzeNhc6vPq0m7rL1SkzkVY4Cl6QRsZZTOwvOwtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AnTNV3xY; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751511564; x=1783047564;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jqkrbGIblO1LWEQnHFU3lka4kBD2RxTr/WcVQOAc2q8=;
  b=AnTNV3xYIPp72oL+5NsBd3133v/fxzWg+u18EnBg0GEoIKSem043SQMl
   9jR/SFl9eo+Icp28uVN4a8uobcyjcDdhNcBJ74rplhiTg/1x5fWeppZlc
   7Izmnpn7KARumXGS9ghijvuXRTP3nwSI+IZS3OtVAar9dGfnEeR/0k4Ha
   kUXK98UXQ7UbJqVUY2pA+cNMe4PuUSqYxfvyAblxJyjGgzHRYRdDmW93T
   M8fD0s1zheyw9Ea5co6shGtfU1c8utb7jtY496AtDhP2FgXM4SQeAIoVS
   eEz8c2gg7BirmugB6iSmpULUbMUA3QZyGazVh0ZbVylm0/2XlmaZV/SNn
   A==;
X-CSE-ConnectionGUID: hTyYh6RtReq9aAz/epmnvQ==
X-CSE-MsgGUID: Hq1K/JXKSUuxq6A9PJcVJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="65281796"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; 
   d="scan'208";a="65281796"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 19:59:24 -0700
X-CSE-ConnectionGUID: 4ltHjfUdRb27zYhAb1hi9Q==
X-CSE-MsgGUID: zYA43KZMQpuUwBKlNtFUnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; 
   d="scan'208";a="159941461"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 02 Jul 2025 19:59:21 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uXAAQ-0001Pf-2Y;
	Thu, 03 Jul 2025 02:59:18 +0000
Date: Thu, 3 Jul 2025 10:58:22 +0800
From: kernel test robot <lkp@intel.com>
To: Mingming Cao <mmc@linux.ibm.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, bjking1@linux.ibm.com,
	haren@linux.ibm.com, ricklind@linux.ibm.com, mmc@linux.ibm.com,
	Dave Marquardt <davemarq@linux.ibm.com>
Subject: Re: [PATCH net-next 2/4] ibmvnic: Use atomic64_t for queue stats
Message-ID: <202507031001.nn9LVAkH-lkp@intel.com>
References: <20250630234806.10885-3-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630234806.10885-3-mmc@linux.ibm.com>

Hi Mingming,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Mingming-Cao/ibmvnic-Derive-NUM_RX_STATS-NUM_TX_STATS-dynamically/20250701-074915
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250630234806.10885-3-mmc%40linux.ibm.com
patch subject: [PATCH net-next 2/4] ibmvnic: Use atomic64_t for queue stats
compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146a88f60492b520a36f8f8f3231e15f3cc6082)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507031001.nn9LVAkH-lkp@intel.com/

includecheck warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/ibm/ibmvnic.c: linux/atomic.h is included more than once.

vim +62 drivers/net/ethernet/ibm/ibmvnic.c

    34	
    35	#include <linux/module.h>
    36	#include <linux/moduleparam.h>
    37	#include <linux/types.h>
    38	#include <linux/errno.h>
    39	#include <linux/completion.h>
    40	#include <linux/ioport.h>
    41	#include <linux/dma-mapping.h>
    42	#include <linux/kernel.h>
    43	#include <linux/netdevice.h>
    44	#include <linux/etherdevice.h>
    45	#include <linux/skbuff.h>
    46	#include <linux/init.h>
    47	#include <linux/delay.h>
    48	#include <linux/mm.h>
    49	#include <linux/ethtool.h>
    50	#include <linux/proc_fs.h>
    51	#include <linux/if_arp.h>
    52	#include <linux/in.h>
    53	#include <linux/ip.h>
    54	#include <linux/ipv6.h>
    55	#include <linux/irq.h>
    56	#include <linux/irqdomain.h>
    57	#include <linux/kthread.h>
    58	#include <linux/seq_file.h>
    59	#include <linux/interrupt.h>
    60	#include <net/net_namespace.h>
    61	#include <asm/hvcall.h>
  > 62	#include <linux/atomic.h>
    63	#include <asm/vio.h>
    64	#include <asm/xive.h>
    65	#include <asm/iommu.h>
    66	#include <linux/uaccess.h>
    67	#include <asm/firmware.h>
    68	#include <linux/workqueue.h>
    69	#include <linux/if_vlan.h>
    70	#include <linux/utsname.h>
    71	#include <linux/cpu.h>
  > 72	#include <linux/atomic.h>
    73	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

