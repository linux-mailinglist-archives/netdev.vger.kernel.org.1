Return-Path: <netdev+bounces-271161-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EW3M8O4wmlilAQAu9opvQ
	(envelope-from <netdev+bounces-271161-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:16:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9374D318D0D
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90DBE30CB8C3
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F183F3B27EF;
	Tue, 24 Mar 2026 16:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qSiWh7yY"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF4535A388
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 16:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774368570; cv=none; b=fZqND6ah8WVUABq3zPJEeFQ9UBg3dleBsT3heJ0YVSrxJ0rC1TTXiS4UiYfvFZTmcE0FExqo2n40hJzi4/mimzBI8foi5i5LD2cnt+H7UvFnpgV+1iyng6ThpdPn6pD+a9+1Vt08LuZDumZf0X4U2iEmiQ/lqn38tMzujRpRtmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774368570; c=relaxed/simple;
	bh=Sz9kUo6deDneVXClMdOf2aaDC4MhNRkUAlmaVpOCVXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eVxb9VnSVUGV0wjl8xg5UN2n5Xs+SXzNwgazLvZD8g52w9LdiG7Plklv3xdCCCzghmy4TpgUVlTq3ox8wqFtjxZ18i5PYISvomtbettK3YPnWdn55qIMRtK0GVM9RKV+uGELSnAFQS9w81YhaG0FLpNkDPg3M8koPex7JbqZfac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qSiWh7yY; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cfaf4077-144a-4876-b6b0-8d4388362217@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774368557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q9HnuHlSuBejVcQaUC7IGTPI3zmgypr9vBTmv2lZWRQ=;
	b=qSiWh7yYiVFnUisxmjTZTQQ0ii6l53riqvrgCbjqQKxS3pV5P2amhE0GVBoPnWQxqBpebR
	/uozWB1BNPZ4OuxnnhyCR+mGwiyuf7/q+eHoy8TWn3nazEwyD6FKdDReqeQZhBrUihMrR4
	8rhB0NCI9wY5hq0ndYx+9Td05Jkjd5U=
Date: Tue, 24 Mar 2026 12:09:04 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net 2/2] net: xilinx: axienet: Fix BQL accounting for
 multi-BD TX packets
To: Suraj Gupta <suraj.gupta2@amd.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, michal.simek@amd.com, radhey.shyam.pandey@amd.com,
 horms@kernel.org
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, harini.katakam@amd.com
References: <20260324145353.1899248-1-suraj.gupta2@amd.com>
 <20260324145353.1899248-3-suraj.gupta2@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20260324145353.1899248-3-suraj.gupta2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271161-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.anderson@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid,amd.com:email]
X-Rspamd-Queue-Id: 9374D318D0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/24/26 10:53, Suraj Gupta wrote:
> When a TX packet spans multiple buffer descriptors (scatter-gather),
> the per-BD byte count is accumulated into a local variable that resets
> on each NAPI poll. If the BDs for a single packet complete across
> different polls, the earlier bytes are lost and never credited to BQL.
> This causes BQL to think bytes are permanently in-flight, eventually
> stalling the TX queue.
> 
> Fix this by replacing the local accumulator with a persistent counter
> (tx_compl_bytes) that survives across polls and is reset only after
> updating BQL and stats.

Do we need this? Can't we just do something like

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 415e9bc252527..1ea8a6592bce1 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -768,6 +768,7 @@ static int axienet_free_tx_chain(struct axienet_local *lp, u32 *sizep, int budge
                if (cur_p->skb) {
                        struct axienet_cb *cb = (void *)cur_p->skb->cb;
 
+                       *sizep += skb->len;
                        dma_unmap_sgtable(lp->dev, &cb->sgt, DMA_TO_DEVICE, 0);
                        sg_free_table_chained(&cb->sgt, XAE_INLINE_SG_CNT);
                        napi_consume_skb(cur_p->skb, budget);
@@ -783,8 +784,6 @@ static int axienet_free_tx_chain(struct axienet_local *lp, u32 *sizep, int budge
                wmb();
                cur_p->cntrl = 0;
                cur_p->status = 0;
-
-               *sizep += status & XAXIDMA_BD_STS_ACTUAL_LEN_MASK;
        }
 
        smp_store_release(&lp->tx_bd_ci, (ci + i) & (lp->tx_bd_num - 1));

> Fixes: c900e49d58eb ("net: xilinx: axienet: Implement BQL")
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> ---
>  drivers/net/ethernet/xilinx/xilinx_axienet.h  |  3 +++
>  .../net/ethernet/xilinx/xilinx_axienet_main.c | 20 +++++++++----------
>  2 files changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> index 602389843342..a4444c939451 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> @@ -509,6 +509,8 @@ struct skbuf_dma_descriptor {
>   *		complete. Only updated at runtime by TX NAPI poll.
>   * @tx_bd_tail:	Stores the index of the next Tx buffer descriptor in the ring
>   *              to be populated.
> + * @tx_compl_bytes: Accumulates TX completion length until a full packet is
> + *              reported to the stack.
>   * @tx_packets: TX packet count for statistics
>   * @tx_bytes:	TX byte count for statistics
>   * @tx_stat_sync: Synchronization object for TX stats
> @@ -592,6 +594,7 @@ struct axienet_local {
>  	u32 tx_bd_num;
>  	u32 tx_bd_ci;
>  	u32 tx_bd_tail;
> +	u32 tx_compl_bytes;
>  	u64_stats_t tx_packets;
>  	u64_stats_t tx_bytes;
>  	struct u64_stats_sync tx_stat_sync;
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index b06e4c37ff61..95bf61986cb7 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -692,6 +692,8 @@ static void axienet_dma_stop(struct axienet_local *lp)
>  	axienet_lock_mii(lp);
>  	__axienet_device_reset(lp);
>  	axienet_unlock_mii(lp);
> +
> +	lp->tx_compl_bytes = 0;
>  }
>  
>  /**
> @@ -770,8 +772,6 @@ static int axienet_device_reset(struct net_device *ndev)
>   * @first_bd:	Index of first descriptor to clean up
>   * @nr_bds:	Max number of descriptors to clean up
>   * @force:	Whether to clean descriptors even if not complete
> - * @sizep:	Pointer to a u32 filled with the total sum of all bytes
> - *		in all cleaned-up descriptors. Ignored if NULL.
>   * @budget:	NAPI budget (use 0 when not called from NAPI poll)
>   *
>   * Would either be called after a successful transmit operation, or after
> @@ -780,7 +780,7 @@ static int axienet_device_reset(struct net_device *ndev)
>   * Return: The number of packets handled.
>   */
>  static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
> -				 int nr_bds, bool force, u32 *sizep, int budget)
> +				 int nr_bds, bool force, int budget)
>  {
>  	struct axidma_bd *cur_p;
>  	unsigned int status;
> @@ -819,8 +819,8 @@ static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
>  		cur_p->cntrl = 0;
>  		cur_p->status = 0;
>  
> -		if (sizep)
> -			*sizep += status & XAXIDMA_BD_STS_ACTUAL_LEN_MASK;
> +		if (!force)
> +			lp->tx_compl_bytes += status & XAXIDMA_BD_STS_ACTUAL_LEN_MASK;
>  	}
>  
>  	if (!force) {
> @@ -999,18 +999,18 @@ static int axienet_tx_poll(struct napi_struct *napi, int budget)
>  {
>  	struct axienet_local *lp = container_of(napi, struct axienet_local, napi_tx);
>  	struct net_device *ndev = lp->ndev;
> -	u32 size = 0;
>  	int packets;
>  
>  	packets = axienet_free_tx_chain(lp, lp->tx_bd_ci, lp->tx_bd_num, false,
> -					&size, budget);
> +					budget);
>  
>  	if (packets) {
> -		netdev_completed_queue(ndev, packets, size);
> +		netdev_completed_queue(ndev, packets, lp->tx_compl_bytes);
>  		u64_stats_update_begin(&lp->tx_stat_sync);
>  		u64_stats_add(&lp->tx_packets, packets);
> -		u64_stats_add(&lp->tx_bytes, size);
> +		u64_stats_add(&lp->tx_bytes, lp->tx_compl_bytes);
>  		u64_stats_update_end(&lp->tx_stat_sync);
> +		lp->tx_compl_bytes = 0;
>  
>  		/* Matches barrier in axienet_start_xmit */
>  		smp_mb();
> @@ -1115,7 +1115,7 @@ axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  				netdev_err(ndev, "TX DMA mapping error\n");
>  			ndev->stats.tx_dropped++;
>  			axienet_free_tx_chain(lp, orig_tail_ptr, ii + 1,
> -					      true, NULL, 0);
> +					      true, 0);
>  			dev_kfree_skb_any(skb);
>  			return NETDEV_TX_OK;
>  		}

