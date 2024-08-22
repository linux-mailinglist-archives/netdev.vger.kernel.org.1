Return-Path: <netdev+bounces-121103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED0F95BB2D
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 17:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C8931C23B84
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 15:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AF31CCEC1;
	Thu, 22 Aug 2024 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Q6GiiF6F"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876D21CCEC6;
	Thu, 22 Aug 2024 15:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724342307; cv=none; b=KxsJNpHDQeE1W7cV8yZ25Q6Mw7xyfVzeyjN1KJjrRydN5G9QwAPecsdMyyQJiTH4zyXZnWRUIDB5ybEAIU2UrLOYCYpNbeK8eUFxojMOBz9eKrECvCITjRWqcXUU9NRQtfHMbfniLq///Cw3lvkKAnm6U2VbVrehUR0M1JBMwJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724342307; c=relaxed/simple;
	bh=0kwLXkjWsmvkjG1eVlTQ6ISeNfnmRlQNjjN2BXNFJVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOnwRKGvxIxeu19ZDkLL5P3IgfSXLKM8m5B2K5Dy9izxMqCMo7yUZjPpa4XRqtn8DGB1PGugqKDvDT0GQ8KiUqEiIovWufol0UFD7sSTbKqFCBJdgXJZIZbRaSybUG8LvLwAPYa84x8QZ3r4lDzzCUZ0q9HuM2YF3wajl5bgcDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Q6GiiF6F; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=p9T0nIbbsOnoYxwmuxZMAo2ELSl3l1YjreHaqf2zT/M=; b=Q6GiiF6FrAB/jgcfpHfi4vp3uM
	K8YzFTgsBiKT8kH6BGJ0iIPSdDhLv6HPsvuc2v1hoP8Nq0u7lOyQXjF2xoG+W88LpqWz1KA/+JqgQ
	0NOXp0rXVJsUnevDaxfjZB7fzwAxJhmXplJkYzCwmwhJ0DF7FWJX5hyd+4Gmv+/962iM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1shACX-005RoO-BS; Thu, 22 Aug 2024 17:58:17 +0200
Date: Thu, 22 Aug 2024 17:58:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: vitesse: implement MDI-X
 configuration in vsc73xx
Message-ID: <3abe172b-cbad-4879-9dbf-9257e736ec6a@lunn.ch>
References: <20240822145336.409867-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822145336.409867-1-paweldembicki@gmail.com>

> +static int vsc73xx_mdix_set(struct phy_device *phydev, u8 mdix)
> +{
> +	int ret;
> +	u16 val;
> +
> +	val = phy_read(phydev, MII_VSC73XX_PHY_BYPASS_CTRL);
> +
> +	switch (mdix) {
> +	case ETH_TP_MDI:
> +		val |= MII_VSC73XX_PBC_FOR_SPD_AUTO_MDIX_DIS |
> +		       MII_VSC73XX_PBC_PAIR_SWAP_DIS |
> +		       MII_VSC73XX_PBC_POL_INV_DIS;
> +		break;
> +	case ETH_TP_MDI_X:
> +		/* When MDI-X auto configuration is disabled, is possible
> +		 * to force only MDI mode. Let's use autoconfig for forced
> +		 * MDIX mode.
> +		 */
> +	default:
> +		val &= ~(MII_VSC73XX_PBC_FOR_SPD_AUTO_MDIX_DIS |

This could be a little bit more readable if rather than default: you
used case ETH_TP_MDI_AUTO: . Then after this code, add a real default:
which returns -EINVAL,

    Andrew

---
pw-bot: cr

