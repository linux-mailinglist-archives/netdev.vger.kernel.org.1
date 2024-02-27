Return-Path: <netdev+bounces-75258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EDD868DCA
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 11:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D2151F2357D
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 10:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E6113AA3F;
	Tue, 27 Feb 2024 10:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="uQidwuu6"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD291386D2
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 10:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709030244; cv=none; b=Iv4lHfo8t9KdAjWFH9w+6u2/9zzek3KEReWJXU0UmduIcRFATM49WiYh8OFKXrCWmMwR7Jo+lJaWPE6dg7k8KMogPnGsbeZXtD6a9xUngSVOJdWlZCU+oHkT+/oseGh7Rvctwe8YQy+kp+JRMIg0RT446pJKClBfAs5bKJYSDkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709030244; c=relaxed/simple;
	bh=sHM/GYTwFlwAFPTUce89SAEddnBTWUpWLrwEiBJ1GzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3fALx8RewmsfyTyiuQycYI0jibEb+mghBmIZarR05zzIynMfJXR1TGbHF4tC+74udgEPZt9x64SwI+0NFEdk6v3B718qcKTAuyt2iInklPRLn86ByyqM6deEYne29RAITvaoBmjf2t0msIeUY3o788qUNGOKoG/Rubp6+xKjlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=uQidwuu6; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9jdUkLDl+bbxaHDb5GmFwMACzIokLVgkvd1z6P9kg1A=; b=uQidwuu6XSAlW/BM/oCiOrJMvt
	sWaaRvPwKhxMZ9I16nciouTulxVK8bhwzV+X6JR1sJ3iJ3VXeb7ZKpFQOTk1Hj6O65f2qi17Z+j9r
	UQWWc3CLH1WgnQQKL7+yybqrf1tkoKGcGqDsxb0dgFkgJYKsoyzdma+++Rq5KrNo3W5hCOMz/a1dp
	TU+ukpxciIFFwXi71MubW3/BSG9Z8gLEpMdJlbW5Xh/hLU+T/j7nq+rtRnBz8Etp0WvbQEi8GZVru
	Ks3OrJruRGgv3NKztc2TZfn59i+G0hK42NPPw6isqOWZ2cBOafe+39u7D+h/7ThoFM6ab7+OedpKY
	pZjDPorA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33122)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1reupn-0007ni-1w;
	Tue, 27 Feb 2024 10:37:15 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1reupm-0007Jh-SH; Tue, 27 Feb 2024 10:37:14 +0000
Date: Tue, 27 Feb 2024 10:37:14 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next 2/6] net: phy: realtek: add
 get_rate_matching() for rtl822x/8251b PHYs
Message-ID: <Zd27WpSyhMNdA/B+@shell.armlinux.org.uk>
References: <20240227075151.793496-1-ericwouds@gmail.com>
 <20240227075151.793496-3-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227075151.793496-3-ericwouds@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Feb 27, 2024 at 08:51:47AM +0100, Eric Woudstra wrote:
> Uses vendor register to determine if SerDes is setup in rate-matching mode.
> 
> Rate-matching only supported when SerDes is set to 2500base-x.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

