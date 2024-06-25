Return-Path: <netdev+bounces-106305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78407915BB0
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 03:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EB57282494
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 01:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6194B17559;
	Tue, 25 Jun 2024 01:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TLLw/Fb4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC5D17BA0
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 01:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719278862; cv=none; b=NylYvGZxfcQVI9PtSB6VXQrGwezgEKzXRysA/QEwXMnGnv+PY2qhYwNu/cdkWNTvVrTlCtf+lo5zgsaL/VMmm7WlH0TbMlJPuv6JdVkaiBMCAmEg/bqNGGVii3KZh2Si3eEz48XOehEwxdOvuevhzdiKFute2tiQnTQbZBRio/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719278862; c=relaxed/simple;
	bh=lcl3kjOcrdpnrmRC0LXidWtYMWMJGh7ncjegY8IrIMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BsiuZsHmWKrRcEjB7eTKXpCI5CmZUqxiGYK87n9H/OHRtROgwOXmUWJ5qWnNK4KlFd6zyMoVSaH/c80NnMP8v08qKv7SHvJFLmyO8OfaycIQMDZxhmqdWFCarxgzDBb1ghi1NUXMtPld7m+6fU/WjD/8cwWkRxZF7XsNRt/rPLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TLLw/Fb4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719278859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lDFjTk1JNql5tI0ia7WLJKWDIsw4M/msf+eUvs8c+NU=;
	b=TLLw/Fb4n2MmXNypIA6il6kLfDWpuhFzpXwfviWIefBXaB94PGHe4PW08PHm6c1snwMrzd
	Kgnvl/mhqHXzNh1tQh3lA9tAm0hOm3kRhIIgLRQSnWjnr0rxhUmWYe+GHTfirjLtRrMz26
	CzEGkEKeiKkY7lzA7ZT4OnI/+UQNQak=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-xbaT2xMGO0eZnOh7ARp3cw-1; Mon, 24 Jun 2024 21:27:37 -0400
X-MC-Unique: xbaT2xMGO0eZnOh7ARp3cw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2c7a8fa8013so6407658a91.2
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 18:27:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719278856; x=1719883656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lDFjTk1JNql5tI0ia7WLJKWDIsw4M/msf+eUvs8c+NU=;
        b=KJo9Xo4gxtuQ6YffQEJKob8uj5/5v0OSH8xByyuZefIjOUyQJaplj88Dqfsrtl0I5w
         EEgeWGdT0tIv/PME36GbYvpXezc9a4nt9Yqv+0XTU4EZHQ32g4uUUuuSxADa9oF2vBqV
         bHGMdgW7WovQ3bH5l4056K02zSAi73TswassVIptoelFjYm9aQDJxSWkTlLyeJOeijBF
         HNm/8K3297KOcV2WOPuHk2LzpgUcVhhiaYKNoo50iJ7IemWqi0Gsc+SFNE/EUtNk7ULX
         FMnJNAOhz+vpAvU4vx0c5n8ABVI8svLobutshsQT9tDhUe/8nl0vz5rbR6eifserigYS
         OX2g==
X-Forwarded-Encrypted: i=1; AJvYcCUYbIB+MJghhi0F80LZPJ9GJPWLf6Ymz5a2+qKZ/54U6wlmESEuKZUwjg8rOJ7tT3HZ6XXbqQ2y8bcLvXMSM+L4ZImta8sM
X-Gm-Message-State: AOJu0Yy+XEdZBMhz+GcgCvLXjDdMsUU0CTThbE6puILo8jH3YAt6kenY
	n8ZE+xBQrAVNd2DRQAQXDCTj96fUk130SXTbV3v1NbAP6DncD2CmoeWGXYukz6LbQDvaiGdUDjf
	Tcv4lOwDS79TRK8e/kFIeKtGVaVbxij45ijD8s2p/auee6yeVNE3w+ud9gLQRi2Hp2D8YgDNhpO
	8lzTa79w5P9oiFQ19WWoaA6YpPxO4b
X-Received: by 2002:a17:90b:1d12:b0:2bd:d42a:e071 with SMTP id 98e67ed59e1d1-2c8582751e7mr5923448a91.30.1719278856334;
        Mon, 24 Jun 2024 18:27:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQX2v15J9HasbiG0qxwS3EwVOrcoFzC3/3pPPii8IU1Bz65W2MeXYkxKpAHQTcsOIIa9X2YAdalqVNZACS8Rs=
X-Received: by 2002:a17:90b:1d12:b0:2bd:d42a:e071 with SMTP id
 98e67ed59e1d1-2c8582751e7mr5923433a91.30.1719278855823; Mon, 24 Jun 2024
 18:27:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619161908.82348-1-hengqi@linux.alibaba.com>
 <20240619161908.82348-3-hengqi@linux.alibaba.com> <20240619171708-mutt-send-email-mst@kernel.org>
 <1718868555.2701075-5-hengqi@linux.alibaba.com> <CACGkMEv8jnnO=S3LYW00ypwHfM3Tzt42iuASG_d4FAAk60zoLg@mail.gmail.com>
 <CACGkMEtryWEbe-07-7GWyntGN+f-sL+uS0ozN0Oc6aMemmsYEw@mail.gmail.com>
 <1718877195.0503237-9-hengqi@linux.alibaba.com> <20240620060816-mutt-send-email-mst@kernel.org>
 <20240620061109-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240620061109-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 25 Jun 2024 09:27:24 +0800
Message-ID: <CACGkMEtacpgHvD7GLysXWm7_CybhgyJYx=AMAX+jk6+G4wqW8Q@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/5] virtio_net: enable irq for the control vq
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 6:12=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Jun 20, 2024 at 06:10:51AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Jun 20, 2024 at 05:53:15PM +0800, Heng Qi wrote:
> > > On Thu, 20 Jun 2024 16:26:05 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Thu, Jun 20, 2024 at 4:21=E2=80=AFPM Jason Wang <jasowang@redhat=
.com> wrote:
> > > > >
> > > > > On Thu, Jun 20, 2024 at 3:35=E2=80=AFPM Heng Qi <hengqi@linux.ali=
baba.com> wrote:
> > > > > >
> > > > > > On Wed, 19 Jun 2024 17:19:12 -0400, "Michael S. Tsirkin" <mst@r=
edhat.com> wrote:
> > > > > > > On Thu, Jun 20, 2024 at 12:19:05AM +0800, Heng Qi wrote:
> > > > > > > > @@ -5312,7 +5315,7 @@ static int virtnet_find_vqs(struct vi=
rtnet_info *vi)
> > > > > > > >
> > > > > > > >     /* Parameters for control virtqueue, if any */
> > > > > > > >     if (vi->has_cvq) {
> > > > > > > > -           callbacks[total_vqs - 1] =3D NULL;
> > > > > > > > +           callbacks[total_vqs - 1] =3D virtnet_cvq_done;
> > > > > > > >             names[total_vqs - 1] =3D "control";
> > > > > > > >     }
> > > > > > > >
> > > > > > >
> > > > > > > If the # of MSIX vectors is exactly for data path VQs,
> > > > > > > this will cause irq sharing between VQs which will degrade
> > > > > > > performance significantly.
> > > > > > >
> > > > >
> > > > > Why do we need to care about buggy management? I think libvirt ha=
s
> > > > > been teached to use 2N+2 since the introduction of the multiqueue=
[1].
> > > >
> > > > And Qemu can calculate it correctly automatically since:
> > > >
> > > > commit 51a81a2118df0c70988f00d61647da9e298483a4
> > > > Author: Jason Wang <jasowang@redhat.com>
> > > > Date:   Mon Mar 8 12:49:19 2021 +0800
> > > >
> > > >     virtio-net: calculating proper msix vectors on init
> > > >
> > > >     Currently, the default msix vectors for virtio-net-pci is 3 whi=
ch is
> > > >     obvious not suitable for multiqueue guest, so we depends on the=
 user
> > > >     or management tools to pass a correct vectors parameter. In fac=
t, we
> > > >     can simplifying this by calculating the number of vectors on re=
alize.
> > > >
> > > >     Consider we have N queues, the number of vectors needed is 2*N =
+ 2
> > > >     (#queue pairs + plus one config interrupt and control vq). We d=
idn't
> > > >     check whether or not host support control vq because it was add=
ed
> > > >     unconditionally by qemu to avoid breaking legacy guests such as=
 Minix.
> > > >
> > > >     Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
> > > >     Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > > >     Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > >     Signed-off-by: Jason Wang <jasowang@redhat.com>
> > >
> > > Yes, devices designed according to the spec need to reserve an interr=
upt
> > > vector for ctrlq. So, Michael, do we want to be compatible with buggy=
 devices?
> > >
> > > Thanks.
> >
> > These aren't buggy, the spec allows this.

So it doesn't differ from the case when we are lacking sufficient msix
vectors in the case of multiqueue. In that case we just fallback to
share one msix for all queues and another for config and we don't
bother at that time.

Any reason to bother now?

Thanks

> >  So don't fail, but
> > I'm fine with using polling if not enough vectors.
>
> sharing with config interrupt is easier code-wise though, FWIW -
> we don't need to maintain two code-paths.
>
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > > > So no, you can not just do it unconditionally.
> > > > > > >
> > > > > > > The correct fix probably requires virtio core/API extensions.
> > > > > >
> > > > > > If the introduction of cvq irq causes interrupts to become shar=
ed, then
> > > > > > ctrlq need to fall back to polling mode and keep the status quo=
.
> > > > >
> > > > > Having to path sounds a burden.
> > > > >
> > > > > >
> > > > > > Thanks.
> > > > > >
> > > > >
> > > > >
> > > > > Thanks
> > > > >
> > > > > [1] https://www.linux-kvm.org/page/Multiqueue
> > > > >
> > > > > > >
> > > > > > > --
> > > > > > > MST
> > > > > > >
> > > > > >
> > > >
>


