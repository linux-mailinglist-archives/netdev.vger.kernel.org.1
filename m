Return-Path: <netdev+bounces-247950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E56E6D00D35
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 04:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5E1D13001634
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 03:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF26427E1D7;
	Thu,  8 Jan 2026 03:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z6UFNF/T";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nIzhWE5d"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8735F277013
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 03:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767842186; cv=none; b=jkPIABUGU3tXHxl8S+Pr/gd+yIetz5Mkzh50SlDWvGP9cCvu27b0hqbS6zH9FVO8cILMZ5vFgM0oo2iOL25bO7o7put/z75zTMPf1OqGxUCDVe/bvEtgj2hKkOFZIsWiUibOHBE6/LA8JHHP2d6+ZZ1+ckM5V/1nq1p1f6uNZZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767842186; c=relaxed/simple;
	bh=bQI/y/gAY3p+Mu9dBS8pm+qeGx0cDMO1Sk8kBPffcNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7AXWaBJfzHovpBrv3YzwxOOHLhRV4jrf4Lfn6yJ1abGQz+7OvZYF8OHjZNB35hex+uOE3tBlqbLE37BIW8xVxwrURvtiRRJuxGwr4wLLrEz0VI9LFoKNb4tGSy8KgEwRbj0v36isbiNm3Mdoq2whAN6RyxVv3EJ+0gJqXMdoH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z6UFNF/T; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nIzhWE5d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767842183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WCVf+XN1lWUG9w6EJWGe3DZO0uoXc4XXbUsX+NYfhbY=;
	b=Z6UFNF/TMXNAO9jCrmvqoS9HW3z7/XZ6nw+/aPjS/wUch85j7y2Xx73bcQMG8BTWEVHMBg
	mCYrOpfJoDvKxNZdFTdbCIuRQS/qDDRGPUpbmOg72pl6rjmBeneUheaeMgUZGrooe7/zyI
	z5bX8axgetpuw3x07JwotrsH3Rbiay0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-Uo0WqWxqOACk86wIO9PNHw-1; Wed, 07 Jan 2026 22:16:20 -0500
X-MC-Unique: Uo0WqWxqOACk86wIO9PNHw-1
X-Mimecast-MFC-AGG-ID: Uo0WqWxqOACk86wIO9PNHw_1767842179
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34e5a9de94bso5205091a91.0
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 19:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767842179; x=1768446979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCVf+XN1lWUG9w6EJWGe3DZO0uoXc4XXbUsX+NYfhbY=;
        b=nIzhWE5dCPoNIlhvVXaQvR3N1XxEsOise30jwdmnG8fE9RB8Hp+W9PTdY05Fp8kTK1
         MqENcOkkAfDaYvAj5Xe0BrWRROGyzLujxiAVcy5xe5K3FoM2hkJqT1Y9fTfIklovtphe
         nVdHy2pGiuo/OjkQegKMNgQMR9igtJvgzuxOCqampfKmcS50xKXLBp/5XNy4ujO35ZWx
         9R2OG4rSLPhmwWX+ueLrACJp9DC1Rtxb9e9kvcOg3Nma2vSN0R/JQGGuoZ/n6OzJDmXT
         hoKbxQOvke6B3EfOOhIHRkSkTK1pPI96nU05CYtWpL08/R4hP+zZcYuhij/NM3HSvSAK
         Aseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767842179; x=1768446979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WCVf+XN1lWUG9w6EJWGe3DZO0uoXc4XXbUsX+NYfhbY=;
        b=jV2fBeeYPuJXTZ0sJunSPd5LYWFDBRwrvWOpLR3TS6O8oeCZX470NZQ0gZukc8zMeN
         zAW9HJnz0TCg+Bf5h1MuNZPtaylAoxZuBDpgn/6Wq7JgTglq426oQ+WzXrSYdyg6UOrJ
         Q45HCzA6asByODM1vBBELozTkFA2/a2I4HOYg2Nl276FPomfthtyZWngby9fZSbyXbC8
         37kggix8wmHryTtczO/PPt+hesmZUb+z7mLSHBxrkC/n6FUkDtoEeqGcucL0YQ60Oaq8
         S5Ou491y5HsJ0GxCWN0G9+mYoNX8hFP/So2qRbf0hcvfvX12kSv4ROr+expzfHL/skzB
         ysrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFI9YMoVHGlGq2G/MR3q2fT9xn9+9gjCUc/GdWyluBJJIRvZ9kiPq6YAu5xzeczev1/fM0qoY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6L+zXQRTpgh76cO42JtM9pBuEdesBIYUjuPeKqE3gwsh7YQqw
	Ozu68Kd8d3+Qwx23FSk5TVbs0kpjyp9Y08y8XPy69M5HhyR4U6jmigrUOAnJbGN/dbhbC+jh5L3
	jInOV/pDqsE7mImhf2AHqfQqmuldwyC4OYeWDTzKVe87rgp3FpoJSPdACEZrsz8gXmiZRQ2c9Mx
	0nT5Ih2nWNTxhtQVNPAFZl7g5uINu0/Bxo
X-Gm-Gg: AY/fxX5R1IlnBPbYvMbPQ0HK7kAlB1p1VHJ0VrJLQabXtiHmGsbLQWAZyZwgIo5kcfk
	yrXhWAJ7xEFwMlJuf8m8YHva/TBpDEaDxCUvPyowj4XtjoNiLNadcvbRPRQUL7r44gfCRRULFqn
	AfMd/rCj/ikbnJ5GXbjCA6HHTpvOTZeRBmWTk9J90Ov8iBBedxO1yoWchiasjBOk8=
X-Received: by 2002:a17:90b:2741:b0:340:ad5e:ca with SMTP id 98e67ed59e1d1-34f68c92f0emr4620510a91.12.1767842178818;
        Wed, 07 Jan 2026 19:16:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGa//Jq+6ES0cj98UxNb+mZjK304IHknCnp3nCeT+XZHx1PqY0It0m+N4FFMDd16JCo0CSL56JxY/ehfTs60hw=
X-Received: by 2002:a17:90b:2741:b0:340:ad5e:ca with SMTP id
 98e67ed59e1d1-34f68c92f0emr4620480a91.12.1767842178206; Wed, 07 Jan 2026
 19:16:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106221924.123856-1-vishs@meta.com> <20260106221924.123856-2-vishs@meta.com>
In-Reply-To: <20260106221924.123856-2-vishs@meta.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 8 Jan 2026 11:16:04 +0800
X-Gm-Features: AQt7F2p_bj1rklJKBm4c8GwEcSP1XAnQ3MgW1q9g7ScD1MZpT1lg-k_eKdDGG_s
Message-ID: <CACGkMEsfvG5NHd0ShC3DoQEfGH8FeUXDD7FFdb64wK_CkbgQ=g@mail.gmail.com>
Subject: Re: [PATCH 1/2] virtio_net: add page pool support for buffer allocation
To: Vishwanath Seshagiri <vishs@meta.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Wei <dw@davidwei.uk>, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 6:19=E2=80=AFAM Vishwanath Seshagiri <vishs@meta.com=
> wrote:
>
> Use page_pool for RX buffer allocation in mergeable and small buffer
> modes. skb_mark_for_recycle() enables page reuse.
>
> Big packets mode is unchanged because it uses page->private for linked
> list chaining of multiple pages per buffer, which conflicts with
> page_pool's internal use of page->private.
>
> Page pools are created in ndo_open and destroyed in remove (not
> ndo_close). This follows existing driver behavior where RX buffers
> remain in the virtqueue across open/close cycles and are only freed
> on device removal.
>
> The rx_mode_work_enabled flag prevents virtnet_rx_mode_work() from
> sending control virtqueue commands while ndo_close is tearing down
> device state. With MEM_TYPE_PAGE_POOL, xdp_rxq_info_unreg() calls
> page_pool_destroy() during close, and concurrent rx_mode_work can
> cause virtqueue corruption. The check is after rtnl_lock() to
> synchronize with ndo_close(), which sets the flag under the same lock.
>
> Signed-off-by: Vishwanath Seshagiri <vishs@meta.com>
> ---
>  drivers/net/virtio_net.c | 246 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 205 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 22d894101c01..c36663525c17 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -26,6 +26,7 @@
>  #include <net/netdev_rx_queue.h>
>  #include <net/netdev_queues.h>
>  #include <net/xdp_sock_drv.h>
> +#include <net/page_pool/helpers.h>
>
>  static int napi_weight =3D NAPI_POLL_WEIGHT;
>  module_param(napi_weight, int, 0444);
> @@ -359,6 +360,8 @@ struct receive_queue {
>         /* Page frag for packet buffer allocation. */
>         struct page_frag alloc_frag;
>
> +       struct page_pool *page_pool;
> +
>         /* RX: fragments + linear part + virtio header */
>         struct scatterlist sg[MAX_SKB_FRAGS + 2];
>
> @@ -524,11 +527,13 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp=
_prog, struct xdp_buff *xdp,
>                                struct virtnet_rq_stats *stats);
>  static void virtnet_receive_done(struct virtnet_info *vi, struct receive=
_queue *rq,
>                                  struct sk_buff *skb, u8 flags);
> -static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
> +static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *rq,
> +                                              struct sk_buff *head_skb,
>                                                struct sk_buff *curr_skb,
>                                                struct page *page, void *b=
uf,
>                                                int len, int truesize);
>  static void virtnet_xsk_completed(struct send_queue *sq, int num);
> +static void free_unused_bufs(struct virtnet_info *vi);
>
>  enum virtnet_xmit_type {
>         VIRTNET_XMIT_TYPE_SKB,
> @@ -709,15 +714,24 @@ static struct page *get_a_page(struct receive_queue=
 *rq, gfp_t gfp_mask)
>         return p;
>  }
>
> +static void virtnet_put_page(struct receive_queue *rq, struct page *page=
,
> +                            bool allow_direct)
> +{
> +       if (rq->page_pool)
> +               page_pool_put_page(rq->page_pool, page, -1, allow_direct)=
;
> +       else
> +               put_page(page);
> +}
> +
>  static void virtnet_rq_free_buf(struct virtnet_info *vi,
>                                 struct receive_queue *rq, void *buf)
>  {
>         if (vi->mergeable_rx_bufs)
> -               put_page(virt_to_head_page(buf));
> +               virtnet_put_page(rq, virt_to_head_page(buf), false);
>         else if (vi->big_packets)
>                 give_pages(rq, buf);
>         else
> -               put_page(virt_to_head_page(buf));
> +               virtnet_put_page(rq, virt_to_head_page(buf), false);
>  }
>
>  static void enable_delayed_refill(struct virtnet_info *vi)
> @@ -894,9 +908,11 @@ static struct sk_buff *page_to_skb(struct virtnet_in=
fo *vi,
>                 if (unlikely(!skb))
>                         return NULL;
>
> -               page =3D (struct page *)page->private;
> -               if (page)
> -                       give_pages(rq, page);
> +               if (!rq->page_pool) {
> +                       page =3D (struct page *)page->private;
> +                       if (page)
> +                               give_pages(rq, page);
> +               }
>                 goto ok;
>         }
>
> @@ -931,7 +947,10 @@ static struct sk_buff *page_to_skb(struct virtnet_in=
fo *vi,
>                 skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, off=
set,
>                                 frag_size, truesize);
>                 len -=3D frag_size;
> -               page =3D (struct page *)page->private;
> +               if (!rq->page_pool)
> +                       page =3D (struct page *)page->private;
> +               else
> +                       page =3D NULL;
>                 offset =3D 0;
>         }
>
> @@ -942,7 +961,7 @@ static struct sk_buff *page_to_skb(struct virtnet_inf=
o *vi,
>         hdr =3D skb_vnet_common_hdr(skb);
>         memcpy(hdr, hdr_p, hdr_len);
>         if (page_to_free)
> -               put_page(page_to_free);
> +               virtnet_put_page(rq, page_to_free, true);
>
>         return skb;
>  }
> @@ -982,15 +1001,10 @@ static void virtnet_rq_unmap(struct receive_queue =
*rq, void *buf, u32 len)
>  static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void=
 **ctx)
>  {
>         struct virtnet_info *vi =3D rq->vq->vdev->priv;
> -       void *buf;
>
>         BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
>
> -       buf =3D virtqueue_get_buf_ctx(rq->vq, len, ctx);
> -       if (buf)
> -               virtnet_rq_unmap(rq, buf, *len);
> -
> -       return buf;
> +       return virtqueue_get_buf_ctx(rq->vq, len, ctx);
>  }
>
>  static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, =
u32 len)
> @@ -1084,9 +1098,6 @@ static void virtnet_rq_unmap_free_buf(struct virtqu=
eue *vq, void *buf)
>                 return;
>         }
>
> -       if (!vi->big_packets || vi->mergeable_rx_bufs)
> -               virtnet_rq_unmap(rq, buf, 0);
> -
>         virtnet_rq_free_buf(vi, rq, buf);
>  }
>
> @@ -1352,7 +1363,7 @@ static int xsk_append_merge_buffer(struct virtnet_i=
nfo *vi,
>
>                 truesize =3D len;
>
> -               curr_skb  =3D virtnet_skb_append_frag(head_skb, curr_skb,=
 page,
> +               curr_skb  =3D virtnet_skb_append_frag(rq, head_skb, curr_=
skb, page,
>                                                     buf, len, truesize);
>                 if (!curr_skb) {
>                         put_page(page);
> @@ -1788,7 +1799,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>         return ret;
>  }
>
> -static void put_xdp_frags(struct xdp_buff *xdp)
> +static void put_xdp_frags(struct xdp_buff *xdp, struct receive_queue *rq=
)
>  {
>         struct skb_shared_info *shinfo;
>         struct page *xdp_page;
> @@ -1798,7 +1809,7 @@ static void put_xdp_frags(struct xdp_buff *xdp)
>                 shinfo =3D xdp_get_shared_info_from_buff(xdp);
>                 for (i =3D 0; i < shinfo->nr_frags; i++) {
>                         xdp_page =3D skb_frag_page(&shinfo->frags[i]);
> -                       put_page(xdp_page);
> +                       virtnet_put_page(rq, xdp_page, true);
>                 }
>         }
>  }
> @@ -1914,7 +1925,7 @@ static struct page *xdp_linearize_page(struct net_d=
evice *dev,
>                 off =3D buf - page_address(p);
>
>                 if (check_mergeable_len(dev, ctx, buflen)) {
> -                       put_page(p);
> +                       virtnet_put_page(rq, p, true);
>                         goto err_buf;
>                 }
>
> @@ -1922,14 +1933,14 @@ static struct page *xdp_linearize_page(struct net=
_device *dev,
>                  * is sending packet larger than the MTU.
>                  */
>                 if ((page_off + buflen + tailroom) > PAGE_SIZE) {
> -                       put_page(p);
> +                       virtnet_put_page(rq, p, true);
>                         goto err_buf;
>                 }
>
>                 memcpy(page_address(page) + page_off,
>                        page_address(p) + off, buflen);
>                 page_off +=3D buflen;
> -               put_page(p);
> +               virtnet_put_page(rq, p, true);
>         }
>
>         /* Headroom does not contribute to packet length */
> @@ -1979,7 +1990,7 @@ static struct sk_buff *receive_small_xdp(struct net=
_device *dev,
>         unsigned int headroom =3D vi->hdr_len + header_offset;
>         struct virtio_net_hdr_mrg_rxbuf *hdr =3D buf + header_offset;
>         struct page *page =3D virt_to_head_page(buf);
> -       struct page *xdp_page;
> +       struct page *xdp_page =3D NULL;
>         unsigned int buflen;
>         struct xdp_buff xdp;
>         struct sk_buff *skb;
> @@ -2013,7 +2024,7 @@ static struct sk_buff *receive_small_xdp(struct net=
_device *dev,
>                         goto err_xdp;
>
>                 buf =3D page_address(xdp_page);
> -               put_page(page);
> +               virtnet_put_page(rq, page, true);
>                 page =3D xdp_page;
>         }
>
> @@ -2045,13 +2056,19 @@ static struct sk_buff *receive_small_xdp(struct n=
et_device *dev,
>         if (metasize)
>                 skb_metadata_set(skb, metasize);
>
> +       if (rq->page_pool && !xdp_page)
> +               skb_mark_for_recycle(skb);
> +
>         return skb;
>
>  err_xdp:
>         u64_stats_inc(&stats->xdp_drops);
>  err:
>         u64_stats_inc(&stats->drops);
> -       put_page(page);
> +       if (xdp_page)
> +               put_page(page);
> +       else
> +               virtnet_put_page(rq, page, true);
>  xdp_xmit:
>         return NULL;
>  }
> @@ -2099,12 +2116,15 @@ static struct sk_buff *receive_small(struct net_d=
evice *dev,
>         }
>
>         skb =3D receive_small_build_skb(vi, xdp_headroom, buf, len);
> -       if (likely(skb))
> +       if (likely(skb)) {
> +               if (rq->page_pool)
> +                       skb_mark_for_recycle(skb);
>                 return skb;
> +       }
>
>  err:
>         u64_stats_inc(&stats->drops);
> -       put_page(page);
> +       virtnet_put_page(rq, page, true);
>         return NULL;
>  }
>
> @@ -2159,7 +2179,7 @@ static void mergeable_buf_free(struct receive_queue=
 *rq, int num_buf,
>                 }
>                 u64_stats_add(&stats->bytes, len);
>                 page =3D virt_to_head_page(buf);
> -               put_page(page);
> +               virtnet_put_page(rq, page, true);
>         }
>  }
>
> @@ -2270,7 +2290,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_de=
vice *dev,
>                 offset =3D buf - page_address(page);
>
>                 if (check_mergeable_len(dev, ctx, len)) {
> -                       put_page(page);
> +                       virtnet_put_page(rq, page, true);
>                         goto err;
>                 }
>
> @@ -2289,7 +2309,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_de=
vice *dev,
>         return 0;
>
>  err:
> -       put_xdp_frags(xdp);
> +       put_xdp_frags(xdp, rq);
>         return -EINVAL;
>  }
>
> @@ -2364,7 +2384,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_i=
nfo *vi,
>
>         *frame_sz =3D PAGE_SIZE;
>
> -       put_page(*page);
> +       virtnet_put_page(rq, *page, true);
>
>         *page =3D xdp_page;
>
> @@ -2386,6 +2406,7 @@ static struct sk_buff *receive_mergeable_xdp(struct=
 net_device *dev,
>         struct page *page =3D virt_to_head_page(buf);
>         int offset =3D buf - page_address(page);
>         unsigned int xdp_frags_truesz =3D 0;
> +       struct page *org_page =3D page;
>         struct sk_buff *head_skb;
>         unsigned int frame_sz;
>         struct xdp_buff xdp;
> @@ -2410,6 +2431,8 @@ static struct sk_buff *receive_mergeable_xdp(struct=
 net_device *dev,
>                 head_skb =3D build_skb_from_xdp_buff(dev, vi, &xdp, xdp_f=
rags_truesz);
>                 if (unlikely(!head_skb))
>                         break;
> +               if (rq->page_pool && page =3D=3D org_page)
> +                       skb_mark_for_recycle(head_skb);
>                 return head_skb;
>
>         case XDP_TX:
> @@ -2420,10 +2443,13 @@ static struct sk_buff *receive_mergeable_xdp(stru=
ct net_device *dev,
>                 break;
>         }
>
> -       put_xdp_frags(&xdp);
> +       put_xdp_frags(&xdp, rq);
>
>  err_xdp:
> -       put_page(page);
> +       if (page !=3D org_page)
> +               put_page(page);
> +       else
> +               virtnet_put_page(rq, page, true);
>         mergeable_buf_free(rq, num_buf, dev, stats);
>
>         u64_stats_inc(&stats->xdp_drops);
> @@ -2431,7 +2457,8 @@ static struct sk_buff *receive_mergeable_xdp(struct=
 net_device *dev,
>         return NULL;
>  }
>
> -static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
> +static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *rq,
> +                                              struct sk_buff *head_skb,
>                                                struct sk_buff *curr_skb,
>                                                struct page *page, void *b=
uf,
>                                                int len, int truesize)
> @@ -2463,7 +2490,7 @@ static struct sk_buff *virtnet_skb_append_frag(stru=
ct sk_buff *head_skb,
>
>         offset =3D buf - page_address(page);
>         if (skb_can_coalesce(curr_skb, num_skb_frags, page, offset)) {
> -               put_page(page);
> +               virtnet_put_page(rq, page, true);
>                 skb_coalesce_rx_frag(curr_skb, num_skb_frags - 1,
>                                      len, truesize);
>         } else {
> @@ -2512,10 +2539,13 @@ static struct sk_buff *receive_mergeable(struct n=
et_device *dev,
>         }
>
>         head_skb =3D page_to_skb(vi, rq, page, offset, len, truesize, hea=
droom);
> +       if (unlikely(!head_skb))
> +               goto err_skb;
> +
>         curr_skb =3D head_skb;
>
> -       if (unlikely(!curr_skb))
> -               goto err_skb;
> +       if (rq->page_pool)
> +               skb_mark_for_recycle(head_skb);
>         while (--num_buf) {
>                 buf =3D virtnet_rq_get_buf(rq, &len, &ctx);
>                 if (unlikely(!buf)) {
> @@ -2534,7 +2564,7 @@ static struct sk_buff *receive_mergeable(struct net=
_device *dev,
>                         goto err_skb;
>
>                 truesize =3D mergeable_ctx_to_truesize(ctx);
> -               curr_skb  =3D virtnet_skb_append_frag(head_skb, curr_skb,=
 page,
> +               curr_skb  =3D virtnet_skb_append_frag(rq, head_skb, curr_=
skb, page,
>                                                     buf, len, truesize);
>                 if (!curr_skb)
>                         goto err_skb;
> @@ -2544,7 +2574,7 @@ static struct sk_buff *receive_mergeable(struct net=
_device *dev,
>         return head_skb;
>
>  err_skb:
> -       put_page(page);
> +       virtnet_put_page(rq, page, true);
>         mergeable_buf_free(rq, num_buf, dev, stats);
>
>  err_buf:
> @@ -2683,6 +2713,8 @@ static void receive_buf(struct virtnet_info *vi, st=
ruct receive_queue *rq,
>  static int add_recvbuf_small(struct virtnet_info *vi, struct receive_que=
ue *rq,
>                              gfp_t gfp)
>  {
> +       unsigned int offset;
> +       struct page *page;
>         char *buf;
>         unsigned int xdp_headroom =3D virtnet_get_headroom(vi);
>         void *ctx =3D (void *)(unsigned long)xdp_headroom;
> @@ -2692,6 +2724,24 @@ static int add_recvbuf_small(struct virtnet_info *=
vi, struct receive_queue *rq,
>         len =3D SKB_DATA_ALIGN(len) +
>               SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>
> +       if (rq->page_pool) {

I think it would be a burden if we maintain two different data paths.
And what's more, I see this patch doesn't require DMA mapping for the
page pool. This basically defeats the pre mapping logic introduced in
31f3cd4e5756b("virtio-net: rq submits premapped per-buffer"). Lastly,
it seems we should make VIRTIO_NET select PAGE_POOL.

> +               page =3D page_pool_alloc_frag(rq->page_pool, &offset, len=
, gfp);
> +               if (unlikely(!page))
> +                       return -ENOMEM;
> +
> +               buf =3D page_address(page) + offset;
> +               buf +=3D VIRTNET_RX_PAD + xdp_headroom;
> +
> +               sg_init_table(rq->sg, 1);
> +               sg_set_buf(&rq->sg[0], buf, vi->hdr_len + GOOD_PACKET_LEN=
);
> +
> +               err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, c=
tx, gfp);
> +               if (err < 0)
> +                       page_pool_put_page(rq->page_pool,
> +                                          virt_to_head_page(buf), -1, fa=
lse);
> +               return err;
> +       }
> +
>         if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
>                 return -ENOMEM;
>
> @@ -2786,6 +2836,8 @@ static int add_recvbuf_mergeable(struct virtnet_inf=
o *vi,
>         unsigned int tailroom =3D headroom ? sizeof(struct skb_shared_inf=
o) : 0;
>         unsigned int room =3D SKB_DATA_ALIGN(headroom + tailroom);
>         unsigned int len, hole;
> +       unsigned int offset;
> +       struct page *page;
>         void *ctx;
>         char *buf;
>         int err;
> @@ -2796,6 +2848,39 @@ static int add_recvbuf_mergeable(struct virtnet_in=
fo *vi,
>          */
>         len =3D get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
>
> +       if (rq->page_pool) {
> +               page =3D page_pool_alloc_frag(rq->page_pool, &offset,
> +                                           len + room, gfp);
> +               if (unlikely(!page))
> +                       return -ENOMEM;
> +
> +               buf =3D page_address(page) + offset;
> +               buf +=3D headroom; /* advance address leaving hole at fro=
nt of pkt */
> +
> +               hole =3D PAGE_SIZE - (offset + len + room);
> +               if (hole < len + room) {
> +                       /* To avoid internal fragmentation, if there is v=
ery likely not
> +                        * enough space for another buffer, add the remai=
ning space to
> +                        * the current buffer.
> +                        * XDP core assumes that frame_size of xdp_buff a=
nd the length
> +                        * of the frag are PAGE_SIZE, so we disable the h=
ole mechanism.
> +                        */
> +                       if (!headroom)
> +                               len +=3D hole;
> +               }
> +
> +               ctx =3D mergeable_len_to_ctx(len + room, headroom);
> +
> +               sg_init_table(rq->sg, 1);
> +               sg_set_buf(&rq->sg[0], buf, len);
> +
> +               err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, c=
tx, gfp);
> +               if (err < 0)
> +                       page_pool_put_page(rq->page_pool,
> +                                          virt_to_head_page(buf), -1, fa=
lse);
> +               return err;
> +       }
> +
>         if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
>                 return -ENOMEM;
>
> @@ -3181,7 +3266,10 @@ static int virtnet_enable_queue_pair(struct virtne=
t_info *vi, int qp_index)
>                 return err;
>
>         err =3D xdp_rxq_info_reg_mem_model(&vi->rq[qp_index].xdp_rxq,
> -                                        MEM_TYPE_PAGE_SHARED, NULL);
> +                                        vi->rq[qp_index].page_pool ?
> +                                               MEM_TYPE_PAGE_POOL :
> +                                               MEM_TYPE_PAGE_SHARED,
> +                                        vi->rq[qp_index].page_pool);
>         if (err < 0)
>                 goto err_xdp_reg_mem_model;
>
> @@ -3221,11 +3309,77 @@ static void virtnet_update_settings(struct virtne=
t_info *vi)
>                 vi->duplex =3D duplex;
>  }
>
> +static int virtnet_create_page_pools(struct virtnet_info *vi)
> +{
> +       int i, err;
> +
> +       for (i =3D 0; i < vi->curr_queue_pairs; i++) {
> +               struct receive_queue *rq =3D &vi->rq[i];
> +               struct page_pool_params pp_params =3D { 0 };
> +
> +               if (rq->page_pool)
> +                       continue;
> +
> +               if (rq->xsk_pool)
> +                       continue;
> +
> +               if (!vi->mergeable_rx_bufs && vi->big_packets)
> +                       continue;
> +
> +               pp_params.order =3D 0;
> +               pp_params.pool_size =3D virtqueue_get_vring_size(rq->vq);
> +               pp_params.nid =3D dev_to_node(vi->vdev->dev.parent);
> +               pp_params.dev =3D vi->vdev->dev.parent;
> +               pp_params.netdev =3D vi->dev;
> +               pp_params.napi =3D &rq->napi;
> +               pp_params.flags =3D 0;
> +
> +               rq->page_pool =3D page_pool_create(&pp_params);
> +               if (IS_ERR(rq->page_pool)) {
> +                       err =3D PTR_ERR(rq->page_pool);
> +                       rq->page_pool =3D NULL;
> +                       goto err_cleanup;
> +               }
> +       }
> +       return 0;
> +
> +err_cleanup:
> +       while (--i >=3D 0) {
> +               struct receive_queue *rq =3D &vi->rq[i];
> +
> +               if (rq->page_pool) {
> +                       page_pool_destroy(rq->page_pool);
> +                       rq->page_pool =3D NULL;
> +               }
> +       }
> +       return err;
> +}
> +
> +static void virtnet_destroy_page_pools(struct virtnet_info *vi)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> +               struct receive_queue *rq =3D &vi->rq[i];
> +
> +               if (rq->page_pool) {
> +                       page_pool_destroy(rq->page_pool);
> +                       rq->page_pool =3D NULL;
> +               }
> +       }
> +}
> +
>  static int virtnet_open(struct net_device *dev)
>  {
>         struct virtnet_info *vi =3D netdev_priv(dev);
>         int i, err;
>
> +       err =3D virtnet_create_page_pools(vi);

Any reason those page pools were not created during the probe?

> +       if (err)
> +               return err;
> +
> +       vi->rx_mode_work_enabled =3D true;
> +
>         enable_delayed_refill(vi);
>
>         for (i =3D 0; i < vi->max_queue_pairs; i++) {
> @@ -3251,6 +3405,7 @@ static int virtnet_open(struct net_device *dev)
>         return 0;
>
>  err_enable_qp:
> +       vi->rx_mode_work_enabled =3D false;
>         disable_delayed_refill(vi);
>         cancel_delayed_work_sync(&vi->refill);
>
> @@ -3856,6 +4011,8 @@ static int virtnet_close(struct net_device *dev)
>          */
>         cancel_work_sync(&vi->config_work);
>
> +       vi->rx_mode_work_enabled =3D false;
> +
>         for (i =3D 0; i < vi->max_queue_pairs; i++) {
>                 virtnet_disable_queue_pair(vi, i);
>                 virtnet_cancel_dim(vi, &vi->rq[i].dim);
> @@ -3892,6 +4049,11 @@ static void virtnet_rx_mode_work(struct work_struc=
t *work)
>
>         rtnl_lock();
>
> +       if (!vi->rx_mode_work_enabled) {
> +               rtnl_unlock();
> +               return;
> +       }
> +
>         *promisc_allmulti =3D !!(dev->flags & IFF_PROMISC);
>         sg_init_one(sg, promisc_allmulti, sizeof(*promisc_allmulti));
>
> @@ -7193,6 +7355,8 @@ static void remove_vq_common(struct virtnet_info *v=
i)
>
>         free_receive_page_frags(vi);
>
> +       virtnet_destroy_page_pools(vi);
> +
>         virtnet_del_vqs(vi);
>  }
>
> --
> 2.47.3
>

Thanks


