Return-Path: <netdev+bounces-45893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 986837E02A6
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 13:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27BF1B212C0
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 12:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB1E15E90;
	Fri,  3 Nov 2023 12:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VQasqY3J"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA8515ADE
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 12:14:23 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D842D44;
	Fri,  3 Nov 2023 05:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uGWXOxmGU6DijpJJLAD9Go42xjGlOch3s+DAI+XWLI0=; b=VQasqY3JRsMGSCiXl/ygTaJTha
	d5TgpVFRabepseEvnzDZ+yjcH/AVdGfAWz+X4svsx2o7AsV09fm+JfCLbQ6kmndwJpQC+kh1YuigU
	VJnRJF/GzPjWOgT3ic/S+Kv7gpk2yLz9Aam8jtk5sv4to969wcoIh5F7IbN72hbSAZBE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qyt3j-000oOe-Vj; Fri, 03 Nov 2023 13:13:55 +0100
Date: Fri, 3 Nov 2023 13:13:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Marco von Rosenberg <marcovr@selfnet.de>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: broadcom: Wire suspend/resume for BCM54612E
Message-ID: <6d45f4da-c45e-4d35-869f-85dd4ec37b31@lunn.ch>
References: <20231030225446.17422-1-marcovr@selfnet.de>
 <5414570.Sb9uPGUboI@5cd116mnfx>
 <fe3ad92f-31d9-4509-b851-017218229e19@lunn.ch>
 <4890615.31r3eYUQgx@5cd116mnfx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4890615.31r3eYUQgx@5cd116mnfx>

On Fri, Nov 03, 2023 at 02:47:38AM +0100, Marco von Rosenberg wrote:
> On Wednesday, November 1, 2023 11:06:56 PM CET Andrew Lunn wrote:
> > On Wed, Nov 01, 2023 at 10:42:52PM +0100, Marco von Rosenberg wrote:
> > > On Tuesday, October 31, 2023 1:31:11 AM CET Andrew Lunn wrote:
> > > > Are we talking about a device which as been suspended? The PHY has
> > > > been left running because there is no suspend callback? Something then
> > > > triggers a resume. The bootloader then suspends the active PHY? Linux
> > > > then boots, detects its a resume, so does not touch the hardware
> > > > because there is no resume callback? The suspended PHY is then
> > > > useless.
> > > 
> > > Hi Andrew,
> > > 
> > > thanks for your feedback. I guess a bit of context is missing here. The
> > > issue has nothing to do with an ordinary suspension of the OS. The main
> > > point is that on initial power-up, the bootloader suspends the PHY before
> > > booting Linux. With a resume callback defined, Linux would call it on
> > > boot and make the PHY usable.
> > 
> > Ah, so you rely on phy_attach_direct() calling phy_resume(phydev).
> > 
> > This seems an odd way to solve the problem. It was not Linux which
> > suspend the PHY, so using resume is asymmetric.
> > 
> > I think soft_reset() or config_init() should be taking the PHY out of
> > suspend.
> 
> I agree with all of your points. This is just one way which happens to solve
> this specific problem. Of course it might be asymmetric to see the patch as
> a solution to my problem. However is there anything fundamentally wrong with
> adding suspend/resume callbacks?

No, there is nothing wrong with that at all, if you want to support
suspend/resume. I do however see that as a different use case to what
you describe as your problem. It fixing your problem is more of a side
effect.

We can go with this fix, but please change your justification in the
commit message. Also, its unlikely, but resume could be made
conditional in phy_attach_direct(), and you would then be back to a
broken PHY on boot. Fixing this in config_init() is the correct way
for your use case.

       Andrew

