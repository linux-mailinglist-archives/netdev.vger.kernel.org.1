Return-Path: <netdev+bounces-18711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DB475856D
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 21:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3D3328170C
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 19:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3725F168DD;
	Tue, 18 Jul 2023 19:19:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2831B168BD
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 19:19:23 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74059198E;
	Tue, 18 Jul 2023 12:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XBARuUCyX6yvGo0grkLzkMPKrbLpwVIILWLCfgsXO0I=; b=UlyApqh0lmvL2xeIq14IGGi50q
	/yrJzsuqAkVMt6ILg6o6MpMkpj+52/aYapE2mB6AuZSrsq54aRAskDQYDA+k5cId2/+dbDZ3CIV/m
	uFee0yBfEndy+4a9x/eyzin6dkgEjtALsA/qtwGWCq1OPIRd7QyrztBBVNb0EZqcRLUc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qLqDj-001eLd-A7; Tue, 18 Jul 2023 21:18:51 +0200
Date: Tue, 18 Jul 2023 21:18:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Michael Walle <mwalle@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Xu Liang <lxu@maxlinear.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next v3 03/11] net: phy: replace is_c45 with
 phy_accces_mode
Message-ID: <6afc205e-b525-44df-b81b-ef7cfdfb6680@lunn.ch>
References: <20230620-feature-c45-over-c22-v3-0-9eb37edf7be0@kernel.org>
 <20230620-feature-c45-over-c22-v3-3-9eb37edf7be0@kernel.org>
 <509889a3-f633-40b0-8349-9ef378818cc7@lunn.ch>
 <ZLbRTLRbHW/Xt2hL@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLbRTLRbHW/Xt2hL@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 18, 2023 at 06:52:12PM +0100, Russell King (Oracle) wrote:
> On Tue, Jul 18, 2023 at 07:40:49PM +0200, Andrew Lunn wrote:
> > >  static inline bool phy_has_c45_registers(struct phy_device *phydev)
> > >  {
> > > -	return phydev->is_c45;
> > > +	return phydev->access_mode != PHY_ACCESS_C22;
> > >  }
> > 
> > So this is making me wounder if we have a clean separation between
> > register spaces and access methods.
> > 
> > Should there be a phy_has_c22_registers() ?
> 
> Yes, I've been wondering that. I've recently heard about a Realtek PHY
> which is supported by our realtek driver, but appears on a SFP that
> can only do C45 accesses. However, the realtek driver is written to
> use C22 accesses to this PHY - and the PHY supports both. So currently
> it doesn't work.
>
> That's just an additional data point for thinking about this, I haven't
> formulated a solution to it yet.

That kind of sounds like two drivers. Or two drivers in one .c
file. Do you know what C45 IDs it has? Same as the C22? If it is
different, each could have its own struct phy_driver.

	   Andrew

