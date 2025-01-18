Return-Path: <netdev+bounces-159577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33518A15EAD
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 21:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A71F2188619D
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 20:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F961ACEC6;
	Sat, 18 Jan 2025 20:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GSfZ+dGD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033E014A627;
	Sat, 18 Jan 2025 20:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737230476; cv=none; b=oNDEkdB6bwz0JZ/dK2Ux4BHtG2Tgrl/l/vKX6sJNU28/flHMT16Fr9fYq0IRy+L2Htwf0ujlIHcoJPtIZBMyW+ExUhuCGkeMuefZhnOF5m63WZZd72TGHENGc7Gl1Vnx3ezqv5r2jSRH/WM8BJVAKiaJ4kHcP+4Px0itYKambT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737230476; c=relaxed/simple;
	bh=HKMd0jtzV0ytDdBoYba9L3E/E6UavxaScvGVAqdog8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXD7Vt0b1Jx8+RCKsIO06fUd8KyG4AzqchltHWcMGh/+0PfhTRIgKe0IOqhsjKYb0aKqbX8knfi+B3SwE5NeFo0DKPYvcuku4MijyAlQeOljxMa3e43uHVcZ1njRbbVWVtth2td+HwyvAbDaY2BeUVPtBQJymA7Re5KoP0z8pR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GSfZ+dGD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GfrK++bidEGfdhvSl8mhYSsNBxbiCKv4yOdsDGIYaS0=; b=GSfZ+dGDUA+zoCpRjVDKuxHvcZ
	RjO8lQ3EMdQuxxpj8/3pNriymzdps3Oms9PZzL+NCrjf1jPvEw5kmGopEhAM3PwCD2zeWHfHYDxwR
	POpf66Fcv4CEn3EoGZ7TPQyOI3FPjlVSypgFa5rJgtDR3ru+uP2ikI4BzzzDe6DMJQ7M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tZEzu-005rlH-G1; Sat, 18 Jan 2025 21:00:46 +0100
Date: Sat, 18 Jan 2025 21:00:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tristram.Ha@microchip.com
Cc: olteanv@gmail.com, maxime.chevallier@bootlin.com,
	Woojung.Huh@microchip.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Message-ID: <8ad501e1-a56c-48d5-bafb-125bc1099b7b@lunn.ch>
References: <20250114024704.36972-1-Tristram.Ha@microchip.com>
 <20250114160908.les2vsq42ivtrvqe@skbuf>
 <20250115111042.2bf22b61@fedora.home>
 <DM3PR11MB87361CADB3A3A26772B11EEEEC1B2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <91b52099-20de-4b6e-8b05-661e598a3ef3@lunn.ch>
 <DM3PR11MB873695894DC7B99A15357CCBECE52@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20250118012632.qf4jmwz2bry43qqe@skbuf>
 <DM3PR11MB873610BA4FE0832FCB3CA5BAECE52@DM3PR11MB8736.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM3PR11MB873610BA4FE0832FCB3CA5BAECE52@DM3PR11MB8736.namprd11.prod.outlook.com>

> 0x1f8001 needs to be written 0x18 in 1000BaseX mode, but the XPCS driver
> does not do anything, and bit 4 is not defined in the driver.

Does the Synopsis data book describe this bit, for the version of the
IP you have? Is it described in later version?

> The driver enables interrupt in 1000BaseX mode when poll is not set, but
> it does not do that in SGMII Mode.  In KSZ9477 SGMII mode can trigger
> both link up and link down interrupt, but 1000BaseX mode can only trigger
> link up interrupt.  It requires polling to detect link down.

I don't know this driver, but a quick look suggest TXGBE requires
polling. It should be easy to piggy back on that and have KSZ9477
always poll. Just because the hardware can do interrupts does not mean
you actually need to use it. My experience is you are more interested
in fast link down notification, so you can trigger routing protocols
to find an alternative route. You are less interested in fast link up.

	Andrew

