Return-Path: <netdev+bounces-190574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9D1AB7A55
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 02:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 409881BA3ED8
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 00:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1777B81E;
	Thu, 15 May 2025 00:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vYnCuO/+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1CF191;
	Thu, 15 May 2025 00:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747267643; cv=none; b=U2TCT2qlG9Zq+exv4S6ktPyvI7DCnddbxoBKyEhPiinwEl5li9j2crbedJS9rGVeXZgOY5U0OrGdWG3a99cJB4pbpImNCtMy1s37kL/Cj0QSxniWOXThmZMQcaumjR8y0VlwauuCimh2+E1TH+6SBP6URAkQsy1VI+bqYhi7FKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747267643; c=relaxed/simple;
	bh=A61IAPPIQCX9gPpkl4mNttX6eZT/ZSl9vKs8/xX3xHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHkU+GTWHw9qOyCIUqiSVDZAlngq8R2mCIf8CqcmtVdvgoRBCvMwl7QEpqx0eqrQhsjJQSev+iv9VtUaEuHWjgi6LDct//wh0zq1PJsB8CzFTRE0L8vgO0fxDBS0IkFosbVHQv9Ip1VHDgmXUDmmF4fxi2dN2iNLl9YVQtGuQtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vYnCuO/+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=luofUVcAN0UA6x58b67WTFgcxsXtsFsIFSUS1UUxJ8g=; b=vYnCuO/+OBt40VbCg96TjeCwr4
	eauZ1iJpCDX6quiYV43Ck/j/nOcvxHDY7YTLbgHM6XZtMHmL3oASkpk7PxY4FfXqeqztpYJrMOWyF
	rT6XivWDTuJc0x40Nka0EO7SArQegTR3A667VpFGfBolzgWq+eUFTOjr08voTFfCk/3A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uFM81-00CcFF-Cy; Thu, 15 May 2025 02:07:13 +0200
Date: Thu, 15 May 2025 02:07:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Raju Rangoju <Raju.Rangoju@amd.com>, g@lunn.ch
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Shyam-sundar.S-k@amd.com
Subject: Re: [PATCH net] amd-xgbe: read link status twice to avoid
 inconsistencies
Message-ID: <acca227d-c2a9-4fc3-a6fc-3001472370a3@lunn.ch>
References: <20250514194145.3681817-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514194145.3681817-1-Raju.Rangoju@amd.com>

On Thu, May 15, 2025 at 01:11:45AM +0530, Raju Rangoju wrote:
> The link status is latched low, so read the register twice to get the
> current status and avoid link inconsistencies.
> 
> As per IEEE 802.3 "Table 22-8 - Status register bit definitions"
> 1.2  Link Status  1 = link is up    0 = link is down    RO/LL
> 
> Fixes: 4f3b20bfbb75 ("amd-xgbe: add support for rx-adaptation")
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> ---
>  drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
> index 268399dfcf22..d233e3faa1a9 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
> @@ -2914,6 +2914,10 @@ static int xgbe_phy_link_status(struct xgbe_prv_data *pdata, int *an_restart)
>  		}
>  
>  		/* check again for the link and adaptation status */
> +		/* Link status is latched low, so read once to clear
> +		 * and then read again to get current state
> +		 */
> +		reg = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_STAT1);


Since this is not a phylib user, i don't care too much, but:

https://elixir.bootlin.com/linux/v6.14.6/source/drivers/net/phy/phy_device.c#L2514

	/* The link state is latched low so that momentary link
	 * drops can be detected. Do not double-read the status
	 * in polling mode to detect such short link drops except
	 * the link was already down.
	 */

So you don't care about short link drops? You don't want to tell user
space the link went away and came back? It never happened.

	Andrew

