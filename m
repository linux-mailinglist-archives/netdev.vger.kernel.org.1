Return-Path: <netdev+bounces-91201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8083A8B1A95
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 08:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A40301C20E65
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 06:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599513C47B;
	Thu, 25 Apr 2024 06:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGQfwFo9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B827A3A1AC
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 06:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714025095; cv=none; b=pnhA1mvVbrst4sT0Rql9wnwCkhT1NVKXcngRqGn7Bxa+UlHtCv2BQXWYChoBt3hBgkvz2CngJg2KhWXPfT7vBd5MGkCe2VEFNPEbgGhJBa5tuPzCTOrtSUGCBd1L8aMI+vgUTKM9UD4pjH+Aeiw1SmCIN4bcOCT71CtYw37g2hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714025095; c=relaxed/simple;
	bh=yoyDuhImaFYk6MfODe7FWOzq5lPz3/6sKseHfzmm3YU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IgIWTo8ftLTqiZNf89wfGIBQ7HELrY/K0XgaIVZYH1QfaS9yzkNEnaYdIDENgid+6BDii/radzMoyGKbP+9DsxTElo7aelPmqJ1E9Ro+SWfa7fartqlbDk/LkEmhBcklY4EKoXHKIN3eoZWaUhXk5AsgCs4enumD/51jSdu4Rtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EGQfwFo9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714025092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2VqVkXo1lE+9fpUNrU4aH8DrBoZjKZt/x6xACkTCsDc=;
	b=EGQfwFo9R1TG2f2KyZUxFH+2ZetKf7Z2hG8jYrsp3FWj2zZ98LeH9+nkI8xS2jfdAWv5is
	9FYZwI6oYODY4LgANQA9jCMGOMNm8pCqrDEBSwT314jatn6eRIfxaFMC5OxLdIbR+FwkHN
	xN9iDKju4kKqS3ZxL5w5dYHrntn4rg0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-C1cyiMHsNp-kQifXyFA3pg-1; Thu, 25 Apr 2024 02:04:51 -0400
X-MC-Unique: C1cyiMHsNp-kQifXyFA3pg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2a6f2c7c1b8so778502a91.1
        for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 23:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714025090; x=1714629890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2VqVkXo1lE+9fpUNrU4aH8DrBoZjKZt/x6xACkTCsDc=;
        b=B6wed/OsgIq8ZfMk7lXBNdChcej7YxOdaEpp/3LVQzeHC6HoHnsMWMG1Uf+tV8k+tx
         3sxNGMHUoum2AP3zBiaa1PEcve6KXOteYznMZ2Wlg94EOkrOXrPW9/nFjdxQMEhLJ2bl
         lGlh7zgpj2U1b+f7bJBPIQwp5XHLic+FAtAiXRywZP8XIiYwWEzaB/bjrglJhdHRDnWd
         4pNKexZ7dc38OW9zJsrjCybtY5nKC4S8+EKQwx+LYM3I1rkkaHuT/J2r1DvB4MB+aYwh
         Jz6yJKwhQonP/EGJi5Xj2aq7Er/DzMbEN9PGtgPi9zaZNXXXTH6wfzeoyABh1Ce1LxoV
         bs9g==
X-Forwarded-Encrypted: i=1; AJvYcCVWgYKc1TxYlpyYg/KtFnvXuY7nBMT2oIyiP4kHztHE+8IMlL8kVVv3kOPLG49c5Z8s2rUa8v2xygm8Got+1bnfWj18CEHN
X-Gm-Message-State: AOJu0YxRcv2dG6rOi4zJ99h/S40awS4nI/7bgunL6JDZHKvOXATU/xfI
	0eseIiJ24tccNB8Ts/QVuMmt27E69rq+WKrY5mWbeeP5NAvPg61YLcAS11CWIn2AeFznb5GY+0V
	7RDyWIqbTCARcxeA5CCDeor9ebDznswq2ZZ1tBw1L1eAIJI6Gutq9rQCBYykeD5AV5VemXOsvzE
	GT0kfZ1RmcsmUulJcZlrtQUdGIIA3j
X-Received: by 2002:a17:90a:744f:b0:2ac:257d:3e7c with SMTP id o15-20020a17090a744f00b002ac257d3e7cmr4850605pjk.9.1714025090182;
        Wed, 24 Apr 2024 23:04:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGk1Zk4n8BNQN3/HiN3DwbEZl719SLEOZEGJXMcEDPIdNVxRJ8DswGiPqBmV3wMyKxXlJmav9ONmNVL2nM68TU=
X-Received: by 2002:a17:90a:744f:b0:2ac:257d:3e7c with SMTP id
 o15-20020a17090a744f00b002ac257d3e7cmr4850590pjk.9.1714025089840; Wed, 24 Apr
 2024 23:04:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424081636.124029-1-xuanzhuo@linux.alibaba.com>
 <20240424081636.124029-3-xuanzhuo@linux.alibaba.com> <CACGkMEtf9twxTSGpGpmcR4LYS_k1g=NRO78NhkG4uLJ3d+TqAA@mail.gmail.com>
 <1714012507.44893-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1714012507.44893-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 25 Apr 2024 14:04:38 +0800
Message-ID: <CACGkMEu3M8_izh837Z5Eg7uJTVUGNAKcdGRcF=7FAu_REZ1tyA@mail.gmail.com>
Subject: Re: [PATCH vhost v3 2/4] virtio_net: big mode skip the unmap check
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 10:37=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> On Thu, 25 Apr 2024 10:11:55 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Wed, Apr 24, 2024 at 4:17=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > The virtio-net big mode did not enable premapped mode,
> > > so we did not need to check the unmap. And the subsequent
> > > commit will remove the failover code for failing enable
> > > premapped for merge and small mode. So we need to remove
> > > the checking do_dma code in the big mode path.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio_net.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index c22d1118a133..16d84c95779c 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -820,7 +820,7 @@ static void virtnet_rq_unmap_free_buf(struct virt=
queue *vq, void *buf)
> > >
> > >         rq =3D &vi->rq[i];
> > >
> > > -       if (rq->do_dma)
> > > +       if (!vi->big_packets || vi->mergeable_rx_bufs)
> >
> > This seems to be equivalent to
> >
> > if (!vi->big_packets)
>
>
> If VIRTIO_NET_F_MRG_RXBUF and guest_gso are coexisting,
> big_packets and mergeable_rx_bufs are all true.
> !vi->big_packets only means the small.
>
> Did I miss something?

Nope, you are right.

The big_packets are kind of misleading as it doesn't mean big mode.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
> Thanks.
>
>
> >
> >
> > >                 virtnet_rq_unmap(rq, buf, 0);
> > >
> > >         virtnet_rq_free_buf(vi, rq, buf);
> > > @@ -2128,7 +2128,7 @@ static int virtnet_receive(struct receive_queue=
 *rq, int budget,
> > >                 }
> > >         } else {
> > >                 while (packets < budget &&
> > > -                      (buf =3D virtnet_rq_get_buf(rq, &len, NULL)) !=
=3D NULL) {
> > > +                      (buf =3D virtqueue_get_buf(rq->vq, &len)) !=3D=
 NULL) {
> > >                         receive_buf(vi, rq, buf, len, NULL, xdp_xmit,=
 &stats);
> > >                         packets++;
> > >                 }
> >
> > Other part looks good.
> >
> > Thanks
> >
> > > --
> > > 2.32.0.3.g01195cf9f
> > >
> >
>


