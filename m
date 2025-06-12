Return-Path: <netdev+bounces-196807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D97DAD672A
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 07:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A5281781DC
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 05:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1E71D7E57;
	Thu, 12 Jun 2025 05:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sDHB2qpn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EEC347C7
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 05:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749705395; cv=none; b=Dm6/ocFQi5gJzHfjr++VN+wgFh+zEJM4QtAj4FHqPbj0k2t8DbtfTiga+8SvIp4Y4C0oO4oFpaBO6Aee/5Qco8y9m0U5cZeED8OW2VpVD9vHO0Z7oqaNZC33gtzQ6SZtsigxEWYNAxeh4CP47VB+B6A8piMvRmZYao5NapJSvPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749705395; c=relaxed/simple;
	bh=GYwJDBqm5ype1Fn87+cuFdQQ7WJUMfaovIJl6GLLetg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gKzFASI068mjw8pEvxkWautuIthCkLPJTZGF+/XFjHDFixuOoxwUHRvh4H7NVbbANsBReCDp+eqk44ByzhMn+hoy+2BHi0iayW4HlD8xtjY/rNx+R/+U/7pA4C75J1wJ829cCrpMqEXxGxAxgDYyRoUMx7Q51B3CHMoyCJo1bw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sDHB2qpn; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-235e389599fso125355ad.0
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 22:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749705393; x=1750310193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6diRbRZRukPlWo9M8OnwMyyu0ZftkgUDqdamePSBwg=;
        b=sDHB2qpnwXvcOKxsQtQo/Q4WJS5QK/HrPfBdYCgUz3W9Eb04KykuWqhl8HcDa/Ui90
         axXTHe8gHVxfSpsaif29YE6UFLQLgPSZjo3pZQsiipao9Hc+MgySlvYCGRbA6n/daot1
         0i2dHxn3azMLq5dqxMEHnTkWa5nErRAYU/4E7rbAZTXIDpbg9B5mQP/f8LoP3rrU2Pzu
         5WPIERiQUhvpR7KlmSo08l3oU+d+H0MhdgcFmy2J5JzkIi8SjDUWmh/hu0QTjgEJsdzm
         HIjOux2C1tnk7asVgoLvImgThko8L5Kqu5XFZFK5F8iV0LBxsCpIEOw2i+MrMYp2UKrh
         0CqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749705393; x=1750310193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p6diRbRZRukPlWo9M8OnwMyyu0ZftkgUDqdamePSBwg=;
        b=tUNT3X/km/TXacUUB9+SycjhrWyAuyjMijLubFVzCThiHK7I5jB1+lWFH4K11Iz8Lz
         cd1B8fhOHxNOdCuMGtPrMZUWZyp+gOP/H0uuTRj5NG8lu9AQrk5oOTHg3ZVq4v2h49zW
         T+Z+t1Rpt3lyXdM6AdGr1LYtnglzii3TYgUK9Jnf4xdzob35W/lzLgXovBFu5vG1ZZzb
         xpBq2Ld3HaAnLnmKoh8t0BaMi9lytQyCa54C3FtGniunFmBmzXywnUXaQ9M3yxwFQBGp
         awWo7UbDid4ZpsYgqDBJKjJeXwY715UODW90QH03K0TXYFRE53ksKIPnHOyZS94zdiDV
         vxUA==
X-Forwarded-Encrypted: i=1; AJvYcCXv6UFehOUwDw5pUppTARHbic3MC7gcQep2TKbT0F6hKURVSTizzEIt7PWp6w5rw8eE7OUiob0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZIfv4I8i8bEc+Lq7Jv+qdwqmNpfLCN0ot6S9oVH6dcSM0qUpd
	HAZy1LQ8lxBgz9VGmRbl6Jr6Lkoas7zpjvX5X7znOnpNuK2xlXjSTIZWnsDYenkDa5OTGtWS066
	1w9/N4/vlZUD5En7fuQLdJm2h6AcjQyWK3STxEE2Q
X-Gm-Gg: ASbGncv6K/HYj9qVuCVBrXa+d6Wt1bVPQCK60KUWg6PwqqIA2x0K6gYf4fAiXXhtx8G
	/hDHzB3vXGaOrfxeYs5RfDIfb407l2ALeHPNtY0YZEWWzvC43R9S3u2v6adAJBFLl2hH/yX5DgN
	2bSwLZn0dQjYHOYzBkVR0D7ltiOosK+a7m2m0akYWgQ+eJ
X-Google-Smtp-Source: AGHT+IFsS2B5lC69yG+ZIzDjoB42cEDFFoUNubkkslLP3SlQB8j7he9Gt0R5igTKHstKDOVSt4yEWMRv9eqcqO1H2bY=
X-Received: by 2002:a17:902:d4cf:b0:235:e1e4:efc4 with SMTP id
 d9443c01a7336-2364dc69fc5mr1822195ad.14.1749705392972; Wed, 11 Jun 2025
 22:16:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610150950.1094376-1-mbloch@nvidia.com> <20250610150950.1094376-9-mbloch@nvidia.com>
In-Reply-To: <20250610150950.1094376-9-mbloch@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 11 Jun 2025 22:16:18 -0700
X-Gm-Features: AX0GCFtSea24S64oBWfvhRVn2iiOFXlEz1l-q8Ml6dx4ayAJvrSCDhs5kdtjaHM
Message-ID: <CAHS8izOEn+C5QexSPZT3_ekUr2zR1dm9R6OsoGBPaqg5MFvBRQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 08/11] net/mlx5e: Add support for UNREADABLE
 netmem page pools
To: Mark Bloch <mbloch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, saeedm@nvidia.com, gal@nvidia.com, 
	leonro@nvidia.com, tariqt@nvidia.com, Leon Romanovsky <leon@kernel.org>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dragos Tatulea <dtatulea@nvidia.com>, 
	Cosmin Ratiu <cratiu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 8:20=E2=80=AFAM Mark Bloch <mbloch@nvidia.com> wrot=
e:
>
> From: Saeed Mahameed <saeedm@nvidia.com>
>
> On netdev_rx_queue_restart, a special type of page pool maybe expected.
>
> In this patch declare support for UNREADABLE netmem iov pages in the
> pool params only when header data split shampo RQ mode is enabled, also
> set the queue index in the page pool params struct.
>
> Shampo mode requirement: Without header split rx needs to peek at the dat=
a,
> we can't do UNREADABLE_NETMEM.
>
> The patch also enables the use of a separate page pool for headers when
> a memory provider is installed for the queue, otherwise the same common
> page pool continues to be used.
>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/=
net/ethernet/mellanox/mlx5/core/en_main.c
> index 5e649705e35f..a51e204bd364 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -749,7 +749,9 @@ static void mlx5e_rq_shampo_hd_info_free(struct mlx5e=
_rq *rq)
>
>  static bool mlx5_rq_needs_separate_hd_pool(struct mlx5e_rq *rq)
>  {
> -       return false;
> +       struct netdev_rx_queue *rxq =3D __netif_get_rx_queue(rq->netdev, =
rq->ix);
> +
> +       return !!rxq->mp_params.mp_ops;

This is kinda assuming that all future memory providers will return
unreadable memory, which is not a restriction I have in mind... in
theory there is nothing wrong with memory providers that feed readable
pages. Technically the right thing to do here is to define a new
helper page_pool_is_readable() and have the mp report to the pp if
it's all readable or not.

But all this sounds like a huge hassle for an unnecessary amount of
future proofing, so I guess this is fine.

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

