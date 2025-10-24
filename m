Return-Path: <netdev+bounces-232533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFBFC064AE
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 14:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 151D01C05E9B
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 12:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D876730275F;
	Fri, 24 Oct 2025 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tgGTe94K"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9CE278143;
	Fri, 24 Oct 2025 12:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761309802; cv=none; b=dnr1brdD+NZForWZ3WxkqvtR4DWBFTAfYDKe6LloE6fBlEwv+Zj8ivsaQweYAipSq+2vMAEae170li0pgZAKaZDP4UhDDA1tIpElw+OFqsD+UdzwPLSaS7c34+j1Qmjj8HO/SaKLYBvjCtXlzvbdbcyqhNUkDro+Dktk9AKG7yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761309802; c=relaxed/simple;
	bh=k/VtERa7b94rFqGUp6FruIQ2A8h98t0b+1YHgYUy1nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDKgpoommjA0RVlmdtIk6a9EOy9JAd45lh3lRs5c8S0EbOeNpGwQ5kdzNPN2hHsURgsXGU8GIqMSQQ4+ncJsUJkIoz6gGcyYBJCS428ZCfPCpvfXdA/XbRwBj5DqkPHOe572kLa0f8nrbWH8r+yyKwznwk/XcvW3aI8UIRetLzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=tgGTe94K; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sSCWIiX+MqLPwcbYBwmpimdl3z9FmDkAbweXSQKqMIE=; b=tgGTe94KoPkOGF3Tt42ZqRR99L
	UuqCXl9LZWM7vDJkFh11BngEwHQi0OsImNfGBPOipf9aeAj/Skdt0x4EYnBMNMKwxcCAuAhvSkDHk
	czxc02Jd4jaAYtFTLdqSVA0xdYx+McwFRizYvipP5G2CFfFTHhahyekC7smCcqvrPF2YVYKWJodGH
	xUmsqiNn2HnSJP51JJJREj8Hj6WFIA7gURVyTprHmORJ5PATTmyi3NIiw5H4B/Tf/grk/m8cATtpd
	ORWh+0ha/z9vAI8jDv2AQY1oBxBr5pzH3Wbe7ga+E74xBarO8g8ZQRy4dL32/gz819EYSZ7plNTeu
	Q5hUzVjw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51278)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vCH8N-000000007YG-27cE;
	Fri, 24 Oct 2025 13:43:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vCH8J-000000002i4-1Ltu;
	Fri, 24 Oct 2025 13:43:03 +0100
Date: Fri, 24 Oct 2025 13:43:03 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net: stmmac: Move subsecond increment
 configuration in dedicated helper
Message-ID: <aPt0V43zYg5idFU6@shell.armlinux.org.uk>
References: <20251024070720.71174-1-maxime.chevallier@bootlin.com>
 <20251024070720.71174-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024070720.71174-2-maxime.chevallier@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Oct 24, 2025 at 09:07:17AM +0200, Maxime Chevallier wrote:
> In preparation for fine/coarse support, let's move the subsecond increment
> and addend configuration in a dedicated helper.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

