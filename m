Return-Path: <netdev+bounces-241730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2670FC87D02
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 03:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C74923A570F
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 02:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35812701BB;
	Wed, 26 Nov 2025 02:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/YFTX4w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BB828E0F;
	Wed, 26 Nov 2025 02:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764123601; cv=none; b=gjFWG2s+eUWgRqZycirlsEyfSPs4HbCSUlszZicm88BbSarsi8IsLhjT2FIlgCXXnpg2WGqQBEQ4EjoGzsKclibKFT9kAm6csh0qEN0qy1KxFMHWoaUMEQsl5whY3hVrnDG994n3zs5elN3L+YBTXfVu7thKW9CnhS7rmwXm6cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764123601; c=relaxed/simple;
	bh=CpcqGYrc7qKTq9bsj68eusyRjOLLiP4OPeuWlDEVREw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LToFUqgC/I4zsvZ/0eh6TRfWSXeEY23Pcy7SI40Ysla4eAjPrSZlpTTBhuC4QT8mBU7ZgsT8eHgNqBcCZtO5m2PyelpYQxz0XFI/SueCQs+pTARbD/N4i8YLhlbk2b6AB0xVOCsW+l1rqS2ASxcJWuQ1WLf0HSTTAopn73++z0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/YFTX4w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD53C4CEF1;
	Wed, 26 Nov 2025 02:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764123600;
	bh=CpcqGYrc7qKTq9bsj68eusyRjOLLiP4OPeuWlDEVREw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F/YFTX4wpDv9jkreUlnBgX0eioTgpd8NHey1c15dyE/lFSvn3sOrz4FGVqWijfE5T
	 0UnsnUBir/o5v/xGAUqCsKETUFiCzQS99RHqNj0S/VyJut3s58wLbQSHcncrCxXK5y
	 ZKM3mzt/7qhPDjymzO93j2QkpnP8y5QxI8LUvtzu4bpuvCP6kc46L2qyPSdA8qqT2e
	 l6apL8Ysl13SeeiwHxivXn01q1IJ6v1V66ZpuiAfzm3nd7qQW7Y3F+WlI/0q/o3ajD
	 Obr7zy+L8zVYM+08cbvCWbMF6Lzz3x53kOl54cWYwF//xsdxBnZ5/z9leNkp99YshC
	 2VQ8waGoSPBUw==
Date: Tue, 25 Nov 2025 18:19:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Florian
 Fainelli <f.fainelli@gmail.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Lukasz Majewski <lukma@denx.de>, Jonathan Corbet <corbet@lwn.net>, Donald
 Hunter <donald.hunter@gmail.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Jiri Pirko <jiri@resnulli.us>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Russell King
 <linux@armlinux.org.uk>, Divya.Koppera@microchip.com, Sabrina Dubroca
 <sd@queasysnail.net>, Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next v8 1/1] Documentation: net: add flow control
 guide and document ethtool API
Message-ID: <20251125181957.5b61bdb3@kernel.org>
In-Reply-To: <20251119140318.2035340-1-o.rempel@pengutronix.de>
References: <20251119140318.2035340-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Nov 2025 15:03:17 +0100 Oleksij Rempel wrote:
> +Kernel Policy: "Set and Trust"
> +==============================
> +
> +The ethtool pause API is defined as a **wish policy** for
> +IEEE 802.3 link-wide PAUSE only. User requests express the preferred
> +configuration, but drivers may reject unsupported combinations and it
> +may not be possible to apply a request in all link states.
> +
> +Key constraints:
> +
> +- Link-wide PAUSE is not valid on half-duplex links.
> +- Link-wide PAUSE cannot be used together with Priority-based Flow Control
> +  (PFC, IEEE 802.1Q Clause 36).
> +- Drivers may require generic link autonegotiation to be enabled before
> +  allowing Pause Autonegotiation to be enabled.
> +
> +Because of these constraints, the configuration applied to the MAC
> +may differ from the user request depending on the active link mode.
> +
> +Implications for userspace:
> +
> +1. Set once (the "wish"): the requested Rx/Tx PAUSE policy is
> +   remembered even if it cannot be applied immediately.
> +2. Applied conditionally: when the link comes up, the kernel enables
> +   PAUSE only if the active mode allows it.

This section is quite confusing. Documenting the constrains make sense
but it seems like this mostly applies to autoneg on. Without really
saying so. Plus the get behavior.. see below..

> + * @get_pauseparam: Report the configured policy for link-wide PAUSE
> + *      (IEEE 802.3 Annex 31B). Drivers must fill struct ethtool_pauseparam
> + *      such that:
> + *      @autoneg:
> + *              This refers to **Pause Autoneg** (IEEE 802.3 Annex 31B) only
> + *              and is part of the link autonegotiation process.
> + *              true  -> the device follows the negotiated result of pause
> + *                       autonegotiation (Pause/Asym);
> + *              false -> the device uses a forced MAC state independent of
> + *                       negotiation.
> + *      @rx_pause/@tx_pause:
> + *              represent the desired policy (preferred configuration).
> + *              In autoneg mode they describe what is to be advertised;
> + *              in forced mode they describe the MAC state to apply.

How is the user supposed to know what ended up getting configured?
Why do we need to configure autoneg via this API and not link modes directly?

> + *      Drivers should reject a non-zero setting of @autoneg when
> + *      autonegotiation is disabled (or not supported) for the link.

I think this belong in the @set doc below..

> + *      If generic autonegotiation is disabled, pause autonegotiation is
> + *      treated as disabled/inactive.
> + *
> + * @set_pauseparam: Apply a policy for link-wide PAUSE (IEEE 802.3 Annex 31B).
> + *      If @autoneg is true:
> + *              Arrange for pause advertisement (Pause/Asym) based on
> + *              @rx_pause/@tx_pause and program the MAC to follow the
> + *              negotiated result (which may be symmetric, asymmetric, or off
> + *              depending on the link partner).
> + *      If @autoneg is false:
> + *              Do not rely on autonegotiation; force the MAC RX/TX pause
> + *              state directly per @rx_pause/@tx_pause.
> + *
> + *      Implementations that integrate with PHYLIB/PHYLINK should cooperate
> + *      with those frameworks for advertisement and resolution; MAC drivers are
> + *      still responsible for applying the required MAC state.
> + *
> + *      Return: 0 on success or a negative errno. Return -EOPNOTSUPP if
> + *      link-wide PAUSE is unsupported. If only symmetric pause is supported,
> + *      reject unsupported asymmetric requests with -EINVAL (or document any
> + *      coercion policy).
> + *
> + *      See also: Documentation/networking/flow_control.rst

