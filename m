Return-Path: <netdev+bounces-158793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC80A13479
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 08:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9DFD18881CA
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 07:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E41F19644B;
	Thu, 16 Jan 2025 07:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GAaEeVRo"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47356156C76;
	Thu, 16 Jan 2025 07:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737014220; cv=none; b=Z877Z4onnREOU9M6zmE0x3pSQfQc18HB+M3VNVot3EQ9LPiHrQmqvU/VC3+m4BH7S/tgWw3Vd6BvuvA9Of/SI4he1BT7/C9Dzq7DL5OIfm+1RyJoXdWIuxE4I+9gx9MdZWGCoabxgvWxtvFuwepinpGamXjRCKViYyUYQM6inZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737014220; c=relaxed/simple;
	bh=ic1Tdl5eQV9IhEkanXH8pQd/pPr8stQL+iCCxmLxuHk=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=qL+6nfrpnCE3rKgCnV51OzrP8LBzNKrpqRq6sVw4RoYFyx2jBRZI6IkdO5ptZP/G/MS9C2RRe1sCJUH4EbcB5dGh6BANf49r5Dhv/L1wxQq5rck2c380eOQiZ1cLou1vKqzeepYoZJKg/BEA1IU3XdojNDnMuzt7cOwgxBSXbT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GAaEeVRo; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737014216; h=Message-ID:Subject:Date:From:To;
	bh=ki0PBrtLkvSDIfEjuIbvOsNpP0XUwjZ9O5tjmqTVT3A=;
	b=GAaEeVRosPZUDXc2KPO+EeMo0urZfSkaxcnagbyHCvDcZ81Od3SjM6phF+QHcEd3huuYxFd6ytDpKyCFoTT4d/EYmDHRqLBCpEYJBqYkq+baY9thJQCaVVzav8957Ju8qlaCQHy0nwghj0+pnQSHo6l1ykYGD6/eKnkHseLCF1I=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WNl-Mc3_1737014213 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 16 Jan 2025 15:56:54 +0800
Message-ID: <1737014207.587077-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 4/4] virtio_net: Use persistent NAPI config
Date: Thu, 16 Jan 2025 15:56:47 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Joe Damato <jdamato@fastly.com>
Cc: gerhard@engleder-embedded.com,
 jasowang@redhat.com,
 leiyang@redhat.com,
 mkarsten@uwaterloo.ca,
 Joe Damato <jdamato@fastly.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
 linux-kernel@vger.kernel.org (open list),
 netdev@vger.kernel.org
References: <20250116055302.14308-1-jdamato@fastly.com>
 <20250116055302.14308-5-jdamato@fastly.com>
In-Reply-To: <20250116055302.14308-5-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 16 Jan 2025 05:52:59 +0000, Joe Damato <jdamato@fastly.com> wrote:
> Use persistent NAPI config so that NAPI IDs are not renumbered as queue
> counts change.
>
> $ sudo ethtool -l ens4  | tail -5 | egrep -i '(current|combined)'
> Current hardware settings:
> Combined:	4
>
> $ ./tools/net/ynl/pyynl/cli.py \
>     --spec Documentation/netlink/specs/netdev.yaml \
>     --dump queue-get --json='{"ifindex": 2}'
> [{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
>  {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'rx'},
>  {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'rx'},
>  {'id': 0, 'ifindex': 2, 'type': 'tx'},
>  {'id': 1, 'ifindex': 2, 'type': 'tx'},
>  {'id': 2, 'ifindex': 2, 'type': 'tx'},
>  {'id': 3, 'ifindex': 2, 'type': 'tx'}]
>
> Now adjust the queue count, note that the NAPI IDs are not renumbered:
>
> $ sudo ethtool -L ens4 combined 1
> $ ./tools/net/ynl/pyynl/cli.py \
>     --spec Documentation/netlink/specs/netdev.yaml \
>     --dump queue-get --json='{"ifindex": 2}'
> [{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
>  {'id': 0, 'ifindex': 2, 'type': 'tx'}]
>
> $ sudo ethtool -L ens4 combined 8
> $ ./tools/net/ynl/pyynl/cli.py \
>     --spec Documentation/netlink/specs/netdev.yaml \
>     --dump queue-get --json='{"ifindex": 2}'
> [{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
>  {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'rx'},
>  {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'rx'},
>  {'id': 4, 'ifindex': 2, 'napi-id': 8197, 'type': 'rx'},
>  {'id': 5, 'ifindex': 2, 'napi-id': 8198, 'type': 'rx'},
>  {'id': 6, 'ifindex': 2, 'napi-id': 8199, 'type': 'rx'},
>  {'id': 7, 'ifindex': 2, 'napi-id': 8200, 'type': 'rx'},
>  [...]
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
>  v2:
>    - New in this v2. Adds persistent NAPI config so that NAPI IDs are
>      not renumbered and napi_config settings are persisted.
>
>  drivers/net/virtio_net.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c6fda756dd07..52094596e94b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6420,8 +6420,9 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
>  	INIT_DELAYED_WORK(&vi->refill, refill_work);
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
>  		vi->rq[i].pages = NULL;
> -		netif_napi_add_weight(vi->dev, &vi->rq[i].napi, virtnet_poll,
> -				      napi_weight);
> +		netif_napi_add_config(vi->dev, &vi->rq[i].napi, virtnet_poll,
> +				      i);
> +		vi->rq[i].napi.weight = napi_weight;
>  		netif_napi_add_tx_weight(vi->dev, &vi->sq[i].napi,
>  					 virtnet_poll_tx,
>  					 napi_tx ? napi_weight : 0);
> --
> 2.25.1
>

