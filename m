Return-Path: <netdev+bounces-129445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3358B983F2E
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 09:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63C341C22769
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 07:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178171494CE;
	Tue, 24 Sep 2024 07:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ve7cfpUS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7557B1494B3
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 07:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163321; cv=none; b=jdpnLWK84KvlHjtV9IkLb6W5xNhHj52D3JSKOQdljjFJQvLhtKalu/EDylXoM8SwZptsI7gTWNcN7lPIPSNWvz5+EhnRR52fqExiBi4r1pEu4+JCrzGvnwcnmvIqFFRdDXId2GkGlCwjfmu6Obt0HO6bA5fyM94GOXSw41F5NII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163321; c=relaxed/simple;
	bh=gd9TLfoZx2F+kEdm7NZ/WMO9UVX62rFrq7W3T+xr/gE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EeiHAct4QBW8HRFZNiaifOT2qET9o1bYR9XUUDjJI7Wb7MIDhdskxuSRNv0t2uZ4ML5/8frEnIDIQPBjX30A2tbdgbqfuUJpujHYV/+bCTsjv/fVx7s64q46Ha8ztuBYsoPBfiCxT7KdioQh450icvoa6zJjgJe94qVth6jcq4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ve7cfpUS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727163318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cPeVxGad0rWL+6l63ORIof7v2WZ21lQlNY9saN2Whdc=;
	b=Ve7cfpUSS1lElrR88iMTIQB7LfNVuoCwvxoeImabIf57sRCP8jPvZiBNHqIBGgiVKTWnws
	OrAQC3FxCA5Nifjr0zYEdcGv2iu7dHyZrlSRVcNIB01uxAZGCr84vg/9AWARKvs1L98jTg
	BY2gKwt4SCRgg3yjnCeZ4H6o6oXdWZ8=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-UEUO9ly1PrOxPXsXHmkF3g-1; Tue, 24 Sep 2024 03:35:17 -0400
X-MC-Unique: UEUO9ly1PrOxPXsXHmkF3g-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7177906db91so5579651b3a.3
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 00:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727163316; x=1727768116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPeVxGad0rWL+6l63ORIof7v2WZ21lQlNY9saN2Whdc=;
        b=TEx4W0RvFjrgQYmHuW6E/TvzoJzt85s+niIfc0OFTLnK2EFnZpVlmJMS7U/HVKUhn1
         X1PYew/IDIoCl1qEJK8wwukxs6uEznYwWzlED8GYFNOakMoTbTwAca9lW6iYORA/I+P8
         zvgou2UNW6gmTdPs13zfy9SOFC/QvNhsX55yozLkC3S+K7Y5ExROwj9yFtzPWHV7qXcY
         8Eg1vwto18rRKNn0KX1BuwQORy8Qb1h+Y0und9otJsf/IMaVm01XplMVuAupvnODvw6t
         wjn/JJLosF+5hyXTRxcng3MFkovHnV+Q7RzqkBDi5W0MapmrgQQmGsFHrkN77ybTQtru
         BOgA==
X-Gm-Message-State: AOJu0YyPADwq5iSefI1r5W1Ng7X9AZM5mzoR8eAIDxcGwIu6fCn91JSq
	c8NZP9kLuwtMRXlTkESXckQMwkalT6C/MkWBHB8yC+TNUUdCuFPsR+2mSQDX8qhUDLAla4n6nkg
	JlPmrecz/vUPv3Zl7MaDw6MjtSqfmaiW41EazeCMV15E4jTSxEaEj/2LaJYOJeST0UCimKnT9oj
	1PnxHxJE5GuJpghAqiYLPSpJla9lOU
X-Received: by 2002:a05:6a20:d525:b0:1d0:56b1:1c59 with SMTP id adf61e73a8af0-1d30a9fb7b3mr19470595637.32.1727163315963;
        Tue, 24 Sep 2024 00:35:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx/soIIabkJ0QhCDlDO4PjZWR1FTyoTbioUpQfhFh0yWY1kmlQ/qO18q1LS4ki5NKSTFvtS8mDzJ3BNF/H4wk=
X-Received: by 2002:a05:6a20:d525:b0:1d0:56b1:1c59 with SMTP id
 adf61e73a8af0-1d30a9fb7b3mr19470570637.32.1727163315542; Tue, 24 Sep 2024
 00:35:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924013204.13763-1-xuanzhuo@linux.alibaba.com> <20240924013204.13763-8-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240924013204.13763-8-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 24 Sep 2024 15:35:03 +0800
Message-ID: <CACGkMEtbNrwbxhRbjHGiEQeQbWUb2iL0ZtyosXs4_+GoZY-Gsw@mail.gmail.com>
Subject: Re: [RFC net-next v1 07/12] virtio_net: refactor the xmit type
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 9:32=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Because the af-xdp will introduce a new xmit type, so I refactor the
> xmit type mechanism first.
>
> In general, pointers are aligned to 4 or 8 bytes.

I think this needs some clarification, the alignment seems to depend
on the lowest common multiple between the alignments of all struct
members. So we know both xdp_frame and sk_buff are at least 4 bytes
aligned.

If we want to reuse the lowest bit of pointers in AF_XDP, the
alignment of the data structure should be at least 4 bytes.

> If it is aligned to 4
> bytes, then only two bits are free for a pointer. But there are 4 types
> here, so we can't use bits to distinguish them. And 2 bits is enough for
> 4 types:
>
>     00 for skb
>     01 for SKB_ORPHAN
>     10 for XDP
>     11 for af-xdp tx
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 90 +++++++++++++++++++++++-----------------
>  1 file changed, 51 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 630e5b21ad69..41a5ea9b788d 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -45,9 +45,6 @@ module_param(napi_tx, bool, 0644);
>  #define VIRTIO_XDP_TX          BIT(0)
>  #define VIRTIO_XDP_REDIR       BIT(1)
>
> -#define VIRTIO_XDP_FLAG                BIT(0)
> -#define VIRTIO_ORPHAN_FLAG     BIT(1)
> -
>  /* RX packet size EWMA. The average packet size is used to determine the=
 packet
>   * buffer size when refilling RX rings. As the entire RX ring may be ref=
illed
>   * at once, the weight is chosen so that the EWMA will be insensitive to=
 short-
> @@ -512,34 +509,35 @@ static struct sk_buff *virtnet_skb_append_frag(stru=
ct sk_buff *head_skb,
>                                                struct page *page, void *b=
uf,
>                                                int len, int truesize);
>
> -static bool is_xdp_frame(void *ptr)
> -{
> -       return (unsigned long)ptr & VIRTIO_XDP_FLAG;
> -}
> +enum virtnet_xmit_type {
> +       VIRTNET_XMIT_TYPE_SKB,
> +       VIRTNET_XMIT_TYPE_SKB_ORPHAN,
> +       VIRTNET_XMIT_TYPE_XDP,
> +};
>
> -static void *xdp_to_ptr(struct xdp_frame *ptr)
> -{
> -       return (void *)((unsigned long)ptr | VIRTIO_XDP_FLAG);
> -}
> +/* We use the last two bits of the pointer to distinguish the xmit type.=
 */
> +#define VIRTNET_XMIT_TYPE_MASK (BIT(0) | BIT(1))
>
> -static struct xdp_frame *ptr_to_xdp(void *ptr)
> +static enum virtnet_xmit_type virtnet_xmit_ptr_strip(void **ptr)

Nit: not a native speaker but I think something like pack/unpack might
be better.

With those changes.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


