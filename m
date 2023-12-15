Return-Path: <netdev+bounces-57896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2763B8146F8
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 12:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D85E4284913
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 11:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FF824B3F;
	Fri, 15 Dec 2023 11:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NO63frpI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC2628E23
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 11:31:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7042AC433CB;
	Fri, 15 Dec 2023 11:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702639888;
	bh=AAP060Ko/cQbixScvKaL20IHcZXHxjXqSDd3K9XwHFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NO63frpIVY+032l4MbeybdDrZcHnvrwXBUa5ZmevSCUb84UBl7lqOb2xd8cTaGZ2d
	 qPmA4451yEUCAKAVCiHQ03MlEa/M9jlrou5IRKxgDvWbREpFaBXQnNGtYyP43Jzb0G
	 keNu8ZeJ17lSSO18uFsxXTEZ5GsoAACiKN5GWBObbs9M1oQ2gE4c7H8bC+cemSEzfJ
	 K88DyRVNB4yRumIpKxjAT1k6ydnhMWWJTKoTcdyJyDR5PKjLPZmUUe2ELAhsVXG9rI
	 /tZlm1ZUAMhiYHQz6/VBzc+ATxEZa5PRqo0QKbw+ZCMn02cOivrP3ZxBURJ6CgrPlb
	 dUnLNvii35V+w==
Date: Fri, 15 Dec 2023 11:31:24 +0000
From: Simon Horman <horms@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/8] dpaa2-switch: do not clear any
 interrupts automatically
Message-ID: <20231215113124.GA6288@kernel.org>
References: <20231213121411.3091597-1-ioana.ciornei@nxp.com>
 <20231213121411.3091597-6-ioana.ciornei@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213121411.3091597-6-ioana.ciornei@nxp.com>

On Wed, Dec 13, 2023 at 02:14:08PM +0200, Ioana Ciornei wrote:
> The DPSW object has multiple event sources multiplexed over the same
> IRQ. The driver has the capability to configure only some of these
> events to trigger the IRQ.
> 
> The dpsw_get_irq_status() can clear events automatically based on the
> value stored in the 'status' variable passed to it. We don't want that
> to happen because we could get into a situation when we are clearing
> more events than we actually handled.
> Just resort to manually clearing the events that we handled.

Hi Ioana,

Continuing the theme of Jakub's review of v1,
I think it would be useful to state that
there is no user-visible effect of this change.
And, ideally, explain why that is so.

> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
> Changes in v2:
> - add a bit more info in the commit message
> 
>  drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> index e91ade7c7c93..d9906573f71f 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> @@ -1509,7 +1509,7 @@ static irqreturn_t dpaa2_switch_irq0_handler_thread(int irq_num, void *arg)
>  	struct device *dev = (struct device *)arg;
>  	struct ethsw_core *ethsw = dev_get_drvdata(dev);
>  	struct ethsw_port_priv *port_priv;
> -	u32 status = ~0;
> +	u32 status = 0;
>  	int err, if_id;
>  	bool had_mac;

As status is no longer used in the 'out' unwind path,
I don't think the initialisation above is needed any more.

	...
	int err, if_id;
	bool had_mac;
	u32 status;

>  
> @@ -1539,12 +1539,12 @@ static irqreturn_t dpaa2_switch_irq0_handler_thread(int irq_num, void *arg)
>  			dpaa2_switch_port_connect_mac(port_priv);
>  	}
>  
> -out:
>  	err = dpsw_clear_irq_status(ethsw->mc_io, 0, ethsw->dpsw_handle,
>  				    DPSW_IRQ_INDEX_IF, status);
>  	if (err)
>  		dev_err(dev, "Can't clear irq status (err %d)\n", err);
>  
> +out:
>  	return IRQ_HANDLED;
>  }
>  
> -- 
> 2.34.1
> 

