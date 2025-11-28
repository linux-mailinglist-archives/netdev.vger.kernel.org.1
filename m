Return-Path: <netdev+bounces-242615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A48C92E99
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 19:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9493A349091
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 18:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A467A25DB12;
	Fri, 28 Nov 2025 18:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fte2PfQN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E0B212560;
	Fri, 28 Nov 2025 18:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764354782; cv=none; b=ihWQ+JZuDUSqmsfBXD5OaAreYmoZlf01CUvoDVve7Ra6HSpsVsVLF1bmOZ1SaOEmDL/P9DGeM4qO1Kh7VD9GKrqsLff/AoppzCfb+6MODt7TeNPzXzO9g8ESW/gnuYVu4DH9m9nWwRnEgQFE2h21Rvt9617gqZGOTqhYASEL6lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764354782; c=relaxed/simple;
	bh=zoxtJ3wW8oomHZJuWGOP4H2VUNawjRovcLtgvwttqGE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HA0plolAVzfWl89iH5VB+7XCUEgN/utbLzerRUboPkqZv2/DS1sMWj56KsZUwrGiST2KyD0CHcd3/RGeP2zJjZ40nzYcAI4K9PEv9IzD9swtk227HmxxtZxvyEekT1OT507IBHNL92yCu4ACnUuqHcfzp5ZW/mQWpjCflQeOBeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fte2PfQN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A4AC4CEF1;
	Fri, 28 Nov 2025 18:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764354782;
	bh=zoxtJ3wW8oomHZJuWGOP4H2VUNawjRovcLtgvwttqGE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fte2PfQN/gNtT3L8sKtRkk4UEDEIf4wMyk41bEr5OqLfhg1gkQAluFgT4OQu9w/jA
	 g0YCBGDJ0mICWXd3ciyJMY0N1Ufm5Q1wX5H6yeECoARaTdMRBkOtzzzLa64oijtLbT
	 fwBx9Ra68cFat64sClwIc+V/35n+E8IlQALcrMf18lUjnNzOOeJA1ytt61ig3Zigzi
	 um4aczXE0L4AQ3VFCGMtJFjxg4M5x2c2chhbVaXZJ9lS4jpdFujIME57w5pcT/oz9t
	 sUqfXHNVCPMoleEXG3q5CTuE0j0VHj6B2a7Y/OgyZWUPHZ2wkjWJdiRZ1QzWlsErew
	 XZlYIea3dFZpA==
Date: Fri, 28 Nov 2025 10:32:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Andrew Lunn
 <andrew@lunn.ch>, Vladimir Oltean <vladimir.oltean@nxp.com>, Alexei
 Starovoitov <ast@kernel.org>, Eric Dumazet <edumazet@google.com>, Rob
 Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Donald
 Hunter <donald.hunter@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Jonathan Corbet <corbet@lwn.net>, John Fastabend
 <john.fastabend@gmail.com>, Lukasz Majewski <lukma@denx.de>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
 <jiri@resnulli.us>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Divya.Koppera@microchip.com, Kory Maincent <kory.maincent@bootlin.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
 Sabrina Dubroca <sd@queasysnail.net>, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de, Krzysztof Kozlowski <krzk+dt@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next v8 1/1] Documentation: net: add flow control
 guide and document ethtool API
Message-ID: <20251128103259.258f6fa5@kernel.org>
In-Reply-To: <aSljeggP5UHYhFaP@pengutronix.de>
References: <20251119140318.2035340-1-o.rempel@pengutronix.de>
	<20251125181957.5b61bdb3@kernel.org>
	<aSa8Gkl1AP1U2C9j@pengutronix.de>
	<aSj6gM_m-7ZXGchw@shell.armlinux.org.uk>
	<aSj_OxBzq_gJOb4q@shell.armlinux.org.uk>
	<aSljeggP5UHYhFaP@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Nov 2025 09:55:22 +0100 Oleksij Rempel wrote:
>  * **Constraint Checking:**
>  *   Drivers MUST accept a setting of @autoneg (true) even if generic
>  *   link autonegotiation ('ethtool -s / --change') is currently disabled.
>  *   This allows the user to pre-configure the desired policy for future
>  *   link modes.

!? I pointed out so many times that this contradicts the long standing
recommendation.

Can you please tell me what is preventing us from deprecating pauseparam
API *for autoneg* and using linkmodes which are completely unambiguous.
And allows the user to "pre configure" the advertisement.

The pause set API should remain primarily for forced mode configuration.
Perhaps the move is to make it read only for new drivers when aneg is
turned on?

