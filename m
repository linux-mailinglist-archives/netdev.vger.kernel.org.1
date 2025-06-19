Return-Path: <netdev+bounces-199541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F02AE0A85
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 17:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F34267B126F
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 15:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739FC235056;
	Thu, 19 Jun 2025 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SEVVpK0g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB22E230D2B
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750347184; cv=none; b=M1GeC86/o+1HePnvDfGyAefUKPD26UDtuYQak/c/XYsJZVqXSEvBowct/wOVQExkqcCy4zRu0uuNF/gMQi6h5bG3TILipnuW44c+I0ZhDq8j+wqN8A4Aacu4p7K78tS5p0okiHkBeXtuyXFoND5o/GJ2PQVtAdaPF4nSUJ9fxBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750347184; c=relaxed/simple;
	bh=lxBXV+GubjSrJd0XTspC2SdPSyHzVlqI6DPzVTMGnQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gnCEfNK+NUzsD8uLllG3aWXi9/d1mzl8BauV10JxvCa1gZIr/rhLLSItieasepoLmrKXtzeHXd0mTemnW3FcTwhs6yEbfg0CufskWpNXexa+9z9LQ/9OpxGc6h4Lp0cMDffKsrrMDYqeKFPL57fHhHPXQdcIes1+PixiWrbyUuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SEVVpK0g; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2348ac8e0b4so157525ad.1
        for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 08:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750347182; x=1750951982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOM3D8gI4Fn5XbrHI7kszdc+Yv0avQmjCEqnHlu1cqc=;
        b=SEVVpK0gVdYggP3fjqk3SRVMWwpIGa4nTWOEoZ4Ho249ldqY1KfL9rEBkEG2Z1Vf5f
         3dunwwApa24cYOGUjE8hJerE9ZRaqqSbR7UZGBisL23cy4wVrs2jVHpUPadrFYLsfg6W
         QJwCHPfqetDo4rRuZlTveR3E7cccM8OPoN0AS85liqa2gcuuxI+r+X83tH3nFb0s/ERD
         nEM2/jzh3rXHwdKqToceIxvE0ktmAhPtmezZZScHRcojSXevRjdGYZcgWVgbD3KMzwZD
         64n5o77Bbej9e3dZ03KRZHBavMX/PJJ1cKqjBNYMXeTFOWEjoIGRBf5HQyhuTeKkEgtJ
         bnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750347182; x=1750951982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOM3D8gI4Fn5XbrHI7kszdc+Yv0avQmjCEqnHlu1cqc=;
        b=rleRmHeZPOZvu9ddPRTEBdmn7TyT4m2+Cp/QlgeJkzMHWrfIT/sdVjQLpykk2IT9nV
         gknkQAR27mThVsTeit05OFBtO5DGWHz4PJuj47NGNkh3zTxiuTRsqBwiqfs2/l+I0dKQ
         sOad56zb94UVt24qTTY6ikRjExxQvxk0PoXEJiVihJq7+uhhbDNGi3/rKHGFaKOGN2py
         X3VHRLKoHqEuvcGUJHTT8SlDd9GDzqzK5l6p06Yz8KLGyCvz6O4jZjDRppknYCnzed5s
         F1xvv9lTGSnKA38KK5ARtYHbJ2eCBpjW2nvVxvr4ScBqKTuumRzBebKe3Ev6D3TPfLKe
         498w==
X-Forwarded-Encrypted: i=1; AJvYcCWomTWxdTF1nUaHRhZY9hEmx886Ft7ofN0bLL9Pcv73g+MHyFump/WliRfDDAFM1NZeqv7gQ1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSJer7u6WYgq6NFNYQhKBXfSwqGmd0uWzjxnyK/1oUAJPFrlcs
	7tY1SbgaYjLp3IMUtZPBFwc/1x3vcwjW3nDDf4NiHaFSN3Ei+O8emWHjIL232Nl4sqI7tij3wNb
	PkWdPaiVSSTyoHhq6rRql8079ZoZxZfl+vebky5Ed
X-Gm-Gg: ASbGncsjFeyFRRltLtqQbB5RJjTfsB7t6yJpHxrR14dzGZWbatmscjvJDsLBlmnF4jS
	8uM5uB0qj9FxRYY6ocmmApFj9KEzyapDp7+mZ4v98Ow82FVivNo6Bkntuen4rKgyflHESsPT+Eo
	FueNNjFGJuJBbiWgspa4rNF0WssGwfXoiry2N/f5reWT8VMuNsteIolFw=
X-Google-Smtp-Source: AGHT+IErSWv8L1YPw8HOAU41+CMvE2NqmIcXDmcNLJih7xZUUxtLOuDPG7Zts+coXJA1bDnI37gkYepiWSjJ4SNjnhw=
X-Received: by 2002:a17:902:ce8b:b0:235:e1d6:5343 with SMTP id
 d9443c01a7336-237cca97bd0mr3178765ad.20.1750347181562; Thu, 19 Jun 2025
 08:33:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616141441.1243044-1-mbloch@nvidia.com> <20250616141441.1243044-13-mbloch@nvidia.com>
 <aFM6r9kFHeTdj-25@mini-arch> <q7ed7rgg4uakhcc3wjxz3y6qzrvc3mhrdcpljlwfsa2a7u3sgn@6f2ronq35nee>
In-Reply-To: <q7ed7rgg4uakhcc3wjxz3y6qzrvc3mhrdcpljlwfsa2a7u3sgn@6f2ronq35nee>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 19 Jun 2025 08:32:48 -0700
X-Gm-Features: AX0GCFvEVg4miDWdlVmeUP2J0NAdAqMVfItn2V73vw4jp1VCRatXqHkj5WpvejE
Message-ID: <CAHS8izM-9vystQMRZrcCmjnT6N6KyqTU0QkFMJGU7GGLKKq87g@mail.gmail.com>
Subject: Re: [PATCH net-next v6 12/12] net/mlx5e: Add TX support for netmems
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, Mark Bloch <mbloch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com, 
	tariqt@nvidia.com, Leon Romanovsky <leon@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Richard Cochran <richardcochran@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 12:20=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
> On Wed, Jun 18, 2025 at 03:16:15PM -0700, Stanislav Fomichev wrote:
> > On 06/16, Mark Bloch wrote:
> > > From: Dragos Tatulea <dtatulea@nvidia.com>
> > >
> > > Declare netmem TX support in netdev.
> > >
> > > As required, use the netmem aware dma unmapping APIs
> > > for unmapping netmems in tx completion path.
> > >
> > > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> > > Reviewed-by: Mina Almasry <almasrymina@google.com>
> > > Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> > > ---
> > >  drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h | 3 ++-
> > >  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 ++
> > >  2 files changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/driv=
ers/net/ethernet/mellanox/mlx5/core/en/txrx.h
> > > index e837c21d3d21..6501252359b0 100644
> > > --- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
> > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
> > > @@ -362,7 +362,8 @@ mlx5e_tx_dma_unmap(struct device *pdev, struct ml=
x5e_sq_dma *dma)
> > >             dma_unmap_single(pdev, dma->addr, dma->size, DMA_TO_DEVIC=
E);
> > >             break;
> > >     case MLX5E_DMA_MAP_PAGE:
> > > -           dma_unmap_page(pdev, dma->addr, dma->size, DMA_TO_DEVICE)=
;
> > > +           netmem_dma_unmap_page_attrs(pdev, dma->addr, dma->size,
> > > +                                       DMA_TO_DEVICE, 0);
> >
> > For this to work, the dma->addr needs to be 0, so the callers of the
> > dma_map() need to be adjusted as well, or am I missing something?
> > There is netmem_dma_unmap_addr_set to handle that, but I don't see
> > anybody calling it. Do we need to add the following (untested)?
> >
> Hmmmm... yes. I figured that skb_frag_dma_map() would do the work
> but I was wrong, it is not enough.
>
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/=
net/ethernet/mellanox/mlx5/core/en_tx.c
> > index 55a8629f0792..fb6465210aed 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> > @@ -210,7 +210,9 @@ mlx5e_txwqe_build_dsegs(struct mlx5e_txqsq *sq, str=
uct sk_buff *skb,
> >               if (unlikely(dma_mapping_error(sq->pdev, dma_addr)))
> >                       goto dma_unmap_wqe_err;
> >
> > -             dseg->addr       =3D cpu_to_be64(dma_addr);
> > +             dseg->addr =3D 0;
> > +             if (!netmem_is_net_iov(skb_frag_netmem(frag)))
> > +                     dseg->addr =3D cpu_to_be64(dma_addr);
> AFAIU we still want to pass the computed dma_address to the data segment
> to the HW. We only need to make sure in mlx5e_dma_push() to set dma_addr
> to 0,

yes

> to avoid calling netmem_dma_unmap_page_attrs() with dma->addr 0.
> Like in the snippet below. Do you agree?
>

the opposite. You want netmem_dma_unmap_page_attrs() to be called with
dma->addr =3D=3D 0, so that is will skip the dma unmapping.

> We will send a fix patch once the above question is answered. Also, is
> there a way to test this with more confidence? The ncdevmem tx test
> passed just fine.
>

You have to test ncdevmem tx on a platform with iommu enabled. Only in
this case the netmem_dma_unmap_page_attrs() may cause a problem, and
even then it's not a sure thing. It depends on the type of iommu and
type of dmabuf i think.

> Thanks,
> Dragos
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/ne=
t/ethernet/mellanox/mlx5/core/en_tx.c
> index 55a8629f0792..ecee2e4f678b 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> @@ -214,6 +214,9 @@ mlx5e_txwqe_build_dsegs(struct mlx5e_txqsq *sq, struc=
t sk_buff *skb,
>                 dseg->lkey       =3D sq->mkey_be;
>                 dseg->byte_count =3D cpu_to_be32(fsz);
>
> +               if (!netmem_is_net_iov(skb_frag_netmem(frag)))
> +                       dma_addr =3D 0;
> +
>                 mlx5e_dma_push(sq, dma_addr, fsz, MLX5E_DMA_MAP_PAGE);
>                 num_dma++;

If you can find a way to do this via netmem_dma_unmap_addr_set, I
think that would be better, so you're not relying on a manual
netmem_is_net_iov check.

The way you'd do that is you'd pass skb_frag_netmem(frag) to
mlx5e_dma_push, and then replace the `dma->addr =3D addr` with
netmem_dma_unmap_addr_set. But up to you.

If you decide to do a net_iov check and dma_addr =3D 0, add a comment pleas=
e.

--=20
Thanks,
Mina

