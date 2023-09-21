Return-Path: <netdev+bounces-35427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE677A9767
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D52F1C20E81
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 17:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48009171CC;
	Thu, 21 Sep 2023 17:05:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FEF171AF
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:05:39 +0000 (UTC)
Received: from out-213.mta0.migadu.com (out-213.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136DD86A9
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:05:32 -0700 (PDT)
Message-ID: <49fed647-f8aa-857c-4edc-d38cf6a793d7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1695293466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TUQe97Z2n2H+dEfGKaSrBlczHq95ctlYALxcdiloxk4=;
	b=t4MQmHA/6hredlGRT0QZHtb4vVfctTYXHqIsRrLRA4wtKymi2Pfj108a++PvVufkT9UOvt
	w6LXhMGh6Jy44sDrk/IeIjWyTj35CBE3gPRA2MnxLBXTAJVAxtslGBJhofjSpk1PmUPAbQ
	UYMR1eLFSUmA7tuADuPlxtmlzIFgKwA=
Date: Thu, 21 Sep 2023 11:51:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: qualcomm: rmnet: Add side band flow control
 support
Content-Language: en-US
To: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org
Cc: Sean Tranchetti <quic_stranche@quicinc.com>
References: <20230920003337.1317132-1-quic_subashab@quicinc.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20230920003337.1317132-1-quic_subashab@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 20/09/2023 01:33, Subash Abhinov Kasiviswanathan wrote:
> Individual rmnet devices map to specific network types such as internet,
> multimedia messaging services, IP multimedia subsystem etc. Each of
> these network types may support varying quality of service for different
> bearers or traffic types.
> 
> The physical device interconnect to radio hardware may support a
> higher data rate than what is actually supported by the radio network.
> Any packets transmitted to the radio hardware which exceed the radio
> network data rate limit maybe dropped. This patch tries to minimize the
> loss of packets by adding support for bearer level flow control within a
> rmnet device by ensuring that the packets transmitted do not exceed the
> limit allowed by the radio network.
> 
> In order to support multiple bearers, rmnet must be created as a
> multiqueue TX netdevice. Radio hardware communicates the supported
> bearer information for a given network via side band signalling.
> Consider the following mapping -
> 
> IPv4 UDP port 1234 - Mark 0x1001 - Queue 1
> IPv6 TCP port 2345 - Mark 0x2001 - Queue 2
> 
> iptables can be used to install filters which mark packets matching these
> specific traffic patterns and the RMNET_QUEUE_MAPPING_ADD operation can
> then be to install the mapping of the mark to the specific txqueue.
> 
> If the traffic limit is exceeded for a particular bearer, radio hardware
> would notify that the bearer cannot accept more packets and the
> corresponding txqueue traffic can be stopped using RMNET_QUEUE_DISABLE.
> 
> Conversely, if radio hardware can send more traffic for a particular
> bearer, RMNET_QUEUE_ENABLE can be used to allow traffic on that
> particular txqueue. RMNET_QUEUE_MAPPING_REMOVE can be used to remove the
> mark to queue mapping in case the radio network doesn't support that
> particular bearer any longer.
> 
> Signed-off-by: Sean Tranchetti <quic_stranche@quicinc.com>
> Signed-off-by: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>

[ ... ]

> +	case RMNET_QUEUE_ENABLE:
> +	case RMNET_QUEUE_DISABLE:
> +		p = xa_load(&priv->queue_map, mark);
> +		if (p && xa_is_value(p)) {
> +			txq = xa_is_value(p);

                  should it be xa_to_value(p)? otherwise txq is always 1

> +			if (txq >= dev->num_tx_queues) {
> +				NL_SET_ERR_MSG_MOD(extack,
> +						   "queue mapping limit exceeded");
> +				return -EINVAL;
> +			}
> +
> +			q = netdev_get_tx_queue(dev, txq);
> +			if (unlikely(!q)) {
> +				NL_SET_ERR_MSG_MOD(extack,
> +						   "unsupported queue mapping");
> +				return -EINVAL;
> +			}
> +

[ ... ]

>   
>   struct rmnet_port *rmnet_get_port_rcu(struct net_device *real_dev);
> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
> index 046b5f7d8e7c..6dfee4a4d634 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
> @@ -1,5 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /* Copyright (c) 2013-2018, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>    *
>    * RMNET Data virtual network driver
>    */
> @@ -158,6 +159,23 @@ static void rmnet_get_stats64(struct net_device *dev,
>   	s->tx_dropped = total_stats.tx_drops;
>   }
>   
> +static u16 rmnet_vnd_select_queue(struct net_device *dev,
> +				  struct sk_buff *skb,
> +				  struct net_device *sb_dev)
> +{
> +	struct rmnet_priv *priv = netdev_priv(dev);
> +	void *p = xa_load(&priv->queue_map, skb->mark);
> +	u8 txq;
> +
> +	if (!p && !xa_is_value(p))
> +		return 0;

The check is meaningless. I believe you were thinking about

if (!p || !xa_is_value(p))

But the main question: is it even possible to get something from xarray
that won't pass the check? queue_map is filled in the same code, there 
is now way (I believe) to change it from anywhere else, right?

> +
> +	txq = xa_to_value(p);
> +
> +	netdev_dbg(dev, "mark %u -> txq %u\n", skb->mark, txq);
> +	return (txq < dev->num_tx_queues) ? txq : 0;
> +}



