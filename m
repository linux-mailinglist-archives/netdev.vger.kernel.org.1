Return-Path: <netdev+bounces-103680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3B4909096
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 18:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3F761C21FEB
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 16:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E3217C20F;
	Fri, 14 Jun 2024 16:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJz24jXv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D8117E47D
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718383127; cv=none; b=OthZ6ngo0gW4xMzOBBnmkKT1GlrRcn2tbpfrEDd8h2fclItg1dB9EjQWnTGpdJ7JuQ2Br0uoWXas1sAq5YuQuRPMJ/dm7xIrayGmru/EIr2qiCFlBIJ7ZbRCldRe4vQafbMC/+3EnmD6vZUyomvqCxG2MUiDX/OI26eIbBkdRSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718383127; c=relaxed/simple;
	bh=Ah8f6Ea8/hUzL0s7hIbhNRJcbHsy8r7JxrSH9vl4rxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVfXxMDKwxTCn2S5iAj93N7f4SlQ3fyYs0SFF02HlgS7xVYBN9pr9P0okjtrtnMxVLz6f8qkxbytWyZuA9fLCgwiezLdudShv7g9wmMbL4e1yWKB5W6ibotE5LoQqSeE5+J49JVU49YT6QjWN0cDAdlr3BfPAl5czdKTqcYQ9n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJz24jXv; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-795502843ccso134603385a.1
        for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 09:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718383125; x=1718987925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1VgYK0cT1rtZcE4zC+Ip3HzrpvWS7pmA+aGN6P6P8vs=;
        b=cJz24jXv4XoTE9QEEmQ1zJX+IM7klw58fr2ZdLCQTIWdXOd2GE4DM+W4VKGWxbcEea
         tSrnp78HzeCkS/Zu5IrrhE9/PXGGFbcVMJH2mEQ2gWTsj61jRoEW+AXV1j8x5fkS/uBe
         jz3uP+zDh5J2IXs8ps3KNk767slvTL7fddZuk+mRK+qgEv/zERxqks3Mo95TEKSan5El
         imgj8x5TTgnWclnxT34mjHKSCdj5/mPRlzxI7OFmbxlq+oVTfscKJUSlFHLbeSuyE3p3
         /K8gSZcixiYWMxIdXAPAp4zGkCjN15fV1Tld9Lxus+BAbeGsPlA0HyUsjANr1eOBzGx5
         QoeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718383125; x=1718987925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VgYK0cT1rtZcE4zC+Ip3HzrpvWS7pmA+aGN6P6P8vs=;
        b=QkYUOdO9jzrpK6FVFrwq/Xig88vfiTGdstWPxUTrxAe6y/UTNCSLNrZ4zCJJy7jWDf
         yIs4Gc39YnqzzQHo9fsZb9HhZkL7i9nRAA2nfd667JhWpqbozzYwilIW4BfhrII6KeNV
         7Ej/YbzXxjjtr86fILdum1ZIX3zhYCIS6n1GW2tlz/qWV1pQU/naOv6giLfZtYaQDuQ1
         j/sylL1E4m1xWBuN6lQhtOI2x3yDd8QfA9jW26CNPK9BMr+ubL6P13jdVK9NZc5pvTrE
         3yaSXinrQobV9asB7I6S04s6E//eDhmpibskqvI5elkSgl80QnNyK3+zAHZGp0hx6Atx
         vUmA==
X-Forwarded-Encrypted: i=1; AJvYcCWjBIXf777WYEYAGybdyefp8V7ykqp9rNgsSTDKFAqRNUSbbRRaLTrSArmsH2SVKEQyBxwkmpO6Q1Xy7bMdnDOeK5EOGVbZ
X-Gm-Message-State: AOJu0YwsORuhdTGywuA/K/Q4ddni+vGV1NF3FfLgkkj4BeAZpG/n/qFn
	E5jgRe8VI6YuLPaddoqpSWax76rhUDz4L/KUh4aJXsL6oeyTDYxk
X-Google-Smtp-Source: AGHT+IHqafr3Vnf+TWfjTdXJN6lGKMwNFYAnGXAKuDMdyJd/+pk6bm9GyX5kxb6EN7JL13WGpSePbg==
X-Received: by 2002:a05:6214:8e5:b0:6b0:63ab:b7ba with SMTP id 6a1803df08f44-6b2afc936f5mr27299926d6.15.1718383125075;
        Fri, 14 Jun 2024 09:38:45 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5efc4c1sm19901876d6.127.2024.06.14.09.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 09:38:44 -0700 (PDT)
Date: Fri, 14 Jun 2024 19:38:40 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Andrew Halaney <ahalaney@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jose Abreu <joabreu@synopsys.com>, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Romain Gantois <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next v2 1/5] net: stmmac: add select_pcs() platform
 method
Message-ID: <2xl2icmnhym4pzikivo6wqeyqny6ewrbqlfvsxrisykztdcaip@mp54uqtmrgyf>
References: <ZmrLbdwv6ALoy+gs@shell.armlinux.org.uk>
 <E1sHhoM-00Fesu-8E@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1sHhoM-00Fesu-8E@rmk-PC.armlinux.org.uk>

Hi Russell

On Thu, Jun 13, 2024 at 11:36:06AM +0100, Russell King (Oracle) wrote:
> Allow platform drivers to provide their logic to select an appropriate
> PCS.
> 
> Tested-by: Romain Gantois <romain.gantois@bootlin.com>
> Reviewed-by: Romain Gantois <romain.gantois@bootlin.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 +++++++
>  include/linux/stmmac.h                            | 4 +++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index bbedf2a8c60f..302aa4080de3 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -949,6 +949,13 @@ static struct phylink_pcs *stmmac_mac_select_pcs(struct phylink_config *config,
>  						 phy_interface_t interface)
>  {
>  	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
> +	struct phylink_pcs *pcs;
> +
> +	if (priv->plat->select_pcs) {
> +		pcs = priv->plat->select_pcs(priv, interface);
> +		if (!IS_ERR(pcs))
> +			return pcs;
> +	}
>  
>  	if (priv->hw->xpcs)
>  		return &priv->hw->xpcs->pcs;
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index 8f0f156d50d3..9c54f82901a1 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -13,7 +13,7 @@
>  #define __STMMAC_PLATFORM_DATA
>  
>  #include <linux/platform_device.h>
> -#include <linux/phy.h>
> +#include <linux/phylink.h>
>  
>  #define MTL_MAX_RX_QUEUES	8
>  #define MTL_MAX_TX_QUEUES	8
> @@ -271,6 +271,8 @@ struct plat_stmmacenet_data {
>  	void (*dump_debug_regs)(void *priv);

>  	int (*pcs_init)(struct stmmac_priv *priv);
>  	void (*pcs_exit)(struct stmmac_priv *priv);
> +	struct phylink_pcs *(*select_pcs)(struct stmmac_priv *priv,
> +					  phy_interface_t interface);

Just a small note/nitpick. We've got pcs_init() and pcs_exit()
callbacks. Both of them have the pcs_ prefix followed by the action
verb. What about using the same notation for the PCS-select method,
using the plat_stmmacenet_data::pcs_select() callback-name instead?

-Serge(y)

>  	void *bsp_priv;
>  	struct clk *stmmac_clk;
>  	struct clk *pclk;
> -- 
> 2.30.2
> 

