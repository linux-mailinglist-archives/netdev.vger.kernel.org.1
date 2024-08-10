Return-Path: <netdev+bounces-117427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650D694DDD3
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 19:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CBFB281DB2
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 17:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F29916A39E;
	Sat, 10 Aug 2024 17:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="efTnpbBm"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F492F2A;
	Sat, 10 Aug 2024 17:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723312365; cv=none; b=le+SJ5BOYjByikN0oPSjI245yxFPjGiR2Jd4hZykW6Cnn54DqPApLR+WndH0eNKKuuXzLGCOR63tiEQ9yTehUdTcaZNd/oQewXIm7wVGD71ExtplDV11y4a5FBpf6d9yOZedKNUcWc0uF0Mo0167OkZBuwFmvfMuICGy2eQsxKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723312365; c=relaxed/simple;
	bh=e0tv6nXJ4LZUZTv86V7MXxbuh1jk3Kt97an99b1krl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgOTZo8X6P+y/2wjXvlKyyLc42ff+EnG3haFDfaCbUm3nkU1EZSNVfqyflkUyn0pPmc6QV9GBurfEn6k6KQQw/TJalEYh1kaHrNGK8cQQmMFQeHbmBLRDe87puTgxWot21y2ajXFmSU7KRSkMxLv3zvVFjzB+utTzm8q6SZU54Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=efTnpbBm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KJ+BuvHmxUUAXP706pMY7LJcQOTVsjZY8A7lywoxdvw=; b=efTnpbBmbSjOThI0JdLHqBFqMS
	8PDs23XyPeWR9IByBjxnGqMLQltv1CHlV19rIXTVScdCoiPtHn/1rdL3D7rbPaHQyLseGMQuQmbqo
	oRw7SawWIfV/ByNpnFFBcqVc6Z2uOE0g7eEvW2gFR499OFJN320r1g1ql+rE26L0m3eQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1scqGX-004SPL-9Q; Sat, 10 Aug 2024 19:52:33 +0200
Date: Sat, 10 Aug 2024 19:52:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tristram.Ha@microchip.com
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	devicetree@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] net: dsa: microchip: add SGMII port support
 to KSZ9477 switch
Message-ID: <2f59b854-c1d4-4007-bc6e-4c8e88eda940@lunn.ch>
References: <20240809233840.59953-1-Tristram.Ha@microchip.com>
 <20240809233840.59953-5-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809233840.59953-5-Tristram.Ha@microchip.com>

On Fri, Aug 09, 2024 at 04:38:40PM -0700, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> The SGMII module of KSZ9477 switch can be setup in 3 ways: 0 for direct
> connect, 1 for 1000BaseT SFP, and 2 for 10/100/1000 SFP.
> 
> SFP is typically used so the default is 1.  The driver can detect
> 10/100/1000 SFP and change the mode to 2.  For direct connect this mode
> has to be explicitly set to 0 as driver cannot detect that
> configuration.
> 
> The SGMII module can only report basic link status of the SFP, so it is
> simulated as a regular internal PHY.
> 
> Since the regular PHY in the switch uses interrupt instead of polling the
> driver has to handle the SGMII interrupt indicating link on/off.
> 
> One issue for the 1000BaseT SFP is there is no link down interrupt, so
> the driver has to use polling to detect link down when the link is up.
> 
> Recent change in the DSA operation can setup the port before the PHY
> interrupt handling function is registered.  As the SGMII interrupt can
> be triggered after port setup there is extra code in the interrupt
> processing to handle this situation.  Otherwise a kernel fault can be
> triggered.
> 
> Note the SGMII interrupt cannot be masked in hardware.  Also the module
> is not reset when the switch is reset.  It is important to reset the
> module properly to make sure the interrupt is not triggered prematurely.

Why not model this as a PCS? Russell has been converting all PCS like
things in DSA into try PCS drivers. So i suspect Russell will not like
this code, and would prefer a PCS driver.

	Andrew

