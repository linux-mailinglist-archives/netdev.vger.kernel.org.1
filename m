Return-Path: <netdev+bounces-26987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83947779C3B
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 03:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B71391C20CFA
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 01:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEF7EA4;
	Sat, 12 Aug 2023 01:20:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E117FEA2
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 01:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63D9C433C8;
	Sat, 12 Aug 2023 01:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691803227;
	bh=wYICEGflWGmxjyn1cvUXEfdlZXS0waAspNgq3SytX3U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jNiQiiyBJKG60pEXmy5eLsG8d8CxaJlPGZZHd/kxOoN7Ir0Sja8pS5dGeC14u3eTj
	 /qt2L2FNYRz1wFOT7WqgJQsB5flVsTL6WktoESM+TJPnzYg2wuOnDMP2SfJYAMguTP
	 3s/t1sTKrb/wwoCwrn+6PvM3I3L67kvRjS36YD2r1wk23L7PvZDJpcZpEcCo+zv4cm
	 F3OX6cciYRRPQTiy88O3TBIjDjFEH75fZtpyKiniRRAZRc7oS9Ey6/pBZKXFV733A0
	 PWvZsfEbKVjzJVc9dje4+LOrS0Dt4dcEJRCo5Xf9U1HMNfQQ7d4JFYVWxNSoKUgtqz
	 JBExRKTlsWgmQ==
Date: Fri, 11 Aug 2023 18:20:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Remi Pommarel <repk@triplefau.lt>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Sabrina
 Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: remove disable_irq() from
 ->ndo_poll_controller()
Message-ID: <20230811182025.7473bf63@kernel.org>
In-Reply-To: <20230810083716.29653-1-repk@triplefau.lt>
References: <20230810083716.29653-1-repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Aug 2023 10:37:16 +0200 Remi Pommarel wrote:
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 4727f7be4f86..bbe509abc5dc 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5958,8 +5958,8 @@ static void stmmac_poll_controller(struct net_device *dev)
>  		for (i = 0; i < priv->plat->tx_queues_to_use; i++)
>  			stmmac_msi_intr_tx(0, &priv->dma_conf.tx_queue[i]);
>  	} else {
> -		disable_irq(dev->irq);
> -		stmmac_interrupt(dev->irq, dev);
> +		if (disable_hardirq(dev->irq))
> +			stmmac_interrupt(dev->irq, dev);
>  		enable_irq(dev->irq);

Implementing .ndo_poll_controller is only needed if driver doesn't use
NAPI. This driver seems to use NAPI on all paths, AFAICT you can simply
delete this function completely.
-- 
pw-bot: cr

