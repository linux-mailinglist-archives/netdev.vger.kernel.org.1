Return-Path: <netdev+bounces-221420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EE1B507AB
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 23:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CEBB18880B1
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 21:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEB6242D9E;
	Tue,  9 Sep 2025 21:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="qm5e0Bkc"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A958156230
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 21:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757452051; cv=none; b=ikM7nqr+nXaGCpNSRTO4fAZjxKko2/UC0qO2wMNuUpxch05xRgUCvmr9BLj/AJgglkaKBKE8YmitGYqzIFay+vlxTTt34uppwsR8n2xUnB2k7Li4/Qq5/GxCzZILQu5hVocF1iYMb2N0vAGnGiA3pEQIkqZBMncxzRNJhMSAUFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757452051; c=relaxed/simple;
	bh=kJ2ayqMEyk0QQuCkLq4OAY1DxXA3LtDnS5NuI5LcQxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAAbZSUq1JKQ6MmDaybDeZl2wJSVShrDsJuZqbmJmYNUhiZmJs/BpvaWbheFgnKJ4VKC1BOuy4gTRw25kLrVhtPsRsuNk+j3K7Ye9IHJeNRvPK8khs3sW60LXt+GVJvLRYd/5qZAwVkrwVL13W5KE0kRJGoDY2Sg76Su9j9fR1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=qm5e0Bkc; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5k944fySuUGZEVza17/+6ygrm9+IOyzklKmSlnz+DoI=; b=qm5e0Bkcyg/TQBi5ncOktyPFGs
	OZJR1ogw0lVdvhl3lpHVJ8FAibIDg0dtLjq+8DLirJW46Wesmp4G3cwF1l6/J6cBXnsnJFM5ln9zn
	slljeyM4MtGUzrbi4mvL1fN192B5ce7Mi+9V4TFGP53YWxuTImQUGCrhgG/X+KRg12M6Ve7Ub+kKv
	WQzNKsxecboQjvmUDcRpcDu6qmvK62gyNXwKd8J/ZPtPFh3XcOseLv9PacgqvmrbZn1QKcfoxzGpP
	KpzCTHKJpg5SmZ3bzU6WnaoGclth5ujRmm9d6DP3pJZ90P4kkUsq7mtqTgaupM5Kx4vcqgfwBwsVg
	ZqSTXyPg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43980)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uw5Yg-000000000ft-48GQ;
	Tue, 09 Sep 2025 22:07:23 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uw5Ye-000000000kS-1uvl;
	Tue, 09 Sep 2025 22:07:20 +0100
Date: Tue, 9 Sep 2025 22:07:20 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: mvneta: add support for hardware timestamps
Message-ID: <aMCXCPQryckcCR3g@shell.armlinux.org.uk>
References: <E1uw0ID-00000004I6z-2ivB@rmk-PC.armlinux.org.uk>
 <20250909140113.3977f8ba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909140113.3977f8ba@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Sep 09, 2025 at 02:01:13PM -0700, Jakub Kicinski wrote:
> On Tue, 09 Sep 2025 16:30:01 +0100 Russell King wrote:
> > +		/* FIXME: This is not really the true transmit point, since
> > +		 * we batch up several before hitting the hardware, but is
> > +		 * the best we can do without more complexity to walk the
> > +		 * packets in the pending section of the transmit queue.
> > +		 */
> 
> That's true for all SW/driver timestamps I know of. 
> No objection to keeping the comment, just a FWIW.

I'll drop the "FIXME:" prefix and re-send tomorrow with the
.get_ts_info() op filled in.

Thanks Jakub.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

