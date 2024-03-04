Return-Path: <netdev+bounces-76935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A812C86F7EE
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 01:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 481A3B20517
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 00:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B45815D1;
	Mon,  4 Mar 2024 00:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UZlXAmxB"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBA015B7
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 00:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709510671; cv=none; b=csKuCsPKYfUqwZkQYHxaAGtoQ+E/Y+Ta0djvw271BrdpuSmKhYcNm6QIT9gS2Whwkd9+qp4elZPAnN0lpm7TvLpMtFwhwgK933OF5cecbLilRDGA3TBmzGBKKF6acK/FeEx8tudzTt9C8bWra1J5Teiq0KeKEdH+e1zBlAFbjDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709510671; c=relaxed/simple;
	bh=JpblxY03a3wV1XNtr300dyP7LggE/JJhMA1uIQV53Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2K0G+6eboa/wQS4H3DQLHlyCWmi2dmdKy6ekli+IuAbEJMEcCP0ADjcxfrko3dK10+4rpSezYTMGCKWLqr3OzAQRxVMdKJ99p1sRAeAfIT63zdzXol+/H/BXxmXILgbrbUZ6ltBaPtvMavv6D6GBo4iDI7dH8+yjuT3obuOdBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=UZlXAmxB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rlEgZj5izmRrkWlwSSIXoYe60iRrbYYlBU3MGa1M+4g=; b=UZlXAmxBMn9Ya/elvZ7v1XrPk5
	YWvRRwjmT7hSiTYC0en+5s9u2RXgV5FxGDFM9UZYkuxgs2nU5dPIDecxQ0lzo7EL3lipTGQiGoEC5
	s26XmJsoLkwk5KhE18Zn7Pi0+q4NJOP1dQD/s16TTn7beCUahQZKj6jSjFXzm3slrkhP/Lphlh0RY
	O2P/hZfbp8SdtS7T9OnNbtPhavifMuQPiTaKutIWvOWHq83R3A5cCOCEk9tLtlVYWlIli2ZEciAIs
	GhciNQ52RsJuopV8NNa1oiyTzeOpUc7J19wb8/GJYiBJnX0HQbNNqH1OqyxLjTYigADEOuN1pBLZy
	ONNVs2AA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60116)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rgvoO-00045m-0u;
	Mon, 04 Mar 2024 00:04:08 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rgvoJ-0003ym-TF; Mon, 04 Mar 2024 00:04:03 +0000
Date: Mon, 4 Mar 2024 00:04:03 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Eric Woudstra <ericwouds@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Frank Wunderlich <frank-w@public-files.de>, netdev@vger.kernel.org,
	Alexander Couzens <lynxis@fe80.eu>
Subject: Re: [PATCH v2 net-next 1/7] net: phy: realtek: configure SerDes mode
 for rtl822x/8251b PHYs
Message-ID: <ZeUP85PPPqdgrjWu@shell.armlinux.org.uk>
References: <f587013b-8f2c-4ae1-83b8-0c69ba99f3ea@gmail.com>
 <ZeTmv0S9cbqFOUPS@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeTmv0S9cbqFOUPS@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Mar 03, 2024 at 09:08:15PM +0000, Daniel Golle wrote:
> On Sun, Mar 03, 2024 at 09:42:31PM +0100, Heiner Kallweit wrote:
> > Did you test this (and the rest of the series) on RTL8125A, where
> > MMD register access for the integrated 2.5G PHY isn't supported?
> 
> None of this should be done on RealTek NICs, and the easiest way to
> prevent that is to test if phydev->phylink is NULL or not (as the NIC
> driver doesn't use phylink but rather just calls phy_connect_direct()).

Ewwwwwwwwwwwwwwwww. Please do not use the presence of phydev->phylink to
change driver behaviour. That's just... disgusting.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

