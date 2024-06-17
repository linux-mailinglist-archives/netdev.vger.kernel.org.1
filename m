Return-Path: <netdev+bounces-103920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4AB90A54F
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 08:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F33A1C26364
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 06:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A8C14AA0;
	Mon, 17 Jun 2024 06:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZbTLng1j"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A5244C97
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 06:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718605170; cv=none; b=CIjc4I9SGCvbBXC1osj1T4eiVedcCfHMMotuYdUvqzvCqUyQC9rSNzOUOPyZ1FLNZyQJy0dapPlOrmVZPWASAe0328xjxnciTMj+a/KBPOPZjwXsSDCvI0a4c7hxvSZt7OGye83JGwh1vmk/AkUb1ddi9VO+47udcmO5tq9X1Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718605170; c=relaxed/simple;
	bh=D3F1+wyPNv99pLuWCLMnYf9GX99vUkaguc1vOIUJK5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H1oNgXdEfXiUQ/AXztDKSrp0oK3GhVhTj+lv+QP6K8lqtOe/P3I/cGqTeODbEpziPaXJCtc6MulpG7N7P3wtuhzhBdRWxzFdf3TShv8iU1M6dX5ByW2AQJ8Dt2pRuop3j/erJHv8yoEyB6GLgI0KrM7+Jwm6BToP5/mwncTpAXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZbTLng1j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718605167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68rdNBfzYo3jL2HKY9FjMg3nqX/reCxplu85cw2e+zU=;
	b=ZbTLng1j3KKto9EjV9V3yf2ZMoiYdGkDiUV8nfGFTQhOjQYnQfcIvfSiGMfcSBBUjIyMjv
	IQk3rlrxxKNjSPht45Sk9ZhSm83RBUWqvjcPFZ35nww7QwkgtwZhPSW0HEyDFH78Xl91Nl
	Tn71D7udhgDekr2DMniyyir/u3EIlLk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-lW9MRaSfORWt6eivlfflqQ-1; Mon, 17 Jun 2024 02:19:25 -0400
X-MC-Unique: lW9MRaSfORWt6eivlfflqQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2c24109ad3fso4237506a91.0
        for <netdev@vger.kernel.org>; Sun, 16 Jun 2024 23:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718605164; x=1719209964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68rdNBfzYo3jL2HKY9FjMg3nqX/reCxplu85cw2e+zU=;
        b=ORwlCt1JXHD1JragYfmHEWgqbdBpylOnibAKuslIk/Qj0rI5z+69yJ2L7R1NTDavwu
         PxQk5yc6HLqf5QZSTIXzp9KpvJbBxQtlCCoWLxmDr+YppOrN9yPlmCDk43DKMQ4dD1JD
         NgSRqkuaqKSn9N1uCmQxzEkI7GU3tPkqh4SIPMkRCie2VlaKqcJm2ocdw3mGHDbipVlw
         v40R6cjxYEVhAN50m8SfgXMprpCrwrxby2TwdITr9UHNCl42FeSeaglV1RrQeB2scbxo
         0uTbxRp4qOEtMfBOqwZ5o6AGo6YuXlY64Fss50kLFve1taZNsmtnI34vr8yiw8fv3cFG
         OEvg==
X-Gm-Message-State: AOJu0YycBSbg33dRQH5x2Lc3yuNGRxM+aQTPdm5JrMYHVl/IGH3uNvqs
	SVCjyGZULFI8VjFXn48bV5ZijdAGNzpqkaceuttprNxr66J5otFkKFKRnA4xw2zCCC7go+kjNif
	ffKbxUlfexjyamuU0QqwxeQl5DrDoTniWKpQp4mHHtvdjjcKbTNcdmx0Ifm2RLoC3CWaZRuWgqP
	x79xsAE/7sm4DLbGdO13jhYL+AgBtnPcgMbkiefe738Q==
X-Received: by 2002:a17:90b:1112:b0:2c2:d442:aa10 with SMTP id 98e67ed59e1d1-2c4dbd37314mr7497223a91.45.1718605164508;
        Sun, 16 Jun 2024 23:19:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpDhbg7hzNeYN1jye51VdlcD+fKBolhKUzjQ8YClA8wp9731FwGIgwnJcNIWGiLu2E/ivpouxmISkPWByZKI8=
X-Received: by 2002:a17:90b:1112:b0:2c2:d442:aa10 with SMTP id
 98e67ed59e1d1-2c4dbd37314mr7497195a91.45.1718605163662; Sun, 16 Jun 2024
 23:19:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614063933.108811-1-xuanzhuo@linux.alibaba.com> <20240614063933.108811-10-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240614063933.108811-10-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jun 2024 14:19:10 +0800
Message-ID: <CACGkMEuLJSuM2Y1JRnvDoQG-dBsLGaOctv7tDdq8NjFOD2miSw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 09/15] virtio_net: xsk: bind/unbind xsk
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

On Fri, Jun 14, 2024 at 2:39=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> This patch implement the logic of bind/unbind xsk pool to sq and rq.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 201 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 200 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 88ab9ea1646f..35fd8bca7fcf 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -26,6 +26,7 @@
>  #include <net/netdev_rx_queue.h>
>  #include <net/netdev_queues.h>
>  #include <uapi/linux/virtio_ring.h>
> +#include <net/xdp_sock_drv.h>
>
>  static int napi_weight =3D NAPI_POLL_WEIGHT;
>  module_param(napi_weight, int, 0444);
> @@ -57,6 +58,8 @@ DECLARE_EWMA(pkt_len, 0, 64)
>
>  #define VIRTNET_DRIVER_VERSION "1.0.0"
>
> +static struct virtio_net_hdr_mrg_rxbuf xsk_hdr;

Does this mean AF_XDP only supports virtio_net_hdr_mrg_rxbuf but not others=
?

> +
>  static const unsigned long guest_offloads[] =3D {
>         VIRTIO_NET_F_GUEST_TSO4,
>         VIRTIO_NET_F_GUEST_TSO6,
> @@ -321,6 +324,12 @@ struct send_queue {
>         bool premapped;
>
>         struct virtnet_sq_dma_info dmainfo;
> +
> +       struct {
> +               struct xsk_buff_pool *pool;
> +
> +               dma_addr_t hdr_dma_address;
> +       } xsk;
>  };
>
>  /* Internal representation of a receive virtqueue */
> @@ -372,6 +381,13 @@ struct receive_queue {
>
>         /* Record the last dma info to free after new pages is allocated.=
 */
>         struct virtnet_rq_dma *last_dma;
> +
> +       struct {
> +               struct xsk_buff_pool *pool;
> +
> +               /* xdp rxq used by xsk */
> +               struct xdp_rxq_info xdp_rxq;
> +       } xsk;
>  };
>
>  /* This structure can contain rss message with maximum settings for indi=
rection table and keysize
> @@ -695,7 +711,7 @@ static void virtnet_sq_free_dma_meta(struct send_queu=
e *sq)
>  /* This function must be called immediately after creating the vq, or af=
ter vq
>   * reset, and before adding any buffers to it.
>   */
> -static __maybe_unused int virtnet_sq_set_premapped(struct send_queue *sq=
, bool premapped)
> +static int virtnet_sq_set_premapped(struct send_queue *sq, bool premappe=
d)
>  {
>         if (premapped) {
>                 int r;
> @@ -5177,6 +5193,187 @@ static int virtnet_restore_guest_offloads(struct =
virtnet_info *vi)
>         return virtnet_set_guest_offloads(vi, offloads);
>  }
>
> +static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct rece=
ive_queue *rq,
> +                                   struct xsk_buff_pool *pool)
> +{
> +       int err, qindex;
> +
> +       qindex =3D rq - vi->rq;
> +
> +       if (pool) {
> +               err =3D xdp_rxq_info_reg(&rq->xsk.xdp_rxq, vi->dev, qinde=
x, rq->napi.napi_id);
> +               if (err < 0)
> +                       return err;
> +
> +               err =3D xdp_rxq_info_reg_mem_model(&rq->xsk.xdp_rxq,
> +                                                MEM_TYPE_XSK_BUFF_POOL, =
NULL);
> +               if (err < 0) {
> +                       xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
> +                       return err;
> +               }
> +
> +               xsk_pool_set_rxq_info(pool, &rq->xsk.xdp_rxq);
> +       }
> +
> +       virtnet_rx_pause(vi, rq);
> +
> +       err =3D virtqueue_reset(rq->vq, virtnet_rq_unmap_free_buf);
> +       if (err) {
> +               netdev_err(vi->dev, "reset rx fail: rx queue index: %d er=
r: %d\n", qindex, err);
> +
> +               pool =3D NULL;
> +       }
> +
> +       if (!pool)
> +               xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);

Let's use err label instead of duplicating xdp_rxq_info_unreg() here?

> +
> +       rq->xsk.pool =3D pool;
> +
> +       virtnet_rx_resume(vi, rq);
> +
> +       return err;
> +}
> +
> +static int virtnet_sq_bind_xsk_pool(struct virtnet_info *vi,
> +                                   struct send_queue *sq,
> +                                   struct xsk_buff_pool *pool)
> +{
> +       int err, qindex;
> +
> +       qindex =3D sq - vi->sq;
> +
> +       virtnet_tx_pause(vi, sq);
> +
> +       err =3D virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf);
> +       if (err)
> +               netdev_err(vi->dev, "reset tx fail: tx queue index: %d er=
r: %d\n", qindex, err);
> +       else
> +               err =3D virtnet_sq_set_premapped(sq, !!pool);
> +
> +       if (err)
> +               pool =3D NULL;
> +
> +       sq->xsk.pool =3D pool;
> +
> +       virtnet_tx_resume(vi, sq);
> +
> +       return err;
> +}
> +
> +static int virtnet_xsk_pool_enable(struct net_device *dev,
> +                                  struct xsk_buff_pool *pool,
> +                                  u16 qid)
> +{
> +       struct virtnet_info *vi =3D netdev_priv(dev);
> +       struct receive_queue *rq;
> +       struct send_queue *sq;
> +       struct device *dma_dev;
> +       dma_addr_t hdr_dma;
> +       int err;
> +
> +       /* In big_packets mode, xdp cannot work, so there is no need to
> +        * initialize xsk of rq.
> +        *
> +        * Support for small mode firstly.

This comment is kind of confusing, I think mergeable mode is also
supported. If it's true, we can simply remove it.

> +        */
> +       if (vi->big_packets)
> +               return -ENOENT;
> +
> +       if (qid >=3D vi->curr_queue_pairs)
> +               return -EINVAL;
> +
> +       sq =3D &vi->sq[qid];
> +       rq =3D &vi->rq[qid];
> +
> +       /* xsk tx zerocopy depend on the tx napi.
> +        *
> +        * All xsk packets are actually consumed and sent out from the xs=
k tx
> +        * queue under the tx napi mechanism.
> +        */
> +       if (!sq->napi.weight)
> +               return -EPERM;
> +
> +       /* For the xsk, the tx and rx should have the same device. But
> +        * vq->dma_dev allows every vq has the respective dma dev. So I c=
heck
> +        * the dma dev of vq and sq is the same dev.
> +        */
> +       if (virtqueue_dma_dev(rq->vq) !=3D virtqueue_dma_dev(sq->vq))
> +               return -EPERM;

I don't understand how a different DMA device matters here. It looks
like the code is using per virtqueue DMA below.

> +
> +       dma_dev =3D virtqueue_dma_dev(rq->vq);
> +       if (!dma_dev)
> +               return -EPERM;
> +
> +       hdr_dma =3D dma_map_single(dma_dev, &xsk_hdr, vi->hdr_len, DMA_TO=
_DEVICE);
> +       if (dma_mapping_error(dma_dev, hdr_dma))
> +               return -ENOMEM;
> +
> +       err =3D xsk_pool_dma_map(pool, dma_dev, 0);
> +       if (err)
> +               goto err_xsk_map;
> +
> +       err =3D virtnet_rq_bind_xsk_pool(vi, rq, pool);
> +       if (err)
> +               goto err_rq;
> +
> +       err =3D virtnet_sq_bind_xsk_pool(vi, sq, pool);
> +       if (err)
> +               goto err_sq;
> +
> +       /* Now, we do not support tx offset, so all the tx virtnet hdr is=
 zero.
> +        * So all the tx packets can share a single hdr.
> +        */
> +       sq->xsk.hdr_dma_address =3D hdr_dma;
> +
> +       return 0;
> +
> +err_sq:
> +       virtnet_rq_bind_xsk_pool(vi, rq, NULL);
> +err_rq:
> +       xsk_pool_dma_unmap(pool, 0);
> +err_xsk_map:
> +       dma_unmap_single(dma_dev, hdr_dma, vi->hdr_len, DMA_TO_DEVICE);
> +       return err;
> +}
> +
> +static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)
> +{
> +       struct virtnet_info *vi =3D netdev_priv(dev);
> +       struct xsk_buff_pool *pool;
> +       struct device *dma_dev;
> +       struct receive_queue *rq;
> +       struct send_queue *sq;
> +       int err1, err2;
> +
> +       if (qid >=3D vi->curr_queue_pairs)
> +               return -EINVAL;
> +
> +       sq =3D &vi->sq[qid];
> +       rq =3D &vi->rq[qid];
> +
> +       pool =3D sq->xsk.pool;
> +
> +       err1 =3D virtnet_sq_bind_xsk_pool(vi, sq, NULL);
> +       err2 =3D virtnet_rq_bind_xsk_pool(vi, rq, NULL);
> +
> +       xsk_pool_dma_unmap(pool, 0);
> +
> +       dma_dev =3D virtqueue_dma_dev(rq->vq);
> +
> +       dma_unmap_single(dma_dev, sq->xsk.hdr_dma_address, vi->hdr_len, D=
MA_TO_DEVICE);
> +
> +       return err1 | err2;
> +}
> +
> +static int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_=
bpf *xdp)
> +{
> +       if (xdp->xsk.pool)
> +               return virtnet_xsk_pool_enable(dev, xdp->xsk.pool,
> +                                              xdp->xsk.queue_id);
> +       else
> +               return virtnet_xsk_pool_disable(dev, xdp->xsk.queue_id);
> +}
> +
>  static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog=
,
>                            struct netlink_ext_ack *extack)
>  {
> @@ -5302,6 +5499,8 @@ static int virtnet_xdp(struct net_device *dev, stru=
ct netdev_bpf *xdp)
>         switch (xdp->command) {
>         case XDP_SETUP_PROG:
>                 return virtnet_xdp_set(dev, xdp->prog, xdp->extack);
> +       case XDP_SETUP_XSK_POOL:
> +               return virtnet_xsk_pool_setup(dev, xdp);
>         default:
>                 return -EINVAL;
>         }
> --
> 2.32.0.3.g01195cf9f
>

Thanks


