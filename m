Return-Path: <netdev+bounces-36527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE82E7B0458
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 14:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 5F5DC2827AA
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 12:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0613C2772C;
	Wed, 27 Sep 2023 12:38:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2562C79FA
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 12:38:43 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B457EC0
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 05:38:40 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RwbfK05gFzNnpY;
	Wed, 27 Sep 2023 20:34:49 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 27 Sep
 2023 20:38:38 +0800
Subject: Re: [PATCH net-next v2 1/3] net: libwx: support hardware statistics
To: Jiawen Wu <jiawenwu@trustnetic.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew@lunn.ch>
CC: <mengyuanlou@net-swift.com>
References: <20230921033020.853040-1-jiawenwu@trustnetic.com>
 <20230921033020.853040-2-jiawenwu@trustnetic.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <66543766-9a68-b122-f33e-8640c402a0c2@huawei.com>
Date: Wed, 27 Sep 2023 20:38:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230921033020.853040-2-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/9/21 11:30, Jiawen Wu wrote:
> +void wx_update_stats(struct wx *wx)
> +{
> +	struct net_device_stats *net_stats = &wx->netdev->stats;
> +	struct wx_hw_stats *hwstats = &wx->stats;
> +
> +	u64 non_eop_descs = 0, alloc_rx_buff_failed = 0;
> +	u64 hw_csum_rx_good = 0, hw_csum_rx_error = 0;
> +	u64 restart_queue = 0, tx_busy = 0;
> +	u64 packets = 0, bytes = 0;
> +	u32 i;
> +
> +	/* gather some stats to the wx struct that are per queue */
> +	for (i = 0; i < wx->num_rx_queues; i++) {
> +		struct wx_ring *rx_ring = wx->rx_ring[i];
> +
> +		non_eop_descs += rx_ring->rx_stats.non_eop_descs;
> +		alloc_rx_buff_failed += rx_ring->rx_stats.alloc_rx_buff_failed;
> +		hw_csum_rx_good += rx_ring->rx_stats.csum_good_cnt;
> +		hw_csum_rx_error += rx_ring->rx_stats.csum_err;
> +		packets += rx_ring->stats.packets;
> +		bytes += rx_ring->stats.bytes;
> +	}
> +	wx->non_eop_descs = non_eop_descs;
> +	wx->alloc_rx_buff_failed = alloc_rx_buff_failed;
> +	wx->hw_csum_rx_error = hw_csum_rx_error;
> +	wx->hw_csum_rx_good = hw_csum_rx_good;
> +	net_stats->rx_bytes = bytes;
> +	net_stats->rx_packets = packets;
> +
> +	bytes = 0;
> +	packets = 0;
> +	for (i = 0; i < wx->num_tx_queues; i++) {
> +		struct wx_ring *tx_ring = wx->tx_ring[i];
> +
> +		restart_queue += tx_ring->tx_stats.restart_queue;
> +		tx_busy += tx_ring->tx_stats.tx_busy;

Is the ring->syncp needed to protect the fetching here from
the updating in wx_clean_tx_irq() and wx_xmit_frame_ring()?

> +		packets += tx_ring->stats.packets;
> +		bytes += tx_ring->stats.bytes;
> +	}
> +	wx->restart_queue = restart_queue;
> +	wx->tx_busy = tx_busy;
> +	net_stats->tx_packets = packets;
> +	net_stats->tx_bytes = bytes;
> +
> +	hwstats->gprc += rd32(wx, WX_RDM_PKT_CNT);
> +	hwstats->gptc += rd32(wx, WX_TDM_PKT_CNT);
> +	hwstats->gorc += rd64(wx, WX_RDM_BYTE_CNT_LSB);
> +	hwstats->gotc += rd64(wx, WX_TDM_BYTE_CNT_LSB);
> +	hwstats->tpr += rd64(wx, WX_RX_FRAME_CNT_GOOD_BAD_L);
> +	hwstats->tpt += rd64(wx, WX_TX_FRAME_CNT_GOOD_BAD_L);
> +	hwstats->bprc += rd64(wx, WX_RX_BC_FRAMES_GOOD_L);
> +	hwstats->bptc += rd64(wx, WX_TX_BC_FRAMES_GOOD_L);
> +	hwstats->mprc += rd64(wx, WX_RX_MC_FRAMES_GOOD_L);
> +	hwstats->mptc += rd64(wx, WX_TX_MC_FRAMES_GOOD_L);
> +	hwstats->roc += rd32(wx, WX_RX_OVERSIZE_FRAMES_GOOD);
> +	hwstats->ruc += rd32(wx, WX_RX_UNDERSIZE_FRAMES_GOOD);
> +	hwstats->lxonoffrxc += rd32(wx, WX_MAC_LXONOFFRXC);
> +	hwstats->lxontxc += rd32(wx, WX_RDB_LXONTXC);
> +	hwstats->lxofftxc += rd32(wx, WX_RDB_LXOFFTXC);
> +	hwstats->o2bgptc += rd32(wx, WX_TDM_OS2BMC_CNT);
> +	hwstats->b2ospc += rd32(wx, WX_MNG_BMC2OS_CNT);
> +	hwstats->o2bspc += rd32(wx, WX_MNG_OS2BMC_CNT);
> +	hwstats->b2ogprc += rd32(wx, WX_RDM_BMC2OS_CNT);
> +	hwstats->rdmdrop += rd32(wx, WX_RDM_DRP_PKT);
> +	hwstats->crcerrs += rd64(wx, WX_RX_CRC_ERROR_FRAMES_L);
> +	hwstats->rlec += rd64(wx, WX_RX_LEN_ERROR_FRAMES_L);
> +
> +	net_stats->multicast = 0;
> +	for (i = 0; i < wx->mac.max_rx_queues; i++)
> +		net_stats->multicast += rd32(wx, WX_PX_MPRC(i));
> +	/* Rx Errors */
> +	net_stats->rx_errors = hwstats->crcerrs + hwstats->rlec;
> +	net_stats->rx_length_errors = hwstats->rlec;
> +	net_stats->rx_crc_errors = hwstats->crcerrs;
> +}
> +EXPORT_SYMBOL(wx_update_stats);

...

> @@ -877,9 +879,11 @@ static bool wx_clean_tx_irq(struct wx_q_vector *q_vector,
>  
>  		if (__netif_subqueue_stopped(tx_ring->netdev,
>  					     tx_ring->queue_index) &&
> -		    netif_running(tx_ring->netdev))
> +		    netif_running(tx_ring->netdev)) {
>  			netif_wake_subqueue(tx_ring->netdev,
>  					    tx_ring->queue_index);
> +			++tx_ring->tx_stats.restart_queue;
> +		}
>  	}
>  
>  	return !!budget;
> @@ -956,6 +960,7 @@ static int wx_maybe_stop_tx(struct wx_ring *tx_ring, u16 size)
>  
>  	/* A reprieve! - use start_queue because it doesn't call schedule */
>  	netif_start_subqueue(tx_ring->netdev, tx_ring->queue_index);
> +	++tx_ring->tx_stats.restart_queue;
>  
>  	return 0;
>  }
> @@ -1533,8 +1538,10 @@ static netdev_tx_t wx_xmit_frame_ring(struct sk_buff *skb,
>  		count += TXD_USE_COUNT(skb_frag_size(&skb_shinfo(skb)->
>  						     frags[f]));
>  
> -	if (wx_maybe_stop_tx(tx_ring, count + 3))
> +	if (wx_maybe_stop_tx(tx_ring, count + 3)) {
> +		tx_ring->tx_stats.tx_busy++;
>  		return NETDEV_TX_BUSY;
> +	}
>  

