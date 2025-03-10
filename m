Return-Path: <netdev+bounces-173412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB84EA58B3F
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 05:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F1877A2B91
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 04:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F8D1C3BEB;
	Mon, 10 Mar 2025 04:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qz2L6pUF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035861B87F0
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 04:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741581847; cv=none; b=pR+97vXEue6xTb7xfxAXF0o6OsCa0TkqNTeu/tbSWwU43tryD18pKdLdOhXuKb+M+69xsK1zmHhJKtQ6NVvW5i2kmU4FeKRa96HVzPQ1vAHpTOQEWiKr7g+52gnxPwqE8SR27z8fZbWgm17lMONqTlMM6qPB5DV9wSmaRW1583w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741581847; c=relaxed/simple;
	bh=pnQvGp7bnGzzq9tz0+YpYB/XyZel5rpIl6e/BWSRiQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a7V+9Z14Otn5nM1zGFKhJ3+V+R+06V+Dj1eTqfmijfaELCloXrEYrbbx1RDybQDZvrqelgWn66Sv18w/NlsUHfjXjuhVGZcj1m8YTlE3+OA+zO+ha4+UZzyBp03B5uoSmpysuBfpYjXPKnYABhHzcJ3Qm8AZgA0g8DtMSsKpo+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qz2L6pUF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741581845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nev8trpbSnvGVyf58rmxXxAuQy7W5eOvjY/xcGE3UB8=;
	b=Qz2L6pUF+9M/b+8P9rH3/VAW6/UJyf2JSahFqCOszcOOUfrt4TLgWXZF3Z7p1qxVrdM+O8
	oM5agPxJqnkuKmCYyAK3ZfKBFMXH1O1nH8BnERDXTlnP7LZ4QXSyyYgjFhOhrG0dUgGDsu
	VwZHLMPMELx7gremS0WCYDPWyXw+Uv4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-mAoVTTJNNvO_2qpIjKC6Bg-1; Mon, 10 Mar 2025 00:44:03 -0400
X-MC-Unique: mAoVTTJNNvO_2qpIjKC6Bg-1
X-Mimecast-MFC-AGG-ID: mAoVTTJNNvO_2qpIjKC6Bg_1741581842
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff64898e2aso6059557a91.1
        for <netdev@vger.kernel.org>; Sun, 09 Mar 2025 21:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741581842; x=1742186642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nev8trpbSnvGVyf58rmxXxAuQy7W5eOvjY/xcGE3UB8=;
        b=t55v5Rsh1tvNutMrUonLOkJVv4FHdZfCx+wFyfP/uQZQv4oH9jj7KsVxDfjNWI3w4Q
         3iACYBti8igtgIjJ4vGvXdRl2FJXtfWoK+y4V5AZNhh+nUeMcjABRHOFAYE6xEqRsGIp
         9ukRCvAMC8qrsTuXrp5lr++EViWkqOWqQeqc3OiDx4VJOWDx7sCh6eP8BcQbeegL+j/5
         bxj4GUxCcaRMGJSl4arhte/GsveGokD90fJxtqe1CiAm7FKnALKeoKvA4eKmfd8lHw8y
         4ZE37JlXH7Dftb/7OJ/8NNZ85jsg5ovcxGjpB2dUOw/WGpRroo2XVErNkfWSa6F8U9oX
         YAkQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7YZFuXejbtHNh/ZGDM42Phx6RdkWyWj/ZKnIZtjvpc51uOSiFP4S8jFnnYQj/cLdd0Eak9i4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3CeXjyhke9hUJGjsdxG3Z6hFBrC5ZjaNBN/6T0xx1LluTdeXm
	Jyxc/N4TUXGcbXIkx12Sm+21/yNCA58gE6OLu4Cq3hx7P6zb4P3G1eDxy6wZvYo6KsIvJc+OPdK
	a9eVFpEz7a8dOzoMfg+UWNgNrocBXNPOA+0yRsnc6jlivYAovAhPoImX3JnDMo8JDv2IR1dDFZp
	mHpYWrfXIXwYyeYaiWkJ0X66yhVgl9
X-Gm-Gg: ASbGnctskyEmWVWWb0kIdZtb/NAiA7h2PH3k2nNyMwC1cE4TU5/I1wGOO7BqqQCnA1+
	mCcnxf3qBdpe636qVQf5GRQSq5VmlVh4IpRtaYCdMkSnm095dKm8WcgT3xK4mipXjnc05qv/fyQ
	==
X-Received: by 2002:a17:90b:3942:b0:2fa:17e4:b1cf with SMTP id 98e67ed59e1d1-2ffbc1478f7mr13296305a91.2.1741581841799;
        Sun, 09 Mar 2025 21:44:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8596SYY1uEmihx+dPY4+l8IPJzpuHXJkSLoctuIwB7FVBBOLd5nfEBl/a/ZkxNYUOiGzN8PvHZYIw/V0LgT0=
X-Received: by 2002:a17:90b:3942:b0:2fa:17e4:b1cf with SMTP id
 98e67ed59e1d1-2ffbc1478f7mr13296259a91.2.1741581841334; Sun, 09 Mar 2025
 21:44:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-rss-v9-0-df76624025eb@daynix.com> <20250307-rss-v9-6-df76624025eb@daynix.com>
In-Reply-To: <20250307-rss-v9-6-df76624025eb@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 10 Mar 2025 12:43:50 +0800
X-Gm-Features: AQ5f1JphlQ4HfYrWzbh5cl4IywdRmeziUaHOc-Ga-IvwGUrEMgYGcXCVclvp0A0
Message-ID: <CACGkMEuccQ6ah-aZ3tcW1VRuetEoPA_NaLxLT+9fb0uAab8Agg@mail.gmail.com>
Subject: Re: [PATCH net-next v9 6/6] vhost/net: Support VIRTIO_NET_F_HASH_REPORT
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
	Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 7:02=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> VIRTIO_NET_F_HASH_REPORT allows to report hash values calculated on the
> host. When VHOST_NET_F_VIRTIO_NET_HDR is employed, it will report no
> hash values (i.e., the hash_report member is always set to
> VIRTIO_NET_HASH_REPORT_NONE). Otherwise, the values reported by the
> underlying socket will be reported.
>
> VIRTIO_NET_F_HASH_REPORT requires VIRTIO_F_VERSION_1.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Tested-by: Lei Yang <leiyang@redhat.com>
> ---
>  drivers/vhost/net.c | 49 +++++++++++++++++++++++++++++------------------=
--
>  1 file changed, 29 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index b9b9e9d40951856d881d77ac74331d914473cd56..16b241b44f89820a42c302f35=
86ea6bb5e0d4289 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -73,6 +73,7 @@ enum {
>         VHOST_NET_FEATURES =3D VHOST_FEATURES |
>                          (1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
>                          (1ULL << VIRTIO_NET_F_MRG_RXBUF) |
> +                        (1ULL << VIRTIO_NET_F_HASH_REPORT) |
>                          (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
>                          (1ULL << VIRTIO_F_RING_RESET)
>  };
> @@ -1097,9 +1098,11 @@ static void handle_rx(struct vhost_net *net)
>                 .msg_controllen =3D 0,
>                 .msg_flags =3D MSG_DONTWAIT,
>         };
> -       struct virtio_net_hdr hdr =3D {
> -               .flags =3D 0,
> -               .gso_type =3D VIRTIO_NET_HDR_GSO_NONE
> +       struct virtio_net_hdr_v1_hash hdr =3D {
> +               .hdr =3D {
> +                       .flags =3D 0,
> +                       .gso_type =3D VIRTIO_NET_HDR_GSO_NONE
> +               }
>         };
>         size_t total_len =3D 0;
>         int err, mergeable;
> @@ -1110,7 +1113,6 @@ static void handle_rx(struct vhost_net *net)
>         bool set_num_buffers;
>         struct socket *sock;
>         struct iov_iter fixup;
> -       __virtio16 num_buffers;
>         int recv_pkts =3D 0;
>
>         mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_RX);
> @@ -1191,30 +1193,30 @@ static void handle_rx(struct vhost_net *net)
>                         vhost_discard_vq_desc(vq, headcount);
>                         continue;
>                 }
> +               hdr.hdr.num_buffers =3D cpu_to_vhost16(vq, headcount);
>                 /* Supply virtio_net_hdr if VHOST_NET_F_VIRTIO_NET_HDR */
>                 if (unlikely(vhost_hlen)) {
> -                       if (copy_to_iter(&hdr, sizeof(hdr),
> -                                        &fixup) !=3D sizeof(hdr)) {
> +                       if (copy_to_iter(&hdr, vhost_hlen,
> +                                        &fixup) !=3D vhost_hlen) {
>                                 vq_err(vq, "Unable to write vnet_hdr "
>                                        "at addr %p\n", vq->iov->iov_base)=
;
>                                 goto out;

Is this an "issue" specific to RSS/HASH? If it's not, we need a separate pa=
tch.

Honestly, I'm not sure if it's too late to fix this.

Others look fine.

Thanks


