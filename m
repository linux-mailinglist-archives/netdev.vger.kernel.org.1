Return-Path: <netdev+bounces-59301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B534281A4FE
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 17:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 569BF1F27E3F
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 16:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041B34A9AD;
	Wed, 20 Dec 2023 16:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZiSjaZD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDC73E477
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 16:25:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC903C433CD;
	Wed, 20 Dec 2023 16:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703089523;
	bh=bhOGlB1dDBmrf0TtJb89iyq2+DlIHpKazvpkkY2WzJs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lZiSjaZDl/y69ZKa4KjiyCTamnUYCGlTN+/DZ3YMLTCMOqc9ZmFWO+3CrIyqlIEo5
	 kkiuqnBHZRrEkxgy51isz+/RoMscU305Tz6dcmQEz9lIw1EXEkij9WO8nRjot5fINV
	 JmHX1k0T5QQuWVoMwdne5A8virlz75Wcc/Z1lsL93GLD8ewJbGoR8T0qYIWS4iBeBJ
	 G+l8WW/3I/nZs+6I+JIURa2U9sc/6SS0nDqHl4EGprQfNhdPOdylrSBMtUJOTpci4p
	 qnJw0r6g4jbDu3ewxvPpCwFJ/oemIMqYbCGFUN7CO8Pguzg03RjHWYzw3ntdyvJZCi
	 s5GePKeA+nMwg==
Date: Wed, 20 Dec 2023 17:25:18 +0100
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <rmk+kernel@armlinux.org.uk>, Alexander
 Couzens <lynxis@fe80.eu>, Daniel Golle <daniel@makrotopia.org>, Willy Liu
 <willy.liu@realtek.com>, Ioana Ciornei <ioana.ciornei@nxp.com>, Marek
 =?UTF-8?B?TW9qw61r?= <marek.mojik@nic.cz>, =?UTF-8?B?TWF4aW1pbGnDoW4=?=
 Maliar <maximilian.maliar@nic.cz>
Subject: Re: [PATCH net-next 00/15] Realtek RTL822x PHY rework to c45 and
 SerDes interface switching
Message-ID: <20231220172518.50f56aaa@dellmb>
In-Reply-To: <f75e5812-93fe-4744-a160-b5505fecd47d@gmail.com>
References: <20231220155518.15692-1-kabel@kernel.org>
	<f75e5812-93fe-4744-a160-b5505fecd47d@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 20 Dec 2023 17:20:07 +0100
Heiner Kallweit <hkallweit1@gmail.com> wrote:

> On 20.12.2023 16:55, Marek Beh=C3=BAn wrote:
> > Hi,
> >=20
> > this series reworks the realtek PHY driver's support for rtl822x
> > 2.5G transceivers:
> >=20
> > - First I change the driver so that the high level driver methods
> >   only use clause 45 register accesses (the only clause 22 accesses
> >   are left when accessing c45 registers indirectly, if the MDIO bus
> >   does not support clause 45 accesses).
> >   The driver starts using the genphy_c45_* methods.
> >=20
> >   At this point the driver is ready to be used on a MDIO bus capable
> >   of only clause 45 accesses, but will still work on clause 22 only
> >   MDIO bus.
> >=20
> > - I then add support for SerDes mode switching between 2500base-x
> >   and sgmii, based on autonegotiated copper speed.
> >=20
> > All this is done so that we can support another 2.5G copper SFP
> > module, which is enabled by the last patch.
> >  =20
>=20
> Has been verified that the RTL8125-integrated PHY's still work
> properly with this patch set?
>=20

Hi Heiner,

no, I wanted to send you an email to test this. I do not have the
controllers with integrates PHYs.

Can you test this?

Also do you have a controller where the rtlgen driver is used but it
only supports 1gbps ? I.e. where the PHY ID is RTL_GENERIC_PHYID
(0x001cc800).

I am asking because I am told that it also is clause 45, so the drivers
can potentially be merged completely (the rtl822x_ functions can be
merged with rtlgen_ functions and everything rewritten to clause 45,
and gentphy_c45_ functions can be used).

Marek

