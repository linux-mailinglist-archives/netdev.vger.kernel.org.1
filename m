Return-Path: <netdev+bounces-204392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4512DAFA526
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 15:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 713227A855C
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 13:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE20214A8B;
	Sun,  6 Jul 2025 13:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H74tGhnO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DAE2E3701;
	Sun,  6 Jul 2025 13:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751807665; cv=none; b=oyxxmBPC/xFAoYIpB+46OaGFm/5Mwk01HuxQXwv0lbMqWAZppIab4QEeUfN5HNuKAWowtd+lurzUqqnbESjiZADRAmRLfPrzItvfWFWEy895P4LweAfz4oVt8TYhUv9LZq+aKhXQWtOE53GwRI8nIutwqAh0HwLUBWoeU1xGT6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751807665; c=relaxed/simple;
	bh=u8xJci6BCA/NPXr2bGUVttu27gcVFr7isab2Lo+Nre0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0VcCat9uPJeXhUBjbUOIEBOkG6zl1C9Bss5nlSrB90P/yb1ZW/4jQ8PnNMAlnPkp1AJEo3nF9DdgM2N+eFHvzl2GkObXAvW6jDpbB8O9VU8bfSN0nGO54ejnmNM4s51NHGE9BgtnVqQCWIc5c/7r3Ff0wR9UOtDV1DGzGeI/+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H74tGhnO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F04BC4CEF4;
	Sun,  6 Jul 2025 13:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751807664;
	bh=u8xJci6BCA/NPXr2bGUVttu27gcVFr7isab2Lo+Nre0=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=H74tGhnOnclNfDF4L3HiqPatu/Ckv4SZwOZieRM9X1HBvT72eGWkjGnmDrv7miyw9
	 /md3SO6VV9wp5un7SLJY585Cu/xC634IOPRqKSenlFAWLasra7D84WocasA5yNAdlD
	 truaLbkyAf1bmoInf5c1WugXZSj9/M49L3VtGnO0G/wlS3W6obpgMsPh1oh5ZBHhLa
	 OVciZG90FoRDiu/0VBG5iGHISg1+KxXT01I0j1NFUAoFVv/Y/X1jlDlCm1VwhNH99F
	 l5V7Z5whmNhUv3QtzTCBJdRKtGTxMvkg62s/rmxA1PI1IvYi/g1Oi0d8wu9E/jWLMx
	 5blPMHji5owrA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55628eaec6cso2112782e87.0;
        Sun, 06 Jul 2025 06:14:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWesOGrBnNtEBaTu+Rgx9QLxBjgSkk6UzfJG6rN2hpqKBwniNO3Jeu39v48FExmG/MEdjpBYJTg@vger.kernel.org, AJvYcCXkrovdX4KjTXTX1cnRxPee/pR0AcEFfOBIEeSzjNDb6RjWw0AGLyctsZi5+NYD4pQ8SWHaJiTe9Ia+@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Nwu2D3nRaBL8sVw9SAomqFQQg/n/QTJvHmByPn+/dElTosDY
	uAaMh405X4q7S75TCUc5NS9D8HCFFBE8tkz1HXeJg9QB7EJGkzVETssk3dry6yj4PsZj/wJ82In
	xDugZ+DAhychPosr1AuYrORydJLbKWsM=
X-Google-Smtp-Source: AGHT+IEzN50658kYdEZu4z11IX1+qj76bRNUj9L9XsGay2m70Sqt76p+ZP6G4FZVEV9964rwYfujWQD+iVC6l49gAsw=
X-Received: by 2002:a05:6512:4027:b0:553:ceed:c859 with SMTP id
 2adb3069b0e04-557e5537687mr1059540e87.21.1751807662868; Sun, 06 Jul 2025
 06:14:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250628054438.2864220-1-wens@kernel.org> <20250705083600.2916bf0c@minigeek.lan>
 <CAGb2v64My=A_Jw+CBCsqno3SsSSTtBFKXOrgLv+Nyq_z5oeYBg@mail.gmail.com>
 <e9c5949d-9ac5-4b33-810d-b716ccce5fe9@lunn.ch> <20250706002223.128ff760@minigeek.lan>
In-Reply-To: <20250706002223.128ff760@minigeek.lan>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Sun, 6 Jul 2025 21:14:09 +0800
X-Gmail-Original-Message-ID: <CAGb2v64vxtAVi3QK3a=mvDz2u+gKQ6XPMN-JB46eEuwfusMG2w@mail.gmail.com>
X-Gm-Features: Ac12FXwracJUFtxrR-geU8AnCt2mihSX7AlHGCMKyxbdZy4UN94qheE6j6Zh998
Message-ID: <CAGb2v64vxtAVi3QK3a=mvDz2u+gKQ6XPMN-JB46eEuwfusMG2w@mail.gmail.com>
Subject: Re: [PATCH net 0/2] allwinner: a523: Rename emac0 to gmac0
To: Andre Przywara <andre.przywara@arm.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 6, 2025 at 7:23=E2=80=AFAM Andre Przywara <andre.przywara@arm.c=
om> wrote:
>
> On Sat, 5 Jul 2025 17:53:17 +0200
> Andrew Lunn <andrew@lunn.ch> wrote:
>
> Hi Andrew,
>
> > > So it's really whatever Allwinner wants to call it. I would rather ha=
ve
> > > the names follow the datasheet than us making some scheme up.
> >
> > Are the datasheets publicly available?
>
> We collect them in the sunxi wiki (see the links below), but just to
> make sure:
> I am not disputing that GMAC is the name mentioned in the A523 manual,
> and would have probably been the right name to use originally - even
> though it's not very consistent, as the same IP is called EMAC in the
> older SoCs' manuals. I am also not against renaming identifiers or even
> (internal) DT labels. But the problem here is that the renaming affects
> the DT compatible string and the pinctrl function name, both of which
> are used as an interface between the devicetree and its users, which is
> not only the Linux kernel, but also U-Boot and other OSes like the BSDs.

I reiterate my position: they are not stable until they actually hit a
release. This provides some time to fix mistakes before they are set in
stone.

> In this particular case we would probably get away with it, because
> it's indeed very early in the development cycle for this SoC, but for
> instance the "emac0" function name is already used in some U-Boot
> patch series on the list:
> https://lore.kernel.org/linux-sunxi/20250323113544.7933-18-andre.przywara=
@arm.com/
>
> If we REALLY need to rename this, it wouldn't be the end of the world,
> but would create some churn on the U-Boot side.
>
> I just wanted to point out that any changes to the DT bindings have
> some impact to other projects, even if they are proposed as a coherent
> series on the Linux side. Hence my question if this is really necessary.

For the compatible string, I can live with having a comment in the binding
stating the name used in the datasheet for reference.

For the pinctrl stuff, which is the contentious bit here, I thought the
whole idea of the newer pinctrl bindings is that the driver uses
"allwinner,pinmux" instead of "function". I think having both being valid
is confusing, and likely to cause conflicts later on. If we're going to
use the hardware register values in the device tree, I'd really like them
to be the only source of truth. The commit message for the binding also
sort of suggests that "allwinner,pinmux" is the part that matters.


ChenYu

> Cheers,
> Andre
>
> https://linux-sunxi.org/A64#Documentation
> https://linux-sunxi.org/H616#Documentation
> https://linux-sunxi.org/A523#Documentation

