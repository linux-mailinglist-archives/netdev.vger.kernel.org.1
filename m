Return-Path: <netdev+bounces-139549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 229749B2FD0
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 13:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3297B24845
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 12:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421881D9587;
	Mon, 28 Oct 2024 12:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TWUwtJai"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6781D935F;
	Mon, 28 Oct 2024 12:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730117398; cv=none; b=p3z2+UP3JRsV9Q+38uB09cJurZEqoGq9gj1DhYy0p7nxu/HTuPjGXP7ecUK2jE/xwD9bEmtKpRupnI0b5t0MVddOH9+wZwi6OMsYVHS4UsxK7CkDMBUlg/Q5rCW9NDGvxA00GPNRWLexT8NMs4YNrB7ka85iyYa9g6txAol3+f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730117398; c=relaxed/simple;
	bh=ulRfMGas/Too2S0QoU+QK4yqvZF70qRLNOiL0xvY2vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MId02mASJ76GUvnqil8+c96d6nWY0bgbbAhtSKItwvzZmpG+l01/1FrpSnm4bMxyPp4BNt7Li7LZ2dn8rc5tN9uZxkX5tdLZcnHEe1O5E5LO09iyNifOuQfCUbd2QEYTIdD3CLznwWPHvIj3Y8gzpxUYuRT0YVNgBmoHupj+g0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TWUwtJai; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RxqxUcBWJwkT3VjvNoscQnSWTMTtgmvWGQ6F86HHfxM=; b=TWUwtJaiWHwe9vl3gpm8DXexk+
	lWNyaJ7lwZshQH0ioDcePzCsZcSSSlqPflTtE3Kj4cEfBwZJrWBPNIgyyzhoyzWAC5HmCJXsjxB0o
	P8W0V0ak/sWqkJac0+kJZPRIQTp5t7yY7oIMMHoUSDOlRCkvdCSmOExpJf4kfOQ79pF4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t5OZ8-00BRPE-Fx; Mon, 28 Oct 2024 13:09:46 +0100
Date: Mon, 28 Oct 2024 13:09:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/5] dt-bindings: net: dsa: ksz: add internal
 MDIO bus description
Message-ID: <3df6b15e-ec47-4eec-b0fa-5911400e6b2e@lunn.ch>
References: <20241026063538.2506143-1-o.rempel@pengutronix.de>
 <20241026063538.2506143-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026063538.2506143-2-o.rempel@pengutronix.de>

On Sat, Oct 26, 2024 at 08:35:34AM +0200, Oleksij Rempel wrote:
> Add description for the internal MDIO bus, including integrated PHY
> nodes, to ksz DSA bindings.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

