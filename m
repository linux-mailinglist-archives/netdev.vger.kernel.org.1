Return-Path: <netdev+bounces-170541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5041A48EE2
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 03:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF1BA16CBDE
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 02:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C68013665A;
	Fri, 28 Feb 2025 02:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/uYqzsm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98961224D6
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 02:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740711090; cv=none; b=hhh+1zsBF6WqRNc6mnKV8gFxN4i5soW4yG+/+632OnW0UY4ezKnFdobCS6u2e0nOjmRqP+vQtFW+3u2/DQoBYunSlQtaLyajNKzYrDRUG/mYPcdGWZYbBvPFVYx+L7i3c9IMDua9kdX841HevUF6awG83HKVykT2trFFPquTlnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740711090; c=relaxed/simple;
	bh=DdQjQjdMdCs7Msrb2W9TKdcK/ITMhmokuMzAUuB8Pbg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e9x+8Zh2DP8YcMpy1FHdh9M05df/pFbxWbPB3zYq+RLr01heRC2VQGB9RFYwFJLRuxSulnIYerMk/XBDv52wstwlIPO1ZIVXQ8uKg5PanQuKNyzlY4JTj5DAsOYF7yVLwWDOyJmBjxSprJQ4KEDYpua3Hy/aTenITZjePBNr6xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/uYqzsm; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22356471820so24108675ad.0
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 18:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740711088; x=1741315888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxfrttinpfziJbmXgIfvT4LSMdxWcEB9U28aIsi8kko=;
        b=l/uYqzsmtAh1qAXNerwg5S7MoFrVuEi65+eHCayz1s/0zMEWyEJ0COy9FWxJJkY4ph
         QuFZ+MSf9lPAQABeiWmaRcVfzJdbVBxbbUKtOnOf5A4UsDSi/H/Ds4x0vzGYTjw9CDr/
         jmRGQ6tT8cBsAQWdbuNeLHRk9zSDNDQLLKrscOQHaZoz0hBD2Ip8M3wPQLbpOKdzTKRJ
         MpePeMTJ3mVLTLU+yiLdiNgOzob1K2v0P7K9rZQQgdWIfEfZIdax1njgdab+yFKysL2u
         KcZQFEl42O/ydWNA1xDpB9XB5G7tic6tVNr3+JUVjcyWTOYlQFKEX8bSoipFZikHqqCt
         xSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740711088; x=1741315888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxfrttinpfziJbmXgIfvT4LSMdxWcEB9U28aIsi8kko=;
        b=BC/CclerI3iSm2eknpMwAs78XloNZXA4s2TCQYv+7a56OcisF7oO07bdfgYGL5aOrJ
         FXLtuS7zTxGJq/cHlXZYv2HqQshu4DTxKgQavN6CPisPRx7T8ouH5TzXmAk+OfYKsKi7
         y61Z3LI4mO6gQfxgwE6nhAhg/cnsJJZ2eCgOX9Xg/Q6PFUqnfh6yMHDVLXyNKbVe/MnH
         9scYqyjK4qz1wrlxp1EZZ1IqDGMUrjg4cJ9vLzRydkdDnPKwU6l5x51m/RDOkRVFlGbT
         WniyAws+bgQaot+o+iBbUBd+pVtKmpzxvmtiv/NaxxDSBbRrW3e8WbQvoIRmwCeDBQEL
         DFAA==
X-Forwarded-Encrypted: i=1; AJvYcCXdwmsEk6lbm52sV0x68RRUS+sNXFvK0/gt4V8A2dGX93T4gnSxRElcQU5izahUmsatkuftQ6A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyybn+bhBVqLL9vDMP7o+duvZ25QsWycN2/EJEVKal0u4HCbxDr
	caL0gTDtW5lwF7r7socBF3MaiP1Sc2Uheil+L+2SF7Yzt8faFxLm
X-Gm-Gg: ASbGnctKEMEAl/jeHNJZl9X6WtJRy9heSL/MNZqd3UY9dzQqKCyQe6xvnsEsqpUVV1j
	4pMKc7jG7tP3BokYKxQJ7IH6iNWHminq0DrtffRtdHtt816VlyY2/Lfx9ALfOiF/P3q3toqmaD/
	sEnGRqhfV2Ypx6zzLO6j5upXjT+31aW4ykhXNMuK5mhHarm0vtyfRuzAF+8HC0EHRdrOq2GdluV
	pTkw/ExZ1Bdl4E+EGNIdvj1V2gTMPwp7HY3hZkVDYIFpmCiwDfhoAh4/OPvNIAlXZIlBXxUP9eR
	F8PXwRAnyF1KD3w0YTPRnl0=
X-Google-Smtp-Source: AGHT+IEKF5Ov9wR3zxBGu/lY9K2QndPcV7vnjEoWJ66hnW/s1gKFCPCGJh1hzPM3pWau6kekz6Qo7Q==
X-Received: by 2002:a17:902:d506:b0:216:3466:7414 with SMTP id d9443c01a7336-2236926a542mr23196615ad.44.1740711087768;
        Thu, 27 Feb 2025 18:51:27 -0800 (PST)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d3e63sm22964315ad.11.2025.02.27.18.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 18:51:27 -0800 (PST)
Date: Fri, 28 Feb 2025 10:51:18 +0800
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
Subject: Re: [PATCH RFC net-next 3/5] net: stmmac: remove unnecessary
 stmmac_mac_set() in stmmac_release()
Message-ID: <20250228105118.00002723@gmail.com>
In-Reply-To: <E1tnfRo-0057SL-Dz@rmk-PC.armlinux.org.uk>
References: <Z8B-DPGhuibIjiA7@shell.armlinux.org.uk>
	<E1tnfRo-0057SL-Dz@rmk-PC.armlinux.org.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 15:05:12 +0000
"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:

> stmmac_release() calls phylink_stop() and then goes on to call
> stmmac_mac_set(, false). However, phylink_stop() will call
> stmmac_mac_link_down() before returning, which will do this work.
> Remove this unnecessary call.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 9462d05c40c8..e47b702fb9f9 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4120,9 +4120,6 @@ static int stmmac_release(struct net_device *dev)
>  	/* Release and free the Rx/Tx resources */
>  	free_dma_desc_resources(priv, &priv->dma_conf);
>  
> -	/* Disable the MAC Rx/Tx */
> -	stmmac_mac_set(priv, priv->ioaddr, false);
> -
>  	/* Powerdown Serdes if there is */
>  	if (priv->plat->serdes_powerdown)
>  		priv->plat->serdes_powerdown(dev, priv->plat->bsp_priv);

Tested-by: Furong Xu <0x1207@gmail.com>

