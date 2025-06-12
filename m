Return-Path: <netdev+bounces-196769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 265B0AD64CA
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 02:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB4743ACBDB
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 00:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B004CE08;
	Thu, 12 Jun 2025 00:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WHmtqu2i"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADFCA944
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 00:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749689467; cv=none; b=mOUwKTl8yF1z4UoOJWWaqoLQQIP2uqe48C42Ssxaq5K4czoC9uFyAfe02FRInvl44MlzLZCgamMr4XfHDYDGRkIrqHH9AbesZf8Er5vCJBdMVZ6njycVUHgtAsHpgBRbnr3nEOcbcQcy5gpRymMWCXlbIs26ROM7h9NOaw6YEYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749689467; c=relaxed/simple;
	bh=A+AIR2N+YONCF4AAUxgjsFsW4eVwrf9dFhyX4EWhxUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R4UJEEOoBlR8Pw75Po9mIYEAlpzCI34kuVV4RC6PxfoIwpKaq0n2Ho19lYzpNcTkVdRjZ3eyiSJnsCQIovnUujrD2uLBQOLZTW2jQRJ1ZmwkKrIFmBe1+wrENhUXQRPOX7a77Pg3FjMF2HQNr/twWyEnrURyw8at9v5tZ54jIug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WHmtqu2i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749689463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uxs4CAq1Qg1ZI2SqxNp4VbU8kiN+F+U1+gxKp/q/YjE=;
	b=WHmtqu2indHkr/itSY04hK8aA+9hmfPszuxKtlQj2NPufMvRC6RYRbhUjlATrD8icobcxA
	2jKIuhCug3IAlA3pByFnLqkAKc1cgQC0s+P6PJkNX4sikZlz1YMxN/dIitTOVkbmPX64Nq
	JDFwqabh4s3wsw20dYrSKsRQRCcvKnI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-ruPsA7_nP2uvmzVDmBoZww-1; Wed, 11 Jun 2025 20:51:01 -0400
X-MC-Unique: ruPsA7_nP2uvmzVDmBoZww-1
X-Mimecast-MFC-AGG-ID: ruPsA7_nP2uvmzVDmBoZww_1749689461
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-311ef4fb5eeso283281a91.1
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 17:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749689461; x=1750294261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uxs4CAq1Qg1ZI2SqxNp4VbU8kiN+F+U1+gxKp/q/YjE=;
        b=TMUfVpyheS/6eqp66KPOMlGF4tpBDeHCDjug6zx75NN4c7dMxDc90WGdMfi7CWr5Mh
         zgw4+0gdnkIYYYtjQISgXG+59ydtuGyuswaByWmjlWGnYSpGavW7YJ6tTmHlGp+w95wl
         pA9vDADDQgPYdI7lVioy74/eLn+4JBhBiHaQKaOyzKmjXrxPJt+ylZmy81HCsHohkJ+6
         IvnRPG+P2Sflr1JRXbvRqvm8Gqf6ERH2LhOFgvlV3VotLzrkZ6GpP8H7YSrpc18UKWZO
         mGfAoBrSQHPAOIZR4OC78HnfClnPsC1c3EmzNSDdMN0RAXb5yYCQFWflWuHs6sh4jvhR
         Ty/w==
X-Gm-Message-State: AOJu0YyyXl2/54SDCgDU2flY4LAckQSbunODCNpMTfnpxBizq7tib3U/
	35U8VRG1OO7GeLH43FlGnBLY05+B+/QpBJbH/VnlfZfQpRYLCl0YrhNwrbkxmVl9CVy3nQ1C9S+
	gqSiYf2MKgWyRska/PE5mm4/4yIDX+7GymGUi9wDZ9ZeNJAkht1WyPIw1VOaucKejCVjbCZKrUv
	SdyMsR+eKOox9cBmePOXIHrk59Texmuw5M
X-Gm-Gg: ASbGnctz12pbhOq6fthTIM1CGnx/Nca19yMoN0hDz4X+Mv7ldgOBTzZQZng6SQS5DN8
	a/QNnOiW25UEx+gLZR0kNH2l40f225tvV5s8W6JQRD9iG61br0cCeEqkwvyAOut709nWcDb/lIO
	2e9/A=
X-Received: by 2002:a17:90b:1dca:b0:312:dbcd:b93d with SMTP id 98e67ed59e1d1-313bfdf62c4mr1803568a91.14.1749689460555;
        Wed, 11 Jun 2025 17:51:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER0FFtGPTRNL3s3J7kqeve7hcNHgVvsaIdEqgk6JF+WoWEIjwahI8U5GwQI9hxnQRqPioz8M6Wf8j89uoQpSg=
X-Received: by 2002:a17:90b:1dca:b0:312:dbcd:b93d with SMTP id
 98e67ed59e1d1-313bfdf62c4mr1803522a91.14.1749689460012; Wed, 11 Jun 2025
 17:51:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1749210083.git.pabeni@redhat.com> <47a89c6b568c3ab266ab351711f916d4a683ebdf.1749210083.git.pabeni@redhat.com>
In-Reply-To: <47a89c6b568c3ab266ab351711f916d4a683ebdf.1749210083.git.pabeni@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 12 Jun 2025 08:50:48 +0800
X-Gm-Features: AX0GCFvc50gx_C_N_1443g8VMNOGJEnqUy9Xva_EhePoFqPPW2BTpn7Z3L58sAs
Message-ID: <CACGkMEuNL+nLb2EvHWqSfKB6iiDScuKD6RJqxZ2-P9v5BDH1HA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 1/8] virtio: introduce extended features
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
> Introduce extended features as a fixed size array of u64. To minimize
> the diffstat allows legacy driver to access the low 64 bits via a
> transparent union.
>
> Introduce an extended get_extended_features128 configuration callback
> that devices supporting the extended features range must implement in
> place of the traditional one.
>
> Note that legacy and transport features don't need any change, as
> they are always in the low 64 bit range.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v2 -> v3:
>   - uint128_t -> u64[2];
> v1 -> v2:
>   - let u64 VIRTIO_BIT() cope with higher bit values
>   - add .get_features128 instead of changing .get_features signature
> ---
>  drivers/virtio/virtio.c         | 39 +++++++++++-------
>  drivers/virtio/virtio_debug.c   | 27 +++++++------
>  include/linux/virtio.h          |  5 ++-
>  include/linux/virtio_config.h   | 35 ++++++++++++-----
>  include/linux/virtio_features.h | 70 +++++++++++++++++++++++++++++++++
>  5 files changed, 137 insertions(+), 39 deletions(-)
>  create mode 100644 include/linux/virtio_features.h
>
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 95d5d7993e5b..ed1ccedc47b3 100644
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
> +               BUG_ON(f >=3D VIRTIO_FEATURES_MAX);
> +               virtio_features_set_bit(driver_features, f);

Instead of doing BUG_ON here, could we just stop at 128 bits?

>         }
>
>         /* Some drivers have a separate feature table for virtio v1.0 */
> @@ -299,20 +299,25 @@ static int virtio_dev_probe(struct device *_d)
>                         driver_features_legacy |=3D (1ULL << f);
>                 }
>         } else {
> -               driver_features_legacy =3D driver_features;
> +               driver_features_legacy =3D driver_features[0];
>         }
>
> -       if (device_features & (1ULL << VIRTIO_F_VERSION_1))
> -               dev->features =3D driver_features & device_features;
> -       else
> -               dev->features =3D driver_features_legacy & device_feature=
s;
> +       if (virtio_features_test_bit(device_features, VIRTIO_F_VERSION_1)=
) {
> +               for (i =3D 0; i < VIRTIO_FEATURES_DWORDS; ++i)
> +                       dev->features_array[i] =3D driver_features[i] &
> +                                                device_features[i];
> +       } else {
> +               virtio_features_from_u64(dev->features_array,
> +                                        driver_features_legacy &
> +                                        device_features[0]);
> +       }
>
>         /* When debugging, user may filter some features by hand. */
>         virtio_debug_device_filter_features(dev);
>
>         /* Transport features always preserved to pass to finalize_featur=
es. */
>         for (i =3D VIRTIO_TRANSPORT_F_START; i < VIRTIO_TRANSPORT_F_END; =
i++)
> -               if (device_features & (1ULL << i))
> +               if (virtio_features_test_bit(device_features, i))
>                         __virtio_set_bit(dev, i);
>
>         err =3D dev->config->finalize_features(dev);
> @@ -320,14 +325,15 @@ static int virtio_dev_probe(struct device *_d)
>                 goto err;
>
>         if (drv->validate) {
> -               u64 features =3D dev->features;
> +               u64 features[VIRTIO_FEATURES_DWORDS];
>
> +               virtio_features_copy(features, dev->features_array);
>                 err =3D drv->validate(dev);
>                 if (err)
>                         goto err;
>
>                 /* Did validation change any features? Then write them ag=
ain. */
> -               if (features !=3D dev->features) {
> +               if (!virtio_features_equal(features, dev->features_array)=
) {
>                         err =3D dev->config->finalize_features(dev);
>                         if (err)
>                                 goto err;
> @@ -701,6 +707,9 @@ EXPORT_SYMBOL_GPL(virtio_device_reset_done);
>
>  static int virtio_init(void)
>  {
> +       BUILD_BUG_ON(offsetof(struct virtio_device, features) !=3D
> +                    offsetof(struct virtio_device, features_array[0]));
> +
>         if (bus_register(&virtio_bus) !=3D 0)
>                 panic("virtio bus registration failed");
>         virtio_debug_init();
> diff --git a/drivers/virtio/virtio_debug.c b/drivers/virtio/virtio_debug.=
c
> index 95c8fc7705bb..6d066b5e8ec0 100644
> --- a/drivers/virtio/virtio_debug.c
> +++ b/drivers/virtio/virtio_debug.c
> @@ -8,13 +8,13 @@ static struct dentry *virtio_debugfs_dir;
>
>  static int virtio_debug_device_features_show(struct seq_file *s, void *d=
ata)
>  {
> +       u64 device_features[VIRTIO_FEATURES_DWORDS];
>         struct virtio_device *dev =3D s->private;
> -       u64 device_features;
>         unsigned int i;
>
> -       device_features =3D dev->config->get_features(dev);
> -       for (i =3D 0; i < BITS_PER_LONG_LONG; i++) {
> -               if (device_features & (1ULL << i))
> +       virtio_get_features(dev, device_features);
> +       for (i =3D 0; i < VIRTIO_FEATURES_MAX; i++) {
> +               if (virtio_features_test_bit(device_features, i))
>                         seq_printf(s, "%u\n", i);
>         }
>         return 0;
> @@ -26,8 +26,8 @@ static int virtio_debug_filter_features_show(struct seq=
_file *s, void *data)
>         struct virtio_device *dev =3D s->private;
>         unsigned int i;
>
> -       for (i =3D 0; i < BITS_PER_LONG_LONG; i++) {
> -               if (dev->debugfs_filter_features & (1ULL << i))
> +       for (i =3D 0; i < VIRTIO_FEATURES_MAX; i++) {
> +               if (virtio_features_test_bit(dev->debugfs_filter_features=
, i))
>                         seq_printf(s, "%u\n", i);
>         }
>         return 0;
> @@ -39,7 +39,7 @@ static int virtio_debug_filter_features_clear(void *dat=
a, u64 val)
>         struct virtio_device *dev =3D data;
>
>         if (val =3D=3D 1)
> -               dev->debugfs_filter_features =3D 0;
> +               virtio_features_zero(dev->debugfs_filter_features);
>         return 0;
>  }
>
> @@ -50,9 +50,10 @@ static int virtio_debug_filter_feature_add(void *data,=
 u64 val)
>  {
>         struct virtio_device *dev =3D data;
>
> -       if (val >=3D BITS_PER_LONG_LONG)
> +       if (val >=3D VIRTIO_FEATURES_MAX)
>                 return -EINVAL;
> -       dev->debugfs_filter_features |=3D BIT_ULL_MASK(val);
> +
> +       virtio_features_set_bit(dev->debugfs_filter_features, val);
>         return 0;
>  }
>
> @@ -63,9 +64,10 @@ static int virtio_debug_filter_feature_del(void *data,=
 u64 val)
>  {
>         struct virtio_device *dev =3D data;
>
> -       if (val >=3D BITS_PER_LONG_LONG)
> +       if (val >=3D VIRTIO_FEATURES_MAX)
>                 return -EINVAL;
> -       dev->debugfs_filter_features &=3D ~BIT_ULL_MASK(val);
> +
> +       virtio_features_clear_bit(dev->debugfs_filter_features, val);
>         return 0;
>  }
>
> @@ -91,7 +93,8 @@ EXPORT_SYMBOL_GPL(virtio_debug_device_init);
>
>  void virtio_debug_device_filter_features(struct virtio_device *dev)
>  {
> -       dev->features &=3D ~dev->debugfs_filter_features;
> +       virtio_features_and_not(dev->features_array, dev->features_array,
> +                               dev->debugfs_filter_features);
>  }
>  EXPORT_SYMBOL_GPL(virtio_debug_device_filter_features);
>
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 64cb4b04be7a..dcd3949572bd 100644
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
> +       VIRTIO_DECLARE_FEATURES(features);
>         void *priv;
>  #ifdef CONFIG_VIRTIO_DEBUG
>         struct dentry *debugfs_dir;
> -       u64 debugfs_filter_features;
> +       u64 debugfs_filter_features[VIRTIO_FEATURES_DWORDS];
>  #endif
>  };
>
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.=
h
> index 169c7d367fac..83cf25b3028d 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -77,7 +77,10 @@ struct virtqueue_info {
>   *      vdev: the virtio_device
>   * @get_features: get the array of feature bits for this device.
>   *     vdev: the virtio_device
> - *     Returns the first 64 feature bits (all we currently need).
> + *     Returns the first 64 feature bits.
> + * @get_extended_features:
> + *      vdev: the virtio_device
> + *      Returns the first VIRTIO_FEATURES_MAX feature bits (all we curre=
ntly need).
>   * @finalize_features: confirm what device features we'll be using.
>   *     vdev: the virtio_device
>   *     This sends the driver feature bits to the device: it can change
> @@ -121,6 +124,8 @@ struct virtio_config_ops {
>         void (*del_vqs)(struct virtio_device *);
>         void (*synchronize_cbs)(struct virtio_device *);
>         u64 (*get_features)(struct virtio_device *vdev);
> +       void (*get_extended_features)(struct virtio_device *vdev,
> +                                     u64 *features);

I think it would be better to add a size to simplify the future extension.

>         int (*finalize_features)(struct virtio_device *vdev);
>         const char *(*bus_name)(struct virtio_device *vdev);
>         int (*set_vq_affinity)(struct virtqueue *vq,
> @@ -149,11 +154,11 @@ static inline bool __virtio_test_bit(const struct v=
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
> +       return virtio_features_test_bit(vdev->features_array, fbit);
>  }
>
>  /**
> @@ -166,11 +171,11 @@ static inline void __virtio_set_bit(struct virtio_d=
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
> +       virtio_features_set_bit(vdev->features_array, fbit);
>  }
>
>  /**
> @@ -183,11 +188,11 @@ static inline void __virtio_clear_bit(struct virtio=
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
> +       virtio_features_clear_bit(vdev->features_array, fbit);
>  }
>
>  /**
> @@ -204,6 +209,16 @@ static inline bool virtio_has_feature(const struct v=
irtio_device *vdev,
>         return __virtio_test_bit(vdev, fbit);
>  }
>
> +static inline void virtio_get_features(struct virtio_device *vdev, u64 *=
features)
> +{
> +       if (vdev->config->get_extended_features) {
> +               vdev->config->get_extended_features(vdev, features);
> +               return;
> +       }
> +
> +       virtio_features_from_u64(features, vdev->config->get_features(vde=
v));
> +}
> +
>  /**
>   * virtio_has_dma_quirk - determine whether this device has the DMA quir=
k
>   * @vdev: the device
> diff --git a/include/linux/virtio_features.h b/include/linux/virtio_featu=
res.h
> new file mode 100644
> index 000000000000..42c3c7cee500
> --- /dev/null
> +++ b/include/linux/virtio_features.h
> @@ -0,0 +1,70 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_VIRTIO_FEATURES_H
> +#define _LINUX_VIRTIO_FEATURES_H
> +
> +#include <linux/bits.h>
> +
> +#define VIRTIO_FEATURES_DWORDS 2
> +#define VIRTIO_FEATURES_MAX    (VIRTIO_FEATURES_DWORDS * 64)
> +#define VIRTIO_FEATURES_WORDS  (VIRTIO_FEATURES_DWORDS * 2)
> +#define VIRTIO_BIT(b)          BIT_ULL((b) & 0x3f)
> +#define VIRTIO_DWORD(b)                ((b) >> 6)
> +#define VIRTIO_DECLARE_FEATURES(name)                  \
> +       union {                                         \
> +               u64 name;                               \
> +               u64 name##_array[VIRTIO_FEATURES_DWORDS];\
> +       }
> +
> +static inline bool virtio_features_test_bit(const u64 *features,
> +                                           unsigned int bit)
> +{
> +       return !!(features[VIRTIO_DWORD(bit)] & VIRTIO_BIT(bit));
> +}
> +
> +static inline void virtio_features_set_bit(u64 *features,
> +                                          unsigned int bit)
> +{
> +       features[VIRTIO_DWORD(bit)] |=3D VIRTIO_BIT(bit);
> +}
> +
> +static inline void virtio_features_clear_bit(u64 *features,
> +                                            unsigned int bit)
> +{
> +       features[VIRTIO_DWORD(bit)] &=3D ~VIRTIO_BIT(bit);
> +}
> +
> +static inline void virtio_features_zero(u64 *features)
> +{
> +       memset(features, 0, sizeof(features[0]) * VIRTIO_FEATURES_DWORDS)=
;
> +}
> +
> +static inline void virtio_features_from_u64(u64 *features, u64 from)
> +{
> +       virtio_features_zero(features);
> +       features[0] =3D from;
> +}
> +
> +static inline bool virtio_features_equal(const u64 *f1, const u64 *f2)
> +{
> +       u64 diff =3D 0;
> +       int i;
> +
> +       for (i =3D 0; i < VIRTIO_FEATURES_DWORDS; ++i)
> +               diff |=3D f1[i] ^ f2[i];
> +       return !!diff;

Nit: we can return false early here.

> +}
> +
> +static inline void virtio_features_copy(u64 *to, const u64 *from)
> +{
> +       memcpy(to, from, sizeof(to[0]) * VIRTIO_FEATURES_DWORDS);
> +}
> +
> +static inline void virtio_features_and_not(u64 *to, const u64 *f1, const=
 u64 *f2)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < VIRTIO_FEATURES_DWORDS; i++)
> +               to[i] =3D f1[i] & ~f2[i];
> +}
> +
> +#endif
> --
> 2.49.0

Others look good to me.

Thanks

>


