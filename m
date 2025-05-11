Return-Path: <netdev+bounces-189550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5CCAB2989
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 18:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97A9918974D7
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 16:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6344325B1DC;
	Sun, 11 May 2025 16:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nVgnMzQq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A790219E8;
	Sun, 11 May 2025 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746980937; cv=none; b=oHi6fiLS4r9NuXPIjqWhwtdcyHucdzs6a3IC0Y2OPTBWVdlt0Vv1OYztAWEgsDjnYOzvUztYOqS0VERBKKzBW061FsCvkghmvOq61OX/T5mM0IqIWj59vheowrm9kql94ZKX08Y7jbdyEpHHb4jfYhWtczjWunqQdtg+/cpusj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746980937; c=relaxed/simple;
	bh=A8vZFKnCSu4vBom4UjxNtK2aLZLxMmQ6qXACDT1kgF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htRkKQX64tIxwSlgunzd1pln1WDt60xWM2TjfvNvC7RBPt5DxP3RYqN8OD6OldABPjpJkVY5F8vbgebZZrmeVGcJJdfxgxrWIYVDjqLd/qd7TW9RBa+y/mr7LjGp3QSWBNuI+azr97nGr2nU6edAQX1WVbQZdyUqXFBVk2swHYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nVgnMzQq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mn34+aBjpz+mpyZ8/TjtYHeQxAKDEeoodXqicYun3dY=; b=nVgnMzQqoZEoRdDgLmy9BoeIPD
	C1LeyQeIZ92tbw8E9ZL4PMWlii/b4hek0CJh5Qq44eEZUGeEOut/EJUlzJ626asoREi3BFaOCU8mb
	H2D3HWHyo4mc7nvo0J+T5oj/lKPxe1RFmpeTa81IY91aI5gUA6aK65w4N10D5UGPL4jo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uE9XZ-00CGED-0q; Sun, 11 May 2025 18:28:37 +0200
Date: Sun, 11 May 2025 18:28:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Michael Klein <michael@fossekall.de>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v8 5/6] net: phy: Add support for Aeonsemi
 AS21xxx PHYs
Message-ID: <7e8b6fc7-b587-4b89-a71c-bbd23e33f6d4@lunn.ch>
References: <20250510220556.3352247-1-ansuelsmth@gmail.com>
 <20250510220556.3352247-6-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250510220556.3352247-6-ansuelsmth@gmail.com>

> +++ b/drivers/net/phy/Kconfig
> @@ -117,6 +117,18 @@ config AMCC_QT2025_PHY
>  	help
>  	  Adds support for the Applied Micro Circuits Corporation QT2025 PHY.
>  
> +config AS21XXX_PHY
> +	tristate "Aeonsemi AS21xxx PHYs"

nitpick: This file is sorted by tristate. That means Aeonsemi comes
before Airoha.

With that fixed: Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

---
pw-bot: cr

