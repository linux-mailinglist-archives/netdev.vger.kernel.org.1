Return-Path: <netdev+bounces-139548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BBB9B2FCD
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 13:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7486C1C23AA4
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 12:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBC61D8E01;
	Mon, 28 Oct 2024 12:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YIXMk8qQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1E7191473;
	Mon, 28 Oct 2024 12:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730117382; cv=none; b=k2eYU+OkjorebQRZKKuUeIr1xDRoclcssWKt101xOIhga2aAwbszRIq+vP+EFa4ad6UjQrl1ckOAPpu6Y+FQXXE6NtQuVzc65Zv93mJA2/jroUWx6froGbgLiAau5fK3xH97UHYq3Oymebz78d4XInCaYt5ewLk2tDKOwRscZHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730117382; c=relaxed/simple;
	bh=fK2IXJy2VZ3QCaoolLLoxazc2YINSfOzH9FKkNf/Z8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejzNr162oI4ZK3qgic6tIu/nWWreG0TOOfSJeno0eOChQC5ZTlOoE3wHTP6dixcytBQh0aLb/9/TgpiOFuU06ckJ8KS6th66aFLbrEgiA41OvcIwJJID/gM4aJeZTXDDcpsXkWw9LmB0zIadLjQKpOyBMs2yp2pkfhbI37+RtyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YIXMk8qQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6eShjMnOThAZ8kH4hDkZ/XzsEZlENyuw7raM9myBmys=; b=YIXMk8qQ7njTy+zHS5eHh/ga8V
	odoDYmVecdx9B9k/UrA2+PICMdGTlzhSVc1GkvdA7dwtAsQZrA3txeaBeKdaZP8DW5/+8R4SAcCRn
	CWhsKKe0OBns7hPNB91j9U8AmyGZ8l0UGM6D+mHot104uBgKEVDMUHOfUx0CdUwPzuzE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t5OYr-00BROn-Mg; Mon, 28 Oct 2024 13:09:29 +0100
Date: Mon, 28 Oct 2024 13:09:29 +0100
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
Subject: Re: [PATCH net-next v1 4/5] net: dsa: microchip: cleanup error
 handling in ksz_mdio_register
Message-ID: <4c4bc951-8007-479e-95e2-6b9d1153ddcd@lunn.ch>
References: <20241026063538.2506143-1-o.rempel@pengutronix.de>
 <20241026063538.2506143-5-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026063538.2506143-5-o.rempel@pengutronix.de>

On Sat, Oct 26, 2024 at 08:35:37AM +0200, Oleksij Rempel wrote:
> Replace repeated cleanup code with a single error path using a label.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

