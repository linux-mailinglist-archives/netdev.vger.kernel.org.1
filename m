Return-Path: <netdev+bounces-43894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DB37D53B5
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 16:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 264BCB20F0D
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 14:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5522C841;
	Tue, 24 Oct 2023 14:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rWlyXo8G"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD41125DE;
	Tue, 24 Oct 2023 14:13:36 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C628BC4;
	Tue, 24 Oct 2023 07:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LujRB2KkoptvHOhbGnAbkakhiZEXdCUqv3MjVD+tulI=; b=rWlyXo8GlvY1ir1QYjbv5qDoI6
	KSCEVXw+uUUcokg0iCHGjSY9Clf9WajxbGl7qkrSbglTiEAbMdvK4VJcnzvFEYmDEqqStPFqcJ0mB
	M2zjpVs6/8QZSVY96GCTzEG8ywExi3XbbHofwRMPWy5VdwY1xYypKx5mO5x1CgG0jVCU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qvI9y-0004zL-Em; Tue, 24 Oct 2023 16:13:30 +0200
Date: Tue, 24 Oct 2023 16:13:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: davem@davemloft.net, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Luka Perkov <luka.perkov@sartura.hr>,
	Robert Marko <robert.marko@sartura.hr>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 4/5] net: ipqess: add a PSGMII calibration
 procedure to the IPQESS driver
Message-ID: <4bde9110-c88d-4a22-8e67-e788db4673f3@lunn.ch>
References: <20231023155013.512999-1-romain.gantois@bootlin.com>
 <20231023155013.512999-5-romain.gantois@bootlin.com>
 <df71bbe5-fec0-45cc-adb4-acfbcc356ba3@lunn.ch>
 <9d447cb5-c8f9-06d2-0909-2870d57f0f7a@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d447cb5-c8f9-06d2-0909-2870d57f0f7a@bootlin.com>

> Yes, I'll add more detailed comments to the code in the v2. The calibration 
> procedure itself targets the PSGMII device, which is internal to the SoC and can 
> be logically accessed as a PHY device on the MDIO bus. This component is a 
> little opaque and has some nonstandard MII register definitions.
> 
> The "testing" phase that follows the calibration accesses both the internal 
> QCA8K switch ports and the external QCA8075 PHY. For example, it puts both the 
> switch ports and the PHY ports in loopback before starting packet generation on 
> the external PHYs. This is done to verify that the PSGMII link works correctly 
> after being calibrated.
> 
> So this code interacts with both internal ESS devices and external PHYs, but 
> mostly the former, which is why I kept everything in the MAC/switch driver.

Accessing the external PHYs i would suggest go over the normal phylib
API. Somebody might build a board using a different PHY, with
different registers. If all you need is loopback, there is a phylib
call for that.

Directly accessing the internal ESS is fine, it cannot be changed, but
if there are phylib helpers which do the same thing, consider using
them.

     Andrew

