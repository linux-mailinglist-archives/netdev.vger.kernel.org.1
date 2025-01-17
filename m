Return-Path: <netdev+bounces-159345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C87A152E5
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 16:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EFE81881674
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 15:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720011714D0;
	Fri, 17 Jan 2025 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dgb9GYza"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D5733062;
	Fri, 17 Jan 2025 15:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737127865; cv=none; b=H154R+eifiIaCho9GFYnpoRB/90rA7SruYypoOXwW692/9WGoVeud1rCASVssXVmKtRFYaOyIepE1N0Rk9Pgu5/RBrOuAx2YqSSmuje779PfdE+42pSxCro2GCPpZzHAy/LVCLSwDb/SI+jpOAw3RUAlJX0UNVC06zoSbHjgjJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737127865; c=relaxed/simple;
	bh=Ct2LBolJssi12orV1vqNr8g5NmfBpVvpwl8vuoKzVU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8UTCsRY6EW6eX5SCRK3Ph55geh/+SsqG9xl8xA8Id7S8jtwU3Au4vZmKuna6+w36nmhKAkHwWXGVZW7YuJ0kmNuNLgqUjT0RSQt5CqkqazBCgwERdGqKM09wi1Sq5bMw6zOqjC9CnW5ZMcvuUwTh3oeq+PTZmLfi02B5+rbfSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dgb9GYza; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737127862; x=1768663862;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ct2LBolJssi12orV1vqNr8g5NmfBpVvpwl8vuoKzVU8=;
  b=dgb9GYzatESFgYI9fNbO8knXHQtfSPerDUwqKzofZzkqIbK9R1fN5qBD
   oCev0fa4q9AEW0ZazyvydMxyF78QsXPVWZKiVZxOTedg/gLfjIAOM2yth
   R/PfHzSBIm0wou+afHc2RmQj5NAOM0qP0IlLfFopD4OC+6D9dBkknWqB5
   pjO83+JIsdwRPw6olCi7cLOkL3QRszqIttvf0lOm5/290qncp2YHjT/mM
   s3hHMRWcMU9BtkczlMjLBbG6+7C+JSMNc+CHElJqF7jUJ51ROAjhTZBK8
   GlkcyJP1WNQspuvmy4W9nU85intD5Dj1p2xLTYsGeWPcLx4vwGEwmwTcr
   Q==;
X-CSE-ConnectionGUID: gqxFIqM+RDGNwCfyn8rj+w==
X-CSE-MsgGUID: qlnnyqLKTceNkxAsO+q8XA==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="37584357"
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="37584357"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 07:31:02 -0800
X-CSE-ConnectionGUID: leJajOJ/RsS1s8BvVNvDSw==
X-CSE-MsgGUID: WvXFisaaTFKfscJp/ddSng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110940513"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 17 Jan 2025 07:30:56 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tYoJE-000TP5-0d;
	Fri, 17 Jan 2025 15:30:56 +0000
Date: Fri, 17 Jan 2025 23:30:47 +0800
From: kernel test robot <lkp@intel.com>
To: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>,
	wei.fang@nxp.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Subject: Re: [PATCH net-next] net: fec: implement TSO descriptor cleanup
Message-ID: <202501172328.IoOTB8n0-lkp@intel.com>
References: <20250116130920.30984-1-dheeraj.linuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116130920.30984-1-dheeraj.linuxdev@gmail.com>

Hi Dheeraj,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Dheeraj-Reddy-Jonnalagadda/net-fec-implement-TSO-descriptor-cleanup/20250116-211046
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250116130920.30984-1-dheeraj.linuxdev%40gmail.com
patch subject: [PATCH net-next] net: fec: implement TSO descriptor cleanup
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20250117/202501172328.IoOTB8n0-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250117/202501172328.IoOTB8n0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501172328.IoOTB8n0-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/freescale/fec_main.c:25:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:181:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2224:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/freescale/fec_main.c:917:2: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
     917 |         struct bufdesc *tmp_bdp = txq->bd.cur;
         |         ^
   4 warnings generated.


vim +917 drivers/net/ethernet/freescale/fec_main.c

   835	
   836	static int fec_enet_txq_submit_tso(struct fec_enet_priv_tx_q *txq,
   837					   struct sk_buff *skb,
   838					   struct net_device *ndev)
   839	{
   840		struct fec_enet_private *fep = netdev_priv(ndev);
   841		int hdr_len, total_len, data_left;
   842		struct bufdesc *bdp = txq->bd.cur;
   843		struct tso_t tso;
   844		unsigned int index = 0;
   845		int ret;
   846	
   847		if (tso_count_descs(skb) >= fec_enet_get_free_txdesc_num(txq)) {
   848			dev_kfree_skb_any(skb);
   849			if (net_ratelimit())
   850				netdev_err(ndev, "NOT enough BD for TSO!\n");
   851			return NETDEV_TX_OK;
   852		}
   853	
   854		/* Protocol checksum off-load for TCP and UDP. */
   855		if (fec_enet_clear_csum(skb, ndev)) {
   856			dev_kfree_skb_any(skb);
   857			return NETDEV_TX_OK;
   858		}
   859	
   860		/* Initialize the TSO handler, and prepare the first payload */
   861		hdr_len = tso_start(skb, &tso);
   862	
   863		total_len = skb->len - hdr_len;
   864		while (total_len > 0) {
   865			char *hdr;
   866	
   867			index = fec_enet_get_bd_index(bdp, &txq->bd);
   868			data_left = min_t(int, skb_shinfo(skb)->gso_size, total_len);
   869			total_len -= data_left;
   870	
   871			/* prepare packet headers: MAC + IP + TCP */
   872			hdr = txq->tso_hdrs + index * TSO_HEADER_SIZE;
   873			tso_build_hdr(skb, hdr, &tso, data_left, total_len == 0);
   874			ret = fec_enet_txq_put_hdr_tso(txq, skb, ndev, bdp, index);
   875			if (ret)
   876				goto err_release;
   877	
   878			while (data_left > 0) {
   879				int size;
   880	
   881				size = min_t(int, tso.size, data_left);
   882				bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
   883				index = fec_enet_get_bd_index(bdp, &txq->bd);
   884				ret = fec_enet_txq_put_data_tso(txq, skb, ndev,
   885								bdp, index,
   886								tso.data, size,
   887								size == data_left,
   888								total_len == 0);
   889				if (ret)
   890					goto err_release;
   891	
   892				data_left -= size;
   893				tso_build_data(skb, &tso, size);
   894			}
   895	
   896			bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
   897		}
   898	
   899		/* Save skb pointer */
   900		txq->tx_buf[index].buf_p = skb;
   901	
   902		skb_tx_timestamp(skb);
   903		txq->bd.cur = bdp;
   904	
   905		/* Trigger transmission start */
   906		if (!(fep->quirks & FEC_QUIRK_ERR007885) ||
   907		    !readl(txq->bd.reg_desc_active) ||
   908		    !readl(txq->bd.reg_desc_active) ||
   909		    !readl(txq->bd.reg_desc_active) ||
   910		    !readl(txq->bd.reg_desc_active))
   911			writel(0, txq->bd.reg_desc_active);
   912	
   913		return 0;
   914	
   915	err_release:
   916		/* Release all used data descriptors for TSO */
 > 917		struct bufdesc *tmp_bdp = txq->bd.cur;
   918	
   919		while (tmp_bdp != bdp) {
   920			tmp_bdp->cbd_sc = 0;
   921			tmp_bdp->cbd_bufaddr = 0;
   922			tmp_bdp->cbd_datlen = 0;
   923			tmp_bdp = fec_enet_get_nextdesc(tmp_bdp, &txq->bd);
   924		}
   925	
   926		dev_kfree_skb_any(skb);
   927	
   928		return ret;
   929	}
   930	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

