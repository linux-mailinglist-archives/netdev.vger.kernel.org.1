Return-Path: <netdev+bounces-244793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAB9CBEC76
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 16:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A4E23084AB6
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 15:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE7B30F812;
	Mon, 15 Dec 2025 15:50:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30D530BBB7;
	Mon, 15 Dec 2025 15:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765813838; cv=none; b=NN0HyDTkk52s9KnsCQ0z0xThXY3Ha0p3P+yofgtezq1St3FgwRDyeR5OM+L4OTc9ZeUGmKVbkjJAyHe/QeTV/5YQ6j3Y8fCAixvDeSc7LZeeKuHm9u//X+nzvXveXC0d2+eGlw/G23CVxapiwKpNDA8aetkdbM2YQj9zcvqy2pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765813838; c=relaxed/simple;
	bh=UZAkR/Ae3nO4/ZDbRoyznUQpJPHpyjjhcyt78FXXqaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxyDDlE1nF3Rg3bFLL1Vz2iemv16Kr9Yq49ngpa0equi5k+ITDvlQE8bc/fvufTLYPLCMavazmAzAeoEGZgViorVCSkgBuFwLPhz4GAnB7ukMrbKUnKqoaK7gC/CyQt+TTYoe/ELRWG0P5O3M1FLjV0ontqpUhm3x3eE02X/GFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vVAqA-00000000678-16vy;
	Mon, 15 Dec 2025 15:50:26 +0000
Date: Mon, 15 Dec 2025 15:50:17 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: dsa: mxl-gsw1xx: Support R(G)MII slew
 rate configuration
Message-ID: <aUAuObAoaNVOTYdR@makrotopia.org>
References: <20251212204557.2082890-1-alexander.sverdlin@siemens.com>
 <20251212204557.2082890-3-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212204557.2082890-3-alexander.sverdlin@siemens.com>

Hi Alexander,

On Fri, Dec 12, 2025 at 09:45:53PM +0100, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> Support newly introduced maxlinear,mii-slew-rate-slow device tree property
> to configure R(G)MII interface pins slew rate into "slow" mode. It might be
> used to reduce the radiated emissions.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---
>  drivers/net/dsa/lantiq/mxl-gsw1xx.c | 6 ++++++
>  drivers/net/dsa/lantiq/mxl-gsw1xx.h | 2 ++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.c b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> index 0816c61a47f12..ec7b92f62dcb5 100644
> --- a/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> +++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> @@ -526,6 +526,12 @@ static struct phylink_pcs *gsw1xx_phylink_mac_select_pcs(struct phylink_config *
>  	switch (dp->index) {
>  	case GSW1XX_SGMII_PORT:
>  		return &gsw1xx_priv->pcs;
> +	case GSW1XX_MII_PORT:
> +		if (of_property_read_bool(dp->dn, "maxlinear,mii-slew-rate-slow"))
> +			regmap_set_bits(gsw1xx_priv->shell,
> +					RGMII_SLEW_CFG_DRV_TXD | RGMII_SLEW_CFG_DRV_TXC,
> +					GSW1XX_SHELL_RGMII_SLEW_CFG);
> +		return NULL;

Please apply this setting once in the probe function before calling
gswip_probe_common(). You will have to traverse the device tree to
the node of the port, but imho this is still better because there is
no need to apply it every time mac_select_pcs() is called. And while
it is not strictly speaking wrong to do it there, in my understanding
the purpose of .mac_select_pcs is to return the PCS and maybe setup
muxes, but not to apply low-level settings.

Apart from that, please program the register also in the 'else' case.

