Return-Path: <netdev+bounces-101252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EF18FDDBA
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 06:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A34E1C22D81
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 04:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3D8219FF;
	Thu,  6 Jun 2024 04:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QNZaVswd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C6A19D8A1
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 04:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717647939; cv=none; b=uhNCYZ9INMvJKfdUN4PuEAWeCy0FQRuvlYY1VAlE36SpHaOos2VGeJBtaGgH5Rtxn2Ak/jhbOAuMLKcTzAS/7h1atOD/TY5Kvvuea5HRNj8dHuSFux4zi00OwNwpkrvLj2STjUMpJL/UY9hBAiiBgQnpmlnXNg2BbtUj7AGxKDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717647939; c=relaxed/simple;
	bh=DSfi+Biq2aW0cJ8wkedaa3lAHKHIQt7QcVEkTfIDKj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I8oqSR+F1B9zvtwCRM6dM0I4hbenyEb5kCHiFutJwxoYXXXPU0/RhSS2aXN7KyfdsEFgxIslPCv2lJX29Ds9hRQvTA8a1qgN99WuoUUqq5T8c1RP4ZY8rAvLV1wkYVE7u4J5YoWwbgilXpS6aCAw30mHaTFOawGl9kji6W7v4zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QNZaVswd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717647937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wSBCfrMFxIEimCoVPLYQ8l0DHjemGsXczcA6kmz3O+M=;
	b=QNZaVswd7hOzKwTUZIfzMN97j0vAJFmIHKn8qtAol3n65wNiroB9YqfaeJ0CybG/uwiiMC
	Qa8T0NUIysCQLZIVtO8CMD4/KkgiCJ4XrxwFGEybqpIxBZg6eCXLC0juP8DIiEUUK/p3Ba
	h2pbKJgG3xp/5wRCWXaTFzDYaBZ+xo4=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-NIeuK6aPMdOTUrcMkk3dvw-1; Thu, 06 Jun 2024 00:25:30 -0400
X-MC-Unique: NIeuK6aPMdOTUrcMkk3dvw-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-70256c09ec7so576234b3a.1
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 21:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717647929; x=1718252729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wSBCfrMFxIEimCoVPLYQ8l0DHjemGsXczcA6kmz3O+M=;
        b=B7VkLK3DMBdgo5+GUxvcdSfY8vRjl9wnvKE67qNlhK7WJxp+QjreJZpNCxgeMuUUJC
         mPOXvvoZXjYie79QtQAE55ZUVwwh6fIHpAeodqyPuQqaHw1buDqWEOFZyu5i6l33Ga8o
         XOgRePSbuBcwV8WOPZ/JiwBzvzpoFVZJCZpNBm+LUtZo2IOggzdI9q64nmBjjL8IE9uY
         82/1YI3xB7QDxG8tE6lDoXnSGKon97UOh1Se0aJKc2zmxOzMXXyyGxCDxVg6N9XrZAVQ
         H3HLOuA+liXJMTbNUXSDGo85OH+eR3O3U8VKh+9kOvNoZt9Kr64qJTkkvIsNqTpNC2/Y
         k1zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjMgdFQfXws8vmi93N4Z+l8QAahRINhfNpH+aJMFjbI4FFlgFK+LxOVkIMfyP5zHaehB4qLX/QY0HO9BDIPzHV/TqDogQ0
X-Gm-Message-State: AOJu0YwZrYeqlOgLiKym91J2pUQjyZ9/+e7rsyGEy3oFOmDYzExg/bEZ
	ZUDa7sesGRuRSw2Bn60eXp20B+yQx63Fk0wUXl+5uUaAbIP0MONL/vGI48UcUzSwvCzYG/NpWX8
	5yorf/Iyg+jAcGbbpNp568vJ2KjRQZwSe9b7OrWsVbt1EGMwDyoq+XwHAN5gT2Sij7IpwYZ2ElO
	6NzJwz/jmwPAzoR75fSOMWxU6QxqK5
X-Received: by 2002:a05:6a20:9686:b0:1a7:60d8:a6dd with SMTP id adf61e73a8af0-1b2b716eb94mr4390023637.53.1717647929563;
        Wed, 05 Jun 2024 21:25:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDUBe4Da26OmuDzxSJzfrOdRkfFw3X1ifGh/dMSB126LV+1Q/igGAVX2Gw+AdW7T2YmDPz0ADUvXcg9PgWyww=
X-Received: by 2002:a05:6a20:9686:b0:1a7:60d8:a6dd with SMTP id
 adf61e73a8af0-1b2b716eb94mr4390008637.53.1717647929136; Wed, 05 Jun 2024
 21:25:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509114615.317450-1-jiri@resnulli.us> <1715325076.4219763-2-hengqi@linux.alibaba.com>
 <ZktGj4nDU4X0Lxtx@nanopsycho.orion> <ZmBMa7Am3LIYQw1x@nanopsycho.orion>
 <1717587768.1588957-5-hengqi@linux.alibaba.com> <CACGkMEsiosWxNCS=Jpb-H14b=-26UzPjw+sD3H21FwVh2ZTF5g@mail.gmail.com>
 <CAL+tcoB8y6ctDO4Ph8WM-19qAoNMcYTVWLKRqsJYYrmW9q41=w@mail.gmail.com>
In-Reply-To: <CAL+tcoB8y6ctDO4Ph8WM-19qAoNMcYTVWLKRqsJYYrmW9q41=w@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 6 Jun 2024 12:25:15 +0800
Message-ID: <CACGkMEvh6nKfFMp5fb6tbijrs88vgSofCNkwN1UzKHnf6RqURg@mail.gmail.com>
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, Jiri Pirko <jiri@resnulli.us>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mst@redhat.com, 
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 10:59=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> Hello Jason,
>
> On Thu, Jun 6, 2024 at 8:21=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Wed, Jun 5, 2024 at 7:51=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.co=
m> wrote:
> > >
> > > On Wed, 5 Jun 2024 13:30:51 +0200, Jiri Pirko <jiri@resnulli.us> wrot=
e:
> > > > Mon, May 20, 2024 at 02:48:15PM CEST, jiri@resnulli.us wrote:
> > > > >Fri, May 10, 2024 at 09:11:16AM CEST, hengqi@linux.alibaba.com wro=
te:
> > > > >>On Thu,  9 May 2024 13:46:15 +0200, Jiri Pirko <jiri@resnulli.us>=
 wrote:
> > > > >>> From: Jiri Pirko <jiri@nvidia.com>
> > > > >>>
> > > > >>> Add support for Byte Queue Limits (BQL).
> > > > >>
> > > > >>Historically both Jason and Michael have attempted to support BQL
> > > > >>for virtio-net, for example:
> > > > >>
> > > > >>https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e1b=
c3@redhat.com/
> > > > >>
> > > > >>These discussions focus primarily on:
> > > > >>
> > > > >>1. BQL is based on napi tx. Therefore, the transfer of statistica=
l information
> > > > >>needs to rely on the judgment of use_napi. When the napi mode is =
switched to
> > > > >>orphan, some statistical information will be lost, resulting in t=
emporary
> > > > >>inaccuracy in BQL.
> > > > >>
> > > > >>2. If tx dim is supported, orphan mode may be removed and tx irq =
will be more
> > > > >>reasonable. This provides good support for BQL.
> > > > >
> > > > >But when the device does not support dim, the orphan mode is still
> > > > >needed, isn't it?
> > > >
> > > > Heng, is my assuption correct here? Thanks!
> > > >
> > >
> > > Maybe, according to our cloud data, napi_tx=3Don works better than or=
phan mode in
> > > most scenarios. Although orphan mode performs better in specific benc=
kmark,
> >
> > For example pktgen (I meant even if the orphan mode can break pktgen,
> > it can finish when there's a new packet that needs to be sent after
> > pktgen is completed).
> >
> > > perf of napi_tx can be enhanced through tx dim. Then, there is no rea=
son not to
> > > support dim for devices that want the best performance.
> >
> > Ideally, if we can drop orphan mode, everything would be simplified.
>
> Please please don't do this. Orphan mode still has its merits. In some
> cases which can hardly be reproduced in production, we still choose to
> turn off the napi_tx mode because the delay of freeing a skb could
> cause lower performance in the tx path,

Well, it's probably just a side effect and it depends on how to define
performance here.

> which is, I know, surely
> designed on purpose.

I don't think so and no modern NIC uses that. It breaks a lot of things.

>
> If the codes of orphan mode don't have an impact when you enable
> napi_tx mode, please keep it if you can.

For example, it complicates BQL implementation.

Thanks

>
> Thank you.
>


