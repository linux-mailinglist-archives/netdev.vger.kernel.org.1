Return-Path: <netdev+bounces-224675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E283BB8800B
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 08:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB6394664D3
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 06:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BBB23BD13;
	Fri, 19 Sep 2025 06:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EZgFZGq8"
X-Original-To: netdev@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D3334BA52
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 06:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758263549; cv=none; b=YrMxMgS0ed+JnDX9i9j9wESaniY7jHQE2Jsr54QwyLNBwrWAK/hnoDEXW3xqIZNhaqkzW5HFt086T4V3x5Cpbs+qKCFurZSeHVJpAoALYy1YaEaKssPHlVcOsSLAzRvYQLXCs5OjftkmwyktpBkjpWxULhz4fUxUdp9m0LRKTe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758263549; c=relaxed/simple;
	bh=N0k6TtKDKDUQdywtF92TG2uJQGKv4E4BiGc9AuGCHpc=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=mauh2/cyVT4Z7wrJwjQ9UHeH3iPcvHk/RVa8SLn4Uz/CgvTErVEkbB2MC7R2SQwIvyw2JMIFd0BVkVOZRfhC/XIvRrJB45v5F52aLZsmBfIchi7z4KSQWJG3IL9rpBjGkYXfF2eOaVdL5cN3Fa7xWRm/dJtjaSYuMZtBc/XtiF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EZgFZGq8; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758263537; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=68aueCoPAROVNtONYC1RBAOYPfFMaSkaWVtDp3qJFMM=;
	b=EZgFZGq84aM6z8fPVodUDI5lZaHuhqjAm97xfPzR9ZL5WadeulBW89nEgeCxZWFJ2SY3rDl7YyVHdou+ur4pjsWZO3SkJjU++yiiu0I96Y42DBuAOy+fmUd4sz8ZDu8R9LBI7Ogf1lC79MQzDZCIguSZUy4I0vQr453rrjtgN7g=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WoIp-ay_1758263536 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 19 Sep 2025 14:32:17 +0800
Message-ID: <1758263409.2668645-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net] virtio-net: fix incorrect flags recording in big mode
Date: Fri, 19 Sep 2025 14:30:09 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Heng Qi <hengqi@linux.alibaba.com>,
 virtualization@lists.linux.dev
References: <20250919013450.111424-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEscCsCf8RC-xQzfTNMp94Ty4wTrBgLkF50OAQ+yF8xD-A@mail.gmail.com>
In-Reply-To: <CACGkMEscCsCf8RC-xQzfTNMp94Ty4wTrBgLkF50OAQ+yF8xD-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Fri, 19 Sep 2025 10:11:55 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Fri, Sep 19, 2025 at 9:35=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > The purpose of commit 703eec1b2422 ("virtio_net: fixing XDP for fully
> > checksummed packets handling") is to record the flags in advance, as
> > their value may be overwritten in the XDP case. However, the flags
> > recorded under big mode are incorrect, because in big mode, the passed
> > buf does not point to the rx buffer, but rather to the page of the
> > submitted buffer. This commit fixes this issue.
> >
> > For the small mode, the commit c11a49d58ad2 ("virtio_net: Fix mismatched
> > buf address when unmapping for small packets") fixed it.
> >
> > Fixes: 703eec1b2422 ("virtio_net: fixing XDP for fully checksummed pack=
ets handling")
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 975bdc5dab84..6e6e74390955 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2630,13 +2630,19 @@ static void receive_buf(struct virtnet_info *vi=
, struct receive_queue *rq,
> >          */
> >         flags =3D ((struct virtio_net_common_hdr *)buf)->hdr.flags;
> >
> > -       if (vi->mergeable_rx_bufs)
> > +       if (vi->mergeable_rx_bufs) {
> >                 skb =3D receive_mergeable(dev, vi, rq, buf, ctx, len, x=
dp_xmit,
> >                                         stats);
> > -       else if (vi->big_packets)
> > +       } else if (vi->big_packets) {
> > +               void *p;
> > +
> > +               p =3D page_address((struct page *)buf);
> > +               flags =3D ((struct virtio_net_common_hdr *)p)->hdr.flag=
s;
> > +
>
> Patch looks good but a I have a nit:
>
> It looks better to move this above?
>
> if (vi->big_packets) {

This should be
	if (!vi->mergeable_rx_bufs && vi->big_packets)


>                void *p =3D page_address((struct page *)buf);
>                flags =3D ((struct virtio_net_common_hdr *)p)->hdr.flags;
> } else
>                flags =3D ((struct virtio_net_common_hdr *)buf)->hdr.flags;


I'm also torn between these two approaches. I am ok, if you prefer this.

Thanks



>
> To avoid twice the calculations and reuse the comment.
>
> >                 skb =3D receive_big(dev, vi, rq, buf, len, stats);
> > -       else
> > +       } else {
> >                 skb =3D receive_small(dev, vi, rq, buf, ctx, len, xdp_x=
mit, stats);
> > +       }
> >
> >         if (unlikely(!skb))
> >                 return;
> > --
> > 2.32.0.3.g01195cf9f
> >
>
> Thanks
>
>

