Return-Path: <netdev+bounces-119092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCC895400B
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 05:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACB511C220EA
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 03:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D92482E4;
	Fri, 16 Aug 2024 03:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="D4facMP/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CBC1877;
	Fri, 16 Aug 2024 03:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723778899; cv=none; b=evuEtqAQ5yZcArnjTiTLJMF22KfIstnhQT8nXShYNCvZEQFjZjHB8oaKk3x6oTBeAIC1mNeuwqXg8IsO/lpCp3edOsUkZyPaHaXWz9n+GH3tyguiGnvTess3PoNK+qdVzhCfzvWgnKQGf7bpQLiGMtUQEZXg+6T/nEdMDVRzS5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723778899; c=relaxed/simple;
	bh=bE1k2xABhVL+V7BEWHafJOj/zxazAkjyhmPpLGfqL/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbFPHU0nhNNol9dpxnvIj48pq/UeTWAxuJ2SqLQvIaixWCqD/fpcPtIWBzFD/4Q4K/BfMIifGFIqWN2n7eTyi9gu5ZkUZOX8UmffR/13cpXMA1wYNevR8hjan4+SuFvD2JbjT8XVIQ75Fw9MlhMhBU0r506IMzFtDRyLZR7bzIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=D4facMP/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=y+Gxe46x0e2FCrVOFCYCcT5Oj90T8dZoy+0yxj4iqOo=; b=D4facMP/U4YmD41M+Hagy/ijda
	gXpWGyCNYKJ/H7/cuayZrjsRpTvZJ+sfeDno4sDbW1gKI++XXtJRuIoAQ8iIVw0rWEGaa7SolYhIF
	PzJZElXEZVvvDUuNbROd3Wu1m7UnFFBR5yXOxx1sMDZ9opGWwIRxI4QQPexa3ZMia7HM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sendG-004tau-AW; Fri, 16 Aug 2024 05:28:06 +0200
Date: Fri, 16 Aug 2024 05:28:06 +0200
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
Message-ID: <718ad27e-ae17-4cb6-bb86-51d00a1b72df@lunn.ch>
References: <20240815055126.137437-1-wei.fang@nxp.com>
 <20240815055126.137437-2-wei.fang@nxp.com>
 <7aabe196-6d5a-4207-ba75-20187f767cf9@lunn.ch>
 <PAXPR04MB85108770DAF2E69C969FD24288812@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <dba3139c-8224-4515-9147-6ba97c36909d@lunn.ch>
 <PAXPR04MB8510FBC63D4C924B13F26BD988812@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8510FBC63D4C924B13F26BD988812@PAXPR04MB8510.eurprd04.prod.outlook.com>

> Based on the TJA data sheet, like TJA1103/TJA1104, if the reverse mode
> is set. If XMII_MODE is set to MII, the device operates in revMII mode
> (TXCLK and RXCLK are input). If XMII_MODE is set to RMII, the device
> operates in revRMII mode (REF_CLK is output). So it's just that the input
> and output directions of xx_CLK are reversed.
> we don't need to tell the MAC to play the role of the PHY, in our case, we
> just need the PHY to provide the reference clock in RMII mode.

If this is purely about providing a reference clock, normally 25Mhz,
there are a few PHY drivers which support this. Find one and copy
it. There is no need to invent something new.

	Andrew

