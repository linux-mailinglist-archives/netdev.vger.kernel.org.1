Return-Path: <netdev+bounces-181367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAA1A84ACF
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 19:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8033B8B9B
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 17:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F101EF377;
	Thu, 10 Apr 2025 17:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ex3mprEF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E56C1E9B38;
	Thu, 10 Apr 2025 17:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744305502; cv=none; b=ZIvijkRGnVhrDXvCA+zcYohHKVuwX1NQ8LvT6KtvWm7QsHu0MR43cHwMmwlLA8uz0yaXnMq1ds2yQ2S0s0eyV0Bjdhin+7KBf4copA5jZ3mRgYEIb/QpHHnKhJHpQuf/qwZPKtR4nyh5lK7x1XlgfLrElxaGYcPQ1WKlhVNE1Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744305502; c=relaxed/simple;
	bh=LYuPFryOJZFAuFWo6bmehKK7q5WhgKAnRO5BUTMYnHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWlw3WrSoNT5gsITpM207LOXMsKrvJZ6nsfLveOas5v3yDQ5L9ZrOQ9V/8q3hNRX6nfio2zYZkH0oJMv9CP98JCZSpE8hWx0ufxem7c2WKVAScRufy3OJdvWh5dEp6NNpbquzeigI5so6BecM6zKQYLWhbI+W/sYxEMIWO2jvmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ex3mprEF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ADaVs8RIq509XWF1XqpgqWYK2X74IiqnFiI1FqiLiq8=; b=ex3mprEFji1dKNZIt7B10OGMvu
	NrHuYL6xJfArmKtW2dF2xpOXvFIJTyci9s4HCwB3xFJifOxaoGjvKG0Ll9izJRC7+8E+xX2ZNl9Bm
	BcaDLLFQbtvPiHs4j/5RwfpNSsrGoilbx1PfUf1Owj2fzqosuHkVUJQHGuSFGAXwrAVM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u2vXO-008i7f-4S; Thu, 10 Apr 2025 19:18:02 +0200
Date: Thu, 10 Apr 2025 19:18:02 +0200
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
Subject: Re: [net-next PATCH v14 06/16] net: mdio: regmap: prepare support
 for multiple valid addr
Message-ID: <6f29a01d-35da-4d51-b309-a1799950a707@lunn.ch>
References: <20250408095139.51659-1-ansuelsmth@gmail.com>
 <20250408095139.51659-7-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408095139.51659-7-ansuelsmth@gmail.com>

On Tue, Apr 08, 2025 at 11:51:13AM +0200, Christian Marangi wrote:
> Rework the valid_addr and convert it to a mask in preparation for mdio
> regmap to support multiple valid addr in the case the regmap can support
> it.

I think it would be good to pull these MDIO regmap patches out into a
series of their own. We know there is a user, so i'm happy for us the
accept it without that user. But this code needs further discusion,
which will be irrelevant for the switch.

       Andrew

