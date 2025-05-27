Return-Path: <netdev+bounces-193559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E2AAC46F2
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 05:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CCA83A41F7
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 03:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A721B415F;
	Tue, 27 May 2025 03:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GHduVQVv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD27323D
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 03:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748318197; cv=none; b=N3isxSxZva3oEd99Y4CM7J7ne/gUsLZ2EqgAB5MfMJsKniCOiDptJLbkVnCKxEiXE+tb+XHqRZd7YUfp8zHnO2TdS3RPMfYO8byqq9iJkb8mTJ9AUYceiyK1tx/EDb9W88eTy8soUpNlP5AjvUHQN3rZ9JF2hW9VWeSAxMN0nAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748318197; c=relaxed/simple;
	bh=G8ZduZfU7HBUksOZVAaQvRPkQ6B9VfQqH3QphboecP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JYrNomUtUeqPJA3m9NpdQtNtwlAsQSqu+dku8Iaw19FSLRnzZBsl1jqCOx2NGeDoVOd9hsLlbAV5llBn+vGPyidOScV5QOx8rs725785nOMr6z+90oX5hhtoLEZu1ZqGXEf5+hcs/sSMOJz0fy1cq1FHUhVSF3GhnChYzdirxIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GHduVQVv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748318194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TlRx0HbiV8xMdNsad+869NOJNfE8nbRONBWhrAFVEpU=;
	b=GHduVQVvxEI+SD3S5ofWwwfwKkJpUS4vzpGQ4xH+BwrRQloHqKyl/a0O7LxCE/2NbGwu0f
	eUkDSLH43C3vuUqduMZEIuAl/8lDb6XPOWoaENKow33BRSf4FxsrrGR0ZDIcAfj/Zfb/fJ
	ZCRiNo908b+N/3r6S/zSIxqJlhppdkc=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-CTPKt39vNhq-r2G6uf9duA-1; Mon, 26 May 2025 23:56:32 -0400
X-MC-Unique: CTPKt39vNhq-r2G6uf9duA-1
X-Mimecast-MFC-AGG-ID: CTPKt39vNhq-r2G6uf9duA_1748318191
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7429f7f9ee3so1978574b3a.2
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 20:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748318191; x=1748922991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TlRx0HbiV8xMdNsad+869NOJNfE8nbRONBWhrAFVEpU=;
        b=Nu+HEPASusW06Drs/MnEjr8NA6jYEHPb/RMIB2+txx+0Ps1ewhzIQIHFkXOuXXh/6v
         WM9hOyEPpRttFb/4rm+vuPXaIJs8p9pdUGspdBvJRk5q5Ufku0l33X88/jG0GNvsBTU9
         sih+WA+wnK7X7Lrk3Ox0BZa1kIXHQiVJuS6+3GqMgvb+1Jb0ZSgWOeb8Hc7E/aU3W97Y
         wEZMNzKcIok+cT0+clfVaUiYR9T+8U4I3XIHZ+YmdQytgKaBYuXQgE5WTaVpnUb6q04J
         D+KZqzahQ/4iXRqQoeMHpN3jI/gLuTInRaQZYjVye7z1/sU9B+IsFK9JikrR/IwIWmBu
         TQ8Q==
X-Gm-Message-State: AOJu0Yyk6PXHdo2g6F9RQtk4zHhrTXe8ql4YueICoDd7Tvpsdi6nNUva
	sFfK2307F3Jexc9BA2rtKujDJvLSVTvfiMeUQDS0FnuD9QdUnMA+TFqxe4DOzzsQwPKOTeWtvFo
	M6XwCGJJakK8WKnOErKxNyJg/RBsnPsBSoWyux4GAKgwvZriS3JRlhZT4Z/EgQItEE9dk6OCuLD
	XyirEnOzO1A7OX4/4ERyfaSwLjutOZYhyT
X-Gm-Gg: ASbGncstozYkun3kRpaX5wM72BMrYJh+gMaS+HkOJ+BlvzoJFn16D/4KGTdlznNxu1j
	+iJelmQdDBFqZpJ/avn/lBeLILmJ+A3jJM8zRWA3wdWsR8S/0edt6d+BO3fsRACfx1rjRkg==
X-Received: by 2002:a05:6a00:a85:b0:742:a0cf:7753 with SMTP id d2e1a72fcca58-745fdf76e20mr19061921b3a.3.1748318191363;
        Mon, 26 May 2025 20:56:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZP6Ne0g3pT11b6WdhQ2hjMzEpUyTgHtDMq3rfz96B+JEVZDoma3s4SodBIylAMoIoMVRORI6BRvGnMEvkCTc=
X-Received: by 2002:a05:6a00:a85:b0:742:a0cf:7753 with SMTP id
 d2e1a72fcca58-745fdf76e20mr19061889b3a.3.1748318190972; Mon, 26 May 2025
 20:56:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747822866.git.pabeni@redhat.com> <b1d716304a883a4e93178957defee2c560f5b3d4.1747822866.git.pabeni@redhat.com>
 <CACGkMEuzWGQB=kQeX-bA8jVn=5Sj_MP_Q2zbMS=tvKGYrNmWLw@mail.gmail.com> <df320160-88d4-44fc-92f8-dd7a9efb8569@redhat.com>
In-Reply-To: <df320160-88d4-44fc-92f8-dd7a9efb8569@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 May 2025 11:56:18 +0800
X-Gm-Features: AX0GCFtcz6QkZ_ts3wWjzKClU__2CPdG-D9tmeQqCFT31pExXerrnQiUeZYpAdg
Message-ID: <CACGkMEsrPVYzva_EOHMnoqYWajqiRsMoXsfUrPfuimvG=8EKsQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/8] vhost-net: allow configuring extended features
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 6:57=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 5/26/25 2:47 AM, Jason Wang wrote:
> > On Wed, May 21, 2025 at 6:33=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >>
> >> Use the extended feature type for 'acked_features' and implement
> >> two new ioctls operation to get and set the extended features.
> >>
> >> Note that the legacy ioctls implicitly truncate the negotiated
> >> features to the lower 64 bits range.
> >>
> >> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> >> ---
> >>  drivers/vhost/net.c        | 26 +++++++++++++++++++++++++-
> >>  drivers/vhost/vhost.h      |  2 +-
> >>  include/uapi/linux/vhost.h |  8 ++++++++
> >>  3 files changed, 34 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> >> index 7cbfc7d718b3f..b894685dded3e 100644
> >> --- a/drivers/vhost/net.c
> >> +++ b/drivers/vhost/net.c
> >> @@ -77,6 +77,10 @@ enum {
> >>                          (1ULL << VIRTIO_F_RING_RESET)
> >>  };
> >>
> >> +#ifdef VIRTIO_HAS_EXTENDED_FEATURES
> >> +#define VHOST_NET_FEATURES_EX VHOST_NET_FEATURES
> >> +#endif
> >> +
> >>  enum {
> >>         VHOST_NET_BACKEND_FEATURES =3D (1ULL << VHOST_BACKEND_F_IOTLB_=
MSG_V2)
> >>  };
> >> @@ -1614,7 +1618,7 @@ static long vhost_net_reset_owner(struct vhost_n=
et *n)
> >>         return err;
> >>  }
> >>
> >> -static int vhost_net_set_features(struct vhost_net *n, u64 features)
> >> +static int vhost_net_set_features(struct vhost_net *n, virtio_feature=
s_t features)
> >>  {
> >>         size_t vhost_hlen, sock_hlen, hdr_len;
> >>         int i;
> >> @@ -1704,6 +1708,26 @@ static long vhost_net_ioctl(struct file *f, uns=
igned int ioctl,
> >>                 if (features & ~VHOST_NET_FEATURES)
> >>                         return -EOPNOTSUPP;
> >>                 return vhost_net_set_features(n, features);
> >> +#ifdef VIRTIO_HAS_EXTENDED_FEATURES
> >
> > Vhost doesn't depend on virtio. But this invents a dependency, and I
> > don't understand why we need to do that.
>
> What do you mean with "dependency" here? vhost has already a build
> dependency vs virtio, including several virtio headers. It has also a
> logical dependency, using several virtio features.
>
> Do you mean a build dependency? this change does not introduce such a thi=
ng.

I mean vhost can be built without virtio drivers. So old vhost can run
new virtio drivers on top. So I don't see why vhost needs to check if
virtio of the same source tree supports 128 bit or not.

We can just accept an array of features now as

1) the changes are limited to vhost so it wouldn't be too much
2) we don't have to have VHOST_GET_FEATURES_EX2 in the future.

Thanks

>
> /P
>


