Return-Path: <netdev+bounces-205096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A450AAFD583
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 19:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32574567202
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 17:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858F12E613A;
	Tue,  8 Jul 2025 17:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kGJYjVWq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8E82E5B2F;
	Tue,  8 Jul 2025 17:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751996073; cv=none; b=i0X4OIm3gdt8vp0rAPml7BdIruFNqKKmpjIpOJIWKnYB+1KSkIea2cEYz1SdwoOp0EHZzZIpqpUezad5DsHfXSZTdiEnZfVjAFXv/ehu2ejPiQPSEdFC2T2jFSEdu91EKI4AVIaJl4xVSzCPt/BMcHjuesJTCBxPcYH4lpr9lg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751996073; c=relaxed/simple;
	bh=jAMQSvjI09pdeyUUa7Sm7Sk4KAidq+tSxk/w2vOpEv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpddXR8lWT3tWB043sbDGiTS2jrqrVkwNcJoAvgRs29QJLZw5v1NRYvrk6BtN/snAl1wlc5L3nP+MV8iSPVUr03Vf+s+nEZqLlrd/LLP4zMU3zLIIWrqwx4EAFT0tj/LDj/U9lRJXIOj4ZI7qPz3SaYIz7tEz93gWuGBJjfJ4VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kGJYjVWq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HeTiWPyX1Uk+AB/SKOARIcNngzgui6r0hgRLKTkBHIA=; b=kGJYjVWq21LQqgydAHfeMNK8dp
	J+6sYTxzXjuLubKC7Msz6ENWEUhgmhPn7m7sPTbPabrY4Fba/Z4b1v/jshyrMB+sTdxoUK4iuh2/a
	w0SYNPthAl6FLk/Q0LS0blYMeW0hPMDJTZMy5Qe79sgTlbuRBhf8Er9jUGmxf6OxTVlY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uZCCl-000qlv-FD; Tue, 08 Jul 2025 19:34:07 +0200
Date: Tue, 8 Jul 2025 19:34:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lizhe <sensor1010@163.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
	vladimir.oltean@nxp.com, maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: Support gpio high-level reset for devices
 requiring it
Message-ID: <52b71fe7-d10a-4680-9549-ca55fd2e2864@lunn.ch>
References: <20250708165044.3923-1-sensor1010@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708165044.3923-1-sensor1010@163.com>

On Tue, Jul 08, 2025 at 09:50:44AM -0700, Lizhe wrote:
> some devices only reset when the GPIO is at a high level, but the
> current function lacks support for such devices. add high-level
> reset functionality to the function to support devices that require
> high-level triggering for reset

You can probably specify this in DT:

reset-gpios = <&qe_pio_e 18 GPIO_ACTIVE_LOW>;

The gpio core will then flip the meaning of

gpiod_set_value_cansleep(reset_gpio, 1);

such that a value of 1 will become low, 0 will become high.

     Andrew

