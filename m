Return-Path: <netdev+bounces-194684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBD6ACBE67
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 04:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2099F7A8005
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 02:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EF61537A7;
	Tue,  3 Jun 2025 02:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EoUTqHFE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6780D78F5D
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 02:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748916702; cv=none; b=BChIqE03PN/5FgWC/riY6TWBQkZtgHvv+b5X8dbIC0CA8FSq7ndzR4XzmTv4DaWvxdc5Og8qQ/a7wOAyzF14lqj+SdGvu/HbSn8r7lAcjfDpfU4GQDexiQWfDxoUyvTzBPTTw2RoNV4X1fZpe+bjUmmf7nvCNacXiPWYCEKQeBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748916702; c=relaxed/simple;
	bh=3uzqRx1XXjG751WtjleHYzp39sKdhV9LgyfIo9SVRRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nYUIY4aQQzSSqLCElVWaipsT6R7hvIdOKoHL8bhB4ETU36fwSAFIQzy16bKz8/gJd47uDMnN/8Vsd94xfsQWWKpM9MLE/miEcx1vYJgECli5fE6fbhNbd58LtdpBGVkDnk7fGvbxZH1RJFVcHQGEZ2HDBfHda0JJi5hJTVECsdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EoUTqHFE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748916699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1KPMijXkiqNHocBhG8YWvF/SFkGsOr/RctNp1A/iOCM=;
	b=EoUTqHFEdRt6uEd9/Xn8o+rOQ61lBZtCX4t0GkW65bhud954MNwb6lTvke6JJryNrL0ms4
	7D2N4+1n1YwYxc+iTVRSl2AxFv+jj5Dzqj1jNzTerOuynFAxQG0BgreJkzTPrvAJDX0t3/
	Kbsir9ob53hkJzvADhyncdra63hacgg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-zQxF7kWjPeyruJV8muROyQ-1; Mon, 02 Jun 2025 22:11:38 -0400
X-MC-Unique: zQxF7kWjPeyruJV8muROyQ-1
X-Mimecast-MFC-AGG-ID: zQxF7kWjPeyruJV8muROyQ_1748916697
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-311f4f2e6baso4806604a91.0
        for <netdev@vger.kernel.org>; Mon, 02 Jun 2025 19:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748916697; x=1749521497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KPMijXkiqNHocBhG8YWvF/SFkGsOr/RctNp1A/iOCM=;
        b=BjgrRdVHXfpY3/ridzzdzldQPUuTMs0eOB8VqK+4fQMuniGzpqNkpsWJsEtoux9ywL
         9Dt2fmKWnBLwVLF/JOUqUaWGht5JnQzNu2SlEGqa8XcXAazi9v763zMBfcCnFfHE49Hu
         j6pRoSn6Co4ROKuu6pUELGVmiUyCDmzQA/49N7UflZegJ6BtJuMuJwf1OB39rUCVxJY9
         cayh3dYrl/GKcTI3YVJCVTeP3C6GDMubUEf7UEFf2KPmAfXp/0WwYfL+KwRxDgLUXsx+
         yrh/LO0rmquHnTD1F1H8JxIdSV5YnjY46xSOLnv3LNOmY5DVjCrzxa42/w/XWbInQpUi
         yRMA==
X-Gm-Message-State: AOJu0YzmuCiDMRBhQvD9a8v+3kjKTEmOLLVwZVDJFq3yoY2i3Zo63P6o
	hjxi9/5edsugMWWZfxi+qZgoF3/9cLxpsj9KlenFmqFl+XWA+zunZu6BxroqqoL57GU3Zh7FZH9
	R5JpkWIdHRLQltCV0ijPh6B+tQCDAj7H46mst3QpiTW6yAyLY4mDdlf70Y/JL1fS6kkRe3IJf2S
	vNdzULlhHxvweFyHp7OSHUd45INZko2qUi
X-Gm-Gg: ASbGncvXo6kY1lBhgeXbVWuD087o26G5//KPjkSQH3AppDSm1fX0uGqEIgsg2CyccZ4
	n1OIvDzXT7X2gimT7XGKpI73WH0hkNplwDfOdQnw0D64wmV1WwEkWkpOo9fw0ziof3PJxOVOpOT
	oQqUI0
X-Received: by 2002:a17:90b:1dd1:b0:312:1147:7b16 with SMTP id 98e67ed59e1d1-3127c75a1f6mr15544389a91.35.1748916697099;
        Mon, 02 Jun 2025 19:11:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuUe9sJGsO7UK0nl4Vx/9ROvP5GYea0ATfhr9Y+QQ8rh1BwIsSflwM4PiVHY/ZS8Jor6v/zCt91y/qjzXcUKk=
X-Received: by 2002:a17:90b:1dd1:b0:312:1147:7b16 with SMTP id
 98e67ed59e1d1-3127c75a1f6mr15544358a91.35.1748916696645; Mon, 02 Jun 2025
 19:11:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747822866.git.pabeni@redhat.com> <b1d716304a883a4e93178957defee2c560f5b3d4.1747822866.git.pabeni@redhat.com>
 <CACGkMEuzWGQB=kQeX-bA8jVn=5Sj_MP_Q2zbMS=tvKGYrNmWLw@mail.gmail.com>
 <df320160-88d4-44fc-92f8-dd7a9efb8569@redhat.com> <CACGkMEsrPVYzva_EOHMnoqYWajqiRsMoXsfUrPfuimvG=8EKsQ@mail.gmail.com>
 <546a1ee3-7003-4acf-879f-d67f65b534c2@redhat.com>
In-Reply-To: <546a1ee3-7003-4acf-879f-d67f65b534c2@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 3 Jun 2025 10:11:24 +0800
X-Gm-Features: AX0GCFut3EnjV5nWSwn0GI9fLTC9UK7WVr8QgbC2oIYLw-51Dek0wTYCQoAwKMo
Message-ID: <CACGkMEv9-GDayzA+HwY3g8+AT=0PDMQeWv_yx7wXAO96-+82sA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/8] vhost-net: allow configuring extended features
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 7:10=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 5/27/25 5:56 AM, Jason Wang wrote:
> > On Mon, May 26, 2025 at 6:57=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >> On 5/26/25 2:47 AM, Jason Wang wrote:
> >>> On Wed, May 21, 2025 at 6:33=E2=80=AFPM Paolo Abeni <pabeni@redhat.co=
m> wrote:
> >>>>
> >>>> Use the extended feature type for 'acked_features' and implement
> >>>> two new ioctls operation to get and set the extended features.
> >>>>
> >>>> Note that the legacy ioctls implicitly truncate the negotiated
> >>>> features to the lower 64 bits range.
> >>>>
> >>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> >>>> ---
> >>>>  drivers/vhost/net.c        | 26 +++++++++++++++++++++++++-
> >>>>  drivers/vhost/vhost.h      |  2 +-
> >>>>  include/uapi/linux/vhost.h |  8 ++++++++
> >>>>  3 files changed, 34 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> >>>> index 7cbfc7d718b3f..b894685dded3e 100644
> >>>> --- a/drivers/vhost/net.c
> >>>> +++ b/drivers/vhost/net.c
> >>>> @@ -77,6 +77,10 @@ enum {
> >>>>                          (1ULL << VIRTIO_F_RING_RESET)
> >>>>  };
> >>>>
> >>>> +#ifdef VIRTIO_HAS_EXTENDED_FEATURES
> >>>> +#define VHOST_NET_FEATURES_EX VHOST_NET_FEATURES
> >>>> +#endif
> >>>> +
> >>>>  enum {
> >>>>         VHOST_NET_BACKEND_FEATURES =3D (1ULL << VHOST_BACKEND_F_IOTL=
B_MSG_V2)
> >>>>  };
> >>>> @@ -1614,7 +1618,7 @@ static long vhost_net_reset_owner(struct vhost=
_net *n)
> >>>>         return err;
> >>>>  }
> >>>>
> >>>> -static int vhost_net_set_features(struct vhost_net *n, u64 features=
)
> >>>> +static int vhost_net_set_features(struct vhost_net *n, virtio_featu=
res_t features)
> >>>>  {
> >>>>         size_t vhost_hlen, sock_hlen, hdr_len;
> >>>>         int i;
> >>>> @@ -1704,6 +1708,26 @@ static long vhost_net_ioctl(struct file *f, u=
nsigned int ioctl,
> >>>>                 if (features & ~VHOST_NET_FEATURES)
> >>>>                         return -EOPNOTSUPP;
> >>>>                 return vhost_net_set_features(n, features);
> >>>> +#ifdef VIRTIO_HAS_EXTENDED_FEATURES
> >>>
> >>> Vhost doesn't depend on virtio. But this invents a dependency, and I
> >>> don't understand why we need to do that.
> >>
> >> What do you mean with "dependency" here? vhost has already a build
> >> dependency vs virtio, including several virtio headers. It has also a
> >> logical dependency, using several virtio features.
> >>
> >> Do you mean a build dependency? this change does not introduce such a =
thing.
> >
> > I mean vhost can be built without virtio drivers. So old vhost can run
> > new virtio drivers on top. So I don't see why vhost needs to check if
> > virtio of the same source tree supports 128 bit or not.
> >
> > We can just accept an array of features now as
> >
> > 1) the changes are limited to vhost so it wouldn't be too much
> > 2) we don't have to have VHOST_GET_FEATURES_EX2 in the future.
>
> AFAICS the ioctl() interface code wise only impacts on the device
> implementing extended features support, I guess it could be changed to
> to something alike:
>
> struct vhost_virtio_features {
>         __u64 count;
>         __u64 features[];
> };
>
> #define VHOST_GET_FEATURES_VECTOR _IOR(VHOST_VIRTIO, 0x83, struct
> vhost_virtio_features)
> #define VHOST_SET_FEATURES_VECTOR _IOW(VHOST_VIRTIO, 0x83, struct
> vhost_virtio_features)
>
> I could drop the above #ifdef, and the implementation would copy in/out
> only the known/supported number of features.
>
> WDYT?

This looks good.

Thanks

>
> /P
>


