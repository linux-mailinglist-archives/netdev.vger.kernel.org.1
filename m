Return-Path: <netdev+bounces-105160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAC490FEC6
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 10:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1052B1F227F6
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 08:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3674199237;
	Thu, 20 Jun 2024 08:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kb69K0be"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310613CF65
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 08:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718871982; cv=none; b=FK2mp/uxdZBX2ggt3ZPHFi6NOwz/h/TjlxdjnTGg8mYQXmjsL6VPzVfO/aU2GxG4wTQo4AJIL4XJhbWD8TKO5jaYcmvCPnX4QXVpo5QxgSzdt02Nl15Ot+wUo84VG/gLeuG1MMzOs3elhJsAr5tyx6qMxLdTKoINWAxDiobFM6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718871982; c=relaxed/simple;
	bh=CeoY8GPU0CCJrKlp1JJ4nDa6LGodwgXL/Hni5GpJoFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sMdTmPHmX8GDP2V3HPyCnQD0NmtrngPUM4l7hjvv0CAm1AzH0WCnjbJWztlbVvqoi53dfWJ+s4bxLUMIDXvWBwAvktiPBWth8fv9mWzJwW8z+utRj2150Lz/uyPwxeQ4IW7cRpj/uJR5Egtb3PmolLl8MqV/ixSCXVUQUkMNK/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kb69K0be; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718871979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bpzpDxpgiAo4iZSiruXBIQBzuL0A4exTkq3QGIhWnyE=;
	b=Kb69K0bez68oovMLTc0TnA3YbV96QU0cO/TbVOeXkQzobA4tvBtkor57xAT0ZGDzAcApIz
	12Y14MqAhTRiz7YdtR1FXlOCzoODBuSAzIFiJ8YID+Bc8glx1RJUPUHBrpAMdqctYSYTsy
	Tna/J5IDlE8rAMhEMlTiji/4SIIIVBM=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-cXHhisDCM026xaEFWXLJNA-1; Thu, 20 Jun 2024 04:26:18 -0400
X-MC-Unique: cXHhisDCM026xaEFWXLJNA-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-6ea972a3547so865681a12.1
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 01:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718871977; x=1719476777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpzpDxpgiAo4iZSiruXBIQBzuL0A4exTkq3QGIhWnyE=;
        b=PoqXdBqurjhprMxaWWigNEFwglHqq2FLAESgMPQ2T0r3ZxGlRR7wu/b6xGi/FshAla
         mcaUpohT/u6nRqvxp+1tR+YIIGTY2VZdyRhudAbGlNSBDfQytb2EZundSshsN/XngdRj
         LMst/c4Q3fR4wokPiaO9M88LSUsG0qD/wDN4ic8+GF2u7KgG6saHMKH9c/mZ1P/Orw5L
         Kxmo59QHSeJdQlWrc4XU5EWbrq4DeaNueqiPYgprJD8quyv4PRo/B8ivTl+Mclk/zbfJ
         HE7bd6oRuv7GoLWyg3W7S5jOg9sCq9qmOX3uPJHRoKZW8mlsXXF9yY9XU9iiI+2uO3Pc
         OY7w==
X-Forwarded-Encrypted: i=1; AJvYcCWswrz8Y3NYqSHdUtT9TJeEdmuNBHyNB62cc6/3g7Jxui8YT7RJmxHKSnLRR4usMIL0rftaRZ8Vay1o1uFcHxFiTyr4aDs2
X-Gm-Message-State: AOJu0YwCCQlllky5yMpQY8Hy9CtRENc6vWrUcbUKxpgQ6fCCfjWQOBpM
	pH7We+LMHoi1Kfa5bSs+4fhDuRuiubsYCXoUUBk11cJ2bIYKAFryJjJVnS79jPWH8IuU86JtXZ7
	PM3wiPT19HDKYV+TfRqABWGHNeVLuw+CDQD4ULHel3Ly/gcLW+xNW5zrsmD3kVlTnrbDY0DaKP7
	RwzvW6FBBF73fpLAd5mob9JYh8kLFk
X-Received: by 2002:a05:6a20:30d4:b0:1b8:9d79:7839 with SMTP id adf61e73a8af0-1bcbb45f3f7mr4760819637.29.1718871977255;
        Thu, 20 Jun 2024 01:26:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFesgf2aOIIcjAdv+mgbBHRoXQiVhOGizbrkTGeNaR0y3u/NJMc59SVcxYrznSlm4TyhjCB/ToyJxV2qoZvSMw=
X-Received: by 2002:a05:6a20:30d4:b0:1b8:9d79:7839 with SMTP id
 adf61e73a8af0-1bcbb45f3f7mr4760798637.29.1718871976850; Thu, 20 Jun 2024
 01:26:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619161908.82348-1-hengqi@linux.alibaba.com>
 <20240619161908.82348-3-hengqi@linux.alibaba.com> <20240619171708-mutt-send-email-mst@kernel.org>
 <1718868555.2701075-5-hengqi@linux.alibaba.com> <CACGkMEv8jnnO=S3LYW00ypwHfM3Tzt42iuASG_d4FAAk60zoLg@mail.gmail.com>
In-Reply-To: <CACGkMEv8jnnO=S3LYW00ypwHfM3Tzt42iuASG_d4FAAk60zoLg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Jun 2024 16:26:05 +0800
Message-ID: <CACGkMEtryWEbe-07-7GWyntGN+f-sL+uS0ozN0Oc6aMemmsYEw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/5] virtio_net: enable irq for the control vq
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 4:21=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Jun 20, 2024 at 3:35=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com=
> wrote:
> >
> > On Wed, 19 Jun 2024 17:19:12 -0400, "Michael S. Tsirkin" <mst@redhat.co=
m> wrote:
> > > On Thu, Jun 20, 2024 at 12:19:05AM +0800, Heng Qi wrote:
> > > > @@ -5312,7 +5315,7 @@ static int virtnet_find_vqs(struct virtnet_in=
fo *vi)
> > > >
> > > >     /* Parameters for control virtqueue, if any */
> > > >     if (vi->has_cvq) {
> > > > -           callbacks[total_vqs - 1] =3D NULL;
> > > > +           callbacks[total_vqs - 1] =3D virtnet_cvq_done;
> > > >             names[total_vqs - 1] =3D "control";
> > > >     }
> > > >
> > >
> > > If the # of MSIX vectors is exactly for data path VQs,
> > > this will cause irq sharing between VQs which will degrade
> > > performance significantly.
> > >
>
> Why do we need to care about buggy management? I think libvirt has
> been teached to use 2N+2 since the introduction of the multiqueue[1].

And Qemu can calculate it correctly automatically since:

commit 51a81a2118df0c70988f00d61647da9e298483a4
Author: Jason Wang <jasowang@redhat.com>
Date:   Mon Mar 8 12:49:19 2021 +0800

    virtio-net: calculating proper msix vectors on init

    Currently, the default msix vectors for virtio-net-pci is 3 which is
    obvious not suitable for multiqueue guest, so we depends on the user
    or management tools to pass a correct vectors parameter. In fact, we
    can simplifying this by calculating the number of vectors on realize.

    Consider we have N queues, the number of vectors needed is 2*N + 2
    (#queue pairs + plus one config interrupt and control vq). We didn't
    check whether or not host support control vq because it was added
    unconditionally by qemu to avoid breaking legacy guests such as Minix.

    Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
    Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
    Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
    Signed-off-by: Jason Wang <jasowang@redhat.com>

Thanks

>
> > > So no, you can not just do it unconditionally.
> > >
> > > The correct fix probably requires virtio core/API extensions.
> >
> > If the introduction of cvq irq causes interrupts to become shared, then
> > ctrlq need to fall back to polling mode and keep the status quo.
>
> Having to path sounds a burden.
>
> >
> > Thanks.
> >
>
>
> Thanks
>
> [1] https://www.linux-kvm.org/page/Multiqueue
>
> > >
> > > --
> > > MST
> > >
> >


