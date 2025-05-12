Return-Path: <netdev+bounces-189903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 331E6AB4744
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 00:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1FA18666DC
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 22:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943D5299AA4;
	Mon, 12 May 2025 22:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mp/R6WwI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9305F299A9E
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 22:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747088973; cv=none; b=qboNMmPYfvUUOzxKiHLupLhXu4ls9TYx8eMNuEGomslDxHgekuICP6NQOZS+tt3gzgkjhgKPt6qtxMdyZ2YlQ5eIsbPqrYIiHD3+x77GdyDjBxRyPU2mSwskwEkGUgRjPeIeiBfTPmF7yi5Ug1Uu6/sWPEUFS9hz85DY5/b50no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747088973; c=relaxed/simple;
	bh=UYnsx35SJPIChz1+v6IDNAfUfXIRBIZvZZkqMS+2QdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bcbQm6LZP+6DFDNbwl9shN8cXE+dtKq8RNj1sjXHETCZ1rYrC6HHjqvAVFsmBgRCnITa2DhUeV6TRuZgbPVJ4QDrxMszUik1nVc2TsWwjdfcqjRVyJ7G7R78ZRSmMCs6vz9ECE+BsdA7tIuoVAGl2ig6oWqm3ucfgXyO/OnGx80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mp/R6WwI; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747088972; x=1778624972;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UYnsx35SJPIChz1+v6IDNAfUfXIRBIZvZZkqMS+2QdY=;
  b=Mp/R6WwIpXDwASBRAmEpGS/iHr6xSfR/IsSOYbX/emZQTmlXd/ZfS8eM
   Acm3tMtYMonJKUMml+6v/lK46TYFjzbHW+YNka6Ms/dyLG+LI9ZdFEh6E
   nL4TI2iRqhtJfhVUFLnRhyp4AXQz4zwPtPf+Q/V0VxKdl/yXT2MusE+RO
   0rfTv+vdaq6STJ6EF1Y/DkXpBYOFSBWUmE9vnz8W3AjNs1CRvKi81gY2f
   cdYz7FfeKZT6eEezEL/XdaYIZDjdylv+yW8871wVtt0Z99j+PliWTdcIe
   WBmhfd5YTcOcS6aeYNO43AwbFixVgI96RbE5W6q1URO4xakHf+EIwM9jo
   w==;
X-CSE-ConnectionGUID: cgK99CcOTymzy0Zw4QJq1g==
X-CSE-MsgGUID: WuEZbq0vSRu51x+I8yXl1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="66319467"
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="66319467"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 15:29:31 -0700
X-CSE-ConnectionGUID: SmM1cDKYQMeU8rWYeta64g==
X-CSE-MsgGUID: ffWN8QLaTBiYG0emoBVCvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="137353953"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 12 May 2025 15:29:28 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uEbeH-000FUJ-0s;
	Mon, 12 May 2025 22:29:25 +0000
Date: Tue, 13 May 2025 06:29:03 +0800
From: kernel test robot <lkp@intel.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, gakula@marvell.com,
	hkelam@marvell.com, sgoutham@marvell.com, lcherian@marvell.com,
	bbhushan2@marvell.com, jerinj@marvell.com
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Subbaraya Sundeep <sbhatta@marvell.com>
Subject: Re: [net-next PATCH 1/4] octeontx2-af: convert dev_dbg to tracepoint
 in mbox
Message-ID: <202505130631.KZgI1tZ3-lkp@intel.com>
References: <1747039315-3372-2-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1747039315-3372-2-git-send-email-sbhatta@marvell.com>

Hi Subbaraya,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Subbaraya-Sundeep/octeontx2-af-convert-dev_dbg-to-tracepoint-in-mbox/20250512-164344
base:   net-next/main
patch link:    https://lore.kernel.org/r/1747039315-3372-2-git-send-email-sbhatta%40marvell.com
patch subject: [net-next PATCH 1/4] octeontx2-af: convert dev_dbg to tracepoint in mbox
config: x86_64-buildonly-randconfig-002-20250513 (https://download.01.org/0day-ci/archive/20250513/202505130631.KZgI1tZ3-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250513/202505130631.KZgI1tZ3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505130631.KZgI1tZ3-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/trace/trace_events.h:468,
                    from include/trace/define_trace.h:119,
                    from drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h:117,
                    from drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.c:9:
>> drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:107:1: error: macro "__assign_str" passed 2 arguments, but takes just 1
     107 | );
         | ^~            
   In file included from include/trace/trace_events.h:400:
   include/trace/stages/stage6_event_callback.h:34: note: macro "__assign_str" defined here
      34 | #define __assign_str(dst)                                               \
         | 
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h: In function 'do_trace_event_raw_event_otx2_msg_wait_rsp':
>> drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:103:28: error: '__assign_str' undeclared (first use in this function)
     103 |             TP_fast_assign(__assign_str(dev, pci_name(pdev))
         |                            ^~~~~~~~~~~~
   include/trace/trace_events.h:427:11: note: in definition of macro '__DECLARE_EVENT_CLASS'
     427 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/trace_events.h:435:23: note: in expansion of macro 'PARAMS'
     435 |                       PARAMS(assign), PARAMS(print))                    \
         |                       ^~~~~~
   include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLARE_EVENT_CLASS'
      40 |         DECLARE_EVENT_CLASS(name,                              \
         |         ^~~~~~~~~~~~~~~~~~~
   include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:98:1: note: in expansion of macro 'TRACE_EVENT'
      98 | TRACE_EVENT(otx2_msg_wait_rsp,
         | ^~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:103:13: note: in expansion of macro 'TP_fast_assign'
     103 |             TP_fast_assign(__assign_str(dev, pci_name(pdev))
         |             ^~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:103:28: note: each undeclared identifier is reported only once for each function it appears in
     103 |             TP_fast_assign(__assign_str(dev, pci_name(pdev))
         |                            ^~~~~~~~~~~~
   include/trace/trace_events.h:427:11: note: in definition of macro '__DECLARE_EVENT_CLASS'
     427 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/trace_events.h:435:23: note: in expansion of macro 'PARAMS'
     435 |                       PARAMS(assign), PARAMS(print))                    \
         |                       ^~~~~~
   include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLARE_EVENT_CLASS'
      40 |         DECLARE_EVENT_CLASS(name,                              \
         |         ^~~~~~~~~~~~~~~~~~~
   include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:98:1: note: in expansion of macro 'TRACE_EVENT'
      98 | TRACE_EVENT(otx2_msg_wait_rsp,
         | ^~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:103:13: note: in expansion of macro 'TP_fast_assign'
     103 |             TP_fast_assign(__assign_str(dev, pci_name(pdev))
         |             ^~~~~~~~~~~~~~
   In file included from include/trace/trace_events.h:523:
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h: At top level:
>> drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:107:1: error: macro "__assign_str" passed 2 arguments, but takes just 1
     107 | );
         | ^~            
   include/trace/stages/stage6_event_callback.h:34: note: macro "__assign_str" defined here
      34 | #define __assign_str(dst)                                               \
         | 
   In file included from include/trace/perf.h:110,
                    from include/trace/define_trace.h:120:
>> drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:107:1: error: macro "__assign_str" passed 2 arguments, but takes just 1
     107 | );
         | ^~            
   In file included from include/trace/perf.h:7:
   include/trace/stages/stage6_event_callback.h:34: note: macro "__assign_str" defined here
      34 | #define __assign_str(dst)                                               \
         | 
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h: In function 'do_perf_trace_otx2_msg_wait_rsp':
>> drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:103:28: error: '__assign_str' undeclared (first use in this function)
     103 |             TP_fast_assign(__assign_str(dev, pci_name(pdev))
         |                            ^~~~~~~~~~~~
   include/trace/perf.h:51:11: note: in definition of macro '__DECLARE_EVENT_CLASS'
      51 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/perf.h:67:23: note: in expansion of macro 'PARAMS'
      67 |                       PARAMS(assign), PARAMS(print))                    \
         |                       ^~~~~~
   include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLARE_EVENT_CLASS'
      40 |         DECLARE_EVENT_CLASS(name,                              \
         |         ^~~~~~~~~~~~~~~~~~~
   include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:98:1: note: in expansion of macro 'TRACE_EVENT'
      98 | TRACE_EVENT(otx2_msg_wait_rsp,
         | ^~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:103:13: note: in expansion of macro 'TP_fast_assign'
     103 |             TP_fast_assign(__assign_str(dev, pci_name(pdev))
         |             ^~~~~~~~~~~~~~
   In file included from include/trace/bpf_probe.h:131,
                    from include/trace/define_trace.h:121:
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h: At top level:
>> drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:107:1: error: macro "__assign_str" passed 2 arguments, but takes just 1
     107 | );
         | ^~            
   In file included from include/trace/bpf_probe.h:7:
   include/trace/stages/stage6_event_callback.h:34: note: macro "__assign_str" defined here
      34 | #define __assign_str(dst)                                               \
         | 


vim +/__assign_str +107 drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h

    97	
    98	TRACE_EVENT(otx2_msg_wait_rsp,
    99		    TP_PROTO(const struct pci_dev *pdev),
   100		    TP_ARGS(pdev),
   101		    TP_STRUCT__entry(__string(dev, pci_name(pdev))
   102		    ),
 > 103		    TP_fast_assign(__assign_str(dev, pci_name(pdev))
   104		    ),
   105		    TP_printk("[%s] timed out while waiting for response\n",
   106			      __get_str(dev))
 > 107	);
   108	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

