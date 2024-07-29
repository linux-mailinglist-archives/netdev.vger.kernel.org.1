Return-Path: <netdev+bounces-113547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7802893EFEB
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 10:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 340C61C21B00
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 08:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35AF132112;
	Mon, 29 Jul 2024 08:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dnP59uev"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89FD5E091;
	Mon, 29 Jul 2024 08:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722241908; cv=none; b=li1cZjlJKyDiFAKWlKddLzhPvZsNayjS6WZOC+hH7RZaFxDBE/Lk4buBlESgaY/IWOsgqAdH2pfnTC1c1Bax8WzSju61MvIEHlq9I5OyA5OMec5YacaHfMKpTafi6WqdifilE07QfROoJiDWrqmIQvKtnKl9mi9S+lSkSXMzDtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722241908; c=relaxed/simple;
	bh=fuLLUCUblCSBaCEqp25yXN2NDm/N1CDBpjjBkzNFyTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNtq8ExzDMWyBQkRl2++hW55LyCGniFqGU8ixguHb51fzlpuNik70gf8SrBoLwWmy0UjO/GDtLi55AcFcKmv44nuHj6unCV4CapaUUPuUPgn/7XK+narQTvXIufKQbGuWr1IWGjHXhIaDc7MYrK7z3GzsMAUhPbAhMeK1brXVkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=dnP59uev; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZAyMzjM5XGP3Hv8hnWC7x1zDyhNA08sxloeYoYKnnnk=; b=dnP59uevQ3k+gMGFzSU57svGQJ
	cdCVm8xdgtfeTThw6K61MJCh7LWZwKlx5JXVfcQwmHTx1QtC4k80ua7CE4Q0J3jnGo/pJ3Zou31Ox
	FJtKBG5fF5/9F+Z5pwtMl4ghg2wYsvKyqo9RCjFFvyXzZN6nR6Cr5xZt9/FakAjDF757bT8H/w1a7
	DF0t0W+VoFQOvZwOfZFb01iKo4tjNeNBPTQX9ghLNq25tu6ymDCwDBoQdrHiyB6RTzY7sTYtDXwJx
	ZC2ixwImCbGryTfC9r8PFp4R50i0/3KkiUF7G7w3V3A8+105c0jNImKKqGwSpDyJKhMJs9khPAvQd
	VoG7fTFQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59652)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sYLn0-0003PN-2Z;
	Mon, 29 Jul 2024 09:31:30 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sYLn3-0004Af-Np; Mon, 29 Jul 2024 09:31:33 +0100
Date: Mon, 29 Jul 2024 09:31:33 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kamil =?iso-8859-1?Q?Hor=E1k_=282N=29?= <kamilh@axis.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 1/4] net: phy: bcm54811: New link mode for
 BroadR-Reach
Message-ID: <ZqdTZZ5dGGvQtEoV@shell.armlinux.org.uk>
References: <20240708102716.1246571-1-kamilh@axis.com>
 <20240708102716.1246571-2-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240708102716.1246571-2-kamilh@axis.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jul 08, 2024 at 12:27:13PM +0200, Kamil Horák (2N) wrote:
> Introduce a new link mode necessary for 10 MBit single-pair
> connection in BroadR-Reach mode on bcm5481x PHY by Broadcom.
> This new link mode, 10baseT1BRR, is known as 1BR10 in the Broadcom
> terminology. Another link mode to be used is 1BR100 and it is already
> present as 100baseT1, because Broadcom's 1BR100 became 100baseT1
> (IEEE 802.3bw).
> 
> Signed-off-by: Kamil Horák (2N) <kamilh@axis.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Does phylink also need to be updated? E.g. phylink_caps_to_linkmodes()

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

