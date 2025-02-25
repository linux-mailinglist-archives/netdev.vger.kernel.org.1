Return-Path: <netdev+bounces-169469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2A5A4411C
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 14:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ADDA1888BE7
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 13:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F96269830;
	Tue, 25 Feb 2025 13:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aABty445"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FE4267AE5;
	Tue, 25 Feb 2025 13:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740490873; cv=none; b=movXY7DOQGC4jg+ifmkaedh5vhMwTpuVY6ADqndSTwn2rx2yhXtf2n8O93BWVTDBLW8GOHkYS6LlQ9r+ttmoBCGeLAB2nZWNwYoxqAymRWoqzVw4Jtcc0Gqej483iC45g7O57JLa6/rBMLknB46R8Q3V65jxjFk3Xn7N/pDqTew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740490873; c=relaxed/simple;
	bh=8o2HtVC4FM1XL6kCNAFsNzIUp3tYpuDgORl59KzI2dQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sh3VGMv8nBIA8qbhZ3asOynUZ4H05Mz3PD02ddp2fnWM7GAN0pEtK740GUo5hMzRI1JDi3xP8ptIIwj9jPXYR0ZDt53pDktnnSEAo91ELUGJUqsrBcOlJQ2UyxVx7D4BAbXVKn7G+ghjT9NxtZv37oz6y0p1f6omLZrSetmx678=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aABty445; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jKrGQQamhJ8YtplUcRQjmzSHfY9OrteybnOt/SSElS0=; b=aABty445XXKeIao5C45E3biwF2
	EfP7YysQoO7WNpL550cbNMOlSyTc16oMQKSTLvRn7FkdprFZnlb9qTX1BRS4OMTMLi48L6RVHHun0
	foT+ZyHpEiHco8U/j17i7B+avvjInmo+Nap3pTJptLscI68Uj6tmH22FjLAF7TsX+rMk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tmvBI-00HWgW-Ue; Tue, 25 Feb 2025 14:41:04 +0100
Date: Tue, 25 Feb 2025 14:41:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Antoine Tenart <atenart@kernel.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Subject: Re: [PATCH net-next v2 1/2] net: phy: sfp: Add support for SMBus
 module access
Message-ID: <6ff4a225-07c0-40f6-9509-c4fa79966266@lunn.ch>
References: <20250225112043.419189-1-maxime.chevallier@bootlin.com>
 <20250225112043.419189-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225112043.419189-2-maxime.chevallier@bootlin.com>

On Tue, Feb 25, 2025 at 12:20:39PM +0100, Maxime Chevallier wrote:
> The SFP module's eeprom and internals are accessible through an i2c bus.
> However, all the i2c transfers that are performed are SMBus-style
> transfers for read and write operations.
> 
> It is possible that the SFP might be connected to an SMBus-only
> controller, such as the one found in some PHY devices in the VSC85xx
> family.
> 
> Introduce a set of sfp read/write ops that are going to be used if the
> i2c bus is only capable of doing smbus byte accesses.
> 
> As Single-byte SMBus transaction go against SFF-8472 and breaks the
> atomicity for diagnostics data access, hwmon is disabled in the case
> of SMBus access.
> 
> Moreover, as this may cause other instabilities, print a warning at
> probe time to indicate that the setup may be unreliable because of the
> hardware design.
> 
> Tested-by: Sean Anderson <sean.anderson@linux.dev>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
> 
> V2: - Added Sean's tested-by
>     - Added a warning indicating that operations won't be reliable, from
>       Russell and Andrew's reviews
>     - Also added a flag saying we're under a single-byte-access bus, to
>       both print the warning and disable hwmon.
> 
>  drivers/net/phy/sfp.c | 79 +++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 73 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> index 9369f5297769..6e9d3d95eb95 100644
> --- a/drivers/net/phy/sfp.c
> +++ b/drivers/net/phy/sfp.c
> @@ -282,6 +282,7 @@ struct sfp {
>  	unsigned int rs_state_mask;
>  
>  	bool have_a2;
> +	bool single_byte_access;
>  
>  	const struct sfp_quirk *quirk;
>  
> @@ -690,14 +691,70 @@ static int sfp_i2c_write(struct sfp *sfp, bool a2, u8 dev_addr, void *buf,
>  	return ret == ARRAY_SIZE(msgs) ? len : 0;
>  }
>  
> -static int sfp_i2c_configure(struct sfp *sfp, struct i2c_adapter *i2c)
> +static int sfp_smbus_read(struct sfp *sfp, bool a2, u8 dev_addr, void *buf,

Maybe call this sfp_smbus_byte_read(), leaving space for
sfp_smbus_word_read() in the future.

> +			  size_t len)
>  {
> -	if (!i2c_check_functionality(i2c, I2C_FUNC_I2C))
> -		return -EINVAL;
> +	u8 bus_addr = a2 ? 0x51 : 0x50;
> +	union i2c_smbus_data smbus_data;
> +	u8 *data = buf;
> +	int ret;
> +
> +	while (len) {
> +		ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
> +				     I2C_SMBUS_READ, dev_addr,
> +				     I2C_SMBUS_BYTE_DATA, &smbus_data);
> +		if (ret < 0)
> +			return ret;

Isn't this the wrong order? You should do the upper byte first, then
the lower?


    Andrew

---
pw-bot: cr

