Return-Path: <netdev+bounces-258276-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QA0rIw13jGktpAAAu9opvQ
	(envelope-from <netdev+bounces-258276-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 13:33:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7151244E5
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 13:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 413B6305BD7B
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 12:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73380313279;
	Wed, 11 Feb 2026 12:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AATRKUx7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEA6273809;
	Wed, 11 Feb 2026 12:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770813163; cv=none; b=u/pX3UBA3/9BoESYJE0dWQT7RuiMmG57yDwghoVR+x9PDuTyVupprSLCH1AGoOl7pwZtHrvIuFtx6pW/RE3QEhE6TJTAeDg35rw8TF+VuvQmep2miVp+yqWl/3UfT8U0eLWDHETF8MvUfNh2GbEom63lH8ay2EgakyxQM+XNUAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770813163; c=relaxed/simple;
	bh=QAByPVqT09++FJk0uuU+1F6APVuMo+EbFVRjVQuki6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izaJez3GFgB4QBMISrdgCfs6sKQBlC8SxdExKOSIYzz7gI5Mx7k74mmaaCO003PQy420EzpJqpiD749Y2DaRpJHronqBZEjkUA3i5Yd6wKbDo78AqyY2MvL+NWpwSx6yD9h+2Pwubkco6RqufZXrzp181uK6SV10sZtDu2F595A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AATRKUx7; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770813162; x=1802349162;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QAByPVqT09++FJk0uuU+1F6APVuMo+EbFVRjVQuki6A=;
  b=AATRKUx7vC2VUWnKOzO450qoyNj1Y9SytLtvENpl3GxWvH6lOQc4Gy2X
   tBxswykxCC8Uuxg5JIrmbZCJmRjWHum0Y5/wpd5flRkHNG0QEZZJJ33BB
   Sob4nmqnZwa9TYRcP/sXmGEA4OYSBjTjxPqg4OShzjL0gTmeqiSWNAoyU
   dsvfiJzUblDLwWRxOLK2PtroLFkwXlOWH+lcOQ559R36NEu4TKvcU22xy
   9yx4TVPNENVtuzkDgOCjwrUGG6ZKyGMQ00Nb1JKH852v+/vWzrzUiV2U7
   GXvPR9vmrVcXhHL+skJLTOhQLzjMUfflqU1d2xgI8DGI91UDz3Vy9at4T
   Q==;
X-CSE-ConnectionGUID: PKqGag+tTa++W8872YRsnw==
X-CSE-MsgGUID: +ayaTF/bSoWGFjrQ4U+zCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="72145092"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="72145092"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 04:32:42 -0800
X-CSE-ConnectionGUID: Lp5x3XOyS7a+N5GY+/X3LQ==
X-CSE-MsgGUID: VWmLSFPXRma1eVX+c5/yVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="212327590"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 11 Feb 2026 04:32:29 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vq9OL-00000000py8-3rO7;
	Wed, 11 Feb 2026 12:32:25 +0000
Date: Wed, 11 Feb 2026 20:31:53 +0800
From: kernel test robot <lkp@intel.com>
To: Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org,
	akpm@linux-foundation.org, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com, harry.yoo@oracle.com, ast@kernel.org,
	daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
	saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
	mbloch@nvidia.com, andrew+netdev@lunn.ch, edumazet@google.com,
	pabeni@redhat.com, david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	jackmanb@google.com, hannes@cmpxchg.org
Subject: Re: [PATCH v3] mm: introduce a new page type for page pool in page
 type
Message-ID: <202602112054.QKfqC0UR-lkp@intel.com>
References: <20260210114712.55072-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210114712.55072-1-byungchul@sk.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,skhynix.com,oracle.com,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,nvidia.com,lunn.ch,google.com,redhat.com,suse.cz,suse.com,cmpxchg.org];
	TAGGED_FROM(0.00)[bounces-258276-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,01.org:url]
X-Rspamd-Queue-Id: 0A7151244E5
X-Rspamd-Action: no action

Hi Byungchul,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Byungchul-Park/mm-introduce-a-new-page-type-for-page-pool-in-page-type/20260210-194920
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20260210114712.55072-1-byungchul%40sk.com
patch subject: [PATCH v3] mm: introduce a new page type for page pool in page type
config: microblaze-randconfig-r134-20260211 (https://download.01.org/0day-ci/archive/20260211/202602112054.QKfqC0UR-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260211/202602112054.QKfqC0UR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602112054.QKfqC0UR-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   net/core/skbuff.c: note: in included file:
>> net/core/netmem_priv.h:21:20: sparse: sparse: cast to restricted netmem_ref
>> net/core/netmem_priv.h:21:20: sparse: sparse: cast to restricted netmem_ref
   net/core/skbuff.c: note: in included file (through include/linux/skbuff.h, include/net/net_namespace.h, include/linux/inet.h):
   include/net/checksum.h:33:39: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __wsum [usertype] sum @@     got unsigned int @@
   include/net/checksum.h:33:39: sparse:     expected restricted __wsum [usertype] sum
   include/net/checksum.h:33:39: sparse:     got unsigned int
--
>> net/core/page_pool.c:715:20: sparse: sparse: cast to restricted netmem_ref
   net/core/page_pool.c:739:20: sparse: sparse: cast to restricted netmem_ref

vim +21 net/core/netmem_priv.h

    10	
    11	static inline bool netmem_is_pp(netmem_ref netmem)
    12	{
    13		netmem_ref clr_ref;
    14	
    15		/* XXX: Now that the offset of page_type is shared between
    16		 * struct page and net_iov, just cast the netmem to struct page
    17		 * unconditionally by clearing NET_IOV if any, no matter whether
    18		 * it comes from struct net_iov or struct page.  This should be
    19		 * adjusted once the offset is no longer shared.
    20		 */
  > 21		clr_ref = (netmem_ref)((__force unsigned long)netmem & ~NET_IOV);
    22		return PageNetpp(__netmem_to_page(clr_ref));
    23	}
    24	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

