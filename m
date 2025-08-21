Return-Path: <netdev+bounces-215604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1A7B2F7BD
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 14:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 522286023EC
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 12:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00A52D3744;
	Thu, 21 Aug 2025 12:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLSUgr4O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466CD311958;
	Thu, 21 Aug 2025 12:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755778794; cv=none; b=qubJwRV0gJ+jXvlfs2VY2RSIvUCB9FfB71VWUjxSGRoPH6ErJ3r9EeSIhibSzIo92OLMzZKOrmWHXS0RD6c1b+/bTPzEHGqdElgngSmSVm/9rMPbIAi+i6t/8DgbHDpAz60GoXl9Z67kfT9EHoVGDeD85hugCzHXK4rG00VkUvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755778794; c=relaxed/simple;
	bh=f4ZXLQraKeUWdE6NkgCXifJOFIulzraXRRO58aCqkrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HouUPkb/w0qz4Kz/nL93fVf3ZcIdn5xhUkikyyh9vcmKs5O0MPy1bPSwzKInoPtIR38/u5VmuI67rPUJu6o7bIoMfEKSmmi6KgffzjLbwChSCZydp/FOP/nsoLYFjjUhXN+rnK19Wj5a5wmSQyKsCVGQJP14PoBI6fl1zqWwCqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLSUgr4O; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-323267b7dfcso890661a91.1;
        Thu, 21 Aug 2025 05:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755778792; x=1756383592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vaKgXrxF6SpHaQWaJmXdkgOltLQX8upg3py3VLODSZA=;
        b=aLSUgr4OHrD1cwP0AkR5aE7hudMmYLad8zTFRr1Vm4DgM6Fe/yrKFPuVKDDYUbneGb
         ILJDi6nL7fbvc+OJJdiEbSEGhFrDaT55tu4A8D2Ide9js/13sX3lE8bmx7C9iNZkekV2
         b5iZjg1Wy1yMrjuEUcv+ritT12Vn4aU8Jk7BIOXo6UC2cL3sopGkks8plZBV43OdKVP5
         9/1TnQ+IQjkjQ8aj9tIMf14OWpXS05KssRAROkmMTTVdQ4r/KdxPNAA8waiDVrDRnHRH
         bKFC96ERm9MsIDsVWPNON+v4OV+pl4p/o9FNs8F8XKd5+yHBnkkUqMnw9jTbHEz0eFne
         u06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755778792; x=1756383592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vaKgXrxF6SpHaQWaJmXdkgOltLQX8upg3py3VLODSZA=;
        b=o4538js1SnWb2P24gC5f8ieDjXK7BodZRNAQkKFjkQjx4wfriA18WSI80ouM+kXtfw
         z4qrYu/iD9hBoytCkgaP3jVDv20FXeKY7OqSXDo5h7cXQsUgTGYeXqZHdVGLK3sWZfC1
         j4adrenvbtmVizOZ9/rfi6gjPvIvzdayCbRjjZTR7lFDGpbKGF018YaTXncwwtLqWmS6
         2c3LBCUNv9KTLjsV+MJW5hj7gEMhUi32xhwdhiwcWCpB0IYSD70fMl3EPCXgBwgK5Cqt
         NUoKaU6H2ze0zdFE1t+HqEHYm7YI1+9keg4Z3Eo4wJY8BYbIxiQreM2TtKjYaFnsmbYA
         4w3g==
X-Forwarded-Encrypted: i=1; AJvYcCVj80m3vQfTZPalBPsTzbzkaW1+0C4004vy1gACCUSICy49C9NvYtTS5L3moG+ykUQxoFphaFyPkBDY@vger.kernel.org, AJvYcCX7UIuyXhbdm4e9vRK8GN9JqsR84qj9NcpEQRijrCmBLyjZG4fGxPHov7sdYNwDcsjm8aaAzSaZt1TjHSeP@vger.kernel.org
X-Gm-Message-State: AOJu0YyeLOkRiDhcY3ITR2aVcefSyxV0NvxCx8YUMWrMRW8jupd6/Ejh
	jRsjCDM1K6jFuRNR+mPcnMq6/Wt8YqFgcaNDZcw09r5CoNXUfv9YkrRx04JcQRInRkkyP6UNXGT
	cjGXD2FDhtmXLmM1U4alw5Lr/WsaaZKY=
X-Gm-Gg: ASbGncshVKhY+ptyQNKLdh1Rkow9FvcGeqKNbwGf17r/dZalrf3aH8Y08zZCM5qor/k
	DykK+iu0J5uN+LPfh/mRHIUq7oluVFGnB4NxUFGkm7qO4ccxQJgUnh7kkCsHvaEiQo/TfXJWaPb
	VdYfHONcrB1rynheUr5H5mhQqpu1MzsXbj4NE66r1qO2LG1lZziOa1FCAHgMuTfe4vgaqj1jhCn
	1TiK6Q0P+/SfZH3oKohrdTODdI+P/NVLSYU6922
X-Google-Smtp-Source: AGHT+IGM50hDPsf/GYBccWoWK+jHNexFKXj+zQEktHP5NeW/ljtqy2Us7gDShggdepMqD20JwQfwNTE8miCEsUg8OiM=
X-Received: by 2002:a17:90b:57c6:b0:321:9366:5865 with SMTP id
 98e67ed59e1d1-324ed15bc0cmr3366389a91.33.1755778792359; Thu, 21 Aug 2025
 05:19:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820075420.1601068-1-mmyangfl@gmail.com> <20250820075420.1601068-4-mmyangfl@gmail.com>
 <aKbZM6oYhIN6cBQb@shell.armlinux.org.uk> <CAAXyoMMGCRZTuhYG0zxTgKdDdgB1brU7BAUiCVR_MheFK-n5Yw@mail.gmail.com>
 <aKbuQ7MCbq1JL9sw@shell.armlinux.org.uk> <aKbxdaDFMe2Fqnxu@shell.armlinux.org.uk>
In-Reply-To: <aKbxdaDFMe2Fqnxu@shell.armlinux.org.uk>
From: Yangfl <mmyangfl@gmail.com>
Date: Thu, 21 Aug 2025 20:19:15 +0800
X-Gm-Features: Ac12FXxbEV7Y8dawuc3P9ut229C1lMCt0Dlom-IYXt2_mPqORfrMZbGZQRXr148
Message-ID: <CAAXyoMPjdL=KHyr6XCZv-ODV9=8r1_1iwRatAziYU2mPyREmuA@mail.gmail.com>
Subject: Re: [net-next v5 3/3] net: dsa: yt921x: Add support for Motorcomm YT921x
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Simon Horman <horms@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 6:14=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Thu, Aug 21, 2025 at 11:00:35AM +0100, Russell King (Oracle) wrote:
> > On Thu, Aug 21, 2025 at 05:25:46PM +0800, Yangfl wrote:
> > > On Thu, Aug 21, 2025 at 4:30=E2=80=AFPM Russell King (Oracle)
> > > <linux@armlinux.org.uk> wrote:
> > > > Someone clearly doesn't believe in reading the documentation before
> > > > writing code. This also hasn't been tested in any way. Sorry, but
> > > > I'm going to put as much effort into this review as you have into
> > > > understanding the phylink API, and thus my review ends here.
> > > >
> > > > NAK.
> > >
> > > Sorry I'm quite new here. I don't understand very clearly why a
> > > different set of calls is involved in dsa_switch_ops, so I referred t=
o
> > > other dsa drivers and made a working driver (at least tested on my
> > > device), but I would appreciate it much if you could point it out in
> > > an earlier version of series.
> >
> > This isn't dsa_switch_ops, but phylink_mac_ops, which are well
> > documented in include/linux/phylink.h. Please read the documentation
> > found in that header file detailing the phylink_mac_ops methods.
> > You'll find a brief overview before the struct, and then in the #if 0
> > section, detailed per-method documentation.
>
> Also, the reason I state that it hasn't been tested is because when
> your mac_config method is invoked, and print debug information which
> includes state->speed and state->duplex, and then go on to use these.
> Phylink's sole call path to mac_config() does this:
>
>         /* Stop drivers incorrectly using these */
>         linkmode_zero(st.lp_advertising);
>         st.speed =3D SPEED_UNKNOWN;
>         st.duplex =3D DUPLEX_UNKNOWN;
>         st.an_complete =3D false;
>         st.link =3D false;
>
>         phylink_dbg(pl,
>                     "%s: mode=3D%s/%s/%s adv=3D%*pb pause=3D%02x\n",
>                     __func__, phylink_an_mode_str(pl->act_link_an_mode),
>                     phy_modes(st.interface),
>                     phy_rate_matching_to_str(st.rate_matching),
>                     __ETHTOOL_LINK_MODE_MASK_NBITS, st.advertising,
>                     st.pause);
>
>         pl->mac_ops->mac_config(pl->config, pl->act_link_an_mode, &st);
>
> and you would've noticed in your debug print that e.g. state->speed and
> state->duplex are both always -1, and thus are not useful. Note also the
> debugging that phylink includes.
>
> Note that no other mac_config() implementations refer to state->speed
> and state->duplex. The only time drivers _write_ to these is in the
> pcs_get_state() method if they support a PCS.
>
> Therefore, I think your code is completely untested.
>

Thanks for your help. I didn't notice that since it accidentally
configures autonegotiation for me. Anyway I'll take a closer look at
relevant apis.

> I'm also concerned about the SMI locking, which looks to me like you
> haven't realised that the MDIO bus layer has locking which guarantees
> that all invocations of the MDIO bus read* and write* methods are
> serialised.

The device takes two sequential u16 MDIO r/w into one op on its
internal 32b regs, so we need to serialise SMI ops to avoid race
conditions. Strictly speaking only locking the target phyaddr is
needed, but I think it won't hurt to lock the MDIO bus as long as I
don't perform busy wait while holding the bus lock.

