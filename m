Return-Path: <netdev+bounces-108961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 019CD92660A
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 18:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 330FF1C22823
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 16:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E62183090;
	Wed,  3 Jul 2024 16:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ezuJzVc8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D6D183086
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 16:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720023704; cv=none; b=sIU+fD+J7vip2AB7O3TvTvVm48GnChqy8trSiZ36ZyAC0neMXeLSkMQlTEho8dEYh5Vo+rpMSlImLKYo4kxRgy6NTCxK3ifu5Aqtwgre1xi5pJPDDYri8AqpxpWkx8Ei3rUyuDg25CHPyX44/WiZmJXaqPw/kyk3/cs4vjP5gic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720023704; c=relaxed/simple;
	bh=TcS0Nab4P1uInJHhXVtq4QA+KS6M5rJkuPOwVobX3GA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jdfvIZ/Vyb5c0hC/3FDna0dBtbiEZodKxgej2BbZBVGaX3E776OLANEAi22cfRfjgYZT4JnU8e4vYjP7WXU0lSLEeB3WIiNfDPUdspiFqlFSHchsXv80/t1cg+bmSDvSANLTwaMx63vMAH/OW1KPAhc6bvsJYm8BmVxXS50tvBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ezuJzVc8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720023701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RvzgALGPKTw1bigvFfaZyijkP2+PzdDyQ0IADPOqqJg=;
	b=ezuJzVc8UOPBaQWGQJaWDHmAWZgzKLjDmsxIlmSrRUatxAW8fPSsDgPJT8HRB2Q0YSYdwG
	Mz4qHLp8hzX3BCl5OoNZ14KoxwK4r/HAy9XhCCGUZxKiaYK8RR8WUTFA0hwkzxiOyU+J8S
	9P2zqVp8RSFyY6qva5owpxXge+LfwGY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-6catDzhdNVOtJ_4UGmDxIw-1; Wed, 03 Jul 2024 12:21:40 -0400
X-MC-Unique: 6catDzhdNVOtJ_4UGmDxIw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-58c859c5d96so830677a12.3
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 09:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720023699; x=1720628499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvzgALGPKTw1bigvFfaZyijkP2+PzdDyQ0IADPOqqJg=;
        b=Qqpq7OiUsCnh+Lw2pMYY/LK73LcgQOur7cLbdeeJiRuoWtEPJUzsVWQKfAA/QzWPiI
         o8b5V4aG+Vq83QjR7ScfDUuAVauTufzBMqgULtWTyh2mF9yImaK84qE4Zarfb1cKzEgO
         t/V5KHnmYYT+3yMt63ad2fI6kpfJJ+h+zirmpMN8fRoN9IlUDaSG1zWAwC5VRlTIqAVr
         NDp32PCC2Fi8rhU6eB2uBoJGFF18H19BejtX2PDMMOIf6CeVd2FL10KDXwhPVvf+jp9l
         h6GYJU2j1ZnvNkTIcwnUFAlyYIz2vzQB4EEVLYC28gA6U1fvJUH/jtzATCig7up1mG6V
         Xzlw==
X-Forwarded-Encrypted: i=1; AJvYcCUQwos1b1BPqld79com1nCt8kcRI31JfgB+ooK3OjZIccWKdLKrqJtgGeqSqggFQQrbcB7sPIsDWNA3SAx6wdByhNUEAdNp
X-Gm-Message-State: AOJu0YxLXmWn53NXVmc8R9aSlPaM0425SOm69V2xjrk28nbdMaE2ymKu
	feAW0GorfkoE+izjI7mDVqSvcDpQjfeHsbfi1XCXZ9VoOYwb6ipwm1snB81HHp5VzZhSsBNiQpJ
	yZIlqL67YuCqHdYhhQF9Z04oIa5clk6sy8jPEK2xQ4+zsKwpLb6RJcwL/62Rb1gKOcuBvoiErTr
	SiSWDXhxPs7ZIRsYgOl3GgdEy3hMD1
X-Received: by 2002:a05:6402:2113:b0:57a:2ccb:b3f2 with SMTP id 4fb4d7f45d1cf-5879f59bc0dmr8314475a12.16.1720023699465;
        Wed, 03 Jul 2024 09:21:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLrQmfzqoCkSKEjGQCytFKKt1qFveCCZLiKDvdyFB5I6punigduS2DoMmXGBJNBjrgv6P7Ec5gPWUP4aOKX74=
X-Received: by 2002:a05:6402:2113:b0:57a:2ccb:b3f2 with SMTP id
 4fb4d7f45d1cf-5879f59bc0dmr8314456a12.16.1720023699020; Wed, 03 Jul 2024
 09:21:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626-stage-vdpa-vq-precreate-v2-0-560c491078df@nvidia.com> <20240626-stage-vdpa-vq-precreate-v2-16-560c491078df@nvidia.com>
In-Reply-To: <20240626-stage-vdpa-vq-precreate-v2-16-560c491078df@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 3 Jul 2024 18:21:01 +0200
Message-ID: <CAJaqyWdK4u0Y2EbgyWsYupLvybuBK=waf_qhUqne2q9wHvuEqA@mail.gmail.com>
Subject: Re: [PATCH vhost v2 16/24] vdpa/mlx5: Accept Init -> Ready VQ
 transition in resume_vq()
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	Cosmin Ratiu <cratiu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 12:28=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
> Until now resume_vq() was used only for the suspend/resume scenario.
> This change also allows calling resume_vq() to bring it from Init to
> Ready state (VQ initialization).
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 0a62ce0b4af8..adcc4d63cf83 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1557,11 +1557,31 @@ static void suspend_vqs(struct mlx5_vdpa_net *nde=
v)
>
>  static void resume_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtq=
ueue *mvq)
>  {
> -       if (!mvq->initialized || !is_resumable(ndev))
> +       if (!mvq->initialized)
>                 return;
>
> -       if (mvq->fw_state !=3D MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND)
> +       switch (mvq->fw_state) {
> +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT:
> +               /* Due to a FW quirk we need to modify the VQ fields firs=
t then change state.
> +                * This should be fixed soon. After that, a single comman=
d can be used.
> +                */
> +               if (modify_virtqueue(ndev, mvq, 0))
> +                       mlx5_vdpa_warn(&ndev->mvdev,
> +                               "modify vq properties failed for vq %u\n"=
, mvq->index);
> +               break;
> +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND:
> +               if (!is_resumable(ndev)) {
> +                       mlx5_vdpa_warn(&ndev->mvdev, "vq %d is not resuma=
ble\n", mvq->index);
> +                       return;
> +               }
> +               break;
> +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY:
>                 return;
> +       default:
> +               mlx5_vdpa_warn(&ndev->mvdev, "resume vq %u called from ba=
d state %d\n",
> +                              mvq->index, mvq->fw_state);
> +               return;
> +       }
>
>         if (modify_virtqueue_state(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_ST=
ATE_RDY))
>                 mlx5_vdpa_warn(&ndev->mvdev, "modify to resume failed for=
 vq %u\n", mvq->index);
>
> --
> 2.45.1
>


