Return-Path: <netdev+bounces-122861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70947962D84
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 18:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 258211F25846
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 16:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF271A38D5;
	Wed, 28 Aug 2024 16:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="d24hCijP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5F844C68;
	Wed, 28 Aug 2024 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724861954; cv=none; b=rdcYfYW75d19oIXGjX3WNTx/wcCPTiS6JY/m/CYDMwCpXKjo4Anq6sUA0TSaG/ZxCNxNlGDeXgSTXvWK4tsXFLNaKcm29nym9zuvsDte3ftSTBUX7C9phCVlzOdnFUd+CoHtj0wxlyNYgvf4++/T9MWYvZ8SHrJ5UFo0tEx2xY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724861954; c=relaxed/simple;
	bh=7FOCNAkyb18q93EUQmESrW55Nul8uNlZ55KN2G2hiS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMqi7Y2hdEhY2QiK5YvqRmV6LzIz3sl4eSxoXKLoyFlsH3wp6C1zZro2t30vltPngfgf0G1uUk2mp6OkMH5HHIG97J/tJNYM2XwwJc3To6OJpLw7caIvzVGT8X+whUS/mHqYaTpMb2h6/Ag2mQaDOrSJq5ByzoY/795mN+72zjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=d24hCijP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=B55QGb3XeN8Sx1Nn0BNu8uirRXJNjaPTVSPXKaoyBqQ=; b=d24hCijPlIeMFQarbZVB30f8uy
	q0EPYtvV5nIEB+0uc5E5OuI9uDQ56c6ME/2XExsD9By2mTFC0QbiFIfRRueAHnE+LAmgbMKxXr5gX
	xi0YvGW7nc+ORsu9EqceUf29ZQk7+DTF3N7U7Jc7x6NzufAprezdBGbR2yfGn1gZuD3w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sjLNr-005xEt-R4; Wed, 28 Aug 2024 18:18:59 +0200
Date: Wed, 28 Aug 2024 18:18:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Wilkins, Stephen" <Stephen.Wilkins@teledyne.com>
Cc: Conor Dooley <conor@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	"valentina.fernandezalanis@microchip.com" <valentina.fernandezalanis@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next] net: macb: add support for configuring eee via
 ethtool
Message-ID: <08d191dd-bc70-4292-8031-d1d41036e731@lunn.ch>
References: <20240827-excuse-banister-30136f43ef50@spud>
 <3c5a3db5-a598-454e-807a-b5106008aa40@lunn.ch>
 <AM0PR04MB41316B50F68C83A73E57A82F89952@AM0PR04MB4131.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB41316B50F68C83A73E57A82F89952@AM0PR04MB4131.eurprd04.prod.outlook.com>

On Wed, Aug 28, 2024 at 03:47:21PM +0000, Wilkins, Stephen wrote:
> Thanks for the feedback.
> 
> In my particular use-case I wanted to ensure the PHY didn't advertise EEE
> support, as it can cause issues in our deployment environment. The problem I
> had was the PHY we are using enables EEE advertisement by default, and the
> generic phy support in phy_device.c reads the c45 registers and enables EEE if
> there are any linkmodes already advertised. Without the phylink hook in macb, I
> couldn't use ethtool to disable it, but I now see my patch is only a partial
> solution and would also imply support that is missing. That's why code reviews
> are important. Maybe I need an alternative approach for ensuring the PHY
> advertising is disabled if the MAC layer support is missing. 

In this particular case, do you know what is causing you problems?

I agree that if the MAC does not support EEE, the PHY should not be
advertising it. But historically EEE has been a mess. It could be the
MAC does EEE by default, using default settings, and the PHY is
advertising EEE, and the link partner is happy, and EEE just works. So
if we turn advertisement of EEE off by default, we might cause
regressions :-(

Now, we know some PHYs are actually broken. And we have a standard way
to express this:

Documentation/devicetree/bindings/net/ethernet-phy.yaml

  eee-broken-100tx:
    $ref: /schemas/types.yaml#/definitions/flag
    description:
      Mark the corresponding energy efficient ethernet mode as
      broken and request the ethernet to stop advertising it.

  eee-broken-1000t:
    $ref: /schemas/types.yaml#/definitions/flag
    description:
      Mark the corresponding energy efficient ethernet mode as
      broken and request the ethernet to stop advertising it.

If you know this MAC/PHY combination really is broken, not that it is
just missing support for EEE, you could add these properties to your
device tree.

Otherwise, you do a very minimal EEE implementation. After connecting
to the PHY call phy_ethtool_set_eee() with everything in data set to
0. That should disable adverting of EEE.

	Andrew

