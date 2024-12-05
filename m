Return-Path: <netdev+bounces-149254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 038909E4E74
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 08:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFDDD18820B8
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 07:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B7B1B395D;
	Thu,  5 Dec 2024 07:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nmZGsgMg"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B651E2770C;
	Thu,  5 Dec 2024 07:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383958; cv=none; b=ib9Eg6IJCyxDM0T3psRptdY3VSBRqkvUsKHQDj6FmSnHPPNNReX1Y+XUrCuVBOFG4PNos4rBbyF1X4lsBnMSx2iD0H1FD0rY3zewQ/KMgkpnxKZIinosZW0doloWP5xkB/Wec6bOrzOg6umqnY8bcHWwLwonT/Pi/FdWd7py2Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383958; c=relaxed/simple;
	bh=8v8rNpYCt5+w7TUoucBk34CLs31HOmkIcLaBdCmdwzE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=snjg1AVVlT98yVZ+IAaypRNlouSI7n2N7bpiW4vxMDp6xcyMuFhOj0tRIoz5sTj6DLSEizfy/sfOTKnuf4c6WSo/A5ZNxIMlauEr78ZxjKaV+B2mVqVIueKAimluLlVCWO6NhD/JaEeUIPrglHFGoE63NhslytONhlr71uBNMjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nmZGsgMg; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C9EE81BF205;
	Thu,  5 Dec 2024 07:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733383953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M0uLzqoQedwirIumfnvNOpR0fEO9z6ZDDUf+XyF2k1c=;
	b=nmZGsgMgcL7R2GwptET0jTVmXpIGp030DPZr91xtkvYkN7Cbhgn+5o+k/w1uiDcxUXRUBb
	nQYNI5q+lXq8jiij00dhkF2LhqUP7QVd2YKMZYxDP+jOlVvf+XU3SqoZKb0Fe50G8cjOF8
	atXyTQKUbVvykP+QLV+cQQHbv4M17sRbuYYn8S1GEko7Fz9Z1mwj1gVUtDJOhuvnQcAdau
	cC38FReuOum3xlUvIBZOMB2WgEluDNL5/b3h2hddYkjpGg+JYIC7MzbKJqskeDLKgPL3pD
	74VL6NsE+0FVZ511rYCjBY1CSWT6eDrAOt5MDAosKIoaPMTllGDHFJlXFguk7Q==
Date: Thu, 5 Dec 2024 08:32:30 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Simon Horman
 <horms@kernel.org>, Herve Codina <herve.codina@bootlin.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next v3 09/10] net: freescale: ucc_geth: Introduce a
 helper to check Reduced modes
Message-ID: <20241205083230.2344d850@fedora.home>
In-Reply-To: <49fbbbf8-ec21-41a6-b87e-0172d0a4a2b3@lunn.ch>
References: <20241203124323.155866-1-maxime.chevallier@bootlin.com>
	<20241203124323.155866-10-maxime.chevallier@bootlin.com>
	<ce002489-2a88-47e3-ba9a-926c3a71dea9@lunn.ch>
	<20241204092232.02b8fb9a@fedora.home>
	<49fbbbf8-ec21-41a6-b87e-0172d0a4a2b3@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

On Wed, 4 Dec 2024 16:41:33 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> On Wed, Dec 04, 2024 at 09:22:32AM +0100, Maxime Chevallier wrote:
> > Hello Andrew,
> > 
> > On Wed, 4 Dec 2024 03:15:52 +0100
> > Andrew Lunn <andrew@lunn.ch> wrote:
> >   
> > > > +static bool phy_interface_mode_is_reduced(phy_interface_t interface)
> > > > +{
> > > > +	return phy_interface_mode_is_rgmii(interface) ||
> > > > +	       interface == PHY_INTERFACE_MODE_RMII ||
> > > > +	       interface == PHY_INTERFACE_MODE_RTBI;
> > > > +}    
> > > 
> > > I wounder if this is useful anywhere else? Did you take a look around
> > > other MAC drivers? Maybe this should be in phy.h?  
> > 
> > Yes I did consider it but it looks like ucc_geth is the only driver
> > that has a configuration that applies to all R(MII/GMII/TBI) interfaces  
> 
> O.K. What is important is you considered it. Thanks. Too many
> developers are focus on just their driver and don't think about other
> drivers and code reuse.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Thanks Andrew. I should have indicated that in the commit log or in the
cover in the first place though, I'll make sure to do it next time.

Maxime

