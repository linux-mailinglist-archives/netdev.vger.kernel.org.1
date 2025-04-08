Return-Path: <netdev+bounces-180319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 581E2A80EEE
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 16:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4C0D1BA62A8
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 14:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D41F1DF99C;
	Tue,  8 Apr 2025 14:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSMi+sI6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571261B6CE5;
	Tue,  8 Apr 2025 14:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744123850; cv=none; b=Xfm3AgpghcPGAW8x3X86IvNRrH+joONuFMR+87e7cHnwo/Dsw/MoP1ZHbeDcjnXVE/lCC1CuWYzsacxT6pcwwF3UaTuaFqSbMKg+Vr1y5n4A2s4Jmms5fJzLUpe7qrlpx8gg4fSdzfyG7gUv2LRBIA+AOx4t0slnwSP3qSPZKJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744123850; c=relaxed/simple;
	bh=iippsYe8qLb/2X9/I9NX6d/fzC9lDY7Hh/+44sczz4g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GOTPjnP0bdLaMceaM9YEhfPBd6btnj+0ZSqlxy/rwfMXjvlrjyy6/VKqFsbJGnF7xI68s3cS+6sJ7DfCn/yb01JVIErdq58W3goerRPmeM/77TbjVGhwwXV5cZv/6wzwgxu+JirMn9fZnTubZI/DTO4C2iQMeDxV9XdNVAGMuRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSMi+sI6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2297AC4CEE5;
	Tue,  8 Apr 2025 14:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744123849;
	bh=iippsYe8qLb/2X9/I9NX6d/fzC9lDY7Hh/+44sczz4g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NSMi+sI6BfxNdjGVuI7k1YPEEB3cI1ZteuMz/i77RX6ZKVVtc7G5wTT1aSxozuebA
	 XMflo8Dg43jH0NMQTNts8wq5qxJk/KX2JwIt/jhxJDVCZ4nfBlEdutImR4Y8TcCGYr
	 a/LZp8xVwK5rZ8s5TpytyreXMUjrkSIDT3dfjZA+mKTMjzNxb00w63F9LCi2sDaXhM
	 TIDpgJYw9Skn+WXlBrEQ6c6lH13pqYKgkqZjUgH+ju6TbeV8JhlZv2pzeLBH9H8w9a
	 hApED5WPIbOVRA8ssP34+b8l6uizHChdo0YvbYvAoSbbprKSYOk6daNln8naVIVuOY
	 ngrqmh3HwUXXQ==
Date: Tue, 8 Apr 2025 07:50:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, upstream@airoha.com, Christian Marangi
 <ansuelsmth@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, Kory
 Maincent <kory.maincent@bootlin.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Clark Wang <xiaoning.wang@nxp.com>, Claudiu
 Beznea <claudiu.beznea@microchip.com>, Claudiu Manoil
 <claudiu.manoil@nxp.com>, Conor Dooley <conor+dt@kernel.org>, Ioana Ciornei
 <ioana.ciornei@nxp.com>, Jonathan Corbet <corbet@lwn.net>, Joyce Ooi
 <joyce.ooi@intel.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Madalin
 Bucur <madalin.bucur@nxp.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Radhey Shyam Pandey
 <radhey.shyam.pandey@amd.com>, Rob Herring <robh+dt@kernel.org>, Rob
 Herring <robh@kernel.org>, Robert Hancock <robert.hancock@calian.com>,
 Saravana Kannan <saravanak@google.com>, UNGLinuxDriver@microchip.com,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [net-next PATCH v2 00/14] Add PCS core support
Message-ID: <20250408075047.69d031a9@kernel.org>
In-Reply-To: <20250407231746.2316518-1-sean.anderson@linux.dev>
References: <20250407231746.2316518-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon,  7 Apr 2025 19:17:31 -0400 Sean Anderson wrote:
> This series depends on [1,2], and they have been included at the
> beginning so CI will run. However, I expect them to be reviewed/applied
> outside the net-next tree.

These appear to break the build:

drivers/acpi/property.c:1669:39: error: initialization of =E2=80=98int (*)(=
const struct fwnode_handle *, const char *, const char *, int,  unsigned in=
t,  struct fwnode_reference_args *)=E2=80=99 from incompatible pointer type=
 =E2=80=98int (*)(const struct fwnode_handle *, const char *, const char *,=
 unsigned int,  unsigned int,  struct fwnode_reference_args *)=E2=80=99 [-W=
incompatible-pointer-types]
 1669 |                 .get_reference_args =3D acpi_fwnode_get_reference_a=
rgs,   \

Could you post as RFC until we can actually merge this? I'm worried=20
some sleep deprived maintainer may miss the note in the cover letter
and just apply it all to net-next..
--=20
pw-bot: cr

