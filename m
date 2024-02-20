Return-Path: <netdev+bounces-73472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B616985CBE4
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 00:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 709981F22FCD
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 23:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981ED154445;
	Tue, 20 Feb 2024 23:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RT2kOKSl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EC8152DEE
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 23:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708471037; cv=none; b=gkjg3Cqnq3yGkNJxh37RNiNNgaK+6mXk31zhssYlA6TGVJS5vX9Eck3aM3b8nQ+H86aIU0+1JYKQzMDvBIGLTMF/24zOu6HkTUErfyj3Wm00NyM2zP5T3T9qOFLGxnbE10HLzTiOxxB52oKX3zhyyINbWGVOYPClgFNdGA86gDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708471037; c=relaxed/simple;
	bh=MQoa8dE2TOk9OUFb1sFOKWlJBcMmJiYn5Ci6fkC15kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mp7L/gKOdAmsKcjbJzHpdkhOFpY/gPE+QPrhi5a4+SCX0LuRz9ngneYpkaatPRJ8gRXh1MubdIgtfT9aaem3SKa8evp1kSqTBnQUKws0r/iR8mFTO8XrghryYy76H+26XeQzBcHD3PPONlnImkKPDyL9YNd9jI7rr2xG+A0zJTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RT2kOKSl; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708471036; x=1740007036;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MQoa8dE2TOk9OUFb1sFOKWlJBcMmJiYn5Ci6fkC15kk=;
  b=RT2kOKSljPsjWa0QpWzkG1fnFZk+fCFSV/7kSHux2bJczS8w28vZlp7N
   j9g1CNiOwDCTg9iJJrZe2OvaWCTIJRYBXtc4eNymlEaos91V8nb7nOZwE
   Rb9MY8nVig4xwiW4iXGVvEcmRdrl5GrSDoszwUX+NnjxJN2OCyXB4mtOs
   qWncnjZGywdqRxYztpEuNecL0/x5dn/fxpy+hir3hj5hKHAOqAGA2OfMa
   TAZYbup7ZxJg+4FB8RfhLNsUI06Or918CUHruTW+GvDtzW6ylfbmBQ9RO
   4s4RtvJdOy3xS1GDL1MPK2uRZDj0BxnE007LqQJ6Npco9+GOgXGHYaVaa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2472458"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2472458"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 15:17:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="9635450"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 20 Feb 2024 15:17:11 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rcZML-0004sG-08;
	Tue, 20 Feb 2024 23:17:09 +0000
Date: Wed, 21 Feb 2024 07:16:49 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org
Cc: oe-kbuild-all@lists.linux.dev,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@chopps.org>
Subject: Re: [PATCH ipsec-next v1 8/8] iptfs: impl: add new iptfs xfrm mode
 impl
Message-ID: <202402210751.pKXknmd9-lkp@intel.com>
References: <20240219085735.1220113-9-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219085735.1220113-9-chopps@chopps.org>

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on klassert-ipsec-next/master]
[also build test ERROR on klassert-ipsec/master netfilter-nf/main linus/master v6.8-rc5 next-20240220]
[cannot apply to nf-next/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Hopps/iptfs-config-add-CONFIG_XFRM_IPTFS/20240219-171931
base:   https://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git master
patch link:    https://lore.kernel.org/r/20240219085735.1220113-9-chopps%40chopps.org
patch subject: [PATCH ipsec-next v1 8/8] iptfs: impl: add new iptfs xfrm mode impl
config: i386-randconfig-r063-20240220 (https://download.01.org/0day-ci/archive/20240221/202402210751.pKXknmd9-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240221/202402210751.pKXknmd9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402210751.pKXknmd9-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: net/xfrm/xfrm_iptfs.o: in function `iptfs_copy_to_user':
>> net/xfrm/xfrm_iptfs.c:2624: undefined reference to `__udivdi3'
>> ld: net/xfrm/xfrm_iptfs.c:2628: undefined reference to `__udivdi3'


vim +2624 net/xfrm/xfrm_iptfs.c

  2602	
  2603	static int iptfs_copy_to_user(struct xfrm_state *x, struct sk_buff *skb)
  2604	{
  2605		struct xfrm_iptfs_data *xtfs = x->mode_data;
  2606		struct xfrm_iptfs_config *xc = &xtfs->cfg;
  2607		int ret;
  2608	
  2609		if (xc->dont_frag) {
  2610			ret = nla_put_flag(skb, XFRMA_IPTFS_DONT_FRAG);
  2611			if (ret)
  2612				return ret;
  2613		}
  2614		ret = nla_put_u16(skb, XFRMA_IPTFS_REORDER_WINDOW, xc->reorder_win_size);
  2615		if (ret)
  2616			return ret;
  2617		ret = nla_put_u32(skb, XFRMA_IPTFS_PKT_SIZE, xc->pkt_size);
  2618		if (ret)
  2619			return ret;
  2620		ret = nla_put_u32(skb, XFRMA_IPTFS_MAX_QSIZE, xc->max_queue_size);
  2621		if (ret)
  2622			return ret;
  2623		ret = nla_put_u32(skb, XFRMA_IPTFS_DROP_TIME,
> 2624				  xtfs->drop_time_ns / NSECS_IN_USEC);
  2625		if (ret)
  2626			return ret;
  2627		ret = nla_put_u32(skb, XFRMA_IPTFS_INIT_DELAY,
> 2628				  xtfs->init_delay_ns / NSECS_IN_USEC);
  2629		return ret;
  2630	}
  2631	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

