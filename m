Return-Path: <netdev+bounces-134343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC747998E07
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 19:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4D70B235B2
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 16:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EED19992D;
	Thu, 10 Oct 2024 16:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jbNK2JIX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E22192B71;
	Thu, 10 Oct 2024 16:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728579524; cv=none; b=p8Oimvds+eDbfrMJuNehTqPkHdbRTJ8Vt1SbxzDTXFty1L+KzS0Ij2+KU9IPHTrD+Y3FzTEjJo5a4yHZgT+6L9e60xJE94guRd3opEmMqb/5mU6hehHAxGWB77aNgVaDvwhmWq0l99MuqVwj+aDn4RJxh0hu0wc2cOTJzTGaXo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728579524; c=relaxed/simple;
	bh=u7WMTNhl0Y3Uxvl7H4UJFlDlJpqHEE6FA9fRXNWLedE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUwE2lOJrfDPpCkn1VslOQhE4cqrkkQhcAplxeSWT86B7pewJWJMTPxg2ZkNMTtBJ4CozTJ+UDNQmAgYCEVEouFO9VBqzai4jeE8zkOb58pVS0LxVRhKaoZFhOv/Uj2kneFTAvkPsNPZlB66Jxney1CMo1NNhrZJIOKn2dzSP6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jbNK2JIX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=o+hQvy7Xpv1AU8dUqccMe+pXHH1TDOTIVsSeW8CICsQ=; b=jbNK2JIX88bpSMJ+ybSemjghQ/
	W6r9PLK1F43Ft9J0+PM+uZ3/CSFe5vOU4zQQOQPveVu4xzsgj0ewzrNkheEta0qNUhLEmmYlXV5lc
	KxHSP6fpaisN5HX8z6BCK/9BJC3WKL2goYW+lHp05D8GI0A4ySh9mBsDu2Bh7hrpqC7k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sywUd-009dVV-D6; Thu, 10 Oct 2024 18:58:27 +0200
Date: Thu, 10 Oct 2024 18:58:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Alexander Couzens <lynxis@fe80.eu>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: populate host_interfaces when
 attaching PHY
Message-ID: <cc2b5686-d82b-4578-b9f4-c3e84f2066e4@lunn.ch>
References: <ZwZGVRL_j62tH9Mp@shell.armlinux.org.uk>
 <ZwZubYpZ4JAhyavl@makrotopia.org>
 <Zwa-j1LKB3V2o2r9@shell.armlinux.org.uk>
 <ZwbQ-thwDxPfqGnW@makrotopia.org>
 <Zwbjlln3X5RXTt8x@shell.armlinux.org.uk>
 <Zwb2RzOQXd2Wfd6O@makrotopia.org>
 <ZwcQZmR0Q40ugXI7@shell.armlinux.org.uk>
 <ZwffopLK0x26n206@makrotopia.org>
 <ZwfrnFpqTlt0GnMn@shell.armlinux.org.uk>
 <ZwgAomacnmOtg8AK@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwgAomacnmOtg8AK@makrotopia.org>

> I initially tried to upstream the patch Alexander Couzens had written
> for that in 2023, and back then we assumed that interface mode switching
> would always be performed in case 2500Base-X was the main mode.
> However, I gave up at some point because I was asked for detailed
> definition of the PHY registers and bits, which, frankly speaking, just
> doesn't exist, not even in RealTek's under-NDA datasheet which merely
> lists some magic sequences of register writes.
> 
> https://patchwork.kernel.org/comment/25331309/

It is fine to document that these are magic values written into magic
registers and nobody knows what they are doing, if there is no
documentation. I just like to push people to actually check if there
is documentation, otherwise there will be more and more examples of
this magic.

I've been keeping an eye out for 'magic' registers which are actually
part of 802.3, and pushing back that these are least should be fully
documented. And it does happen, particularly in vendor submitted code
:-(

But you said the patch got merged eventually, so it seems like it
worked out in the end.

	Andrew

