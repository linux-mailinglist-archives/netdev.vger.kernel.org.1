Return-Path: <netdev+bounces-156839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B19C0A07FA5
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 19:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E53273A36B1
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 18:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA5C18D64B;
	Thu,  9 Jan 2025 18:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PiGidhRI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D98B186E27
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 18:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736446554; cv=none; b=mOJEjqbqj8gD3eSuOeWMcfZkS7h/IquFeGGRfm1trpeFGKD/EDOCpvdOy33fCurzYYvyutgp6nlXmkGJJbFVIyMvEEV4jubVyGQYTC8e1y8DT37OOCrEdrogr4H2vG8SmDYZZwYozBFURQGb6EmMfneg5A4Ssnsn3nK+kGycUeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736446554; c=relaxed/simple;
	bh=rqTDQyM6f6t1vg7y/LAHyrEnq1TH4fX4bGMBaaA8Phk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AoHx9Wu7b7RQQnLhqEouwjwZz3Ew6S1MxZV6vLcnmsZYC42etySknE/a4yBXuMoFi5HlMPqMbxNf6qjPDI7jZrxR6rHSQBoQOanIbJwvUZMTxKNYRydjiFwlK0oMb4p+K8O/XJqBpDekXM99mI6FSNFfhIDhHNrFeHOmrC4Br3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PiGidhRI; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736446552; x=1767982552;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rqTDQyM6f6t1vg7y/LAHyrEnq1TH4fX4bGMBaaA8Phk=;
  b=PiGidhRIwRfEVbnjoJUc6EGz6RvaFEsOXcJO0pIHx3OzWPCELqMh1Zj4
   fJmCuRfDEtaxMN89hFk45ahH0nkTz62wMQkhNzwDQdPqPqW/CNg3TzM1O
   tAADLR4FuTsGRUBFrr2RROkbjThUYUJWFH3MvOd/lV0aS9OsFDRIaE8GF
   wjnyBeZrRNeaFmI3fpuo7LSdT/7nREJt5qhx6JzqAnKFtzQJBkpzredyf
   JfULnU/DZMs63edh1uAWNcCJFLG6/g+AmHaQXZSJiri95pXNPacBtzwdE
   Es7+lh5eP2pJP94Drs+2Ac1Cq+0IT+cC1mD/qNNzax1652uzMSa9jRtV1
   A==;
X-CSE-ConnectionGUID: anf4PHnaTKec4I5fJJ1gXA==
X-CSE-MsgGUID: mpGxRl8rQ6e+dX1OvEFeew==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="48138572"
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="48138572"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 10:15:51 -0800
X-CSE-ConnectionGUID: G2koycWQSwCA57NL1I8Z1w==
X-CSE-MsgGUID: s1kNrwevTl2KbggLvOpZdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="108480831"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 09 Jan 2025 10:15:49 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tVx4M-000Hyt-2O;
	Thu, 09 Jan 2025 18:15:46 +0000
Date: Fri, 10 Jan 2025 02:14:59 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next 3/4] net: expedite synchronize_net() for
 cleanup_net()
Message-ID: <202501100222.pLf6muKs-lkp@intel.com>
References: <20250107173838.1130187-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107173838.1130187-4-edumazet@google.com>

Hi Eric,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/net-no-longer-assume-RTNL-is-held-in-flush_all_backlogs/20250108-014049
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250107173838.1130187-4-edumazet%40google.com
patch subject: [PATCH net-next 3/4] net: expedite synchronize_net() for cleanup_net()
config: powerpc-fsp2_defconfig (https://download.01.org/0day-ci/archive/20250110/202501100222.pLf6muKs-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250110/202501100222.pLf6muKs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501100222.pLf6muKs-lkp@intel.com/

All errors (new ones prefixed by >>):

   powerpc-linux-ld: net/core/dev.o: in function `synchronize_net':
   net/core/dev.c:11426:(.text+0x1be2): undefined reference to `cleanup_net_task'
>> powerpc-linux-ld: net/core/dev.c:11426:(.text+0x1be6): undefined reference to `cleanup_net_task'
   powerpc-linux-ld: net/core/dev.c:11426:(.text+0x68ce): undefined reference to `cleanup_net_task'
   powerpc-linux-ld: net/core/dev.c:11426:(.text+0x68d2): undefined reference to `cleanup_net_task'
   powerpc-linux-ld: net/core/dev.o: in function `free_netdev':
   net/core/dev.c:11372:(.text+0x6ae2): undefined reference to `cleanup_net_task'
   powerpc-linux-ld: net/core/dev.o:net/core/dev.c:11372: more undefined references to `cleanup_net_task' follow

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

