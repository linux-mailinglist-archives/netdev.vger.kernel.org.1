Return-Path: <netdev+bounces-94809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF028C0BD0
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 08:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0091F2202A
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 06:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649AF13AA5A;
	Thu,  9 May 2024 06:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="JFZXg6Ho"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83446127E3D;
	Thu,  9 May 2024 06:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715237890; cv=none; b=keFHfFxB9J2lnB0JMcthcGtt/4QkiubA5hf4mxbgRdwED8yJe7XNidB1+lLPyKXSRXukhLcpHzUuwuy6HLpDbfyK6VAFYafcGG55MM6CWaAEf6H8U4hfKMgofrF3wHrlN5mBniMrKG+LquXMeE7lj8YunydQ/ssSIMLrQqusuvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715237890; c=relaxed/simple;
	bh=6qA/k8Uo+9wS2YxLrs1J1zfN53pquTtnPDBJRCf6WQc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PobyvlHoPDb+eQxU49kCe9JooQkoaNWdQ6ewcHE4IdwbhVOc4DKOAMMqcl6vOlYt3GkBin1azGsf6YG1o80vxcgV4vD8HTR+TQqHb5sd7vppPaItXNQ+x8Kn8MkOG7YtjUoOW67KWjPnhilU7se/y/kbOHGAR8YovMCAek9KP3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=JFZXg6Ho; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4494fVAo022119;
	Wed, 8 May 2024 23:57:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pfpt0220; bh=j+XlDjlIwADvxa08WJazpB
	QTiknsZgHnrYnq+EmH9nA=; b=JFZXg6Ho9t6VjRahQqAtXNlUbfuDFYYr5dgYRn
	HmWLHjGnrDGplC+mpwyHb4PooD9cbR6k5IHbjt/JM9uSvlHioDCzNVbIAuO7E4p2
	z1Tb9wKbpuotXZhfgMyTdJyKj+3gmrmwaBMUx4tloNRww+LnYxghiBM+b9zQvk7F
	V+NxQTx/tLLsvMglq6lXBTwJRm6acLI2jd2KNMc08PJuL0+g+EN8WpOHH4rAACGI
	PGWF3UvTRmu2R/KXALCya/ksKz+9yIklMcQ5TldfBRutgJWZMSIdigy0FZjB0Syb
	8YRxQFSqtpwtAXQM7VYlFJQHFShaMSGcTO9km02YgBaWcR4A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3y0qpbrkyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 23:57:53 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 8 May 2024 23:57:52 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 8 May 2024 23:57:52 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id AEE913F7063;
	Wed,  8 May 2024 23:57:48 -0700 (PDT)
Date: Thu, 9 May 2024 12:27:47 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Justin Lai <justinlai0215@realtek.com>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <andrew@lunn.ch>, <jiri@resnulli.us>,
        <horms@kernel.org>, <pkshih@realtek.com>, <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v18 02/13] rtase: Implement the .ndo_open
 function
Message-ID: <20240509065747.GB1077013@maili.marvell.com>
References: <20240508123945.201524-1-justinlai0215@realtek.com>
 <20240508123945.201524-3-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240508123945.201524-3-justinlai0215@realtek.com>
X-Proofpoint-GUID: ZdnxY70ey0FCmF_2Jms_wBjMLWCJplN0
X-Proofpoint-ORIG-GUID: ZdnxY70ey0FCmF_2Jms_wBjMLWCJplN0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_02,2024-05-08_01,2023-05-22_02

On 2024-05-08 at 18:09:34, Justin Lai (justinlai0215@realtek.com) wrote:
>
> +static int rtase_alloc_desc(struct rtase_private *tp)
> +{
> +	struct pci_dev *pdev = tp->pdev;
> +	u32 i;
> +
> +	/* rx and tx descriptors needs 256 bytes alignment.
> +	 * dma_alloc_coherent provides more.
> +	 */
> +	for (i = 0; i < tp->func_tx_queue_num; i++) {
> +		tp->tx_ring[i].desc =
> +				dma_alloc_coherent(&pdev->dev,
> +						   RTASE_TX_RING_DESC_SIZE,
> +						   &tp->tx_ring[i].phy_addr,
> +						   GFP_KERNEL);
> +		if (!tp->tx_ring[i].desc)
You have handled errors gracefully very where else. why not here ?
> +			return -ENOMEM;
> +	}
> +
> +	for (i = 0; i < tp->func_rx_queue_num; i++) {
> +		tp->rx_ring[i].desc =
> +				dma_alloc_coherent(&pdev->dev,
> +						   RTASE_RX_RING_DESC_SIZE,
> +						   &tp->rx_ring[i].phy_addr,
> +						   GFP_KERNEL);
> +		if (!tp->rx_ring[i].desc)
> +			return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static void rtase_free_desc(struct rtase_private *tp)
> +{
> +	struct pci_dev *pdev = tp->pdev;
> +	u32 i;
> +
> +	for (i = 0; i < tp->func_tx_queue_num; i++) {
> +		if (!tp->tx_ring[i].desc)
> +			continue;
> +
> +		dma_free_coherent(&pdev->dev, RTASE_TX_RING_DESC_SIZE,
> +				  tp->tx_ring[i].desc,
> +				  tp->tx_ring[i].phy_addr);
> +		tp->tx_ring[i].desc = NULL;
> +	}
> +
> +	for (i = 0; i < tp->func_rx_queue_num; i++) {
> +		if (!tp->rx_ring[i].desc)
> +			continue;
> +
> +		dma_free_coherent(&pdev->dev, RTASE_RX_RING_DESC_SIZE,
> +				  tp->rx_ring[i].desc,
> +				  tp->rx_ring[i].phy_addr);
> +		tp->rx_ring[i].desc = NULL;
> +	}
> +}
> +
> +static void rtase_mark_to_asic(union rtase_rx_desc *desc, u32 rx_buf_sz)
> +{
> +	u32 eor = le32_to_cpu(desc->desc_cmd.opts1) & RTASE_RING_END;
> +
> +	desc->desc_status.opts2 = 0;
desc->desc_cmd.addr to be written before desc->desc_status.opts2 ? Just a question
whether below dma_wmb() suffice for both ?
> +	/* force memory writes to complete before releasing descriptor */
> +	dma_wmb();
> +	WRITE_ONCE(desc->desc_cmd.opts1,
> +		   cpu_to_le32(RTASE_DESC_OWN | eor | rx_buf_sz));
> +}
> +
> +static void rtase_tx_desc_init(struct rtase_private *tp, u16 idx)
> +{
> +	struct rtase_ring *ring = &tp->tx_ring[idx];
> +	struct rtase_tx_desc *desc;
> +	u32 i;
> +
> +	memset(ring->desc, 0x0, RTASE_TX_RING_DESC_SIZE);
> +	memset(ring->skbuff, 0x0, sizeof(ring->skbuff));
> +	ring->cur_idx = 0;
> +	ring->dirty_idx = 0;
> +	ring->index = idx;
> +
> +	for (i = 0; i < RTASE_NUM_DESC; i++) {
> +		ring->mis.len[i] = 0;
> +		if ((RTASE_NUM_DESC - 1) == i) {
> +			desc = ring->desc + sizeof(struct rtase_tx_desc) * i;
> +			desc->opts1 = cpu_to_le32(RTASE_RING_END);
> +		}
> +	}
> +
> +	ring->ring_handler = tx_handler;
> +	if (idx < 4) {
> +		ring->ivec = &tp->int_vector[idx];
> +		list_add_tail(&ring->ring_entry,
> +			      &tp->int_vector[idx].ring_list);
> +	} else {
> +		ring->ivec = &tp->int_vector[0];
> +		list_add_tail(&ring->ring_entry, &tp->int_vector[0].ring_list);
> +	}
> +}
> +
> +static void rtase_map_to_asic(union rtase_rx_desc *desc, dma_addr_t mapping,
> +			      u32 rx_buf_sz)
> +{
> +	desc->desc_cmd.addr = cpu_to_le64(mapping);
> +	/* make sure the physical address has been updated */
> +	wmb();
why not dma_wmb();
> +	rtase_mark_to_asic(desc, rx_buf_sz);
> +}
> +
> +static void rtase_make_unusable_by_asic(union rtase_rx_desc *desc)
> +{
> +	desc->desc_cmd.addr = cpu_to_le64(RTK_MAGIC_NUMBER);
> +	desc->desc_cmd.opts1 &= ~cpu_to_le32(RTASE_DESC_OWN | RSVD_MASK);
> +}
> +
> +static int rtase_alloc_rx_skb(const struct rtase_ring *ring,
> +			      struct sk_buff **p_sk_buff,
> +			      union rtase_rx_desc *desc,
> +			      dma_addr_t *rx_phy_addr, u8 in_intr)
> +{
> +	struct rtase_int_vector *ivec = ring->ivec;
> +	const struct rtase_private *tp = ivec->tp;
> +	struct sk_buff *skb = NULL;
> +	dma_addr_t mapping;
> +	struct page *page;
> +	void *buf_addr;
> +	int ret = 0;
> +
> +	page = page_pool_dev_alloc_pages(tp->page_pool);
> +	if (!page) {
> +		netdev_err(tp->dev, "failed to alloc page\n");
> +		goto err_out;
> +	}
> +
> +	buf_addr = page_address(page);
> +	mapping = page_pool_get_dma_addr(page);
> +
> +	skb = build_skb(buf_addr, PAGE_SIZE);
> +	if (!skb) {
> +		page_pool_put_full_page(tp->page_pool, page, true);
> +		netdev_err(tp->dev, "failed to build skb\n");
> +		goto err_out;
> +	}
Did you mark the skb for recycle ? Hmm ... did i miss to find the code ?

> +
> +	*p_sk_buff = skb;
> +	*rx_phy_addr = mapping;
> +	rtase_map_to_asic(desc, mapping, tp->rx_buf_sz);
> +
> +	return ret;
> +
> +err_out:
> +	if (skb)
> +		dev_kfree_skb(skb);
> +
> +	ret = -ENOMEM;
> +	rtase_make_unusable_by_asic(desc);
> +
> +	return ret;
> +}
> +
> +static u32 rtase_rx_ring_fill(struct rtase_ring *ring, u32 ring_start,
> +			      u32 ring_end, u8 in_intr)
> +{
> +	union rtase_rx_desc *desc_base = ring->desc;
> +	u32 cur;
> +
> +	for (cur = ring_start; ring_end - cur > 0; cur++) {
> +		u32 i = cur % RTASE_NUM_DESC;
> +		union rtase_rx_desc *desc = desc_base + i;
> +		int ret;
> +
> +		if (ring->skbuff[i])
> +			continue;
> +
> +		ret = rtase_alloc_rx_skb(ring, &ring->skbuff[i], desc,
> +					 &ring->mis.data_phy_addr[i],
> +					 in_intr);
> +		if (ret)
> +			break;
> +	}
> +
> +	return cur - ring_start;
> +}
> +
> +static void rtase_mark_as_last_descriptor(union rtase_rx_desc *desc)
> +{
> +	desc->desc_cmd.opts1 |= cpu_to_le32(RTASE_RING_END);
> +}
> +
> +static void rtase_rx_ring_clear(struct rtase_ring *ring)
> +{
> +	union rtase_rx_desc *desc;
> +	u32 i;
> +
> +	for (i = 0; i < RTASE_NUM_DESC; i++) {
> +		desc = ring->desc + sizeof(union rtase_rx_desc) * i;
> +
> +		if (!ring->skbuff[i])
> +			continue;
> +
> +		skb_mark_for_recycle(ring->skbuff[i]);
> +
> +		dev_kfree_skb(ring->skbuff[i]);
> +
> +		ring->skbuff[i] = NULL;
> +
> +		rtase_make_unusable_by_asic(desc);
> +	}
> +}
> +
> +static void rtase_rx_desc_init(struct rtase_private *tp, u16 idx)
> +{
> +	struct rtase_ring *ring = &tp->rx_ring[idx];
> +	u16 i;
> +
> +	memset(ring->desc, 0x0, RTASE_RX_RING_DESC_SIZE);
> +	memset(ring->skbuff, 0x0, sizeof(ring->skbuff));
> +	ring->cur_idx = 0;
> +	ring->dirty_idx = 0;
> +	ring->index = idx;
> +
> +	for (i = 0; i < RTASE_NUM_DESC; i++)
> +		ring->mis.data_phy_addr[i] = 0;
> +
> +	ring->ring_handler = rx_handler;
> +	ring->ivec = &tp->int_vector[idx];
> +	list_add_tail(&ring->ring_entry, &tp->int_vector[idx].ring_list);
> +}
> +
> +static void rtase_rx_clear(struct rtase_private *tp)
> +{
> +	u32 i;
> +
> +	for (i = 0; i < tp->func_rx_queue_num; i++)
> +		rtase_rx_ring_clear(&tp->rx_ring[i]);
> +
> +	page_pool_destroy(tp->page_pool);
> +	tp->page_pool = NULL;
> +}
> +
> +static int rtase_init_ring(const struct net_device *dev)
> +{
> +	struct rtase_private *tp = netdev_priv(dev);
> +	struct page_pool_params pp_params = { 0 };
> +	struct page_pool *page_pool;
> +	u32 num;
> +	u16 i;
> +
> +	pp_params.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
> +	pp_params.order = 0;
> +	pp_params.pool_size = RTASE_NUM_DESC * tp->func_rx_queue_num;
> +	pp_params.nid = dev_to_node(&tp->pdev->dev);
> +	pp_params.dev = &tp->pdev->dev;
> +	pp_params.dma_dir = DMA_FROM_DEVICE;
> +	pp_params.max_len = PAGE_SIZE;
> +	pp_params.offset = 0;
> +
> +	page_pool = page_pool_create(&pp_params);
> +	if (IS_ERR(page_pool)) {
> +		netdev_err(tp->dev, "failed to create page pool\n");
> +		return -ENOMEM;
> +	}
> +
> +	tp->page_pool = page_pool;
> +
> +	for (i = 0; i < tp->func_tx_queue_num; i++)
> +		rtase_tx_desc_init(tp, i);
> +
> +	for (i = 0; i < tp->func_rx_queue_num; i++) {
> +		rtase_rx_desc_init(tp, i);
> +		num = rtase_rx_ring_fill(&tp->rx_ring[i], 0,
> +					 RTASE_NUM_DESC, 0);
> +		if (num != RTASE_NUM_DESC)
> +			goto err_out;
> +
> +		rtase_mark_as_last_descriptor(tp->rx_ring[i].desc +
> +					      sizeof(union rtase_rx_desc) *
> +					      (RTASE_NUM_DESC - 1));
> +	}
> +
> +	return 0;
> +
> +err_out:
> +	rtase_rx_clear(tp);
> +	return -ENOMEM;
> +}
> +
>  static void rtase_tally_counter_clear(const struct rtase_private *tp)
>  {
>  	u32 cmd = lower_32_bits(tp->tally_paddr);
> @@ -138,6 +424,130 @@ static void rtase_tally_counter_clear(const struct rtase_private *tp)
>  	rtase_w32(tp, RTASE_DTCCR0, cmd | RTASE_COUNTER_RESET);
>  }
>
> +static void rtase_nic_enable(const struct net_device *dev)
> +{
> +	const struct rtase_private *tp = netdev_priv(dev);
> +	u16 rcr = rtase_r16(tp, RTASE_RX_CONFIG_1);
> +	u8 val;
> +
> +	rtase_w16(tp, RTASE_RX_CONFIG_1, rcr & ~RTASE_PCIE_RELOAD_EN);
> +	rtase_w16(tp, RTASE_RX_CONFIG_1, rcr | RTASE_PCIE_RELOAD_EN);
> +
> +	val = rtase_r8(tp, RTASE_CHIP_CMD);
> +	rtase_w8(tp, RTASE_CHIP_CMD, val | RTASE_TE | RTASE_RE);
> +
> +	val = rtase_r8(tp, RTASE_MISC);
> +	rtase_w8(tp, RTASE_MISC, val & ~RTASE_RX_DV_GATE_EN);
> +}
> +
> +static void rtase_enable_hw_interrupt(const struct rtase_private *tp)
> +{
> +	const struct rtase_int_vector *ivec = &tp->int_vector[0];
> +	u32 i;
> +
> +	rtase_w32(tp, ivec->imr_addr, ivec->imr);
> +
> +	for (i = 1; i < tp->int_nums; i++) {
> +		ivec = &tp->int_vector[i];
> +		rtase_w16(tp, ivec->imr_addr, ivec->imr);
> +	}
> +}
> +
> +static void rtase_hw_start(const struct net_device *dev)
> +{
> +	const struct rtase_private *tp = netdev_priv(dev);
> +
> +	rtase_nic_enable(dev);
> +	rtase_enable_hw_interrupt(tp);
> +}
> +
> +static int rtase_open(struct net_device *dev)
> +{
> +	struct rtase_private *tp = netdev_priv(dev);
> +	const struct pci_dev *pdev = tp->pdev;
> +	struct rtase_int_vector *ivec;
> +	u16 i = 0, j;
> +	int ret;
> +
> +	ivec = &tp->int_vector[0];
> +	tp->rx_buf_sz = RTASE_RX_BUF_SIZE;
> +
> +	ret = rtase_alloc_desc(tp);
> +	if (ret)
> +		goto err_free_all_allocated_mem;
> +
> +	ret = rtase_init_ring(dev);
> +	if (ret)
> +		goto err_free_all_allocated_mem;
> +
> +	rtase_hw_config(dev);
> +
> +	if (tp->sw_flag & RTASE_SWF_MSIX_ENABLED) {
> +		ret = request_irq(ivec->irq, rtase_interrupt, 0,
> +				  dev->name, ivec);
> +		if (ret)
> +			goto err_free_all_allocated_irq;
> +
> +		/* request other interrupts to handle multiqueue */
> +		for (i = 1; i < tp->int_nums; i++) {
> +			ivec = &tp->int_vector[i];
> +			snprintf(ivec->name, sizeof(ivec->name), "%s_int%i",
> +				 tp->dev->name, i);
> +			ret = request_irq(ivec->irq, rtase_q_interrupt, 0,
> +					  ivec->name, ivec);
> +			if (ret)
> +				goto err_free_all_allocated_irq;
> +		}
> +	} else {
> +		ret = request_irq(pdev->irq, rtase_interrupt, 0, dev->name,
> +				  ivec);
> +		if (ret)
> +			goto err_free_all_allocated_mem;
> +	}
> +
> +	rtase_hw_start(dev);
> +
> +	for (i = 0; i < tp->int_nums; i++) {
> +		ivec = &tp->int_vector[i];
> +		napi_enable(&ivec->napi);
> +	}
> +
> +	netif_carrier_on(dev);
> +	netif_wake_queue(dev);
> +
> +	return 0;
> +
> +err_free_all_allocated_irq:
You are allocating from i = 1, but freeing from j = 0;
> +	for (j = 0; j < i; j++)
> +		free_irq(tp->int_vector[j].irq, &tp->int_vector[j]);
> +
> +err_free_all_allocated_mem:
> +	rtase_free_desc(tp);
> +
> +	return ret;
> +}
> +
> +static int rtase_close(struct net_device *dev)
> +{
> +	struct rtase_private *tp = netdev_priv(dev);
> +	const struct pci_dev *pdev = tp->pdev;
> +	u32 i;
> +
> +	rtase_down(dev);
> +
> +	if (tp->sw_flag & RTASE_SWF_MSIX_ENABLED) {
> +		for (i = 0; i < tp->int_nums; i++)
> +			free_irq(tp->int_vector[i].irq, &tp->int_vector[i]);
> +
> +	} else {
> +		free_irq(pdev->irq, &tp->int_vector[0]);
> +	}
> +
> +	rtase_free_desc(tp);
> +
> +	return 0;
> +}
> +
>  static void rtase_enable_eem_write(const struct rtase_private *tp)
>  {
>  	u8 val;
> @@ -170,6 +580,11 @@ static void rtase_rar_set(const struct rtase_private *tp, const u8 *addr)
>  	rtase_w16(tp, RTASE_LBK_CTRL, RTASE_LBK_ATLD | RTASE_LBK_CLR);
>  }
>
> +static const struct net_device_ops rtase_netdev_ops = {
> +	.ndo_open = rtase_open,
> +	.ndo_stop = rtase_close,
> +};
> +
>  static void rtase_get_mac_address(struct net_device *dev)
>  {
>  	struct rtase_private *tp = netdev_priv(dev);
> @@ -190,6 +605,11 @@ static void rtase_get_mac_address(struct net_device *dev)
>  	rtase_rar_set(tp, dev->dev_addr);
>  }
>
> +static void rtase_init_netdev_ops(struct net_device *dev)
> +{
> +	dev->netdev_ops = &rtase_netdev_ops;
> +}
> +
>  static void rtase_reset_interrupt(struct pci_dev *pdev,
>  				  const struct rtase_private *tp)
>  {
> --
> 2.34.1
>

