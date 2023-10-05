Return-Path: <netdev+bounces-38232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6207B9D0E
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 14:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id DA7F2281C93
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 12:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E75134C8;
	Thu,  5 Oct 2023 12:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnYQeBCH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3162017F5
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 12:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1880C3279C;
	Thu,  5 Oct 2023 12:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696509897;
	bh=tfP78HkdL2aboDchfP7ZoYSDLCLouHOG9G2V0CQzbiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TnYQeBCHeTPdu4n9iiu7+5L3J+kLoVMQkmnPfWS6z+qjC6EryDY+tsf3PsbdE4r/Y
	 ontRAVI/JXGFC1YDwiJejv6LJ7xdAN5WizhwtZdC7/RY0vB/cw29XXrapjcH3WvJHW
	 /fEEvpCOb0UnQ3wkBkXQnUzNrB5VsgExVkWu0nkcbF8Z5q4s9sqAYKmP5Tt5f4hmHU
	 PhyB4dEISSZ0nxu5ZJr2YOS4gsloJhAUTXv1KkoG7Mun/DkbhPykOzcuWlvyq1INPW
	 ItTeaG4lKNw4EGXfa2fbBgMJyOItFyPKHUcFyivOTgInaTAi0jq6lhceqtqYWnkEBf
	 FE//vq5P6upZQ==
Date: Thu, 5 Oct 2023 14:44:53 +0200
From: Simon Horman <horms@kernel.org>
To: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev, lkp@intel.com,
	Sean Tranchetti <quic_stranche@quicinc.com>
Subject: Re: [PATCH net-next v3] net: qualcomm: rmnet: Add side band flow
 control support
Message-ID: <ZR6vxaot4AP7FXTg@kernel.org>
References: <20231004204320.1068010-1-quic_subashab@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004204320.1068010-1-quic_subashab@quicinc.com>

On Wed, Oct 04, 2023 at 01:43:20PM -0700, Subash Abhinov Kasiviswanathan wrote:
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

Hi Subash and Sean,

a few comments on error handling from my side.

...

> @@ -88,6 +90,66 @@ static int rmnet_register_real_device(struct net_device *real_dev,
>  	return 0;
>  }
>  
> +static int rmnet_update_queue_map(struct net_device *dev, u8 operation,
> +				  u8 txqueue, u32 mark,
> +				  struct netlink_ext_ack *extack)
> +{
> +	struct rmnet_priv *priv = netdev_priv(dev);
> +	struct netdev_queue *q;
> +	void *p;
> +	u8 txq;
> +
> +	if (unlikely(txqueue >= dev->num_tx_queues)) {
> +		NL_SET_ERR_MSG_MOD(extack, "invalid txqueue");
> +		return -EINVAL;
> +	}
> +
> +	switch (operation) {
> +	case RMNET_QUEUE_MAPPING_ADD:
> +		p = xa_store(&priv->queue_map, mark, xa_mk_value(txqueue),
> +			     GFP_ATOMIC);
> +		if (xa_is_err(p)) {
> +			NL_SET_ERR_MSG_MOD(extack, "unable to add mapping");
> +			return -EINVAL;
> +		}
> +		break;
> +	case RMNET_QUEUE_MAPPING_REMOVE:
> +		p = xa_erase(&priv->queue_map, mark);
> +		if (xa_is_err(p)) {
> +			NL_SET_ERR_MSG_MOD(extack, "unable to remove mapping");
> +			return -EINVAL;
> +		}
> +		break;
> +	case RMNET_QUEUE_ENABLE:
> +	case RMNET_QUEUE_DISABLE:
> +		p = xa_load(&priv->queue_map, mark);
> +		if (p && xa_is_value(p)) {
> +			txq = xa_to_value(p);
> +
> +			q = netdev_get_tx_queue(dev, txq);
> +			if (unlikely(!q)) {
> +				NL_SET_ERR_MSG_MOD(extack,
> +						   "unsupported queue mapping");
> +				return -EINVAL;
> +			}
> +
> +			if (operation == RMNET_QUEUE_ENABLE)
> +				netif_tx_wake_queue(q);
> +			else
> +				netif_tx_stop_queue(q);
> +		} else {
> +			NL_SET_ERR_MSG_MOD(extack, "invalid queue mapping");
> +			return -EINVAL;
> +		}
> +		break;
> +	default:
> +		NL_SET_ERR_MSG_MOD(extack, "unsupported operation");
> +		return -EINVAL;

I'm wondering if EOPNOTSUPP is appropriate here.

> +	}
> +
> +	return 0;
> +}
> +
>  static void rmnet_unregister_bridge(struct rmnet_port *port)
>  {
>  	struct net_device *bridge_dev, *real_dev, *rmnet_dev;
> @@ -175,8 +237,24 @@ static int rmnet_newlink(struct net *src_net, struct net_device *dev,
>  	netdev_dbg(dev, "data format [0x%08X]\n", data_format);
>  	port->data_format = data_format;
>  
> +	if (data[IFLA_RMNET_QUEUE]) {
> +		struct rmnet_queue_mapping *queue_map;
> +
> +		queue_map = nla_data(data[IFLA_RMNET_QUEUE]);
> +		if (rmnet_update_queue_map(dev, queue_map->operation,
> +					   queue_map->txqueue, queue_map->mark,
> +					   extack))

Should the return value of rmnet_update_queue_map() be stored in err
so that it is also the return value of this function?

> +			goto err3;
> +
> +		netdev_dbg(dev, "op %02x txq %02x mark %08x\n",
> +			   queue_map->operation, queue_map->txqueue,
> +			   queue_map->mark);
> +	}
> +
>  	return 0;
>  
> +err3:
> +	hlist_del_init_rcu(&ep->hlnode);

Is a call to netdev_upper_dev_unlink() needed here?

>  err2:
>  	unregister_netdevice(dev);
>  	rmnet_vnd_dellink(mux_id, port, ep);
> @@ -352,6 +430,20 @@ static int rmnet_changelink(struct net_device *dev, struct nlattr *tb[],
>  		}
>  	}
>  
> +	if (data[IFLA_RMNET_QUEUE]) {
> +		struct rmnet_queue_mapping *queue_map;
> +
> +		queue_map = nla_data(data[IFLA_RMNET_QUEUE]);
> +		if (rmnet_update_queue_map(dev, queue_map->operation,
> +					   queue_map->txqueue, queue_map->mark,
> +					   extack))
> +			return -EINVAL;

I guess that with the current implementation of rmnet_update_queue_map()
it makes no difference, but perhaps it would be better to return
the return value of rmnet_update_queue_map() rather than hard coding
-EINVAL here.

> +
> +		netdev_dbg(dev, "op %02x txq %02x mark %08x\n",
> +			   queue_map->operation, queue_map->txqueue,
> +			   queue_map->mark);
> +	}
> +
>  	return 0;
>  }
>  

...

