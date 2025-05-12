Return-Path: <netdev+bounces-189911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF03AB480D
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 01:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65C207ACC1A
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 23:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E6B267B8E;
	Mon, 12 May 2025 23:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fzy50VEb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEFD3D76
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 23:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747093904; cv=none; b=QkSEv8kCr0tDUq45QttoiuiysE/YlxPRSCoMzonkFUersmRtsWly/1u4b0Jz58+tY+KYDy36bgdMOoyTSXElyNgw+5dKiR1oQXlRho4tkrTjbZ1R3FUirFNSUxIMYoHNCvMA9g1qXWCZ86QG29KYLxEGkQjYjtk+HtYOx6blWWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747093904; c=relaxed/simple;
	bh=IqIJqT9/r3q7VXTbnTvvNgbRKuvfaGBe7a2DS5Dtryk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1zPOOMUU7N6pfZJdGCXB306P1YFK7BUJMDJdFgtQtJ9/LK2J42hGgnLnSL++wpTX05X2zeVXEUSKJq1dKHT9BTNw5fmmc8FTs8gXUoTNvZJurBbpTxWquXTAOujsYxZU4gENs0inxVO3Fi9M4ZJVzNRTGl+wa6+MBApjcFKEOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fzy50VEb; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747093902; x=1778629902;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IqIJqT9/r3q7VXTbnTvvNgbRKuvfaGBe7a2DS5Dtryk=;
  b=fzy50VEbjz+ji7FWLqeYf8/FQfmeRtwiU2nvY/NG/eZHxZxify5o0g3T
   4JQSAPJUYl/AthJ8wqFN4va56INZUECPPAthHo1LP4MiyJx1bjzENug23
   1lb7/Ff927XUsbOd5a+BExXHCOdqSafHqaVn0RDzXHh6vWKkPrqxsaV1d
   n1YJpFz0Lww21VkwVO8+UtlTP8mUBjmCmDtbAHkMMks5GmZZtTLZHkxq1
   sCnmEKOKXanBVjJxVQdjVswYIqKqXFIIq/mkauWMo4TcUwwil1z68zFd1
   NUlQitvpl46HlUsRoA7qazC8Fiw/1nW8OT/RB4RR75PP7anjdWYDrCbCA
   w==;
X-CSE-ConnectionGUID: f8vLqBEuSE+ehljZi9wU8A==
X-CSE-MsgGUID: MfhkqEi7R+WE3XuKiLRV+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="59577907"
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="59577907"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 16:51:41 -0700
X-CSE-ConnectionGUID: HFRRU5VgTv+SWmmuRXM52g==
X-CSE-MsgGUID: TjrRgocHRlCAXODRgtvxuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="138039847"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 12 May 2025 16:51:36 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uEcvl-000FWp-21;
	Mon, 12 May 2025 23:51:33 +0000
Date: Tue, 13 May 2025 07:51:20 +0800
From: kernel test robot <lkp@intel.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, gakula@marvell.com,
	hkelam@marvell.com, sgoutham@marvell.com, lcherian@marvell.com,
	bbhushan2@marvell.com, jerinj@marvell.com
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Subbaraya Sundeep <sbhatta@marvell.com>
Subject: Re: [net-next PATCH 4/4] octeontx2: Add new tracepoint
 otx2_msg_status
Message-ID: <202505130701.84lzGj2T-lkp@intel.com>
References: <1747039315-3372-6-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1747039315-3372-6-git-send-email-sbhatta@marvell.com>

Hi Subbaraya,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Subbaraya-Sundeep/octeontx2-af-convert-dev_dbg-to-tracepoint-in-mbox/20250512-164344
base:   net-next/main
patch link:    https://lore.kernel.org/r/1747039315-3372-6-git-send-email-sbhatta%40marvell.com
patch subject: [net-next PATCH 4/4] octeontx2: Add new tracepoint otx2_msg_status
config: x86_64-buildonly-randconfig-002-20250513 (https://download.01.org/0day-ci/archive/20250513/202505130701.84lzGj2T-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250513/202505130701.84lzGj2T-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505130701.84lzGj2T-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/trace/trace_events.h:468,
                    from include/trace/define_trace.h:119,
                    from drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h:144,
                    from drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.c:9:
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:119:1: error: macro "__assign_str" passed 2 arguments, but takes just 1
     119 | );
         | ^~            
   In file included from include/trace/trace_events.h:400:
   include/trace/stages/stage6_event_callback.h:34: note: macro "__assign_str" defined here
      34 | #define __assign_str(dst)                                               \
         | 
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h: In function 'do_trace_event_raw_event_otx2_msg_wait_rsp':
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:115:28: error: '__assign_str' undeclared (first use in this function)
     115 |             TP_fast_assign(__assign_str(dev, pci_name(pdev))
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
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:110:1: note: in expansion of macro 'TRACE_EVENT'
     110 | TRACE_EVENT(otx2_msg_wait_rsp,
         | ^~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:115:13: note: in expansion of macro 'TP_fast_assign'
     115 |             TP_fast_assign(__assign_str(dev, pci_name(pdev))
         |             ^~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:115:28: note: each undeclared identifier is reported only once for each function it appears in
     115 |             TP_fast_assign(__assign_str(dev, pci_name(pdev))
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
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h: In function 'do_trace_event_raw_event_otx2_msg_status':
>> drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:128:28: error: unknown type name '__assign_str'
     128 |             TP_fast_assign(__assign_str(dev, pci_name(pdev))
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
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:121:1: note: in expansion of macro 'TRACE_EVENT'
     121 | TRACE_EVENT(otx2_msg_status,
         | ^~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:128:13: note: in expansion of macro 'TP_fast_assign'
     128 |             TP_fast_assign(__assign_str(dev, pci_name(pdev))
         |             ^~~~~~~~~~~~~~
>> include/trace/stages/stage6_event_callback.h:9:17: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'entry'
       9 | #define __entry entry
         |                 ^~~~~
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
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:121:1: note: in expansion of macro 'TRACE_EVENT'
     121 | TRACE_EVENT(otx2_msg_status,
         | ^~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:128:13: note: in expansion of macro 'TP_fast_assign'
     128 |             TP_fast_assign(__assign_str(dev, pci_name(pdev))
         |             ^~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:130:28: note: in expansion of macro '__entry'
     130 |                            __entry->num_msgs = num_msgs;
         |                            ^~~~~~~
   In file included from include/trace/trace_events.h:523:
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h: At top level:
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:119:1: error: macro "__assign_str" passed 2 arguments, but takes just 1
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
   In file included from include/trace/perf.h:110,
                    from include/trace/define_trace.h:120:
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:119:1: error: macro "__assign_str" passed 2 arguments, but takes just 1
     119 | );
         | ^~            
   In file included from include/trace/perf.h:7:
   include/trace/stages/stage6_event_callback.h:34: note: macro "__assign_str" defined here
      34 | #define __assign_str(dst)                                               \
         | 
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h: In function 'do_perf_trace_otx2_msg_wait_rsp':
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:115:28: error: '__assign_str' undeclared (first use in this function)
     115 |             TP_fast_assign(__assign_str(dev, pci_name(pdev))
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
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h: In function 'do_perf_trace_otx2_msg_status':
>> drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:128:28: error: unknown type name '__assign_str'
     128 |             TP_fast_assign(__assign_str(dev, pci_name(pdev))
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
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:121:1: note: in expansion of macro 'TRACE_EVENT'
     121 | TRACE_EVENT(otx2_msg_status,
         | ^~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:128:13: note: in expansion of macro 'TP_fast_assign'
     128 |             TP_fast_assign(__assign_str(dev, pci_name(pdev))
         |             ^~~~~~~~~~~~~~
>> include/trace/stages/stage6_event_callback.h:9:17: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'entry'
       9 | #define __entry entry
         |                 ^~~~~
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
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:121:1: note: in expansion of macro 'TRACE_EVENT'
     121 | TRACE_EVENT(otx2_msg_status,
         | ^~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:128:13: note: in expansion of macro 'TP_fast_assign'
     128 |             TP_fast_assign(__assign_str(dev, pci_name(pdev))
         |             ^~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:130:28: note: in expansion of macro '__entry'
     130 |                            __entry->num_msgs = num_msgs;
         |                            ^~~~~~~
   In file included from include/trace/bpf_probe.h:131,
                    from include/trace/define_trace.h:121:
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h: At top level:
   drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h:119:1: error: macro "__assign_str" passed 2 arguments, but takes just 1
     119 | );
         | ^~            
   In file included from include/trace/bpf_probe.h:7:
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


vim +/__assign_str +128 drivers/net/ethernet/marvell/octeontx2/af/./rvu_trace.h

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
   134	);
   135	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

