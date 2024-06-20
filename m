Return-Path: <netdev+bounces-105159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B99290FEA8
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 10:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 142F42865CB
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 08:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F8E17C7BE;
	Thu, 20 Jun 2024 08:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQ9WIhte"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C417F5B05E
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 08:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718871679; cv=none; b=YR4pYlLEuv6nnCLu9qSO+0YpK6JoNK4OWV5Q+oXjCObsS8qnsTt8bFYDbLZb7VV9HFGXJsZAZFb2L9rODhp9BHDc2T1aqBgMJl96/69O0OGdq1I34qjX+FmHcugSpGvvdaOBcJT8zux9kYo6EGBJUhyFRMrcLyjhywYu8UQB+zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718871679; c=relaxed/simple;
	bh=/n3uJxZGHDBrLN6/BzeZ/X4SdYonmAdhMRnGu+C5EYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c0HRpzOM/wlk7MHEpcWYWEaEQjqEWliUwPEVkKHVI3XGjdlw2gb0GRwvNrvHYOFt8poIf6am/5PmdRjn3Fnn81CZk1kEad0uti7v6MF7YqgeanL69wh3H+683E5N//Xlkir9iWF0Ubf8agFdI3SQU7AETLwQTdJInTG1N+N+ZgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SQ9WIhte; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718871676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UOPoZ6lA6/IZ64IgHqSK6o73AoMp8QIpZ9FSfSUbtuk=;
	b=SQ9WIhteZARClOgr/U8ueOaJv4OZeMhHIsBTvLGrGOmbWyFozlT5pRGXEefEQ2k/L1umEC
	C6XzFggWRe2A3GvyMZYYCqAdaU/W5PcEs08xk80eZfN1yYhKbN1gPpLeOGVEtX6Zpfb9bQ
	QgsZVAMmb3jUGYuZ2dtE0lA3CL4qWzA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-nS3_VypXNzyXPq4VjfkNIw-1; Thu, 20 Jun 2024 04:21:15 -0400
X-MC-Unique: nS3_VypXNzyXPq4VjfkNIw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2c79f32200aso786443a91.1
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 01:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718871674; x=1719476474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOPoZ6lA6/IZ64IgHqSK6o73AoMp8QIpZ9FSfSUbtuk=;
        b=RwCdOzGIaXURu6oN+SqLNvMT9sGIiCjiH7v9A2RlhHvodeDncHqh+EeB55Z72dVRWh
         K4hgGN9DszHC0UqKH5ZK82Jd+1pEvvrxZlNbC2k3tPlRkHxnDPznugcItZsLPmHhzeP8
         8azpBcgj95OcVldUHwHBKPILa6c9+AldGkpA4NNNmHmaJxJN2Gr4aRRk/3ZIXB4KL5bd
         teX9fFFnyBi6csPSO6ErrUstef9OhvWQPHtC1VGWNXHoiu7wBpwvfH93/NIFC+Xm4mgG
         cor9T7BSEBLV4W+j0UJbXeJMkbaRvDAWmPwsQmVuHE7TgEitBBJWg5vSI528Lfi4SylG
         1AbA==
X-Forwarded-Encrypted: i=1; AJvYcCWi0+wDBQFphansCIOnsKeHZo7mzkkAvPEDJI5SH2kTDDceN4L8K+lDCqpSIphBS+PThSIp9a0OAGIc2wRv9kqS34QfSPzO
X-Gm-Message-State: AOJu0Yxkz+ILfoOaXW/mPmBVyRNTGHfJwFkNXIITcvmA++jvkAQ8BA06
	FM3oJBEnPYKN2Cex+GMqyhcT7cVJpXCKJ0XU/93FpRgacgSRU3WsD/j2UrUhsj/SCC/wxk+0oal
	z81OndoAiMNBbwJrve6NlcSSiYRDb0uKorL92PytIvXugZaY12qxnQN9S/s8hFRNnBWIzk76gHs
	0ZPuGSeVSOwnKGfXFGeVWv2aw8IMTz
X-Received: by 2002:a17:90a:e00e:b0:2c2:c61f:e09 with SMTP id 98e67ed59e1d1-2c7b5c8ab04mr4856702a91.20.1718871673980;
        Thu, 20 Jun 2024 01:21:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEELXLOS9maMM8/VKYz9vtsvs8uB8tfK91+qINgt4JeMnX/Yop4+S/SdYYQlGJlokc9zzzowtkPFO6a1HfYlMg=
X-Received: by 2002:a17:90a:e00e:b0:2c2:c61f:e09 with SMTP id
 98e67ed59e1d1-2c7b5c8ab04mr4856685a91.20.1718871673621; Thu, 20 Jun 2024
 01:21:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619161908.82348-1-hengqi@linux.alibaba.com>
 <20240619161908.82348-3-hengqi@linux.alibaba.com> <20240619171708-mutt-send-email-mst@kernel.org>
 <1718868555.2701075-5-hengqi@linux.alibaba.com>
In-Reply-To: <1718868555.2701075-5-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Jun 2024 16:21:02 +0800
Message-ID: <CACGkMEv8jnnO=S3LYW00ypwHfM3Tzt42iuASG_d4FAAk60zoLg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/5] virtio_net: enable irq for the control vq
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 3:35=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
> On Wed, 19 Jun 2024 17:19:12 -0400, "Michael S. Tsirkin" <mst@redhat.com>=
 wrote:
> > On Thu, Jun 20, 2024 at 12:19:05AM +0800, Heng Qi wrote:
> > > @@ -5312,7 +5315,7 @@ static int virtnet_find_vqs(struct virtnet_info=
 *vi)
> > >
> > >     /* Parameters for control virtqueue, if any */
> > >     if (vi->has_cvq) {
> > > -           callbacks[total_vqs - 1] =3D NULL;
> > > +           callbacks[total_vqs - 1] =3D virtnet_cvq_done;
> > >             names[total_vqs - 1] =3D "control";
> > >     }
> > >
> >
> > If the # of MSIX vectors is exactly for data path VQs,
> > this will cause irq sharing between VQs which will degrade
> > performance significantly.
> >

Why do we need to care about buggy management? I think libvirt has
been teached to use 2N+2 since the introduction of the multiqueue[1].

> > So no, you can not just do it unconditionally.
> >
> > The correct fix probably requires virtio core/API extensions.
>
> If the introduction of cvq irq causes interrupts to become shared, then
> ctrlq need to fall back to polling mode and keep the status quo.

Having to path sounds a burden.

>
> Thanks.
>


Thanks

[1] https://www.linux-kvm.org/page/Multiqueue

> >
> > --
> > MST
> >
>


