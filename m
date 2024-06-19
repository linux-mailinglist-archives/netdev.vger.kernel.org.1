Return-Path: <netdev+bounces-104941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCEF90F3CC
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 18:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C071B20E90
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 16:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADD615099B;
	Wed, 19 Jun 2024 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X4jif4Es"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D006485626
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 16:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718813726; cv=none; b=VszHB2jjZMMpL0CP8DfFcs77kQzui2n83M1p3Ha4AxuaCfJs78nGQpuPP1zhiFe2iAMCKtElLD/vqGi0L1brd9I4FxZw+UUlwcpR+PVW8JvAyREx/O5PVRYTGNOySYlvGdKNhL175eVJQgkChmqdjO4MqodYREcxSps4ME7KsIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718813726; c=relaxed/simple;
	bh=ss0Uh9EdjlVVVTaBDNia4yMe/Wcg/oAnvkrDgWyx1Pc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PMeudvfgsU7F+aTyEL9Mt2ZEreUTcTjIKeppnytsNSDxBGVzfXHvingcMqRb7g+xePNJvb9wAdOiA/p/CQUFy3BC+wUr9LIarCsX2Kk55v++96z37z7unW47OFhrp+dQ1Ts23Pa8ExytBwuYClQ+PxC087e93ZFYRkoDmdCzzWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X4jif4Es; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718813723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K6uw6c8xTJWi+pvcU2aMToH9/dEBpeu9C2fVbRq6KEk=;
	b=X4jif4EsFrI9TOIDvNM78NhPXTUq0SCJjpjeWnqEB55B0zC3rBIzfEVbCV2sllD0zvIxHS
	GMYasazdOMOMJ+sHtg9z8pTuAolZPEuyHX1nvJVl8+oBdyrAryByuXul20gY8NJcDy9HYz
	E142ujF3iVKmrj4st8wp56m5MeN7fmQ=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-_zwJVGuaNFuZzBMjV4FvoA-1; Wed, 19 Jun 2024 12:15:22 -0400
X-MC-Unique: _zwJVGuaNFuZzBMjV4FvoA-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-6311e0f4db4so125448217b3.3
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 09:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718813722; x=1719418522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6uw6c8xTJWi+pvcU2aMToH9/dEBpeu9C2fVbRq6KEk=;
        b=vzIXptlY/RaZ7ATdJCfS+x9AevXHsRIlq8IoOUSLkrrrB/X3G4wvQ1U0DRbtM5rPoG
         Ms0XD+GZ2cTy9ap9vbC84s5sMmDk8FUsZgxXuAEUfnEx/SmKgwk2+eJkqDnUOLG/iDR4
         aNZZRUia/Y6+WqSSyDe217TN2RX4D9kizAqLNSotVLFuggLSdCrF7xveVrQQVzsyKU8F
         4sd/uzOLrrA0x1oeHyJxxGVFBKco7MShmtG5B3m0kmnwfJoAWi/ooSDNnmIMCk4y54YQ
         GcdPAEiCF7mOf4D8WFP1FzaScSUaijwomUrSc4LU2pO0P0ysBuYOUNmUf5novm1Fqasp
         O66w==
X-Forwarded-Encrypted: i=1; AJvYcCXLVsbUoZJAcjVt02/52FIS3tJQD1sQfgZ+PMMAvrCYeHAgG0H+0pZgdPPn7ZvNBzIIVvzUDHfQAtDKplzCeIQ66LFuDieN
X-Gm-Message-State: AOJu0YwHoUKn1gn6smSVvL28dS7CHCpTFV/rWhEYFE6/gjXo3iYIPc/6
	lYQKWsC/Lm9dUfD5C14crnsoUGMiO4zxqpiNjXAoLODjObyIz72E50j18TJYiwlvHRfvfSml4oG
	C3nOc4koWGr66uowhL1StSIoLlSWXcfq0J5bmalm13jkRFiPLCx98/OjNhr7fEt7SV+JuKT1jys
	jNa6zlXKag0zPaos8MozvMcXFtwlnFcxdePvRg3CM=
X-Received: by 2002:a81:9e04:0:b0:62f:3278:a635 with SMTP id 00721157ae682-63a8db11467mr30440507b3.20.1718813721754;
        Wed, 19 Jun 2024 09:15:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYj9yHFJVb+3h0QXR7hz1TBdvtwdMW2hViXwyFTLlI/REfheh7B4/sRoIX5a0uxH+gXSI/PDw6ksDPNWWW1Ps=
X-Received: by 2002:a81:9e04:0:b0:62f:3278:a635 with SMTP id
 00721157ae682-63a8db11467mr30440377b3.20.1718813721450; Wed, 19 Jun 2024
 09:15:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com> <20240617-stage-vdpa-vq-precreate-v1-22-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-22-8c0483f0ca2a@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Jun 2024 18:14:45 +0200
Message-ID: <CAJaqyWezppMAL85-w7QLmEnKrebjdg9BQORApCj2ZHqWtiDptw@mail.gmail.com>
Subject: Re: [PATCH vhost 22/23] vdpa/mlx5: Don't reset VQs more than necessary
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	Cosmin Ratiu <cratiu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 5:09=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> The vdpa device can be reset many times in sequence without any
> significant state changes in between. Previously this was not a problem:
> VQs were torn down only on first reset. But after VQ pre-creation was
> introduced, each reset will delete and re-create the hardware VQs and
> their associated resources.
>
> To solve this problem, avoid resetting hardware VQs if the VQs are still
> in a blank state.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index d80d6b47da61..1a5ee0d2b47f 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3134,18 +3134,41 @@ static void init_group_to_asid_map(struct mlx5_vd=
pa_dev *mvdev)
>                 mvdev->group2asid[i] =3D 0;
>  }
>
> +static bool needs_vqs_reset(const struct mlx5_vdpa_dev *mvdev)
> +{
> +       struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
> +       struct mlx5_vdpa_virtqueue *mvq =3D &ndev->vqs[0];
> +
> +       if (mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK)
> +               return true;
> +
> +       if (mvq->fw_state !=3D MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT)
> +               return true;
> +
> +       return mvq->modified_fields & (
> +               MLX5_VIRTQ_MODIFY_MASK_STATE |
> +               MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_ADDRS |
> +               MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_AVAIL_IDX |
> +               MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_USED_IDX
> +       );
> +}
> +
>  static int mlx5_vdpa_compat_reset(struct vdpa_device *vdev, u32 flags)
>  {
>         struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
>         struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
> +       bool vq_reset;
>
>         print_status(mvdev, 0, true);
>         mlx5_vdpa_info(mvdev, "performing device reset\n");
>
>         down_write(&ndev->reslock);
>         unregister_link_notifier(ndev);
> -       teardown_vq_resources(ndev);
> -       init_mvqs(ndev);
> +       vq_reset =3D needs_vqs_reset(mvdev);
> +       if (vq_reset) {
> +               teardown_vq_resources(ndev);
> +               init_mvqs(ndev);
> +       }
>
>         if (flags & VDPA_RESET_F_CLEAN_MAP)
>                 mlx5_vdpa_destroy_mr_resources(&ndev->mvdev);
> @@ -3165,7 +3188,8 @@ static int mlx5_vdpa_compat_reset(struct vdpa_devic=
e *vdev, u32 flags)
>                 if (mlx5_vdpa_create_dma_mr(mvdev))
>                         mlx5_vdpa_warn(mvdev, "create MR failed\n");
>         }
> -       setup_vq_resources(ndev, false);
> +       if (vq_reset)
> +               setup_vq_resources(ndev, false);
>         up_write(&ndev->reslock);
>
>         return 0;
>
> --
> 2.45.1
>


