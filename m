Return-Path: <netdev+bounces-157905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B59FAA0C45A
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 23:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEEA616524C
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 22:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823F81DACAA;
	Mon, 13 Jan 2025 22:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvZrLZ48"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5313C1C4A3B;
	Mon, 13 Jan 2025 22:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736805888; cv=none; b=Dlc6+IufTl3iG63pKbnz4zW+fvrS63IUe7YORNVckdaszhDDtlWMAerWXn0Wx9CEhzlTeiEE9wXxE0E9ehsFTlJD97OGlYtddL1xsFHvaVbZqaDYfSfejaU3prqKZvaIsKjISPimUGvJvyJxtz1IYLc5eZzHKhaSKEuJoiumEU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736805888; c=relaxed/simple;
	bh=jDD4sat488ta/SYXZLZJBq17r7HGDrDGvfXOvne4b48=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZS6D9f1e7t5evLf8jPdU9MPmdwIe8iY+Beu9lsqFwR2sRbHXnmOrQNPwuYoNn3F4Lp4y9+SGsNAcJ874woFlGb8N2j+XqRQDQeuQ2deHfFU8jD/fzBo2XxO0vSCJa691bX8HwGgESy+TMAYDRNdeRQGwtwplS21cH3XFe+p6WrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvZrLZ48; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72155C4CED6;
	Mon, 13 Jan 2025 22:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736805887;
	bh=jDD4sat488ta/SYXZLZJBq17r7HGDrDGvfXOvne4b48=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TvZrLZ48wCLoxh+bPQfN7pRtVmw0JvONJPVJQ9b8HBvoPN430eBDjvRLA4Kp8RUWF
	 EZ0jFkEO5hNb2bbxezaZbVTsvJ6PYd1bAipH34dQoeynIOrB2GnZcZV4PcSv1SknIO
	 DVhYjzeJp/HdZr1WsHEJ761y9M3EqplxihTPTGq5dc+ZzJAVCBJFRYqEEbRt2P4Mjb
	 2Wl8EKN+2CtwxEJK3dUX2WNmcWupRfESfFoc1D+FD/vZYtiEsipChB9bpsmbyLP10/
	 Q1PENbQx28s+DNhlU35pyarSWYWKMGQJS3gt/vr2fvvOTVvQh0T8ZZ1Xm2+fcNqDxt
	 xESKtU6+NQVig==
Date: Mon, 13 Jan 2025 14:04:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
 mkarsten@uwaterloo.ca, "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 3/3] virtio_net: Map NAPIs to queues
Message-ID: <20250113140446.12d7b7d3@kernel.org>
In-Reply-To: <Z4VNrAI794LixEXt@LQ3V64L9R2>
References: <20250110202605.429475-1-jdamato@fastly.com>
	<20250110202605.429475-4-jdamato@fastly.com>
	<CACGkMEtjERF72zkLzDn2OKz3OGkJOQ+FCJS3MRscJqakEz9FYA@mail.gmail.com>
	<Z4VNrAI794LixEXt@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jan 2025 09:30:20 -0800 Joe Damato wrote:
> > >  static void virtnet_napi_enable_lock(struct virtqueue *vq,
> > > -                                    struct napi_struct *napi)
> > > +                                    struct napi_struct *napi,
> > > +                                    bool need_rtnl)
> > >  {
> > > +       struct virtnet_info *vi = vq->vdev->priv;
> > > +       int q = vq2rxq(vq);
> > > +
> > >         virtnet_napi_do_enable(vq, napi);
> > > +
> > > +       if (q < vi->curr_queue_pairs) {
> > > +               if (need_rtnl)
> > > +                       rtnl_lock();  
> > 
> > Can we tweak the caller to call rtnl_lock() instead to avoid this trick?  
> 
> The major problem is that if the caller calls rtnl_lock() before
> calling virtnet_napi_enable_lock, then virtnet_napi_do_enable (and
> thus napi_enable) happen under the lock.
> 
> Jakub mentioned in a recent change [1] that napi_enable may soon
> need to sleep.
> 
> Given the above constraints, the only way to avoid the "need_rtnl"
> would be to refactor the code much more, placing calls (or wrappers)
> to netif_queue_set_napi in many locations.
> 
> IMHO: This implementation seemed cleaner than putting calls to
> netif_queue_set_napi throughout the driver.
> 
> Please let me know how you'd like to proceed on this.
> 
> [1]: https://lore.kernel.org/netdev/20250111024742.3680902-1-kuba@kernel.org/

I'm going to make netif_queue_set_napi() take netdev->lock, and remove
the rtnl_lock requirement ~this week. If we need conditional locking
perhaps we're better off waiting?

