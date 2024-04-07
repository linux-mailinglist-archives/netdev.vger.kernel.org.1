Return-Path: <netdev+bounces-85477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AD189AE71
	for <lists+netdev@lfdr.de>; Sun,  7 Apr 2024 06:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AF2F1C21738
	for <lists+netdev@lfdr.de>; Sun,  7 Apr 2024 04:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F1E1C0DE6;
	Sun,  7 Apr 2024 04:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJzGvJKJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E21017F0
	for <netdev@vger.kernel.org>; Sun,  7 Apr 2024 04:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712463857; cv=none; b=K4epaY/WE1rfgmve3idg/l1zmsv5pPNpxe5r5ENRUzIwMMTxI6f7WD7PCFK/ogueK+0YppJCa919oFrrcDOVV8rbjC6KiGVjb6a+FWVu+EE9WRhh7yheFdimY4euOmhseMlsVLW1pxqCi6ZhQm/7CX41E8wqgkBjHdTJENzTrJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712463857; c=relaxed/simple;
	bh=6OATBPOVpS/ms3tqzNZDFhOAZJq2v3CoGie3cCKXJbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hFEtJEV2PHqjwX0BmIdOaTOdoIsOBQBEx8tzcpSWN2UAW/5AVzaixxaLruLfgV3ymnWeVmt4M5qypcgftN3SbtJYsFTOKHnbt9NX6aU/NmHOTPvxbLIuAH94g0fBbxW5GLW7Xp++5o2d++SH7ghW9fQqAe+EX3iZbivqvIvvOMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WJzGvJKJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712463854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6OATBPOVpS/ms3tqzNZDFhOAZJq2v3CoGie3cCKXJbA=;
	b=WJzGvJKJ907sv6fHU1FeZicx6wwkdmI5jGlqFgaVK4mmOm17gEfLjmqXhnGGCy9oW+H/E4
	y0Kw08o0QqUvUbGH5/VRcnKa5hOutzT/kv09DxlaDCm7rgvB8nTBwF5mgMDaFp4nzq7i9e
	Z5/rq3xh+KVyx8fed0gAJpNJbSJ8gB8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-9Gu1uzHdM4mck2xdtogq9w-1; Sun, 07 Apr 2024 00:24:12 -0400
X-MC-Unique: 9Gu1uzHdM4mck2xdtogq9w-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1e3deea5ac0so6869355ad.3
        for <netdev@vger.kernel.org>; Sat, 06 Apr 2024 21:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712463851; x=1713068651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6OATBPOVpS/ms3tqzNZDFhOAZJq2v3CoGie3cCKXJbA=;
        b=XEyseA6X6zSgldWi553GDPVwAW3W6khLOMrejYMu7jk/XFWTUdVeCimMywpzwqVxf5
         GarauqQZhJ2xmayGIhenxxr/6IBh2Zl7YJY5iu0NNFfOxviqVR18raNQd4O8vhvC4ia9
         9HJdQhOaR/rFFAKjTR4sK9nGiAEBBp2cFn0EC1xCCVeY3KAf+DUnZ/rt8txW8wLLWe2v
         QxAzC5EfjcXuUD3JHVdOBsQAwt92y+Yy054SpuCR11JDK3fLy69yqwJflIS6AaxCgVY3
         o6kASs0KivdDq0WX1QzOtNQaxqSfFea90S/QEUeDfJEP5TYWYDB3ZKrBmbbwsGxHGVGD
         ACng==
X-Forwarded-Encrypted: i=1; AJvYcCXBvuqlT71s8aTbazqAhp+g0ox23JzHq4JfjxZmiOff07fCCKY2ALmv9JT0HadjCl7pjGkwnH69QrYlA07lu6+ephJs0j2r
X-Gm-Message-State: AOJu0YxaA/pRarJlzmFGwB/OuYzbOhGxhbH3Bfqw5EGDMdnRKnMs3OKf
	n+Owh9R6VxYsRPxdRWtELGbrgZbVKwBIJAMH1TAiMf/CGVWKWj8DWkeSLBpQZz+fPCewCsldgab
	YGRh2j/KQr9coCKqKSve6yQKQ2ezZ0EvzkHei1FkFLvlSVlgirzvKT264pT7+HE1eKrPuEhVQaZ
	aNnKXIENNd/uHAGp3NyrAfmO9nEkb5
X-Received: by 2002:a17:902:d386:b0:1e2:aa62:2fbf with SMTP id e6-20020a170902d38600b001e2aa622fbfmr6062726pld.45.1712463851640;
        Sat, 06 Apr 2024 21:24:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKJ9h6aWFRS908/Qz7yqmKf6aKfGWv/jyE2JG7Z9q5DRXsyL7vtatY26Z0jM6vN9jB1rSm9kjSYvAmi7qPeUk=
X-Received: by 2002:a17:902:d386:b0:1e2:aa62:2fbf with SMTP id
 e6-20020a170902d38600b001e2aa622fbfmr6062713pld.45.1712463851383; Sat, 06 Apr
 2024 21:24:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327111430.108787-1-xuanzhuo@linux.alibaba.com>
 <20240327111430.108787-10-xuanzhuo@linux.alibaba.com> <CACGkMEs=NZGkkA7ye0wY7YcPBPfbKkYq84KCRX1gS0e=bZDX-w@mail.gmail.com>
 <1711614157.5913072-7-xuanzhuo@linux.alibaba.com> <CACGkMEuBhfMwrfaiburLG7gFw36GuVHSbRTtK+FycrGFVTgOcA@mail.gmail.com>
 <1711935607.4691076-1-xuanzhuo@linux.alibaba.com> <1711940418.2573907-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1711940418.2573907-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 7 Apr 2024 12:24:00 +0800
Message-ID: <CACGkMEvPZKa-au=2XaXrjT4t1vpPF4mPRNYNZ6uTPNyUpT8dfA@mail.gmail.com>
Subject: Re: [PATCH vhost v6 09/10] virtio_net: set premapped mode by find_vqs()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 11:10=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Mon, 1 Apr 2024 09:40:07 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com>=
 wrote:
> > On Fri, 29 Mar 2024 11:20:08 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Thu, Mar 28, 2024 at 4:27=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > On Thu, 28 Mar 2024 16:05:02 +0800, Jason Wang <jasowang@redhat.com=
> wrote:
> > > > > On Wed, Mar 27, 2024 at 7:14=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux=
.alibaba.com> wrote:
> > > > > >
> > > > > > Now, the virtio core can set the premapped mode by find_vqs().
> > > > > > If the premapped can be enabled, the dma array will not be
> > > > > > allocated. So virtio-net use the api of find_vqs to enable the
> > > > > > premapped.
> > > > > >
> > > > > > Judge the premapped mode by the vq->premapped instead of saving
> > > > > > local variable.
> > > > > >
> > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > ---
> > > > >
> > > > > I wonder what's the reason to keep a fallback when premapped is n=
ot enabled?
> > > >
> > > > Rethink this.
> > > >
> > > > I think you are right. We can remove the fallback.
> > > >
> > > > Because we have the virtio dma apis that wrap all the cases.
> > > > So I will remove the fallback from the virtio-net in next version.
> > >
> > > Ok.
> > >
> > > >
> > > > But we still need to export the premapped to the drivers.
> > > > Because we can enable the AF_XDP only when premapped is true.
> > >
> > > I may miss something but it should work like
> > >
> > > enable AF_XDP -> enable remapping
> > >
> > > So can we fail during remapping enablement?
> >
> >
> > YES.
> >
> > Enabling the premapped mode may fail, then we must stop to enable AF_XD=
P.
> >
> > AF-XDP requires that we export the dma dev to the af-xdp.
> > We can do that only when the virtio core works with use_dma_api.
> > Other other side, if we support the page-pool in future, we may have th=
e
> > same requirement.
>
> Rethink this.
>
> Enable premapped MUST NOT fail. No care the use_dma_api is true or not, b=
ecause
> we have the DMA APIs for virtio. Then the virtio-net rx will work with
> premapped (I will make the big mode work with premapped mode)

Just to make sure we're at the same page. Rx will always work in the
mode or pre mapping. So we can easily fail the probe if we fail to
enable RX premapping?

>
> AF_XDP checks the virtqueue_dma_dev() when enabling.
>
> But disabling premapped mode may fail, because that virtio ring need to
> allocate memory for dma.

That's kind of too tricky, what if we just allocate the memory for dma
unconditionally?

Thanks

>
> Thanks.
>
>
>
> >
> >
> > Thanks.
> >
> >
> > >
> > > THanks
> > >
> > > >
> > > > Thanks
> > > >
> > > >
> > > > >
> > > > > Thanks
> > > > >
> > > >
> > >
> >
>


