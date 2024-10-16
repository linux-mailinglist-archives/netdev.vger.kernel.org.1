Return-Path: <netdev+bounces-136316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB669A14D2
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 23:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E74E9B23F10
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 21:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5E41D2708;
	Wed, 16 Oct 2024 21:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UXfIEEsV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7DF1D2226;
	Wed, 16 Oct 2024 21:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729114322; cv=none; b=DyfTnLJmgcg/kc9LZiGoDupF0nvtLoS2A3GPbj6fLOs7O4/jDv6sQ5fRBc3TWUTzm6HuZIG14ZnlNJua87gi25KZMbSvAIoUE8PMvxKgsfdUm0+swElVUcWSbnUH31/VhczWJMWC0AGsknaU7m+ljnhsOoZ5b98ZlykxGf/KmoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729114322; c=relaxed/simple;
	bh=sszvx0RVx0ECqMcnzQRqKNnIgll1vl1pXXeTE0FLSv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CH/pzOKEtSlbG6m0ButFV1TQ5QeMoTGn3BWMVPXvi3cfi6TqcG48pePVgJJkr4uTZy1rsWOHkN+wHyRmtL//x3sSI0wpmrdMQ2TkTxoC2LY+YWl3h9WwJ/3hChOiykrjF3jBpMZSqzxUIbitic7J1yCcdzG64QyHTR8cLkWrahM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UXfIEEsV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=waBt5I6+IDKpsOdEOQsggR92Qg/M30CrDwfNhYV3hmI=; b=UXfIEEsVIIooZhsqfx5lUNBcC6
	PFf1ZAoCq9V8csqhjyJToZYWpP+IBpdGq8f4q4KA6kprjGe0HCGARcOUAKPS3cdTfe49fQctrqd+A
	FdBRIkls0Q0ixR59diF2PappZv1wJDqpMqATCvwhAcJk2a1ZB/bYGC71/+sFzxDX4efE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t1BcJ-00ABtW-GA; Wed, 16 Oct 2024 23:31:39 +0200
Date: Wed, 16 Oct 2024 23:31:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Michel Alex <Alex.Michel@wiedemann-group.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Dan Murphy <dmurphy@ti.com>,
	Waibel Georg <Georg.Waibel@wiedemann-group.com>,
	Appelt Andreas <Andreas.Appelt@wiedemann-group.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] net: phy: dp83822: Fix reset pin definitions
Message-ID: <b3ed91ad-ef67-4aad-978f-ace7e05a2bf4@lunn.ch>
References: <AS1P250MB060858238D6D869D2E063282A9462@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
 <20241016132911.0865f8bb@fedora.home>
 <AS1P250MB0608A798661549BF83C4B43EA9462@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS1P250MB0608A798661549BF83C4B43EA9462@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>

On Wed, Oct 16, 2024 at 12:11:15PM +0000, Michel Alex wrote:
> This change fixes a rare issue where the PHY fails to detect a link
> due to incorrect reset behavior.
> 
> The SW_RESET definition was incorrectly assigned to bit 14, which is the
> Digital Restart bit according to the datasheet. This commit corrects
> SW_RESET to bit 15 and assigns DIG_RESTART to bit 14 as per the
> datasheet specifications.
> 
> The SW_RESET define is only used in the phy_reset function, which fully
> re-initializes the PHY after the reset is performed. The change in the
> bit definitions should not have any negative impact on the functionality
> of the PHY.
> 
> v2:
> - added Fixes tag
> - improved commit message
> 
> Cc: stable@vger.kernel.org
> Fixes: 5dc39fd5ef35 ("net: phy: DP83822: Add ability to advertise Fiber connection")
> Signed-off-by: Alex Michel <alex.michel@wiedemann-group.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

