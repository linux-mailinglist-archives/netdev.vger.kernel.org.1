Return-Path: <netdev+bounces-260259-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOitFpfhnGnCLwQAu9opvQ
	(envelope-from <netdev+bounces-260259-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 00:24:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4B617F48D
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 00:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A8B2302797E
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 23:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6341937F748;
	Mon, 23 Feb 2026 23:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D2J5KUQr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDF337F74C
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 23:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889043; cv=none; b=cosOnGW4oNVBMTghwXzl8dD/yIpy5uD/dJX75XmHAFYufK2IGc5waYfDclHUiDRi1v3sUP3QC0ugbk+wW1I0d5whf9HBhQb3+hPEKmKPoilKYGM04vbRtX1LLo2n6OENZFAebj0tjWwGGMHL2jkuJYL7kkTbgXtneQCo4i4/V9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889043; c=relaxed/simple;
	bh=pCQRwUB18cL9IhLHvvAID1cleX6dfDa/YbPB3043ZP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eq5wnIPNgw1gjQ82P272XYe/S1lpGm/y0oEsigScEydgSGlvmh+9tgdNX+QykcTYeOjrOww/GAtUxX6BiamiByFTGDmKYDBg9q87DaiLBzpXMdaUtjP0a6MuWMdG+DqaeU1urVutsuCwbuHWtOXBrgXCestf0978hUZr9wdGcEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D2J5KUQr; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771889039; x=1803425039;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pCQRwUB18cL9IhLHvvAID1cleX6dfDa/YbPB3043ZP8=;
  b=D2J5KUQrMxekXWGxER2oRhEXe846RbAgWHTXXM7rC2P4ZYvvBuP+WY6I
   ytsi4h+WbSSQEDO8JufJUeIL39ReaORIJ4JlVGSphWYVY/whTeGLyA0l2
   +KeVUjxPOxDW+1Upv9CtZiOXvLIGj+Ln8SzlmiMg0UnW5ar57GsAlMmbM
   zRAIJJqyxs3ExBxIQ2+V8YIO/yDBwpS+lvyOH64CEtjsSOKhJwPhQety4
   I5MOJQsiQcXfTFTrAFtHgc6FD/NIfQA3Yn8PkX3/FlpEZGs9pkVc7fzGm
   3Vk/iuyd4UxDeQvg9nJ2SQS1G6IwpUw9vWJWIKkuEwsvl3qqetHdoasAN
   A==;
X-CSE-ConnectionGUID: q3t5o0bRR+Syrmydc0icHA==
X-CSE-MsgGUID: tAUktr5TRZGL5KPXxhPe8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="75503594"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="75503594"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 15:23:58 -0800
X-CSE-ConnectionGUID: GThoQFBSSM6m5KEZfuANxQ==
X-CSE-MsgGUID: h7D62WMSTyeuV1f2GpL48w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="220720210"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 23 Feb 2026 15:23:54 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vufHM-000000000vt-0piV;
	Mon, 23 Feb 2026 23:23:52 +0000
Date: Tue, 24 Feb 2026 07:23:12 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Valerio <pvalerio@redhat.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v2 5/8] net: macb: add XDP support for gem
Message-ID: <202602240713.bQWzr8aD-lkp@intel.com>
References: <20260223182632.1681809-6-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223182632.1681809-6-pvalerio@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260259-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,01.org:url]
X-Rspamd-Queue-Id: EB4B617F48D
X-Rspamd-Action: no action

Hi Paolo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Paolo-Valerio/net-macb-move-Rx-buffers-alloc-from-link-up-to-open/20260224-023220
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260223182632.1681809-6-pvalerio%40redhat.com
patch subject: [PATCH net-next v2 5/8] net: macb: add XDP support for gem
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20260224/202602240713.bQWzr8aD-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260224/202602240713.bQWzr8aD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602240713.bQWzr8aD-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/cadence/macb_main.c:2749:10: warning: variable 'err' is uninitialized when used here [-Wuninitialized]
    2749 |                 return err;
         |                        ^~~
   drivers/net/ethernet/cadence/macb_main.c:2743:9: note: initialize the variable 'err' to silence this warning
    2743 |         int err;
         |                ^
         |                 = 0
   1 warning generated.


vim +/err +2749 drivers/net/ethernet/cadence/macb_main.c

89e5785fc8a6b9 drivers/net/macb.c                       Haavard Skinnemoen 2006-11-09  2726  
fa62bb4def147c drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2727  static int gem_create_page_pool(struct macb_queue *queue, int qid)
65104588f8cde9 drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2728  {
65104588f8cde9 drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2729  	struct page_pool_params pp_params = {
65104588f8cde9 drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2730  		.order = 0,
65104588f8cde9 drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2731  		.flags = PP_FLAG_DMA_MAP,
65104588f8cde9 drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2732  		.pool_size = queue->bp->rx_ring_size,
65104588f8cde9 drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2733  		.nid = NUMA_NO_NODE,
fa62bb4def147c drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2734  		.dma_dir = rcu_access_pointer(queue->bp->prog)
fa62bb4def147c drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2735  				? DMA_BIDIRECTIONAL
fa62bb4def147c drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2736  				: DMA_FROM_DEVICE,
65104588f8cde9 drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2737  		.dev = &queue->bp->pdev->dev,
65104588f8cde9 drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2738  		.netdev = queue->bp->dev,
65104588f8cde9 drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2739  		.napi = &queue->napi_rx,
65104588f8cde9 drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2740  		.max_len = PAGE_SIZE,
65104588f8cde9 drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2741  	};
65104588f8cde9 drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2742  	struct page_pool *pool;
fa62bb4def147c drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2743  	int err;
65104588f8cde9 drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2744  
65104588f8cde9 drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2745  	/* This can happen in the case of HRESP error.
65104588f8cde9 drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2746  	 * Do nothing as page pool is already existing.
65104588f8cde9 drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2747  	 */
65104588f8cde9 drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2748  	if (queue->page_pool)
65104588f8cde9 drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23 @2749  		return err;
65104588f8cde9 drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2750  
65104588f8cde9 drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2751  	pool = page_pool_create(&pp_params);
65104588f8cde9 drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2752  	if (IS_ERR(pool)) {
65104588f8cde9 drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2753  		netdev_err(queue->bp->dev, "cannot create rx page pool\n");
65104588f8cde9 drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2754  		err = PTR_ERR(pool);
fa62bb4def147c drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2755  		goto clear_pool;
65104588f8cde9 drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2756  	}
65104588f8cde9 drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2757  
65104588f8cde9 drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2758  	queue->page_pool = pool;
65104588f8cde9 drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2759  
fa62bb4def147c drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2760  	err = xdp_rxq_info_reg(&queue->xdp_rxq, queue->bp->dev, qid,
fa62bb4def147c drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2761  			       queue->napi_rx.napi_id);
fa62bb4def147c drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2762  	if (err < 0) {
fa62bb4def147c drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2763  		netdev_err(queue->bp->dev, "xdp: failed to register rxq info\n");
fa62bb4def147c drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2764  		goto destroy_pool;
fa62bb4def147c drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2765  	}
fa62bb4def147c drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2766  
fa62bb4def147c drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2767  	err = xdp_rxq_info_reg_mem_model(&queue->xdp_rxq, MEM_TYPE_PAGE_POOL,
fa62bb4def147c drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2768  					 queue->page_pool);
fa62bb4def147c drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2769  	if (err) {
fa62bb4def147c drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2770  		netdev_err(queue->bp->dev, "xdp: failed to register rxq memory model\n");
fa62bb4def147c drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2771  		goto unreg_info;
fa62bb4def147c drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2772  	}
fa62bb4def147c drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2773  
fa62bb4def147c drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2774  	return 0;
fa62bb4def147c drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2775  
fa62bb4def147c drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2776  unreg_info:
fa62bb4def147c drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2777  	xdp_rxq_info_unreg(&queue->xdp_rxq);
fa62bb4def147c drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2778  destroy_pool:
fa62bb4def147c drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2779  	page_pool_destroy(pool);
fa62bb4def147c drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2780  clear_pool:
fa62bb4def147c drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2781  	queue->page_pool = NULL;
fa62bb4def147c drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2782  
65104588f8cde9 drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2783  	return err;
65104588f8cde9 drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2784  }
65104588f8cde9 drivers/net/ethernet/cadence/macb_main.c Paolo Valerio      2026-02-23  2785  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

