Return-Path: <netdev+bounces-206750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11716B04467
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 17:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E88416318C
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 15:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193F1259CA0;
	Mon, 14 Jul 2025 15:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="u2gyHu4Z"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9A5251791;
	Mon, 14 Jul 2025 15:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507506; cv=none; b=KpemdWJDn67oyBtmaQ+O35Ibj+KAulqBNoDr7D8ddO27A22Q/xyXIK0HB5uZuG18vLJE1zEVyD4ZPkoJLyr2+PQpi4xJm1cPueUUNk4rJNco6qGvh5oRcPEn0EWkU+i54Afu1CPNLfqjihbSCL1ULrN8njzQhCxlh5JH3uTbPpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507506; c=relaxed/simple;
	bh=Jp6a7sFCA8bADzjFKBewsi2dTVeNX6BR5dt8ClsAD8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kc9E6MbdxNDk8ffbS/QCqVKbeyX/sSXmhOWjw75Obz5lpdl6EeDT2DY1yfmDp9Ms2VIavVYcgueDsCBsAEIA8QTkLxHejYbm+Ot/wycy0hLfxqGnouZFtsR8OTV5bhkKhm9lm9qdFNXL9QHA4bBS1bbUuqmvAQdaWz9LYa46mdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=u2gyHu4Z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7XTQ1m4MzAcEXx/P+ZyDtRSsoZG9qL19KcIoqi9+fQQ=; b=u2gyHu4ZeEXc/81OUAZF1rqzPX
	YpzM5RlB83XapYCOuco7OleR8J4VT+n+L+O3mQ0yu2ePS/5fbN8n8eNg3zTUJiQeebJTZFWs94O+y
	vTyhqRYDIK7jMjrxrrgekAhSsI9Q2894OagjovPrHFuOr/5ZIaHU4K/i9p8KVKkcKQJQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ubLFr-001Tl7-3j; Mon, 14 Jul 2025 17:38:11 +0200
Date: Mon, 14 Jul 2025 17:38:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Hau <hau@realtek.com>
Cc: "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	nic_swsd <nic_swsd@realtek.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] r8169: add quirk for RTL8116af SerDes
Message-ID: <e571d596-da26-4596-bf90-b858b5a2f5b4@lunn.ch>
References: <20250711034412.17937-1-hau@realtek.com>
 <9291f271-eafe-4f65-aa08-3c6cb4236f64@lunn.ch>
 <50df9352e81e4688b917072949b2ee4c@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50df9352e81e4688b917072949b2ee4c@realtek.com>

On Mon, Jul 14, 2025 at 03:28:37PM +0000, Hau wrote:
> > 
> > Can you give us a few more details. What is on the other end of the SERDES?
> > An SGMII PHY? An SFP cage? An Ethernet switch chip?
> > 
> > A quick search suggests it is used with an SFP cage. How is the I2C bus
> > connected? What about GPIOs? Does the RTL8116af itself have GPIOs and an
> > I2C bus?
> > 

> RTL8116af 's SERDES will connect to a SFP cage. It has GPIO and a
> I2C bus. But driver did not use it to access SFP cage.  Driver
> depends on mac io 0x6c (LinkStatus) to check link status.

You cannot correctly use an SFP cage without using the I2C bus and the
GPIOs. e.g. A copper SFP module likely needs SGMII, where as a fibre
module needs 1000BaseX. You need to reprogram the PCS depending on
what the SFP EEPROM says.

The kernel has all the code needed to coordinate this, phylink. All
you need to do is write a standard Linux I2C bus driver, a standard
Linux GPIO driver, and turn your PCS into a Linux PCS. You can then
instantiate an SFP device. The txgbe driver does this, you can
probably copy the code from there.

Have you licensed these parts? The txgbe hardware uses synopsys I2C
and PCS. So all that was needed was a wrapper around the existing
drivers.

	Andrew

