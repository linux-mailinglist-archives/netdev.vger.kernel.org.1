Return-Path: <netdev+bounces-120177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5189587D2
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 15:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 171B2B21608
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 13:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B8519046E;
	Tue, 20 Aug 2024 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="H6dgkpz6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1079918E370;
	Tue, 20 Aug 2024 13:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724160346; cv=none; b=FHW8WOtjY47+Sq0fmcgCvmIYJa78ZybMX0vmLdxIyb4s19BvkOEeuuaBpDB0xSpBEIrTjp/bAVk6ClmYavlkT8RLyn0kVy1rMxhX/y+5a4fsVYiAzgGBsBisZ+sw6sELMz2O4djTmiYRQu4fKmLMp6PtD7SmML59KeBUfwBO848=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724160346; c=relaxed/simple;
	bh=nXotEjWHRHqZNxB4azPS0pQFiOS7aFd8+CVjDMf0jBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaSVYFHMVhouCeVV06XbJaHkMgjXLXBBGESxTGybOujAOjoQtcaSI+uV1MoqmQ6ZfQOtgsRBm4QzFAyXRG3+csONZ4P/iQ7pgAw24nwLDtJFrD2u4mkALnnC7jeSj3Pp1QugOb0Ro5fNrkCsdiPwjJz56k7tUlo76bfMDjc2Srs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=H6dgkpz6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vXkydQsIQwMnO+SDvyfUoarMlkGKie6DTsYruPcvW1A=; b=H6dgkpz6NYa1DroKKkNP7SfgUu
	JtGJdpqLEmNVHbrvdv4FMYHshP05Ix+ZHsIawYlk53rE0uXH1biMbPQyiJAEki1o5Z6+puZOUWVkp
	f455BdpOWB7qxY5g/2qL5OQb06vrkX8Q5X41/EUOFKgOGg5yEyuBUrMegq8KdKZ9mwfo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sgOrY-005Dxl-KK; Tue, 20 Aug 2024 15:25:28 +0200
Date: Tue, 20 Aug 2024 15:25:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"Andrei Botila (OSS)" <andrei.botila@oss.nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/3] dt-bindings: net: tja11xx: use reverse-mode
 to instead of rmii-refclk-in
Message-ID: <248b38f3-3cb6-4dd8-825b-e4d2083a99ef@lunn.ch>
References: <20240815055126.137437-1-wei.fang@nxp.com>
 <20240815055126.137437-2-wei.fang@nxp.com>
 <7aabe196-6d5a-4207-ba75-20187f767cf9@lunn.ch>
 <PAXPR04MB85108770DAF2E69C969FD24288812@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <dba3139c-8224-4515-9147-6ba97c36909d@lunn.ch>
 <PAXPR04MB8510FBC63D4C924B13F26BD988812@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <718ad27e-ae17-4cb6-bb86-51d00a1b72df@lunn.ch>
 <PAXPR04MB851069B2ABDBBBC4C235336E88812@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <PAXPR04MB8510B51569571BA58243FEB0888D2@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8510B51569571BA58243FEB0888D2@PAXPR04MB8510.eurprd04.prod.outlook.com>

> > Sorry, I didn't find the correct PHY driver, could you point me to which PHY
> > driver that I can refer to?
> > The PHY drivers I searched for using the "clk" keyword all seem to set the
> > clock via a vendor defined property. Such as,
> > realtek: "realtek,clkout-disable"
> > dp83867 and dp83869: "ti,clk-output-sel" and
> > "ti,sgmii-ref-clock-output-enable"
> > motorcomm: " motorcomm,tx-clk-1000-inverted"
> > micrel: "rmii-ref"
> 
> Hi Andrew,
> I still cannot find a generic method in other PHY drivers to provide
> reference clock by PHY. So I think this patch is the best I could do, at
> least it's more reasonable than the "nxp,rmii-refclk-in" property.

I did not say there was a generic method. I just said copy one. We
have too many different ways of doing the same thing, so we should not
add another one. Which of these is closest to what you want? You
should use your own vendor part, but copy clk-output-sel, rmii-ref,
etc, and implement the same behaviour in your driver.

     Andrew

