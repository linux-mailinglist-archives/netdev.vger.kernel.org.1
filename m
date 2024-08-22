Return-Path: <netdev+bounces-121100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C5195BAF5
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 17:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A69111C235AC
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 15:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09911CC163;
	Thu, 22 Aug 2024 15:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GR+ELl8o"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D1C1C9EC4;
	Thu, 22 Aug 2024 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724341801; cv=none; b=R3IRCjMHaeGY0I10x3V6S5+IqIRnJxVMijJ/dQS3oD9eh+AzdUv5dvSMQYp5N/nWJJO2kEdO30RpBOF8tydXhfeu0oABLtXDvOfnqRJLFlVJ0Xc9KmKXOrww0ChCgWCXVk6QCV325CxNhe2M3dqaTTXabvPXaB22NgEsI7jwdis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724341801; c=relaxed/simple;
	bh=Yt9hQ3I2tZCTt0WKclQj3ASyNM+KSaK1c+0J+E/9CqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYVabhC5ohsCXD2T4neyOTiM5XsvzsABF39a0FjtcY8EPQLzrQ9B4ixY4U4NAKA1127RIPCr5tFbs8/DNZp3mClddCrLYIRmN4FS1m2ZVqYb6r8jMSULJlj2nwD+H6DPld8pe0+ZgZJVftDxVUncopjXxUiyoXujmxEFNisHEkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GR+ELl8o; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WR5hjaWl3HcDCXvvJnF07p+ySaPY+8eWnQyGTxeF4Ms=; b=GR+ELl8oTAMdaNaQmTxnVOJ9JH
	0HIUxaROTUI2RDsbdWz10+Gc023JMu4mfUwpCMSrDNS78xGQYJ3e14xAwm9s2uhX9d04twy4DG5bt
	F0jKaNFgHfZZ5+pRJ1+mOsx/oMdDuEkQS+ueBJ3WQxh/+ghCcGheq0J7K3+lhHeY/VfI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1shA4M-005Ra5-QN; Thu, 22 Aug 2024 17:49:50 +0200
Date: Thu, 22 Aug 2024 17:49:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/3] phy: dp83tg720: Add statistics support
Message-ID: <f18ac2ce-3bbf-4f12-8d0c-14429aaf9e40@lunn.ch>
References: <20240822115939.1387015-1-o.rempel@pengutronix.de>
 <20240822115939.1387015-4-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822115939.1387015-4-o.rempel@pengutronix.de>

On Thu, Aug 22, 2024 at 01:59:39PM +0200, Oleksij Rempel wrote:
> Introduce statistics support for the DP83TG720 PHY driver, enabling
> detailed monitoring and reporting of link quality and packet-related
> metrics.
> 
> To avoid double reading of certain registers, the implementation caches
> all relevant register values in a single operation. This approach
> ensures accurate and consistent data retrieval, particularly for
> registers that clear upon reading or require special handling.
> 
> Some of the statistics, such as link training times, do not increment
> and therefore require special handling during the extraction process.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

