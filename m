Return-Path: <netdev+bounces-36647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1437B0FCA
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 02:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id BDB421C20925
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 00:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652E5163;
	Thu, 28 Sep 2023 00:12:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F4C17C6
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 00:12:34 +0000 (UTC)
Received: from out-197.mta0.migadu.com (out-197.mta0.migadu.com [91.218.175.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7FAF9
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 17:12:32 -0700 (PDT)
Message-ID: <8cbd0969-0c1f-3c19-778b-4af9b3ad6417@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1695859950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kYTdN2gVxeeLigM+vPnEEQiRKBD6T4IGoyGeM6lXCMo=;
	b=mVlJLC/Uq7Vp2e5JfxtGOCtuMPo6wCOnizTxMk/kOX1JSxox08E/88VSP5vPkLOLw4FVRO
	xGhSaLHMOt9EfaTBcsH4Opg6+Ux5kBeOLfZ8R6OuzomvnylAYFNDRPFjprRZz46L79swb6
	e8ax7gWvMdmMsmuxCSE5fejZxDA18hI=
Date: Thu, 28 Sep 2023 01:12:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2] net: qualcomm: rmnet: Add side band flow
 control support
Content-Language: en-US
To: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, lkp@intel.com
Cc: Sean Tranchetti <quic_stranche@quicinc.com>
References: <20230926182407.964671-1-quic_subashab@quicinc.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20230926182407.964671-1-quic_subashab@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 26/09/2023 19:24, Subash Abhinov Kasiviswanathan wrote:
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
> ---
> v1 -> v2
>   Fix incorrect xarray API usage in rmnet_update_queue_map() and remove some
>   unneccessary checks in rmnet_vnd_select_queue() as mentioned by Vadim.
>   Fix UAPI types as reported by kernel test robot.
> 
>   .../ethernet/qualcomm/rmnet/rmnet_config.c    | 96 ++++++++++++++++++-
>   .../ethernet/qualcomm/rmnet/rmnet_config.h    |  2 +
>   .../net/ethernet/qualcomm/rmnet/rmnet_vnd.c   | 21 ++++
>   include/uapi/linux/if_link.h                  | 16 ++++
>   4 files changed, 134 insertions(+), 1 deletion(-)

[...]

> +static u16 rmnet_vnd_select_queue(struct net_device *dev,
> +				  struct sk_buff *skb,
> +				  struct net_device *sb_dev)
> +{
> +	struct rmnet_priv *priv = netdev_priv(dev);
> +	void *p = xa_load(&priv->queue_map, skb->mark);

Reverse X-mas tree, please.

> +	u8 txq;
> +
> +	if (!p || !xa_is_value(p))
> +		return 0;
> +
> +	txq = xa_to_value(p);
> +
> +	netdev_dbg(dev, "mark %08x -> txq %02x\n", skb->mark, txq);
> +	return txq;
> +}
> +



