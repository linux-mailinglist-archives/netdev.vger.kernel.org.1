Return-Path: <netdev+bounces-166909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96006A37D9B
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 09:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BD1D1885268
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 08:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D3C1A8F63;
	Mon, 17 Feb 2025 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wci7OTtW"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5F41A3147
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 08:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739782478; cv=none; b=gYilBRh7wUNr8zNTXq5aKSbHCBOD1WqtqYLYc6BIc1ZMUQ+vU1/zUr3NeuiLBqvq/QeM5xJ02YrDZeAoe5GMVabzV9jpaAGMj2zK/u+oAaKmOa5ls2uLBfyDODNM7ZqspHgBC45VTw+Fw6/2RagZcObJ49s/si7Qjl9ZxvuQe4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739782478; c=relaxed/simple;
	bh=FaZ+X6BZWpTv1rzkO5RMW8d3sLcDESBA/kCePkMCROg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2NtpXAmKXqjCMjHuaiWjJkH7ga2bNXtweGtDuULwJqGdgttjoGmE1IpEhwG33MwmvH0Pec8coAZ8/ZtJM3DgITFyVufktSY0B3ULIa8+UgVydrf/Wa/Hzf0gzKwqWkwNOsrI44f+YP53TwPgdoH68lLQeYCiI34h0805v8EQKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wci7OTtW; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UGCcRkwnooS9VtsWESWiZqHBA7JDeyAck/80LCrtsMU=; b=wci7OTtWHtwXCyY2r+9i2BmuQ/
	wX71crvPhW1wCxWwagsAPTiEqTNgQCANaBZR01FNCvhKVZ6LTMHWH3KrLwhjLsCfNfEGnjJ01Ifp0
	j4nxLzlrckwKP+kncgauY8Ivv1QXIG8ZhbRNqJdPy2j5UHCRC+mefVf7WpC4HSIP7B+XzHYM7FdNu
	7wCzJcpCIou/du+bTB/ioYWrZsBBvexdlSy7LbfV7G5PAgCrev/pbkSojkUi6EA0OLKzW0BIXCvPk
	g34EI0s4/RBp2CTZkhSjWmrBtRoi4/BNxKLV5HLPrz5tCRMXu2RNBBqBVtJXv/QzImZH58hyhm3uW
	1FoxwPtQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58416)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tjwta-0005rY-1V;
	Mon, 17 Feb 2025 08:54:30 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tjwtZ-00064j-11;
	Mon, 17 Feb 2025 08:54:29 +0000
Date: Mon, 17 Feb 2025 08:54:29 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 2/6] net: phy: improve phy_disable_eee_mode
Message-ID: <Z7L5RasngmDnZ01o@shell.armlinux.org.uk>
References: <3caa3151-13ac-44a8-9bb6-20f82563f698@gmail.com>
 <92164896-38ff-4474-b98b-e83fc05b9509@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92164896-38ff-4474-b98b-e83fc05b9509@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Feb 16, 2025 at 10:16:34PM +0100, Heiner Kallweit wrote:
> If a mode is to be disabled, remove it from advertising_eee.
> Disabling EEE modes shall be done before calling phy_start(),
> warn if that's not the case.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

