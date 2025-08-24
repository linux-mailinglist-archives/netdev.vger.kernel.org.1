Return-Path: <netdev+bounces-216269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FDAB32DF1
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 09:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BD037AE1D9
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 07:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D86923504D;
	Sun, 24 Aug 2025 07:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpY7tpEm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A83188000;
	Sun, 24 Aug 2025 07:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756019892; cv=none; b=jDXVE2kS5wTlPi3VvTroW3Epg5GLzOYWucAoWdRl9licv6y5qFNFr5k6hd9+mDs8Muj/Lq4+Vbb+40ixytZQh1Vwzd5mIDfuaMD3mpdA+Xyg02Eq0ej6B+O/6AkXwQHqYR1kVcKoKC1KJhRHPmAK/TYKhEm5izyN+VRWLrkoo/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756019892; c=relaxed/simple;
	bh=0fh0gGpu0t//MXZ11+UqTS4MNTzyq/dz/PwrJz2CL/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4XC2CPC/QE0zL/JRh4YYam25385W6hye0ecxGehHXDgrbOjLDJvPFN12U8Vzep8cXy9+Uu0uVB/5GgalBeMTWUPH3ixMZHPgeWJVBw0Et05Ok0ZJC4KTq+m9eaz80bXlmVBxRPYnY9kJWPdkadai+0VTtWsEzMhd5WSNkxHkF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpY7tpEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54615C4CEEB;
	Sun, 24 Aug 2025 07:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756019890;
	bh=0fh0gGpu0t//MXZ11+UqTS4MNTzyq/dz/PwrJz2CL/g=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=GpY7tpEmUzWQ22Ku/8Aky16LAV3UD5t3Z971mEpzjCUmAoio4DZ7IA4GlDl4szkk3
	 h8v2g+R4zUzOcepxb89+3pSTHdO67PEjvXym3zcGjr4bThbWkFDowPpE6ukY3xpEYz
	 bA4WsCdIKq8HR9j8nQAJgbKyzc3+fxwwY38X9cTQ0fI+cC9quWaEVeW7+xUxSr54Is
	 I4bD38wF7zSwtS02Ndp+9HkZMT3D3PrsYl33GxopTuesUKzRLcm47hCCZF9VO27i9e
	 /lILvLBNVZS4IavTMLQ9nMg8uvnAxKhuLTYFUh3ayol2R7wm6T6rcHpyZ/A3Hp/GV4
	 xO5ZjLFsli/qg==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3366766118aso4799231fa.0;
        Sun, 24 Aug 2025 00:18:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWRRhfH6Epn66agrhKIa+j98jS5dX8Js4yfgxcYwdRsgDxlCM2LL++Iugxp5qdJPeeNVxgEbDU/P5uN@vger.kernel.org, AJvYcCWYBSqdG1IL84gZtcqtjjrwJ99ZJCCdmUKAmRzwSp8y8raLukSoGwWRBOLbuyrWHbSEI9mAF0A0@vger.kernel.org, AJvYcCXjm8dnWc4b0mmT8O/WMUwUpW0Zx0jOQNYfv4dBsvtwik8/k75CF2y1ICENLnh5Rs8MiSmW7oM18q6vEKQI@vger.kernel.org
X-Gm-Message-State: AOJu0YwEQFzAxo6ncJByFhQqIfZvyW20quOrYELrVlaXvzOHubiYEYh+
	IAOZSPKDt0R8lbA3Uu4MBYBRn3DLOj8geaR6s4Jcxg8uU8bruadrzbB74V2SXFyAx/WGnU2OYg2
	rKnUquiFr4trnCGnVUhaJToq6cK7yTgM=
X-Google-Smtp-Source: AGHT+IEJYKJm9oxMtoKhPUUIqoRJqzRy7kx4QCxWtWwOw/B6CTvUqPHyV5enNtb9irkZ5kRX/OIWTP9CV/YtH0uF8lM=
X-Received: by 2002:a05:651c:31ca:20b0:30b:edfc:5d8a with SMTP id
 38308e7fff4ca-33650b8a25fmr13646791fa.0.1756019888725; Sun, 24 Aug 2025
 00:18:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813145540.2577789-1-wens@kernel.org> <20250813145540.2577789-7-wens@kernel.org>
 <aJyraGJ3JbvfGfEw@shell.armlinux.org.uk> <CAGb2v67cKrQygew2CVaq5GCGvzcpkSdU_12Gjq9KR7tFFBow0Q@mail.gmail.com>
 <aJy_qUbmqoOG-GBC@shell.armlinux.org.uk>
In-Reply-To: <aJy_qUbmqoOG-GBC@shell.armlinux.org.uk>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Sun, 24 Aug 2025 09:17:56 +0200
X-Gmail-Original-Message-ID: <CAGb2v6532sc3tk99OYWu5A92NYgPF3J51vsDGnMM=TtrS4TQCw@mail.gmail.com>
X-Gm-Features: Ac12FXxzg5NyZyTyJnQtY_4IH-x_XLg3gCT00louWNGK9on2RVQmjCu1YaIrTDY
Message-ID: <CAGb2v6532sc3tk99OYWu5A92NYgPF3J51vsDGnMM=TtrS4TQCw@mail.gmail.com>
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

On Wed, Aug 13, 2025 at 6:39=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Wed, Aug 13, 2025 at 11:51:18PM +0800, Chen-Yu Tsai wrote:
> > On Wed, Aug 13, 2025 at 11:12=E2=80=AFPM Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Wed, Aug 13, 2025 at 10:55:36PM +0800, Chen-Yu Tsai wrote:
> > > > diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dt=
s b/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
> > > > index 70d439bc845c..d4cee2222104 100644
> > > > --- a/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
> > > > +++ b/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
> > > > @@ -94,6 +94,9 @@ &mdio0 {
> > > >       ext_rgmii_phy: ethernet-phy@1 {
> > > >               compatible =3D "ethernet-phy-ieee802.3-c22";
> > > >               reg =3D <1>;
> > > > +             reset-gpios =3D <&pio 7 8 GPIO_ACTIVE_LOW>; /* PH8 */
> > > > +             reset-assert-us =3D <10000>;
> > > > +             reset-deassert-us =3D <150000>;
> > >
> > > Please verify that kexec works with this, as if the calling kernel
> > > places the PHY in reset and then kexec's, and the reset remains
> > > asserted, the PHY will not be detected.
> >
> > I found this to be a bit confusing to be honest.
> >
> > If I put the reset description in the PHY (where I think it belongs),
> > then it wouldn't work if the reset isn't by default deasserted (through
> > some pull-up). This would be similar to the kexec scenario.
>
> The reason for this is quite simple. While it's logical to put it in
> there, the problem is that the PHY doesn't respond on the MDIO bus
> while it's reset pin is asserted.
>
> Consequently, when we probe the MDIO bus to detect PHYs and discover
> the PHY IDs, we get no response, and thus we believe there isn't a
> device at the address. That means we don't create a device, and thus
> there's no mdio device for the address.

It feels like a limitation of the implementation though. With the split
of mdio_device and phy_device, maybe it's possible to add some API that
registers mdio_device first based on information from the DT, have its
reset deasserted, read back the PHY ID, then create the PHY device?

This limitation also applies to handling regulator supplies for the PHY,
which we currently resort to sticking under the MAC, which is even worse?

> There is a work-around, which is to encode the PHY ID in the DT
> compatible (check the ethernet-phy binding). However, note that we
> will then not read the actual PHY ID (maybe we should?) which means
> if the driver wants to know e.g. the revision, or during production
> the PHY changes, it will require DT to change.

Judging from previous board iterations, I think this is quite likely
to happen. If the additional SoC internal delay values stay the same,
I would prefer we not run into this.


Thanks
ChenYu

