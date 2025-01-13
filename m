Return-Path: <netdev+bounces-157829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4C5A0BEE1
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 18:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C84AC1887D92
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 17:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D051C245C;
	Mon, 13 Jan 2025 17:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="uRl83OLW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9DC1BBBE3
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736789428; cv=none; b=exqq9GwNRTNAOxt9jptpYkb4q6kfQoHuYwuQ0ErLQtAheH5n9de8FVsFhcK1xUGeNnqF0HKC44081SP3fN43ySyUzoRie0bBpRkM+f5PrOiHILsubsjZG/w5TEzyxUi/SsfQTcKZjOqbO2IPvrFO878ZjfrQPs0YJlLf420F4Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736789428; c=relaxed/simple;
	bh=Ld8hD8g7CJ6n72FsIdee2/vGEKRDh+C6VV0pHaA/Gvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSVihWLp6NW5G/kZFJL61KO2vYhnOo1sWBZMsvLvkM94i87+sLMM0JMCX6VbYU9FideL9oBIUJ+uTIgrSsVE5g2QPVOPidkEEJ/+OT6J/8YLqUCfoW8puKCtyzuzggXHX4ts8o8tmKyggfSMhwzvbZLs/sm+/GYhn8ShD4c6nQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=uRl83OLW; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2f441904a42so8026282a91.1
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 09:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736789426; x=1737394226; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2L7jjhLQe7N38fsyHHQWUHvjNNVhiPmAQDNozmsH4n4=;
        b=uRl83OLWnrIA/9C0iOa7799PROn4BaKFicCX7DBub6nVFFBoZAQWGmpDb4IQ9ILHBd
         RydvFedMX08mKCwHPR1GCUkbghLs1tgSjlkv0jZQ8XCLx8qIyfOB2c0/6b9RDGWZEjjf
         2q3ObxuaV9VcWycLIjGaEdid8m9bmOlqO92RE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736789426; x=1737394226;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2L7jjhLQe7N38fsyHHQWUHvjNNVhiPmAQDNozmsH4n4=;
        b=NM4AdC+lSoQeVRQ/SzBZd841HpxCibSW5xaL0184fFRIhc+6QjgiQ4urMW2ndtX/qu
         XRGerWf5fMeg1pU0bZMUG7bT8SxqOlloSAgbsQjawMRQWBYApd+x7VI8pCfA/sVYwIhr
         tMqvJtsq1K3fNtIm8AMq/VGgGkJ7fGcxJnSKuE+ZPtn6n2ya3yoZqKGvHMyU42LBst1G
         OEPbzkrx2cuCokdLpqfGb6dlFVwdqdqjmQUDfW5FjkRAvcVUtYylYwF+YdQCo5Q7lQ5i
         bNrC7iF6zbgTeXfrRNsPj7+t6tFBiDDPsXQOYyS5uHXPmyZpOIujxel8BRgPoqjLnw8F
         TNLQ==
X-Gm-Message-State: AOJu0YyDcZkQVyL3k4BF2z6VwonoAPqCBXekoIsuguzRL0VgvHWWozTG
	wESDZtawkzMVU0OPR+4nbcJxKuRBwUiMAb6fyLa0yXpolsmx2AEd6N9hK4tFlws=
X-Gm-Gg: ASbGncs9L4jQwFD+arSYqxY0RMbdh8SXVkx/hSdmo7QSSoEVfiyutsSAzv38r/Jh+WZ
	m4EykXAtaLeEZS3e0vpF5t06zBPv8AP0wB8Z9hT/z3uPFQEfT4w4sTDYdYKdA7DScYiBnHlQKfP
	+2tjexpg2WyH7/OYRCuQbMWrlBS7A81SKbbQb8V6MoWskaa6B7Ss0Qq829YyutAD1OVPn/oHhRJ
	hprNhBDn58oQekn/akgAGmYUPxLN1EOmvLKyegKf+x8/wbHAjXWZp20wwQxbmTEJnlEE+NB/9Bl
	CjCi4bRKA1PU8Lgv3AchMjw=
X-Google-Smtp-Source: AGHT+IEghGvW/5nuiHAodJ8dty4udkpMIP741x9g938C/rpWzwpfsOW+LZDZsEBtPbBB14VxjhFnPg==
X-Received: by 2002:a17:90b:274e:b0:2f4:4003:f3ea with SMTP id 98e67ed59e1d1-2f5490f19c7mr33426283a91.33.1736789424156;
        Mon, 13 Jan 2025 09:30:24 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f559454f73sm8179724a91.38.2025.01.13.09.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 09:30:23 -0800 (PST)
Date: Mon, 13 Jan 2025 09:30:20 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 3/3] virtio_net: Map NAPIs to queues
Message-ID: <Z4VNrAI794LixEXt@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, "Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
References: <20250110202605.429475-1-jdamato@fastly.com>
 <20250110202605.429475-4-jdamato@fastly.com>
 <CACGkMEtjERF72zkLzDn2OKz3OGkJOQ+FCJS3MRscJqakEz9FYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtjERF72zkLzDn2OKz3OGkJOQ+FCJS3MRscJqakEz9FYA@mail.gmail.com>

On Mon, Jan 13, 2025 at 12:05:51PM +0800, Jason Wang wrote:
> On Sat, Jan 11, 2025 at 4:26 AM Joe Damato <jdamato@fastly.com> wrote:
> >
> > Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
> > can be accessed by user apps.
> >
> > $ ethtool -i ens4 | grep driver
> > driver: virtio_net
> >
> > $ sudo ethtool -L ens4 combined 4
> >
> > $ ./tools/net/ynl/pyynl/cli.py \
> >        --spec Documentation/netlink/specs/netdev.yaml \
> >        --dump queue-get --json='{"ifindex": 2}'
> > [{'id': 0, 'ifindex': 2, 'napi-id': 8289, 'type': 'rx'},
> >  {'id': 1, 'ifindex': 2, 'napi-id': 8290, 'type': 'rx'},
> >  {'id': 2, 'ifindex': 2, 'napi-id': 8291, 'type': 'rx'},
> >  {'id': 3, 'ifindex': 2, 'napi-id': 8292, 'type': 'rx'},
> >  {'id': 0, 'ifindex': 2, 'type': 'tx'},
> >  {'id': 1, 'ifindex': 2, 'type': 'tx'},
> >  {'id': 2, 'ifindex': 2, 'type': 'tx'},
> >  {'id': 3, 'ifindex': 2, 'type': 'tx'}]
> >
> > Note that virtio_net has TX-only NAPIs which do not have NAPI IDs, so
> > the lack of 'napi-id' in the above output is expected.
> >
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> >  drivers/net/virtio_net.c | 29 ++++++++++++++++++++++++++---
> >  1 file changed, 26 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 4e88d352d3eb..8f0f26cc5a94 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2804,14 +2804,28 @@ static void virtnet_napi_do_enable(struct virtqueue *vq,
> >  }
> >
> >  static void virtnet_napi_enable_lock(struct virtqueue *vq,
> > -                                    struct napi_struct *napi)
> > +                                    struct napi_struct *napi,
> > +                                    bool need_rtnl)
> >  {
> > +       struct virtnet_info *vi = vq->vdev->priv;
> > +       int q = vq2rxq(vq);
> > +
> >         virtnet_napi_do_enable(vq, napi);
> > +
> > +       if (q < vi->curr_queue_pairs) {
> > +               if (need_rtnl)
> > +                       rtnl_lock();
> 
> Can we tweak the caller to call rtnl_lock() instead to avoid this trick?

The major problem is that if the caller calls rtnl_lock() before
calling virtnet_napi_enable_lock, then virtnet_napi_do_enable (and
thus napi_enable) happen under the lock.

Jakub mentioned in a recent change [1] that napi_enable may soon
need to sleep.

Given the above constraints, the only way to avoid the "need_rtnl"
would be to refactor the code much more, placing calls (or wrappers)
to netif_queue_set_napi in many locations.

IMHO: This implementation seemed cleaner than putting calls to
netif_queue_set_napi throughout the driver.

Please let me know how you'd like to proceed on this.

[1]: https://lore.kernel.org/netdev/20250111024742.3680902-1-kuba@kernel.org/

> > +
> > +               netif_queue_set_napi(vi->dev, q, NETDEV_QUEUE_TYPE_RX, napi);
> > +
> > +               if (need_rtnl)
> > +                       rtnl_unlock();
> > +       }
> >  }
> >
> >  static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
> >  {
> > -       virtnet_napi_enable_lock(vq, napi);
> > +       virtnet_napi_enable_lock(vq, napi, false);
> >  }
> >
> >  static void virtnet_napi_tx_enable(struct virtnet_info *vi,
> > @@ -2848,9 +2862,13 @@ static void refill_work(struct work_struct *work)
> >         for (i = 0; i < vi->curr_queue_pairs; i++) {
> >                 struct receive_queue *rq = &vi->rq[i];
> >
> > +               rtnl_lock();
> > +               netif_queue_set_napi(vi->dev, i, NETDEV_QUEUE_TYPE_RX, NULL);
> > +               rtnl_unlock();
> >                 napi_disable(&rq->napi);
> 
> I wonder if it's better to have a helper to do set napi to NULL as
> well as napi_disable().

There are a couple places where this code is repeated, so I could do
that, but I'd probably employ the same "trick" as above with a flag
for "need_rtnl" in the helper.

I can send a v2 which adds a virtnet_napi_disable_lock and call it
from the 4 sites I see that can use it (virtnet_xdp_set,
virtnet_rx_pause, virtnet_disable_queue_pair, refill_work).

But first.... we need to agree on the flag being passed in to hold
rtnl :)

Please let me know.

Thanks for the review.

