Return-Path: <netdev+bounces-139550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B85A9B2FD2
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 13:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E473CB23914
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 12:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029A21DBB13;
	Mon, 28 Oct 2024 12:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="c2mWlBFg"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B511D7982;
	Mon, 28 Oct 2024 12:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730117409; cv=none; b=DbWllTkB9JS42PVG/H/1qGqaMsiQKc3cOCpjrZaKgPxQN9o0/KjHvz4Way0AStd4gSj9USjMlty1DhNAa8S4f61+Bz37anJg6LgW/ViarBID6QjNAEl6Xfzu2yJnGe0SvxRwvR1idkpbXDyI2rdVdNhcqknDhFSWSUgkyIbUBnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730117409; c=relaxed/simple;
	bh=PVQtlV4H+QsScox6KfoJ7jqd1+pGRd1gqCh8Yjrow1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uG5XmeTLyNlJrUZPzQyO7Y9m05Y/2hXfUfHnM99e4RlvoXjDLdKNZbLNVPxw/OZeWuWE52+KRFPS8RNV0eie8C8KqLSxA4oxwSrhtWJ8n6LuM2PEXQuM4vFO0x+EFLzSgOWs3Y7BkKsbQrN/OXzGGD+Qua1Pzg6xaUnMBrUxACM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=c2mWlBFg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/p4h6ktea/EimcSUjDOsklu3heEWy/psrnRW6kirqmE=; b=c2mWlBFgmx8oxtXstdVqAKUVFx
	jN1SqWA40V6GUwovRcci3Z2THLuGKqiYnyXfy4yioqA52niy2CVPe1UA8eTWdcrsGpPSSfRgA9Ehb
	7QOWKa/S/rNFVy6PJ3FNrKdYTa4mGZ2YiDddrhiuoG+xg/RQUMMXDeEQkUlVBMv0RtRk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t5OZK-00BRPf-CC; Mon, 28 Oct 2024 13:09:58 +0100
Date: Mon, 28 Oct 2024 13:09:58 +0100
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
Subject: Re: [PATCH net-next v1 2/5] dt-bindings: net: dsa: ksz: add
 mdio-parent-bus property for internal MDIO
Message-ID: <8195337c-e925-4c17-9764-e6241263cc4b@lunn.ch>
References: <20241026063538.2506143-1-o.rempel@pengutronix.de>
 <20241026063538.2506143-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026063538.2506143-3-o.rempel@pengutronix.de>

On Sat, Oct 26, 2024 at 08:35:35AM +0200, Oleksij Rempel wrote:
> Introduce `mdio-parent-bus` property in the ksz DSA bindings to
> reference the parent MDIO bus when the internal MDIO bus is attached to
> it, bypassing the main management interface.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

