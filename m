Return-Path: <netdev+bounces-133313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C395D99595F
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D0C21F250DF
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 21:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD542213EF1;
	Tue,  8 Oct 2024 21:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ovSq+9zt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523591DF241;
	Tue,  8 Oct 2024 21:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728423654; cv=none; b=UBPHsjbxHq6aheqUi7YrE7CZ3oXawd98Iti3lIPKbOlRGpnwlO4BcDosZ9D0gPHH/79C4QlKGes5rKLfM7s4issK507YCkN60TXtil/xEo+POh43dJIiw4PvswbThtpBMhxeVCFzZmsximHYTgf3qu1wz6/8bYzU/ExqDOAEVWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728423654; c=relaxed/simple;
	bh=mjuZtvbvN6yB1MZfQJAXHp9GY1DzfjRXz1ozIEosAVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIj5L7G6RKbLk+/B+lgSIdOCpcRFsLgp84N+7eihXM8K79QOTVwH975T6U9E34Nq6pqjNjdIH8c3/6iOVZcUxr4ZZA4QXaQzGktBED9wzkm9t68AAOcXs390t3KS991BkYzRJj4d7AIkd3LEvt5z9qv3UjzxPd1X3SVbMo2slCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ovSq+9zt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5GDTP1p+hoBPmsPFl/Dm1EEMqKTI/kABb/RyAjvIxKg=; b=ovSq+9ztKTA8KREnlnYOIje66D
	evoCNhByMSyy7VtR1OySgXKEO/uXs6D0BEVOevVGz1Zb7Q5/GYOdNrGiHR+Ae11LdugEdaXNt/HBv
	c7pmGNQWqOLD7gWOlHOTfQbMsT6nV9BlJc/lPg9qJKfag09lWjd4GmZqYQ/FCDPCqfmM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1syHwe-009PsY-NC; Tue, 08 Oct 2024 23:40:40 +0200
Date: Tue, 8 Oct 2024 23:40:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v0] net: phy: aquantia: poll status register
Message-ID: <5f4a8026-0057-48dd-b51e-6888d79c3d76@lunn.ch>
References: <20241006213536.3153121-1-aryan.srivastava@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006213536.3153121-1-aryan.srivastava@alliedtelesis.co.nz>

On Mon, Oct 07, 2024 at 10:35:36AM +1300, Aryan Srivastava wrote:
> The system interface connection status register is not immediately
> correct upon line side link up. This results in the status being read as
> OFF and then transitioning to the correct host side link mode with a
> short delay. This results in the phylink framework passing the OFF
> status down to all MAC config drivers, resulting in the host side link
> being misconfigured, which in turn can lead to link flapping or complete
> packet loss in some cases.
> 
> Mitigate this by periodically polling the register until it not showing
> the OFF state. This will be done every 1ms for 10ms, using the same
> poll/timeout as the processor intensive operation reads.

Does the datasheet say anything about when MDIO_PHYXS_VEND_IF_STATUS
is valid?

>  #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_XAUI	4
>  #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_SGMII	6
>  #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_RXAUI	7
> +#define MDIO_PHYXS_VEND_IF_STATUS_TYPE_OFF	9
>  #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_OCSGMII	10
>  
>  #define MDIO_AN_VEND_PROV			0xc400
> @@ -342,9 +343,18 @@ static int aqr107_read_status(struct phy_device *phydev)
>  	if (!phydev->link || phydev->autoneg == AUTONEG_DISABLE)
>  		return 0;
>  
> -	val = phy_read_mmd(phydev, MDIO_MMD_PHYXS, MDIO_PHYXS_VEND_IF_STATUS);
> -	if (val < 0)
> -		return val;
> +	/**
> +	 * The status register is not immediately correct on line side link up.
> +	 * Poll periodically until it reflects the correct ON state.
> +	 */
> +	ret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_PHYXS,
> +					MDIO_PHYXS_VEND_IF_STATUS, val,
> +					(FIELD_GET(MDIO_PHYXS_VEND_IF_STATUS_TYPE_MASK, val) !=
> +					MDIO_PHYXS_VEND_IF_STATUS_TYPE_OFF),
> +					AQR107_OP_IN_PROG_SLEEP,
> +					AQR107_OP_IN_PROG_TIMEOUT, false);
> +	if (ret)
> +		return ret;

I don't know if returning ETIMEDOUT is the correct thing to do
here. It might be better to set phydev->link to false, since there is
no end to end link yet.

	Andrew

