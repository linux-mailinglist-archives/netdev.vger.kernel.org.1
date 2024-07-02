Return-Path: <netdev+bounces-108316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A082A91ED21
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 04:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D25241C21269
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 02:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0947B15AE0;
	Tue,  2 Jul 2024 02:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XwGpluBs"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABE02207A;
	Tue,  2 Jul 2024 02:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719888669; cv=none; b=JqLiCh3sUbA94EvHejrlqAUE6nIJvax7N6Igp4//aSEiXMgo3RzapSCBXrZnseYw5y0Wf+7w2zwgaIcVpE6wzM2coMGaUFXHItwiBJyj8Gcqei2N2VKunWCLvufSiv8xu8qawXSzAci2MJzn5yzQfH+Cq9BdA0RkhpTnwLfm1jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719888669; c=relaxed/simple;
	bh=wHHM/3hFJk0xCUITZ+9cXJAtDu8zCLg/ZftvX5BhNdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvlXRJSrZiXO4TJ6DWliQeCumTwzHTcBFW5hwuNLkCeR+dptGC9d7tkol3GKShnTVV5PWBLPSQFTYtmjiwlznBbb5876bhhIUaKI2qR1e2xgEDVE+dfNj57dc/mxrNBx3J6DJUqswNWZjglyli9KwajHT9UGS23HNXVgFOX3ZJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XwGpluBs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2EdzcyCiTpCY8iry1aJzJ8RLMwWeHoycdhOFxh0w+qQ=; b=XwGpluBsDBP1THxJhgLrEyeRSF
	FI1lctu81qLJV8a3yqupPYS1M5e00cqiwm9vCIHgzhyLlLo2H1hdrJnnHnTWZJEZBqtZ603gSjlBw
	SKYA2qsNbrstgrWWtQl6pivSX9P1d+n1MhkDXXsUKDclUPt6oRKIMf9THMksd7la9eIQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sOTbQ-001b3S-V1; Tue, 02 Jul 2024 04:50:44 +0200
Date: Tue, 2 Jul 2024 04:50:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"alsi@bang-olufsen.dk" <alsi@bang-olufsen.dk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"olteanv@gmail.com" <olteanv@gmail.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	"ericwouds@gmail.com" <ericwouds@gmail.com>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"justinstitt@google.com" <justinstitt@google.com>,
	"rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
	netdev <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"sander@svanheule.net" <sander@svanheule.net>
Subject: Re: net: dsa: Realtek switch drivers
Message-ID: <c19eb8d0-f89b-4909-bf14-dfffcdc7c1a6@lunn.ch>
References: <aa5ffa9a-62cc-4a79-9368-989f5684c29c@alliedtelesis.co.nz>
 <CACRpkdbF-OsV_jUp42yttvdjckqY0MsLg4kGxTr3JDnjGzLRsA@mail.gmail.com>
 <CAJq09z6dN0TkxxjmXT6yui8ydRUPTLcpFHyeExq_41RmSDdaHg@mail.gmail.com>
 <b15b15ce-ae24-4e04-83ab-87017226f558@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b15b15ce-ae24-4e04-83ab-87017226f558@alliedtelesis.co.nz>

> What would I be loosing if I don't use the DSA infrastructure? I got kind of
> hung up at the point where it really wanted a CPU port and I just couldn't
> provide a nice discrete NIC.
 
DSA gives you a wrapper which handles some common stuff, which you
will end up implementing if you do a pure switchdev driver. Mostly
translating netdev to port index. The tagging part of DSA does not
apply if you have DMA per user port, so you don't loose anything
there.  I guess you cannot cascade multiple switches, so the D in DSA
also does not apply. You do lose out on tcpdump support, since you
don't have a conduit interface which all traffic goes through.

But you should not try to impose DSA if it does not fit. There are
'simple' pure switchdev drivers, you don't need to try to understand
the mellanox code. Look at the microchip drivers for something to
copy.

	Andrew

