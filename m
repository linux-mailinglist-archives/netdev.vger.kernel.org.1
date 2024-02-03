Return-Path: <netdev+bounces-68871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D438584890C
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 22:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1080B1C22048
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 21:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775A1134C5;
	Sat,  3 Feb 2024 21:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JQ1P79bL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F2A111AE
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 21:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706997018; cv=none; b=bDCHo1RcCDlAucfcdj/FJe/69JcnXwnml0Kmtbp0fMZH4GiUUzK33jATVJ0rO9kj4CsuhVy+gLoGhHGjURPttUfyGSuLNmhJqO7hP5HoZ23sdEZ1ZTioKcqvYlbVupaDWJsn1t5trEv3PUFswFGbBOOZdrglm1VWit3x4Grhd54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706997018; c=relaxed/simple;
	bh=GVtuxF0+4Fz0WnQp/SeouuNlrfnVdlzQnpK/aQTsj/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQRvEeTzqqozhtaccy1+VW2SAthOzjRze20jBqcIWFvS06txyLQieG0Auc3XBmzTxDpYIiyyk2mawe3YSa2SRhnJt270g3kdEYqnzUWR51gmPMnnNtO0M9RWqmD4eNhMFbTkl7aoS+J/iUtjbVEyR/32e3RY5muVmFOZSdKMhcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JQ1P79bL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=61NBGmCVe2Lcwk9mppUq2e5owY3gwEXA+I4jl+kawKA=; b=JQ1P79bLCm+d1sXKlw2j9fqbU1
	GJvrevLv617NYjQYwDjGcrz9I7eBejw+fvPYVHEQWVD1o+Q+IgbxXG4C1LclYXrANHGc2wiaP1rw4
	201gQa/SxXa3JbuE1NeFQM4tmLJwRDBYGEQgOzDccWUJzkOJjIvxtzysrbq4jOSK0U6I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rWNtj-006vc8-VX; Sat, 03 Feb 2024 22:50:03 +0100
Date: Sat, 3 Feb 2024 22:50:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Igor Russkikh <irusskikh@marvell.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: atlantic: convert EEE handling to use
 linkmode bitmaps
Message-ID: <c7979b55-142b-469b-8da3-2662f0fe826e@lunn.ch>
References: <7d34ec3f-a2b7-41f5-8f4b-46ee78a76267@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d34ec3f-a2b7-41f5-8f4b-46ee78a76267@gmail.com>

On Sat, Feb 03, 2024 at 10:25:44PM +0100, Heiner Kallweit wrote:
> Convert EEE handling to use linkmode bitmaps. This prepares for
> removing the legacy bitmaps from struct ethtool_keee.
> No functional change intended.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  .../ethernet/aquantia/atlantic/aq_ethtool.c   | 21 +++++++++----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
> index 0bd1a0a1a..7cc36517b 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
> @@ -15,6 +15,7 @@
>  #include "aq_macsec.h"
>  #include "aq_main.h"
>  
> +#include <linux/linkmode.h>
>  #include <linux/ptp_clock_kernel.h>
>  
>  static void aq_ethtool_get_regs(struct net_device *ndev,
> @@ -681,20 +682,18 @@ static int aq_ethtool_get_ts_info(struct net_device *ndev,
>  	return 0;
>  }
>  
> -static u32 eee_mask_to_ethtool_mask(u32 speed)
> +static void eee_mask_to_ethtool_mask(unsigned long *mode, u32 speed)
>  {
> -	u32 rate = 0;
> +	linkmode_zero(mode);

Some comment as to bnx2x.

>  static int aq_ethtool_get_eee(struct net_device *ndev, struct ethtool_keee *eee)
> @@ -713,14 +712,14 @@ static int aq_ethtool_get_eee(struct net_device *ndev, struct ethtool_keee *eee)
>  	if (err < 0)
>  		return err;
>  
> -	eee->supported_u32 = eee_mask_to_ethtool_mask(supported_rates);
> +	eee_mask_to_ethtool_mask(eee->supported, supported_rates);
>  
>  	if (aq_nic->aq_nic_cfg.eee_speeds)
> -		eee->advertised_u32 = eee->supported_u32;
> +		linkmode_copy(eee->advertised, eee->supported);

This is again a correct translation. But the underlying implementation
seems wrong. aq_ethtool_set_eee() does not appear to allow the
advertisement to be changed, so advertised does equal
supported. However aq_ethtool_set_eee() does not validate that the
user is not changing what is advertised and returning an error. Lets
leave it broken, and see if Aquantia/Marvell care.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

