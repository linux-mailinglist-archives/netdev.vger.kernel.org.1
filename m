Return-Path: <netdev+bounces-134428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FA6999589
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 00:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E804F1F228B2
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 22:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02471E6DD5;
	Thu, 10 Oct 2024 22:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fSnWk9kx"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9146C14D6F9;
	Thu, 10 Oct 2024 22:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728600895; cv=none; b=t1Kq/9PRVY5F7eMmjQrxIrn/ohOsApMKb6CBpHF6XXlWZZX0Soee1xRyAMsOHtBpRUKz1et6opdPBb7393FIRBnWHzr2M/7LwhBu9LO9BCO/ulA3B4EjT/5wfhjcftJAmQ1kWLyAMFrymwgYXhLMVEzMnIQsOw0WxqpS6Bf70CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728600895; c=relaxed/simple;
	bh=AeKj0w4QZaKxaTInJPXEO48jpfE9/PG62cdNBaD/7sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VuwVKZEAs8QkMaRERfa0pC0SNEr/4/97cVtDwHQrfYyjRzc5hGGMR6pVFEO243L1cgyW0h8YwUaDeZrPR+bCGliH4vn6UpjcIQXqtUNMCM8XyLUgxtCOCVhEay9Yyb3FL0Lp//ZPxU+DWOTn++vuJYZ1gCLA/FaYGHQXLDODWRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=fSnWk9kx; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/2HRlr+d+n9aiIVGzasiFiHIdPkl/uH4AHL9pIOtGUI=; b=fSnWk9kxA9p77qhlmDIikCJh/y
	dQjyM6zuhuYk4lfLkZn9oPs4ssqLZPV/utEIhjwmTsMUdKooG7rAN39Y0kAIzl2i1gQqz55NcWU0n
	NP9zVzQXsFgdxpy115CEoKLL3Yg4B9WpDkIG3nDWKLNYq7JCzWi+bLW8oV7PD+AHNrtNx0iBA87Gs
	eCOGyf1YArkoxgKJqlUfwsy0u/Fg0VV+WQATfxP991NPzBawGczYkxILgxV3V7TvWCHtPgpQyxlpn
	mKIu9PxQexozBrvKffl0URa5nDGS3R5ETS1D61QPpz0sJltbuXBNk4Tiu7rnqTMHL3SLEAMJcr/zL
	kpgNf6cA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36678)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sz23K-0003CK-2I;
	Thu, 10 Oct 2024 23:54:38 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sz23H-0007gP-1x;
	Thu, 10 Oct 2024 23:54:35 +0100
Date: Thu, 10 Oct 2024 23:54:35 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Iulian Gilca <igilca1980@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, igilca@outlook.com,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: net: Add option for random mac address
Message-ID: <ZwhbK_QKm8oSHcO6@shell.armlinux.org.uk>
References: <3287d9dd-94c2-45a8-b1e7-e4f895b75754@lunn.ch>
 <20241010215417.332801-1-igilca1980@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010215417.332801-1-igilca1980@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Oct 10, 2024 at 05:54:17PM -0400, Iulian Gilca wrote:
> Embedded devices that don't have a fixed mac address may want
> to use this property. For example dsa switch ports may use this property in
> order avoid setting this from user space.

As Andrew has already explained, DSA switch ports derive their ethernet
address from the ethernet address of the host MAC they are connected to,
and each port does not have its own ethernet address.

Please explain why you want to have DSA switch ports having their own
randomised ethernet addresses, and why this is advantageous over having
a stable ethernet address for the switch ports.

> Sometimes, in case of DSA switch
> ports is desirable to use a random mac address rather than using the 
> conduit interface mac address.

This is just a statement but gives no insight into _why_ you want this.

We want to know the reason behind this change.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

