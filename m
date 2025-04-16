Return-Path: <netdev+bounces-183144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21448A8B275
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 09:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2974217A338
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 07:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F0422D7A5;
	Wed, 16 Apr 2025 07:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="R/HD9uNG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="M/MtMDua"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020551A8F9E;
	Wed, 16 Apr 2025 07:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744789340; cv=none; b=mDTl6FYVh2PHOaxMFm2m/ydiKFr3XxQXeVzwSPI0HU7VR+9g318zcaGgI05xhTZXpUIYaoUmLnePAjHAjSo0HW8BdJlQFm1fAUzpd/6YIhR+1WbDi54iY4F2X91oYFYxY8IFDrxDsTOQk3ZFwIk+Hsiw3Fl6ahbHWsaJDOfxTfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744789340; c=relaxed/simple;
	bh=v25A/wzR9AvhuS5vVybL2FLQ/7j++SzyiyIA+8jlU2k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l8HIUzewH8pF7+72Tagv6d8hfExYyRxT4IsAt1B91jr99M2zhvUcZeCY2AFBgNRxYpn9fCjTTuSVB0/Lw0TN7pNWenupEwnYcf7qt422iBPNUUQwUJMsFaPM9l3VgFVCNM0owgKZuxgfVc+URCi7XePDwE4skXj4w45gOqpG/Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=R/HD9uNG; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=M/MtMDua reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1744789336; x=1776325336;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=+ic5Mzuh+6gVyT/cjuEACzFs09tFVLNoZJQMRkUzWw0=;
  b=R/HD9uNG9Ij3qanrkoyfoyhaK6uFcjpFnLb+oxnyODn4zqPbYvWEnaZw
   gJHjWGw912FcIdS1xYqcL02oxMq3VV3XwLCUxfsO2rbnrf1dh21ZX+cgH
   VG4e2LQzDDIFyez6qSlV2jgiyHyM/6xxzvfo+/cg4MRS7bgFZjGMMQ6WY
   T6Wdmb8Co/mCLEZA3CcP4PRfe1bcgyZo4zoquOSMDOTGW8xvHWKK3v1Vf
   owLrFBejHJk+f8f4U2RYb4DuGciKld3xvYUqX6FsLXuIvSeVpECJQS0Kk
   msPpX1qZaPr6wdX836aL94TOzaCG9+6KVolZD+bFKhTBy18eQk3PiuByJ
   A==;
X-CSE-ConnectionGUID: OjJQBx9WQeiBmnGab79m3A==
X-CSE-MsgGUID: vRI8Fz7rRtunAMcO6SuQeQ==
X-IronPort-AV: E=Sophos;i="6.15,215,1739833200"; 
   d="scan'208";a="43559009"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 16 Apr 2025 09:42:11 +0200
X-CheckPoint: {67FF5F53-32-B1D34AC3-DEA5B19F}
X-MAIL-CPID: 25AC1741F08C06D9D92310D82C1FB32A_4
X-Control-Analysis: str=0001.0A006375.67FF5F50.0006,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 90B6216C05B;
	Wed, 16 Apr 2025 09:41:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1744789327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ic5Mzuh+6gVyT/cjuEACzFs09tFVLNoZJQMRkUzWw0=;
	b=M/MtMDuaCVsUrYg5k5jSsiYw7QkR3zAqIlGVppUaVxHxGhZSpjRagHzYaOR33GUa8B/+mr
	V0FP85KaNypEdgNHGjWgg18wvlwCMundEPoMouXH05+EG5WFuimPHIA/3nNpAThr8zngt5
	hgxfuLtggXzYfTbkZk80kjc3AdMVR9+048TRxIpdYQbjiU/I04wf2jgTfzLF9tA0JON6Xs
	UKMpKEdOQSQInAg7V41UNqv+dSFfmCplvt49UiPQH9t/ivMVl+bLeNNRh4BP+NRvebEmok
	5qeOCHH4lDDZYwUKOOA/YOz/Gs5IE/v2U/UOIr/fin+QjLjJPw2pvYkyHKwTsA==
Message-ID: <b53fba84c8435859a40288f3a12db40685b8863a.camel@ew.tq-group.com>
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: ethernet-controller:
 update descriptions of RGMII modes
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andy Whitcroft <apw@canonical.com>, Dwaipayan Ray
 <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, Joe
 Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>, Nishanth Menon
 <nm@ti.com>,  Vignesh Raghavendra <vigneshr@ti.com>, Roger Quadros
 <rogerq@kernel.org>, Tero Kristo <kristo@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
Date: Wed, 16 Apr 2025 09:41:57 +0200
In-Reply-To: <5d74d4b2-f442-4cb8-910e-cb1cc7eb2b3d@ti.com>
References: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
	 <218a27ae2b2ef2db53fdb3573b58229659db65f9.1744710099.git.matthias.schiffer@ew.tq-group.com>
	 <6be3bdbe-e87e-4e83-9847-54e52984c645@ti.com>
	 <cd483b43465d6e50b75f0b11d0fae57251cdc3db.camel@ew.tq-group.com>
	 <5d74d4b2-f442-4cb8-910e-cb1cc7eb2b3d@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 2025-04-15 at 17:25 +0530, Siddharth Vadapalli wrote:
>=20
> On Tue, Apr 15, 2025 at 01:28:48PM +0200, Matthias Schiffer wrote:
> > On Tue, 2025-04-15 at 16:06 +0530, Siddharth Vadapalli wrote:
> > >=20
> > > On Tue, Apr 15, 2025 at 12:18:01PM +0200, Matthias Schiffer wrote:
> > > > As discussed [1], the comments for the different rgmii(-*id) modes =
do not
> > > > accurately describe what these values mean.
> > > >=20
> > > > As the Device Tree is primarily supposed to describe the hardware a=
nd not
> > > > its configuration, the different modes need to distinguish board de=
signs
> > >=20
> > > If the Ethernet-Controller (MAC) is integrated in an SoC (as is the c=
ase
> > > with CPSW Ethernet Switch), and, given that "phy-mode" is a property
> > > added within the device-tree node of the MAC, I fail to understand ho=
w
> > > the device-tree can continue "describing" hardware for different boar=
d
> > > designs using the same SoC (unchanged MAC HW).
> >=20
> > The setting is part of the MAC node, but it is always set in the board =
DTS,
> > together with assigning a PHY to the MAC.
>=20
> The MAC is the same independent of which board it is used in. So are we
> really describing the "MAC" or configuring the "MAC"? Isn't it the PHY
> along with the PCB lines on a given board that determine how the "MAC"
> should be "configured" to make the combination of "MAC" + "PHY"
> functional together?
>=20
> >=20
> > > How do we handle situations where a given MAC supports various
> > > "phy-modes" in HW? Shouldn't "phy-modes" then be a "list" to technica=
lly
> > > descibe the HW? Even if we set aside the "rgmii" variants that this
> > > series is attempting to address, the CPSW MAC supports "sgmii", "qsgm=
ii"
> > > and "usxgmii/xfi" as well.
> >=20
> > This is not about PHY mode support of the MAC, but the mode to be used =
on a
> > particular board. I would not expect a board to use multiple different
> > interfaces with a single PHY (and if such cases exist, I consider them =
out of
>=20
> For a fixed PHY, the MAC will be "configured" to operate in a set of
> modes supported by the PHY. The HW description is coming from the PHY
> that has been "fixed", and not the MAC. But the "phy-mode" property
> resides within the device-tree node of the MAC and not the PHY. So are
> we still "describing" the MAC when it is the "PHY" that introduces the
> limitation or requires the MAC to be configured for a particular
> "phy-mode"?

The phy-mode property does not describe the MAC, but how MAC and PHY are
connected. The MAC node just happens to be where this information is placed=
 in
the Device Tree (Using graph nodes to describe the connection between MAC a=
nd
PHY seems like overkill...)

Also note that (as I understand it) I'm not changing anything, I'm updating=
 the
documentation to reflect what has been the intended behavior already. Pleas=
e see
the previous discussion with Andrew that I linked, where he convinced me th=
at
this is the correct approach.

>=20
> > scope for this patch series).
> >=20
> > >=20
> > > > (if a delay is built into the PCB using different trace lengths); w=
hether
> > > > a delay is added on the MAC or the PHY side when needed should not =
matter.
> > > >=20
> > > > Unfortunately, implementation in MAC drivers is somewhat inconsiste=
nt
> > > > where a delay is fixed or configurable on the MAC side. As a first =
step
> > > > towards sorting this out, improve the documentation.
>=20
> While this patch is improving the documentation and making it consistent
> when it comes to the description of "rgmii" by stating that the "MAC"
> shouldn't add a delay, for the remaining cases, as to who adds the delay
> and whether or not the MAC should add a delay has been left open.
> Existing documentation clarifies what the MAC should do for each case
> except "rgmii" which is being fixed by your patch.

Andrew specifically asked to leave it open in the DT bindings whether MAC o=
r PHY
add the delay, and it might differ between drivers (and different operating
systems using the same Device Tree).

Whether the MAC should add a required delay in cases where it's configurabl=
e is
an interesting question - not one of the Device Tree bindings, but of drive=
r
implementation.

On Linux, there currently isn't a way for the MAC driver to query from the =
PHY
whether it could include the delays itself. My assumption is that most PHYs
either don't have internal delays, or the delays are configurable. If this =
is
the case, having the MAC add them in internal-delay modes and not adding th=
em on
the PHY side would be the best default (also for PHY-less/fixed-link setups=
,
which should be handled like a PHY without internal delay capabilities.)

@Andrew, does the above seem correct to you?

Best,
Matthias


>=20
> > > >=20
> > > > Link: https://lore.kernel.org/lkml/d25b1447-c28b-4998-b238-92672434=
dc28@lunn.ch/ [1]
> > > > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com=
>
> > > > ---
> > > >  .../bindings/net/ethernet-controller.yaml        | 16 +++++++++---=
----
> > > >  1 file changed, 9 insertions(+), 7 deletions(-)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/net/ethernet-control=
ler.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> > > > index 45819b2358002..2ddc1ce2439a6 100644
> > > > --- a/Documentation/devicetree/bindings/net/ethernet-controller.yam=
l
> > > > +++ b/Documentation/devicetree/bindings/net/ethernet-controller.yam=
l
> > > > @@ -74,19 +74,21 @@ properties:
> > > >        - rev-rmii
> > > >        - moca
> > > > =20
> > > > -      # RX and TX delays are added by the MAC when required
> > > > +      # RX and TX delays are part of the board design (through PCB=
 traces). MAC
> > > > +      # and PHY must not add delays.
> > > >        - rgmii
> > > > =20
> > > > -      # RGMII with internal RX and TX delays provided by the PHY,
> > > > -      # the MAC should not add the RX or TX delays in this case
> > > > +      # RGMII with internal RX and TX delays provided by the MAC o=
r PHY. No
> > > > +      # delays are included in the board design; this is the most =
common case
> > > > +      # in modern designs.
> > > >        - rgmii-id
> > > > =20
> > > > -      # RGMII with internal RX delay provided by the PHY, the MAC
> > > > -      # should not add an RX delay in this case
> > > > +      # RGMII with internal RX delay provided by the MAC or PHY. T=
X delay is
> > > > +      # part of the board design.
> > > >        - rgmii-rxid
> > > > =20
> > > > -      # RGMII with internal TX delay provided by the PHY, the MAC
> > > > -      # should not add an TX delay in this case
> > > > +      # RGMII with internal TX delay provided by the MAC or PHY. R=
X delay is
> > > > +      # part of the board design.
>=20
> [...]
>=20
> Regards,
> Siddharth.

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

