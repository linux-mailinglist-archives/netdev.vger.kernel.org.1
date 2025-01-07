Return-Path: <netdev+bounces-155806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 363F3A03DAB
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 12:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98DC23A49B1
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 11:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8101A840A;
	Tue,  7 Jan 2025 11:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gImPgzFW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C1D18A6C1
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 11:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736249337; cv=none; b=ayaQq3OrXifY/0Jk5BrKigqC0OjJvkUNqiS96kaVYtQB3ryeFRJeeRArSqRRqpnp6RokwICGTGnzwjgxcrBHGt2l71+KPumnAofcCLSzPpZqntSpDyuE6ILXwM5zxCieezHhzFx+LkBcP1/iFwnfLCH0KCFM08+0xe2PtDyNUfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736249337; c=relaxed/simple;
	bh=a/nUa1LpYlu8s73KEhuvs+6oTFnQ69UQk445ZrCficQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JR5H+9IhIShpb0ISXVseNloeGM1wMGLngY6RzogTicllRHeHK/sMfeNSC75HQ4ewYCCYrugP2FnXYQhhg3wmrj0qkjq8nLrjllz0NtbRQdvoPY4ft1m0Tuu0DrLI+DPAnxtKGA3sqz1a8UiiUpIP5S9VOtT/aKBclGAxFBmnyLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gImPgzFW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF24DC4CED6;
	Tue,  7 Jan 2025 11:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736249336;
	bh=a/nUa1LpYlu8s73KEhuvs+6oTFnQ69UQk445ZrCficQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gImPgzFWKdaLfhzGloiicMj18CgRTePlPywu2sxqZzJB7pXfAAPZTTzPlM2C7keyA
	 AAwwEKlIqBk+qKD6ZN670879wOhRm2SVeuE1Q5WW5BVoso2KdTqx5BOD6XMEKOpQD7
	 vcrMImtbS9DRqzk2wHZjJp7TnPk+xw2R6tOrquuOIIxtuzSEVLhvw4KxP1I9u2r0mR
	 A0zSxUozsvlgs/KDIbGMSn3t5vIhlNGvSN2Teu0WhSqU4STXkemsvEqruKTHLnWZ/4
	 efI7l28N48n3OW3n7inOwPcRKmfyLLpiDbkhBA049t33h1iAmYfpV3CFTvjUg/Xk7T
	 hk7erpGh03HAw==
Date: Tue, 7 Jan 2025 11:28:51 +0000
From: Simon Horman <horms@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 03/17] net: stmmac: use correct type for
 tx_lpi_timer
Message-ID: <20250107112851.GE33144@kernel.org>
References: <Z3vLbRQ9Ctl-Rpdg@shell.armlinux.org.uk>
 <E1tUmAE-007VWv-UW@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tUmAE-007VWv-UW@rmk-PC.armlinux.org.uk>

On Mon, Jan 06, 2025 at 12:24:58PM +0000, Russell King (Oracle) wrote:
> The ethtool interface uses u32 for tx_lpi_timer, and so does phylib.
> Use u32 to store this internally within stmmac rather than "int"
> which could misinterpret large values.
> 
> Since eee_timer is used to initialise priv->tx_lpi_timer, this also
> should be unsigned to avoid a negative number being interpreted as a
> very large positive number.
> 
> Also correct "value" in dwmac4_set_eee_lpi_entry_timer() to use u32
> rather than int, which is derived from tx_lpi_timer, even though
> masking with STMMAC_ET_MAX will truncate the sign bits. u32 is the
> value argument type for writel().
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

...

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 9a9169ca7cd2..b0ef439b715b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -111,8 +111,8 @@ static const u32 default_msg_level = (NETIF_MSG_DRV | NETIF_MSG_PROBE |
>  				      NETIF_MSG_IFDOWN | NETIF_MSG_TIMER);
>  
>  #define STMMAC_DEFAULT_LPI_TIMER	1000
> -static int eee_timer = STMMAC_DEFAULT_LPI_TIMER;
> -module_param(eee_timer, int, 0644);
> +static unsigned int eee_timer = STMMAC_DEFAULT_LPI_TIMER;
> +module_param(eee_timer, uint, 0644);
>  MODULE_PARM_DESC(eee_timer, "LPI tx expiration time in msec");
>  #define STMMAC_LPI_T(x) (jiffies + usecs_to_jiffies(x))
>  

Hi Russell,

now that eee_timer is unsigned the following check in stmmac_verify_args()
can never be true. I guess it should be removed.

        if (eee_timer < 0)
                eee_timer = STMMAC_DEFAULT_LPI_TIMER;

Flagged by Smatch.

...

