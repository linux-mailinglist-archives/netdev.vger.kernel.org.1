Return-Path: <netdev+bounces-179215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 943E0A7B264
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 01:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 811713B98B9
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 23:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5141A5B8F;
	Thu,  3 Apr 2025 23:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hd+cAr+0"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0914F1ACEBB
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 23:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743722784; cv=none; b=cG++ftt10ZrhMHmwlX1LI/ernFM5qMH1cxC6YPaOHJJMfiKrUuJm4w+1gJk0q4JU3pwsm+K9VUDs2VJBmAjfpb0E9i5WQcYpK2e4rD1n4mqs+Uj4KXVt1dj5Np7yqcDc6UorzisLqUSQ7exz4mu0yVJcV9dBTafBCrv8TZeA3Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743722784; c=relaxed/simple;
	bh=J64u6Ol2ZYpLQ/D4oJn8ejXSdMNgZJ1JUmjAwlMcWfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUDxdUkyZczoNVnDS0MsoDEz23KVXxG0kaxh1B3HWWMojcQJlMWjVRk/Gdw4jIX/aPDMXqTRlV+MD8rznaQplqYFtnpWQWF8MC6nTq+14gyvqQHK+X98Eo16DIepjxBJsx2zzt+nd2apmY5txq4iO9h9YbRjmCdt/MOraBtJUqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hd+cAr+0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zcYKsbKmwfEqYlD2vORKHfK5BQ+7gNK8RjM/+ho/1IE=; b=hd+cAr+0J8oyVgGsZ2mmrgm9z7
	bAJp7zlUEHZBXOOaumRsKQIcEkdr+cjji7+oWp0tQ/r6QLniR2LhqbLqQuKsEYiwWnMqQi/l//RzG
	ANJZCnAPu2r2/c0W172xIKnRK/fJ2DEsdnGSfXLp3LhRY9Hz8I26fAlGQH7bL6coDZOoojv3BdpJS
	4TTPNxKw4MxwMzcEBb5u8vaWnfWyhVyeEHJC2ZyMtX3bigwrkyd7xScv7lS+iEl8lpnbd030v/aG4
	5K50jfeE/uaw58hV0ilieTI1UHoF8Z+StKdxZ0+0Mi0xI0PelGCu4hyRqx6c86bBiPE0n+BXmzKvl
	wLWeMQVQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47556)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u0Twv-00012h-2L;
	Fri, 04 Apr 2025 00:26:17 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u0Twt-0005As-1a;
	Fri, 04 Apr 2025 00:26:15 +0100
Date: Fri, 4 Apr 2025 00:26:15 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, hkallweit1@gmail.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [net PATCH 1/2] net: phy: Cleanup handling of recent changes to
 phy_lookup_setting
Message-ID: <Z-8ZFzlAl1zys63e@shell.armlinux.org.uk>
References: <174354264451.26800.7305550288043017625.stgit@ahduyck-xeon-server.home.arpa>
 <174354300640.26800.16674542763242575337.stgit@ahduyck-xeon-server.home.arpa>
 <Z-6hcQGI8tgshtMP@shell.armlinux.org.uk>
 <20250403172953.5da50762@fedora.home>
 <de19e9f1-4ae3-4193-981c-e366c243352d@lunn.ch>
 <CAKgT0UdhTT=g+ODpzR5uoTEOkC8u+cfCp7H-8718Zphd=24buw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UdhTT=g+ODpzR5uoTEOkC8u+cfCp7H-8718Zphd=24buw@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Apr 03, 2025 at 02:53:22PM -0700, Alexander Duyck wrote:
> How is it not a fixed link? If anything it was going to be more fixed
> than what you described above.

I had to laugh at this. Really. I don't think you quite understand the
case that Andrew was referring to.

While he said MAC to MAC, he's not just referring to two MACs that
software can program to operate at any speed, thus achieving a link
without autoneg. He is also talking about cases where one end is
fixed e.g. by pinstrapping to a specific configuration including
speed, and using anything different on the host MAC side results in
no link.

In that latter case, I don't think you could come up with something
that is "more fixed" than that, because using anything other than
the specified parameters means no link!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

