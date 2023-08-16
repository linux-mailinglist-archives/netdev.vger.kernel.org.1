Return-Path: <netdev+bounces-27862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7AA77D7AB
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 03:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C7D82813EA
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 01:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EB464C;
	Wed, 16 Aug 2023 01:29:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA03392
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 01:29:42 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4527D211E;
	Tue, 15 Aug 2023 18:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bfS5LUD1zjNYyRIJC4f8khPclEuBDPMUL6qQTc/jqQQ=; b=3ZSJBcsKSY/X08DUQ2pvtDMl2D
	wMlCaoIUKDtLZBsnTGd8gcDrfFyA5ZwLnb425Rx0PQsV+W9rY1V2rr53hqeH5JhM/hwsBDvMj0oBb
	EQri7hFRHvLSsMwfqDtygaF54/zWzJ356CdZiODqU6OqmVcJu0i+o04t3uaQDGgWjDag=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qW5Lg-004Dsk-8j; Wed, 16 Aug 2023 03:29:24 +0200
Date: Wed, 16 Aug 2023 03:29:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc: "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
	"simon.horman@corigine.com" <simon.horman@corigine.com>,
	"Verdun, Jean-Marie" <verdun@hpe.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] net: hpe: Add GXP UMAC MDIO
Message-ID: <8f68f1dc-1841-4d28-b0b5-d968b1950e81@lunn.ch>
References: <20230802201824.3683-1-nick.hawkins@hpe.com>
 <20230802201824.3683-3-nick.hawkins@hpe.com>
 <0b227994-2577-4a74-b604-79410f5607b8@lunn.ch>
 <75F51B6F-A477-4A2B-B40F-1CC894546CF2@hpe.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75F51B6F-A477-4A2B-B40F-1CC894546CF2@hpe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 16, 2023 at 12:55:56AM +0000, Hawkins, Nick wrote:
> Greetings Andrew,
> 
> I have a follow up question below:
> 
> >> +static int umac_mdio_read(struct mii_bus *bus, int phy_id, int reg)
> >> +{
> >> + struct umac_mdio_priv *umac_mdio = bus->priv;
> >> + unsigned int status;
> >> + unsigned int value;
> >> + int ret;
> >> +
> >> + status = __raw_readl(umac_mdio->base + UMAC_MII);
> >> +
> >> + status &= ~(UMAC_MII_PHY_ADDR_MASK | UMAC_MII_REG_ADDR_MASK);
> >> + status |= ((phy_id << UMAC_MII_PHY_ADDR_SHIFT) &
> >> + UMAC_MII_PHY_ADDR_MASK);
> >> + status |= (reg & UMAC_MII_REG_ADDR_MASK);
> >> + status |= UMAC_MII_MRNW; /* set bit for read mode */
> >> + __raw_writel(status, umac_mdio->base + UMAC_MII);
> >> +
> >> + status |= UMAC_MII_MOWNER; /* set bit to activate mii transfer */
> >> + __raw_writel(status, umac_mdio->base + UMAC_MII);
> 
> 
> > I assume UMAC_MII_MOWNER must be set in a separate operation? But
> > using __raw_writel() i'm not sure there is any barrier between the two
> > writes.
> 
> Is there a function you would recommend using instead?

writel().

In general, it is best to use writel()/readl() for correctness. In the
hot path, dealing with actually Ethernet frames where every uS counts,
you can then think about using writel_relaxed()/readl_relaxed(). But
for something slow like an MDIO bus driver, i would always avoid the
possibility of having hard to find bugs because of missing barriers.

	Andrew

