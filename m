Return-Path: <netdev+bounces-140787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CF79B810F
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 18:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3841028143C
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 17:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40491BE235;
	Thu, 31 Oct 2024 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="b/DWy6M8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7401BDA9A
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 17:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730395209; cv=none; b=jC2+1lpi3EAbkbZvPyQT9LlwFjF8AtkXpRZ8MP6NPbJGRb3jMCzsAxQqLBD38G/5go3F6QZzbS2KHnTSILGSc/0spUdKQTqSTaCEKg/o+G731bJM/pt4z73fVXIlst+FI98w1XfPyjoXBxotdkBytrHcMlhWkoKxDqD6XOrM+T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730395209; c=relaxed/simple;
	bh=mBfBKMdNjU6LD3I7YHUbQ9mT5gM9AFujU/rJ0kWLqbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=djz1RjBpGIIS8F5EYFdbAXc5+KQwFQQh5YefaolyAH9KjFXz1H7YgrES2YJj0o0czMHio0B3UVzrR0+UGZxcG361RYntR01yCi23ASX3XeLRkC6d1Fsm0TVXgXEanNpZm63mXMETIYZ8mTpdtzpWY+e/NNGQP5mG0rDi24K76lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=b/DWy6M8; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e2ab5bbc01so131575a91.2
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 10:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1730395206; x=1731000006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKkFDkzIEBItD3yNbuSEm7Az14lr6rR23lccwnGeVnE=;
        b=b/DWy6M8QwiR2jMbwUgRKI48rrxRBoPeUnXaP8A6atdWBO5SzLKiU9ESm2xusUFuxM
         CosRDnvhxR0/fhe15ksMhBFs0EQDH3QbN4GCxdcNipOaEt4ZdaFV9xJgeXI98HwLovSg
         jpXYgJNWQ5K0oHBpTeUmNZZ2h4V59mhLaxSdkRBboUWtvR/RcEISfZlLigLpcJiz8wUa
         cQNJLiU9bcTqEJl9931ZEgiBOobFoAZO6Pjok1AC14BKa6QjaW3QQxNNBPm/cvUIgHOf
         WTD8nR6fzwdSdeldFNWXWUPCRmPTeWmFOfHaSa3Xy33y9vTp7tq7+W/95PKc9MuXdFFP
         Dpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730395206; x=1731000006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKkFDkzIEBItD3yNbuSEm7Az14lr6rR23lccwnGeVnE=;
        b=WMBBvt0uGJCRMki7Uk8c2md2Zm6T0TJqRCVnUiEBnDixYMqfG6cCwTvrIGTBLA+mX1
         A+wXeNc26FjE5SUmzWF17dlb162/ZZPkm3CL0hMbIW9t8uybu4GX4vasQjqcFfN1R9F/
         P2M9z01XqOvFpPT/pE1G7gvZG4GjXIl4GY1lhDxDLAIh762TWyYwxELXa+PmRCeFAGpK
         yrO/wphUeQE53JDEiDXINDcL9jJPnargt7l1e3TL2AOLkPE2iR7ITJhQDHZ0t9nUj0uv
         DV+Xy9RCujAS5TYXRwkX5bxEitECF31uncrtd6Cxh2r6txri6PRvErmvn38I9yM/c0kv
         orCg==
X-Forwarded-Encrypted: i=1; AJvYcCX3RkcRNTyk2pvtzYmjo5hw/6WwE9TX3SNfZNTv/zNyTiMxK/f/ZINh5ihji9PZ8t8xPuAwwQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUJBIBcrSt7W4STNFh0kEb7puFwfszmfL2pS4AuvWGne1BE9ES
	Ahzy0gaGwosv6ksCjjKTkj2HbDnl6w2pMl4IEpfM1g9IMZLhrTwZXGZW2c8SSYJdIlvdTTsnSG6
	oumopuwY9sUA9Bqe2XFKkAAR5CbzU/EemZQtArg==
X-Google-Smtp-Source: AGHT+IH6t05mbCPluyw/Zm7bZ8Y86vIuSvJgupQimK2c7oAZcHqEQQGqxSncMtgAi8PvmdylJnQUlmy+Sc53Mt/5SYg=
X-Received: by 2002:a17:90b:3003:b0:2e2:b45d:bbb9 with SMTP id
 98e67ed59e1d1-2e8f11bfd7bmr9879885a91.6.1730395206352; Thu, 31 Oct 2024
 10:20:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031002326.3426181-1-csander@purestorage.com>
 <20241031002326.3426181-2-csander@purestorage.com> <ZyN8xpq5C36Tg9rz@LouisNoVo>
In-Reply-To: <ZyN8xpq5C36Tg9rz@LouisNoVo>
From: Caleb Sander <csander@purestorage.com>
Date: Thu, 31 Oct 2024 10:19:55 -0700
Message-ID: <CADUfDZoba9hNOBU7TT+0K6BYiYzVkZ_awt751g6HBm+-cCZf8w@mail.gmail.com>
Subject: Re: [resend PATCH 2/2] dim: pass dim_sample to net_dim() by reference
To: Louis Peens <louis.peens@corigine.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Arthur Kiyanovski <akiyano@amazon.com>, Brett Creeley <brett.creeley@amd.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Claudiu Manoil <claudiu.manoil@nxp.com>, 
	David Arinzon <darinzon@amazon.com>, "David S. Miller" <davem@davemloft.net>, 
	Doug Berger <opendmb@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Felix Fietkau <nbd@nbd.name>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Geetha sowjanya <gakula@marvell.com>, hariprasad <hkelam@marvell.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Leon Romanovsky <leon@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Mark Lee <Mark-MC.Lee@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Michael Chan <michael.chan@broadcom.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Noam Dagan <ndagan@amazon.com>, Paolo Abeni <pabeni@redhat.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Roy Pledge <Roy.Pledge@nxp.com>, 
	Saeed Bishara <saeedb@amazon.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Sean Wang <sean.wang@mediatek.com>, Shannon Nelson <shannon.nelson@amd.com>, 
	Shay Agroskin <shayagr@amazon.com>, Simon Horman <horms@kernel.org>, 
	Subbaraya Sundeep <sbhatta@marvell.com>, Sunil Goutham <sgoutham@marvell.com>, 
	Tal Gilboa <talgi@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, intel-wired-lan@lists.osuosl.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, oss-drivers@corigine.com, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 5:49=E2=80=AFAM Louis Peens <louis.peens@corigine.c=
om> wrote:
>
> On Wed, Oct 30, 2024 at 06:23:26PM -0600, Caleb Sander Mateos wrote:
> > net_dim() is currently passed a struct dim_sample argument by value.
> > struct dim_sample is 24 bytes. Since this is greater 16 bytes, x86-64
> > passes it on the stack. All callers have already initialized dim_sample
> > on the stack, so passing it by value requires pushing a duplicated copy
> > to the stack. Either witing to the stack and immediately reading it, or
> > perhaps dereferencing addresses relative to the stack pointer in a chai=
n
> > of push instructions, seems to perform quite poorly.
> >
> > In a heavy TCP workload, mlx5e_handle_rx_dim() consumes 3% of CPU time,
> > 94% of which is attributed to the first push instruction to copy
> > dim_sample on the stack for the call to net_dim():
> > // Call ktime_get()
> >   0.26 |4ead2:   call   4ead7 <mlx5e_handle_rx_dim+0x47>
> > // Pass the address of struct dim in %rdi
> >        |4ead7:   lea    0x3d0(%rbx),%rdi
> > // Set dim_sample.pkt_ctr
> >        |4eade:   mov    %r13d,0x8(%rsp)
> > // Set dim_sample.byte_ctr
> >        |4eae3:   mov    %r12d,0xc(%rsp)
> > // Set dim_sample.event_ctr
> >   0.15 |4eae8:   mov    %bp,0x10(%rsp)
> > // Duplicate dim_sample on the stack
> >  94.16 |4eaed:   push   0x10(%rsp)
> >   2.79 |4eaf1:   push   0x10(%rsp)
> >   0.07 |4eaf5:   push   %rax
> > // Call net_dim()
> >   0.21 |4eaf6:   call   4eafb <mlx5e_handle_rx_dim+0x6b>
> >
> > To allow the caller to reuse the struct dim_sample already on the stack=
,
> > pass the struct dim_sample by reference to net_dim().
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  Documentation/networking/net_dim.rst                   |  2 +-
> >  drivers/net/ethernet/amazon/ena/ena_netdev.c           |  2 +-
> >  drivers/net/ethernet/broadcom/bcmsysport.c             |  2 +-
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.c              |  4 ++--
> >  drivers/net/ethernet/broadcom/genet/bcmgenet.c         |  2 +-
> >  drivers/net/ethernet/freescale/enetc/enetc.c           |  2 +-
> >  drivers/net/ethernet/hisilicon/hns3/hns3_enet.c        |  4 ++--
> >  drivers/net/ethernet/intel/ice/ice_txrx.c              |  4 ++--
> >  drivers/net/ethernet/intel/idpf/idpf_txrx.c            |  4 ++--
> >  drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c |  2 +-
> >  drivers/net/ethernet/mediatek/mtk_eth_soc.c            |  4 ++--
> >  drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c      |  4 ++--
> >  drivers/net/ethernet/netronome/nfp/nfd3/dp.c           |  4 ++--
> >  drivers/net/ethernet/netronome/nfp/nfdk/dp.c           |  4 ++--
> >  drivers/net/ethernet/pensando/ionic/ionic_txrx.c       |  2 +-
> >  drivers/net/virtio_net.c                               |  2 +-
> >  drivers/soc/fsl/dpio/dpio-service.c                    |  2 +-
> >  include/linux/dim.h                                    |  2 +-
> >  lib/dim/net_dim.c                                      | 10 +++++-----
> >  19 files changed, 31 insertions(+), 31 deletions(-)
> >
> --- snip --
>
> > diff --git a/drivers/net/ethernet/netronome/nfp/nfd3/dp.c b/drivers/net=
/ethernet/netronome/nfp/nfd3/dp.c
> > index d215efc6cad0..f1c6c47564b1 100644
> > --- a/drivers/net/ethernet/netronome/nfp/nfd3/dp.c
> > +++ b/drivers/net/ethernet/netronome/nfp/nfd3/dp.c
> > @@ -1177,11 +1177,11 @@ int nfp_nfd3_poll(struct napi_struct *napi, int=
 budget)
> >                       pkts =3D r_vec->rx_pkts;
> >                       bytes =3D r_vec->rx_bytes;
> >               } while (u64_stats_fetch_retry(&r_vec->rx_sync, start));
> >
> >               dim_update_sample(r_vec->event_ctr, pkts, bytes, &dim_sam=
ple);
> > -             net_dim(&r_vec->rx_dim, dim_sample);
> > +             net_dim(&r_vec->rx_dim, &dim_sample);
> >       }
> >
> >       if (r_vec->nfp_net->tx_coalesce_adapt_on && r_vec->tx_ring) {
> >               struct dim_sample dim_sample =3D {};
> >               unsigned int start;
> > @@ -1192,11 +1192,11 @@ int nfp_nfd3_poll(struct napi_struct *napi, int=
 budget)
> >                       pkts =3D r_vec->tx_pkts;
> >                       bytes =3D r_vec->tx_bytes;
> >               } while (u64_stats_fetch_retry(&r_vec->tx_sync, start));
> >
> >               dim_update_sample(r_vec->event_ctr, pkts, bytes, &dim_sam=
ple);
> > -             net_dim(&r_vec->tx_dim, dim_sample);
> > +             net_dim(&r_vec->tx_dim, &dim_sample);
> >       }
> >
> >       return pkts_polled;
> >  }
> >
> > diff --git a/drivers/net/ethernet/netronome/nfp/nfdk/dp.c b/drivers/net=
/ethernet/netronome/nfp/nfdk/dp.c
> > index dae5af7d1845..ebeb6ab4465c 100644
> > --- a/drivers/net/ethernet/netronome/nfp/nfdk/dp.c
> > +++ b/drivers/net/ethernet/netronome/nfp/nfdk/dp.c
> > @@ -1287,11 +1287,11 @@ int nfp_nfdk_poll(struct napi_struct *napi, int=
 budget)
> >                       pkts =3D r_vec->rx_pkts;
> >                       bytes =3D r_vec->rx_bytes;
> >               } while (u64_stats_fetch_retry(&r_vec->rx_sync, start));
> >
> >               dim_update_sample(r_vec->event_ctr, pkts, bytes, &dim_sam=
ple);
> > -             net_dim(&r_vec->rx_dim, dim_sample);
> > +             net_dim(&r_vec->rx_dim, &dim_sample);
> >       }
> >
> >       if (r_vec->nfp_net->tx_coalesce_adapt_on && r_vec->tx_ring) {
> >               struct dim_sample dim_sample =3D {};
> >               unsigned int start;
> > @@ -1302,11 +1302,11 @@ int nfp_nfdk_poll(struct napi_struct *napi, int=
 budget)
> >                       pkts =3D r_vec->tx_pkts;
> >                       bytes =3D r_vec->tx_bytes;
> >               } while (u64_stats_fetch_retry(&r_vec->tx_sync, start));
> >
> >               dim_update_sample(r_vec->event_ctr, pkts, bytes, &dim_sam=
ple);
> > -             net_dim(&r_vec->tx_dim, dim_sample);
> > +             net_dim(&r_vec->tx_dim, &dim_sample);
> >       }
> >
> >       return pkts_polled;
> >  }
> --- snip ---
>
> Hi Caleb. Looks like a fair enough update to me in general, but I am not =
an
> expert on 'dim'. For the corresponding nfp driver changes feel free to ad=
d:
>
> Signed-off-by: Louis Peens <louis.peens@corigine.com>

Hi Louis,
Thanks for the review. Did you mean "Reviewed-by"? If there was a
change you were suggesting, I missed it.

Best,
Caleb

