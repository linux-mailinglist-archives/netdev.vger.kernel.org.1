Return-Path: <netdev+bounces-123453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5540E964EBB
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 21:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C4A71F23840
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 19:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D54D15C120;
	Thu, 29 Aug 2024 19:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSriv3Wn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633B316C853;
	Thu, 29 Aug 2024 19:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724959417; cv=none; b=ccpU46U5YzlCxQ/ZnRYqmj6XLeujbjUvuew9Mw80NNNTFTNwZdFDYcbNkjgvfhvyBSKzjpXnuo4ShzAHe9B/OWjWNo2Zw7npM+pw8Veu+s5XDUKJk30cqbbALDGcTt7B5E0VOy0TqZjDfrqyVykH3Y+o7YlD2OM5V8cl7/ggEps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724959417; c=relaxed/simple;
	bh=SbnGnpRAslUu9Ujl5qV76B+ZETi7n+OFprqF6M/qqFY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ERgnFEJgYQYfbpLZGk/WEuyZeXt9+Como/KgajVLM1gUxdCGAU8CcZ4508bHwedJxBhVQTNNrfnBtscvTTpUVhU4jBFH3G/DrPGGaMmgmUCwoPwENJTZ3q/qs6qKAeRCBRTTf3a+RA/XdAdMFwNcO7egTx6k+foYD86oh8A1vFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSriv3Wn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686F0C4CEC1;
	Thu, 29 Aug 2024 19:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724959417;
	bh=SbnGnpRAslUu9Ujl5qV76B+ZETi7n+OFprqF6M/qqFY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VSriv3Wnv5luJ2EtP7qSwRko4h62INIuDcvfhMzsb5c2gAZnPsr3Iq//103dsy/xf
	 aEiIjh2U3lt5bwNAEHauH2m3ki15LMP0o/DZothAcdjxuxSGtryBqNojuVcYmHzUlF
	 A5HeYTUeP6rWUBH82RpiF/bYWU5GuTt66RundpLlF3Zdn0LG/ytsjLn7XkrFO0rGzm
	 VtbxOKULcN7oCfNRnw9ZSHZoj+gGiQl29WZuaenYcY1Y8646cIYdKl0RS3ZAq3AwV7
	 mo3kFdGGbdPO4e1bEdrFAyFXxjVGkO9seTPJQBGDIXPQGbz+C/wvH6TzYjleJA31gd
	 2pdeivecKT7jg==
Date: Thu, 29 Aug 2024 12:23:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, corbet@lwn.net, hkallweit1@gmail.com,
 linux@armlinux.org.uk, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, kory.maincent@bootlin.com,
 maxime.chevallier@bootlin.com, linux-doc@vger.kernel.org
Subject: Re: [RFC net-next 2/2] net: ethtool: add phy(dev) specific stats
 over netlink
Message-ID: <20240829122335.1dd1c052@kernel.org>
In-Reply-To: <056e03a1-ed13-40b0-b66d-755dd2760988@lunn.ch>
References: <20240829174342.3255168-1-kuba@kernel.org>
	<20240829174342.3255168-3-kuba@kernel.org>
	<056e03a1-ed13-40b0-b66d-755dd2760988@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Aug 2024 20:47:04 +0200 Andrew Lunn wrote:
> > +/* Additional PHY statistics, not defined by IEEE */
> > +struct ethtool_phy_stats {
> > +	/* Basic packet / byte counters are meant for PHY drivers */
> > +	u64 rx_packets;
> > +	u64 rx_bytes;
> > +	u64 rx_error; /* TODO: we need to define here whether packet
> > +		       * counted here is also counted as rx_packets,
> > +		       * and whether it's passed to the MAC with some
> > +		       * error indication or MAC never sees it.
> > +		       */
> > +	u64 tx_packets;
> > +	u64 tx_bytes;
> > +	u64 tx_error; /* TODO: same as for rx */
> > +}; =20
>=20
> I'm not sure these are actually useful.
>=20
> adin.c:
>         { "total_frames_checked_count",         0x940A, 0x940B }, /* hi +=
 lo */
>         { "length_error_frames_count",          0x940C },
>         { "alignment_error_frames_count",       0x940D },
>         { "symbol_error_count",                 0x940E },

This one's IEEE, from patch 1.

>         { "oversized_frames_count",             0x940F },
>         { "undersized_frames_count",            0x9410 },

bunch of IEEE stats, but from the MAC space :S

>         { "odd_nibble_frames_count",            0x9411 },
>         { "odd_preamble_packet_count",          0x9412 },
>         { "dribble_bits_frames_count",          0x9413 },
>         { "false_carrier_events_count",         0x9414 },

These may be interesting?

> bcm-phy-lib.c:
>         { "phy_receive_errors", -1, MII_BRCM_CORE_BASE12, 0, 16 },

matching rx errors

>         { "phy_serdes_ber_errors", -1, MII_BRCM_CORE_BASE13, 8, 8 },

Dunno what BER errors is =F0=9F=A4=94=EF=B8=8F

>         { "phy_false_carrier_sense_errors", -1, MII_BRCM_CORE_BASE13, 0, =
8 },

false carrier like in adin.c

>         { "phy_local_rcvr_nok", -1, MII_BRCM_CORE_BASE14, 8, 8 },
>         { "phy_remote_rcv_nok", -1, MII_BRCM_CORE_BASE14, 0, 8 },

nok is not okay ? ... =F0=9F=A4=B7=EF=B8=8F

>         { "phy_lpi_count", MDIO_MMD_AN, BRCM_CL45VEN_EEE_LPI_CNT, 0, 16 },

Sounds standard :)

> icplus.c:
>         { "phy_crc_errors", 1 },
>         { "phy_symbol_errors", 11, },

Why the PHY wants to check CRC I can only guess, but the other one=20
is in patch 1.

... I think going thru them right now is not super useful.

> 802.3 does not define in PHY statistics, the same as it does not
> define any MAC statistics. As a result it is a wild west, vendors
> doing whatever they want.

I think IEEE does define the MIB including some counters. It just does=20
a shit job and defines very few.

> The exception is the Open Alliance, which have defined a number of
> different standards defining statistics which Automotive vendors can
> optionally follow.
>=20
> https://opensig.org/automotive-ethernet-specifications/
>=20
> These could be defined as either one or three groups, with the
> expectation more will be added later.

SG.

To be clear, I'm adding the pkt/error counters because Oleksij was
trying to add defines for these into linux/phy.h

https://lore.kernel.org/all/20240822115939.1387015-3-o.rempel@pengutronix.d=
e/

You acked that which I read as an agreement that there's sufficient
commonality :)

I threw in the byte counters, perhaps unnecessarily. We can drop those
for sure.

