Return-Path: <netdev+bounces-230553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D84BEB0B5
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 19:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 388554E6236
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 17:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1A72FFF81;
	Fri, 17 Oct 2025 17:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PYiHBG0g"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9CB2459D9;
	Fri, 17 Oct 2025 17:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760721428; cv=none; b=BZ4m11drlucjvWBbVXc0RdmM1etJLRjVl2AUuDQdh6buBjEun9/pLMJhQFa7NPK+R2H1t5MkXYjtogczXc2+PnzNU9zuvSk4cneAuCfkmCvS6s17bKZJ29libqQCzmVyVBoH5FmvyjPssL+9R2aPpomcN9E4Yklj6ygem0DQJ1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760721428; c=relaxed/simple;
	bh=5HWbqOWYvfmFoiG9fvtGtU8661QNVQm7OM6kuBUg2po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKwlRShG8jS4SOJ5bx+jRklZN2wHzmpKzn24CTY09e6wByqWPAlHxVOY20VkpR3+p3c2oAsrRGoHXMuwT6bFxNfWRtQ136uqadU/5smG/kAV/uhmd+rdJ3rnnNW/M2ilnHHYygxMYdyaBfglH308bu23Ws1aKZw9gMKszi0EYqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PYiHBG0g; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760721426; x=1792257426;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5HWbqOWYvfmFoiG9fvtGtU8661QNVQm7OM6kuBUg2po=;
  b=PYiHBG0gZfj2Y4F1+dOjDQsEmuo79JHmMMcDW+tiqyZrz1//Z2dxG5gd
   BCAwGwWGguO5Ku7oU62G9qscsM1M3pW2lLJRG0l1b21gmamvgcPp/OBTN
   hdPT4/xzWixISkLMZ72CSo5h6DGvFPRd7RLDV4GBKMqeegXpUi7Y3TPgC
   +azu2VtVwiIhljK7fd3q17lGwA1QK+Nr6QdgFEmQn6bXIaJ9WXKcWpYsE
   JB+xACUJ2s4L+2PmVQjlGIxSqRwyR0T3LVsPDJKze+nH9OeQkmanBWfLm
   6szA72Ix4sL4zs2VOSMebk0xEvembTgcBYAzBRHDPswzaFinYdTE15LqH
   Q==;
X-CSE-ConnectionGUID: zGktkyifTTqmukasEAgtLg==
X-CSE-MsgGUID: EgvG5Rt/RgKWe5YvLW/Ahw==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="62984896"
X-IronPort-AV: E=Sophos;i="6.19,237,1754982000"; 
   d="scan'208";a="62984896"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 10:17:05 -0700
X-CSE-ConnectionGUID: e0YFpg1DTJ6ZU84CZtiGig==
X-CSE-MsgGUID: C+dZUDN6RhW+z4W8B8yqbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,237,1754982000"; 
   d="scan'208";a="187878775"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 17 Oct 2025 10:17:01 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9o4Y-0007bX-2d;
	Fri, 17 Oct 2025 17:16:58 +0000
Date: Sat, 18 Oct 2025 01:16:19 +0800
From: kernel test robot <lkp@intel.com>
To: Rohan G Thomas via B4 Relay <devnull+rohan.g.thomas.altera.com@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Rohan G Thomas <rohan.g.thomas@intel.com>,
	Boon Khai Ng <boon.khai.ng@altera.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: Re: [PATCH net v3 2/3] net: stmmac: Consider Tx VLAN offload tag
 length for maxSDU
Message-ID: <202510180039.zqD7oO26-lkp@intel.com>
References: <20251017-qbv-fixes-v3-2-d3a42e32646a@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-qbv-fixes-v3-2-d3a42e32646a@altera.com>

Hi Rohan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on cb85ca4c0a349e246cd35161088aa3689ae5c580]

url:    https://github.com/intel-lab-lkp/linux/commits/Rohan-G-Thomas-via-B4-Relay/net-stmmac-vlan-Disable-802-1AD-tag-insertion-offload/20251017-144104
base:   cb85ca4c0a349e246cd35161088aa3689ae5c580
patch link:    https://lore.kernel.org/r/20251017-qbv-fixes-v3-2-d3a42e32646a%40altera.com
patch subject: [PATCH net v3 2/3] net: stmmac: Consider Tx VLAN offload tag length for maxSDU
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20251018/202510180039.zqD7oO26-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251018/202510180039.zqD7oO26-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510180039.zqD7oO26-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:4503:6: warning: variable 'sdu_len' set but not used [-Wunused-but-set-variable]
    4503 |         u32 sdu_len;
         |             ^
   1 warning generated.


vim +/sdu_len +4503 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

  4478	
  4479	/**
  4480	 *  stmmac_xmit - Tx entry point of the driver
  4481	 *  @skb : the socket buffer
  4482	 *  @dev : device pointer
  4483	 *  Description : this is the tx entry point of the driver.
  4484	 *  It programs the chain or the ring and supports oversized frames
  4485	 *  and SG feature.
  4486	 */
  4487	static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
  4488	{
  4489		unsigned int first_entry, tx_packets, enh_desc;
  4490		struct stmmac_priv *priv = netdev_priv(dev);
  4491		unsigned int nopaged_len = skb_headlen(skb);
  4492		int i, csum_insertion = 0, is_jumbo = 0;
  4493		u32 queue = skb_get_queue_mapping(skb);
  4494		int nfrags = skb_shinfo(skb)->nr_frags;
  4495		int gso = skb_shinfo(skb)->gso_type;
  4496		struct stmmac_txq_stats *txq_stats;
  4497		struct dma_edesc *tbs_desc = NULL;
  4498		struct dma_desc *desc, *first;
  4499		struct stmmac_tx_queue *tx_q;
  4500		bool has_vlan, set_ic;
  4501		int entry, first_tx;
  4502		dma_addr_t des;
> 4503		u32 sdu_len;
  4504	
  4505		tx_q = &priv->dma_conf.tx_queue[queue];
  4506		txq_stats = &priv->xstats.txq_stats[queue];
  4507		first_tx = tx_q->cur_tx;
  4508	
  4509		if (priv->tx_path_in_lpi_mode && priv->eee_sw_timer_en)
  4510			stmmac_stop_sw_lpi(priv);
  4511	
  4512		/* Manage oversized TCP frames for GMAC4 device */
  4513		if (skb_is_gso(skb) && priv->tso) {
  4514			if (gso & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))
  4515				return stmmac_tso_xmit(skb, dev);
  4516			if (priv->plat->has_gmac4 && (gso & SKB_GSO_UDP_L4))
  4517				return stmmac_tso_xmit(skb, dev);
  4518		}
  4519	
  4520		if (unlikely(stmmac_tx_avail(priv, queue) < nfrags + 1)) {
  4521			if (!netif_tx_queue_stopped(netdev_get_tx_queue(dev, queue))) {
  4522				netif_tx_stop_queue(netdev_get_tx_queue(priv->dev,
  4523									queue));
  4524				/* This is a hard error, log it. */
  4525				netdev_err(priv->dev,
  4526					   "%s: Tx Ring full when queue awake\n",
  4527					   __func__);
  4528			}
  4529			return NETDEV_TX_BUSY;
  4530		}
  4531	
  4532		sdu_len = skb->len;
  4533		/* Check if VLAN can be inserted by HW */
  4534		has_vlan = stmmac_vlan_insert(priv, skb, tx_q);
  4535		if (has_vlan)
  4536			sdu_len += VLAN_HLEN;
  4537	
  4538		if (priv->est && priv->est->enable &&
  4539		    priv->est->max_sdu[queue] &&
  4540		    skb->len > priv->est->max_sdu[queue]){
  4541			priv->xstats.max_sdu_txq_drop[queue]++;
  4542			goto max_sdu_err;
  4543		}
  4544	
  4545		entry = tx_q->cur_tx;
  4546		first_entry = entry;
  4547		WARN_ON(tx_q->tx_skbuff[first_entry]);
  4548	
  4549		csum_insertion = (skb->ip_summed == CHECKSUM_PARTIAL);
  4550		/* DWMAC IPs can be synthesized to support tx coe only for a few tx
  4551		 * queues. In that case, checksum offloading for those queues that don't
  4552		 * support tx coe needs to fallback to software checksum calculation.
  4553		 *
  4554		 * Packets that won't trigger the COE e.g. most DSA-tagged packets will
  4555		 * also have to be checksummed in software.
  4556		 */
  4557		if (csum_insertion &&
  4558		    (priv->plat->tx_queues_cfg[queue].coe_unsupported ||
  4559		     !stmmac_has_ip_ethertype(skb))) {
  4560			if (unlikely(skb_checksum_help(skb)))
  4561				goto dma_map_err;
  4562			csum_insertion = !csum_insertion;
  4563		}
  4564	
  4565		if (likely(priv->extend_desc))
  4566			desc = (struct dma_desc *)(tx_q->dma_etx + entry);
  4567		else if (tx_q->tbs & STMMAC_TBS_AVAIL)
  4568			desc = &tx_q->dma_entx[entry].basic;
  4569		else
  4570			desc = tx_q->dma_tx + entry;
  4571	
  4572		first = desc;
  4573	
  4574		if (has_vlan)
  4575			stmmac_set_desc_vlan(priv, first, STMMAC_VLAN_INSERT);
  4576	
  4577		enh_desc = priv->plat->enh_desc;
  4578		/* To program the descriptors according to the size of the frame */
  4579		if (enh_desc)
  4580			is_jumbo = stmmac_is_jumbo_frm(priv, skb->len, enh_desc);
  4581	
  4582		if (unlikely(is_jumbo)) {
  4583			entry = stmmac_jumbo_frm(priv, tx_q, skb, csum_insertion);
  4584			if (unlikely(entry < 0) && (entry != -EINVAL))
  4585				goto dma_map_err;
  4586		}
  4587	
  4588		for (i = 0; i < nfrags; i++) {
  4589			const skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
  4590			int len = skb_frag_size(frag);
  4591			bool last_segment = (i == (nfrags - 1));
  4592	
  4593			entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_tx_size);
  4594			WARN_ON(tx_q->tx_skbuff[entry]);
  4595	
  4596			if (likely(priv->extend_desc))
  4597				desc = (struct dma_desc *)(tx_q->dma_etx + entry);
  4598			else if (tx_q->tbs & STMMAC_TBS_AVAIL)
  4599				desc = &tx_q->dma_entx[entry].basic;
  4600			else
  4601				desc = tx_q->dma_tx + entry;
  4602	
  4603			des = skb_frag_dma_map(priv->device, frag, 0, len,
  4604					       DMA_TO_DEVICE);
  4605			if (dma_mapping_error(priv->device, des))
  4606				goto dma_map_err; /* should reuse desc w/o issues */
  4607	
  4608			tx_q->tx_skbuff_dma[entry].buf = des;
  4609	
  4610			stmmac_set_desc_addr(priv, desc, des);
  4611	
  4612			tx_q->tx_skbuff_dma[entry].map_as_page = true;
  4613			tx_q->tx_skbuff_dma[entry].len = len;
  4614			tx_q->tx_skbuff_dma[entry].last_segment = last_segment;
  4615			tx_q->tx_skbuff_dma[entry].buf_type = STMMAC_TXBUF_T_SKB;
  4616	
  4617			/* Prepare the descriptor and set the own bit too */
  4618			stmmac_prepare_tx_desc(priv, desc, 0, len, csum_insertion,
  4619					priv->mode, 1, last_segment, skb->len);
  4620		}
  4621	
  4622		/* Only the last descriptor gets to point to the skb. */
  4623		tx_q->tx_skbuff[entry] = skb;
  4624		tx_q->tx_skbuff_dma[entry].buf_type = STMMAC_TXBUF_T_SKB;
  4625	
  4626		/* According to the coalesce parameter the IC bit for the latest
  4627		 * segment is reset and the timer re-started to clean the tx status.
  4628		 * This approach takes care about the fragments: desc is the first
  4629		 * element in case of no SG.
  4630		 */
  4631		tx_packets = (entry + 1) - first_tx;
  4632		tx_q->tx_count_frames += tx_packets;
  4633	
  4634		if ((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) && priv->hwts_tx_en)
  4635			set_ic = true;
  4636		else if (!priv->tx_coal_frames[queue])
  4637			set_ic = false;
  4638		else if (tx_packets > priv->tx_coal_frames[queue])
  4639			set_ic = true;
  4640		else if ((tx_q->tx_count_frames %
  4641			  priv->tx_coal_frames[queue]) < tx_packets)
  4642			set_ic = true;
  4643		else
  4644			set_ic = false;
  4645	
  4646		if (set_ic) {
  4647			if (likely(priv->extend_desc))
  4648				desc = &tx_q->dma_etx[entry].basic;
  4649			else if (tx_q->tbs & STMMAC_TBS_AVAIL)
  4650				desc = &tx_q->dma_entx[entry].basic;
  4651			else
  4652				desc = &tx_q->dma_tx[entry];
  4653	
  4654			tx_q->tx_count_frames = 0;
  4655			stmmac_set_tx_ic(priv, desc);
  4656		}
  4657	
  4658		/* We've used all descriptors we need for this skb, however,
  4659		 * advance cur_tx so that it references a fresh descriptor.
  4660		 * ndo_start_xmit will fill this descriptor the next time it's
  4661		 * called and stmmac_tx_clean may clean up to this descriptor.
  4662		 */
  4663		entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_tx_size);
  4664		tx_q->cur_tx = entry;
  4665	
  4666		if (netif_msg_pktdata(priv)) {
  4667			netdev_dbg(priv->dev,
  4668				   "%s: curr=%d dirty=%d f=%d, e=%d, first=%p, nfrags=%d",
  4669				   __func__, tx_q->cur_tx, tx_q->dirty_tx, first_entry,
  4670				   entry, first, nfrags);
  4671	
  4672			netdev_dbg(priv->dev, ">>> frame to be transmitted: ");
  4673			print_pkt(skb->data, skb->len);
  4674		}
  4675	
  4676		if (unlikely(stmmac_tx_avail(priv, queue) <= (MAX_SKB_FRAGS + 1))) {
  4677			netif_dbg(priv, hw, priv->dev, "%s: stop transmitted packets\n",
  4678				  __func__);
  4679			netif_tx_stop_queue(netdev_get_tx_queue(priv->dev, queue));
  4680		}
  4681	
  4682		u64_stats_update_begin(&txq_stats->q_syncp);
  4683		u64_stats_add(&txq_stats->q.tx_bytes, skb->len);
  4684		if (set_ic)
  4685			u64_stats_inc(&txq_stats->q.tx_set_ic_bit);
  4686		u64_stats_update_end(&txq_stats->q_syncp);
  4687	
  4688		if (priv->sarc_type)
  4689			stmmac_set_desc_sarc(priv, first, priv->sarc_type);
  4690	
  4691		/* Ready to fill the first descriptor and set the OWN bit w/o any
  4692		 * problems because all the descriptors are actually ready to be
  4693		 * passed to the DMA engine.
  4694		 */
  4695		if (likely(!is_jumbo)) {
  4696			bool last_segment = (nfrags == 0);
  4697	
  4698			des = dma_map_single(priv->device, skb->data,
  4699					     nopaged_len, DMA_TO_DEVICE);
  4700			if (dma_mapping_error(priv->device, des))
  4701				goto dma_map_err;
  4702	
  4703			tx_q->tx_skbuff_dma[first_entry].buf = des;
  4704			tx_q->tx_skbuff_dma[first_entry].buf_type = STMMAC_TXBUF_T_SKB;
  4705			tx_q->tx_skbuff_dma[first_entry].map_as_page = false;
  4706	
  4707			stmmac_set_desc_addr(priv, first, des);
  4708	
  4709			tx_q->tx_skbuff_dma[first_entry].len = nopaged_len;
  4710			tx_q->tx_skbuff_dma[first_entry].last_segment = last_segment;
  4711	
  4712			if (unlikely((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
  4713				     priv->hwts_tx_en)) {
  4714				/* declare that device is doing timestamping */
  4715				skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
  4716				stmmac_enable_tx_timestamp(priv, first);
  4717			}
  4718	
  4719			/* Prepare the first descriptor setting the OWN bit too */
  4720			stmmac_prepare_tx_desc(priv, first, 1, nopaged_len,
  4721					csum_insertion, priv->mode, 0, last_segment,
  4722					skb->len);
  4723		}
  4724	
  4725		if (tx_q->tbs & STMMAC_TBS_EN) {
  4726			struct timespec64 ts = ns_to_timespec64(skb->tstamp);
  4727	
  4728			tbs_desc = &tx_q->dma_entx[first_entry];
  4729			stmmac_set_desc_tbs(priv, tbs_desc, ts.tv_sec, ts.tv_nsec);
  4730		}
  4731	
  4732		stmmac_set_tx_owner(priv, first);
  4733	
  4734		netdev_tx_sent_queue(netdev_get_tx_queue(dev, queue), skb->len);
  4735	
  4736		stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
  4737		skb_tx_timestamp(skb);
  4738		stmmac_flush_tx_descriptors(priv, queue);
  4739		stmmac_tx_timer_arm(priv, queue);
  4740	
  4741		return NETDEV_TX_OK;
  4742	
  4743	dma_map_err:
  4744		netdev_err(priv->dev, "Tx DMA map failed\n");
  4745	max_sdu_err:
  4746		dev_kfree_skb(skb);
  4747		priv->xstats.tx_dropped++;
  4748		return NETDEV_TX_OK;
  4749	}
  4750	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

