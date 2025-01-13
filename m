Return-Path: <netdev+bounces-157885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE53FA0C248
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 20:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4411699DD
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 19:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB031C549F;
	Mon, 13 Jan 2025 19:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="lcfJcXnN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4144D1BD504
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 19:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736798387; cv=none; b=Lv6e1V/LBYAPt2IPIZ2+fYMNzNFHd5H/wKhwNYAR8OB0P143W+/diZpt44gBOXTRP/O2pr7fSxvvtWNGCu8xxpnNxTxljeqoB0c7LOnCA2XRw96nVc4bzh1ZYQZLWkjPGWAWuzJ9mNQQe5tFzpZxsVqOqLgbDToICYX5nhPLjhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736798387; c=relaxed/simple;
	bh=jxdOtjVau7wxxIy/ggw0jOnsKz8D4quYfM9PbMZxI9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfirslZUDE2pBMLyVhWbIekD8MzZN0Idq0jqjPN+VgLxvrXddUOIC2Vj7k09V8+EbEs2lyqY2jZYtMba5pEwANkeZCKyyqugRtrP/S8QGLSoR6sRCQFTxuRm+27ZOFyg05iwOR74AueQG6W1ccjuRmpkdAIkBticZ+JcerpqMkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=lcfJcXnN; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21a7ed0155cso80978445ad.3
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 11:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736798385; x=1737403185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FP1OLQq2oO6+heCmpR67enJ+J1EfH0SdobFPZeoQmDs=;
        b=lcfJcXnNLdKU8YMjgbinYCuIPGfvrR+FwlqLP8dBowKYPhjJTrNZBmCztf8a3+VP/h
         j6n43RxV7lXY4NqFR1pXEXx0bX0vwKjKGYW9MtCj43M0ETgG3zMbIH7d5ZT1wJhfgost
         VeIBVReIPygu/hoZ60Sqt6QhS3tqrr6sOyS7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736798385; x=1737403185;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FP1OLQq2oO6+heCmpR67enJ+J1EfH0SdobFPZeoQmDs=;
        b=Tnc8koeTeWVt609gbvAYqgajD1xR9banySb78m/yrWmKE17gPRMBNhuK9M8Jrw7goB
         fDr18yK6r4cQS112mSlWzzI2fzQuDmtUYGzR6o/4juazVg8kZXlOIWZgB+jUj8Np4bOW
         njxIpL/n56/3XGE1yadymwcTCSVPQ9swam0X48ZpJPjyVgfG0W22ACj+lPwvp5ts65Al
         VHgAwQhYdrye7Fs5wnqhtLmDapm1wD6GqZi40CPP/KpKtnI0TAo5PHc3A86KyYNwzn1U
         DzaZEx+qrP/pmGD/s7+Y8GhN+nxWZC7XmsHnqpPSKmSUzbXfUEvzFXpeRIaAfyujMVSn
         kQFw==
X-Forwarded-Encrypted: i=1; AJvYcCVVIX3+bFME/jg6C9tUGp9Y9OnvTApeZCgFkYYIREWe5gFSo/1l0Hv1hbt7LWDrpRFkbrTH6Cg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9XbuYruVhhBCQza+LVsZqPHdtt/iEcGUFqs/DCNuGmHEknY+H
	ZFqccQB2sbWypRz/q0o3hKe/0WQpItYQSY7O5wX9CdA6UMiZ/Mq/S5bdFms8snY=
X-Gm-Gg: ASbGnct/W0riqyvdvhxJBZvsNhoKTN86De17O7m5eY01zAPdvOLUbdAVGL7eoMuGA6V
	oH2BZ6IAtcDhljhbTQ1N1vNj0eg7iUFvo3kPvy/3MaU9VrSLugOHYozLnjidVHQTHpO8Lra7EKy
	nA+onfDMWHYGAOySDy2UL9oYNFd9WIbYHYnzi5UuxLXWiGAdSPJoZN0EjLAQVimCaj64G7fs9AB
	kBckpbNgI9t0cEov/LclMvNLwtYp/X0aKD/LxXp3/PjR2CsK+0/6Z/wFipVS3ENhXVaG4Md6arX
	t2RKuyytmWZSeT52iS3n+LQ=
X-Google-Smtp-Source: AGHT+IHYi/GggO/c1HSyoNoXXYasnNL3u761pIvDa8DXpWCEAy845VjsiQJlM7fewUKs1Y8aYvRKHQ==
X-Received: by 2002:a05:6a21:33a6:b0:1e8:bff6:8356 with SMTP id adf61e73a8af0-1e8bff68643mr17786546637.20.1736798385469;
        Mon, 13 Jan 2025 11:59:45 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40658a73sm6261116b3a.119.2025.01.13.11.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 11:59:45 -0800 (PST)
Date: Mon, 13 Jan 2025 11:59:42 -0800
From: Joe Damato <jdamato@fastly.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] tsnep: Link queues to NAPIs
Message-ID: <Z4VwrhhXU4uKqYGR@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Gerhard Engleder <gerhard@engleder-embedded.com>, andrew@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
References: <20250110223939.37490-1-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110223939.37490-1-gerhard@engleder-embedded.com>

On Fri, Jan 10, 2025 at 11:39:39PM +0100, Gerhard Engleder wrote:
> Use netif_queue_set_napi() to link queues to NAPI instances so that they
> can be queried with netlink.
> 
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                          --dump queue-get --json='{"ifindex": 11}'
> [{'id': 0, 'ifindex': 11, 'napi-id': 9, 'type': 'rx'},
>  {'id': 1, 'ifindex': 11, 'napi-id': 10, 'type': 'rx'},
>  {'id': 0, 'ifindex': 11, 'napi-id': 9, 'type': 'tx'},
>  {'id': 1, 'ifindex': 11, 'napi-id': 10, 'type': 'tx'}]
> 
> Additionally use netif_napi_set_irq() to also provide NAPI interrupt
> number to userspace.
> 
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                          --do napi-get --json='{"id": 9}'
> {'defer-hard-irqs': 0,
>  'gro-flush-timeout': 0,
>  'id': 9,
>  'ifindex': 11,
>  'irq': 42,
>  'irq-suspend-timeout': 0}
> 
> Providing information about queues to userspace makes sense as APIs like
> XSK provide queue specific access. Also XSK busy polling relies on
> queues linked to NAPIs.
> 
> Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
> ---
>  drivers/net/ethernet/engleder/tsnep_main.c | 28 ++++++++++++++++++----
>  1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
> index 45b9f5780902..71e950e023dc 100644
> --- a/drivers/net/ethernet/engleder/tsnep_main.c
> +++ b/drivers/net/ethernet/engleder/tsnep_main.c
> @@ -1984,23 +1984,41 @@ static int tsnep_queue_open(struct tsnep_adapter *adapter,
>  
>  static void tsnep_queue_enable(struct tsnep_queue *queue)
>  {
> +	struct tsnep_adapter *adapter = queue->adapter;
> +
> +	netif_napi_set_irq(&queue->napi, queue->irq);
>  	napi_enable(&queue->napi);
> -	tsnep_enable_irq(queue->adapter, queue->irq_mask);
> +	tsnep_enable_irq(adapter, queue->irq_mask);
>  
> -	if (queue->tx)
> +	if (queue->tx) {
> +		netif_queue_set_napi(adapter->netdev, queue->tx->queue_index,
> +				     NETDEV_QUEUE_TYPE_TX, &queue->napi);
>  		tsnep_tx_enable(queue->tx);
> +	}
>  
> -	if (queue->rx)
> +	if (queue->rx) {
> +		netif_queue_set_napi(adapter->netdev, queue->rx->queue_index,
> +				     NETDEV_QUEUE_TYPE_RX, &queue->napi);
>  		tsnep_rx_enable(queue->rx);
> +	}
>  }
>  
>  static void tsnep_queue_disable(struct tsnep_queue *queue)
A>  {
> -	if (queue->tx)
> +	struct tsnep_adapter *adapter = queue->adapter;
> +
> +	if (queue->rx)
> +		netif_queue_set_napi(adapter->netdev, queue->rx->queue_index,
> +				     NETDEV_QUEUE_TYPE_RX, NULL);
> +
> +	if (queue->tx) {
>  		tsnep_tx_disable(queue->tx, &queue->napi);
> +		netif_queue_set_napi(adapter->netdev, queue->tx->queue_index,
> +				     NETDEV_QUEUE_TYPE_TX, NULL);
> +	}
>  
>  	napi_disable(&queue->napi);
> -	tsnep_disable_irq(queue->adapter, queue->irq_mask);
> +	tsnep_disable_irq(adapter, queue->irq_mask);
>  
>  	/* disable RX after NAPI polling has been disabled, because RX can be
>  	 * enabled during NAPI polling

The changes generally look OK to me (it seems RTNL is held on all
paths where this code can be called from as far as I can tell), but
there was one thing that stood out to me.

AFAIU, drivers avoid marking XDP queues as NETDEV_QUEUE_TYPE_RX
or NETDEV_QUEUE_TYPE_TX. I could be wrong, but that was my
understanding and I submit patches to several drivers with this
assumption.

For example, in commit b65969856d4f ("igc: Link queues to NAPI
instances"), I unlinked/linked the NAPIs and queue IDs when XDP was
enabled/disabled. Likewise, in commit 64b62146ba9e ("net/mlx4: link
NAPI instances to queues and IRQs"), I avoided the XDP queues.

If drivers are to avoid marking XDP queues as NETDEV_QUEUE_TYPE_RX
or NETDEV_QUEUE_TYPE_TX, perhaps tsnep needs to be modified
similarly?

