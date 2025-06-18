Return-Path: <netdev+bounces-198892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5391DADE35B
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 08:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A303B8C9C
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 06:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF811A316E;
	Wed, 18 Jun 2025 06:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="FRl5N5r6"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E51202C5C
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 06:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750226627; cv=none; b=IzIRp1Il8WHtOgv9ymvJHDL0LIs5jjPdVsnZV7Vwtc1OMRL8BfmweDCH5iLMjlLmQzsS49C+i8BwiAPS/Jzt0zzkiu+nU/3Gr7rKV1jYdVxkvzFCTYAU9m/RSaAQQSBqeiSG6gIP5IsMcCUwa5EhKYh74CL29DTDVlcoQRq57fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750226627; c=relaxed/simple;
	bh=vZPj/jT8Meln/LBmm4lZ44C8Kxd8uYDJzTRG9jMHZ1A=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=gIXh5YGA05VADq7hdU6qL063YwJgySjoexmUXlAhsVoFGNRE9E1ZHyx9P+e7lBua4p0dRjM5dgl/ihec31XiIbTfUp8EB2JYUmTBAg3Fq1c6w4qYER4D7x+bVDMZbok6EZstV6kthIgV6vxtzntEqj2Jv0ndRUZki5TYqnx2H0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=FRl5N5r6; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1750226614; x=1750831414;
	i=markus.stockhausen@gmx.de;
	bh=pKhILAKKd90tbwzp0lFrHxd/11R+TZwRJ2W1oCdNVXA=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FRl5N5r6ZgE3u3J3dV9DUiQSt4OEs8FmARXiQyZe6COAO+2imUK6h6wVK5+Jjkv4
	 bodii3quiljsO68oyK98NrxvwkuY4PzzQr+I7rMge1yTeBg6kkJsMhGq2cq9lXqk8
	 Fl5WHCAUMdZ6JO+beTxy1TTnAOwOVT1gnyw4BtBsQzW0PoUp08B3mTEE3OXqEj9Gm
	 4s26s/gkO+1NBnTj8h29roB6GWDRjszkw0FbVmvckj18ewkSKAL3AM+ggy5+K2l9/
	 1Vfs7KwR4yu8mH22pY3/mVMS1/JYP8Jp31j41q5Ee6wFfmOVamlbBW+aeeadS0ekJ
	 Jby+vo+UsOr+A7yBeQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from colnote55 ([94.31.70.55]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXXuB-1uHY5p0Q8d-00NOAJ; Wed, 18
 Jun 2025 08:03:34 +0200
From: <markus.stockhausen@gmx.de>
To: "'Andrew Lunn'" <andrew@lunn.ch>,
	<Chris.Packham@alliedtelesis.co.nz>
Cc: <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<michael@fossekall.de>,
	<daniel@makrotopia.org>,
	<netdev@vger.kernel.org>
References: <20250617150147.2602135-1-markus.stockhausen@gmx.de> <6e0e38b4-db64-4b63-ac36-4a432b762767@lunn.ch>
In-Reply-To: <6e0e38b4-db64-4b63-ac36-4a432b762767@lunn.ch>
Subject: AW: [PATCH] net: phy: realtek: convert RTL8226-CG to c45 only
Date: Wed, 18 Jun 2025 08:03:25 +0200
Message-ID: <788b01dbe016$b92c4470$2b84cd50$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHIkk1ZwrMdRrTYJJUEkbagN+qSQAGXWE03tCJIh9A=
Content-Language: de
X-Provags-ID: V03:K1:uHIa13lGJZcbIqWaCRy72gZlowMVv19brgKDHrlq+7eOs/HOL4L
 bTCMv6+Zo6iH0zLhqYk/nz1F6UpheHwquwMzG04gQzRLAlZdNiaZRI02PF6gvdtoz0IixJP
 vF20APqwEHkjUIhuUbQUCPnz0qpceVwY6089rapgP9oBFHHw/HKBYYD02I0FXlYJ8BCRcK9
 a7irc4cD/lUiGl2fQoAQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oEZF+RS7IuA=;Urj0q3FIDpjqo/pICEPLNQlbnK+
 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

> Von: Andrew Lunn <andrew@lunn.ch>=20
> Gesendet: Dienstag, 17. Juni 2025 17:36
> An: Markus Stockhausen <markus.stockhausen@gmx.de>
> Betreff: Re: [PATCH] net: phy: realtek: convert RTL8226-CG to c45 only
>=20
> On Tue, Jun 17, 2025 at 11:01:47AM -0400, Markus Stockhausen wrote:
> > The RTL8226-CG can be found on devices like the Zyxel XGS1210-12. Thes=
e
> > are driven by a RTL9302B SoC that has active phy hardware polling in
> > the background.
>=20
> It would be a lot better to just turn that polling off.

This is our challenge:
https://elixir.bootlin.com/linux/v6.16-rc2/source/drivers/net/mdio/mdio-re=
al
tek-rtl9300.c#L366

>
> > As soon as this is active and set to c45 most c22
> > register accesses are blocked and will stop working. Convert the
> > phy to a c45-only function set.
> >=20
> > For documentation purposes some register extracts that where taken to
> > verify proper detection.
>
> Please could you show us the output from ethtool before/after.
>
> >  		PHY_ID_MATCH_EXACT(0x001cc838),
> >  		.name           =3D "RTL8226-CG 2.5Gbps PHY",
> > -		.get_features   =3D rtl822x_get_features,
>
> You can see this calls genphy_read_abilities(phydev) at the end, so
> reading information about 10/100/1G speeds, using the standard C22
> registers.
>
> > -		.config_aneg    =3D rtl822x_config_aneg,
> > -		.read_status    =3D rtl822x_read_status,
> > -		.suspend        =3D genphy_suspend,
> > -		.resume         =3D rtlgen_resume,
> > +		.soft_reset     =3D rtl822x_c45_soft_reset,
> > +		.get_features   =3D rtl822x_c45_get_features,
>
> This only calls genphy_c45_pma_read_abilities(). So i expect 10/100/1G
> is missing.

I had to patch the mdio driver to make the existing RTL8226 phy driver wor=
k
with
It. So whenever a c22 command is sent it will toggle the protocol. I do no=
t
believe
that this is what it was designed for but maybe Chris has some more
experience.

Output with patched bus:

[   49.552627] toggle bus 1 from c45 to c22 to read port 24 page 0 registe=
r
1
[   49.560663] toggle bus 1 from c22 to c45
...
# ethtool lan9=20
Settings for lan9:
        Supported ports: [ TP MII ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
                                2500baseT/Full
        Supported pause frame use: Symmetric Receive-only
        Supports auto-negotiation: Yes
        Supported FEC modes: Not reported
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
                                2500baseT/Full
        Advertised pause frame use: Symmetric Receive-only
        Advertised auto-negotiation: Yes
        Advertised FEC modes: Not reported
        Speed: Unknown!
        Duplex: Unknown! (255)
        Port: Twisted Pair
        PHYAD: 24
        Transceiver: external
        Auto-negotiation: on
        MDI-X: Unknown
        Supports Wake-on: d
        Wake-on: d
        Link detected: no

The RTL8226 seems to support proper MDIO_PMA_EXTABLE flags.
So genphy_c45_pma_read_abilities() can conveniently call
genphy_c45_pma_read_ext_abilities() and 10/100/1000 is=20
populated right.

Outputs with patched driver:

# ethtool lan9
Settings for lan9:
        Supported ports: [ TP ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
                                2500baseT/Full
        Supported pause frame use: Symmetric Receive-only
        Supports auto-negotiation: Yes
        Supported FEC modes: Not reported
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
                                2500baseT/Full
        Advertised pause frame use: Symmetric Receive-only
        Advertised auto-negotiation: Yes
        Advertised FEC modes: Not reported
        Speed: Unknown!
        Duplex: Unknown! (255)
        Port: Twisted Pair
        PHYAD: 24
        Transceiver: external
        Auto-negotiation: on
        MDI-X: Unknown
        Supports Wake-on: d
        Wake-on: d
        Link detected: no

Markus


