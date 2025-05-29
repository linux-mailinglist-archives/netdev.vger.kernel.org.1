Return-Path: <netdev+bounces-194148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC63AC787F
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 07:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AEE11652D2
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 05:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDAD2417D9;
	Thu, 29 May 2025 05:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eYZiHjrt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE9519E97A
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 05:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748498383; cv=none; b=HLKEAORBQEWifZUtVqbI5Wlo3TCOmL/ZJZ5+YEQV0KtMlvzzBq+8pI8sAuwYxFs/w6NETiBjFbLlTWrc9ZDK2+dMHeYgj2zZDJeqmv5VDttBSduB1UlIHXLIRmT26gyR3O0HozyhQI4LS//NUNUCfLTsWMC1Hdz+Ljf1Cet0lg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748498383; c=relaxed/simple;
	bh=iPaSHY988H9Kcx23HvxF8liBMTdsJZ0pejD77+6Ls1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fN53gFk/Nd9JG9ByK/PilSXTJ75+561KfWR9GCBSE1rv+ihBXL7rF5xkBKV72kj2XFZRVUT/goikPIvsSEhOugH8QO9g3rVzejjuBvef5gCglL4RDAzjBAAqrLMtEMok1eSt/QPsJx8Qo2tUUK0O9JB4Xzo7/sywgCF57UtVMS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eYZiHjrt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748498380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hrp8Tsg3gq4eYqgZHBaMCj3lwesK/mHoylipYTBhHT4=;
	b=eYZiHjrt03XhHOKyd2BKeyl5EGu/Bh2h+Lz9UfJwjr7mY5azsmOfXN5GYFR3bZlyUfKy55
	PcGMjktjBsLD7eGKdCme/SS61vd/MTR02FCNq+7Ewa+hbuwaK1zI+NrkpszKL0FVkfAkf9
	R90aEABmp0NqLJupbKqc9BWgpEetXNk=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-mmGthmN_P8WOmkj014I04g-1; Thu, 29 May 2025 01:59:37 -0400
X-MC-Unique: mmGthmN_P8WOmkj014I04g-1
X-Mimecast-MFC-AGG-ID: mmGthmN_P8WOmkj014I04g_1748498377
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-73c09e99069so637718b3a.0
        for <netdev@vger.kernel.org>; Wed, 28 May 2025 22:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748498377; x=1749103177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hrp8Tsg3gq4eYqgZHBaMCj3lwesK/mHoylipYTBhHT4=;
        b=ZpMCMLAHqf6d5pGhSDfgiCPiQyTlTBnaqSMRMiYeT4l4q2PTAKpsRbwJeD72fHEY9V
         CfoYExS+OdBCAjN04AclMEzOnPhYm3JhOV6MZBrSsz973ssw/i3wDYT3c9VuKGDUJ5Lk
         gCnzJJf+3syOia7E4ZzvxSqUiMJk079fiveIQUimGJFfmgEwmxpUYa1+9ItVcvrZyYJp
         3eeJgMuhxqiuyWHYQ2z6g0pmnNTzgTjq21gi4JfxLy5vTnvc+boNw2PUYYSgRctnLl16
         UiqsTlQVaAOkKEmHLvQxT+dpQpV2IA4F+fFweFLPuV+FG8azCWzBLyofZQCsy7DKvoHT
         7D5Q==
X-Gm-Message-State: AOJu0YzdqHBA/NBtxj9Ed7OErSVTSLT+cIre2z/6rzgto6kvo7blxzD4
	bmyuZicC1eVaoJp7ZEq0NVVoWq0+BXQ7zwVrhn3+4+nIp5JGlfMK14XpmxWHip3poraw3mkU+gU
	kTLDBE74qLwVS6UOoVmRzMKcB0Shks5eH4yQZrBbB9yILBAmefqpo667mxd6nd27UuCgcBq6P7q
	CVVPLOqYO1q5hD4plc4POnAS+f2/a45BTK
X-Gm-Gg: ASbGncsiOzbKnbfwwQrI7vswTOD+SbPyfZV010U4eyCErurPpomWTpMBKZe7/3TcGNx
	+HTMIJ/oI55iAdWzsaNlcSmeJrMWZSpowHqI+xuR6DQOU/bLEhl7hib/NPLIE+4jQ5DzvfQ==
X-Received: by 2002:a05:6a20:3d8c:b0:1f5:8cc8:9cc5 with SMTP id adf61e73a8af0-2188c37d595mr36238828637.34.1748498376640;
        Wed, 28 May 2025 22:59:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEppiK3rECq3UScHTVDpF9H46LDpf7/Vz/aWHze9R2mzgO7X7xwc6pTEtfOfbZZgHKK1Ng9NbkbRd3EdjgJ4k8=
X-Received: by 2002:a05:6a20:3d8c:b0:1f5:8cc8:9cc5 with SMTP id
 adf61e73a8af0-2188c37d595mr36238802637.34.1748498376235; Wed, 28 May 2025
 22:59:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527161904.75259-1-minhquangbui99@gmail.com> <20250527161904.75259-2-minhquangbui99@gmail.com>
In-Reply-To: <20250527161904.75259-2-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 29 May 2025 13:59:24 +0800
X-Gm-Features: AX0GCFvV4SMxVeAp88dfab7cgPBX-hOf80WPlNoWi1BcZpIXiRmPygKp4JwIjWk
Message-ID: <CACGkMEvAJziO3KW3Nk9+appXmR92ixcTeWY_XEZz4Qz1MwrhYA@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v2 1/2] virtio-net: support zerocopy multi
 buffer XDP in mergeable
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 12:19=E2=80=AFAM Bui Quang Minh
<minhquangbui99@gmail.com> wrote:
>
> Currently, in zerocopy mode with mergeable receive buffer, virtio-net
> does not support multi buffer but a single buffer only. This commit adds
> support for multi mergeable receive buffer in the zerocopy XDP path by
> utilizing XDP buffer with frags.
>
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/net/virtio_net.c | 123 +++++++++++++++++++++------------------
>  1 file changed, 66 insertions(+), 57 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e53ba600605a..a9558650f205 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -45,6 +45,8 @@ module_param(napi_tx, bool, 0644);
>  #define VIRTIO_XDP_TX          BIT(0)
>  #define VIRTIO_XDP_REDIR       BIT(1)
>
> +#define VIRTNET_MAX_ZC_SEGS    8
> +
>  /* RX packet size EWMA. The average packet size is used to determine the=
 packet
>   * buffer size when refilling RX rings. As the entire RX ring may be ref=
illed
>   * at once, the weight is chosen so that the EWMA will be insensitive to=
 short-
> @@ -1232,65 +1234,53 @@ static void xsk_drop_follow_bufs(struct net_devic=
e *dev,
>         }
>  }
>
> -static int xsk_append_merge_buffer(struct virtnet_info *vi,
> -                                  struct receive_queue *rq,
> -                                  struct sk_buff *head_skb,
> -                                  u32 num_buf,
> -                                  struct virtio_net_hdr_mrg_rxbuf *hdr,
> -                                  struct virtnet_rq_stats *stats)
> +static int virtnet_build_xsk_buff_mrg(struct virtnet_info *vi,
> +                                     struct receive_queue *rq,
> +                                     u32 num_buf,
> +                                     struct xdp_buff *xdp,
> +                                     struct virtnet_rq_stats *stats)
>  {
> -       struct sk_buff *curr_skb;
> -       struct xdp_buff *xdp;
> -       u32 len, truesize;
> -       struct page *page;
> +       unsigned int len;
>         void *buf;
>
> -       curr_skb =3D head_skb;
> +       if (num_buf < 2)
> +               return 0;
> +
> +       while (num_buf > 1) {
> +               struct xdp_buff *new_xdp;
>
> -       while (--num_buf) {
>                 buf =3D virtqueue_get_buf(rq->vq, &len);
> -               if (unlikely(!buf)) {
> -                       pr_debug("%s: rx error: %d buffers out of %d miss=
ing\n",
> -                                vi->dev->name, num_buf,
> -                                virtio16_to_cpu(vi->vdev,
> -                                                hdr->num_buffers));
> +               if (!unlikely(buf)) {
> +                       pr_debug("%s: rx error: %d buffers missing\n",
> +                                vi->dev->name, num_buf);
>                         DEV_STATS_INC(vi->dev, rx_length_errors);
> -                       return -EINVAL;
> -               }
> -
> -               u64_stats_add(&stats->bytes, len);
> -
> -               xdp =3D buf_to_xdp(vi, rq, buf, len);
> -               if (!xdp)
> -                       goto err;
> -
> -               buf =3D napi_alloc_frag(len);
> -               if (!buf) {
> -                       xsk_buff_free(xdp);
> -                       goto err;
> +                       return -1;
>                 }
>
> -               memcpy(buf, xdp->data - vi->hdr_len, len);
> -
> -               xsk_buff_free(xdp);
> +               new_xdp =3D buf_to_xdp(vi, rq, buf, len);
> +               if (!new_xdp)
> +                       goto drop_bufs;
>
> -               page =3D virt_to_page(buf);
> +               /* In virtnet_add_recvbuf_xsk(), we ask the host to fill =
from
> +                * xdp->data - vi->hdr_len with both virtio_net_hdr and d=
ata.
> +                * However, only the first packet has the virtio_net_hdr,=
 the
> +                * following ones do not. So we need to adjust the follow=
ing

Typo here.

> +                * packets' data pointer to the correct place.
> +                */

I wonder what happens if we don't use this trick? I meant we don't
reuse the header room for the virtio-net header. This seems to be fine
for a mergeable buffer and can help to reduce the trick.

> +               new_xdp->data -=3D vi->hdr_len;
> +               new_xdp->data_end =3D new_xdp->data + len;
>
> -               truesize =3D len;
> +               if (!xsk_buff_add_frag(xdp, new_xdp))
> +                       goto drop_bufs;
>
> -               curr_skb  =3D virtnet_skb_append_frag(head_skb, curr_skb,=
 page,
> -                                                   buf, len, truesize);
> -               if (!curr_skb) {
> -                       put_page(page);
> -                       goto err;
> -               }
> +               num_buf--;
>         }
>
>         return 0;
>
> -err:
> +drop_bufs:
>         xsk_drop_follow_bufs(vi->dev, rq, num_buf, stats);
> -       return -EINVAL;
> +       return -1;
>  }
>
>  static struct sk_buff *virtnet_receive_xsk_merge(struct net_device *dev,=
 struct virtnet_info *vi,
> @@ -1307,23 +1297,42 @@ static struct sk_buff *virtnet_receive_xsk_merge(=
struct net_device *dev, struct
>         num_buf =3D virtio16_to_cpu(vi->vdev, hdr->num_buffers);
>
>         ret =3D XDP_PASS;
> +       if (virtnet_build_xsk_buff_mrg(vi, rq, num_buf, xdp, stats))
> +               goto drop;
> +
>         rcu_read_lock();
>         prog =3D rcu_dereference(rq->xdp_prog);
> -       /* TODO: support multi buffer. */
> -       if (prog && num_buf =3D=3D 1)
> -               ret =3D virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, sta=
ts);

Without this patch it looks like we had a bug:

        ret =3D XDP_PASS;
        rcu_read_lock();
        prog =3D rcu_dereference(rq->xdp_prog);
        /* TODO: support multi buffer. */
        if (prog && num_buf =3D=3D 1)
                ret =3D virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, stats=
);
        rcu_read_unlock();

This implies if num_buf is greater than 1, we will assume XDP_PASS?

> +       if (prog) {
> +               /* We are in zerocopy mode so we cannot copy the multi-bu=
ffer
> +                * xdp buff to a single linear xdp buff. If we do so, in =
case
> +                * the BPF program decides to redirect to a XDP socket (X=
SK),
> +                * it will trigger the zerocopy receive logic in XDP sock=
et.
> +                * The receive logic thinks it receives zerocopy buffer w=
hile
> +                * in fact, it is the copy one and everything is messed u=
p.
> +                * So just drop the packet here if we have a multi-buffer=
 xdp
> +                * buff and the BPF program does not support it.
> +                */
> +               if (xdp_buff_has_frags(xdp) && !prog->aux->xdp_has_frags)
> +                       ret =3D XDP_DROP;

Could we move the check before trying to build a multi-buffer XDP buff?

> +               else
> +                       ret =3D virtnet_xdp_handler(prog, xdp, dev, xdp_x=
mit,
> +                                                 stats);
> +       }
>         rcu_read_unlock();
>
>         switch (ret) {
>         case XDP_PASS:
> -               skb =3D xsk_construct_skb(rq, xdp);
> +               skb =3D xdp_build_skb_from_zc(xdp);

Is this better to make this change a separate patch?

>                 if (!skb)
> -                       goto drop_bufs;
> +                       break;
>
> -               if (xsk_append_merge_buffer(vi, rq, skb, num_buf, hdr, st=
ats)) {
> -                       dev_kfree_skb(skb);
> -                       goto drop;
> -               }
> +               /* Later, in virtnet_receive_done(), eth_type_trans()
> +                * is called. However, in xdp_build_skb_from_zc(), it is =
called
> +                * already. As a result, we need to reset the data to bef=
ore
> +                * the mac header so that the later call in
> +                * virtnet_receive_done() works correctly.
> +                */
> +               skb_push(skb, ETH_HLEN);
>
>                 return skb;
>
> @@ -1332,14 +1341,11 @@ static struct sk_buff *virtnet_receive_xsk_merge(=
struct net_device *dev, struct
>                 return NULL;
>
>         default:
> -               /* drop packet */
> -               xsk_buff_free(xdp);
> +               break;
>         }
>
> -drop_bufs:
> -       xsk_drop_follow_bufs(dev, rq, num_buf, stats);
> -
>  drop:
> +       xsk_buff_free(xdp);
>         u64_stats_inc(&stats->drops);
>         return NULL;
>  }
> @@ -1396,6 +1402,8 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_i=
nfo *vi, struct receive_queue
>                 return -ENOMEM;
>
>         len =3D xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
> +       /* Reserve some space for skb_shared_info */
> +       len -=3D SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>
>         for (i =3D 0; i < num; ++i) {
>                 /* Use the part of XDP_PACKET_HEADROOM as the virtnet hdr=
 space.
> @@ -6734,6 +6742,7 @@ static int virtnet_probe(struct virtio_device *vdev=
)
>         dev->netdev_ops =3D &virtnet_netdev;
>         dev->stat_ops =3D &virtnet_stat_ops;
>         dev->features =3D NETIF_F_HIGHDMA;
> +       dev->xdp_zc_max_segs =3D VIRTNET_MAX_ZC_SEGS;
>
>         dev->ethtool_ops =3D &virtnet_ethtool_ops;
>         SET_NETDEV_DEV(dev, &vdev->dev);
> --
> 2.43.0
>

Thanks


