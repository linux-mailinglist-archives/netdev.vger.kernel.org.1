Return-Path: <netdev+bounces-122411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B14C961282
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 17:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 354911F23457
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 15:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E7F1C6F65;
	Tue, 27 Aug 2024 15:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qo8e28tG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4529A1CDA27;
	Tue, 27 Aug 2024 15:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772586; cv=none; b=FnFVKoPOWRxlfnijvcsW/BrBuet/6o/WeiKXlIf/BbDclXvuXOTVNH6uEjw8sdG8LN0vTEDHBOraCJuwaZZiARnM4ut3xNXgub9ij417XVzDnGYisUJkgCqTxZ2ydOAGW5E8TeNzx6fTDXxb64iJSR2QciM8JbKLt0kwzaY0T7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772586; c=relaxed/simple;
	bh=/YEQ+6PxrMq+4gcAParVVn5LUiRUbWdM2vwVTgftC3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0FAxh9Xrr8Hkyp9gcTPI36m3GKBvIH990la6PLvJvDW4uUBOtfMfu6UqNzuSQn/Z9e01KT0+BvFCTX7zlzA95b7Mp6QlvGHorrw9pH/meNihhyTgzXRTSqhx/336xJZhqBOTQ1+jzsh2EYfBtMmscQunb4n4eJ29ZfcTgaG7MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qo8e28tG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Q0LGUFtZeFVYu6AUPid/NL3zjZd2B6q+F/q/ub8LtpM=; b=qo
	8e28tGQGygacg7nfwKOUfnroE3gS8WXlOSyxh1IZ87XZbc1rbhud1FZk8p9OvqC4AvW092CSGHT2d
	O24XAPcS6MqXxd8lKyafanFg04CZsntIfECxTNII7pa6q4aKwel6gl67NAv5dJkvci3taRy4POC6A
	vvP2sBb7Dg3a6l4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1siy8O-005pye-FP; Tue, 27 Aug 2024 17:29:28 +0200
Date: Tue, 27 Aug 2024 17:29:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Conor Dooley <conor@kernel.org>
Cc: netdev@vger.kernel.org, Steve Wilkins <steve.wilkins@raymarine.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	valentina.fernandezalanis@microchip.com,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next] net: macb: add support for configuring eee via
 ethtool
Message-ID: <3c5a3db5-a598-454e-807a-b5106008aa40@lunn.ch>
References: <20240827-excuse-banister-30136f43ef50@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240827-excuse-banister-30136f43ef50@spud>

On Tue, Aug 27, 2024 at 12:29:23PM +0100, Conor Dooley wrote:
> From: Steve Wilkins <steve.wilkins@raymarine.com>
> 
> Add ethtool_ops for configuring Energy Efficient Ethernet in the PHY.
> 
> Signed-off-by: Steve Wilkins <steve.wilkins@raymarine.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Steve sent me this patch (modulo the eee -> keee change), but I know
> nothing about the macb driver, so I asked Nicolas whether the patch
> made sense. His response was:
> > Interesting although I have the feeling that some support from our MAC
> > is missing for pretending to support the feature.
> > I'm not sure the phylink without the MAC support is valid.
> >
> > I think we need a real task to be spawn to support EEE / LPI on cadence
> > driver (but I don't see it scheduled in a way or another 🙁 ).
> 
> Since he was not sure, next port of call is lkml.. Is this patch
> sufficient in isolation, or are additional changes required to the driver
> for it?
> 
> The other drivers that I looked at that use phylink_ethtool_set_eee()
> vary between doing what's done here and just forwarding the call, but
> others are more complex, so without an understanding of the subsystem
> I cannot tell :)
> 
> Alternatively, Steve, shout if you can tell me why forwarding to the phy
> is sufficient, and I'll update the commit message and send this as
> non-RFC.

This is not sufficient. EEE is negotiated with the link peer, so
phylib/phylink is involved so that negotiation is performed, and the
results reported back to the MAC.

The MAC then needs to act on the results of the negotiation. The MAC
does most of the work. It keeps a timer of when it last sent a
packet. If this time exceeds 'tx-timer', it signals to the PHY it can
swap into low power mode, because there is nothing to send. When the
next packet comes along, it needs to signal the PHY to transition back
into full power mode, and it needs to wait a little for that to
happen.

You are missing the MAC parts.

	Andrew

