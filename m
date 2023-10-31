Return-Path: <netdev+bounces-45420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA3E7DCD2F
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 13:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6BE41C20C3B
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 12:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6861FA4;
	Tue, 31 Oct 2023 12:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mUwNs9bt"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8811108;
	Tue, 31 Oct 2023 12:48:27 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C2F98;
	Tue, 31 Oct 2023 05:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uu3dorM1BwNO7ya/P4sr4zNZu6tWr377yz93OprYyw4=; b=mUwNs9bthnmDK8zfD2uE+xv02/
	N5tjiEKrgRwmzte3T9A5K7ee6Gm1W4BcRFmGW3gU6PvB28hhl41eQk1NxEIvsYqd+OYQRoYZKR//X
	KxTfVG/GLBaovLfusRrgH1QYusfbNNNd6oqqNvoptisVMo2Re6ZUrMdjX766o5MaeJEI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qxoAE-000c2y-Dx; Tue, 31 Oct 2023 13:48:10 +0100
Date: Tue, 31 Oct 2023 13:48:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban.Veerasooran@microchip.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	corbet@lwn.net, Steen.Hegelund@microchip.com, rdunlap@infradead.org,
	horms@kernel.org, casper.casan@gmail.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Horatiu.Vultur@microchip.com,
	Woojung.Huh@microchip.com, Nicolas.Ferre@microchip.com,
	UNGLinuxDriver@microchip.com, Thorsten.Kummermehr@microchip.com
Subject: Re: [PATCH net-next v2 5/9] net: ethernet: oa_tc6: implement
 internal PHY initialization
Message-ID: <c67b0e57-b87b-45cd-b3fd-be11b0670b0d@lunn.ch>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <20231023154649.45931-6-Parthiban.Veerasooran@microchip.com>
 <5c240b3b-60c2-45bb-8861-e3a8de28d00f@lunn.ch>
 <7873124e-d7b2-4983-9be3-f85865d46de2@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7873124e-d7b2-4983-9be3-f85865d46de2@microchip.com>

> >> +             tc6->mdiobus = mdiobus_alloc();
> >> +             if (!tc6->mdiobus) {
> >> +                     netdev_err(tc6->netdev, "MDIO bus alloc failed\n");
> >> +                     return -ENODEV;
> >> +             }
> >> +
> >> +             tc6->mdiobus->phy_mask = ~(u32)BIT(1);
> > 
> > Does the standard define this ? BIT(1), not BIT(0)?
> Ok, I think here is a typo. Will correct it.

There is still the open question, does the standard define this? If
not, a vendor might decide to use some other address, not 0. So it
might be better to not set a mask and scan the whole bus.
phy_find_first() should then work, no matter what address it is using.

	Andrew

