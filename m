Return-Path: <netdev+bounces-169521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F33A4453C
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 17:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434D818890A2
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 16:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C96516EB54;
	Tue, 25 Feb 2025 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ZflnUnB+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DEE15C14B
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740499256; cv=none; b=sb90PEjCLUxgGnyv3lO2TYFMTTUrpmJxIxMjOn3fqaH05B+R+gKOCyNWIo54udSrHsxsNMM+Cs6He9hGEVWwLK3MeVBDAJXbxgxLSFc+1vENZaNrZNp6f+rQthxMjhflxT1NW1f6h6YbM4cZXuCTqvrSFM8Ss6vgPZpLMpRV2Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740499256; c=relaxed/simple;
	bh=4/6WNfOFt0tBeL4b4ZFXpp6KrBRycH/p/0PSMwuLqJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAQMR6fzn/zL/IZtrnmK2l5V4GBNngzXtEpnluh7xDOWmacKKgJw3ddwSxCO1/DbPhJ0W7FiWxWxOqzu40FDM2d6fZrkjQlOQBiOqtQznHarqBY2blzSUvGp3iO9k56j00IMROcwpYbAxlINwAtj7Gsq+fqRCn58V1Lp+K2adcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ZflnUnB+; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e65e0a3f7eso26190106d6.0
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 08:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740499253; x=1741104053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qfo6+lok37Xv4JW+s09KuDgrT6+5xL1zebJ3c/AEumA=;
        b=ZflnUnB+PeZMI4/b70E6a2cU58jPeq62/pEaWrYrSHi9ULd94fG0+uXeSktADpAa9I
         1OJik1HxEM5/2LHJ5ykJEKPhL6GN0qY+l6JkpHnTO0nnNnkIoYwpTl7BKG9Eet3Pnt2R
         U1a1mLyAlbVoTu3p1lnQI7D7LZnoWYKd+GmpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740499253; x=1741104053;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qfo6+lok37Xv4JW+s09KuDgrT6+5xL1zebJ3c/AEumA=;
        b=I5LMTxiWdLUZEFLed5wcbzGRKi0iCKt3E6hXyz8RL18nbn/+gK0gm/CSXp9+7jW9aS
         DMqWgf5t3Fz1RFsJ7pkcA0OWQTDyKFW0V0WGrAy6PpVaSlWx4pxpm3+6GrCVKqdSdL72
         b/9Vo311dUEXtYz77twI2eswlvmRroBiDwBd+n+HM7Fl5mi3HPrvU4s1Pr7Qyn8OkQxw
         Kmly/yEhiWpXrviwwavu8QlGY/WFxWLxRFrls8fltuPa6D4CT19yPrqRr/qeLXNEfNXv
         o/7HqO15tsWkh48r6PUG0OIC0d8F5BuTEhdT8Zo8HTitK6zD8VgfgwMYSDuderDWlBy/
         YP5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWcQYg770xarNng0utNeiTCm/wpQ4sEVlDvHZ1XJrS/P3c+wQRbhPsWQiZaHy2q72mvGaKS0x4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBITcR9O31yQSeeq47m4wPBTc2gSkw2wdSWRDbPFcAuZl45i8z
	vpN50eEHxjPbg4l/bhwuvtn9zNQQYH7wAinFlG2F6fMtx+XYEBJeizL7jgLk4CDSTE0ZPmUce6z
	8
X-Gm-Gg: ASbGncsCZpL12GNo6ywVc9WwZgvnTZzseSOfmX3L07yqqPAA+jvo7p+OE16AI0aFyN9
	shiBa055uRMqLc648Pv7k9xt4h4ClxsPVSVxLncjSZ6haxDAD/E4UsypJBAyJmZnpdy+yLfd2t/
	oGfPcbIwx6yjzjzqBNBbbaRDHN5xZuC1OESHTtJPgjLHsxj3gpEhdT77XhxRKPltwVmPE2E0Qjq
	BV7MM930s4vGDLHaylu0fMjs0DcBq2o8CGAhClsoi9lyYuy2UqR7mUoQBq56coeDZiLWvAeZMYf
	3SPPUQA9HMWX185in9/vLtGrTn7X7MGQKRX6SoAhl7cg2dDXYjlaWVI+OBkSPohx
X-Google-Smtp-Source: AGHT+IFy8cr87IYs/ikvSPfJnNOc6xW3Y53Ei4eNhSOWrUVVAE6ouMuggS+w7Eme1vNlh671mSTUjA==
X-Received: by 2002:ad4:5bea:0:b0:6e6:4969:f005 with SMTP id 6a1803df08f44-6e6ae994f63mr168782136d6.30.1740499252509;
        Tue, 25 Feb 2025 08:00:52 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b176c02sm10540366d6.110.2025.02.25.08.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 08:00:51 -0800 (PST)
Date: Tue, 25 Feb 2025 11:00:49 -0500
From: Joe Damato <jdamato@fastly.com>
To: Gur Stavi <gur.stavi@huawei.com>
Cc: Fan Gong <gongfan1@huawei.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Cai Huoqing <cai.huoqing@linux.dev>, luosifu <luosifu@huawei.com>,
	Xin Guo <guoxin09@huawei.com>,
	Shen Chenyang <shenchenyang1@hisilicon.com>,
	Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
	Shi Jing <shijing34@huawei.com>,
	Meny Yossefi <meny.yossefi@huawei.com>,
	Suman Ghosh <sumang@marvell.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v06 1/1] hinic3: module initialization and tx/rx
 logic
Message-ID: <Z73pMXNsYprCcbmk@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Gur Stavi <gur.stavi@huawei.com>, Fan Gong <gongfan1@huawei.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Cai Huoqing <cai.huoqing@linux.dev>, luosifu <luosifu@huawei.com>,
	Xin Guo <guoxin09@huawei.com>,
	Shen Chenyang <shenchenyang1@hisilicon.com>,
	Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
	Shi Jing <shijing34@huawei.com>,
	Meny Yossefi <meny.yossefi@huawei.com>,
	Suman Ghosh <sumang@marvell.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <cover.1740487707.git.gur.stavi@huawei.com>
 <0e13370a2a444eb4e906e49276b2d5c4b8862616.1740487707.git.gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e13370a2a444eb4e906e49276b2d5c4b8862616.1740487707.git.gur.stavi@huawei.com>

On Tue, Feb 25, 2025 at 04:53:30PM +0200, Gur Stavi wrote:
> From: Fan Gong <gongfan1@huawei.com>
> 
> This is [1/3] part of hinic3 Ethernet driver initial submission.
> With this patch hinic3 is a valid kernel module but non-functional
> driver.

IMHO, there's a huge amount of code so it makes reviewing pretty
difficult.

Is there no way to split this into multiple smaller patches? I am
sure his was asked and answered in a previous thread that I missed.

I took a quick pass over the code, but probably missed many things
due to the large amount of code in a single patch.

[...]

> +static void init_intr_coal_param(struct net_device *netdev)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct hinic3_intr_coal_info *info;
> +	u16 i;
> +
> +	for (i = 0; i < nic_dev->max_qps; i++) {
> +		info = &nic_dev->intr_coalesce[i];
> +		info->pending_limt = HINIC3_DEAULT_TXRX_MSIX_PENDING_LIMIT;
> +		info->coalesce_timer_cfg = HINIC3_DEAULT_TXRX_MSIX_COALESC_TIMER_CFG;
> +		info->resend_timer_cfg = HINIC3_DEAULT_TXRX_MSIX_RESEND_TIMER_CFG;
> +	}
> +}
> +
> +static int hinic3_init_intr_coalesce(struct net_device *netdev)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
> +	u64 size;
> +
> +	size = sizeof(*nic_dev->intr_coalesce) * nic_dev->max_qps;
> +	if (!size) {
> +		dev_err(hwdev->dev, "Cannot allocate zero size intr coalesce\n");
> +		return -EINVAL;
> +	}
> +	nic_dev->intr_coalesce = kzalloc(size, GFP_KERNEL);
> +	if (!nic_dev->intr_coalesce)
> +		return -ENOMEM;
> +
> +	init_intr_coal_param(netdev);
> +	return 0;
> +}
> +
> +static void hinic3_free_intr_coalesce(struct net_device *netdev)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +
> +	kfree(nic_dev->intr_coalesce);
> +}

Do you need the IRQ coalescing code in this version of the patch? It
looks like hinic3_alloc_rxqs is unimplemented... so it's a bit
confusing to see code for IRQ coalescing but none for queue
allocation ?

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c
> new file mode 100644
> index 000000000000..4a166c13eb38
> --- /dev/null
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
> +
> +#include "hinic3_hwdev.h"
> +#include "hinic3_hwif.h"
> +#include "hinic3_nic_cfg.h"
> +#include "hinic3_nic_dev.h"
> +#include "hinic3_rss.h"
> +
> +void hinic3_clear_rss_config(struct net_device *netdev)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +
> +	kfree(nic_dev->rss_hkey);
> +	nic_dev->rss_hkey = NULL;
> +
> +	kfree(nic_dev->rss_indir);
> +	nic_dev->rss_indir = NULL;
> +}

Do you need the above code in hinic3_clear_rss_config?

I probably missed it but hinic3_try_to_enable_rss is empty, so I'm
not sure why you'd need to implement the de-allocaion of the
rss_hkey and rss_indir in this patch ?

> +static void hinic3_reuse_rx_page(struct hinic3_rxq *rxq,
> +				 struct hinic3_rx_info *old_rx_info)
> +{
> +	struct hinic3_rx_info *new_rx_info;
> +	u16 nta = rxq->next_to_alloc;
> +
> +	new_rx_info = &rxq->rx_info[nta];
> +
> +	/* update, and store next to alloc */
> +	nta++;
> +	rxq->next_to_alloc = (nta < rxq->q_depth) ? nta : 0;
> +
> +	new_rx_info->page = old_rx_info->page;
> +	new_rx_info->page_offset = old_rx_info->page_offset;
> +	new_rx_info->buf_dma_addr = old_rx_info->buf_dma_addr;
> +
> +	/* sync the buffer for use by the device */
> +	dma_sync_single_range_for_device(rxq->dev, new_rx_info->buf_dma_addr,
> +					 new_rx_info->page_offset,
> +					 rxq->buf_len,
> +					 DMA_FROM_DEVICE);
> +}

Are you planning to use the page pool in future revisions to
simplify the code ?

> +static void hinic3_add_rx_frag(struct hinic3_rxq *rxq,
> +			       struct hinic3_rx_info *rx_info,
> +			       struct sk_buff *skb, u32 size)
> +{
> +	struct page *page;
> +	u8 *va;
> +
> +	page = rx_info->page;
> +	va = (u8 *)page_address(page) + rx_info->page_offset;
> +	prefetch(va);

net_prefetch ?

> +
> +	dma_sync_single_range_for_cpu(rxq->dev,
> +				      rx_info->buf_dma_addr,
> +				      rx_info->page_offset,
> +				      rxq->buf_len,
> +				      DMA_FROM_DEVICE);
> +
> +	if (size <= HINIC3_RX_HDR_SIZE && !skb_is_nonlinear(skb)) {
> +		memcpy(__skb_put(skb, size), va,
> +		       ALIGN(size, sizeof(long)));
> +
> +		/* page is not reserved, we can reuse buffer as-is */
> +		if (likely(page_to_nid(page) == numa_node_id()))
> +			goto reuse_rx_page;
> +
> +		/* this page cannot be reused so discard it */
> +		put_page(page);
> +		goto err_reuse_buffer;
> +	}
> +
> +	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page,
> +			rx_info->page_offset, size, rxq->buf_len);
> +
> +	/* avoid re-using remote pages */
> +	if (unlikely(page_to_nid(page) != numa_node_id()))
> +		goto err_reuse_buffer;
> +
> +	/* if we are the only owner of the page we can reuse it */
> +	if (unlikely(page_count(page) != 1))
> +		goto err_reuse_buffer;

Are you planning to use the page pool in future revisions to
simplify the code ?

> +static struct sk_buff *hinic3_fetch_rx_buffer(struct hinic3_rxq *rxq,
> +					      u32 pkt_len)
> +{
> +	struct net_device *netdev = rxq->netdev;
> +	struct sk_buff *skb;
> +	u32 sge_num;
> +
> +	skb = netdev_alloc_skb_ip_align(netdev, HINIC3_RX_HDR_SIZE);
> +	if (unlikely(!skb))
> +		return NULL;
> +
> +	sge_num = hinic3_get_sge_num(rxq, pkt_len);
> +
> +	prefetchw(skb->data);

net_prefetchw ?

> +int hinic3_rx_poll(struct hinic3_rxq *rxq, int budget)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(rxq->netdev);
> +	u32 sw_ci, status, pkt_len, vlan_len;
> +	struct hinic3_rq_cqe *rx_cqe;
> +	u32 num_wqe = 0;
> +	int nr_pkts = 0;
> +	u16 num_lro;
> +
> +	while (likely(nr_pkts < budget)) {
> +		sw_ci = rxq->cons_idx & rxq->q_mask;
> +		rx_cqe = rxq->cqe_arr + sw_ci;
> +		status = rx_cqe->status;
> +		if (!RQ_CQE_STATUS_GET(status, RXDONE))
> +			break;
> +
> +		/* make sure we read rx_done before packet length */
> +		rmb();
> +
> +		vlan_len = rx_cqe->vlan_len;
> +		pkt_len = RQ_CQE_SGE_GET(vlan_len, LEN);
> +		if (recv_one_pkt(rxq, rx_cqe, pkt_len, vlan_len, status))
> +			break;
> +
> +		nr_pkts++;
> +		num_lro = RQ_CQE_STATUS_GET(status, NUM_LRO);
> +		if (num_lro)
> +			num_wqe += hinic3_get_sge_num(rxq, pkt_len);
> +
> +		rx_cqe->status = 0;
> +
> +		if (num_wqe >= nic_dev->lro_replenish_thld)
> +			break;
> +	}
> +
> +	if (rxq->delta >= HINIC3_RX_BUFFER_WRITE)
> +		hinic3_rx_fill_buffers(rxq);

Doesn't this function need to re-enable hw IRQs? Maybe it does
somewhere in one of the helpers and I missed it?

Even so, it should probably be checking napi_complete_done before
re-enabling IRQs and I don't see a call to that anywhere, but maybe
I missed it?

I also don't see any calls to netif_napi_add, so I'm not sure if
this code needs to be included in this patch ?

> +#define HINIC3_BDS_PER_SQ_WQEBB \
> +	(HINIC3_SQ_WQEBB_SIZE / sizeof(struct hinic3_sq_bufdesc))
> +
> +int hinic3_tx_poll(struct hinic3_txq *txq, int budget)
> +{
> +	struct net_device *netdev = txq->netdev;
> +	u16 hw_ci, sw_ci, q_id = txq->sq->q_id;
> +	struct hinic3_nic_dev *nic_dev;
> +	struct hinic3_tx_info *tx_info;
> +	u16 wqebb_cnt = 0;
> +	int pkts = 0;
> +
> +	nic_dev = netdev_priv(netdev);
> +	hw_ci = hinic3_get_sq_hw_ci(txq->sq);
> +	dma_rmb();
> +	sw_ci = hinic3_get_sq_local_ci(txq->sq);
> +
> +	do {
> +		tx_info = &txq->tx_info[sw_ci];
> +
> +		/* Did all wqebb of this wqe complete? */
> +		if (hw_ci == sw_ci ||
> +		    ((hw_ci - sw_ci) & txq->q_mask) < tx_info->wqebb_cnt)
> +			break;
> +
> +		sw_ci = (sw_ci + tx_info->wqebb_cnt) & (u16)txq->q_mask;
> +		prefetch(&txq->tx_info[sw_ci]);

net_prefetch ?

