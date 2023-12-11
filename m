Return-Path: <netdev+bounces-55872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E622B80C9B7
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 13:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F3851F21161
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 12:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402823B2A7;
	Mon, 11 Dec 2023 12:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFaicvBJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243B639AE5
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 12:26:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3F7C433C8;
	Mon, 11 Dec 2023 12:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702297563;
	bh=8eH90tIOYIey9KHKlCcSawRSMqikjOiZSb7nrsddSW0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sFaicvBJ4/bL7bmRhgMM9AJPEukQ1E4qrhSnMDJIoPmNogg37hudxoTv0WiOfF8TF
	 8er7HYlxDUtGnf65Nj2yniGqdxb26/i5GMnW6saEeoSSZa0gkIVKnLf9y0GTMHMQqh
	 e0fwVa7+Quqnor6rPV1w0l07lHqdqY/uUcEPJ8qshMdwn/lN1bnDrIiC0a3Qut2i1Z
	 45nXw6TyzEAXe9n5Mm5L4C8VriavgNCi4ARoWxpde3Sn/SjY8Hvc7k+tKu/OcMeKT8
	 sDax9eBotWovg3m2seOJsmZwlaWz55R3r53tiscc5X2LCN9qCdYcezBfS0dHXBt7tS
	 fAOBnXORDbcHQ==
Message-ID: <0d2bfc00-86e4-440b-95d2-d25afd15c69f@kernel.org>
Date: Mon, 11 Dec 2023 14:25:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 6/8] net: ethernet: ti: am65-cpsw-qos: Add
 Frame Preemption MAC Merge support
Content-Language: en-US
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
 vigneshr@ti.com, srk@ti.com, horms@kernel.org, p-varis@ti.com,
 netdev@vger.kernel.org
References: <20231201135802.28139-1-rogerq@kernel.org>
 <20231201135802.28139-7-rogerq@kernel.org>
 <20231204123531.tpjbt7byzdnrhs7f@skbuf>
 <8caf8252-4068-4d17-b919-12adfef074e5@kernel.org>
 <7d8fb848-a491-414b-adb8-d26a16a499a4@kernel.org>
 <20231211121105.l5nk47b5uaptzhay@skbuf>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231211121105.l5nk47b5uaptzhay@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/12/2023 14:11, Vladimir Oltean wrote:
> On Fri, Dec 08, 2023 at 12:26:24PM +0200, Roger Quadros wrote:
>> On 08/12/2023 12:13, Roger Quadros wrote:
>>> Wondering how to fix this the right way. Should set/get_mm fail if CONFIG_TI_AM65_CPSW_TAS is not enabled?
>>>
>>
>> How about this fix?
>>
>> diff --git a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
>> index 1ac4b9b53c93..688291d6038f 100644
>> --- a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
>> +++ b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
>> @@ -775,6 +775,9 @@ static int am65_cpsw_get_mm(struct net_device *ndev, struct ethtool_mm_state *st
>>  	u32 port_ctrl, iet_ctrl, iet_status;
>>  	u32 add_frag_size;
>>  
>> +	if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS))
>> +		return -EOPNOTSUPP;
>> +
>>  	mutex_lock(&priv->mm_lock);
>>  
>>  	iet_ctrl = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
>> @@ -827,6 +830,9 @@ static int am65_cpsw_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
>>  	u32 val, add_frag_size;
>>  	int err;
>>  
>> +	if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS))
>> +		return -EOPNOTSUPP;
>> +
>>  	err = ethtool_mm_frag_size_min_to_add(cfg->tx_min_frag_size, &add_frag_size, extack);
>>  	if (err)
>>  		return err;
>> diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.h b/drivers/net/ethernet/ti/am65-cpsw-qos.h
>> index 6df3c2c5a04b..946e89fbb314 100644
>> --- a/drivers/net/ethernet/ti/am65-cpsw-qos.h
>> +++ b/drivers/net/ethernet/ti/am65-cpsw-qos.h
>> @@ -100,6 +100,8 @@ void am65_cpsw_qos_link_up(struct net_device *ndev, int link_speed);
>>  void am65_cpsw_qos_link_down(struct net_device *ndev);
>>  int am65_cpsw_qos_ndo_tx_p0_set_maxrate(struct net_device *ndev, int queue, u32 rate_mbps);
>>  void am65_cpsw_qos_tx_p0_rate_init(struct am65_cpsw_common *common);
>> +void am65_cpsw_iet_commit_preemptible_tcs(struct am65_cpsw_port *port);
>> +void am65_cpsw_iet_common_enable(struct am65_cpsw_common *common);
>>  #else
>>  static inline int am65_cpsw_qos_ndo_setup_tc(struct net_device *ndev,
>>  					     enum tc_setup_type type,
>> @@ -124,10 +126,12 @@ static inline int am65_cpsw_qos_ndo_tx_p0_set_maxrate(struct net_device *ndev,
>>  
>>  static inline void am65_cpsw_qos_tx_p0_rate_init(struct am65_cpsw_common *common)
>>  { }
>> +static inline void am65_cpsw_iet_commit_preemptible_tcs(struct am65_cpsw_port *port)
>> +{ }
>> +static inline void am65_cpsw_iet_common_enable(struct am65_cpsw_common *common)
>> +{ }
>>  #endif
>>  
>> -void am65_cpsw_iet_commit_preemptible_tcs(struct am65_cpsw_port *port);
>> -void am65_cpsw_iet_common_enable(struct am65_cpsw_common *common);
>>  
>>  #define AM65_CPSW_REG_CTL			0x004
>>  #define AM65_CPSW_PN_REG_CTL			0x004
>>
>>
>> -- 
>> cheers,
>> -roger
> 
> I don't know, does it sound like it is related?
> 
> config TI_AM65_CPSW_TAS
> 	bool "Enable TAS offload in AM65 CPSW"
> 	depends on TI_K3_AM65_CPSW_NUSS && NET_SCH_TAPRIO && TI_K3_AM65_CPTS
> 	help
> 	  Say y here to support Time Aware Shaper(TAS) offload in AM65 CPSW.
> 	  AM65 CPSW hardware supports Enhanced Scheduled Traffic (EST)
> 	  defined in IEEE 802.1Q 2018. The EST scheduler runs on CPTS and the
> 	  TAS/EST schedule is updated in the Fetch RAM memory of the CPSW.

The config option mentions only about TAS/EST 802.1Qbv.
Maybe it needs to be extended to include IET/Frame-preeption 802.1Qbu as well?

This is the simplest way as the file am65-cpsw-qos.c can be completely omitted if
TI_AM65_CPSW_TSN is not set.

-- 
cheers,
-roger

