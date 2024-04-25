Return-Path: <netdev+bounces-91157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFAF8B18FC
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 04:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 716301F22C48
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 02:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D581911711;
	Thu, 25 Apr 2024 02:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vaYXZiky"
X-Original-To: netdev@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714F5AD2D
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 02:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714012654; cv=none; b=fpupqivii1VJccykwnbERqDkQ8trTs+0VGHQOYY6EqSUz+GG2VNrmmxAiymPdqgWzWzIYHxa88hbCuJIdrfRaBYpSZzVNyG/DhlLDnq/dykCcnux9p1NpcZQv3vN2vGsQ7DwzgfdkfZZREzKupsrDEmOotIPtAT74spghUd355Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714012654; c=relaxed/simple;
	bh=MrxFf54Y1HaExv9K7Cv/Em3ZsBEZ6EWDpe21OcJ3+RY=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=EsOmPvzlAQf/aVItLTxtV50I+WfOMd1TkTgB0Mdm6fWmN/HpEBT0mO0oSahaAKWXHX9pTQ/ZMBWvg92fGREo6UFF9nB3lgHbt9jzWszOq47jHMDcX3hI9KRl0Fvkq/pXuKHGACFFoHoZgRWdpw8bWFP81Wjd6jT3DcJ8vCCjmsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vaYXZiky; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714012649; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=0f/HiyHELD1UBhPn6xVVXFBvFmkln0xTZmPMl+WoVzE=;
	b=vaYXZiky4ChhOcEt4Jv5T4CAbF6vxX5M9x7OShuM4uaYel31TP5OBKcdm3WK1keMptLUurS6KSaQebAMNJu9V5lF/uzgRYn0D6IBy+ORj8cYgbEm1/OM21Dan0omC6M2SlvG214UBhE1wPsZgX17Y4cpmTo3crXRuLqGetELhZE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W5DmdZP_1714012647;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W5DmdZP_1714012647)
          by smtp.aliyun-inc.com;
          Thu, 25 Apr 2024 10:37:28 +0800
Message-ID: <1714012507.44893-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v3 2/4] virtio_net: big mode skip the unmap check
Date: Thu, 25 Apr 2024 10:35:07 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20240424081636.124029-1-xuanzhuo@linux.alibaba.com>
 <20240424081636.124029-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEtf9twxTSGpGpmcR4LYS_k1g=NRO78NhkG4uLJ3d+TqAA@mail.gmail.com>
In-Reply-To: <CACGkMEtf9twxTSGpGpmcR4LYS_k1g=NRO78NhkG4uLJ3d+TqAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 25 Apr 2024 10:11:55 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Wed, Apr 24, 2024 at 4:17=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > The virtio-net big mode did not enable premapped mode,
> > so we did not need to check the unmap. And the subsequent
> > commit will remove the failover code for failing enable
> > premapped for merge and small mode. So we need to remove
> > the checking do_dma code in the big mode path.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index c22d1118a133..16d84c95779c 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -820,7 +820,7 @@ static void virtnet_rq_unmap_free_buf(struct virtqu=
eue *vq, void *buf)
> >
> >         rq =3D &vi->rq[i];
> >
> > -       if (rq->do_dma)
> > +       if (!vi->big_packets || vi->mergeable_rx_bufs)
>
> This seems to be equivalent to
>
> if (!vi->big_packets)


If VIRTIO_NET_F_MRG_RXBUF and guest_gso are coexisting,
big_packets and mergeable_rx_bufs are all true.
!vi->big_packets only means the small.

Did I miss something?

Thanks.


>
>
> >                 virtnet_rq_unmap(rq, buf, 0);
> >
> >         virtnet_rq_free_buf(vi, rq, buf);
> > @@ -2128,7 +2128,7 @@ static int virtnet_receive(struct receive_queue *=
rq, int budget,
> >                 }
> >         } else {
> >                 while (packets < budget &&
> > -                      (buf =3D virtnet_rq_get_buf(rq, &len, NULL)) !=
=3D NULL) {
> > +                      (buf =3D virtqueue_get_buf(rq->vq, &len)) !=3D N=
ULL) {
> >                         receive_buf(vi, rq, buf, len, NULL, xdp_xmit, &=
stats);
> >                         packets++;
> >                 }
>
> Other part looks good.
>
> Thanks
>
> > --
> > 2.32.0.3.g01195cf9f
> >
>

