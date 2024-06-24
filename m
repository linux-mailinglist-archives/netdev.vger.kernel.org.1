Return-Path: <netdev+bounces-106199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D37915308
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 17:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAE5F1C22B96
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 15:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D4319D884;
	Mon, 24 Jun 2024 15:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XlusyNJJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB8413E024;
	Mon, 24 Jun 2024 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719244762; cv=none; b=B9Qx6PupXbEeew1cAnM29v4Lkd39G58xKKMJsGSp0RFUzZBt6ft/4JAL9ETT/PFHAewQqLWz+HUKuC5db7JUgbywfWMBIW32A9IOoTip9ZQg3/eSAL1A6d/XC7O/DMIZVlerATDwemgTkoVI6GgaXQ2UsF2c76sQIZS06nwaNc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719244762; c=relaxed/simple;
	bh=QlQRvDcovkaqiX8QqFySm0UK0zjk+X4pV/Gqh9lAUKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3ooo/Qavil769PzToAmsKJeUt64t3wufee7OPLUL7ah+gprS+WrJ+WSVtAJLBiBNStD6QWL7rrdjVCxSmYC8BcwocXEbZ5H4nzXbwRombtTPXg53gEs0vVHiwY7wzsNyR1ReCZGRydBxD/vKe+oF5ZYORhc+RsWOqibpXWdwvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XlusyNJJ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719244760; x=1750780760;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QlQRvDcovkaqiX8QqFySm0UK0zjk+X4pV/Gqh9lAUKw=;
  b=XlusyNJJSw2vMjvZu2ili2gJD4Tl7SE6C44UiI5DV2zl6JI7hcUoBJhQ
   pTY9dD/lx3y+XV2leJlZ7+IRO+GHFaIukusIGLOHV399syT3JIHLsr4dc
   EQkzxnb1w05t0qiV9rYR0CeuBTg3P6hoaADAvJSxQO9n762SsKFGXKWzo
   U6Zh1IJnvY8o8AgnbiHxnpRo4s0v8jvevHKElMa8YrG4TAPGgvEye3EGN
   8aUWf53W71ReZlt/7GAhxOXb+CuQzwod9xnE0sR8xFaEUef2BbzgSDpFa
   5rV7rZKHgfKqLHhRtodWTbvDwZ/DgWvJWVVDdjp0AnkFiJSs2nU86ynY2
   g==;
X-CSE-ConnectionGUID: I7VCghcQTBa9GvgBS1ZkAQ==
X-CSE-MsgGUID: VQF00/VcSgyMrWi6bn5jZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="12217240"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="12217240"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 08:59:19 -0700
X-CSE-ConnectionGUID: 2WFT4yrcS/2ZExSil8CO7w==
X-CSE-MsgGUID: PmxySSG9T56qxAQRuQp3RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="43422423"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 24 Jun 2024 08:59:14 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sLm63-000DUN-2g;
	Mon, 24 Jun 2024 15:59:11 +0000
Date: Mon, 24 Jun 2024 23:58:50 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, nbd@nbd.name,
	lorenzo.bianconi83@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	conor@kernel.org, linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	catalin.marinas@arm.com, will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu, linux-clk@vger.kernel.org,
	rkannoth@marvell.com, sgoutham@marvell.com, andrew@lunn.ch
Subject: Re: [PATCH v2 net-next 2/2] net: airoha: Introduce ethernet support
 for EN7581 SoC
Message-ID: <202406242337.21CXNZvT-lkp@intel.com>
References: <f146a6f58492394a77f7d159f3c650a268fbe489.1718696209.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f146a6f58492394a77f7d159f3c650a268fbe489.1718696209.git.lorenzo@kernel.org>

Hi Lorenzo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Bianconi/dt-bindings-net-airoha-Add-EN7581-ethernet-controller/20240618-182217
base:   net-next/main
patch link:    https://lore.kernel.org/r/f146a6f58492394a77f7d159f3c650a268fbe489.1718696209.git.lorenzo%40kernel.org
patch subject: [PATCH v2 net-next 2/2] net: airoha: Introduce ethernet support for EN7581 SoC
config: arm64-randconfig-r121-20240623 (https://download.01.org/0day-ci/archive/20240624/202406242337.21CXNZvT-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project ad79a14c9e5ec4a369eed4adf567c22cc029863f)
reproduce: (https://download.01.org/0day-ci/archive/20240624/202406242337.21CXNZvT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406242337.21CXNZvT-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/mediatek/airoha_eth.c:1328:45: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __sum16 [usertype] check @@     got restricted __be16 [usertype] @@
   drivers/net/ethernet/mediatek/airoha_eth.c:1328:45: sparse:     expected restricted __sum16 [usertype] check
   drivers/net/ethernet/mediatek/airoha_eth.c:1328:45: sparse:     got restricted __be16 [usertype]
>> drivers/net/ethernet/mediatek/airoha_eth.c:1787:27: sparse: sparse: symbol 'of_airoha_match' was not declared. Should it be static?

vim +1328 drivers/net/ethernet/mediatek/airoha_eth.c

  1303	
  1304	static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
  1305					   struct net_device *dev)
  1306	{
  1307		struct skb_shared_info *sinfo = skb_shinfo(skb);
  1308		struct airoha_eth *eth = netdev_priv(dev);
  1309		int i, qid = skb_get_queue_mapping(skb);
  1310		u32 nr_frags, msg0 = 0, msg1;
  1311		u32 len = skb_headlen(skb);
  1312		struct netdev_queue *txq;
  1313		struct airoha_queue *q;
  1314		void *data = skb->data;
  1315		u16 index;
  1316	
  1317		if (skb->ip_summed == CHECKSUM_PARTIAL)
  1318			msg0 |= FIELD_PREP(QDMA_ETH_TXMSG_TCO_MASK, 1) |
  1319				FIELD_PREP(QDMA_ETH_TXMSG_UCO_MASK, 1) |
  1320				FIELD_PREP(QDMA_ETH_TXMSG_ICO_MASK, 1);
  1321	
  1322		/* TSO: fill MSS info in tcp checksum field */
  1323		if (skb_is_gso(skb)) {
  1324			if (skb_cow_head(skb, 0))
  1325				goto error;
  1326	
  1327			if (sinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)) {
> 1328				tcp_hdr(skb)->check = cpu_to_be16(sinfo->gso_size);
  1329				msg0 |= FIELD_PREP(QDMA_ETH_TXMSG_TSO_MASK, 1);
  1330			}
  1331		}
  1332	
  1333		msg1 = FIELD_PREP(QDMA_ETH_TXMSG_FPORT_MASK, DPORT_GDM1) |
  1334		       FIELD_PREP(QDMA_ETH_TXMSG_METER_MASK, 0x7f);
  1335	
  1336		if (WARN_ON_ONCE(qid >= ARRAY_SIZE(eth->q_tx)))
  1337			qid = 0;
  1338	
  1339		q = &eth->q_tx[qid];
  1340		if (WARN_ON_ONCE(!q->ndesc))
  1341			goto error;
  1342	
  1343		spin_lock_bh(&q->lock);
  1344	
  1345		nr_frags = 1 + sinfo->nr_frags;
  1346		if (q->queued + nr_frags > q->ndesc) {
  1347			/* not enough space in the queue */
  1348			spin_unlock_bh(&q->lock);
  1349			return NETDEV_TX_BUSY;
  1350		}
  1351	
  1352		index = q->head;
  1353		for (i = 0; i < nr_frags; i++) {
  1354			struct airoha_qdma_desc *desc = &q->desc[index];
  1355			struct airoha_queue_entry *e = &q->entry[index];
  1356			skb_frag_t *frag = &sinfo->frags[i];
  1357			dma_addr_t addr;
  1358			u32 val;
  1359	
  1360			addr = dma_map_single(dev->dev.parent, data, len,
  1361					      DMA_TO_DEVICE);
  1362			if (unlikely(dma_mapping_error(dev->dev.parent, addr)))
  1363				goto error_unmap;
  1364	
  1365			index = (index + 1) % q->ndesc;
  1366	
  1367			val = FIELD_PREP(QDMA_DESC_LEN_MASK, len);
  1368			if (i < nr_frags - 1)
  1369				val |= FIELD_PREP(QDMA_DESC_MORE_MASK, 1);
  1370			WRITE_ONCE(desc->ctrl, cpu_to_le32(val));
  1371			WRITE_ONCE(desc->addr, cpu_to_le32(addr));
  1372			val = FIELD_PREP(QDMA_DESC_NEXT_ID_MASK, index);
  1373			WRITE_ONCE(desc->data, cpu_to_le32(val));
  1374			WRITE_ONCE(desc->msg0, cpu_to_le32(msg0));
  1375			WRITE_ONCE(desc->msg1, cpu_to_le32(msg1));
  1376			WRITE_ONCE(desc->msg2, cpu_to_le32(0xffff));
  1377	
  1378			e->skb = i ? NULL : skb;
  1379			e->dma_addr = addr;
  1380			e->dma_len = len;
  1381	
  1382			wmb();
  1383			airoha_qdma_rmw(eth, REG_TX_CPU_IDX(qid), TX_RING_CPU_IDX_MASK,
  1384					FIELD_PREP(TX_RING_CPU_IDX_MASK, index));
  1385	
  1386			data = skb_frag_address(frag);
  1387			len = skb_frag_size(frag);
  1388		}
  1389	
  1390		q->head = index;
  1391		q->queued += i;
  1392	
  1393		txq = netdev_get_tx_queue(dev, qid);
  1394		netdev_tx_sent_queue(txq, skb->len);
  1395		skb_tx_timestamp(skb);
  1396	
  1397		if (q->ndesc - q->queued < q->free_thr)
  1398			netif_tx_stop_queue(txq);
  1399	
  1400		spin_unlock_bh(&q->lock);
  1401	
  1402		return NETDEV_TX_OK;
  1403	
  1404	error_unmap:
  1405		for (i--; i >= 0; i++)
  1406			dma_unmap_single(dev->dev.parent, q->entry[i].dma_addr,
  1407					 q->entry[i].dma_len, DMA_TO_DEVICE);
  1408	
  1409		spin_unlock_bh(&q->lock);
  1410	error:
  1411		dev_kfree_skb_any(skb);
  1412		dev->stats.tx_dropped++;
  1413	
  1414		return NETDEV_TX_OK;
  1415	}
  1416	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

