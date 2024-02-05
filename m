Return-Path: <netdev+bounces-69271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEC384A8D9
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 23:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDDCEB24AED
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 22:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FBE5C617;
	Mon,  5 Feb 2024 21:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMv8uBp/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D75A487AB
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 21:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707170132; cv=none; b=c4tvVl5ZwQ43KkBG8H3KBUsMco24OoddSoWSnVBDzOzffV+OthlGdK4TzDQ++mZzPc/R4jpXaNR3byjYpgvLreOrlJGj9qBRORZQ90DVvYbjiXHoFWwq6gtneQcNDv+sjz1C+QFL6dps85nYdrhve6IcEtrDOC5U2J9BwgzDtaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707170132; c=relaxed/simple;
	bh=bEDHf8MqbCJEYddWfU9HLkw150L9OIAgaSqUdb9ootM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0Ie/fZ1sMIQevZjRynqV6L93boxVQl4HylIyOSm4H5FK1AureX0tCzW8DBIAEK6ZftHa26nZDTAD+I+PIrE9y3i6GsluiuC79UQFMb/Ap+5pJVmNZI1T3rQyWqau9vLi2wXK7CO5XzEYHnBldjpTDgopMIBlclwyOZKkZKn+bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMv8uBp/; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d066b532f0so2082011fa.1
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 13:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707170128; x=1707774928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OlBSpZiW6u6bf7dC1YxHLSy5nl37WYUfigGZcQJDJ8I=;
        b=TMv8uBp/SUakXKKHaO96KseFzWLB4MqMBgwPjBhLkABpsd9YyX8tRhLGXdtebNoU5U
         hqNm5acd7utRh0Bt51QFeo9B9EBNolmetBqzKwPLqjkREXkHe/cdunxa8Jk2McYUZCjw
         MS46YgtNT5+d+Eg1XKGBCu0DF7fI2G9dHueswczR95Lo5mRk7ZX6qr2ziFygKVXzs6BO
         nTQUv2e8gupb2ih9qXBoX1T25n7InmPdXxdV8PspcfnCHKAQbtFzGZnmCkQGdXtU81yN
         CgKTOz/meR/EmNX9MqYwZ/yyYeu68VtSxVQmIlPp+Bbk7qqTL6QM+NS1cWq9N5JK2ylx
         vWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707170128; x=1707774928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlBSpZiW6u6bf7dC1YxHLSy5nl37WYUfigGZcQJDJ8I=;
        b=BOdb10cFCWo61w8i5/WN+eMMztjhYyoI/QpcyaY9hbI3rt+BOFLSFmAKPws8+Sn5re
         HC1Y8cEsNnx+s9NnJBl3iGueZcXJkmqi741XCnkzc8cD9hnrVgHE4cX4ED9mMfZtV1y1
         RaUMJQBRRdgBE95hPHjLemdgIgAR1bD9RwwpNAlHPQ2BufiXsIV3B2lT/y2Y9RdobJiY
         /Jd/ecCAlBUMAnwDEKh7n7bKo3ngd/AO80Pok2iE8K5K6oMFNw1dPW58byagU2y5386n
         K8GIpkeg3i5MvRJCXvC5Zix5tdqYo5nNQEIG/tVFYFIKb1VugoSZW1q8x3DaqE6eGs8X
         q5aQ==
X-Gm-Message-State: AOJu0YyDq742Hr4v2WD6treHnFJ580kM9lKV5aSV6fcXj0OfoNrmoyIT
	pkJ9+r+TJqTRQ/prpboT9ybrwReHeUqBvDjzRR9DwyDDQvXBbujHnmgL5Xn1vQU=
X-Google-Smtp-Source: AGHT+IGlvkjgo0QcvvpTR11Eotdh6d+gCIHM8w1TsRlinLP2r2z0z752yNuZ/I21QuSEDwlf1SPOqg==
X-Received: by 2002:ac2:5dfc:0:b0:511:577c:ee7a with SMTP id z28-20020ac25dfc000000b00511577cee7amr580113lfq.23.1707170127889;
        Mon, 05 Feb 2024 13:55:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUA3wGx01MQXt0zrfdqHunsERxK45ohST+c1INvHCaea0QBFEGk+h29GDJPHcKxooTatHGE9KI2xbWrkedzfivODrj8jZMJ29EiNvj03NMiaXHZNyu0Jgahw4+J3NHLI3kVczfDRBW1uEjaaVoDXMpPf6EoIPGW/6t2rjXTPsmilW5e99qucL7aeptqmhPO7z2yv1gS3LM0D1j/+EHzUcuOKhQLzEertURnCa0Lwn38VbRA206L7PycVhNyy3vcLnHeVRlLN3fmV2rufNwJNQzijqLWsjt81I7GWRJ3YNBsWRcumor4OdQBmqi922p910MNbHYwH4zPmuiNJ/S7ShrjskTKnSHiIsREv1IpvAx9wUvWa1Da3xufHArenb7KfabBj2RvNA==
Received: from mobilestation ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id l3-20020ac24a83000000b005114a920f86sm61934lfp.145.2024.02.05.13.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 13:55:27 -0800 (PST)
Date: Tue, 6 Feb 2024 00:55:25 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v8 08/11] net: stmmac: dwmac-loongson: Fix MAC
 speed for GNET
Message-ID: <fg46ykzlyhw7vszgfaxkfkqe5la77clj2vcyrxo6f2irjod3gq@xdrlg4h7hzbu>
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <e3c83d1e62cd67d5f3b50b30f46c232a307504ab.1706601050.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3c83d1e62cd67d5f3b50b30f46c232a307504ab.1706601050.git.siyanteng@loongson.cn>

On Tue, Jan 30, 2024 at 04:48:20PM +0800, Yanteng Si wrote:
> Current GNET on LS7A only supports ANE when speed is
> set to 1000M.

If so you need to merge it into the patch
[PATCH net-next v8 06/11] net: stmmac: dwmac-loongson: Add GNET support

> 
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 19 +++++++++++++++++++
>  .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  6 ++++++
>  include/linux/stmmac.h                        |  1 +
>  3 files changed, 26 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 60d0a122d7c9..264c4c198d5a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -344,6 +344,21 @@ static struct stmmac_pci_info loongson_gmac_pci_info = {
>  	.config = loongson_gmac_config,
>  };
>  
> +static void loongson_gnet_fix_speed(void *priv, unsigned int speed, unsigned int mode)
> +{
> +	struct loongson_data *ld = (struct loongson_data *)priv;
> +	struct net_device *ndev = dev_get_drvdata(ld->dev);
> +	struct stmmac_priv *ptr = netdev_priv(ndev);
> +

> +	/* The controller and PHY don't work well together.

So there _is_ a PHY. What is the interface between MAC and PHY then?

> +	 * We need to use the PS bit to check if the controller's status
> +	 * is correct and reset PHY if necessary.
> +	 */

> +	if (speed == SPEED_1000)
> +		if (readl(ptr->ioaddr + MAC_CTRL_REG) & (1 << 15) /* PS */)
> +			phy_restart_aneg(ndev->phydev);

1. Please add curly braces for the outer if-statement.
2. MAC_CTRL_REG.15 is defined by the GMAC_CONTROL_PS macro.
3. How is the AN-restart helps? PHY-reset is done in
stmmac_init_phy()->phylink_connect_phy()->... a bit earlier than
this is called in the framework of the stmmac_mac_link_up() callback.
Wouldn't that restart AN too?

> +}
> +
>  static struct mac_device_info *loongson_setup(void *apriv)
>  {
>  	struct stmmac_priv *priv = apriv;
> @@ -401,6 +416,7 @@ static int loongson_gnet_data(struct pci_dev *pdev,
>  	plat->phy_interface = PHY_INTERFACE_MODE_INTERNAL;
>  
>  	plat->bsp_priv = &pdev->dev;
> +	plat->fix_mac_speed = loongson_gnet_fix_speed;
>  
>  	plat->dma_cfg->pbl = 32;
>  	plat->dma_cfg->pblx8 = true;
> @@ -416,6 +432,9 @@ static int loongson_gnet_config(struct pci_dev *pdev,
>  				struct stmmac_resources *res,
>  				struct device_node *np)
>  {

> +	if (pdev->revision == 0x00 || pdev->revision == 0x01)
> +		plat->flags |= STMMAC_FLAG_DISABLE_FORCE_1000;
> +

This should be in the patch
[PATCH net-next v8 06/11] net: stmmac: dwmac-loongson: Add GNET support

>  	return 0;
>  }
>  
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> index 42d27b97dd1d..31068fbc23c9 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> @@ -422,6 +422,12 @@ stmmac_ethtool_set_link_ksettings(struct net_device *dev,
>  		return 0;
>  	}
>  

> +	if (FIELD_GET(STMMAC_FLAG_DISABLE_FORCE_1000, priv->plat->flags)) {

FIELD_GET()?

> +		if (cmd->base.speed == SPEED_1000 &&
> +		    cmd->base.autoneg != AUTONEG_ENABLE)
> +			return -EOPNOTSUPP;
> +	}
> +
>  	return phylink_ethtool_ksettings_set(priv->phylink, cmd);
>  }
>  
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index dee5ad6e48c5..2810361e4048 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -221,6 +221,7 @@ struct dwmac4_addrs {
>  #define STMMAC_FLAG_RX_CLK_RUNS_IN_LPI		BIT(10)
>  #define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING	BIT(11)
>  #define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY	BIT(12)
> +#define STMMAC_FLAG_DISABLE_FORCE_1000	BIT(13)

Detach the change introducing the STMMAC_FLAG_DISABLE_FORCE_1000 flag
into a separate patch a place it before
[PATCH net-next v8 06/11] net: stmmac: dwmac-loongson: Add GNET support
as a pre-requisite/preparation patch.
Don't forget a _detailed_ description of why it's necessary, what is
wrong with GNET so 1G speed doesn't work without AN.

-Serge(y)

>  
>  struct plat_stmmacenet_data {
>  	int bus_id;
> -- 
> 2.31.4
> 

