Return-Path: <netdev+bounces-248436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE06FD08809
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 11:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 83083301A33C
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 10:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27082D8760;
	Fri,  9 Jan 2026 10:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="o1jUc5rX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05092D9EF3;
	Fri,  9 Jan 2026 10:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767953229; cv=none; b=ACPj9u5+SUrnMAremA5Bkax+UJNILc1KBuSL3DkAAMkd/EQr8f7wF/kzFKAxApRWOEV7PBxvwsuuQNsvRaAgK3j6/i1ZhvP0IPMx8dlx1Gl1CQVPZzMEpwytHjyHtMgbMTBNLv6aIZ8qpaV3VfaCZB/4X8LeNd4o/+mzc1gtWIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767953229; c=relaxed/simple;
	bh=J/1jpPmJF8zGt5KxKA8WqUgqJApTyYJMV8nkhRejsNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UduZmfSLlFtegw9i0WHth1oK5+534cV30RoZ9LyU7CnrvvInLuVu0YD/FJAHJHnClmZ6l5IClrInkCIYm5cB2nJ+IBhrUPoUWCTOts33whuGHyhKkbZgAkbjZRKthtWBJbwCJV3Zh6aYFFTwcFZu3zkxo9sQ+87eSjEW6rEhej4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=o1jUc5rX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KeLYzRDapET3DwdHULox57JF8Lpro9tDrD/hi5Nl1yE=; b=o1jUc5rX+0gnWrWSynXel2VxJe
	HZiWjeX071F+11Cf51ypiuLcDqu/gQibG4lgEv02CKk+sZ/8EqPSEjH/C5Dec1kOhqXJs8oBtvG7Z
	AmnazAzxMIbSo/h31hu8o6sPCphmmdkfQtvamqKYcqsi0JD66dnVvHujjDWQkwxSfTiDC1tLPgPaB
	31B+wDKTCb5KW9M9PlZiCQE8ZISWDYaqJPxNcVO8BwYC2Dw7QTb91teWPGjloRMjQcw/JKa7HWf9L
	KPS68otSXcrxeBD/Q7cpilJZoJiZ+Y7ZiG+hIL8y6dpFnmqQxHwjwizHSfbjWRCDbJSzNfLFasacL
	/oqUgdQg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54476)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ve9OG-000000003gj-1oVb;
	Fri, 09 Jan 2026 10:06:44 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ve9O7-000000003DZ-47kE;
	Fri, 09 Jan 2026 10:06:36 +0000
Date: Fri, 9 Jan 2026 10:06:35 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Yao Zi <me@ziyao.cc>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Chen-Yu Tsai <wens@csie.org>, Jisheng Zhang <jszhang@kernel.org>,
	Furong Xu <0x1207@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH RESEND net-next v6 1/3] net: phy: motorcomm: Support
 YT8531S PHY in YT6801 Ethernet controller
Message-ID: <aWDTK0OgaoGUXmc-@shell.armlinux.org.uk>
References: <20260109093445.46791-2-me@ziyao.cc>
 <20260109093445.46791-3-me@ziyao.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109093445.46791-3-me@ziyao.cc>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jan 09, 2026 at 09:34:44AM +0000, Yao Zi wrote:
> YT6801's internal PHY is confirmed as a GMII-capable variant of YT8531S
> by a previous series[1] and reading PHY ID. Add support for
> PHY_INTERFACE_MODE_GMII for YT8531S to allow the Ethernet driver to
> reuse the PHY code for its internal PHY.
> 
> Link: https://lore.kernel.org/all/a48d76ac-db08-46d5-9528-f046a7b541dc@motor-comm.com/ # [1]
> Co-developed-by: Frank Sae <Frank.Sae@motor-comm.com>
> Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

