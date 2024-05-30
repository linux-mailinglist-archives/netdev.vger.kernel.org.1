Return-Path: <netdev+bounces-99551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E33338D5407
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 22:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 102131C20CBF
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 20:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1BE17F4E0;
	Thu, 30 May 2024 20:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QXEw0bN7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700E317E442;
	Thu, 30 May 2024 20:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717102302; cv=none; b=FTXvrUuQg93Dksd0taOyGDEvwjcdGuUJ76izrkFNfXoqFgGodhQoH/bjAYVWRHWp+e5GUZuCbZBuNTWexH5vYg8+faLx4gkOLq2+Q9eB5SKko0Vz/koVubu6HFF4oiJwZK6BMphaMF5nfxqX8kyfLIk4695i3/gW4FwcR5A8Tzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717102302; c=relaxed/simple;
	bh=RAYBy0qHJIwdJxwWflZaAKdWrjsSMABWj1ElC/ICSCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2yim/ZhYlizPPqyhqxdUmxrlbJiulV2083RriWouEO59UJ6t66ujBsFoSOejhM09g0t6UTI+GhfdG3HX57tDu0EY5s90xwIUcJHhn/IgotlbaEuj1MGYHHUrNY81u2nK9HRCFH7OcCShxniq8tiH/mJ94K8sFZd1pObCqBCX3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QXEw0bN7; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717102299; x=1748638299;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RAYBy0qHJIwdJxwWflZaAKdWrjsSMABWj1ElC/ICSCM=;
  b=QXEw0bN7N26U/Cg245eKuzTMDwFxidyQGF/I/FEKso9JAVasQjZtYyl4
   IbFsuKFALsZJn+rbnWryV4199NP6GnOQaQoQw+cm5cNVromyt86aEKvn6
   eH1mLSrzCkTHH6hfRjw4D446g3lMP+nqOTC3nSrVKdj1N0fjG+YEuY87X
   yqY2LNWq0wniVPoi2jJgw+id4w+v4cz1EIksu+ru3jz+Wrk1OBzd2bbb2
   CQ1tGT8vxqeIKqiAnsKNHxfGFcpLp0HYPDPW6wzft3+05/wSbU7D0NwHl
   iSKQ4zwk7iQ3CYizovBgvk2X2CK6ZWEePEKelogJ2Mk2i75ndPdbAAnUf
   Q==;
X-CSE-ConnectionGUID: RaBdZ+S0Th2cfIbwWPdsqw==
X-CSE-MsgGUID: Yo927A+LSXm4RBIYAQAs3Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="31114957"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="31114957"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 13:51:39 -0700
X-CSE-ConnectionGUID: nQeAQxXuQx2BCT4H/y9BJg==
X-CSE-MsgGUID: M5ftgt0KTsqUxFvQd8Cvlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="35869134"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 30 May 2024 13:51:35 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sCmkH-000Fxh-00;
	Thu, 30 May 2024 20:51:33 +0000
Date: Fri, 31 May 2024 04:51:27 +0800
From: kernel test robot <lkp@intel.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Subbaraya Sundeep <sbhatta@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [net-next PATCH] octeontx2: Improve mailbox tracepoints for
 debugging
Message-ID: <202405310425.kxMtnCmV-lkp@intel.com>
References: <1717070038-18381-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1717070038-18381-1-git-send-email-sbhatta@marvell.com>

Hi Subbaraya,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Subbaraya-Sundeep/octeontx2-Improve-mailbox-tracepoints-for-debugging/20240530-195537
base:   net-next/main
patch link:    https://lore.kernel.org/r/1717070038-18381-1-git-send-email-sbhatta%40marvell.com
patch subject: [net-next PATCH] octeontx2: Improve mailbox tracepoints for debugging
config: um-allyesconfig (https://download.01.org/0day-ci/archive/20240531/202405310425.kxMtnCmV-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240531/202405310425.kxMtnCmV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405310425.kxMtnCmV-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/trace/trace_events.h:419,
                    from include/trace/define_trace.h:102,
                    from drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h:144,
                    from drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.c:9:
>> drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:119:1: error: macro "__assign_str" passed 2 arguments, but takes just 1
     119 | );
         | ^~            
   In file included from include/trace/trace_events.h:375:
   include/trace/stages/stage6_event_callback.h:34: note: macro "__assign_str" defined here
      34 | #define __assign_str(dst)                                               \
         | 
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h: In function 'trace_event_raw_event_otx2_msg_wait_rsp':
>> drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:115:28: error: '__assign_str' undeclared (first use in this function)
     115 |             TP_fast_assign(__assign_str(dev, pci_name(pdev))
         |                            ^~~~~~~~~~~~
   include/trace/trace_events.h:402:11: note: in definition of macro 'DECLARE_EVENT_CLASS'
     402 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:110:1: note: in expansion of macro 'TRACE_EVENT'
     110 | TRACE_EVENT(otx2_msg_wait_rsp,
         | ^~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:115:13: note: in expansion of macro 'TP_fast_assign'
     115 |             TP_fast_assign(__assign_str(dev, pci_name(pdev))
         |             ^~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:115:28: note: each undeclared identifier is reported only once for each function it appears in
     115 |             TP_fast_assign(__assign_str(dev, pci_name(pdev))
         |                            ^~~~~~~~~~~~
   include/trace/trace_events.h:402:11: note: in definition of macro 'DECLARE_EVENT_CLASS'
     402 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:110:1: note: in expansion of macro 'TRACE_EVENT'
     110 | TRACE_EVENT(otx2_msg_wait_rsp,
         | ^~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:115:13: note: in expansion of macro 'TP_fast_assign'
     115 |             TP_fast_assign(__assign_str(dev, pci_name(pdev))
         |             ^~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h: At top level:
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:134:1: error: macro "__assign_str" passed 2 arguments, but takes just 1
     134 | );
         | ^~            
   include/trace/stages/stage6_event_callback.h:34: note: macro "__assign_str" defined here
      34 | #define __assign_str(dst)                                               \
         | 
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:134:1: error: macro "__assign_str" passed 2 arguments, but takes just 1
     134 | );
         | ^~            
   include/trace/stages/stage6_event_callback.h:34: note: macro "__assign_str" defined here
      34 | #define __assign_str(dst)                                               \
         | 
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h: In function 'trace_event_raw_event_otx2_msg_status':
>> drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:128:28: error: unknown type name '__assign_str'
     128 |             TP_fast_assign(__assign_str(dev, pci_name(pdev))
         |                            ^~~~~~~~~~~~
   include/trace/trace_events.h:402:11: note: in definition of macro 'DECLARE_EVENT_CLASS'
     402 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:121:1: note: in expansion of macro 'TRACE_EVENT'
     121 | TRACE_EVENT(otx2_msg_status,
         | ^~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:128:13: note: in expansion of macro 'TP_fast_assign'
     128 |             TP_fast_assign(__assign_str(dev, pci_name(pdev))
         |             ^~~~~~~~~~~~~~
>> include/trace/stages/stage6_event_callback.h:9:17: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'entry'
       9 | #define __entry entry
         |                 ^~~~~
   include/trace/trace_events.h:402:11: note: in definition of macro 'DECLARE_EVENT_CLASS'
     402 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:121:1: note: in expansion of macro 'TRACE_EVENT'
     121 | TRACE_EVENT(otx2_msg_status,
         | ^~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:128:13: note: in expansion of macro 'TP_fast_assign'
     128 |             TP_fast_assign(__assign_str(dev, pci_name(pdev))
         |             ^~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:130:28: note: in expansion of macro '__entry'
     130 |                            __entry->num_msgs = num_msgs;
         |                            ^~~~~~~
   In file included from include/trace/trace_events.h:469:
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h: At top level:
>> drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:119:1: error: macro "__assign_str" passed 2 arguments, but takes just 1
     119 | );
         | ^~            
   include/trace/stages/stage6_event_callback.h:34: note: macro "__assign_str" defined here
      34 | #define __assign_str(dst)                                               \
         | 
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:134:1: error: macro "__assign_str" passed 2 arguments, but takes just 1
     134 | );
         | ^~            
   include/trace/stages/stage6_event_callback.h:34: note: macro "__assign_str" defined here
      34 | #define __assign_str(dst)                                               \
         | 
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:134:1: error: macro "__assign_str" passed 2 arguments, but takes just 1
     134 | );
         | ^~            
   include/trace/stages/stage6_event_callback.h:34: note: macro "__assign_str" defined here
      34 | #define __assign_str(dst)                                               \
         | 


vim +/__assign_str +119 drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h

   109	
   110	TRACE_EVENT(otx2_msg_wait_rsp,
   111		    TP_PROTO(const struct pci_dev *pdev),
   112		    TP_ARGS(pdev),
   113		    TP_STRUCT__entry(__string(dev, pci_name(pdev))
   114		    ),
 > 115		    TP_fast_assign(__assign_str(dev, pci_name(pdev))
   116		    ),
   117		    TP_printk("[%s] timed out while waiting for response\n",
   118			      __get_str(dev))
 > 119	);
   120	
   121	TRACE_EVENT(otx2_msg_status,
   122		    TP_PROTO(const struct pci_dev *pdev, const char *msg, u16 num_msgs),
   123		    TP_ARGS(pdev, msg, num_msgs),
   124		    TP_STRUCT__entry(__string(dev, pci_name(pdev))
   125				     __string(str, msg)
   126				     __field(u16, num_msgs)
   127		    ),
 > 128		    TP_fast_assign(__assign_str(dev, pci_name(pdev))
   129				   __assign_str(str, msg)
   130				   __entry->num_msgs = num_msgs;
   131		    ),
   132		    TP_printk("[%s] %s num_msgs:%d\n", __get_str(dev),
   133			      __get_str(str), __entry->num_msgs)
 > 134	);
   135	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

