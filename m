Return-Path: <netdev+bounces-146644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAAB9D4DB6
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 14:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCE8FB25346
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 13:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7091D86F1;
	Thu, 21 Nov 2024 13:22:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ni.piap.pl (ni.piap.pl [195.187.100.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5C41D6DDA;
	Thu, 21 Nov 2024 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.187.100.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732195378; cv=none; b=BefOBglntvLRcBxP8tjsdujm7uUa9mY/UMpLE8oYvubsrzAp9AvS76yaxU2vA+Pze3FSMa7el7zdr2udzbHQex/cWe8ygyW6ajrnxOyKb0FdDYjz8FxuWBaRCbrq0Zl3ReuRukxp37Tcb6dC8FwXSG5eJC0wjrbLFFdYe7wLm58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732195378; c=relaxed/simple;
	bh=FuXpVUzb7frRTs+C0WNM9a1LtzYMemKKFhUDyPOgmEY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F7uOGDH5pz60ZVmSXSg+Tve8B6xpoJ0K7qCmLkh6+O0Ua4xWS9GKOQ1+8SJAfU4qTB3VmDzdTMdAk8yyYwNH099zf347Jjrss4BZ7ny7Q1bidw+gS4rmCAA33KVhviz0F8Cwm9CoVbGNWFQRew8Cc1qpZvFJFxF2MBLL90JKMMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=piap.pl; spf=pass smtp.mailfrom=piap.pl; arc=none smtp.client-ip=195.187.100.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=piap.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=piap.pl
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
	by ni.piap.pl (Postfix) with ESMTPS id E1EB2C3EEAC5;
	Thu, 21 Nov 2024 14:22:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl E1EB2C3EEAC5
From: =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To: netdev <netdev@vger.kernel.org>
Cc: Oliver Neukum <oneukum@suse.com>,  Andrew Lunn <andrew+netdev@lunn.ch>,
  "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  linux-usb@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Jose Ignacio Tornos Martinez
 <jtornosm@redhat.com>,  Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH] usbnet_link_change() fails to call netif_carrier_on()
In-Reply-To: <m34j43gwto.fsf@t19.piap.pl> ("Krzysztof =?utf-8?Q?Ha=C5=82as?=
 =?utf-8?Q?a=22's?= message of
	"Tue, 19 Nov 2024 14:46:59 +0100")
References: <m34j43gwto.fsf@t19.piap.pl>
Sender: khalasa@piap.pl
Date: Thu, 21 Nov 2024 14:22:50 +0100
Message-ID: <m35xogg1qt.fsf@t19.piap.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I'm still trying to understand how is it all (phy + phylink) supposed to
work. My adapter uses fixed PHY mode (uses a special SFP module and the
ASIX AX88772B internal PHY, configured by internal SROM memory).

This is not a fixed *MII connection, though. This is a regular clause 22
transceiver, a part of the ASIX MAC IC.

The MDIO registers are initialized (on power-up) to (BMCR) 0x2100 and
(BMSR) 0x780D, meaning autonegotiation is supported but disabled,
100 Mbps FD is selected. Link is established.

Ethtool shows the following:
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
        Supported pause frame use: Symmetric Receive-only
        Supports auto-negotiation: Yes
        Supported FEC modes: Not reported
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
        Advertised pause frame use: Symmetric Receive-only
        Advertised auto-negotiation: Yes
        Advertised FEC modes: Not reported
the above is generally true, but:
        Speed: Unknown!
        Duplex: Unknown! (255)
        Auto-negotiation: on <<<<<<<<<<<<<<<<
        Port: Twisted Pair
        PHYAD: 10
        Transceiver: internal
        MDI-X: Unknown
        Link detected: no <<<<<<<<<<<<<<<<

Autonegotiation is definitely off.

Perhaps this code is responsible (in phy_probe()):

	if (!linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
			       phydev->supported))
		phydev->autoneg =3D 0;

Shouldn't it check if the actual PHY BMCR autoneg bit (aka 0.12) isn't
zero, and if it is, set autoneg =3D 0?


The other part which may be contributing (in genphy_update_link()):

	/* Consider the case that autoneg was started and "aneg complete"
	 * bit has been reset, but "link up" bit not yet.
	 */
	if (phydev->autoneg =3D=3D AUTONEG_ENABLE && !phydev->autoneg_complete)
		phydev->link =3D 0;

Since phydev->autoneg apparently means "autoneg is supported", the above
doesn't seem very right.

But I guess phydev->autoneg is supposed to mean "autoneg is actually
enabled".

What do you think?
--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa

