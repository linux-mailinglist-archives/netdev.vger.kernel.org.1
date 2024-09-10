Return-Path: <netdev+bounces-126839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BFC972A2D
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 09:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFC69B2141A
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 07:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7E417C213;
	Tue, 10 Sep 2024 07:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hf8LRGSr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C618217BB3F
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 07:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725951961; cv=none; b=OHnlc1u2KGJ3BJYKHu9b+CqnBYME8XrckRADN+5pld2k2HhX1bN3Ok4o1HUqSoEJi8Olkg7LZeLYKaJlJ9uyEmdEyRO+mZl5//PICPchlgm/VN061YJgaxad4ZI78A71M7yBP90zcg4TFbvT1WQEkUE5qwRTTS5nf6JUZ+rQLzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725951961; c=relaxed/simple;
	bh=gqF06DA7eFnsn0rKiQDdVrzFfjrAyFqYKop9G+HSQT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ha37xbN0spBVZjuEIQB6qOTSKQVq0oUKPkistTP85I1AX0uGEFETD+iJWSNbcoHi+7EjaQO/5j1wYV9lOehKA+c+zys4IyyQTTmI6/wb/ICa+sh8cC/fHvwL26WsAVQAAMZqUhf6TVIgYUW6zH6VLRrzDiELWVqKJJ40y3TgJDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hf8LRGSr; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725951959; x=1757487959;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gqF06DA7eFnsn0rKiQDdVrzFfjrAyFqYKop9G+HSQT8=;
  b=Hf8LRGSrsTdsnuKsyThRKxzHePaPCf22qpZ05ji2cIddWtonRVS49RLD
   waLkamVEtHfL+LPsf9GSE/skzqU7VuKXBa+Ek4lOShTTsHlHsB8FPD3dl
   KbmcQbTwNyivczteM/T1XZwkdxOdIAS4akmM9M1uJNhIPfIBpoxtZG7dW
   FEOIMLpyWfy+AxDvWLSSnh5ET4xswtuSbPMPFYkrtzm00VTts+Kp52vBB
   yNcOjRewXUDpQ8EGVTtitKLY92lXVjb0X7RVRdONwOqD2oRgZgpl6YnuR
   YJ/pmNuzgX6+RKsQgb5sk7Hyb7ozMttdZrmNXGYXQ2bd537rP6qJQ8Quz
   Q==;
X-CSE-ConnectionGUID: DgYU3Vt0Tau7ig6+JY3kGA==
X-CSE-MsgGUID: AWYnv49pTByzItyn5zuTpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="28571872"
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="28571872"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 00:05:57 -0700
X-CSE-ConnectionGUID: n/zJixobRey0zzAxypIMUQ==
X-CSE-MsgGUID: tEfp3j0WQM2xmbrEPdFTiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="97638226"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 10 Sep 2024 00:05:51 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1snuwd-0000CK-1L;
	Tue, 10 Sep 2024 07:05:47 +0000
Date: Tue, 10 Sep 2024 15:05:41 +0800
From: kernel test robot <lkp@intel.com>
To: Vadim Fedorenko <vadfed@meta.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Simon Horman <horms@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/3] net_tstamp: add SCM_TS_OPT_ID for RAW
 sockets
Message-ID: <202409101415.65PxVwQn-lkp@intel.com>
References: <20240909165046.644417-3-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909165046.644417-3-vadfed@meta.com>

Hi Vadim,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Vadim-Fedorenko/net_tstamp-add-SCM_TS_OPT_ID-to-provide-OPT_ID-in-control-message/20240910-005324
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240909165046.644417-3-vadfed%40meta.com
patch subject: [PATCH net-next v4 2/3] net_tstamp: add SCM_TS_OPT_ID for RAW sockets
config: arm-integrator_defconfig (https://download.01.org/0day-ci/archive/20240910/202409101415.65PxVwQn-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 05f5a91d00b02f4369f46d076411c700755ae041)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240910/202409101415.65PxVwQn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409101415.65PxVwQn-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/ipv4/tcp.c:252:
   In file included from include/linux/inet_diag.h:5:
   In file included from include/net/netlink.h:6:
   In file included from include/linux/netlink.h:7:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/arm/include/asm/cacheflush.h:10:
   In file included from include/linux/mm.h:2232:
   include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> net/ipv4/tcp.c:485:25: error: use of undeclared identifier 'sockc'
     485 |                 sock_tx_timestamp(sk, sockc, &shinfo->tx_flags);
         |                                       ^
   1 warning and 1 error generated.


vim +/sockc +485 net/ipv4/tcp.c

   476	
   477	static void tcp_tx_timestamp(struct sock *sk, u16 tsflags)
   478	{
   479		struct sk_buff *skb = tcp_write_queue_tail(sk);
   480	
   481		if (tsflags && skb) {
   482			struct skb_shared_info *shinfo = skb_shinfo(skb);
   483			struct tcp_skb_cb *tcb = TCP_SKB_CB(skb);
   484	
 > 485			sock_tx_timestamp(sk, sockc, &shinfo->tx_flags);
   486			if (tsflags & SOF_TIMESTAMPING_TX_ACK)
   487				tcb->txstamp_ack = 1;
   488			if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
   489				shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
   490		}
   491	}
   492	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

