Return-Path: <netdev+bounces-169449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7973A43F98
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 13:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D663189C1A1
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 12:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E02268689;
	Tue, 25 Feb 2025 12:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="jLzDQcb3"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2695E2054F1;
	Tue, 25 Feb 2025 12:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740487160; cv=none; b=qURrBGWTmNuz8r4JIQn/gTXVhpjoweufKpT+VzvIQVMJw4IpriqERevTRsYr0OObgFVUL7zc4gIb1FvsqvsPu3EdL+rz/HSPLm3MFPXvHLLfSh2ujXZi+Kjdm6Omw/VAAy6RbIWPD/U/XL3DjWFiuTHGkTZLT848BYo4im72AJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740487160; c=relaxed/simple;
	bh=ftLvHAbw9RMakhP/ufDTsErd7gqkHAIqb/By5HedWLY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=EHRezxmFbZm/QKNs8Ji+CssKMGfhjpEeayiVoXHB/OFjgP4VDd7KLdFYAMuW48F3SyTDnkc8WGYkE3VByAP2xNpNYAm2Z1W/mXp10cj8w3TQKMkuqzx4b6PB8HnbptM+7zObJaS+UTRWRlT3RIwAm6DRop7SxtiMXjuuukrqhUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=jLzDQcb3; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=jLzDQcb3;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10de:2e00:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 51PCcVsd1041440
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 12:38:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1740487110; bh=Bg4yfmGGiDqwDSgFoHRuE53cxwY5ywqg7fVJNc0u3pQ=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=jLzDQcb3i4tR7w7P+X41j1AAjvRRQGekUi4+qDpceYWIkxSxwKQuHwYkRe9MjUqJG
	 S64a+s5kzIgdWYqr2OwoDodRB0CDPwyC49msoVjifD3aIkB9spBzEoQ4dZEdBUyH6k
	 6z4Y1jkgkWzjRg9t+ycENwOv34Em8P1erDX2sChY=
Received: from miraculix.mork.no ([IPv6:2a01:799:10de:2e0a:149a:2079:3a3a:3457])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 51PCcUIF3191216
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 13:38:30 +0100
Received: (nullmailer pid 1139729 invoked by uid 1000);
	Tue, 25 Feb 2025 12:38:30 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
        Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        =?utf-8?Q?K=C3=B6ry?= Maincent <kory.maincent@bootlin.com>,
        Simon Horman <horms@kernel.org>,
        Romain Gantois <romain.gantois@bootlin.com>,
        Antoine Tenart <atenart@kernel.org>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>
Subject: Re: [PATCH net-next 0/2] net: phy: sfp: Add single-byte SMBus SFP
 access
Organization: m
References: <20250223172848.1098621-1-maxime.chevallier@bootlin.com>
	<Z7tdlaGfVHuaWPaG@shell.armlinux.org.uk>
Date: Tue, 25 Feb 2025 13:38:30 +0100
In-Reply-To: <Z7tdlaGfVHuaWPaG@shell.armlinux.org.uk> (Russell King's message
	of "Sun, 23 Feb 2025 17:40:37 +0000")
Message-ID: <87o6yqrygp.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.0.7 at canardo.mork.no
X-Virus-Status: Clean

"Russell King (Oracle)" <linux@armlinux.org.uk> writes:
> On Sun, Feb 23, 2025 at 06:28:45PM +0100, Maxime Chevallier wrote:
>> Hi everyone,
>>=20
>> Some PHYs such as the VSC8552 have embedded "Two-wire Interfaces" design=
ed to
>> access SFP modules downstream. These controllers are actually SMBus cont=
rollers
>> that can only perform single-byte accesses for read and write.
>
> This goes against SFF-8472, and likely breaks atomic access to 16-bit
> PHY registers.
>
> For the former, I quote from SFF-8472:
>
> "To guarantee coherency of the diagnostic monitoring data, the host is
> required to retrieve any multi-byte fields from the diagnostic
> monitoring data structure (e.g. Rx Power MSB - byte 104 in A2h, Rx
> Power LSB - byte 105 in A2h) by the use of a single two-byte read
> sequence across the 2-wire interface."
>
> So, if using a SMBus controller, I think we should at the very least
> disable exporting the hwmon parameters as these become non-atomic
> reads.

Would SMBus word reads be an alternative for hwmon, if the SMBus
controller support those?  Should qualify as "a single two-byte read
sequence across the 2-wire interface."

> Whether PHY access works correctly or not is probably module specific.
> E.g. reading the MII_BMSR register may not return latched link status
> because the reads of the high and low bytes may be interpreted as two
> seperate distinct accesses.

Bear with me.  Trying to learn here.  AFAIU, we only have a defacto
specification of the clause 22 phy interface over i2c, based on the
88E1111 implementation.  As Maxime pointed out, this explicitly allows
two sequential distinct byte transactions to read or write the 16bit
registers. See figures 27 and 30 in
https://www.marvell.com/content/dam/marvell/en/public-collateral/transceive=
rs/marvell-phys-transceivers-alaska-88e1111-datasheet.pdf

Looks like the latch timing restrictions are missing, but I still do not
think that's enough reason to disallow access to phys over SMBus.  If
this is all the interface specification we have?

I have been digging around for the RollBall protocol spec, but Google
isn't very helpful.  This list and the mdio-i2c.c implementation is all
that comes up.  It does use 4 and 6 byte transactions which will be
difficult to emulate on SMBus.  But the

	/* By experiment it takes up to 70 ms to access a register for these
	 * SFPs. Sleep 20ms between iterations and try 10 times.
	 */

comment in i2c_rollball_mii_poll() indicates that it isn't very timing
sensitive at all. The RollBall SFP+ I have ("FS", "SFP-10G-T") is faster
than the comment indicates, but still leaves plenty of time for the
single byte SMBus transactions to complete.

Haven't found any formal specification of i2c clause 45 access either.
But some SFP+ vendors have been nice enough to document their protocol
in datasheets.  Examples:

https://www.repotec.com/download/managed-ethernet/ds-ml/01-MOD-M10GTP-DS-ve=
rB.pdf
https://www.apacoe.com.tw/files/ASFPT-TNBT-X-NA%20V1.4.pdf

They all seem to agree that 2/4/6 byte accesses are required, and they
offer no single byte alternative even if the presence of a "smart"
bridge should allow intelligent latching.  So this might be
"impossible" (aka "hard") to do over SMBus.   I have no such SFP+ so I
cannot even try.

> In an ideal world, I'd prefer to say no to hardware designs like this,
> but unfortunately, hardware designers don't know these details of the
> protocol, and all they see is "two wire, oh SMBus will do".

I believe you are reading more into the spec than what's actually there.

SFF-8419 defines the interface as

 "The SFP+ management interface is a two-wire interface, similar to
  I2C."

There is no i2c requirement. This does not rule out SMBus. Maybe I am
reading too much into it as well, but in my view "similar to I2C" sounds
like they wanted to include SMBus.

Both the adhoc phy additions and the diagnostic parts of SFF-8472
silently ignores this.  I do not think the blame for any incompatibilty
is solely on the host side here.


Bj=C3=B8rn

