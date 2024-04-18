Return-Path: <netdev+bounces-89062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEE78A9537
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 10:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43C26B212E2
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 08:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CFF15534D;
	Thu, 18 Apr 2024 08:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uI0Apoz8"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C301586DB
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 08:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713429740; cv=none; b=o43iqFCOSVyrShTpiD7I7YTrC+CEZ937Qvgs3mai9Z4DOPeBj3qqPHTeN9tRrO3MQtf9vLk3+3hOTYepljOXuTo9Wf0olXCTbrbrak4QG0oVPqYPg1h/YlVC1oFOuhb/aQeuJhlyHvf3O6/uNemnAMns1EuqBlqQTCj/M6xJGco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713429740; c=relaxed/simple;
	bh=JaZGRhO3jSTyI0t7zJoh9Lky7UZ/epu6Dq/UoJrYki4=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=RtQb8un3LDWl7p9n9gWG7GzdZO0VYzdnI7G5CE71oaH0Hucens9pmkCtGQFuFFspnhUJ0x0fk8ZqQSYUUNE0kghUDjfkm/oi13ZbxFRh67Jv7wV618RZYme6lhBhTEz0z5nrzocB0KpPNZRJCiP3kzq28u9LNXo2mJ/ybPnpWd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uI0Apoz8; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713429729; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=keuJ0LEJ+gUDtVA+E+zuXEvw7G9Es5NFBjrda7YVOto=;
	b=uI0Apoz8B9UO0u2+I7wEoxGb0QgtcLORmPzCYXClarHfUdCd1PtZmOf3z3rgDGoowmi6mwAIOirvw+R/g+Oj+6kAu2KsysprpHQBK+/WRSxwEGggTdgJtiqCG4XUZN2ezIf6B7pmWnwApfgRu/TulCckgH3hy6y+4cDWO84BN2s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W4o21xo_1713429411;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W4o21xo_1713429411)
          by smtp.aliyun-inc.com;
          Thu, 18 Apr 2024 16:36:52 +0800
Message-ID: <1713429342.96617-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 5/6] virtio_net: enable premapped by default
Date: Thu, 18 Apr 2024 16:35:42 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20240411025127.51945-1-xuanzhuo@linux.alibaba.com>
 <20240411025127.51945-6-xuanzhuo@linux.alibaba.com>
 <CACGkMEv2_wmXsh5uZhfZLQTtJX9633NdRL4KZrHumsTcr70-Sw@mail.gmail.com>
In-Reply-To: <CACGkMEv2_wmXsh5uZhfZLQTtJX9633NdRL4KZrHumsTcr70-Sw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 18 Apr 2024 14:26:33 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Thu, Apr 11, 2024 at 10:51=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> >
> > Currently, big, merge, and small modes all support the premapped mode.
> > We can now enable premapped mode by default. Furthermore,
> > virtqueue_set_dma_premapped() must succeed when called immediately after
> > find_vqs(). Consequently, we can assume that premapped mode is always
> > enabled.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 7ea7e9bcd5d7..f0faf7c0fe59 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -860,15 +860,13 @@ static void *virtnet_rq_alloc(struct receive_queu=
e *rq, u32 size, gfp_t gfp)
> >
> >  static void virtnet_rq_set_premapped(struct virtnet_info *vi)
> >  {
> > -       int i;
> > -
> > -       /* disable for big mode */
> > -       if (!vi->mergeable_rx_bufs && vi->big_packets)
> > -               return;
> > +       int i, err;
> >
> >         for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > -               if (virtqueue_set_dma_premapped(vi->rq[i].vq))
> > -                       continue;
> > +               err =3D virtqueue_set_dma_premapped(vi->rq[i].vq);
> > +
> > +               /* never happen */
> > +               BUG_ON(err);
>
> Nit:
>
> Maybe just a BUG_ON(virtqueue_set_dma_premapped()).

OK


>
> Btw, if there's no way to disable pre mapping, maybe it's better to
> rename virtqueue_set_dma_premapped() to
> virtqueue_enable_dma_premapped(ing).

This patch will add a way to disable pre mapping.

	https://lore.kernel.org/all/20240327111430.108787-11-xuanzhuo@linux.alibab=
a.com/

Thanks.


>
> Thanks
>
> >
> >                 vi->rq[i].do_dma =3D true;
> >         }
> > --
> > 2.32.0.3.g01195cf9f
> >
>

