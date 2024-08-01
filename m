Return-Path: <netdev+bounces-114912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA5D944AAB
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FDDBB24647
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 11:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25891946C1;
	Thu,  1 Aug 2024 11:58:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB00158A2C;
	Thu,  1 Aug 2024 11:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722513523; cv=none; b=ftyVAu0EMk5wlYdwvixCgZwpN5ue8gbUNfyV7njWDLZ9FLR8AHLx92ZphAZTfNbv18CXOoDojKhYQ68I4QoZIvFscsli7yZkQ08bEMQ+5bYleFV1huz434mkz884Lf9Hv8lB/uEyHh5N4Ld5YKD7BLUbaGRHddigkmUb61BVRnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722513523; c=relaxed/simple;
	bh=VeLo6DLo4sUwfbYapDDwOFqJypLiBvQt/vlWjIJHQVA=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rA5dv9MoweBJN+ktELefAlEYMKiamt7i/YLFiSchKC0hk92i8BNjy1rkSP5e00uTWCQMUQ9jgNwIeGr5Ls2P6KgIVXCFGOiKNQVYs/Sv1Y4sQjjU/LbWxxHbq18tj2u+92oCdpgo0WcSMgYeCK7LAQKeqhepKsKN8FiQ1NxN0qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WZSCj136Fz1L9MN;
	Thu,  1 Aug 2024 19:58:25 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id CCD93180102;
	Thu,  1 Aug 2024 19:58:37 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 1 Aug 2024 19:58:36 +0800
Message-ID: <ff75f342-4894-4c06-922c-377701c461df@huawei.com>
Date: Thu, 1 Aug 2024 19:58:36 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, "yisen.zhuang@huawei.com"
	<yisen.zhuang@huawei.com>, "salil.mehta@huawei.com" <salil.mehta@huawei.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "shenjian15@huawei.com"
	<shenjian15@huawei.com>, "wangpeiyang1@huawei.com" <wangpeiyang1@huawei.com>,
	"liuyonglong@huawei.com" <liuyonglong@huawei.com>, "sudongming (A)"
	<sudongming1@huawei.com>, <xujunsheng@huawei.com>, "shiyongbang (A)"
	<shiyongbang@huawei.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH net-next 07/10] net: hibmcge: Implement rx_poll
 function to receive packets
To: Joe Damato <jdamato@fastly.com>
References: <20240731094245.1967834-1-shaojijie@huawei.com>
 <20240731094245.1967834-8-shaojijie@huawei.com> <Zqo66ZPaD2GtLZwg@LQ3V64L9R2>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <Zqo66ZPaD2GtLZwg@LQ3V64L9R2>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/7/31 21:23, Joe Damato wrote:
> On Wed, Jul 31, 2024 at 05:42:42PM +0800, Jijie Shao wrote:
>> Implement rx_poll function to read the rx descriptor after
>> receiving the rx interrupt. Adjust the skb based on the
>> descriptor to complete the reception of the packet.
>>
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>> ---
>>   .../ethernet/hisilicon/hibmcge/hbg_common.h   |   5 +
>>   .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   |  10 ++
>>   .../net/ethernet/hisilicon/hibmcge/hbg_hw.h   |   1 +
>>   .../net/ethernet/hisilicon/hibmcge/hbg_irq.c  |   9 +-
>>   .../net/ethernet/hisilicon/hibmcge/hbg_main.c |   2 +
>>   .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |   2 +
>>   .../hisilicon/hibmcge/hbg_reg_union.h         |  65 ++++++++
>>   .../net/ethernet/hisilicon/hibmcge/hbg_txrx.c | 157 +++++++++++++++++-
>>   8 files changed, 248 insertions(+), 3 deletions(-)
>   
>> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
>> index 8efeea9b0c26..bb5f8321da8a 100644
>> --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
>> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
>> @@ -36,6 +36,7 @@ static int hbg_net_open(struct net_device *dev)
>>   		return 0;
>>   
>>   	netif_carrier_off(dev);
>> +	napi_enable(&priv->rx_ring.napi);
>>   	napi_enable(&priv->tx_ring.napi);
>>   	hbg_enable_intr(priv, true);
>>   	hbg_hw_mac_enable(priv, HBG_STATUS_ENABLE);
> In the future, it might be good to consider using:
>     - netif_napi_set_irq
>     - netif_queue_set_napi
>   
> to link NAPIs with IRQs and queues.
>
Sounds good, but I can't find these two functions in 6.4 kernel?

>
>> +static int hbg_rx_fill_buffers(struct hbg_priv *priv)
>> +{
>> +	struct hbg_ring *ring = &priv->rx_ring;
>> +	int ret;
>> +
>> +	while (!(hbg_fifo_is_full(priv, ring->dir) ||
>> +		 hbg_queue_is_full(ring->ntc, ring->ntu, ring))) {
>> +		ret = hbg_rx_fill_one_buffer(priv);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static bool hbg_sync_data_from_hw(struct hbg_priv *priv,
>> +				  struct hbg_buffer *buffer)
>> +{
>> +	struct hbg_rx_desc *rx_desc;
>> +
>> +	/* make sure HW write desc complete */
>> +	dma_rmb();
>> +
>> +	dma_sync_single_for_cpu(&priv->pdev->dev, buffer->skb_dma,
>> +				buffer->skb_len, DMA_FROM_DEVICE);
>> +
>> +	rx_desc = (struct hbg_rx_desc *)buffer->skb->data;
>> +	return rx_desc->len != 0;
>> +}
> Have you looked into using the page pool to simplify some of the
> logic above?

Thanks, but I probably won't use it at the moment.

>
>> +static int hbg_napi_rx_poll(struct napi_struct *napi, int budget)
>> +{
>> +	struct hbg_ring *ring = container_of(napi, struct hbg_ring, napi);
>> +	struct hbg_priv *priv = ring->priv;
>> +	struct hbg_rx_desc *rx_desc;
>> +	struct hbg_buffer *buffer;
>> +	u32 packet_done = 0;
>> +
>> +	if (unlikely(!hbg_nic_is_open(priv))) {
>> +		napi_complete(napi);
>> +		return 0;
>> +	}
>> +
>> +	while (packet_done < budget) {
>> +		if (unlikely(hbg_queue_is_empty(ring->ntc, ring->ntu)))
>> +			break;
>> +
>> +		buffer = &ring->queue[ring->ntc];
>> +		if (unlikely(!buffer->skb))
>> +			goto next_buffer;
>> +
>> +		if (unlikely(!hbg_sync_data_from_hw(priv, buffer)))
>> +			break;
>> +
>> +		hbg_dma_unmap(buffer);
>> +
>> +		rx_desc = (struct hbg_rx_desc *)buffer->skb->data;
>> +		skb_reserve(buffer->skb, HBG_PACKET_HEAD_SIZE + NET_IP_ALIGN);
>> +		skb_put(buffer->skb, rx_desc->len);
>> +		buffer->skb->protocol = eth_type_trans(buffer->skb, priv->netdev);
>> +
>> +		priv->netdev->stats.rx_bytes += rx_desc->len;
>> +		priv->netdev->stats.rx_packets++;
>> +		netif_receive_skb(buffer->skb);
> Any reason why not napi_gro_receive ?

Is it OK if the MAC does not support gro?

>
>> +		buffer->skb = NULL;
>> +		hbg_rx_fill_one_buffer(priv);
>> +
>> +next_buffer:
>> +		hbg_queue_move_next(ntc, ring);
>> +		packet_done++;
>> +	}
>> +
>> +	hbg_rx_fill_buffers(priv);
>> +	if (packet_done >= budget)
>> +		return packet_done;
>> +
>> +	napi_complete(napi);
> Maybe:
>
>     if (napi_complete_done(napi))
>       hbg_irq_enable(priv, HBG_IRQ_RX, true);

okay, I will fix it in v2

Thanks again,

Jijie Shao


