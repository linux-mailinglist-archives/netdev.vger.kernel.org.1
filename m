Return-Path: <netdev+bounces-131391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E724E98E69D
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 01:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD7172836AF
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 23:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AD6199929;
	Wed,  2 Oct 2024 23:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xnhoPMqK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196B11991C9
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 23:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727910803; cv=none; b=PefqrUIDYOgLiTZFk53J8Cq0UpI4Jhxoz9oHA7RDmIYqFU+2EaPQjRZCx645VqMfYpWrNBouQUB0KijEmNTIBlbjK9JXaI8jxQaA9b/7MpeHzkuU4thgxGbEM4nYyE1qPX4C7nvkyFw6L+YGUOPYzlFXEYp+w5cRDUatnWk+cao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727910803; c=relaxed/simple;
	bh=GL7CG50Ls4DcfdQ/DHzDyv5i5qARafRdgS0tLKvmois=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4kBvX2jiUj+G+KfxLW8NFt8QWAoBZoMr6aoKTUMd3lZybisfsdjMd0SPy9R6w3k6hPZ9r7dIB/GpSa8j4j34swUi3Z8MXjHYmqKkByC7HIZNDvfoqd4k2kEbKjf1O9dFeK0j11oDzz/qkTBNWn0B5LCocq3/bOJs42zN1kDfkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xnhoPMqK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=T4BZkIzkj8CDbdK8xi7LiVDvTqxTcPR6TfjxKqOtIec=; b=xnhoPMqK4xW2o8+vJV4r8/Nuj8
	xRo8TpETqH56aOZeNtr4ElxYr0jtUKS1iE8vKZeFOHHY1P6OVZpEqSzGXMPr/TVdpgvEuRYOHEWmO
	Y4BXFaInfvmFZ+uznGSNovtB8tBpw5B8cMPRbTMR8EmAX9iXJDb7hnEB2UD6knM6RFoA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sw8Wg-008tzv-BG; Thu, 03 Oct 2024 01:12:58 +0200
Date: Thu, 3 Oct 2024 01:12:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
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
Message-ID: <84c6ed98-a11a-42bf-96c0-9b1e52055d3f@lunn.ch>
References: <ZvwdKIp3oYSenGdH@shell.armlinux.org.uk>
 <E1svfMA-005ZI3-Va@rmk-PC.armlinux.org.uk>
 <fp2h6mc2346egjtcshek4jvykzklu55cbzly3sj3zxhy6sfblj@waakp6lr6u5t>
 <ZvxxJWCTD4PgoMwb@shell.armlinux.org.uk>
 <68bc05c2-6904-4d33-866f-c828dde43dff@lunn.ch>
 <pm7v7x2ttdkjygakcjjbjae764ezagf4jujn26xnk7driykbu3@hfh4lwpfuowk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pm7v7x2ttdkjygakcjjbjae764ezagf4jujn26xnk7driykbu3@hfh4lwpfuowk>

> But if my reasoning haven't been persuasive enough anyway, then fine by
> me. I'll just add a new patch (as described in 2.1y) to my series.
> But please be ready that it will look as a reversion of the Russell'
> patches 2.1 and 2.3.

Note what Russell said in patch 0/X:

> First, sorry for the bland series subject - this is the first in a
> number of cleanup series to the XPCS driver.

I suspect you need to wait until all the series have landed before
your patches can be applied on top.

	Andrew

