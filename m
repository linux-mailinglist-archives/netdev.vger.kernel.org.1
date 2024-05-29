Return-Path: <netdev+bounces-98930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C81328D3286
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 11:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CABBBB2266F
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 09:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35476169360;
	Wed, 29 May 2024 09:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e01T1exz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750AC1E888
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 09:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716973517; cv=none; b=MlwapPrxAk0Y2s2+J1j9K5CUHzC+Dlbu6CVSetSzYli+qukbqvijQBiI9MkHFTUOtOl9PnCu1KF0CjN7mnuFMBV8ZLNK/OHYaut7Xd1F+IgMFrvcO9VOU2MO3P0I/wTPRJ8s7LZJDpqnLG5F0ptfcQOmV52+pcT/ErFk7yUJDoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716973517; c=relaxed/simple;
	bh=s70m1v4q4sVcX15sBK0yOh/mGl71k7ke9+d1t22BCH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3sEFHJDJ9jamJi/JOuIAJMzUGReF7HxbpJU69XNS6dqmQp+FYkF9GNMCFxfcdsepld78EX7UTho82b5ffk+xf+IPeahjxAzD1LGYJVtiMec4pqqFnQDw/IiqSEDp2xeyqgSPSE7LWl4JXjtcbIJune/OCmZ1gToWGIntzD0yEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e01T1exz; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-529661f2552so2261281e87.2
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 02:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716973513; x=1717578313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2uhqxaKdsBnrqyALusZlhX48zdbF/2oM3lehcGhLjfU=;
        b=e01T1exzzpJmwAwI6q9h9lBcTpQ3yaSMQjnlD5qSBv6r+5738W5do+epH3qeO/ywBp
         sGE9uDnOcjNe3IigsvRp0mI1sRvPVwIWdZsvNbuhz+Pa//c7KkiunqZ4lz9JGYj417OG
         HheWRCvL3crvNH8LT0uxbYKF7rSGFuxQatvN8UJ0hk2M/yiZC1uLs138V6swcnbnm4Vj
         xYFLVgAdL54lpdZQUddas/D4GGTQ1lVZQesQuIzvLKqkmRVKAlsWaYhdun4yc4VSrPe0
         jPyX3PzwfFJKQkPNUdGE1g0Ld7Cf7izgZ8ew2MbQ72deIRz6hezugMOxqhhLKb3H+ocn
         HRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716973513; x=1717578313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uhqxaKdsBnrqyALusZlhX48zdbF/2oM3lehcGhLjfU=;
        b=kBrpEahGjDpFcwptYbZ0nhSFwd9ZFezobwm1oHOdj3NfY/wfE3QxJjXGm2a1zJtkV6
         aKCSwb1VNdRfWFmL/AQARFVW+/Ct64UOAw8DOw/iDKwYAapVC4o5CH8rVevA2SSpV4NN
         fS6RQc5f8q55Fdj3iaqOrrZeoiIXkdizZAx5T81Y7aAWOldeSh7Od8WyuZyIY6CRc0kX
         AKqnrnvl5q717xRQ7Ed2TOzoS04dxnwttc3f3hpstAx1kug3zhZTtR3PTD4BDr4uvFnp
         JCdaiZoRYwvvbDqinvrC+zZbrMBOSs7DjvxkVgqJEvnuulEzEC0yEi51dilWXFct/YiI
         xw5A==
X-Forwarded-Encrypted: i=1; AJvYcCWVPY7s+EtabqKd9fUnnD44ghh/yP0z4z95xcA83ujXq0ABt06D+zFJEERTDxr4Kbi8TdB9fxv2Rv30DSwvBZWTr37BXBK4
X-Gm-Message-State: AOJu0Yw8zvwj19QDmh1RSJ+ZIdcQUfYXghQvOaUETwPD1srVMmHT96YT
	SBYbs5h6BP73PJ3xUvLggOob7Ox6uTQwRNtc884ZQ46QHNHiNV59
X-Google-Smtp-Source: AGHT+IGkJLkQMou+KJ5AYD271MNcgYNd5Ks9H4jDXgA41PXt63NDcXHszC5RogGekpQjLjW87jJmTg==
X-Received: by 2002:a05:6512:3c9b:b0:529:b734:ebc9 with SMTP id 2adb3069b0e04-529b734ec38mr4424149e87.38.1716973513190;
        Wed, 29 May 2024 02:05:13 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5296e886ea4sm1175791e87.26.2024.05.29.02.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 02:05:12 -0700 (PDT)
Date: Wed, 29 May 2024 12:05:09 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Halaney <ahalaney@redhat.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jose Abreu <joabreu@synopsys.com>, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH net-next v2 0/6] net: stmmac: cleanups
Message-ID: <bfiqy7q3fb6ybmpszd7ktvuxr3kec4z2ra455pdqjkn6i4fb64@crtsjh4bslim>
References: <Zlbp7xdUZAXblOZJ@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zlbp7xdUZAXblOZJ@shell.armlinux.org.uk>

Hi Russell

On Wed, May 29, 2024 at 09:40:15AM +0100, Russell King (Oracle) wrote:
> Hi,
> 
> This series removes various redundant items in the stmmac driver:
> 
> - the unused TBI and RTBI PCS flags
> - the NULL pointer initialisations for PCS methods in dwxgmac2
> - the stmmac_pcs_rane() method which is never called, and it's
>   associated implementations
> - the redundant netif_carrier_off()s
> 
> Finally, it replaces asm/io.h with the preferred linux/io.h.
> 
> Changes since v1:
>  - Fix patch 1 "Drop TBI/RTBI flags" which didn't transfer correctly
>    between my internal trees!
>  - Update patch 5 to address all the asm/io.h in stmmac
>  - Add Andrew Halaney's reviewed-by
>  - Add patch 6 cleaning up qcom-ethqos phy speed setting

Thanks for the series. For all patches:

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

* Note I've got your messages regarding the STMMAC driver and
RGMII/SGMII/etc PCS. I do remember about that and will respond to all
of them either later today or tomorrow. Currently busy with my long
lasting DW XPCS series.

-Serge(y)

> 
>  drivers/net/ethernet/stmicro/stmmac/common.h       |  2 --
>  .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    | 24 +++++++-------
>  .../net/ethernet/stmicro/stmmac/dwmac1000_core.c   |  8 +----
>  .../net/ethernet/stmicro/stmmac/dwmac1000_dma.c    |  2 +-
>  .../net/ethernet/stmicro/stmmac/dwmac100_core.c    |  2 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c |  2 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |  8 -----
>  .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  6 ----
>  drivers/net/ethernet/stmicro/stmmac/hwif.h         |  3 --
>  .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |  2 +-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 38 +++++-----------------
>  drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h   | 17 ----------
>  12 files changed, 26 insertions(+), 88 deletions(-)
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

