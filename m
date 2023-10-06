Return-Path: <netdev+bounces-38573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D67A7BB78C
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 14:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6822282259
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 12:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678DD1D52B;
	Fri,  6 Oct 2023 12:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPDPrQ9+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C52D1CF8F
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 12:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312EDC433C7;
	Fri,  6 Oct 2023 12:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696595297;
	bh=3SAB/z4JQ4yxIUvay/XIvVc0hYSL/L+0t04LAbPkpLk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WPDPrQ9+pRgzQfUM0f3fFkybB7R/kGWvExeuUXVpngubEpgHTnWMQb4rVb9tP+ycF
	 oItjTvm8E6AsrpKfvQVvlFwQDKjqczh/KzYSw5jlwd11vR+E8m8YBKb9ibvgkFcck7
	 lQteEFVfKoH+wpZXut06j4jpEPYHSeaFGahTYyqeqFpDgCIwzK1hjaRTJsna4HJCyn
	 m6f6zvVO8XVwLn+KJ8uoSAykfCgSy+Bocz6WGQbGmln35r9fG0dU20R5OgWthwMxRy
	 /90WvZrhMPr+QXc0Qn+xycU0S+4jgplvxN45zloqlpqBbMcHKrAu3FZ+6yddfSaSY0
	 Xflvv0YmEq7pQ==
Message-ID: <f6eb4bfc-e8f5-491b-8b3b-4cb9eed79483@kernel.org>
Date: Fri, 6 Oct 2023 15:28:11 +0300
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
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, vladimir.oltean@nxp.com, s-vadapalli@ti.com, srk@ti.com,
 vigneshr@ti.com, p-varis@ti.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230927072741.21221-1-rogerq@kernel.org>
 <20230927072741.21221-3-rogerq@kernel.org>
 <20231001065554.GH92317@kernel.org>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231001065554.GH92317@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 01/10/2023 09:55, Simon Horman wrote:
> On Wed, Sep 27, 2023 at 10:27:39AM +0300, Roger Quadros wrote:
> 
> ...
> 
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
>> +		goto exit_put;am65_cpsw_iet_commit_preemptible_tcs
>> +	}
>> +
>> +	ret = am65_cpsw_mqprio_verify_shaper(port, mqprio);
>> +	if (ret)
>> +		goto exit_put;
>> +
>> +	netdev_set_num_tc(ndev, num_tc);
>> +
>> +	/* Multiple Linux priorities can map to a Traffic Class
>> +	 * A Traffic Class can have multiple contiguous Queues,
>> +	 * Queues get mapped to Channels (thread_id),
>> +	 *	if not VLAN tagged, thread_id is used as packet_priority
>> +	 *	if VLAN tagged. VLAN priority is used as packet_priorit
> 
> Hi,
> 
> I don't think it is worth respinning just because of this, but
> there seems to be a 'y' missing from the end of the line above.

Now that there will be  a re-spin. I'll fix this. Thanks!

> 
>> +	 * packet_priority gets mapped to header_priority in p0_rx_pri_map,
>> +	 * header_priority gets mapped to switch_priority in pn_tx_pri_map.
>> +	 * As p0_rx_pri_map is left at defaults (0x76543210), we can
>> +	 * assume that Queue_n gets mapped to header_priority_n. We can then
>> +	 * set the switch priority in pn_tx_pri_map.
>> +	 */
> 
> ...

-- 
cheers,
-roger

