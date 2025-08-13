Return-Path: <netdev+bounces-213320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4280B248BD
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 13:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76D7D1AA8C4D
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 11:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF67A2F7463;
	Wed, 13 Aug 2025 11:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jngcdhzF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029842F83AA
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 11:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755085504; cv=none; b=uFKx/k4q1WXHFYvKs5Vd4XhctWKZIdNo3eOpcrJ0iJ6S5cwVNXKkAoUjUMZP1X0a56Ahv+bc+yfg1bkWWV2z/rBJrUre/iIpW8gQwIe1lrKhw7CqvtvUiG2EpT1/OUAlCOSILW3Ux7mZYt7CpfvQoP/fiJcAnn5rLmLxQ2VOEM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755085504; c=relaxed/simple;
	bh=GxXBufJbulJ1NgpI9raFhOC66rCuwp9ukrV2LbwI/is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OWikYRs7xjRCoMFNz19uhoI1scTrfRvrSEOf8+fV33eiU8pejZCWF5Hc0Vnhcg8Ck4yCIjnFBvc0+pzIkCAqKmBFxnwcShgkzjoh6tWa3u2XFGZ+KnYZb6xEvSAP0hYRKFiddoMQVJrfFiHAk6KZldwKpNcilULpd2I1Uci5CSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jngcdhzF; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-88109d54abdso231236539f.1
        for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 04:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755085502; x=1755690302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUhWu7vD3crqHUMbzM2VV1c4jy08jvkD/8PH3CnbVQQ=;
        b=jngcdhzFraFxyfi6Sg2D0vrENSsh8oOYUfudO+tm41kEUzxa/KHkx4XA/KsOhZFlTP
         wDxDJQbNVlZfvIKWssj6amgjqrYXMbTByjn6pClYAYa2JlkiRh75e9HuefFS/OoZLBDs
         Ii55KAYFD6kAJneDIa6JZxjaOPtszVQYHoXjFwwdfaILAxNibHfHBZ7DDJxuydpOBXFH
         t2RVFqCe5tzojQy5QJs5WlSJ3MAL/NO0/XYHBpwsw0GKU4YRO9bOiBH33bdMuZZfzULZ
         ugBJ54HNX5gafwkW8kHakegMgW3CmBL0DsIVLS1lDqdtdZwUBc6shwgykBTV2eNN0pMh
         54hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755085502; x=1755690302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUhWu7vD3crqHUMbzM2VV1c4jy08jvkD/8PH3CnbVQQ=;
        b=meaNdHVvwZ7wHEL0o0H4kYJQi9M95KEom/chhjZNZIlMEO8ZE31hTBcaU1QCBrck+u
         gxQcYjHRMQo1u5Byj+UI3gyut06UDNhmJP0y0wzahVj5NcLLvx9TGxl37PDyLCW40F1l
         ucLcTrhSxv02PFCbTyhQkKi3igYV4u3EA8VU6Hdhfo8zDsh7EmzycFHn+ewG7OdvCc9w
         4DVno2+CcVVZXwiabVC2U0BarvrpVrxvfUxMs1rqOnsoRHCjvnXr0HH0aDESpvhoOH9Y
         Su+9vuuMcMWarkPOvF8Qn7nBKYfoQF8yGzdnAVFx06bZJ9Usoi3WX7UsmASWMEluM++y
         FoCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHoi0gq4Lj5cY0X00cqnIbJvNnPMOipMviWKdUP52prfQQO3oeCqvvuUcu9su2Iw59wob2Ff4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgs26lm8QaGVdiLewc0S/VzPQ23vldubGbJnoRXTFJYLUS8cHH
	AE5ACmaOVmg+DVz2dQtvoW1fuSWbIaf3ZcR9Oo0pYWiCZA1sUA3MTuyG6HsZ9uU3dqBS1lUfJB/
	iO/2Eu4OEu4pRx/AgUPckbdOK+Q4u3AY=
X-Gm-Gg: ASbGncvFB8dwnsHrCbzBIzcVOk3TwBsPgzo12IJ6a4zhfj8e5YhbhdVzqWixjVVO0ZB
	UmD7E36W57qe9qP3vgh2bbjFNxaUw1xABJyEjGw+oI9WvYT2+wxYqeq4iuidikR2zGxg3PvHs7B
	lyWzA0utbwxjq8VhAtYKOU9SeqKoNs3m5Gjj2fFxz3jatPRCXTVY4xVpFzsqeB9hXXrAy2TTN/b
	RR7sZk=
X-Google-Smtp-Source: AGHT+IEMleh6MlTZE63lr0ZMsSsNEyZkVbztB1HEuYFg2Vh/3kj9JVLr26YLuI07w46MyxabiEU8JlG8pYjoegndrhk=
X-Received: by 2002:a05:6602:6d05:b0:861:6f49:626 with SMTP id
 ca18e2360f4ac-88429657518mr501915039f.6.1755085501945; Wed, 13 Aug 2025
 04:45:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812075504.60498-1-kerneljasonxing@gmail.com>
 <20250812075504.60498-3-kerneljasonxing@gmail.com> <IA3PR11MB89869A1D876059D6EBCB64E0E52AA@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB89869A1D876059D6EBCB64E0E52AA@IA3PR11MB8986.namprd11.prod.outlook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 13 Aug 2025 19:44:25 +0800
X-Gm-Features: Ac12FXxtntZrEczNCaQP-bA796Yt2hGBzgWpRgmXZA45z6JGpss5pVtvJfdGWqQ
Message-ID: <CAL+tcoDHgcr+fapRxVZMoefi+PujENenYSr+e-Dd=Tb=jJP03w@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2 2/3] ixgbe: xsk: use
 ixgbe_desc_unused as the budget in ixgbe_xmit_zc
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"horms@kernel.org" <horms@kernel.org>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "sdf@fomichev.me" <sdf@fomichev.me>, 
	"Zaremba, Larysa" <larysa.zaremba@intel.com>, 
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 7:14=E2=80=AFPM Loktionov, Aleksandr
<aleksandr.loktionov@intel.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Jason Xing
> > Sent: Tuesday, August 12, 2025 9:55 AM
> > To: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > pabeni@redhat.com; horms@kernel.org; andrew+netdev@lunn.ch; Nguyen,
> > Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> > <przemyslaw.kitszel@intel.com>; sdf@fomichev.me; Zaremba, Larysa
> > <larysa.zaremba@intel.com>; Fijalkowski, Maciej
> > <maciej.fijalkowski@intel.com>
> > Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Jason
> > Xing <kernelxing@tencent.com>
> > Subject: [Intel-wired-lan] [PATCH iwl-net v2 2/3] ixgbe: xsk: use
> > ixgbe_desc_unused as the budget in ixgbe_xmit_zc
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > - Adjust ixgbe_desc_unused as the budget value.
> > - Avoid checking desc_unused over and over again in the loop.
> >
> > The patch makes ixgbe follow i40e driver that was done in commit
> > 1fd972ebe523 ("i40e: move check of full Tx ring to outside of send
> > loop").
> > [ Note that the above i40e patch has problem when
> > ixgbe_desc_unused(tx_ring)
> > returns zero. The zero value as the budget value means we don't have
> > any
> > possible descs to be sent, so it should return true instead to tell
> > the
> > napi poll not to launch another poll to handle tx packets. Even
> > though
> > that patch behaves correctly by returning true in this case, it
> > happens
> > because of the unexpected underflow of the budget. Taking the
> > current
> > version of i40e_xmit_zc() as an example, it returns true as
> > expected. ]
> > Hence, this patch adds a standalone if statement of zero budget in
> > front
> > of ixgbe_xmit_zc() as explained before.
> >
> > Use ixgbe_desc_unused to replace the original fixed budget with the
> > number
> > of available slots in the Tx ring. It can gain some performance.
> You state =E2=80=9CIt can gain some performance=E2=80=9D but provide no n=
umbers
> (before/after metrics, hardware, workload, methodology).
> The https://www.kernel.org/doc/html/latest/process/submitting-patches.htm=
l
> ask to quantify optimizations with measurements and discuss trade=E2=80=
=91offs.

Based on my understanding of performance, there are two kinds: 1) it
can save some cycles and indeed reduce the time but cannot be easily
observed, 2) it can be directly shown through various tests. The whole
series belongs to the former due to limited tests. We cannot deny the
optimization even though we cannot see it from the numbers but we can
conclude it from the theory.

As the official doc requires us to do so, I will remove all the
related words to avoid further confusion in V3. Thanks for sharing it
with me.

>
> >
> If the change addresses a behavioral bug (e.g., incorrect NAPI completion=
 behavior when budget is zero),
> add Fixes: <sha1> ("commit subject") to help backporting and tracking.

Well, it's not a bugfix. I just pointed out that the i40e patch that
has a bug was overwritten/buried by another patch :)

Thanks,
Jason

>
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> > In this version, I keep it as is (please see the following link)
> > https://lore.kernel.org/intel-wired-
> > lan/CAL+tcoAUW_J62aw3aGBru+0GmaTjoom1qu8Y=3DaiSc9EGU09Nww@mail.gmail.c
> > om/
> > ---
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 13 +++++--------
> >  1 file changed, 5 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> > b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> > index a463c5ac9c7c..f3d3f5c1cdc7 100644
> > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> > @@ -393,17 +393,14 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring
> > *xdp_ring, unsigned int budget)
> >       struct xsk_buff_pool *pool =3D xdp_ring->xsk_pool;
> >       union ixgbe_adv_tx_desc *tx_desc =3D NULL;
> >       struct ixgbe_tx_buffer *tx_bi;
> > -     bool work_done =3D true;
> >       struct xdp_desc desc;
> >       dma_addr_t dma;
> >       u32 cmd_type;
> >
> > -     while (likely(budget)) {
> > -             if (unlikely(!ixgbe_desc_unused(xdp_ring))) {
> > -                     work_done =3D false;
> > -                     break;
> > -             }
> > +     if (!budget)
> > +             return true;
> >
> > +     while (likely(budget)) {
> >               if (!netif_carrier_ok(xdp_ring->netdev))
> >                       break;
> >
> > @@ -442,7 +439,7 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring
> > *xdp_ring, unsigned int budget)
> >               xsk_tx_release(pool);
> >       }
> >
> > -     return !!budget && work_done;
> > +     return !!budget;
> >  }
> >
> >  static void ixgbe_clean_xdp_tx_buffer(struct ixgbe_ring *tx_ring,
> > @@ -505,7 +502,7 @@ bool ixgbe_clean_xdp_tx_irq(struct
> > ixgbe_q_vector *q_vector,
> >       if (xsk_uses_need_wakeup(pool))
> >               xsk_set_tx_need_wakeup(pool);
> >
> > -     return ixgbe_xmit_zc(tx_ring, q_vector->tx.work_limit);
> > +     return ixgbe_xmit_zc(tx_ring, ixgbe_desc_unused(tx_ring));
> >  }
> >
> >  int ixgbe_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
> > --
> > 2.41.3
>

