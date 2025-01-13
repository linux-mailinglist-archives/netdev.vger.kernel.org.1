Return-Path: <netdev+bounces-157899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5588EA0C417
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 22:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 461BD1885BB2
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 21:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CB51F9A91;
	Mon, 13 Jan 2025 21:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="JRtB1xmc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF96E1F9A94
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 21:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736804899; cv=none; b=i6JCfov3a7qnB9vEkCa5XWresaF0+yIgbiWH+RCDPuZ8qkYvlXQCYosW+Ap9vRhxJ9GAFCZdM0WHCcvbYRqnR1v7RAVZisqjABvc9pYXn7hwotBZ6W9DUki2HbhmqtKklSUSRib/RmfzSNQV5Hm4ryrnpt5VWFYwScrBjMTE0rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736804899; c=relaxed/simple;
	bh=3fAjbf1UJEhhZFXlEL1OJNW4f84TVAJgX/Lef4iCHLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9zGiRujUdeNhwYNVqODg+X6JsfXZl4n4yC75kgtJ2p5tu2C/E2wqccHSrmTU386lIrfBXU1hDO3OircGfg9XM+qFabmQQraKQOlPrk8TdW7qwJgkOZlld0U9PmBWQauQymM5lx8i1uJx9VO0NnnwqRSfW56K1ogU8vEfS+4RAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=JRtB1xmc; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21649a7bcdcso81579355ad.1
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 13:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736804897; x=1737409697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zYRC6m7ilLaR26HQEBEuPve9BOAc2R2xQdAwiheei7M=;
        b=JRtB1xmcw6G5+Xa9UsgICGTN/CHfgEt/u3nDAfDm16AN66UInFmy07eIxcdOCRiol3
         UjMPif9fmR6cLQJbqm0pv+re1S5wjWulgvEyDVy/MyiVzgsEibfAnEz094Q23bfTsFJr
         0BPIOf6FMr2oywGz3eHCF8KJVkQH94FkN9enw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736804897; x=1737409697;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zYRC6m7ilLaR26HQEBEuPve9BOAc2R2xQdAwiheei7M=;
        b=BxnFEtCwVvnTBw362lC1RsPzGKI4PcMxttIf4GORaUtT6YPgzDUhlE9oWu5rT346hA
         7ua4dgj2EHfi6TCpuG5veR8ldx7QGA90482rZP+Rmv48bwIgUs2Odb6kzZpZlqeftS9W
         UPihGHs2z2qh9hGhklAHzkPcEFS1wrNV+W2HEbu5VVpcqC05+X2VbOR7v76SGogfPs2I
         aoOotb2avJ6HF3Vws2j2f35ISuwElrJT90xkOKeQ4KGBcK3J7W8g5yeLjzY1aPK/8JUV
         n4g1Ndj2JpWMXJpmSjroTpiq7UXqqurXBBeCMrgrBN4xYgNC7ygokSd3XGsZQEAvkJ+4
         oLyw==
X-Forwarded-Encrypted: i=1; AJvYcCXScbKrKBHJeGz2Y1xV4jxeqbHrqBTJaKVBjJRCp7h9a2LJ4qKWKEBP5n+p4l8VNN6qqjB9Q/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXH7fgsMExxRMIksTn9o8ml4Q2z6mSOIV0jB1OZgRpSvkgkOPa
	CmRClHq0ekEuWeorlUdvyV6BOJnXolrLGcazD/Wtv+fK7WhcxHXahq4Tdk1w5H4=
X-Gm-Gg: ASbGncvwrAEXz5eSLbFY1OGHdj0/NM8OhSPMvpGZHBMveUqyVaCY1a1XSC5YK8XDayK
	IudfXoR+5q5xcsZUfe/c1vQeEawIh7i+8OUJRYrFYHJdyTVzIT8s4DLFLnn0SecBERd7D9S3LkC
	wakrIDdduZuGkvAx6srMbH9EQZnrndqprhcATQaS3tycWA3FRsEUkTefWAkyazFcqB+oed+491i
	no7geDlEzUvXNPXm4/wbG6nxtw4RBNCl4kAvp43URcv9UcbkBdx5mke7RxCDdyqyF3b/fy0yANw
	KfL5OB9RFrGU4EZ1efSNqoE=
X-Google-Smtp-Source: AGHT+IHAaAVbOShJsZrzsPU9PljV2JFQYNtowSpkNMZUCQHNFxg4Ngx7IgXYiiv9nLNq51vMQiuK/g==
X-Received: by 2002:a05:6a21:3997:b0:1e0:ca1c:8581 with SMTP id adf61e73a8af0-1e88d108843mr35013247637.21.1736804897156;
        Mon, 13 Jan 2025 13:48:17 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a317a07d050sm7343257a12.15.2025.01.13.13.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 13:48:16 -0800 (PST)
Date: Mon, 13 Jan 2025 13:48:14 -0800
From: Joe Damato <jdamato@fastly.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: magnus.karlsson@intel.com, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] tsnep: Link queues to NAPIs
Message-ID: <Z4WKHnDG9VSMe5OD@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	magnus.karlsson@intel.com, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
References: <20250110223939.37490-1-gerhard@engleder-embedded.com>
 <Z4VwrhhXU4uKqYGR@LQ3V64L9R2>
 <91fc249e-c11a-47a1-aafe-fef833c3bafa@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91fc249e-c11a-47a1-aafe-fef833c3bafa@engleder-embedded.com>

On Mon, Jan 13, 2025 at 09:32:23PM +0100, Gerhard Engleder wrote:
> On 13.01.25 20:59, Joe Damato wrote:
> > On Fri, Jan 10, 2025 at 11:39:39PM +0100, Gerhard Engleder wrote:
> > > Use netif_queue_set_napi() to link queues to NAPI instances so that they
> > > can be queried with netlink.
> > > 
> > > $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
> > >                           --dump queue-get --json='{"ifindex": 11}'
> > > [{'id': 0, 'ifindex': 11, 'napi-id': 9, 'type': 'rx'},
> > >   {'id': 1, 'ifindex': 11, 'napi-id': 10, 'type': 'rx'},
> > >   {'id': 0, 'ifindex': 11, 'napi-id': 9, 'type': 'tx'},
> > >   {'id': 1, 'ifindex': 11, 'napi-id': 10, 'type': 'tx'}]
> > > 
> > > Additionally use netif_napi_set_irq() to also provide NAPI interrupt
> > > number to userspace.
> > > 
> > > $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
> > >                           --do napi-get --json='{"id": 9}'
> > > {'defer-hard-irqs': 0,
> > >   'gro-flush-timeout': 0,
> > >   'id': 9,
> > >   'ifindex': 11,
> > >   'irq': 42,
> > >   'irq-suspend-timeout': 0}
> > > 
> > > Providing information about queues to userspace makes sense as APIs like
> > > XSK provide queue specific access. Also XSK busy polling relies on
> > > queues linked to NAPIs.
> > > 
> > > Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
> > > ---
> > >   drivers/net/ethernet/engleder/tsnep_main.c | 28 ++++++++++++++++++----
> > >   1 file changed, 23 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
> > > index 45b9f5780902..71e950e023dc 100644
> > > --- a/drivers/net/ethernet/engleder/tsnep_main.c
> > > +++ b/drivers/net/ethernet/engleder/tsnep_main.c
> > > @@ -1984,23 +1984,41 @@ static int tsnep_queue_open(struct tsnep_adapter *adapter,
> > >   static void tsnep_queue_enable(struct tsnep_queue *queue)
> > >   {
> > > +	struct tsnep_adapter *adapter = queue->adapter;
> > > +
> > > +	netif_napi_set_irq(&queue->napi, queue->irq);
> > >   	napi_enable(&queue->napi);
> > > -	tsnep_enable_irq(queue->adapter, queue->irq_mask);
> > > +	tsnep_enable_irq(adapter, queue->irq_mask);
> > > -	if (queue->tx)
> > > +	if (queue->tx) {
> > > +		netif_queue_set_napi(adapter->netdev, queue->tx->queue_index,
> > > +				     NETDEV_QUEUE_TYPE_TX, &queue->napi);
> > >   		tsnep_tx_enable(queue->tx);
> > > +	}
> > > -	if (queue->rx)
> > > +	if (queue->rx) {
> > > +		netif_queue_set_napi(adapter->netdev, queue->rx->queue_index,
> > > +				     NETDEV_QUEUE_TYPE_RX, &queue->napi);
> > >   		tsnep_rx_enable(queue->rx);
> > > +	}
> > >   }
> > >   static void tsnep_queue_disable(struct tsnep_queue *queue)
> > A>  {
> > > -	if (queue->tx)
> > > +	struct tsnep_adapter *adapter = queue->adapter;
> > > +
> > > +	if (queue->rx)
> > > +		netif_queue_set_napi(adapter->netdev, queue->rx->queue_index,
> > > +				     NETDEV_QUEUE_TYPE_RX, NULL);
> > > +
> > > +	if (queue->tx) {
> > >   		tsnep_tx_disable(queue->tx, &queue->napi);
> > > +		netif_queue_set_napi(adapter->netdev, queue->tx->queue_index,
> > > +				     NETDEV_QUEUE_TYPE_TX, NULL);
> > > +	}
> > >   	napi_disable(&queue->napi);
> > > -	tsnep_disable_irq(queue->adapter, queue->irq_mask);
> > > +	tsnep_disable_irq(adapter, queue->irq_mask);
> > >   	/* disable RX after NAPI polling has been disabled, because RX can be
> > >   	 * enabled during NAPI polling
> > 
> > The changes generally look OK to me (it seems RTNL is held on all
> > paths where this code can be called from as far as I can tell), but
> > there was one thing that stood out to me.
> > 
> > AFAIU, drivers avoid marking XDP queues as NETDEV_QUEUE_TYPE_RX
> > or NETDEV_QUEUE_TYPE_TX. I could be wrong, but that was my
> > understanding and I submit patches to several drivers with this
> > assumption.
> > 
> > For example, in commit b65969856d4f ("igc: Link queues to NAPI
> > instances"), I unlinked/linked the NAPIs and queue IDs when XDP was
> > enabled/disabled. Likewise, in commit 64b62146ba9e ("net/mlx4: link
> > NAPI instances to queues and IRQs"), I avoided the XDP queues.
> > 
> > If drivers are to avoid marking XDP queues as NETDEV_QUEUE_TYPE_RX
> > or NETDEV_QUEUE_TYPE_TX, perhaps tsnep needs to be modified
> > similarly?
> 
> With 5ef44b3cb4 ("xsk: Bring back busy polling support") the linking of
> the NAPIs is required for XDP/XSK. So it is strange to me if for XDP/XSK
> the NAPIs should be unlinked. But I'm not an expert, so maybe there is
> a reason why.
> 
> I added Magnus, maybe he knows if XSK queues shall still be linked to
> NAPIs.

OK, so I think I was probably just wrong?

I looked at bnxt and it seems to mark XDP queues, which means
probably my patches for igc, ena, and mlx4 need to be fixed and the
proposed patch I have for virtio_net needs to be adjusted.

I can't remember now why I thought XDP queues should be avoided. I
feel like I read that or got that as feedback at some point, but I
can't remember now. Maybe it was just one driver or something I was
working on and I accidentally thought it should be avoided
everywhere? Not sure.

Hopefully some one can give a definitive answer on this one before I
go through and try to fix all the drivers I modified :|

