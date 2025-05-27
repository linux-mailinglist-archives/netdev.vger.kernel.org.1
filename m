Return-Path: <netdev+bounces-193552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84467AC46A7
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 05:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C32B16F997
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 03:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D0B16FF44;
	Tue, 27 May 2025 03:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i02adTCr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AE1101FF
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 03:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748315108; cv=none; b=Z0DByGMqAIMDTsZbI4MbcfRO/fcKyebdEp3fL52LDy9Wg2zqprJrX3m+fpLXx3Xfr5yfK1+KKw39hqQ94TjU/gq61eGT5Rd4qs3vwe/SB//Jq14vYrA3xCJI22AI7ycfZe78DHjNxEgaLWxYE2xG8XN0MHu7HNs3/XVjHkEHDyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748315108; c=relaxed/simple;
	bh=k10n3ZDTBPjq4A/ncCvQbRE1VG6CxYW5mKQVlsjd7Rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g8B4rYKBH2dirHLRI22eVWaP+Fza8wZg9ktia0qDVnuRNzcr/5h91NKSJNZesaoT/YMcaWLqARU9OeYpif7ZbblEDfdADYMF6AcI9/dgfOf/5+fq2LcoUBrwTCxLL0AbUG1TCs/MUT//PVanq4h+33juoGqX/JE5WLd0cfheFGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i02adTCr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748315105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SlnRuu4hzLlxJn4LqFSJ/fu3VkYTvP5aXn9drPaVUTA=;
	b=i02adTCr1dZ1p8Eathf0wy09OQ/OuQXO+0h0gZwrSE7yQNypcq9VuI31ZwEmtXD276anl+
	+Si2SFrdLFV+3dp826wRr74ec6urISJYl+RnVINSDZEZKh2fqePHsPBT53P8gZEGWeoKt4
	tMMSH0yaTiNeWwR4bOwAVOO4vugLL8U=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-X_fSLGwyNOmCb0LD9z7QYg-1; Mon, 26 May 2025 23:05:03 -0400
X-MC-Unique: X_fSLGwyNOmCb0LD9z7QYg-1
X-Mimecast-MFC-AGG-ID: X_fSLGwyNOmCb0LD9z7QYg_1748315102
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b2c0cbf9fddso1686170a12.3
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 20:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748315102; x=1748919902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SlnRuu4hzLlxJn4LqFSJ/fu3VkYTvP5aXn9drPaVUTA=;
        b=AYyQdh5K5ATaR04yuy7uD39KZpZsS8PWifnkvxZTuBXglGN5yVKiBSsLTtrtXH8YJI
         /LAovHJmMOkL4ZCQvQNdZJ2+wdZf+yBCjhuvaHfVoqxCBJNVJJeoQUkV/jedYTtynLfl
         fyK2tl5IMf//znKwIwmxzNANSo/SljhNg/Qv0s+qRWMfxaPplnH41ZQqQGsPwHd4/3Mf
         5B09Rqx3zetCASiiMkJIzzKg9pPZyTwkOfQEjzEJdeTLH03NPhD8nS2JKHTWW9W3J874
         NRwXceGUSQqsJ9CXyISzWHMT9FsB3QoVjzveSqJkiSAX38BqO+SNHYPgfTQvWvZ++/IF
         UnLA==
X-Gm-Message-State: AOJu0Yw/gwZ1ikPHMnuZMaKSyarRALkgOJyGs0Up8fHjIQykD418PAf0
	oCitHAyqAWl+aUYOwioTF6CeSeEscCmQrQsNw08agoJF6w20CD5Ki5G+JMxSRhB+3pmjWajnbyR
	wpK3IIfVQgY6uvUAqIvRr1pogaracsyluKHrgB5QdeTR1CMt5xaZw/jFNOA4tdFT60G5giuN0np
	2g7h+Mh6ybwuaaeS+hnb/PuOp6O/M2S4UgjEdxume/XqQ9aQ==
X-Gm-Gg: ASbGncuHnmDpQusQ30merp8mQ0UaL4ALc1dQP1D8oFuFQGSawg954FkcFfD2mbVOSN8
	hgUaUGlE+/a4+1Yvb5mUmlir6jeMRLQx9Vk5a4Zr6a0A6m6ZA7VZ7LklRk2uBHLkM4dwbQQ==
X-Received: by 2002:a17:90b:3d85:b0:2ee:693e:ed7a with SMTP id 98e67ed59e1d1-3111127fb1cmr17435570a91.35.1748315102160;
        Mon, 26 May 2025 20:05:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3jv5K/Z7dq5ehuWkg9ElaTpmRvQQeUzgab/qTcA8XkDEYx7Wjxdqglg90yZZvVagVdTNCR0ifPiaapn1fUjU=
X-Received: by 2002:a17:90b:3d85:b0:2ee:693e:ed7a with SMTP id
 98e67ed59e1d1-3111127fb1cmr17435539a91.35.1748315101780; Mon, 26 May 2025
 20:05:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747822866.git.pabeni@redhat.com> <f85bc2d08dfd1a686b1cd102977f615aa07b3190.1747822866.git.pabeni@redhat.com>
 <CACGkMEv=XnqKDXCEitEOs-AL1g=H=7WiHEaHrMUN-RfKN1JCRg@mail.gmail.com> <53242a04-ef11-4d5b-9c7e-7a34f7ad4274@redhat.com>
In-Reply-To: <53242a04-ef11-4d5b-9c7e-7a34f7ad4274@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 May 2025 11:04:49 +0800
X-Gm-Features: AX0GCFu25mCCFbbK3UDGPHKm7yR5Z4_EihPO1zsnDSZF9hKnv8c9zNDsI2fADsA
Message-ID: <CACGkMEtZZbN8vj-V-PSwAmQKCP=gDN5sDz4TOXcOhNXGPLp_yQ@mail.gmail.com>
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

On Mon, May 26, 2025 at 6:53=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 5/26/25 2:49 AM, Jason Wang wrote:
> > On Wed, May 21, 2025 at 6:33=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >>
> >> The virtio specifications allows for up to 128 bits for the
> >> device features. Soon we are going to use some of the 'extended'
> >> bits features (above 64) for the virtio_net driver.
> >>
> >> Extend the virtio pci modern driver to support configuring the full
> >> virtio features range, replacing the unrolled loops reading and
> >> writing the features space with explicit one bounded to the actual
> >> features space size in word.
> >>
> >> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> >> ---
> >>  drivers/virtio/virtio_pci_modern_dev.c | 39 +++++++++++++++++--------=
-
> >>  1 file changed, 25 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/v=
irtio_pci_modern_dev.c
> >> index 1d34655f6b658..e3025b6fa8540 100644
> >> --- a/drivers/virtio/virtio_pci_modern_dev.c
> >> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> >> @@ -396,12 +396,16 @@ EXPORT_SYMBOL_GPL(vp_modern_remove);
> >>  virtio_features_t vp_modern_get_features(struct virtio_pci_modern_dev=
ice *mdev)
> >>  {
> >>         struct virtio_pci_common_cfg __iomem *cfg =3D mdev->common;
> >> -       virtio_features_t features;
> >> +       virtio_features_t features =3D 0;
> >> +       int i;
> >>
> >> -       vp_iowrite32(0, &cfg->device_feature_select);
> >> -       features =3D vp_ioread32(&cfg->device_feature);
> >> -       vp_iowrite32(1, &cfg->device_feature_select);
> >> -       features |=3D ((u64)vp_ioread32(&cfg->device_feature) << 32);
> >> +       for (i =3D 0; i < VIRTIO_FEATURES_WORDS; i++) {
> >> +               virtio_features_t cur;
> >> +
> >> +               vp_iowrite32(i, &cfg->device_feature_select);
> >> +               cur =3D vp_ioread32(&cfg->device_feature);
> >> +               features |=3D cur << (32 * i);
> >> +       }
> >
> > No matter if we decide to go with 128bit or not. I think at the lower
> > layer like this, it's time to allow arbitrary length of the features
> > as the spec supports.
>
> Is that useful if the vhost interface is not going to support it?

I think so, as there are hardware virtio devices that can benefit from this=
.

>
> Note that the above code is independent from the feature-space. Defining
> larger value of VIRTIO_FEATURES_WORDS it will deal with larger number of
> features.
>
> /P
>

Thanks


