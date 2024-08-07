Return-Path: <netdev+bounces-116469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE44194A88A
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 15:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEBFFB21333
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 13:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC04F1E7A58;
	Wed,  7 Aug 2024 13:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RiUJgS+V"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C591E7A41
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 13:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723037173; cv=none; b=KDy10Ztsbe+h+RlKGF5lcVd/vobW3xMcc0u6Tjl0k/kcZpwoz90JHo9L15crBLIBckU8yFFy2AOQIkvp9PmT3HxPoSrFLZajqbaHDT8hTtTOJyeTMqgJ7jF5sVMzxYLso2nZzTGAMkGtuQQNI+amhyTBvHgSY3CRBA5NOKY2Ugs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723037173; c=relaxed/simple;
	bh=i08Eu++Bs5ZfYyhmfDLsgMllWxZSyJTGvRtL9wXdWUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sobhAA5Bb3NFF1LD7osm29kjJSmGqwEoHVpBiUw10mL0S6zUJhYFMvfW1sRc94gW1q/TXfx0ML96iDig53DwAOxUZb5oYVPIjy9MWY4XHYoYXb4EWX4EUNw0y/5f0/S1rSEOcdWh+Q1QLmyt2wXk8LMPTlmMuYZa+Ppzdka5J7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RiUJgS+V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723037171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vloTJ8N6rDB2OVVpi1DvU3M2IhFk9AAWb0s6CTF2pM4=;
	b=RiUJgS+V110N8AzYYg1+YiVdm1rpRTrlMhqTdFEEWUldRezZP8TMfhvfGMkOdfWRZvhQ7l
	2m7c7Nx7kPkQlvHRc5FeZDWHGS7taIpT2SCBWmGXdxwk19Qa1bgfcaKDCr2ijicAzAz/WC
	nIHLM0MZb0Tjsf8EfCoqhP0UBqb88+0=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-cKIN2dZtOyCizNd2hzqLwg-1; Wed, 07 Aug 2024 09:26:10 -0400
X-MC-Unique: cKIN2dZtOyCizNd2hzqLwg-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-690404fd34eso37313287b3.1
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 06:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723037168; x=1723641968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vloTJ8N6rDB2OVVpi1DvU3M2IhFk9AAWb0s6CTF2pM4=;
        b=HEN0thiBtAtlr2Kyrj6ATXDV0o1ng1b8sw3jDAfFyXH3ik1wEiSlpgNAmLAdtjEr4t
         3YFwVDeLvX7W0K1mo90H7CHPdheR0JoaoDiCtZD9gJbnjujCcQ/VHR76dB8c4d5nq6Yr
         2v7DG45LKtlHnMHtxZb6RmiWemiXE0cgx4dihq/FA5xYP+jxUfYj/swnmj1hBYqftsaP
         xQtxE5Od7GrgcoiovMLKSWawidlJXkRt0ONFmqvUBvSFDyeoy0217LNFfK7bgisC5KuF
         FmM3Idmci8nS6ixHcR90l0JIwM0QubSk8CYJGyvECp+D22/Yh0WwXVFyZDXAQq5muoL1
         QexA==
X-Forwarded-Encrypted: i=1; AJvYcCXUWvhea5BhJpCirbMwpjrvBlIcCKHW7uEJR3LSc/Yrb20AuvHXqO6MS4EcY6JrHLkaX8VBlHo2ZE2qy+eWcYz7mUmaYit4
X-Gm-Message-State: AOJu0YwJiUPkMtG9NMRseZFKJPOJp2u1xmp3PVzDvBOEIWlo72wBKiZv
	eddS4DjJSw6FrpQrhT7T2OgQjbm8pheP+lvV0OTTTjSi57ErA0VmGyMz4OYmacs2SSF5pj4I3kt
	34w4MMJyD8uC3IkFIzzBcqpgxLCoZ2RrIXAm2Des/Esczlc7nYOGtt1iTm9WAonvtMvtu8FVplJ
	pHj/p8kaoBOJDqQCqdzUdRZr/HVAWf
X-Received: by 2002:a81:8887:0:b0:63b:b3b8:e834 with SMTP id 00721157ae682-68963423819mr222073827b3.32.1723037168336;
        Wed, 07 Aug 2024 06:26:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlaQzWaMhaOL8yyUTkscgvdFCW3vr0eHO4IPz4j2TIsmeWnld07fIgPnkUYUvyGyLGq+dpPFUOtl3iXD2ZKEw=
X-Received: by 2002:a81:8887:0:b0:63b:b3b8:e834 with SMTP id
 00721157ae682-68963423819mr222073587b3.32.1723037168001; Wed, 07 Aug 2024
 06:26:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802072039.267446-1-dtatulea@nvidia.com>
In-Reply-To: <20240802072039.267446-1-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 7 Aug 2024 15:25:32 +0200
Message-ID: <CAJaqyWdGNfJ3n-E2-PvkuvCiOMsLkEzYaUi5wi-C_n84-a_LAw@mail.gmail.com>
Subject: Re: [PATCH vhost 0/7] vdpa/mlx5: Parallelize device suspend/resume
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 9:24=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
> This series parallelizes the mlx5_vdpa device suspend and resume
> operations through the firmware async API. The purpose is to reduce live
> migration downtime.
>
> The series starts with changing the VQ suspend and resume commands
> to the async API. After that, the switch is made to issue multiple
> commands of the same type in parallel.
>

There is a missed opportunity processing the CVQ MQ command here,
isn't it? It can be applied on top in another series for sure.

> Finally, a bonus improvement is thrown in: keep the notifierd enabled
> during suspend but make it a NOP. Upon resume make sure that the link
> state is forwarded. This shaves around 30ms per device constant time.
>
> For 1 vDPA device x 32 VQs (16 VQPs), on a large VM (256 GB RAM, 32 CPUs
> x 2 threads per core), the improvements are:
>
> +-------------------+--------+--------+-----------+
> | operation         | Before | After  | Reduction |
> |-------------------+--------+--------+-----------|
> | mlx5_vdpa_suspend | 37 ms  | 2.5 ms |     14x   |
> | mlx5_vdpa_resume  | 16 ms  | 5 ms   |      3x   |
> +-------------------+--------+--------+-----------+
>

Looks great :).

Apart from the nitpick,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

For the vhost part.

Thanks!

> Note for the maintainers:
> The first patch contains changes for mlx5_core. This must be applied
> into the mlx5-vhost tree [0] first. Once this patch is applied on
> mlx5-vhost, the change has to be pulled from mlx5-vdpa into the vhost
> tree and only then the remaining patches can be applied.
>
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/lo=
g/?h=3Dmlx5-vhost
>
> Dragos Tatulea (7):
>   net/mlx5: Support throttled commands from async API
>   vdpa/mlx5: Introduce error logging function
>   vdpa/mlx5: Use async API for vq query command
>   vdpa/mlx5: Use async API for vq modify commands
>   vdpa/mlx5: Parallelize device suspend
>   vdpa/mlx5: Parallelize device resume
>   vdpa/mlx5: Keep notifiers during suspend but ignore
>
>  drivers/net/ethernet/mellanox/mlx5/core/cmd.c |  21 +-
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h            |   7 +
>  drivers/vdpa/mlx5/net/mlx5_vnet.c             | 435 +++++++++++++-----
>  3 files changed, 333 insertions(+), 130 deletions(-)
>
> --
> 2.45.2
>


