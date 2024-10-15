Return-Path: <netdev+bounces-135826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C328599F4C5
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 20:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E61E81C20D43
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 18:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B004C1B219C;
	Tue, 15 Oct 2024 18:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RWsz94JK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E45E1B392C
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 18:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729015425; cv=none; b=eiWZqRaeGkcAMbgMRtc0GpKNM0FTBlhRQMd56JTLF3SZf5U+H9EirOXlzYX+4VGtP8zQ3NvOYOu5NHAkiKnDkyCpsJBj8o43aUkd8g+Yc66FcEioIu1cYTQlCXYQWe8EA7SqbLmXQePXWEaqdb1gq7aHDlxObTYfMEN2DB3PckI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729015425; c=relaxed/simple;
	bh=FUxYJtCSs6rsDB6KaZF+B5u3c5DTcljuc15UIOoOLjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sn77cYEe7F2JC9BngLwVlJYG2McrJci8+oisEN7Yf36oTOljcan6qlWBkPph8xuYqnYTv4LCjOWTJEnkd2VFX0Yz4NNdG8SDwKXkmlaPXiOG9dyJP0z57JWJbdxmbsFJLW6kZBczallSa2k/5rQWzDWMgbebHvx4KGoA2Si6dNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RWsz94JK; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729015423; x=1760551423;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FUxYJtCSs6rsDB6KaZF+B5u3c5DTcljuc15UIOoOLjw=;
  b=RWsz94JKmy7fZKnQ24GOQ6F+4qUnG9gsbviltR6qH8ABGthqFm/r4Pqe
   mL7cTVGRyWVbNCYmiO77jmEIvXcgPG0hZ4WeBDrR0SdpYmt5Xd61sV2WM
   csESPJzXX7iMo1zrSG+SNpna/LxkTN3Z/nnl7rLJ55GOWE5CTS5pqOSGV
   D64hxux1vq64QQNob1p/vsTLZzLd7kmax4MhDmsGUWJARfqjZGruPedfG
   HwuRf5rLNz8uV5dHsXbq93n7M5ygpZ1mrX5CL/X6vaYaEcDW/dhHvU5Bk
   /G0mh1SwZq5/Cc/ltSz4SQ/hr/zToLwcDNXWlVFX5fKp9bhGD3Eqvbw/X
   A==;
X-CSE-ConnectionGUID: L5Iy+IX9QbyXLrJeVv5Ruw==
X-CSE-MsgGUID: X6Gy2k3uSIS0PiySS+QbXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="39818627"
X-IronPort-AV: E=Sophos;i="6.11,205,1725346800"; 
   d="scan'208";a="39818627"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 11:03:43 -0700
X-CSE-ConnectionGUID: 2OLwxAtWR3mbgRXseSctXw==
X-CSE-MsgGUID: 8OsR92p0ScO85/UBS+NHkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,205,1725346800"; 
   d="scan'208";a="78158364"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 15 Oct 2024 11:03:41 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t0ltS-000JhW-23;
	Tue, 15 Oct 2024 18:03:38 +0000
Date: Wed, 16 Oct 2024 02:03:30 +0800
From: kernel test robot <lkp@intel.com>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	intel-wired-lan@lists.osuosl.org, aleksander.lobakin@intel.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v11 09/14] libeth: move
 idpf_rx_csum_decoded and idpf_rx_extracted
Message-ID: <202410160123.5dWnVGKr-lkp@intel.com>
References: <20241013154415.20262-10-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241013154415.20262-10-mateusz.polchlopek@intel.com>

Hi Mateusz,

kernel test robot noticed the following build errors:

[auto build test ERROR on a77c49f53be0af1efad5b4541a9a145505c81800]

url:    https://github.com/intel-lab-lkp/linux/commits/Mateusz-Polchlopek/virtchnl-add-support-for-enabling-PTP-on-iAVF/20241014-174710
base:   a77c49f53be0af1efad5b4541a9a145505c81800
patch link:    https://lore.kernel.org/r/20241013154415.20262-10-mateusz.polchlopek%40intel.com
patch subject: [Intel-wired-lan] [PATCH iwl-next v11 09/14] libeth: move idpf_rx_csum_decoded and idpf_rx_extracted
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20241016/202410160123.5dWnVGKr-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241016/202410160123.5dWnVGKr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410160123.5dWnVGKr-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c:1040:64: error: expected ';' after expression
    1040 |                 idpf_rx_singleq_process_skb_fields(rx_q, skb, rx_desc, ptype)
         |                                                                              ^
         |                                                                              ;
   1 error generated.


vim +1040 drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c

   954	
   955	/**
   956	 * idpf_rx_singleq_clean - Reclaim resources after receive completes
   957	 * @rx_q: rx queue to clean
   958	 * @budget: Total limit on number of packets to process
   959	 *
   960	 * Returns true if there's any budget left (e.g. the clean is finished)
   961	 */
   962	static int idpf_rx_singleq_clean(struct idpf_rx_queue *rx_q, int budget)
   963	{
   964		unsigned int total_rx_bytes = 0, total_rx_pkts = 0;
   965		struct sk_buff *skb = rx_q->skb;
   966		u16 ntc = rx_q->next_to_clean;
   967		u16 cleaned_count = 0;
   968		bool failure = false;
   969	
   970		/* Process Rx packets bounded by budget */
   971		while (likely(total_rx_pkts < (unsigned int)budget)) {
   972			struct libeth_rqe_info fields = { };
   973			union virtchnl2_rx_desc *rx_desc;
   974			struct idpf_rx_buf *rx_buf;
   975			u32 ptype;
   976	
   977			/* get the Rx desc from Rx queue based on 'next_to_clean' */
   978			rx_desc = &rx_q->rx[ntc];
   979	
   980			/* status_error_ptype_len will always be zero for unused
   981			 * descriptors because it's cleared in cleanup, and overlaps
   982			 * with hdr_addr which is always zero because packet split
   983			 * isn't used, if the hardware wrote DD then the length will be
   984			 * non-zero
   985			 */
   986	#define IDPF_RXD_DD VIRTCHNL2_RX_BASE_DESC_STATUS_DD_M
   987			if (!idpf_rx_singleq_test_staterr(rx_desc,
   988							  IDPF_RXD_DD))
   989				break;
   990	
   991			/* This memory barrier is needed to keep us from reading
   992			 * any other fields out of the rx_desc
   993			 */
   994			dma_rmb();
   995	
   996			idpf_rx_singleq_extract_fields(rx_q, rx_desc, &fields, &ptype);
   997	
   998			rx_buf = &rx_q->rx_buf[ntc];
   999			if (!libeth_rx_sync_for_cpu(rx_buf, fields.len))
  1000				goto skip_data;
  1001	
  1002			if (skb)
  1003				idpf_rx_add_frag(rx_buf, skb, fields.len);
  1004			else
  1005				skb = idpf_rx_build_skb(rx_buf, fields.len);
  1006	
  1007			/* exit if we failed to retrieve a buffer */
  1008			if (!skb)
  1009				break;
  1010	
  1011	skip_data:
  1012			rx_buf->page = NULL;
  1013	
  1014			IDPF_SINGLEQ_BUMP_RING_IDX(rx_q, ntc);
  1015			cleaned_count++;
  1016	
  1017			/* skip if it is non EOP desc */
  1018			if (idpf_rx_singleq_is_non_eop(rx_desc) || unlikely(!skb))
  1019				continue;
  1020	
  1021	#define IDPF_RXD_ERR_S FIELD_PREP(VIRTCHNL2_RX_BASE_DESC_QW1_ERROR_M, \
  1022					  VIRTCHNL2_RX_BASE_DESC_ERROR_RXE_M)
  1023			if (unlikely(idpf_rx_singleq_test_staterr(rx_desc,
  1024								  IDPF_RXD_ERR_S))) {
  1025				dev_kfree_skb_any(skb);
  1026				skb = NULL;
  1027				continue;
  1028			}
  1029	
  1030			/* pad skb if needed (to make valid ethernet frame) */
  1031			if (eth_skb_pad(skb)) {
  1032				skb = NULL;
  1033				continue;
  1034			}
  1035	
  1036			/* probably a little skewed due to removing CRC */
  1037			total_rx_bytes += skb->len;
  1038	
  1039			/* protocol */
> 1040			idpf_rx_singleq_process_skb_fields(rx_q, skb, rx_desc, ptype)
  1041	
  1042			/* send completed skb up the stack */
  1043			napi_gro_receive(rx_q->pp->p.napi, skb);
  1044			skb = NULL;
  1045	
  1046			/* update budget accounting */
  1047			total_rx_pkts++;
  1048		}
  1049	
  1050		rx_q->skb = skb;
  1051	
  1052		rx_q->next_to_clean = ntc;
  1053	
  1054		page_pool_nid_changed(rx_q->pp, numa_mem_id());
  1055		if (cleaned_count)
  1056			failure = idpf_rx_singleq_buf_hw_alloc_all(rx_q, cleaned_count);
  1057	
  1058		u64_stats_update_begin(&rx_q->stats_sync);
  1059		u64_stats_add(&rx_q->q_stats.packets, total_rx_pkts);
  1060		u64_stats_add(&rx_q->q_stats.bytes, total_rx_bytes);
  1061		u64_stats_update_end(&rx_q->stats_sync);
  1062	
  1063		/* guarantee a trip back through this routine if there was a failure */
  1064		return failure ? budget : (int)total_rx_pkts;
  1065	}
  1066	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

