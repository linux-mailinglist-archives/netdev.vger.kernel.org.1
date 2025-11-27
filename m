Return-Path: <netdev+bounces-242240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 54588C8DEF5
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 12:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CD04234D5F3
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 11:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785C4315D2C;
	Thu, 27 Nov 2025 11:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Hk6Nj2WK"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4618B2DF150;
	Thu, 27 Nov 2025 11:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764242258; cv=none; b=Qevo11yGug5T783pNNTwYW9G34tVOI0NjS+qA/2S6p50nF2UJeSdGPo+8TwYbXPaKMvRGloOYl3WN++xwVsr4EEbrHthC4/U1IoWBP48vz3za/5mo73tEzAYUoZiYjjUO6JN7PZKvQrLGmJugh7Bcl1lmyBC/SEJtWSWOVEE5lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764242258; c=relaxed/simple;
	bh=lnq9RCKczDMZP1xdBgExGaKBVbQEE6lNzOOdc21yd80=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbwR3NlAe26gteIUF2XSUer/jQ90eT1yDfLyrjAe8dtTHss+XJvv8xyIs7nKDsEWdN3HR9KOs7U4MHTwHdaX89+K6YaPAkbvOQlF1tEbRx1yYUlk1w4uKJf1JW+Mqtp89dL0RZDhjwZrC/j7jirQl7JBifGQ9rkV38OcA2V88sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Hk6Nj2WK; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 4AE1CA0CC8;
	Thu, 27 Nov 2025 12:17:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-type:content-type:date:from:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=mail; bh=w7hRsXVqzhVA+p/mOHCtQlbuNpvrwqdArvrBFqwpRFI=; b=
	Hk6Nj2WKRzTgLHKzn2hvJ5X7TIAwt7VL5qf2qr8bkUU/GqV22YBZLBna/1GRFUIi
	vh4NpXRwfcFrpPx/uudWfP/ila9fA5XgH96BlN2Jdu6yBoi4A4Ec+afcCH5msEFt
	Sih1nAL3KGIrZ+P6t6A/+X0qHZ2KT3qShkMkD887Ep00bmrg+4VsyQhlCbHWJSJH
	KtuSBsQI05+SgddmhB0XitXy48sMAFveI4EfpZp1mdkA4KqdptRmQuKyjoXe7VJi
	go9RGqrIEIwQlXip+pVHwwNp0Y9u6vXwh3juIHcOxsstnxVXZrS4csZ1AeAuie8H
	ra+dpN28i3LZ8lPdZjJCT/CP4nDrmMzxTI/WB0fDJ9o9ShJecZ340RhERqqPqIdm
	69f3HamJtsyxRZjdtO/nebND/ISzsvq/U38jVAoTN7o1jwKjXFuSdjL3U8Sw+7yl
	ogvQgrBqpqSBBA9vzKUdqjEKY398Xs/34cprWjGUwcVVTpDAQyo6OBv06PYx3d9X
	WGe0D4T1WwsVUCH9LKd6bSeEkQ+GCcgWjYRH/g2pqwZO+CLnuvIvc6kTz0lHKLTa
	bBBbG55EDNkWxx6HnCChSnxjTDojZFcmxq9O5I+mZ2PJ8jmWVK5ZcAzwMECWr2kr
	uJFT27J3oX+oE67nN/qgzz9dsFybvw8BLGEGowIjE4o=
Date: Thu, 27 Nov 2025 12:17:24 +0100
From: Buday Csaba <buday.csaba@prolan.hu>
To: Jakub Kicinski <kuba@kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/1] net: mdio: reset PHY before attempting to
 access ID register
Message-ID: <aSgzRMf1LZycQoni@debianbuilder>
References: <6cb97b7bfd92d8dc1c1c00662114ece03b6d2913.1764069248.git.buday.csaba@prolan.hu>
 <20251125184335.040f015e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251125184335.040f015e@kernel.org>
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1764242245;VERSION=8002;MC=715725827;ID=140077;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2998FD515F607266

On Tue, Nov 25, 2025 at 06:43:35PM -0800, Jakub Kicinski wrote:
> On Tue, 25 Nov 2025 12:15:51 +0100 Buday Csaba wrote:
> > When the ID of an Ethernet PHY is not provided by the 'compatible'
> > string in the device tree, its actual ID is read via the MDIO bus.
> > For some PHYs this could be unsafe, since a hard reset may be
> > necessary to safely access the MDIO registers.
> 
> You may be missing exports because it doesn't build with allmodconfig:
> 
> ERROR: modpost: "mdio_device_register_reset" [drivers/net/mdio/fwnode_mdio.ko] undefined!
> ERROR: modpost: "mdio_device_unregister_reset" [drivers/net/mdio/fwnode_mdio.ko] undefined!
> -- 
> pw-bot: cr
> 

I require some advice on how to do it properly.
The high level functionality belongs to either fwnode_mdio.c or maybe
phy_device.c

The latter may be better, since get_phy_device() already performs some
kind of recovery for PHYs with a certain unexpected behaviour.

But the low level functionality: registering the reset properties are
now in their proper place in mdio_device.c

These three source files build into three different modules, so I only
see the following options:

a) make mdio_device_register_reset() and its counterpart public
   But we have already agreed that they should not be, and keep them
   internal

b) create a new helper function in mdio_device.c, and make that public
   This could work, but then what is the point of hiding
   mdio_device_register_reset()? My idea was something like
   mdio_device_reset_strobe(), which calls register/unregister reset
   while also performing the assertion/deassertion of the reset.
   But such a function is unsafe on an already established mdio_device,
   so making that exported may be questionable as well.
   It is possible to work around that, but then it is getting out of hand
   fast, and does not follow the keep it simple and stupid principle.

c) what about using EXPORT_SYMBOL_FOR_MODULES() on the problematic
   functions? Are there any objections against it?
   This type of export is rarely used in the kernel, so I am uncertain
   about that. Is using it on functions declared in private headers
   also discouraged?

Thank you in advance,
Csaba


