Return-Path: <netdev+bounces-35140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B076A7A73D5
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 09:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20F7D281A2E
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 07:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FC58483;
	Wed, 20 Sep 2023 07:19:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51178472
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 07:19:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37707C433C7;
	Wed, 20 Sep 2023 07:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695194358;
	bh=WyO9M//XrozD9V7TnomV/MSTgBlPqTOV4kfhlkxyjSU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U+YO+seSaVhGE61tbw7daKIcwHsvtGx6VsQenbdtEZ77Rmrr0voTBoP7zvXToLX5p
	 8h8qn6gk0nul2EC9kuw8FTVswGOmVSVqIkK+rW9n8MTh7YQWlEjVNdVxcxmHCUAWY3
	 gHyLknMIgdQQP+Lu9GQQT0riUjYtZ6X5LfOJPq5uiUbtCzxkIPS/h4fmUaCO+NBq6E
	 hCtyMJxOABL4mwaJX6HXJLxbgRg6yDuiCBrayvBkdDPuypU5P0lDwc6SlHs7EhbVyl
	 uLq6ZqbALxmJiC1qzwR/gq0ZLWpCXlVkomuyrLntgNIkEVYmpGTdP6ZyLb5praUKFy
	 3tXT1Dw2+aMiA==
Message-ID: <79bd4b5b-7ea8-4a3b-d098-9aecd43b1675@kernel.org>
Date: Wed, 20 Sep 2023 10:19:12 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] net: ethernet: ti: am65-cpsw: add mqprio qdisc offload
 in channel mode
Content-Language: en-US
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, s-vadapalli@ti.com, srk@ti.com,
 vigneshr@ti.com, p-varis@ti.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, rogerq@kernel.rog
References: <20230918075358.5878-1-rogerq@kernel.org>
 <20230918075358.5878-1-rogerq@kernel.org>
 <20230919124703.hj2bvqeogfhv36qy@skbuf>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230919124703.hj2bvqeogfhv36qy@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Vladimir,

On 19/09/2023 15:47, Vladimir Oltean wrote:
> Hi Roger,
> 
> On Mon, Sep 18, 2023 at 10:53:58AM +0300, Roger Quadros wrote:
>> -int am65_cpsw_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
>> -			       void *type_data)
>> -{
>> -	switch (type) {
>> -	case TC_QUERY_CAPS:
>> -		return am65_cpsw_tc_query_caps(ndev, type_data);
>> -	case TC_SETUP_QDISC_TAPRIO:
>> -		return am65_cpsw_setup_taprio(ndev, type_data);
>> -	case TC_SETUP_BLOCK:
>> -		return am65_cpsw_qos_setup_tc_block(ndev, type_data);
>> -	default:
>> -		return -EOPNOTSUPP;
>> -	}
>> -}
>> -
>> -void am65_cpsw_qos_link_up(struct net_device *ndev, int link_speed)
>> -{
>> -	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
>> -
>> -	if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS))
>> -		return;
>> -
>> -	am65_cpsw_est_link_up(ndev, link_speed);
>> -	port->qos.link_down_time = 0;
>> -}
>> -
>> -void am65_cpsw_qos_link_down(struct net_device *ndev)
>> -{
>> -	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
>> -
>> -	if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS))
>> -		return;
>> -
>> -	if (!port->qos.link_down_time)
>> -		port->qos.link_down_time = ktime_get();
>> -
>> -	port->qos.link_speed = SPEED_UNKNOWN;
>> -}
>> -
> 
> Could you split the code movement to a separate change?

OK.

> 
>> +	if (port->qos.link_speed != SPEED_UNKNOWN) {
>> +		if (min_rate_total > port->qos.link_speed) {
>> +			NL_SET_ERR_MSG_FMT_MOD(extack, "TX rate min %llu exceeds link speed %d\n",
>> +					       min_rate_total, port->qos.link_speed);
>> +			return -EINVAL;
>> +		}
>> +
>> +		if (max_rate_total > port->qos.link_speed) {
>> +			NL_SET_ERR_MSG_FMT_MOD(extack, "TX rate max %llu exceeds link speed %d\n",
>> +					       max_rate_total, port->qos.link_speed);
>> +			return -EINVAL;
>> +		}
>> +	}
> 
> Link speeds can be renegotiated, and the mqprio offload can be installed
> while the link is down. So this restriction, while honorable, has limited
> usefulness.

For link down case it won't run those checks, but I get your point.
I'll drop these checks.

> 
>> +
>> +	p_mqprio->shaper_en = 1;
> 
> s/1/true/
> 
>> +	p_mqprio->max_rate_total = max_t(u64, min_rate_total, max_rate_total);
>> +
>> +	return 0;
>> +}
>> +
>> +static void am65_cpsw_reset_tc_mqprio(struct net_device *ndev)
>> +{
>> +	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
>> +	struct am65_cpsw_mqprio *p_mqprio = &port->qos.mqprio;
>> +	struct am65_cpsw_common *common = port->common;
>> +
>> +	p_mqprio->shaper_en = 0;
> 
> s/0/false/
> 
>> +	p_mqprio->max_rate_total = 0;
>> +
>> +	am65_cpsw_tx_pn_shaper_reset(port);
>> +	netdev_reset_tc(ndev);
>> +	netif_set_real_num_tx_queues(ndev, common->tx_ch_num);
>> +
>> +	/* Reset all Queue priorities to 0 */
>> +	writel(0,
>> +	       port->port_base + AM65_CPSW_PN_REG_TX_PRI_MAP);
> 
> What exactly needs pm_runtime_get_sync()? This writel() doesn't?

Good catch. In my tests, the network interface was up so controller
was already active. But we will need to do a pm_runtime_get_sync()
if all network interfaces of the controller are down.

So, I will need to move the pm_runtime_get_sync() call before
am65_cpsw_reset_tc_mqprio();

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
>> +	if (!num_tc) {
>> +		am65_cpsw_reset_tc_mqprio(ndev);
>> +		return 0;
>> +	}
>> +
>> +	ret = pm_runtime_get_sync(common->dev);
>> +	if (ret < 0) {
>> +		pm_runtime_put_noidle(common->dev);
>> +		return ret;
>> +	}

-- 
cheers,
-roger

