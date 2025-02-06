Return-Path: <netdev+bounces-163451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6633CA2A4AA
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 10:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCF727A149C
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 09:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5D7226528;
	Thu,  6 Feb 2025 09:35:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B1D22652B
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 09:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738834505; cv=none; b=bS36WxLUKV8Y/vaIMF+F9gzczolSvLdEvghgV2MjmGWoMrvG365uorxs1Q6sXUJwtQ41IPFmpo9zzP06Wl1hnRff6s0qj0c2gqFNc4vpF79i36Gq4AM78HIWtP2P1On9ov82PyY/70HfZQqTPWPb8MB/hFFfJd5BQfIKQ/agOYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738834505; c=relaxed/simple;
	bh=xwNW2rnL6WuNu4Bu2mCvnWRTADakVsFtzgL1yVDiAaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qMr/aEYWNkbOr3AVe+KKBzW19PqtynIv5C5iHPJwGwb7q8aDMAQYX9EdDc1PVAJa3aPpqOYCFwmxsDfzMa5/Idt3zboC+CyLkkJUOPN/EpZtbpPMdxi0Ypri195s9izBwsVTWiXi/YdMlCjxJl4GaB6+3XtbzJ/rCF4shqafm04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4YpX5X1PL7z20q2C;
	Thu,  6 Feb 2025 17:35:28 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id ECD251A016C;
	Thu,  6 Feb 2025 17:34:59 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 6 Feb 2025 17:34:59 +0800
Message-ID: <76025962-594e-442e-928f-d88ed1d73ab5@huawei.com>
Date: Thu, 6 Feb 2025 17:34:59 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 3/4] enic: Use the Page Pool API for RX
To: John Daley <johndale@cisco.com>, <benve@cisco.com>, <satishkh@cisco.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Nelson Escobar <neescoba@cisco.com>
References: <20250205235416.25410-1-johndale@cisco.com>
 <20250205235416.25410-4-johndale@cisco.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20250205235416.25410-4-johndale@cisco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/2/6 7:54, John Daley wrote:
> The Page Pool API improves bandwidth and CPU overhead by recycling pages
> instead of allocating new buffers in the driver. Make use of page pool
> fragment allocation for smaller MTUs so that multiple packets can share
> a page. For MTUs larger than PAGE_SIZE, adjust the 'order' page
> parameter so that contiguous pages can be used to receive the larger
> packets.
> 
> The RQ descriptor field 'os_buf' is repurposed to hold page pointers
> allocated from page_pool instead of SKBs. When packets arrive, SKBs are
> allocated and the page pointers are attached instead of preallocating SKBs.
> 
> 'alloc_fail' netdev statistic is incremented when page_pool_dev_alloc()
> fails.
> 
> Co-developed-by: Nelson Escobar <neescoba@cisco.com>
> Signed-off-by: Nelson Escobar <neescoba@cisco.com>
> Co-developed-by: Satish Kharat <satishkh@cisco.com>
> Signed-off-by: Satish Kharat <satishkh@cisco.com>
> Signed-off-by: John Daley <johndale@cisco.com>
> ---
>  drivers/net/ethernet/cisco/enic/enic.h      |  3 +
>  drivers/net/ethernet/cisco/enic/enic_main.c | 33 +++++++-
>  drivers/net/ethernet/cisco/enic/enic_rq.c   | 94 ++++++++-------------
>  drivers/net/ethernet/cisco/enic/vnic_rq.h   |  2 +
>  4 files changed, 71 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
> index 10b7e02ba4d0..2ccf2d2a77db 100644
> --- a/drivers/net/ethernet/cisco/enic/enic.h
> +++ b/drivers/net/ethernet/cisco/enic/enic.h
> @@ -17,6 +17,7 @@
>  #include "vnic_nic.h"
>  #include "vnic_rss.h"
>  #include <linux/irq.h>
> +#include <net/page_pool/helpers.h>
>  
>  #define DRV_NAME		"enic"
>  #define DRV_DESCRIPTION		"Cisco VIC Ethernet NIC Driver"
> @@ -158,6 +159,7 @@ struct enic_rq_stats {
>  	u64 pkt_truncated;		/* truncated pkts */
>  	u64 no_skb;			/* out of skbs */
>  	u64 desc_skip;			/* Rx pkt went into later buffer */
> +	u64 pp_alloc_fail;		/* page pool alloc failure */

why not consider adding the above to pool->alloc_stats so that other
drivers doesn't need to implement something similar?

>  };
>  
>  struct enic_wq {
> @@ -169,6 +171,7 @@ struct enic_wq {
>  struct enic_rq {
>  	struct vnic_rq vrq;
>  	struct enic_rq_stats stats;
> +	struct page_pool *pool;
>  } ____cacheline_aligned;
>  
>  /* Per-instance private data structure */
> diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
> index 1d9f109346b8..447c54dcd89b 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_main.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_main.c
> @@ -1736,6 +1736,17 @@ static int enic_open(struct net_device *netdev)
>  	struct enic *enic = netdev_priv(netdev);
>  	unsigned int i;
>  	int err, ret;
> +	unsigned int max_pkt_len = netdev->mtu + VLAN_ETH_HLEN;
> +	struct page_pool_params pp_params = {
> +		.order = get_order(max_pkt_len),
> +		.pool_size = enic->config.rq_desc_count,
> +		.nid = dev_to_node(&enic->pdev->dev),
> +		.dev = &enic->pdev->dev,
> +		.dma_dir = DMA_FROM_DEVICE,
> +		.max_len = (max_pkt_len > PAGE_SIZE) ? max_pkt_len : PAGE_SIZE,

Perhaps change the checking to ((max_pkt_len << 1) > PAGE_SIZE) to avoid
overhead of dma sync operation as much as possible?

Also, there is a similar checking page_pool_alloc(), maybe add an inline
helper for that checking so that there is a consistent checking for both
page_pool core and drivers.

> +		.netdev = netdev,
> +		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
> +	};


