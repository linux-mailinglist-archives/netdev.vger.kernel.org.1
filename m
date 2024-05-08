Return-Path: <netdev+bounces-94569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0628A8BFE09
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 15:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5495285BE6
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 13:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8076A347;
	Wed,  8 May 2024 13:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="RxSJb7Sp"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5614256454;
	Wed,  8 May 2024 13:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715173801; cv=none; b=DGbv3BriERxDFsSnR/ybIiMZbSkKcg5XigHr/65CHzSKYupmKzZ3syG+z7y9kuCUoS8FYD3nPEKETv52bJvT2FCHENOBI0FJ6Hk6AaYQjKTwKmjBzEsh8kgwsNupzQpyIRz69pimxkeS0eSK+V0zBGFDadIfyYYCvS0fvyNLykk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715173801; c=relaxed/simple;
	bh=9nupFW/QjOyvBp4lXy18CeJ4uCNVsZ8k/Rv/E8n9eP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLchTOUjkA8pxQM0wncQbkGfWfAivfs0mitZdYjoCfrtUpDB2n+W8Er4YFupGaGXo8XEmJMgWqTHvDlUahGN/cfkmdirU887rNJNCgwtZxytE+ATR/lsBlgqLYbu+hya2Ui7KyE1xtjIZdx/DFWRWZ4GgGjjqTg84J0StU1boXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=RxSJb7Sp; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rlmkt8g9gLz2FbVYrvJA9JT7otm1jUX7lKLhqslbHGI=; b=RxSJb7Sp74qndsfLvvKEIOPdMa
	KiM42boTGqab+gwvAILrvWeEgwiUvELAV9UohU9tBo+KLYB9Bi/BfXaH8X2T/DtUVugFGs6dDb0RK
	ENFqOb70DXPSiab+XKPwcLEP+OOr1zUF1h0/Fu3qoY6iaCXOeDx7LlBR/adnjPC/eB+6OqqTM7Az5
	gIrFB7py2+qzhy/7DTOthu2CnbU69O3Vk3XCFvxD6BK65qPLiGGKemYc34cRtBSWKiRZAelFFn/Lm
	zEJ7yxsL1sWRX0JI6WxfgLPVSQUEnDn4wpPGxGlpPaz4+qIQ5f5539AOQn5V0PqO3xzJadUtFB3Mu
	xWRQjYCA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39206)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s4h39-0005FO-0X;
	Wed, 08 May 2024 14:09:35 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s4h34-0001OL-HC; Wed, 08 May 2024 14:09:30 +0100
Date: Wed, 8 May 2024 14:09:30 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Daniel Golle <daniel@makrotopia.org>,
	Sky Huang <SkyLake.Huang@mediatek.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH 2/3] net: phy: mediatek: Add mtk phy lib for token ring
 access & LED/other manipulations
Message-ID: <Zjt5iobHklvrVgtB@shell.armlinux.org.uk>
References: <20240425023325.15586-1-SkyLake.Huang@mediatek.com>
 <20240425023325.15586-3-SkyLake.Huang@mediatek.com>
 <Zjo9SZiGKDUf2Kwx@makrotopia.org>
 <a005409e-255e-4633-a58c-6c29e6708b34@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a005409e-255e-4633-a58c-6c29e6708b34@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, May 08, 2024 at 02:25:56PM +0200, Andrew Lunn wrote:
> On Tue, May 07, 2024 at 03:40:09PM +0100, Daniel Golle wrote:
> > Could you create this helper library in a way that it would be useful
> > also for the otherwise identical LED controller of the Airoha EN8811H,
> > ie. supporting both variants with LED_ON_LINK2500 at BIT(7) as well as
> > BIT(8) would be worth it imho as all the rest could be shared.
> 
> Please trim the email when replying to just what is relevant. If i
> need to page down lots of time to find a comment it is possible i will
> skip write passed a comment...

+1. There are _too_ _many_ people on netdev who just don't bother to do
this, and it's getting to the point where if people can't be bothered
to make it easier for me to engage with them, I'm just not going to be
bothered engaging with them. People need to realise that this is a two-
way thing, and stop making reviewers have extra work trying to find
their one or two line comment buried in a few hundred lines of irrevant
content. I might just send a reply, top posting, stating I can't be
bothered to read their email.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

