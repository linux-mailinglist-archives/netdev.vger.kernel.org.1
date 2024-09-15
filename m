Return-Path: <netdev+bounces-128429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 978AD979838
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 20:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2B01F21CC6
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 18:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DDC1C9DFB;
	Sun, 15 Sep 2024 18:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QcjOzvSa"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51752F4A;
	Sun, 15 Sep 2024 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726425728; cv=none; b=Yl0nTOhbHJpLWoOAGjZ8aTJ5V1ZW0vf4m6Hwfxl7+6jBYTkuz9JR2sFjirhy0ueAc+VRXE8ufaUxa+RBAqjzE9f3HqAND2kZRZYgoqWPebAy2y6fnmJ3EJsP5MpAe7iIIomW21Zvm2dH6uDcXhH0vguICqSjNpE3gOjUwJ3jr2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726425728; c=relaxed/simple;
	bh=4WArnAgFZ1RsLIBejZ3FEo5KQ80z/6WM43E5FcPoh3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I032N+lxwD/KBeLYg8P+oKQMfpBtoucCshGVkvIZRJ1CWSFzeWeLDati7jd3lcR6S++N3l9sQNUi53ICHPjLL33cOkBQDj+EhMtRCqpsMRPPsN1I7AQ2qblkjhBn+og3xrAXlgvgddyuE+C3QY8LvPJK5BdZw3n3gkDK/MVfovk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QcjOzvSa; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=U8/tbEdFoHXqOiG/YLXzy2LtmW2ImDT55zt0J4tQrQM=; b=QcjOzvSadaNeNzBskCn7dhZ30O
	aYvA4v7g0XRZqhjidD50J7t0FL+6RzSOKWnrqGh9oF0wcqEdPSuRMxnOd/lPL0/toyoOAdJo+qgAA
	ko9ZhRc1AHHJXSxDacCZf0R6w1hAlMTfWUhM2q+EWmuyIapTw6oYKvV9gYpH0sFLbyig=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1spuBq-007Vte-HA; Sun, 15 Sep 2024 20:41:42 +0200
Date: Sun, 15 Sep 2024 20:41:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/2] net: phy: Support master-slave config
 via device tree
Message-ID: <5befa01e-f52d-44de-b356-bc7e1946777a@lunn.ch>
References: <20240913084022.3343903-1-o.rempel@pengutronix.de>
 <20240915180630.613433aa@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240915180630.613433aa@kernel.org>

On Sun, Sep 15, 2024 at 06:06:30PM +0200, Jakub Kicinski wrote:
> On Fri, 13 Sep 2024 10:40:20 +0200 Oleksij Rempel wrote:
> > This patch series adds support for configuring the master/slave role of
> > PHYs via the device tree. A new `master-slave` property is introduced in
> > the device tree bindings, allowing PHYs to be forced into either master
> > or slave mode. This is particularly necessary for Single Pair Ethernet
> > (SPE) PHYs (1000/100/10Base-T1), where hardware strap pins may not be
> > available or correctly configured, but it is applicable to all PHY
> > types.
> 
> I was hoping we'd see some acks here in time, but now Linus cut the 6.11
> final so the 6.12 game is over now:

The device tree binding is not decided on yet. So deferred is correct.

    Andrew

