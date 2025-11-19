Return-Path: <netdev+bounces-239804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F07C6C7BB
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 03:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 0A5E42CC7B
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 02:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220532D641D;
	Wed, 19 Nov 2025 02:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dsz7qVHw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZXBYrMFC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FA321D3CC
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 02:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763520995; cv=none; b=KQPj58uuNHP4E4dQ2/AlgLlVXB2tZLc0VbvkhUnx224lLGAp1VldnpcG9HKA7q7PlZrtzw8iCMoW0P1SmHr1UmJvVCeUI0crF8gPVx22rl9rQQ3sEeigCrCRxx4uVu1YK8UXZMeuhTUXOs3IxfKI28tuM5R4hY7Tk6q9F8laC8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763520995; c=relaxed/simple;
	bh=G12hxObS9vVdQSHOVQsEwJdya84pJfSeHUQ2pXezb/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qbbqOS8BGVMntwQJnMRQDlZnbHkuHzQxc3qxEhgdUHRYJXuqcsNfct1sLgTtS9lhoU6mMwEHp0nBVJJowmmtDOCt3NM1regmJ1UPH8llY9i0WaJBtm+mog/I8ZZIqN4FJf4vgRc2YBnuUtcVQVi36tmCKzxb/vH+nX75Za/i3L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dsz7qVHw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZXBYrMFC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763520992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jDvPTx8od/LRicGRV59Ci5CqBppmh/yq9CH+cOE9Xiw=;
	b=dsz7qVHw9C3W8GO2xcE9wkLwabbmpZ9EAmM9paEYPbRJGY3y0JwEks/PAkp8pz4ECp+k/P
	o96fGsYaICUgkDQqXcU7H5DM+8WUII/aCA7OV+CWcAOeK4GIh+bVHFOErXOP+pUTlldWg0
	Y2DHuqjR4CfS6/cqWyPmXhZ+q0z7BZc=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-hFDNNWWbM0-BonHUINV9qA-1; Tue, 18 Nov 2025 21:56:30 -0500
X-MC-Unique: hFDNNWWbM0-BonHUINV9qA-1
X-Mimecast-MFC-AGG-ID: hFDNNWWbM0-BonHUINV9qA_1763520990
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-5dfb4950a48so15363554137.0
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 18:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763520990; x=1764125790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDvPTx8od/LRicGRV59Ci5CqBppmh/yq9CH+cOE9Xiw=;
        b=ZXBYrMFC4R3upu86JqxrnKc8pUwc541fOUIcr2lW83OWb7MyiGlakRT3DQh/NNaklx
         DuI0W82eWlyIfqQgWwvw3aZX99ngVnxCH4UEU4Om8/bCaIEO0sZhrL2fsSRXOMXvVRBO
         X3Z4uIZXaKSeiduiMyfySKcmUQILVfqnXW0vePUqWdvjUv9JDXuRM1iZJKRPUEXGif8E
         1dGc16Bs3uXdqAsvoaJdlFquFjQdEQVB/zz+QvWFbS/Obb4vmUotnaF24u/v9fqxQa0J
         7ma96TyOM2OnZynw7Trsld6H4EpG/uZWGcGkaWVMK2PcFdXm2X2O4knA933oiINc05nV
         qoVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763520990; x=1764125790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jDvPTx8od/LRicGRV59Ci5CqBppmh/yq9CH+cOE9Xiw=;
        b=V6rq+nOuLpK0K7hdbM/BmZbTBDmr0jCv7xeyLWgcTkONLkA2LJgwyBBI0AFQWwjK3u
         BcO/gdsst4m95OrWXe9qjzVZa7b0CmN1/4Z92LmSmsbm1M7KNGwVvE9G1xZw7Jesv9Dy
         xh5IU8ydhVWk4ehKi2UosBk2xFAmWA+L1idB++N2wEWjDfBB5KLdMRYunf9ihl8rH5hz
         /buy2ChOUzb7HYRKLGqdgC+abAwYYoghhAYltwOeO1rvh2NAo1713I6dUUz+xVu+xkC3
         IhaJtXfq6kslwR9kTBk057ITy1h/46AeUGGrjqRSzUVoLNnXvOXVaWAMiMlx2M+F+eZa
         /Hxw==
X-Forwarded-Encrypted: i=1; AJvYcCW4IvhePM4BgN7tQR+VPvVMk7Kgl8njgg+fQs7QckoCmhk2RY7CUin4n0vZzpy0JDFyY9rQ2Hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMLav/vD3U3z9l0GJksQLSyQvFxm8gnEqLiqpKGQ5z4b+lWhXW
	GjbSweg4al6un7n+9S/3vD3Ah62bcJztTpV0XYux9aqgE4OeDFMZN91KsfY7eYIyq3IrpwsSHey
	e5DwA1zzpHnE5SApgpFRZ8VOnQTlpl/6rxKY7uTKldRuOhDcuo6GuT8C8E2D+13v60pxrwxFKYA
	LlFLu4EzglPJDhRGurFyt7GhXZIT9GMYPj
X-Gm-Gg: ASbGnct7MrpeVSm0B4x5wXC2pLz6XUPivXGVkRl4mS/jQVBRiWL38MghPyhHMyBcdlS
	S0PLUNDRCM2qKH9HT2Xf7ngNoRW5ckxJ1UyZwEpYFzyRkkKfGEWTcTzZFnMcCpMQvb7VCQggtes
	9wMC8Ld/tjTRbdLwTmpw0SGuLE5As443iM7YGHV/9bbQC+zuFmkCadVFr/TdP2FP4=
X-Received: by 2002:a05:6102:e0a:b0:5db:ef3f:6c7d with SMTP id ada2fe7eead31-5dfc5556bf8mr6112206137.14.1763520990174;
        Tue, 18 Nov 2025 18:56:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMHvc8TbnsY8T2F+eiw7C0cSgj9lMpJACXTR8AzjwZ2GrCglhiRk/Pmo0QAEu0HhMJS9z+SDjksvQGpkSmyfk=
X-Received: by 2002:a05:6102:e0a:b0:5db:ef3f:6c7d with SMTP id
 ada2fe7eead31-5dfc5556bf8mr6112195137.14.1763520989781; Tue, 18 Nov 2025
 18:56:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118090942.1369-1-liming.wu@jaguarmicro.com>
In-Reply-To: <20251118090942.1369-1-liming.wu@jaguarmicro.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 19 Nov 2025 10:56:17 +0800
X-Gm-Features: AWmQ_bmKFv4JLlor4jL7WLrkrIdgod9abx7FeAA8sB4t9HbQcF1R97xzgCvVagE
Message-ID: <CACGkMEvwedzRrMd9hYm7PbDezBu1GM3q-YcUhsvfYJVv=bNSdw@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: enhance wake/stop tx queue statistics accounting
To: liming.wu@jaguarmicro.com
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, angus.chen@jaguarmicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 5:10=E2=80=AFPM <liming.wu@jaguarmicro.com> wrote:
>
> From: Liming Wu <liming.wu@jaguarmicro.com>
>
> This patch refines and strengthens the statistics collection of TX queue
> wake/stop events introduced by a previous patch.

It would be better to add commit id here.

>
> Previously, the driver only recorded partial wake/stop statistics
> for TX queues. Some wake events triggered by 'skb_xmit_done()' or resume
> operations were not counted, which made the per-queue metrics incomplete.
>
> Signed-off-by: Liming Wu <liming.wu@jaguarmicro.com>
> ---
>  drivers/net/virtio_net.c | 49 ++++++++++++++++++++++------------------
>  1 file changed, 27 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8e8a179aaa49..f92a90dde2b3 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -775,10 +775,26 @@ static bool virtqueue_napi_complete(struct napi_str=
uct *napi,
>         return false;
>  }
>
> +static void virtnet_tx_wake_queue(struct virtnet_info *vi,
> +                               struct send_queue *sq)
> +{
> +       unsigned int index =3D vq2txq(sq->vq);
> +       struct netdev_queue *txq =3D netdev_get_tx_queue(vi->dev, index);
> +
> +       if (netif_tx_queue_stopped(txq)) {
> +               u64_stats_update_begin(&sq->stats.syncp);
> +               u64_stats_inc(&sq->stats.wake);
> +               u64_stats_update_end(&sq->stats.syncp);
> +               netif_tx_wake_queue(txq);
> +       }
> +}
> +
>  static void skb_xmit_done(struct virtqueue *vq)
>  {
>         struct virtnet_info *vi =3D vq->vdev->priv;
> -       struct napi_struct *napi =3D &vi->sq[vq2txq(vq)].napi;
> +       unsigned int index =3D vq2txq(vq);
> +       struct send_queue *sq =3D &vi->sq[index];
> +       struct napi_struct *napi =3D &sq->napi;
>
>         /* Suppress further interrupts. */
>         virtqueue_disable_cb(vq);
> @@ -786,8 +802,7 @@ static void skb_xmit_done(struct virtqueue *vq)
>         if (napi->weight)
>                 virtqueue_napi_schedule(napi, vq);
>         else
> -               /* We were probably waiting for more output buffers. */
> -               netif_wake_subqueue(vi->dev, vq2txq(vq));
> +               virtnet_tx_wake_queue(vi, sq);
>  }
>
>  #define MRG_CTX_HEADER_SHIFT 22
> @@ -1166,10 +1181,7 @@ static void check_sq_full_and_disable(struct virtn=
et_info *vi,
>                         /* More just got used, free them then recheck. */
>                         free_old_xmit(sq, txq, false);
>                         if (sq->vq->num_free >=3D MAX_SKB_FRAGS + 2) {
> -                               netif_start_subqueue(dev, qnum);
> -                               u64_stats_update_begin(&sq->stats.syncp);
> -                               u64_stats_inc(&sq->stats.wake);
> -                               u64_stats_update_end(&sq->stats.syncp);
> +                               virtnet_tx_wake_queue(vi, sq);

This is suspicious, netif_tx_wake_queue() will schedule qdisc, or is
this intended?

>                                 virtqueue_disable_cb(sq->vq);
>                         }
>                 }
> @@ -3068,13 +3080,8 @@ static void virtnet_poll_cleantx(struct receive_qu=
eue *rq, int budget)
>                         free_old_xmit(sq, txq, !!budget);
>                 } while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>
> -               if (sq->vq->num_free >=3D MAX_SKB_FRAGS + 2 &&
> -                   netif_tx_queue_stopped(txq)) {
> -                       u64_stats_update_begin(&sq->stats.syncp);
> -                       u64_stats_inc(&sq->stats.wake);
> -                       u64_stats_update_end(&sq->stats.syncp);
> -                       netif_tx_wake_queue(txq);
> -               }
> +               if (sq->vq->num_free >=3D MAX_SKB_FRAGS + 2)
> +                       virtnet_tx_wake_queue(vi, sq);
>
>                 __netif_tx_unlock(txq);
>         }
> @@ -3264,13 +3271,8 @@ static int virtnet_poll_tx(struct napi_struct *nap=
i, int budget)
>         else
>                 free_old_xmit(sq, txq, !!budget);
>
> -       if (sq->vq->num_free >=3D MAX_SKB_FRAGS + 2 &&
> -           netif_tx_queue_stopped(txq)) {
> -               u64_stats_update_begin(&sq->stats.syncp);
> -               u64_stats_inc(&sq->stats.wake);
> -               u64_stats_update_end(&sq->stats.syncp);
> -               netif_tx_wake_queue(txq);
> -       }
> +       if (sq->vq->num_free >=3D MAX_SKB_FRAGS + 2)
> +               virtnet_tx_wake_queue(vi, sq);
>
>         if (xsk_done >=3D budget) {
>                 __netif_tx_unlock(txq);
> @@ -3521,6 +3523,9 @@ static void virtnet_tx_pause(struct virtnet_info *v=
i, struct send_queue *sq)
>
>         /* Prevent the upper layer from trying to send packets. */
>         netif_stop_subqueue(vi->dev, qindex);
> +       u64_stats_update_begin(&sq->stats.syncp);
> +       u64_stats_inc(&sq->stats.stop);
> +       u64_stats_update_end(&sq->stats.syncp);
>
>         __netif_tx_unlock_bh(txq);
>  }
> @@ -3537,7 +3542,7 @@ static void virtnet_tx_resume(struct virtnet_info *=
vi, struct send_queue *sq)
>
>         __netif_tx_lock_bh(txq);
>         sq->reset =3D false;
> -       netif_tx_wake_queue(txq);
> +       virtnet_tx_wake_queue(vi, sq);
>         __netif_tx_unlock_bh(txq);
>
>         if (running)
> --
> 2.34.1
>

Thanks


