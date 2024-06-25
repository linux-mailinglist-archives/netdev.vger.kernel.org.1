Return-Path: <netdev+bounces-106436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4CD91653E
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 12:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F0E4B21CBB
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 10:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA7014A0BC;
	Tue, 25 Jun 2024 10:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="NhVbdKCL"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2951214A0AA
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 10:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719311235; cv=none; b=axz0vVepzjYs8Wm3ICIjbnhppwuthiquGIqzOnJqo7ietGxynALVCEsdpT8xPDYll6zy2QJ1kO9Yz5ENeRLHTDV+lLzNQjKpjtHbhBT6VVhw51DOSvUERWoDf3M+aiDjOr/K/pa7WyVwt63wYM5y5OzqkVOgjcMVNYwCOgjBGD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719311235; c=relaxed/simple;
	bh=el7j0idRQKK8J36KkvSZnjHG3BYxDy6leAfJQPpuzoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3OZO91MJpm3AFcZpvZasy7NoRZccg0uSSrgJ0Q5VQ4AZih3U9U7IogfK4IsPRvjCG5QAmLo0c6lP0Z7chElPLxm6t6CPTM4ca+tjpttVaz1L+H0XinncknqEg02hcTISaHt3M/5O/cxcPxt0fVYDtavnFOlezipWztiCLw0N1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=NhVbdKCL; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=S/aCWq5lhdaxNP7k23C7HPhPtz8WEcEN4hp4oxH4jVE=; b=NhVbdKCLN6M64ayEkQRe9Ph1gN
	wTYL7nudu5O+3xFah/tnh3tKR8qxix0y5W9VAiuL2UDGyzxb69qCA8aHJwGyL8uYfjI7GrruX6fuX
	/YiqFGLYK0Rthp+9cVB0ZLzpTZnGv/R6YZHf3sBtdaZPrY7Z7bGDLdCIfxXxxyDKKgUaACCLfDEOn
	oejsBkb/dWTrcXOXh9Ih68TwLJt5YLgjq3b4yEek97cn4pSVNsDpDUtKN3FPGrXDFgS4sqBU81PA/
	nk0WkYwV5+h9i0I98tSQVFmak3HG44GUrS2Cd/g1mtgxb/hX+FtWJEHVjx7Z2nHLwx89tyh7frZX+
	7a20wWVw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57230)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sM3OD-0000Kk-0p;
	Tue, 25 Jun 2024 11:27:05 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sM3OG-0003i8-11; Tue, 25 Jun 2024 11:27:08 +0100
Date: Tue, 25 Jun 2024 11:27:07 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
	horms@kernel.org, Tristram.Ha@microchip.com,
	Arun.Ramadoss@microchip.com
Subject: Re: [PATCH net v7 3/3] net: dsa: microchip: monitor potential faults
 in half-duplex mode
Message-ID: <Znqbe6HDrajK0UVq@shell.armlinux.org.uk>
References: <20240621144322.545908-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <20240621144322.545908-4-enguerrand.de-ribaucourt@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621144322.545908-4-enguerrand.de-ribaucourt@savoirfairelinux.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jun 21, 2024 at 04:43:22PM +0200, Enguerrand de Ribaucourt wrote:
> The errata DS80000754 recommends monitoring potential faults in
> half-duplex mode for the KSZ9477 family.
> 
> half-duplex is not very common so I just added a critical message
> when the fault conditions are detected. The switch can be expected
> to be unable to communicate anymore in these states and a software
> reset of the switch would be required which I did not implement.
> 
> Fixes: b987e98e50ab ("dsa: add DSA switch driver for Microchip KSZ9477")
> Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
> ---
> v7:
>  - use dev_crit_once instead of dev_crit_ratelimited
>    The condition will remain true forever and the routine called every
>    5 seconds. There's no need to repeat the message.
>  - add explanations in the comment above the warning to help users
>    anticipate the consequences of the fault.
> v6: https://lore.kernel.org/netdev/20240614094642.122464-4-enguerrand.de-ribaucourt@savoirfairelinux.com/
>  - use macros for PORT_INTF_SPEED_MASK check
>  - add VLAN condition before checking the resources
> v5: https://lore.kernel.org/all/20240604092304.314636-5-enguerrand.de-ribaucourt@savoirfairelinux.com/
>  - use macros for bitmasks
>  - check for return values on ksz_pread*
> v4: https://lore.kernel.org/all/20240531142430.678198-6-enguerrand.de-ribaucourt@savoirfairelinux.com/
>  - rebase on net/main
>  - add Fixes tag
>  - reverse x-mas tree
> v3: https://lore.kernel.org/all/20240530102436.226189-6-enguerrand.de-ribaucourt@savoirfairelinux.com/
> ---
>  drivers/net/dsa/microchip/ksz9477.c     | 51 +++++++++++++++++++++++++
>  drivers/net/dsa/microchip/ksz9477.h     |  2 +
>  drivers/net/dsa/microchip/ksz9477_reg.h | 10 ++++-
>  drivers/net/dsa/microchip/ksz_common.c  | 11 ++++++
>  drivers/net/dsa/microchip/ksz_common.h  |  1 +
>  5 files changed, 73 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
> index c2878dd0ad7e..6924b3818357 100644
> --- a/drivers/net/dsa/microchip/ksz9477.c
> +++ b/drivers/net/dsa/microchip/ksz9477.c
> @@ -429,6 +429,57 @@ void ksz9477_freeze_mib(struct ksz_device *dev, int port, bool freeze)
>  	mutex_unlock(&p->mib.cnt_mutex);
>  }
>  
> +int ksz9477_errata_monitor(struct ksz_device *dev, int port,
> +			   u64 tx_late_col)
> +{
> +	u32 pmavbc;
> +	u8 status;
> +	u16 pqm;
> +	int ret;
> +
> +	ret = ksz_pread8(dev, port, REG_PORT_STATUS_0, &status);
> +	if (ret)
> +		return ret;
> +	if (!(FIELD_GET(PORT_INTF_SPEED_MASK, status) == PORT_INTF_SPEED_NONE) &&
> +	    !(status & PORT_INTF_FULL_DUPLEX)) {
> +		/* Errata DS80000754 recommends monitoring potential faults in
> +		 * half-duplex mode. The switch might not be able to communicate anymore
> +		 * in these states.
> +		 * If you see this message, please read the errata-sheet for more information:

While I realise that the URL is long, netdev still prefers lines to be
no longer than 80 characters, so please wrap the comment accordingly.
The URL is probably fine (since there isn't any option), and then
dev_warn_once() string shouldn't be broken over separate lones either.

However, also consider whether moving this code block into a function
would tidy things up - the compiler can automatically  inline static
functions (and does in many cases, especially when they only have one
callsite.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

