Return-Path: <netdev+bounces-57903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E20D3814750
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 12:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 987C61F226F7
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 11:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326C125561;
	Fri, 15 Dec 2023 11:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwgqnXym"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BA32DB69
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 11:51:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C450C433C8;
	Fri, 15 Dec 2023 11:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702641094;
	bh=Q2Emxw5Sm4tOze6rUhtRIQ2UCwJGWZkFaKzCketr1Jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pwgqnXymk2oNr2QQLygXyv2i6nBz+u1nEqR8N8uYho+mYWY13ZAjzB3FFwMK36Igt
	 bQAhOBR7seW3ysBihBfJN+y6K0mRzGVIDeysOfpAqXzuDB9eD8OaQXVhvws2j6JHh8
	 lyQGkZZIrXhzRcKokn0vpSS10sfjBdNiLRuxIo10+/DDmgkL+YmLoQGbKpJaztN31k
	 4yvR/mz7XuuyqGUzdw9lJ5cYPaxX3D0qP6WFfDcAvNwvPMrVWZwjheOW1TIi8JHso/
	 6AysrRwxkXOgihDDMq8ZH6BGqIUha410Y5lLz0lOfVAZ2/1n5UN4l7ELUH3Iyked3V
	 lKykOc0/sbzSA==
Date: Fri, 15 Dec 2023 11:51:30 +0000
From: Simon Horman <horms@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/8] dpaa2-switch: add ENDPOINT_CHANGED to
 the irq_mask
Message-ID: <20231215115130.GC6288@kernel.org>
References: <20231213121411.3091597-1-ioana.ciornei@nxp.com>
 <20231213121411.3091597-5-ioana.ciornei@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213121411.3091597-5-ioana.ciornei@nxp.com>

On Wed, Dec 13, 2023 at 02:14:07PM +0200, Ioana Ciornei wrote:
> The blamed commit added support for MAC endpoints in the dpaa2-switch
> driver but omitted to add the ENDPOINT_CHANGED irq to the list of
> interrupt sources. Fix this by extending the list of events which can
> raise an interrupt by extending the mask passed to the
> dpsw_set_irq_mask() firmware API.
> 
> There is no user visible impact even without this patch since whenever a
> switch interface is connected/disconnected from an endpoint both events
> are set (LINK_CHANGED and ENDPOINT_CHANGED) and, luckily, the
> LINK_CHANGED event could actually raise the interrupt and thus get the
> MAC/PHY SW configuration started.
> 
> Even with this, it's better to just not rely on undocumented firmware
> behavior which can change.
> 
> Fixes: 84cba72956fd ("dpaa2-switch: integrate the MAC endpoint support")

Hi Ioana,

As there is no user-visible bug, I think it is better to drop the Fixes tag.

If you want to mention the commit, which is probably a good idea,
then perhaps you can use something like:

   Introduced by commit ...

> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
> Changes in v2:
> - add a bit more info in the commit message
> 
>  drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> index 654dd10df307..e91ade7c7c93 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> @@ -1550,9 +1550,9 @@ static irqreturn_t dpaa2_switch_irq0_handler_thread(int irq_num, void *arg)
>  
>  static int dpaa2_switch_setup_irqs(struct fsl_mc_device *sw_dev)
>  {
> +	u32 mask = DPSW_IRQ_EVENT_LINK_CHANGED | DPSW_IRQ_EVENT_ENDPOINT_CHANGED;
>  	struct device *dev = &sw_dev->dev;
>  	struct ethsw_core *ethsw = dev_get_drvdata(dev);
> -	u32 mask = DPSW_IRQ_EVENT_LINK_CHANGED;
>  	struct fsl_mc_device_irq *irq;
>  	int err;
>  
> -- 
> 2.34.1
> 

