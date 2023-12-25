Return-Path: <netdev+bounces-60186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5306281DFB9
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 11:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 785581C21708
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 10:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFB130D0B;
	Mon, 25 Dec 2023 10:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQqXoraS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BB22E41A
	for <netdev@vger.kernel.org>; Mon, 25 Dec 2023 10:28:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394A1C433C7;
	Mon, 25 Dec 2023 10:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703500121;
	bh=VUk9KD28SFTgH+2+etqxTGW1fQIO2k2iFLdUmLIGD9U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sQqXoraSPj/AZrOh1rAkuGxDrFCRwr9HhKol3sNWawCMhT6u3bEwM6Et+mJ9z0Ooj
	 QcDeo2aiNWqda4/2Y9ghBXxdmOdHda2W1/4n1zabRc2Fqq+3KJsdcOOn8quxugWD3V
	 Zqiv4WnH7IK4kruZu8v1pVZcogKXTZ4IRNZRou+fw2w6T4W8iJmIRtrEVnl4CT2I0f
	 8fLKKiiYXyv6I6kTlkeVkRW9SG2+mjyPgc8nW4YhFdAsBCaG6GhK4/bHwmBmKLwp0D
	 JCa5nvXszAUx17Opgh4wIm1RysEto53M/ooumZF8WpGuccw3FWVia2TTfaMYV6olP3
	 OifeUuUDY3sPA==
Date: Mon, 25 Dec 2023 11:28:31 +0100
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
Message-ID: <20231225112831.65e3a942@thinkpad>
In-Reply-To: <5b9ae8ea-5817-47b0-9d51-0b15098db5cf@gmail.com>
References: <20231220155518.15692-1-kabel@kernel.org>
	<f75e5812-93fe-4744-a160-b5505fecd47d@gmail.com>
	<20231220172518.50f56aaa@dellmb>
	<5b9ae8ea-5817-47b0-9d51-0b15098db5cf@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 23 Dec 2023 20:09:33 +0100
Heiner Kallweit <hkallweit1@gmail.com> wrote:

> On 20.12.2023 17:25, Marek Beh=C3=BAn wrote:
> > On Wed, 20 Dec 2023 17:20:07 +0100
> > Heiner Kallweit <hkallweit1@gmail.com> wrote:
> >  =20
> >> On 20.12.2023 16:55, Marek Beh=C3=BAn wrote: =20
> >>> Hi,
> >>>
> >>> this series reworks the realtek PHY driver's support for rtl822x
> >>> 2.5G transceivers:
> >>>
> >>> - First I change the driver so that the high level driver methods
> >>>   only use clause 45 register accesses (the only clause 22 accesses
> >>>   are left when accessing c45 registers indirectly, if the MDIO bus
> >>>   does not support clause 45 accesses).
> >>>   The driver starts using the genphy_c45_* methods.
> >>>
> >>>   At this point the driver is ready to be used on a MDIO bus capable
> >>>   of only clause 45 accesses, but will still work on clause 22 only
> >>>   MDIO bus.
> >>>
> >>> - I then add support for SerDes mode switching between 2500base-x
> >>>   and sgmii, based on autonegotiated copper speed.
> >>>
> >>> All this is done so that we can support another 2.5G copper SFP
> >>> module, which is enabled by the last patch.
> >>>    =20
> >>
> >> Has been verified that the RTL8125-integrated PHY's still work
> >> properly with this patch set?
> >> =20
> >=20
> > Hi Heiner,
> >=20
> > no, I wanted to send you an email to test this. I do not have the
> > controllers with integrates PHYs.
> >=20
> > Can you test this?
> >=20
> > Also do you have a controller where the rtlgen driver is used but it
> > only supports 1gbps ? I.e. where the PHY ID is RTL_GENERIC_PHYID
> > (0x001cc800).
> >=20
> > I am asking because I am told that it also is clause 45, so the drivers
> > can potentially be merged completely (the rtl822x_ functions can be
> > merged with rtlgen_ functions and everything rewritten to clause 45,
> > and gentphy_c45_ functions can be used).
> >  =20
> At least on RTL8168h indirect MMD reads return 0 always.
> IIRC this was the reason why the rtlgen functions use the vendor-specific
> registers.

Looking at the code in r8169_phy_config.c, I see function
  rtl8168h_config_eee_phy()
with three paged writes to vendor registers, but the writes do not access
the same registers as the .read_mmd() methods for the PCS_EEE / AN_EEE regi=
sters
in realtek.c PHY driver.

It seems for now it would be best to keep the methods for paged
accesses.

Could you test the patchset without the patch that removes the paged
access methods?

The rewrite of the read_mmd / write_mmd methods should not cause
problems. I am told by the realtek contact you gave me that:

  If FE PHY supports EEE, then it will support MMD register and it will
  also support use internal registers to access theses MMD registers.

Marek

