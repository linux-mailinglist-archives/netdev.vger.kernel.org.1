Return-Path: <netdev+bounces-251094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 314A4D3AAE7
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 45B4930024DE
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 13:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1A536E474;
	Mon, 19 Jan 2026 13:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PS8Mp7VD"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980FB364E93;
	Mon, 19 Jan 2026 13:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768831060; cv=none; b=BiU7ncvXaXWgfrwWnWK/EKqBzC6ULjr4PlYoBFK5WXXrcdO9kcOc8QNaR4LmIG2OrchslfCEiY6hWJCYstS1y1VzPvfhOFl3PNA/jdqpM0xvw8Pn3m1yfanbvynaS7EuUjams/hmmXvlDpl/KGxgNZoTbCvCw84wiO4G2G0i/CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768831060; c=relaxed/simple;
	bh=4bySpCu+PlW8tgxq+NxvZ2dZcp8Q1rxi6CpGyKWYhSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PE8waa8Q8GzgKhx/cyJ4aB5HRSY9mcgHCACd9iCDyF8DC2V1Z+0g0/7/4R8M8DRd5iJAEZZqY+2tZ9034Zt4mAFNQczdSSJEq67uy6Q+j5KCcgOrDWaggtMPtmW78BUBDeJuLNGMuKk0ye7vkM45RcBPnuGHab/W65SgZEySJlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=PS8Mp7VD; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ST6rvenpytwUEYvJgVLSd+1bp0O4aP2n5myvH5mVnqg=; b=PS8Mp7VDvWHF4gO39OECAmIZRF
	hEkaWPUzCJ9kNJC1Wb9cy9HyjIzvAxV8kT0o3nP222SzNMv53NdL+Q943C0+RKoaoAP9mmPwrku1M
	jqpuc2Qn3Mv/p+Y5CsyZ03zuwkv/L6Ffcu/gpOrZx48rGwkRSzfbvhC8DMRa/yudQH/paJuG1i/Hf
	ZwQ5PaeExGDNjfvp0wT3fSzzSfal6q4vrqLVRNCXUXIG3BTv29Tt3dBA59ZEHgnTNd9mmuFjgvBhw
	ihXXOKfbTJil/m6sAQzPa5lN0eHIT1YI+DJHgsk3/VPckJ3RQoaQdOfyTAOFLAA9LC/NQCBAs+bwG
	jg94ogog==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43964)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vhpl8-000000005F5-2qA2;
	Mon, 19 Jan 2026 13:57:34 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vhpl6-000000006ba-00kt;
	Mon, 19 Jan 2026 13:57:32 +0000
Date: Mon, 19 Jan 2026 13:57:31 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net-next 1/4] net: phylink: simplify phylink_resolve()
 -> phylink_major_config() path
Message-ID: <aW44S8XmTRR808QQ@shell.armlinux.org.uk>
References: <20260119121954.1624535-1-vladimir.oltean@nxp.com>
 <20260119121954.1624535-2-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119121954.1624535-2-vladimir.oltean@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 19, 2026 at 02:19:51PM +0200, Vladimir Oltean wrote:
> This is a trivial change with no functional effect which replaces the
> pattern:
> 
> if (a) {
> 	if (b) {
> 		do_stuff();
> 	}
> }
> 
> with:
> 
> if (a && b) {
> 	do_stuff();
> };
> 
> The purpose is to reduce the delta of a subsequent functional change.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

