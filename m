Return-Path: <netdev+bounces-105308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE259106B5
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 15:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99D1DB2339F
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B8F1AD496;
	Thu, 20 Jun 2024 13:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="y9LtXQyY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE88C1AD3E7;
	Thu, 20 Jun 2024 13:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718891388; cv=none; b=hkKVF8nZvK7lvR/GiEDbP+8IkybLw/8RNvMfw02kkwdc/bR8eG0VIWhzsVkz+TElnIO+1s7cm6Vqvg0uG6kzuw6nMIctwI/9N9wrVrkAFg9pyexxJwSxLryW4UIsyijj1F7d68xhTRWBujcvFUn0/lD0Dh2LJZbKmNaKOY+T+Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718891388; c=relaxed/simple;
	bh=BT/dLuyKO1lUfI+6iQXNATpfbiALiLEAShjvIeFW8ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1c66DRDstM6uH79Ny/ThgbX13eqGy/tY89i4P38nhZDIDM8PayVwSjfsZUgky5J7EE/juU0fR22bWro07uFXHIEjeTL41TdZLy2ZXuVzqLetiu1hbBaKKuH58q13tGNX0yG72faXHvKe4FTBuYNfQbh78pT1e4p1oD+oP+0qYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=y9LtXQyY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=X8o/m32qh3NRbEo0U2FxeVWxnDOq9zUkFFpYzblydBQ=; b=y9LtXQyYUFDpEbDuOkvkjNrDXg
	8McVCtIfVgZ8TM/HZYc4a103Mk9CmiCgxWbZfufIPh9ZkL84vq4ejZGHD9sgRm8jaabe49FxSN0wG
	7WEQd1sLkZJ+O+abSPpspOGzkWyS2Z5ux1GsCGIKzGtpPqZJQdgTYuu66/S3UuN/QB08=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sKIAY-000Zwt-2o; Thu, 20 Jun 2024 15:49:42 +0200
Date: Thu, 20 Jun 2024 15:49:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rengarajan.S@microchip.com
Cc: linux-usb@vger.kernel.org, davem@davemloft.net,
	Woojung.Huh@microchip.com, linux-kernel@vger.kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, edumazet@google.com,
	UNGLinuxDriver@microchip.com, kuba@kernel.org
Subject: Re: [PATCH net-next v1] lan78xx: lan7801 MAC support with lan8841
Message-ID: <d72dd190-39d1-49ca-aeb2-9c0bc1357b68@lunn.ch>
References: <20240611094233.865234-1-rengarajan.s@microchip.com>
 <6eec7a37-13d0-4451-9b32-4b031c942aa1@lunn.ch>
 <06a180e5c21761c53c18dd208c9ea756570dd142.camel@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06a180e5c21761c53c18dd208c9ea756570dd142.camel@microchip.com>

On Thu, Jun 20, 2024 at 05:48:31AM +0000, Rengarajan.S@microchip.com wrote:
> Hi Andrew,
> 
> Apologies for the delay in reply. Thanks for reviewing the patch.
> Please find my comments inline.
> 
> On Thu, 2024-06-13 at 22:46 +0200, Andrew Lunn wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> > 
> > On Tue, Jun 11, 2024 at 03:12:33PM +0530, Rengarajan S wrote:
> > > Add lan7801 MAC only support with lan8841. The PHY fixup is
> > > registered
> > > for lan8841 and the initializations are done using lan8835_fixup
> > > since
> > > the register configs are similar for both lann8841 and lan8835.
> > 
> > What exactly does this fixup do?
> 
> Fixup related to the phy handle and manage the configuration and status
> registers of a particular phy. In this patch it is used to handle the
> configuration registers of LAN8841 which are similar to registers in
> LAN8835.

Details please, not hand waving. What does the errata say? Why is this
specific to your USB dongle, and not all cases where this PHY is used?

> > Looking at it, what protects it from being used on some other device
> > which also happens to use the same PHY? Is there something to
> > guarantee:
> > 
> > struct lan78xx_net *dev = netdev_priv(phydev->attached_dev);
> > 
> > really is a lan78xx_net * ?
> 
> In this case fixup is called through lan78xx only when interfacing the
> phy with lan78xx MAC. Since this will not be called on interfacing with
> other devices, it prevents them from accessing the registers.

Please give me a details explanation why this fixup will not be
applied to other instances of this PHY in the system.

	Andrew

