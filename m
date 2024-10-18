Return-Path: <netdev+bounces-136834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B35B9A32FC
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 04:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D38F8B21DE0
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 02:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3886126C07;
	Fri, 18 Oct 2024 02:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zVQp2LCk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8539153365;
	Fri, 18 Oct 2024 02:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729219548; cv=none; b=EOIhMqbSi8u+Jl45Y18yAVHu6K1KicND9wVcAAEp51Ap1HfmbSlzZU0Fc7sO4dG9tNQO1T6IrlvxrHqPkB1ZCnboQLXePKr6T7DsbBaxy1gOB0YUROd3d590Qic/lKm0xScPis7Io187CiFcdiBq72wLxIubkny/dbDkAX58qDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729219548; c=relaxed/simple;
	bh=TPRq9oRY3+aEbUmQaAeSiOoL+i3XIx/8Gv87Cj1T/2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IB5ZXbg/V6QcaiHBTod6XWry5d0kdJUjQws8f7FDDb3KwYfQhP88oH1nLZBZCCWKaiacqbAkGJjK8luZyLSw/JkhIFHc6BAOXrzCri8EHB1Eksp+KvG4IwZfIg5m7tqGVhcQRWbwT/g3jXSWDWMlia3G1PUVtXHrPtPz8Y4kI54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zVQp2LCk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=K5max6BF00alHy8d08PHc5nApuudaCk55ogs9a07ktk=; b=zVQp2LCkaAYSBC8E1Kd5C8uPtm
	MM7ls+02UyJN02FPMzIFRhoMQS1O0VSE8kdo4TPqEllQ/JkPoMYe/N/Z6CyeeNobydntiRVv5mqmN
	xu2topanQCV4PD0BaQbC9o0K384AwwC8FDaHF2e0lnhFtgrcf65ixtiA5gofW1joVKXA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t1czf-00AJR9-B1; Fri, 18 Oct 2024 04:45:35 +0200
Date: Fri, 18 Oct 2024 04:45:35 +0200
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
Message-ID: <1ec3bf2e-e908-444a-ac5e-c3fd62e50b62@lunn.ch>
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

Please create a new thread for each new patch submission. The
machinary testing patches does not understand it when you just add a
new version to an existing thread.


    Andrew

---
pw-bot: cr

