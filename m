Return-Path: <netdev+bounces-107497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C10D591B32D
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 02:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C05AD1C20B1E
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 00:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEFC193;
	Fri, 28 Jun 2024 00:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoNSK5dY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16055191
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 00:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719533289; cv=none; b=cO8qgponWLARz5wn6Lzws/15ykozpffK8TgKN9iF7GzaSYeErrXM2i6GVZ41xlxyYjbtpymgASCoKPQbGtMru6b9yKmt4956YG8wQtX2FhV1yv4ORGIFvZifwCKB70KJTyYzcuB+NMeC5oAKYo6LxqV5dSJvOUm+tNxo4USchGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719533289; c=relaxed/simple;
	bh=3NvVf161WS9Pxdpu0zztLkF5R/2K0FGNw/kjSCvxIX8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oh4drLTGKdhB8x73TW+OF1p1ZmtK/IZBgC25hrxNaClsQCRBETaCkuvve97SqxBI43Vdi20pJTQebCQe7w8qTwg+N4J1/8dN9g+8s+k3Ssw2fuLl2Ytg7kf5gBORjrhtUw3Kv28nBPOYC3rJSYYaDit+ujJDo3ceI6023qpweg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoNSK5dY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572F8C2BBFC;
	Fri, 28 Jun 2024 00:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719533288;
	bh=3NvVf161WS9Pxdpu0zztLkF5R/2K0FGNw/kjSCvxIX8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YoNSK5dYlyx6M6jjyxlKibV0zSddHvVoKuIMbNhhf+8GwCpkgVOP8EOjKiwKnQD4b
	 F6nxMSjgjo2LRnHyR1dTeSbD/mGmE2SmPWMOUYJEF1+HHrgPVFqxX9uGJNr50al9m4
	 3sCeRRfBMCqi05Eey5gHCGBEiQXEd2oK3zv5zIcxYxemxmUv58GCiz88PO3rTQDWgI
	 /e/uNm4/yWxkOJ44PbvcyES4zw2+xxEjLgAoW0sTDWRCBhoQZkrqWqpxUsTADu/0tq
	 81nk9tw5Yyon56r3rdyT/lN+oUw24DU9/BNtlTGjczUC2q+12vNwEoa2dL5zSRNh+0
	 BuHDQx/PjqAag==
Date: Thu, 27 Jun 2024 17:08:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, richardcochran@gmail.com
Subject: Re: [PATCH net-next 02/10] bnxt_en: Add is_ts_pkt field to struct
 bnxt_sw_tx_bd
Message-ID: <20240627170807.1a68c8ce@kernel.org>
In-Reply-To: <20240626164307.219568-3-michael.chan@broadcom.com>
References: <20240626164307.219568-1-michael.chan@broadcom.com>
	<20240626164307.219568-3-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jun 2024 09:42:59 -0700 Michael Chan wrote:
> @@ -612,9 +613,11 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  normal_tx:
>  	if (length < BNXT_MIN_PKT_SIZE) {
>  		pad = BNXT_MIN_PKT_SIZE - length;
> -		if (skb_pad(skb, pad))
> +		if (skb_pad(skb, pad)) {
>  			/* SKB already freed. */
> +			tx_buf->is_ts_pkt = 0;
>  			goto tx_kick_pending;
> +		}
>  		length = BNXT_MIN_PKT_SIZE;
>  	}

There is a jump to tx_free in between these two, when DMA mapping
head fails. It appears not to clear is_ts_pkt.

Why not add the clearing above the line on the error patch which 
clears the skb pointer?

@@ -771,6 +770,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
        if (txr->kick_pending)
                bnxt_txr_db_kick(bp, txr, txr->tx_prod);
        txr->tx_buf_ring[txr->tx_prod].skb = NULL;
+       txr->tx_buf_ring[txr->tx_prod].is_ts_pkt = 0;
        dev_core_stats_tx_dropped_inc(dev);
        return NETDEV_TX_OK;
 }

> @@ -741,6 +744,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	/* start back at beginning and unmap skb */
>  	prod = txr->tx_prod;
>  	tx_buf = &txr->tx_buf_ring[RING_TX(bp, prod)];
> +	tx_buf->is_ts_pkt = 0;
>  	dma_unmap_single(&pdev->dev, dma_unmap_addr(tx_buf, mapping),
>  			 skb_headlen(skb), DMA_TO_DEVICE);
>  	prod = NEXT_TX(prod);

