Return-Path: <netdev+bounces-254004-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJawASkpeWkIvwEAu9opvQ
	(envelope-from <netdev+bounces-254004-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 22:07:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6249A97C
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 22:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D44403007525
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 21:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C15F29ACF7;
	Tue, 27 Jan 2026 21:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMufnlzk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B0829992B;
	Tue, 27 Jan 2026 21:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769548067; cv=none; b=GZP08uWxO3oXwVY6Lj+anuuERpOJS1fmsdKvuEPnAfC7V4+tvzm6DxpKpnPdFny8qyxhcXD3luINIphl+VyveHm1mcyiwOJjw6MDGB3gSgabIn1EtdwXgMOi5nOFFfVYWTAYh09EPWklr24rdoO/sTvlXPbRhpNOz6++i7XLvfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769548067; c=relaxed/simple;
	bh=ctQ+Us2hemCPKi3k4i3ryBcEtVG/tnxGMJbsGhchrsE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=thg0TsHfHOydrRo96XoAxeXVi3jNCVa8U6mwn4iDslUMipSssP4bZ61abDNT4rYFtDFxIBj46lomv2FrUgpzb3OXM/Out+GwD4dxPjb6LL2ne6+RGJDLKvNWo6TA1CAeHo5ufPOoOJRiSIu6Z8F4m0ncrqnlK8sndS5plr8ibzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMufnlzk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63D3C19422;
	Tue, 27 Jan 2026 21:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769548066;
	bh=ctQ+Us2hemCPKi3k4i3ryBcEtVG/tnxGMJbsGhchrsE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WMufnlzkD29onk9sCPu5b2U8G7HP45uLsBgLSGxalkdIpqNM1uIQfX7ALD6zRhinL
	 OQxItrEgbDpgyrQZVTgj59dqMDiWyynYiPov+Gf9oYiMFVXaaMNTtTT0IsojeBdNPD
	 1TjqLD9vwAXgHB0ptsltVc3V8/WCmOm1FH386UxL00m8mXciDhk4sWFNFJlRKmF89h
	 X2xdeZ7a1Fa2dbWSp6ZLt9q1dwQtmf6x+rYi5gUx1zbtu1JOSaV1e43xZHUIe1unJY
	 tEQTmARx/pD81BAm8yfSXRYVjF1Xg8ftC6i6IWD4QbbsHFdUBQh8JIHCuCfKOfUVgP
	 qwKtsVxL4k6Nw==
Date: Tue, 27 Jan 2026 13:07:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
 mwojtas@chromium.org, Romain Gantois <romain.gantois@bootlin.com>, Daniel
 Golle <daniel@makrotopia.org>, Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Subject: Re: [PATCH net-next 00/13] net: phy_port: SFP modules
 representation and phy_port listing
Message-ID: <20260127130745.5cc65868@kernel.org>
In-Reply-To: <20260127134202.8208-1-maxime.chevallier@bootlin.com>
References: <20260127134202.8208-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254004-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,google.com,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org,bootlin.com,csgroup.eu,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7E6249A97C
X-Rspamd-Action: no action

On Tue, 27 Jan 2026 14:41:48 +0100 Maxime Chevallier wrote:
> This series is another step towards dealing with multi-port interfaces.
>=20
> It build on the recent addition of phy_port representation to enable
> listing the front-facing ports of an interface. For now, we don't control
> these ports, we merely list their presence and their capabilities.
>=20
> As the most common use-case of multi-port interfaces is combo-ports that
> provide both RJ45 and SFP connectors on a single MAC, there's a lot of
> SFP stuff in this series.
>=20
> This series is in 2 main parts. The first one aims at representing the
> SFP cages and modules using phy_port, as combo-ports with RJ45 + SFP are
> by far the most common cases for multi-connector setups.
>=20
> The second part is the netlink interface to list those ports, now that
> most use-cases are covered.

Some config-related build unhappines here (kunit hits this):

../include/linux/phy_link_topology.h:110:1: error: return type defaults to =
=E2=80=98int=E2=80=99 [-Wimplicit-int]
  110 | phy_link_topo_get_port(struct net_device *dev, u32 port_id)
      | ^~~~~~~~~~~~~~~~~~~~~~
../include/linux/phy_link_topology.h:110:1: warning: no previous prototype =
for =E2=80=98phy_link_topo_get_port=E2=80=99 [-Wmissing-prototypes]
In file included from ../include/uapi/linux/posix_types.h:5,
                 from ../include/uapi/linux/types.h:14,
                 from ../include/linux/types.h:6,
                 from ../include/linux/kasan-checks.h:5,
                 from ../include/asm-generic/rwonce.h:26,
                 from ./arch/x86/include/generated/asm/rwonce.h:1,
                 from ../include/linux/compiler.h:380,
                 from ../include/linux/build_bug.h:5,
                 from ../include/linux/bits.h:30,
                 from ../include/linux/bitops.h:6,
                 from ../include/linux/bitmap.h:8,
                 from ../include/linux/ethtool.h:16,
                 from ../include/uapi/linux/ethtool_netlink.h:12,
                 from ../include/linux/ethtool_netlink.h:6,
                 from ../net/ethtool/common.c:3:
../include/linux/phy_link_topology.h: In function =E2=80=98phy_link_topo_ge=
t_port=E2=80=99:
../include/linux/stddef.h:8:14: error: returning =E2=80=98void *=E2=80=99 f=
rom a function with return type =E2=80=98int=E2=80=99 makes integer from po=
inter without a cast [-Wint-conversion]
    8 | #define NULL ((void *)0)
      |              ^
../include/linux/phy_link_topology.h:112:16: note: in expansion of macro =
=E2=80=98NULL=E2=80=99
  112 |         return NULL;
      |                ^~~~
--=20
pw-bot: cr

