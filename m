Return-Path: <netdev+bounces-236590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A5BC3E303
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 03:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6791E18854CD
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 02:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A145521765B;
	Fri,  7 Nov 2025 02:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="a8anxoyB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85F51FAC42;
	Fri,  7 Nov 2025 02:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762480911; cv=none; b=NU6l7Al9473Ytao1ZBArekUJWqYaIenpGuttzmTdNX8mCNY7aNqW0ocUi5GxuCV0NmSvHTa03jR3hS8zKI0nhLzc2wiLKZDLMhe8EeGiuYNcJWavUIdF2kC5fFyjwcnB3SCldco9ejAf+DkgXRh6felTOiTyzBrA8L+Q+Xrx4N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762480911; c=relaxed/simple;
	bh=wO+jO5+m/GOZfMH52JEzzrT8LmPH589gJSnrLAgCL8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrHe2p05nXy+rBA0+6a1aENhN1/vDW7eZGgMhmp6+5HNF3eJ4W2pwm4Ic2HoZh2Z8te+DhMkEtu2ZcmCKVMck8tmUjqE1P/BXfeChuXsL1zlFGVFAvo297pZiQNtVS79Rw1nZ/IlXMD3f/aBrBsMKp4C5RMtDx8McCACNhQ/Er8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=a8anxoyB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8N27r7Oyc3ywyYoactwLwAQqQuBjFkaj2XYsC9wqqK8=; b=a8anxoyBx7wvtgUTEJpLKERgMl
	V+UTcgG4iGjmD2EgxRzkEjCoc7DoHYXIuQHqcF0m9ASAg/1S5j9bxDOoEd4U72iMpsPLAN93IpNUE
	CR3416YcFDWFVvbfyoiq3ftgKJA+x2HK0P9NJwc4bEsCP7cu9fEDb/it4hufMRwquxBo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vHBn3-00DAwe-UJ; Fri, 07 Nov 2025 03:01:25 +0100
Date: Fri, 7 Nov 2025 03:01:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"taoren@meta.com" <taoren@meta.com>
Subject: Re: [PATCH net-next v3 1/4] dt-bindings: net: ftgmac100: Add delay
 properties for AST2600
Message-ID: <8b2f985f-d24e-427e-88cc-94d9bc5815b2@lunn.ch>
References: <20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com>
 <20251103-rgmii_delay_2600-v3-1-e2af2656f7d7@aspeedtech.com>
 <20251104-victorious-crab-of-recreation-d10bf4@kuoka>
 <SEYPR06MB5134B91F5796311498D87BE29DC4A@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <9ae116a5-ede1-427f-bdff-70f1a204a7d6@kernel.org>
 <SEYPR06MB5134004879B45343D135FC4B9DC2A@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <1f3106e6-c49f-4fb3-9d5a-890229636bcd@kernel.org>
 <SEYPR06MB51346AEB8BF7C7FA057180CE9DC3A@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <44776060-6e76-4112-8026-1fcd73be19b8@lunn.ch>
 <SEYPR06MB5134F0CF51189317B94377C09DC3A@SEYPR06MB5134.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB5134F0CF51189317B94377C09DC3A@SEYPR06MB5134.apcprd06.prod.outlook.com>

On Fri, Nov 07, 2025 at 01:12:08AM +0000, Jacky Chou wrote:
> Hi Andrew
> 
> > > There are four MACs in the AST2600. In the DT bindings and DTS files,
> > > what would be the recommended way to identify which MAC is which?
> > > In version 3 of my patches, I used the aliases in the DTSI file to
> > > allow the driver to get the MAC index.
> > 
> > It is a bit ugly, but you are working around broken behaviour, so sometimes you
> > need to accept ugly. The addresses are fixed. You know
> > 1e660000 is mac0, 1e680000 is mac1, etc. Put the addresses into the driver,
> > for compatible aspeed,ast2600-mac.
> > 
> 
> I used this fixed address as MAC index in the first version of this series.
> But the other reviewer mentioned maybe there has the other better way to 
> identify index.
> https://lore.kernel.org/all/20250317095229.6f8754dd@fedora.home/
> I find the "aliase", on preparing the v2 and v3, I think it may be a way to
> do that. But I am not sure.
> So, I would like to confirm the other good way before submitting the next
> version.

The problem with alias is that it normally a board property, in the
.dts file. A board might want a different mapping, which could then
break delays.

	Andrew

