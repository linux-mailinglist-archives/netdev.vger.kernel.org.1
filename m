Return-Path: <netdev+bounces-141357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 063729BA881
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 23:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D64A9B21066
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 22:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DEA18C341;
	Sun,  3 Nov 2024 22:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Z0lAo4pm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7076D18BC27
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 22:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730672338; cv=none; b=CSdD8XiwDsNJnyIfLpWo2zXqNqA9OacJji2QbJ8UhNu/0+FcIgG6Roo0Mlb9QWuu5VZIsSgu/ndU8GfwviWNMZ5hTPZOdTIWCo5yWPO5gaX54XY6h1G1arozvSpphNF/+A9IkdM3DVYG82e4n+wrCy18mudgg/mf9jPXksPyBOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730672338; c=relaxed/simple;
	bh=YGawsJXB+jsEC2Okr4d21ol8xSluHNkz7XQ5YfM4hmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRKZHIsV0rQyT+hr3UbLKBIpBBcvkLIPlpia2zKMaaImf3gtEpRc93AWyUcn+7qVqqGiECKHThrFtHJUUbzUD6uCGcvijwWsUyyE0NM/rK3nxCkzle5U6qNvDdtEMP1E5capATD8YzDTV5v7tc8Ut2sUIs089SbB9ov0SLUJC+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Z0lAo4pm; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7ee6afa7ac7so320583a12.2
        for <netdev@vger.kernel.org>; Sun, 03 Nov 2024 14:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1730672335; x=1731277135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DR6c/WPJN94TSRP9CTlobXAtJd4oqXafjQHarDgT3xg=;
        b=Z0lAo4pm9kE/AL/MM90CCrdbc1DMqNVaTcZF/rgDQgpKxHJF7ikrdnOVHBP9i0yA1O
         D7XOB58ITkxOPaQ0AH4oCWdWUT3g9BjRdB54RXkwGGmMf54GDRpWbnnyeXnLBOmDGnGt
         87/P6Q1YmWdZWkir9mk7RL8oq0GuwnVoF8w68cPlPUWSuefOVa4O1TaoHjiXVwp4oIM+
         zUq0+vi2/MBegEAIbdogQpQ4lvhTvK74SkxYt+60Njxpi0WnDNwqIRJDAkn37n3SriKU
         j0/O7j37FJqHo6jj7gjqOI6HTawQeskaWN67/OOKmoEirxnUskWvlzPlYH07ODDd4ygC
         DjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730672335; x=1731277135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DR6c/WPJN94TSRP9CTlobXAtJd4oqXafjQHarDgT3xg=;
        b=r9kzhLFs3WlNHsR5l7xAIhYy6W9Qap/D7JI89f3t5+zsJBcZOD5FAXj6y69tBsjw6J
         NJ8ZXMF9Crbx02JkYbYHadqOVT/Eez6tQqFyKoY0wLNuF2ZlQm9w1khOFEqZj/Ba8Hv1
         Xr3EGcpKaIjOfFQOtN50eRGqNch7LvunfXpq7uVte6FUn/L0qShg6yR+rskfv0VqBjie
         M3QFxKpfqkF9sHBP5FWke2j1IIOlKoV/zsMCBpjQ1LpWnx4ChGI3LUnNKkBAakDAmzaX
         rkGRajmz3vR5TEhms2p74//crczU5nTlxLzJbe4Ra5z49tOkgwUBQAoBcGPcuZaWT6s/
         iqSg==
X-Forwarded-Encrypted: i=1; AJvYcCUg6VoWflbPz/laimg4v3l9KfpxfzS6g6i4we9UKubQAO6aIf7OUEMp+DVLUZUcHSs8lepixXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbRVD/Fy2IfrWOb02UV1hMtVQXubfvBlBHrr3/7YbVMQ4UQWYr
	uMUX2YCnLlU+XhkQ6iUurg26IeuA79OWEZ28kiK5WSM/uaq5yP7k/th58ObQYk+YBIhRE8OgZ8f
	dL5cQgirMnD6GSoRmtdFe1CqYG738n1eejezZGA==
X-Google-Smtp-Source: AGHT+IExPA2hsiAKoyDZwRCgYk5UAZ7TEXffOizLQFxWQDP2pcqP6Jrb05184RINemMWnN8NpvwAMu6stmFhPCSnf1w=
X-Received: by 2002:a17:90a:77c5:b0:2e5:5a58:630 with SMTP id
 98e67ed59e1d1-2e8f11a8ba9mr15038332a91.5.1730672334564; Sun, 03 Nov 2024
 14:18:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101034647.51590-1-csander@purestorage.com>
 <20241101034647.51590-2-csander@purestorage.com> <CY8PR12MB71958512F168E2C172D0BE05DC502@CY8PR12MB7195.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB71958512F168E2C172D0BE05DC502@CY8PR12MB7195.namprd12.prod.outlook.com>
From: Caleb Sander <csander@purestorage.com>
Date: Sun, 3 Nov 2024 14:18:43 -0800
Message-ID: <CADUfDZofFwy12oZYTmm3TE314RM79EGsxV6bKEBRMVFv8C3jNg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] mlx5/core: deduplicate {mlx5_,}eq_update_ci()
To: Parav Pandit <parav@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 2, 2024 at 8:55=E2=80=AFPM Parav Pandit <parav@nvidia.com> wrot=
e:
>
>
>
> > From: Caleb Sander Mateos <csander@purestorage.com>
> > Sent: Friday, November 1, 2024 9:17 AM
> >
> > The logic of eq_update_ci() is duplicated in mlx5_eq_update_ci(). The o=
nly
> > additional work done by mlx5_eq_update_ci() is to increment
> > eq->cons_index. Call eq_update_ci() from mlx5_eq_update_ci() to avoid
> > the duplication.
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  drivers/net/ethernet/mellanox/mlx5/core/eq.c | 9 +--------
> >  1 file changed, 1 insertion(+), 8 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> > b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> > index 859dcf09b770..078029c81935 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> > @@ -802,19 +802,12 @@ struct mlx5_eqe *mlx5_eq_get_eqe(struct
> > mlx5_eq *eq, u32 cc)  }  EXPORT_SYMBOL(mlx5_eq_get_eqe);
> >
> >  void mlx5_eq_update_ci(struct mlx5_eq *eq, u32 cc, bool arm)  {
> > -     __be32 __iomem *addr =3D eq->doorbell + (arm ? 0 : 2);
> > -     u32 val;
> > -
> >       eq->cons_index +=3D cc;
> > -     val =3D (eq->cons_index & 0xffffff) | (eq->eqn << 24);
> > -
> > -     __raw_writel((__force u32)cpu_to_be32(val), addr);
> > -     /* We still want ordering, just not swabbing, so add a barrier */
> > -     wmb();
> > +     eq_update_ci(eq, arm);
> Long ago I had similar rework patches to get rid of __raw_writel(), which=
 I never got chance to push,
>
> Eq_update_ci() is using full memory barrier.
> While mlx5_eq_update_ci() is using only write memory barrier.
>
> So it is not 100% deduplication by this patch.
> Please have a pre-patch improving eq_update_ci() to use wmb().
> Followed by this patch.

Right, patch 1/2 in this series is changing eq_update_ci() to use
writel() instead of __raw_writel() and avoid the memory barrier:
https://lore.kernel.org/lkml/20241101034647.51590-1-csander@purestorage.com=
/
Are you suggesting something different? If so, it would be great if
you could clarify what you mean.

Best,
Caleb

