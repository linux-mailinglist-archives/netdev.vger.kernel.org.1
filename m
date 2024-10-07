Return-Path: <netdev+bounces-132616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 274B19926FE
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 10:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5BD11F2310F
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 08:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC0C18B462;
	Mon,  7 Oct 2024 08:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bX4DeVpG"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2D916849F;
	Mon,  7 Oct 2024 08:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728289788; cv=none; b=KTaiOVvJKsiXaHRq1mqiBcK3GZjtsSTtae6d8No41A6io2FdwV+z2zyGFYoXlLbI03jtvQGWq4AaBthAl8sJJOrzR4Ckt1msj5rYaVfwO/w7cnDIgZ7bFSStVUFy2eO3zU/QKeuYuHsJ7MmpZVtVQR/teAc+/QQlr3fmA2iD+jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728289788; c=relaxed/simple;
	bh=Klf5ounytGs2pXxrEmGPa9MQhQ1AxIMmfYRSj2ytswE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xw9m449dlYqL44D4es6pcZ9icqY7om2ksYz8NsMzsHyh07O3cDsW1NrArD3IvE59MPQIYgn0Q+/uS94OhvOMmRLOG0fL6+I+jSj+Gil1dIIqfX2tArAP6afqbhxo5GQTRko3rsB9mjjG0lKluwsMzlynPWxV2NTqnW0Ry/UFC+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bX4DeVpG; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C4B7260006;
	Mon,  7 Oct 2024 08:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728289778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mJKNfHc7055rC/FvjwJstSqwovUh7KyChDgu1RZK00w=;
	b=bX4DeVpGOTU5P/cyyrerv2kzqbGZRmanFHCu6bGKJPhVg/KQDERYtTZ+6K2bxrr3yxAY4J
	kEP0aU6KnjQ+L2RZFEGnqtArUMaG/CqCuLpxglp8eJ4dFaVGQyO1OR1e/R1WmZDHQ4PLIa
	zRSLYwsSm/jT2jomOyfEc87rpeRaBLExQjiGLL/LHVtrCXLD/jRI/KcBqaFFxcRptjGgRt
	8EHfVA2NQrIp5PSl1OkpHkkKlKNifLA2Kh4Ki/LC8vHkoC9WC6GlNzLeruIe/1cfZdT5o4
	LSVDZBm9b5tOM+CE7IcRqCIytc1th6utFKU1s0xAVvC6KG1wbP43ffl6n8CWbg==
Date: Mon, 7 Oct 2024 12:27:20 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Marek
 =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next v2 3/9] net: phy: Allow PHY drivers to report
 isolation support
Message-ID: <20241007122720.2e1eba76@device-21.home>
In-Reply-To: <cf015eee-0d09-4fc7-b214-f9b0db12016e@lunn.ch>
References: <20241004161601.2932901-1-maxime.chevallier@bootlin.com>
	<20241004161601.2932901-4-maxime.chevallier@bootlin.com>
	<cf015eee-0d09-4fc7-b214-f9b0db12016e@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

On Fri, 4 Oct 2024 20:20:10 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > +static bool phy_can_isolate(struct phy_device *phydev)
> > +{
> > +	if (phydev->drv && phydev->drv->can_isolate)
> > +		return phydev->drv->can_isolate(phydev);
> > +
> > +	return true;  
> 
> Reading Russells comment, and the fact that this feature is nearly
> unused, so we have no idea how well PHYs actually support this, i
> would flip the logic. Default to false. A PHY driver needs to actively
> sign up to supporting isolation, with the understanding it has been
> tested on at least one board with two or more PHYs.

Fair point, I'll reverse the logic.

Thanks,

Maxime


