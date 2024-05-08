Return-Path: <netdev+bounces-94546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F278BFD16
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 14:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99C3F28418A
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 12:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C8483CBE;
	Wed,  8 May 2024 12:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="V+mV4j4i"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E5281ABF;
	Wed,  8 May 2024 12:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715171176; cv=none; b=iqpjx56+7VSGheAhBcJrOHzwhGmeNF+Q9zbhbWzeQhkWV4VA8k7L6/e3nW4vykgGbJwRmfjcwxs7SwQsXb5WfmLccQeGsa6WlougQRW99UyE8yXDXtwPjosQSYKr3OVOSwXvzIq/b3wIfy0/5WutLcOt8cEiWrViHBhJODSgGVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715171176; c=relaxed/simple;
	bh=j3Ot/IyazXb8aifsPqkGgRMobmYq0OZQJ/U3tJeKFsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbqHGjwwt+CSEFUVcRdNLpiSLww3kO3H+SR4EVhypqkUdjK4JA/u/PGPPykCxHetEg1fe6N23cyz9grxYOSm1Bg3hjPzWwVkO3vWlFWGWp7ehD7q4Z38z7uGQRJChZ2ygYmq8mAdcqJHBpo40HJhhN4q6cD/dFlUqh/MHQs3ruE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=V+mV4j4i; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=c6FK8kE2E3qY4r3/M503lbKRVuqOuZQLe5oE7UqdJHg=; b=V+mV4j4inbuhAz6AIWRBNs3IQi
	NOZlDUdJ4zXWr1Ml995bvReYQczAhXUaZixVikHFfF9GMKnM/xQuazWx3+DtIV2MjnBM0/P03+NWY
	6aRqHq4BPcMEkSXNYwCAZtw1KVS35tu/FVWMSKmbsPG3tu4HKOZ7hjgDUoZ2/TAL54cc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s4gMu-00Ewpn-6b; Wed, 08 May 2024 14:25:56 +0200
Date: Wed, 8 May 2024 14:25:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Sky Huang <SkyLake.Huang@mediatek.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
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
Message-ID: <a005409e-255e-4633-a58c-6c29e6708b34@lunn.ch>
References: <20240425023325.15586-1-SkyLake.Huang@mediatek.com>
 <20240425023325.15586-3-SkyLake.Huang@mediatek.com>
 <Zjo9SZiGKDUf2Kwx@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zjo9SZiGKDUf2Kwx@makrotopia.org>

On Tue, May 07, 2024 at 03:40:09PM +0100, Daniel Golle wrote:
> > +/* Registers on MDIO_MMD_VEND2 */
> > +#define MTK_PHY_LED0_ON_CTRL			0x24
> > +#define MTK_PHY_LED1_ON_CTRL			0x26
> > +#define   MTK_PHY_LED_ON_MASK			GENMASK(6, 0)
> 
> Shouldn't this be
> GENMASK(6, 0) | BIT(7)
> 
> to include the MTK_PHY_LED_ON_LINK2500 bit as well?
> 
> I also noticed that this bit is the only difference between the LED
> controller of the internal 2.5G PHY in MT7988 and the Airoha EN8811H
> (driver air_en8811h.c, present in net-next). The EN8811H seems to use
> BIT(8) for LED_ON_LINK2500.
> 
> Could you create this helper library in a way that it would be useful
> also for the otherwise identical LED controller of the Airoha EN8811H,
> ie. supporting both variants with LED_ON_LINK2500 at BIT(7) as well as
> BIT(8) would be worth it imho as all the rest could be shared.

Please trim the email when replying to just what is relevant. If i
need to page down lots of time to find a comment it is possible i will
skip write passed a comment...

     Andrew

