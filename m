Return-Path: <netdev+bounces-197075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D985AD7739
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7434616E633
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A19299AAB;
	Thu, 12 Jun 2025 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jpYSMxTK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086412989A4
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743356; cv=none; b=poKyY/954yHa6zThQLF6SVOmUNIpK+QPoBl2HAJ+E6o2iTbLoyFfC/c4hhsrNcbiNd9nIM+zCoFVYmcLSDn0h1o2zakY73ByU+GPDBg14DJnwC1J2RLvse5evc724I1NlKEVR9C89+Ec4Zy4rX6aokWWML4mPRvUC9P6Cx25zYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743356; c=relaxed/simple;
	bh=DWtc24xXsFbZmvOsoemXgnGNWFvz0o+KSnbZflhCJw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJlGIUarLclbxHS6awFCjkgEfmcSdo+5kGhf5p8n+IlLx9RYieDCh5E5GIwfR0rRJ88x8bHFvCmDNxK6kNWOll2t0GyN8DrldVDmlMNLLRNiHkElw3fbpZCMNXXJfb/wntw7LxEIV4XIC5nVP7LFSm0kKhIDFyIhB1uF7ZWFZA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jpYSMxTK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7JL26w8K0dLRiG1S/saI2ZvE8MpTkarkv0Vc5Oq/vhs=; b=jpYSMxTK9gNaS+poyIPobuZAt3
	0M9of1MFVOXd+v0hB0/ZwQmSUaGyjIDeKubwkrb15sH16fQNZL8OVCESDTo4ZamFZLOZlcrXQ2ACC
	4DnjDACkIU6ILtzndZH7reHhG1+/5WPT7ML1GAgGHMznhqM6+w8SFX77rLd7CnVVCiqs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uPkAs-00FZBv-LR; Thu, 12 Jun 2025 17:49:06 +0200
Date: Thu, 12 Jun 2025 17:49:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 4/9] net: stmmac: rk: combine rv1126
 set_*_speed() methods
Message-ID: <d0af5dcc-1567-42b0-9bc5-417dd8c37d33@lunn.ch>
References: <aEr1BhIoC6-UM2XV@shell.armlinux.org.uk>
 <E1uPk2z-004CFT-0e@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uPk2z-004CFT-0e@rmk-PC.armlinux.org.uk>

On Thu, Jun 12, 2025 at 04:40:57PM +0100, Russell King (Oracle) wrote:
> Just like rk3568, there is no need to have separate RGMII and RMII
> methods to set clk_mac_speed() as rgmii_clock() can be used to return
> the clock rate for both RGMII and RMII interface modes. Combine these
> two methods.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

