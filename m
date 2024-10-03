Return-Path: <netdev+bounces-131521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D872998EBF5
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 10:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15A4C1C21868
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 08:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB8613E8AE;
	Thu,  3 Oct 2024 08:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="f2a3Mqy1"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F36113DDA7
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727945931; cv=none; b=ZfNQ/wcsgqerugz1ysue7utDsnqnecs3AFob63nTAnygTxsDIwAdvLG1kJwD1Y0kXxef5BSIy5Sq9dptUcvDeHSxASG7+Npg0LRoDOfc6xSUOpD9iCbjDaJj9jpnCV9+ENTLwwVxALjiE2B8bJ6gWhCW14gNWUx8MwFS9QVamWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727945931; c=relaxed/simple;
	bh=yJURDnNDQiZUE90QYDh4jdtUYSpZbO3Ppah3qoVkm50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6MZW1KmNpWUnN7h/dx3/HihWFNJJvFYebwsaAWN7qIP7qfOoh2i365RcYGs7euNIALVeHEuLl24tEUSt8yOpL8fccb6DS1PbnOzrwS/S2cENI+ToI1dTmb8bIzenlmCXGDCxP0B/E9S2ZFvwPf4BjVhqGksvqVCNPPGU0YztI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=f2a3Mqy1; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UFLXtPkTLY9YWYZuXI/P16YFfhLwH7LyfPFSOm6FhPE=; b=f2a3Mqy1/UmSRsEMEZEmFw98V1
	diNLZbOIBVVY8BoDG/fZ8cqJ6SZSuVJMdn8sHRWgiyZ4RMEaRy2Slj56JvXptUHX4GOIxhd5Zv+RC
	moH2xuEcEti3ftKGrPd+K+8EXFP5m/hRMW4/aeXAH2Xz9IpNXHpLq72hBqQ+YhupXuuXuqAY9PAcn
	ja4ggHIvFm/b3NXcUPbBZ8dAI2w8ETSLk8eaoion8MzHPh8UokFR35lZqzEkigfHDV+QssbXYKQrf
	oYXu0nD/paz6vYVqU23/H9TkER5gQ0an6OV1LBEhznG7EhDTUZBz4NJyqyuWkRoubFv5SqaGGY2FP
	6kqe37bQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48300)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1swHf9-0000EN-0r;
	Thu, 03 Oct 2024 09:58:18 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1swHf1-0008PL-23;
	Thu, 03 Oct 2024 09:58:11 +0100
Date: Thu, 3 Oct 2024 09:58:11 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH net-next 01/10] net: pcs: xpcs: move PCS reset to
 .pcs_pre_config()
Message-ID: <Zv5co5giM1AcQxD6@shell.armlinux.org.uk>
References: <ZvwdKIp3oYSenGdH@shell.armlinux.org.uk>
 <E1svfMA-005ZI3-Va@rmk-PC.armlinux.org.uk>
 <fp2h6mc2346egjtcshek4jvykzklu55cbzly3sj3zxhy6sfblj@waakp6lr6u5t>
 <ZvxxJWCTD4PgoMwb@shell.armlinux.org.uk>
 <68bc05c2-6904-4d33-866f-c828dde43dff@lunn.ch>
 <pm7v7x2ttdkjygakcjjbjae764ezagf4jujn26xnk7driykbu3@hfh4lwpfuowk>
 <84c6ed98-a11a-42bf-96c0-9b1e52055d3f@lunn.ch>
 <zghybnunit6o3wq3kpb237onag2lycilwg5abl5elxxkke4myq@c72lnzkozeun>
 <acdc1443-15ca-4a35-aee0-ddf760136efa@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acdc1443-15ca-4a35-aee0-ddf760136efa@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Oct 03, 2024 at 02:04:36AM +0200, Andrew Lunn wrote:
> > Anyway the Russell' patch set in general looks good to me. I have no
> > more comments other than regarding the soft-reset change I described in
> > my previous message.
> 
> Sorry, i've not been keeping track. Have you sent reviewed-by: and
> Tested-by: for them?

Of course Serge hasn't. He hasn't even said he's tested them. He's more
concerned with the soft-reset change to do anything else other than
whinge about that.

After the previous debacle over the stmmac PCS cleanup (that I've given
up with) I decided later in the series of XPCS cleanups I have to touch
stmmac as little as possible because I don't want to interact with
Serge anymore. This has now been reinforced further, to the extent that
I'm now going to ask Serge to _remove_ all usage of phylink from stmmac
for this very reason - I do not wish to interact further with Serge.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

