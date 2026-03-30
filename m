Return-Path: <netdev+bounces-273299-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMPqI2bGymmL/wUAu9opvQ
	(envelope-from <netdev+bounces-273299-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 20:52:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB80C35FF98
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 20:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88702303F055
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 18:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A16B3DFC69;
	Mon, 30 Mar 2026 18:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dXamNKUK"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795733346A0
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 18:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774896626; cv=none; b=fiJk9jZnlf90Som/SJ+hpsBJgUjTT46LaOQa9ggl/ULZKrnvYUuTf6PQZBaNlQzCM46aeqj+jpv/TeS1578p2LhrPO4uJprbBGDcZVDUtDkOuRFkKGixKoScJPOxVarASvWr8CpMBoPiuyDsvclyo/+sVhkym0GD+VH/CRuSUZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774896626; c=relaxed/simple;
	bh=QsrmC22upVvQWb1ttkE2gs6nFEWpOFmpRk7fl+hFzkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iw08xsCpM6n56tq2AvswwcaLa6JcXiBQMdPNM33UhqiAZ/quVisVKbWdC2CH6NK0PMSSyp5esmVR/xcJPHr8VdoUTyM4sGDmTg1QAWiA9EnJkRP76hcfrez21Yi2xABdiHiDM1whjAcvU2Itb9mFqtwhOmuQFmfguyhc34XBmRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dXamNKUK; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8a57e85b-8917-48b8-9412-b10a38fa230b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774896612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZbI/xWQ/rrC6wAb85E1XodfYiivSfrUvb5aJFFUK0R4=;
	b=dXamNKUKlXf3V7TOgKCvckNA8R4hlEefGV1lkULsTRrQwPcO2HWM0lPy99bob7KpucHVR2
	/8gwDkVk+iRKYIITKU+oy1ANThY8TLqSVDzZVX4hMvZS5Rr2cSLcS00JMdKNC/JI5oV52B
	Z4J7fYAAc5CJeelap4+eCNbFtAmW+oU=
Date: Mon, 30 Mar 2026 14:49:59 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net V2 2/2] net: xilinx: axienet: Fix BQL accounting for
 multi-BD TX packets
To: Suraj Gupta <suraj.gupta2@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Michal Simek <michal.simek@amd.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Ariane Keller <ariane.keller@tik.ee.ethz.ch>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260327073238.134948-1-suraj.gupta2@amd.com>
 <20260327073238.134948-3-suraj.gupta2@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20260327073238.134948-3-suraj.gupta2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273299-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: DB80C35FF98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/27/26 03:32, Suraj Gupta wrote:
> When a TX packet spans multiple buffer descriptors (scatter-gather),
> axienet_free_tx_chain sums the per-BD actual length from descriptor
> status into a caller-provided accumulator. That sum is reset on each
> NAPI poll. If the BDs for a single packet complete across different
> polls, the earlier bytes are lost and never credited to BQL. This
> causes BQL to think bytes are permanently in-flight, eventually
> stalling the TX queue.
> 
> The SKB pointer is stored only on the last BD of a packet. When that
> BD completes, use skb->len for the byte count instead of summing
> per-BD status lengths. This matches netdev_sent_queue(), which debits
> skb->len, and naturally survives across polls because no partial
> packet contributes to the accumulator.
> 
> Fixes: c900e49d58eb ("net: xilinx: axienet: Implement BQL")
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> ---
>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index b06e4c37ff61..263c4b67fd5a 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -770,8 +770,8 @@ static int axienet_device_reset(struct net_device *ndev)
>   * @first_bd:	Index of first descriptor to clean up
>   * @nr_bds:	Max number of descriptors to clean up
>   * @force:	Whether to clean descriptors even if not complete
> - * @sizep:	Pointer to a u32 filled with the total sum of all bytes
> - *		in all cleaned-up descriptors. Ignored if NULL.
> + * @sizep:	Pointer to a u32 accumulating the total byte count of
> + *		completed packets (using skb->len). Ignored if NULL.
>   * @budget:	NAPI budget (use 0 when not called from NAPI poll)
>   *
>   * Would either be called after a successful transmit operation, or after
> @@ -805,6 +805,8 @@ static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
>  				 DMA_TO_DEVICE);
>  
>  		if (cur_p->skb && (status & XAXIDMA_BD_STS_COMPLETE_MASK)) {
> +			if (sizep)
> +				*sizep += cur_p->skb->len;
>  			napi_consume_skb(cur_p->skb, budget);
>  			packets++;
>  		}
> @@ -818,9 +820,6 @@ static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
>  		wmb();
>  		cur_p->cntrl = 0;
>  		cur_p->status = 0;
> -
> -		if (sizep)
> -			*sizep += status & XAXIDMA_BD_STS_ACTUAL_LEN_MASK;
>  	}
>  
>  	if (!force) {

Reviewed-by: Sean Anderson <sean.anderson@linux.dev>

Although FWIW this may result in slightly-different statistics. Not sure
if we care since this will only affect packets that could not be sent
for whatever reason (collisions, loss of carrier, etc.)

