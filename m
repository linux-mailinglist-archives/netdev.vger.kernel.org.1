Return-Path: <netdev+bounces-205210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 611A5AFDCE0
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 03:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B46685841E6
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 01:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900F517BED0;
	Wed,  9 Jul 2025 01:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmpbkE8O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66385156F4A;
	Wed,  9 Jul 2025 01:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752024440; cv=none; b=X8YZ+/3Rxm3jHuM8eaLJ39GW7+CnvSGh6NTgVWHfaTltumlu3mnWZ20EBuMmQLi/CZvr+++lPjxZa3BabCiDAaVgsV5NIi+Ioj3KAi7JBNJEiiWhM5lQOAHdpS9mpUUFSJmB30Ub6IGhhaevKZtqwICcLeCZ7QWNpOCRoQ7bJkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752024440; c=relaxed/simple;
	bh=3qKp4OirmL5iiTHmB7o2DL/lL8+uVoiwE9iUiN7HcyM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oRKOSP/tGmTl0MFggughVk6vPS8x5t0UZQIVTSHKzDtzLAggzigrddlyu5IeJOAUypVdhNvd3UgHCAnHpcAfoqzhVpGtbDMZz1wi1bnBwpw/Ya1uvWpVFcTM78gKa/AiplIBcGUQYOaXYjWIgl0fpjThFvpeiO04dHAKrzi9UeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmpbkE8O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835DCC4CEED;
	Wed,  9 Jul 2025 01:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752024439;
	bh=3qKp4OirmL5iiTHmB7o2DL/lL8+uVoiwE9iUiN7HcyM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jmpbkE8OuvMIXr3Luz3KunGgMdw2sOg9q2FfyO+Rood1K9G4geaLE+RuOjwG3eGXH
	 cLwHtN5JC3BIqChLgciwTZ8q2+LU6EuyubeHIykfKpUCyGpX8HQZNIh4+7ZKeoO2wi
	 IJZjdkXRp9PoJITRFsdzCodkQWBoy4VyDDYzomhgi7sEHr1hbymBLo/r3Qyc78MiuN
	 rIJal/8yrVu3RKU4Xf2ukN88/KYoNPsE+XewdQ44qiz8NWg56hM80SKI6Ax/RUbrLM
	 1PGjbfEvtWdnExGmd6wAmFemzVVN7wUXh49h/kens2lx3i+E5P3YL3Vu4po4sA751I
	 efu9loIB0NeKA==
Date: Tue, 8 Jul 2025 18:27:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, dw@davidwei.uk
Subject: Re: [PATCH net-next v2] netdevsim: implement peer queue flow
 control
Message-ID: <20250708182718.29c4ae45@kernel.org>
In-Reply-To: <20250703-netdev_flow_control-v2-1-ab00341c9cc1@debian.org>
References: <20250703-netdev_flow_control-v2-1-ab00341c9cc1@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 03 Jul 2025 06:09:31 -0700 Breno Leitao wrote:
> +static int nsim_napi_rx(struct net_device *dev, struct nsim_rq *rq,
> +			struct sk_buff *skb)
>  {
>  	if (skb_queue_len(&rq->skb_queue) > NSIM_RING_SIZE) {
> +		nsim_stop_peer_tx_queue(dev, rq, skb_get_queue_mapping(skb));
>  		dev_kfree_skb_any(skb);
>  		return NET_RX_DROP;
>  	}

we should probably add:

	if (skb_queue_len(&rq->skb_queue) > NSIM_RING_SIZE)
		nsim_stop_tx_queue(dev, rq, skb_get_queue_mapping(skb));

after enqueuing the skb, so that we stop the queue before any drops
happen

> @@ -51,7 +109,7 @@ static int nsim_napi_rx(struct nsim_rq *rq, struct sk_buff *skb)
>  static int nsim_forward_skb(struct net_device *dev, struct sk_buff *skb,
>  			    struct nsim_rq *rq)
>  {
> -	return __dev_forward_skb(dev, skb) ?: nsim_napi_rx(rq, skb);
> +	return __dev_forward_skb(dev, skb) ?: nsim_napi_rx(dev, rq, skb);
>  }
>  
>  static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)

nsim_start_xmit() has both dev and peer_dev, pass them all the way to
nsim_stop_peer_tx_queue() so that you don't have to try to dereference
the peer again.

> +	if (dev->real_num_tx_queues != peer_dev->num_rx_queues)

given that we compare real_num_tx_queues I think we should also kick
the queues in nsim_set_channels(), like we do in unlink_device_store()
-- 
pw-bot: cr

