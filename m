Return-Path: <netdev+bounces-56364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D3580E98F
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 11:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EF641C20AEB
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 10:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B067A5CD11;
	Tue, 12 Dec 2023 10:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLImtWxI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D775BA0;
	Tue, 12 Dec 2023 02:59:29 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50bffb64178so6520251e87.2;
        Tue, 12 Dec 2023 02:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702378768; x=1702983568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UBACCwW/u1iAUGLoPTfmihwXKrVJVbnjXJdVbLxBVuc=;
        b=TLImtWxIKnyiWo1goY5pw6aJzjGur/5b98LF/msLof+FovWePPK8Ly+FTkqGsilDyk
         rYZ9G3tAAuaISfmw3fcA2zxI8MUlhm0RXkRWtGplCLdEkOFWBcinlf2zBgYr6T75HNcz
         GoAEEttWA8ah34s5fFD3e4HTg3OFZ6qypvQhmKF0x+8gXxQ4tf9+AIQ5VOGFYMq0OacT
         +LvULlZKmnrf6MQlMuTbriPeQuzjlV5EbL+xhTVwxueYoPknlHwvJ7PVK/D5yfGB+m21
         Yt9dpiFucVjkn+AJ0CFoWN+P9R8Li0fn/Rfk+/EeOGApEdYJ1NddLoYQKOoaHUwK9iVB
         gDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702378768; x=1702983568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBACCwW/u1iAUGLoPTfmihwXKrVJVbnjXJdVbLxBVuc=;
        b=myLu1xckwUWVhEHqfKsjvYqYuKk8NztlCCGLCgcnEDlQOCeBc476coTZYQWXZ2hYZd
         CKkqE74DJeBOMM7FnCU+GvNAKZzCtcI7WTheAtUsDRduYenLWcUqUIm+p7Frc8NE62vH
         o8oG8V6JLENcUpMzQdePNFufkPBxCJKanlpbyGOT0/jPeQToh6EVYieFbpzcdu2xml0j
         CNlX80Ilwecwi3+7W2iRQcwH7gyQFX2ot51mzJKsfwqiiwwJL6NdFZTG/TtUkmOkBkZi
         xwqaAvnUn+y7AucZV1lhHeuLhEXxr6NmzOsR0TAqEy7aceG/W6Ox/jCVzMHNXoxybrwJ
         eeHw==
X-Gm-Message-State: AOJu0YxkO94NprVSaRXx4e/dw44yWDu3aY25wblb28xnGG5iCuFubzFU
	OLYkk1dpvkpGqx0chteKYy0=
X-Google-Smtp-Source: AGHT+IFENj5x54Op3KLBMNmk1vpxHnMd7tYQWResL1rD1eJl9lh0gvrTRZQsB8pjxfiVQfYkjXFdgw==
X-Received: by 2002:a05:6512:6cb:b0:50d:12ea:cba0 with SMTP id u11-20020a05651206cb00b0050d12eacba0mr3566985lff.95.1702378767797;
        Tue, 12 Dec 2023 02:59:27 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id dx7-20020a0565122c0700b0050d12fa98fesm1289491lfb.300.2023.12.12.02.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 02:59:27 -0800 (PST)
Date: Tue, 12 Dec 2023 13:59:25 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: Handle disabled MDIO busses from
 devicetree
Message-ID: <ggbqvhdhgl6wmuewqtwtgud7ubx2ypmnb3p6p6w7cy37mnnyxn@2eqd63s2t5ii>
References: <20231211-b4-stmmac-handle-mdio-enodev-v1-1-73c20c44f8d6@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211-b4-stmmac-handle-mdio-enodev-v1-1-73c20c44f8d6@redhat.com>

On Mon, Dec 11, 2023 at 03:31:17PM -0600, Andrew Halaney wrote:
> Many hardware configurations have the MDIO bus disabled, and are instead
> using some other MDIO bus to talk to the MAC's phy.
> 
> of_mdiobus_register() returns -ENODEV in this case. Let's handle it
> gracefully instead of failing to probe the MAC.
> 
> Fixes: 47dd7a540b8a (net: add support for STMicroelectronics Ethernet controllers.")
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> index fa9e7e7040b9..a39be15d41a8 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> @@ -591,7 +591,13 @@ int stmmac_mdio_register(struct net_device *ndev)
>  	new_bus->parent = priv->device;
>  
>  	err = of_mdiobus_register(new_bus, mdio_node);
> -	if (err != 0) {
> +	if (err) {
> +		if (err == -ENODEV) {
> +			/* The bus is disabled in the devicetree, that's ok */
> +			mdiobus_free(new_bus);
> +			return 0;
> +		}
> +
>  		dev_err_probe(dev, err, "Cannot register the MDIO bus\n");
>  		goto bus_register_fail;
>  	}

This can be implemented a bit simpler, more maintainable and saving
one indentations level:

	err = of_mdiobus_register(new_bus, mdio_node);
	if (err == -ENODEV) {
		err = 0;
		dev_warn(dev, "MDIO bus is disabled\n");
		goto bus_register_fail;
	} else if (err) {
  		dev_err_probe(dev, err, "Cannot register the MDIO bus\n");
  		goto bus_register_fail;
	}

-Serge(y)

> 
> ---
> base-commit: bbd220ce4e29ed55ab079007cff0b550895258eb
> change-id: 20231211-b4-stmmac-handle-mdio-enodev-82168de68c6a
> 
> Best regards,
> -- 
> Andrew Halaney <ahalaney@redhat.com>
> 

