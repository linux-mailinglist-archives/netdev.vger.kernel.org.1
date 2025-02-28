Return-Path: <netdev+bounces-170544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 598E1A48F20
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 04:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5103F16DFE3
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 03:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3765E15ECDF;
	Fri, 28 Feb 2025 03:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fh90XJR/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB7114A4DF
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 03:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740713333; cv=none; b=C54AMPkdHWYO4owyriZ9IU5N7mzm5gRYdSgMSTiVQV3JGMAMkUZaS1dqy8uB8N/LgsY7xpe2JEuVEapeDTtkxEqcKXFxUP5KNtJoQwc4t6v7F50pZCpWYfgdFy4OzL9/ECC0VmwLjIlE5VZyx0jo9ORctvMB0tyF8ETCXjvrVlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740713333; c=relaxed/simple;
	bh=qk0RjPSDNSrpg6ygvmj0TWlMA8bgjUm7T2ESWmcD6J4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=El4he5X5nd3USQK2e0OdWegPv/lYkbsCm89QHZgubZ8iq+QPAs830UCvPUUgDPn0ReCCn+c8Hf8GVsq7487Fu2wYhzgQFaSrvfmtMXkzbeebmtsWN7zgRyzL+Krji8c7lxa5A/TKMQ1dxDfagH3MMDDDkxgxGUcQIje5fvz0y1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fh90XJR/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220d132f16dso23883835ad.0
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 19:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740713331; x=1741318131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EY43HLtzrUzkXYHTHJfVcm+528T6DiMSEe7dNOvpyIw=;
        b=Fh90XJR/rvrSTIc4aiG/r8iVV7MDb9f0c7PA1xnuXBmZTO+aC8CmkS7qb6D8rVvYWs
         mJAhquRJHFtYnflM68Orw2l/n1xI0WBn7UiAZafgG2CPTvonHiOjBoYOUGo5FvP/bers
         a2Aw9wAYbI5F5GoL+xl1F+0gwG4MHTgf3MRaL7enYjjeR3jeLoviiv2fi0yQJcRUjssL
         H93nyEKFtEfxYPn6Q2q1LZnJ/lv8B742DetP96CXt8VmGfITEj7tbBGHpaHzthE1qnLq
         n8vMa/hSgRBUBsVNXhUOvM2LXhEAcUX+VKSy9cgOKeYFNZb0KZTCW4SQPPTfcsmgDFp7
         asqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740713331; x=1741318131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EY43HLtzrUzkXYHTHJfVcm+528T6DiMSEe7dNOvpyIw=;
        b=wn+jLK4j8zB4Kg+Hx1aU0qQqHIR5ScUQtx+yAe8VphPkkBTGO2OIuKxEhgw7PIstQy
         s947Sd8hcJWzG3hD6CEV8fQKMfhBgWhur+IxKp2MvbiotFA/x6PV5kMSqSoHfJVKC+5e
         T+Gz/cqc+NJfmKz5wertz/aEqSNQPFTv36jkxxiGVu691Ht6Myhv3UMMuUePv5DoNqVN
         wKmEZ6w3hu19TgmdtUyccx70R6+hpcqQjGaNkj61KTdm/uCceETpVvUFTcoKDP/fTCw6
         d2J28vMSIlJE6panF8x2pezVk0u29QQuXfAJlIXMIBYOw0Dus3FE/GRDzuHsGbYIvWvN
         ADjg==
X-Forwarded-Encrypted: i=1; AJvYcCVEdteHbjgiwDmuXCh45vQLdkzPa1CHkgZyznt4yU3m7R63iveL9HvIFsgFU7WiTQ0Wc5BbU4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGdOqRejDaq3Me6j/eLVX0+XxtSVPndPgsI8H7dTzWlD/MYnF7
	K0ZJQOZdRAyfS88YWqpl/hQ15WyAPdex36V2xsR/nudSx0JtdYbY
X-Gm-Gg: ASbGncszgnfvN//mIARjnKFTXF+HmpUhuj9ksvGgQViRaKenhMeydPxqNeiswLSzSAT
	MLvwHSbh8wLUahvhqBwu6wu7l5cQglCjpaSIew0wKqsKn9Edlc0ikf23c6/bKU2FIV+5+Mw1WtE
	eszVBh7G7IxqfeDm5ay4Yfo4EwX9zAPP1oOgHhl9knLAK76Rk1kLCMfzy8wdmJ0tEfKO79IoN6b
	ITxUCHt1VPrzNqHtNiD//YMHmIR3lWR1/ain+PbkjHWGHJwHKkqqVM6LfbcGsUIwVHVIDoEWwlt
	szDOsatPJSc/s4F29AyjAaQ=
X-Google-Smtp-Source: AGHT+IFhTzQtlbRb4GUfkQUHLHJc2YBAelAdku34kRQilo8jgysSfJHVUW03LTM8vyRl+NUxhY5UeQ==
X-Received: by 2002:a17:902:d48f:b0:211:e812:3948 with SMTP id d9443c01a7336-22368bc365fmr29598825ad.0.1740713330830;
        Thu, 27 Feb 2025 19:28:50 -0800 (PST)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bf3sm23485515ad.110.2025.02.27.19.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 19:28:50 -0800 (PST)
Date: Fri, 28 Feb 2025 11:28:40 +0800
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
Subject: Re: [PATCH RFC net-next 2/5] net: stmmac: remove redundant racy
 tear-down in stmmac_dvr_remove()
Message-ID: <20250228112840.00003e24@gmail.com>
In-Reply-To: <E1tnfRj-0057SF-9t@rmk-PC.armlinux.org.uk>
References: <Z8B-DPGhuibIjiA7@shell.armlinux.org.uk>
	<E1tnfRj-0057SF-9t@rmk-PC.armlinux.org.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 15:05:07 +0000
"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:

> While the network device is registered, it is published to userspace,
> and thus userspace can change its state. This means calling
> functions such as stmmac_stop_all_dma() and stmmac_mac_set() are
> racy.
> 
> Moreover, unregister_netdev() will unpublish the network device, and
> then if appropriate call the .ndo_stop() method, which is
> stmmac_release(). This will first call phylink_stop() which will
> synchronously take the link down, resulting in stmmac_mac_link_down()
> and stmmac_mac_set(, false) being called.
> 
> stmmac_release() will also call stmmac_stop_all_dma().
> 
> Consequently, neither of these two functions need to called prior
> to unregister_netdev() as that will safely call paths that will
> result in this work being done if necessary.
> 
> Remove these redundant racy calls.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 84d8b1c9f6d4..9462d05c40c8 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -7757,8 +7757,6 @@ void stmmac_dvr_remove(struct device *dev)
>  
>  	pm_runtime_get_sync(dev);
>  
> -	stmmac_stop_all_dma(priv);
> -	stmmac_mac_set(priv, priv->ioaddr, false);
>  	unregister_netdev(ndev);
>  
>  #ifdef CONFIG_DEBUG_FS

We always build stmmac driver as built-in.
Tried to build stmmac driver as a module, but some complicated dependencies were
reported in our down-stream kernel :(
I can not test this patch, so:

Reviewed-by: Furong Xu <0x1207@gmail.com>

