Return-Path: <netdev+bounces-142651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E588E9BFD6F
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 05:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46BA5B2195A
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 04:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6534718DF62;
	Thu,  7 Nov 2024 04:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="D4DJthtB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1825282C60
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 04:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730954735; cv=none; b=LySYFcnlbXR4pQ4BkByYc5tp3DSVFFb3sC/xxijXQC7gZLROhy/dIkaYBiDl6syVuAsEyO6AgZrQ76vmIkLeKI9xGcdL6pQRX/nnm244+XlDirRFeGvSry9tko5kwH8XUgeh6TM61QZZI4lsAkIMqDZ6NENBVBgLQjyeBMWyCUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730954735; c=relaxed/simple;
	bh=u5u6J+p9KvxvHcLEKvZFthjYircE+5q68XJQEzSYMDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pOchFIkRI3wGux1Af0y/LDJOJZMQQJW8CeaASRTCVW9t5N2zR3s90r/ggH3AvtiykpiQYh6musTWtKo+J2BNu/dcy46v9ZC8GmRTFSrDpHjBvBKe+3d2cYxYJBOsR9iZtAWCFolKcPgFJgozhcbfC7qqUI3GGM6smv/ZE9uhQiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=D4DJthtB; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ee36621734so87152a12.3
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 20:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1730954732; x=1731559532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtOHfAy5aCt+GGU4uG0UwF/fwe6/CQNExXJXCksm6QA=;
        b=D4DJthtBMP+5YFEPKWqq1UNMquLc9EpZtZS9byu2MLwoeNmhRqehYHJQPHSJCs1prv
         UIu/OqLmCRwsfy75NgR1w9sQLC+1MhBKNp0eOwMf1QPvdfT40fCYmTb4OzbLS6UHhx8E
         Ji88ixS+tPdIOufSA+MIi7tz5Vx7JIIxcshbX3Puej5aXVwSYIZbw33q5gdScJJLyfMh
         gktm/X8PFQqiDktfnUEb+R5lhhtiuRs95a1OcvosP5ZLQIZKticUrJfv3tBKlD7TdEz5
         HQ9lOg0Zt/9GpX8WKTCL5suHvX5VE15WhaSoHtLaRGG/dcb1PVNPqgyHOs253eDms/rQ
         MzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730954732; x=1731559532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtOHfAy5aCt+GGU4uG0UwF/fwe6/CQNExXJXCksm6QA=;
        b=arpFAi+SSSq/mKYvw04+xsSn4E9B1VXxSGHqhpvHHqnUDT6xrwLk5+o4YkGlunB9j+
         mJs1L/yBk4lVYU5R2auODbakOKG5nkWPa2w+NqpTMuonqWaVVB/mdbcTKxq9NoPpAI7U
         D3rSdpZYCZVZC5TAJWYfutCwd3ol55FZsJcXAgn1uRVCTeknsY6x1SzBGAR2RkwMMupx
         vsZTMucDX5HUVbF1A9GNGWpaM6ZAcn6QWgME+Yyf9HMZd96XKRcEwxeceucKRRYkj1RG
         nB0fv5XyUKIjCF49BCNcXaRI2GJ+p4HvTwGiDd1nlTIs8rp/n3abbjq9gdtHmiERNKsA
         qRCg==
X-Forwarded-Encrypted: i=1; AJvYcCXDAjvRr4mTl0wEA7m2FHP3IE5b1B6oLDWoDuqHcypbKOXSYkwoF/AkREWLXociOpOpyMDXLsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDMDg4wQgLZXgb98Gwb8L/Jjtch9VWvIhhH2HgZLs6VhvDe88m
	c/QxOBlE4/sJN+CChMt0smzGZRaN6qa6c/00zPyvs3Ww3wiwj/HEyLPFTCyobX1ct6Nl2ehKAG9
	RkBjxdM5LGcIBetZBAls3iop9/IR7n1EYGyvHXQ==
X-Google-Smtp-Source: AGHT+IF4MWWFPUVr+eNFH0BUtu6VV1JsBn+uZvnKv9TrBQ2BkQChJZMyB/ggEyuXbM2f+zU63HsozJ4K0luvG0cxQxA=
X-Received: by 2002:a17:90b:33c9:b0:2e2:af5b:a18d with SMTP id
 98e67ed59e1d1-2e9a4b305e8mr1026480a91.4.1730954732197; Wed, 06 Nov 2024
 20:45:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101034647.51590-1-csander@purestorage.com>
 <20241101034647.51590-2-csander@purestorage.com> <CY8PR12MB71958512F168E2C172D0BE05DC502@CY8PR12MB7195.namprd12.prod.outlook.com>
 <CADUfDZofFwy12oZYTmm3TE314RM79EGsxV6bKEBRMVFv8C3jNg@mail.gmail.com>
 <CY8PR12MB71953FD36C70ACACEBE3DBA1DC522@CY8PR12MB7195.namprd12.prod.outlook.com>
 <CADUfDZqanDo+v_jap7pQire86QkfaDQE4HvhvVBb64YqKNgRHg@mail.gmail.com>
 <CY8PR12MB7195FDC4A280F4CD7EA219ABDC532@CY8PR12MB7195.namprd12.prod.outlook.com>
 <CADUfDZon6QbURp7TqB6dvE4Ewb_To2EDyUTQ=spNCorXDy0DbQ@mail.gmail.com> <ZywnmDQIxzgV3uJe@x130>
In-Reply-To: <ZywnmDQIxzgV3uJe@x130>
From: Caleb Sander <csander@purestorage.com>
Date: Wed, 6 Nov 2024 20:45:20 -0800
Message-ID: <CADUfDZq0E-GJZxFD4gR7qqpHqcQ2d4cy-Duz7SYMpOZTRvOcKA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] mlx5/core: deduplicate {mlx5_,}eq_update_ci()
To: Saeed Mahameed <saeed@kernel.org>
Cc: Parav Pandit <parav@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 6:36=E2=80=AFPM Saeed Mahameed <saeed@kernel.org> wr=
ote:
>
> On 06 Nov 15:44, Caleb Sander wrote:
> >On Tue, Nov 5, 2024 at 9:44=E2=80=AFPM Parav Pandit <parav@nvidia.com> w=
rote:
> >>
> >>
> >> > From: Caleb Sander <csander@purestorage.com>
> >> > Sent: Tuesday, November 5, 2024 9:36 PM
> >> >
> >> > On Mon, Nov 4, 2024 at 9:22=E2=80=AFPM Parav Pandit <parav@nvidia.co=
m> wrote:
> >> > >
> >> > >
> >> > >
> >> > > > From: Caleb Sander <csander@purestorage.com>
> >> > > > Sent: Monday, November 4, 2024 3:49 AM
> >> > > >
> >> > > > On Sat, Nov 2, 2024 at 8:55=E2=80=AFPM Parav Pandit <parav@nvidi=
a.com> wrote:
> >> > > > >
> >> > > > >
> >> > > > >
> >> > > > > > From: Caleb Sander Mateos <csander@purestorage.com>
> >> > > > > > Sent: Friday, November 1, 2024 9:17 AM
> >> > > > > >
> >> > > > > > The logic of eq_update_ci() is duplicated in mlx5_eq_update_=
ci().
> >> > > > > > The only additional work done by mlx5_eq_update_ci() is to
> >> > > > > > increment
> >> > > > > > eq->cons_index. Call eq_update_ci() from mlx5_eq_update_ci()=
 to
> >> > > > > > eq->avoid
> >> > > > > > the duplication.
> >> > > > > >
> >> > > > > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> >> > > > > > ---
> >> > > > > >  drivers/net/ethernet/mellanox/mlx5/core/eq.c | 9 +--------
> >> > > > > >  1 file changed, 1 insertion(+), 8 deletions(-)
> >> > > > > >
> >> > > > > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> >> > > > > > b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> >> > > > > > index 859dcf09b770..078029c81935 100644
> >> > > > > > --- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> >> > > > > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> >> > > > > > @@ -802,19 +802,12 @@ struct mlx5_eqe *mlx5_eq_get_eqe(struc=
t
> >> > > > > > mlx5_eq *eq, u32 cc)  }  EXPORT_SYMBOL(mlx5_eq_get_eqe);
> >> > > > > >
> >> > > > > >  void mlx5_eq_update_ci(struct mlx5_eq *eq, u32 cc, bool arm=
)  {
> >> > > > > > -     __be32 __iomem *addr =3D eq->doorbell + (arm ? 0 : 2);
> >> > > > > > -     u32 val;
> >> > > > > > -
> >> > > > > >       eq->cons_index +=3D cc;
> >> > > > > > -     val =3D (eq->cons_index & 0xffffff) | (eq->eqn << 24);
> >> > > > > > -
> >> > > > > > -     __raw_writel((__force u32)cpu_to_be32(val), addr);
> >> > > > > > -     /* We still want ordering, just not swabbing, so add a=
 barrier */
> >> > > > > > -     wmb();
> >> > > > > > +     eq_update_ci(eq, arm);
> >> > > > > Long ago I had similar rework patches to get rid of
> >> > > > > __raw_writel(), which I never got chance to push,
> >> > > > >
> >> > > > > Eq_update_ci() is using full memory barrier.
> >> > > > > While mlx5_eq_update_ci() is using only write memory barrier.
> >> > > > >
> >> > > > > So it is not 100% deduplication by this patch.
> >> > > > > Please have a pre-patch improving eq_update_ci() to use wmb().
> >> > > > > Followed by this patch.
> >> > > >
> >> > > > Right, patch 1/2 in this series is changing eq_update_ci() to us=
e
> >> > > > writel() instead of __raw_writel() and avoid the memory barrier:
> >> > > > https://lore.kernel.org/lkml/20241101034647.51590-1-
> >> > > > csander@purestorage.com/
> >> > > This patch has two bugs.
> >> > > 1. writel() writes the MMIO space in LE order. EQ updates are in B=
E order.
> >> > > So this will break on ppc64 BE.
> >> >
> >> > Okay, so this should be writel(cpu_to_le32(val), addr)?
> >> >
> >> That would break the x86 side because device should receive in BE form=
at regardless of cpu endianness.
> >> Above code will write in the LE format.
> >>
> >> So an API foo_writel() need which does
> >> a. write memory barrier
> >> b. write to MMIO space but without endineness conversion.
> >
> >Got it, thanks. writel(bswap_32(val, addr)) should work, then? I
> >suppose it may introduce a second bswap on BE architectures, but
> >that's probably worth it to avoid the memory barrier.
> >
>
> The existing mb() needs to be changed to wmb(), this will provide a more
> efficient fence on most architectures.
>
> I don't understand why you are still discussing the use of writel(), yes
> it will work but you are introducing two unconditional swaps per doorbell
> write.

Well, no memory fence is cheaper still than a wmb(). But it's your
driver, so if you prefer to use wmb() rather than switch to writel(),
that's fine. I'll update the patch series.
As for the bytes swaps in writel(bswap_32(val), addr), it would still
be 1 on LE architectures, but 2 instead of 0 on BE architectures.
Certainly a bit inefficient, but probably less overhead than the
memory barrier currently adds on strongly-ordered architectures.

>
> Just replace the existing mb with wmb() in eq_update_ci()
>
> And if you have time to write one extra patch, please reuse eq_update_ci(=
)
> inside mlx5_eq_update_ci().
>
> mlx5_eq_update_ci(eq, cc, arm) {
>         eq->cons_index +=3D cc;
>         eq_update_ci(eq, arm);
> }
>
> So we won't have two different implementations of EQ doorbell ringing
> anymore.

Isn't this what my patch 2 (at the start of this reply chain) already
does? If you are suggesting something else, please clarify.

Thanks for the reviews,
Caleb

