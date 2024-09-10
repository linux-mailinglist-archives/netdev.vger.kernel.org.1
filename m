Return-Path: <netdev+bounces-127055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4986B973DCD
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 18:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E76E1C2529B
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 16:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF1419ABC6;
	Tue, 10 Sep 2024 16:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qr6Uwk9t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01240156F2B;
	Tue, 10 Sep 2024 16:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725987260; cv=none; b=K3ozfkOx4Oxovg+m9OsbnU9tDwFxRogtVDHuC3b1zl9em3CqTov90bc5L0fcQPRoBjWU8l8WV49TL+rOJ5T+3Lbi63wh1DWpqV0A/PRYpIJyLHNWB86dtYj3Ms0I9w3UH2hie0n4VWYobEEqaOPDZutMj5r45j1OWf1czqEM3hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725987260; c=relaxed/simple;
	bh=5Bezvc0CAkEXgnJXcBMaGNMUz7wLbTT6fuMXocnKg+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZi8/hV6ZnRvNg75D9sxjaBhoJYVNbm97Zzk036gZAn7kO/1XWdYrtdOLgpv7Gk37PdFkoh5gx+KwS4hE42eZo7dmYE8XDpKVWxHyTgTGc/OIS1DWDMOu4/mvwKcJao4yOI3BcDeJtqQByGi26jrapM+qZzTwBylFNuW/zmmLEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qr6Uwk9t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B04C4AF09;
	Tue, 10 Sep 2024 16:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725987259;
	bh=5Bezvc0CAkEXgnJXcBMaGNMUz7wLbTT6fuMXocnKg+w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qr6Uwk9tGN08+5H/A7XQrI/FGgZLbT6QXhhRJFfJ1z6MqTAzrNwhcx0mRl5a+sW+C
	 diDN0hCvBRGZClK0bkkQWw1sftp7u7GlxuQvOw1oeo9Pz7NWe/e7LZYaU3X9RUZLtB
	 xm/s+2GT3ZB9OiWVlkSn359R2zuOVO2ezDRI/TdMBIQWGb0b6DbCkuInAlHDObWT+t
	 DGAZl628U9LQXQejmoFlGdqbCZlq6XBj7jKpc2q+jqx8khIhVjBhqEHV0m96Z27JwX
	 hKLTUW0gzf57qfc+mjHWKtKS5VMBbepP8P773m/3BFL6smx22Z95pCU/3y+E+2vQbC
	 wNq5ofwMkAXKQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53661a131b4so4010403e87.1;
        Tue, 10 Sep 2024 09:54:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+0V4ubk2gsfk2Q+wzikJs7Kq8g7gvS7/N4jKOcHCVV8j4U9CfEIediUf7wCgLrFUS/+CAXka9@vger.kernel.org, AJvYcCVVoMhzvEUBILy5/vCOohhTHXgaz0AB94sClGjgqcq42D2D9+vPRYArvnp8xGI0nvyPHKlggdPSO7SuYMCD@vger.kernel.org, AJvYcCXlKNuPqoGHclz6B2ZTQ1L+kAD+wiFOUBzBUgPOYW7n3nYIV0O1EiO62CDRircGSwnNPM+cW2mpvl4i@vger.kernel.org
X-Gm-Message-State: AOJu0YywcjZER/0fRyXdcT54/41KSoTJe5j4iufb+Q/9lagxT7VAcwlz
	WQGZCW7RT13fRQWTSbZIlWtt4q/73SO1H6BUDR0cja+TXVmHAxwNNQD6RrwtclwdiDEve0Ox/gJ
	iXoT7AV4Cg4oDndIj1FUc9WJvIg==
X-Google-Smtp-Source: AGHT+IEECbxdAEfk6uHdwgpcFSE+K8gp5bBA32EPrllIwSafIrwdYm0qGuCfk0dhQ8umoMikZ1gfk6FPDr59dwNetR4=
X-Received: by 2002:a05:6512:1593:b0:52c:f2e0:db23 with SMTP id
 2adb3069b0e04-536587fc7d2mr11113032e87.40.1725987257812; Tue, 10 Sep 2024
 09:54:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909124342.2838263-1-o.rempel@pengutronix.de>
 <20240909124342.2838263-2-o.rempel@pengutronix.de> <20240909162009.GA339652-robh@kernel.org>
 <c2e4539f-34ba-4fcf-a319-8fb006ee0974@lunn.ch>
In-Reply-To: <c2e4539f-34ba-4fcf-a319-8fb006ee0974@lunn.ch>
From: Rob Herring <robh@kernel.org>
Date: Tue, 10 Sep 2024 11:54:04 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+qJStck1OTiXg0jPR3EPEpLsu-or0pNqNh0orFjf+0uA@mail.gmail.com>
Message-ID: <CAL_Jsq+qJStck1OTiXg0jPR3EPEpLsu-or0pNqNh0orFjf+0uA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: ethernet-phy: Add
 master-slave role property for SPE PHYs
To: Andrew Lunn <andrew@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Heiner Kallweit <hkallweit1@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <f.fainelli@gmail.com>, kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 12:00=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Sep 09, 2024 at 11:20:09AM -0500, Rob Herring wrote:
> > On Mon, Sep 09, 2024 at 02:43:40PM +0200, Oleksij Rempel wrote:
> > > Introduce a new `master-slave` string property in the ethernet-phy
> > > binding to specify the link role for Single Pair Ethernet
> > > (1000/100/10Base-T1) PHYs. This property supports the values
> > > `forced-master` and `forced-slave`, which allow the PHY to operate in=
 a
> > > predefined role, necessary when hardware strap pins are unavailable o=
r
> > > wrongly set.
> > >
> > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > ---
> > > changes v2:
> > > - use string property instead of multiple flags
> > > ---
> > >  .../devicetree/bindings/net/ethernet-phy.yaml      | 14 ++++++++++++=
++
> > >  1 file changed, 14 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml =
b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > > index d9b62741a2259..025e59f6be6f3 100644
> > > --- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > > +++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > > @@ -158,6 +158,20 @@ properties:
> > >        Mark the corresponding energy efficient ethernet mode as
> > >        broken and request the ethernet to stop advertising it.
> > >
> > > +  master-slave:
> >
> > Outdated terminology and kind of vague what it is for...
> >
> > The usual transformation to 'controller-device' would not make much
> > sense though. I think a better name would be "spe-link-role" or
> > "spe-link-mode".
>
> This applies to more than Single Pair Ethernet. This property could
> also be used for 2 and 4 pair cables. So spe-link-mode would be wrong.

I kind of figured that... Propose something that's not just
duplicating possible values.

>
> Also:
>
> https://grouper.ieee.org/groups/802/3/dc/comments/P8023_D2p0_comments_fin=
al_by_cls.pdf
>
> On 3 December 2020, the IEEE SA Standard Board passed the following resol=
ution. (See
> <https://standards.ieee.org/about/sasb/resolutions.html>.)
>
>   "IEEE standards (including recommended practices and guides) shall
>   be written in such a way as to unambiguously communicate the
>   technical necessities, preferences, and options of the standard to
>   best enable market adoption, conformity assessment,
>   interoperability, and other technical aspirations of the developing
>   standards committee. IEEE standards should be written in such a way
>   as to avoid non-inclusive and insensitive terminology (see IEEE
>   Policy 9.27) and other deprecated terminology (see clause 10 of the
>   IEEE SA Style Manual) except when required by safety, legal,
>   regulatory, and other similar considerations.  Terms such as
>   master/slave, blacklist, and whitelist should be avoided."
>
>   In IEEE Std 802.3, 1000BASE-T, 10BASE-T1L, 100BASE-T1, 1000BASE-T1,
>   and MultiGBASE-T PHYs use the terms "master" and "slave" to indicate
>   whether the clock is derived from an external source or from the
>   received signal. In these cases, the terms appear in the text,
>   figures, state names, variable names, register/bit names, etc. A
>   direct substitution of terms will create disconnects between the
>   standard and the documentation for devices in the field (e.g., the
>   register interface) and also risks the introduction of technical
>   errors. Note that "master" and "slave" are also occasionally used to
>   describe the relationship between an ONT and an ONU for EPON and
>   between a CNT and a CNU for EPoC.
>
>   The approach that other IEEE standards are taking to address this
>   issue have been considered. For example, IEEE P1588g proposes to
>   define "optional alternative suitable and inclusive terminology" but
>   not replace the original terms. (See
>   <https://development.standards.ieee.org/myproject-web/public/view.html#=
pardetail/8858>.)
>   It is understood that an annex to the IEEE 1588 standard has been
>   proposed that defines the inclusive terminology. It is also
>   understood that the inclusive terminology has been chosen to be
>   "leader" and "follower".
>
>   The IEEE P802.1ASdr project proposes to align to the IEEE P1588g
>   inclusive terminology.  (See
>   <https://development.standards.ieee.org/myprojectweb/public/view.html#p=
ardetail/9009>.)
>   Based on this, it seems reasonable to include an annex that defines
>   optional alternative inclusive terminology and, for consistency, to
>   use the terms "leader" and "follower" as the inclusive terminology
>
> The 2022 revision of 802.3 still has master/slave when describing the
> registers, but it does have Annex K as described above saying "leader"
> and "follower" are optional substitutions.
>
> The Linux code has not changed, and the uAPI has not changed. It seems
> like the best compromise would be to allow both 'force-master' and
> 'force-leader', as well as 'force-slave' and 'force-follower', and a
> reference to 802.3 Annex K.

It seems silly to maintain both forever. I'd rather have one or the
other than both.

> As to you comment about it being unclear what it means i would suggest
> a reference to 802.3 section 1.4.389:
>
>   1.4.389 master Physical Layer device (PHY): Within IEEE 802.3, in a
>   100BASE-T2, 1000BASE-T, 10BASE-T1L, 100BASE-T1, 1000BASE-T1, or any
>   MultiGBASE-T link containing a pair of PHYs, the PHY that uses an
>   external clock for generating its clock signals to determine the
>   timing of transmitter and receiver operations. It also uses the
>   master transmit scrambler generator polynomial for side-stream
>   scrambling. Master and slave PHY status is determined during the
>   Auto-Negotiation process that takes place prior to establishing the
>   transmission link, or in the case of a PHY where Auto-Negotiation is
>   optional and not used, master and slave PHY status

phy-status? Shrug.

Another thought. Is it possible that h/w strapping disables auto-neg,
but you actually want to override that and force auto-neg?

Rob

