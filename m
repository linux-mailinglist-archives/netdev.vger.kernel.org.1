Return-Path: <netdev+bounces-45596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC837DE7EE
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 23:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B2E81C20CD2
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 22:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C791BDCF;
	Wed,  1 Nov 2023 22:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OYSWK1YF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A906E579
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 22:07:18 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F0F119;
	Wed,  1 Nov 2023 15:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KgzCwQKtlZ3s9s50rcNwyHCoDZfACulHcl3W84haDr4=; b=OYSWK1YF4X45HUwjA5CyXAzwr2
	/I4EiffvQhPEokY4fA6QF5iTIGSbLgS1U7eaPZ3xM5YUXoCWdnp7l+T9d39GuiTedyO9gyx0P9zrh
	H9xyPPmNIIHUpVljhJ4VYDhb3R/0m9rJp8J/aJRXg5auR8X7biR0ppHoyZF2vVMLhtSo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qyJMW-000i2r-4k; Wed, 01 Nov 2023 23:06:56 +0100
Date: Wed, 1 Nov 2023 23:06:56 +0100
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
Message-ID: <fe3ad92f-31d9-4509-b851-017218229e19@lunn.ch>
References: <20231030225446.17422-1-marcovr@selfnet.de>
 <9cb4f059-edea-4c81-9ee4-e6020cccb8a5@lunn.ch>
 <5414570.Sb9uPGUboI@5cd116mnfx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5414570.Sb9uPGUboI@5cd116mnfx>

On Wed, Nov 01, 2023 at 10:42:52PM +0100, Marco von Rosenberg wrote:
> On Tuesday, October 31, 2023 1:31:11 AM CET Andrew Lunn wrote:
> > Are we talking about a device which as been suspended? The PHY has
> > been left running because there is no suspend callback? Something then
> > triggers a resume. The bootloader then suspends the active PHY? Linux
> > then boots, detects its a resume, so does not touch the hardware
> > because there is no resume callback? The suspended PHY is then
> > useless.
> 
> Hi Andrew,
> 
> thanks for your feedback. I guess a bit of context is missing here. The issue 
> has nothing to do with an ordinary suspension of the OS. The main point is 
> that on initial power-up, the bootloader suspends the PHY before booting 
> Linux. With a resume callback defined, Linux would call it on boot and make the 
> PHY usable.

Ah, so you rely on phy_attach_direct() calling phy_resume(phydev).

This seems an odd way to solve the problem. It was not Linux which
suspend the PHY, so using resume is asymmetric.

I think soft_reset() or config_init() should be taking the PHY out of
suspend.

	Andrew

