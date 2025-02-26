Return-Path: <netdev+bounces-169672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0143A45345
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 03:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7E1169CD5
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 02:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0215F21CC60;
	Wed, 26 Feb 2025 02:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZS0tauxt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7F621C9ED
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 02:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740537823; cv=none; b=MPzzdzDOIeyICgmqMq936VkqKQu79/1pgHm3qe+SA29OjHPTI7Dre304EOGAoJNSk9Fh6y8mxIaFrlTOc5WQz1rbCFjjPi3HrIE2Xd2entg/YmcmzDMeZflxcQa4aqX3ghf563BWwLgkx9uEmjWQqzMYpNGgVaPtNEC6njrA3rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740537823; c=relaxed/simple;
	bh=+QWYbR1IEqUHxYtc6gkd4YrIaQZcWJeKBo2yzavBrTU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u14A1WkZhuohMoXSnYXo5bNMKDMEFR2s7nrB+u+0TRc6z6iPFGswjbCT3ycEgn9VZbZHc8XSQMwgSL2Na46zfWqdHxWJMAD1jEmhHdqx3OoDAoot38g4sZTuLYrSrfypjvdasRyF6pvsLkT6KDBjRY7AE8zx8qjc11g5bNCWNdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZS0tauxt; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fc0bd358ccso12446474a91.2
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 18:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740537820; x=1741142620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09wSZxKgriakTOPJO9UMgX94JkvJeeXEmpJoFk0WInU=;
        b=ZS0tauxtvsMybNG2NS6PURJMMuIctBGDsCkEOmce4DYxeEK6SYFD1r3Y+J5CTkDjdL
         D4iRwdvjfv18ZyX0eXxxIyr2cgTUWP4LrCAHH0XY2BL0/5psKsN/NFIkt45f4pkyZ3PY
         sjmpeJfg1MUKmyqQgssaQOMZ230G97YacHtizoemPo1BUCsxaOa2NVvCqvWj0xxND2Pm
         DmnwJ99H+RhteRy0Agj+xL9M+YT/hZF8FMEhAgNf28wvGnbBl+yOmtY+Ce4zCrAr5lCZ
         72xqy5GT6BYItR00g92aOXJ+jIdvTIrmWnRLgkxMJiYdlNimHDyPG433Qwk6rTQCwKfV
         g7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740537820; x=1741142620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09wSZxKgriakTOPJO9UMgX94JkvJeeXEmpJoFk0WInU=;
        b=indUA1tIKBVD9fmxbYZ5XnGLmFiemTxuQ/G476rkw8r6EfNeBC9x/JjxUc6gltYs3L
         BrWZKGfNkzv+Px77vHpKX5hopcIxLbJsaJIIpLdy63CHQnR22Sq6+7qaPwW55wDDRT5B
         3GYgpE7jKWFXnL/TuLHPxKgKe9jLIUeU3gzLbHCb5PRhEhEaFoqUrePtg/CS5W61BxnN
         SRhZeV9ROtjKl+Ck1vcs3IR2wOdFso01VcIInC24aKTCnwGeSFyxCe077O0KcHXNFDUz
         b5idk37S4I1w1yRx3FM35gqqY5fiXijoksbwnNQJxs2uapiIZtj0yOueGc3Iiq++G3JH
         TMCw==
X-Forwarded-Encrypted: i=1; AJvYcCVWMoajTaClBx4GaYPwGrlE+kLx6B8X6e8ssh0jLSuAttDwZ4OvWaJRbQFT2Q3anUIF2TeQTKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl3hRx48vEUpkBBFaOxYI5eOTgBH6gjSlXswaVN0zpnvknQrLM
	PAQVlQMz3S3qvxRHf3/QF3wCt+Euy0Vx2BwthPeSzBEqBU+olEve
X-Gm-Gg: ASbGncvcA493CtYnfkPF5l9jamhLmp56uSDpQ+IlOj2vIQQ3Q6VAHQ0N9SscOJV20ZZ
	QIpomn2dIIXCtIIsjXOFn5yMwtZ+0W9rp7UIShZqxKlWrD/63khRXVs83KwV9U2FdIJxRywJePb
	ZyeNeOalCTizpIU6RT3vRAEgz/cF+WvO6zM3CKgh1VhGrbSiZesFsOf7cHTBU4sd8gRJWWlnTpD
	vsZcmW0nyE7YuOEMwPp8EWfsOz59U/tZ+fEPVK9EHxrc8UgOCKUGKsjNR6WvZCj6pqk1ZzwXOaa
	WqWfmTEDAphZ3qHe5eFW4+Q=
X-Google-Smtp-Source: AGHT+IHqWiTmKahLoNDEtQkn8Ysj7aO7VlP6FoYVWXaVQHY/r9/BHTTRDx4CPzCNopfHUXBmu0dRbg==
X-Received: by 2002:a17:90b:53c3:b0:2ee:f687:6acb with SMTP id 98e67ed59e1d1-2fe68adedc1mr8899627a91.13.1740537820375;
        Tue, 25 Feb 2025 18:43:40 -0800 (PST)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe825d2b85sm326939a91.26.2025.02.25.18.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 18:43:40 -0800 (PST)
Date: Wed, 26 Feb 2025 10:43:26 +0800
From: Furong Xu <0x1207@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Emil
 Renner Berthing <kernel@esmil.dk>, Eric Dumazet <edumazet@google.com>,
 Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev, Inochi Amaoto
 <inochiama@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Jan Petrous
 <jan.petrous@oss.nxp.com>, Jon Hunter <jonathanh@nvidia.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Minda Chen <minda.chen@starfivetech.com>,
 netdev@vger.kernel.org, NXP S32 Linux Team <s32@nxp.com>, Paolo Abeni
 <pabeni@redhat.com>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Thierry Reding <treding@nvidia.com>, hailong.fan@siengine.com,
 2694439648@qq.com
Subject: Re: net: stmmac: weirdness in stmmac_hw_setup()
Message-ID: <20250226104326.0000766e@gmail.com>
In-Reply-To: <Z7dVp7_InAHe0q_y@shell.armlinux.org.uk>
References: <Z7dVp7_InAHe0q_y@shell.armlinux.org.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 16:17:43 +0000, "Russell King (Oracle)" wrote:

> While looking through the stmmac driver, I've come across some
> weirdness in stmmac_hw_setup() which looks completely barmy to me.
> 
> It seems that it follows the initialisation suggested by Synopsys
> (as best I can determine from the iMX8MP documentation), even going
> as far as to *enable* transmit and receive *before* the network
> device has been administratively brought up. stmmac_hw_setup() does
> this:
> 
>         /* Enable the MAC Rx/Tx */
>         stmmac_mac_set(priv, priv->ioaddr, true);
> 
> which sets the TE and RE bits in the MAC configuration register.
> 
> This means that if the network link is active, packets will start
> to be received and will be placed into the receive descriptors.
> 
> We won't transmit anything because we won't be placing packets in
> the transmit descriptors to be transmitted.
> 
> However, this in stmmac_hw_setup() is just wrong. Can it be deleted
> as per the below?
> Tested-by: Thierry Reding <treding@nvidia.com>
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index c2913f003fe6..d6e492f523f5 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -3493,9 +3493,6 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
>  		priv->hw->rx_csum = 0;
>  	}
>  
> -	/* Enable the MAC Rx/Tx */
> -	stmmac_mac_set(priv, priv->ioaddr, true);
> -
>  	/* Set the HW DMA mode and the COE */
>  	stmmac_dma_operation_mode(priv);
>  

A better fix here:
https://lore.kernel.org/all/tencent_CCC29C4F562F2DEFE48289DB52F4D91BDE05@qq.com/

I can reproduce and confirm that patch works well.
I was going to leave a Tested-by: tag on that patch if everything looks good enough,
but the author (now copied) never come back.

