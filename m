Return-Path: <netdev+bounces-72024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3BF856386
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 13:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C9C2288F2D
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 12:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39A812D75B;
	Thu, 15 Feb 2024 12:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="acgOdNSd"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45CD12D740
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 12:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708001104; cv=none; b=tCuNFICQZcRTZzIzhKwcEmod7UgSYjYatZSPVuJXbTIhIN9un/4pQvJojrSyawkpPAxVx4WBVtYhEeEZ3OZM/DQQZYbwg2W6+JvMN3II7ECZ9QvGXWRXvQMtj/SRSHsdS6ymZMsaNr69FRjy1bLmzajXQ7EBZMtVcupMuh+Z9c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708001104; c=relaxed/simple;
	bh=m6I1LJiYUD1G+/74Dd6FRlu8IypGqRxQxcnKqXeM7F8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W3PS1Q/wfEaC0LEJj+sdyRCek0gzs6NiC9VxWkH8zv3dr490zaDHbiSGoPmKlnFxygwJgBTjKaWQvbs3XIczjjQ72wS329AIci8HQ2QjYwvQz5el8YcYlzlckOhey21opuD4kb5mcA+HOSfKSlVEKAET9mZP5euD1hWfpcx3DL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=acgOdNSd; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240215124456cea09a2e2cc9996ed6
        for <netdev@vger.kernel.org>;
        Thu, 15 Feb 2024 13:44:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ui08RXLlMeyrrk71srApeALk5WRCw9H0QNeubMIeJOc=;
 b=acgOdNSdNcXhJWLMH8LFpCLRpXF307OLlsonSkik3JQIHXFEoUA9lkKw2YFaLCZEaWBjrr
 sxo7KDj/L8qjVd0ZRbdawFV3sRWLKU07D5vGQujnbQS0XMcc+1nnl9oWzJvb/ctn7tu+zORe
 HYrZVBuuJK4b0lm7pacn1ZLRsRAWU=;
Message-ID: <ce2c5ee0-3bed-490e-ac57-58e849ec1eee@siemens.com>
Date: Thu, 15 Feb 2024 12:44:54 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: ti: icssg-prueth: Remove duplicate cleanup calls
 in emac_ndo_stop()
To: danishanwar@ti.com, rogerq@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
 vigneshr@ti.com, jan.kiszka@siemens.com, dan.carpenter@linaro.org,
 robh@kernel.org, grygorii.strashko@ti.com, horms@kernel.org,
 diogo.ivo@siemens.com
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
References: <20240206152052.98217-1-diogo.ivo@siemens.com>
Content-Language: en-US
From: Diogo Ivo <diogo.ivo@siemens.com>
In-Reply-To: <20240206152052.98217-1-diogo.ivo@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer


On 2/6/24 15:20, Diogo Ivo wrote:
> Remove the duplicate calls to prueth_emac_stop() and
> prueth_cleanup_tx_chns() in emac_ndo_stop().
>
> Fixes: 128d5874c082 ("net: ti: icssg-prueth: Add ICSSG ethernet driver")
> Fixes: 186734c15886 ("net: ti: icssg-prueth: add packet timestamping and ptp support")
> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
> ---
>   drivers/net/ethernet/ti/icssg/icssg_prueth.c | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index 411898a4f38c..cf7b73f8f450 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -1489,9 +1489,6 @@ static int emac_ndo_stop(struct net_device *ndev)
>   	/* Destroying the queued work in ndo_stop() */
>   	cancel_delayed_work_sync(&emac->stats_work);
>   
> -	/* stop PRUs */
> -	prueth_emac_stop(emac);
> -
>   	if (prueth->emacs_initialized == 1)
>   		icss_iep_exit(emac->iep);
>   
> @@ -1502,7 +1499,6 @@ static int emac_ndo_stop(struct net_device *ndev)
>   
>   	free_irq(emac->rx_chns.irq[rx_flow], emac);
>   	prueth_ndev_del_tx_napi(emac, emac->tx_ch_num);
> -	prueth_cleanup_tx_chns(emac);
>   
>   	prueth_cleanup_rx_chns(emac, &emac->rx_chns, max_rx_flows);
>   	prueth_cleanup_tx_chns(emac);

Hello,

Gentle ping on this patch.


Thank you,

Diogo


