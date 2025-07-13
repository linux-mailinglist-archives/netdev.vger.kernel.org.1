Return-Path: <netdev+bounces-206451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A309B032EE
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 22:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A91D3ACDDA
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 20:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A734230BE3;
	Sun, 13 Jul 2025 20:37:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7792E36FA;
	Sun, 13 Jul 2025 20:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752439023; cv=none; b=J485edUrTL+VhV2mAHMhLwEn4AGa2sn/NZecb3x0oukSblJ3+WaVqohRUbgd8N+gocx9gI7lNKnqq+VEPSkzR4cEEWMcBtcBrTHRoiBq9vcxNJ1efxmkKq4tABlPaDJ6myuIti2KTzJj5F2nz33DHDd3NWNed0fi55RTXdhm7Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752439023; c=relaxed/simple;
	bh=sGGiagykudEKZkkGzuuKG3XVSWwTTSUV7fAg084mJmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S845MX2n+ZY0+iZD+5SOdR7TMannRmmLvAwDJuEkPZPXHWLYHcK7bbHN/ad+hLSdyL1rKvjfpB41gD8tGyWlviuwgepQCCpRljc6oqfUo/q3G/mBwHDmLUVNLqTwtr0wQiuPJ+al2F1lu2ogCX3rRfUfipVMY9dye5RPGwyElbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1ub3R7-000000002gs-20cO;
	Sun, 13 Jul 2025 20:36:37 +0000
Date: Sun, 13 Jul 2025 21:36:34 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next] net: dsa: mt7530: Constify struct regmap_config
Message-ID: <aHQY0hVsua5pP0QC@makrotopia.org>
References: <1b20b2e717e9ff15aa0d1e73442dde613174cfef.1752419299.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b20b2e717e9ff15aa0d1e73442dde613174cfef.1752419299.git.christophe.jaillet@wanadoo.fr>

On Sun, Jul 13, 2025 at 05:09:24PM +0200, Christophe JAILLET wrote:
> 'struct regmap_config' are not modified in these drivers. They be
> statically defined instead of allocated and populated at run-time.
> 
> The main benefits are:
>   - it saves some memory at runtime
>   - the structures can be declared as 'const', which is always better for
>     structures that hold some function pointers
>   - the code is less verbose
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/net/dsa/mt7530-mdio.c | 21 +++++++++------------
>  drivers/net/dsa/mt7530-mmio.c | 21 ++++++++++-----------
>  2 files changed, 19 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/dsa/mt7530-mdio.c b/drivers/net/dsa/mt7530-mdio.c
> index 51df42ccdbe6..0286a6cecb6f 100644
> --- a/drivers/net/dsa/mt7530-mdio.c
> +++ b/drivers/net/dsa/mt7530-mdio.c
> @@ -136,10 +136,17 @@ static const struct of_device_id mt7530_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, mt7530_of_match);
>  
> +static const struct regmap_config regmap_config = {

Maybe calling this one 'regmap_config_mdio'...


> +	.reg_bits = 16,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = MT7530_CREV,
> +	.disable_locking = true,
> +};
> +
> ...

> diff --git a/drivers/net/dsa/mt7530-mmio.c b/drivers/net/dsa/mt7530-mmio.c
> index 842d74268e77..1dc8b93fb51a 100644
> --- a/drivers/net/dsa/mt7530-mmio.c
> +++ b/drivers/net/dsa/mt7530-mmio.c
> @@ -18,10 +18,17 @@ static const struct of_device_id mt7988_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, mt7988_of_match);
>  
> +static const struct regmap_config sw_regmap_config = {

... and this one 'regmap_config_mmio' would be a bit nicer.

> +	.name = "switch",
> +	.reg_bits = 16,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = MT7530_CREV,
> +};
> +

Other than that:

Reviewed-by: Daniel Golle <daniel@makrotopia.org>

