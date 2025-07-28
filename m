Return-Path: <netdev+bounces-210623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BBAB14108
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 19:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF0CB5406C6
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 17:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872811C862C;
	Mon, 28 Jul 2025 17:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Vf1libXA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E30CEED8
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 17:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753722739; cv=none; b=NkFU0A7sokbsQxMv4vapJ2FzbT+o2ZvUoKrUakG950GTZQW+h7ktspCuEpq6Gb75sxJjKcsymgNnN6puEab9FGczV+8cJFvI14D+1W9Zy/b1kkZeAwk9HSEzBQxM4ui0D6joPSG+HbnQ/w+jw2za5vj56F+NFn8DFByZeG+t/74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753722739; c=relaxed/simple;
	bh=w9B91kJ6rsl4uhiQCRb6LEQSxDXMUQ3qowQpyC2FjL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXFYVU2OFJJ4INWXlmT4DjMIBgl97mhpD1KwRvG4pTUEHcuaTj8CINNFCrFjGgibdI33oqB1uX08+Lc1hmuDkEq4J7q/qgX4ihbMofpLQxC0NXFI9VaSShqoqrF74VPsAOuLgmB0LcziR9zh2Ti7vB0yBpkS246cEQADVBebrpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Vf1libXA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oeyvvuTCaBRy7drnXePaUBtIXrGKicLr161z5oeQWTA=; b=Vf1libXAmZ3fGrZF9TaeB87gB2
	MJ2BnUHvG4/m97ycRsaJ57W7ul5gbL+O9Fxep5UQTv8DTohMHFI2z5tCNqmPKCr4gZbjd8A86d927
	oGo5S/UHAaItwJOjxYQv0n9P/81zK8GZIp7Jdkbuz4P6Q4u5cGTBpeg9d8jZv2lJorRU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ugROS-0037Ks-E7; Mon, 28 Jul 2025 19:12:08 +0200
Date: Mon, 28 Jul 2025 19:12:08 +0200
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
Subject: Re: [PATCH RFC net-next 5/7] net: stmmac: use core wake IRQ support
Message-ID: <c8fe4307-f036-40bd-8d77-b80f19ca8fc2@lunn.ch>
References: <aIebMKnQgzQxIY3j@shell.armlinux.org.uk>
 <E1ugQ2y-006KDL-K7@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1ugQ2y-006KDL-K7@rmk-PC.armlinux.org.uk>

> -	if (wol->wolopts) {
> -		device_set_wakeup_enable(priv->device, 1);
> -		/* Avoid unbalanced enable_irq_wake calls */
> -		if (priv->wol_irq_disabled)
> -			enable_irq_wake(priv->wol_irq);
> -		priv->wol_irq_disabled = false;
> -	} else {
> -		device_set_wakeup_enable(priv->device, 0);
> -		/* Avoid unbalanced disable_irq_wake calls */
> -		if (!priv->wol_irq_disabled)
> -			disable_irq_wake(priv->wol_irq);
> -		priv->wol_irq_disabled = true;
> -	}
> +	device_set_wakeup_enable(priv->device, !!wol->wolopts);

It might be worth mentioning in the commit message that
device_set_wakeup_enable() does not care about unbalanced calls to
enable/disable. This obviously caused issues in the past with
enable_irq_wake()/disable_irq_wake().

	Andrew

