Return-Path: <netdev+bounces-149960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5895D9E834D
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 04:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46A84164752
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 03:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790F122097;
	Sun,  8 Dec 2024 03:27:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590E246B8
	for <netdev@vger.kernel.org>; Sun,  8 Dec 2024 03:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733628424; cv=none; b=uajjAKiLJ/7aw8YZS0teRgTXYQF8av3IWlR17tHhoPMtofui7Rz2TAKqnB22pIy6IJlWXJD5VXeZpJ1yFUfp7t/PR9Za7vBenI79kofwoutr9bawvHHCYBVraIMiL9WNcvxYxSUOD4lhbpgrW63LSwcfKJGzgxnS9ClXCYTTCyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733628424; c=relaxed/simple;
	bh=xPxcS+DgpX296WLAauhqmmrHnvlAmFGQynHPtzWY8EY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5QiMEQWL7sATsA2PKlWEPzDwWclG4r7Wv0lzldSjUpO5mW337N4wsXv3bX4iOXw4XVkOPhLoVJd04DBN71hk3KpoETJJJ9gPsl5lf+3R852+4b898Yo3uXbqk9d6x+In6el7g173qHamO3mIwLF2mSQGLpSf3AKnObFbRJnpO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1tK7YL-000000006ze-18Ds;
	Sun, 08 Dec 2024 03:01:49 +0000
Date: Sun, 8 Dec 2024 03:01:38 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexander Couzens <lynxis@fe80.eu>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 2/3] net: pcs: pcs-mtk-lynxi: implement
 pcs_inband_caps() method
Message-ID: <Z1UMEnlZ_ivTsru5@pidgin.makrotopia.org>
References: <Z1F1b8eh8s8T627j@shell.armlinux.org.uk>
 <E1tJ8NR-006L5P-E3@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tJ8NR-006L5P-E3@rmk-PC.armlinux.org.uk>

On Thu, Dec 05, 2024 at 09:42:29AM +0000, Russell King (Oracle) wrote:
> Report the PCS in-band capabilities to phylink for the LynxI PCS.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/pcs/pcs-mtk-lynxi.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-lynxi.c
> index 4f63abe638c4..7de804535229 100644
> --- a/drivers/net/pcs/pcs-mtk-lynxi.c
> +++ b/drivers/net/pcs/pcs-mtk-lynxi.c
> @@ -88,6 +88,21 @@ static struct mtk_pcs_lynxi *pcs_to_mtk_pcs_lynxi(struct phylink_pcs *pcs)
>  	return container_of(pcs, struct mtk_pcs_lynxi, pcs);
>  }
>  
> +static unsigned int mtk_pcs_lynxi_inband_caps(struct phylink_pcs *pcs,
> +					      phy_interface_t interface)
> +{
> +	switch (interface) {
> +	case PHY_INTERFACE_MODE_1000BASEX:
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +	case PHY_INTERFACE_MODE_SGMII:
> +	case PHY_INTERFACE_MODE_QSGMII:

QSGMII is not supported by this PCS.

Apart from that looks good to me.

Reviewed-by: Daniel Golle <daniel@makrotopia.org>


