Return-Path: <netdev+bounces-194703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCD1ACBFFE
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 08:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E26B3A4C25
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 06:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED31202F65;
	Tue,  3 Jun 2025 06:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QRqr5lHS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8154E17A318
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 06:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748930695; cv=none; b=YJ/kjJr+0HNqm+fTAvTlIgnh+lh+EKOWIRiTuu0Uswyc9Yk382JonT+DZlLURsScGkU2ELJ9BOWOBBTT2ND+kX9AgaEgpmbeMy2qChZ1zZj7a+a6nRQoQBSgDV/KiepvDc4FrSFjwANP7tkgJHDzUUUwkKZSfh6lHvDmmNAuDKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748930695; c=relaxed/simple;
	bh=Qo4akI9pR3dvyqNI6pWSC4c7hDgCxvLhLMc26YWUNqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FwadQmqoroD2yAsZh8J9nx48zGTf6mXZa2bvBzdTtCa+xeCVAfotlFOMGTjpS/fuzE8mvWFxZ5j71USgJHzS7Zqx3CK7LZFYodzKRXkhFMLPZ0aEUXi4fy1bpxFlIB2PhxpuWMfFmWCBj3+AZHZOtn8l2aebLAGj1WyYaog70WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QRqr5lHS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748930690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C4kk7REJPo5LVVCXYeE4H5PmhzE5bRIo4VhFMQx+60A=;
	b=QRqr5lHSPXko/RHBHVfeJcDdkQRJTn0HFMyNjCzb6YRQrrXRP3YckxURvVCLBBW3GiGnCT
	AjCQRlyh2l8ZkrI/P948Pi5itqyOLxV/WLyBUr43tI30IiiugWMXd8QAuaqqSr3TyzDm90
	htOfTod3LUC8Ph+KhYUQgkVTiCzOWs0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-KtrNWCFRNRO36YKgbZ31IQ-1; Tue, 03 Jun 2025 02:04:48 -0400
X-MC-Unique: KtrNWCFRNRO36YKgbZ31IQ-1
X-Mimecast-MFC-AGG-ID: KtrNWCFRNRO36YKgbZ31IQ_1748930687
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ad88ac202c0so469370866b.1
        for <netdev@vger.kernel.org>; Mon, 02 Jun 2025 23:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748930687; x=1749535487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C4kk7REJPo5LVVCXYeE4H5PmhzE5bRIo4VhFMQx+60A=;
        b=iWf/g6FRrPk6u/9Sm812/O3LzLc8VVmQQhmZz7FyYlKIa4YdxrzgppGMbBuWtGPytI
         I/7MY69ygN1qPwLjtXADWeeyd1Iuohw03zoTIn9Cy3mFEZ2Mo37X0LFcV4MVUh7HYH8n
         C/ivGLScB5UuLKaWtRtnVheLWhvVgKWz3HO110GpBc+UX5U8JcNJtbhYbLp74xgBiHq0
         wg8vEIO7HewtsXne42YR2F6jFt6mqfCckV5A7IywGzGmdrwjcmi0hISwk8ALkgV+ACd+
         8tpWfQGHC/kv3cm6dPwlARLv0hVHpN36O8oG1N2Bs8I7UhaGjoV13ICoINkF04Uaqy9Y
         7jwg==
X-Gm-Message-State: AOJu0YxIA/4QHY2OpUwx5Olrt1TIZ6l0VICJmLJfCoaWSD5eI6x2m1Pr
	G2Ayy6vZY7L0CJp5cCuPGOHp/ppiyx4Eq6lCKEYkjQp+7/Ud7bfF3XZDY/kpJvMoPK7EXIzIKU1
	wh9zfo9tqih3Esj9tCHKLOXuH8zIpSZ/Jks4FHWp6V1tBfRxCi/ruVOqNMVX927QMae7Zh6pBiV
	5FUFYvPWGa6ojxOkB3rD9PrJXROW9XFYbq
X-Gm-Gg: ASbGncs2Vu0EqVfEbppVgDPj+wQP6PKM2JRXYe0P9a+gyVUdNCReLNNsYglNVodK9hx
	BSu6TpEK82iQ8RATh0nrwV+kuWktzMU57s7itU272tIjMs5iz4K/vL3bftn8PTTdh3jA8LQ==
X-Received: by 2002:a17:907:5c1:b0:ad5:431d:fb32 with SMTP id a640c23a62f3a-adde5f1c71emr122578266b.14.1748930686642;
        Mon, 02 Jun 2025 23:04:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDqGWcsBEiyI8G77qxQfY9LRPjS9n1Y1MiStZVBpJF5sxgkeiT2avlQHgnMYEIngQ5ArsJOBo20scIAw00DaE=
X-Received: by 2002:a17:907:5c1:b0:ad5:431d:fb32 with SMTP id
 a640c23a62f3a-adde5f1c71emr122573266b.14.1748930686102; Mon, 02 Jun 2025
 23:04:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527161904.75259-1-minhquangbui99@gmail.com>
 <20250527161904.75259-2-minhquangbui99@gmail.com> <CACGkMEvAJziO3KW3Nk9+appXmR92ixcTeWY_XEZz4Qz1MwrhYA@mail.gmail.com>
 <d572e8b6-e25c-480e-9d05-8c7eeb396b12@gmail.com> <CACGkMEvBPaqXxnmNqZAbAbYFh=9gONva+dpouAeW-sd1pzK58Q@mail.gmail.com>
In-Reply-To: <CACGkMEvBPaqXxnmNqZAbAbYFh=9gONva+dpouAeW-sd1pzK58Q@mail.gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 3 Jun 2025 14:04:09 +0800
X-Gm-Features: AX0GCFsfXLm2TC8NF-uKkDeAms9B2pKJaVSC9CISoMN6lat5FOQdoiwAow7ih7g
Message-ID: <CAPpAL=yYweFPtA-E_vwPiHFjQpXXb2_v9yiPkfCP3WHnDZBqPQ@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v2 1/2] virtio-net: support zerocopy multi
 buffer XDP in mergeable
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Jason Wang <jasowang@redhat.com>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this patch with virtio-net regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Tue, Jun 3, 2025 at 10:57=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, May 29, 2025 at 8:28=E2=80=AFPM Bui Quang Minh <minhquangbui99@gm=
ail.com> wrote:
> >
> > On 5/29/25 12:59, Jason Wang wrote:
> > > On Wed, May 28, 2025 at 12:19=E2=80=AFAM Bui Quang Minh
> > > <minhquangbui99@gmail.com> wrote:
> > >> Currently, in zerocopy mode with mergeable receive buffer, virtio-ne=
t
> > >> does not support multi buffer but a single buffer only. This commit =
adds
> > >> support for multi mergeable receive buffer in the zerocopy XDP path =
by
> > >> utilizing XDP buffer with frags.
> > >>
> > >> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> > >> ---
> > >>   drivers/net/virtio_net.c | 123 +++++++++++++++++++++--------------=
----
> > >>   1 file changed, 66 insertions(+), 57 deletions(-)
> > >>
> > >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > >> index e53ba600605a..a9558650f205 100644
> > >> --- a/drivers/net/virtio_net.c
> > >> +++ b/drivers/net/virtio_net.c
> > >> @@ -45,6 +45,8 @@ module_param(napi_tx, bool, 0644);
> > >>   #define VIRTIO_XDP_TX          BIT(0)
> > >>   #define VIRTIO_XDP_REDIR       BIT(1)
> > >>
> > >> +#define VIRTNET_MAX_ZC_SEGS    8
> > >> +
> > >>   /* RX packet size EWMA. The average packet size is used to determi=
ne the packet
> > >>    * buffer size when refilling RX rings. As the entire RX ring may =
be refilled
> > >>    * at once, the weight is chosen so that the EWMA will be insensit=
ive to short-
> > >> @@ -1232,65 +1234,53 @@ static void xsk_drop_follow_bufs(struct net_=
device *dev,
> > >>          }
> > >>   }
> > >>
> > >> -static int xsk_append_merge_buffer(struct virtnet_info *vi,
> > >> -                                  struct receive_queue *rq,
> > >> -                                  struct sk_buff *head_skb,
> > >> -                                  u32 num_buf,
> > >> -                                  struct virtio_net_hdr_mrg_rxbuf *=
hdr,
> > >> -                                  struct virtnet_rq_stats *stats)
> > >> +static int virtnet_build_xsk_buff_mrg(struct virtnet_info *vi,
> > >> +                                     struct receive_queue *rq,
> > >> +                                     u32 num_buf,
> > >> +                                     struct xdp_buff *xdp,
> > >> +                                     struct virtnet_rq_stats *stats=
)
> > >>   {
> > >> -       struct sk_buff *curr_skb;
> > >> -       struct xdp_buff *xdp;
> > >> -       u32 len, truesize;
> > >> -       struct page *page;
> > >> +       unsigned int len;
> > >>          void *buf;
> > >>
> > >> -       curr_skb =3D head_skb;
> > >> +       if (num_buf < 2)
> > >> +               return 0;
> > >> +
> > >> +       while (num_buf > 1) {
> > >> +               struct xdp_buff *new_xdp;
> > >>
> > >> -       while (--num_buf) {
> > >>                  buf =3D virtqueue_get_buf(rq->vq, &len);
> > >> -               if (unlikely(!buf)) {
> > >> -                       pr_debug("%s: rx error: %d buffers out of %d=
 missing\n",
> > >> -                                vi->dev->name, num_buf,
> > >> -                                virtio16_to_cpu(vi->vdev,
> > >> -                                                hdr->num_buffers));
> > >> +               if (!unlikely(buf)) {
> > >> +                       pr_debug("%s: rx error: %d buffers missing\n=
",
> > >> +                                vi->dev->name, num_buf);
> > >>                          DEV_STATS_INC(vi->dev, rx_length_errors);
> > >> -                       return -EINVAL;
> > >> -               }
> > >> -
> > >> -               u64_stats_add(&stats->bytes, len);
> > >> -
> > >> -               xdp =3D buf_to_xdp(vi, rq, buf, len);
> > >> -               if (!xdp)
> > >> -                       goto err;
> > >> -
> > >> -               buf =3D napi_alloc_frag(len);
> > >> -               if (!buf) {
> > >> -                       xsk_buff_free(xdp);
> > >> -                       goto err;
> > >> +                       return -1;
> > >>                  }
> > >>
> > >> -               memcpy(buf, xdp->data - vi->hdr_len, len);
> > >> -
> > >> -               xsk_buff_free(xdp);
> > >> +               new_xdp =3D buf_to_xdp(vi, rq, buf, len);
> > >> +               if (!new_xdp)
> > >> +                       goto drop_bufs;
> > >>
> > >> -               page =3D virt_to_page(buf);
> > >> +               /* In virtnet_add_recvbuf_xsk(), we ask the host to =
fill from
> > >> +                * xdp->data - vi->hdr_len with both virtio_net_hdr =
and data.
> > >> +                * However, only the first packet has the virtio_net=
_hdr, the
> > >> +                * following ones do not. So we need to adjust the f=
ollowing
> > > Typo here.
> >
> > I'm sorry, could you clarify which word contains the typo?
> >
> > >
> > >> +                * packets' data pointer to the correct place.
> > >> +                */
> > > I wonder what happens if we don't use this trick? I meant we don't
> > > reuse the header room for the virtio-net header. This seems to be fin=
e
> > > for a mergeable buffer and can help to reduce the trick.
> >
> > I don't think using the header room for virtio-net header creates this
> > case handling. In my opinion, it comes from the slightly difference in
> > the recvbuf between single buffer and multi-buffer. When we have n
> > single-buffer packets, each buffer will have its own virtio-net header.
> > But when we have 1 multi-buffer packet (which spans across n buffers),
> > only the first buffer has virtio-net header, the following buffers do n=
ot.
> >
> > There 2 important pointers here. The pointer we announce to the vhost
> > side to fill the data, let's call it announced_addr, and xdp_buff->data
> > which is expected to point the the start of Ethernet frame. Currently,
> >
> >      announced_addr =3D xdp_buff->data - hdr_len
> >
> > The host side will write the virtio-net header to announced_addr then
> > the Ethernet frame's data in the first buffer. In case of multi-buffer
> > packet, in the following buffers, host side writes the Ethernet frame's
> > data to the announced_addr no virtio-net header. So in the virtio-net,
> > we need to subtract xdp_buff->data, otherwise, we lose some Ethernet
> > frame's data.
> >
> > I think a slightly better solution is that we set announced_addr =3D
> > xdp_buff->data then we only need to xdp_buff->data +=3D hdr_len for the
> > first buffer and do need to adjust xdp_buff->data of the following buff=
ers.
>
> Exactly my point.
>
> >
> > >
> > >> +               new_xdp->data -=3D vi->hdr_len;
> > >> +               new_xdp->data_end =3D new_xdp->data + len;
> > >>
> > >> -               truesize =3D len;
> > >> +               if (!xsk_buff_add_frag(xdp, new_xdp))
> > >> +                       goto drop_bufs;
> > >>
> > >> -               curr_skb  =3D virtnet_skb_append_frag(head_skb, curr=
_skb, page,
> > >> -                                                   buf, len, truesi=
ze);
> > >> -               if (!curr_skb) {
> > >> -                       put_page(page);
> > >> -                       goto err;
> > >> -               }
> > >> +               num_buf--;
> > >>          }
> > >>
> > >>          return 0;
> > >>
> > >> -err:
> > >> +drop_bufs:
> > >>          xsk_drop_follow_bufs(vi->dev, rq, num_buf, stats);
> > >> -       return -EINVAL;
> > >> +       return -1;
> > >>   }
> > >>
> > >>   static struct sk_buff *virtnet_receive_xsk_merge(struct net_device=
 *dev, struct virtnet_info *vi,
> > >> @@ -1307,23 +1297,42 @@ static struct sk_buff *virtnet_receive_xsk_m=
erge(struct net_device *dev, struct
> > >>          num_buf =3D virtio16_to_cpu(vi->vdev, hdr->num_buffers);
> > >>
> > >>          ret =3D XDP_PASS;
> > >> +       if (virtnet_build_xsk_buff_mrg(vi, rq, num_buf, xdp, stats))
> > >> +               goto drop;
> > >> +
> > >>          rcu_read_lock();
> > >>          prog =3D rcu_dereference(rq->xdp_prog);
> > >> -       /* TODO: support multi buffer. */
> > >> -       if (prog && num_buf =3D=3D 1)
> > >> -               ret =3D virtnet_xdp_handler(prog, xdp, dev, xdp_xmit=
, stats);
> > > Without this patch it looks like we had a bug:
> > >
> > >          ret =3D XDP_PASS;
> > >          rcu_read_lock();
> > >          prog =3D rcu_dereference(rq->xdp_prog);
> > >          /* TODO: support multi buffer. */
> > >          if (prog && num_buf =3D=3D 1)
> > >                  ret =3D virtnet_xdp_handler(prog, xdp, dev, xdp_xmit=
, stats);
> > >          rcu_read_unlock();
> > >
> > > This implies if num_buf is greater than 1, we will assume XDP_PASS?
> >
> > Yes, I think XDP_DROP should be returned in that case.
>
> Care to post a patch and cc stable?
>
> >
> > >
> > >> +       if (prog) {
> > >> +               /* We are in zerocopy mode so we cannot copy the mul=
ti-buffer
> > >> +                * xdp buff to a single linear xdp buff. If we do so=
, in case
> > >> +                * the BPF program decides to redirect to a XDP sock=
et (XSK),
> > >> +                * it will trigger the zerocopy receive logic in XDP=
 socket.
> > >> +                * The receive logic thinks it receives zerocopy buf=
fer while
> > >> +                * in fact, it is the copy one and everything is mes=
sed up.
> > >> +                * So just drop the packet here if we have a multi-b=
uffer xdp
> > >> +                * buff and the BPF program does not support it.
> > >> +                */
> > >> +               if (xdp_buff_has_frags(xdp) && !prog->aux->xdp_has_f=
rags)
> > >> +                       ret =3D XDP_DROP;
> > > Could we move the check before trying to build a multi-buffer XDP buf=
f?
> >
> > Yes, I'll fix this in next version.
> >
> > >
> > >> +               else
> > >> +                       ret =3D virtnet_xdp_handler(prog, xdp, dev, =
xdp_xmit,
> > >> +                                                 stats);
> > >> +       }
> > >>          rcu_read_unlock();
> > >>
> > >>          switch (ret) {
> > >>          case XDP_PASS:
> > >> -               skb =3D xsk_construct_skb(rq, xdp);
> > >> +               skb =3D xdp_build_skb_from_zc(xdp);
> > > Is this better to make this change a separate patch?
> >
> > Okay, I'll create a separate patch to convert the current XDP_PASS
> > handler to use xdp_build_skb_from_zc helper.
>
> That would be better.
>
> >
> > >
> > >>                  if (!skb)
> > >> -                       goto drop_bufs;
> > >> +                       break;
> > >>
> > >> -               if (xsk_append_merge_buffer(vi, rq, skb, num_buf, hd=
r, stats)) {
> > >> -                       dev_kfree_skb(skb);
> > >> -                       goto drop;
> > >> -               }
> > >> +               /* Later, in virtnet_receive_done(), eth_type_trans(=
)
> > >> +                * is called. However, in xdp_build_skb_from_zc(), i=
t is called
> > >> +                * already. As a result, we need to reset the data t=
o before
> > >> +                * the mac header so that the later call in
> > >> +                * virtnet_receive_done() works correctly.
> > >> +                */
> > >> +               skb_push(skb, ETH_HLEN);
> > >>
> > >>                  return skb;
> > >>
> > >> @@ -1332,14 +1341,11 @@ static struct sk_buff *virtnet_receive_xsk_m=
erge(struct net_device *dev, struct
> > >>                  return NULL;
> > >>
> > >>          default:
> > >> -               /* drop packet */
> > >> -               xsk_buff_free(xdp);
> > >> +               break;
> > >>          }
> > >>
> > >> -drop_bufs:
> > >> -       xsk_drop_follow_bufs(dev, rq, num_buf, stats);
> > >> -
> > >>   drop:
> > >> +       xsk_buff_free(xdp);
> > >>          u64_stats_inc(&stats->drops);
> > >>          return NULL;
> > >>   }
> > >> @@ -1396,6 +1402,8 @@ static int virtnet_add_recvbuf_xsk(struct virt=
net_info *vi, struct receive_queue
> > >>                  return -ENOMEM;
> > >>
> > >>          len =3D xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
> > >> +       /* Reserve some space for skb_shared_info */
> > >> +       len -=3D SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > >>
> > >>          for (i =3D 0; i < num; ++i) {
> > >>                  /* Use the part of XDP_PACKET_HEADROOM as the virtn=
et hdr space.
> > >> @@ -6734,6 +6742,7 @@ static int virtnet_probe(struct virtio_device =
*vdev)
> > >>          dev->netdev_ops =3D &virtnet_netdev;
> > >>          dev->stat_ops =3D &virtnet_stat_ops;
> > >>          dev->features =3D NETIF_F_HIGHDMA;
> > >> +       dev->xdp_zc_max_segs =3D VIRTNET_MAX_ZC_SEGS;
> > >>
> > >>          dev->ethtool_ops =3D &virtnet_ethtool_ops;
> > >>          SET_NETDEV_DEV(dev, &vdev->dev);
> > >> --
> > >> 2.43.0
> > >>
> > > Thanks
> > >
> >
>
> Thanks
>
>


