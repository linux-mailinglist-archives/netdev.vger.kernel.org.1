Return-Path: <netdev+bounces-204301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DD9AFA00C
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 14:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7425D1BC6F34
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 12:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6858C2550C2;
	Sat,  5 Jul 2025 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NO97l4Uh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B98252287;
	Sat,  5 Jul 2025 12:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751718044; cv=none; b=fhFZNxG74E6CgoHZHyjOntMStOjEkb35Ohli/xah5g14WALJU6XnFizxJOM1QhfcFotKt137bqFrG0YnYduxnkHCtqHu38B18B0pEwX+gJJWvlnLDEbd55h/tHeiUhqj0iuOV9u5mK7Hsq/bIfHAEP2ld2yOk63WQhgK/G7+tKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751718044; c=relaxed/simple;
	bh=w6JVrjNC7s+w46VT5qoV9Am1SjT66OpW5xDi+rFdRiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n8uEW/Pq64xHI2Finazd41njOmJrDvrlQzqvtoO6Evp7s7npXYVgisDct7wvW2/XukGgO2GpYX4J6sXuecbPaHKVYZdlEhlVSRjqLJhGhw/xNS2mUt70f+ibbZh2t6GHc0Ocb/hhqgGt7NwZY8fwAgOlrTJBLzSRmh5qGwzbXz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NO97l4Uh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B691DC4AF09;
	Sat,  5 Jul 2025 12:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751718043;
	bh=w6JVrjNC7s+w46VT5qoV9Am1SjT66OpW5xDi+rFdRiw=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=NO97l4Uh1TnQv0IgibQlK8jSxdy5+saaJFnqpoZJ32HXznZja1vuRpy6IEPbvBFjn
	 U9ZDGiwSWzANC3fWbivFHWhkM9K2BrjwbNV6Lf+0PmbSRMSrPyZ8ZNdRL6pCWZnvJ6
	 3I6skH+H3KsDvrEFB1VYPUU5v8nQDvn1vTUsZ/96mjDKVuanBfyzoU2bB3XD6felBG
	 ksweZSvZdDnorhAx4dzGBd6rWikZ07JTWcl4q0ueZeSjKIGqgppB6oMFevOQeU2CbZ
	 YCYMZpVTcqVfDCZQQQ9JlQs4R4kkCWpKuI634EhdyLXGu83HPKjWbs4gCXuNyC1bMj
	 5Dz37HNSncqpA==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32b595891d2so13263011fa.2;
        Sat, 05 Jul 2025 05:20:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUeEeP32SsDiw/D2SS6KMqXdQEc812V/f/93NV8o5QQmYEEG67VOFOZ7qHyNB0nrezjy6i5qGiArlpv@vger.kernel.org, AJvYcCXReICa/2hLimgtimablo1Vm8Lk5Sai1PML7g6GfiR+Znwszx9/S7cXa76LPSIrC2iHgvhv0Hrb@vger.kernel.org
X-Gm-Message-State: AOJu0Yzif8sjxx/37mrWjc3is2ew1ZAYwOpod9r338kNLWEzN6atSGyV
	LlwGnX+yyugd2PG1VLKenjjQw2ka2Q9f1+Ycff6sfVI3+i3kzhAGHOajRtXdYFVtHqIS4eq6q1v
	JwQiAf6YVkL5GfWn3UeaVd4117GGnMGE=
X-Google-Smtp-Source: AGHT+IE2FeBYZ8ZmnNW0SV5XaswcVwlOSGE5JRdJuwk2CAsSkNvjgDvq3feTe9kdVd6rU22ciEC8vE3JOGVj9L4sHqY=
X-Received: by 2002:a2e:ae1c:0:b0:32a:74db:f3c1 with SMTP id
 38308e7fff4ca-32f19ad68d4mr4847691fa.24.1751718042043; Sat, 05 Jul 2025
 05:20:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250628054438.2864220-1-wens@kernel.org> <20250705083600.2916bf0c@minigeek.lan>
In-Reply-To: <20250705083600.2916bf0c@minigeek.lan>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Sat, 5 Jul 2025 21:20:29 +0900
X-Gmail-Original-Message-ID: <CAGb2v64My=A_Jw+CBCsqno3SsSSTtBFKXOrgLv+Nyq_z5oeYBg@mail.gmail.com>
X-Gm-Features: Ac12FXyj5gh1iUI7aiMezVsM5cn9-cQcjwImIe4vvpZrS6Hd_ny1T0St79tYcpI
Message-ID: <CAGb2v64My=A_Jw+CBCsqno3SsSSTtBFKXOrgLv+Nyq_z5oeYBg@mail.gmail.com>
Subject: Re: [PATCH net 0/2] allwinner: a523: Rename emac0 to gmac0
To: Andre Przywara <andre.przywara@arm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 5, 2025 at 4:37=E2=80=AFPM Andre Przywara <andre.przywara@arm.c=
om> wrote:
>
> On Sat, 28 Jun 2025 13:44:36 +0800
> Chen-Yu Tsai <wens@kernel.org> wrote:
>
> Hi,
>
> > From: Chen-Yu Tsai <wens@csie.org>
> >
> > Hi folks,
> >
> > This small series aims to align the name of the first ethernet
> > controller found on the Allwinner A523 SoC family with the name
> > found in the datasheets. It renames the compatible string and
> > any other references from "emac0" to "gmac0".
>
> To be honest I am not a big fan of those cosmetic renames when it
> touches DT files. It seems to not break compatibility in this case,
> since we don't use the specific compatible string, but leaves a bitter
> taste anyway. Also I pick DT patches out of -rc releases for U-Boot,
> and did so internally already, so it's not without churns.

I'd say that new stuff shouldn't really be considered stable until
it is actually released, hence why I wanted to get this series merged
now. Picking from an -rc release is a tradeoff of getting new stuff
faster vs having something changed or reverted during the -rc process.
I'm sorry that it went the other way this time.

> So is this really necessary, and what is the purpose of this patch?

It's really about aligning the names used throughout the kernel with
the ones seen in the datasheet.

> I am fine with using GMAC for the GMAC200 part in the SoC, but the A64,
> H6, H616, A133 all use the same IP - as the fallback compatible proves -
> and they call it all EMAC.

There's also an EMAC in the A10 and A20 that only does up to 100 Mbps,
and there's no lineage there. Also, not all datasheets for SoCs with
this gigabit-capable EMAC call it the EMAC. Off the top of my head, I
believe the R40 calls it the GMAC. And the R40's compatible string
in this binding even uses the string "gmac".

So it's really whatever Allwinner wants to call it. I would rather have
the names follow the datasheet than us making some scheme up. We just
have to remember that this funky gigabit-capable Ethernet controller
is this piece of hardware.

Hope that explains things.

Thanks
ChenYu

> That's not a NAK, but just wanted to bring this up.
>
> Cheers,
> Andre.
>
> > When support of the hardware was introduced, the name chosen was
> > "EMAC", which followed previous generations. However the datasheets
> > use the name "GMAC" instead, likely because there is another "GMAC"
> > based on a newer DWMAC IP.
> >
> > The first patch fixes the compatible string entry in the device tree
> > binding.
> >
> > The second patch fixes all references in the existing device trees.
> >
> > Since this was introduced in v6.16-rc1, I hope to land this for v6.16
> > as well.
> >
> > There's a small conflict in patch one around the patch context with
> >
> >     dt-bindings: net: sun8i-emac: Add A100 EMAC compatible
> >
> > that just landed in net-next today. I will leave this patch to the net
> > mainainers to merge to avoid making a bigger mess. Once that is landed
> > I will merge the second patch through the sunxi tree.
> >
> >
> > Thanks
> > ChenYu
> >
> >
> > Chen-Yu Tsai (2):
> >   dt-bindings: net: sun8i-emac: Rename A523 EMAC0 to GMAC0
> >   arm64: dts: allwinner: a523: Rename emac0 to gmac0
> >
> >  .../devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml  | 2 +-
> >  arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi              | 6 +++---
> >  arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts     | 4 ++--
> >  arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts     | 4 ++--
> >  4 files changed, 8 insertions(+), 8 deletions(-)
> >
>

