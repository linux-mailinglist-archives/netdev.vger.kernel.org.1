Return-Path: <netdev+bounces-107525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D1A91B50B
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 04:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A78E1C21876
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 02:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4121F95E;
	Fri, 28 Jun 2024 02:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hufR1Z6e"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024A61E888
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 02:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719541205; cv=none; b=p77RIKknwmOrPnoMMhYcoTUjUmJZIm9JesgAXwbhlxO6Y1uIVD3MZTjk4hNhuYc8VL1RHXCjFJD878YfHmI+aCwPNayNKOwPk6duYpsTv0Iqz00II3RPLMu71MBH3A30E+vCSrryr/2ylXZPi6oXbQQhn8An2Zm5yvCxEK1dTBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719541205; c=relaxed/simple;
	bh=O/CQfmPQM0eY4d7wyOW5I4ggKNFPLdYmErVxqBo6dFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AalbPfm7gb7d5zZbadWj1HWICFoaKc6rAq8ZaVok8ISIt4xuRXVMls4G3nWobtNNGPn/1Y4j6UnTKaoZYnh7qKZgcN8oxpk17zV/Q7UrHCulxxxLmsA/9f7NQXPzu1d3rt7XIhnbKq8Dk4JK7N9830lC/rZlDAIh9BuQYjl17hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hufR1Z6e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719541201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=24Ce/ZaIZMNMqzCu0jVvb+4QsT79hmjdfiG5HRValjs=;
	b=hufR1Z6eGLxPI/OPQA5g+Zk9rY1e4y17FT3s4bx59wKiBnkC57JnJiwWn6ZRyYGYojhI9c
	3e2TcURaH70BK+lCE/2tV5U1yXR/e/+2IMIQcjfhyof2coWb0kdC5lDywZPd2BK3PIyhcy
	BWB26eHooSkz1IwHZMs2U34PqXDqS9Y=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-ee8LKFWNODe2BBmzaA5FPA-1; Thu, 27 Jun 2024 22:19:58 -0400
X-MC-Unique: ee8LKFWNODe2BBmzaA5FPA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2c7a8a79cebso198531a91.3
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 19:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719541196; x=1720145996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24Ce/ZaIZMNMqzCu0jVvb+4QsT79hmjdfiG5HRValjs=;
        b=Pez8zCjjKK9Oe3gNurJZWrWxtyv+qUCv8TiOA2YSEe04z3tE5h8B22KCWmwY6XCp2q
         Naw5FsMZUihfENK3j4TN8sI+n3L6qt+Bgyn3zEO6bgEjhZq9fqwTzyvl/cCaxleOORAZ
         PRk1jtujZozMIs/TY+7yOf6njNi4jU4PYN/T/ylRpzY7bZR4uuTnNRd8rqsp4ofAM4Xc
         TnztutKhT2/WTzyMWiogIU2MyH2Zy/SbEzZ10Orx7D17oHzPOVf9GtE32Eo5923e0POn
         dtqsh15C8MVPMkV+GqzbuBOpofWR1KNPzQLqCQ6xd7WtLaSfT4RsEJYPargHLEQhLeq+
         I+hQ==
X-Gm-Message-State: AOJu0Yw70crNN5G6rl2RBxvniFszG5C2RyNdByj07P9r7+upHFkfa9Op
	WcE+O/yPJsQQP9pkNq5Vp6Yo/yW90uye8AHfGrmlqivS7qSvQljR88OVJTB7LUOQzBK1MN455yg
	M1RebxIiAc4GqGBBuXQSEqrIMmLcYV6ZHEIeJ4yZydrYOBJgVGvIB/If8Nbu+x9fvSgLzzH66f8
	gnZd5sKhiyz1fjpxBjd9Uzxb2z+1LT
X-Received: by 2002:a17:90a:b116:b0:2c8:858:7035 with SMTP id 98e67ed59e1d1-2c8614096cemr12176239a91.25.1719541196386;
        Thu, 27 Jun 2024 19:19:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHudDP8J7qpcW2Ue6bVOpBtlOp14tFGDgoD+/QZ3lixc37SvGcGCSAu5MccMrSsp2Brpo3cHqpWaXec/5SUpo=
X-Received: by 2002:a17:90a:b116:b0:2c8:858:7035 with SMTP id
 98e67ed59e1d1-2c8614096cemr12176229a91.25.1719541195933; Thu, 27 Jun 2024
 19:19:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618075643.24867-1-xuanzhuo@linux.alibaba.com> <20240618075643.24867-10-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240618075643.24867-10-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 28 Jun 2024 10:19:44 +0800
Message-ID: <CACGkMEsqBeV9mSVV0yO_sZ=hB==PFoHvtPyma1pctc_+HMEFrA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 09/10] virtio_net: xsk: rx: support recv merge mode
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

On Tue, Jun 18, 2024 at 3:57=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Support AF-XDP for merge mode.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 139 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 139 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 06608d696e2e..cfa106aa8039 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -504,6 +504,10 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_=
prog, struct xdp_buff *xdp,
>                                struct net_device *dev,
>                                unsigned int *xdp_xmit,
>                                struct virtnet_rq_stats *stats);
> +static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
> +                                              struct sk_buff *curr_skb,
> +                                              struct page *page, void *b=
uf,
> +                                              int len, int truesize);
>
>  static bool is_xdp_frame(void *ptr)
>  {
> @@ -1128,6 +1132,139 @@ static struct sk_buff *virtnet_receive_xsk_small(=
struct net_device *dev, struct
>         }
>  }
>
> +static void xsk_drop_follow_bufs(struct net_device *dev,
> +                                struct receive_queue *rq,
> +                                u32 num_buf,
> +                                struct virtnet_rq_stats *stats)
> +{
> +       struct xdp_buff *xdp;
> +       u32 len;
> +
> +       while (num_buf-- > 1) {
> +               xdp =3D virtqueue_get_buf(rq->vq, &len);
> +               if (unlikely(!xdp)) {
> +                       pr_debug("%s: rx error: %d buffers missing\n",
> +                                dev->name, num_buf);
> +                       DEV_STATS_INC(dev, rx_length_errors);
> +                       break;
> +               }
> +               u64_stats_add(&stats->bytes, len);
> +               xsk_buff_free(xdp);
> +       }
> +}
> +
> +static int xsk_append_merge_buffer(struct virtnet_info *vi,
> +                                  struct receive_queue *rq,
> +                                  struct sk_buff *head_skb,
> +                                  u32 num_buf,
> +                                  struct virtio_net_hdr_mrg_rxbuf *hdr,
> +                                  struct virtnet_rq_stats *stats)
> +{
> +       struct sk_buff *curr_skb;
> +       struct xdp_buff *xdp;
> +       u32 len, truesize;
> +       struct page *page;
> +       void *buf;
> +
> +       curr_skb =3D head_skb;
> +
> +       while (--num_buf) {
> +               buf =3D virtqueue_get_buf(rq->vq, &len);
> +               if (unlikely(!buf)) {
> +                       pr_debug("%s: rx error: %d buffers out of %d miss=
ing\n",
> +                                vi->dev->name, num_buf,
> +                                virtio16_to_cpu(vi->vdev,
> +                                                hdr->num_buffers));
> +                       DEV_STATS_INC(vi->dev, rx_length_errors);
> +                       return -EINVAL;
> +               }
> +
> +               u64_stats_add(&stats->bytes, len);
> +
> +               xdp =3D buf_to_xdp(vi, rq, buf, len);
> +               if (!xdp)
> +                       goto err;
> +
> +               buf =3D napi_alloc_frag(len);

So we don't do this for non xsk paths. Any reason we can't reuse the
existing codes?

Thanks


