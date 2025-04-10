Return-Path: <netdev+bounces-181423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29515A84EDE
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 22:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6521B62EF0
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 20:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EE7290BC5;
	Thu, 10 Apr 2025 20:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="icN/Z1BF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF92290BD5;
	Thu, 10 Apr 2025 20:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744318619; cv=none; b=aM4hMCYe9EDcsCvpk6ufaIPgOIhRvdbWR3alzCdLlRbdpOOp+oDXoAbJCQy+WNNLArgODYtPFuh5Nd6xn/4g/akoooGSde6jm9NmrngWErwaqTB42tKLjfhO+5HF6e6SQzmdJMX3j8No82RmqQbcW246Sjjusq7ZbsfwbyxqbYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744318619; c=relaxed/simple;
	bh=gjRlPSDk+HP4s4FGm5gbcf/CmugeuOqJPfC/yVVpyyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcZoCHHbD1KlaVpQRRM0zxtW1G1KOKh8izeBJC2O6fKHvS/Eijwvj9hT/21NcuqjA0gZYsTSsnlECtPF5ZnzevqgvqEKokhNEiG+C/KJJRDR23TIIS9/IC5dm06atYk90U1VsVgoZUTnayTSffUwXNp7ukMYxmRl6iKiYQ/aS+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=icN/Z1BF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OpP8724RjBuTtHqPoOQEYb+UxkeI+0f3hSg/HwAnRco=; b=icN/Z1BFMHxh7eIZg8j2CW4tVW
	hHIGaaBjnmXtwawWDpVZLt1mP/C20pZ3xlQkC948V6q2MhQSSSK7Tru1fr0GAbOlCQSK7+Z4DfRQm
	nWs1pZ21+QvE3vOvDVz97G4MfajtZDrGmk5nOCpaXAqwNOwo4BNWzW3ORkg97kBvJPww=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u2ywq-008jEk-I3; Thu, 10 Apr 2025 22:56:32 +0200
Date: Thu, 10 Apr 2025 22:56:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Simon Horman <horms@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v14 07/16] net: mdio: regmap: add support for
 C45 read/write
Message-ID: <5472c608-df78-4433-a086-6ac9323d9d35@lunn.ch>
References: <20250408095139.51659-1-ansuelsmth@gmail.com>
 <20250408095139.51659-8-ansuelsmth@gmail.com>
 <50c7328d-b8f7-4b07-9e34-6d7c34923335@lunn.ch>
 <67f80275.df0a0220.39b09a.dd38@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67f80275.df0a0220.39b09a.dd38@mx.google.com>

> Hope you can give some guidance about this! Happy to split this once we
> find a common point on how to proceed with this.

One thing i'm failing to understand is, why use a regmap at all. For a
single C22 device it make sense. 32 linear registers, nice and
simple. They could be memory mapped, I2C addresses, SPI addresses,
etc. The regmap implementer probably just adds a constant offset and
does a hardware access.

Multiple C22 devices gets us into a two dimensional problem. Multiple
C45 devices gives us a three dimensional problem. Mixing multiple C22
and C45 gets us a four dimensional problem. This is a long way from
regmaps nice simple model of linear registers.

What does regmap bring here?

	Andrew

