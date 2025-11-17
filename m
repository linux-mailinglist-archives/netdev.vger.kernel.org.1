Return-Path: <netdev+bounces-239110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 580CDC6405D
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 13:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6690C4E6BAD
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 12:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F7432B9B4;
	Mon, 17 Nov 2025 12:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Zm2eAB05"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7842D47E4;
	Mon, 17 Nov 2025 12:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763382163; cv=none; b=qhnkOh/+XehMz28fPwH4lTt/TnPpbHRfum+yvq217bZNKg/NmKnEFnCAlDpg9niegoSjK0AsnhbRez2GPqCIXn05Scl3u/QtXBhgruM5XhuauOafKSS41npJpe1nm0j/4lzMHEWLRogbVYc+ghZt2+xjndabpa1uEOnABtwnaCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763382163; c=relaxed/simple;
	bh=Q4fgwQnj5oOxrFiFwBtm7wy4uN2rv1g0e1fgDN4PAsM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u62hmk4fqDhTxUFdzTzf4FLwa0hO6vNMRMGP3TL/+6VhqjZXka/TDwj2Cu+Jwn/jOQAPacok1sk/HAAZgLE+s0UTPNLr9CD5uBKgbCUQ4xj7CB8GbXzDnC3cUqhWHald7hU5IxRTd/e32XiDo1fatc26Vsadvu8eltyaPOLHRHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Zm2eAB05; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id A0E99A0EFF;
	Mon, 17 Nov 2025 13:22:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-type:content-type:date:from:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=mail; bh=WsGN4MyPOWyrsRNE7c+iQgGAHxBnkEUl04Fft4mLzvU=; b=
	Zm2eAB05V4HyRm+IsCFhMokFTrO2o3qQrt9XQ4jLx6yYWX0bTH2m4tntD3z09Zd8
	8YGSsKKldhXj47wKrTCCjm+qPwYdBkWM/xTwRgZFOAMooF1QywFewFgvnK7gW0EB
	h7b18apIqnH2Q0vqhDeNelUojrqx3F0jNYqkwhlclxBXh2MvZrr00Ah7N9lZOOlx
	AyS1QO0XKPY0OrswQBX2qK2lFMDFBst/3JMML9IQ7tLeM6njWFGABJsmj4Behhh5
	09tYRxfHiY7rQX5wMXRd+SGroYEE0F+3bPE2+Ob223XT7FtscHiRnWoQAd/M6691
	45Sj1GVI/qhT9JvAvKSewTmntD4EMepB1CInduGpSMp4cONZAaMBLZUpgT495A0M
	hsXv05x5haoCDpGwFA3Lqv2QRVmet0EXbTI6sGqXjx8vkkBJPFXNc2mlVyHb0p7i
	dKY0s08wmlZB6bftATW0KkLk4KMUFNeRKwqnja3KecXt12X1BO7bVI+oW0MnJZzf
	ZM4QgVOJjZ/eD81BKuqai8KDbLImuSLS2oCn4D66RXuJ9tgVSS9HZ+L5k7DPc0oe
	ExFFW5/MJ6QtX4HpwaMsw4wjgcIjqZW3K/K2+LPQH4+4VegsvHH6mHT4D4iLrUAu
	U3PkFgFC+OUw4UEu0XUEyvolFs9jIHxOP8gvmSg9TnQ=
Date: Mon, 17 Nov 2025 13:22:32 +0100
From: Buday Csaba <buday.csaba@prolan.hu>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Philipp
 Zabel" <p.zabel@pengutronix.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/3] net: mdio: move device reset functions
 to mdio_device.c
Message-ID: <aRsTiBZBqc-cx38W@debianbuilder>
References: <cover.1763371003.git.buday.csaba@prolan.hu>
 <d81e9c2f26c4af4f18403d0b2c6139f12c98f7b3.1763371003.git.buday.csaba@prolan.hu>
 <aRrsOfJv6kUPCxNd@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aRrsOfJv6kUPCxNd@shell.armlinux.org.uk>
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1763382153;VERSION=8002;MC=1669868717;ID=74622;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155F617360

On Mon, Nov 17, 2025 at 09:34:49AM +0000, Russell King (Oracle) wrote:
> On Mon, Nov 17, 2025 at 10:28:51AM +0100, Buday Csaba wrote:
> > diff --git a/include/linux/mdio.h b/include/linux/mdio.h
> > index 42d6d47e4..1322d2623 100644
> > --- a/include/linux/mdio.h
> > +++ b/include/linux/mdio.h
> > @@ -92,6 +92,8 @@ void mdio_device_free(struct mdio_device *mdiodev);
> >  struct mdio_device *mdio_device_create(struct mii_bus *bus, int addr);
> >  int mdio_device_register(struct mdio_device *mdiodev);
> >  void mdio_device_remove(struct mdio_device *mdiodev);
> > +int mdio_device_register_gpiod(struct mdio_device *mdiodev);
> > +int mdio_device_register_reset(struct mdio_device *mdiodev);
> 
> These are private functions to the mdio code living in drivers/net/phy,
> so I wonder whether we want to have drivers/net/phy/mdio.h for these to
> discourage other code calling these?

I completely agree with that, but that file does not exist yet.
Is it worth creating just for the sake of these two functions?

Csaba


