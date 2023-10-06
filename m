Return-Path: <netdev+bounces-38574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 966DE7BB793
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 14:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F3941C2098D
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 12:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B932D1D52F;
	Fri,  6 Oct 2023 12:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mA99UncT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9851CF8F
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 12:29:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F305C433C8;
	Fri,  6 Oct 2023 12:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696595393;
	bh=51m5wGizcEYElwYCHpNGdY2Iw17cdYgJSa3s4ueJ80c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mA99UncT6o3snJFGoBVaLbSwpgGUgls5XBwiTh0u9VViN7/TBCudO4vKCe9cnvG4h
	 qXlvoIViFOjiN/3+nxUIBqvbF1wqWQT9lkvYv3kB00erBsiJTpdKgjf9GpX8u9RQPh
	 UShGSg9leaGAyiF3aomIrKbpqf4bL7w9QzKQcG+WS3WZnn9uanWJmXHHoJlvRRf5jK
	 sOYIKHVeHeRwvquPS5od+xXvRCzaA8Nsaulsk+sOoAmC2FnjVc9VhHwRzb/nQpVdKF
	 Tc4q0haNp3BvNcG31UNflY2NTtwv6VutSodIUAkcUIJTHcuRgWgd9Y60D2TG0YVE07
	 nW5JLFJSRgfWA==
Message-ID: <6075c30f-5e2b-43b9-b57b-f4b9a918df22@kernel.org>
Date: Fri, 6 Oct 2023 15:29:49 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 2/4] net: ethernet: ti: am65-cpsw: add mqprio
 qdisc offload in channel mode
Content-Language: en-US
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, s-vadapalli@ti.com, srk@ti.com,
 vigneshr@ti.com, p-varis@ti.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230927072741.21221-1-rogerq@kernel.org>
 <20230927072741.21221-3-rogerq@kernel.org>
 <20231005090141.bjya2lfarcs3ujhb@skbuf>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231005090141.bjya2lfarcs3ujhb@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 05/10/2023 12:01, Vladimir Oltean wrote:
> On Wed, Sep 27, 2023 at 10:27:39AM +0300, Roger Quadros wrote:
>> diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.c b/drivers/net/ethernet/ti/am65-cpsw-qos.c
>> index f91137d8e73b..991221d8f148 100644
>> --- a/drivers/net/ethernet/ti/am65-cpsw-qos.c
>> +++ b/drivers/net/ethernet/ti/am65-cpsw-qos.c
>> @@ -16,10 +16,19 @@
>>  #include "cpsw_ale.h"
>>  
>>  #define AM65_CPSW_REG_CTL			0x004
>> +#define AM65_CPSW_P0_REG_TX_PRI_MAP		0x018
>> +#define AM65_CPSW_P0_REG_RX_PRI_MAP		0x020
>> +#define AM65_CPSW_P0_REG_FIFO_STATUS		0x050
>> +#define AM65_CPSW_P0_REG_PRI_CIR(pri)		(0x140 + 4 * (pri))
>> +#define AM65_CPSW_P0_REG_PRI_EIR(pri)		(0x160 + 4 * (pri))
>> +
>>  #define AM65_CPSW_PN_REG_CTL			0x004
>> +#define AM65_CPSW_PN_REG_TX_PRI_MAP		0x018
>> +#define AM65_CPSW_PN_REG_RX_PRI_MAP		0x020
>>  #define AM65_CPSW_PN_REG_FIFO_STATUS		0x050
>>  #define AM65_CPSW_PN_REG_EST_CTL		0x060
>>  #define AM65_CPSW_PN_REG_PRI_CIR(pri)		(0x140 + 4 * (pri))
>> +#define AM65_CPSW_PN_REG_PRI_EIR(pri)		(0x160 + 4 * (pri))
>>  
>>  /* AM65_CPSW_REG_CTL register fields */
>>  #define AM65_CPSW_CTL_EST_EN			BIT(18)
>> @@ -50,12 +59,18 @@
>>  #define AM65_CPSW_FETCH_ALLOW_MSK		GENMASK(7, 0)
>>  #define AM65_CPSW_FETCH_ALLOW_MAX		AM65_CPSW_FETCH_ALLOW_MSK
>>  
>> +#define TO_MBPS(x)	((x) * 8 / 1000000)
>> +
>>  enum timer_act {
>>  	TACT_PROG,		/* need program timer */
>>  	TACT_NEED_STOP,		/* need stop first */
>>  	TACT_SKIP_PROG,		/* just buffer can be updated */
>>  };
>>  
>> +/* number of priority queues per port FIFO */
>> +#define AM65_CPSW_PN_FIFO_PRIO_NUM		8
>> +#define AM65_CPSW_PN_TX_PRI_MAP_DEFAULT		0x76543210
> 
>> +static void am65_cpsw_reset_tc_mqprio(struct net_device *ndev)
>> +{
>> +	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
>> +	struct am65_cpsw_mqprio *p_mqprio = &port->qos.mqprio;
>> +	struct am65_cpsw_common *common = port->common;
>> +
>> +	p_mqprio->shaper_en = false;
>> +	p_mqprio->max_rate_total = 0;
>> +
>> +	am65_cpsw_tx_pn_shaper_reset(port);
>> +	netdev_reset_tc(ndev);
>> +	netif_set_real_num_tx_queues(ndev, common->tx_ch_num);
> 
> If this never gets changed from the value set by am65_cpsw_nuss_ndo_slave_open(),
> then there is no reason to call netif_set_real_num_tx_queues() here.
> 
>> +
>> +	/* Reset all Queue priorities to 0 */
>> +	writel(0, port->port_base + AM65_CPSW_PN_REG_TX_PRI_MAP);
> 
> To 0 or to AM65_CPSW_PN_TX_PRI_MAP_DEFAULT (which is now unused)?
> Also, do I understand correctly that immediately after boot, TX_PRI_MAP
> will have a different value than after the deletion of the mqprio root qdisc
> (if AM65_CPSW_PN_TX_PRI_MAP_DEFAULT represents the hardware default value)?
> The behavior needs to be identical in the 2 cases, since both represent
> "no mqprio offload".

Good catch. I'll get rid of AM65_CPSW_PN_TX_PRI_MAP_DEFAULT and set this to
0 at init time.

> 
>> +}
>> +
>> +static int am65_cpsw_setup_mqprio(struct net_device *ndev, void *type_data)
>> +{
>> +	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
>> +	struct am65_cpsw_mqprio *p_mqprio = &port->qos.mqprio;
>> +	struct tc_mqprio_qopt_offload *mqprio = type_data;
>> +	struct am65_cpsw_common *common = port->common;
>> +	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
>> +	int tc, offset, count, ret, prio;
>> +	u8 num_tc = qopt->num_tc;
>> +	u32 tx_prio_map = 0;
>> +	int i;
>> +
>> +	memcpy(&p_mqprio->mqprio_hw, mqprio, sizeof(*mqprio));
>> +
>> +	ret = pm_runtime_get_sync(common->dev);
>> +	if (ret < 0) {
>> +		pm_runtime_put_noidle(common->dev);
>> +		return ret;
>> +	}
>> +
>> +	if (!num_tc) {
>> +		am65_cpsw_reset_tc_mqprio(ndev);
>> +		goto exit_put;
>> +	}
>> +
>> +	ret = am65_cpsw_mqprio_verify_shaper(port, mqprio);
>> +	if (ret)
>> +		goto exit_put;
> 
> At "exit_put" we have "return 0" and this discards the value of "ret".

Will fix.

> 
>> +
>> +	netdev_set_num_tc(ndev, num_tc);
>> +
>> +	/* Multiple Linux priorities can map to a Traffic Class
>> +	 * A Traffic Class can have multiple contiguous Queues,
>> +	 * Queues get mapped to Channels (thread_id),
>> +	 *	if not VLAN tagged, thread_id is used as packet_priority
>> +	 *	if VLAN tagged. VLAN priority is used as packet_priorit
>> +	 * packet_priority gets mapped to header_priority in p0_rx_pri_map,
>> +	 * header_priority gets mapped to switch_priority in pn_tx_pri_map.
>> +	 * As p0_rx_pri_map is left at defaults (0x76543210), we can
>> +	 * assume that Queue_n gets mapped to header_priority_n. We can then
>> +	 * set the switch priority in pn_tx_pri_map.
>> +	 */
>> +
>> +	for (tc = 0; tc < num_tc; tc++) {
>> +		prio = tc;
>> +
>> +		/* For simplicity we assign the same priority (TCn) to
>> +		 * all queues of a Traffic Class.
>> +		 */
>> +		for (i = qopt->offset[tc]; i < qopt->offset[tc] + qopt->count[tc]; i++)
>> +			tx_prio_map |= prio << (4 * i);
>> +
>> +		count = qopt->count[tc];
>> +		offset = qopt->offset[tc];
>> +		netdev_set_tc_queue(ndev, tc, count, offset);
>> +	}
> 
> I think this is okay.
> 
>> +
>> +	writel(tx_prio_map,
>> +	       port->port_base + AM65_CPSW_PN_REG_TX_PRI_MAP);
> 
> Nit: This can be written on a single line.
> 
OK.

>> +
>> +	am65_cpsw_tx_pn_shaper_apply(port);
>> +
>> +exit_put:
>> +	pm_runtime_put(common->dev);
>> +	return 0;
>> +}
>> +
>>  int am65_cpsw_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
>>  			       void *type_data)
>>  {

-- 
cheers,
-roger

