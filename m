Return-Path: <netdev+bounces-232494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71237C0603D
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 13:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B10113B80DE
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 11:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250EF314B69;
	Fri, 24 Oct 2025 11:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Th81nqUL"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5513A3126BC
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 11:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761304244; cv=none; b=Rb8I8njyYhGwW2WVzQFNjzLwjs+e5ThlLoRM8jEkS1jCD+/SyYEdQ3AW3TBNS6cVTqsaRxNMgjtsi82iyt+YCw/Q4cQzgEidrTAi6JDYv343pCUFzYo0t3mo6Hj4Yvy8f21u6EJhszTny3v4FBZJHiB4lZxseOuJvtFpebHKRO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761304244; c=relaxed/simple;
	bh=H4vk7sU2Qnl0eVRIIetDW9raRcKnUHAUMXH/1YBkp9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3q6cCdis/2vVLcvTU+yN4i/0ReIUUmjbfsmcUe3j1AKd/G3XJzIKPacv0i1wUY+aCRx8JoqenvNdjl3/B5bv7+Y4ncuRdrjuqEVaDwXTsB0pIVrhfBnldTOU6yVO1kfNWye8cxQs4bFt39CUpZhibR1jIsiCK8zbiNVNZYQN9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Th81nqUL; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GDpctzUzikXL5mr7jsd57bMJaOx9W5e5E6CpNx8Gahs=; b=Th81nqULbGbjjKR79CdwmOIGcr
	y8WpnOEojfstJp+/4umsKlu5NcCELKDaYKbYzNk4ur+8ttLlqOQqXlwwP1E93EyieKwk20UgdI5/B
	UjJXbqUrVKZBjQCM+cyrUrNOk1APRGuUUHPo+fQENFGS7VGEcHeBefQuQpks7paGWWrsXGqCUpnPC
	ffUFQroNmlxwD97xCyLh9LvXNxn1ZoqAb0AeWRDyLm4WJoLOEStLdzlyE+Hx3Sqk+GcytzkR1e9x+
	1kax5UAp049Jhkl9cfjWrC5fAbzMBNvQ1kyqBdsWPQoq/03JCVMua3CSCPMihnLxg1RsyJZIMqKL7
	HDE89+1g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39360)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vCFgp-000000007Sj-1qqU;
	Fri, 24 Oct 2025 12:10:35 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vCFgn-000000002eS-0hGl;
	Fri, 24 Oct 2025 12:10:33 +0100
Date: Fri, 24 Oct 2025 12:10:33 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net-next 2/8] net: stmmac: simplify stmmac_get_version()
Message-ID: <aPteqZ57fWULRfNy@shell.armlinux.org.uk>
References: <aPn3MSQvjUWBb92P@shell.armlinux.org.uk>
 <E1vBrlB-0000000BMPs-1eS9@rmk-PC.armlinux.org.uk>
 <81d5c1f2-e912-40de-a870-290b0cf054b3@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81d5c1f2-e912-40de-a870-290b0cf054b3@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Oct 23, 2025 at 08:46:00PM +0200, Andrew Lunn wrote:
> On Thu, Oct 23, 2025 at 10:37:29AM +0100, Russell King (Oracle) wrote:
> > We can simplify stmmac_get_version() by pre-initialising the version
> > members to zero, detecting the MAC100 core and returning, otherwise
> > determining the version register offset separately from calling
> > stmmac_get_id() and stmmac_get_dev_id(). Do this.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>


Hi Andrew,

It seems I had a typo "verison" which should've been "version" in this
patch, which carried through patches 3 and 4. Are you happy for me to
retain your r-b with this typo fixed please?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

