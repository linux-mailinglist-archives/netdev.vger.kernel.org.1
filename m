Return-Path: <netdev+bounces-138150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68ED99AC6AA
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 11:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A46A6B24A62
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 09:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A20F19E982;
	Wed, 23 Oct 2024 09:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="r9lzyMSa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA67319DF4B
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 09:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729675976; cv=none; b=uvZKA6fcm+5ItUmWBUh5rAibnEGIfXRM/q8sagFQiKJOnSXyp9lMTsIxHOYpEHco1ohL713ASaZ7OhX9lW3Z9uxkSq2QuJmlDgc7y1vu8jiL1ZPPRCC4sPRj5X4+1UiqZ1dX7831sFgXuNFHzSodckPXpX8OJpuWNVxiJMGsygQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729675976; c=relaxed/simple;
	bh=+hiji2bfjAW8cUnmlFPD9XWkt4ENY6EEoWYgbq0mPPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UhL88ruOJ014bDEEBq/oglI4sN/jTSmTyEcBgJ7ixzYtttP7L7slY9ChwQv9O+7oRN7istDV+rNbZTrPM/8wlVwZROkLImsV5BwWAbRa4t6xFrpiva+W2tBsnC3Tqbe7e7KKBYQaiGH698nEpGfwXYRfnrL2BCBb4/1QQIJrnhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=r9lzyMSa; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1CC243F17E
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 09:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1729675968;
	bh=EjhAYSWuMWcY9+F1bfEIJ6rw0z2JaMjOgVamvmV6dkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=r9lzyMSaYTlmF/5FK7D9zsMc+OeCHkhCzavbios8Vzmd0abFfeMEBeJqsnyZfAPDx
	 bsRmc6DhgnJ5CMC+EmqQBcgRNO7zUtNtJpLFpjjw28J3hoJAb2JjCfJ3tx1IT/bEnK
	 Vqg29x8dyAto4HBlO8gGBS85eqw7QuECT/Q/SeHGrFv8pUmn58lnPXxCUhip6mZMlJ
	 FijRfitHBhLuKndNqGmF6u4dpLcxTWAmayqqFHefluwK4YVDUbsQ5s5BnXF/cQqObU
	 NIsgvWIMYcNDQ5pLKMUCw9Qqq/qj1JEW6Dd6kICBMS85a61xrGgzikFFvwveJ2lMdl
	 tA+R21EaUOM6g==
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-7163489149fso6264449a12.3
        for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 02:32:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729675967; x=1730280767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EjhAYSWuMWcY9+F1bfEIJ6rw0z2JaMjOgVamvmV6dkw=;
        b=T+jdmILiRO81SDoXm6lgPfqXysGuIibMLO8hrXCmAfZ3fvXS6HJ1AlSFCSDfEQWEKs
         XisN30L+ODRSgbPPUj6JMGUFM41U782wyRE7x5cDmFMcVdIgaGUuqjdWJ5zQNL94LCJ7
         KqtCaQmveOjLbxnbIc0zayGzdc2OandI1JLEokI9wWxjIDhGHfOTHwtmHS98wdZuLgWX
         a5ZSKEk+nqnv2X6zVgdgTTFrB6z3C9jjtIXtFcy0Gt67mNpUnUSgJl6eS3X/IHgr0sRb
         3EPQg0NBDYry/LvCYltcBMwrX4MLpS8lvm41Y71FGZH20NWETVuVZb5WAI7p7Gb8QuK+
         0cbg==
X-Forwarded-Encrypted: i=1; AJvYcCWuZbOuCPkAmSjKH4XIR9u2ozJU4+ziNkU7FpDcLXv9e9LdAhJ6CLAKBacpgzssQFuxbKNPCfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrK+G7C/5x0AeyFWPz/8hHjBc07ld3yjs8/UVbnX2TCocVFItj
	BD1RPByZ5VNxDcnyh2SX+gRCnhymDiG4laZVE4b4xF5DGpYuGQlDvpFQuPmUk5BzFkmaM9bYkuS
	iYD70K5qT0Nu7KmlWlRxK8mQANiVQoqdmhVl5bA1AM8uxyZYr68Jl5o6nOQPt5E6MuarFTe+WJA
	FLg88gY6pFxBFXQzaLi499tWYnfdFynfBhxiqs33MsxfBY
X-Received: by 2002:a05:6a21:4d8b:b0:1d9:cc2:2c00 with SMTP id adf61e73a8af0-1d978af8325mr2112632637.14.1729675966645;
        Wed, 23 Oct 2024 02:32:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFr83Aq6kOUjlKZ22A7Bd+0WCiN8m2BCuMfVylA6+geLojpcOYML/m+GSxbePTP+WAYXAJAthy/Dz5yvZmBEpc=
X-Received: by 2002:a05:6a21:4d8b:b0:1d9:cc2:2c00 with SMTP id
 adf61e73a8af0-1d978af8325mr2112619637.14.1729675966256; Wed, 23 Oct 2024
 02:32:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231012195127.129585-1-saeed@kernel.org> <20231012195127.129585-10-saeed@kernel.org>
In-Reply-To: <20231012195127.129585-10-saeed@kernel.org>
From: Frode Nordahl <frode.nordahl@canonical.com>
Date: Wed, 23 Oct 2024 11:32:34 +0200
Message-ID: <CAKpbOAT=i2_j7uSXNwbcES04aDm64YEJa=6YD4Bdzneww4Epag@mail.gmail.com>
Subject: Re: [net 09/10] net/mlx5e: Don't offload internal port if filter
 device is out device
To: Saeed Mahameed <saeedm@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, 
	Ariel Levkovich <lariel@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 9:53=E2=80=AFPM Saeed Mahameed <saeed@kernel.org> w=
rote:
>
> From: Jianbo Liu <jianbol@nvidia.com>
>
> In the cited commit, if the routing device is ovs internal port, the
> out device is set to uplink, and packets go out after encapsulation.
>
> If filter device is uplink, it can trigger the following syndrome:
> mlx5_core 0000:08:00.0: mlx5_cmd_out_err:803:(pid 3966): SET_FLOW_TABLE_E=
NTRY(0x936) op_mod(0x0) failed, status bad parameter(0x3), syndrome (0xcdb0=
51), err(-22)
>
> Fix this issue by not offloading internal port if filter device is out
> device. In this case, packets are not forwarded to the root table to
> be processed, the termination table is used instead to forward them
> from uplink to uplink.

This patch breaks forwarding for in production use cases with hardware
offload enabled. In said environments, we do not see the above
mentioned syndrome, so it appears the logic change in this patch hits
too wide.

I do not know the details and inner workings of the constructs
outlined above, can you explain how this is intended to work to help
our understanding of how to approach a fix to this?

Flow steering dumps from a system showing broken and working behavior
(same kernel with this patch reverted) have been attached to
https://launchpad.net/bugs/2085018.

--=20
Frode Nordahl

> Fixes: 100ad4e2d758 ("net/mlx5e: Offload internal port as encap route dev=
ice")
> Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
> Reviewed-by: Ariel Levkovich <lariel@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c b/=
drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
> index 1730f6a716ee..b10e40e1a9c1 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
> @@ -24,7 +24,8 @@ static int mlx5e_set_int_port_tunnel(struct mlx5e_priv =
*priv,
>
>         route_dev =3D dev_get_by_index(dev_net(e->out_dev), e->route_dev_=
ifindex);
>
> -       if (!route_dev || !netif_is_ovs_master(route_dev))
> +       if (!route_dev || !netif_is_ovs_master(route_dev) ||
> +           attr->parse_attr->filter_dev =3D=3D e->out_dev)
>                 goto out;
>
>         err =3D mlx5e_set_fwd_to_int_port_actions(priv, attr, e->route_de=
v_ifindex,
> --
> 2.41.0
>
>

