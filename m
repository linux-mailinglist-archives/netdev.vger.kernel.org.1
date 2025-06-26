Return-Path: <netdev+bounces-201396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E8AAE9468
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 04:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24CD53AE562
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 02:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1DD1F4CA9;
	Thu, 26 Jun 2025 02:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U2/RTvQa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535C81482F5
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 02:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750906279; cv=none; b=EXxXqRvXDKtMC2dUh/8zlMy5B2JYZpUZgLzLPohBuETxuqKzK9hjy7SIQbwm1svyKcPemceMpa9mMkFvvgakqSfpjwvRwoKiBDFd53PU/VAV9HPeqzQQMJGm1/bQD41ul6WAFAVW61+tCeqqPvHGWoWIl5et+DZdCZcBp/mPQ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750906279; c=relaxed/simple;
	bh=AbbTcY3G90uhbAvwfnDrpva8mh1yG4yY6IHShSbbWSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rl3YYboEqmaR11Etg2G6X+dMbcd7kOu5pUyu08d7WIRFw9JFpHBZztqDDkcYRL00yJDkOza42pTVkhxZ1Z3iRm4tK1WefSY9NwEoapuKu9bTDm51FlodKCqhpu8TqLLBysWprQWI4EDXj4MF9QxeT/mFXfMYisPkfBFPOXdsS+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U2/RTvQa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750906277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xEngYMz6+Uctu+0RSamLzUn3jyWMAMQ76O4pVQprsBY=;
	b=U2/RTvQaj2Vd1ovvx+qdyzQReQldrpVvTpCRA3+qDSqJ3+o12ptAh9JTk8DUNL2CsmrQBm
	tqxItymnZC0qTdne9nQV05P5la0AG3X10vHCvMWtAo3A2aWW31QWd8cUG672RAYrmZAJxS
	YJHFSZbrcIQIUs8ULCIEfj/GtkHB9P8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-0-OdhShBNFyZ9Ua4xU3RKA-1; Wed, 25 Jun 2025 22:51:14 -0400
X-MC-Unique: 0-OdhShBNFyZ9Ua4xU3RKA-1
X-Mimecast-MFC-AGG-ID: 0-OdhShBNFyZ9Ua4xU3RKA_1750906273
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-313f8835f29so782545a91.3
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 19:51:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750906273; x=1751511073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEngYMz6+Uctu+0RSamLzUn3jyWMAMQ76O4pVQprsBY=;
        b=wtZroHQI3glw9sm1fN9aR04LPmki4EQOU810iMI2v+nBZ/KJg0GJHLRUQMbM5MO++2
         X4Zu8pUB5kE/fEPHrLnr7mtUW/LBzrWlJreb6v+lS6TYNfhbseXx8G/mVmenDp+U0JZW
         CwxT88UWTo78C3fO1EJRxkoSS8i0uZ90SYrZES2yPcebBr1mMvNRSjpqzMEyvOtipqV1
         AOc7WbdvndkkirwnWWhSHwkqfA/TV3Et+vEjiXPNQ2NqH3fBJh3BDH9MYVT1aZU4ymj1
         To8CtDISI5LMBKgbdS1czWSFo5rbFiOgGNMTYYTs3Bmd6mRIfSW8yTAscqlE+X9SewUw
         Bk0A==
X-Gm-Message-State: AOJu0YxyS5mbtncFIqev4zQM+KB77pBkwbB/K8AxXrYUbIwcJXJPylpz
	+zrNAhj8IZow0bcjB9+0hAJJdvZCmHHkEGTAnzOs4TckxbKJsJhFiJ4PB0UmkoLsVZuz/B2C9gQ
	+s8K8XMkFlc2skWgF2fKTlI3R4g7TVtkKyUbROq00YBNk+k9GH7Q4wjCcR8K81erMBv79F3LpHu
	XZ5bWM0N4DMNVc7gU+6wkNPPhrgB6gWy4h
X-Gm-Gg: ASbGncu1FeQhAXb3XsGHMZ6znQ7RLpY/ATmyOhR3qwx+dV98ZzbPhlBGjqu9Z+0sC37
	RO1fYgHFQ+QWO2vv8+MmVuFD6KHjp7mg+Ld6BVMirvh6B+NEonR/9C3GioBd/hlEsrT+zbXZjyM
	uGSwh/
X-Received: by 2002:a17:90b:562d:b0:30e:3718:e9d with SMTP id 98e67ed59e1d1-315f26b3e52mr7507603a91.35.1750906273389;
        Wed, 25 Jun 2025 19:51:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFy1oEFNW+pNyBHKxl5UFz4XuW+PyQ5F7+ZNjbo3jFzhfPpd3FRUMNsXAMnW3CCIEXyQmt+3K6tjBWZQ09ordg=
X-Received: by 2002:a17:90b:562d:b0:30e:3718:e9d with SMTP id
 98e67ed59e1d1-315f26b3e52mr7507572a91.35.1750906273025; Wed, 25 Jun 2025
 19:51:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625160849.61344-1-minhquangbui99@gmail.com> <20250625160849.61344-5-minhquangbui99@gmail.com>
In-Reply-To: <20250625160849.61344-5-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 26 Jun 2025 10:51:01 +0800
X-Gm-Features: Ac12FXxCVxp6548gkQ8YE-vjFv3IjVZGUSKTIBIUxHnJq7DtVbLHmVNL-WVcg1k
Message-ID: <CACGkMEv-EgkZs6d4MHwxj0t_-pQvxMRLTdgguP7GUijbg-kEoA@mail.gmail.com>
Subject: Re: [PATCH net 4/4] virtio-net: allow more allocated space for
 mergeable XDP
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 12:10=E2=80=AFAM Bui Quang Minh
<minhquangbui99@gmail.com> wrote:
>
> When the mergeable receive buffer is prefilled before XDP is set, it
> does not reserve the space for XDP_PACKET_HEADROOM and skb_shared_info.
> So when XDP is set and this buffer is used to receive frame, we need to
> create a new buffer with reserved headroom, tailroom and copy the frame
> data over. Currently, the new buffer's size is restricted to PAGE_SIZE
> only. If the frame data's length + headroom + tailroom exceeds
> PAGE_SIZE, the frame is dropped.
>
> However, it seems like there is no restriction on the total size in XDP.
> So we can just increase the size of new buffer to 2 * PAGE_SIZE in that
> case and continue to process the frame.
>
> In my opinion, the current drop behavior is fine and expected so this
> commit is just an improvement not a bug fix.

Then this should go for net-next.

>
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/net/virtio_net.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 844cb2a78be0..663cec686045 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2277,13 +2277,26 @@ static void *mergeable_xdp_get_buf(struct virtnet=
_info *vi,
>                                               len);
>                 if (!xdp_page)
>                         return NULL;
> +
> +               *frame_sz =3D PAGE_SIZE;
>         } else {
> +               unsigned int total_len;
> +
>                 xdp_room =3D SKB_DATA_ALIGN(XDP_PACKET_HEADROOM +
>                                           sizeof(struct skb_shared_info))=
;
> -               if (*len + xdp_room > PAGE_SIZE)
> +               total_len =3D *len + xdp_room;
> +
> +               /* This must never happen because len cannot exceed PAGE_=
SIZE */
> +               if (unlikely(total_len > 2 * PAGE_SIZE))
>                         return NULL;
>
> -               xdp_page =3D alloc_page(GFP_ATOMIC);
> +               if (total_len > PAGE_SIZE) {
> +                       xdp_page =3D alloc_pages(GFP_ATOMIC, 1);

I'm not sure it's worth optimizing the corner case here that may bring
burdens for maintenance.

And a good optimization here is to reduce the logic duplication by
reusing xdp_linearize_page().


> +                       *frame_sz =3D 2 * PAGE_SIZE;
> +               } else {
> +                       xdp_page =3D alloc_page(GFP_ATOMIC);
> +                       *frame_sz =3D PAGE_SIZE;
> +               }
>                 if (!xdp_page)
>                         return NULL;
>
> @@ -2291,8 +2304,6 @@ static void *mergeable_xdp_get_buf(struct virtnet_i=
nfo *vi,
>                        page_address(*page) + offset, *len);
>         }
>
> -       *frame_sz =3D PAGE_SIZE;
> -
>         put_page(*page);
>
>         *page =3D xdp_page;
> --

Thanks

> 2.43.0
>


