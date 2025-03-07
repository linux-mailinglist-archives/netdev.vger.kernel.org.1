Return-Path: <netdev+bounces-172949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 449EBA56970
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 14:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6054E3AB9A3
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 13:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31E721ADAC;
	Fri,  7 Mar 2025 13:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="e8cnS3UN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B8221ADC1;
	Fri,  7 Mar 2025 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355547; cv=none; b=A1upV9ZYEF3sz9bXaIHtkfjrL9rFtPQPbPbn3OE++gCxXe37XpeiEAwTuVBGBQBd9/qrciFVTvtPUZ1Qi8P3o43olS66Sl/D+F6xM6Y24qXGlfuyIvfDHmODeGbWe+b3sVSgWEPWLQwqCHRjPwE8hKcNGD6suKxxotu1n6jiSwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355547; c=relaxed/simple;
	bh=29lY7GfFGvGCLaxOLAFeaKEnprybrIf65ur29KZxkw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkVtjU5sZHEpWED1WsP36pvvr9PglpI4tIqY68qaVSTfubH8w9LU3EO6l/7IEARZpdQcDCd6XqB2zP6iLOxIfLn7OHeT6Sm51SCdW75o2gptQ58e/LpP7WTZ8Hq8x261iAqIG628yc6K+B7UU4qlJ7M+cqtt3CLIImrHdMgKf/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=e8cnS3UN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Jkx3f0giLdjTBdslQHfz5NRis+vzSJwwRoYIVdv9lsw=; b=e8cnS3UN7dYibdwZ10jktHczPl
	15tNwuQTBmqZxPOFXUGY3q8Duy5ddpk38Qib02oSsht9MK2oX5AptZAgwEA9B1jg+uY+ba3jmmfRV
	Iwy2s/rrSlUreWt0RCJ3OIDtvrPV2LbkSoO8BkpiBBk6Qx5P8pFRE/JF7Ku1h9vodFnI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tqY7Z-0039Yt-LO; Fri, 07 Mar 2025 14:52:13 +0100
Date: Fri, 7 Mar 2025 14:52:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Wadim Egorov <w.egorov@phytec.de>, netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/3] net: stmmac: dwmac-rk: Use DELAY_ENABLE macro for
 RK3328
Message-ID: <f5f397bb-476a-429a-9d1e-1c1a9beb8f89@lunn.ch>
References: <20250306203858.1677595-1-jonas@kwiboo.se>
 <20250306203858.1677595-2-jonas@kwiboo.se>
 <d6b15dc2-f6b2-4703-a4da-07618eaed4db@lunn.ch>
 <624f2474-9a39-46a3-a6e5-f9966471bf3d@kwiboo.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <624f2474-9a39-46a3-a6e5-f9966471bf3d@kwiboo.se>

On Fri, Mar 07, 2025 at 12:28:42AM +0100, Jonas Karlman wrote:
> Hi Andrew,
> 
> On 2025-03-06 23:25, Andrew Lunn wrote:
> > On Thu, Mar 06, 2025 at 08:38:52PM +0000, Jonas Karlman wrote:
> >> Support for Rockchip RK3328 GMAC and addition of the DELAY_ENABLE macro
> >> was merged in the same merge window. This resulted in RK3328 not being
> >> converted to use the new DELAY_ENABLE macro.
> >>
> >> Change to use the DELAY_ENABLE macro to help disable MAC delay when
> >> RGMII_ID/RXID/TXID is used.
> >>
> >> Fixes: eaf70ad14cbb ("net: stmmac: dwmac-rk: Add handling for RGMII_ID/RXID/TXID")
> > 
> > Please add a description of the broken behaviour. How would i know i
> > need this fix? What would i see?
> 
> Based on my layman testing I have not seen any real broken behaviour
> with current enablement of a zero rx/tx MAC delay for RGMII_ID/RXID/TXID.
> 
> The driver ops is called with a rx/tx_delay=0 for RGMII_ID/RXID/TXID
> modes, what the MAC does with enable=true and rx/tx_delay=0 is unclear
> to me.
> 
> > 
> > We also need to be careful with backwards compatibility. Is there the
> > potential for double bugs cancelling each other out? A board which has
> > the wrong phy-mode in DT, but because of this bug, the wrong register
> > is written and it actually works because of reset defaults?
> 
> To my knowledge this should have very limited effect, however I am no
> network expert and after doing very basic testing on several different
> rk3328/rk3566/rk3568/rk3588 I could not see any real affect with/without
> this change.
> 
> The use of Fixes-tag was more to have a reference to the commit that
> first should have used the DELAY_ENABLE macro.

https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

  It must either fix a real bug that bothers people or just add a device ID.

It does not sound like this meets the stable requirements. Plus there
is the potential for breakage. So i suggest you drop the Fixes: tag
and we merge this via net-next.

Please take a look at:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

    Andrew

---
pw-bot: cr

