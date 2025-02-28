Return-Path: <netdev+bounces-170543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A78A48EE8
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 03:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACD6B7A3111
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 02:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B006814B08C;
	Fri, 28 Feb 2025 02:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1YaC28S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430A223CB
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 02:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740711156; cv=none; b=VTDXiRvIrIMJ9R9FX4F1AIGI7XWxwIb2KPp1heRrbhmH1k7OHgFzba43IZkuL/YVkENzs4RFzOXvQd7bl3Iq2J/9bcd6piwR+L/oVLKcEgNTIsrgfZDeL7kgGZ0G2jDB33p9wljyBSk2563Fr0rWeiFY/RWRXI1fmBrZF2FmAxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740711156; c=relaxed/simple;
	bh=HLswj2imkfSqjWS0lCz61RKcuhcAzSII9ta1QustFyk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sLcvCSmmKIe5moqSgi2HF/VRrX/m5HCO55QzFO3gutyzuFHx5MXGJmXF8XwDeyGljvsp7KMIEtFBbIf3Y09fI1/yordFWlq3QqADFe5efmP4lbRol1gOE7sZZiZrHvBE4I9ARHRKkvEV0v7W81L1GIO0OmcSI9Hyzm/L83tmsI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1YaC28S; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22113560c57so31937655ad.2
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 18:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740711154; x=1741315954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYQdPVJK9ENC+FmWjq1SRLNqpphJKsZVKqKTbvYauzA=;
        b=i1YaC28SKNFYhaz8Q7m9W7Za1nURVuHD7+IxxDpfT8mzE3AFpuaPBSIap1eAUJuCgy
         mJb0o0zuoUbbPDfkdfoPPXQ+8Ka3XfpRPTsxAHbQngdpd464MyvLVrLG43WNWA8P6EAe
         mTtiAcKDYoL7kkQxmhCUG7pjlfgddDr+lxhUUNWGiX6ZrGox/STmILyg05bFLF0QIggn
         w5/hFnkFxLlWdXPfYYKbXv+tuJ7Sg2/OcCcPI6UtipkInRUpN7f3+rH64PnvxIM/uaH/
         zjyhs55Rfsy6nFTs47XQd9+yyjbyC3xVAkuRaMTTKgQcTmiWpi3nKkOg697rnD1uee5R
         3bzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740711154; x=1741315954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zYQdPVJK9ENC+FmWjq1SRLNqpphJKsZVKqKTbvYauzA=;
        b=JiiBReI88VGlF28TZqz+B+zkD/Zidq7dzhu0rX6teMTyDIMP/rI1uULFmCmoMTowrG
         5E4008NWtt2Og1eoVEaC3Zw8hIziOTL+VcpppALGSBjtPbBwjsneaJ75h+sQEDShABEy
         F9ylUESUh14U19y5N3sIyhC2Ap7wNnPyeeNJzUBHw7WrrzADjjMis1q3jks28aKtfavG
         h3I2uhRVEF8OfqYoF5ZHBSl0LmTTkn/n42EbK/rPXbnTf2TpyT7sPl3VYe2svWz8h+Ya
         IkQsy72YKStixzfnlbUym65ogJxoCTsCkwr+DfFOmndek9ZtRxxkgt0Ic+mHGT/adt8q
         GmMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7NzXr5pqrPb7fnG/ENjS8hX1CiHS1YPtdO7bK1q3C4UEeYU/GxADFMgM+kntiQY/tGYnbM1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUabBEYa49ISTlT1WoBKz5tY1rze3YakXsJPZDHdJHSDKYKPyl
	Y3wQ+IfXZ/gCOnv33jx79DYD+9rwJQPvGfO9+Oms0Y1CWoHj/evA
X-Gm-Gg: ASbGncvYpxT8ODvFQrJ104e6/tOksLuWQBTJAZsn22PlgEY065u92hiuMwn/fACs3n/
	Nvg1qklSXAys8HVroxvqB8sdMQheH2E8X5WhdzNxUj56II+WI1w3E16VsXwCOQj/ps3f+/1MYgR
	1HIY4sIehzE/EzlXx7oM6wA7owDfrvpHyH+y64yNJC1J1M3XUNHw05SkbMXCjFlP9MyPk6Y8tZ8
	Pj55He9qu8fyII1bb7JrX+FzQY/xI7FxBMl5dYg6F+xMWuYPCh+tBSW35lqpllVm2lXvehz39A6
	kuSsQR2RjBXsoIHUNffp1j8=
X-Google-Smtp-Source: AGHT+IHaqgolZnBHpg/hTDrE86Pp13wwGc6p6xtFrspmuVKyv7VoeiQOT/3UPkYXRlSlielhuf1AKw==
X-Received: by 2002:a17:902:e54e:b0:215:9642:4d7a with SMTP id d9443c01a7336-22368bd1f52mr28089615ad.0.1740711154400;
        Thu, 27 Feb 2025 18:52:34 -0800 (PST)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d279csm23221655ad.44.2025.02.27.18.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 18:52:34 -0800 (PST)
Date: Fri, 28 Feb 2025 10:52:25 +0800
From: Furong Xu <0x1207@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jon Hunter
 <jonathanh@nvidia.com>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH RFC net-next 5/5] net: stmmac: leave enabling RE and TE
 to stmmac_mac_link_up()
Message-ID: <20250228105225.000015f5@gmail.com>
In-Reply-To: <E1tnfRy-0057SX-Lj@rmk-PC.armlinux.org.uk>
References: <Z8B-DPGhuibIjiA7@shell.armlinux.org.uk>
	<E1tnfRy-0057SX-Lj@rmk-PC.armlinux.org.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 15:05:22 +0000
"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:

> We only need to enable the MAC receiver and transmiter only when the
> link has come up.
> 
> With commit "net: stmmac: move phylink_resume() after resume setup
> is complete" we move the race between stmmac_mac_link_up() and
> stmmac_hw_setup(), ensuring that stmmac_mac_link_up() happens
> afterwards. This patch is a pre-requisit of this change.
> 
> Remove the unnecessary call to stmmac_mac_set(, true) in
> stmmac_hw_setup().
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index e47b702fb9f9..c80952349eb7 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -3506,9 +3506,6 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
>  		priv->hw->rx_csum = 0;
>  	}
>  
> -	/* Enable the MAC Rx/Tx */
> -	stmmac_mac_set(priv, priv->ioaddr, true);
> -
>  	/* Set the HW DMA mode and the COE */
>  	stmmac_dma_operation_mode(priv);
>  

Tested-by: Furong Xu <0x1207@gmail.com>

