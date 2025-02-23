Return-Path: <netdev+bounces-168860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B3BA410EF
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 19:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 550FB171A0F
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 18:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CE384037;
	Sun, 23 Feb 2025 18:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="UywiXatY"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52F415D1;
	Sun, 23 Feb 2025 18:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740335876; cv=none; b=U2Lkbb0Xs3pfeFbZuYevsTPrEuguUd3SFHT375r/WYYblJhmm7z2PewzPuyiZ9b7Vq0v/m7Uc2qo0kcjwAADxd9+izNf+E4pBkgjEA3b1aCd4/kBhES5AckMCXpyVe9QKXO+zDQBRrBL3P6oWoDaPKIw37IVL+5gROfbDZar5kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740335876; c=relaxed/simple;
	bh=lUXXP9/lSOpd855MlenHSzmP9FvNyJ2ETG7jjxf5hf8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=f3vuqzwRgi5EFBFrWTKxMfMBltVgUQRtaiAGRlHlMneBREhTNLKdFrJklbN8TOIJMEawTUgK8djNhmy8tmEkZLIaIsVTPKA6xzOaPJQdQqpOMqWX/aHu21VGkUOMeR6qc9E4lso6Q/VU6Hbl3TY/mfiIcYoFSEwYLZzep3KSsiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=UywiXatY; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=UywiXatY;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10de:2e00:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 51NIb6rr930751
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sun, 23 Feb 2025 18:37:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1740335826; bh=cASfj/hI0O25yx+d9HSKNmQxxJ3addtVxQWFqMDxmlE=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=UywiXatYUoXlNQtdjGO2t1XueznmjrTRpJDzeCn6avWwy3ln5FEhqK84QH9QL1smO
	 KM24V1ZrBdZSo90KwGgid2wGFTbO+VeyvJ2onLVk+BU1yx8IsLAOpjfwPkN6h72QH0
	 M7eWNdOojysvvWiPxsBQx7JHa1DFT8MFJ3yGd0QQ=
Received: from miraculix.mork.no ([IPv6:2a01:799:10de:2e0a:149a:2079:3a3a:3457])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 51NIb67q2263848
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sun, 23 Feb 2025 19:37:06 +0100
Received: (nullmailer pid 965631 invoked by uid 1000);
	Sun, 23 Feb 2025 18:37:05 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
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
Date: Sun, 23 Feb 2025 19:37:05 +0100
In-Reply-To: <20250223172848.1098621-1-maxime.chevallier@bootlin.com> (Maxime
	Chevallier's message of "Sun, 23 Feb 2025 18:28:45 +0100")
Message-ID: <87r03otsmm.fsf@miraculix.mork.no>
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

Maxime Chevallier <maxime.chevallier@bootlin.com> writes:

> Hi everyone,
>
> Some PHYs such as the VSC8552 have embedded "Two-wire Interfaces" designe=
d to
> access SFP modules downstream. These controllers are actually SMBus contr=
ollers
> that can only perform single-byte accesses for read and write.
>
> This series adds support for accessing SFP modules through single-byte SM=
Bus,
> which could be relevant for other setups.
>
> The first patch deals with the SFP module access by itself, for addresses=
 0x50
> and 0x51.
>
> The second patch allows accessing embedded PHYs within the module with si=
ngle-byte
> SMBus, adding this in the mdio-i2c driver.
>
> As raw i2c transfers are always more efficient, we make sure that the smb=
us accesses
> are only used if we really have no other choices.
>
> This has been tested with the following modules (as reported upon module =
insertion)
>
> Fiber modules :
>
> 	UBNT             UF-MM-1G         rev      sn FT20051201212    dc 200512
> 	PROLABS          SFP-1GSXLC-T-C   rev A1   sn PR2109CA1080     dc 220607
> 	CISCOSOLIDOPTICS CWDM-SFP-1490    rev 1.0  sn SOSC49U0891      dc 181008
> 	CISCOSOLIDOPTICS CWDM-SFP-1470    rev 1.0  sn SOSC47U1175      dc 190620
> 	OEM              SFP-10G-SR       rev 02   sn CSSSRIC3174      dc 181201
> 	FINISAR CORP.    FTLF1217P2BTL-HA rev A    sn PA3A0L6          dc 230716
> 	OEM              ES8512-3LCD05    rev 10   sn ESC22SX296055    dc 220722
> 	SOURCEPHOTONICS  SPP10ESRCDFF     rev 10   sn E8G2017450       dc 140715
> 	CXR              SFP-STM1-MM-850  rev 0000 sn K719017031       dc 200720
>
>  Copper modules
>
> 	OEM              SFT-7000-RJ45-AL rev 11.0 sn EB1902240862     dc 190313
> 	FINISAR CORP.    FCLF8521P2BTL    rev A    sn P1KBAPD          dc 190508
> 	CHAMPION ONE     1000SFPT         rev -    sn     GBC59750     dc 191104=
01
>
> DAC :
>
> 	OEM              SFP-H10GB-CU1M   rev R    sn CSC200803140115  dc 200827
>
> In all cases, read/write operations happened without errors, and the inte=
rnal
> PHY (if any) was always properly detected and accessible
>
> I haven't tested with any RollBall SFPs though, as I don't have any, and =
I don't
> have Copper modules with anything else than a Marvell 88e1111 inside. The=
 support
> for the VSC8552 SMBus may follow at some point.
>
> Thanks,
>
> Maxime
>
> Maxime Chevallier (2):
>   net: phy: sfp: Add support for SMBus module access
>   net: mdio: mdio-i2c: Add support for single-byte SMBus operations
>
>  drivers/net/mdio/mdio-i2c.c | 79 ++++++++++++++++++++++++++++++++++++-
>  drivers/net/phy/sfp.c       | 65 +++++++++++++++++++++++++++---
>  2 files changed, 138 insertions(+), 6 deletions(-)

Nice!  Don't know if you're aware, but OpenWrt have had patches for
SMBus access to SFPs for some time:

https://github.com/openwrt/openwrt/blob/main/target/linux/realtek/patches-6=
.6/714-net-phy-sfp-add-support-for-SMBus.patch
https://github.com/openwrt/openwrt/blob/main/target/linux/realtek/patches-6=
.6/712-net-phy-add-an-MDIO-SMBus-library.patch

The reason they carry these is that they support Realtek rtl930x based
switches.  The rtl930x SoCs include an 8 channel SMBus host which is
typically connected to any SFP+ slots on the switch.

There has been work going on for a while to bring the support for these
SoCs to mainline, and the SMBus host driver is already here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/d=
rivers/i2c/busses/i2c-rtl9300.c?id=3Dc366be720235301fdadf67e6f1ea6ff32669c0=
74

I assume DSA and ethernet eventually will follow, making SMBus SFP
support necessary for this platform too.

So thanks for doing this!

FWIW, I don't think the OpenWrt mdio patch works at all.  I've recently
been playing with an 8 SFP+ port switch based on rtl9303, and have tried
to fixup both the clause 22 support and add RollBall and clause 45.
This is still a somewhat untested hack, and I was not planning on
presenting it here as such, but since this discussion is open:
https://github.com/openwrt/openwrt/pull/17950/commits/c40387104af62a065797b=
c3e23dfb9f36e03851b

Sorry for the format.  This is a patch for the patch already present in
OpenWrt. Let me know if you want me to post the complete patched
mdio-smbus.c for easier reading.

The main point I wanted to make is that we also need RollBall and clause
45 over SMBus.  Maybe not today, but at some point.  Ideally, the code
should be shared with the i2c implementation, but I found that very hard
to do as it is.

As for Russel's comments regarding atomic reads, I'm hoping for the
pragmatic approach and allow all possible features over SMBus. It's not
like we have the option of using i2c on a host which only supports
SMBus.  My experience is that both hwmon and phy access works pretty
well with SMBus byte accesses.

Some examples:

root@s508cl:~# ethtool -m lan1
        Identifier                                : 0x03 (SFP)
        Extended identifier                       : 0x04 (GBIC/SFP defined =
by 2-wire interface ID)
        Connector                                 : 0x07 (LC)
        Transceiver codes                         : 0x10 0x00 0x00 0x00 0x0=
0 0x00 0x06 0x00 0x00
        Transceiver type                          : 10G Ethernet: 10G Base-=
SR
        Transceiver type                          : FC: Multimode, 50um (M5)
        Encoding                                  : 0x03 (NRZ)
        BR, Nominal                               : 10300MBd
        Rate identifier                           : 0x00 (unspecified)
        Length (SMF,km)                           : 0km
        Length (SMF)                              : 0m
        Length (50um)                             : 300m
        Length (62.5um)                           : 300m
        Length (Copper)                           : 0m
        Length (OM3)                              : 300m
        Laser wavelength                          : 850nm
        Vendor name                               : OEM
        Vendor OUI                                : 00:00:00
        Vendor PN                                 : SFP-10G-SR
        Vendor rev                                : B
        Option values                             : 0x00 0x1a
        Option                                    : RX_LOS implemented
        Option                                    : TX_FAULT implemented
        Option                                    : TX_DISABLE implemented
        BR margin, max                            : 0%
        BR margin, min                            : 0%
        Vendor SN                                 : 202412240025
        Date code                                 : 241224
        Optical diagnostics support               : Yes
        Laser bias current                        : 7.146 mA
        Laser output power                        : 0.4005 mW / -3.97 dBm
        Receiver signal average optical power     : 0.5088 mW / -2.93 dBm
        Module temperature                        : 52.13 degrees C / 125.8=
3 degrees F
        Module voltage                            : 3.2644 V
        Alarm/warning flags implemented           : Yes
        Laser bias current high alarm             : Off
        Laser bias current low alarm              : Off
        Laser bias current high warning           : Off
        Laser bias current low warning            : Off
        Laser output power high alarm             : Off
        Laser output power low alarm              : Off
        Laser output power high warning           : Off
        Laser output power low warning            : Off
        Module temperature high alarm             : Off
        Module temperature low alarm              : Off
        Module temperature high warning           : Off
        Module temperature low warning            : Off
        Module voltage high alarm                 : Off
        Module voltage low alarm                  : Off
        Module voltage high warning               : Off
        Module voltage low warning                : Off
        Laser rx power high alarm                 : Off
        Laser rx power low alarm                  : Off
        Laser rx power high warning               : Off
        Laser rx power low warning                : Off
        Laser bias current high alarm threshold   : 12.000 mA
        Laser bias current low alarm threshold    : 1.000 mA
        Laser bias current high warning threshold : 10.000 mA
        Laser bias current low warning threshold  : 2.000 mA
        Laser output power high alarm threshold   : 1.5849 mW / 2.00 dBm
        Laser output power low alarm threshold    : 0.1000 mW / -10.00 dBm
        Laser output power high warning threshold : 1.2589 mW / 1.00 dBm
        Laser output power low warning threshold  : 0.1259 mW / -9.00 dBm
        Module temperature high alarm threshold   : 85.00 degrees C / 185.0=
0 degrees F
        Module temperature low alarm threshold    : -10.00 degrees C / 14.0=
0 degrees F
        Module temperature high warning threshold : 80.00 degrees C / 176.0=
0 degrees F
        Module temperature low warning threshold  : -5.00 degrees C / 23.00=
 degrees F
        Module voltage high alarm threshold       : 3.7000 V
        Module voltage low alarm threshold        : 2.9000 V
        Module voltage high warning threshold     : 3.6000 V
        Module voltage low warning threshold      : 3.0000 V
        Laser rx power high alarm threshold       : 1.9953 mW / 3.00 dBm
        Laser rx power low alarm threshold        : 0.0398 mW / -14.00 dBm
        Laser rx power high warning threshold     : 1.5849 mW / 2.00 dBm
        Laser rx power low warning threshold      : 0.0501 mW / -13.00 dBm

root@s508cl:~# ethtool -m lan3
        Identifier                                : 0x03 (SFP)
        Extended identifier                       : 0x04 (GBIC/SFP defined =
by 2-wire interface ID)
        Connector                                 : 0x07 (LC)
        Transceiver codes                         : 0x10 0x00 0x00 0x00 0x4=
0 0x00 0x0c 0x00 0x00
        Transceiver type                          : 10G Ethernet: 10G Base-=
SR
        Transceiver type                          : FC: short distance (S)
        Transceiver type                          : FC: Multimode, 62.5um (=
M6)
        Transceiver type                          : FC: Multimode, 50um (M5)
        Encoding                                  : 0x06 (64B/66B)
        BR, Nominal                               : 10300MBd
        Rate identifier                           : 0x00 (unspecified)
        Length (SMF,km)                           : 0km
        Length (SMF)                              : 0m
        Length (50um)                             : 30m
        Length (62.5um)                           : 10m
        Length (Copper)                           : 0m
        Length (OM3)                              : 0m
        Laser wavelength                          : 850nm
        Vendor name                               : FS
        Vendor OUI                                : 00:00:00
        Vendor PN                                 : SFP-10G-T
        Vendor rev                                :=20
        Option values                             : 0x00 0x1a
        Option                                    : RX_LOS implemented
        Option                                    : TX_FAULT implemented
        Option                                    : TX_DISABLE implemented
        BR margin, max                            : 10%
        BR margin, min                            : 88%
        Vendor SN                                 : F2220644072
        Date code                                 : 220824
        Optical diagnostics support               : Yes
        Laser bias current                        : 6.000 mA
        Laser output power                        : 0.5000 mW / -3.01 dBm
        Receiver signal average optical power     : 0.0000 mW / -inf dBm
        Module temperature                        : 54.22 degrees C / 129.5=
9 degrees F
        Module voltage                            : 3.3368 V
        Alarm/warning flags implemented           : Yes
        Laser bias current high alarm             : Off
        Laser bias current low alarm              : Off
        Laser bias current high warning           : Off
        Laser bias current low warning            : Off
        Laser output power high alarm             : Off
        Laser output power low alarm              : Off
        Laser output power high warning           : Off
        Laser output power low warning            : Off
        Module temperature high alarm             : Off
        Module temperature low alarm              : Off
        Module temperature high warning           : Off
        Module temperature low warning            : Off
        Module voltage high alarm                 : Off
        Module voltage low alarm                  : Off
        Module voltage high warning               : Off
        Module voltage low warning                : Off
        Laser rx power high alarm                 : Off
        Laser rx power low alarm                  : On
        Laser rx power high warning               : Off
        Laser rx power low warning                : On
        Laser bias current high alarm threshold   : 15.000 mA
        Laser bias current low alarm threshold    : 1.000 mA
        Laser bias current high warning threshold : 13.000 mA
        Laser bias current low warning threshold  : 2.000 mA
        Laser output power high alarm threshold   : 1.9952 mW / 3.00 dBm
        Laser output power low alarm threshold    : 0.1584 mW / -8.00 dBm
        Laser output power high warning threshold : 1.5848 mW / 2.00 dBm
        Laser output power low warning threshold  : 0.1778 mW / -7.50 dBm
        Module temperature high alarm threshold   : 80.00 degrees C / 176.0=
0 degrees F
        Module temperature low alarm threshold    : -10.00 degrees C / 14.0=
0 degrees F
        Module temperature high warning threshold : 75.00 degrees C / 167.0=
0 degrees F
        Module temperature low warning threshold  : -5.00 degrees C / 23.00=
 degrees F
        Module voltage high alarm threshold       : 3.6000 V
        Module voltage low alarm threshold        : 3.0000 V
        Module voltage high warning threshold     : 3.5000 V
        Module voltage low warning threshold      : 3.1000 V
        Laser rx power high alarm threshold       : 1.1220 mW / 0.50 dBm
        Laser rx power low alarm threshold        : 0.0199 mW / -17.01 dBm
        Laser rx power high warning threshold     : 1.0000 mW / 0.00 dBm
        Laser rx power low warning threshold      : 0.0223 mW / -16.52 dBm


root@s508cl:~# ethtool -m lan8
        Identifier                                : 0x03 (SFP)
        Extended identifier                       : 0x04 (GBIC/SFP defined =
by 2-wire interface ID)
        Connector                                 : 0x07 (LC)
        Transceiver codes                         : 0x10 0x00 0x00 0x00 0x0=
0 0x00 0x00 0x00 0x00
        Transceiver type                          : 10G Ethernet: 10G Base-=
SR
        Encoding                                  : 0x06 (64B/66B)
        BR, Nominal                               : 10300MBd
        Rate identifier                           : 0x00 (unspecified)
        Length (SMF,km)                           : 0km
        Length (SMF)                              : 0m
        Length (50um)                             : 80m
        Length (62.5um)                           : 20m
        Length (Copper)                           : 0m
        Length (OM3)                              : 300m
        Laser wavelength                          : 0nm
        Vendor name                               : OEM
        Vendor OUI                                : 00:00:00
        Vendor PN                                 : SFP-10G-T8
        Vendor rev                                : A
        Option values                             : 0x00 0x1a
        Option                                    : RX_LOS implemented
        Option                                    : TX_FAULT implemented
        Option                                    : TX_DISABLE implemented
        BR margin, max                            : 0%
        BR margin, min                            : 0%
        Vendor SN                                 : F250114T0010
        Date code                                 : 250115
        Optical diagnostics support               : Yes
        Laser bias current                        : 6.000 mA
        Laser output power                        : 0.5010 mW / -3.00 dBm
        Receiver signal average optical power     : 0.5010 mW / -3.00 dBm
        Module temperature                        : 67.64 degrees C / 153.7=
5 degrees F
        Module voltage                            : 3.2538 V
        Alarm/warning flags implemented           : Yes
        Laser bias current high alarm             : Off
        Laser bias current low alarm              : Off
        Laser bias current high warning           : Off
        Laser bias current low warning            : Off
        Laser output power high alarm             : Off
        Laser output power low alarm              : Off
        Laser output power high warning           : Off
        Laser output power low warning            : Off
        Module temperature high alarm             : Off
        Module temperature low alarm              : Off
        Module temperature high warning           : Off
        Module temperature low warning            : Off
        Module voltage high alarm                 : Off
        Module voltage low alarm                  : Off
        Module voltage high warning               : Off
        Module voltage low warning                : Off
        Laser rx power high alarm                 : Off
        Laser rx power low alarm                  : Off
        Laser rx power high warning               : Off
        Laser rx power low warning                : Off
        Laser bias current high alarm threshold   : 15.000 mA
        Laser bias current low alarm threshold    : 1.000 mA
        Laser bias current high warning threshold : 13.000 mA
        Laser bias current low warning threshold  : 2.000 mA
        Laser output power high alarm threshold   : 1.1220 mW / 0.50 dBm
        Laser output power low alarm threshold    : 0.1862 mW / -7.30 dBm
        Laser output power high warning threshold : 1.0000 mW / 0.00 dBm
        Laser output power low warning threshold  : 0.2344 mW / -6.30 dBm
        Module temperature high alarm threshold   : 80.00 degrees C / 176.0=
0 degrees F
        Module temperature low alarm threshold    : -10.00 degrees C / 14.0=
0 degrees F
        Module temperature high warning threshold : 75.00 degrees C / 167.0=
0 degrees F
        Module temperature low warning threshold  : -5.00 degrees C / 23.00=
 degrees F
        Module voltage high alarm threshold       : 3.5999 V
        Module voltage low alarm threshold        : 2.9000 V
        Module voltage high warning threshold     : 3.5000 V
        Module voltage low warning threshold      : 3.0000 V
        Laser rx power high alarm threshold       : 1.1220 mW / 0.50 dBm
        Laser rx power low alarm threshold        : 0.0645 mW / -11.90 dBm
        Laser rx power high warning threshold     : 1.0000 mW / 0.00 dBm
        Laser rx power low warning threshold      : 0.0812 mW / -10.90 dBm


Phy access works too:

root@s508cl:~# mdio smbus:sfp-p5 phy 22
BMCR(0x00): 0x1140
  flags: -reset -loopback +aneg-enable -power-down -isolate -aneg-restart
         -collision-test
  speed: 1000-full

BMSR(0x01): 0x7949
  capabilities: -100-t4 +100-tx-f +100-tx-h +10-t-f +10-t-h -100-t2-f -100-=
t2-h
  flags:        +ext-status -aneg-complete -remote-fault +aneg-capable -link
                -jabber +ext-register

ID(0x02/0x03): 0x01410cc2

ESTATUS(0x0F): 0xf000
  capabilities: +1000-x-f +1000-x-h +1000-t-f +1000-t-h



Even this, which is using RollBall over SMBus:

root@s508cl:~# mdio smbus:sfp-p3 mmd 17:1
CTRL1(0x00): 0x0002
  flags: -reset -low-power +remote-loopback -local-loopback
  speed: 10

STAT1(0x01): 0x0002
  capabilities: -pias -peas +low-power
  flags:        -fault -link

DEVID(0x02/0x03): 0x31c31c12

SPEED(0x04): 0x6031
  capabilities: -400g +5g +2.5g -200g -25g -10g-xr -100g -40g -10g/1g -10 +=
100
                +1000 -10-ts -2-tl +10g

DEVS(0x06/0x05): 0xe000009a
  devices: +vendor2 +vendor1 +c22-ext -power-unit -ofdm -pma4 -pma3 -pma2 -=
pma1
           +aneg -tc -dte-xs +phy-xs +pcs -wis +pma/pmd -c22

CTRL2(0x07): 0x0009
  flags: -pias -peas
  type:  10g-t

STAT2(0x08): 0xb301
  capabilities: +tx-fault +rx-fault +ext-register +tx-disable +local-loopba=
ck
                -10g-sr -10g-lr -10g-er -10g-lx4 -10g-sw -10g-lw -10g-ew
  flags:        +present -tx-fault -rx-fault

EXTABLE(0x0B): 0x40fc
  capabilities: -10g-cx4 -10g-lrm +10g-t +10g-kx4 +10g-kr +1000-t +1000-kx
                +100-tx -10-t -p2mp -40g/100g -1000/100-t1 -25g -200g/400g
                +2.5g/5g -1000-h

PKGID(0x0E/0x0F): 0x31c31c12


Bj=C3=B8rn

