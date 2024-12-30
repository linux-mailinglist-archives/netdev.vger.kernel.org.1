Return-Path: <netdev+bounces-154510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A16229FE4C3
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 10:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 543911620B6
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 09:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAA11A23AC;
	Mon, 30 Dec 2024 09:18:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D911A08AB
	for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 09:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735550327; cv=none; b=SxGB/7nMUst6NOz/C10cN6Nb2ZORbRHiI9GT2oKe2WHU3kDUwOJKMupamAch0pVmrkLsCRNx63U9m47rfqfjel8T1tMu47rEnNaAgMpfn+zFh36nrhcrAOQi50eNIQ2B8PkJZODBIPlvABJLykS81oTSeUoW9IkCF8n30M3WeoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735550327; c=relaxed/simple;
	bh=FkdmcBQUYH1X8STBRAR+WZlu5XIXo+NNA5kiYhY1/m8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CvHuBHNisoyt0Y5KA4YBMeobOZjGkbubL19Qcal6xZyZ7qodpdCIud+9L8ZHEJmcFJimxMWjlH7MYLzTq4MUC5orW5ZbPoNuPySshrgEw9ngFJK+Xpz3g3eU35W0EXyZ7KsrACZm5ej3HVotbilgBvPocDb3yAfbULqZdgf2FBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YM9SV4FKbz11RY0;
	Mon, 30 Dec 2024 17:15:54 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id A3722180106;
	Mon, 30 Dec 2024 17:18:39 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 30 Dec 2024 17:18:39 +0800
Message-ID: <ef5266a0-6d7a-4327-be7c-11f46f8d1074@huawei.com>
Date: Mon, 30 Dec 2024 17:18:39 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 4/6] enic: Use the Page Pool API for RX when
 MTU is less than page size
To: John Daley <johndale@cisco.com>, <benve@cisco.com>, <satishkh@cisco.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Nelson Escobar <neescoba@cisco.com>
References: <20241228001055.12707-1-johndale@cisco.com>
 <20241228001055.12707-5-johndale@cisco.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20241228001055.12707-5-johndale@cisco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/12/28 8:10, John Daley wrote:
> +void enic_rq_free_page(struct vnic_rq *vrq, struct vnic_rq_buf *buf)
> +{
> +	struct enic *enic = vnic_dev_priv(vrq->vdev);
> +	struct enic_rq *rq = &enic->rq[vrq->index];
> +
> +	if (!buf->os_buf)
> +		return;
> +
> +	page_pool_put_page(rq->pool, (struct page *)buf->os_buf,
> +			   get_max_pkt_len(enic), true);

It seems the above has a similar problem of not using
page_pool_put_full_page() when page_pool_dev_alloc() API is used and
page_pool is created with PP_FLAG_DMA_SYNC_DEV flags.

It seems like a common mistake that a WARN_ON might be needed to catch
this kind of problem.

https://lore.kernel.org/netdev/89d7ce83-cc1d-4791-87b5-6f7af29a031d@huawei.com/

> +	buf->os_buf = NULL;
> +}
> +
> +int enic_rq_alloc_page(struct vnic_rq *vrq)
> +{
> +	struct enic *enic = vnic_dev_priv(vrq->vdev);
> +	struct enic_rq *rq = &enic->rq[vrq->index];
> +	struct enic_rq_stats *rqstats = &rq->stats;
> +	struct vnic_rq_buf *buf = vrq->to_use;
> +	dma_addr_t dma_addr;
> +	struct page *page;
> +	unsigned int offset = 0;
> +	unsigned int len;
> +	unsigned int truesize;
> +
> +	len = get_max_pkt_len(enic);
> +	truesize = len;
> +
> +	if (buf->os_buf) {
> +		dma_addr = buf->dma_addr;
> +	} else {
> +		page = page_pool_dev_alloc(rq->pool, &offset, &truesize);
> +		if (unlikely(!page)) {
> +			rqstats->pp_alloc_error++;
> +			return -ENOMEM;
> +		}
> +		buf->os_buf = (void *)page;
> +		buf->offset = offset;
> +		buf->truesize = truesize;
> +		dma_addr = page_pool_get_dma_addr(page) + offset;
> +	}
> +
> +	enic_queue_rq_desc(vrq, buf->os_buf, dma_addr, len);
> +
> +	return 0;
> +}

