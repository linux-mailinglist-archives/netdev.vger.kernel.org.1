Return-Path: <netdev+bounces-210411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4C0B13274
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 01:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22C043B74B9
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 23:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592A024DCEB;
	Sun, 27 Jul 2025 23:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EugQExxE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00B71DFE26
	for <netdev@vger.kernel.org>; Sun, 27 Jul 2025 23:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753658042; cv=none; b=hDW0zpyt9Mb02Yksl4Efyg+ggxrM7hkUXKARsQ4TA3ziUHie2ggQn8v4dhGaT8mhGJkaY/hVVZBpqPIfBq4PICV1oKUKc0cEODdEsHjNvYWjwqJfmCr0VG0yw6KZcY9SFCrJpjh9mlayleEJgxH53+tYlZN+FiIKThqQ5TtdhnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753658042; c=relaxed/simple;
	bh=AA5cEiCZGPQQ1l349zBa3b0Ko36pA+EkiQVGmjrx4BE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EVl79xNcOVNl2q2l5tEop1mY2CH8T45WVhE9DmYJBovX1FlMdNLPSifggkE0CmkBLmBJrvC48r009jCPs55yJ+W65VMTm5x2pYrNXx6qwRD0LhN00cLcLrYbyF9rGRX/ktVjsVqKbDpH39YnevkHbrbJzCHLCGL2v21AUKtnQyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EugQExxE; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3e3d181e839so6120515ab.2
        for <netdev@vger.kernel.org>; Sun, 27 Jul 2025 16:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753658040; x=1754262840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UuRwDLo2z1zF0ZI+zOBq6CzyaD7vIeBz8xEvVsB+W48=;
        b=EugQExxE7yXC26Ufk8jNym3DvfFqTyvpmo5mHoIne2a9opyu0D1VnA1ApJ6zvTvh70
         ut0FPNVyCUFn3xQafS1m3eP8SVWHPX0bZr4mibDWiubDBwvgVk7Kx1/t+K1dcXCxdzep
         L5yWYnt7Torc7AzEZZfaTIywRoYHvNSwEYPD+XbuJFG46jXP2O0gVWsDM7exRoZPCWlf
         54B8vBDr+No8t9EOyXD0Tz2TwaY04Mo5hPZyLRi9w9tPIXUMdH3e6nY/JSSZWXzab9qN
         sGtsnJRg2kFVbHQTlh14IqLY3CEOONanbkTYFK0b4XexHa9eQNH9CI+cqkJM/1jlakZL
         sXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753658040; x=1754262840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UuRwDLo2z1zF0ZI+zOBq6CzyaD7vIeBz8xEvVsB+W48=;
        b=gCErQIwsetWg8fJ0LgYznbl+nW7QvWVBpcACmFbB2xQkO1i1zpC5t0UtOgp1rHGPfy
         nEzhVm1P9Q5POXyWyDSS6M9m2FLefsEisNePZYDq906+IeD0THpk5PP1vNX5Slu29OOM
         4vBXTVniR4ytDaGpxWXQr/dt5UoXobcr9M9LUdJlhIIlN56PT/5GKhYm2zgOgEWUoI5v
         58141qRkleoUgjYzjbYiV0uqlr53BQuQ4RqDg18kxTcPxeV+YBRpwbMzThg4rispetPP
         ZnBhUyFQvh+CtyZblGHlyskUzVUDpwSWSxHsT8H+lAIt0U3J2kDiUTR1UqzVqEBFInDP
         rhoA==
X-Forwarded-Encrypted: i=1; AJvYcCWHt9Bgh8mu6qyueHMizBQfCUramTx9m9qj+U8Qc7cjNEKAaagM9PthZbJq0X+0pBlyEl+/dec=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZVH5HTPbouDPvU2zPq9k934NHDG6xuqNpRSaf4zGKmfdsTv6u
	kRKorjmJpnKunDfymgb9NF4t4sVZ5+b9pmw34/AFE+/jpnt+tZIYqP7yyeFBNIrmT7eQo7Q4uzo
	1c79NVrhlcxPunn5tKOT81laLM0n4YEWINJo8
X-Gm-Gg: ASbGncs23gGuRKEtdSvoOhYDrWpwYH+nqZ4OvivKpl10+ID6aFgrzOZivDRURHWnh6t
	mFXjzq8XrBJhHHEU432DNPIhhaX4mzqmGuXv1qodHBud5KHvkbuDVDPzFOg8m8ZLIqTURyrMirX
	7cPTSu3V4HfmHtFfYLw8CBdA7qombu46/PAx7zFixae59nWqpKM+YzbfhHpoJ2p5PEJEY9FqE4v
	ZmcAseQG9vjFy8Zdw==
X-Google-Smtp-Source: AGHT+IFOwTIpbhK1VM83TEOhnCoCZ1jf/SzDLtGhmkzK9qJZKTwNEvG/DTWwU0FR41jsSpBmJRl4XHbzf4VupLYc+oE=
X-Received: by 2002:a05:6e02:310d:b0:3e2:c574:ab80 with SMTP id
 e9e14a558f8ab-3e3c52c7e01mr191025975ab.12.1753658039661; Sun, 27 Jul 2025
 16:13:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250726070356.58183-1-kerneljasonxing@gmail.com>
 <a8eba276-afbf-456c-943d-36144877cfc0@molgen.mpg.de> <CAL+tcoD3zwiWsrqDQp1uhegiiFnYs8jcpFVTpuacZ_c6y9-X+Q@mail.gmail.com>
 <20250727135455.GW1367887@horms.kernel.org> <CAL+tcoBUKmt5mCq4coLkbqT5Ehb+V6NFDcjOErg_8AYHG4fgcg@mail.gmail.com>
 <20250727144727.GY1367887@horms.kernel.org>
In-Reply-To: <20250727144727.GY1367887@horms.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 28 Jul 2025 07:13:23 +0800
X-Gm-Features: Ac12FXz3BOm5n7lfmtGuhafWlO9R5LzD5zM-dI26z2VahlnOh25yPHuFuHvB8tQ
Message-ID: <CAL+tcoCsB_Kfm5MOLcqB8vYQJ4_Lds-yZQ9RyoVVanb_eJ3scA@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH v2 iwl-net] ixgbe: xsk: resolve the
 negative overflow of budget in ixgbe_xmit_zc
To: Simon Horman <horms@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, anthony.l.nguyen@intel.com, 
	przemyslaw.kitszel@intel.com, larysa.zaremba@intel.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 27, 2025 at 10:47=E2=80=AFPM Simon Horman <horms@kernel.org> wr=
ote:
>
> On Sun, Jul 27, 2025 at 10:16:10PM +0800, Jason Xing wrote:
> > Hi Simon,
> >
> > On Sun, Jul 27, 2025 at 9:55=E2=80=AFPM Simon Horman <horms@kernel.org>=
 wrote:
> > >
> > > On Sun, Jul 27, 2025 at 06:06:55PM +0800, Jason Xing wrote:
> > > > Hi Paul,
> > > >
> > > > On Sun, Jul 27, 2025 at 4:36=E2=80=AFPM Paul Menzel <pmenzel@molgen=
.mpg.de> wrote:
> > > > >
> > > > > Dear Jason,
> > > > >
> > > > >
> > > > > Thank you for the improved version.
> > > > >
> > > > > Am 26.07.25 um 09:03 schrieb Jason Xing:
> > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > >
> > > > > > Resolve the budget negative overflow which leads to returning t=
rue in
> > > > > > ixgbe_xmit_zc even when the budget of descs are thoroughly cons=
umed.
> > > > > >
> > > > > > Before this patch, when the budget is decreased to zero and fin=
ishes
> > > > > > sending the last allowed desc in ixgbe_xmit_zc, it will always =
turn back
> > > > > > and enter into the while() statement to see if it should keep p=
rocessing
> > > > > > packets, but in the meantime it unexpectedly decreases the valu=
e again to
> > > > > > 'unsigned int (0--)', namely, UINT_MAX. Finally, the ixgbe_xmit=
_zc returns
> > > > > > true, showing 'we complete cleaning the budget'. That also mean=
s
> > > > > > 'clean_complete =3D true' in ixgbe_poll.
> > > > > >
> > > > > > The true theory behind this is if that budget number of descs a=
re consumed,
> > > > > > it implies that we might have more descs to be done. So we shou=
ld return
> > > > > > false in ixgbe_xmit_zc to tell napi poll to find another chance=
 to start
> > > > > > polling to handle the rest of descs. On the contrary, returning=
 true here
> > > > > > means job done and we know we finish all the possible descs thi=
s time and
> > > > > > we don't intend to start a new napi poll.
> > > > > >
> > > > > > It is apparently against our expectations. Please also see how
> > > > > > ixgbe_clean_tx_irq() handles the problem: it uses do..while() s=
tatement
> > > > > > to make sure the budget can be decreased to zero at most and th=
e negative
> > > > > > overflow never happens.
> > > > > >
> > > > > > The patch adds 'likely' because we rarely would not hit the loo=
p codition
> > > > > > since the standard budget is 256.
> > > > > >
> > > > > > Fixes: 8221c5eba8c1 ("ixgbe: add AF_XDP zero-copy Tx support")
> > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > > > > ---
> > > > > > Link: https://lore.kernel.org/all/20250720091123.474-3-kernelja=
sonxing@gmail.com/
> > > > > > 1. use 'negative overflow' instead of 'underflow' (Willem)
> > > > > > 2. add reviewed-by tag (Larysa)
> > > > > > 3. target iwl-net branch (Larysa)
> > > > > > 4. add the reason why the patch adds likely() (Larysa)
> > > > > > ---
> > > > > >   drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 4 +++-
> > > > > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/dri=
vers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> > > > > > index ac58964b2f08..7b941505a9d0 100644
> > > > > > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> > > > > > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> > > > > > @@ -398,7 +398,7 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring=
 *xdp_ring, unsigned int budget)
> > > > > >       dma_addr_t dma;
> > > > > >       u32 cmd_type;
> > > > > >
> > > > > > -     while (budget-- > 0) {
> > > > > > +     while (likely(budget)) {
> > > > > >               if (unlikely(!ixgbe_desc_unused(xdp_ring))) {
> > > > > >                       work_done =3D false;
> > > > > >                       break;
> > > > > > @@ -433,6 +433,8 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring=
 *xdp_ring, unsigned int budget)
> > > > > >               xdp_ring->next_to_use++;
> > > > > >               if (xdp_ring->next_to_use =3D=3D xdp_ring->count)
> > > > > >                       xdp_ring->next_to_use =3D 0;
> > > > > > +
> > > > > > +             budget--;
> > > > > >       }
> > > > > >
> > > > > >       if (tx_desc) {
> > > > >
> > > > > Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > > > >
> > > > > Is this just the smallest fix, and the rewrite to the more idioma=
tic for
> > > > > loop going to be done in a follow-up?
> > > >
> > > > Thanks for the review. But I'm not that sure if it's worth a follow=
-up
> > > > patch. Or if anyone else also expects to see a 'for loop' version, =
I
> > > > can send a V3 patch then. I have no strong opinion either way.
> > >
> > > I think we have iterated over this enough (pun intended).
> >
> > Hhh, interesting.
> >
> > > If this patch is correct then lets stick with this approach.
> >
> > No problem. Tomorrow I will send the 'for loop' version :)
>
> I meant, I think the while loop is fine.
> But anything that is correct is fine by me :)

Okay, great, then no more updates will be made unless other reviewers
have opinions :)

Thanks,
Jason

