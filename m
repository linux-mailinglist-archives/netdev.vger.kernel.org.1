Return-Path: <netdev+bounces-201733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A43AEACEB
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 04:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B957C4A6B2D
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 02:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F01194C96;
	Fri, 27 Jun 2025 02:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VDNM2pDL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3769F17A2FB
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 02:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750992149; cv=none; b=LJ3ECGd3qlg12jPM7Q6o9c57JPLDlGaJ90zb7BUFHo/kJl8/0HqUg4bjWbJ3+kHWVIxj80SZEdABobVUds61fTRk/lfmKuJpUDJP4+ju/sC4mydBw50cf/AJgw4VVJEhQpjr9jzb9FGj+3i1S/ZwGFG+ZXcvhap87036hC1RQGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750992149; c=relaxed/simple;
	bh=SdTf8Z6fyK/HZshyR2WSEcVEDgIXDaUI6GJQaYYwApU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dyj6qaelByAUdMl+38T6IrqzcJmwmPxO6lwiNGJmcmK0+97pahUyNafEaQedWkuw+RBlYl3PpYGJeDwwfZdqxjqiy2AHrPquckRxyESYHGd3nBUljxOttlMx2Cl0nlN4ziAVF6HIP7ywmwtbJ3l+A5cNv+blDUqqiigtDJX8OlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VDNM2pDL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750992146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0y4ogdWfKUskoLksqSv1cDEXTKy/QANfgQ8Wcutrwa0=;
	b=VDNM2pDLe88eJ3Z5jfsaDJrcfh835IFbV0ml1+L9e9lgzo/s7j7tBqUrec0ovfbu+3GHk5
	wx0aqvclrH6isWQptVpurLYdpiF1qQPyOR4eeC0/gIxiQkc/yKZDvsghi5uIlF542/cbL9
	cb9LaA8V0XkMai/2GNRRbIkhuryR8lc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-knIKmy3tPYOKWM5NcfB29g-1; Thu, 26 Jun 2025 22:42:24 -0400
X-MC-Unique: knIKmy3tPYOKWM5NcfB29g-1
X-Mimecast-MFC-AGG-ID: knIKmy3tPYOKWM5NcfB29g_1750992143
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-31327b2f8e4so1521552a91.1
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 19:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750992143; x=1751596943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0y4ogdWfKUskoLksqSv1cDEXTKy/QANfgQ8Wcutrwa0=;
        b=BKhCb3FbAJpia1aqg/yr3UXuIDM3teJOcyI3xuMiiKjjSnv28XwGNE3+GSTh1DrgJ2
         jrLo1v571XsaW+E9QJH+kXRPnZY/VV+adlIxdNv1kt2WjGXBatwc/p0amzf1dcXD8FAe
         390sqLnpgVTd64w2IuJ6cySWYi5w/VgK4LjBNdO3jU8lXTHtBycVOSmjnj/GYKL9+Ew2
         jQYXrPWzHWu0whW6jD4tpGG3NOsTfnT32ZqbY3rplFoFSardTKzXjjGFRa9IwLuWWEBm
         9RnGQIA/yjdtO9bGVBcJ5LWciYNEwXNmgmt6Q6Pb7yq2dSxmeYkhShY2KH46XJ6Lo/pb
         M9kA==
X-Gm-Message-State: AOJu0YyE5cpK2YhbUIqXCfcz8XX0AhJjdQEe0a77vlNWfZBMxHSSSI06
	UmuAxNvBJeQSsfcwCWeTh5PDFy6S6Vdxbf0QrYMGl6hqRESMBFi9my2g/3i33IFwicxFviT+g8c
	HH0LG1cy3goqfR9DDoIMohFiGHywp/Ux4YnRPhRiQ/RbyvpSBuKI025X8JBtIkZrqueUI63u0zU
	tQXFZsVy1poIjtfOWYdFCxJrYN3W/76dRr
X-Gm-Gg: ASbGncvh6CnI+L6hgK/8AIvrpNxkpwdMu1FppWTAJFqqwzWdP74SIC0/BvOsz8qWk6v
	To/oiZD0Btx7jFZKpkvXRR1E9PKBBCi9dxb/W25UYCFt9PhKgzOf317dVW6XYptAgZPeHrNG1FG
	/d
X-Received: by 2002:a17:90b:1f89:b0:312:1cd7:b337 with SMTP id 98e67ed59e1d1-318c911e00dmr1944388a91.5.1750992143505;
        Thu, 26 Jun 2025 19:42:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwGbHlkbt0ZZkXIHkgZ1VmAjcfzX3PaJulYFgYKAEcgaDwZicgMiljALERrT6XFmENjSrOdPALHnOlGHUcwhg=
X-Received: by 2002:a17:90b:1f89:b0:312:1cd7:b337 with SMTP id
 98e67ed59e1d1-318c911e00dmr1944344a91.5.1750992143051; Thu, 26 Jun 2025
 19:42:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625160849.61344-1-minhquangbui99@gmail.com>
 <20250625160849.61344-2-minhquangbui99@gmail.com> <CACGkMEvioXkt3_zB-KijwhoUx5NS5xa0Jvd=w2fhBZFf3un1Ww@mail.gmail.com>
 <0bf0811e-cdb8-4410-9b69-1c38b06bbadf@gmail.com>
In-Reply-To: <0bf0811e-cdb8-4410-9b69-1c38b06bbadf@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 27 Jun 2025 10:42:11 +0800
X-Gm-Features: Ac12FXxdViEQWWA017DWAwJPntu53W5CWymI2HEGHOwPav-f88RyBtMLMqPNFP0
Message-ID: <CACGkMEsfU=84EYB_L6vusEbdnCLdQ_ri+izMGr+drC9z75LP_g@mail.gmail.com>
Subject: Re: [PATCH net 1/4] virtio-net: ensure the received length does not
 exceed allocated size
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

On Thu, Jun 26, 2025 at 11:34=E2=80=AFPM Bui Quang Minh
<minhquangbui99@gmail.com> wrote:
>
> On 6/26/25 09:34, Jason Wang wrote:
> > On Thu, Jun 26, 2025 at 12:10=E2=80=AFAM Bui Quang Minh
> > <minhquangbui99@gmail.com> wrote:
> >> In xdp_linearize_page, when reading the following buffers from the rin=
g,
> >> we forget to check the received length with the true allocate size. Th=
is
> >> can lead to an out-of-bound read. This commit adds that missing check.
> >>
> >> Fixes: 4941d472bf95 ("virtio-net: do not reset during XDP set")
> > I think we should cc stable.
>
> Okay, I'll do that in next version.
>
> >
> >> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> >> ---
> >>   drivers/net/virtio_net.c | 27 ++++++++++++++++++++++-----
> >>   1 file changed, 22 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >> index e53ba600605a..2a130a3e50ac 100644
> >> --- a/drivers/net/virtio_net.c
> >> +++ b/drivers/net/virtio_net.c
> >> @@ -1797,7 +1797,8 @@ static unsigned int virtnet_get_headroom(struct =
virtnet_info *vi)
> >>    * across multiple buffers (num_buf > 1), and we make sure buffers
> >>    * have enough headroom.
> >>    */
> >> -static struct page *xdp_linearize_page(struct receive_queue *rq,
> >> +static struct page *xdp_linearize_page(struct net_device *dev,
> >> +                                      struct receive_queue *rq,
> >>                                         int *num_buf,
> >>                                         struct page *p,
> >>                                         int offset,
> >> @@ -1818,17 +1819,33 @@ static struct page *xdp_linearize_page(struct =
receive_queue *rq,
> >>          page_off +=3D *len;
> >>
> >>          while (--*num_buf) {
> >> -               unsigned int buflen;
> >> +               unsigned int headroom, tailroom, room;
> >> +               unsigned int truesize, buflen;
> >>                  void *buf;
> >> +               void *ctx;
> >>                  int off;
> >>
> >> -               buf =3D virtnet_rq_get_buf(rq, &buflen, NULL);
> >> +               buf =3D virtnet_rq_get_buf(rq, &buflen, &ctx);
> >>                  if (unlikely(!buf))
> >>                          goto err_buf;
> >>
> >>                  p =3D virt_to_head_page(buf);
> >>                  off =3D buf - page_address(p);
> >>
> >> +               truesize =3D mergeable_ctx_to_truesize(ctx);
> > This won't work for receive_small_xdp().
>
> If it is small mode, the num_buf =3D=3D 1 and we don't get into the while=
 loop.

You are right, it might be worth mentioning this somewhere.

>
> >
> >> +               headroom =3D mergeable_ctx_to_headroom(ctx);
> >> +               tailroom =3D headroom ? sizeof(struct skb_shared_info)=
 : 0;
> >> +               room =3D SKB_DATA_ALIGN(headroom + tailroom);
> >> +
> >> +               if (unlikely(buflen > truesize - room)) {
> >> +                       put_page(p);
> >> +                       pr_debug("%s: rx error: len %u exceeds truesiz=
e %lu\n",
> >> +                                dev->name, buflen,
> >> +                                (unsigned long)(truesize - room));
> >> +                       DEV_STATS_INC(dev, rx_length_errors);
> >> +                       goto err_buf;
> >> +               }
> > I wonder if this issue only affect XDP should we check other places?
>
> In small mode, we check the len with GOOD_PACKET_LEN in receive_small.
> In mergeable mode, we have some checks over the place and this is the
> only one I see we miss. In xsk, we check inside buf_to_xdp. However, in
> the big mode, I feel like there is a bug.
>
> In add_recvbuf_big, 1 first page + vi->big_packets_num_skbfrags pages.
> The pages are managed by a linked list. The vi->big_packets_num_skbfrags
> is set in virtnet_set_big_packets
>
>      vi->big_packets_num_skbfrags =3D guest_gso ? MAX_SKB_FRAGS :
> DIV_ROUND_UP(mtu, PAGE_SIZE);
>
> So the vi->big_packets_num_skbfrags can be fewer than MAX_SKB_FRAGS.
>
> In receive_big, we call to page_to_skb, there is a check
>
>      if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
>          /* error case */
>      }
>
> But because the number of allocated buffer is
> vi->big_packets_num_skbfrags + 1 and vi->big_packets_num_skbfrags can be
> fewer than MAX_SKB_FRAGS, the check seems not enough
>
>      while (len) {
>          unsigned int frag_size =3D min((unsigned)PAGE_SIZE - offset, len=
);
>          skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, offset,
>                  frag_size, truesize);
>          len -=3D frag_size;
>          page =3D (struct page *)page->private;
>          offset =3D 0;
>      }
>
> In the following while loop, we keep running based on len without NULL
> check the pages linked list, so it may result into NULL pointer dereferen=
ce.
>
> What do you think?

This looks like a bug, let's fix it.

Thanks

>
> Thanks,
> Quang Minh.
>
> >
> >> +
> >>                  /* guard against a misconfigured or uncooperative bac=
kend that
> >>                   * is sending packet larger than the MTU.
> >>                   */
> >> @@ -1917,7 +1934,7 @@ static struct sk_buff *receive_small_xdp(struct =
net_device *dev,
> >>                  headroom =3D vi->hdr_len + header_offset;
> >>                  buflen =3D SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom)=
 +
> >>                          SKB_DATA_ALIGN(sizeof(struct skb_shared_info)=
);
> >> -               xdp_page =3D xdp_linearize_page(rq, &num_buf, page,
> >> +               xdp_page =3D xdp_linearize_page(dev, rq, &num_buf, pag=
e,
> >>                                                offset, header_offset,
> >>                                                &tlen);
> >>                  if (!xdp_page)
> >> @@ -2252,7 +2269,7 @@ static void *mergeable_xdp_get_buf(struct virtne=
t_info *vi,
> >>           */
> >>          if (!xdp_prog->aux->xdp_has_frags) {
> >>                  /* linearize data for XDP */
> >> -               xdp_page =3D xdp_linearize_page(rq, num_buf,
> >> +               xdp_page =3D xdp_linearize_page(vi->dev, rq, num_buf,
> >>                                                *page, offset,
> >>                                                XDP_PACKET_HEADROOM,
> >>                                                len);
> >> --
> >> 2.43.0
> >>
>


