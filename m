Return-Path: <netdev+bounces-128007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC8B97776C
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 05:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DA102858EA
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 03:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569B41C461C;
	Fri, 13 Sep 2024 03:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="USMu/Q0V"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2BA13D882
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 03:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726198609; cv=none; b=ZAOVVJeQWDnjBS1R286w8JRumtkHKHmnaIN/xmp8mBRqsjlP/Wljie9NeG2GwVprs5YYyjAR/QByJChrb1N4P0NbE/OFsE9YMQborf5Kbrs+ET6WJifDybMKXZTT8UhLSs0I8qJmILv9pJVYANOjW260xrVYnF6gJgADQwbCR1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726198609; c=relaxed/simple;
	bh=TLwWA35kUPnPcDc4B0Q6ubvsZVr7nfIY2AFWT8BmMPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iexN61SUUfqgE0cq79NVwMrN5yrD0p4PREVIVwPDeDgW1rKzhjBVMvlZQ8BpknNn08o2aiPBo7l6pcHFcypIU9v/sD+rliruIu9AK4OUP4WUuNFD5JDKFuTmdMRd8c7GlOAnItGTmOP755pEp2mZVizxXgoVz6fqmpeI5+Jg2yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=USMu/Q0V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726198606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TLwWA35kUPnPcDc4B0Q6ubvsZVr7nfIY2AFWT8BmMPQ=;
	b=USMu/Q0VQ5P2O7DEfr7eFakOzXbMNKESI2l+VZYk0mu63f46FHcYCk0zQDiCJXe8CSx0QR
	Q0ep3cqFcZTfbUL144WERY4AhvqOoIx3aJwJ+SAblBEcmEQCR7xnFXnCkeHw1mimmzn+U1
	JKaYOmvDSeBRSRmoUtEmPra2HLfrh5g=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-P1bJoJ6INXqe8_jRFtr-ig-1; Thu, 12 Sep 2024 23:36:45 -0400
X-MC-Unique: P1bJoJ6INXqe8_jRFtr-ig-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2058ba8562fso31061275ad.3
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 20:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726198604; x=1726803404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLwWA35kUPnPcDc4B0Q6ubvsZVr7nfIY2AFWT8BmMPQ=;
        b=Ky3eteQiFPcb16SOPpLXI+SIasWP4Wp1oI/1zcHOAplMZqoqU8/Pch3PE+pRz95KEy
         nwyhwEklNu58VuSq3E0OPVdqi5MGuojoM87zU2dNy/VPdvnHTlN+s7zfYmCmkq69/SD1
         tehahZ9P7XsAoCHKl5qjdtb8PP/XTIbcXPIwtYp0g6Weav8F/mLBcAOe9Xl+FOdBJ14E
         wUCPU0CSoWegm7fk5WqibTdG2kUh/d/hlUDpR6uj+6eWpZo+nPDqEcUe2i3PnXp3KQE4
         bWth6zJsaOvjhtSjhrsqmGO3baAyT1ITmcUqnq4n+oSQSwSBdLa/KY3qC5AH0SWlwjTS
         wrLQ==
X-Gm-Message-State: AOJu0YyVibPHtaNL/iDPZGW5SzC5va3H79qxHh19BbOVw/jY/wJJOzdk
	+hg2xRNgBcm2THdk6oCwAvHcaHlP95zqrrNHIeE9ApHbSHK/eGX0N69Hxm2zulB+pR7GiA5/JUm
	/kooXLt2DGw9k2yVLtzomK62VfrR85QOqTTcosg2Z2cl28hopZ69YPFp/OKgZiDVzCI0DK3wSCj
	lRnZa4HuVdnmajYNgeVIYGMYsWRIAcP6fX9/WQP+Hpjw==
X-Received: by 2002:a17:902:e810:b0:202:60e:7700 with SMTP id d9443c01a7336-2076e30a90fmr81943635ad.7.1726198604068;
        Thu, 12 Sep 2024 20:36:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5KxL/+Jl5OHno+vBwCRfslH4I1TwXRrVogJku/JCJxU7qag9maJSGO3PPJAtx4nNtx91dAo70ROzV+X5P4Rs=
X-Received: by 2002:a17:902:e810:b0:202:60e:7700 with SMTP id
 d9443c01a7336-2076e30a90fmr81943185ad.7.1726198603466; Thu, 12 Sep 2024
 20:36:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com>
 <20240820073330.9161-5-xuanzhuo@linux.alibaba.com> <CACGkMEt19u07b_2GkT_tEBhpKJj97VoF-jcSqoaTyEULoWvdFw@mail.gmail.com>
 <1726126586.5406406-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1726126586.5406406-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Sep 2024 11:36:32 +0800
Message-ID: <CACGkMEvO+xg+237mq2Y+wDMxMum0CaiP3tMN81uqCGCfe_=Rbw@mail.gmail.com>
Subject: Re: [PATCH net-next 04/13] virtio_ring: perform premapped operations
 based on per-buffer
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 3:43=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Wed, 11 Sep 2024 11:54:25 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Tue, Aug 20, 2024 at 3:33=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > The current configuration sets the virtqueue (vq) to premapped mode,
> > > implying that all buffers submitted to this queue must be mapped ahea=
d
> > > of time. This presents a challenge for the virtnet send queue (sq): t=
he
> > > virtnet driver would be required to keep track of dma information for=
 vq
> > > size * 17, which can be substantial. However, if the premapped mode w=
ere
> > > applied on a per-buffer basis, the complexity would be greatly reduce=
d.
> > > With AF_XDP enabled, AF_XDP buffers would become premapped, while ker=
nel
> > > skb buffers could remain unmapped.
> >
> > Is this only applied to TX or both TX and RX.
>
>
> For rx, if you mean per-buffer dma buffer, I think it is yes,
> rx can reuse this. If you mean should we do premapped for the
> normal rx buffers, I think we should, that can reduce the
> dma map operations.
>
>
> >
> > >
> > > We can distinguish them by sg_page(sg), When sg_page(sg) is NULL, thi=
s
> > > indicates that the driver has performed DMA mapping in advance, allow=
ing
> > > the Virtio core to directly utilize sg_dma_address(sg) without
> > > conducting any internal DMA mapping.
> >
> > This seems conflict with the code below?
> >
> > #define sg_is_premapped(sg) (!sg_page(sg))
>
> Sorry, I do not get for you.
>
> The key point is that the sg->page is setted by driver.

Ok, I forget that but let's document this assumption in the changelog.

>
> So I mean if the driver sets sg->page =3D NULL, then for this sg,
> the virtio core can skip dma mapping. If the driver sets
> sg->page to the page of the buffer, then the virtio core should
> do dma mapping for this sg.
>

Ok, let's describe this in the changelog.

Thanks


