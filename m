Return-Path: <netdev+bounces-215571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFCEB2F4C3
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 12:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0907217FDE5
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 09:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FDC2E040E;
	Thu, 21 Aug 2025 09:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Sq1KoDHi"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CB22DC332;
	Thu, 21 Aug 2025 09:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755770380; cv=none; b=Oj5bFAMG1bhvsQN0qwxzyT8/fPpTrGfpuYBP0d49mG/eiZOeYmvtBpIsQsJz3BAyg5xl9ekl6y0P7qhhdcrsqSr5/t1aWNlLOWsHKpQ1FlwycouDkmDsJUUKiawbxuxOeju6Fa0Qbfe+wj/sl439S/ofULrCAdIvDqRC3qhsiyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755770380; c=relaxed/simple;
	bh=qqfVWCXciiPUVUyqqSDg0kOjI471fKmQt+rEZPSTbtI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fUr6ae8dviJ7LfhfHtSbLTc8bivWcUDMkRprw6XbFDB2ENdRCG28KGilqXe28yQmmdmHsyBJM8OUxRngXvlk8FyfQPzGhmmicKBeg3PeolhGRiznrrTLjEkzt9ofLVKtcTr8yvzJ3gtt03TccQK5mrrJd1CszIBGO51Iok5Comw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Sq1KoDHi; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B1C8BC653FE;
	Thu, 21 Aug 2025 09:59:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5D20360303;
	Thu, 21 Aug 2025 09:59:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 82EB21C2286DB;
	Thu, 21 Aug 2025 11:59:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1755770366; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=UXi3DuBgIr4bBk+OUpKFphqn8o2nLKh/CMmHtgGF9Ug=;
	b=Sq1KoDHi/UohzLYwq/XWgHG0gAKsV6rpOpsg7pr33SMwgfiY0vZ0boZ4yz3YEYYgRzyKS/
	pUSMhe3blqZ0TD5DLm6e9sSF6WCMkb/hfByUdvLyFze1A4LdV1/D/odwP77jYaJB7tDY3R
	QtIU0YlLGKXpnx2hqjJHS9kXeSWw4zZB0Y9t1cd7Y5G6z97X2aCNVTd8ZcuYGIkJZit+cI
	p9eLlKgCNbCxlzsHnshouapV+6bIBw2iLSk6OCX4zCLYgkiokFvOkvIeaJRaMKleWR2qL8
	1Jc7ayVwFDbm0nVNIqu2qPmP7Hl6yWos3fIttJaMChrkPF0TH6oi87kYJu+PFg==
Date: Thu, 21 Aug 2025 11:59:14 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, Nishanth Menon
 <nm@ti.com>, kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
 linux-doc@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>, Roan van Dijk
 <roan@protonic.nl>
Subject: Re: [PATCH net-next v4 2/5] ethtool: netlink: add
 ETHTOOL_MSG_MSE_GET and wire up PHY MSE access
Message-ID: <20250821115830.3a231885@kmaincent-XPS-13-7390>
In-Reply-To: <20250821091101.1979201-3-o.rempel@pengutronix.de>
References: <20250821091101.1979201-1-o.rempel@pengutronix.de>
	<20250821091101.1979201-3-o.rempel@pengutronix.de>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello Oleksij,

Le Thu, 21 Aug 2025 11:10:58 +0200,
Oleksij Rempel <o.rempel@pengutronix.de> a =C3=A9crit :

> Introduce the userspace entry point for PHY MSE diagnostics via
> ethtool netlink. This exposes the core API added previously and
> returns both configuration and one or more snapshots.
>=20
> Userspace sends ETHTOOL_MSG_MSE_GET with an optional channel
> selector. The reply carries:
>   - ETHTOOL_A_MSE_CONFIG: scale limits, timing, and supported
>     capability bitmask
>   - ETHTOOL_A_MSE_SNAPSHOT+: one or more snapshots, each tagged
>     with the selected channel
>=20
> If no channel is requested, the kernel returns snapshots for all
> supported selectors (per=E2=80=91channel if available, otherwise WORST,
> otherwise LINK). Requests for unsupported selectors fail with
> -EOPNOTSUPP; link down returns -ENOLINK.
>=20
> Changes:
>   - YAML: add attribute sets (mse, mse-config, mse-snapshot) and
>     the mse-get operation
>   - UAPI (generated): add ETHTOOL_A_MSE_* enums and message IDs,
>     ETHTOOL_MSG_MSE_GET/REPLY
>   - ethtool core: add net/ethtool/mse.c implementing the request,
>     register genl op, and hook into ethnl dispatch
>   - docs: document MSE_GET in ethtool-netlink.rst
>=20
> The include/uapi/linux/ethtool_netlink_generated.h is generated
> from Documentation/netlink/specs/ethtool.yaml.
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

...

> +MSE Configuration
> +-----------------
> +
> +This nested attribute contains the full configuration properties for the=
 MSE
> +measurements
> +
> +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =
=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +  ETHTOOL_A_MSE_CONFIG_MAX_AVERAGE_MSE             u32     max avg_mse s=
cale
> +  ETHTOOL_A_MSE_CONFIG_MAX_PEAK_MSE                u32     max peak_mse =
scale
> +  ETHTOOL_A_MSE_CONFIG_REFRESH_RATE_PS             u64     sample rate (=
ps)
> +  ETHTOOL_A_MSE_CONFIG_NUM_SYMBOLS                 u64     symbols per s=
ample
> +  ETHTOOL_A_MSE_CONFIG_SUPPORTED_CAPS              bitset  capability bi=
tmask
> +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =
=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D +

Why did you remove the kernel doc identifiers to phy_mse_config?
It was useful for the documentation.

> +MSE Snapshot
> +------------
> +
> +This nested attribute contains an atomic snapshot of MSE values for a
> specific +channel or for the link as a whole.
> +
> +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =
=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +  ETHTOOL_A_MSE_SNAPSHOT_CHANNEL                   u32     channel enum =
value
> +  ETHTOOL_A_MSE_SNAPSHOT_AVERAGE_MSE               u32     average MSE v=
alue
> +  ETHTOOL_A_MSE_SNAPSHOT_PEAK_MSE                  u32     current peak =
MSE
> +  ETHTOOL_A_MSE_SNAPSHOT_WORST_PEAK_MSE            u32     worst-case pe=
ak
> MSE
> +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =
=3D=3D=3D=3D=3D=3D

Same question here for phy_mse_snapshot.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

