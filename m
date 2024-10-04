Return-Path: <netdev+bounces-132255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A29AD991229
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 00:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C83BB1C22EEF
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE7A1ADFFB;
	Fri,  4 Oct 2024 22:11:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707F21ADFE4;
	Fri,  4 Oct 2024 22:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728079874; cv=none; b=mTbhKFaxMF94BNyJXh07l/DmGl+uRmO0wi7G22ou4eiS6V9hSY3M9LoNoR0qe3wpQXMaltfjAQbxIhQG77ibwOFMVpTKiCdnf1l36gvhW1K0u9IrGPKXxLcSHHty0XFA+RDZbGcYPAiNILa3fvVmDjWua/+w5geEEHEFtWRLlY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728079874; c=relaxed/simple;
	bh=2jN9COZV+RfQ5JCy7SR2iumGCeccDQIodJiNLVQYI9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uObVVxIU4lgoRKctNbaInJwoM73T62oE0FQo/6M2L2WNwpE/r1vNRs45UD/lIws2hSXP0+ODarw90s9a1fGt1bxyHnRRI2TOLH/4i7gsrbDC/s2PNF1BI60BwWare1+Dx9qk6bQDlvQaZUBCr89ab2hQzGOX5h7XJfNeYvA9q4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1swqVv-000000001M8-0b5i;
	Fri, 04 Oct 2024 22:11:07 +0000
Date: Fri, 4 Oct 2024 23:11:04 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next] net: phy: always set polarity_modes if op
 is supported
Message-ID: <ZwBn-GJq3BovSJd4@makrotopia.org>
References: <473d62f268f2a317fd81d0f38f15d2f2f98e2451.1728056697.git.daniel@makrotopia.org>
 <5c821b2d-17eb-4078-942f-3c1317b025ff@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c821b2d-17eb-4078-942f-3c1317b025ff@lunn.ch>

On Fri, Oct 04, 2024 at 10:59:45PM +0200, Andrew Lunn wrote:
> On Fri, Oct 04, 2024 at 04:46:33PM +0100, Daniel Golle wrote:
> > Some PHYs drive LEDs active-low by default and polarity needs to be
> > configured in case the 'active-low' property is NOT set.
> > One way to achieve this without introducing an additional 'active-high'
> > property would be to always call the led_polarity_set operation if it
> > is supported by the phy driver.
> 
> It is a good idea to state why it is RFC. What comments do you want?
> 
> [...]
> I think adding an active-high property is probably the safest bet,
> even if it is more work.

Thank you. Exactly that was the clarification I was looking for:
If absence of "active-low" would mean "active-high" or should be
interpreted as "don't touch".

I'll add "active-high" as an additional property then, as I found out
that both, Aquantia and Intel/MaxLinear are technically speaking
active-low by default (ie. after reset) and what we need to set is a
property setting the LED to be driven active-high (ie. driving VDD
rather than GND) instead. I hope it's not too late to make this change
also for the Aquantia driver.

