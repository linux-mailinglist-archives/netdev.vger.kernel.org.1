Return-Path: <netdev+bounces-22996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 556F376A5B7
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 02:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 062FE28175A
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 00:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1097367;
	Tue,  1 Aug 2023 00:47:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FB67E
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 00:47:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57773C433C8;
	Tue,  1 Aug 2023 00:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690850837;
	bh=HVCJWkm17XYYTeXMWqebimNK5wqYP92jp1ePEqqz6WM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GJC6+TAlwS7zb7RSesSA/gdaCkV5gKSExFIeb8c1nsBsYuAb5JdO1yeuVxSZ/xkM8
	 vkPIAbJCi3kMT7CBe6ujOyJNoPeOZexx0GWYlgxfE3oan+E/iCc0fN2YP/RRG7eRQ7
	 3vsViss2fvIRbfjXOlxV2AXFmiaa/iuqd16LAmQQ6Vw2MZH5iyGOjMdIid/U7QVaJW
	 ppYNN7JbK9ncQT58ka4q+br0PQY4+d7q9aSAoDAbDt+vl0FSAawAb8gjk+WUVbckv1
	 EKl5nrZYx3rj34bKhyx7+8uoEBBk2dpy01giZc31s4C7adtlX6PSIAP25f4GKO2zOT
	 KL59gzzGdbArg==
Date: Mon, 31 Jul 2023 17:47:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thinh Tran <thinhtr@linux.vnet.ibm.com>
Cc: aelior@marvell.com, davem@davemloft.net, edumazet@google.com,
 manishc@marvell.com, netdev@vger.kernel.org, pabeni@redhat.com,
 skalluru@marvell.com, drc@linux.vnet.ibm.com, abdhalee@in.ibm.com,
 simon.horman@corigine.com
Subject: Re: [PATCH v4] bnx2x: Fix error recovering in switch configuration
Message-ID: <20230731174716.0898ff62@kernel.org>
In-Reply-To: <20230728211133.2240873-1-thinhtr@linux.vnet.ibm.com>
References: <20220916195114.2474829-1-thinhtr@linux.vnet.ibm.com>
	<20230728211133.2240873-1-thinhtr@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jul 2023 16:11:33 -0500 Thinh Tran wrote:
> As the BCM57810 and other I/O adapters are connected
> through a PCIe switch, the bnx2x driver causes unexpected
> system hang/crash while handling PCIe switch errors, if
> its error handler is called after other drivers' handlers.
> 
> In this case, after numbers of bnx2x_tx_timout(), the
> bnx2x_nic_unload() is  called, frees up resources and
> calls bnx2x_napi_disable(). Then when EEH calls its
> error handler, the bnx2x_io_error_detected() and
> bnx2x_io_slot_reset() also calling bnx2x_napi_disable()
> and freeing the resources.
> 
> 
> Signed-off-by: Thinh Tran <thinhtr@linux.vnet.ibm.com>
> Reviewed-by: Manish Chopra <manishc@marvell.com>
> Tested-by: Abdul Haleem <abdhalee@in.ibm.com>
> Tested-by: David Christensen <drc@linux.vnet.ibm.com>
> 
> Reviewed-by: Simon Horman <simon.horman@corigine.com>

nit: no empty lines between tags

There should be a "---" line between the tags and changelog.

>   v4:
>    - factoring common code into new function bnx2x_stop_nic()
>      that disables and releases IRQs and NAPIs 
>   v3:
>     - no changes, just repatched to the latest driver level
>     - updated the reviewed-by Manish in October, 2022
> 
>   v2:
>    - Check the state of the NIC before calling disable nappi
>      and freeing the IRQ
>    - Prevent recurrence of TX timeout by turning off the carrier,
>      calling netif_carrier_off() in bnx2x_tx_timeout()
>    - Check and bail out early if fp->page_pool already freed
>
> ---
>  drivers/net/ethernet/broadcom/bnx2x/bnx2x.h   |  2 ++

> @@ -3095,14 +3097,8 @@ int bnx2x_nic_unload(struct bnx2x *bp, int unload_mode, bool keep_link)
>  		if (!CHIP_IS_E1x(bp))
>  			bnx2x_pf_disable(bp);
>  
> -		/* Disable HW interrupts, NAPI */
> -		bnx2x_netif_stop(bp, 1);
> -		/* Delete all NAPI objects */
> -		bnx2x_del_all_napi(bp);
> -		if (CNIC_LOADED(bp))
> -			bnx2x_del_all_napi_cnic(bp);
> -		/* Release IRQs */
> -		bnx2x_free_irq(bp);

Could you split the change into two patches - one factoring out the
code into bnx2x_stop_nic() and the other adding the nic_stopped
variable? First one should be pure code refactoring with no functional
changes. That'd make the reviewing process easier.

> +		/* Disable HW interrupts, delete NAPIs, Release IRQs */
> +		bnx2x_stop_nic(bp);
>  
>  		/* Report UNLOAD_DONE to MCP */
>  		bnx2x_send_unload_done(bp, false);
> @@ -4987,6 +4983,12 @@ void bnx2x_tx_timeout(struct net_device *dev, unsigned int txqueue)
>  {
>  	struct bnx2x *bp = netdev_priv(dev);
>  
> +	/* Immediately indicate link as down */
> +	bp->link_vars.link_up = 0;
> +	bp->force_link_down = true;
> +	netif_carrier_off(dev);
> +	BNX2X_ERR("Indicating link is down due to Tx-timeout\n");

Is this code move to make the shutdown more immediate?
That could also be a separate patch.

>  	/* We want the information of the dump logged,
>  	 * but calling bnx2x_panic() would kill all chances of recovery.
>  	 */
> diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
> index d8b1824c334d..f5ecbe8d604a 100644
> --- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
> +++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
> @@ -1015,6 +1015,9 @@ static inline void bnx2x_free_rx_sge_range(struct bnx2x *bp,
>  {
>  	int i;
>  
> +	if (!fp->page_pool.page)
> +		return;
> +
>  	if (fp->mode == TPA_MODE_DISABLED)
>  		return;
>  
> @@ -1399,5 +1402,20 @@ void bnx2x_set_os_driver_state(struct bnx2x *bp, u32 state);
>   */
>  int bnx2x_nvram_read(struct bnx2x *bp, u32 offset, u8 *ret_buf,
>  		     int buf_size);
> +static inline void bnx2x_stop_nic(struct bnx2x *bp)

can't it live in bnx2x_cmn.c ? Why make it a static inline?

> +{
> +	if (!bp->nic_stopped) {
> +		/* Disable HW interrupts, NAPI */
> +		bnx2x_netif_stop(bp, 1);
> +		/* Delete all NAPI objects */
> +		bnx2x_del_all_napi(bp);
> +		if (CNIC_LOADED(bp))
> +			bnx2x_del_all_napi_cnic(bp);
> +		/* Release IRQs */
> +		bnx2x_free_irq(bp);
> +		bp->nic_stopped = true;
> +	}
> +}
> +
>  

nit: double new line

> --- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c
> +++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c
> @@ -529,13 +529,8 @@ void bnx2x_vfpf_close_vf(struct bnx2x *bp)
>  	bnx2x_vfpf_finalize(bp, &req->first_tlv);
>  
>  free_irq:
> -	/* Disable HW interrupts, NAPI */
> -	bnx2x_netif_stop(bp, 0);

This used to say 

	bnx2x_netif_stop(bp, 0);

but bnx2x_stop_nic() will do:

	bnx2x_netif_stop(bp, 1);

is it okay to shut down the HW here ? (whatever that entails)

> -	/* Delete all NAPI objects */
> -	bnx2x_del_all_napi(bp);
> -
> -	/* Release IRQs */
> -	bnx2x_free_irq(bp);
> +	/* Disable HW interrupts, delete NAPIs, Release IRQs */
> +	bnx2x_stop_nic(bp);
-- 
pw-bot: cr

