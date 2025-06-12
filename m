Return-Path: <netdev+bounces-196771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CCBAD64D2
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 02:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92CF6189B398
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 00:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE357502BE;
	Thu, 12 Jun 2025 00:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UB56yW9l"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD3A44C77
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 00:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749689879; cv=none; b=LMIt0hWxMGmoV8iSWFmEb3m5+5AOF0+YA1qihT6ch0ZRevDsKozubYHjDCVD/WZQYyZdAqORu1m0a+DC1hXrQWBihT/vnyfL0SjbLpM85cdKQeKc+IeT3Rcht8sKH29a3FgRgaPHauDgzmEbHIhZ0a/4ninMcxPDafDoyYC/D/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749689879; c=relaxed/simple;
	bh=P+e1mzfTB2Xkre3+V4ukISxO1FCcLnk/ZLAuh5VDosE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uHKE5Oqvq/yuzeSw4TzUpsfIafJCXR/JQpZzU4qHrFaQS+kNcBCCC1tQvrH0Cdo3bZ8RfdrW7vapsJMaOwVSpg5xxSWyGyzhmV+sx+Qifl3/q30ZfyIvImfs9eSGD48U3a8NOcpU5+SuaJiajLBg3+AmYDCnx5/ja0Gvnzl64Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UB56yW9l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749689876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nreEbGQ5FC+xWCINtiBsaW2Dj1RetKVZ1ujN8C+cobs=;
	b=UB56yW9lXRoJILbiDcVcQ+lk36I4NBl4dpX6v8z8r2+f9mGwAOzyOJCrxlFdT18Gr6mjfK
	Ho06ub9v8sn5NElJuCZ+oZG9aZtfcVPiAsMt5AG6+ErVHcMHwNzjlt86Xz3EYhUDfvDgXc
	RtvthZIzmc2cveJtY2iqow+kXGF1zLA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-t9i6WsAxMMSuh-LZcTS5Ag-1; Wed, 11 Jun 2025 20:57:55 -0400
X-MC-Unique: t9i6WsAxMMSuh-LZcTS5Ag-1
X-Mimecast-MFC-AGG-ID: t9i6WsAxMMSuh-LZcTS5Ag_1749689874
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3138c50d2a0so545174a91.2
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 17:57:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749689874; x=1750294674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nreEbGQ5FC+xWCINtiBsaW2Dj1RetKVZ1ujN8C+cobs=;
        b=YVhRNf2ugXv3tF8RSqTmGnBUUHmDWYGWDbjuHHyqrazaIUWODnrNs1SF2q2kv+NkRD
         UJKSaiIETQ4JRdodZzTOwPVoXNqdE6C5NhyDfHHhYNp3uNgxSUVoTkyPUXFVjZFJ2fKq
         N1ZceDsuq/5INdndZRUNTCJwy1Lbjw569eGWb1KNTCAH0wfTXWN0jjgxKOjRzMY9M4FF
         8NN4eDG6tiPNb+O4mbtl593DNRnoXqyWmpYirMYFHnleXDNwkB+TM2xfUpeqarTLcEkF
         VdCzoXsrqSBcutJIhcOceUGL3BD1fRUnUFQe173paapUpv8hPLaQL9rCVDoA4+Yx7c9O
         DUFw==
X-Gm-Message-State: AOJu0Yx0uegNTEFeUhI+B4UEH7UiH23fzTTiogwln5XB6gXr3MiBMaws
	gL5TqyCCvPZc9MFUgghPkcSQ1NuxCAx0LGSK35sj2jjgz7yRlN1SR2JVjONKWODRiWh40lO19DP
	BNgDSe9v7nvtt9iYxdUTuRJls9lRVOAfSb1E+aOw+DRptGFK9k8b0o5O32SFrIC8tAES7uXXz/3
	x9BUOgi+rqqX2Z8BMPlcaNiW3rrobfkE/5
X-Gm-Gg: ASbGnctdQG0TbY0UkYeDREGcp5CVT7+bw0aAalyXJ8HsFIAtzUMBfF328Tsw8qq9iIH
	6inmnPeZtUR5EPhvbo6v261cpPjpf9ATwm0ueCDAfoewcr0iHl64ZpgXU7dJtNsTnleR6D44c4L
	ElsB8=
X-Received: by 2002:a17:90b:3502:b0:312:51a9:5d44 with SMTP id 98e67ed59e1d1-313af0fd2cemr7996434a91.5.1749689874165;
        Wed, 11 Jun 2025 17:57:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw4xFrduNk/pyi8lg4ryImHkDygx7a4FCaeI3MpyzXCGyHo5WK7seJdNbYZS8XO8ALCUSFUVrsEpQ9rY3jt1A=
X-Received: by 2002:a17:90b:3502:b0:312:51a9:5d44 with SMTP id
 98e67ed59e1d1-313af0fd2cemr7996393a91.5.1749689873673; Wed, 11 Jun 2025
 17:57:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1749210083.git.pabeni@redhat.com> <19ee74a1a46e9eb302fc742fb7c9913bcc6b7d86.1749210083.git.pabeni@redhat.com>
In-Reply-To: <19ee74a1a46e9eb302fc742fb7c9913bcc6b7d86.1749210083.git.pabeni@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 12 Jun 2025 08:57:42 +0800
X-Gm-Features: AX0GCFvN1M48SASjxhabtzL725nGtH0wI9ou0psHG9itwlfyw6Fz6npiGttcqBU
Message-ID: <CACGkMEvH8cq+AdvJMO0eV0jps_-t1tUMc-cbdfReJdWFThOVuw@mail.gmail.com>
Subject: Re: [PATCH RFC v3 2/8] virtio_pci_modern: allow configuring extended features
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 7:46=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
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
> v2 -> v3:
>   - virtio_features_t -> u64 *
>
> v1 -> v2:
>   - use get_extended_features
> ---
>  drivers/virtio/virtio_pci_modern.c     | 10 ++--
>  drivers/virtio/virtio_pci_modern_dev.c | 69 +++++++++++++++-----------
>  include/linux/virtio_pci_modern.h      | 46 +++++++++++++++--
>  3 files changed, 87 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_p=
ci_modern.c
> index d50fe030d825..255203441201 100644
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
> @@ -426,7 +426,7 @@ static int vp_finalize_features(struct virtio_device =
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
> @@ -1223,7 +1223,7 @@ static const struct virtio_config_ops virtio_pci_co=
nfig_nodev_ops =3D {
>         .find_vqs       =3D vp_modern_find_vqs,
>         .del_vqs        =3D vp_del_vqs,
>         .synchronize_cbs =3D vp_synchronize_vectors,
> -       .get_features   =3D vp_get_features,
> +       .get_extended_features =3D vp_get_features,
>         .finalize_features =3D vp_finalize_features,
>         .bus_name       =3D vp_bus_name,
>         .set_vq_affinity =3D vp_set_vq_affinity,
> @@ -1243,7 +1243,7 @@ static const struct virtio_config_ops virtio_pci_co=
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
> +       }
>  }
> -EXPORT_SYMBOL_GPL(vp_modern_get_features);
> +EXPORT_SYMBOL_GPL(vp_modern_get_extended_features);
>
>  /*
>   * vp_modern_get_driver_features - get driver features from device
>   * @mdev: the modern virtio-pci device
> + * @features: the features array to be filled
>   *
> - * Returns the driver features read from the device
> + * Fill the specified features array with the driver features read from =
the
> + * device
>   */
> -u64 vp_modern_get_driver_features(struct virtio_pci_modern_device *mdev)
> +void
> +vp_modern_get_driver_extended_features(struct virtio_pci_modern_device *=
mdev,
> +                                      u64 *features)
>  {
>         struct virtio_pci_common_cfg __iomem *cfg =3D mdev->common;
> +       int i;
>
> -       u64 features;
> -
> -       vp_iowrite32(0, &cfg->guest_feature_select);
> -       features =3D vp_ioread32(&cfg->guest_feature);
> -       vp_iowrite32(1, &cfg->guest_feature_select);
> -       features |=3D ((u64)vp_ioread32(&cfg->guest_feature) << 32);
> +       virtio_features_zero(features);
> +       for (i =3D 0; i < VIRTIO_FEATURES_WORDS; i++) {
> +               u64 cur;
>
> -       return features;
> +               vp_iowrite32(i, &cfg->guest_feature_select);
> +               cur =3D vp_ioread32(&cfg->guest_feature);
> +               features[i >> 1] |=3D cur << (32 * (i & 1));
> +       }
>  }
> -EXPORT_SYMBOL_GPL(vp_modern_get_driver_features);
> +EXPORT_SYMBOL_GPL(vp_modern_get_driver_extended_features);
>
>  /*
> - * vp_modern_set_features - set features to device
> + * vp_modern_set_extended_features - set features to device
>   * @mdev: the modern virtio-pci device
>   * @features: the features set to device
>   */
> -void vp_modern_set_features(struct virtio_pci_modern_device *mdev,
> -                           u64 features)
> +void vp_modern_set_extended_features(struct virtio_pci_modern_device *md=
ev,
> +                                    const u64 *features)
>  {
>         struct virtio_pci_common_cfg __iomem *cfg =3D mdev->common;
> +       int i;
> +
> +       for (i =3D 0; i < VIRTIO_FEATURES_WORDS; i++) {
> +               u32 cur =3D features[i >> 1] >> (32 * (i & 1));
>
> -       vp_iowrite32(0, &cfg->guest_feature_select);
> -       vp_iowrite32((u32)features, &cfg->guest_feature);
> -       vp_iowrite32(1, &cfg->guest_feature_select);
> -       vp_iowrite32(features >> 32, &cfg->guest_feature);
> +               vp_iowrite32(i, &cfg->guest_feature_select);
> +               vp_iowrite32(cur, &cfg->guest_feature);
> +       }
>  }
> -EXPORT_SYMBOL_GPL(vp_modern_set_features);
> +EXPORT_SYMBOL_GPL(vp_modern_set_extended_features);
>
>  /*
>   * vp_modern_generation - get the device genreation
> diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci=
_modern.h
> index c0b1b1ca1163..0764802a50ea 100644
> --- a/include/linux/virtio_pci_modern.h
> +++ b/include/linux/virtio_pci_modern.h
> @@ -3,6 +3,7 @@
>  #define _LINUX_VIRTIO_PCI_MODERN_H
>
>  #include <linux/pci.h>
> +#include <linux/virtio_config.h>
>  #include <linux/virtio_pci.h>
>
>  /**
> @@ -95,10 +96,47 @@ static inline void vp_iowrite64_twopart(u64 val,
>         vp_iowrite32(val >> 32, hi);
>  }
>
> -u64 vp_modern_get_features(struct virtio_pci_modern_device *mdev);
> -u64 vp_modern_get_driver_features(struct virtio_pci_modern_device *mdev)=
;
> -void vp_modern_set_features(struct virtio_pci_modern_device *mdev,
> -                    u64 features);
> +void
> +vp_modern_get_driver_extended_features(struct virtio_pci_modern_device *=
mdev,
> +                                      u64 *features);
> +void vp_modern_get_extended_features(struct virtio_pci_modern_device *md=
ev,
> +                                    u64 *features);
> +void vp_modern_set_extended_features(struct virtio_pci_modern_device *md=
ev,
> +                                    const u64 *features);
> +
> +static inline u64
> +vp_modern_get_features(struct virtio_pci_modern_device *mdev)
> +{
> +       u64 features_array[VIRTIO_FEATURES_DWORDS];
> +       int i;
> +
> +       vp_modern_get_extended_features(mdev, features_array);
> +       for (i =3D 1; i < VIRTIO_FEATURES_DWORDS; ++i)
> +               WARN_ON_ONCE(features_array[i]);

It looks to me it's sufficient and safe to just return
featuers_array[0] here. Or maybe we need some comment to explain why
we need WARN here.

Thanks


