Return-Path: <netdev+bounces-255551-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yN9LByKYfmlTbQIAu9opvQ
	(envelope-from <netdev+bounces-255551-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 01:02:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EA5C46CA
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 01:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 790B13015D1D
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 00:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A791A3EBF35;
	Sun,  1 Feb 2026 00:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeviGF80"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CCF163;
	Sun,  1 Feb 2026 00:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769904159; cv=none; b=MGt4W9oyN8m4jrxoPQ4k1TJWz8bnZ0TkvuMweiOwjA9cdzdRKG0Mn79QglMLARff5+sRy0gz4L7Yl5cAEQ9h/q+z9Z+h5B56e004f76RccQlV0gdUf9k+aNYGNBJvXm42YSDB7gd6AKp1LmNwdXl9CXUii0tS0oDLkOkn4l+mpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769904159; c=relaxed/simple;
	bh=oUi0nMaMrH1PZFx8wHi2LyYp7blgKlrgCLUYZ5ozKPM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kbrJQdQ/X2vO//lVxsM16M3B0wMv+ZNZZ+oo6HU0jNpw8Qbj4zUVlUPKzMXeYQGlb/c8zMdZ4+8/fAz7013l/B5/pUHCSw714+lpCrmhXWx/bXMelD7wCgaBS14R1X+Cxx+rk4199DxwdFX+xcZ+WFp+zosQXQjG9QCV+7qKMiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeviGF80; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52CEAC4CEF1;
	Sun,  1 Feb 2026 00:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769904159;
	bh=oUi0nMaMrH1PZFx8wHi2LyYp7blgKlrgCLUYZ5ozKPM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KeviGF80GbEOwKXkmGzPFGEvOoJbynhnNP4CHPfOse/QOJUuAArBFGZJBEB/Wvipl
	 M8RjTqHqoDxp4Cyc8sclpm54bKeIbv1Vk+GFqkfRasFgu8MkemXr/8fuMu2xVDq8Vn
	 VdlDzm8WYer+MlVPCddWggGCR52yf1GfqjCXWnSD071LiSqGjyDd/emvTwGj12WlzF
	 Be4xyrPeM66sracyqGo3Rct1W0WL57cJNggYPt5CqWhf/aJlrXLEx4yNJPApboHOlX
	 TN7IHEmp8VQ62chlh4l7JqeTlBiuMaiHp5ffhRB0eMDSGYxOYqs7YFTqcXMKf6MLfW
	 Pf0dOct40M0Xw==
Date: Sat, 31 Jan 2026 16:02:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v8 06/16] net: Proxy net_mp_{open,close}_rxq
 for leased queues
Message-ID: <20260131160237.07789674@kernel.org>
In-Reply-To: <20260129222830.439687-7-daniel@iogearbox.net>
References: <20260129222830.439687-1-daniel@iogearbox.net>
	<20260129222830.439687-7-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255551-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,kernel.org,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 89EA5C46CA
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 23:28:20 +0100 Daniel Borkmann wrote:
> @@ -191,24 +214,15 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
>  }
>  EXPORT_SYMBOL_NS_GPL(netdev_rx_queue_restart, "NETDEV_INTERNAL");
>  
> -int net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
> -		    const struct pp_memory_provider_params *p,
> -		    struct netlink_ext_ack *extack)
> +static int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
> +			     const struct pp_memory_provider_params *p,
> +			     struct netlink_ext_ack *extack)
>  {
>  	const struct netdev_queue_mgmt_ops *qops = dev->queue_mgmt_ops;
>  	struct netdev_queue_config qcfg[2];
>  	struct netdev_rx_queue *rxq;
>  	int ret;
>  
> -	if (!netdev_need_ops_lock(dev))
> -		return -EOPNOTSUPP;
> -
> -	if (rxq_idx >= dev->real_num_rx_queues) {
> -		NL_SET_ERR_MSG(extack, "rx queue index out of range");
> -		return -ERANGE;
> -	}
> -	rxq_idx = array_index_nospec(rxq_idx, dev->real_num_rx_queues);
> -

> +int net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
> +		    const struct pp_memory_provider_params *p,
> +		    struct netlink_ext_ack *extack)
> +{
> +	struct net_device *orig_dev = dev;
> +	int ret;
> +
> +	if (!netdev_need_ops_lock(dev))
> +		return -EOPNOTSUPP;
> +
> +	if (rxq_idx >= dev->real_num_rx_queues) {
> +		NL_SET_ERR_MSG(extack, "rx queue index out of range");
> +		return -ERANGE;
> +	}
> +

nit: delete this empty line please, like it was in the original code.

> +	rxq_idx = array_index_nospec(rxq_idx, dev->real_num_rx_queues);
> +
> +	if (!netif_get_rx_queue_lease_locked(&dev, &rxq_idx)) {
> +		NL_SET_ERR_MSG(extack, "rx queue leased to a virtual netdev");
> +		return -EBUSY;
> +	}
> +	if (!dev->dev.parent) {
> +		NL_SET_ERR_MSG(extack, "rx queue belongs to a virtual netdev");
> +		ret = -EOPNOTSUPP;
> +		goto out;
> +	}
> +
> +	ret = __net_mp_open_rxq(dev, rxq_idx, p, extack);
> +out:
> +	netif_put_rx_queue_lease_locked(orig_dev, dev);
> +	return ret;

Please:

	if (!netif_queue_is_a_lease())
		return __net_mp_open_rxq(dev, rxq_idx, p, extack);

	..explicit code that deals with the lease, no conditional locking
	...
	ret = __net_mp_open_rxq($dev, $rxq_idx, p, extack);
	...


> -	rxq = __netif_get_rx_queue(dev, ifq_idx);
> +	rxq = __netif_get_rx_queue(dev, rxq_idx);

Indeed good to cleanup the ifq_idx naming that sneaked in, but IDK if
this belongs in this commit :S

