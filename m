Return-Path: <netdev+bounces-137106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D47F09A463A
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 20:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 029B31C23FB5
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 18:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA1B205148;
	Fri, 18 Oct 2024 18:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QVZn3ssY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CA520492A
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729277166; cv=none; b=IbX0LDimYQMVbEXvHmP9D07RgwIqUeTohNwpu3jZel5SaJ8W78H1QRn6enlVvhLlAY6Gu7IFA+Uj+ySIXlAVrw5/Ht+2uQaKQVhhQxkicY+v9odIuyCH4C6D/FUHPXr02eVbSJE/GliLl3GUrPsO+v0DC3A4JhPNabfUZAQoMJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729277166; c=relaxed/simple;
	bh=hhnA/YPn+ZYS6jHFvDtwSH23zI1zQIo3jP9zrP6+kWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMEGO2C5h99yxTYxEZlrA5/EMBhqbSipAlNKOje5KW205FTm6RHtFmjjyLSSFkzY8JEo3zFAEZXfj1CGI99hn3xYhIFH2jvjKbzupb9/0Z5O9ZcZ45GLn5s8PIY7U5RaenmC0lWADohzig06iO8PS+474W2YvQuOiSfhLtL1nmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QVZn3ssY; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729277165; x=1760813165;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hhnA/YPn+ZYS6jHFvDtwSH23zI1zQIo3jP9zrP6+kWo=;
  b=QVZn3ssYCHz1fC8Fok6fJpfjTKeMLcPbQP4xFplnMpnoK80TICvTWFbD
   Gxh1WNxf99HYrGu/vYDs9xJg6HgQYmWqIAqWgB4gMyJz+bsvqS3QA/xCu
   /Dy323jTC/alM3Tnzvf7h5F+eM/upPoL5HzRG9hyTveb/4pGX3tw9HHmt
   X7G9XdpMKblRXmvzgGvirECC6LsgNxk7L0TovnxodObwLGiEdjMv6ytST
   IYQ4ChOhO5o/tvATKeAZiZS3kmndqRgIro+bdKBKIJyTYjlxsVIsbSXOv
   ICngLtNPQQ2A/dcNK/CPJVCV4erIxU0ETL8Nw4x3oCTsBHjyEaMYA2Ne3
   w==;
X-CSE-ConnectionGUID: RGf1K4qESZylz6JV6BwnjA==
X-CSE-MsgGUID: VrSvoaN/QZaDRomd45Pcvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="40182411"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="40182411"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 11:46:02 -0700
X-CSE-ConnectionGUID: rTaJe69eTFeoS9dDHVIEqw==
X-CSE-MsgGUID: aF8o4rsESfiI8g3cWEwhag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="83571245"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 18 Oct 2024 11:45:57 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1rz1-000OBl-1s;
	Fri, 18 Oct 2024 18:45:55 +0000
Date: Sat, 19 Oct 2024 02:45:03 +0800
From: kernel test robot <lkp@intel.com>
To: chia-yu.chang@nokia-bell-labs.com, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, dsahern@kernel.org, ij@kernel.org,
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Olga Albisser <olga@albisser.org>,
	Olivier Tilmans <olivier.tilmans@nokia.com>,
	Henrik Steen <henrist@henrist.net>,
	Bob Briscoe <research@bobbriscoe.net>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: Re: [PATCH net-next 1/1] sched: Add dualpi2 qdisc
Message-ID: <202410190238.xwFjIctf-lkp@intel.com>
References: <20241018021004.39258-2-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018021004.39258-2-chia-yu.chang@nokia-bell-labs.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/chia-yu-chang-nokia-bell-labs-com/sched-Add-dualpi2-qdisc/20241018-101154
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241018021004.39258-2-chia-yu.chang%40nokia-bell-labs.com
patch subject: [PATCH net-next 1/1] sched: Add dualpi2 qdisc
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20241019/202410190238.xwFjIctf-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241019/202410190238.xwFjIctf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410190238.xwFjIctf-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/sched/sch_dualpi2.c:536:12: error: call to undeclared function 'skb_sojourn_time'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     536 |                 qdelay = skb_sojourn_time(skb, now);
         |                          ^
   1 error generated.


vim +/skb_sojourn_time +536 net/sched/sch_dualpi2.c

   527	
   528	static int do_step_aqm(struct dualpi2_sched_data *q, struct sk_buff *skb,
   529			       u64 now)
   530	{
   531		u64 qdelay = 0;
   532	
   533		if (q->step.in_packets)
   534			qdelay = qdisc_qlen(q->l_queue);
   535		else
 > 536			qdelay = skb_sojourn_time(skb, now);
   537	
   538		if (dualpi2_skb_cb(skb)->apply_step && qdelay > q->step.thresh) {
   539			if (!dualpi2_skb_cb(skb)->ect)
   540				/* Drop this non-ECT packet */
   541				return 1;
   542			if (dualpi2_mark(q, skb))
   543				++q->step_marks;
   544		}
   545		qdisc_bstats_update(q->l_queue, skb);
   546		return 0;
   547	}
   548	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

