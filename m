Return-Path: <netdev+bounces-104320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2FF90C23E
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 05:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED0CA283ED0
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 03:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCCC1CD35;
	Tue, 18 Jun 2024 03:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1O2db9t"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BEE1D9503
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 03:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718680244; cv=none; b=bc0bKTLFQ9cjfiO/GPDtaucR5GoiQSwqG+sJw6znlnk9MUOfsDp2DdiBh1mYHv/wN255YaC+CT7uhe1istLgOxrCtXr7ZA3krzce8Sk9uVxQ6R9MpzsmbSq0v1LDhJF3VoMyx3c6OlDnRh6tA/e0oJzHe2sxyaFwxTpz3dL2/F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718680244; c=relaxed/simple;
	bh=mEknhENwwwrGaRiRd6p+nKr0zrvmSIP/29CZKIBcELs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CuJShTjHziEm73odsIKA4MP90kZBxuaCsKS35j/tkoTZxm13gENLD1x+pukaAqbgaPwEGw+48OGdFYBL1SOGP0ySCbvDmeLr89Cdes9Bvsvd4K+C0BzvjnaozCBSbu15FYfZBPwSnFNGeXR8/uPWXyGXwk5xg8hamHIHkykhp7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I1O2db9t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718680241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qzWk7spTbqvkyeUSY8qLCJNvpfG6yw0e/buTa8U5CMI=;
	b=I1O2db9tPyQfjOkLcEtypaf0+D2bxFSRNbm/EFIaGaUTay6bob3Hj3WzPudpsUkMd8n7Nx
	xZ4qGaoBVzTkSY+IKa5cR5EiaJnU2ummQyfrGE/3JPpNF/tbo+jcKw4Jhls4FcAz0XX9DF
	T7IeE7xCtL7x5hoguOcpK8Gq099szkQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-EVKetfX_NKS0fFWYQt2QLg-1; Mon, 17 Jun 2024 23:10:39 -0400
X-MC-Unique: EVKetfX_NKS0fFWYQt2QLg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2c2e7927a77so5082685a91.3
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 20:10:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718680239; x=1719285039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzWk7spTbqvkyeUSY8qLCJNvpfG6yw0e/buTa8U5CMI=;
        b=ZyJiu2K/ezY4lnTnHFw2DYCdVaMiFgqMJadMsVb8LglkaC8CCOlNQwqucKccUyl+lc
         QdUKNH1oxLt/Jb/0uP/XbJduXUJxToIc+S+UUPwt9Tm0mjKhB+SlE7xXgdXCC/trmh7E
         73BImoFIyp/UPoplmKG7vtldaLM++dnm+sTg+xJbi2K0opEnSCty8lm1I4zu75SnWFW1
         S9RlNufneM1u+NaUo6xtSc51nMkqXBgDCT2ZZiKQM3a7AB4ti3ZaQVdpi78Seb61sixE
         W7N+bGOhnmDUMNiWlyoyREeZO64xv3+wKdX0Gr+UZ0bfrcWx90iNTZjCC6k4OVyCVMTY
         2cCg==
X-Gm-Message-State: AOJu0YykqJlJ+Lv8BEXUchhscIhPtVKRMeWK2AF31imv0wPyzSl7AXtS
	+lqJPtDyuCsKg2VRhsJ48+HWH8i35SrUJd8ZCOJAHpEx3+MpWTsCLkOU0n8TLhjEE72AUiYzEy5
	WTXnmBRD0jQCevxxBYTjlygM5+qOwNmbg8L6GcAfyorfBhB7Xnpe3gEfFRH5fGJ/2Jqd5wIyrG7
	hRdmHyYHtwO35lAhD9n1BU6mCXccH7
X-Received: by 2002:a17:90a:bd07:b0:2bf:7eb7:373b with SMTP id 98e67ed59e1d1-2c4dbd3104dmr9504807a91.33.1718680238688;
        Mon, 17 Jun 2024 20:10:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmAW8pUzP9tvdjhPj++hSVR41VPL8akkGk1TUVZbZOn9MdZKH7Z7iqtbei+8v/w6WnIsNsaywbXvGxYnGfIMk=
X-Received: by 2002:a17:90a:bd07:b0:2bf:7eb7:373b with SMTP id
 98e67ed59e1d1-2c4dbd3104dmr9504794a91.33.1718680238294; Mon, 17 Jun 2024
 20:10:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617131524.63662-1-hengqi@linux.alibaba.com> <20240617131524.63662-3-hengqi@linux.alibaba.com>
In-Reply-To: <20240617131524.63662-3-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Jun 2024 11:10:26 +0800
Message-ID: <CACGkMEvj8fvXkCxDFQ1-Cyq5DL=axEf1Ch1zVnuQUNQy6Wjn+g@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio_net: fixing XDP for fully checksummed packets handling
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	Thomas Huth <thuth@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 9:15=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
> The XDP program can't correctly handle partially checksummed
> packets, but works fine with fully checksummed packets.

Not sure this is ture, if I was not wrong, XDP can try to calculate checksu=
m.

Thanks

> If the
> device has already validated fully checksummed packets, then
> the driver doesn't need to re-validate them, saving CPU resources.
>
> Additionally, the driver does not drop all partially checksummed
> packets when VIRTIO_NET_F_GUEST_CSUM is not negotiated. This is
> not a bug, as the driver has always done this.
>
> Fixes: 436c9453a1ac ("virtio-net: keep vnet header zeroed after processin=
g XDP")
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index aa70a7ed8072..ea10db9a09fa 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1360,6 +1360,10 @@ static struct sk_buff *receive_small_xdp(struct ne=
t_device *dev,
>         if (unlikely(hdr->hdr.gso_type))
>                 goto err_xdp;
>
> +       /* Partially checksummed packets must be dropped. */
> +       if (unlikely(hdr->hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
> +               goto err_xdp;
> +
>         buflen =3D SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom) +
>                 SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>
> @@ -1677,6 +1681,10 @@ static void *mergeable_xdp_get_buf(struct virtnet_=
info *vi,
>         if (unlikely(hdr->hdr.gso_type))
>                 return NULL;
>
> +       /* Partially checksummed packets must be dropped. */
> +       if (unlikely(hdr->hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
> +               return NULL;
> +
>         /* Now XDP core assumes frag size is PAGE_SIZE, but buffers
>          * with headroom may add hole in truesize, which
>          * make their length exceed PAGE_SIZE. So we disabled the
> @@ -1943,6 +1951,7 @@ static void receive_buf(struct virtnet_info *vi, st=
ruct receive_queue *rq,
>         struct net_device *dev =3D vi->dev;
>         struct sk_buff *skb;
>         struct virtio_net_common_hdr *hdr;
> +       u8 flags;
>
>         if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
>                 pr_debug("%s: short packet %i\n", dev->name, len);
> @@ -1951,6 +1960,15 @@ static void receive_buf(struct virtnet_info *vi, s=
truct receive_queue *rq,
>                 return;
>         }
>
> +       /* 1. Save the flags early, as the XDP program might overwrite th=
em.
> +        * These flags ensure packets marked as VIRTIO_NET_HDR_F_DATA_VAL=
ID
> +        * stay valid after XDP processing.
> +        * 2. XDP doesn't work with partially checksummed packets (refer =
to
> +        * virtnet_xdp_set()), so packets marked as
> +        * VIRTIO_NET_HDR_F_NEEDS_CSUM get dropped during XDP processing.
> +        */
> +       flags =3D ((struct virtio_net_common_hdr *)buf)->hdr.flags;
> +
>         if (vi->mergeable_rx_bufs)
>                 skb =3D receive_mergeable(dev, vi, rq, buf, ctx, len, xdp=
_xmit,
>                                         stats);
> @@ -1966,7 +1984,7 @@ static void receive_buf(struct virtnet_info *vi, st=
ruct receive_queue *rq,
>         if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
>                 virtio_skb_set_hash(&hdr->hash_v1_hdr, skb);
>
> -       if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
> +       if (flags & VIRTIO_NET_HDR_F_DATA_VALID)
>                 skb->ip_summed =3D CHECKSUM_UNNECESSARY;
>
>         if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
> --
> 2.32.0.3.g01195cf9f
>


