Return-Path: <netdev+bounces-13116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8545F73A53C
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 17:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C125E2819E0
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 15:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAEF1F94E;
	Thu, 22 Jun 2023 15:43:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1278E1DCB0
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 15:43:37 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDB8135
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 08:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2xEg5GEvHIKM4hUlaMsHfUzM7qeGVG+hSwMwQ9+hv3M=; b=sj/pIQSv6pHmvr8rvEIKyzuMEX
	m9V+G2qHab6N6V2yg9UHVL3XJSW3Uel+GMLIkO0hLMGNY+4yDQiOflAob1kMAEgxyBWeYUPo82K9R
	dZC3usTt5SUrKfJYvzC3b+8RYGxLGVTlRVzR4lI/7cHX6gEREW+ZJOO3pRbsC6wJ+Kqs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qCMT8-00HHMf-6A; Thu, 22 Jun 2023 17:43:34 +0200
Date: Thu, 22 Jun 2023 17:43:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev <netdev@vger.kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Oleksij Rempel <linux@rempel-privat.de>
Subject: Re: [PATCH v4 net-next 7/9] net: phy: Add phy_support_eee()
 indicating MAC support EEE
Message-ID: <d37a3f46-e92e-4ac0-aee0-b9f3638a3b93@lunn.ch>
References: <20230618184119.4017149-1-andrew@lunn.ch>
 <20230618184119.4017149-8-andrew@lunn.ch>
 <6951e7fa-a922-c498-9bb9-eaae5f47faaf@gmail.com>
 <ZJRmvIldnyYBbBYa@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJRmvIldnyYBbBYa@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > > + * Efficient Ethernet. This should be called before phy_start() in
> > > + * order that EEE is negotiated when the link comes up as part of
> > > + * phy_start(). EEE is enabled by default when the hardware supports
> > > + * it.
> > > + */
> > > +void phy_support_eee(struct phy_device *phydev)
> > > +{
> > > +	linkmode_copy(phydev->advertising_eee, phydev->supported_eee);
> > > +	phydev->eee_cfg.tx_lpi_enabled = true;
> > > +	phydev->eee_cfg.eee_enabled = true;
> > > +}
> > > +EXPORT_SYMBOL(phy_support_eee);
> > 
> > A bit worried that naming this function might be confusing driver authors
> > that this is a function that reports whether EEE is supported, though I am
> > not able to come up with better names.
> 
> Possibly phy_enable_eee_support() ?

As i said in the commit message, i followed what we do for pause:

void phy_support_sym_pause(struct phy_device *phydev);
void phy_support_asym_pause(struct phy_device *phydev);

but phy_enable_eee_support() is less ambiguous.

    Andrew



