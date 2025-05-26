Return-Path: <netdev+bounces-193291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A44D3AC3779
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 02:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E5823AF9C9
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 00:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7B328691;
	Mon, 26 May 2025 00:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R01H/xVC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB269163
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 00:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748220247; cv=none; b=P3slbNFr9tfQZfOrJnwB0iRDJ6M55gx+pgOqlanGhJVOy1PQHScogw/Yrab1g/gdzj6jL0TZ9lqL5pEYvulChBpx73Q8W4i9gMamIQmO9ZPr9Knym13ZF83t7YIgMvg63Q3p0fCK+uPDwteeskr3zPRr3W6HW+HH8Yj38cYidIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748220247; c=relaxed/simple;
	bh=tBziOrIV7IqNH2bqItxmxNhYPzSljh2RKLI+MNzUgLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gdAVyc5uGgdymP2+ovgbPGC15ps5YjPG+++PlaIYQVlr1QaOwGI+DOMI4GZxtvrt50OCIDHWhy5g8HC6S7Fa451n1PlHAyoI9txgbuYcZI5pgvqg7wAOnF7Ex7xs+tg2+fE3BdpFV7E/25cWZ3NnVEJrHQPyoXpr6vOYfG7jHdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R01H/xVC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748220243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qu8SEhqNnSVm9eQlQX+5EM1hvJ/KMAJ8+EX1YkQ9vng=;
	b=R01H/xVCW73x6sjjYzBlpiTqR8QasBcIC0AYL/kMP/fXEQXkHlG00gRCuuQKNnclU56HYY
	G8SVvdZKcWkl3UHo0CnPLcy8Md1l4rX0BUTVd9b7byxwdzy/m2gFUdfZrOWeXtQ/X97sAy
	GPjLbSCMjBdJnyU4kZxrNUMN1JBWjeU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-zMykVYtEP9emrJTMbi4W3w-1; Sun, 25 May 2025 20:44:02 -0400
X-MC-Unique: zMykVYtEP9emrJTMbi4W3w-1
X-Mimecast-MFC-AGG-ID: zMykVYtEP9emrJTMbi4W3w_1748220241
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3111814d7cbso926968a91.0
        for <netdev@vger.kernel.org>; Sun, 25 May 2025 17:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748220241; x=1748825041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qu8SEhqNnSVm9eQlQX+5EM1hvJ/KMAJ8+EX1YkQ9vng=;
        b=W4HBqBvb244MhBOK6h2Kvw1xX6Lr7V1W5VyPttLecTvg+fPetu07cOEZJn7qzdj3S5
         B9Jr42YpB+i2Cb8lZX6HlNavLtwOUgWU6OtKoFzIohNq6V3ieMM4gdxI9zrcY3JvE4ET
         k2dJJFCTiIZ4M5/TP/6L8+UCszLI5zmRTfXC9puYs8GQKwrR4lkbgpLAuJajM46nENJz
         n01TiZczcNDXN7NpDpoitvf/8nJD8c11uC5Cv0TdtOTQP3TGjwhhMrkk/27rZpiMckWL
         fxjbZ3wxaFtjRh+tTRC21JEIjBs+kDtglyTf4Hr1y53rvNOIlq0G3HYQBLC7lfU5L41S
         IZIA==
X-Gm-Message-State: AOJu0Yx5qRwN3gSeKVt7sb6QBky5vcFpNYBu1WIh9qmpY64BR122rMHS
	Rj7lhqb8k8HRRSR58Bu0XaCUvI7GT6yx5wfgYuPpnlP340/Dvb7WlrvTGj+T66L8HxehpPfxaxC
	IDJ5yidRpkQj8UaKdgGKqbA9uGciaB+xGAlIFekUzoW7ez5TZ8C9ounZUnrKni81L/vCRRGkYNz
	+WmRefgvU7iJ55cPLTS2HZu4RmUNsl24CG
X-Gm-Gg: ASbGncvsxtSSf72EiipZD4qivvERzipszpA0ueXygtkDMp06Jxo5sVM620Jak6n+GeB
	K9uq51OS5TnaFmk8lc1S4rD89pb/y0dtjvy4m9nS24G/qGMx80ckfWt1ZNsSNd/FaLkBorA==
X-Received: by 2002:a17:90b:1d4c:b0:30e:9b31:9495 with SMTP id 98e67ed59e1d1-310e88c4266mr16174669a91.9.1748220240946;
        Sun, 25 May 2025 17:44:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiTQJpBUVlOLtkMyQBhxbZhQJ4u+ewKBoTPyuLJCF+xtOaKembs962WHds9syDwWXTuqq2Vz9MMeOfoH74S2A=
X-Received: by 2002:a17:90b:1d4c:b0:30e:9b31:9495 with SMTP id
 98e67ed59e1d1-310e88c4266mr16174639a91.9.1748220240493; Sun, 25 May 2025
 17:44:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747822866.git.pabeni@redhat.com> <9a1c198245370c3ec403f14d118cd841df0fcfee.1747822866.git.pabeni@redhat.com>
In-Reply-To: <9a1c198245370c3ec403f14d118cd841df0fcfee.1747822866.git.pabeni@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 May 2025 08:43:48 +0800
X-Gm-Features: AX0GCFtfSbnc1lBmHYK4z4gs-f8MC9ZaaCd1W9koEYSC8gRrZiigqu_4e57Hnjs
Message-ID: <CACGkMEtGRK-DmonOfqLodYVqYhUHyEZfrpsZcp=qH7GMCTDuQg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/8] virtio: introduce virtio_features_t
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
> Introduce an specific type to represent the virtio features bitmask.
> On platform where 128 bits integer are available use such wide int
> for the features bitmask, otherwise maintain the current u64.
>
> Updates all the relevant virtio API to use the new type.
>
> Note that legacy and transport features don't need any change, as
> they are always in the low 64 bit range.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  drivers/virtio/virtio.c                | 12 ++++++------
>  drivers/virtio/virtio_mmio.c           |  4 ++--
>  drivers/virtio/virtio_pci_legacy.c     |  2 +-
>  drivers/virtio/virtio_pci_modern.c     |  7 ++++---
>  drivers/virtio/virtio_pci_modern_dev.c | 13 ++++++-------
>  drivers/virtio/virtio_vdpa.c           |  2 +-
>  include/linux/virtio.h                 |  5 +++--
>  include/linux/virtio_config.h          | 22 +++++++++++-----------
>  include/linux/virtio_features.h        | 23 +++++++++++++++++++++++
>  include/linux/virtio_pci_modern.h      | 11 ++++++++---
>  10 files changed, 65 insertions(+), 36 deletions(-)
>  create mode 100644 include/linux/virtio_features.h
>
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 95d5d7993e5b1..542735d3a12ba 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -272,9 +272,9 @@ static int virtio_dev_probe(struct device *_d)
>         int err, i;
>         struct virtio_device *dev =3D dev_to_virtio(_d);
>         struct virtio_driver *drv =3D drv_to_virtio(dev->dev.driver);
> -       u64 device_features;
> -       u64 driver_features;
> -       u64 driver_features_legacy;
> +       virtio_features_t device_features;
> +       virtio_features_t driver_features;
> +       virtio_features_t driver_features_legacy;
>
>         /* We have a driver! */
>         virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER);
> @@ -286,8 +286,8 @@ static int virtio_dev_probe(struct device *_d)
>         driver_features =3D 0;
>         for (i =3D 0; i < drv->feature_table_size; i++) {
>                 unsigned int f =3D drv->feature_table[i];
> -               BUG_ON(f >=3D 64);
> -               driver_features |=3D (1ULL << f);
> +               BUG_ON(f >=3D VIRTIO_FEATURES_MAX);
> +               driver_features |=3D VIRTIO_BIT(f);
>         }
>
>         /* Some drivers have a separate feature table for virtio v1.0 */
> @@ -320,7 +320,7 @@ static int virtio_dev_probe(struct device *_d)
>                 goto err;
>
>         if (drv->validate) {
> -               u64 features =3D dev->features;
> +               virtio_features_t features =3D dev->features;
>
>                 err =3D drv->validate(dev);
>                 if (err)
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 5d78c2d572abf..158c47ac67de7 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -106,10 +106,10 @@ struct virtio_mmio_vq_info {
>
>  /* Configuration interface */
>
> -static u64 vm_get_features(struct virtio_device *vdev)
> +static virtio_features_t vm_get_features(struct virtio_device *vdev)
>  {
>         struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev)=
;
> -       u64 features;
> +       virtio_features_t features;
>
>         writel(1, vm_dev->base + VIRTIO_MMIO_DEVICE_FEATURES_SEL);
>         features =3D readl(vm_dev->base + VIRTIO_MMIO_DEVICE_FEATURES);
> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_p=
ci_legacy.c
> index d9cbb02b35a11..b2fbc74f74b5c 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -18,7 +18,7 @@
>  #include "virtio_pci_common.h"
>
>  /* virtio config->get_features() implementation */
> -static u64 vp_get_features(struct virtio_device *vdev)
> +static virtio_features_t vp_get_features(struct virtio_device *vdev)
>  {
>         struct virtio_pci_device *vp_dev =3D to_vp_device(vdev);
>
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_p=
ci_modern.c
> index d50fe030d8253..c3e0ddc7ae9ab 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -22,7 +22,7 @@
>
>  #define VIRTIO_AVQ_SGS_MAX     4
>
> -static u64 vp_get_features(struct virtio_device *vdev)
> +static virtio_features_t vp_get_features(struct virtio_device *vdev)
>  {
>         struct virtio_pci_device *vp_dev =3D to_vp_device(vdev);
>
> @@ -353,7 +353,8 @@ static void vp_modern_avq_cleanup(struct virtio_devic=
e *vdev)
>         }
>  }
>
> -static void vp_transport_features(struct virtio_device *vdev, u64 featur=
es)
> +static void vp_transport_features(struct virtio_device *vdev,
> +                                 virtio_features_t features)
>  {
>         struct virtio_pci_device *vp_dev =3D to_vp_device(vdev);
>         struct pci_dev *pci_dev =3D vp_dev->pci_dev;
> @@ -409,7 +410,7 @@ static int vp_check_common_size(struct virtio_device =
*vdev)
>  static int vp_finalize_features(struct virtio_device *vdev)
>  {
>         struct virtio_pci_device *vp_dev =3D to_vp_device(vdev);
> -       u64 features =3D vdev->features;
> +       virtio_features_t features =3D vdev->features;
>
>         /* Give virtio_ring a chance to accept features. */
>         vring_transport_features(vdev);
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virt=
io_pci_modern_dev.c
> index 0d3dbfaf4b236..1d34655f6b658 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -393,11 +393,10 @@ EXPORT_SYMBOL_GPL(vp_modern_remove);
>   *
>   * Returns the features read from the device
>   */
> -u64 vp_modern_get_features(struct virtio_pci_modern_device *mdev)
> +virtio_features_t vp_modern_get_features(struct virtio_pci_modern_device=
 *mdev)
>  {
>         struct virtio_pci_common_cfg __iomem *cfg =3D mdev->common;
> -
> -       u64 features;
> +       virtio_features_t features;
>
>         vp_iowrite32(0, &cfg->device_feature_select);
>         features =3D vp_ioread32(&cfg->device_feature);
> @@ -414,11 +413,11 @@ EXPORT_SYMBOL_GPL(vp_modern_get_features);
>   *
>   * Returns the driver features read from the device
>   */
> -u64 vp_modern_get_driver_features(struct virtio_pci_modern_device *mdev)
> +virtio_features_t
> +vp_modern_get_driver_features(struct virtio_pci_modern_device *mdev)
>  {
>         struct virtio_pci_common_cfg __iomem *cfg =3D mdev->common;
> -
> -       u64 features;
> +       virtio_features_t features;
>
>         vp_iowrite32(0, &cfg->guest_feature_select);
>         features =3D vp_ioread32(&cfg->guest_feature);
> @@ -435,7 +434,7 @@ EXPORT_SYMBOL_GPL(vp_modern_get_driver_features);
>   * @features: the features set to device
>   */
>  void vp_modern_set_features(struct virtio_pci_modern_device *mdev,
> -                           u64 features)
> +                           virtio_features_t features)
>  {
>         struct virtio_pci_common_cfg __iomem *cfg =3D mdev->common;
>
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index 1f60c9d5cb181..b92749174885e 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -409,7 +409,7 @@ static int virtio_vdpa_find_vqs(struct virtio_device =
*vdev, unsigned int nvqs,
>         return err;
>  }
>
> -static u64 virtio_vdpa_get_features(struct virtio_device *vdev)
> +static virtio_features_t virtio_vdpa_get_features(struct virtio_device *=
vdev)
>  {
>         struct vdpa_device *vdpa =3D vd_get_vdpa(vdev);
>         const struct vdpa_config_ops *ops =3D vdpa->config;
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 64cb4b04be7ad..6e51400d04635 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -11,6 +11,7 @@
>  #include <linux/gfp.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/completion.h>
> +#include <linux/virtio_features.h>
>
>  /**
>   * struct virtqueue - a queue to register buffers for sending or receivi=
ng.
> @@ -159,11 +160,11 @@ struct virtio_device {
>         const struct virtio_config_ops *config;
>         const struct vringh_config_ops *vringh_config;
>         struct list_head vqs;
> -       u64 features;
> +       virtio_features_t features;
>         void *priv;
>  #ifdef CONFIG_VIRTIO_DEBUG
>         struct dentry *debugfs_dir;
> -       u64 debugfs_filter_features;
> +       virtio_features_t debugfs_filter_features;
>  #endif
>  };
>
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.=
h
> index 169c7d367facb..bff57f675fca7 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -77,7 +77,7 @@ struct virtqueue_info {
>   *      vdev: the virtio_device
>   * @get_features: get the array of feature bits for this device.
>   *     vdev: the virtio_device
> - *     Returns the first 64 feature bits (all we currently need).
> + *     Returns the first VIRTIO_FEATURES_MAX feature bits (all we curren=
tly need).
>   * @finalize_features: confirm what device features we'll be using.
>   *     vdev: the virtio_device
>   *     This sends the driver feature bits to the device: it can change
> @@ -120,7 +120,7 @@ struct virtio_config_ops {
>                         struct irq_affinity *desc);
>         void (*del_vqs)(struct virtio_device *);
>         void (*synchronize_cbs)(struct virtio_device *);
> -       u64 (*get_features)(struct virtio_device *vdev);
> +       virtio_features_t (*get_features)(struct virtio_device *vdev);
>         int (*finalize_features)(struct virtio_device *vdev);
>         const char *(*bus_name)(struct virtio_device *vdev);
>         int (*set_vq_affinity)(struct virtqueue *vq,
> @@ -149,11 +149,11 @@ static inline bool __virtio_test_bit(const struct v=
irtio_device *vdev,
>  {
>         /* Did you forget to fix assumptions on max features? */
>         if (__builtin_constant_p(fbit))
> -               BUILD_BUG_ON(fbit >=3D 64);
> +               BUILD_BUG_ON(fbit >=3D VIRTIO_FEATURES_MAX);
>         else
> -               BUG_ON(fbit >=3D 64);
> +               BUG_ON(fbit >=3D VIRTIO_FEATURES_MAX);
>
> -       return vdev->features & BIT_ULL(fbit);
> +       return vdev->features & VIRTIO_BIT(fbit);
>  }
>
>  /**
> @@ -166,11 +166,11 @@ static inline void __virtio_set_bit(struct virtio_d=
evice *vdev,
>  {
>         /* Did you forget to fix assumptions on max features? */
>         if (__builtin_constant_p(fbit))
> -               BUILD_BUG_ON(fbit >=3D 64);
> +               BUILD_BUG_ON(fbit >=3D VIRTIO_FEATURES_MAX);
>         else
> -               BUG_ON(fbit >=3D 64);
> +               BUG_ON(fbit >=3D VIRTIO_FEATURES_MAX);
>
> -       vdev->features |=3D BIT_ULL(fbit);
> +       vdev->features |=3D VIRTIO_BIT(fbit);
>  }
>
>  /**
> @@ -183,11 +183,11 @@ static inline void __virtio_clear_bit(struct virtio=
_device *vdev,
>  {
>         /* Did you forget to fix assumptions on max features? */
>         if (__builtin_constant_p(fbit))
> -               BUILD_BUG_ON(fbit >=3D 64);
> +               BUILD_BUG_ON(fbit >=3D VIRTIO_FEATURES_MAX);
>         else
> -               BUG_ON(fbit >=3D 64);
> +               BUG_ON(fbit >=3D VIRTIO_FEATURES_MAX);
>
> -       vdev->features &=3D ~BIT_ULL(fbit);
> +       vdev->features &=3D ~VIRTIO_BIT(fbit);
>  }
>
>  /**
> diff --git a/include/linux/virtio_features.h b/include/linux/virtio_featu=
res.h
> new file mode 100644
> index 0000000000000..2f742eeb45a29
> --- /dev/null
> +++ b/include/linux/virtio_features.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_VIRTIO_FEATURES_H
> +#define _LINUX_VIRTIO_FEATURES_H
> +
> +#include <linux/bits.h>
> +
> +#if IS_ENABLED(CONFIG_ARCH_SUPPORTS_INT128)
> +#define VIRTIO_HAS_EXTENDED_FEATURES
> +#define VIRTIO_FEATURES_MAX    128
> +#define VIRTIO_FEATURES_WORDS  4
> +#define VIRTIO_BIT(b)          _BIT128(b)
> +
> +typedef __uint128_t            virtio_features_t;

Consider:

1) need the trick for arch that doesn't support 128bit
2) some transport (e.g PCI) allows much more than just 128 bit features

 I wonder if it's better to just use arrays here.

Thanks

> +
> +#else
> +#define VIRTIO_FEATURES_MAX    64
> +#define VIRTIO_FEATURES_WORDS  2
> +#define VIRTIO_BIT(b)          BIT_ULL(b)
> +
> +typedef u64                    virtio_features_t;
> +#endif
> +
> +#endif
> diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci=
_modern.h
> index c0b1b1ca11635..e55fbb272b4d3 100644
> --- a/include/linux/virtio_pci_modern.h
> +++ b/include/linux/virtio_pci_modern.h
> @@ -3,6 +3,7 @@
>  #define _LINUX_VIRTIO_PCI_MODERN_H
>
>  #include <linux/pci.h>
> +#include <linux/virtio_features.h>
>  #include <linux/virtio_pci.h>
>
>  /**
> @@ -95,10 +96,14 @@ static inline void vp_iowrite64_twopart(u64 val,
>         vp_iowrite32(val >> 32, hi);
>  }
>
> -u64 vp_modern_get_features(struct virtio_pci_modern_device *mdev);
> -u64 vp_modern_get_driver_features(struct virtio_pci_modern_device *mdev)=
;
> +virtio_features_t
> +vp_modern_get_features(struct virtio_pci_modern_device *mdev);
> +
> +virtio_features_t
> +vp_modern_get_driver_features(struct virtio_pci_modern_device *mdev);
> +
>  void vp_modern_set_features(struct virtio_pci_modern_device *mdev,
> -                    u64 features);
> +                    virtio_features_t features);
>  u32 vp_modern_generation(struct virtio_pci_modern_device *mdev);
>  u8 vp_modern_get_status(struct virtio_pci_modern_device *mdev);
>  void vp_modern_set_status(struct virtio_pci_modern_device *mdev,
> --
> 2.49.0
>


