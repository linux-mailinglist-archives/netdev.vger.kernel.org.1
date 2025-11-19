Return-Path: <netdev+bounces-239774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF773C6C543
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 03:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 03A104EF0FC
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 02:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15ED26158B;
	Wed, 19 Nov 2025 02:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V/tZJGsg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tsK9mYh8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE92925B662
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 02:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763517857; cv=none; b=jKPpD7jKTtZqS1SbS7wowsdB+GC8/c+qhjDX0Ny+J3nJqpo0831nolgrdPz8YWa9pQ7nKEA/hJ56T1L0JpB9YaSknBaOFQF8g8869iizKeeVaSXD/FfdzudBQ1HOqJBbgdh83ZCGwxu3HV/9nE6NriPKuvZ6y+l498eRsdsgtlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763517857; c=relaxed/simple;
	bh=ozObOcqnnKRxfSLIiRoj5WHV66cvy5XDT0cuieq6YJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oR5vg6djPjS53/mjcYKCGfTQGR9qd0wAxUQK4xnzuDTibkGHvebjUBJOmHagm23bgy9PfT5i0ZRPq3or84CY7LHt56sLNSNA5U0t1nAGkWO0KD/ltvSX04hHvMApRg9/5XilQmaHVebEngTN/F60BPC1r6lwD2ieMmlYWvLvz9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V/tZJGsg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tsK9mYh8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763517853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2H22WidGzJlZzyKi0xDeOV98viC9aWgGoX+719A6aDA=;
	b=V/tZJGsg8sRev0vJYyFHVXWPJ32Rln+NOBfMLulv+HUT+/vhoTQAQ6n1KdWAJT2fIRvQPM
	ia8wozorYT24aofqbnNWls22ipqYPwmXToW7iFJ7Xf77EGoSHpaqoz7sKqJoJntxXqOtsb
	HYmhqew/goQFf7fAbxcVhVNxvTeFTf4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-oxjJb0hBNmuKZVcEUHt9Bg-1; Tue, 18 Nov 2025 21:04:12 -0500
X-MC-Unique: oxjJb0hBNmuKZVcEUHt9Bg-1
X-Mimecast-MFC-AGG-ID: oxjJb0hBNmuKZVcEUHt9Bg_1763517851
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-340c261fb38so12272321a91.0
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 18:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763517851; x=1764122651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2H22WidGzJlZzyKi0xDeOV98viC9aWgGoX+719A6aDA=;
        b=tsK9mYh8prRW8h/SUZJOfEp240AIOJzS3W89LjZpIm9QvGjkZzaeVohRUnl7XTjTbs
         i2iR5VuQK8QCCXoj4OCmWvjzAycnIu130IA9QIWib5iCBHnYT1wV5fFHLE+/d5zM2u/z
         mbnBJ3LUDXVNZjO7Fgbvy4l2I8tCpZXAdZOVK/HnS6YXiNn52KCtvzqIULLws/7td9WT
         TemJ4xn/Ptrs4NKhAq9SEGCizIxp2HfvRbPA0ES12dWusHiBbINsFW2EcHUyYW1YKUCs
         bx0AktiLBKvwh3bgb5hUqEznqo0nIIJyyXp+I54FUZY8dxG7xN9aoKjqUdPklJuJ3OuM
         U4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763517851; x=1764122651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2H22WidGzJlZzyKi0xDeOV98viC9aWgGoX+719A6aDA=;
        b=pGotQdNH+0ogfHLqY84Nr6a43qOav6U6/bwYqCBxIYfrooMWU+b93nvH+7EtEFknjy
         HTHuicnjVmcW7n6RV1RoMVK7nLiMfFX/BYETRdn9nByG3caEIVG4JU6MTuYGynfwEXFr
         /UlJqonqFAI5C/GiIT5KbekTjdouALnYp94pYgcSJP8xM19gtvNfyRM7KnZxqhrTHxct
         ODQCCuGc5Rfik073/pDCc7J1QzKXToZ6UCm2099RB1mJpE9ZGE/vRx17p2lIcd21WmKo
         FBDRRuYwGHtlHkUFMx1+dRO3FkAC2E6SiZ0s94/QYFySTLIaOYPrKG0B8eQM3ev/8wle
         u/EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA58F68T0IrKvYZ2PBogyeEdp1Enrin/gaMeauA7jck1Gd4PquPZ2dUfly20dcmR9rn20+OzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXy6POofcGSdjai2KTWRJqKRDJWHENhrlvhUZXGzcSIYGWzRkH
	cqkDmeEhpDl0pOohZMxBaUJlDdoJ1lkPntIU43boEdXxrL1blj0MyJaIPZoS9j64n6FWtDTkWDx
	HpJT32rAh4+cj0OD/pYmZMDoUibirf0jirXyXCRZ2NSkQyLM+j8bBy7zDoQFlXuW8z5STlrw5vX
	F9GqpnCoJN7d6YttfnyQOrXxmcmf/bod3N
X-Gm-Gg: ASbGncsnwD7woqUWKOOXSrbbGT0HmtGayMpAqL3BlQGVGpyxNmmvSZ4XWKmGgEkP6b6
	ni6AttTRxYujBitoFrrhRATkvo+fuahfB+LA/c3lL/qBj2hLoOmNmwuxNNFmxlyr1e1ZhFjOAeC
	YDX9w1MDgR4TVbN7U1aNVwAdcnvRhW9kPHaljU2mLQeGgq3xgyITzn+1WkX1b8N3U=
X-Received: by 2002:a17:90b:3e4e:b0:340:ad5e:c3 with SMTP id 98e67ed59e1d1-345bd35b962mr700554a91.1.1763517851044;
        Tue, 18 Nov 2025 18:04:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnJGjwwAIDeF7uPafwMhf59ePT/2noUwTEo8kmPiqp5TcxgFp1WO4IJH0672NvLqOsCimu4D/TRGpPzxyEq3o=
X-Received: by 2002:a17:90b:3e4e:b0:340:ad5e:c3 with SMTP id
 98e67ed59e1d1-345bd35b962mr700512a91.1.1763517850564; Tue, 18 Nov 2025
 18:04:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763278904.git.mst@redhat.com> <17c98c7304b6d78d2d59893ba7295c2f64ab1224.1763278904.git.mst@redhat.com>
In-Reply-To: <17c98c7304b6d78d2d59893ba7295c2f64ab1224.1763278904.git.mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 19 Nov 2025 10:03:58 +0800
X-Gm-Features: AWmQ_bmWvw61Pe3AkzIrut_xsDT-CtFJhAnx-sIpiBFLZI86OCTTM2PSpQEM4i4
Message-ID: <CACGkMEu28fHr7Bo5Zm4chwOj-xBmTYcHM3TfXRx8OZ3OhO8q8Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] vhost: switch to arrays of feature bits
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Paolo Abeni <pabeni@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, Mike Christie <michael.christie@oracle.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 16, 2025 at 3:45=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> The current interface where caller has to know in which 64 bit chunk
> each bit is, is inelegant and fragile.
> Let's simply use arrays of bits.
> By using unroll macros text size grows only slightly.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/vhost/net.c   | 34 +++++++++++++++++++---------------
>  drivers/vhost/scsi.c  |  9 ++++++---
>  drivers/vhost/test.c  | 10 ++++++++--
>  drivers/vhost/vhost.h | 42 ++++++++++++++++++++++++++++++++++--------
>  drivers/vhost/vsock.c | 10 ++++++----
>  5 files changed, 73 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index d057ea55f5ad..00d00034a97e 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -69,15 +69,15 @@ MODULE_PARM_DESC(experimental_zcopytx, "Enable Zero C=
opy TX;"
>
>  #define VHOST_DMA_IS_DONE(len) ((__force u32)(len) >=3D (__force u32)VHO=
ST_DMA_DONE_LEN)
>
> -static const u64 vhost_net_features[VIRTIO_FEATURES_U64S] =3D {
> -       VHOST_FEATURES |
> -       (1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
> -       (1ULL << VIRTIO_NET_F_MRG_RXBUF) |
> -       (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
> -       (1ULL << VIRTIO_F_RING_RESET) |
> -       (1ULL << VIRTIO_F_IN_ORDER),
> -       VIRTIO_BIT(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) |
> -       VIRTIO_BIT(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO),
> +static const int vhost_net_features[] =3D {
> +       VHOST_FEATURES,
> +       VHOST_NET_F_VIRTIO_NET_HDR,
> +       VIRTIO_NET_F_MRG_RXBUF,
> +       VIRTIO_F_ACCESS_PLATFORM,
> +       VIRTIO_F_RING_RESET,
> +       VIRTIO_F_IN_ORDER,
> +       VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO,
> +       VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO
>  };
>
>  enum {
> @@ -1734,14 +1734,14 @@ static long vhost_net_ioctl(struct file *f, unsig=
ned int ioctl,
>                         return -EFAULT;
>                 return vhost_net_set_backend(n, backend.index, backend.fd=
);
>         case VHOST_GET_FEATURES:
> -               features =3D vhost_net_features[0];
> +               features =3D VHOST_FEATURES_U64(vhost_net_features, 0);
>                 if (copy_to_user(featurep, &features, sizeof features))
>                         return -EFAULT;
>                 return 0;
>         case VHOST_SET_FEATURES:
>                 if (copy_from_user(&features, featurep, sizeof features))
>                         return -EFAULT;
> -               if (features & ~vhost_net_features[0])
> +               if (features & ~VHOST_FEATURES_U64(vhost_net_features, 0)=
)
>                         return -EOPNOTSUPP;
>
>                 virtio_features_from_u64(all_features, features);
> @@ -1753,9 +1753,13 @@ static long vhost_net_ioctl(struct file *f, unsign=
ed int ioctl,
>                 /* Copy the net features, up to the user-provided buffer =
size */
>                 argp +=3D sizeof(u64);
>                 copied =3D min(count, (u64)VIRTIO_FEATURES_U64S);
> -               if (copy_to_user(argp, vhost_net_features,
> -                                copied * sizeof(u64)))
> -                       return -EFAULT;
> +
> +               {
> +                       const DEFINE_VHOST_FEATURES_ARRAY(features, vhost=
_net_features);
> +
> +                       if (copy_to_user(argp, features, copied * sizeof(=
u64)))
> +                               return -EFAULT;
> +               }

Any reason to use a standalone block here?

>
>                 /* Zero the trailing space provided by user-space, if any=
 */
>                 if (clear_user(argp, size_mul(count - copied, sizeof(u64)=
)))
> @@ -1784,7 +1788,7 @@ static long vhost_net_ioctl(struct file *f, unsigne=
d int ioctl,
>                 }
>
>                 for (i =3D 0; i < VIRTIO_FEATURES_U64S; i++)
> -                       if (all_features[i] & ~vhost_net_features[i])
> +                       if (all_features[i] & ~VHOST_FEATURES_U64(vhost_n=
et_features, i))
>                                 return -EOPNOTSUPP;
>
>                 return vhost_net_set_features(n, all_features);
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 98e4f68f4e3c..04fcbe7efd77 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -197,11 +197,14 @@ enum {
>  };
>
>  /* Note: can't set VIRTIO_F_VERSION_1 yet, since that implies ANY_LAYOUT=
. */
> -enum {
> -       VHOST_SCSI_FEATURES =3D VHOST_FEATURES | (1ULL << VIRTIO_SCSI_F_H=
OTPLUG) |
> -                                              (1ULL << VIRTIO_SCSI_F_T10=
_PI)
> +static const int vhost_scsi_features[] =3D {
> +       VHOST_FEATURES,
> +       VIRTIO_SCSI_F_HOTPLUG,
> +       VIRTIO_SCSI_F_T10_PI
>  };
>
> +#define VHOST_SCSI_FEATURES VHOST_FEATURES_U64(vhost_scsi_features, 0)
> +
>  #define VHOST_SCSI_MAX_TARGET  256
>  #define VHOST_SCSI_MAX_IO_VQ   1024
>  #define VHOST_SCSI_MAX_EVENT   128
> diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
> index 42c955a5b211..af727fccfe40 100644
> --- a/drivers/vhost/test.c
> +++ b/drivers/vhost/test.c
> @@ -308,6 +308,12 @@ static long vhost_test_set_backend(struct vhost_test=
 *n, unsigned index, int fd)
>         return r;
>  }
>
> +static const int vhost_test_features[] =3D {
> +       VHOST_FEATURES
> +};
> +
> +#define VHOST_TEST_FEATURES VHOST_FEATURES_U64(vhost_test_features, 0)
> +
>  static long vhost_test_ioctl(struct file *f, unsigned int ioctl,
>                              unsigned long arg)
>  {
> @@ -328,14 +334,14 @@ static long vhost_test_ioctl(struct file *f, unsign=
ed int ioctl,
>                         return -EFAULT;
>                 return vhost_test_set_backend(n, backend.index, backend.f=
d);
>         case VHOST_GET_FEATURES:
> -               features =3D VHOST_FEATURES;
> +               features =3D VHOST_TEST_FEATURES;
>                 if (copy_to_user(featurep, &features, sizeof features))
>                         return -EFAULT;
>                 return 0;
>         case VHOST_SET_FEATURES:
>                 if (copy_from_user(&features, featurep, sizeof features))
>                         return -EFAULT;
> -               if (features & ~VHOST_FEATURES)
> +               if (features & ~VHOST_TEST_FEATURES)
>                         return -EOPNOTSUPP;
>                 return vhost_test_set_features(n, features);
>         case VHOST_RESET_OWNER:
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index 621a6d9a8791..d8f1af9a0ff1 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -14,6 +14,7 @@
>  #include <linux/atomic.h>
>  #include <linux/vhost_iotlb.h>
>  #include <linux/irqbypass.h>
> +#include <linux/unroll.h>
>
>  struct vhost_work;
>  struct vhost_task;
> @@ -279,14 +280,39 @@ void vhost_iotlb_map_free(struct vhost_iotlb *iotlb=
,
>                                 eventfd_signal((vq)->error_ctx);\
>         } while (0)
>
> -enum {
> -       VHOST_FEATURES =3D (1ULL << VIRTIO_F_NOTIFY_ON_EMPTY) |
> -                        (1ULL << VIRTIO_RING_F_INDIRECT_DESC) |
> -                        (1ULL << VIRTIO_RING_F_EVENT_IDX) |
> -                        (1ULL << VHOST_F_LOG_ALL) |
> -                        (1ULL << VIRTIO_F_ANY_LAYOUT) |
> -                        (1ULL << VIRTIO_F_VERSION_1)
> -};
> +#define VHOST_FEATURES \
> +       VIRTIO_F_NOTIFY_ON_EMPTY, \
> +       VIRTIO_RING_F_INDIRECT_DESC, \
> +       VIRTIO_RING_F_EVENT_IDX, \
> +       VHOST_F_LOG_ALL, \
> +       VIRTIO_F_ANY_LAYOUT, \
> +       VIRTIO_F_VERSION_1
> +
> +static inline u64 vhost_features_u64(const int *features, int size, int =
idx)
> +{
> +       unsigned long res =3D 0;

Should this be u64?

> +
> +       unrolled_count(VIRTIO_FEATURES_BITS)
> +       for (int i =3D 0; i < size; ++i) {
> +               int bit =3D features[i];
> +
> +               if (virtio_features_chk_bit(bit) && VIRTIO_U64(bit) =3D=
=3D idx)
> +                       res |=3D VIRTIO_BIT(bit);
> +       }
> +       return res;
> +}
> +
> +#define VHOST_FEATURES_U64(features, idx) \
> +       vhost_features_u64(features, ARRAY_SIZE(features), idx)
> +
> +#define DEFINE_VHOST_FEATURES_ARRAY_ENTRY(idx, features) \
> +       [idx] =3D VHOST_FEATURES_U64(features, idx),
> +
> +#define DEFINE_VHOST_FEATURES_ARRAY(array, features) \
> +       u64 array[VIRTIO_FEATURES_U64S] =3D { \
> +               UNROLL(VIRTIO_FEATURES_U64S, \
> +                      DEFINE_VHOST_FEATURES_ARRAY_ENTRY, features) \
> +       }
>
>  /**
>   * vhost_vq_set_backend - Set backend.
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index ae01457ea2cd..16662f2b87c1 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -29,12 +29,14 @@
>   */
>  #define VHOST_VSOCK_PKT_WEIGHT 256
>
> -enum {
> -       VHOST_VSOCK_FEATURES =3D VHOST_FEATURES |
> -                              (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
> -                              (1ULL << VIRTIO_VSOCK_F_SEQPACKET)
> +static const int vhost_vsock_features[] =3D {
> +       VHOST_FEATURES,
> +       VIRTIO_F_ACCESS_PLATFORM,
> +       VIRTIO_VSOCK_F_SEQPACKET
>  };
>
> +#define VHOST_VSOCK_FEATURES VHOST_FEATURES_U64(vhost_vsock_features, 0)
> +
>  enum {
>         VHOST_VSOCK_BACKEND_FEATURES =3D (1ULL << VHOST_BACKEND_F_IOTLB_M=
SG_V2)
>  };
> --
> MST
>

Thanks


