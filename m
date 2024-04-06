Return-Path: <netdev+bounces-85375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B4C89A7E6
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 02:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29E2A1F23104
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 00:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E2B620;
	Sat,  6 Apr 2024 00:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="wGg4+uzd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B37336B
	for <netdev@vger.kernel.org>; Sat,  6 Apr 2024 00:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712362809; cv=none; b=O9/mEpMszZBjH96v0Ba5XPeucl7lhLn4tNXOFaSAXlMNiTGhDdZR90f3kv24StxTZH/H/TYiBkrbuBNwhzB9qt/De8PM2FkWS33EAsPBcqSgGYDVJHGOcp4lA5bw4AR3NjAlxbqrA+OwsOtbNRwOD5mayccVw5GzM1VFwgfLjVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712362809; c=relaxed/simple;
	bh=m6ae/N3ftPzt0pSGMbATcQYKcV1V8KnPwebXCKeNz/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J1p/T+b7m7dAvQnPO7MeOL8b4Sz8obMPGaWQ0OD4M3joQ6AL6hvmna8P+CYdI1ANj2RAN4dXbAjbyGd+6rma91luZdXB0d/s0IMpDYHG0p0ALRs/nWTQGRoAzTHf/6oCxpgXMzErlhzwv/lyRr0LHNp3RrP3YoxAsTVZd8Qtsr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=wGg4+uzd; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6eaf7c97738so2231935b3a.2
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 17:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1712362807; x=1712967607; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O6hW7oPfHP2bYU3e5u3yAoQm2gACd7nMPuyXMRxuVwA=;
        b=wGg4+uzdc9ls5gtrKTC0JufkFfmIz5z7B3cS+5xE9gem6i+1Br1qFTF5rXIYLVag6c
         ivIqh1MHCHxoAah/BsttsWM1EN9rTgIymW72mgoWcJ36C848qp8UrhXNnlgv90KrkJ3Y
         iwxcMJkOcX4zo38Ftyyzoee7nrtqbOI7gh2lmQZKkZAA9gi76RaUQ0si0cjb7rxAjmAp
         3k3Ea3stxpkqgnRTE3F9aKqZJ1HeCrRDvTaGYtD2pBxxK7JU2MFTo7hKf36jrSrYsPWe
         15UslN4ktjV2IhsME9sMkWL/uUIB7w4R6bVpd082sWe437khwdw5VKN7Evpgo6mvRST7
         jZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712362807; x=1712967607;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O6hW7oPfHP2bYU3e5u3yAoQm2gACd7nMPuyXMRxuVwA=;
        b=Xb78Ur//8Dtk76R3NdhY39TvrumKYFhnCyDXC9PV1UfqAUddUS691u/BmTsqLqh+0d
         PXg9KJxg/S1n+RL8PtzqSmlNNsOkleB8t/vvszn0tgiHu2PXFKDFUYU0lk/9dt2+pTyu
         QLCfhIZGsdLKjWZFymEvX9+pTb6myozIO7arqiYAyvqdjpeycreCxPe/GykX4Dq9A6v7
         ciENNDf+8QY0AAJTiU7WnyNgmAxO2D59s5TVYrXj6f7nBm5LxafHQ8hIqtLe82Fu3GNn
         jxgSGRElBY1cbisAJ5OjmacPAO4VA0xUC22odQF43e2jc3+H/4024Ji2fcu/258+wDYE
         M1cw==
X-Forwarded-Encrypted: i=1; AJvYcCUhYO18zMkBlDDhaIEmfnqB7AJds/T6kJQa0BkySOKi58uNUiqdOn8QVBQd5bBg0EAyM6wph/uGAUbdVZlbVxb5BNQQfXVi
X-Gm-Message-State: AOJu0YzH9SAtiqUmSfjnFMqhtrAvWmgNuEQ8KZZz8fOLsbKaDFVuyLso
	HUxsMGMQgo3OIU/ZY5os0MOcn/CeVmNcCEJGKjf6hjRcBmtfa/9KrMD4bGO3t90=
X-Google-Smtp-Source: AGHT+IG8K37KT8wwQSwpHQ8eqTaHOh6igT6mWFvHtYe6kQL4jYJSc3nghXSGOMcXVbsyKjCG0uQJzA==
X-Received: by 2002:a05:6a00:139c:b0:6e8:f708:4b09 with SMTP id t28-20020a056a00139c00b006e8f7084b09mr3468725pfg.15.1712362807463;
        Fri, 05 Apr 2024 17:20:07 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1256:2:c51:2090:e106:83fa? ([2620:10d:c090:500::4:bbe8])
        by smtp.gmail.com with ESMTPSA id i4-20020aa787c4000000b006e64c9bc2b3sm2185545pfo.11.2024.04.05.17.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 17:20:07 -0700 (PDT)
Message-ID: <c6597621-dbb5-4891-8aba-f0596b08e667@davidwei.uk>
Date: Fri, 5 Apr 2024 17:20:05 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next, RFC PATCH 2/5] netdev-genl: Add netlink framework
 functions for queue-set NAPI
Content-Language: en-GB
To: Amritha Nambiar <amritha.nambiar@intel.com>, netdev@vger.kernel.org,
 kuba@kernel.org, davem@davemloft.net
Cc: edumazet@google.com, pabeni@redhat.com, ast@kernel.org, sdf@google.com,
 lorenzo@kernel.org, tariqt@nvidia.com, daniel@iogearbox.net,
 anthony.l.nguyen@intel.com, lucien.xin@gmail.com, hawk@kernel.org,
 sridhar.samudrala@intel.com
References: <171234737780.5075.5717254021446469741.stgit@anambiarhost.jf.intel.com>
 <171234777883.5075.17163018772262453896.stgit@anambiarhost.jf.intel.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <171234777883.5075.17163018772262453896.stgit@anambiarhost.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-04-05 13:09, Amritha Nambiar wrote:
> Implement the netdev netlink framework functions for associating
> a queue with NAPI ID.
> 
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> ---
>  include/linux/netdevice.h |    7 +++
>  net/core/netdev-genl.c    |  117 +++++++++++++++++++++++++++++++++++++++------
>  2 files changed, 108 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 0c198620ac93..70df1cec4a60 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1351,6 +1351,10 @@ struct netdev_net_notifier {
>   *			   struct kernel_hwtstamp_config *kernel_config,
>   *			   struct netlink_ext_ack *extack);
>   *	Change the hardware timestamping parameters for NIC device.
> + *
> + * int (*ndo_queue_set_napi)(struct net_device *dev, u32 q_idx, u32 q_type,
> + *			     struct napi_struct *napi);
> + *	Change the NAPI instance associated with the queue.
>   */
>  struct net_device_ops {
>  	int			(*ndo_init)(struct net_device *dev);
> @@ -1596,6 +1600,9 @@ struct net_device_ops {
>  	int			(*ndo_hwtstamp_set)(struct net_device *dev,
>  						    struct kernel_hwtstamp_config *kernel_config,
>  						    struct netlink_ext_ack *extack);
> +	int			(*ndo_queue_set_napi)(struct net_device *dev,
> +						      u32 q_idx, u32 q_type,
> +						      struct napi_struct *napi);
>  };
>  
>  /**
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index d5b2e90e5709..6b3d3165d76e 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -288,12 +288,29 @@ int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>  	return err;
>  }
>  
> +/* must be called under rtnl_lock() */
> +static struct napi_struct *
> +napi_get_by_queue(struct net_device *netdev, u32 q_idx, u32 q_type)
> +{
> +	struct netdev_rx_queue *rxq;
> +	struct netdev_queue *txq;
> +
> +	switch (q_type) {
> +	case NETDEV_QUEUE_TYPE_RX:
> +		rxq = __netif_get_rx_queue(netdev, q_idx);
> +		return rxq->napi;
> +	case NETDEV_QUEUE_TYPE_TX:
> +		txq = netdev_get_tx_queue(netdev, q_idx);
> +		return txq->napi;
> +	}
> +	return NULL;
> +}
> +
>  static int
>  netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
>  			 u32 q_idx, u32 q_type, const struct genl_info *info)
>  {
> -	struct netdev_rx_queue *rxq;
> -	struct netdev_queue *txq;
> +	struct napi_struct *napi;
>  	void *hdr;
>  
>  	hdr = genlmsg_iput(rsp, info);
> @@ -305,19 +322,9 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
>  	    nla_put_u32(rsp, NETDEV_A_QUEUE_IFINDEX, netdev->ifindex))
>  		goto nla_put_failure;
>  
> -	switch (q_type) {
> -	case NETDEV_QUEUE_TYPE_RX:
> -		rxq = __netif_get_rx_queue(netdev, q_idx);
> -		if (rxq->napi && nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID,
> -					     rxq->napi->napi_id))
> -			goto nla_put_failure;
> -		break;
> -	case NETDEV_QUEUE_TYPE_TX:
> -		txq = netdev_get_tx_queue(netdev, q_idx);
> -		if (txq->napi && nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID,
> -					     txq->napi->napi_id))
> -			goto nla_put_failure;
> -	}
> +	napi = napi_get_by_queue(netdev, q_idx, q_type);
> +	if (napi && nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID, napi->napi_id))
> +		goto nla_put_failure;
>  
>  	genlmsg_end(rsp, hdr);
>  
> @@ -674,9 +681,87 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
>  	return err;
>  }
>  
> +static int
> +netdev_nl_queue_set_napi(struct sk_buff *rsp, struct net_device *netdev,
> +			 u32 q_idx, u32 q_type, u32 napi_id,
> +			 const struct genl_info *info)
> +{
> +	struct napi_struct *napi, *old_napi;
> +	int err;
> +
> +	if (!(netdev->flags & IFF_UP))
> +		return 0;

Should this be an error code?

> +
> +	err = netdev_nl_queue_validate(netdev, q_idx, q_type);
> +	if (err)
> +		return err;
> +
> +	old_napi = napi_get_by_queue(netdev, q_idx, q_type);
> +	if (old_napi && old_napi->napi_id == napi_id)
> +		return 0;

Same as above, I think this should be an error.

> +
> +	napi = napi_by_id(napi_id);
> +	if (!napi)
> +		return -EINVAL;
> +
> +	err = netdev->netdev_ops->ndo_queue_set_napi(netdev, q_idx, q_type, napi);
> +
> +	return err;

nit: return ndo_queue_set_napi() would save two lines.

> +}
> +
>  int netdev_nl_queue_set_doit(struct sk_buff *skb, struct genl_info *info)
>  {
> -	return -EOPNOTSUPP;
> +	u32 q_id, q_type, ifindex;

nit: q_idx for consistency?

> +	struct net_device *netdev;
> +	struct sk_buff *rsp;
> +	u32 napi_id = 0;
> +	int err = 0;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_ID) ||
> +	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_TYPE) ||
> +	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_IFINDEX))
> +		return -EINVAL;
> +
> +	q_id = nla_get_u32(info->attrs[NETDEV_A_QUEUE_ID]);
> +	q_type = nla_get_u32(info->attrs[NETDEV_A_QUEUE_TYPE]);
> +	ifindex = nla_get_u32(info->attrs[NETDEV_A_QUEUE_IFINDEX]);
> +
> +	if (info->attrs[NETDEV_A_QUEUE_NAPI_ID]) {
> +		napi_id = nla_get_u32(info->attrs[NETDEV_A_QUEUE_NAPI_ID]);
> +		if (napi_id < MIN_NAPI_ID)
> +			return -EINVAL;
> +	}
> +
> +	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
> +	if (!rsp)
> +		return -ENOMEM;
> +
> +	rtnl_lock();
> +
> +	netdev = __dev_get_by_index(genl_info_net(info), ifindex);
> +	if (netdev) {
> +		if (!napi_id)
> +			GENL_SET_ERR_MSG(info, "No queue parameters changed\n");

Could this be checked earlier outside of rtnl_lock? I feel like not
setting a napi_id here is EINVAL.

> +		else
> +			err = netdev_nl_queue_set_napi(rsp, netdev, q_id,
> +						       q_type, napi_id, info);
> +		if (!err)
> +			err = netdev_nl_queue_fill_one(rsp, netdev, q_id,
> +						       q_type, info);
> +	} else {
> +		err = -ENODEV;

Could be less nesty (completely untested):

	if (!netdev) {
		err = -ENODEV;
		goto err_rtnl_unlock;
	}

	if (!napi_id) {
		GENL_SET_ERR_MSG(info, "No queue parameters changed\n");
		goto err_nonapi;
	}

	err = netdev_nl_queue_set_napi(rsp, netdev, q_id,
				       q_type, napi_id, info);
	if (err)
		goto err_rtnl_unlock;

err_nonapi:
	err = netdev_nl_queue_fill_one(rsp, netdev, q_id,
				       q_type, info);

err_rtnl_unlock:
	rtnl_unlock();

	if (!err)
		return genlmsg_reply(rsp, info);

err_free_msg:
	nlmsg_free(rsp);
	return err;

> +	}
> +
> +	rtnl_unlock();
> +
> +	if (err)
> +		goto err_free_msg;
> +
> +	return genlmsg_reply(rsp, info);
> +
> +err_free_msg:
> +	nlmsg_free(rsp);
> +	return err;
>  }
>  
>  static int netdev_genl_netdevice_event(struct notifier_block *nb,
> 

