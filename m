Return-Path: <netdev+bounces-194110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C86AC75D8
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 04:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 240DE1748D5
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 02:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EBA2441A6;
	Thu, 29 May 2025 02:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cab38P1l"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1402B19E968
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 02:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748485378; cv=none; b=Ojl0MruxHuKU3s5BXSTMIsuQK9cbuSe9C7T1b81O46EC69Ruaiy/qbyibW3VUdgiBRos4CR5qtsN0zBsdFSNBVd5SLA77sCns8X3eSZ3aN2nxWfq039Nb6/AN2Yvqe91PFIr9PJX5yGHGk1PTu3Cmj/DTAEuwxvR0EltE9kU12c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748485378; c=relaxed/simple;
	bh=l20XhqXTvOsFpczVAt7IfGpCVqj1+02YFqH0iMqEr4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=flfk4wy5v8+5Cw80DBtUInAXQO7ZaVwIukTRas26XwPqLfv55GYHxCcvsqdQhxkLRv3c1xg2OOw5R9QXXy0jlwSl4R33KlUdBZJ3+eorbbXtxvwzD4PF3EYSNUlSHCCfDXfsKMGg/wgP7POpRQfeSb2Q8Jg8YGlihBP4TY7yIQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cab38P1l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748485374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pD+lpHG7PSW+C8uubrji1uTcQf759HAEgtP2Ipc4Mrk=;
	b=Cab38P1lsbZ9mTuZZ3umfz0Au5lUZLRHyNqrEqJ1xDkn1IjmoAOSdo3f3zZxoyBqJM5Pf/
	hj4B2kHhkNhEOYLTXHTLms2ZhnMxPVKf3aODuEgXXVO/83SSymoiY5PTcJqzOrXQhqj9j6
	p4/UqF5VPrFejbr/0vx2kHlxREggASg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-4Jhgo3DSNGSOj-K_A5Ylbg-1; Wed, 28 May 2025 22:22:53 -0400
X-MC-Unique: 4Jhgo3DSNGSOj-K_A5Ylbg-1
X-Mimecast-MFC-AGG-ID: 4Jhgo3DSNGSOj-K_A5Ylbg_1748485372
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-311e7337f26so296663a91.3
        for <netdev@vger.kernel.org>; Wed, 28 May 2025 19:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748485372; x=1749090172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pD+lpHG7PSW+C8uubrji1uTcQf759HAEgtP2Ipc4Mrk=;
        b=wMW1GAV+ulvSTO3v5+PIcANYfVlJa4SGu9tW000ssIfinMGnG6u/hreI6DE8uExKmB
         I99FLQQP3h1IYdQs4nkqSI/QjhhL31BJp7YkiuG6eSA7TM+dQzZRsLx6d+NHW57Cxrjh
         HQwkkKvg6cve2ck7dstllhUyopQ/vrLGXoD1xjucmRXCHN1HnYPM22hie9p1Gy/80gii
         f+fxEWNp9DdfEg6ERw1VLu2mizTQZEW5Kchzs0XzKTwebmTF7YBTVWRqOU+UzLnunu8r
         fsxo1pFn6fF/GUBhKYW37UlMvVTtranbY04kyUhRJFc4emTRd2Oa91N7wO/r7Cfd0Qba
         lq9A==
X-Gm-Message-State: AOJu0YyRX9j5/oudC++dwDYQFPmqcdGgp3PdjZEAqcYCCtdAY/Tovc0q
	Z4Z8wSLgJjgz/XI/CCm3KbiRRVEvevPbkp6KhkzuTRGGqUfOTg7+3UYJGYa31pplw9vHFXyi8kQ
	lZj74gcMAIAgaBm7be57tI9Nk8QYFehV6mAAFm7OtOGk0nzXWEInsTTAxgk7Rrwz9VSovQSl48s
	C24sLwK5PHQQg4SLOCvC1yu5f5HWLIhrF8
X-Gm-Gg: ASbGnctZJqRbSlsrdlUD6mqJfLoB1KSrDBRWS2Ol16plBAbXGtWpVfITb/xDI/zu5OF
	FemYz2PexWq0o+6ad6rAQdCzZppyKypyCA+og/pJj3n4+7lOWdh+jSE+YFkLaO39bd5mWJA==
X-Received: by 2002:a17:90b:1d44:b0:312:1b53:5ea8 with SMTP id 98e67ed59e1d1-3121dcb69b3mr834014a91.24.1748485372391;
        Wed, 28 May 2025 19:22:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQYoHj2g2JZQtV+7md3QI6V130SJ+CULzKmqLF+k04tNBCtHn50Z/94nSDOgrkZcKDTr6UEZdCWRu02+4E530=
X-Received: by 2002:a17:90b:1d44:b0:312:1b53:5ea8 with SMTP id
 98e67ed59e1d1-3121dcb69b3mr833977a91.24.1748485371934; Wed, 28 May 2025
 19:22:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747822866.git.pabeni@redhat.com> <f85bc2d08dfd1a686b1cd102977f615aa07b3190.1747822866.git.pabeni@redhat.com>
 <CACGkMEv=XnqKDXCEitEOs-AL1g=H=7WiHEaHrMUN-RfKN1JCRg@mail.gmail.com>
 <53242a04-ef11-4d5b-9c7e-7a34f7ad4274@redhat.com> <CACGkMEtZZbN8vj-V-PSwAmQKCP=gDN5sDz4TOXcOhNXGPLp_yQ@mail.gmail.com>
 <3d5c65e0-d458-4a56-8c93-c0b5d37420b5@redhat.com>
In-Reply-To: <3d5c65e0-d458-4a56-8c93-c0b5d37420b5@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 29 May 2025 10:22:40 +0800
X-Gm-Features: AX0GCFtobMk9UNoK1uAbcerm8Ezs-5uEzsO9f19R8VB5r7ulKy2m6-TOIvcW_CA
Message-ID: <CACGkMEuBrzozRYqrgu8pM-+Ke2-NhCbFRHr8NeVpP15Qo0RZGg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/8] virtio_pci_modern: allow setting configuring
 extended features
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 12:02=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 5/27/25 5:04 AM, Jason Wang wrote:
> > On Mon, May 26, 2025 at 6:53=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >> On 5/26/25 2:49 AM, Jason Wang wrote:
> >>> On Wed, May 21, 2025 at 6:33=E2=80=AFPM Paolo Abeni <pabeni@redhat.co=
m> wrote:
> >>>>
> >>>> The virtio specifications allows for up to 128 bits for the
> >>>> device features. Soon we are going to use some of the 'extended'
> >>>> bits features (above 64) for the virtio_net driver.
> >>>>
> >>>> Extend the virtio pci modern driver to support configuring the full
> >>>> virtio features range, replacing the unrolled loops reading and
> >>>> writing the features space with explicit one bounded to the actual
> >>>> features space size in word.
> >>>>
> >>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> >>>> ---
> >>>>  drivers/virtio/virtio_pci_modern_dev.c | 39 +++++++++++++++++------=
---
> >>>>  1 file changed, 25 insertions(+), 14 deletions(-)
> >>>>
> >>>> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio=
/virtio_pci_modern_dev.c
> >>>> index 1d34655f6b658..e3025b6fa8540 100644
> >>>> --- a/drivers/virtio/virtio_pci_modern_dev.c
> >>>> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> >>>> @@ -396,12 +396,16 @@ EXPORT_SYMBOL_GPL(vp_modern_remove);
> >>>>  virtio_features_t vp_modern_get_features(struct virtio_pci_modern_d=
evice *mdev)
> >>>>  {
> >>>>         struct virtio_pci_common_cfg __iomem *cfg =3D mdev->common;
> >>>> -       virtio_features_t features;
> >>>> +       virtio_features_t features =3D 0;
> >>>> +       int i;
> >>>>
> >>>> -       vp_iowrite32(0, &cfg->device_feature_select);
> >>>> -       features =3D vp_ioread32(&cfg->device_feature);
> >>>> -       vp_iowrite32(1, &cfg->device_feature_select);
> >>>> -       features |=3D ((u64)vp_ioread32(&cfg->device_feature) << 32)=
;
> >>>> +       for (i =3D 0; i < VIRTIO_FEATURES_WORDS; i++) {
> >>>> +               virtio_features_t cur;
> >>>> +
> >>>> +               vp_iowrite32(i, &cfg->device_feature_select);
> >>>> +               cur =3D vp_ioread32(&cfg->device_feature);
> >>>> +               features |=3D cur << (32 * i);
> >>>> +       }
> >>>
> >>> No matter if we decide to go with 128bit or not. I think at the lower
> >>> layer like this, it's time to allow arbitrary length of the features
> >>> as the spec supports.
> >>
> >> Is that useful if the vhost interface is not going to support it?
> >
> > I think so, as there are hardware virtio devices that can benefit from =
this.
>
> Let me look at the question from another perspective. Let's suppose that
> the virtio device supports an arbitrary wide features space, and the
> uAPI allows passing to/from the kernel an arbitrary high number of featur=
es.
>
> How could the kernel stop the above loop? AFAICS the virtio spec does
> not define any way to detect the end of the features space. An arbitrary
> bound is actually needed.

I think this is a good question ad we have something that could work:

1) current driver has drv->feature_table_size, so the driver knows
it's meaningless to read above the size

and

2) we can extend the spec, e.g add a transport specific field to let
the driver to know the feature size

>
> If 128 looks too low (why?) it can be raised to say 256 (why?). But
> AFAICS the only visible effect would be slower configuration due to
> larger number of unneeded I/O operations.

See above.

>
> /P
>

Thanks


