Return-Path: <netdev+bounces-210369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A397B12F26
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 12:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C73AE3A779D
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 10:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D571DDC23;
	Sun, 27 Jul 2025 10:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpxeWy53"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B852A1D7E26
	for <netdev@vger.kernel.org>; Sun, 27 Jul 2025 10:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753610854; cv=none; b=bF+LpwAoUfmcPB9pyvcS4mtC7hQxMsubeypB15I1h9KYZFyTelSkALy7nDX/VQEFzifTV8UOmh3CDgTQKyzz3uXXglI0Wll4X42DH+Uw7CzPdmu0NYF5WxKA8suEJaSnkMDHMQ/W4sBJ1QKLsbWsnRvFYHUgDHsYRhb0opnTQ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753610854; c=relaxed/simple;
	bh=pFea9iNoje0ep41wBw3DFfpH2S2fkEd+o4R6enW5y/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gO6vJopH9s8McdNmcnEOEOo9tSbs7/vcAJ2SzC0ZI7aApDvsArmPSTsTc+yX63OYo18nOYRm+VWvI/G/JrIG/FfeXduWgBzJ3UUeWnojDDe3bfMJKPsM4rNdSmPI5UD+eQbgWtZQHw8+BLR439Ld0i0Y+YVHi1+yVnWY1x5ifOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpxeWy53; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3df303e45d3so10732475ab.0
        for <netdev@vger.kernel.org>; Sun, 27 Jul 2025 03:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753610852; x=1754215652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3o0Sqj440gi2/GezB0eJZOv7l8bHZyW+Oo9D6FQcF3g=;
        b=CpxeWy53HpG6TWkb/kj+0VLwBzEVHYIjuxv5OvJoe3NuHcwj7+wvlZ6Qmm9ZJs9AMl
         VeLGKicwWID+gaXYDaJKQ/LLQuN5ZGaYPBbHOLX9HpDPTtBjcBgfQk5cDpTKWEjP7pXn
         Zq1Zg47RN4PXanRpJgKRa4vf4KcBkBmFJjn3GP9YpSfxaEkk+QcBJQzqtdlLus5ZGih9
         GugfysiJ8/awdC17hcAbO3E4E7uWpkEdKQMagHoDDk0FIoZgjwGNhbrxe4ZNMav4YAE6
         pC0efhIaswm2+sSxfRdHX+9CQzcxRrQAisLYuvug7GypOh0HiVeSgcxVFHCkb6fK1RfB
         U7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753610852; x=1754215652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3o0Sqj440gi2/GezB0eJZOv7l8bHZyW+Oo9D6FQcF3g=;
        b=R6K1YRnbefqbzVLt9lBFqdoCei0F/CpK7vPXNBYMgpgo/A6AL5oySY5IKOWv31NYpW
         njChCyrlS1wfqwuOOIqqSCuSJh+wa6wR8uomXo4o9sLj8uAhnLUpQ2P5FBe7IMl06w8G
         W2dO00x7rghyRMeyN3koZJU+NlJ37hgpHvtLLBWhl74CL5poFLllXiMjdPIQ042MVKZS
         CleDogz79tJAe47IToLHDRQlRsPEfq13YNt50iIRfMSyOoX7ZMfgVENJBSuw5xIASLay
         pc6IFSD4nheGyoOehlfaC2yb7hP2ZL6Cvo/Ew/GOspNZz/JA23EW9oZ5VBXEETskhVWH
         HLKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoYUOiCMgsK4rTH6bdfBwmHD6XgZ7B1uJEPCYDuiUB/vSEVT+c2gcCMJdoV2FKrQ7/BxYl+ck=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhZ/ii1B0EcQaR+DtkrHOOMOEj4ZWs6GI+7FhpsJMqiqAN7Tq7
	nF7GfG6ve3ldY4C/jR7D0uz8W4Rau0QA24RgLIBGdJv+TYcnCfXdNVSmiR/JCZKQJ/Dx12RV4BY
	2yVAdFWnVsdxD5Dp2nXMjPul03Yen3eo=
X-Gm-Gg: ASbGncvdM1yrRJMAY2A6TjNmvthLew2ipERs4yC0lTTojtH1UzTEYryICAbjSbis2QB
	Luv2jrklxZRnbYvVN0DqppQzxDG73gwTaq52iHD/7EjJmwVT/QgeqFjI90wFgmYk8AMP8FbM5oM
	yQ0965CbuCAA4I0PshA1w0IgSizr4uttmzzPat8kSSpFajOVP+EWwB9me5wVfQRcq/krgoIFoex
	BcmLnM=
X-Google-Smtp-Source: AGHT+IHgKC5ysJrh0wyUH20C38x4NE6A2eti66eOfzvGtkqyLUvJA+CsWXYUnI1ycQna3TJoXe5pgZm5qgKInPH8Ae4=
X-Received: by 2002:a05:6e02:1a48:b0:3e3:d5d2:23e4 with SMTP id
 e9e14a558f8ab-3e3d5d2256amr30618145ab.13.1753610851669; Sun, 27 Jul 2025
 03:07:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250726070356.58183-1-kerneljasonxing@gmail.com> <a8eba276-afbf-456c-943d-36144877cfc0@molgen.mpg.de>
In-Reply-To: <a8eba276-afbf-456c-943d-36144877cfc0@molgen.mpg.de>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 27 Jul 2025 18:06:55 +0800
X-Gm-Features: Ac12FXwC0dhsVaY9nIUU9nTShpWBlOwOboRlfBwg3Z2SewapZQs7eBk9YNeAvUc
Message-ID: <CAL+tcoD3zwiWsrqDQp1uhegiiFnYs8jcpFVTpuacZ_c6y9-X+Q@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH v2 iwl-net] ixgbe: xsk: resolve the
 negative overflow of budget in ixgbe_xmit_zc
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	larysa.zaremba@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org, 
	maciej.fijalkowski@intel.com, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Sun, Jul 27, 2025 at 4:36=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> Dear Jason,
>
>
> Thank you for the improved version.
>
> Am 26.07.25 um 09:03 schrieb Jason Xing:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Resolve the budget negative overflow which leads to returning true in
> > ixgbe_xmit_zc even when the budget of descs are thoroughly consumed.
> >
> > Before this patch, when the budget is decreased to zero and finishes
> > sending the last allowed desc in ixgbe_xmit_zc, it will always turn bac=
k
> > and enter into the while() statement to see if it should keep processin=
g
> > packets, but in the meantime it unexpectedly decreases the value again =
to
> > 'unsigned int (0--)', namely, UINT_MAX. Finally, the ixgbe_xmit_zc retu=
rns
> > true, showing 'we complete cleaning the budget'. That also means
> > 'clean_complete =3D true' in ixgbe_poll.
> >
> > The true theory behind this is if that budget number of descs are consu=
med,
> > it implies that we might have more descs to be done. So we should retur=
n
> > false in ixgbe_xmit_zc to tell napi poll to find another chance to star=
t
> > polling to handle the rest of descs. On the contrary, returning true he=
re
> > means job done and we know we finish all the possible descs this time a=
nd
> > we don't intend to start a new napi poll.
> >
> > It is apparently against our expectations. Please also see how
> > ixgbe_clean_tx_irq() handles the problem: it uses do..while() statement
> > to make sure the budget can be decreased to zero at most and the negati=
ve
> > overflow never happens.
> >
> > The patch adds 'likely' because we rarely would not hit the loop coditi=
on
> > since the standard budget is 256.
> >
> > Fixes: 8221c5eba8c1 ("ixgbe: add AF_XDP zero-copy Tx support")
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > ---
> > Link: https://lore.kernel.org/all/20250720091123.474-3-kerneljasonxing@=
gmail.com/
> > 1. use 'negative overflow' instead of 'underflow' (Willem)
> > 2. add reviewed-by tag (Larysa)
> > 3. target iwl-net branch (Larysa)
> > 4. add the reason why the patch adds likely() (Larysa)
> > ---
> >   drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net=
/ethernet/intel/ixgbe/ixgbe_xsk.c
> > index ac58964b2f08..7b941505a9d0 100644
> > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> > @@ -398,7 +398,7 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ri=
ng, unsigned int budget)
> >       dma_addr_t dma;
> >       u32 cmd_type;
> >
> > -     while (budget-- > 0) {
> > +     while (likely(budget)) {
> >               if (unlikely(!ixgbe_desc_unused(xdp_ring))) {
> >                       work_done =3D false;
> >                       break;
> > @@ -433,6 +433,8 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ri=
ng, unsigned int budget)
> >               xdp_ring->next_to_use++;
> >               if (xdp_ring->next_to_use =3D=3D xdp_ring->count)
> >                       xdp_ring->next_to_use =3D 0;
> > +
> > +             budget--;
> >       }
> >
> >       if (tx_desc) {
>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>
> Is this just the smallest fix, and the rewrite to the more idiomatic for
> loop going to be done in a follow-up?

Thanks for the review. But I'm not that sure if it's worth a follow-up
patch. Or if anyone else also expects to see a 'for loop' version, I
can send a V3 patch then. I have no strong opinion either way.

Thanks,
Jason

