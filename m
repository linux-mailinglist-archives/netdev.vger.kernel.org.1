Return-Path: <netdev+bounces-105561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC84A911C1B
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 08:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 637DB1F24464
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 06:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F637130ADA;
	Fri, 21 Jun 2024 06:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D++1zZPI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292ED12D1EB
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 06:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718952489; cv=none; b=R2TZH0QepSiTOmA+SZ3iDI/JhLM/lakFbKfGx/h170tICXLB/3ZEEZY1l/eMFTZPuS0pUVJAJzBb3F1Raplptr0jXVXAsCJIBPDWR7FFcrAOfxxoY248SNJRzQcb9a11izW42kmn8NE3WSu3hkrfjhgWp8jnkY0HNwR7EHuBzWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718952489; c=relaxed/simple;
	bh=NDc/75pDXad38C/zGc+d+UAIROD+w2LRxECzaom97Sg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TV8IHbxMwdhB4XUpQ30OcHTBF9xF4Qy22PZVagdlSoWqCZwyOwSwmmfo8tuKmP8RaICp+wdMZtRGaY1Q8s94cyvC4kxF/rYOYQkCF2G4So5Ayr/dYSQo+69JkQcrQbYdBHfGfqZn/yxQIbF606xDANVti2x5ILxnagqjaAVxLpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D++1zZPI; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57d280e2d5dso1015158a12.1
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 23:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718952484; x=1719557284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j9Lc6oXf30TZuTdbD5PwTytKR9vomSEwuW2Oz8Ur1w8=;
        b=D++1zZPI6FX/7auw30jxGogscQhf9UVWP4bSQWXg8exfde0Sd4vpdTL42tTx9ZThxZ
         HaQNWb/I1oMYkJ/dSj9zOM6YEXqxYEUeMq4jWVZl/lHyzcJETrgdAY6UMvZTYWMWCRra
         tH86WW5I27zUXIFGudY8huPE48paV6rh+BeLKsN1oRBfmoSsRoDLGfnp6ex7ow9u2tiR
         Dp4dE/DhQeIHWuccWNsICJ6R3o2ElVI8c1Z55nH8R7xl/8dlODGWymJvM+SUhu3Cg9Gg
         kbq5CIaRM0TPBbG6L/Ez3LjNI5vLCM4FJJu8dbFHTd4GbuEAccwJTdqhb6hvMscxbUvI
         U6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718952484; x=1719557284;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j9Lc6oXf30TZuTdbD5PwTytKR9vomSEwuW2Oz8Ur1w8=;
        b=jMJieYGcTl7dpImf05xB8ZK25wLEiFKxW3ieQ4BtF14MGMi2YnTYK4xLa8OQshXVTY
         15mgu8goAtZcb7dQwpIzKxU3rlzAPxlXGlUI2+yxWUus+CLRTa5wBjIJRw10O/EcAMEZ
         7w1yGivroimZxJr8pCz/5yDrJe8gmI0B8sxCjaK2stiyGc+9HVQ6VJKZX0rcMn0T7dPR
         89HGbHGdX7jAUE732P8987nsBzSxaNnJ45cWVCfkX+tl4B4s2/6FS4GrDKtDpAFTHaf+
         pcN6DSuNEO5NGsYfFQgishcSncWHcCxYbRD/AhgM2mqIbuLKgjU8cvT09WSkOUdDMAlq
         9mIw==
X-Forwarded-Encrypted: i=1; AJvYcCUP4uJG8K37xn1DC0YZb7+2BMxF0USzGommEi/jKlWTEKanYorRrKuwOE5gi4P4bp8gmJPFpMVDSnPCj5hckmARGYLsL11C
X-Gm-Message-State: AOJu0YywGl0zQIwOPkg982yqJGS+X6X6qx7/HGWhTYgvu8Hg8eaLdrPo
	2e/0tMjg8ATInDYRFJMfBFu2bO2S1Uo+StIjcMiPMZmD5qNymIAg1VFXRAQIa3s=
X-Google-Smtp-Source: AGHT+IEs/3JdTjTdn7IsyG5WSDbYRbG+9UWhZ6btsDLDaywPFTG5G2sehNTzimSEZPqrjd76W140JQ==
X-Received: by 2002:a17:907:a80f:b0:a6f:b67d:959e with SMTP id a640c23a62f3a-a6fb67d9870mr418077166b.53.1718952484146;
        Thu, 20 Jun 2024 23:48:04 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf54944esm48179866b.101.2024.06.20.23.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 23:48:03 -0700 (PDT)
Date: Fri, 21 Jun 2024 09:48:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Taehee Yoo <ap420073@gmail.com>,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, shannon.nelson@amd.com, brett.creeley@amd.com,
	drivers@pensando.io, netdev@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, ap420073@gmail.com,
	jacob.e.keller@intel.com
Subject: Re: [PATCH net] ionic: fix kernel panic due to multi-buffer handling
Message-ID: <802ab365-7f48-49b8-8f03-a06a119c4386@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618041412.3184919-1-ap420073@gmail.com>

Hi Taehee,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Taehee-Yoo/ionic-fix-kernel-panic-due-to-multi-buffer-handling/20240618-121629
base:   net/main
patch link:    https://lore.kernel.org/r/20240618041412.3184919-1-ap420073%40gmail.com
patch subject: [PATCH net] ionic: fix kernel panic due to multi-buffer handling
config: x86_64-randconfig-161-20240620 (https://download.01.org/0day-ci/archive/20240621/202406211040.17BtI0lu-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202406211040.17BtI0lu-lkp@intel.com/

New smatch warnings:
drivers/net/ethernet/pensando/ionic/ionic_txrx.c:588 ionic_run_xdp() error: uninitialized symbol 'sinfo'.

Old smatch warnings:
drivers/net/ethernet/pensando/ionic/ionic_txrx.c:253 ionic_rx_build_skb() warn: variable dereferenced before check 'buf_info->page' (see line 237)
drivers/net/ethernet/pensando/ionic/ionic_txrx.c:614 ionic_run_xdp() error: uninitialized symbol 'sinfo'.

vim +/sinfo +588 drivers/net/ethernet/pensando/ionic/ionic_txrx.c

180e35cdf035d1 Shannon Nelson 2024-02-14  483  static bool ionic_run_xdp(struct ionic_rx_stats *stats,
180e35cdf035d1 Shannon Nelson 2024-02-14  484  			  struct net_device *netdev,
180e35cdf035d1 Shannon Nelson 2024-02-14  485  			  struct bpf_prog *xdp_prog,
180e35cdf035d1 Shannon Nelson 2024-02-14  486  			  struct ionic_queue *rxq,
180e35cdf035d1 Shannon Nelson 2024-02-14  487  			  struct ionic_buf_info *buf_info,
180e35cdf035d1 Shannon Nelson 2024-02-14  488  			  int len)
180e35cdf035d1 Shannon Nelson 2024-02-14  489  {
17cb07b96a5f58 Taehee Yoo     2024-06-18  490  	int remain_len, frag_len, i, err = 0;
17cb07b96a5f58 Taehee Yoo     2024-06-18  491  	struct skb_shared_info *sinfo;
180e35cdf035d1 Shannon Nelson 2024-02-14  492  	u32 xdp_action = XDP_ABORTED;
180e35cdf035d1 Shannon Nelson 2024-02-14  493  	struct xdp_buff xdp_buf;
8eeed8373e1cca Shannon Nelson 2024-02-14  494  	struct ionic_queue *txq;
8eeed8373e1cca Shannon Nelson 2024-02-14  495  	struct netdev_queue *nq;
8eeed8373e1cca Shannon Nelson 2024-02-14  496  	struct xdp_frame *xdpf;
180e35cdf035d1 Shannon Nelson 2024-02-14  497  
180e35cdf035d1 Shannon Nelson 2024-02-14  498  	xdp_init_buff(&xdp_buf, IONIC_PAGE_SIZE, rxq->xdp_rxq_info);
5377805dc1c02a Shannon Nelson 2024-02-14  499  	frag_len = min_t(u16, len, IONIC_XDP_MAX_LINEAR_MTU + VLAN_ETH_HLEN);
180e35cdf035d1 Shannon Nelson 2024-02-14  500  	xdp_prepare_buff(&xdp_buf, ionic_rx_buf_va(buf_info),
5377805dc1c02a Shannon Nelson 2024-02-14  501  			 XDP_PACKET_HEADROOM, frag_len, false);
180e35cdf035d1 Shannon Nelson 2024-02-14  502  
180e35cdf035d1 Shannon Nelson 2024-02-14  503  	dma_sync_single_range_for_cpu(rxq->dev, ionic_rx_buf_pa(buf_info),
f81da39bf4c0a5 Shannon Nelson 2024-02-14  504  				      XDP_PACKET_HEADROOM, len,
180e35cdf035d1 Shannon Nelson 2024-02-14  505  				      DMA_FROM_DEVICE);
180e35cdf035d1 Shannon Nelson 2024-02-14  506  
180e35cdf035d1 Shannon Nelson 2024-02-14  507  	prefetchw(&xdp_buf.data_hard_start);
180e35cdf035d1 Shannon Nelson 2024-02-14  508  
5377805dc1c02a Shannon Nelson 2024-02-14  509  	/*  We limit MTU size to one buffer if !xdp_has_frags, so
5377805dc1c02a Shannon Nelson 2024-02-14  510  	 *  if the recv len is bigger than one buffer
5377805dc1c02a Shannon Nelson 2024-02-14  511  	 *     then we know we have frag info to gather
5377805dc1c02a Shannon Nelson 2024-02-14  512  	 */
5377805dc1c02a Shannon Nelson 2024-02-14  513  	remain_len = len - frag_len;
5377805dc1c02a Shannon Nelson 2024-02-14  514  	if (remain_len) {
5377805dc1c02a Shannon Nelson 2024-02-14  515  		struct ionic_buf_info *bi;
5377805dc1c02a Shannon Nelson 2024-02-14  516  		skb_frag_t *frag;
5377805dc1c02a Shannon Nelson 2024-02-14  517  
5377805dc1c02a Shannon Nelson 2024-02-14  518  		bi = buf_info;
5377805dc1c02a Shannon Nelson 2024-02-14  519  		sinfo = xdp_get_shared_info_from_buff(&xdp_buf);
5377805dc1c02a Shannon Nelson 2024-02-14  520  		sinfo->nr_frags = 0;
5377805dc1c02a Shannon Nelson 2024-02-14  521  		sinfo->xdp_frags_size = 0;
5377805dc1c02a Shannon Nelson 2024-02-14  522  		xdp_buff_set_frags_flag(&xdp_buf);
5377805dc1c02a Shannon Nelson 2024-02-14  523  
5377805dc1c02a Shannon Nelson 2024-02-14  524  		do {
5377805dc1c02a Shannon Nelson 2024-02-14  525  			if (unlikely(sinfo->nr_frags >= MAX_SKB_FRAGS)) {
5377805dc1c02a Shannon Nelson 2024-02-14  526  				err = -ENOSPC;
5377805dc1c02a Shannon Nelson 2024-02-14  527  				goto out_xdp_abort;
5377805dc1c02a Shannon Nelson 2024-02-14  528  			}
5377805dc1c02a Shannon Nelson 2024-02-14  529  
5377805dc1c02a Shannon Nelson 2024-02-14  530  			frag = &sinfo->frags[sinfo->nr_frags];
5377805dc1c02a Shannon Nelson 2024-02-14  531  			sinfo->nr_frags++;
5377805dc1c02a Shannon Nelson 2024-02-14  532  			bi++;
5377805dc1c02a Shannon Nelson 2024-02-14  533  			frag_len = min_t(u16, remain_len, ionic_rx_buf_size(bi));
5377805dc1c02a Shannon Nelson 2024-02-14  534  			dma_sync_single_range_for_cpu(rxq->dev, ionic_rx_buf_pa(bi),
5377805dc1c02a Shannon Nelson 2024-02-14  535  						      0, frag_len, DMA_FROM_DEVICE);
5377805dc1c02a Shannon Nelson 2024-02-14  536  			skb_frag_fill_page_desc(frag, bi->page, 0, frag_len);
5377805dc1c02a Shannon Nelson 2024-02-14  537  			sinfo->xdp_frags_size += frag_len;
5377805dc1c02a Shannon Nelson 2024-02-14  538  			remain_len -= frag_len;
5377805dc1c02a Shannon Nelson 2024-02-14  539  
5377805dc1c02a Shannon Nelson 2024-02-14  540  			if (page_is_pfmemalloc(bi->page))
5377805dc1c02a Shannon Nelson 2024-02-14  541  				xdp_buff_set_frag_pfmemalloc(&xdp_buf);
5377805dc1c02a Shannon Nelson 2024-02-14  542  		} while (remain_len > 0);
5377805dc1c02a Shannon Nelson 2024-02-14  543  	}

sinfo uninitialized on else path.

5377805dc1c02a Shannon Nelson 2024-02-14  544  
180e35cdf035d1 Shannon Nelson 2024-02-14  545  	xdp_action = bpf_prog_run_xdp(xdp_prog, &xdp_buf);
180e35cdf035d1 Shannon Nelson 2024-02-14  546  
180e35cdf035d1 Shannon Nelson 2024-02-14  547  	switch (xdp_action) {
180e35cdf035d1 Shannon Nelson 2024-02-14  548  	case XDP_PASS:
180e35cdf035d1 Shannon Nelson 2024-02-14  549  		stats->xdp_pass++;
180e35cdf035d1 Shannon Nelson 2024-02-14  550  		return false;  /* false = we didn't consume the packet */
180e35cdf035d1 Shannon Nelson 2024-02-14  551  
180e35cdf035d1 Shannon Nelson 2024-02-14  552  	case XDP_DROP:
180e35cdf035d1 Shannon Nelson 2024-02-14  553  		ionic_rx_page_free(rxq, buf_info);
180e35cdf035d1 Shannon Nelson 2024-02-14  554  		stats->xdp_drop++;
180e35cdf035d1 Shannon Nelson 2024-02-14  555  		break;
180e35cdf035d1 Shannon Nelson 2024-02-14  556  
180e35cdf035d1 Shannon Nelson 2024-02-14  557  	case XDP_TX:
8eeed8373e1cca Shannon Nelson 2024-02-14  558  		xdpf = xdp_convert_buff_to_frame(&xdp_buf);
8eeed8373e1cca Shannon Nelson 2024-02-14  559  		if (!xdpf)
8eeed8373e1cca Shannon Nelson 2024-02-14  560  			goto out_xdp_abort;
8eeed8373e1cca Shannon Nelson 2024-02-14  561  
8eeed8373e1cca Shannon Nelson 2024-02-14  562  		txq = rxq->partner;
8eeed8373e1cca Shannon Nelson 2024-02-14  563  		nq = netdev_get_tx_queue(netdev, txq->index);
8eeed8373e1cca Shannon Nelson 2024-02-14  564  		__netif_tx_lock(nq, smp_processor_id());
8eeed8373e1cca Shannon Nelson 2024-02-14  565  		txq_trans_cond_update(nq);
8eeed8373e1cca Shannon Nelson 2024-02-14  566  
8eeed8373e1cca Shannon Nelson 2024-02-14  567  		if (netif_tx_queue_stopped(nq) ||
1937b7ab6bd6bd Brett Creeley  2024-02-29  568  		    !netif_txq_maybe_stop(q_to_ndq(netdev, txq),
061b9bedbef124 Brett Creeley  2024-02-29  569  					  ionic_q_space_avail(txq),
061b9bedbef124 Brett Creeley  2024-02-29  570  					  1, 1)) {
8eeed8373e1cca Shannon Nelson 2024-02-14  571  			__netif_tx_unlock(nq);
8eeed8373e1cca Shannon Nelson 2024-02-14  572  			goto out_xdp_abort;
8eeed8373e1cca Shannon Nelson 2024-02-14  573  		}
8eeed8373e1cca Shannon Nelson 2024-02-14  574  
8eeed8373e1cca Shannon Nelson 2024-02-14  575  		dma_unmap_page(rxq->dev, buf_info->dma_addr,
8eeed8373e1cca Shannon Nelson 2024-02-14  576  			       IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
1937b7ab6bd6bd Brett Creeley  2024-02-29  577  		err = ionic_xdp_post_frame(txq, xdpf, XDP_TX,
8eeed8373e1cca Shannon Nelson 2024-02-14  578  					   buf_info->page,
8eeed8373e1cca Shannon Nelson 2024-02-14  579  					   buf_info->page_offset,
8eeed8373e1cca Shannon Nelson 2024-02-14  580  					   true);
8eeed8373e1cca Shannon Nelson 2024-02-14  581  		__netif_tx_unlock(nq);
8eeed8373e1cca Shannon Nelson 2024-02-14  582  		if (err) {
8eeed8373e1cca Shannon Nelson 2024-02-14  583  			netdev_dbg(netdev, "tx ionic_xdp_post_frame err %d\n", err);
8eeed8373e1cca Shannon Nelson 2024-02-14  584  			goto out_xdp_abort;
8eeed8373e1cca Shannon Nelson 2024-02-14  585  		}
491aee894a08bc Taehee Yoo     2024-06-03  586  		buf_info->page = NULL;
17cb07b96a5f58 Taehee Yoo     2024-06-18  587  		if (xdp_frame_has_frags(xdpf)) {
17cb07b96a5f58 Taehee Yoo     2024-06-18 @588  			for (i = 0; i < sinfo->nr_frags; i++) {
                                                                                ^^^^^
Warning generated here

17cb07b96a5f58 Taehee Yoo     2024-06-18  589  				buf_info++;
17cb07b96a5f58 Taehee Yoo     2024-06-18  590  				dma_unmap_page(rxq->dev, buf_info->dma_addr,
17cb07b96a5f58 Taehee Yoo     2024-06-18  591  					       IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
17cb07b96a5f58 Taehee Yoo     2024-06-18  592  				buf_info->page = NULL;
17cb07b96a5f58 Taehee Yoo     2024-06-18  593  			}
17cb07b96a5f58 Taehee Yoo     2024-06-18  594  		}
17cb07b96a5f58 Taehee Yoo     2024-06-18  595  
8eeed8373e1cca Shannon Nelson 2024-02-14  596  		stats->xdp_tx++;
8eeed8373e1cca Shannon Nelson 2024-02-14  597  
8eeed8373e1cca Shannon Nelson 2024-02-14  598  		/* the Tx completion will free the buffers */
8eeed8373e1cca Shannon Nelson 2024-02-14  599  		break;
8eeed8373e1cca Shannon Nelson 2024-02-14  600  
180e35cdf035d1 Shannon Nelson 2024-02-14  601  	case XDP_REDIRECT:
17cb07b96a5f58 Taehee Yoo     2024-06-18  602  		xdpf = xdp_convert_buff_to_frame(&xdp_buf);
587fc3f0dceb08 Shannon Nelson 2024-02-14  603  		/* unmap the pages before handing them to a different device */
587fc3f0dceb08 Shannon Nelson 2024-02-14  604  		dma_unmap_page(rxq->dev, buf_info->dma_addr,
587fc3f0dceb08 Shannon Nelson 2024-02-14  605  			       IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
587fc3f0dceb08 Shannon Nelson 2024-02-14  606  
587fc3f0dceb08 Shannon Nelson 2024-02-14  607  		err = xdp_do_redirect(netdev, &xdp_buf, xdp_prog);
587fc3f0dceb08 Shannon Nelson 2024-02-14  608  		if (err) {
587fc3f0dceb08 Shannon Nelson 2024-02-14  609  			netdev_dbg(netdev, "xdp_do_redirect err %d\n", err);
587fc3f0dceb08 Shannon Nelson 2024-02-14  610  			goto out_xdp_abort;
587fc3f0dceb08 Shannon Nelson 2024-02-14  611  		}
587fc3f0dceb08 Shannon Nelson 2024-02-14  612  		buf_info->page = NULL;
17cb07b96a5f58 Taehee Yoo     2024-06-18  613  		if (xdp_frame_has_frags(xdpf)) {
17cb07b96a5f58 Taehee Yoo     2024-06-18  614  			for (i = 0; i < sinfo->nr_frags; i++) {
17cb07b96a5f58 Taehee Yoo     2024-06-18  615  				buf_info++;
17cb07b96a5f58 Taehee Yoo     2024-06-18  616  				dma_unmap_page(rxq->dev, buf_info->dma_addr,
17cb07b96a5f58 Taehee Yoo     2024-06-18  617  					       IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
17cb07b96a5f58 Taehee Yoo     2024-06-18  618  				buf_info->page = NULL;
17cb07b96a5f58 Taehee Yoo     2024-06-18  619  			}
17cb07b96a5f58 Taehee Yoo     2024-06-18  620  		}
17cb07b96a5f58 Taehee Yoo     2024-06-18  621  
587fc3f0dceb08 Shannon Nelson 2024-02-14  622  		rxq->xdp_flush = true;
587fc3f0dceb08 Shannon Nelson 2024-02-14  623  		stats->xdp_redirect++;
587fc3f0dceb08 Shannon Nelson 2024-02-14  624  		break;
587fc3f0dceb08 Shannon Nelson 2024-02-14  625  
180e35cdf035d1 Shannon Nelson 2024-02-14  626  	case XDP_ABORTED:
180e35cdf035d1 Shannon Nelson 2024-02-14  627  	default:
8eeed8373e1cca Shannon Nelson 2024-02-14  628  		goto out_xdp_abort;
8eeed8373e1cca Shannon Nelson 2024-02-14  629  	}
8eeed8373e1cca Shannon Nelson 2024-02-14  630  
8eeed8373e1cca Shannon Nelson 2024-02-14  631  	return true;
8eeed8373e1cca Shannon Nelson 2024-02-14  632  
8eeed8373e1cca Shannon Nelson 2024-02-14  633  out_xdp_abort:
180e35cdf035d1 Shannon Nelson 2024-02-14  634  	trace_xdp_exception(netdev, xdp_prog, xdp_action);
180e35cdf035d1 Shannon Nelson 2024-02-14  635  	ionic_rx_page_free(rxq, buf_info);
180e35cdf035d1 Shannon Nelson 2024-02-14  636  	stats->xdp_aborted++;
180e35cdf035d1 Shannon Nelson 2024-02-14  637  
180e35cdf035d1 Shannon Nelson 2024-02-14  638  	return true;
180e35cdf035d1 Shannon Nelson 2024-02-14  639  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


