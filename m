Return-Path: <netdev+bounces-272222-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOpbIfqPxWlG/QQAu9opvQ
	(envelope-from <netdev+bounces-272222-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 20:58:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D967433B303
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 20:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 884AC303FFDD
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 19:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162203932DD;
	Thu, 26 Mar 2026 19:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VjL2urrk"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2BD37B02D
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 19:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774554993; cv=none; b=tlk3lfseHKahbH5rKUto4nGLdg6Zk+lNPdRobFVXpLLc5Bx3ADDgQwWCwgTYpbKWM4k9sfkAlvMB+dgeRgG4CIkF5s0ZN4DNHf3kLjKuEuTPlQV30bpqZ6N9eP2A3mI+xL+FVgf4MODwbKQssmfJRhP6fGqHxydRP6Gfpph5Trg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774554993; c=relaxed/simple;
	bh=8vsqQdfKeyqUWAguK8UnvZTeAhIn5Kn0XZ+L6K3Ue+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ADlHzDWeiazZEAlLSuxG4IcXQw29u20zOvMvWSfT+ef6HUBx4KFdirZ7HcmptlKfIupn9lDOzZS9xCuNaCrK8wGNqOZDKocWbnEU07V0W2Zo8FVq2sqSB1pI9E453IO1AK7wvagqye20gQK6gS/fMeP8cPZiPk/lJwj/cPAXGfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VjL2urrk; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c7f22eac-3098-4833-b247-3a615f49a5ea@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774554978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bdtXqquknGuUqL6GqA/v4IZ+ed3yZ+2k+ngeORMK4GU=;
	b=VjL2urrk/SBki+yQR99mMY549D5LYJaXb020OwkspvZRg1ZvpnrQXoZCeSdlUNyukZGhmm
	9XFYBIGzfQ+ZVZQYiBWD47PRtuOvFwf2Z3jF7fnU7xyaLFa3c1zNIELZ2DsYmqIvYm4ZiP
	J6QSLZ1hZsGw9XQoocRWwOk3qQbW24c=
Date: Thu, 26 Mar 2026 15:56:07 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net 2/2] net: xilinx: axienet: Fix BQL accounting for
 multi-BD TX packets
To: "Gupta, Suraj" <Suraj.Gupta2@amd.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "Simek, Michal" <michal.simek@amd.com>,
 "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
 "horms@kernel.org" <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Katakam, Harini" <harini.katakam@amd.com>
References: <20260324145353.1899248-1-suraj.gupta2@amd.com>
 <20260324145353.1899248-3-suraj.gupta2@amd.com>
 <cfaf4077-144a-4876-b6b0-8d4388362217@linux.dev>
 <SA1PR12MB6798E4EB242D58AEB86661B9C949A@SA1PR12MB6798.namprd12.prod.outlook.com>
 <9f6a4e9f-9f93-4ced-92de-8fdc6154c694@linux.dev>
 <SA1PR12MB679810BDE0FD91B702A869C2C956A@SA1PR12MB6798.namprd12.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <SA1PR12MB679810BDE0FD91B702A869C2C956A@SA1PR12MB6798.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272222-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.anderson@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,linux.dev:dkim,linux.dev:email,linux.dev:mid,lunn.ch:email,bootlin.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D967433B303
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/26/26 15:51, Gupta, Suraj wrote:
> [Public]
> 
>> -----Original Message-----
>> From: Sean Anderson <sean.anderson@linux.dev>
>> Sent: Thursday, March 26, 2026 9:08 PM
>> To: Gupta, Suraj <Suraj.Gupta2@amd.com>; andrew+netdev@lunn.ch;
>> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
>> pabeni@redhat.com; Simek, Michal <michal.simek@amd.com>; Pandey,
>> Radhey Shyam <radhey.shyam.pandey@amd.com>; horms@kernel.org
>> Cc: netdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>> kernel@vger.kernel.org; Katakam, Harini <harini.katakam@amd.com>
>> Subject: Re: [PATCH net 2/2] net: xilinx: axienet: Fix BQL accounting for multi-BD
>> TX packets
>>
>> Caution: This message originated from an External Source. Use proper caution
>> when opening attachments, clicking links, or responding.
>>
>>
>> On 3/25/26 01:30, Gupta, Suraj wrote:
>> > [Public]
>> >
>> >> -----Original Message-----
>> >> From: Sean Anderson <sean.anderson@linux.dev>
>> >> Sent: Tuesday, March 24, 2026 9:39 PM
>> >> To: Gupta, Suraj <Suraj.Gupta2@amd.com>; andrew+netdev@lunn.ch;
>> >> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
>> >> pabeni@redhat.com; Simek, Michal <michal.simek@amd.com>; Pandey,
>> >> Radhey Shyam <radhey.shyam.pandey@amd.com>; horms@kernel.org
>> >> Cc: netdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>> >> linux- kernel@vger.kernel.org; Katakam, Harini
>> >> <harini.katakam@amd.com>
>> >> Subject: Re: [PATCH net 2/2] net: xilinx: axienet: Fix BQL accounting
>> >> for multi-BD TX packets
>> >>
>> >> Caution: This message originated from an External Source. Use proper
>> >> caution when opening attachments, clicking links, or responding.
>> >>
>> >>
>> >> On 3/24/26 10:53, Suraj Gupta wrote:
>> >> > When a TX packet spans multiple buffer descriptors
>> >> > (scatter-gather), the per-BD byte count is accumulated into a local
>> >> > variable that resets on each NAPI poll. If the BDs for a single
>> >> > packet complete across different polls, the earlier bytes are lost and never
>> credited to BQL.
>> >> > This causes BQL to think bytes are permanently in-flight,
>> >> > eventually stalling the TX queue.
>> >> >
>> >> > Fix this by replacing the local accumulator with a persistent
>> >> > counter
>> >> > (tx_compl_bytes) that survives across polls and is reset only after
>> >> > updating BQL and stats.
>> >>
>> >> Do we need this? Can't we just do something like
>> >>
>> >
>> > Nope, the 'size' variable passed to axienet_free_tx_chain() is local
>> > to axienet_tx_poll() and goes out of scope between different polls.
>> > This means it can't track completion bytes across multiple NAPI polls.
>>
>> Yes, but that's fine since we only update completed bytes when we retire at
>> least one packet:
>>
>>         packets = axienet_free_tx_chain(lp, &size, budget);
>>         if (packets) {
>>                 netdev_completed_queue(ndev, packets, size);
>>                 u64_stats_update_begin(&lp->tx_stat_sync);
>>                 u64_stats_add(&lp->tx_packets, packets);
>>                 u64_stats_add(&lp->tx_bytes, size);
>>                 u64_stats_update_end(&lp->tx_stat_sync);
>>
>>                 /* Matches barrier in axienet_start_xmit */
>>                 smp_mb();
>>                 if (((tail - ci) & (lp->rx_bd_num - 1)) >= MAX_SKB_FRAGS + 1)
>>                         netif_wake_queue(ndev);
>>         }
>>
>> and this matches the value we use when enqueuing a packet
>>
>>         tail_p = lp->tx_bd_p + sizeof(*lp->tx_bd_v) * (last_p - lp->tx_bd_v);
>>         smp_store_release(&lp->tx_bd_tail, new_tail_ptr);
>>         netdev_sent_queue(ndev, skb->len);
>>
> 
> Let’s say we have a packet with 4 fragments. When xmit() is called, the last buffer descriptor (the 4th one) is marked with the retiral flag[1]. Now, during completion, suppose the first 3 buffer descriptors are processed in one NAPI poll, and the 4th descriptor is handled in a subsequent poll. In this scenario, the size won’t get updated for the first 3 BDs because there’s no packet retiral for them. Then, during the second poll, the size update will only reflect the completion length of the 4th BD.

That's why I suggested using skb->len and not the size from the descriptor.

--Sean

> This means that the bytes corresponding to the first 3 fragments are never credited to BQL, which leads to incorrect accounting and, eventually, to the TX queue stalling as described.
> Proposed changes to accumulate the completion length across polls until the entire packet is processed directly addresses this gap.
> 
> [1]: https://elixir.bootlin.com/linux/v7.0-rc5/source/drivers/net/ethernet/xilinx/xilinx_axienet_main.c#L1127
> 
> 
> Regards,
> Suraj
> 
>> > Regards,
>> > Suraj
>> >
>> >> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> >> b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> >> index 415e9bc252527..1ea8a6592bce1 100644
>> >> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> >> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> >> @@ -768,6 +768,7 @@ static int axienet_free_tx_chain(struct
>> >> axienet_local *lp, u32 *sizep, int budge
>> >>                 if (cur_p->skb) {
>> >>                         struct axienet_cb *cb = (void
>> >> *)cur_p->skb->cb;
>> >>
>> >> +                       *sizep += skb->len;
>> >>                         dma_unmap_sgtable(lp->dev, &cb->sgt, DMA_TO_DEVICE, 0);
>> >>                         sg_free_table_chained(&cb->sgt, XAE_INLINE_SG_CNT);
>> >>                         napi_consume_skb(cur_p->skb, budget); @@
>> >> -783,8 +784,6 @@ static int axienet_free_tx_chain(struct axienet_local *lp,
>> u32 *sizep, int budge
>> >>                 wmb();
>> >>                 cur_p->cntrl = 0;
>> >>                 cur_p->status = 0;
>> >> -
>> >> -               *sizep += status & XAXIDMA_BD_STS_ACTUAL_LEN_MASK;
>> >>         }
>> >>
>> >>         smp_store_release(&lp->tx_bd_ci, (ci + i) & (lp->tx_bd_num -
>> >> 1));
>> >>
>> >> > Fixes: c900e49d58eb ("net: xilinx: axienet: Implement BQL")
>> >> > Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
>> >> > ---
>> >> >  drivers/net/ethernet/xilinx/xilinx_axienet.h  |  3 +++
>> >> > .../net/ethernet/xilinx/xilinx_axienet_main.c | 20
>> >> > +++++++++----------
>> >> >  2 files changed, 13 insertions(+), 10 deletions(-)
>> >> >
>> >> > diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h
>> >> > b/drivers/net/ethernet/xilinx/xilinx_axienet.h
>> >> > index 602389843342..a4444c939451 100644
>> >> > --- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
>> >> > +++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
>> >> > @@ -509,6 +509,8 @@ struct skbuf_dma_descriptor {
>> >> >   *           complete. Only updated at runtime by TX NAPI poll.
>> >> >   * @tx_bd_tail:      Stores the index of the next Tx buffer descriptor in the
>> ring
>> >> >   *              to be populated.
>> >> > + * @tx_compl_bytes: Accumulates TX completion length until a full
>> packet is
>> >> > + *              reported to the stack.
>> >> >   * @tx_packets: TX packet count for statistics
>> >> >   * @tx_bytes:        TX byte count for statistics
>> >> >   * @tx_stat_sync: Synchronization object for TX stats @@ -592,6
>> >> > +594,7 @@ struct axienet_local {
>> >> >       u32 tx_bd_num;
>> >> >       u32 tx_bd_ci;
>> >> >       u32 tx_bd_tail;
>> >> > +     u32 tx_compl_bytes;
>> >> >       u64_stats_t tx_packets;
>> >> >       u64_stats_t tx_bytes;
>> >> >       struct u64_stats_sync tx_stat_sync; diff --git
>> >> > a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> >> > b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> >> > index b06e4c37ff61..95bf61986cb7 100644
>> >> > --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> >> > +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> >> > @@ -692,6 +692,8 @@ static void axienet_dma_stop(struct
>> >> > axienet_local
>> >> *lp)
>> >> >       axienet_lock_mii(lp);
>> >> >       __axienet_device_reset(lp);
>> >> >       axienet_unlock_mii(lp);
>> >> > +
>> >> > +     lp->tx_compl_bytes = 0;
>> >> >  }
>> >> >
>> >> >  /**
>> >> > @@ -770,8 +772,6 @@ static int axienet_device_reset(struct
>> >> > net_device
>> >> *ndev)
>> >> >   * @first_bd:        Index of first descriptor to clean up
>> >> >   * @nr_bds:  Max number of descriptors to clean up
>> >> >   * @force:   Whether to clean descriptors even if not complete
>> >> > - * @sizep:   Pointer to a u32 filled with the total sum of all bytes
>> >> > - *           in all cleaned-up descriptors. Ignored if NULL.
>> >> >   * @budget:  NAPI budget (use 0 when not called from NAPI poll)
>> >> >   *
>> >> >   * Would either be called after a successful transmit operation,
>> >> > or after @@ -780,7 +780,7 @@ static int axienet_device_reset(struct
>> >> > net_device
>> >> *ndev)
>> >> >   * Return: The number of packets handled.
>> >> >   */
>> >> >  static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
>> >> > -                              int nr_bds, bool force, u32 *sizep, int budget)
>> >> > +                              int nr_bds, bool force, int budget)
>> >> >  {
>> >> >       struct axidma_bd *cur_p;
>> >> >       unsigned int status;
>> >> > @@ -819,8 +819,8 @@ static int axienet_free_tx_chain(struct
>> >> > axienet_local
>> >> *lp, u32 first_bd,
>> >> >               cur_p->cntrl = 0;
>> >> >               cur_p->status = 0;
>> >> >
>> >> > -             if (sizep)
>> >> > -                     *sizep += status & XAXIDMA_BD_STS_ACTUAL_LEN_MASK;
>> >> > +             if (!force)
>> >> > +                     lp->tx_compl_bytes += status &
>> >> > + XAXIDMA_BD_STS_ACTUAL_LEN_MASK;
>> >> >       }
>> >> >
>> >> >       if (!force) {
>> >> > @@ -999,18 +999,18 @@ static int axienet_tx_poll(struct napi_struct
>> >> > *napi, int budget)  {
>> >> >       struct axienet_local *lp = container_of(napi, struct axienet_local,
>> napi_tx);
>> >> >       struct net_device *ndev = lp->ndev;
>> >> > -     u32 size = 0;
>> >> >       int packets;
>> >> >
>> >> >       packets = axienet_free_tx_chain(lp, lp->tx_bd_ci, lp->tx_bd_num, false,
>> >> > -                                     &size, budget);
>> >> > +                                     budget);
>> >> >
>> >> >       if (packets) {
>> >> > -             netdev_completed_queue(ndev, packets, size);
>> >> > +             netdev_completed_queue(ndev, packets,
>> >> > + lp->tx_compl_bytes);
>> >> >               u64_stats_update_begin(&lp->tx_stat_sync);
>> >> >               u64_stats_add(&lp->tx_packets, packets);
>> >> > -             u64_stats_add(&lp->tx_bytes, size);
>> >> > +             u64_stats_add(&lp->tx_bytes, lp->tx_compl_bytes);
>> >> >               u64_stats_update_end(&lp->tx_stat_sync);
>> >> > +             lp->tx_compl_bytes = 0;
>> >> >
>> >> >               /* Matches barrier in axienet_start_xmit */
>> >> >               smp_mb();
>> >> > @@ -1115,7 +1115,7 @@ axienet_start_xmit(struct sk_buff *skb,
>> >> > struct
>> >> net_device *ndev)
>> >> >                               netdev_err(ndev, "TX DMA mapping error\n");
>> >> >                       ndev->stats.tx_dropped++;
>> >> >                       axienet_free_tx_chain(lp, orig_tail_ptr, ii + 1,
>> >> > -                                           true, NULL, 0);
>> >> > +                                           true, 0);
>> >> >                       dev_kfree_skb_any(skb);
>> >> >                       return NETDEV_TX_OK;
>> >> >               }


