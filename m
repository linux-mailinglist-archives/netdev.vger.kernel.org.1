Return-Path: <netdev+bounces-193296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 305B7AC3784
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 03:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C7113A8E1C
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 01:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1477263B;
	Mon, 26 May 2025 01:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YBW95YP+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132AC2DCBF0
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 01:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748221299; cv=none; b=CtcC0+8d/PP4AD+X/y7mXenMVbYFGU3m9lNCpsHgBVK6ct6314axWy1Z7gJao97BbjBl2OonT624EJRp3Q2oKKwUyqouL4aTsrLnllLfQoa45odEDSDXC3JGzln02B9/VvWqL3wpVxFR9SlRuiXGRyMLLKz42C4Jo0vDM6pC9JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748221299; c=relaxed/simple;
	bh=RmqtJi9O9dDXs2xLYtNp6TeV/mwYFoPHGV9swyUzXx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fxsFtHwhlbCozgKS2DWJXxF/snccDTBghwnTMY/q6mZl1iO/1Q1SnH/BQeTjxWmjwrCJ6GcsFcvlO4VFv3zgX6fu/EdnDNtNqjIW4mmQqMfj3qaabfDj7kB7utycK2YCMv+4hFzvyaG7989oojeCAwpNiU5Z6klspQN+PBW/WgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YBW95YP+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748221296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6bIhoSHw0pFZp+C3Py0htPUyQCgYiJSsLKssUNyY3gM=;
	b=YBW95YP++K2E0GLj+Ak01hBFRX8Gr+kUdGJhYMEkddSpIJTRdyxY1lJM1HD0l7EEWM6p5D
	iO6M/JEumhOzUl+q6O+MtZbiuA5rnXZVyC0CpZaBvVt6UX59mnHA69lu+tx+WRfHo9Gz4a
	wduK9dPhLrBzMFF1qAi8LSRhuOR7rU0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-k7r6NtPoNWaA29qkQRsb5g-1; Sun, 25 May 2025 21:01:35 -0400
X-MC-Unique: k7r6NtPoNWaA29qkQRsb5g-1
X-Mimecast-MFC-AGG-ID: k7r6NtPoNWaA29qkQRsb5g_1748221294
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3113a29e1fdso1479984a91.3
        for <netdev@vger.kernel.org>; Sun, 25 May 2025 18:01:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748221294; x=1748826094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6bIhoSHw0pFZp+C3Py0htPUyQCgYiJSsLKssUNyY3gM=;
        b=ETX1Uj7wWsDW4kjDEI4jz6asIKcJqtmMBiZ/v4wT46v8An1ctMm0ll4AVInXxZPuO2
         4Kg754hLYHu9zIUX5BJixTFe1AiqtA2WxkUAZWfGIOQZy3AAbiJYud22XowOmNCRuhHb
         1nYtP47UWnbr/Ml8WkFQtHuvTx0hNZItgnjaDiZYjAKtU28x/r6eYkdujDtAz3RtjOp/
         MCwmsstmiWVFnqV1Fr7Y+IXxKTXcYLzwOG0ErzocW3tUo2mxa6q/BKLuwN+nMN1zMDDD
         P2/BwyEbbOCsJL7bLYc58TwGnuVBgo6ieyCY4GOolDdGmLwLQBZWf0XyWKtwh8Tk6Pde
         p43g==
X-Gm-Message-State: AOJu0Yx7H1gdInEUpDNxrwlBdqBgke6pFI0mhVgH/lUKCzbC0xtq2/Rv
	EB0SdpCNb7uCgDvpnSXbTwVaDDBKZiFMKQoNUPXv9QiiXNKNH9rS/qDPKyKauD6AERycRkH1Bpy
	9TC9G8n4/RLYCPa1xXiI4a5qNCPQk1Q2PsBkRM8xIgQqDt63cj44XFYFBiYZAPdnFMOGPxD0r0u
	sLg8kKI4oBuDqu5cVIfeRQDvGNexKo6m0r
X-Gm-Gg: ASbGncsV4M9/jha+wWA8uR0fyp12xkSswzdbZmc7k6WMQrEl3UvrQtsX2ntlm1y/Saa
	ZAhhOcim2IYmVqPDKAu+qtkb6wekB5ZsTdv2JzeJrc0gAm5xF7myomUcZfrT07xL/c+vjIA==
X-Received: by 2002:a17:90b:35c8:b0:310:8d9a:95b6 with SMTP id 98e67ed59e1d1-31111d3eee4mr10536694a91.25.1748221294368;
        Sun, 25 May 2025 18:01:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGta3emAQIMx9O+jOAvzRqGVJ7S4JzamBI9Qw81QlvwhhyvICQybKsO++IdAqFvEiWj1HCuil2uOaLwBUUmuIo=
X-Received: by 2002:a17:90b:35c8:b0:310:8d9a:95b6 with SMTP id
 98e67ed59e1d1-31111d3eee4mr10536643a91.25.1748221293922; Sun, 25 May 2025
 18:01:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747822866.git.pabeni@redhat.com> <4000eafb3dc20b225aa6626f4af8c2df894bb465.1747822866.git.pabeni@redhat.com>
In-Reply-To: <4000eafb3dc20b225aa6626f4af8c2df894bb465.1747822866.git.pabeni@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 May 2025 09:01:21 +0800
X-Gm-Features: AX0GCFtiAEMV66kAhlBuiscjKjbVOXTmePJNEYXPKA4z2IHw-w3SuAJ5IXqfC8A
Message-ID: <CACGkMEtfzcCzdCCFWKup2d417_OtpBgiWRf2bu1Qh=SQnD7Jcw@mail.gmail.com>
Subject: Re: [PATCH net-next 4/8] virtio_net: add supports for extended offloads
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 6:33=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> The virtio_net driver needs it to implement GSO over UDP tunnel
> offload.
>
> The only missing piece is mapping them to/from the extended
> features.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  drivers/net/virtio_net.c | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e53ba600605a5..71a972f20f19b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -35,6 +35,29 @@ module_param(csum, bool, 0444);
>  module_param(gso, bool, 0444);
>  module_param(napi_tx, bool, 0644);
>
> +#define VIRTIO_OFFLOAD_MAP_MIN 46
> +#define VIRTIO_OFFLOAD_MAP_MAX 49
> +#define VIRTIO_FEATURES_MAP_MIN        65
> +#define VIRTIO_O2F_DELTA       (VIRTIO_FEATURES_MAP_MIN - VIRTIO_OFFLOAD=
_MAP_MIN)

Instead of doing this, I wonder if it's simple to just have an array
for the mapping from all guest offload features to guest controllable
offload bits?

> +
> +static bool virtio_is_mapped_offload(unsigned int obit)
> +{
> +       return obit >=3D VIRTIO_OFFLOAD_MAP_MIN &&
> +              obit <=3D VIRTIO_OFFLOAD_MAP_MAX;
> +}
> +
> +#define VIRTIO_FEATURE_TO_OFFLOAD(fbit)        \
> +       ({                                                              \
> +               unsigned int __f =3D fbit;                               =
 \
> +               __f >=3D VIRTIO_FEATURES_MAP_MIN ? __f - VIRTIO_O2F_DELTA=
 : __f; \
> +       })
> +#define VIRTIO_OFFLOAD_TO_FEATURE(obit)        \
> +       ({                                                              \
> +               unsigned int __o =3D obit;                               =
 \
> +               virtio_is_mapped_offload(__o) ? __o + VIRTIO_O2F_DELTA :\
> +                                               __o;                    \
> +       })
> +
>  /* FIXME: MTU in config. */
>  #define GOOD_PACKET_LEN (ETH_HLEN + VLAN_HLEN + ETH_DATA_LEN)
>  #define GOOD_COPY_LEN  128
> @@ -7037,9 +7060,13 @@ static int virtnet_probe(struct virtio_device *vde=
v)
>                 netif_carrier_on(dev);
>         }
>
> -       for (i =3D 0; i < ARRAY_SIZE(guest_offloads); i++)
> -               if (virtio_has_feature(vi->vdev, guest_offloads[i]))
> +       for (i =3D 0; i < ARRAY_SIZE(guest_offloads); i++) {
> +               unsigned int fbit;
> +
> +               fbit =3D VIRTIO_OFFLOAD_TO_FEATURE(guest_offloads[i]);
> +               if (virtio_has_feature(vi->vdev, fbit))
>                         set_bit(guest_offloads[i], &vi->guest_offloads);
> +       }
>         vi->guest_offloads_capable =3D vi->guest_offloads;
>
>         rtnl_unlock();
> --
> 2.49.0
>

Thanks


