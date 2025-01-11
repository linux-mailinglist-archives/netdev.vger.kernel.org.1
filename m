Return-Path: <netdev+bounces-157397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D98A0A23E
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 10:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87D3C3A6BB1
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 09:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051751865E3;
	Sat, 11 Jan 2025 09:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="H1n4hVLY"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C2C14F132
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 09:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736587278; cv=none; b=Pwa0bN+iwi6oVWImdEnSvxKPdfC8H0A9+f24zV0+ElkowuswM141JVDbyotjlbjc1yMp5dlLTiQw7iG/v494vtwbcqhcm0ZORfRWIDZ3cyKYoeCWZvcZ3pUU2gs8uWOn+bY5V+WDsEdV9NHyQhjV+jsPLRua/Rdw6bEyzZ3pJ6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736587278; c=relaxed/simple;
	bh=/HopWDPE/BaY//xrG+ipDF4OsXLZv7Df7ubeMmAcHGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfLad0XLTar3yYcDWJsq66cJ+Z5VqmsY9NigRDZ41/TEyX99SmU+okqEmzYDaeEWs6e9ErhTwvTdfn+wMTv85BWZskrnAJOFRZupOUJ4T9w21zG/IDnU2hlHmDERE5AwjQNd8zXPSL51tGObEcSfI3jSitIDG20N0pFZWJNq52I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=H1n4hVLY; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=S/fkT3HscW2toNyiy4C77S7MbbLP8/FY6qr4K4oBt0U=; b=H1n4hVLY9aBHOn8Dep1WSoMouT
	ssJhQXi+1qrBAyOOI8WeYXg+vKxIYn1vO6zdc40ESHh5wtAQ8k+dsehVqWG3u224cvGwiiH34/5gc
	p1wQD0+wnTsTg/bLqZFyBoMPjdMvAdNGc7d7oLlbiwEDOva+oMPLnqeNF2EknWCCahGvJItbNXTV5
	sShgIzImwt6VV/y6DBmGJbBwC8O4zlodoe23krolnqyA2irs/iDLfJjipjCISnqSksNiWJNS4DM2n
	L+KTe8Kyb6W667qmHN2abmxPLFKUoi87LR6pn/9Y/vbkKstG/La2yW68op3P0KI4G8tRCxoQYWYus
	A19cFvEg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57364)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tWXg3-0004U5-09;
	Sat, 11 Jan 2025 09:21:07 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tWXg0-0000oD-0f;
	Sat, 11 Jan 2025 09:21:04 +0000
Date: Sat, 11 Jan 2025 09:21:04 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 3/9] net: phy: c45: don't accept disabled EEE
 modes in genphy_c45_ethtool_set_eee
Message-ID: <Z4I4ADNO1nSdZRja@shell.armlinux.org.uk>
References: <a002914f-8dc7-4284-bc37-724909af9160@gmail.com>
 <5964fa47-2eff-4968-894c-0b7f487d820c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5964fa47-2eff-4968-894c-0b7f487d820c@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Jan 11, 2025 at 10:06:02AM +0100, Heiner Kallweit wrote:
> Link modes in phydev->eee_disabled_modes are filtered out by
> genphy_c45_write_eee_adv() and won't be advertised. Therefore
> don't accept such modes from userspace.

Why do we need this? Surely if the MAC doesn't support modes, then they
should be filtered out of phydev->supported_eee so that userspace knows
that the mode is not supported by the network interface as a whole, just
like we do for phydev->supported.

That would give us the checking here.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

