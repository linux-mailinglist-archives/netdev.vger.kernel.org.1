Return-Path: <netdev+bounces-211272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEFCB17706
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 22:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B8021C27790
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 20:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2FE1ACED9;
	Thu, 31 Jul 2025 20:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbEBB58l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CEA134CF;
	Thu, 31 Jul 2025 20:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753993124; cv=none; b=G67+E8ZHQH6IwB2UeILFIfeu+ClHTh0y/AXtOcwLHT6tH6/Jkpe76TEeuXALyVgH8wTI6iNPledFVUWEjhPG8OKlIc7vr9pqpCYyqbQK8ZpU6CzfrIdDWZSDV1TuiFb3NCtIgeXJ10mUbnWgUvHGKekaA1/sVBCsg911U+XPqjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753993124; c=relaxed/simple;
	bh=wRM/PA6cJ2JEMESFHLAWKFrlHYJBYwYV2kTWQyU87lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGLnAYM/f3kNt/hfmQ9I3R2M4hQ4cgOo6LdPGKp8H03kpMhp9bANH/8a6tOCvhD/V7fUG6TALo8gNr9FtdEiQH3EvmoQqbvr62T8pjd3UXoTxn+mQAV1R3KXZcvvCSDPwM418AzodsMngg8nvkZDxYJv89zKTTOz2Dt+0WcW6ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbEBB58l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C60BC4CEEF;
	Thu, 31 Jul 2025 20:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753993123;
	bh=wRM/PA6cJ2JEMESFHLAWKFrlHYJBYwYV2kTWQyU87lc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NbEBB58lngVa/0Az1+8+ZmTxAn61RHCjU/CSl5rE7+t7u4Mk2Aayg06G8hGxIJUSU
	 3jx+qyBMPqmyCYBgNs+C2kLCGsgASoUa49XeBSydXaUIn2COC5HylO/OVwcabDNi/C
	 iAkSHuERXC6g4GDSbtOBb2ujKa+jr6Ynobue9K7LLq3PL7Uyi7mj98/bDnih6nZGg2
	 BZlE9DmZA2Yfs44N9TpLwUxyV3Ma83/5xtVi8lmzTCuOOKierW8AKRM4SzxrQIIeTi
	 9QlhcpD0XaEspNz1yPY8iKXdd0MLCEa/t/AYlPHW0IrxUSl78Ka80L4dr/EAyBbz7J
	 MWRnxXN7xE1RQ==
Date: Thu, 31 Jul 2025 21:18:39 +0100
From: Simon Horman <horms@kernel.org>
To: Kyle Hendry <kylehendrydev@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	noltari@gmail.com, jonas.gorski@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: dsa: b53: mmap: Implement bcm63268
 gphy power control
Message-ID: <20250731201839.GG8494@horms.kernel.org>
References: <20250730020338.15569-1-kylehendrydev@gmail.com>
 <20250730020338.15569-3-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730020338.15569-3-kylehendrydev@gmail.com>

On Tue, Jul 29, 2025 at 07:03:36PM -0700, Kyle Hendry wrote:
> Add check for gphy in enable/disable phy calls and set power bits
> in gphy control register.
> 
> Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>

Hi Kyle,

Thanks for your patches.

Unfortunately net-next is currently closed. So I'd like to ask for you to
post this patchset when it reopens. You should include Florian's tags when
doing so.

## Form letter - net-next-closed

The merge window for v6.17 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations. We are
currently accepting bug fixes only.

Please repost when net-next reopens after 11th August.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

> ---
>  drivers/net/dsa/b53/b53_mmap.c | 33 +++++++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/dsa/b53/b53_mmap.c b/drivers/net/dsa/b53/b53_mmap.c
> index 87e1338765c2..f4a59d8fbdd6 100644
> --- a/drivers/net/dsa/b53/b53_mmap.c
> +++ b/drivers/net/dsa/b53/b53_mmap.c
> @@ -29,6 +29,10 @@
>  #include "b53_priv.h"
>  
>  #define BCM63XX_EPHY_REG 0x3C
> +#define BCM63268_GPHY_REG 0x54
> +
> +#define GPHY_CTRL_LOW_PWR	BIT(3)
> +#define GPHY_CTRL_IDDQ_BIAS	BIT(0)
>  
>  struct b53_phy_info {
>  	u32 gphy_port_mask;
> @@ -292,13 +296,30 @@ static int bcm63xx_ephy_set(struct b53_device *dev, int port, bool enable)
>  	return regmap_update_bits(gpio_ctrl, BCM63XX_EPHY_REG, mask, val);
>  }
>  
> +static int bcm63268_gphy_set(struct b53_device *dev, bool enable)
> +{
> +	struct b53_mmap_priv *priv = dev->priv;
> +	struct regmap *gpio_ctrl = priv->gpio_ctrl;
> +	u32 mask = GPHY_CTRL_IDDQ_BIAS | GPHY_CTRL_LOW_PWR;
> +	u32 val = 0;

I'm also wondering if you could update this to follow the
reverse xmas tree - longest line to shortest - for local variable
declarations. I realise that isn't followed particularly well
in this file. But it is preferred for Networking code.

I think in this case that could be as follows (completely untested!):

	u32 mask = GPHY_CTRL_IDDQ_BIAS | GPHY_CTRL_LOW_PWR;
	struct b53_mmap_priv *priv = dev->priv;
	struct regmap *gpio_ctrl;
	u32 val = 0;

	gpio_ctrl = priv->gpio_ctrl;

Edward Cree's tool can be of assistance here.
https://github.com/ecree-solarflare/xmastree

> +
> +	if (!enable)
> +		val = mask;
> +
> +	return regmap_update_bits(gpio_ctrl, BCM63268_GPHY_REG, mask, val);
> +}
> +

...

-- 
pw-bot: defer

