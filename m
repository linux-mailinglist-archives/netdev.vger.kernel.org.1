Return-Path: <netdev+bounces-50661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B07BE7F6826
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 21:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C1A0B20CAF
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 20:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2EA4D12A;
	Thu, 23 Nov 2023 20:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LBjjJT7I"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B2DD41;
	Thu, 23 Nov 2023 12:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kJeXbrZOUj5rdzQgMSVZ1x5SEGn76ScEL3QEZ1NKcyQ=; b=LBjjJT7IFEDSq0m8h8vvBvJyD0
	nWRfw7B1eziTxK7FD4qioH+tRKnZ0FbjBSIJcz/T1HkID8VqR6rR4zPZUnzqR/XmcdViq97zNcH64
	atippMG8swE/5F/CnxUiG4S5UWT3D0dot5dRY6OHWOaw4XRkrkeFX9luXSTR1/Fwez1U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r6G0r-0011wP-Ri; Thu, 23 Nov 2023 21:09:25 +0100
Date: Thu, 23 Nov 2023 21:09:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiko Schocher <heiko.schocher@gmail.com>
Cc: netdev@vger.kernel.org, Heiko Schocher <hs@denx.de>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	NXP Linux Team <linux-imx@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
	Shenwei Wang <shenwei.wang@nxp.com>, Wei Fang <wei.fang@nxp.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: fec: fix probing of fec1 when fec0 is not probed yet
Message-ID: <132aca53-6570-41a4-b2b2-0907d74f9b31@lunn.ch>
References: <20231123132744.62519-1-hs@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123132744.62519-1-hs@denx.de>

On Thu, Nov 23, 2023 at 02:27:43PM +0100, Heiko Schocher wrote:
> it is possible that fec1 is probed before fec0. On SoCs
> with FEC_QUIRK_SINGLE_MDIO set (which means fec1 uses mii
> from fec0) init of mii fails for fec1 when fec0 is not yet
> probed, as fec0 setups mii bus. In this case fec_enet_mii_init
> for fec1 returns with -ENODEV, and so fec1 never comes up.
> 
> Return here with -EPROBE_DEFER so interface gets later
> probed again.
> 
> Found this on imx8qxp based board, using 2 ethernet interfaces,
> and from time to time, fec1 interface came not up.
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>
> ---
> 
>  drivers/net/ethernet/freescale/fec_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index c3b7694a7485..d956f95e7a65 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -2445,7 +2445,7 @@ static int fec_enet_mii_init(struct platform_device *pdev)
>  			mii_cnt++;
>  			return 0;
>  		}
> -		return -ENOENT;
> +		return -EPROBE_DEFER;

I think this has been tried before.

Are there any issues with the mii_cnt++; I thought the previous
attempt as this had problems with the wrong mdio bus being assigned to
fep->mii_bus ? But i could be remembering wrongly.

	Andrew

