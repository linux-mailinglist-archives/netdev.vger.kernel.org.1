Return-Path: <netdev+bounces-47808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B96287EB6D2
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 20:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A4E8B209B8
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 19:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A48221362;
	Tue, 14 Nov 2023 19:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wtpZKlfQ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93231D684;
	Tue, 14 Nov 2023 19:20:26 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC4D10D;
	Tue, 14 Nov 2023 11:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gcFuzhS4Y89nin+Ez8I8h+eMETjNYpCd8P8kVLFp7fM=; b=wtpZKlfQsknhUG1J3/ghW8+P3x
	0DFjap4K/Rq+BQuyJud5WbVx3pB+s1kUJTBg3dfxtX9LE7vMfEv+1WtyOOh5qhP6/O33X9ErsL6x2
	abYTqVORgZtrHShba1f8pU/f5Ks3B7R0A+IjrmCRHiVieUSQ4v1JvNxl/JFzKhGagY2c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r2yxP-000BXj-QX; Tue, 14 Nov 2023 20:20:19 +0100
Date: Tue, 14 Nov 2023 20:20:19 +0100
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
	Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH net-next v3 6/8] net: phy: add calibration callbacks to
 phy_driver
Message-ID: <c60c5723-0386-47cb-8135-f36c3208c302@lunn.ch>
References: <20231114105600.1012056-1-romain.gantois@bootlin.com>
 <20231114105600.1012056-7-romain.gantois@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114105600.1012056-7-romain.gantois@bootlin.com>

On Tue, Nov 14, 2023 at 11:55:56AM +0100, Romain Gantois wrote:
> The IPQESS integrated Ethernet switch found in the IPQ4019 SoC requires
> calibration of the PHY link when its ports are brought up. This calibration
> procedure requires knowledge of precise timings and vendor-specific
> registers on both the PHY and MAC side.
> 
> The existing PHY abstraction layer does not allow coordinating this kind of
> calibration operation between MAC drivers and PHY drivers. As a
> consequence, PHY-specific calibration information has to be included in
> Ethernet drivers, since it has to schedule the entire calibration procedure
> on it's own.
> 
> Add two callbacks that extend the PHY abstraction layer to allow MAC
> drivers to start and stop PHY calibration runs in a PHY-model-independent
> manner.

When adding new APIs, you need to add an example of both sides of
it. We can then decide if the API makes sense. I don't see a PHY
driver implementing this API.


    Andrew

---
pw-bot: cr

