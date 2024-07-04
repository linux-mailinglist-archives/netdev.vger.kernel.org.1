Return-Path: <netdev+bounces-109290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A65B0927BC9
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 19:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CACDC1C23192
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 17:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F78345976;
	Thu,  4 Jul 2024 17:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1hJevEy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A5044C7E;
	Thu,  4 Jul 2024 17:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720113372; cv=none; b=LhcY8uuviuHLuVfiHHgEEHxO0OXpaofL13JFb31M25pcrSxNhkL+sLUFgWqu/T1vDEf0e4ho0BXu/G0B9bbMDqHOD83FT+AuEqRwsl2lFlLwGOtNRU1Ii4fWfL3cTQA/o4nVpTfPNIhjzs+2DA3RkyZfKpmKNjL60zDcwpREGF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720113372; c=relaxed/simple;
	bh=3x8lP/aTiF5WqSbnLsl7dbOKsbYQj2t1Eh7lHauCaek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZwu3aDdJuxQkx9u6Q3X1LKX502liF5Ruf7qqUgdQT7rhPHuQnFqa+ns84NfMB/ebd5lenBIjr8S/DXOaFbulujBLXDiFmRMaSkAqYknW7H/kt0iFemwBknNqabxPBNtHGqMDQNSvBXtgVH/bBWrihHftCW0FB/A9geWdc+Szos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1hJevEy; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ec1ac1aed2so9047301fa.3;
        Thu, 04 Jul 2024 10:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720113369; x=1720718169; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=akj1yGVTlXRj2mY3MwoGNS6aRJcCL4nmykWEYKR6h6Q=;
        b=Q1hJevEyTpL5w6Xlq4QLBfkySlH5p09tFZfg9ZVqJU4G6fmB7nsJoxyAV8J73T+G4T
         yYltIfvSQ+spVIh6WiJAMcURvF2cXL7dVpTeFRgYCUH/DQ+M4VZTHiU6fmjz3y/5qkxN
         ojPk5y6EcYBUiC9hhOXPZgirgzVEBLJ5kBA/CcKdfh/dNryk2l5GXvSakvh4wykRn5gy
         DqLEJ7t9sgv+UhQLOMiAnmnOSa+YvF87ogFeP1eX+RZPZeTGy7sEVCdQn089eO/DOfUR
         SxoAb38+L371ZD7xTo8+3e53CRmoSSJFl3M8FSxHRsH5wGXzwI3Fi6Mh0pnniCWC5pX9
         3IVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720113369; x=1720718169;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=akj1yGVTlXRj2mY3MwoGNS6aRJcCL4nmykWEYKR6h6Q=;
        b=vB/7gKHFbnZdjaTXydQ56RWMBcNlQZqwhoJA6I1nXcsLpWnROxfpJ9g8VNXKjhMzEA
         vVJjwoy0dRjmaCuwpKGu3qQfuYW1T9WHv/e1Wndcs0ysy9lFwZAfA91QL7I+GQFXwDZ4
         UNooL+bZ/9YHTY4WZu4T6XzUZKdBJ2CibbOYZRm3DqsY4eTU/zF5iy6ylCQRsgS2eL9D
         9N1r7L8c/tkgQqe/LBA02+/nQTf29zg2h+/5FFP/N7sJLef/P+h8VEydzFEJOJhoC6XO
         29EJ6eFVGByq7m8lZTU3bbjJ7W/kkrj9QQNnKCdRV5VZUQQPh1XCiM5/FMqT2ysVnKdx
         KgQw==
X-Forwarded-Encrypted: i=1; AJvYcCV4/qjbaHkyIWdwXOlUIG1iZglZeJvRQ9vmmuRef3/NZ8YT2lH76fx155DClojWmpaMauZ+6+jJwSJWYobzjYQp437UkmY07Wp/xvNB9+398i2IB2nxQ36hzmU2WtJMLaABDgB7
X-Gm-Message-State: AOJu0YwQeaMND3tgK9AB4sYENXr8Dg8oDjk39UWWYGQ/nPIIwdeUqRXB
	UUTi59E8oFzu7MQ6BYZZpRef1QPKNuS0wIczaS10fpFzt4WHKPKC
X-Google-Smtp-Source: AGHT+IFTA8kd9mjM2p40e2ZtadZbcVKxwDbfrWZ/Shn/mauifxOtKFwqzRmFtdoxFS3r+DxEPLODog==
X-Received: by 2002:a2e:9515:0:b0:2eb:f472:e7d3 with SMTP id 38308e7fff4ca-2ee8ed22c62mr15348351fa.6.1720113368407;
        Thu, 04 Jul 2024 10:16:08 -0700 (PDT)
Received: from skbuf ([188.25.110.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42649dec1cbsm12327265e9.1.2024.07.04.10.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:16:07 -0700 (PDT)
Date: Thu, 4 Jul 2024 20:16:04 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Landen Chao <Landen.Chao@mediatek.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v4] net: dsa: mt7530: fix impossible MDIO address and
 issue warning
Message-ID: <20240704171604.3ownsxasch5hokty@skbuf>
References: <1c378be54d0fb76117f6d72dadd4a43a9950f0dc.1720105125.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c378be54d0fb76117f6d72dadd4a43a9950f0dc.1720105125.git.daniel@makrotopia.org>

On Thu, Jul 04, 2024 at 04:08:22PM +0100, Daniel Golle wrote:
> The MDIO address of the MT7530 and MT7531 switch ICs can be configured
> using bootstrap pins. However, there are only 4 possible options for the
> switch itself: 7, 15, 23 and 31. As in MediaTek's SDK the address of the
> switch is wrongly stated in the device tree as 0 (while in reality it is
> 31), warn the user about such broken device tree and make a good guess
> what was actually intended.

Zero is the MDIO broadcast address. Doesn't the switch respond to it, or
what's exactly the problem?

> 
> This is imporant also to not break compatibility with older Device Trees

important

> as with commit 868ff5f4944a ("net: dsa: mt7530-mdio: read PHY address of
> switch from device tree") the address in device tree will be taken into
> account, while before it was hard-coded to 0x1f.
> 
> Fixes: b8f126a8d543 ("net-next: dsa: add dsa support for Mediatek MT7530 switch")

I fail to understand the logic behind blaming this commit. There was no
observable issue prior to 868ff5f4944a ("net: dsa: mt7530-mdio: read PHY
address of switch from device tree"), was there? That's what 'git bisect'
with a broken device tree would point towards?

> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> Reviewed-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
> Changes since v3 [3]:
>  - simplify calculation of correct address
> 
> Changes since v2 [2]:
>  - use macros instead of magic numbers
>  - introduce helper functions
>  - register new device on MDIO bus instead of messing with the address
>    and schedule delayed_work to unregister the "wrong" device.
>    This is a slightly different approach than suggested by Russell, but
>    imho makes things much easier than keeping the "wrong" device and
>    having to deal with keeping the removal of both devices linked.
>  - improve comments
> 
> Changes since v1 [1]:
>  - use FW_WARN as suggested.
>  - fix build on net tree which doesn't have 'mdiodev' as member of the
>    priv struct. Imho including this patch as fix makes sense to warn
>    users about broken firmware, even if the change introducing the
>    actual breakage is only present in net-next for now.
> 
> [1]: https://patchwork.kernel.org/project/netdevbpf/patch/e615351aefba25e990215845e4812e6cb8153b28.1714433716.git.daniel@makrotopia.org/
> [2]: https://patchwork.kernel.org/project/netdevbpf/patch/11f5f127d0350e72569c36f9060b6e642dfaddbb.1714514208.git.daniel@makrotopia.org/
> [3]: https://patchwork.kernel.org/project/netdevbpf/patch/7e3fed489c0bbca84a386b1077c61589030ff4ab.1719963228.git.daniel@makrotopia.org/
> 
>  drivers/net/dsa/mt7530-mdio.c | 91 +++++++++++++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
> 
> diff --git a/drivers/net/dsa/mt7530-mdio.c b/drivers/net/dsa/mt7530-mdio.c
> index 51df42ccdbe6..2037ed944801 100644
> --- a/drivers/net/dsa/mt7530-mdio.c
> +++ b/drivers/net/dsa/mt7530-mdio.c
> @@ -11,6 +11,7 @@
>  #include <linux/regmap.h>
>  #include <linux/reset.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/workqueue.h>
>  #include <net/dsa.h>
>  
>  #include "mt7530.h"
> @@ -136,6 +137,92 @@ static const struct of_device_id mt7530_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, mt7530_of_match);
>  
> +static int
> +mt7530_correct_addr(int phy_addr)

The prototype fits onto a single line.

> +{
> +	/* The corrected address is calculated as stated below:
> +	 * 0~6, 31 -> 31
> +	 * 7~14    -> 7
> +	 * 15~22   -> 15
> +	 * 23~30   -> 23
> +	 */
> +return (phy_addr - MT7530_NUM_PORTS & ~MT7530_NUM_PORTS) + MT7530_NUM_PORTS & PHY_MAX_ADDR - 1;

In addition to being weirdly indented and having difficult to follow
logic.. Why not opt for the simple, self-documenting variant below?

	switch (phy_addr) {
	case 0 ... 6:
	case 31:
		return 31;
	case 7 ... 14:
		return 7;
	case 15 ... 22:
		return 15;
	case 23 ... 30:
		return 23;
	default:
		return -EINVAL ???
	}

> +}
> +
> +static bool
> +mt7530_is_invalid_addr(int phy_addr)
> +{
> +	/* Only MDIO bus addresses 7, 15, 23, and 31 are valid options,
> +	 * which all have the least significant three bits set. Check
> +	 * for this.
> +	 */
> +	return (phy_addr & MT7530_NUM_PORTS) != MT7530_NUM_PORTS;

Why not implement this in terms of phy_addr != mt7530_correct_addr(phy_addr)?

> +}
> +
> +struct remove_impossible_priv {
> +	struct delayed_work remove_impossible_work;
> +	struct mdio_device *mdiodev;
> +};
> +
> +static void
> +mt7530_remove_impossible(struct work_struct *work)

Fits onto a single line.

> +{
> +	struct remove_impossible_priv *priv = container_of(work, struct remove_impossible_priv,
> +							   remove_impossible_work.work);
> +	struct mdio_device *mdiodev = priv->mdiodev;
> +
> +	mdio_device_remove(mdiodev);
> +	mdio_device_free(mdiodev);
> +	kfree(priv);
> +}
> +
> +static int
> +mt7530_reregister(struct mdio_device *mdiodev)
> +{
> +	/* If the address in DT must be wrong, make a good guess about
> +	 * the most likely intention, issue a warning, register a new
> +	 * MDIO device at the correct address and schedule the removal
> +	 * of the device having an impossible address.
> +	 */
> +	struct fwnode_handle *fwnode = dev_fwnode(&mdiodev->dev);
> +	int corrected_addr = mt7530_correct_addr(mdiodev->addr);
> +	struct remove_impossible_priv *rem_priv;
> +	struct mdio_device *new_mdiodev;
> +	int ret;
> +
> +	rem_priv = kmalloc(sizeof(*rem_priv), GFP_KERNEL);
> +	if (!rem_priv)
> +		return -ENOMEM;
> +
> +	new_mdiodev = mdio_device_create(mdiodev->bus, corrected_addr);
> +	if (IS_ERR(new_mdiodev)) {
> +		ret = PTR_ERR(new_mdiodev);
> +		goto out_free_work;
> +	}
> +	device_set_node(&new_mdiodev->dev, fwnode);
> +
> +	ret = mdio_device_register(new_mdiodev);
> +	if (WARN_ON(ret))
> +		goto out_free_dev;
> +
> +	dev_warn(&mdiodev->dev, FW_WARN
> +		 "impossible switch MDIO address in device tree, assuming %d\n",
> +		 corrected_addr);
> +
> +	/* schedule impossible device for removal from mdio bus */
> +	rem_priv->mdiodev = mdiodev;
> +	INIT_DELAYED_WORK(&rem_priv->remove_impossible_work, mt7530_remove_impossible);
> +	schedule_delayed_work(&rem_priv->remove_impossible_work, 0);

What makes it so that mt7530_remove_impossible() is actually guaranteed
to run after the probing of the mdio_device @ the incorrect address
_finishes_? mdio_device_remove() will not work on a device which has
probing in progress, will it?

There's also the more straightforward option of fixing up priv->mdiodev->addr
in mt7530.c to be something like priv->switch_base, which is derived
from priv->mdiodev->addr, with a fallback to 0x1f if the latter is zero,
and a FW_WARN().

