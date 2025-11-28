Return-Path: <netdev+bounces-242624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BA7C93183
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 21:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E7A7E4E2353
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 20:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84C32D46D6;
	Fri, 28 Nov 2025 20:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IhxrPbHV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875E723EAB6;
	Fri, 28 Nov 2025 20:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764361025; cv=none; b=fuq9/GjZtLI2vtXxEWpidH+flVnKXrjQ3veEq1DV7PyeXuBR3HceFU+27mKtIazfYAjcqGSTT4ddoIILTIPIjtI8jWCF2Ad/bOUATnSuNCqU6POaWHeUev/NQH7x8Zq5z2tM9UpgdHyE8VKuOEM/nn4fhjUpv950YuoiJp9YYmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764361025; c=relaxed/simple;
	bh=TbHc8WVx5t0nRUgChtSiDSAb6kSZvN9h/2LJRsToQ6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQTJw7rwrhH09U23wlgk/mfYP1oKeCo2MYH96tnSxw6O1lLcd+HcdWn+KhQ1/vtvCbMEwPAxsr2UTVLHfwCxi/Yg2NFqjIADML+RwIrjh3REJbMlJc/fFH3KMWol2dV/djqVaebWKOw7Y1PI+ylFoPenFmsqN0EbvBd7a6wqWek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IhxrPbHV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JEYc/YVM/hMRxtnN7C6IAGrnxoAmUnIY0muxFE1vXN0=; b=IhxrPbHVXkGhe+CrB3eWyYsoVW
	14HthCQMJZgZYFS0TIb7pNd+jIQB90YJeluher6y8H4VlQSvwhDju3B2QDv6jBrdENCF6U3hGMVPN
	mYST6EQZpXcueZnyT8yBzvbGj+hvEF4kFtdUaDmzyNYVYyYjZg8E7XdvI4fh0ApZwVWI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vP4tE-00FN1o-52; Fri, 28 Nov 2025 21:16:24 +0100
Date: Fri, 28 Nov 2025 21:16:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Rob Herring <robh@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jonathan Corbet <corbet@lwn.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Lukasz Majewski <lukma@denx.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Divya.Koppera@microchip.com,
	Kory Maincent <kory.maincent@bootlin.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next v8 1/1] Documentation: net: add flow control
 guide and document ethtool API
Message-ID: <63082064-44b1-42b0-b6c8-a7d9585c82f5@lunn.ch>
References: <20251119140318.2035340-1-o.rempel@pengutronix.de>
 <20251125181957.5b61bdb3@kernel.org>
 <aSa8Gkl1AP1U2C9j@pengutronix.de>
 <aSj6gM_m-7ZXGchw@shell.armlinux.org.uk>
 <aSj_OxBzq_gJOb4q@shell.armlinux.org.uk>
 <aSljeggP5UHYhFaP@pengutronix.de>
 <20251128103259.258f6fa5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128103259.258f6fa5@kernel.org>

> Can you please tell me what is preventing us from deprecating pauseparam
> API *for autoneg* and using linkmodes which are completely unambiguous.

Just to make sure i understand you here...

You mean make use of

        ETHTOOL_LINK_MODE_Pause_BIT             = 13,
        ETHTOOL_LINK_MODE_Asym_Pause_BIT        = 14,

So i would do a ksettings_set() with

__ETHTOOL_LINK_MODE_LEGACY_MASK(Pause) | __ETHTOOL_LINK_MODE_LEGACY_MASK(Asym_Pause)

to indicate both pause and asym pause should be advertised.

The man page for ethtool does not indicate you can do this. It does
have a list of link mode bits you can pass via the advertise option to
ethtool -s, bit they are all actual link modes, not features like TP,
AUI, BNC, Pause, Backplane, FEC none, FEC baser, etc.

	Andrew

