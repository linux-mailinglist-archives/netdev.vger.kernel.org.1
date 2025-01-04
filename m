Return-Path: <netdev+bounces-155216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE72A0176F
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 00:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D1DF3A385B
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 23:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9780A1D61AC;
	Sat,  4 Jan 2025 23:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="mfxjaXFE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66E01D63E4
	for <netdev@vger.kernel.org>; Sat,  4 Jan 2025 23:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736032576; cv=none; b=kC8NHVr1gh2oGwUxhBMlkbTn4os3YmyVw+jkNHmqzeY6FxSdKH6DMsPAu3xvcY65t2mppif5YA37x3r1WejFXtf29rjxZgruji63Gxbu05pMLLuJBoWEL89YekotLxAEIGefSaVsTCZgq3p+lPuJ13V9h9iYpW0MY7aHJNT0cnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736032576; c=relaxed/simple;
	bh=MnRVBqPfX/Vf+Q1roDneA7Zec421ruCyjFvIJdK4euc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AIYvo6ND/Z16eSIsPRwwWxzNhnvj1m8NfP8J/mTWLnFr8JytcO0+4Ihbfuz6zvuJxbIS2JyULqM9FwUT6gFPa21OQIwx1I2zsHScccH4cEe+tgWUfmf+5DcmzPaUzxfFZ5sZqmfdCF6SA+KLZsS87VC2u8l2mN4sV64sOJywN6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=mfxjaXFE; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54024aa9febso14532765e87.1
        for <netdev@vger.kernel.org>; Sat, 04 Jan 2025 15:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1736032571; x=1736637371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OnUBrw7h//qW1pAlmHCU2ILDLdKaDLeduOXF5uiya9w=;
        b=mfxjaXFEQkRhCmEc4bi4H6LfdAV7ESYwySf2kbR3YoJOk1pIWJMViZppRw0dEMIS4F
         uRl1UfxE1GGQPK02/9lRjjuUZhrGhAiNlPGB9BQK0gOckAPLB+wEnCJBf2vd8GDiSh8t
         aOX5EfUxWxr4D5Qg7CAGu0xKMjmL8lh53r/sKBCEy/qrgUehjmHCegzP2HGQsH97k877
         qe1xkEF7adegPzE9J5LN9Rs3c+eD2tD3X5C/KkGmwitskl1ROypmnWxccz/G4730cAi1
         ImmL0TD/xEOpCzY8tIJep5JLheSG87oQVeOCXMVAEv7twzi5hB9nx6D2tBonW0shxMbt
         USmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736032571; x=1736637371;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OnUBrw7h//qW1pAlmHCU2ILDLdKaDLeduOXF5uiya9w=;
        b=NAxWW36Y7qwdc+eudZuJPlAAHKV3XuxUK1IiovaEoajdmM29I0GDnC84mEwo3NZsEM
         BbUAdg/3cNdA9g/fEoutLLD0weboNgdrq9RmtcRs0Fm1GOZKvNNAZWrX8MAaDyj8hEbc
         YvtLdv1vmIP6jH05QRcJHl231zZOHMyTLrt/2aMsJ4ppKwweO0k2fR1NPs2LiZQutxlc
         6+c+s4dseALXZG8vzUwV9CyWj4AuWTDS8NCPiNBRu4uPwHsoJyrIEYGlAm/wYHmCN5Yn
         36O6EclKqOEYafehgqytRqLERHY0kXNFjp21HkkoUYb+si11ugohPvEqAW3mleSI+fpQ
         uCeQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3CHYWqUMIEdF2ErdIDQiF9fXUBJURnDXbXPVA0+H/Q5A6lzq93aS6XC5tPvSba9gHEHm8hFg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh36guoxLvse+qYGMniR8ep3Z7UJKGdQWA0tdVE2Hg5pK6D1vG
	g/JBmIwHc+Ss3rNlMw3LptLQxnRCZQWW7PjufrE05lc3y0AmSYbrqvVPMaiqXRQ=
X-Gm-Gg: ASbGncvGhRNJxOFj0CopvgM8YSJxdVue6JtjmG7BkMzXCBMNuVjwB2kSRHL61CrsKDo
	17b7j0Y+QMQeBE3YpH7E0D5oAAKGwi8mzS0FxIFO7z1i2066nWHWZ3MfSD5el4M3s+5YsNKPP6m
	2WB1yNV0aI6qAH+8vBG8DNvSlpdBjobBL3PkwhDzlMdY40ZqlZDPnYzm03mCOavYG0tkmLlkUki
	sxX5Mlh3zuoGGd1MW5MpnjA2+A5W2aEamzrPJhq39IG/6d6PDeQ6JCmh8ONmMi/9ZcDuqRbNzOz
	Z0m4l6t/BGqOIQ==
X-Google-Smtp-Source: AGHT+IFIOaj2hxZDb7HOcM8sbRJIADirnUhoTog92ZLZS46RcBiQc1iDFAFSfY5eqcLl2hH5Xy8NWg==
X-Received: by 2002:a05:6512:15a8:b0:540:2542:6081 with SMTP id 2adb3069b0e04-54229533e1dmr15288902e87.23.1736032571498;
        Sat, 04 Jan 2025 15:16:11 -0800 (PST)
Received: from wkz-x13 (h-176-10-159-15.NA.cust.bahnhof.se. [176.10.159.15])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54223821696sm4457111e87.180.2025.01.04.15.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 15:16:09 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, netdev@vger.kernel.org,
 chris.packham@alliedtelesis.co.nz, pabeni@redhat.com, marek.behun@nic.cz
Subject: Re: [PATCH v2 net 3/4] net: dsa: mv88e6xxx: Never force link on
 in-band managed MACs
In-Reply-To: <Z3mxsEziH_ylpCD_@shell.armlinux.org.uk>
References: <20241219123106.730032-1-tobias@waldekranz.com>
 <20241219123106.730032-4-tobias@waldekranz.com>
 <Z3ZrH9yqtvu2-W7f@shell.armlinux.org.uk> <87zfk974br.fsf@waldekranz.com>
 <Z3bIF7xaXrje79D8@shell.armlinux.org.uk> <87pll26z2b.fsf@waldekranz.com>
 <Z3mxsEziH_ylpCD_@shell.armlinux.org.uk>
Date: Sun, 05 Jan 2025 00:16:07 +0100
Message-ID: <87msg66uh4.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On l=C3=B6r, jan 04, 2025 at 22:09, "Russell King (Oracle)" <linux@armlinux=
.org.uk> wrote:
> On Sat, Jan 04, 2025 at 10:37:00PM +0100, Tobias Waldekranz wrote:
>> On tor, jan 02, 2025 at 17:08, "Russell King (Oracle)" <linux@armlinux.o=
rg.uk> wrote:
>> > On Thu, Jan 02, 2025 at 02:06:32PM +0100, Tobias Waldekranz wrote:
>> >> On tor, jan 02, 2025 at 10:31, "Russell King (Oracle)" <linux@armlinu=
x.org.uk> wrote:
>> >> > On Thu, Dec 19, 2024 at 01:30:42PM +0100, Tobias Waldekranz wrote:
>> >> >> NOTE: This issue was addressed in the referenced commit, but a
>> >> >> conservative approach was chosen, where only 6095, 6097 and 6185 g=
ot
>> >> >> the fix.
>> >> >>=20
>> >> >> Before the referenced commit, in the following setup, when the PHY
>> >> >> detected loss of link on the MDI, mv88e6xxx would force the MAC
>> >> >> down. If the MDI-side link was then re-established later on, there=
 was
>> >> >> no longer any MII link over which the PHY could communicate that
>> >> >> information back to the MAC.
>> >> >>=20
>> >> >>         .-SGMII/USXGMII
>> >> >>         |
>> >> >> .-----. v .-----.   .--------------.
>> >> >> | MAC +---+ PHY +---+ MDI (Cu/SFP) |
>> >> >> '-----'   '-----'   '--------------'
>> >> >>=20
>> >> >> Since this a generic problem on all MACs connected to a SERDES - w=
hich
>> >> >> is the only time when in-band-status is used - move all chips to a
>> >> >> common mv88e6xxx_port_sync_link() implementation which avoids forc=
ing
>> >> >> links on _all_ in-band managed ports.
>> >> >>=20
>> >> >> Fixes: 4efe76629036 ("net: dsa: mv88e6xxx: Don't force link when u=
sing in-band-status")
>> >> >> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
>> >> >
>> >> > I'm feeling uneasy about this change.
>> >> >
>> >> > The history of the patch you refer to is - original v1:
>> >> >
>> >> > https://lore.kernel.org/r/20201013021858.20530-2-chris.packham@alli=
edtelesis.co.nz
>> >> >
>> >> > When v3 was submitted, it was unchanged:
>> >> >
>> >> > https://lore.kernel.org/r/20201020034558.19438-2-chris.packham@alli=
edtelesis.co.nz
>> >> >
>> >> > Both of these applied the in-band-status thing to all Marvell DSA
>> >> > switches, but as Marek states here:
>> >> >
>> >> > https://lore.kernel.org/r/20201020165115.3ecfd601@nic.cz
>> >>=20
>> >> Thanks for that context!
>> >>=20
>> >> > doing so breaks last least one Marvell DSA switch (88E6390). Hence =
why
>> >> > this approach is taken, rather than not forcing the link status on =
all
>> >> > DSA switches.
>> >> >
>> >> > Your patch appears to be reverting us back to what was effectively =
in
>> >> > Chris' v1 patch from back then, so I don't think we can accept this
>> >> > change. Sorry.
>> >>=20
>> >> Before I abandon this broader fix, maybe you can help me understand
>> >> something:
>> >>=20
>> >> If a user explicitly selects `managed =3D "in-band-status"`, why woul=
d we
>> >> ever interpret that as "let's force the MAC's settings according to w=
hat
>> >> the PHY says"? Is that not what `managed =3D "auto"` is for?
>> >
>> > You seem confused with that point, somehow confusing the calls to
>> > mac_link_up()/mac_link_down() when using in-band-status with something
>> > that a PHY would indicate. No, that's just wrong.
>> >
>> > If using in-band-status, these calls will be made in response to what
>> > the PCS says the link state is, possibly in conjunction with a PHY if
>> > there is a PHY present. Whether the PCS state gets forwarded to the MAC
>> > is hardware specific, and we have at least one DSA switch where this
>> > doesn't appear happen.
>> >
>> > Please realise that there are _three_ distinct modules here:
>> >
>> > - The MAC
>> > - The PCS
>> > - The PHY or media
>>=20
>> Right, I sloppily used "PHY" to refer to the link partner on the other
>> end of the SERDES.  I realize that the remote PCS does not have to
>> reside within a PHY.
>
> Sigh, it seems I'm not making myself clear.
>
> Host system:
>
>   ---------------------------+
>     NIC (or DSA switch port) |
>      +-------+    +-------+  |
>      |       |    |       |  |
>      |  MAC  <---->  PCS  <-----------------------> PHY, SFP or media
>      |       |    |       |  |     ^
>      +-------+    +-------+  |     |
>                              |   phy interface type
>   ---------------------------+   also in-band signalling
>                                  which managed =3D "in-band-status"
> 				 applies to

This part is 100% clear

>> E.g. what does it mean to have an SGMII link where in-band signaling is
>> not used?  Is that not part of what defines SGMII?
>
> There _are_ PHYs out there that implement Cisco SGMII (which is IEEE
> 802.3 1000BASE-X modified to allow signalling at 10M and 100M speeds by
> symbol replication, and changing the format of the 1000BASE-X to provide
> the details of the SGMII link speed and duplex) but do _not_ support
> that in-band signalling.
>
> The point of SGMII without in-band signalling rather than just using
> 1000BASE-X without in-band signalling is that SGMII can operate at
> 10M and 100M, whereas 1000BASE-X can not.
>
> The usual situation, however, is that most devices that support Cisco
> SGMII also allow the in-band signalling to be configured to be used or
> not used.

Yes, I know about the relationship between 1000BASE-X and SGMII, I just
did not know that there were devices that only implemented the symbol
replication part.

> Going back to the diagram above, the link between the MAC and PCS is
> _not_ described in DT currently, not by the managed property not by
> the phy-modes etc properties.

Clear.

> Now, the port configuration register on the Marvell switches controls
> the MAC settings. The PCS has a separate register set (normally
> referred to as serdes in Marvell's Switch terminology) which is an
> IEEE compliant clause 22 register layout.

...or Clause 45 on the Amethyst - sure.  I am quite familiar with these
devices.  That is not the source of my confusion.

> The problem is, it seems *some* Marvell switches automatically forward
> the PCS status to the MAC. Other switches do not. The DT "managed"

Yes, I understand this problem, and that that is the reason for
rejecting the patch.

> property does not describe this - because - as stated above - the
> "managed" property applies to the link between the PCS and external
> world (which may be a PHY, or may be media) and _not_ between the
> MAC and its associated PCS.

I understand _where_ it applies and _what_ it describes, but I do not
understand _how_ a driver should make use of it.

In other words, my question is:

For a NIC driver to properly support the `managed` property, how should
the setup and/or runtime behavior of the hardware and/or the driver
differ with the two following configs?

    &eth0 {
        phy-connection-type =3D "sgmii";
        managed =3D "auto";
    };

vs.

    &eth0 {
        phy-connection-type =3D "sgmii";
        managed =3D "in-band-status";
    };

