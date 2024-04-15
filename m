Return-Path: <netdev+bounces-88130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A0B8A5DBB
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 00:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C828D1F218BE
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 22:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EB8158203;
	Mon, 15 Apr 2024 22:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LLZYNJly"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3B783CB7
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 22:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713220207; cv=none; b=ostSH0w8ldqlu2q1XcNy6tzlO+aQ5+1NoYHiKzIJJPtGwjg/1aOb6HA9lSp6sQ3c4vLQxCwcfSYR9QLL8oZP1TVsGJ0gm+spsFxEFOd+9KeSVRWoUjnCKjaBzT8XDy/fMzi+/ikKZJj2xUwmhg8jOgSGK1nibevEwLDn1z/0aM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713220207; c=relaxed/simple;
	bh=/3dTTCnKF/6DaP0nlP8pcaQFuHV41OQnv/ut9dtBY0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVFugu1jRRhJdT3Uq+PDwgo4FJlAoFl8NzV4qYkG9yujIOfyw00XUMn9UHSZnN9jejv9Jq+f+O6ztlAqTMC7yU5A1xJYqLDWyWBRN9UCf5tpO5ui/Rw2y05+5N2dszzOnuOTZ90ZWdw3zf2D8fFrG2lQ/W59pD1RJvuw8ceAk10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LLZYNJly; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713220205; x=1744756205;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/3dTTCnKF/6DaP0nlP8pcaQFuHV41OQnv/ut9dtBY0Q=;
  b=LLZYNJlyJY061j3AAmJJ5onPLPJJUH14OHDMJyA1EYiMLPeyACpg9uJz
   EHW6z2jWeHIUOly+LLlAJ9imI0iO/osBvUBXMa5dBaIO2XdLoeZeO8oin
   A3qu193QrHCdEH5YjhLIRsJUtLe0XJEvAc1ga0YlW+rrDzW6roI+BBvux
   ZR5IJFOiZyf8yLzYKOYXmYcbnCfmUhpJLXdAx67Gg+3bu/B5xnpn4KgFt
   t4AXbBni4h2M5BqTylKshwan0XOXlePO6cSbHiXP5oY0kc6TKTNE0JOZb
   m6E96JSEFX/zwQhlEdlgUZE39TWNEk7KmIrsa+rk8dqWVfg+yohWEwdEc
   Q==;
X-CSE-ConnectionGUID: /lJUzYCaS/mY80JK8jIUug==
X-CSE-MsgGUID: UKqwli45RI2bnbQ1wWgM6A==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8801153"
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="8801153"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 15:30:04 -0700
X-CSE-ConnectionGUID: wqzSVAAMTDeg05sbaLVVvQ==
X-CSE-MsgGUID: 8ZSiw5npSIKpc3dpJXKSMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="21950975"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 15 Apr 2024 15:30:02 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rwUpr-0004gO-3C;
	Mon, 15 Apr 2024 22:29:59 +0000
Date: Tue, 16 Apr 2024 06:29:25 +0800
From: kernel test robot <lkp@intel.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andrew@lunn.ch
Subject: Re: [PATCH net-next v1 3/5] net: tn40xx: add basic Tx handling
Message-ID: <202404160600.TORqdc7K-lkp@intel.com>
References: <20240415104352.4685-4-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415104352.4685-4-fujita.tomonori@gmail.com>

Hi FUJITA,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 32affa5578f0e6b9abef3623d3976395afbd265c]

url:    https://github.com/intel-lab-lkp/linux/commits/FUJITA-Tomonori/net-tn40xx-add-pci-driver-for-Tehuti-Networks-TN40xx-chips/20240415-185416
base:   32affa5578f0e6b9abef3623d3976395afbd265c
patch link:    https://lore.kernel.org/r/20240415104352.4685-4-fujita.tomonori%40gmail.com
patch subject: [PATCH net-next v1 3/5] net: tn40xx: add basic Tx handling
config: microblaze-allmodconfig (https://download.01.org/0day-ci/archive/20240416/202404160600.TORqdc7K-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240416/202404160600.TORqdc7K-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404160600.TORqdc7K-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/tehuti/tn40.c: In function 'bdx_start_xmit':
>> drivers/net/ethernet/tehuti/tn40.c:370:29: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     370 |         txdd->va_lo = (u32)((u64)skb);
         |                             ^
--
>> drivers/net/ethernet/tehuti/tn40.c:189: warning: expecting prototype for txdb_map_skb(). Prototype was for bdx_tx_map_skb() instead
>> drivers/net/ethernet/tehuti/tn40.c:323: warning: Function parameter or struct member 'priv' not described in 'bdx_tx_space'


vim +370 drivers/net/ethernet/tehuti/tn40.c

   171	
   172	/**
   173	 * txdb_map_skb - create and store DMA mappings for skb's data blocks
   174	 * @priv: NIC private structure
   175	 * @skb: socket buffer to map
   176	 * @txdd: pointer to tx descriptor to be updated
   177	 * @pkt_len: pointer to unsigned long value
   178	 *
   179	 * This function creates DMA mappings for skb's data blocks and writes them to
   180	 * PBL of a new tx descriptor. It also stores them in the tx db, so they could
   181	 * be unmapped after the data has been sent. It is the responsibility of the
   182	 * caller to make sure that there is enough space in the txdb. The last
   183	 * element holds a pointer to skb itself and is marked with a zero length.
   184	 *
   185	 * Return: 0 on success and negative value on error.
   186	 */
   187	static inline int bdx_tx_map_skb(struct bdx_priv *priv, struct sk_buff *skb,
   188					 struct txd_desc *txdd, unsigned int *pkt_len)
 > 189	{
   190		dma_addr_t dma;
   191		int i, len, err;
   192		struct txdb *db = &priv->txdb;
   193		struct pbl *pbl = &txdd->pbl[0];
   194		int nr_frags = skb_shinfo(skb)->nr_frags;
   195		unsigned int size;
   196		struct mapping_info info[MAX_PBL];
   197	
   198		netdev_dbg(priv->ndev, "TX skb %p skbLen %d dataLen %d frags %d\n", skb,
   199			   skb->len, skb->data_len, nr_frags);
   200		if (nr_frags > MAX_PBL - 1) {
   201			err = skb_linearize(skb);
   202			if (err)
   203				return -1;
   204			nr_frags = skb_shinfo(skb)->nr_frags;
   205		}
   206		/* initial skb */
   207		len = skb->len - skb->data_len;
   208		dma = dma_map_single(&priv->pdev->dev, skb->data, len,
   209				     DMA_TO_DEVICE);
   210		if (dma_mapping_error(&priv->pdev->dev, dma))
   211			return -1;
   212	
   213		bdx_set_txdb(db, dma, len);
   214		bdx_set_pbl(pbl++, db->wptr->addr.dma, db->wptr->len);
   215		*pkt_len = db->wptr->len;
   216	
   217		for (i = 0; i < nr_frags; i++) {
   218			skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
   219	
   220			size = skb_frag_size(frag);
   221			dma = skb_frag_dma_map(&priv->pdev->dev, frag, 0,
   222					       size, DMA_TO_DEVICE);
   223	
   224			if (dma_mapping_error(&priv->pdev->dev, dma))
   225				goto mapping_error;
   226			info[i].dma = dma;
   227			info[i].size = size;
   228		}
   229	
   230		for (i = 0; i < nr_frags; i++) {
   231			bdx_tx_db_inc_wptr(db);
   232			bdx_set_txdb(db, info[i].dma, info[i].size);
   233			bdx_set_pbl(pbl++, db->wptr->addr.dma, db->wptr->len);
   234			*pkt_len += db->wptr->len;
   235		}
   236	
   237		/* SHORT_PKT_FIX */
   238		if (skb->len < SHORT_PACKET_SIZE)
   239			++nr_frags;
   240	
   241		/* Add skb clean up info. */
   242		bdx_tx_db_inc_wptr(db);
   243		db->wptr->len = -txd_sizes[nr_frags].bytes;
   244		db->wptr->addr.skb = skb;
   245		bdx_tx_db_inc_wptr(db);
   246	
   247		return 0;
   248	 mapping_error:
   249		dma_unmap_page(&priv->pdev->dev, db->wptr->addr.dma, db->wptr->len, DMA_TO_DEVICE);
   250		for (; i > 0; i--)
   251			dma_unmap_page(&priv->pdev->dev, info[i - 1].dma, info[i - 1].size, DMA_TO_DEVICE);
   252		return -1;
   253	}
   254	
   255	static void init_txd_sizes(void)
   256	{
   257		int i, lwords;
   258	
   259		if (txd_sizes[0].bytes)
   260			return;
   261	
   262		/* 7 - is number of lwords in txd with one phys buffer
   263		 * 3 - is number of lwords used for every additional phys buffer
   264		 */
   265		for (i = 0; i < MAX_PBL; i++) {
   266			lwords = 7 + (i * 3);
   267			if (lwords & 1)
   268				lwords++;	/* pad it with 1 lword */
   269			txd_sizes[i].qwords = lwords >> 1;
   270			txd_sizes[i].bytes = lwords << 2;
   271		}
   272	}
   273	
   274	static int create_tx_ring(struct bdx_priv *priv)
   275	{
   276		int ret;
   277	
   278		ret = bdx_fifo_alloc(priv, &priv->txd_fifo0.m, priv->txd_size,
   279				     REG_TXD_CFG0_0, REG_TXD_CFG1_0,
   280				     REG_TXD_RPTR_0, REG_TXD_WPTR_0);
   281		if (ret)
   282			return ret;
   283	
   284		ret = bdx_fifo_alloc(priv, &priv->txf_fifo0.m, priv->txf_size,
   285				     REG_TXF_CFG0_0, REG_TXF_CFG1_0,
   286				     REG_TXF_RPTR_0, REG_TXF_WPTR_0);
   287		if (ret)
   288			goto err_free_txd;
   289	
   290		/* The TX db has to keep mappings for all packets sent (on
   291		 * TxD) and not yet reclaimed (on TxF).
   292		 */
   293		ret = bdx_tx_db_init(&priv->txdb, max(priv->txd_size, priv->txf_size));
   294		if (ret)
   295			goto err_free_txf;
   296	
   297		/* SHORT_PKT_FIX */
   298		priv->b0_len = 64;
   299		priv->b0_va =
   300			dma_alloc_coherent(&priv->pdev->dev, priv->b0_len, &priv->b0_dma, GFP_KERNEL);
   301		if (!priv->b0_va)
   302			goto err_free_db;
   303	
   304		priv->tx_level = BDX_MAX_TX_LEVEL;
   305		priv->tx_update_mark = priv->tx_level - 1024;
   306		return 0;
   307	err_free_db:
   308		bdx_tx_db_close(&priv->txdb);
   309	err_free_txf:
   310		bdx_fifo_free(priv, &priv->txf_fifo0.m);
   311	err_free_txd:
   312		bdx_fifo_free(priv, &priv->txd_fifo0.m);
   313		return ret;
   314	}
   315	
   316	/**
   317	 * bdx_tx_space - Calculate the available space in the TX fifo.
   318	 *
   319	 * @priv - NIC private structure
   320	 * Return: available space in TX fifo in bytes
   321	 */
   322	static inline int bdx_tx_space(struct bdx_priv *priv)
 > 323	{
   324		struct txd_fifo *f = &priv->txd_fifo0;
   325		int fsize;
   326	
   327		f->m.rptr = read_reg(priv, f->m.reg_rptr) & TXF_WPTR_WR_PTR;
   328		fsize = f->m.rptr - f->m.wptr;
   329		if (fsize <= 0)
   330			fsize = f->m.memsz + fsize;
   331		return fsize;
   332	}
   333	
   334	static int bdx_start_xmit(struct sk_buff *skb, struct net_device *ndev)
   335	{
   336		struct bdx_priv *priv = netdev_priv(ndev);
   337		struct txd_fifo *f = &priv->txd_fifo0;
   338		int txd_checksum = 7;	/* full checksum */
   339		int txd_lgsnd = 0;
   340		int txd_vlan_id = 0;
   341		int txd_vtag = 0;
   342		int txd_mss = 0;
   343		unsigned int pkt_len;
   344		struct txd_desc *txdd;
   345		int nr_frags, len, err;
   346	
   347		/* Build tx descriptor */
   348		txdd = (struct txd_desc *)(f->m.va + f->m.wptr);
   349		err = bdx_tx_map_skb(priv, skb, txdd, &pkt_len);
   350		if (err) {
   351			dev_kfree_skb(skb);
   352			return NETDEV_TX_OK;
   353		}
   354		nr_frags = skb_shinfo(skb)->nr_frags;
   355		if (unlikely(skb->ip_summed != CHECKSUM_PARTIAL))
   356			txd_checksum = 0;
   357	
   358		if (skb_shinfo(skb)->gso_size) {
   359			txd_mss = skb_shinfo(skb)->gso_size;
   360			txd_lgsnd = 1;
   361			netdev_dbg(priv->ndev, "skb %p pkt len %d gso size = %d\n", skb,
   362				   pkt_len, txd_mss);
   363		}
   364		if (skb_vlan_tag_present(skb)) {
   365			/* Don't cut VLAN ID to 12 bits */
   366			txd_vlan_id = skb_vlan_tag_get(skb);
   367			txd_vtag = 1;
   368		}
   369		txdd->va_hi = 0;
 > 370		txdd->va_lo = (u32)((u64)skb);
   371		txdd->length = cpu_to_le16(pkt_len);
   372		txdd->mss = cpu_to_le16(txd_mss);
   373		txdd->txd_val1 =
   374			cpu_to_le32(TXD_W1_VAL
   375				    (txd_sizes[nr_frags].qwords, txd_checksum,
   376				     txd_vtag, txd_lgsnd, txd_vlan_id));
   377		netdev_dbg(priv->ndev, "=== w1 qwords[%d] %d =====\n", nr_frags,
   378			   txd_sizes[nr_frags].qwords);
   379		netdev_dbg(priv->ndev, "=== TxD desc =====================\n");
   380		netdev_dbg(priv->ndev, "=== w1: 0x%x ================\n", txdd->txd_val1);
   381		netdev_dbg(priv->ndev, "=== w2: mss 0x%x len 0x%x\n", txdd->mss,
   382			   txdd->length);
   383		/* SHORT_PKT_FIX */
   384		if (pkt_len < SHORT_PACKET_SIZE) {
   385			struct pbl *pbl = &txdd->pbl[++nr_frags];
   386	
   387			txdd->length = cpu_to_le16(SHORT_PACKET_SIZE);
   388			txdd->txd_val1 =
   389				cpu_to_le32(TXD_W1_VAL
   390					    (txd_sizes[nr_frags].qwords,
   391					     txd_checksum, txd_vtag, txd_lgsnd,
   392					     txd_vlan_id));
   393			pbl->len = cpu_to_le32(SHORT_PACKET_SIZE - pkt_len);
   394			pbl->pa_lo = cpu_to_le32(L32_64(priv->b0_dma));
   395			pbl->pa_hi = cpu_to_le32(H32_64(priv->b0_dma));
   396			netdev_dbg(priv->ndev, "=== SHORT_PKT_FIX   ================\n");
   397			netdev_dbg(priv->ndev, "=== nr_frags : %d   ================\n",
   398				   nr_frags);
   399		}
   400	
   401		/* Increment TXD write pointer. In case of fifo wrapping copy
   402		 * reminder of the descriptor to the beginning.
   403		 */
   404		f->m.wptr += txd_sizes[nr_frags].bytes;
   405		len = f->m.wptr - f->m.memsz;
   406		if (unlikely(len >= 0)) {
   407			f->m.wptr = len;
   408			if (len > 0)
   409				memcpy(f->m.va, f->m.va + f->m.memsz, len);
   410		}
   411		/* Force memory writes to complete before letting the HW know
   412		 * there are new descriptors to fetch.
   413		 */
   414		wmb();
   415	
   416		priv->tx_level -= txd_sizes[nr_frags].bytes;
   417		if (priv->tx_level > priv->tx_update_mark) {
   418			write_reg(priv, f->m.reg_wptr,
   419				  f->m.wptr & TXF_WPTR_WR_PTR);
   420		} else {
   421			if (priv->tx_noupd++ > BDX_NO_UPD_PACKETS) {
   422				priv->tx_noupd = 0;
   423				write_reg(priv, f->m.reg_wptr,
   424					  f->m.wptr & TXF_WPTR_WR_PTR);
   425			}
   426		}
   427	
   428		netif_trans_update(ndev);
   429		priv->net_stats.tx_packets++;
   430		priv->net_stats.tx_bytes += pkt_len;
   431		if (priv->tx_level < BDX_MIN_TX_LEVEL) {
   432			netdev_dbg(priv->ndev, "TX Q STOP level %d\n", priv->tx_level);
   433			netif_stop_queue(ndev);
   434		}
   435	
   436		return NETDEV_TX_OK;
   437	}
   438	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

