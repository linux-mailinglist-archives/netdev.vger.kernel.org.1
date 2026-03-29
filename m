Return-Path: <netdev+bounces-272986-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mZOcM+GByWmBygUAu9opvQ
	(envelope-from <netdev+bounces-272986-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 21:47:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24645353D2E
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 21:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FFFF300A625
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 19:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01B1244692;
	Sun, 29 Mar 2026 19:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTVT1+9i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4451C8634
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 19:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774813662; cv=none; b=Q1KR2m/lzJneTsKuhvqPXRDCUas5IO/IeSo/0xnxd8EtkhPqc+MQPfnV+eK93kuLrmPurymQkxINDGKXGH5AWPmjfDSyn05RC/6Vvnc29gfBXVFTuMWFQku27Ih5eiYYG7kLnHcMjiGamghf1AoKx9U1xkyx3jci3lTybNq2ITc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774813662; c=relaxed/simple;
	bh=VdsmcZtSyn1wbk6ZOA7ply1vgF/F82CyH5qHYy+OqyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pKlQBAX4S9GHCWIxncIqwvOHWqW5ZB2RjdUDNT1GAFYRte+EcIGaZmMq6a80Qshess5Ui2+bpsZ61BjB0RZNEL884r/xXhFCxOUbMMYcrTA9aiCM280y0P11pLRUKZ+BcbrvzJwGPNd2ooW1BHyJt31zFXstO4rGYB6Vpi0pe5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTVT1+9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98014C116C6;
	Sun, 29 Mar 2026 19:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774813662;
	bh=VdsmcZtSyn1wbk6ZOA7ply1vgF/F82CyH5qHYy+OqyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WTVT1+9io29TCDtJ79uxcKoMbz9Vsf6tTAEp7dqBzS7o90K+SfmjMx1wMraV7ktCW
	 0s0NzGNTjV7I/jR3gaXC4Al3ZDlWu/kpuJuWiSRgm2Q/zd8s3HyCOXQ5Ro9ADtlYQF
	 rYITigzfzvXpVkhUDGgKWIh+qrWyLeECzzZtGqBjdsKjXMB/18wl5tnei5f6znwD/q
	 yCyKIvdXrMPa192zN2MeBM7unkP775gmytXRsMWRqemdVzWsa9u2Ax+etXCXgQxps2
	 omEZpIxcoStoEfeUUnYynJVrxdQGqTtVS0D80NXMivmb7sVpHqLfpkIFvDJUL5zUYG
	 ZN4yljVzE7okA==
From: Jakub Kicinski <kuba@kernel.org>
To: pvalerio@redhat.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	lorenzo@kernel.org,
	theo.lebrun@bootlin.com,
	nb@tipi-net.de
Subject: Re: [PATCH net-next v6 1/7] net: macb: move Rx buffers alloc from link up to open
Date: Sun, 29 Mar 2026 12:47:35 -0700
Message-ID: <20260329194735.2781096-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323221047.2749577-2-pvalerio@redhat.com>
References: <20260323221047.2749577-2-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-272986-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 24645353D2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: macb: move Rx buffers alloc from link up to open

This commit moves the Rx buffer allocation in the macb driver from link up
to open. It allows the initialization to fail early and loudly if the
Rx rings cannot be refilled, rather than initializing the device in a
broken state.

[ ... ]

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 1cb49252abf5..38302cba05ad 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -1504,6 +1505,7 @@ static void gem_rx_refill(struct macb_queue *queue)
>  			if (unlikely(!skb)) {
>  				netdev_err(bp->dev,
>  					   "Unable to allocate sk_buff\n");
> +				err = -ENOMEM;
>  				break;
>  			}

If dma_map_single() fails shortly after this block, the code frees the
allocated skb and breaks out of the loop:

	paddr = dma_map_single(&bp->pdev->dev, skb->data,
			       bp->rx_buffer_size,
			       DMA_FROM_DEVICE);
	if (dma_mapping_error(&bp->pdev->dev, paddr)) {
		dev_kfree_skb(skb);
		break;
	}

Does this cause the function to return 0 (success) despite the DMA mapping
failure, bypassing the new fail-early design?

[ ... ]

> @@ -6108,12 +6127,20 @@ static int __maybe_unused macb_resume(struct device *dev)
>  	for (q = 0, queue = bp->queues; q < bp->num_queues;
>  	     ++q, ++queue) {
>  		if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC)) {
> -			if (macb_is_gem(bp))
> -				gem_init_rx_ring(queue);
> -			else
> +			if (macb_is_gem(bp)) {
> +				err = gem_init_rx_ring(queue);
> +				if (err) {
> +					dev_err(dev, "Unable to init RX ring: %d\n", err);
> +					return err;
> +				}
> +			} else {
>  				macb_init_rx_ring(queue);
> +			}
>  		}
> +	}
>  
> +	for (q = 0, queue = bp->queues; q < bp->num_queues;
> +	     ++q, ++queue) {
>  		napi_enable(&queue->napi_rx);
>  		napi_enable(&queue->napi_tx);
>  	}

If gem_init_rx_ring() fails and we return err early here, the subsequent
loop that calls napi_enable() is skipped.

Since NAPI was disabled during suspend, the NAPI context remains in a
disabled state. If the interface is later administratively brought down,
.ndo_stop (macb_close) will unconditionally call napi_disable().

Can calling napi_disable() on an already disabled NAPI context cause an
infinite loop and a hard kernel deadlock in this scenario?
-- 
pw-bot: cr

