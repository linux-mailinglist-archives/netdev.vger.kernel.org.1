Return-Path: <netdev+bounces-198867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC4CADE112
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 04:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0798B189B74D
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 02:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536E619F135;
	Wed, 18 Jun 2025 02:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="baJoSNnq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67686C2EF
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 02:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750213660; cv=none; b=NNqntusvWZd9Ztk15J9Y5lvw278Vw2CzBgCAGHo0ny0LcpaezbqzPWPVVH/2M4yvJuqG+38Va0A78otSjIs+8PbvkM//ZvvbrbPSgptjJmPiakJBSAwQwQ0tQEquGKmh7eng2gjKrw2adJqkaEcv//p2nah3RQ3gl12EL4EZKjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750213660; c=relaxed/simple;
	bh=Re45Yl9Xdic3XjzcEkDZFrts/2PBeppPtr99xp7cdcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k6Cwb/FRyeFN7OqYLNL4rXoKxuxC5LMVGwNbZ7/vL6vOdgTG+DOaqDOW4Z0PdQhKCIQY8SOkszk+hh58WJhvrB8ZAfLERYESEe42IJbNRywr2S7U20Z2IBOoW9tEg3pEI9Mtlb+YauEeiGY23uBOu56TKY5aMyvRlljsa2aVdag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=baJoSNnq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750213657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D23fc5Ud+aF2skpnBuEspFcEWYu6NrkHv8kMKlhG5D4=;
	b=baJoSNnqhYlVvWFtsPHvkpkIwTVdq01/0SP+jYdr/Re1+QwVeynMh0ybwxmHawMcr1Ki0Y
	BACledEfh9dxvcviDIzOd5wllBA2Frf2H3Di8e9lc65KsK0Q78rPzr98JRkrnAOlExbUFg
	tOmcnE4SmpwLPvArwt7TUPfeCVfoHbo=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-0s5KcAznMU6wtcs-3I_voA-1; Tue, 17 Jun 2025 22:27:35 -0400
X-MC-Unique: 0s5KcAznMU6wtcs-3I_voA-1
X-Mimecast-MFC-AGG-ID: 0s5KcAznMU6wtcs-3I_voA_1750213655
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b2eeff19115so8104731a12.0
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 19:27:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750213655; x=1750818455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D23fc5Ud+aF2skpnBuEspFcEWYu6NrkHv8kMKlhG5D4=;
        b=N8yP/WIIJ4DSwJjM7aOPoe4JNGxoTTs4fAitX1PrTM1v5PUuoUZ2T5nKUGP7F1Ma8X
         HTqFPY2fBtbJnBIp1zlMq5T1gkeTEcEaaOatFYrmPjgEnlECsqDvfkp3Ecq7VHj5r7c7
         7TSxUZc70C3tfYYQXXuOwPeOdRVQEM4PfWbZC2k8jo5z8Dj31iNR/BgtjEDdmjMRmyCz
         QjcV2sD1M3BzX0rEAEZ+4XGbOx1DV3GOTTyEoEtrmBbZVxGS6a2Tl2yjBcI4CCWJiKXd
         21wmsj7pQHoTby33To8S7WV9eRCchygodv0T+7WGJ/QB13p1lt6zZXVS8ZappVyB0wwH
         p1Hw==
X-Gm-Message-State: AOJu0YxSjQzk74vIkHf2SD4k94sXxUyQtINgaYv0p4r3lY5Gnlq/LK91
	Ax8pARJw00ENR7UyW6NHVkJVHca8cXPVINvbOveJ2E7Sb/2R/jdtI0xELNtVjDObC22L7Ep056z
	vOkIMecLwdu5r5U08+RhLkt68lOixkNKqogcF9D1fT0keT7KSxuwBQcxLPkQlkhEWgfgc8hUEZS
	23crk7a7L5T3G9v93G1F6ad1P5jWuiAHhI
X-Gm-Gg: ASbGncv6QA5Cw13OJLangS1bw8QC2ZhFDe1mX98ZZhVGP2O5rKC/9JjhaSYOTJbVtVr
	Xw+g7RbDkNJRtYgKKrXxVN0zTvXPDx2QRPOZ7d1EL4lpbzrj8Hz0fHyf5nLyR1II31DjyOYKpVt
	nUfg==
X-Received: by 2002:a05:6a21:600b:b0:21f:56d0:65de with SMTP id adf61e73a8af0-21fbd559106mr24786103637.21.1750213654840;
        Tue, 17 Jun 2025 19:27:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/Rf4A1Ru3ctYgfIEBM1X66peLF5yMjY9HuVPXGeqS+TCInW4sIl4LR/UJc0g/yGKE1zhBrw3o6ym9hMKrlhI=
X-Received: by 2002:a05:6a21:600b:b0:21f:56d0:65de with SMTP id
 adf61e73a8af0-21fbd559106mr24786072637.21.1750213654424; Tue, 17 Jun 2025
 19:27:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750176076.git.pabeni@redhat.com> <1382006752c261a7d5ad42a06a365f252a9a0967.1750176076.git.pabeni@redhat.com>
In-Reply-To: <1382006752c261a7d5ad42a06a365f252a9a0967.1750176076.git.pabeni@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 18 Jun 2025 10:27:21 +0800
X-Gm-Features: AX0GCFuvo2JkgrkfB3yvGUg1f98ywANgMMms04TG5YxbXYUz-yNbV8CVxE9gS-w
Message-ID: <CACGkMEuuLn20jWA_SzJxj1j+2AUnONoXc0MqPk6aWbS=kO=+kg@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 2/8] virtio_pci_modern: allow configuring
 extended features
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
> Extend the virtio pci modern driver to support configuring the full
> virtio features range, replacing the unrolled loops reading and
> writing the features space with explicit one bounded to the actual
> features space size in word and implementing the get_extended_features
> callback.
>
> Note that in vp_finalize_features() we only need to cache the lower
> 64 features bits, to process the transport features.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v3 -> v4:
>   - dropped unneeded check in vp_modern_get_features()
>
> v2 -> v3:
>   - virtio_features_t -> u64 *
>
> v1 -> v2:
>   - use get_extended_features
> ---
>  drivers/virtio/virtio_pci_modern.c     | 10 ++--
>  drivers/virtio/virtio_pci_modern_dev.c | 69 +++++++++++++++-----------
>  include/linux/virtio_pci_modern.h      | 43 ++++++++++++++--
>  3 files changed, 84 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_p=
ci_modern.c
> index 7182f43ed055..dd0e65f71d41 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -22,11 +22,11 @@
>
>  #define VIRTIO_AVQ_SGS_MAX     4
>
> -static u64 vp_get_features(struct virtio_device *vdev)
> +static void vp_get_features(struct virtio_device *vdev, u64 *features)
>  {
>         struct virtio_pci_device *vp_dev =3D to_vp_device(vdev);
>
> -       return vp_modern_get_features(&vp_dev->mdev);
> +       vp_modern_get_extended_features(&vp_dev->mdev, features);
>  }
>
>  static int vp_avq_index(struct virtio_device *vdev, u16 *index, u16 *num=
)
> @@ -437,7 +437,7 @@ static int vp_finalize_features(struct virtio_device =
*vdev)
>         if (vp_check_common_size(vdev))
>                 return -EINVAL;
>
> -       vp_modern_set_features(&vp_dev->mdev, vdev->features);
> +       vp_modern_set_extended_features(&vp_dev->mdev, vdev->features_arr=
ay);
>
>         return 0;
>  }
> @@ -1234,7 +1234,7 @@ static const struct virtio_config_ops virtio_pci_co=
nfig_nodev_ops =3D {
>         .find_vqs       =3D vp_modern_find_vqs,
>         .del_vqs        =3D vp_del_vqs,
>         .synchronize_cbs =3D vp_synchronize_vectors,
> -       .get_features   =3D vp_get_features,
> +       .get_extended_features =3D vp_get_features,
>         .finalize_features =3D vp_finalize_features,
>         .bus_name       =3D vp_bus_name,
>         .set_vq_affinity =3D vp_set_vq_affinity,
> @@ -1254,7 +1254,7 @@ static const struct virtio_config_ops virtio_pci_co=
nfig_ops =3D {
>         .find_vqs       =3D vp_modern_find_vqs,
>         .del_vqs        =3D vp_del_vqs,
>         .synchronize_cbs =3D vp_synchronize_vectors,
> -       .get_features   =3D vp_get_features,
> +       .get_extended_features =3D vp_get_features,
>         .finalize_features =3D vp_finalize_features,
>         .bus_name       =3D vp_bus_name,
>         .set_vq_affinity =3D vp_set_vq_affinity,
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virt=
io_pci_modern_dev.c
> index 0d3dbfaf4b23..d665f8f73ea8 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -388,63 +388,74 @@ void vp_modern_remove(struct virtio_pci_modern_devi=
ce *mdev)
>  EXPORT_SYMBOL_GPL(vp_modern_remove);
>
>  /*
> - * vp_modern_get_features - get features from device
> + * vp_modern_get_extended_features - get features from device
>   * @mdev: the modern virtio-pci device
> + * @features: the features array to be filled
>   *
> - * Returns the features read from the device
> + * Fill the specified features array with the features read from the dev=
ice
>   */
> -u64 vp_modern_get_features(struct virtio_pci_modern_device *mdev)
> +void vp_modern_get_extended_features(struct virtio_pci_modern_device *md=
ev,
> +                                    u64 *features)
>  {
>         struct virtio_pci_common_cfg __iomem *cfg =3D mdev->common;
> +       int i;
>
> -       u64 features;
> +       virtio_features_zero(features);
> +       for (i =3D 0; i < VIRTIO_FEATURES_WORDS; i++) {
> +               u64 cur;
>
> -       vp_iowrite32(0, &cfg->device_feature_select);
> -       features =3D vp_ioread32(&cfg->device_feature);
> -       vp_iowrite32(1, &cfg->device_feature_select);
> -       features |=3D ((u64)vp_ioread32(&cfg->device_feature) << 32);
> -
> -       return features;
> +               vp_iowrite32(i, &cfg->device_feature_select);
> +               cur =3D vp_ioread32(&cfg->device_feature);
> +               features[i >> 1] |=3D cur << (32 * (i & 1));

Nit: why not simply cast features to u32 * then everything is simplified.

Others look good.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


