Return-Path: <netdev+bounces-170587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3FAA49237
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 08:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C03016C665
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 07:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFF91ABEC1;
	Fri, 28 Feb 2025 07:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8TD8hd9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6496870825
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 07:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740727899; cv=none; b=l9r+vAkOce0PdlmzjH+WBKMup5W1ga7sLQFstm2cNY4p9tAir7Hu7L3AypdHvmq7l8Ha/GHZFPgVhjLAN3NuX47NCGGFugqhLmknrEmyBhYRTycjBauOdxji6pwzfBIyFaN5NuORKxe57VoN35TgUvQfJ9SGRKdavaJsFhYhl0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740727899; c=relaxed/simple;
	bh=a+yZnMnQOi3TT4cgUbL3BVaBC8vqACxgWpdqMrUvyTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oRUuP/96HvxhBkeCaX3B+ZCuLprgQ+UqV/oUVxvffQ3VYzMu2oTGzw9/O0slTGEUplnSb0V/d2oit+Bn6DAyFLonQpeDPonDbD9IWdqfAYcA54T36kcPpcXAhuEqCvRVrf2IY1LSyEGYFoixZg1bsfLTZDWz/9ZQ7ecZ98s/qYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8TD8hd9; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2235c5818a3so33029125ad.1
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 23:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740727897; x=1741332697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEo5Ilj/CnKUxlNE5iH4oY22/g/iUpKFoP4fBLWqvpA=;
        b=i8TD8hd9A1GcvQCdMEIIDPMnrLJwKW75E+/vk6DSviRGgMcnUA5TI5WZUlwn+v5Nr0
         WGPHgBDVusr9NsiJzOz//fVXQQW0zeQYxKIjQMSCiCgAWXhV79ladkL2jyoerAQcXGSb
         NyJ/EoWdpqeubiSLwWgdmoKxLapd1LwljBrB5UBX3NYhRfpNKXiNcd77A//JEhbxBM9C
         QWhaFhuu3FMvjvbnRAmUFaksLiU3/Pj+uwZ4Uejbwg6RUD5xh/ZS6+qr4etJ0Op7xOHq
         JQbTNr082WCGyfeLIfG6l87aFzt2i1FAOC8ph4rQmNNl9QV3phAj7rLnJS4FLNZ7s07P
         M6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740727897; x=1741332697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OEo5Ilj/CnKUxlNE5iH4oY22/g/iUpKFoP4fBLWqvpA=;
        b=i34jRtetYg2LHAZopQYpJKJMm4SDhtEXA4DXvJwXjA5kqfoW/iubSXYmLv1YKeKDi5
         mzUQWcAAelxXe6+RYq4GSMgmt1/6s1TUb67tUwPcsTbDTgR9o54d+44AFfuhyxdjTyyM
         wTI3x1ehvHxt4ZxRUhwWuw03Q7dRsmisbDSBt+SH/VhNUzhXMdU77BmKu2qxK/sYLEJW
         1FcfH5gozeB04OF0OOjuBtyOxBy10K64JTGon7S7av5rSKrVqI6JG2qHBts9w6JgqTvn
         fV9I3wE5IwdDb4QcLv9Yu52fjaocl4NdOsZmTDYtSH7pu1TKwNDUWQMjPq6xQbhZWs4T
         FJ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVhwkJyYHZZBqtTyhqu/uDnfQ7fmeIDiQg2yynV8+bouOTOwoNovnf1gjh2rtllR69GkXwlvq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXxTtEs/ZHdl/b3acqfYsTebQMTW8y7NBtaxgxB9AOPDd/nxp+
	TG+eEYB089AW3ZG8pQ2wtNCPgH5lia6q/XovG2IEVn9JFN9s4KnM
X-Gm-Gg: ASbGncsCKDR+HofFfgDAXT3v+Az053N2B/6UVQJEVlCgyTzGvufNiSvXIdst3fLMHQL
	GQ1Sgj/uCypTTDlCOvt+igCbfgR7mcWpYEM0MvnsXhOdJ3OZ48Dfyi3ufS2dT9LmlvnN/1gsd3c
	ZDE+NsRE7b7ILut7Wamv2YxSpBqgtkLvuYC1MyW8wq90/L0bDkidMhIsBDxYKQe4PfvoVMPkA3l
	qjA+wL5kIk9zorBXyJJuTiVGSgwnx/KTFVhlcDDW5ReTU5aPR1HrtDrFqBkyQFl5KS3i1lWqfQ4
	q3/LOqmJOePW1kG3ZGIqc8s=
X-Google-Smtp-Source: AGHT+IFrEMfFeWVgVjwA/8gquLeiMkDUEwznolmMGr2Xy7GVL3JkNx1UIJph/S+ONtF7kGxuiKo4sQ==
X-Received: by 2002:a17:903:292:b0:21f:7e12:5642 with SMTP id d9443c01a7336-22368fbee43mr34263825ad.18.1740727897464;
        Thu, 27 Feb 2025 23:31:37 -0800 (PST)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe999a5a1dsm3795470a91.33.2025.02.27.23.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 23:31:37 -0800 (PST)
Date: Fri, 28 Feb 2025 15:31:22 +0800
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
Subject: Re: [PATCH RFC net-next 1/5] net: stmmac: call phylink_start() and
 phylink_stop() in XDP functions
Message-ID: <20250228153122.00007c75@gmail.com>
In-Reply-To: <E1tnfRe-0057S9-6W@rmk-PC.armlinux.org.uk>
References: <Z8B-DPGhuibIjiA7@shell.armlinux.org.uk>
	<E1tnfRe-0057S9-6W@rmk-PC.armlinux.org.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 15:05:02 +0000
"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:

> Phylink does not permit drivers to mess with the netif carrier, as
> this will de-synchronise phylink with the MAC driver. Moreover,
> setting and clearing the TE and RE bits via stmmac_mac_set() in this
> path is also wrong as the link may not be up.
> 
> Replace the netif_carrier_on(), netif_carrier_off() and
> stmmac_mac_set() calls with the appropriate phylink_start() and
> phylink_stop() calls, thereby allowing phylink to manage the netif
> carrier and TE/RE bits through the .mac_link_up() and .mac_link_down()
> methods.
> 
> Note that RE should only be set after the DMA is ready to avoid the
> receive FIFO between the MAC and DMA blocks overflowing, so
> phylink_start() needs to be placed after DMA has been started.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 13796b1c8d7c..84d8b1c9f6d4 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -6887,6 +6887,8 @@ void stmmac_xdp_release(struct net_device *dev)
>  	/* Ensure tx function is not running */
>  	netif_tx_disable(dev);
>  
> +	phylink_stop(priv->phylink);
> +
>  	/* Disable NAPI process */
>  	stmmac_disable_all_queues(priv);
>  
> @@ -6902,14 +6904,10 @@ void stmmac_xdp_release(struct net_device *dev)
>  	/* Release and free the Rx/Tx resources */
>  	free_dma_desc_resources(priv, &priv->dma_conf);
>  
> -	/* Disable the MAC Rx/Tx */
> -	stmmac_mac_set(priv, priv->ioaddr, false);
> -
>  	/* set trans_start so we don't get spurious
>  	 * watchdogs during reset
>  	 */
>  	netif_trans_update(dev);
> -	netif_carrier_off(dev);
>  }
>  
>  int stmmac_xdp_open(struct net_device *dev)
> @@ -6992,25 +6990,25 @@ int stmmac_xdp_open(struct net_device *dev)
>  		tx_q->txtimer.function = stmmac_tx_timer;
>  	}
>  
> -	/* Enable the MAC Rx/Tx */
> -	stmmac_mac_set(priv, priv->ioaddr, true);
> -
>  	/* Start Rx & Tx DMA Channels */
>  	stmmac_start_all_dma(priv);
>  
> +	phylink_start(priv->phylink);
> +
>  	ret = stmmac_request_irq(dev);
>  	if (ret)
>  		goto irq_error;
>  
>  	/* Enable NAPI process*/
>  	stmmac_enable_all_queues(priv);
> -	netif_carrier_on(dev);
>  	netif_tx_start_all_queues(dev);
>  	stmmac_enable_all_dma_irq(priv);
>  
>  	return 0;
>  
>  irq_error:
> +	phylink_stop(priv->phylink);
> +
>  	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
>  		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
>  

XDP programs work like a charm both before and after this patch.

Tested-by: Furong Xu <0x1207@gmail.com>

