Return-Path: <netdev+bounces-68834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AECA84875E
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 17:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C773C1F23557
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 16:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8965F56E;
	Sat,  3 Feb 2024 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TEPwgOwC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C095F54F
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 16:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706977053; cv=none; b=BO39mzE26TwUp7f8MNoS+yJpOhsXaZ3dE06wJSSXt6utHgbGhNs9/6V9H52sdKJGAOzFj0he4k4O6sqEr8lbYcMueZTMGjpVq9uAM/E+aTGpsah8dXPby6szVRNPOyqAnbXK/arvkATtldkWionig1xJGVySdYgdVUlpgT+XZ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706977053; c=relaxed/simple;
	bh=4Er5TVAUaBg/NoR8Nsi9zgLpOJG6U+80kAOwlxXnDy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V62i9caND+egx283kCiTWdyL/fE8MDmZKqjAtpmmjLKIhHqol+25Ox98mXjzEei9+AqnpSYCRzy00WDboiWcjg93/oIFf5tErET5fg8/uks3DyYN0rPR61aY6NNZEn4qyLfCNom+ALidUnH7192O1u0MqhtqpiPeDXqPt0RlIUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TEPwgOwC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+6kadNR76S1Xq5LFQ/4uGTgX85i2jjJmbpVKQJ3Ewa0=; b=TEPwgOwCzC47TPRpBH8L1VQOiT
	UPpQouqQ2dsgSPzEr+SIksjKwfz/mrLX+suTNClMgsfV5svYh0m7dDZCfeXEghkHf9CrBV+OeYZOc
	gomB1VV7pCGGvEk57GPoKwEPSEJqYiZXuddhlZoFPZ+579W+83z532E0869wMelnGnP4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rWIhn-006ubQ-Fj; Sat, 03 Feb 2024 17:17:23 +0100
Date: Sat, 3 Feb 2024 17:17:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Realtek linux nic maintainers <nic_swsd@realtek.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] r8169: use new helper phy_advertise_eee_all
Message-ID: <66df869b-fd7d-453f-93a1-cd68b358889e@lunn.ch>
References: <14ee6c37-3b4f-454e-9760-ca41848fffc2@gmail.com>
 <4a963539-80f9-4e85-9731-b41281eafc63@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a963539-80f9-4e85-9731-b41281eafc63@gmail.com>

On Sat, Feb 03, 2024 at 12:21:05PM +0100, Heiner Kallweit wrote:
> Use new helper phy_advertise_eee_all() to simplify the code.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

