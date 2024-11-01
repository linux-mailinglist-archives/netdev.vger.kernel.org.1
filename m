Return-Path: <netdev+bounces-141049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCA79B941E
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 16:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C24871C20C05
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 15:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6659C1ADFF9;
	Fri,  1 Nov 2024 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MzDuuTgo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DF724B34
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 15:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730474089; cv=none; b=EviOVsXGfdICJ4wlsuQT18SoHHAo2QoNQQ1UUDig8F1Ra9oPTGwsN2d1GF26vwjNISZLJv6eh6JOkbZCJ5KsmjDxxBrFc52Ka9/4bw3BCQGkSt93UhOdpsZvp1DYYz42Ccafo5rTod3+/ysKMJttZHr248N5MCT4OneVr3FWOmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730474089; c=relaxed/simple;
	bh=F1Upgo6KcOgyL4gO865PbZ6gPG0AyykfKj2c05R7ts0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5UY5E3O9eGxeQ0J1SKcGZKhBtMuAMS+sS74HevumUi4lFUwWZpswHCJ1azOyIVjAlpCFDZYRcpNZSDHbVGt5oOa4jUGMGVYZE5aOAN6j/JSGfrR6m7yuyTtTl4F0ES0cAbVA2AxMhsUR8vUfm807IBWQMhhOUC/O4MfSea7wXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MzDuuTgo; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730474086; x=1762010086;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F1Upgo6KcOgyL4gO865PbZ6gPG0AyykfKj2c05R7ts0=;
  b=MzDuuTgoiBElexjPYWvrGiz6ph8Gw5frUPEiTgQzIwFUDhVkDqsl8Ohl
   fKGwK88vB+lNH4iMZpN1kHYhQpUnbKbrhRR4YXcASWuX9bbj0FHY5Fy6V
   2p+WJQSL5lvCwJMcWHFcYis06UKS5vZfE0zqmGl0JBR/UtNPxi7OZKdzz
   BILN7bVkcSZ10aafzWLEpMFRn1J4kTQB6CdA2OymZaWnwbIBA7AhJvCfw
   QdfGI5aNUlwZB6VhJ7vW5CIge3wuXsfqf3387Cv9EuPKyqSopZ4sDA6VQ
   sjin+ezC93HWfL+nFOVQWN+513nwad8z4mfLn1EnRbPtjvkwo0az2IojE
   w==;
X-CSE-ConnectionGUID: Ke9iY7GSSbue/OBLE/UuJw==
X-CSE-MsgGUID: xgdxezA3RimlOXP8dYa/Ug==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="34175638"
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="34175638"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 08:14:46 -0700
X-CSE-ConnectionGUID: 2fVJsjMIRQGKeO9S2iTnEw==
X-CSE-MsgGUID: xlHn9e2SQ/asWQ+d7LJHVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="113768622"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 01 Nov 2024 08:14:44 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6tMI-000hgs-0J;
	Fri, 01 Nov 2024 15:14:42 +0000
Date: Fri, 1 Nov 2024 23:14:19 +0800
From: kernel test robot <lkp@intel.com>
To: Anna Emese Nyiri <annaemesenyiri@gmail.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, fejes@inf.elte.hu,
	annaemesenyiri@gmail.com
Subject: Re: [PATCH net-next] support SO_PRIORITY cmsg
Message-ID: <202411012324.a9SOqSqV-lkp@intel.com>
References: <20241029144142.31382-1-annaemesenyiri@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029144142.31382-1-annaemesenyiri@gmail.com>

Hi Anna,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mkl-can-next/testing]
[also build test WARNING on linus/master v6.12-rc5]
[cannot apply to net-next/main horms-ipvs/master next-20241101]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anna-Emese-Nyiri/support-SO_PRIORITY-cmsg/20241029-224326
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git testing
patch link:    https://lore.kernel.org/r/20241029144142.31382-1-annaemesenyiri%40gmail.com
patch subject: [PATCH net-next] support SO_PRIORITY cmsg
config: i386-randconfig-141-20241101 (https://download.01.org/0day-ci/archive/20241101/202411012324.a9SOqSqV-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411012324.a9SOqSqV-lkp@intel.com/

smatch warnings:
net/core/sock.c:2870 __sock_cmsg_send() warn: always true condition '(*(cmsg + 12) >= 0) => (0-u32max >= 0)'

vim +2870 net/core/sock.c

  2828	
  2829	int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
  2830			     struct sockcm_cookie *sockc)
  2831	{
  2832		u32 tsflags;
  2833	
  2834		switch (cmsg->cmsg_type) {
  2835		case SO_MARK:
  2836			if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) &&
  2837			    !ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
  2838				return -EPERM;
  2839			if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
  2840				return -EINVAL;
  2841			sockc->mark = *(u32 *)CMSG_DATA(cmsg);
  2842			break;
  2843		case SO_TIMESTAMPING_OLD:
  2844		case SO_TIMESTAMPING_NEW:
  2845			if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
  2846				return -EINVAL;
  2847	
  2848			tsflags = *(u32 *)CMSG_DATA(cmsg);
  2849			if (tsflags & ~SOF_TIMESTAMPING_TX_RECORD_MASK)
  2850				return -EINVAL;
  2851	
  2852			sockc->tsflags &= ~SOF_TIMESTAMPING_TX_RECORD_MASK;
  2853			sockc->tsflags |= tsflags;
  2854			break;
  2855		case SCM_TXTIME:
  2856			if (!sock_flag(sk, SOCK_TXTIME))
  2857				return -EINVAL;
  2858			if (cmsg->cmsg_len != CMSG_LEN(sizeof(u64)))
  2859				return -EINVAL;
  2860			sockc->transmit_time = get_unaligned((u64 *)CMSG_DATA(cmsg));
  2861			break;
  2862		/* SCM_RIGHTS and SCM_CREDENTIALS are semantically in SOL_UNIX. */
  2863		case SCM_RIGHTS:
  2864		case SCM_CREDENTIALS:
  2865			break;
  2866		case SO_PRIORITY:
  2867			if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
  2868				return -EINVAL;
  2869	
> 2870			if ((*(u32 *)CMSG_DATA(cmsg) >= 0 && *(u32 *)CMSG_DATA(cmsg) <= 6) ||
  2871			    sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) ||
  2872			    sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN)) {
  2873				sockc->priority_cmsg_value = *(u32 *)CMSG_DATA(cmsg);
  2874				sockc->priority_cmsg_set = 1;
  2875				break;
  2876			}
  2877			return -EPERM;
  2878		default:
  2879			return -EINVAL;
  2880		}
  2881		return 0;
  2882	}
  2883	EXPORT_SYMBOL(__sock_cmsg_send);
  2884	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

