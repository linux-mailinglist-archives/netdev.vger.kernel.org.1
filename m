Return-Path: <netdev+bounces-225033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9155B8D8F0
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 11:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6956C44172F
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 09:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F99A25485F;
	Sun, 21 Sep 2025 09:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Kgf73VFD"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2405534BA52
	for <netdev@vger.kernel.org>; Sun, 21 Sep 2025 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758448604; cv=none; b=Q+PUTkUjFFjTtngRl3Pd5xb9CucwxHEkqt6gXhm/Vrv91rfHTkhP8rV3LIbeoMErxNFRCcBezI9bqLYIcC8pVs14Kjp2Q9aPf0XOjBdwH+OPvOjCfVZyKt9miZ3u01BIstPBkEaiT86iF5n8oCQKuLOrPArIa72OwoZoYbWHNHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758448604; c=relaxed/simple;
	bh=Q2uUDOLRKOy5bJsajmPxE7LSMPjS9fd7DzPC0/8r3Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPZlLOMuIaWUD4x8RJI4jw8BJqIiMODR4n2gQ6zehMuJjIm5W9ChnKMu7wRav6xoeSNHgs5+12sXsKSeRhAaB02gj3ItZq6YdYuE86LIO8HOrCjikcT4TgE4oixbX+DcNhulvxs4lZPtzaiBqyHm21RWQPXN8FGQwCsr0oq/SqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Kgf73VFD; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SAlpxox4T45lEdK6tTIyVr1n9ywrtA5BLDLMGKKtQu0=; b=Kgf73VFDl+WLWmLW/wRmKpXGuv
	gtk7yBrp0HQrIc2fKb7t2U8ZZWg+qlAr+9y/FmDIxu9BNqRQVCY6jY+B0vdGs2lC2rsdY7lBkSZqM
	idQ8ALiTtNcXzI1CGflnxCnNhD5CJHC0vi9J4ilMZdO4jZ3yN8SXm+R5ydc2Yjy3SSOEUCMWKnka4
	tMGVj57WQ0Kyrt20yAKx0ZfDXGnrtoAaJb1hW3C/at9utBAjogw3CsYHl1LSj5pmru9N0BjkwyNav
	vBzykNv6SNdm8eF5JUaSSTr3qw9vpOODNW7NTVN8G3GkM1RQl1f7Fd0K8OmsdloHtCevK2P761UJf
	Wh7Ns/ww==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48490)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v0GoA-0000000028i-1q3Y;
	Sun, 21 Sep 2025 10:56:38 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v0Go9-0000000041O-0GNo;
	Sun, 21 Sep 2025 10:56:37 +0100
Date: Sun, 21 Sep 2025 10:56:36 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Zoo Moo <zoomoo100@proton.me>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Marcin Wojtas <mw@semihalf.com>
Subject: Re: Marvell 375 and Marvel 88E1514 Phy network problem: mvpp2 or DTS
 related?
Message-ID: <aM_L1Hbind29q_Z_@shell.armlinux.org.uk>
References: <wL97kjSJHOArswIoM2huzx9vV9M9uh0SoCZtDVYo-HJFeCwZXraoJ4kc0l1hkxt1XLsejTsRCRCkTqASpo98zAUyfmYoCfzGD3vkaThigVA=@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wL97kjSJHOArswIoM2huzx9vV9M9uh0SoCZtDVYo-HJFeCwZXraoJ4kc0l1hkxt1XLsejTsRCRCkTqASpo98zAUyfmYoCfzGD3vkaThigVA=@proton.me>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Sep 21, 2025 at 09:05:18AM +0000, Zoo Moo wrote:
> Hi,
> 
> Bodhi from Doozan (https://forum.doozan.com) has been helping me try to get Debian to work on a Synology DS215j NAS. The DS215j is based on a Marvell Armada 375 (88F6720) and uses a Marvel 88E1514 PHY.

Probably wrong RGMII phy-mode. I see you're using rgmii-id. Maybe that
isn't correct. Just a guess based on the problems that RGMII normally
causes.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

