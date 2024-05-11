Return-Path: <netdev+bounces-95673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C25D8C2F65
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 05:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 062D81C2130F
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 03:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FF636122;
	Sat, 11 May 2024 03:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUQ9pTE8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E31B21A04
	for <netdev@vger.kernel.org>; Sat, 11 May 2024 03:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715398738; cv=none; b=d5adS8NQHWEsf3fRJfLANUHnagQZ3QDvBYKvqcKMoG2bNXqd9IVhcfl+GOy1fiV3/KgRKFxsRUjGz7rh3yMzgz7p1Yxybt0zhkh7fbM0NL+8r2MXW7tmJSpYdqmeBzNBQGc63r6EP+RGCHpALfbm8cBAnXDbOhG/tY3pgTvnP64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715398738; c=relaxed/simple;
	bh=rYUj3aHDAjTWCO3zmRdQgFYArGOHZewr+0dPdqdJQMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/6GoxzzDJ7uLlf28Yq7qzYrNIu7rJAau99bxCuCY75qNZJimH7HCZKBWqb0nSjr+tNC1fT5WfplxYa1EVQkvsWRwY7wcUcz9RnLAQH4oVleRLRRa7o0oia0UGKcESihCRAWSVm9D80ZoJHkBFfD+CK4fYXp6I3ylIPKSQXymAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUQ9pTE8; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-522297f91easo931418e87.2
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 20:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715398735; x=1716003535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMwJyrS69aBB/AIHg+ejA8vPPkzSH95eVzoKFAGJIhI=;
        b=AUQ9pTE8z5QejTPaZ4WnXTXKTd58K97YnNqxXARb/2/8NU5rzfWSZKaUykw6P3t8X4
         x4TRvbDdgDf6I3IUMDLrDyXOGeIpB5dtnhTsBfOnCLvQaULls86kO/tJnFjYeiURlVAg
         hw++DyTYkvjTQH5YXk0lNGzqgu9ZCQxbmHatrT4oCL05bVJKUQ07tIl8VsOucUtTA8mi
         A1tB/YhFiWawSNUz4ivCVj3IMOvIKF7llKHU17aIC3boYyBJ+igaDN/1oucFuhHGeB7Q
         Y6DQIq9KMZW4vPU0zEtkPSPy/2PWqgjqSvsO5NJ7TQ4ugcrwAy453RvqiG1Zi9UGLPih
         TYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715398735; x=1716003535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMwJyrS69aBB/AIHg+ejA8vPPkzSH95eVzoKFAGJIhI=;
        b=j14Ln98RUlZfeLBa08/IG/B2xk6+1MV1GvVXXxq1K7x4XeKvaKtQVDWahxw9rE4AnG
         Fm33FupfcwXtTzAJkDiuTKTt0FWVbXsSbyJfAMmPcdOA30xBb1KcMZTByTsNzGPp2cOE
         NrPaN4v4k/OPcEMg1rJFo0Z/3OQ9dwM6aVGXUk1fNYfAXnWsc/q+OOJ/+HAD/mfFtTF7
         A1DbPMlRq9UEsm4Ojnsu2Vny8ClVO80AJ0OyEbMcdTPsHmpaPvS+FMAYwajra8LApJCi
         dD8dMGEwhmU54lRisXHnwie6AjP6vlJab+b6H9/8E8X9Xz3lb1+0x0n/g+3OFwVsaPdR
         mwyA==
X-Gm-Message-State: AOJu0YxvVvPyhd9at1W7KtXmiZmgYZxU+JshI+ZvTZAK3As4Lk+9kdgI
	x9eqd6Vn86JisbRTs6hdjYr1jqOaEg48C9gYTE/M+fBJfPjYstcHvhWHJT6oc39cf5P2a4P+MGN
	XK2FhwOb/hGE8oVNfXRPHfvfozr8DIJl3dCs=
X-Google-Smtp-Source: AGHT+IHp03TXfkKPY1+1X+ydJPdmjx3TQTPhvudtPm3tFZLbWL/wLGGLmceTQC3YSFR/Tlea6G2zvZ2FfIAIx7xnuCc=
X-Received: by 2002:a05:6512:4025:b0:521:9315:670 with SMTP id
 2adb3069b0e04-5220fb774eamr3499607e87.9.1715398734995; Fri, 10 May 2024
 20:38:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510201927.1821109-1-danielj@nvidia.com> <20240510201927.1821109-3-danielj@nvidia.com>
In-Reply-To: <20240510201927.1821109-3-danielj@nvidia.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 11 May 2024 11:38:18 +0800
Message-ID: <CAL+tcoBRqEyr+4NPDiORJgM4nUzYjeHNZJLDo2K=dAJhKWvz_g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] virtio_net: Add TX stopped and wake counters
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	jiri@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2024 at 4:20=E2=80=AFAM Daniel Jurgens <danielj@nvidia.com>=
 wrote:
>
> Add a tx queue stop and wake counters, they are useful for debugging.
>
> $ ./tools/net/ynl/cli.py --spec netlink/specs/netdev.yaml \
> --dump qstats-get --json '{"scope": "queue"}'
> ...
>  {'ifindex': 13,
>   'queue-id': 0,
>   'queue-type': 'tx',
>   'tx-bytes': 14756682850,
>   'tx-packets': 226465,
>   'tx-stop': 113208,
>   'tx-wake': 113208},
>  {'ifindex': 13,
>   'queue-id': 1,
>   'queue-type': 'tx',
>   'tx-bytes': 18167675008,
>   'tx-packets': 278660,
>   'tx-stop': 8632,
>   'tx-wake': 8632}]
>
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks!

> ---
>  drivers/net/virtio_net.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 218a446c4c27..df6121c38a1b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -95,6 +95,8 @@ struct virtnet_sq_stats {
>         u64_stats_t xdp_tx_drops;
>         u64_stats_t kicks;
>         u64_stats_t tx_timeouts;
> +       u64_stats_t stop;
> +       u64_stats_t wake;
>  };
>
>  struct virtnet_rq_stats {
> @@ -145,6 +147,8 @@ static const struct virtnet_stat_desc virtnet_rq_stat=
s_desc[] =3D {
>  static const struct virtnet_stat_desc virtnet_sq_stats_desc_qstat[] =3D =
{
>         VIRTNET_SQ_STAT_QSTAT("packets", packets),
>         VIRTNET_SQ_STAT_QSTAT("bytes",   bytes),
> +       VIRTNET_SQ_STAT_QSTAT("stop",    stop),
> +       VIRTNET_SQ_STAT_QSTAT("wake",    wake),
>  };
>
>  static const struct virtnet_stat_desc virtnet_rq_stats_desc_qstat[] =3D =
{
> @@ -1014,6 +1018,9 @@ static void check_sq_full_and_disable(struct virtne=
t_info *vi,
>          */
>         if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
>                 netif_stop_subqueue(dev, qnum);
> +               u64_stats_update_begin(&sq->stats.syncp);
> +               u64_stats_inc(&sq->stats.stop);
> +               u64_stats_update_end(&sq->stats.syncp);
>                 if (use_napi) {
>                         if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)=
))
>                                 virtqueue_napi_schedule(&sq->napi, sq->vq=
);
> @@ -1022,6 +1029,9 @@ static void check_sq_full_and_disable(struct virtne=
t_info *vi,
>                         free_old_xmit(sq, false);
>                         if (sq->vq->num_free >=3D 2+MAX_SKB_FRAGS) {
>                                 netif_start_subqueue(dev, qnum);
> +                               u64_stats_update_begin(&sq->stats.syncp);
> +                               u64_stats_inc(&sq->stats.wake);
> +                               u64_stats_update_end(&sq->stats.syncp);
>                                 virtqueue_disable_cb(sq->vq);
>                         }
>                 }
> @@ -2322,8 +2332,14 @@ static void virtnet_poll_cleantx(struct receive_qu=
eue *rq)
>                         free_old_xmit(sq, true);
>                 } while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>
> -               if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS)
> +               if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS) {
> +                       if (netif_tx_queue_stopped(txq)) {
> +                               u64_stats_update_begin(&sq->stats.syncp);
> +                               u64_stats_inc(&sq->stats.wake);
> +                               u64_stats_update_end(&sq->stats.syncp);
> +                       }
>                         netif_tx_wake_queue(txq);
> +               }
>
>                 __netif_tx_unlock(txq);
>         }
> @@ -2473,8 +2489,14 @@ static int virtnet_poll_tx(struct napi_struct *nap=
i, int budget)
>         virtqueue_disable_cb(sq->vq);
>         free_old_xmit(sq, true);
>
> -       if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS)
> +       if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS) {
> +               if (netif_tx_queue_stopped(txq)) {
> +                       u64_stats_update_begin(&sq->stats.syncp);
> +                       u64_stats_inc(&sq->stats.wake);
> +                       u64_stats_update_end(&sq->stats.syncp);
> +               }
>                 netif_tx_wake_queue(txq);
> +       }
>
>         opaque =3D virtqueue_enable_cb_prepare(sq->vq);
>
> @@ -4790,6 +4812,8 @@ static void virtnet_get_base_stats(struct net_devic=
e *dev,
>
>         tx->bytes =3D 0;
>         tx->packets =3D 0;
> +       tx->stop =3D 0;
> +       tx->wake =3D 0;
>
>         if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_TX_BASIC) {
>                 tx->hw_drops =3D 0;
> --
> 2.45.0
>
>

