Return-Path: <netdev+bounces-228185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A571BC420C
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 11:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6EBCB4EA6C5
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 09:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E143A2F28E0;
	Wed,  8 Oct 2025 09:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyM1v587"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70DC23ABA1;
	Wed,  8 Oct 2025 09:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759914830; cv=none; b=hPiBmGoD03M1WfKOrCkUcYJIRT//jzhBUql927E7bEjKvAkJQFc0dvhqdmp2dlniFwkciRfX3OjdDZ+0YEnmhctQ3W6qjCYm97/0bTIGAyxq5JjT2/NagUNVFYmQ9A04qv2hY1VH69rdg0DEgmEEW3E3AdWPieN0uegDCUAdDTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759914830; c=relaxed/simple;
	bh=eurWf6g12WEClCkCh+jJCglmEsZtMc18LlN1ZJ++/mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9AVX8BFja57NPHYzKLFVpngCDLFjkmdd10cOhcaSkj6RpnfWprAU9oCF+Ga64INFJa0iL3uGSVtpM3mazwNUcg/qF66ET4R61/34dvyAahf7K/voL8kkF2u8Y2095ujIy83TlOQN2ooVrmuWdnesiBnAaL416ByDeH3r95OBoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyM1v587; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA591C4CEF4;
	Wed,  8 Oct 2025 09:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759914830;
	bh=eurWf6g12WEClCkCh+jJCglmEsZtMc18LlN1ZJ++/mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IyM1v587lYcNUpW0/zKiHZWXz/QMTlP5uMM+5ivozGNpqgie2Qk/o2cT88Zjas49l
	 qbPP1EKEBKkQLac7TmvKxXJB0qQGnCbOTZ539huRw9bcYKvgkm+0GWhJupfJJr96Bt
	 4d9Y+K8avyoAQL8xUYKiUPMzddXiZ+oT0ysFM5NYazRPV+uqYm/HVT1g0kxqsH66gC
	 fqvyeoI+tXfvCk7p5l5p44gVJyb7gX0AI7+M1LafWc/GD4lFQJ0XjWqpMZdsKUdIAi
	 CFJ5JZbuUNCQIJbndxT0pwHBDuoMCBEv/oGyhMKsci0E4iZB6iVFrSQD7l9y+nh3VF
	 /7nxWfZ9WdueA==
Date: Wed, 8 Oct 2025 10:13:46 +0100
From: Simon Horman <horms@kernel.org>
To: Yeounsu Moon <yyyynoom@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dlink: handle dma_map_single() failure properly
Message-ID: <20251008091346.GO3060232@horms.kernel.org>
References: <20251002152638.1165-1-yyyynoom@gmail.com>
 <20251003094424.GF2878334@horms.kernel.org>
 <DDA4Y2GRUHD4.1DFHX01NOJYCB@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDA4Y2GRUHD4.1DFHX01NOJYCB@gmail.com>

On Sun, Oct 05, 2025 at 02:22:43PM +0900, Yeounsu Moon wrote:
> Hello Simon.
> 
> I'm currenly re-writing the code as you suggested. I think `alloc_list()` 
> can easily adopt the `goto` pattern, but for others functions, it's not 
> that straightforward.
> 
> My question is whether a style combining `goto`, `continue`, and `break`
> would be acceptable in this context:
> 
> ```c
> 	if (np->cur_rx - np->old_rx >= RX_RING_SIZE) {
> 		printk(KERN_INFO "Try to recover rx ring exhausted...\n");
> 		/* Re-allocate skbuffs to fill the descriptor ring */
> 		for (; np->cur_rx - np->old_rx > 0; np->old_rx++) {
> 			struct sk_buff *skb;
> 			dma_addr_t addr;
> 			entry = np->old_rx % RX_RING_SIZE;
> 			/* Dropped packets don't need to re-allocate */
> 			if (np->rx_skbuff[entry])
> 				goto fill_entry;
> 
> 			skb = netdev_alloc_skb_ip_align(dev, np->rx_buf_sz);
> 			if (skb == NULL)
> 				goto out_clear_fraginfo;
> 
> 			addr = dma_map_single(&np->pdev->dev, skb->data,
> 					      np->rx_buf_sz,
> 					      DMA_FROM_DEVICE);
> 			if (dma_mapping_error(&np->pdev->dev, addr))
> 				goto out_kfree_skb;
> 
> 			np->rx_skbuff[entry] = skb;
> 			np->rx_ring[entry].fraginfo = cpu_to_le64(addr);
> fill_entry:
> 			np->rx_ring[entry].fraginfo |=
> 			    cpu_to_le64((u64)np->rx_buf_sz << 48);
> 			np->rx_ring[entry].status = 0;
> 			continue;
> 
> out_kfree_skb:
> 			dev_kfree_skb_irq(skb);
> out_clear_fraginfo:
> 			np->rx_ring[entry].fraginfo = 0;
> 			printk(KERN_INFO
> 			       "%s: Still unable to re-allocate Rx skbuff.#%d\n"
> 			       , dev->name, entry);
> 			break;
> 		} /* end for */
> 	} /* end if */
> 	spin_unlock_irqrestore (&np->rx_lock, flags);
> 	np->timer.expires = jiffies + next_tick;
> 	add_timer(&np->timer);
> }
> ```
> 
> Or is there any better way to handle errors here?
> I'd appreciate your guidance.

Sorry for the slow response, I've been ill for the past few days.

I did also consider the option above. That is handling the
errors in the loop. And I can see some merit in that approach,
e.g. reduced scope of variables.

But I think the more idiomatic approach is to handle them 'here'.
That is, at the end of the function. So I would lean towards
that option.

