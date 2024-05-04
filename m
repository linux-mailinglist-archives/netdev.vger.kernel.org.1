Return-Path: <netdev+bounces-93459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F5F8BBEB2
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 00:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5627B2142C
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 22:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC6584D3E;
	Sat,  4 May 2024 22:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F37v3ZOu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F4684D25
	for <netdev@vger.kernel.org>; Sat,  4 May 2024 22:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714860833; cv=none; b=PyDnu6aAWjmFOLQ+l2pXsXxbg2u8wVPla350ALUCQWus7Htk+UxHHle9TE0wpyR6A+fRKICIMSbM74to7Vfkss6eJnFPZsTsjN0FSPocNf+o5nGQGP8ffOdaOrclrFHttsM1PxSOLwNZlU9ssOgd39BgAVEOt8keJ0lHTLBsISQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714860833; c=relaxed/simple;
	bh=Y1ArtbMyVcsjLl9Ba/Rk+dooPPyCpbIjkDWdsgkYrmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwAvNoPMf824CEbBpND72hr41LkVLjSElQG2plLDnt/hxO1F0o5/MvKecEGEcd5OdJOEgvMJ18Vu5kjp23RdkT/0y0Tjb+FVOcxDmhQNYUinUTMuKfERNgmUUkHyo9jPeL4vWBc/sAFFCMxuD0mS5CK5frUnTDl53wQGWh+5YNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F37v3ZOu; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2db7c6b5598so10048251fa.1
        for <netdev@vger.kernel.org>; Sat, 04 May 2024 15:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714860830; x=1715465630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oBLChz7jG5XRwm2uizwTWjT9+aKUa7d8YJ7XzwMJHXU=;
        b=F37v3ZOu7cBfflTiqfa0agXOtEE/Psx31CFc0gTbTLbZs+hLRaHfkUkSfjbonskGk7
         8/YIY1fxbbHLqDeHEjI8INwmW37cWrBCFaFV1RDEuZZlxEWyT0grjKIyqihO9qxHqGV7
         /4oTXU6M2cqokHx6S37N3wQc1cPoahCSHY0REc4TUwA95li5hIE6Fa7eH+LmiAuGii/i
         tMWhjn7JQ6N/2Z0FVsNggjOcvrYHuTyi9g84G1CSBDz67hjkaIJSD613RMd5iIuUgNmN
         D3pbIxKBYC8li8Yw+0vq0ZKHd7aNuRmssnDPj2+Jf1mDO0xbJTZC28ShHztxNKWtNp5/
         y4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714860830; x=1715465630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBLChz7jG5XRwm2uizwTWjT9+aKUa7d8YJ7XzwMJHXU=;
        b=RcZIQr8d3qecQRPgYJJrMSZI8F3anyNRzBybGRTvCNwm3L4WZaBKxoGinbftYo3CRh
         iFdI1m0Tb8e2LB03nwEhHzBFWUiqUkvA1JyeJ6nXDPQqOSniZAxJIbqEtQcEe5iRrBk9
         GC7PhQmpKEUbIwJ22CMGOKNgliqHEk+mZ/w0aOtNKd2fQ6NLl9eRu0QJ7dVoLZsQlHAA
         xfWcBVcw6PTDsp9hGb6bBApww9OBEwdJDAFXt3LyRjnQ5D2L8InQoeM/A97/T9X0WlRj
         Pgu6N8YKP23Qo8qNMPlfXcDf2PbH0Q2OxTjUHP50ANx+BgCWfrZ0jLPxPNXyKAuUzkeG
         ZrQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiGdpnZyAMqyjD6Exvv6FdbGHbGrwxsjDLY6Im6xz3kGY9HGkRnhXkAVpZ0zAOf33Pr7bnDdwUOP2x/hX59D4KuPe2CmWE
X-Gm-Message-State: AOJu0YxVxX+v39pKEzd4L6Wf+T3W60fogguXOHQVQfyHgqFX546dTRwK
	rfgB2ap4gDJd1buWLll0u/qpTXjNgg3T7flwCQK7sSujLMZ38PEu
X-Google-Smtp-Source: AGHT+IGBwr/VBvKIo/Q458P4HADfXUmHnmRB9C35/30VtZMWjYNiVnmNSDakVbSRibqC3fYscAsJ8w==
X-Received: by 2002:a19:8c1a:0:b0:51f:fcaf:e932 with SMTP id o26-20020a198c1a000000b0051ffcafe932mr1511848lfd.17.1714860829707;
        Sat, 04 May 2024 15:13:49 -0700 (PDT)
Received: from mobilestation ([95.79.182.53])
        by smtp.gmail.com with ESMTPSA id s9-20020a19ad49000000b0051ab68bbb63sm1009960lfd.56.2024.05.04.15.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 15:13:49 -0700 (PDT)
Date: Sun, 5 May 2024 01:13:47 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
Subject: Re: [PATCH net-next v12 12/15] net: stmmac: dwmac-loongson: Fixed
 failure to set network speed to 1000.
Message-ID: <2pxumw5ctsnvr2mzqxnj7lvlzttxtokmzhwvswmq7ujigatdsz@mcfh5tlte3cl>
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <9b9f8ddd1e3ac9e05fa0d15585e172a4965f675f.1714046812.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b9f8ddd1e3ac9e05fa0d15585e172a4965f675f.1714046812.git.siyanteng@loongson.cn>

On Thu, Apr 25, 2024 at 09:10:37PM +0800, Yanteng Si wrote:
> GNET devices with dev revision 0x00 do not support manually
> setting the speed to 1000.
> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 8 ++++++++
>  drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 6 ++++++
>  include/linux/stmmac.h                               | 1 +
>  3 files changed, 15 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index df5899bec91a..a16bba389417 100644


> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -10,6 +10,7 @@
>  #include "stmmac.h"
>  
>  #define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
> +#define PCI_DEVICE_ID_LOONGSON_GNET	0x7a13
>  
>  struct stmmac_pci_info {
>  	int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
> @@ -179,6 +180,13 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  
>  	ret = loongson_dwmac_config_legacy(pdev, plat, &res, np);
>  
> +	/* GNET devices with dev revision 0x00 do not support manually
> +	 * setting the speed to 1000.
> +	 */
> +	if (pdev->device == PCI_DEVICE_ID_LOONGSON_GNET &&
> +	    pdev->revision == 0x00)
> +		plat->flags |= STMMAC_FLAG_DISABLE_FORCE_1000;
> +

That's why it's important to wait for the discussions being finished.
If you waited for some time I would have told you that the only part
what was required to move to the separate patch was the changes in the
files:
drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
include/linux/stmmac.h

So please move the changes above to the patch
[PATCH net-next v12 13/15] net: stmmac: dwmac-loongson: Add Loongson GNET support
* with the flag setup being done in the loongson_gnet_data() method.

Thus you'll be able to drop the patch 14
[PATCH net-next v12 14/15] net: stmmac: dwmac-loongson: Move disable_force flag to _gnet_date

-Serge(y)


>  	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
>  	if (ret)
>  		goto err_disable_msi;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> index 542e2633a6f5..eb4b3eaf9e17 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> @@ -422,6 +422,12 @@ stmmac_ethtool_set_link_ksettings(struct net_device *dev,
>  		return 0;
>  	}
>  
> +	if (priv->plat->flags & STMMAC_FLAG_DISABLE_FORCE_1000) {
> +		if (cmd->base.speed == SPEED_1000 &&
> +		    cmd->base.autoneg != AUTONEG_ENABLE)
> +			return -EOPNOTSUPP;
> +	}
> +
>  	return phylink_ethtool_ksettings_set(priv->phylink, cmd);
>  }
>  
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index 1b54b84a6785..c5d3d0ddb6f8 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -223,6 +223,7 @@ struct dwmac4_addrs {
>  #define STMMAC_FLAG_RX_CLK_RUNS_IN_LPI		BIT(10)
>  #define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING	BIT(11)
>  #define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY	BIT(12)
> +#define STMMAC_FLAG_DISABLE_FORCE_1000		BIT(13)
>  
>  struct plat_stmmacenet_data {
>  	int bus_id;
> -- 
> 2.31.4
> 
> 

