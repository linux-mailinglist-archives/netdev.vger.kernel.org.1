Return-Path: <netdev+bounces-193293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C88D7AC377E
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 02:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 871333AFB5E
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 00:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EE028373;
	Mon, 26 May 2025 00:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YE2Bs9BO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEA42110E
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 00:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748220592; cv=none; b=mzRdZ8VXEM5MTjC0Xa2H7TvFi/1luySYR+1nbfxwLh/iGGnR9A6tylkXVGuJjeQq7tv5xrm4cdgWqK6GfKq/oXTA44Jp7mzCLgLcGSkg3b0MgT8PRn8gv0RO5I3FPHPFEf2Vv/Rbnt5FM94/mhMKBOols4gf3JZuE6/xM6SM7qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748220592; c=relaxed/simple;
	bh=TEh5UaOkj1Og3Zeb10zHKYFB6aYQuQh0JI35Cd7tsfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n5FOSnSoc257tQXukw41HirvjPuy2P82KhoPVXogFBF6K8N6QSIFJzEg3jA1Lc4xW/Td+YxzGITwiuUQVO7q/AAttKqEpC9FAcxuYR4BILrS62R1BGN6p4r3sNib7+wPqgcwAVloCmlZhGNKN4qjWpkByoeGh3iXEabuicsaU9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YE2Bs9BO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748220589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VCjzNnurfzkblmvChblaHlafpgMLirqOMGRPqAC+goI=;
	b=YE2Bs9BOxhvYu9dOktgWzi+RA7v5j9chsMM3/hhYtMlEDxFObPJmErebyjZrOs8pjQS1g6
	cvfBFC9S2xuOZItz4OZNSD1n33ZpsKIDOQP3DKYPyuXwborxSyK7buQHudzq6UuYlGC0xQ
	DfVdJPVhA75/GFhX4zRscv/nQkYSIkE=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-6YMV8jStNPCe5wEFZ8oD1w-1; Sun, 25 May 2025 20:49:48 -0400
X-MC-Unique: 6YMV8jStNPCe5wEFZ8oD1w-1
X-Mimecast-MFC-AGG-ID: 6YMV8jStNPCe5wEFZ8oD1w_1748220587
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b26db9af463so1835101a12.2
        for <netdev@vger.kernel.org>; Sun, 25 May 2025 17:49:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748220587; x=1748825387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VCjzNnurfzkblmvChblaHlafpgMLirqOMGRPqAC+goI=;
        b=FTiK8HoRO0lyouzvtmjvERaa1kuh4FWoBEsPGaQ8dCWnNodhwehFSNT0zGe8jyUHno
         RxemI5QHSLd7zg08Q78Rw+isM7c9OOezzOey6d2vqKpGoljwFLrb920eueYkNakrPPtM
         cJL/xRVqdJFJT55Yr3539oQ4RsTwFM+ao4g1AALDi/j+q5t2iBOpzy3mHkwt18j0s0at
         EUA4EykCNkZZMT1amzdSdzM2+9YUZ1lYqNoDjasXPW7K+g7+iY3u+NwcfD/yiG25/tt1
         4Sp+vHpLAv7/NQ9hjeiErHcFDdmQ+jDZ3pUZJXeBn5FMXjYZo3Ac27d03SpzTSaFdbQx
         YyjQ==
X-Gm-Message-State: AOJu0Yw3uJlgT+QlitgAgjZ4t4UMjEBPAfzKcvQuTlmf07UDf9ONBJqG
	7CwFNnrgQFQ8AHJXjLi1yG9+AApGBf1y/8mLEsnp2+tlZNFzuNufXTdgnVdZULRzXNpuWyd07qy
	hjD7rkwNzZjEe5aIcJtmSR9i4TPp5LOhfB3EUy5phIGnwZl0KOHV2Jf/I7sAAqaHD9T9tF9/jFJ
	hUWWZIFqgAnkPGh79BPSMH+tWaVo94Zrz2
X-Gm-Gg: ASbGnctl4Eje2++QGhDIliMfXtMy2+kJQvjEKCiU30XbT6RX538uQj2yi3JNn0QaA8d
	cLI491CvA9Pn5IUYEuETaeR6TkJmzzxRgGby3EVTkZ/ajD/nKHddzV5IzMiyBco9rmSn6mw==
X-Received: by 2002:a05:6a20:c916:b0:1f5:8a1d:3905 with SMTP id adf61e73a8af0-2188c20011dmr10968851637.7.1748220587456;
        Sun, 25 May 2025 17:49:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbId/oFgmmrrUtuDMUcDOnfWHDXv2EhOSFCceBaNynMvPlNGv8N+tLsyHaVlYvKwx2iEn1BUFdt20jypwrgao=
X-Received: by 2002:a05:6a20:c916:b0:1f5:8a1d:3905 with SMTP id
 adf61e73a8af0-2188c20011dmr10968829637.7.1748220587130; Sun, 25 May 2025
 17:49:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747822866.git.pabeni@redhat.com> <f85bc2d08dfd1a686b1cd102977f615aa07b3190.1747822866.git.pabeni@redhat.com>
In-Reply-To: <f85bc2d08dfd1a686b1cd102977f615aa07b3190.1747822866.git.pabeni@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 May 2025 08:49:35 +0800
X-Gm-Features: AX0GCFvgzS48D9ZmvkNWckHoO-4AcviPx7yhc3B0iEzAsfCNHm-vUH13zDz5jWs
Message-ID: <CACGkMEv=XnqKDXCEitEOs-AL1g=H=7WiHEaHrMUN-RfKN1JCRg@mail.gmail.com>
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

On Wed, May 21, 2025 at 6:33=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> The virtio specifications allows for up to 128 bits for the
> device features. Soon we are going to use some of the 'extended'
> bits features (above 64) for the virtio_net driver.
>
> Extend the virtio pci modern driver to support configuring the full
> virtio features range, replacing the unrolled loops reading and
> writing the features space with explicit one bounded to the actual
> features space size in word.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  drivers/virtio/virtio_pci_modern_dev.c | 39 +++++++++++++++++---------
>  1 file changed, 25 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virt=
io_pci_modern_dev.c
> index 1d34655f6b658..e3025b6fa8540 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -396,12 +396,16 @@ EXPORT_SYMBOL_GPL(vp_modern_remove);
>  virtio_features_t vp_modern_get_features(struct virtio_pci_modern_device=
 *mdev)
>  {
>         struct virtio_pci_common_cfg __iomem *cfg =3D mdev->common;
> -       virtio_features_t features;
> +       virtio_features_t features =3D 0;
> +       int i;
>
> -       vp_iowrite32(0, &cfg->device_feature_select);
> -       features =3D vp_ioread32(&cfg->device_feature);
> -       vp_iowrite32(1, &cfg->device_feature_select);
> -       features |=3D ((u64)vp_ioread32(&cfg->device_feature) << 32);
> +       for (i =3D 0; i < VIRTIO_FEATURES_WORDS; i++) {
> +               virtio_features_t cur;
> +
> +               vp_iowrite32(i, &cfg->device_feature_select);
> +               cur =3D vp_ioread32(&cfg->device_feature);
> +               features |=3D cur << (32 * i);
> +       }

No matter if we decide to go with 128bit or not. I think at the lower
layer like this, it's time to allow arbitrary length of the features
as the spec supports.

Thanks


