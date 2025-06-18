Return-Path: <netdev+bounces-198861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF0BADE0D8
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 03:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A6053A944A
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 01:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E30155A25;
	Wed, 18 Jun 2025 01:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FeXFlZvS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1715D38DF9
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 01:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750211517; cv=none; b=ACYgtYIbjMVLh8894tE2sBX8jXonxMtnADBgtvrN0rq9+EsJOk9zDhnP7QAJG35LdRWH9sT5vzyQFNDep4CZ01m2h4cKDq5TOpfuVndNEOpkRGIwTYGq2yXIrdC2iMOaTDxWOf3M8YDAYplJNrQ8blIGXq6Tsspr+ghI178K6IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750211517; c=relaxed/simple;
	bh=1UwVHkms6cAfLZ+SfcTQ93klZYMPYtI+k8BphCk8hCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fsVAY/9ECHgzwnY/a/cPD52lRzFkMYnf1YgjZjBzutJIv0oAzdK+twyXZXj+tfKJz4Jzk+xhHY+pIavKPeKP3JcxfQnXqYYkM9Cd2/5PWpAGavqdLuX0Afx7glQWkqiFrQwGYxIODZ+pc/yYNR2UjWnEz1B2y6mpVKEFN86yXCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FeXFlZvS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750211514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/VVYBdiqC6Rj7wkZGRuR/VPQeG4Z+BkaHbpybW6CJQ4=;
	b=FeXFlZvS2ULkZ3oOf89f8if69Cjiga2AchxWV9/0uCG9609UdLIxgjuOEiuPVoMIOKqqmu
	X19WMZFQoJpOt6fs+evsiUYgSfO7wZOH+6+X2Uxt655utQACtlKY86TGjYbkNqWnUbBKRU
	34Ebzo0wmukVXIB2r6/MdsKgy5/DZ+g=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-UurwVMg8MlaWRlBzC0AbSQ-1; Tue, 17 Jun 2025 21:51:52 -0400
X-MC-Unique: UurwVMg8MlaWRlBzC0AbSQ-1
X-Mimecast-MFC-AGG-ID: UurwVMg8MlaWRlBzC0AbSQ_1750211511
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7425efba1a3so347073b3a.0
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 18:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750211511; x=1750816311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/VVYBdiqC6Rj7wkZGRuR/VPQeG4Z+BkaHbpybW6CJQ4=;
        b=nJE9oIbI+kA+/eQQn0Ej1t5WG8HgrWfwMG7ToEI2TxIMWQl9Roe+Qb+Jsm1yfMQxg9
         I8U3AYvyoMWwN1Zzt6Y+TTc6LcG4cPkrSRBiKPhNZTzu0pA4ZjQHdqPS008H1Qotv2Sy
         Q0ztOCsqPumcYqUzpIVPPpMbek/bZgAsUsBkW0VVddCHj0OMYmyedro1rgc30LorCJ6e
         miBLFzhH0ETUWI0XnACKcrzOlyk61ri28EKrq3qSsKPmbezVs84v8oXVW8xaeUtlTBm6
         qP4UcobY1hQjeqaXCUwYfrRKYWo7K6+eeZNFisLXOOLITjPtt4mEkLm88+MR44BcusQF
         nBCw==
X-Gm-Message-State: AOJu0Yy+1uOzZsKbn0+6fyAUMwG1Ojxj/Iay6GgFdoj7YIgOv3O0wJAW
	heFixaz1rwZLNZc88vLJAVQwV1BIZRNVF2emjahLMA4Q+sLRflzz/hU1x0Y+Rhbf8vD3f5XqYnv
	LiFuCw3gdZh8pKnlx1u/jIo+q5zrIlGERJXwKEKltXPhXFAlIA7YBF8sP10Ht8/QEV1/6YxcObR
	FxKdIrQPLn1i8a8XzZ1dhDyDkSL9M8cjxM
X-Gm-Gg: ASbGnctlxLM/6RrrGcpwug1DHh7/ilLzWpzt1B3/BdEhMw6h1PCqdMl6ZWwyxTjoZpn
	DUxF93acUM9BXBB6Devtp7b4gUjRugEJHzbHB7LULU8mIn6iA/tr/9NwVVah5VO4qiL2DH0CF4O
	KxsNr0
X-Received: by 2002:a05:6a00:181f:b0:736:3ea8:4813 with SMTP id d2e1a72fcca58-748e6ec3cc2mr1185068b3a.2.1750211511354;
        Tue, 17 Jun 2025 18:51:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFH4tKFlAA504kXN+aqTWawSzA9c7zTrFbTP3Xcebu1gtOw98UwkfTLX1AxPrQdDmwnjdKD/ksg+Gzs8MUT5o=
X-Received: by 2002:a05:6a00:181f:b0:736:3ea8:4813 with SMTP id
 d2e1a72fcca58-748e6ec3cc2mr1185034b3a.2.1750211510840; Tue, 17 Jun 2025
 18:51:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750176076.git.pabeni@redhat.com> <2d17ac04283e0751c6a8e8dbda509dcc1237490f.1750176076.git.pabeni@redhat.com>
In-Reply-To: <2d17ac04283e0751c6a8e8dbda509dcc1237490f.1750176076.git.pabeni@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 18 Jun 2025 09:51:39 +0800
X-Gm-Features: AX0GCFsiw-yCrzYiqsHOxwUpZXnJNh9kMEk2_eFa8fat6T7A4X8MOZiU3BB-HqM
Message-ID: <CACGkMEv8b33EeMuHU03EGByumHRMhT3C6_Xeq_Lig=gjroofRg@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 1/8] virtio: introduce extended features
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 12:12=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> The virtio specifications allows for up to 128 bits for the
> device features. Soon we are going to use some of the 'extended'
> bits features (above 64) for the virtio_net driver.
>
> Introduce extended features as a fixed size array of u64. To minimize
> the diffstat allows legacy driver to access the low 64 bits via a
> transparent union.
>
> Introduce an extended get_extended_features configuration callback
> that devices supporting the extended features range must implement in
> place of the traditional one.
>
> Note that legacy and transport features don't need any change, as
> they are always in the low 64 bit range.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v3 -> v4:
>   - moved bit sanity check in virtio_features_*
>   - replaced BUG_ON with WARN_ON_ONCE
>   - *_and_not -> _andnot
>   - short circuit features comparison
> v2 -> v3:
>   - uint128_t -> u64[2];
> v1 -> v2:
>   - let u64 VIRTIO_BIT() cope with higher bit values
>   - add .get_features128 instead of changing .get_features signature
> ---
>  drivers/virtio/virtio.c         | 43 +++++++++-------
>  drivers/virtio/virtio_debug.c   | 27 +++++-----
>  include/linux/virtio.h          |  5 +-
>  include/linux/virtio_config.h   | 41 +++++++--------
>  include/linux/virtio_features.h | 88 +++++++++++++++++++++++++++++++++
>  5 files changed, 151 insertions(+), 53 deletions(-)
>  create mode 100644 include/linux/virtio_features.h
>
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 95d5d7993e5b..5c48788cdbec 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -53,7 +53,7 @@ static ssize_t features_show(struct device *_d,
>
>         /* We actually represent this as a bitstring, as it could be
>          * arbitrary length in future. */
> -       for (i =3D 0; i < sizeof(dev->features)*8; i++)
> +       for (i =3D 0; i < VIRTIO_FEATURES_MAX; i++)
>                 len +=3D sysfs_emit_at(buf, len, "%c",
>                                __virtio_test_bit(dev, i) ? '1' : '0');
>         len +=3D sysfs_emit_at(buf, len, "\n");
> @@ -272,22 +272,22 @@ static int virtio_dev_probe(struct device *_d)
>         int err, i;
>         struct virtio_device *dev =3D dev_to_virtio(_d);
>         struct virtio_driver *drv =3D drv_to_virtio(dev->dev.driver);
> -       u64 device_features;
> -       u64 driver_features;
> +       u64 device_features[VIRTIO_FEATURES_DWORDS];
> +       u64 driver_features[VIRTIO_FEATURES_DWORDS];
>         u64 driver_features_legacy;
>
>         /* We have a driver! */
>         virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER);
>
>         /* Figure out what features the device supports. */
> -       device_features =3D dev->config->get_features(dev);
> +       virtio_get_features(dev, device_features);
>
>         /* Figure out what features the driver supports. */
> -       driver_features =3D 0;
> +       virtio_features_zero(driver_features);
>         for (i =3D 0; i < drv->feature_table_size; i++) {
>                 unsigned int f =3D drv->feature_table[i];
> -               BUG_ON(f >=3D 64);
> -               driver_features |=3D (1ULL << f);
> +               if (!WARN_ON_ONCE(f >=3D VIRTIO_FEATURES_MAX))

Nit: Any reason why switching to use WARN_ON_ONCE()?

Other than this.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


