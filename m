Return-Path: <netdev+bounces-96670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D508C70AE
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 05:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E99D1F2274F
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 03:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758684411;
	Thu, 16 May 2024 03:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I+bmX6qu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA87523A6;
	Thu, 16 May 2024 03:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715830291; cv=none; b=BHQ1YjUSJ2YOphpsnn9rSUfM+ZswvXH+SFftcxfgEIxl6POidzhLk7aJ5ujoOjt7/dp0Cx2z66qZkCDX2wd2haQYONelebxEozcjS6ipkqTkXScXKq0QIZ4mcjvizGI1xXruyhJ/q0YPhm8H0Ql3WT8Dsu0XOy6bwisbvHpjmGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715830291; c=relaxed/simple;
	bh=6nIFCyTBysDjoWLfPU6KU5s1MlTbkpP/5bwNBnLHUxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuZ+ToWJJg7y6nOG8mOcb/aeGjkIAUzEoFWylYDce71xKYlnEc5gD1TR4KMg0KgcR8pQFtZsRixkruF7RvaCVg7plwQb+7B7yL5kTqMhYH7o4s1nVvPpU5Ih+gS4p8m6XcEpeANb6cRC4aP4p4x5Pg0rm+oFysmwGkU4REiqbOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I+bmX6qu; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715830290; x=1747366290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6nIFCyTBysDjoWLfPU6KU5s1MlTbkpP/5bwNBnLHUxw=;
  b=I+bmX6quc3YUH9Ntn0NHwkv8Fok9o6K/6DfbY6308BXUXLC98HrKidTa
   DDcWTIJxTt8YsLZMG6RS+3UPdcQwdZlNF4LgW1V9OmyrvmRbBD9u9rylg
   nsPArq9KAQ66VDyvwQg4LapPJrOjSJmo6CJaqv0IlFZqYPrHllpWPbGrI
   VT5lbv5h2qGo6G2mMK2O7MctFWckjO93FCqtlLU9Y2VcETX3Jg6Q7lqxl
   BhJWUz96D+qmWDyX3vsLBFMtLITTp3vSRRgs4QpmlOLhWXebz1k4Ictev
   KZulfv9jtXaxhOH1JBkv7XKEbh6lcXI5TZtl+sPsyvrYDhLlG325dsLDE
   w==;
X-CSE-ConnectionGUID: Fn8U16i9TlSGqouH9j4GZw==
X-CSE-MsgGUID: 3UVcfwqEQpmawZyFM00LeA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="15744027"
X-IronPort-AV: E=Sophos;i="6.08,163,1712646000"; 
   d="scan'208";a="15744027"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 20:31:29 -0700
X-CSE-ConnectionGUID: 1v3OYIM+SeapcY81BgdmRg==
X-CSE-MsgGUID: frZcW+IsRWGRidxMfJAYKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,163,1712646000"; 
   d="scan'208";a="62119217"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 15 May 2024 20:31:27 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s7Rq0-000DZo-2b;
	Thu, 16 May 2024 03:31:24 +0000
Date: Thu, 16 May 2024 11:31:20 +0800
From: kernel test robot <lkp@intel.com>
To: Ronak Doshi <ronak.doshi@broadcom.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Ronak Doshi <ronak.doshi@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/4] vmxnet3: add latency measurement support in
 vmxnet3
Message-ID: <202405161123.iWtQjhIw-lkp@intel.com>
References: <20240514182050.20931-3-ronak.doshi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514182050.20931-3-ronak.doshi@broadcom.com>

Hi Ronak,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Ronak-Doshi/vmxnet3-prepare-for-version-9-changes/20240515-023833
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240514182050.20931-3-ronak.doshi%40broadcom.com
patch subject: [PATCH net-next 2/4] vmxnet3: add latency measurement support in vmxnet3
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20240516/202405161123.iWtQjhIw-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240516/202405161123.iWtQjhIw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405161123.iWtQjhIw-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In function 'vmxnet3_get_cycles',
       inlined from 'vmxnet3_rq_rx_complete' at drivers/net/vmxnet3/vmxnet3_drv.c:1675:25:
>> drivers/net/vmxnet3/vmxnet3_drv.c:151:9: warning: 'asm' operand 2 probably does not match constraints
     151 |         asm volatile("rdpmc" : "=a" (low), "=d" (high) : "c" (pmc));
         |         ^~~
   drivers/net/vmxnet3/vmxnet3_drv.c:151:9: error: impossible constraint in 'asm'
   In function 'vmxnet3_get_cycles',
       inlined from 'vmxnet3_tq_xmit.isra' at drivers/net/vmxnet3/vmxnet3_drv.c:1316:28:
>> drivers/net/vmxnet3/vmxnet3_drv.c:151:9: warning: 'asm' operand 2 probably does not match constraints
     151 |         asm volatile("rdpmc" : "=a" (low), "=d" (high) : "c" (pmc));
         |         ^~~


vim +/asm +151 drivers/net/vmxnet3/vmxnet3_drv.c

   145	
   146	static u64
   147	vmxnet3_get_cycles(int pmc)
   148	{
   149		u32 low, high;
   150	
 > 151		asm volatile("rdpmc" : "=a" (low), "=d" (high) : "c" (pmc));
   152		return (low | ((u_int64_t)high << 32));
   153	}
   154	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

