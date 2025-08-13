Return-Path: <netdev+bounces-213418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A80B24E9D
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 18:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F68F9A179A
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 15:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828F224291B;
	Wed, 13 Aug 2025 15:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/qMCFrf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FDFC148;
	Wed, 13 Aug 2025 15:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100294; cv=none; b=um/aISNO80biGrDqFffwm4yfGpJZKLClJ0GyrCgBScy/3nHbXHpJL36zXMyPS+iGMiEq0GhcjQByCRVviM52ovoffRTQ6AABLs2BYx+aw1uRcZNSGHCinoIdYjX3S+OAHAXUEnM+kAchLXEzmKVAp4BD7NvX98im1IjDwO27MWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100294; c=relaxed/simple;
	bh=Nned+2OXLAR4zbMBIAOqe5xsNi80BA2aVmJkwOizo/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IKkKMNM92gvEoO3E2qzk6/2aTQEep3zJt5rTwSJ4zOgT8H+kTH8OMqRmtmm1KKMnN5+YxtKdWaGmJka/Y+lz34n6I9enah+wmuqQFi1iyi0Zhd50JobfEZpGH25WwpBV26KmSvkmBrS3x/IqzWAcxBvRcgR379t+J2ak5gtGLRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/qMCFrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53BFC4CEEB;
	Wed, 13 Aug 2025 15:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755100293;
	bh=Nned+2OXLAR4zbMBIAOqe5xsNi80BA2aVmJkwOizo/A=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=Z/qMCFrfEERYFA8IES6JygMml11nsuNkVSY1quWx7F+D7wF31X8MlEECLSfwkwWAn
	 XErYabNXdin0znaccplF3O+tR9VQwLTZ7tbcFMgCaPHbmTlekDNr8uaiqJDUl51Stq
	 py/Y0N+K8xtfU7tu3lHaGwJQw+Cl+U2m1o+SmO5zwJymG4DpqJpdeunaRdDBRELiO/
	 hDV4EEZJuckxK5esHLkCxNzFlfvLsiAnIQjZf2qklf5/5AjrJK02kqvWogeNKO5K3R
	 azAjg6YNxRQaeHDvwIJ3+T9GFckD7cK0J68bsFfelMdoMfSULnW259sdUXODJg7lyX
	 MVjkXTUcS3Yag==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-333a17be4e0so47496971fa.1;
        Wed, 13 Aug 2025 08:51:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVUhtqrQDwZ+weBfrllBIOHac2fBJd5SSG8NvZr5pZiNPN1vgjR1P9l1sm+y6QfKZiE82VK0f5c@vger.kernel.org, AJvYcCW2nn5LFvMGxLSQhSxQQ/D/ECUz9pfLX7EiKjDKyR/Fj2KEdsjvu57xIwapg7QTCG8H69LKHugbR04Nhe+U@vger.kernel.org, AJvYcCXDsrbHuMsMo2S+DEOeLDqgHbB9+irc9vikE3PmRz7CasE2LA/nz/qq1Qq7k78my2TRernSQalMi5KZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwYQYG8C58lpIVng9OCR3D3ND4dqldoom3/rCuaUYoP6/D7arGT
	k4f2gRREXYwZuFy57lUqZn1MbOP+nRPVg7Mux/egJJpvHUBG2OtsZ4MBTxdq19XxKtCh2BvfuuJ
	g+zja4BrKtuOpBBActRNF3dg6dMtj9Do=
X-Google-Smtp-Source: AGHT+IF/AlFvjXg9axEmXPnPSPFeb7xCGFHKQ17NbUjRATjXnSeff8Hv94XSiaaI3kXUimdVd3Yinhj/CTkIyHUENJo=
X-Received: by 2002:a05:651c:20cf:20b0:332:6304:3076 with SMTP id
 38308e7fff4ca-333e9548740mr7131671fa.1.1755100292240; Wed, 13 Aug 2025
 08:51:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813145540.2577789-1-wens@kernel.org> <20250813145540.2577789-7-wens@kernel.org>
 <aJyraGJ3JbvfGfEw@shell.armlinux.org.uk>
In-Reply-To: <aJyraGJ3JbvfGfEw@shell.armlinux.org.uk>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 13 Aug 2025 23:51:18 +0800
X-Gmail-Original-Message-ID: <CAGb2v67cKrQygew2CVaq5GCGvzcpkSdU_12Gjq9KR7tFFBow0Q@mail.gmail.com>
X-Gm-Features: Ac12FXym9NQN41ia2Vqvuf9FmKIFWMrTnliSDOIAEvwEtKHt0VT0y1bsZEx7Lbg
Message-ID: <CAGb2v67cKrQygew2CVaq5GCGvzcpkSdU_12Gjq9KR7tFFBow0Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 06/10] arm64: dts: allwinner: a527: cubie-a5e:
 Add ethernet PHY reset setting
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Andre Przywara <andre.przywara@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 11:12=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Wed, Aug 13, 2025 at 10:55:36PM +0800, Chen-Yu Tsai wrote:
> > diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts b/=
arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
> > index 70d439bc845c..d4cee2222104 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
> > @@ -94,6 +94,9 @@ &mdio0 {
> >       ext_rgmii_phy: ethernet-phy@1 {
> >               compatible =3D "ethernet-phy-ieee802.3-c22";
> >               reg =3D <1>;
> > +             reset-gpios =3D <&pio 7 8 GPIO_ACTIVE_LOW>; /* PH8 */
> > +             reset-assert-us =3D <10000>;
> > +             reset-deassert-us =3D <150000>;
>
> Please verify that kexec works with this, as if the calling kernel
> places the PHY in reset and then kexec's, and the reset remains
> asserted, the PHY will not be detected.

I found this to be a bit confusing to be honest.

If I put the reset description in the PHY (where I think it belongs),
then it wouldn't work if the reset isn't by default deasserted (through
some pull-up). This would be similar to the kexec scenario.

Whereas if I put the reset under the MDIO bus, then the core would
deassert the reset before scanning the bus.

It's confusing to me because the code already goes through the MDIO bus
device tree node and *knows* that there are PHYs under it, and that the
PHYs might have a reset. And it can even handle them _after_ the initial
bus scan.

Describing the PHY reset as a bus reset IMHO isn't correct.


ChenYu

