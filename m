Return-Path: <netdev+bounces-124083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05790967ED8
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 07:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4654EB217C7
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 05:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEC77DA81;
	Mon,  2 Sep 2024 05:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YkHX6Zb0"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082DA195;
	Mon,  2 Sep 2024 05:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725255370; cv=none; b=ghCHeOUGLWhbAZvG6x5kzXdLfP+pS04mWspJhVTXH60kmoALnVfP+1EbTBPLDWjaYcIGygLlclTYt5xVZAsJIz5HSvj8JiUWOSjU59Xn//5Yw2yOniKrZmysHq0SfseTc2H6EA6rljlp3v7WLKqxlALOiGrvJvqsN7ybg5XlcSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725255370; c=relaxed/simple;
	bh=uDwQKpz+rQf9nOxJn7c2gkv6Bl9b3ZM0TcssRbvz+jQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=COIZIf++YClXCZOvfscDEXGanyEHNsX8hBHxORIqX8zA1hoejdRwierc8NFF+sIErAMLJMn8N6IvRzm321iB4RABbctVE+MeFizuzgNzAbT4b+biQunbw5awykC3IYw3Wd4ksxi4P70Na7JOhfBDoXMEAhlA3ygWfEWAIrOkAUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YkHX6Zb0; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4825ZpkR120665;
	Mon, 2 Sep 2024 00:35:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725255351;
	bh=WZ59zBqwq+723lxdIL24tUg61XO83oLUhG1HMUJwh6A=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=YkHX6Zb0FSJgXps0yjktJVDeW/y7sMG+3ezYuLncD4OZ1j4cAgvgmdnyQdhuWmGkW
	 vG9W6A5nTpE0ZVZOCqpPenr6p1E8DLMA+XRB9XlFV/47jFYPjAyz0j2c22uOjVQynj
	 QcQT2T39KrN5o3J/3Ts4LDRqGYr3Xmvxw+8YERbM=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4825ZpPt009351
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Sep 2024 00:35:51 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Sep 2024 00:35:51 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Sep 2024 00:35:51 -0500
Received: from [10.249.135.225] ([10.249.135.225])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4825Zjtv078931;
	Mon, 2 Sep 2024 00:35:46 -0500
Message-ID: <9ef62d97-e72b-4b66-b535-a1de8fe43d57@ti.com>
Date: Mon, 2 Sep 2024 11:05:45 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 4/6] net: ti: icssg-prueth: Enable HSR Tx
 Packet duplication offload
To: Roger Quadros <rogerq@kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
        Andrew Lunn <andrew@lunn.ch>, Dan Carpenter <dan.carpenter@linaro.org>,
        Jan
 Kiszka <jan.kiszka@siemens.com>,
        Javier Carrasco
	<javier.carrasco.cruz@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Diogo Ivo <diogo.ivo@siemens.com>, Simon Horman <horms@kernel.org>,
        Richard
 Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S.
 Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>
References: <20240828091901.3120935-1-danishanwar@ti.com>
 <20240828091901.3120935-5-danishanwar@ti.com>
 <7ebd7657-8e79-44e4-9680-832946fab523@kernel.org>
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <7ebd7657-8e79-44e4-9680-832946fab523@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 8/30/2024 7:00 PM, Roger Quadros wrote:
> 
> 
> On 28/08/2024 12:18, MD Danish Anwar wrote:
>> From: Ravi Gunasekaran <r-gunasekaran@ti.com>
>>
>> The HSR stack allows to offload its Tx packet duplication functionality to
>> the hardware. Enable this offloading feature for ICSSG driver
>>
>> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  drivers/net/ethernet/ti/icssg/icssg_common.c | 13 ++++++++++---
>>  drivers/net/ethernet/ti/icssg/icssg_prueth.c |  5 +++--
>>  drivers/net/ethernet/ti/icssg/icssg_prueth.h |  2 ++
>>  3 files changed, 15 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
>> index b9d8a93d1680..2d6d8648f5a9 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
>> @@ -660,14 +660,15 @@ enum netdev_tx icssg_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev
>>  {
>>  	struct cppi5_host_desc_t *first_desc, *next_desc, *cur_desc;
>>  	struct prueth_emac *emac = netdev_priv(ndev);
>> +	struct prueth *prueth = emac->prueth;
>>  	struct netdev_queue *netif_txq;
>>  	struct prueth_tx_chn *tx_chn;
>>  	dma_addr_t desc_dma, buf_dma;
>> +	u32 pkt_len, dst_tag_id;
>>  	int i, ret = 0, q_idx;
>>  	bool in_tx_ts = 0;
>>  	int tx_ts_cookie;
>>  	void **swdata;
>> -	u32 pkt_len;
>>  	u32 *epib;
>>  
>>  	pkt_len = skb_headlen(skb);
>> @@ -712,9 +713,15 @@ enum netdev_tx icssg_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev
>>  
>>  	/* set dst tag to indicate internal qid at the firmware which is at
>>  	 * bit8..bit15. bit0..bit7 indicates port num for directed
>> -	 * packets in case of switch mode operation
>> +	 * packets in case of switch mode operation and port num 0
>> +	 * for undirected packets in case of HSR offload mode
>>  	 */
>> -	cppi5_desc_set_tags_ids(&first_desc->hdr, 0, (emac->port_id | (q_idx << 8)));
>> +	dst_tag_id = emac->port_id | (q_idx << 8);
>> +
>> +	if (prueth->is_hsr_offload_mode && (ndev->features & NETIF_F_HW_HSR_DUP))
>> +		dst_tag_id = PRUETH_UNDIRECTED_PKT_DST_TAG;
>> +
>> +	cppi5_desc_set_tags_ids(&first_desc->hdr, 0, dst_tag_id);
>>  	k3_udma_glue_tx_dma_to_cppi5_addr(tx_chn->tx_chn, &buf_dma);
>>  	cppi5_hdesc_attach_buf(first_desc, buf_dma, pkt_len, buf_dma, pkt_len);
>>  	swdata = cppi5_hdesc_get_swdata(first_desc);
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> index f4fd346fe6f5..b60efe7bd7a7 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> @@ -41,7 +41,8 @@
>>  #define DEFAULT_PORT_MASK	1
>>  #define DEFAULT_UNTAG_MASK	1
>>  
>> -#define NETIF_PRUETH_HSR_OFFLOAD_FEATURES	NETIF_F_HW_HSR_FWD
>> +#define NETIF_PRUETH_HSR_OFFLOAD_FEATURES	(NETIF_F_HW_HSR_FWD | \
>> +						 NETIF_F_HW_HSR_DUP)
> 
> You mentioned that these 2 features can't be enabled individually.
> 

Not these two but NETIF_F_HW_HSR_TAG_INS and NETIF_F_HW_HSR_DUP needs to
be enabled together. NETIF_F_HW_HSR_TAG_INS is added in patch 6/6.

2) Inorder to enable hsr-tag-ins-offload, hsr-dup-offload
   must also be enabled as these are tightly coupled in
   the firmware implementation.


> So better to squash this with previous patch and use ndo_fix_features() to make sure both
> are set or cleared together.
> 

I will squash patch 6/6 with this patch so that both are added in the
same patch. I will use ndo_fix_features() to make sure they re set /
unset together. I will add this also in this patch. Let me know if this
sounds good to you.

>>  
>>  /* CTRLMMR_ICSSG_RGMII_CTRL register bits */
>>  #define ICSSG_CTRL_RGMII_ID_MODE                BIT(24)
>> @@ -897,7 +898,7 @@ static int prueth_netdev_init(struct prueth *prueth,
>>  	ndev->ethtool_ops = &icssg_ethtool_ops;
>>  	ndev->hw_features = NETIF_F_SG;
>>  	ndev->features = ndev->hw_features;
>> -	ndev->hw_features |= NETIF_F_HW_HSR_FWD;
>> +	ndev->hw_features |= NETIF_PRUETH_HSR_OFFLOAD_FEATURES;
>>  
>>  	netif_napi_add(ndev, &emac->napi_rx, icssg_napi_rx_poll);
>>  	hrtimer_init(&emac->rx_hrtimer, CLOCK_MONOTONIC,
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> index a4b025fae797..e110a5f92684 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> @@ -59,6 +59,8 @@
>>  
>>  #define IEP_DEFAULT_CYCLE_TIME_NS	1000000	/* 1 ms */
>>  
>> +#define PRUETH_UNDIRECTED_PKT_DST_TAG	0
>> +
>>  /* Firmware status codes */
>>  #define ICSS_HS_FW_READY 0x55555555
>>  #define ICSS_HS_FW_DEAD 0xDEAD0000	/* lower 16 bits contain error code */
> 

-- 
Thanks and Regards,
Md Danish Anwar

