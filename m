Return-Path: <netdev+bounces-233733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D63BEC17C03
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 02:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B42181C830C8
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 01:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6432D8365;
	Wed, 29 Oct 2025 01:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fbmkzoOw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC041F0E32
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 01:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699968; cv=none; b=cf9reruiXbboeIEI4njTxgQIpzeQrOmoZu86HpKqbIQz+u7DBuAbKxAFLp7K0OstaD3DkmH31/oa0uBPsECGVbCzpkURZx9E/o2CkRtumggX9cAA7f6oultH9HvMp35mkrUblKhqr+Nj7JKlVOZILFN6TuU2lKjA6qhtNnDb3rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699968; c=relaxed/simple;
	bh=4rKXcsEqAaajDIbcVK5FPPjANzPZ+F4xSPgFyTeC6As=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bY8Js3gGIhZJDXcvkgqmr+4cBeqT/0N/G03YbjHnW1ZDoJL38UX59AWM/2NwXeRo0P798ZsZ1H7us0YRcdoFMIWk55e9ThtkedsXK6/2n+E8qfM/oI4h8t9y18Y/FNof0X1jTci3LtVvhqbzQImzfQx84w7IPSSKfa/NBhbcFf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fbmkzoOw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761699964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LqvZkVwS4D/DMvfxtfY0zM5tRus8vTjeQLDhqse9kWE=;
	b=fbmkzoOwX1t+R8MD3FCYUkw2kciR8cM7khha/TPRAPB0QCJLhD1hnTOpdxTROiD+NR/ar/
	61bm9i9Ea/2j3sckRuJguPFuf/JqnG4utUbbAtE2C+0NjbGtIwUYBhKDA1cBgV2KHjrHL/
	OWPlrspDUxlHImc2yryJziGXjS5vS60=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-YHJqdnxaMy2HYL-jcz7Lsw-1; Tue, 28 Oct 2025 21:06:03 -0400
X-MC-Unique: YHJqdnxaMy2HYL-jcz7Lsw-1
X-Mimecast-MFC-AGG-ID: YHJqdnxaMy2HYL-jcz7Lsw_1761699963
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-5db93df6957so40791137.3
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 18:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761699963; x=1762304763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LqvZkVwS4D/DMvfxtfY0zM5tRus8vTjeQLDhqse9kWE=;
        b=Wn+4bjQS/q1E8Myqq62uVq6/NZmgTgsOIjqN8c866XaD4/+TPr97DCUJOa9VFTFnk1
         jYn/ILT9iPb9jLXahLqtX/ecseX0uwLUuhUWeSAbqcCQQPi0X5UL7fLr/iSnDRfp+6qR
         0wlhnl4ixZ8S+YA9TdMQ5TEbUl8iPMOuZ653AXrONQ8CsIWV/agI+6rdUDAgun7ol2CJ
         hWc2E2UJXjGXHLcCfpS3JXib6PwNJJ9TaaXYaBgHzImcxCRfBU/Q77lhxaX8AbgL21dm
         sHmyteLkzkx6IlXHRTFR3MCtmGUFIcmT0VEN7/QZ4IvhpVijmhTJUAYmqor0KdVqJBQN
         4TQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw/Oz1nnXJRR+3xkVzsX6bbTeqDVZT7DO6BsR70QrVpBnZxOlIjkRhaYMe9x66mM9cra6IDao=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzDYQRPw0pENu2sInms+PFaXK9MTy0y41yJ62CQIj3CIeI1wh4
	JqkACmAAXcV7TBQi5Ooe5pJoL6oMSO8P38Bfbp1P4y/PGzvlZjSeF/lWF/ROcHxFyWzlBUW9wBX
	rgEVg4alZ8Ih+mJjOReh6PhjekhVFlyqbQE9i9ejGmhQy8Hi59kYRJs6wxdu9e3EKYW+04ciIOA
	YPVyNbOfl4nD7jPyJdphhyGXqvOKyb/juQ
X-Gm-Gg: ASbGncvlYNEeQaEsNK6OPeGuh/p8YPqkA1tKQeDDOHHfnxeYcm1scx2j3v+P+ONiGu1
	shMUc/4dXjsILHDUe30kZalzEMreNeb7mZB30Fy6BXQgDRHZzxXacAwpyU6R+ToqdONtesnAe/I
	SZYnRAZk6Ho0g3Adk+b6bsnxMgxhtS6iCDl+HZqKNiVncQmi4Co66r8mim
X-Received: by 2002:a05:6102:c89:b0:5d5:f6ae:38cd with SMTP id ada2fe7eead31-5db906bf09fmr320205137.44.1761699962668;
        Tue, 28 Oct 2025 18:06:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFI/zaw38+AhmGbx6A3agVStmL8oTqW3Nz5bSSlh7PFtDfaccTBJ4Rd1laBz7CD0TnxQIXxp/IVhKrIuqX/41k=
X-Received: by 2002:a05:6102:c89:b0:5d5:f6ae:38cd with SMTP id
 ada2fe7eead31-5db906bf09fmr320197137.44.1761699962213; Tue, 28 Oct 2025
 18:06:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028030341.46023-1-jasowang@redhat.com> <20251028101144-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251028101144-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 29 Oct 2025 09:05:47 +0800
X-Gm-Features: AWmQ_blsWiXuIt1RoBQUCAMZu2u9gBaPh9UlZ-pGRBO9KBYUDMeLmbYbRVF99MU
Message-ID: <CACGkMEu9AMtTn6cZjW=N+OJZMLqgaiLiAS6V0EhuA7fSeXJ69A@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: calculate header alignment mask based on features
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 10:39=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Tue, Oct 28, 2025 at 11:03:41AM +0800, Jason Wang wrote:
> > Commit 56a06bd40fab ("virtio_net: enable gso over UDP tunnel support.")
> > switches to check the alignment of the virtio_net_hdr_v1_hash_tunnel
> > even when doing the transmission even if the feature is not
> > negotiated. This will cause
>
>
> you mean this causes
>
> >a series performance degradation of pktgen
> > as the skb->data can't satisfy the alignment requirement due to the
> > increase of the header size then virtio-net must prepare at least 2
> > sgs with indirect descriptors which will introduce overheads in the
>
>
> introduces, accordinglt
>
> > device.
> >
> > Fixing this by calculate the header alignment during probe so when
> > tunnel gso is not negotiated, we can less strict.
> >
> > Pktgen in guest + XDP_DROP on TAP + vhost_net shows the TX PPS is
> > recovered from 2.4Mpps to 4.45Mpps.
> >
> > Note that we still need a way to recover the performance when tunnel
> > gso is enabled, probably a new vnet header format.
>
> you mean improve, not recover as such

The PPS drops to 2.4Mpps after the 56a06bd40fab, so this patch
recovers it the number before 56a06bd40fab.

>
>
> >
> > Fixes: 56a06bd40fab ("virtio_net: enable gso over UDP tunnel support.")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/net/virtio_net.c | 21 +++++++++++++++------
> >  1 file changed, 15 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 31bd32bdecaf..5b851df749c0 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -441,6 +441,9 @@ struct virtnet_info {
> >       /* Packet virtio header size */
> >       u8 hdr_len;
> >
> > +     /* header alignment */
> > +     size_t hdr_align;
> > +
>
> It makes no sense to have u8 for length but size_t for alignment,
> and u8 would fit in a memory hole we have, anyway.

Oh right.


>
> >       /* Work struct for delayed refilling if we run low on memory. */
> >       struct delayed_work refill;
> >
> > @@ -3308,8 +3311,9 @@ static int xmit_skb(struct send_queue *sq, struct=
 sk_buff *skb, bool orphan)
> >       pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
> >
> >       can_push =3D vi->any_header_sg &&
> > -             !((unsigned long)skb->data & (__alignof__(*hdr) - 1)) &&
> > +             !((unsigned long)skb->data & (vi->hdr_align - 1)) &&
>
>
> So let me get it straight.
> We use the alignment check to be able to cast to the correct type.
> The issue is that alignment for the header changed.
>
> virtio_net_hdr_v1 has 2 byte alignment, but:
>
>
>
> struct virtio_net_hdr_v1_hash {
>         struct virtio_net_hdr_v1 hdr;
>         __le32 hash_value;
> #define VIRTIO_NET_HASH_REPORT_NONE            0
> #define VIRTIO_NET_HASH_REPORT_IPv4            1
> #define VIRTIO_NET_HASH_REPORT_TCPv4           2
> #define VIRTIO_NET_HASH_REPORT_UDPv4           3
> #define VIRTIO_NET_HASH_REPORT_IPv6            4
> #define VIRTIO_NET_HASH_REPORT_TCPv6           5
> #define VIRTIO_NET_HASH_REPORT_UDPv6           6
> #define VIRTIO_NET_HASH_REPORT_IPv6_EX         7
> #define VIRTIO_NET_HASH_REPORT_TCPv6_EX        8
> #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
>         __le16 hash_report;
>         __le16 padding;
> };
>
>
> has 4 byte due to hash_value, and accordingly:
>
>
> struct virtio_net_hdr_v1_hash_tunnel {
>         struct virtio_net_hdr_v1_hash hash_hdr;
>         __le16 outer_th_offset;
>         __le16 inner_nh_offset;
> };
>
>
> now is 4 byte aligned so everything is messed up:
> net tends not to be 4 byte aligned.
>
>
>
>
> >               !skb_header_cloned(skb) && skb_headroom(skb) >=3D hdr_len=
;
> > +
> >       /* Even if we can, don't push here yet as this would skew
> >        * csum_start offset below. */
> >       if (can_push)
> > @@ -6926,15 +6930,20 @@ static int virtnet_probe(struct virtio_device *=
vdev)
> >       }
> >
> >       if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) |=
|
> > -         virtio_has_feature(vdev, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO))
> > +         virtio_has_feature(vdev, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO)) {
> >               vi->hdr_len =3D sizeof(struct virtio_net_hdr_v1_hash_tunn=
el);
> > -     else if (vi->has_rss_hash_report)
> > +             vi->hdr_align =3D __alignof__(struct virtio_net_hdr_v1_ha=
sh_tunnel);
> > +     } else if (vi->has_rss_hash_report) {
> >               vi->hdr_len =3D sizeof(struct virtio_net_hdr_v1_hash);
> > -     else if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF) ||
> > -              virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
> > +             vi->hdr_align =3D __alignof__(struct virtio_net_hdr_v1_ha=
sh);
> > +     } else if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF) ||
> > +             virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> >               vi->hdr_len =3D sizeof(struct virtio_net_hdr_mrg_rxbuf);
> > -     else
> > +             vi->hdr_align =3D __alignof__(struct virtio_net_hdr_mrg_r=
xbuf);
> > +     } else {
> >               vi->hdr_len =3D sizeof(struct virtio_net_hdr);
> > +             vi->hdr_align =3D __alignof__(struct virtio_net_hdr);
> > +     }
> >
> >       if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CS=
UM))
> >               vi->rx_tnl_csum =3D true;
>
> So how about just fixing the root cause then?
> Like this (untested, if you agree pls take over this):
>
> ---
>
> virtio_net: fix alignment for virtio_net_hdr_v1_hash
>
>
> changing alignment of header would mean it's no longer safe to cast a 2
> byte aligned pointer between formats. Use two 16 bit fields to make it 2
> byte aligned as previously.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

This looks indeed better, will go this way.

>
> --
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 31bd32bdecaf..02ce5316f47d 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2535,6 +2535,13 @@ static struct sk_buff *receive_mergeable(struct ne=
t_device *dev,
>         return NULL;
>  }
>
> +static inline u16

Should be u32.

> +virtio_net_hash_value(const struct virtio_net_hdr_v1_hash *hdr_hash)
> +{
> +       return __le16_to_cpu(hdr_hash->hash_value_lo) |
> +               (__le16_to_cpu(hdr_hash->hash_value_hi) << 16);
> +}
> +
>  static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr=
_hash,
>                                 struct sk_buff *skb)
>  {
> @@ -2561,7 +2568,7 @@ static void virtio_skb_set_hash(const struct virtio=
_net_hdr_v1_hash *hdr_hash,
>         default:
>                 rss_hash_type =3D PKT_HASH_TYPE_NONE;
>         }
> -       skb_set_hash(skb, __le32_to_cpu(hdr_hash->hash_value), rss_hash_t=
ype);
> +       skb_set_hash(skb, virtio_net_hash_value(hdr_hash), rss_hash_type)=
;
>  }
>
>  static void virtnet_receive_done(struct virtnet_info *vi, struct receive=
_queue *rq,
> @@ -3307,6 +3314,10 @@ static int xmit_skb(struct send_queue *sq, struct =
sk_buff *skb, bool orphan)
>
>         pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
>
> +       /* Make sure it's safe to cast between formats */
> +       BUILD_BUG_ON(__alignof__(*hdr) !=3D __alignof__(hdr->hash_hdr));
> +       BUILD_BUG_ON(__alignof__(*hdr) !=3D __alignof__(hdr->hash_hdr.hdr=
));
> +
>         can_push =3D vi->any_header_sg &&
>                 !((unsigned long)skb->data & (__alignof__(*hdr) - 1)) &&
>                 !skb_header_cloned(skb) && skb_headroom(skb) >=3D hdr_len=
;
> @@ -6755,7 +6766,7 @@ static int virtnet_xdp_rx_hash(const struct xdp_md =
*_ctx, u32 *hash,
>                 hash_report =3D VIRTIO_NET_HASH_REPORT_NONE;
>
>         *rss_type =3D virtnet_xdp_rss_type[hash_report];
> -       *hash =3D __le32_to_cpu(hdr_hash->hash_value);
> +       *hash =3D virtio_net_hash_value(hdr_hash);
>         return 0;
>  }
>
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_=
net.h
> index 8bf27ab8bcb4..1db45b01532b 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -193,7 +193,8 @@ struct virtio_net_hdr_v1 {
>
>  struct virtio_net_hdr_v1_hash {
>         struct virtio_net_hdr_v1 hdr;
> -       __le32 hash_value;
> +       __le16 hash_value_lo;
> +       __le16 hash_value_hi;
>  #define VIRTIO_NET_HASH_REPORT_NONE            0
>  #define VIRTIO_NET_HASH_REPORT_IPv4            1
>  #define VIRTIO_NET_HASH_REPORT_TCPv4           2
>

Thanks


