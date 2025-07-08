Return-Path: <netdev+bounces-204982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0B2AFCC36
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 15:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3749C567AF8
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 13:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23F22DCF7D;
	Tue,  8 Jul 2025 13:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHDN0uK5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E56144C63
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 13:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751981496; cv=none; b=eVmIibYhf9ZYUumCTrVO3wbCyYRjReGDxgta7s7K29Jc5eXStXnbCvM5Xe5IObFjb91bE0JN4YIa3ZykKo0731L5FFbxmBpkxUoIhC5ooLB3rTSOGlIGfeBfRvKCu+IAWHtez7iPkHTF/rnvfCx1HX4NLyQoJvO/PEhsngAGM1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751981496; c=relaxed/simple;
	bh=L8gUUWdyynK3+EaLry9gN/i2Pns5/27yBgeXAQ+np2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0Io3QimDtn3kNoew7NMdhurcs9toaBzdJWkiLYT8m55ky5gQf0xNWKyTArbNIQKlRgKErhJLuXlkamlbTCuvT+iG31nsaXfcSbKctQSi6lLi8ioZKsqFVxD9uPSuWUZEEHPVgcNwALvQ9Ft8z81rLgbzCE+s7Eem9lZ5fnyAVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHDN0uK5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46511C4CEED;
	Tue,  8 Jul 2025 13:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751981496;
	bh=L8gUUWdyynK3+EaLry9gN/i2Pns5/27yBgeXAQ+np2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QHDN0uK5SviV5ehj9PJ680BvN6x8xPSe4+D4/3KSJHlVQED3Deh85ke7kIn7rGrMO
	 i8C37J3khgisgd7tRy/RsIYd0XReAcI0/oLnjiqNFJR2H1xwZf4kElrIDhe4HIm00g
	 FiluEsPaNZMvjSIImjurBu5qz45w2xzpY+Jbyhc4zgwkJ7wK1sy3uwcimXIMKAIdfx
	 RzOZfSlMXtqS3CcIFNUS5AyfkAF5FV7Atp8ZyNbEMypOmaaUzPqER4iOV89sdhbIXC
	 x0X159A8Sg4sIF6Vi869TseWzwn+2n8DP9RV30aTYBxmwm3brcpXVRDQsGLusNhjrd
	 QyKmVE+IsaljQ==
Date: Tue, 8 Jul 2025 14:31:32 +0100
From: Simon Horman <horms@kernel.org>
To: Jeroen de Borst <jeroendb@google.com>
Cc: netdev@vger.kernel.org, hramamurthy@google.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, willemb@google.com,
	pabeni@redhat.com, Bailey Forrest <bcf@google.com>,
	Joshua Washington <joshwash@google.com>
Subject: Re: [PATCH net-next v2] gve: make IRQ handlers and page allocation
 NUMA aware
Message-ID: <20250708133132.GL452973@horms.kernel.org>
References: <20250707210107.2742029-1-jeroendb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707210107.2742029-1-jeroendb@google.com>

On Mon, Jul 07, 2025 at 02:01:07PM -0700, Jeroen de Borst wrote:
> From: Bailey Forrest <bcf@google.com>
> 
> All memory in GVE is currently allocated without regard for the NUMA
> node of the device. Because access to NUMA-local memory access is
> significantly cheaper than access to a remote node, this change attempts
> to ensure that page frags used in the RX path, including page pool
> frags, are allocated on the NUMA node local to the gVNIC device. Note
> that this attempt is best-effort. If necessary, the driver will still
> allocate non-local memory, as __GFP_THISNODE is not passed. Descriptor
> ring allocations are not updated, as dma_alloc_coherent handles that.
> 
> This change also modifies the IRQ affinity setting to only select CPUs
> from the node local to the device, preserving the behavior that TX and
> RX queues of the same index share CPU affinity.
> 
> Signed-off-by: Bailey Forrest <bcf@google.com>
> Signed-off-by: Joshua Washington <joshwash@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Signed-off-by: Jeroen de Borst <jeroendb@google.com>
> ---
> v1: https://lore.kernel.org/netdev/20250627183141.3781516-1-hramamurthy@google.com/
> v2:
> - Utilize kvcalloc_node instead of kvzalloc_node for array-type
>   allocations.

Thanks for the update.
I note that this addresses Jakub's review of v1.

I have a minor suggestion below, but I don't think it warrants
blocking progress of this patch.

Reviewed-by: Simon Horman <horms@kernel.org>

...

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c

...

> @@ -533,6 +540,8 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)
>  	}
>  
>  	/* Setup the other blocks - the first n-1 vectors */
> +	node_mask = gve_get_node_mask(priv);
> +	cur_cpu = cpumask_first(node_mask);
>  	for (i = 0; i < priv->num_ntfy_blks; i++) {
>  		struct gve_notify_block *block = &priv->ntfy_blocks[i];
>  		int msix_idx = i;
> @@ -549,9 +558,17 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)
>  			goto abort_with_some_ntfy_blocks;
>  		}
>  		block->irq = priv->msix_vectors[msix_idx].vector;
> -		irq_set_affinity_hint(priv->msix_vectors[msix_idx].vector,
> -				      get_cpu_mask(i % active_cpus));
> +		irq_set_affinity_and_hint(block->irq,
> +					  cpumask_of(cur_cpu));
>  		block->irq_db_index = &priv->irq_db_indices[i].index;
> +
> +		cur_cpu = cpumask_next(cur_cpu, node_mask);
> +		/* Wrap once CPUs in the node have been exhausted, or when
> +		 * starting RX queue affinities. TX and RX queues of the same
> +		 * index share affinity.
> +		 */
> +		if (cur_cpu >= nr_cpu_ids || (i + 1) == priv->tx_cfg.max_queues)
> +			cur_cpu = cpumask_first(node_mask);

FWIIW, maybe this can be written more succinctly as follows.
(Completely untested!)

		/* TX and RX queues of the same index share affinity. */
		if (i + 1 == priv->tx_cfg.max_queues)
			cur_cpu = cpumask_first(node_mask);
		else
			cur_cpu = cpumask_next_wrap(cur_cpu, node_mask);

...

