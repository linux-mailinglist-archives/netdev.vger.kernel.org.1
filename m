Return-Path: <netdev+bounces-236562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6EAC3E026
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 01:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B0FA4E2EC5
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 00:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A3C2D9EE7;
	Fri,  7 Nov 2025 00:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eVWTBKou"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29011482E8;
	Fri,  7 Nov 2025 00:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476426; cv=none; b=FwjyWzioyH3eAfbwYa4Q/R1Ecz+5jcxCFJzYIi9gH0PIwdtZcWBsT2UmAhSkbWS+Far5rvh7kGcIWl9HIe59VH5y9aJyThBmLQsDyboHZ4tmmZjqH/K8Ztryz3Hyqs3Eyk1Wk6jDdmLCZ77/2bFU+H/Fn52Xifz6iEQOpRLkDyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476426; c=relaxed/simple;
	bh=UauAuAVRl8qpfeybXEwzh1tNC4Ry5nOH3kT6C36Rxws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnyQaLjABQR+aWxzKugCxsICQfyDjuMRmC7YZP0Djwyxtsn/uYB59XefjiWSeYyQGWL79nLpteXUXJdzzNP19DbMgDtvDbqhFzqt7s4cVlXB5m+WW9rgK8vQg433AH+dPLHnUwAAhUSfThbUW+o59Z0Xm1QL3rDOabCe9j+iSoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eVWTBKou; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WrNpnT5reuJY83DsJNX7vrBmHrZOe4gWqsUP7XHCLTI=; b=eVWTBKouPKx6jECpQqrB4mfOfe
	MdkLukCOYF96hVapsQDBaRkfMHMnT/U3zhU6hX+VQ4jW5hIudKycTn4Hy5MRFPo9EsgxRi/Dki3b8
	oHJtGyvWm8nPZvSHTcZEZpabug3yldmEGYP2JE8gLkhmqz7WOuRqiUtcKZFx1MSV44nI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vHAch-00DAXt-E3; Fri, 07 Nov 2025 01:46:39 +0100
Date: Fri, 7 Nov 2025 01:46:39 +0100
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
Message-ID: <44776060-6e76-4112-8026-1fcd73be19b8@lunn.ch>
References: <20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com>
 <20251103-rgmii_delay_2600-v3-1-e2af2656f7d7@aspeedtech.com>
 <20251104-victorious-crab-of-recreation-d10bf4@kuoka>
 <SEYPR06MB5134B91F5796311498D87BE29DC4A@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <9ae116a5-ede1-427f-bdff-70f1a204a7d6@kernel.org>
 <SEYPR06MB5134004879B45343D135FC4B9DC2A@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <1f3106e6-c49f-4fb3-9d5a-890229636bcd@kernel.org>
 <SEYPR06MB51346AEB8BF7C7FA057180CE9DC3A@SEYPR06MB5134.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB51346AEB8BF7C7FA057180CE9DC3A@SEYPR06MB5134.apcprd06.prod.outlook.com>

> There are four MACs in the AST2600. In the DT bindings and DTS files, what would be 
> the recommended way to identify which MAC is which?
> In version 3 of my patches, I used the aliases in the DTSI file to allow the driver to get 
> the MAC index.

It is a bit ugly, but you are working around broken behaviour, so
sometimes you need to accept ugly. The addresses are fixed. You know
1e660000 is mac0, 1e680000 is mac1, etc. Put the addresses into the
driver, for compatible aspeed,ast2600-mac.

	Andrew

