Return-Path: <netdev+bounces-67792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4D9844F24
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 03:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF9E51C2328D
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 02:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AAF5234;
	Thu,  1 Feb 2024 02:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrXZKQrP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8661A27A
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 02:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706754309; cv=none; b=uFC58yz8+y24mW9LYdMDYaAWlbwAShIsw4R59CgSVPpGekp2BYK8AQC8TLiMttJzPcVd6LchjzhiZNbg4juqSNNsnaCgJt8pzFbRTrgGX8DLafgDWWq/6KoToKAsm1qAMMgTAiMQQ7OB+BhyCoOeLfyXBDMt6GziMX1SGm5ZqJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706754309; c=relaxed/simple;
	bh=2pr+9lz0MqI25T5Y8iroeGJE/d8GEZI70Ln+WQXTu5w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jgkb10jDr4mAPUf8sC1BowcQrPlpF+tohpesf7vEZ6WuQNRIwhtOOAASb+v+S1p5V68GkdG7Nsa9Y/LrrGzgKgjo2EvEPpnliaJWwLASlcTOprhhw6wWrG7OcPGVhIl51S0knFJ9Y4asAa8HOAZXYZNaPNPi2YAoCJU8pctm8YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrXZKQrP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2237C433F1;
	Thu,  1 Feb 2024 02:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706754309;
	bh=2pr+9lz0MqI25T5Y8iroeGJE/d8GEZI70Ln+WQXTu5w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NrXZKQrP+AutcpM/YiC0PqJSAFEJRP61BwYGEtszJgDaTY+AWTJ+m2QV/Rwc/YxKB
	 BlDbYLra6xiWUZUS9ip/DrPSy4jzIvXpGIpREBFJMn6E1U1ewZelJMCOvSlIeAH3+Z
	 6v6mPbYUQWzY5m+ynMVa6bMRvMshGEVEDkW+tB5jll7wqdXtvJ+5Tnp94yJOVBwBbL
	 DGhBfriTu8C88BRCUvBjPVzvgK936zT5T939kxQeUcWOi6Pk2Vb5d6cjBklBv3uCIe
	 h6jW+LPejxpwBSc0P+bEDnh0O2XHweji/NDlHQKib04pwu+cZqa2rJWx/Jt8bP2Ck2
	 dh2BL1rk91TVA==
Date: Wed, 31 Jan 2024 18:25:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <brett.creeley@amd.com>, <drivers@pensando.io>
Subject: Re: [PATCH net-next 6/9] ionic: Add XDP_TX support
Message-ID: <20240131182505.67eeedd9@kernel.org>
In-Reply-To: <20240130013042.11586-7-shannon.nelson@amd.com>
References: <20240130013042.11586-1-shannon.nelson@amd.com>
	<20240130013042.11586-7-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jan 2024 17:30:39 -0800 Shannon Nelson wrote:
>  	case XDP_TX:
> +		xdpf = xdp_convert_buff_to_frame(&xdp_buf);
> +		if (!xdpf)
> +			goto out_xdp_abort;
> +
> +		txq = rxq->partner;
> +		nq = netdev_get_tx_queue(netdev, txq->index);
> +		__netif_tx_lock(nq, smp_processor_id());
> +
> +		if (netif_tx_queue_stopped(nq) ||
> +		    unlikely(ionic_maybe_stop_tx(txq, 1))) {
> +			__netif_tx_unlock(nq);
> +			goto out_xdp_abort;
> +		}
> +
> +		dma_unmap_page(rxq->dev, buf_info->dma_addr,
> +			       IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
> +
> +		err = ionic_xdp_post_frame(netdev, txq, xdpf, XDP_TX,
> +					   buf_info->page,
> +					   buf_info->page_offset,
> +					   true);

I think that you need txq_trans_cond_update() somewhere, otherwise 
if XDP starves stack Tx the stack will think the queue is stalled.

> +		__netif_tx_unlock(nq);
> +		if (err) {
> +			netdev_dbg(netdev, "tx ionic_xdp_post_frame err %d\n", err);
> +			goto out_xdp_abort;
> +		}
> +		stats->xdp_tx++;
> +
> +		/* the Tx completion will free the buffers */
> +		break;
> +
>  	case XDP_ABORTED:
>  	default:
> -		trace_xdp_exception(netdev, xdp_prog, xdp_action);
> -		ionic_rx_page_free(rxq, buf_info);
> -		stats->xdp_aborted++;
> +		goto out_xdp_abort;
>  	}
>  
> +	return true;
> +
> +out_xdp_abort:
> +	trace_xdp_exception(netdev, xdp_prog, xdp_action);
> +	ionic_rx_page_free(rxq, buf_info);
> +	stats->xdp_aborted++;
> +
>  	return true;
>  }
>  
> @@ -880,6 +1001,16 @@ static void ionic_tx_clean(struct ionic_queue *q,
>  	struct sk_buff *skb = cb_arg;
>  	u16 qi;
>  
> +	if (desc_info->xdpf) {
> +		ionic_xdp_tx_desc_clean(q->partner, desc_info);
> +		stats->clean++;
> +
> +		if (unlikely(__netif_subqueue_stopped(q->lif->netdev, q->index)))
> +			netif_wake_subqueue(q->lif->netdev, q->index);
> +
> +		return;
> +	}

You can't complete XDP if NAPI budget is 0, you may be in hard IRQ
context if its netpoll calling :(

