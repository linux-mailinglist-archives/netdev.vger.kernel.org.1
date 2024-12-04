Return-Path: <netdev+bounces-148773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DC69E3196
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 03:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58B95B2961B
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 02:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E029E40855;
	Wed,  4 Dec 2024 02:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="boQjkTkI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284B14A1A
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 02:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733280558; cv=none; b=MByEmi9ZwNrsK3+Vq+4blVR+PlVIbSUqBPwdjby9PsppavVGs5makDceKO3u7KUCeUHNSWKtPIany6V/FdCzCmj4TliJ+Iw/DQrLE0fuA2rTA0UdmvPLlbNwmcF+5OtNtcHl+Zay31b2Sg7Mqg4JFHy2o9v0asBo4uoNzYjwZtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733280558; c=relaxed/simple;
	bh=TOKXJ9rIYYz9mEp3F9nZfG9+id1wmYy7VtWtelOVUxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oh+mIWF0mZK0p3zDfglYxtjBDZyyHpTObBz9pSXYzoGkU0HqD6j8X8B5DAaN59o1WeMGw/eWl4jGNRp4QSA8Z1czqZ+hqcKQ7OsActiE3/4K+itOCyBRf2oHXjbz17j/tf0Tvsw4Owvadlxjl2tv73r1NRmvNLWcGeD08Uzij7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=boQjkTkI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733280556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c24b0aojPcSy5fMUgMajgZWX2t8sneTXVxIv1lQUC1A=;
	b=boQjkTkIEIUKjQoCyiPVeXh9UhqzOm88YH+8L++XGG8RMlhBlV4AyhLvgf2zQetOdDzgfX
	aFlECIcOOaFKuC10uj1k+eWuJ1UjEHGg9TzVAHkalWclr0KizSrTYugqtJGRSWZ+oxq0xq
	6wfAb0tvFjBmvFr7MBXO/9PoS5TqyY0=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-Cki7TkeuNUGR7-Y8iXiG5Q-1; Tue, 03 Dec 2024 21:49:15 -0500
X-MC-Unique: Cki7TkeuNUGR7-Y8iXiG5Q-1
X-Mimecast-MFC-AGG-ID: Cki7TkeuNUGR7-Y8iXiG5Q
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-7fcf8b5140fso273535a12.0
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 18:49:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733280554; x=1733885354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c24b0aojPcSy5fMUgMajgZWX2t8sneTXVxIv1lQUC1A=;
        b=A5U/R0YUDWkjRJdfTq6xskYXpeLfftjv/x0zSR3gc2FrrxrUulzK0kcK+C85bpzZja
         Hp4HunKY7+nG00qD59p3xYXRzguF6zYVbPeumEfjHYd6RAiv+LK1dH+cH6ApSqWVzCAh
         5r1/n8LYxe2sx3tV6X+b4iBpfGLAK9iZHVsx7dD0xki+SvEjETfVGRC6DHLJIZCpsPW3
         rD9os6vip4VBNV9TR0dOxFthj84/wMzoBBn6UmkQ4OZ9fllcxrDR1RJmi+WhS7jdW5pV
         ZxDnz8TZuoqwKnkAIrlI3HWus3Mqfa/McEV0YSxsKcJwMAGQkBGfZFYWM4hydu50EzL2
         KZ7A==
X-Forwarded-Encrypted: i=1; AJvYcCUxG39zjEd7D/kp27++LTzARh4dSGMNgUlUmFctXIjoIRzGIrlkb024fGPgEzNJvBbFh1JCWCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVmeg8Dz0QYAuKXe6cXaNw5jZlsuVfWDZlbLXpbwNZz4dFUrZW
	yFKEZY4+OmfcU+vSOFDXl3D2ToNPwhUHvrSuVFSQoA4JtILt1Pc0B6XxUu4+51T5TidJ3cs2HYf
	rJEboAdemV2uMuZTUncofF3zS8T2OUMaeNS16KXPtbXVfDMP5Bvf++mgNGCf2SbKMuR7mV+jXBG
	DqdzR8Vf54SAjwFiphufwqd91EY9ed
X-Gm-Gg: ASbGnctQHJjP/3wmtiBHDY5yt/lbTla6IqPOcAYMfjY4SfOpqb1FMFYx+mM5HHg0lNe
	7JvDOOB+mDqmuWqq1bJ00WDcbxpiwXxvU
X-Received: by 2002:a17:90b:1e4f:b0:2ee:ad18:b310 with SMTP id 98e67ed59e1d1-2ef0262ddc4mr7260544a91.18.1733280554231;
        Tue, 03 Dec 2024 18:49:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZcqsAhghjmH/484dFh700xwwcOiFPYlB810UI197DONEX9jOMQzSsmaISh5CyYuH1hhBd5fKSpxOiglUbnhk=
X-Received: by 2002:a17:90b:1e4f:b0:2ee:ad18:b310 with SMTP id
 98e67ed59e1d1-2ef0262ddc4mr7260510a91.18.1733280553846; Tue, 03 Dec 2024
 18:49:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203073025.67065-1-koichiro.den@canonical.com> <20241203073025.67065-5-koichiro.den@canonical.com>
In-Reply-To: <20241203073025.67065-5-koichiro.den@canonical.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Dec 2024 10:49:02 +0800
Message-ID: <CACGkMEuUa+6_uaa7H2CSvUnfNzBr-rdoQ+cp8eZD+Ay1CZ=A-g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/5] virtio_ring: add 'flushed' as an argument
 to virtqueue_reset()
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 3:31=E2=80=AFPM Koichiro Den <koichiro.den@canonical=
.com> wrote:
>
> When virtqueue_reset() has actually recycled all unused buffers,
> additional work may be required in some cases. Relying solely on its
> return status is fragile, so introduce a new argument 'flushed' to
> explicitly indicate whether it has really occurred.
>
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> ---
>  drivers/net/virtio_net.c     | 6 ++++--
>  drivers/virtio/virtio_ring.c | 6 +++++-
>  include/linux/virtio.h       | 3 ++-
>  3 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0103d7990e44..d5240a03b7d6 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -5695,6 +5695,7 @@ static int virtnet_rq_bind_xsk_pool(struct virtnet_=
info *vi, struct receive_queu
>                                     struct xsk_buff_pool *pool)
>  {
>         int err, qindex;
> +       bool flushed;
>
>         qindex =3D rq - vi->rq;
>
> @@ -5713,7 +5714,7 @@ static int virtnet_rq_bind_xsk_pool(struct virtnet_=
info *vi, struct receive_queu
>
>         virtnet_rx_pause(vi, rq);
>
> -       err =3D virtqueue_reset(rq->vq, virtnet_rq_unmap_free_buf);
> +       err =3D virtqueue_reset(rq->vq, virtnet_rq_unmap_free_buf, &flush=
ed);
>         if (err) {
>                 netdev_err(vi->dev, "reset rx fail: rx queue index: %d er=
r: %d\n", qindex, err);
>
> @@ -5737,12 +5738,13 @@ static int virtnet_sq_bind_xsk_pool(struct virtne=
t_info *vi,
>                                     struct xsk_buff_pool *pool)
>  {
>         int err, qindex;
> +       bool flushed;
>
>         qindex =3D sq - vi->sq;
>
>         virtnet_tx_pause(vi, sq);
>
> -       err =3D virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf);
> +       err =3D virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf, &flus=
hed);
>         if (err) {
>                 netdev_err(vi->dev, "reset tx fail: tx queue index: %d er=
r: %d\n", qindex, err);
>                 pool =3D NULL;
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 34a068d401ec..b522ef798946 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2828,6 +2828,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
>   * virtqueue_reset - detach and recycle all unused buffers
>   * @_vq: the struct virtqueue we're talking about.
>   * @recycle: callback to recycle unused buffers
> + * @flushed: whether or not unused buffers are all flushed
>   *
>   * Caller must ensure we don't call this with other virtqueue operations
>   * at the same time (except where noted).
> @@ -2839,14 +2840,17 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
>   * -EPERM: Operation not permitted
>   */
>  int virtqueue_reset(struct virtqueue *_vq,
> -                   void (*recycle)(struct virtqueue *vq, void *buf))
> +                   void (*recycle)(struct virtqueue *vq, void *buf),
> +                   bool *flushed)
>  {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
>         int err;
>
> +       *flushed =3D false;
>         err =3D virtqueue_disable_and_recycle(_vq, recycle);
>         if (err)
>                 return err;
> +       *flushed =3D true;
>

This makes me think if it would be easier if we just find a way to
reset the tx queue inside virtqueue_disable_and_recycle().

For example, introducing a recycle_done callback?

Thanks


