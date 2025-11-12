Return-Path: <netdev+bounces-237798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAC2C504B8
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 03:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 025024E5ADC
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 02:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7C8255E53;
	Wed, 12 Nov 2025 02:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfimH5Ym"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263741EFF9B;
	Wed, 12 Nov 2025 02:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762913094; cv=none; b=Yfe6Izxoty6B5QMUS6aAB1Y+KJ7v8pS6SERP2DnIGBhH8WMXfNwfXhCQ5OVl+fd9dulfHrFXbk/JvzYFZInWPs8pFj0jIdZodJdMlb7AC06VaBt7LqUXW7Di4JnsdylH8xxoX8pN1Z8+yhCBXHYLsV5S//1N/a+2F1vVOCl5ZYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762913094; c=relaxed/simple;
	bh=Uz5EtMpVn6519xtKF+vC8bmfybmH8hJy0801N8rm/0E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ffmXuF0kbmRCXzOcCtUXu12510jGCk5nXp+Q20B+fg1vH6NaNWbMNDj45WQqkJYUpeSlcYTOTDP3kOFYumOzWrNd/t+nGuVYPNSFopw3m5x3UvmHyLCyEOGn9nFETZ++G6yE+MHkJ5tXAfOaLcoqYpF0Lf25pYy3X1fTUPt8ie8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfimH5Ym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181E9C4CEF5;
	Wed, 12 Nov 2025 02:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762913093;
	bh=Uz5EtMpVn6519xtKF+vC8bmfybmH8hJy0801N8rm/0E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SfimH5Ymq9+ZbUxv0zM93q32qDniKAP6tfxR1/i/RjL5r7IDdzB55S2ZkvWbTfScU
	 r/ipl1c8XnG3MaW82bNzP+jBX30kmI+EDfRgbwHC6n4ib19i7CyKtvTb7QGJqoSpuw
	 c+pItosmZSbf86kKRMrmlVXqQ41EyVw3wqDctH+G9RiYZ/1rJP9+AETWlmMjn0+idI
	 wFIncnF7vGpvuWtbWgixKjrf/Gvfe0Oeayc8C9CfiYAM9tTgkIx6E2TEzd1oSI6SA0
	 94Obomw2t+GTBbBQyl831yEhgBOPfYjZKkd+wuGFzIupRD3ilLhFkwJ46U88qUKo00
	 NcKHrikY/VIiA==
Date: Tue, 11 Nov 2025 18:04:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fuchs <fuchsfl@gmail.com>
Cc: Geoff Levand <geoff@infradead.org>, netdev@vger.kernel.org, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: ps3_gelic_net: handle skb allocation failures
Message-ID: <20251111180451.0ef1dc9c@kernel.org>
In-Reply-To: <20251110114523.3099559-1-fuchsfl@gmail.com>
References: <20251110114523.3099559-1-fuchsfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Nov 2025 12:45:23 +0100 Florian Fuchs wrote:
> Handle skb allocation failures in RX path, to avoid NULL pointer
> dereference and RX stalls under memory pressure. If the refill fails
> with -ENOMEM, complete napi polling and wake up later to retry via timer.
> Also explicitly re-enable RX DMA after oom, so the dmac doesn't remain
> stopped in this situation.
> 
> Previously, memory pressure could lead to skb allocation failures and
> subsequent Oops like:
> 
> 	Oops: Kernel access of bad area, sig: 11 [#2]
> 	Hardware name: SonyPS3 Cell Broadband Engine 0x701000 PS3
> 	NIP [c0003d0000065900] gelic_net_poll+0x6c/0x2d0 [ps3_gelic] (unreliable)
> 	LR [c0003d00000659c4] gelic_net_poll+0x130/0x2d0 [ps3_gelic]
> 	Call Trace:
> 	  gelic_net_poll+0x130/0x2d0 [ps3_gelic] (unreliable)
> 	  __napi_poll+0x44/0x168
> 	  net_rx_action+0x178/0x290
> 
> Steps to reproduce the issue:
> 	1. Start a continuous network traffic, like scp of a 20GB file
> 	2. Inject failslab errors using the kernel fault injection:
> 	    echo -1 > /sys/kernel/debug/failslab/times
> 	    echo 30 > /sys/kernel/debug/failslab/interval
> 	    echo 100 > /sys/kernel/debug/failslab/probability
> 	3. After some time, traces start to appear, kernel Oopses
> 	   and the system stops
> 
> Step 2 is not always necessary, as it is usually already triggered by
> the transfer of a big enough file.

Have you actually tested this on a real device?
Please describe the testing you have done rather that "how to test".

> Fixes: 02c1889166b4 ("ps3: gigabit ethernet driver for PS3, take3")
> Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
> ---
>  drivers/net/ethernet/toshiba/ps3_gelic_net.c | 54 +++++++++++++++-----
>  drivers/net/ethernet/toshiba/ps3_gelic_net.h |  1 +
>  2 files changed, 42 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.c b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
> index 5ee8e8980393..a8121f7583f9 100644
> --- a/drivers/net/ethernet/toshiba/ps3_gelic_net.c
> +++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
> @@ -259,6 +259,7 @@ void gelic_card_down(struct gelic_card *card)
>  	mutex_lock(&card->updown_lock);
>  	if (atomic_dec_if_positive(&card->users) == 0) {
>  		pr_debug("%s: real do\n", __func__);
> +		timer_delete_sync(&card->rx_oom_timer);
>  		napi_disable(&card->napi);

I think the ordering here should be inverted

>  		/*
>  		 * Disable irq. Wireless interrupts will
> @@ -970,7 +971,8 @@ static void gelic_net_pass_skb_up(struct gelic_descr *descr,
>   * gelic_card_decode_one_descr - processes an rx descriptor
>   * @card: card structure
>   *
> - * returns 1 if a packet has been sent to the stack, otherwise 0
> + * returns 1 if a packet has been sent to the stack, -ENOMEM on skb alloc
> + * failure, otherwise 0
>   *
>   * processes an rx descriptor by iommu-unmapping the data buffer and passing
>   * the packet up to the stack
> @@ -981,16 +983,17 @@ static int gelic_card_decode_one_descr(struct gelic_card *card)
>  	struct gelic_descr_chain *chain = &card->rx_chain;
>  	struct gelic_descr *descr = chain->head;
>  	struct net_device *netdev = NULL;
> -	int dmac_chain_ended;
> +	int dmac_chain_ended = 0;
>  
>  	status = gelic_descr_get_status(descr);
>  
>  	if (status == GELIC_DESCR_DMA_CARDOWNED)
>  		return 0;
>  
> -	if (status == GELIC_DESCR_DMA_NOT_IN_USE) {
> +	if (status == GELIC_DESCR_DMA_NOT_IN_USE || !descr->skb) {
>  		dev_dbg(ctodev(card), "dormant descr? %p\n", descr);
> -		return 0;
> +		dmac_chain_ended = 1;
> +		goto refill;
>  	}
>  
>  	/* netdevice select */
> @@ -1048,9 +1051,10 @@ static int gelic_card_decode_one_descr(struct gelic_card *card)
>  refill:
>  
>  	/* is the current descriptor terminated with next_descr == NULL? */
> -	dmac_chain_ended =
> -		be32_to_cpu(descr->hw_regs.dmac_cmd_status) &
> -		GELIC_DESCR_RX_DMA_CHAIN_END;
> +	if (!dmac_chain_ended)
> +		dmac_chain_ended =
> +			be32_to_cpu(descr->hw_regs.dmac_cmd_status) &
> +			GELIC_DESCR_RX_DMA_CHAIN_END;

TBH handling the OOM inside the Rx function seems a little fragile.
What if there is a packet to Rx as we enter. I don't see any loop here
it just replaces the used buffer..

>  	/*
>  	 * So that always DMAC can see the end
>  	 * of the descriptor chain to avoid
> @@ -1062,10 +1066,12 @@ static int gelic_card_decode_one_descr(struct gelic_card *card)
>  	gelic_descr_set_status(descr, GELIC_DESCR_DMA_NOT_IN_USE);
>  
>  	/*
> -	 * this call can fail, but for now, just leave this
> -	 * descriptor without skb
> +	 * this call can fail, propagate the error
>  	 */
> -	gelic_descr_prepare_rx(card, descr);
> +	int ret = gelic_descr_prepare_rx(card, descr);
> +

please dont declare variables half way thru a function and dont
separate function call from its error check with empty lines

> +	if (ret)
> +		return ret;
>  
>  	chain->tail = descr;
>  	chain->head = descr->next;
> @@ -1087,6 +1093,17 @@ static int gelic_card_decode_one_descr(struct gelic_card *card)
>  	return 1;
>  }
>  
> +/**
> + *  gelic_rx_oom_timer - Restart napi poll if oom occurred
> + *  @t: timer list
> + */

This kdoc is worthless 

> +static void gelic_rx_oom_timer(struct timer_list *t)
> +{
> +	struct gelic_card *card = timer_container_of(card, t, rx_oom_timer);
> +
> +	napi_schedule(&card->napi);
> +}
> +
>  /**
>   * gelic_net_poll - NAPI poll function called by the stack to return packets
>   * @napi: napi structure
> @@ -1099,12 +1116,21 @@ static int gelic_net_poll(struct napi_struct *napi, int budget)
>  {
>  	struct gelic_card *card = container_of(napi, struct gelic_card, napi);
>  	int packets_done = 0;
> +	int work_result = 0;
>  
>  	while (packets_done < budget) {
> -		if (!gelic_card_decode_one_descr(card))
> -			break;
> +		work_result = gelic_card_decode_one_descr(card);
> +		if (work_result == 1) {
> +			packets_done++;
> +			continue;
> +		}
> +		break;

common / success path should be the less indented one.

> +	}
>  
> -		packets_done++;
> +	if (work_result == -ENOMEM) {
> +		napi_complete_done(napi, packets_done);
> +		mod_timer(&card->rx_oom_timer, jiffies + 1);
> +		return packets_done;
>  	}
>  
>  	if (packets_done < budget) {
> @@ -1576,6 +1602,8 @@ static struct gelic_card *gelic_alloc_card_net(struct net_device **netdev)
>  	mutex_init(&card->updown_lock);
>  	atomic_set(&card->users, 0);
>  
> +	timer_setup(&card->rx_oom_timer, gelic_rx_oom_timer, 0);
> +
>  	return card;
>  }
>  
> diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.h b/drivers/net/ethernet/toshiba/ps3_gelic_net.h
> index f7d7931e51b7..c10f1984a5a1 100644
> --- a/drivers/net/ethernet/toshiba/ps3_gelic_net.h
> +++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.h
> @@ -268,6 +268,7 @@ struct gelic_vlan_id {
>  struct gelic_card {
>  	struct napi_struct napi;
>  	struct net_device *netdev[GELIC_PORT_MAX];
> +	struct timer_list rx_oom_timer;
>  	/*
>  	 * hypervisor requires irq_status should be
>  	 * 8 bytes aligned, but u64 member is
> 
> base-commit: 96a9178a29a6b84bb632ebeb4e84cf61191c73d5
-- 
pw-bot: cr

