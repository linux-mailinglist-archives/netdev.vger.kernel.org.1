Return-Path: <netdev+bounces-120966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 895DC95B4CD
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 14:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C6832864C1
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 12:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DE61C9452;
	Thu, 22 Aug 2024 12:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rNa90iTq"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7521C944B;
	Thu, 22 Aug 2024 12:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724328895; cv=none; b=m1I2oVfsPneEpX0flFssRY/VwPwqZz7yBpof7shy4xNJZFU5IzJ7dq4BuywmiCPca9G7qmpguML3A+9tV5InQ6s34W6s1oXZ6/HN8UzDhsg76yyuGtrNRtitsOMxnR6WYjs/9w/5TUe8rg21y8pW6yiMjtT5A/RalswGbEZZ6Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724328895; c=relaxed/simple;
	bh=ATJVp3lpnkfs4QsNFNntgkzRlk3XMHUwG4vsdi09DVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Qaz6M9T7EM2rH1uWa66mqsfMk7INvzUOZBpgEtwIQzPqOdREMYTb6NByStqWJ0iPOcdkNwPlLlgvYXwiw0qPgaPeRngq1lCnXnyN5hv7Ve59ZvCoBJvH2obchgZL7Ap8DdHjsCqeRYnpfxi/rdMF04jan0EQ9C5u6/yG3OhBEAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rNa90iTq; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47MCEP7W083434;
	Thu, 22 Aug 2024 07:14:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724328865;
	bh=DSYOcj5Ckgo8h2B8oow/pztkj2240hze06pziEVRE44=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=rNa90iTq6GzGO56/5tc60EmZEsgrwgLewCu9Lr/0kJMnGnr841KO7LNBaQhdneFGW
	 2ixRE12+IwgF05PW8NgOIQmNaGFB08rppVjAIBJiosEmiPGOCZbYOl30FqTWjJlAbA
	 UFziabLXATMf8fAqrmSZRYBfaV/M8EiaKpGXTVRU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47MCEPKY097467
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Aug 2024 07:14:25 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Aug 2024 07:14:25 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Aug 2024 07:14:25 -0500
Received: from [10.249.135.225] ([10.249.135.225])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47MCEFR8104126;
	Thu, 22 Aug 2024 07:14:16 -0500
Message-ID: <3bee2863-8d6c-4b62-aadf-a051b6f9905a@ti.com>
Date: Thu, 22 Aug 2024 17:44:14 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 7/7] net: ti: icssg-prueth: Enable HSR Tx Tag
 and Rx Tag offload
To: Roger Quadros <rogerq@kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
        Dan Carpenter <dan.carpenter@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
        Jan
 Kiszka <jan.kiszka@siemens.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Jacob Keller
	<jacob.e.keller@intel.com>,
        Diogo Ivo <diogo.ivo@siemens.com>, Simon Horman
	<horms@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
References: <20240813074233.2473876-1-danishanwar@ti.com>
 <20240813074233.2473876-8-danishanwar@ti.com>
 <9f8beb62-42db-47d9-bba6-f942a655217d@kernel.org>
 <cfb025a4-41a4-448f-a7a8-7ce14f8532f5@ti.com>
 <e89b3b8d-98db-4bf7-b90b-4df1fd1105e3@kernel.org>
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <e89b3b8d-98db-4bf7-b90b-4df1fd1105e3@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 8/22/2024 4:58 PM, Roger Quadros wrote:
> 
> 
> On 22/08/2024 11:03, MD Danish Anwar wrote:
>>
>>
>> On 21/08/24 5:45 pm, Roger Quadros wrote:
>>>
>>>
>>> On 13/08/2024 10:42, MD Danish Anwar wrote:
>>>> From: Ravi Gunasekaran <r-gunasekaran@ti.com>
>>>>
>>>> Add support to offload HSR Tx Tag Insertion and Rx Tag Removal
>>>> and duplicate discard.
>>>
>>> I can see code for Tx Tag insertion and RX tag removal.
>>> Where are you doing duplicate discard in this patch?
>>>
>>
>> Roger, duplicate discard is done as part of RX tag removal and it is
>> done by firmware.
>> When driver sends the command ICSSG_EMAC_HSR_RX_OFFLOAD_ENABLE, firmware
>> does RX tag removal as well as duplicate discard.
>>
>> Maybe I can modify the commit message to stated that duplicate discard
>> is done as part of rx tag removal?
> 
> Yes please, that will help. Thanks!
> 

Sure Roger, will do.

>>
>>>>
>>>> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>>>> ---
>>>>  drivers/net/ethernet/ti/icssg/icssg_common.c |  3 +++
>>>>  drivers/net/ethernet/ti/icssg/icssg_config.c |  4 +++-
>>>>  drivers/net/ethernet/ti/icssg/icssg_config.h |  2 ++
>>>>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 11 ++++++++++-
>>>>  drivers/net/ethernet/ti/icssg/icssg_prueth.h |  1 +
>>>>  5 files changed, 19 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
>>>> index 2d6d8648f5a9..4eae4f9250c0 100644
>>>> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
>>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
>>>> @@ -721,6 +721,9 @@ enum netdev_tx icssg_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev
>>>>  	if (prueth->is_hsr_offload_mode && (ndev->features & NETIF_F_HW_HSR_DUP))
>>>>  		dst_tag_id = PRUETH_UNDIRECTED_PKT_DST_TAG;
>>>>  
>>>> +	if (prueth->is_hsr_offload_mode && (ndev->features & NETIF_F_HW_HSR_TAG_INS))
>>>> +		epib[1] |= PRUETH_UNDIRECTED_PKT_TAG_INS;
>>>> +
>>>>  	cppi5_desc_set_tags_ids(&first_desc->hdr, 0, dst_tag_id);
>>>>  	k3_udma_glue_tx_dma_to_cppi5_addr(tx_chn->tx_chn, &buf_dma);
>>>>  	cppi5_hdesc_attach_buf(first_desc, buf_dma, pkt_len, buf_dma, pkt_len);
>>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
>>>> index 2f485318c940..f061fa97a377 100644
>>>> --- a/drivers/net/ethernet/ti/icssg/icssg_config.c
>>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
>>>> @@ -531,7 +531,9 @@ static const struct icssg_r30_cmd emac_r32_bitmask[] = {
>>>>  	{{EMAC_NONE,  0xffff4000, EMAC_NONE, EMAC_NONE}},	/* Preemption on Tx ENABLE*/
>>>>  	{{EMAC_NONE,  0xbfff0000, EMAC_NONE, EMAC_NONE}},	/* Preemption on Tx DISABLE*/
>>>>  	{{0xffff0010,  EMAC_NONE, 0xffff0010, EMAC_NONE}},	/* VLAN AWARE*/
>>>> -	{{0xffef0000,  EMAC_NONE, 0xffef0000, EMAC_NONE}}	/* VLAN UNWARE*/
>>>> +	{{0xffef0000,  EMAC_NONE, 0xffef0000, EMAC_NONE}},	/* VLAN UNWARE*/
>>>> +	{{0xffff2000, EMAC_NONE, EMAC_NONE, EMAC_NONE}},	/* HSR_RX_OFFLOAD_ENABLE */
>>>> +	{{0xdfff0000, EMAC_NONE, EMAC_NONE, EMAC_NONE}}		/* HSR_RX_OFFLOAD_DISABLE */
>>>>  };
>>>>  
>>>>  int icssg_set_port_state(struct prueth_emac *emac,
>>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.h b/drivers/net/ethernet/ti/icssg/icssg_config.h
>>>> index 1ac60283923b..92c2deaa3068 100644
>>>> --- a/drivers/net/ethernet/ti/icssg/icssg_config.h
>>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.h
>>>> @@ -80,6 +80,8 @@ enum icssg_port_state_cmd {
>>>>  	ICSSG_EMAC_PORT_PREMPT_TX_DISABLE,
>>>>  	ICSSG_EMAC_PORT_VLAN_AWARE_ENABLE,
>>>>  	ICSSG_EMAC_PORT_VLAN_AWARE_DISABLE,
>>>> +	ICSSG_EMAC_HSR_RX_OFFLOAD_ENABLE,
>>>> +	ICSSG_EMAC_HSR_RX_OFFLOAD_DISABLE,
>>>>  	ICSSG_EMAC_PORT_MAX_COMMANDS
>>>>  };
>>>>  
>>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>>>> index 521e9f914459..582e72dd8f3f 100644
>>>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>>>> @@ -42,7 +42,9 @@
>>>>  #define DEFAULT_UNTAG_MASK	1
>>>>  
>>>>  #define NETIF_PRUETH_HSR_OFFLOAD	(NETIF_F_HW_HSR_FWD | \
>>>> -					 NETIF_F_HW_HSR_DUP)
>>>> +					 NETIF_F_HW_HSR_DUP | \
>>>> +					 NETIF_F_HW_HSR_TAG_INS | \
>>>> +					 NETIF_F_HW_HSR_TAG_RM)
>>>>  
>>>>  /* CTRLMMR_ICSSG_RGMII_CTRL register bits */
>>>>  #define ICSSG_CTRL_RGMII_ID_MODE                BIT(24)
>>>> @@ -1032,6 +1034,13 @@ static void icssg_change_mode(struct prueth *prueth)
>>>>  
>>>>  	for (mac = PRUETH_MAC0; mac < PRUETH_NUM_MACS; mac++) {
>>>>  		emac = prueth->emac[mac];
>>>> +		if (prueth->is_hsr_offload_mode) {
>>>> +			if (emac->ndev->features & NETIF_F_HW_HSR_TAG_RM)
>>>> +				icssg_set_port_state(emac, ICSSG_EMAC_HSR_RX_OFFLOAD_ENABLE);
>>
>> Duplicate discard is done here ^^^^
> 
> Got it.
> 
>>
>>>> +			else
>>>> +				icssg_set_port_state(emac, ICSSG_EMAC_HSR_RX_OFFLOAD_DISABLE);
>>>> +		}
>>>> +
>>>>  		if (netif_running(emac->ndev)) {
>>>>  			icssg_fdb_add_del(emac, eth_stp_addr, prueth->default_vlan,
>>>>  					  ICSSG_FDB_ENTRY_P0_MEMBERSHIP |
>>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>>>> index 6cb1dce8b309..246f1e41c13a 100644
>>>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>>>> @@ -58,6 +58,7 @@
>>>>  #define IEP_DEFAULT_CYCLE_TIME_NS	1000000	/* 1 ms */
>>>>  
>>>>  #define PRUETH_UNDIRECTED_PKT_DST_TAG	0
>>>> +#define PRUETH_UNDIRECTED_PKT_TAG_INS	BIT(30)
>>>>  
>>>>  /* Firmware status codes */
>>>>  #define ICSS_HS_FW_READY 0x55555555
>>>
>>
> 

-- 
Thanks and Regards,
Md Danish Anwar

