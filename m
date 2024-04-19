Return-Path: <netdev+bounces-89486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFFF8AA651
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 02:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D288B2137A
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 00:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68723387;
	Fri, 19 Apr 2024 00:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQhTdkPI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1784B64A
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 00:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713487470; cv=none; b=FF2LCqZ+HqY0831P6ZgMgVKN0rw2gAZqFF5IQSV3H+LMRyVLflrEmq3+NaEbF5SbIOW2yYvNfQsNK+molCy/4jkxjbVs0wfQOcI+Hx0HvKyReiJZV0SHI9anK00iSy3Wr+Qp6l9MgXcB2HFESuTf/LEpv73iza77vGgaOHk3ZU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713487470; c=relaxed/simple;
	bh=pBiz3LVrMCFjBKto+yUf+AajEVPLZZ2Msd8t8QjcNs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CfT2lv7cKuTGAv522HeLb/zKFlQK7XC6xY1NI2TvaBqG9BIjKOTRDSY8jZC13522Ts4toTEHYrOg3PfbFMHTTTZslDBjiZmOFzU6bLY2XRfVnpleUe0HuImW8noIzR2GjvHTqZzO1TA8QDmR3klSSiqBPiWA8NQ87E89moPopp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SQhTdkPI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713487466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/tzjilb7VmJ2J6//QDT/ySUeP2NChxSQTHnTBR1E3bs=;
	b=SQhTdkPIvxPaUvFdEMhisj8oiiOxkSHmwPdYIDav/nZ5BvDUgJvDwaefBEphquhSPYq77d
	TFgccA0p+ffLQbvBPmCtMXTd3jTGpvgN4wHFDE3uJYr+LB+lfZPJtg99pmuY/0UoBAwWlk
	KRGXFCepdqgfuTvPFJnQKUEPCdFOxGA=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-K0SsfX3wMIe5zlHsLnMnlw-1; Thu, 18 Apr 2024 20:44:25 -0400
X-MC-Unique: K0SsfX3wMIe5zlHsLnMnlw-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5d8bff2b792so1571587a12.1
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 17:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713487464; x=1714092264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/tzjilb7VmJ2J6//QDT/ySUeP2NChxSQTHnTBR1E3bs=;
        b=E+FeZeA1++rWmWQu/caTDS0E763OkWSaXBpxegOfnKQILtZrdOngsU9svoW7y7xXAG
         SaD47DaDGSt0PakPx7SVX2UsfcUiw5A+sbz4vws0OV1z6lbsYFgbXmlo349VTLANgyib
         Sz76cgSbem2paRG2VlTrh2yVYfG23onsfPh8ooTJhQOf6X3Zl/a0Hqk/g1icPqcvnPst
         JEp70/VHhvgjdFdQ4ezdNDXRIeSJBFZ9AB6oh8I+P6jwwpewm/fToLDzNQNIC7TAPwqK
         Do/TY7CzjYElhaCl3fI23jlQZhRsjs+QtKsbgZ5pZLNUWk8kKPRiuGM22sfTx+Wqa8Gk
         v+mQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2SLKn5PmNHLMah1P9pCg51P225LO2zqJraetVYRnkfOJNoQYezy4wPM9KlpFloWA26rstS9VAFFYC5cDGiTn0d7UDDwUh
X-Gm-Message-State: AOJu0YzAQa1r2BIxWDGvDkqv9ryPwdglhOh+xwVRzfAqtXhIWDo/xgjy
	Bl4ogs5aUubgj8kzKHlRJvfJi+oVd86naB1SXGkDwNghJmY727B/rQFK2CpJ5+/U2rl3xymdItK
	dhyilUd26BVGRvqgFeBrxLydGJwUuh2SMwCfkNj89iKC7EyjZ1XtI/avDYJHpZ4wITOGhMYWIBO
	CTVKKR7ULmZNwUKfZ6DNfHR98llJGD
X-Received: by 2002:a05:6a21:78a5:b0:1a7:a86a:113a with SMTP id bf37-20020a056a2178a500b001a7a86a113amr1060824pzc.6.1713487464335;
        Thu, 18 Apr 2024 17:44:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuTRpNGCcKmmfOeg3USih+ZL1ti6HCLk1+MRQFl8qLGI3Kl4ALCmPKX/FDo+WZT4sblejqbzvED/WE8/LIYXQ=
X-Received: by 2002:a05:6a21:78a5:b0:1a7:a86a:113a with SMTP id
 bf37-20020a056a2178a500b001a7a86a113amr1060814pzc.6.1713487464043; Thu, 18
 Apr 2024 17:44:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411025127.51945-1-xuanzhuo@linux.alibaba.com>
 <20240411025127.51945-6-xuanzhuo@linux.alibaba.com> <CACGkMEv2_wmXsh5uZhfZLQTtJX9633NdRL4KZrHumsTcr70-Sw@mail.gmail.com>
 <1713429342.96617-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1713429342.96617-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 19 Apr 2024 08:44:12 +0800
Message-ID: <CACGkMEtZQ6FRqqzjo3Yc_uxw2uopf4+30G-33y3oi-ruHtUTUg@mail.gmail.com>
Subject: Re: [PATCH vhost 5/6] virtio_net: enable premapped by default
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 4:37=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Thu, 18 Apr 2024 14:26:33 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Thu, Apr 11, 2024 at 10:51=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alib=
aba.com> wrote:
> > >
> > > Currently, big, merge, and small modes all support the premapped mode=
.
> > > We can now enable premapped mode by default. Furthermore,
> > > virtqueue_set_dma_premapped() must succeed when called immediately af=
ter
> > > find_vqs(). Consequently, we can assume that premapped mode is always
> > > enabled.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio_net.c | 12 +++++-------
> > >  1 file changed, 5 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 7ea7e9bcd5d7..f0faf7c0fe59 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -860,15 +860,13 @@ static void *virtnet_rq_alloc(struct receive_qu=
eue *rq, u32 size, gfp_t gfp)
> > >
> > >  static void virtnet_rq_set_premapped(struct virtnet_info *vi)
> > >  {
> > > -       int i;
> > > -
> > > -       /* disable for big mode */
> > > -       if (!vi->mergeable_rx_bufs && vi->big_packets)
> > > -               return;
> > > +       int i, err;
> > >
> > >         for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > > -               if (virtqueue_set_dma_premapped(vi->rq[i].vq))
> > > -                       continue;
> > > +               err =3D virtqueue_set_dma_premapped(vi->rq[i].vq);
> > > +
> > > +               /* never happen */
> > > +               BUG_ON(err);
> >
> > Nit:
> >
> > Maybe just a BUG_ON(virtqueue_set_dma_premapped()).
>
> OK
>
>
> >
> > Btw, if there's no way to disable pre mapping, maybe it's better to
> > rename virtqueue_set_dma_premapped() to
> > virtqueue_enable_dma_premapped(ing).
>
> This patch will add a way to disable pre mapping.
>
>         https://lore.kernel.org/all/20240327111430.108787-11-xuanzhuo@lin=
ux.alibaba.com/
>
> Thanks.

Ok, fine.

Thanks

>
>
> >
> > Thanks
> >
> > >
> > >                 vi->rq[i].do_dma =3D true;
> > >         }
> > > --
> > > 2.32.0.3.g01195cf9f
> > >
> >
>


