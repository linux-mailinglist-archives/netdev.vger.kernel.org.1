Return-Path: <netdev+bounces-75264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B069B868DE1
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 11:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C457D1C22188
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 10:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E051384A2;
	Tue, 27 Feb 2024 10:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jfv9DHR+"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5442753376
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 10:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709030557; cv=none; b=ZkaJK8OiMg9lHxq/QkvqCFXQ+85GdA3LHZeqGy30+Q136YredoVtSZ666O9IUYnsxquixoXAVVoc2MsqYkvcFVYbkkJ3gEVTt3lemwbUsojBbWbXDOU6j6WH4LFfvD4mkWQBt1wwuRvvj4zghnSvnnZ+Wf8hvem2gIAQBJ6v+XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709030557; c=relaxed/simple;
	bh=UweO7jcp1m2WB84UIvrQu6yxifbAykivEBbz2vCEsfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8dXOi4GC0xBbFNdHkhq/fXhSGOvjZYIgz/p3p2d3EoCIWPFAYfeQMDZeVuNKgglwYAGxqDJ6K6ZvWGy5y4tzj9XvY9myz6qKHwyvu/LfHLRmN8WNUnRppFGKxGqJTwSiZGJlI8QltIG459M3Hs+Lw7LwIJcKu3wdg1jiKAyLNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jfv9DHR+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8MD92HO2nVE0b8uLaFWPCAx0yLPxB5MaihHEmGCpZYo=; b=jfv9DHR+GxktpSdCrQUE7zRBkg
	ciEkwLqPOKR6Bz1T4dXH9ChaeAI05BIEeV3kr5jV2z70xSv+ENwUJN2r1cTFBiQVkG3qELFuzGe2j
	5EDM3HwnrSL9TLILYxOcbOlJEG/a4HxncjrsKbnKYrdGNehpX8atKS2bXKSXX8Txa1Kobgh8SBiOd
	OGbnFR35XgBLHMulVs2j/r3heAUH3I2RkHGPDSYlFEbLjUNddt8jRoAbx8d8Dg/a/o/Ietw9gN+1V
	jPwHcslteXB59ilKe7UnPrHPx27TPg6tUcIl7biNWAbza5xlXD16I3DFz1ISuZ+CXfU0wuevwWrcY
	Z3OCSHZA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47006)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1reuuq-0007pM-0n;
	Tue, 27 Feb 2024 10:42:28 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1reuup-0007Ks-Jm; Tue, 27 Feb 2024 10:42:27 +0000
Date: Tue, 27 Feb 2024 10:42:27 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next 5/6] net: phy: sfp: Fixup for OEM SFP-2.5G-T
 module
Message-ID: <Zd28k+vFpulsH0PX@shell.armlinux.org.uk>
References: <20240227075151.793496-1-ericwouds@gmail.com>
 <20240227075151.793496-6-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227075151.793496-6-ericwouds@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Feb 27, 2024 at 08:51:50AM +0100, Eric Woudstra wrote:
> +// For 2.5GBASE-T short-reach modules
> +static void sfp_fixup_oem_2_5g(struct sfp *sfp)

I think it would be better to name this sfp_fixup_oem_2_5gbaset().

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

