Return-Path: <netdev+bounces-235543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 045C5C32574
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 18:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0890E18C15D8
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 17:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E14A33438F;
	Tue,  4 Nov 2025 17:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bDh4omAh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GiUvoRHC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9681927B4F5
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 17:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762276934; cv=none; b=sTarcHI5iiQXlnsTcJ/Nie9PWT7B90pmVLxOsGJ/SEdaF7xySqi0KpFq4Y6c1vL/U2c9WGLLB+l9OLYLuZwxzM3s/IDuy10OmpjC/tLesC+R+WOKsLh91QPC05CqfcsZIe9x/7gMLQfQiKAuAZ5IeEaXqX/1rDEpHukev/orD2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762276934; c=relaxed/simple;
	bh=RN85k6AHL2pQ5CqZYH41YO/5F+DbetbZxo60cWxsByA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iUwRibT6U/AnYlzQ9ByfXiJnMC71G2VoSVx9zI92ss7WGr7Rw2WLuXWySAVlkz/pch5HTDHpfydgVk7WgomCygb51Sz/oyEH8DYymZgp/NYqfZUdtdxQXv+TbgXG6K/vhW9dZy5UHxWENE/WCXnwfZX3lYM5nt8UyzaSrdB1xHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bDh4omAh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GiUvoRHC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762276930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dXDflPqYnW7EZU/LpvY0qXtFQSuEG8JnIwAlz6RqROg=;
	b=bDh4omAhIT2QQRnVQP8OWq3ud31C1hox/xcSWnCEYAcQV7Cs6A/N13NXEqoU6yvzBoSqIW
	LEfYXwHmLMmdOT30Waw26EqWj+awYstZMT5ZzNp2f74qiC6lkurIhJPv/yfNk6VKdTTRf2
	RySQlf+kHHxbkVDT4/iY0yiEaZMLc/8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-o_v88UrIOL-KEM_LRgEz5w-1; Tue, 04 Nov 2025 12:22:09 -0500
X-MC-Unique: o_v88UrIOL-KEM_LRgEz5w-1
X-Mimecast-MFC-AGG-ID: o_v88UrIOL-KEM_LRgEz5w_1762276928
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b7067f229b8so464048066b.2
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 09:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762276928; x=1762881728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXDflPqYnW7EZU/LpvY0qXtFQSuEG8JnIwAlz6RqROg=;
        b=GiUvoRHC8afr/zm8vjTDvcuc/OQT30EV921gX48bxlt7xRVABCzalh4tayiN58E36U
         EVg45xWfTs0MRaXmxnGzKIrj+IBbjNxW0TWOHS7Zzd4riCjIvUegXE6o4R9eSC0E93j1
         U0XcAs/hZeetRbMPXr7jBNY6fOmxeOd6iXIjbA4ETtkds/9PVwqKi//xoovH94kraoXR
         JXjpbIuGwbtpum74rQwYQ7Ruv52ox3GqnMpzIXeqee99OI4RcPVTE0k3864HuZf15ANm
         XBInL8qivKepvpq9mC3I38Go49LwKL3O5giiyN2wSjpNamJi9i2vqGF8sYkGX8enqD9f
         KcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762276928; x=1762881728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXDflPqYnW7EZU/LpvY0qXtFQSuEG8JnIwAlz6RqROg=;
        b=Hu1w2kviY1M0msiZfUyJ4qQn45jQv0zt2ykfCe/oiZJeFgPbGh7gPSFIwC4N4TYZ1X
         aflNX/vYxRWYVSZLlp1jkEh/ZJVTzLeXKvTydvO29c5pk5MJqQ8UND81OaCX4ThJrDTG
         KhWvHHMxY0tKY9aAkDe5yELBIj58hiiUcs6vqGXTjyKCWePqf9An488nSWGoO5DOk7Zq
         bIyJHYnM6gAcVLLsaYLtf4uXdsa+Bh7T4FE2khuTm+4rKNhl0CVX54GQ7lF0fnhdAGy5
         1b56p478Cg7FvKLvwh1QCIvUqrVI9dUtVXMKta7VSuLyp/WyAFMpmHJ+yLEWs+2VS9mK
         /faw==
X-Forwarded-Encrypted: i=1; AJvYcCXQ5vteK+2sxt2o8KyoiQy3S94VmvWOydSG12QIriKiWwXWYYTtszH+yFz5Y/ZEwauubIaODJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8EEMD+zEzTjdqvqI9JfDPiunvfxgWPiPHopZnYD/WhfIEpwpZ
	edPeqh4qUi+eIsSdJYVmsvMUNNP5fd5ocQaGrtK5MTIiqX6z04GiEmsC1WfbVGLbXuFpl3Bi+6P
	69uWuPrqtmR2Sg3jxzL5aM8GHJP/2wrKQ3EN8uJaM13Tjf7p+BdA8IROGmZGh2qwS6OsU4ysRat
	/EGoyXExnQcvnxw8M9odVWrAPLEqbxKvj/
X-Gm-Gg: ASbGncs1MJDoixipAyWitBhou1703d4vvi6RxZYNYH/Z6dVWaKn1VLUgu5Fl93mlW+X
	nELVN6xhLbnrJL7gt4deDxatgjrFqSgyb9dRAtoZwWHcPjNWAat8GprPcVLFYpnsqjDRe8LN5zD
	VvU1kjllmb7IODkExwWUZdx5d9EY+bD1JosodOFiVJLir7+QC7MHk0Wywp
X-Received: by 2002:a17:906:dc92:b0:b71:88eb:e60c with SMTP id a640c23a62f3a-b7188ebf492mr614834666b.44.1762276928042;
        Tue, 04 Nov 2025 09:22:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmS15xkBQlo46WUljLA50Fixrdz+Xfp9YJOuOn440rslgPxVsSs5bO8JGYSwoCQVGwl9vZDe3sCRPYTRWVVjg=
X-Received: by 2002:a17:906:dc92:b0:b71:88eb:e60c with SMTP id
 a640c23a62f3a-b7188ebf492mr614831566b.44.1762276927657; Tue, 04 Nov 2025
 09:22:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031060551.126-1-jasowang@redhat.com>
In-Reply-To: <20251031060551.126-1-jasowang@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 5 Nov 2025 01:21:29 +0800
X-Gm-Features: AWmQ_bmCsEsZ54yScl_2yysAyvg-JGUKJB9xsSDFcnkTf1mDrO5lo_hg0ahm2LQ
Message-ID: <CAPpAL=ybrp2kBCLivWpX_0NpV7tiCS26o6tzeDea6RWsAkS2Hg@mail.gmail.com>
Subject: Re: [PATCH net V2] virtio_net: fix alignment for virtio_net_hdr_v1_hash
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this patch with virtio-net regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Fri, Oct 31, 2025 at 2:06=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> From: "Michael S. Tsirkin" <mst@redhat.com>
>
> Changing alignment of header would mean it's no longer safe to cast a
> 2 byte aligned pointer between formats. Use two 16 bit fields to make
> it 2 byte aligned as previously.
>
> This fixes the performance regression since
> commit ("virtio_net: enable gso over UDP tunnel support.") as it uses
> virtio_net_hdr_v1_hash_tunnel which embeds
> virtio_net_hdr_v1_hash. Pktgen in guest + XDP_DROP on TAP + vhost_net
> shows the TX PPS is recovered from 2.4Mpps to 4.45Mpps.
>
> Fixes: 56a06bd40fab ("virtio_net: enable gso over UDP tunnel support.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> Changes since V1:
> - Fix build issues of virtio_net_hdr_tnl_from_skb()
> ---
>  drivers/net/virtio_net.c        | 15 +++++++++++++--
>  include/linux/virtio_net.h      |  3 ++-
>  include/uapi/linux/virtio_net.h |  3 ++-
>  3 files changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8e8a179aaa49..e6e650bc3bc3 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2539,6 +2539,13 @@ static struct sk_buff *receive_mergeable(struct ne=
t_device *dev,
>         return NULL;
>  }
>
> +static inline u32
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
> @@ -2565,7 +2572,7 @@ static void virtio_skb_set_hash(const struct virtio=
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
> @@ -3311,6 +3318,10 @@ static int xmit_skb(struct send_queue *sq, struct =
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
> @@ -6750,7 +6761,7 @@ static int virtnet_xdp_rx_hash(const struct xdp_md =
*_ctx, u32 *hash,
>                 hash_report =3D VIRTIO_NET_HASH_REPORT_NONE;
>
>         *rss_type =3D virtnet_xdp_rss_type[hash_report];
> -       *hash =3D __le32_to_cpu(hdr_hash->hash_value);
> +       *hash =3D virtio_net_hash_value(hdr_hash);
>         return 0;
>  }
>
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 4d1780848d0e..b673c31569f3 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -401,7 +401,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb=
,
>         if (!tnl_hdr_negotiated)
>                 return -EINVAL;
>
> -        vhdr->hash_hdr.hash_value =3D 0;
> +       vhdr->hash_hdr.hash_value_lo =3D 0;
> +       vhdr->hash_hdr.hash_value_hi =3D 0;
>          vhdr->hash_hdr.hash_report =3D 0;
>          vhdr->hash_hdr.padding =3D 0;
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
> --
> 2.31.1
>
>


