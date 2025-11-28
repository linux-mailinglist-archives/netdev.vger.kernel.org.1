Return-Path: <netdev+bounces-242462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 911CCC907AF
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 02:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3FC8734DBC9
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 01:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8AD207DF7;
	Fri, 28 Nov 2025 01:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ok+ds5L5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15BC6A33B;
	Fri, 28 Nov 2025 01:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764292901; cv=none; b=JWfpjThT+AkCV+SoEpjWt5MtMogzLKrTUMRecWKG5MEcs4t9/MZ9HdyiAU7D84JsyQJ3mSjajBMJEGyrtkxx/Dr8PLyD04PiLTBMmOUn2SgA3QQKyImCZRuH7rC1YbV3hn6s3qGUR01/K12g3ZvV1j6Hn7aJN0uR40QcsPqRw/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764292901; c=relaxed/simple;
	bh=vi+R73dniB1Wr54wJaEcDwuZlYn7UjMXzgUkFkXI2To=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mZacxH+RB2lE386OYvH53ziU3O+7HUN8H5AQTgQEdtsuhSdxC4/Iyrri7e/Lc1TOmD0bIxIDLnt9X46etth0gHMcttKaatqNN3pr+UkOwhgv6UjT4XfGyvKpDmG4IA40vQ5odGoxjPonCjlf4WjRZ1yvXCL4W4crGf9UMs7ZM6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ok+ds5L5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F16C4CEF8;
	Fri, 28 Nov 2025 01:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764292901;
	bh=vi+R73dniB1Wr54wJaEcDwuZlYn7UjMXzgUkFkXI2To=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ok+ds5L5wqUqJc5Y5m/BonhGZr5g2Ajtdpdp7Gpi2hk1HG4zV+sA5pKZTrQkPblft
	 lLUAQbAmRMOLtirjC1vMj+NL2r6Ah1VlqbkKoOlIk3az8m2IdjKfxeeGa2chZAWb9s
	 P5ZLDCNryp8g226tvbTJuXLDE02Tcj547u47ZvO5uogplO1iaWMNlmiSqHDEi8jwsO
	 IqyJrHs0BLYc3GR645B7Ulp2XoY6L0HBR6I0StBowEJ6LjaFvPqWUtyOX0q7XgvD1D
	 Nt835HiW8dFInw5MV7IL5H+cgQ53njXZnBAqwfI7NuSPGFUeU8/RJfhSP7jYCOiLdA
	 9x0YumbxDkH1Q==
Date: Thu, 27 Nov 2025 17:21:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Alexei Starovoitov
 <ast@kernel.org>, Eric Dumazet <edumazet@google.com>, Rob Herring
 <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Donald Hunter
 <donald.hunter@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Jonathan
 Corbet <corbet@lwn.net>, John Fastabend <john.fastabend@gmail.com>, Lukasz
 Majewski <lukma@denx.de>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Divya.Koppera@microchip.com, Kory
 Maincent <kory.maincent@bootlin.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org, Sabrina Dubroca
 <sd@queasysnail.net>, linux-kernel@vger.kernel.org, kernel@pengutronix.de,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next v8 1/1] Documentation: net: add flow control
 guide and document ethtool API
Message-ID: <20251127172139.5b4c34d0@kernel.org>
In-Reply-To: <aSh411Hogj3O4VT5@shell.armlinux.org.uk>
References: <20251119140318.2035340-1-o.rempel@pengutronix.de>
	<20251125181957.5b61bdb3@kernel.org>
	<aSa8Gkl1AP1U2C9j@pengutronix.de>
	<20251126144225.3a91b8cc@kernel.org>
	<aSgX9ue6uUheX4aB@pengutronix.de>
	<7a5a9201-4c26-42f8-94f2-02763f26e8c1@lunn.ch>
	<aSh411Hogj3O4VT5@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Nov 2025 16:14:15 +0000 Russell King (Oracle) wrote:
> > >  *	**Constraint Checking:**
> > >  *	Drivers should reject a non-zero setting of @autoneg when
> > >  *	autonegotiation is disabled (or not supported) for the link.
> > >  *	Drivers should reject unsupported rx/tx combinations with -EINVAL.  
> 
> Definitely not. Drivers should accept autoneg=1 because that is the
> user stating "my desire is to use the result of autonegotiation when
> it becomes available". Just because autoneg may be disabled doesn't
> mean it will remain disabled, and having to issue ethtool commands
> in the right sequence leads to poor user experiences.

It's an existing recommendation, coming from 6a7a1081cebacc4.
I thought it's just because of the ambiguity what the settings mean
with autoneg on or off. But looks like Ben has been trying to push
people towards link mode bits 11 years ago already :(

