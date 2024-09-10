Return-Path: <netdev+bounces-127096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1780897412D
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 19:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 995751F267E7
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 17:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F391A4B7F;
	Tue, 10 Sep 2024 17:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rXIJWGxz"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D51B192D7B;
	Tue, 10 Sep 2024 17:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725990810; cv=none; b=QBxB7Juvj79EP948nU1BdfjrT1IS4jr9MRiCUk6lARBogf+9/zDmLSuW/m/bmhX6yunUvuKkVd5JE1hBSi8n5HT8UxgZ1L3n2EBHxEucLdSXQyhH0h66Exm6PErLoCy0npqhn0g1HE3kR4JKEimPAgf9OFT+4vqyqf+Ha7J5t7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725990810; c=relaxed/simple;
	bh=0ru3h4KSMO+7tkntex5ptOLE0afcV6b0izcgVxnbS6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ERFIFeS9zOdTGL143/+r+jB5ANzJ0Mc+RqedwMRjrU0bpDNKLo0cgkHYp1sc0n1Ztpiad3bN7kSkqZLFDzzqT8PhnBLjsm9/IRg812iF0oQMknebKXu+AT114muguIXhorVNCTNVDW+GhKyjEblkZvLiQq/AzVPEGpeX9E38iLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rXIJWGxz; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48AHr4Sd106080;
	Tue, 10 Sep 2024 12:53:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725990784;
	bh=GsY444LNAR1ZPcf/6FOhSGl8OO3RnSfb2+VhXOUepII=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=rXIJWGxzeSlKwEs23TS/RYAr9fYqsEtnQXRfOk1r2/eAqcSVFxrU0WbEjuDeULfjO
	 AtZYPTtvgRfJ+UqXi6NAytyZBJbkOp5UtJEKFlX3JKclotqV5j0IfcZgTCwoIbmOnE
	 1hN8VDaAZC2DyLopncvJPUeEt/hv+eKcr1PsQgzY=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48AHr3mG068829
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Sep 2024 12:53:03 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Sep 2024 12:53:03 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Sep 2024 12:53:03 -0500
Received: from [10.249.135.225] ([10.249.135.225])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48AHquh5113745;
	Tue, 10 Sep 2024 12:52:57 -0500
Message-ID: <e2379571-09ab-4061-8428-37707de32bc5@ti.com>
Date: Tue, 10 Sep 2024 23:22:56 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 4/5] net: ti: icssg-prueth: Enable HSR Tx
 duplication, Tx Tag and Rx Tag offload
To: Roger Quadros <rogerq@kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
        <robh@kernel.org>, <jan.kiszka@siemens.com>,
        <dan.carpenter@linaro.org>, <saikrishnag@marvell.com>,
        <andrew@lunn.ch>, <javier.carrasco.cruz@gmail.com>,
        <jacob.e.keller@intel.com>, <diogo.ivo@siemens.com>,
        <horms@kernel.org>, <richardcochran@gmail.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>
References: <20240906111538.1259418-1-danishanwar@ti.com>
 <20240906111538.1259418-5-danishanwar@ti.com>
 <7df37a43-e2d6-4775-859d-1ca05f456e21@kernel.org>
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <7df37a43-e2d6-4775-859d-1ca05f456e21@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Roger,

On 9/10/2024 11:08 PM, Roger Quadros wrote:
> 
> 
> On 06/09/2024 14:15, MD Danish Anwar wrote:
>> From: Ravi Gunasekaran <r-gunasekaran@ti.com>
>>
>> The HSR stack allows to offload its Tx packet duplication functionality to
>> the hardware. Enable this offloading feature for ICSSG driver. Add support
>> to offload HSR Tx Tag Insertion and Rx Tag Removal and duplicate discard.
>>
>> Inorder to enable hsr-tag-ins-offload, hsr-dup-offload must also be enabled
> 
> "In order"
> 
>> as these are tightly coupled in the firmware implementation.
>>
>> Duplicate discard is done as part of RX tag removal and it is
>> done by the firmware. When driver sends the r30 command
>> ICSSG_EMAC_HSR_RX_OFFLOAD_ENABLE, firmware does RX tag removal as well as
>> duplicate discard.
>>
>> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  drivers/net/ethernet/ti/icssg/icssg_common.c | 18 ++++++++++---
>>  drivers/net/ethernet/ti/icssg/icssg_config.c |  4 ++-
>>  drivers/net/ethernet/ti/icssg/icssg_config.h |  2 ++
>>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 28 +++++++++++++++++++-
>>  drivers/net/ethernet/ti/icssg/icssg_prueth.h |  3 +++
>>  5 files changed, 50 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
>> index b9d8a93d1680..fdebeb2f84e0 100644
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
>> @@ -712,9 +713,20 @@ enum netdev_tx icssg_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev
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
>> +	if (prueth->is_hsr_offload_mode &&
>> +	    (ndev->features & NETIF_F_HW_HSR_DUP))
>> +		dst_tag_id = PRUETH_UNDIRECTED_PKT_DST_TAG;
>> +
>> +	if (prueth->is_hsr_offload_mode &&
>> +	    (ndev->features & NETIF_F_HW_HSR_TAG_INS))
>> +		epib[1] |= PRUETH_UNDIRECTED_PKT_TAG_INS;
>> +
>> +	cppi5_desc_set_tags_ids(&first_desc->hdr, 0, dst_tag_id);
>>  	k3_udma_glue_tx_dma_to_cppi5_addr(tx_chn->tx_chn, &buf_dma);
>>  	cppi5_hdesc_attach_buf(first_desc, buf_dma, pkt_len, buf_dma, pkt_len);
>>  	swdata = cppi5_hdesc_get_swdata(first_desc);
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
>> index 7b2e6c192ff3..72ace151d8e9 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_config.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
>> @@ -531,7 +531,9 @@ static const struct icssg_r30_cmd emac_r32_bitmask[] = {
>>  	{{EMAC_NONE,  0xffff4000, EMAC_NONE, EMAC_NONE}},	/* Preemption on Tx ENABLE*/
>>  	{{EMAC_NONE,  0xbfff0000, EMAC_NONE, EMAC_NONE}},	/* Preemption on Tx DISABLE*/
>>  	{{0xffff0010,  EMAC_NONE, 0xffff0010, EMAC_NONE}},	/* VLAN AWARE*/
>> -	{{0xffef0000,  EMAC_NONE, 0xffef0000, EMAC_NONE}}	/* VLAN UNWARE*/
>> +	{{0xffef0000,  EMAC_NONE, 0xffef0000, EMAC_NONE}},	/* VLAN UNWARE*/
>> +	{{0xffff2000, EMAC_NONE, EMAC_NONE, EMAC_NONE}},	/* HSR_RX_OFFLOAD_ENABLE */
>> +	{{0xdfff0000, EMAC_NONE, EMAC_NONE, EMAC_NONE}}		/* HSR_RX_OFFLOAD_DISABLE */
>>  };
>>  
>>  int icssg_set_port_state(struct prueth_emac *emac,
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.h b/drivers/net/ethernet/ti/icssg/icssg_config.h
>> index 1ac60283923b..92c2deaa3068 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_config.h
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.h
>> @@ -80,6 +80,8 @@ enum icssg_port_state_cmd {
>>  	ICSSG_EMAC_PORT_PREMPT_TX_DISABLE,
>>  	ICSSG_EMAC_PORT_VLAN_AWARE_ENABLE,
>>  	ICSSG_EMAC_PORT_VLAN_AWARE_DISABLE,
>> +	ICSSG_EMAC_HSR_RX_OFFLOAD_ENABLE,
>> +	ICSSG_EMAC_HSR_RX_OFFLOAD_DISABLE,
>>  	ICSSG_EMAC_PORT_MAX_COMMANDS
>>  };
>>  
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> index 676168d6fded..9af06454ba64 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> @@ -41,7 +41,10 @@
>>  #define DEFAULT_PORT_MASK	1
>>  #define DEFAULT_UNTAG_MASK	1
>>  
>> -#define NETIF_PRUETH_HSR_OFFLOAD_FEATURES	NETIF_F_HW_HSR_FWD
>> +#define NETIF_PRUETH_HSR_OFFLOAD_FEATURES	(NETIF_F_HW_HSR_FWD | \
>> +						 NETIF_F_HW_HSR_DUP | \
>> +						 NETIF_F_HW_HSR_TAG_INS | \
>> +						 NETIF_F_HW_HSR_TAG_RM)
>>  
>>  /* CTRLMMR_ICSSG_RGMII_CTRL register bits */
>>  #define ICSSG_CTRL_RGMII_ID_MODE                BIT(24)
>> @@ -758,6 +761,21 @@ static void emac_change_hsr_feature(struct net_device *ndev,
>>  	}
>>  }
>>  
>> +static netdev_features_t emac_ndo_fix_features(struct net_device *ndev,
>> +					       netdev_features_t features)
>> +{
>> +	/* In order to enable hsr tag insertion offload, hsr dup offload must
>> +	 * also be enabled as these two are tightly coupled in firmware
>> +	 * implementation.
>> +	 */
>> +	if (features & NETIF_F_HW_HSR_TAG_INS)
>> +		features |= NETIF_F_HW_HSR_DUP;
> 
> What if only NETIF_F_HW_HSR_DUP was set? Don't you have to set NETIF_F_HW_HSR_TAG_INS as well?
> 
>> +	else
>> +		features &= ~NETIF_F_HW_HSR_DUP;
> 
> what if NETIF_F_HW_HSR_DUP was still set?
> 
> I think you need to write a logic like follows.
> 	if both are already cleared in ndev->features and any one is set in features you set both in features.
> 	if both are already set in ndev->features and any one is cleared in features you clear both in features.
> 
> is this reasonable?
> 

Yes that does sound reasonable,
How does below code look to you.

	if (!(ndev->features & NETIF_F_HW_HSR_DUP) &&
	    !(ndev->features & NETIF_F_HW_HSR_TAG_INS))
		if ((features & NETIF_F_HW_HSR_DUP) ||
		    (features & NETIF_F_HW_HSR_TAG_INS)) {
			features |= NETIF_F_HW_HSR_DUP;
			features |= NETIF_F_HW_HSR_TAG_INS;
		}

	if ((ndev->features & NETIF_F_HW_HSR_DUP) &&
	    (ndev->features & NETIF_F_HW_HSR_TAG_INS))
		if (!(features & NETIF_F_HW_HSR_DUP) ||
		    !(features & NETIF_F_HW_HSR_TAG_INS)) {
			features &= ~NETIF_F_HW_HSR_DUP;
			features &= ~NETIF_F_HW_HSR_TAG_INS;
		}

>> +
>> +	return features;
>> +}
>> +
>>  static int emac_ndo_set_features(struct net_device *ndev,
>>  				 netdev_features_t features)
>>  {
>> @@ -780,6 +798,7 @@ static const struct net_device_ops emac_netdev_ops = {
>>  	.ndo_eth_ioctl = icssg_ndo_ioctl,
>>  	.ndo_get_stats64 = icssg_ndo_get_stats64,
>>  	.ndo_get_phys_port_name = icssg_ndo_get_phys_port_name,
>> +	.ndo_fix_features = emac_ndo_fix_features,
>>  	.ndo_set_features = emac_ndo_set_features,
>>  };
>>  
>> @@ -1007,6 +1026,13 @@ static void icssg_change_mode(struct prueth *prueth)
>>  
>>  	for (mac = PRUETH_MAC0; mac < PRUETH_NUM_MACS; mac++) {
>>  		emac = prueth->emac[mac];
>> +		if (prueth->is_hsr_offload_mode) {
>> +			if (emac->ndev->features & NETIF_F_HW_HSR_TAG_RM)
>> +				icssg_set_port_state(emac, ICSSG_EMAC_HSR_RX_OFFLOAD_ENABLE);
>> +			else
>> +				icssg_set_port_state(emac, ICSSG_EMAC_HSR_RX_OFFLOAD_DISABLE);
>> +		}
>> +
>>  		if (netif_running(emac->ndev)) {
>>  			icssg_fdb_add_del(emac, eth_stp_addr, prueth->default_vlan,
>>  					  ICSSG_FDB_ENTRY_P0_MEMBERSHIP |
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> index a4b025fae797..bba6da2e6bd8 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> @@ -59,6 +59,9 @@
>>  
>>  #define IEP_DEFAULT_CYCLE_TIME_NS	1000000	/* 1 ms */
>>  
>> +#define PRUETH_UNDIRECTED_PKT_DST_TAG	0
>> +#define PRUETH_UNDIRECTED_PKT_TAG_INS	BIT(30)
>> +
>>  /* Firmware status codes */
>>  #define ICSS_HS_FW_READY 0x55555555
>>  #define ICSS_HS_FW_DEAD 0xDEAD0000	/* lower 16 bits contain error code */
> 

-- 
Thanks and Regards,
Md Danish Anwar

