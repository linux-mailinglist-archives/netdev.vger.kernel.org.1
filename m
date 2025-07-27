Return-Path: <netdev+bounces-210376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4F4B12FD3
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 16:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 252117AAA87
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 14:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC9178F59;
	Sun, 27 Jul 2025 14:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vbw4cFYi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082E71C84BC
	for <netdev@vger.kernel.org>; Sun, 27 Jul 2025 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753625809; cv=none; b=IdMjVc2LLew3cf2s0zqwI7gd0WpgKmS+0kZWwjFEDlbvI88mB3GzWtEYnkgrNJgVOsZoJVuexXTMZkC+jhyLU7Wzaxlf583o+VL92gqLFtqgxi/ZFQZPf43WfTULbndUHivHB4wNLWqKAldG/VwDlaRau50We89Rc2j++0SAWNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753625809; c=relaxed/simple;
	bh=knlT89uXFuwA520TlDXdVdnGs8qrOT2+nflKTh1bBpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BZABCqSmJVmvsscMTgSYqoQiUpwAmD5zfYckvqKMO2WvUU+zwo4BeTiWNVlViPyb0Xflikyooqsjsrbk2jK0uR/i7z6KWZtdXbyjCbkFscOHE98/6QZSrE2YooK80Aow/qbBs9giPtqsdUkPBHp2WzgOFbp04AxzQ4vhR/8ll/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vbw4cFYi; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3e3d2ad9180so5244685ab.1
        for <netdev@vger.kernel.org>; Sun, 27 Jul 2025 07:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753625807; x=1754230607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1qV5YSbtVjT7o1D4U3/3TyCz9t1aKACYnwaTjXc0bM=;
        b=Vbw4cFYiZsz2rPV5lOJkIgmLaw06aDnEUQNAGvI1yxiAUCMraZj4oZu31+x47Wbz0G
         ZOjG2sRcEvw1yMoMD+YHihoQ0tN7Nr/hvzbH3sL+F6oNelbFfwzMl0YczCNH6cokbwuB
         KgKpqjOhmjuL2in2AIotp2OXKJFcI+2eAkhrsIZxkcxmdT6L7/b7c8pgzzAIAmn9VOOf
         NOVHgKHy6IAaCfm9ohnFBLlOHmHb/oP8DzKQ7KkrHrIxHNARQCvOUhD14C0fZlMn4jE8
         B1L7daieC0D4L2OklI0T5errXHH49nx4MW2s9VfrurzOHO5kV+KIIV95p05tn9gi5fZK
         hkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753625807; x=1754230607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w1qV5YSbtVjT7o1D4U3/3TyCz9t1aKACYnwaTjXc0bM=;
        b=YfH3eBsa8FW/Ohg+AU+jwWldiw0EwhrdTnBWfbET7iahh1+F+yE+NMZmGEDn1kwjK6
         oVep/h0N4y7ycpReZ4m2UT40t0sNSfU8766nYhpuMIPhnzdZaK0moyDFY3O4B7AzxTfT
         qQK8OWVUWNR+8WlBPCFmUgH+uuoP9+rlV78j7gVxwh9A8L8Brv4t56GVN0mTtcc9fkV+
         NPnMEhYDp2t/GtwhFoWrHg25jNan4xhxYeGV8vJmtrQBWrLguxeYgeB6VB2Nsa+z/BRK
         ujqNzv7eg38k3UnIF1ZmHUr1jsg0r4N+jW4K5y75ggyExmlruOvcXO+39H+HzCt1SDZA
         pMbQ==
X-Forwarded-Encrypted: i=1; AJvYcCX67fVhzxHjuoS2Gs8YDTwmlznqhKVP2X2LNtemYbRDVXMpZ9YaGT0ATo+ZletnvXRyyhsDM5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUO60RapMdc24ggYEeydFG6S9A1VwW31PBGaGfENMx/Mm8jjrf
	JlX9TAX7rIFV+U2fQnRZM3rov20cHpRi9c0Rr8VdjlgFh9hT7Lsdi9UZUhyNuA4jM4mcOOvSDfa
	LgUbz9WGJtMYMHqUO2n/yyV83JZom+J4=
X-Gm-Gg: ASbGncuSPp6+cv+pUZChhtAbdHdE/Bwytc7JOLi5nm8V3C/Ap/aDYICQFrziLdtRF0T
	Vd5TXuDjec+n8J9ot+aBJQ3uvuEJzCUB4p0wPsANkLzwlJuCCSE8ewk281K2r9Qswt5zoAGWErK
	lgpFwBNodMO/asmnBBLeace4O+0ldn3zMpcef2A7CPRl/Yi8hY7lhLxwtSUmDIP7umFCXnP/u8W
	wL0ug==
X-Google-Smtp-Source: AGHT+IHNWz7Ze19aP8Qn/NvNkSn04IjDbBR95MDhpBVO3zCWcdGmJDZdvPaefeS/ooBAY70nKCC8LDnwqIZvOkRc07w=
X-Received: by 2002:a05:6e02:440c:20b0:3e3:cc88:f48c with SMTP id
 e9e14a558f8ab-3e3cc88f602mr65847965ab.5.1753625807000; Sun, 27 Jul 2025
 07:16:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250726070356.58183-1-kerneljasonxing@gmail.com>
 <a8eba276-afbf-456c-943d-36144877cfc0@molgen.mpg.de> <CAL+tcoD3zwiWsrqDQp1uhegiiFnYs8jcpFVTpuacZ_c6y9-X+Q@mail.gmail.com>
 <20250727135455.GW1367887@horms.kernel.org>
In-Reply-To: <20250727135455.GW1367887@horms.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 27 Jul 2025 22:16:10 +0800
X-Gm-Features: Ac12FXxBhmNmPowy6FzD5kGh5feEaT6P3fqSupxQKERh9GJapy7ZTo_vXKFwkeU
Message-ID: <CAL+tcoBUKmt5mCq4coLkbqT5Ehb+V6NFDcjOErg_8AYHG4fgcg@mail.gmail.com>
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

Hi Simon,

On Sun, Jul 27, 2025 at 9:55=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Sun, Jul 27, 2025 at 06:06:55PM +0800, Jason Xing wrote:
> > Hi Paul,
> >
> > On Sun, Jul 27, 2025 at 4:36=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg=
.de> wrote:
> > >
> > > Dear Jason,
> > >
> > >
> > > Thank you for the improved version.
> > >
> > > Am 26.07.25 um 09:03 schrieb Jason Xing:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > Resolve the budget negative overflow which leads to returning true =
in
> > > > ixgbe_xmit_zc even when the budget of descs are thoroughly consumed=
.
> > > >
> > > > Before this patch, when the budget is decreased to zero and finishe=
s
> > > > sending the last allowed desc in ixgbe_xmit_zc, it will always turn=
 back
> > > > and enter into the while() statement to see if it should keep proce=
ssing
> > > > packets, but in the meantime it unexpectedly decreases the value ag=
ain to
> > > > 'unsigned int (0--)', namely, UINT_MAX. Finally, the ixgbe_xmit_zc =
returns
> > > > true, showing 'we complete cleaning the budget'. That also means
> > > > 'clean_complete =3D true' in ixgbe_poll.
> > > >
> > > > The true theory behind this is if that budget number of descs are c=
onsumed,
> > > > it implies that we might have more descs to be done. So we should r=
eturn
> > > > false in ixgbe_xmit_zc to tell napi poll to find another chance to =
start
> > > > polling to handle the rest of descs. On the contrary, returning tru=
e here
> > > > means job done and we know we finish all the possible descs this ti=
me and
> > > > we don't intend to start a new napi poll.
> > > >
> > > > It is apparently against our expectations. Please also see how
> > > > ixgbe_clean_tx_irq() handles the problem: it uses do..while() state=
ment
> > > > to make sure the budget can be decreased to zero at most and the ne=
gative
> > > > overflow never happens.
> > > >
> > > > The patch adds 'likely' because we rarely would not hit the loop co=
dition
> > > > since the standard budget is 256.
> > > >
> > > > Fixes: 8221c5eba8c1 ("ixgbe: add AF_XDP zero-copy Tx support")
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > > ---
> > > > Link: https://lore.kernel.org/all/20250720091123.474-3-kerneljasonx=
ing@gmail.com/
> > > > 1. use 'negative overflow' instead of 'underflow' (Willem)
> > > > 2. add reviewed-by tag (Larysa)
> > > > 3. target iwl-net branch (Larysa)
> > > > 4. add the reason why the patch adds likely() (Larysa)
> > > > ---
> > > >   drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 4 +++-
> > > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers=
/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> > > > index ac58964b2f08..7b941505a9d0 100644
> > > > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> > > > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> > > > @@ -398,7 +398,7 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring *xd=
p_ring, unsigned int budget)
> > > >       dma_addr_t dma;
> > > >       u32 cmd_type;
> > > >
> > > > -     while (budget-- > 0) {
> > > > +     while (likely(budget)) {
> > > >               if (unlikely(!ixgbe_desc_unused(xdp_ring))) {
> > > >                       work_done =3D false;
> > > >                       break;
> > > > @@ -433,6 +433,8 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring *xd=
p_ring, unsigned int budget)
> > > >               xdp_ring->next_to_use++;
> > > >               if (xdp_ring->next_to_use =3D=3D xdp_ring->count)
> > > >                       xdp_ring->next_to_use =3D 0;
> > > > +
> > > > +             budget--;
> > > >       }
> > > >
> > > >       if (tx_desc) {
> > >
> > > Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > >
> > > Is this just the smallest fix, and the rewrite to the more idiomatic =
for
> > > loop going to be done in a follow-up?
> >
> > Thanks for the review. But I'm not that sure if it's worth a follow-up
> > patch. Or if anyone else also expects to see a 'for loop' version, I
> > can send a V3 patch then. I have no strong opinion either way.
>
> I think we have iterated over this enough (pun intended).

Hhh, interesting.

> If this patch is correct then lets stick with this approach.

No problem. Tomorrow I will send the 'for loop' version :)

Thanks,
Jason

