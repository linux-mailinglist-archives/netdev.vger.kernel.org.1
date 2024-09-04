Return-Path: <netdev+bounces-125016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF19696B97B
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 12:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C357B27488
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 10:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE711CFEC1;
	Wed,  4 Sep 2024 10:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fg6a9ny5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582E01CC887
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 10:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725447467; cv=none; b=E4R0L95k34D4h/H4KU3GgJUaSCXWoiWr7qGFTXqoKLpv9WpE6JySNbExFlOOcQxC0c3o/wfK+CJo9BBoIY08n8bnRLbdoWKEDdMPX2FkCWePbodgairBa7SNiEazMG3maxxGP1zZ2RbG8/bfl0l62hyLlyx5xOzUE4BjopUFvfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725447467; c=relaxed/simple;
	bh=+g60buYkNs482gAOZIHUNmzE2rgVaRxfXaFe9VsN+BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsPNmf3gwfv093ISpVz/SI8Ozc6NW/lscbCL7DOfxMTgz8H7EF3g6G+1o4M4jAhZNioW9INDjyDjNG75jeWKtQXPMzPuHLz4lWHgVTu84DvkHAwwog3um5p2g5ACapMLJjm/YKdb3sjgM5NYAMcsdmWXLbb1DN7JKveu7v2v6yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fg6a9ny5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725447465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rw2ZChNtb/jDuSC/Rnl6IchZi9rO4dgpRix6imcWTTE=;
	b=Fg6a9ny5AwS+yZElzd33WUGf+CGl14toxU0lpMqxx56AJoGEPyghY5ALUgFYXzitx8FMdB
	cv7uCzjhaTU+NCV6wGydYWz8SZB98pQBhmuofjFQPY9nSOnpGdu5D0pXc3TeRez/ww+o5k
	k+K/ucRkVaV87RYsooGYBZ7Ygj6WSME=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-N5P3e_UNMDaxFt7FOA2ecA-1; Wed, 04 Sep 2024 06:57:43 -0400
X-MC-Unique: N5P3e_UNMDaxFt7FOA2ecA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-428040f49f9so58365135e9.0
        for <netdev@vger.kernel.org>; Wed, 04 Sep 2024 03:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725447462; x=1726052262;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rw2ZChNtb/jDuSC/Rnl6IchZi9rO4dgpRix6imcWTTE=;
        b=Vm/Io1+9+nbckEShiQtKSpVmVDBhKTMjHF1M53o0GUziMUUdDy1AkbExy0nfdao7s+
         Yp37hLKyYzeUiaNDzaG/ub4rIkaaXKhVMibalypWmf6bmx0qgTZNzD0qVY1hEjWzkPu7
         1X4x++rFlOSkZlRNnW7w2TpAykhVpNgp+xDKfujkcLGyPcxj7LDMBGfAwih2V4jIj9Gr
         nD/SSAhr/AOwn+nU/ZtS9RSv+jbRqkg7DpvvGh9nWeXt7Un40DPPXy4Fcsumlbj7vDQW
         uO7xWWIWdqT9Ko8gj9JkSAu/KA/HQrOiegTfCnP9IMgoH0wasCTB+U9kPVmDJ8XJzhjI
         vVPg==
X-Forwarded-Encrypted: i=1; AJvYcCUj04BvGz4dtbfwlHTVCLWh1LMVcnpsM4umDQUW8LPT4rIyDtAZPZTGtGXYQFoD8bDHweHZLQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyheSMexJ6HcureecvvSo132KNBheGqb+m3yDvtZR20lSSbsfu9
	EluBJQzudr76z4tuTjaPGgvRSjwPurnJ9W2YbVdL7eLKHpBlWp0jxdvrKfVtTgciMAMtVqRtKTQ
	nqtxewuppLKLiZd0C1Dy4dhC4+2y60cfGg2p7B53ZK94fJJNSuk7naQ==
X-Received: by 2002:a05:600c:a09:b0:428:1608:831e with SMTP id 5b1f17b1804b1-42bb0309910mr160893275e9.22.1725447462554;
        Wed, 04 Sep 2024 03:57:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkXwypcqrJh3Y7gP5Q6Ltrp9NU+HSv0Qi7Do0Jl++xDXPGVKmVZyxkDfQPyxOpKULa8FQy6w==
X-Received: by 2002:a05:600c:a09:b0:428:1608:831e with SMTP id 5b1f17b1804b1-42bb0309910mr160892975e9.22.1725447461617;
        Wed, 04 Sep 2024 03:57:41 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:25b:d02e:ab32:7c17:4d7a:fa4a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c8a08dafsm9108194f8f.75.2024.09.04.03.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 03:57:40 -0700 (PDT)
Date: Wed, 4 Sep 2024 06:57:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: =?utf-8?B?5paH5Y2a5p2O?= <liwenbo.martin@bytedance.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jiahui Cen <cenjiahui@bytedance.com>,
	Ying Fang <fangying.tommy@bytedance.com>, jasowang@redhat.com,
	eperezma@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [External] Re: [PATCH v2] virtio_net: Fix mismatched buf address
 when unmapping for small packets
Message-ID: <20240904065626-mutt-send-email-mst@kernel.org>
References: <20240904061009.90785-1-liwenbo.martin@bytedance.com>
 <1725432304.274084-1-xuanzhuo@linux.alibaba.com>
 <CABwj4+hMwUQ+=m+XyG=66e+PUbOzOvHEsQzboB17DE+3aBHA3g@mail.gmail.com>
 <1725435002.9733856-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1725435002.9733856-1-xuanzhuo@linux.alibaba.com>

On Wed, Sep 04, 2024 at 03:30:02PM +0800, Xuan Zhuo wrote:
> On Wed, 4 Sep 2024 15:21:28 +0800, =?utf-8?b?5paH5Y2a5p2O?= <liwenbo.martin@bytedance.com> wrote:
> > When SWIOTLB is enabled, a DMA map will allocate a bounce buffer for real
> > DMA operations,
> > and when unmapping, SWIOTLB copies the content in the bounce buffer to the
> > driver-allocated
> > buffer (the `buf` variable). Such copy only synchronizes data in the buffer
> > range, not the whole page.
> > So we should give the correct offset for DMA unmapping.
> 
> I see.
> 
> But I think we should pass the "correct" buf to virtio core as the "data" by
> virtqueue_add_inbuf_ctx().
> 
> In the merge mode, we pass the pointer that points to the virtnet header.
> In the small mode, we pass the pointer that points to the virtnet header - offset.
> 
> But this is not the only problem, we try to get the virtnet header by the buf
> inside receive_buf(before receive_small).
> 
> 	flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
> 
> So I think it is time to unify the buf that passed to the virtio core into a
> pointer pointed to the virtnet header.
> 
> Thanks.

Hard to say without seeing what is proposed, but I think
data pointer is opaque to virtio, it does not have to
point to anything specific - just !NULL.


> 
> >
> > Thanks.
> >
> > On Wed, Sep 4, 2024 at 2:46 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > >
> > > On Wed,  4 Sep 2024 14:10:09 +0800, Wenbo Li <liwenbo.martin@bytedance.com>
> > wrote:
> > > > Currently, the virtio-net driver will perform a pre-dma-mapping for
> > > > small or mergeable RX buffer. But for small packets, a mismatched
> > address
> > > > without VIRTNET_RX_PAD and xdp_headroom is used for unmapping.
> > >
> > > Will used virt_to_head_page(), so could you say more about it?
> > >
> > >         struct page *page = virt_to_head_page(buf);
> > >
> > > Thanks.
> > >
> > > >
> > > > That will result in unsynchronized buffers when SWIOTLB is enabled, for
> > > > example, when running as a TDX guest.
> > > >
> > > > This patch handles small and mergeable packets separately and fixes
> > > > the mismatched buffer address.
> > > >
> > > > Changes from v1: Use ctx to get xdp_headroom.
> > > >
> > > > Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling
> > mergeable buffers")
> > > > Signed-off-by: Wenbo Li <liwenbo.martin@bytedance.com>
> > > > Signed-off-by: Jiahui Cen <cenjiahui@bytedance.com>
> > > > Signed-off-by: Ying Fang <fangying.tommy@bytedance.com>
> > > > ---
> > > >  drivers/net/virtio_net.c | 29 ++++++++++++++++++++++++++++-
> > > >  1 file changed, 28 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index c6af18948..cbc3c0ae4 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -891,6 +891,23 @@ static void *virtnet_rq_get_buf(struct
> > receive_queue *rq, u32 *len, void **ctx)
> > > >       return buf;
> > > >  }
> > > >
> > > > +static void *virtnet_rq_get_buf_small(struct receive_queue *rq,
> > > > +                                   u32 *len,
> > > > +                                   void **ctx,
> > > > +                                   unsigned int header_offset)
> > > > +{
> > > > +     void *buf;
> > > > +     unsigned int xdp_headroom;
> > > > +
> > > > +     buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
> > > > +     if (buf) {
> > > > +             xdp_headroom = (unsigned long)*ctx;
> > > > +             virtnet_rq_unmap(rq, buf + VIRTNET_RX_PAD + xdp_headroom,
> > *len);
> > > > +     }
> > > > +
> > > > +     return buf;
> > > > +}
> > > > +
> > > >  static void virtnet_rq_init_one_sg(struct receive_queue *rq, void
> > *buf, u32 len)
> > > >  {
> > > >       struct virtnet_rq_dma *dma;
> > > > @@ -2692,13 +2709,23 @@ static int virtnet_receive_packets(struct
> > virtnet_info *vi,
> > > >       int packets = 0;
> > > >       void *buf;
> > > >
> > > > -     if (!vi->big_packets || vi->mergeable_rx_bufs) {
> > > > +     if (vi->mergeable_rx_bufs) {
> > > >               void *ctx;
> > > >               while (packets < budget &&
> > > >                      (buf = virtnet_rq_get_buf(rq, &len, &ctx))) {
> > > >                       receive_buf(vi, rq, buf, len, ctx, xdp_xmit,
> > stats);
> > > >                       packets++;
> > > >               }
> > > > +     } else if (!vi->big_packets) {
> > > > +             void *ctx;
> > > > +             unsigned int xdp_headroom = virtnet_get_headroom(vi);
> > > > +             unsigned int header_offset = VIRTNET_RX_PAD +
> > xdp_headroom;
> > > > +
> > > > +             while (packets < budget &&
> > > > +                    (buf = virtnet_rq_get_buf_small(rq, &len, &ctx,
> > header_offset))) {
> > > > +                     receive_buf(vi, rq, buf, len, ctx, xdp_xmit,
> > stats);
> > > > +                     packets++;
> > > > +             }
> > > >       } else {
> > > >               while (packets < budget &&
> > > >                      (buf = virtqueue_get_buf(rq->vq, &len)) != NULL) {
> > > > --
> > > > 2.20.1
> > > >
> >


