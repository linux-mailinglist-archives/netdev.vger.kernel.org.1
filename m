Return-Path: <netdev+bounces-20598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61822760354
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 01:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 561241C20CC7
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 23:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6576134B8;
	Mon, 24 Jul 2023 23:52:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ABF134AD;
	Mon, 24 Jul 2023 23:51:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87873C433C7;
	Mon, 24 Jul 2023 23:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690242719;
	bh=OMraFAIU6GX2b7xer6c5z+lNJyNLTIbcVU50mdmeTFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qhKrfI3Or14X3j2O9LZ7JNuqCMKQX9vzAsQOp6XbX6FSExFA6FBlLzKRqyZcjzeeU
	 ZsY/pFTrPjdBJoMHxWsKwAyhaf9jX49ClhvDOeMJzr6RVcJ4dFQ6oCjA1ipDN1pXrD
	 FxDEeGByaHk45a05vNFCklfBYjFpA+jmiasHrmnkDIZkoORbvYCi6N9pJTZN96Knms
	 AvaverxxPIocxTGCQxsC6sDCdoZTFF3yM2wNqvnWL8mAEubkOeQ3hLH60pex8j2kz/
	 cTKGZY+WY86bpzDjrdgP3Cnx1yH9KxoO1cJU1x7e1mZVsNYJd3/yot3R3frcD8DYyN
	 V61kfRc4FFi2A==
Date: Mon, 24 Jul 2023 16:51:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 shenwei.wang@nxp.com, xiaoning.wang@nxp.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 netdev@vger.kernel.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH V2 net-next] net: fec: add XDP_TX feature support
Message-ID: <20230724165157.7094468a@kernel.org>
In-Reply-To: <20230721062153.2769871-1-wei.fang@nxp.com>
References: <20230721062153.2769871-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jul 2023 14:21:53 +0800 Wei Fang wrote:
> +			/* Tx processing cannot call any XDP (or page pool) APIs if
> +			 * the "budget" is 0. Because NAPI is called with budget of
> +			 * 0 (such as netpoll) indicates we may be in an IRQ context,
> +			 * however, we can't use the page pool from IRQ context.
> +			 */
> +			if (unlikely(!budget))
> +				break;
> +
>  			xdpf = txq->tx_buf[index].xdp;
> -			if (bdp->cbd_bufaddr)
> +			if (bdp->cbd_bufaddr &&
> +			    txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO)
>  				dma_unmap_single(&fep->pdev->dev,
>  						 fec32_to_cpu(bdp->cbd_bufaddr),
>  						 fec16_to_cpu(bdp->cbd_datlen),
> @@ -1474,7 +1486,10 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id)
>  			/* Free the sk buffer associated with this last transmit */
>  			dev_kfree_skb_any(skb);
>  		} else {
> -			xdp_return_frame(xdpf);
> +			if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO)
> +				xdp_return_frame(xdpf);
> +			else
> +				xdp_return_frame_rx_napi(xdpf);

I think that you need to also break if (!budget) here,
xdp_return_frame() may call page pool APIs to return the frame 
to a page pool owned by another driver. And that needs to be fixed
in net/main already?
-- 
pw-bot: cr

