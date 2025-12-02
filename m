Return-Path: <netdev+bounces-243210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 50163C9B9EC
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 14:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 424D44E31F5
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 13:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAD5314D3C;
	Tue,  2 Dec 2025 13:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VC9d/UAn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05A52BE033;
	Tue,  2 Dec 2025 13:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764682613; cv=none; b=AccLlu45GsfwuTamrii4Q96UA9DQ11d2VeO9OI6sVK+2H7DljiSA67QJ0g1job22hpE9u1oGEKxHmg5zF49xFz7vK++WMc7SKSluUNnsH0vJIhHRk4UK9GZMDU2SF0W7e5foP3y3ZYOpBBsq6yZvo4jyDC/4+goUbi6iaQs8mlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764682613; c=relaxed/simple;
	bh=fdhup/S/zrXpJWaUcDkcxNrD2Cwp5IAQxDToERCP1nI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GuzJ477PwwfLSfX3c6PR+2VSOvSHfST7oEn98jTsOei3ivmg+Xp8vSfq/a26RRhkLENPhFafALfaJ9Qc+ijdij0a3+s75+dOt8FFPyolkxSLQOEEJtd83yppQh79DoIo4M0FG6SUrCZskGwiDT+mD523uUzIBx79E6SrtAS0URI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VC9d/UAn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1Wpx9IjkcuCXJrN+lvoQ0/PWGUe4eWqI7yjH11ZhMTc=; b=VC9d/UAnse+naHpZdifFVmTv3e
	21BAnHhjw8HPGF19RKmyVaDfCX6uHMOxsibeLkKxh5KZZeEQwS0ZaR2Ua03HSCUyahL8vElefUN41
	iBZxxnp/a8B+iPeb1ShSxBRSNEViUIygvNlf3anjA6FMYUa0PzxmLXuwq5Uhc3Ct54bE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vQQY7-00FhXN-UW; Tue, 02 Dec 2025 14:36:11 +0100
Date: Tue, 2 Dec 2025 14:36:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Tao Ren <rentao.bupt@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
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
Subject: Re: [PATCH net-next v4 4/4] net: ftgmac100: Add RGMII delay support
 for AST2600
Message-ID: <4f0e4aa0-166d-4a7f-b91e-42dbc6b832e5@lunn.ch>
References: <68f10ee1-d4c8-4498-88b0-90c26d606466@lunn.ch>
 <SEYPR06MB5134EBA2235B3D4BE39B19359DCCA@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <3af52caa-88a7-4b88-bd92-fd47421cc81a@lunn.ch>
 <SEYPR06MB51342977EC2246163D14BDC19DCDA@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <041e23a2-67e6-4ebb-aee5-14400491f99c@lunn.ch>
 <SEYPR06MB5134BC17E80DB66DD385024D9DD1A@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <1c2ace4e-f3bb-4efa-a621-53c3711f46cb@lunn.ch>
 <aSbA8i5S36GeryXc@fedora>
 <SEYPR06MB513424DDB2D32ADB9C30B5119DDFA@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <SEYPR06MB5134A5D1603F39E6025629A19DD8A@SEYPR06MB5134.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB5134A5D1603F39E6025629A19DD8A@SEYPR06MB5134.apcprd06.prod.outlook.com>

> Hi Andrew,
> 
> I miss one condition is using fixed-link property.
> In ftgmac100, there are RGMII, NC-SI and fixed-link property.
> On RGMII, we have solution on dedicated PHY, but there is an issue on fixed-link
> property.
> 
> Example on dedicated PHY.
> The driver can pass the "rgmii-id" to tell PHY driver to enable the internal delay on
> PHY side. Therefore, we can force to disable RGMII delay on MAC side.
> But there is not any driver when using fixed-link property, which means
> no body can tell the outside device, like switch or MAC-to-MAC, to enable the internal
> delay on them. Also mean the phy-mode in fixed-link case is not used.
> 
> Therefore, could we ignore the RGMII delay on MAC side when the ftgmac100 driver gets
> the fixed-link property? Just keep the original delay value?

MAC to MAC is one of the edge cases where phy-mode is not great. What
is generally accepted it to use rx-internal-delay-ps and
tx-internal-delay-ps with 2ns and a comment explaining it is a MAC to
MAC link, with this MAC adding the delays.

I suggest you see how messy it is to implement this for 2600. If the
code looks horrible, keep the bootloader delays. For 2700 you have a
clean slate, you can implement all this correctly from the start.

	Andrew

