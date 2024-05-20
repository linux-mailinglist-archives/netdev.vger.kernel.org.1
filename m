Return-Path: <netdev+bounces-97226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC07B8CA186
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 19:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75AC11F21D59
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 17:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049611369BA;
	Mon, 20 May 2024 17:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HOEcB3m6"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F37DD53E;
	Mon, 20 May 2024 17:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716227340; cv=none; b=fmt/2V5/MdOwai5ulOCtIZAuxP8zCI3pCcbimnNp0DacUbZWaUJQd0kXM1ebnTSM9m0bIkkFg6YpBml2MwbWm0pE/cHCRabt4Atn5/ITWV9mPr03TpNERd7ib7coy/ZtaTjik8FQmjuUSMl3ayF8/QN+fIrjNP0+3LSjcidUzCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716227340; c=relaxed/simple;
	bh=Gj0UBJfjFW3PwUY9gUpaYI356SaQ6by9B7HTUA781h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGy3bOHaAoCQ0Aa23wWcBczY4n6vmK78qkd3cStCWmG6q1U9fJzUQtPEzzV7+4sR2n8048CrPLkfkq5nDbths5YUGNpQbmq2VT/DsNLa47BCsuIJPY15tLSpFK7qt0WOYGB0GKROkaAgTHaX+Ab20pGq8RfXDACYHPxlmiHZQns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HOEcB3m6; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XfldnoFCtlXjDUGIkjCxDruNAojvgZwZWzyNtsiBzQI=; b=HOEcB3m6VMMOMDPp2cPBpKomlO
	FekL9B6kRdA3i7PGuGVL6jOAl8+l8w4sUza98ZBCYB/she/YBJ87BuBH/uYaxdE0EVgc3NuHmKYlW
	G1Ufav1ydalYq60mo06uVnnWf/kBK2CQ8r2vQNHzg4CLAw1v9RiQvAk9/zNTZjnT/kfcomuOfzkX6
	5T7DUyMXFY3xpexzATBep97nyKXYp78EbdrCUPVIVzmv5gisGMe3TS8KECo+DwihcrSHB0zDyCcvH
	4nTUFM0bejLOuEE2KQzySqDJv7nHOjAlIOYeDIK/HOKE000QjQLooBC1E7cXoNEvMFVCsonX1lTb3
	+UnysHNg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52632)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s977m-0007BC-2Y;
	Mon, 20 May 2024 18:48:38 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s977k-0004Tz-AX; Mon, 20 May 2024 18:48:36 +0100
Date: Mon, 20 May 2024 18:48:36 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: SkyLake Huang =?utf-8?B?KOm7g+WVn+a+pCk=?= <SkyLake.Huang@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dqfext@gmail.com" <dqfext@gmail.com>,
	Steven Liu =?utf-8?B?KOWKieS6uuixqik=?= <steven.liu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH net-next v2 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Message-ID: <ZkuM9C0Yd/uwwzUA@shell.armlinux.org.uk>
References: <20240517102908.12079-1-SkyLake.Huang@mediatek.com>
 <20240517102908.12079-6-SkyLake.Huang@mediatek.com>
 <cc0f67de-171e-45e1-90d9-b6b40ec71827@lunn.ch>
 <283c893aa17837e7189a852af4f88662cda5536f.camel@mediatek.com>
 <8a5f14f4-4cd9-48b5-a62c-711800cee942@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a5f14f4-4cd9-48b5-a62c-711800cee942@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, May 20, 2024 at 03:02:21PM +0200, Andrew Lunn wrote:
> > Actually this phy is strictly binded to (XFI)MAC on this platform.
> > So I directly disable HDX feature of PHY.
> 
> Sorry, i don't follow your answer:
> 
> Can the PHY do half duplex?
> Can the MAC do half duplex?
> 
> The part which cannot do half-duplex should be the part which disables
> half-duplex.

Note that if the PHY is doing rate adaption (preferably in a form that
it can control the MAC transmission rate), then even if the MAC can't
do half-duplex, the PHY can still do half-duplex.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

