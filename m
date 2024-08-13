Return-Path: <netdev+bounces-117911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB2194FC62
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 05:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 234291C213E9
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 03:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4641BC44;
	Tue, 13 Aug 2024 03:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jMcqL7+a"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146E919470
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 03:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723520763; cv=none; b=R1Ndx9B7UclFTDGiWV9ILav/2ZgZsgd1PekBiGukEnTkO4FW3ZdOVdV1GWFyz1gU3Nq+iDKX0KcbHn/dAUzKy0c9Pi8ns2SJveg2OUJiwvzUsb5gEA+3HuqHma1aGfYX3iB47CwHd0iULyDGtL2FqysyHUT5E2wt3W1cpwYdctM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723520763; c=relaxed/simple;
	bh=yceP9DAWKPKlT7Sq5hjZWKK36tp3OUW2w6K7QPwMXj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S9rLMI5xNrRB7/FwzTWzjfsRzQqyt4qddh9sF9ZKmBu2xmq18pRY5OXsvCLY3EFXsfKpI+TiB70x/GJ5hvR5um2E1EFPl3y1z15b2JjltETSBt4B6sTVuUiBGmyRv55oWOuwyl1f2PqMHeatRBzGxub3aYXl2OpBeT+ZkU/3A7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jMcqL7+a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723520761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VLzbGP2JsMnr9jy5iZ9KVQ1RMqy5vYx7gbKlTyJ7iAc=;
	b=jMcqL7+aLstLo1cM8HndCRoqRNZYiMb1JGf76pC88ofPQ1P4ntvrii//lZyIp9Yi7Xf4EF
	0FRZ94sbQ0JOD5iKKYHhgTxD9Y+NHvkUp1FRpFm4CbBvCL1u/99sOtaoxgA9QyW0aM8FtR
	+kxf721o6v218P9ubinvzJx5fcVwU0U=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-IET1C4Z1Ot2IPeQYc1RSYw-1; Mon, 12 Aug 2024 23:45:59 -0400
X-MC-Unique: IET1C4Z1Ot2IPeQYc1RSYw-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-78e323b3752so2975386a12.0
        for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 20:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723520758; x=1724125558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLzbGP2JsMnr9jy5iZ9KVQ1RMqy5vYx7gbKlTyJ7iAc=;
        b=aJ6hfOzEWIifxWHz32zoKeZdEJeXMayR7Tz0MbFdF7ZteSjZoQ7V2T1WhyRwbEUAwV
         EuNAsbUl958L47b7j+7J/unXq99RSe7LD3SdWCnk/h+BOb1ug33oUkEtObIB0CscBQ7c
         YHaVQm3DtMnz5D8+GwwoBSBCkrWRp/lKfabYsbKVMNjLS/4WNwwFwkMua5xNK8aXH+HO
         rjEa0YiGP7F+7JP7akdxcZmthyLTYi1a6zfN4hZrZcaOTLU4x499mIpsRHxm1QUoG25h
         rJbA9ffeU3zvqYo7D85UyxU2Bxo+XADERv1ud7Xdy44eW6uSbr7+37BG1rjmmFtRhC2g
         lAxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRKAEyj/kfjAQcxmGfY9N1MADDGk+tMxfom0cTaoPF2wuXRv9pDqRuJkKmcjTvv3J/jnsgfzkXaMoeFGdSfPXzodIdR9kJ
X-Gm-Message-State: AOJu0YysvgvC7/xNFa8dyrzHtcNYwLn0ShsvjFSF/cGIibxxD9ZH4CCM
	BrijfsJENccuOid+EswHHNoX5tqAd78lkyyS7ixrJeox6jlEfw4fazjwD0Jqn95iBHY0Gxlj4k5
	qpApjewwSeYGTcgy5vzi4QWTWdRkKJE9mlyuXBx5BpWARiHxjmjmZeeQvP2sAPSsEPoCPyUhtTO
	Q4A9hNP+zq0ns4ne9YAA7tfhu1jKEi
X-Received: by 2002:a05:6a20:d807:b0:1c2:8efc:88e9 with SMTP id adf61e73a8af0-1c8d758f7b3mr2695458637.40.1723520758531;
        Mon, 12 Aug 2024 20:45:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzdASWlW/KSJWKCN/sNH/7JSAZUMKWVCaiEG3UXrFA9r5uSYwo8aJRYAd+QG4neTb0YfGVMCyAfG0csmi814c=
X-Received: by 2002:a05:6a20:d807:b0:1c2:8efc:88e9 with SMTP id
 adf61e73a8af0-1c8d758f7b3mr2695435637.40.1723520757960; Mon, 12 Aug 2024
 20:45:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806022224.71779-1-jasowang@redhat.com> <20240806022224.71779-5-jasowang@redhat.com>
 <20240806082436-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240806082436-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 13 Aug 2024 11:45:46 +0800
Message-ID: <CACGkMEuNqpeNwmFNu-104RxRr0VnBt5Tv_MLg0UdWmjoDxZsMA@mail.gmail.com>
Subject: Re: [PATCH net-next V6 4/4] virtio-net: synchronize probe with ndo_set_features
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 8:25=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Tue, Aug 06, 2024 at 10:22:24AM +0800, Jason Wang wrote:
> > We calculate guest offloads during probe without the protection of
> > rtnl_lock. This lead to race between probe and ndo_set_features. Fix
> > this by moving the calculation under the rtnl_lock.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> Fixes tag pls?

Fixes: 3f93522ffab2 ("virtio-net: switch off offloads on demand if
possible on XDP set")

Thanks


>
> > ---
> >  drivers/net/virtio_net.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index fc5196ca8d51..1d86aa07c871 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -6596,6 +6596,11 @@ static int virtnet_probe(struct virtio_device *v=
dev)
> >               netif_carrier_on(dev);
> >       }
> >
> > +     for (i =3D 0; i < ARRAY_SIZE(guest_offloads); i++)
> > +             if (virtio_has_feature(vi->vdev, guest_offloads[i]))
> > +                     set_bit(guest_offloads[i], &vi->guest_offloads);
> > +     vi->guest_offloads_capable =3D vi->guest_offloads;
> > +
> >       rtnl_unlock();
> >
> >       err =3D virtnet_cpu_notif_add(vi);
> > @@ -6604,11 +6609,6 @@ static int virtnet_probe(struct virtio_device *v=
dev)
> >               goto free_unregister_netdev;
> >       }
> >
> > -     for (i =3D 0; i < ARRAY_SIZE(guest_offloads); i++)
> > -             if (virtio_has_feature(vi->vdev, guest_offloads[i]))
> > -                     set_bit(guest_offloads[i], &vi->guest_offloads);
> > -     vi->guest_offloads_capable =3D vi->guest_offloads;
> > -
> >       pr_debug("virtnet: registered device %s with %d RX and TX vq's\n"=
,
> >                dev->name, max_queue_pairs);
> >
> > --
> > 2.31.1
>


