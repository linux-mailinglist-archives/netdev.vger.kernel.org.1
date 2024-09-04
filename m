Return-Path: <netdev+bounces-124841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F9296B301
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEB741C21BF7
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 07:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EAF1465BB;
	Wed,  4 Sep 2024 07:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="j8V7RAgw"
X-Original-To: netdev@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70EB824AF;
	Wed,  4 Sep 2024 07:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725435451; cv=none; b=err2YA3MZfwAwTZRYQRF06xCQBi+FPacDRjme0s7RqHWT2Z0cRD7N4lCGrjg35ueKfVzsm7RIAvua3bWP7JySeeyq8K+LHjupX6+5i6sBlwjU91uVm8IJGXpB7hHGkf/RSOSTBoGwj8mRMIMl3mDB8mm+xfkq301TwcVaPw2YXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725435451; c=relaxed/simple;
	bh=SXoL0Y2uBCH4szH5JIB1/cEQ+UnjAZakw05pl633cJ0=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=mHojj9F5JDF3etkwUEf+OyFefO9ttbSxI4MNpNS/LsyAM1OsE8Gc825X1r/eAE7obpliPd07JhBmGW7QgUwrD51Mgw64qs0KSc2oTVwufgqT8QgAj1gqyNIOJ8N3v3n7ODOlas12GQdgbm95j3O97St6FRT7L5EvUhS7Vkhqp84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=j8V7RAgw; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725435445; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=ciPN8fkQH+unZgllpAVfdRbO08g5aZIPzLBXvT9Tb5A=;
	b=j8V7RAgwpSE4c8k6ZxXJIsGaoD1+bCwusI0u3LEjQksOKElDAg1FkEUKnr3Uh+umCEeoU5x/Xk22h/k5u0RwM+i+tQqKtQXQbV6xXI0GfzJ5HRyfyJklVRRMhnM2I5yJAtVAHMuHI1s6YE33CJvJvHSWxcCEiftp1Sey7fqdHuI=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WEGYzGb_1725435444)
          by smtp.aliyun-inc.com;
          Wed, 04 Sep 2024 15:37:24 +0800
Message-ID: <1725435002.9733856-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [External] Re: [PATCH v2] virtio_net: Fix mismatched buf address when unmapping for small packets
Date: Wed, 4 Sep 2024 15:30:02 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: =?utf-8?b?5paH5Y2a5p2O?= <liwenbo.martin@bytedance.com>
Cc: virtualization@lists.linux.dev,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Jiahui Cen <cenjiahui@bytedance.com>,
 Ying Fang <fangying.tommy@bytedance.com>,
 mst@redhat.com,
 jasowang@redhat.com,
 eperezma@redhat.com,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com
References: <20240904061009.90785-1-liwenbo.martin@bytedance.com>
 <1725432304.274084-1-xuanzhuo@linux.alibaba.com>
 <CABwj4+hMwUQ+=m+XyG=66e+PUbOzOvHEsQzboB17DE+3aBHA3g@mail.gmail.com>
In-Reply-To: <CABwj4+hMwUQ+=m+XyG=66e+PUbOzOvHEsQzboB17DE+3aBHA3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Wed, 4 Sep 2024 15:21:28 +0800, =3D?utf-8?b?5paH5Y2a5p2O?=3D <liwenbo.ma=
rtin@bytedance.com> wrote:
> When SWIOTLB is enabled, a DMA map will allocate a bounce buffer for real
> DMA operations,
> and when unmapping, SWIOTLB copies the content in the bounce buffer to the
> driver-allocated
> buffer (the `buf` variable). Such copy only synchronizes data in the buff=
er
> range, not the whole page.
> So we should give the correct offset for DMA unmapping.

I see.

But I think we should pass the "correct" buf to virtio core as the "data" by
virtqueue_add_inbuf_ctx().

In the merge mode, we pass the pointer that points to the virtnet header.
In the small mode, we pass the pointer that points to the virtnet header - =
offset.

But this is not the only problem, we try to get the virtnet header by the b=
uf
inside receive_buf(before receive_small).

	flags =3D ((struct virtio_net_common_hdr *)buf)->hdr.flags;

So I think it is time to unify the buf that passed to the virtio core into a
pointer pointed to the virtnet header.

Thanks.


>
> Thanks.
>
> On Wed, Sep 4, 2024 at 2:46=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
> >
> > On Wed,  4 Sep 2024 14:10:09 +0800, Wenbo Li <liwenbo.martin@bytedance.=
com>
> wrote:
> > > Currently, the virtio-net driver will perform a pre-dma-mapping for
> > > small or mergeable RX buffer. But for small packets, a mismatched
> address
> > > without VIRTNET_RX_PAD and xdp_headroom is used for unmapping.
> >
> > Will used virt_to_head_page(), so could you say more about it?
> >
> >         struct page *page =3D virt_to_head_page(buf);
> >
> > Thanks.
> >
> > >
> > > That will result in unsynchronized buffers when SWIOTLB is enabled, f=
or
> > > example, when running as a TDX guest.
> > >
> > > This patch handles small and mergeable packets separately and fixes
> > > the mismatched buffer address.
> > >
> > > Changes from v1: Use ctx to get xdp_headroom.
> > >
> > > Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling
> mergeable buffers")
> > > Signed-off-by: Wenbo Li <liwenbo.martin@bytedance.com>
> > > Signed-off-by: Jiahui Cen <cenjiahui@bytedance.com>
> > > Signed-off-by: Ying Fang <fangying.tommy@bytedance.com>
> > > ---
> > >  drivers/net/virtio_net.c | 29 ++++++++++++++++++++++++++++-
> > >  1 file changed, 28 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index c6af18948..cbc3c0ae4 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -891,6 +891,23 @@ static void *virtnet_rq_get_buf(struct
> receive_queue *rq, u32 *len, void **ctx)
> > >       return buf;
> > >  }
> > >
> > > +static void *virtnet_rq_get_buf_small(struct receive_queue *rq,
> > > +                                   u32 *len,
> > > +                                   void **ctx,
> > > +                                   unsigned int header_offset)
> > > +{
> > > +     void *buf;
> > > +     unsigned int xdp_headroom;
> > > +
> > > +     buf =3D virtqueue_get_buf_ctx(rq->vq, len, ctx);
> > > +     if (buf) {
> > > +             xdp_headroom =3D (unsigned long)*ctx;
> > > +             virtnet_rq_unmap(rq, buf + VIRTNET_RX_PAD + xdp_headroo=
m,
> *len);
> > > +     }
> > > +
> > > +     return buf;
> > > +}
> > > +
> > >  static void virtnet_rq_init_one_sg(struct receive_queue *rq, void
> *buf, u32 len)
> > >  {
> > >       struct virtnet_rq_dma *dma;
> > > @@ -2692,13 +2709,23 @@ static int virtnet_receive_packets(struct
> virtnet_info *vi,
> > >       int packets =3D 0;
> > >       void *buf;
> > >
> > > -     if (!vi->big_packets || vi->mergeable_rx_bufs) {
> > > +     if (vi->mergeable_rx_bufs) {
> > >               void *ctx;
> > >               while (packets < budget &&
> > >                      (buf =3D virtnet_rq_get_buf(rq, &len, &ctx))) {
> > >                       receive_buf(vi, rq, buf, len, ctx, xdp_xmit,
> stats);
> > >                       packets++;
> > >               }
> > > +     } else if (!vi->big_packets) {
> > > +             void *ctx;
> > > +             unsigned int xdp_headroom =3D virtnet_get_headroom(vi);
> > > +             unsigned int header_offset =3D VIRTNET_RX_PAD +
> xdp_headroom;
> > > +
> > > +             while (packets < budget &&
> > > +                    (buf =3D virtnet_rq_get_buf_small(rq, &len, &ctx,
> header_offset))) {
> > > +                     receive_buf(vi, rq, buf, len, ctx, xdp_xmit,
> stats);
> > > +                     packets++;
> > > +             }
> > >       } else {
> > >               while (packets < budget &&
> > >                      (buf =3D virtqueue_get_buf(rq->vq, &len)) !=3D N=
ULL) {
> > > --
> > > 2.20.1
> > >
>

