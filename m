Return-Path: <netdev+bounces-137105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 130DD9A4639
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 20:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FF7C285ECA
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 18:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B922040BF;
	Fri, 18 Oct 2024 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CdvKEb33"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E3A188CB1
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 18:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729277164; cv=none; b=Biem2GMfR74UnxB6c27awtzeMnMDHp2dPhDPMNtm+Fy3/meW701V4r1nul0jtSXvGdt80Ih9ZOz4cUkf58IGm/Fulrg/HUmnY6VCkuW4m8ThtIBrplohiD5YzvtVVxVzZocaFMTNl/I1s+IGMnpVlkDTmAa4NHzQyTCMUQOb/CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729277164; c=relaxed/simple;
	bh=tLeYRCWa9L/6iyxy4OLStSv4/M5ukCDBxY+KRLJwt6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5WtCuwwMgEM0nSEshWpamrUeQLvK8W82K+tDi/vJP2Rzx5IZE4azjgEUUflAm2Jb+kchvOtnCUIVSQv6HWfEXnCWtsMBxC9JkfvOb0A55zCuYl3Y9knNNya23brK468KPly47zAMVJoSdC7zov/wsqz79QfHO1rTOG+WVm8djM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CdvKEb33; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729277163; x=1760813163;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tLeYRCWa9L/6iyxy4OLStSv4/M5ukCDBxY+KRLJwt6g=;
  b=CdvKEb33ysTPP0m8pMlU1a6gUHGPBtzhM/TKBlgDabhENSwNvmt7mkgX
   v+EXgIwnDJL1nwLMenuHwmhomcdlcveNcFD96XE5rdqguVpKSA8IF3NS5
   O/0toi8GSArmGHVl3f31J4bsDWVm9VrVEFSpYpHAjTNgOBo4StNjqEUcB
   jomsoYTn1ahe+j11cV3zlO4/V8+kBmwkQhgdL6V9Tc6q+8nY8cQXHIdM3
   glfPkpzC6ICEYQJrTn8K+tjIxnL00yo67r0QjkDChg27RWSNIImqJ7CfJ
   MwWbOTzkopXbpb6LLsYWrXs3CPmNa4Rv19cNEoUpPk1FsvEebXKDNqNbz
   A==;
X-CSE-ConnectionGUID: OqptK2BNTJ+fofWqAUy6jg==
X-CSE-MsgGUID: tNb9jYtJRYe90WWVtJ1BpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="40182407"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="40182407"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 11:46:02 -0700
X-CSE-ConnectionGUID: 6bnIdJmMQRSdLF9/9FpVXw==
X-CSE-MsgGUID: iLOctQrSRfyVw+jVMEnDfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="83571248"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 18 Oct 2024 11:45:57 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1rz1-000OBr-2H;
	Fri, 18 Oct 2024 18:45:55 +0000
Date: Sat, 19 Oct 2024 02:45:02 +0800
From: kernel test robot <lkp@intel.com>
To: chia-yu.chang@nokia-bell-labs.com, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, dsahern@kernel.org, ij@kernel.org,
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: oe-kbuild-all@lists.linux.dev, Olga Albisser <olga@albisser.org>,
	Olivier Tilmans <olivier.tilmans@nokia.com>,
	Henrik Steen <henrist@henrist.net>,
	Bob Briscoe <research@bobbriscoe.net>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: Re: [PATCH net-next 1/1] sched: Add dualpi2 qdisc
Message-ID: <202410190244.B6vVJG3M-lkp@intel.com>
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
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20241019/202410190244.B6vVJG3M-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241019/202410190244.B6vVJG3M-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410190244.B6vVJG3M-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   net/sched/sch_dualpi2.c: In function 'do_step_aqm':
>> net/sched/sch_dualpi2.c:536:26: error: implicit declaration of function 'skb_sojourn_time'; did you mean 'dualpi2_sojourn_time'? [-Werror=implicit-function-declaration]
     536 |                 qdelay = skb_sojourn_time(skb, now);
         |                          ^~~~~~~~~~~~~~~~
         |                          dualpi2_sojourn_time
   net/sched/sch_dualpi2.c: At top level:
>> net/sched/sch_dualpi2.c:138:12: warning: 'dualpi2_sojourn_time' defined but not used [-Wunused-function]
     138 | static u64 dualpi2_sojourn_time(struct sk_buff *skb, u64 reference)
         |            ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +536 net/sched/sch_dualpi2.c

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

