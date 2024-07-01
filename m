Return-Path: <netdev+bounces-108204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2796491E5AE
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 18:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7C41B25F22
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 16:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BEE16DC30;
	Mon,  1 Jul 2024 16:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OAiD/77k"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F45116D9DF;
	Mon,  1 Jul 2024 16:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852283; cv=none; b=TIl99krBew7OaWeS3HbeA5fujtZA2ByJ2yBfmyRQFbVF9n5jZ07a5iAA5JTFRgtjq7MoKxLF/de5R/JbY1l/yndxdbgts8cR5JbPiU4428xdFbjeQVuUiTH69AEQ5yo82NrVkcJ5iSSEhrvMNtyjLUoADfdjYUnHwJawVs2OhsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852283; c=relaxed/simple;
	bh=l6xus1XAtOiwaRYKP+nR3Kiy9oyeWa0WVrUaPX9yIU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=os5wh1sjzAj0EfDKj6Vhf3nlJ9V7xBgD6FZRjHWzoQJzqp9LTCyEta04QjBNmPvFIovaOt2LdKoS+PEuTpSCNkAb1DLAFr/P/V3k2eXyqmP4H5DyPni8300HNGcTieYPMkVNo+VHXae34kKirxuLRe6048vJY378Si2gfg6srb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OAiD/77k; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UuunPGaLon2h6TKEgW+VbiEjLzjqY73jbXy5dJJCJN0=; b=OAiD/77khE1wj+1kigtZtHxZ9w
	lrubI+UL0afsrof1bGoiniT3c8Y0qMtmb8R0YX5SiKwk7aZt1VPGT8FzITGCqgOWFfjvDsj02HIwG
	NNT0m75e8KHbNJk73jtCXf39TvzS37gZWqFG3Ix4kRZ07BPtI7V3DuNGEBCYEwk21tps=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sOK8n-001YzX-MF; Mon, 01 Jul 2024 18:44:33 +0200
Date: Mon, 1 Jul 2024 18:44:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/6] net: phy: dp83869: Perform software restart
 after configuring op mode
Message-ID: <ba1ac5bb-ee58-406b-9f49-54327696a6a8@lunn.ch>
References: <20240701-b4-dp83869-sfp-v1-0-a71d6d0ad5f8@bootlin.com>
 <20240701-b4-dp83869-sfp-v1-2-a71d6d0ad5f8@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701-b4-dp83869-sfp-v1-2-a71d6d0ad5f8@bootlin.com>

On Mon, Jul 01, 2024 at 10:51:04AM +0200, Romain Gantois wrote:
> The DP83869 PHY requires a software restart after OP_MODE is changed in the
> OP_MODE_DECODE register.
> 
> Add this restart in dp83869_configure_mode().
> 
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> ---
>  drivers/net/phy/dp83869.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
> index f6b05e3a3173e..6bb9bb1c0e962 100644
> --- a/drivers/net/phy/dp83869.c
> +++ b/drivers/net/phy/dp83869.c
> @@ -786,6 +786,10 @@ static int dp83869_configure_mode(struct phy_device *phydev,


Not directly this patch, but dp83869_configure_mode() has:

ret = phy_write(phydev, MII_BMCR, MII_DP83869_BMCR_DEFAULT);

where #define MII_DP83869_BMCR_DEFAULT	(BMCR_ANENABLE | \
					 BMCR_FULLDPLX | \
					 BMCR_SPEED1000)

When considering the previous patch, maybe BMCR_ANENABLE should be
conditional on the mode being selected?

	Andrew

