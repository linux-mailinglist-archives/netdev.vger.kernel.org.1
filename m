Return-Path: <netdev+bounces-165341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44168A31B71
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 02:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E20A01672D1
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 01:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8FF78F20;
	Wed, 12 Feb 2025 01:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnzHSsTD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABBC3D3B8
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 01:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739324681; cv=none; b=B6F91Xvs//9ofnenAsFJXG3CIoRWs0NSG1q215g+t1bWUFG3gAOrdDk1sLZuR0TrPfOKbmV/F4CLP+sXbMD7w7anHRGVpWqFng05fxP/AVj97KzX4M682PjhqFanAILWLfHiqCruyyxc2sPDyfjsEYcGD+HPp0h3p4wFaiL14kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739324681; c=relaxed/simple;
	bh=vwjvqa486loabkKY0VkIST3XHnIBYBzMM7doYaiNR/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZdV0hHidPrWZH5nwkp9adieFybnucRvo4XK7KbOXZhm1YvfwYjryC010rWD7H7ER9LOA29shAFjXhHAv+eDLDHuPerHWrZaxiOHgRqd1Gk/n67EpYZ8YpHIdzq3j9y2upSpWdh1j72Lw9djRcszFHLmzY6OAlkICjZ6bX9PleAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tnzHSsTD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE539C4CEDD;
	Wed, 12 Feb 2025 01:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739324680;
	bh=vwjvqa486loabkKY0VkIST3XHnIBYBzMM7doYaiNR/Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tnzHSsTD/QT5FAF40L1aBMrcQtToDNbmGxNMBlmZ58KUsqPptYyLKEUJigqU6BkAl
	 5P1W4Ew7QpxreIHsWkETl2ymBmS9SWfmqKrzfBza6udRpi0NkGbN1+mbIL+DwcYwF/
	 9GNfuODXi1dc79tftUV7eDK6Hno7RtjElviRPKtZf9ZG3oCj8QoR7QcKDX5RMmQVnV
	 BTb5Ny5aYvzcGDJZhZSNVVXuDzhFU4VExvYLPsDEto4bxyMW+WQbEk2m02ycnoTCbs
	 qOe8whEsaDWHhuSAZ3wVbU2+V9T2D7ANR84Du0p0eV/0d9bSXv9BdKbkge2VodnvwZ
	 bGEKB3wJe1OYA==
Date: Tue, 11 Feb 2025 17:44:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, michal.swiatkowski@linux.intel.com,
 helgaas@kernel.org, horms@kernel.org, Somnath Kotur
 <somnath.kotur@broadcom.com>, Ajit Khaparde <ajit.khaparde@broadcom.com>,
 David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next v4 09/10] bnxt_en: Extend queue stop/start for
 TX rings
Message-ID: <20250211174438.3b8493fe@kernel.org>
In-Reply-To: <20250208202916.1391614-10-michael.chan@broadcom.com>
References: <20250208202916.1391614-1-michael.chan@broadcom.com>
	<20250208202916.1391614-10-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  8 Feb 2025 12:29:15 -0800 Michael Chan wrote:
> +		rc = bnxt_hwrm_cp_ring_alloc_p5(bp, txr->tx_cpr);
> +		if (rc)
> +			return rc;
> +
> +		rc = bnxt_hwrm_tx_ring_alloc(bp, txr, false);
> +		if (rc)
> +			return rc;

Under what circumstances can these alloc calls fail?
"alloc" sounds concerning in a start call.

> +		txr->tx_prod = 0;
> +		txr->tx_cons = 0;
> +		txr->tx_hw_cons = 0;

>  	cpr->sw_stats->rx.rx_resets++;
>  
> +	if (bp->flags & BNXT_FLAG_SHARED_RINGS) {
> +		cpr->sw_stats->tx.tx_resets++;

Is there a reason why queue op stop/start cycles are counted as resets?
IIUC previously only faults (~errors) would be counted as resets.
ifdown / ifup or ring reconfig (ethtool -L / -G) would not increment
resets. I think queue reconfig is more like ethtool -L than a fault.
It'd be more consistent with existing code not to increment these
counters.

> +		rc = bnxt_tx_queue_start(bp, idx);
> +		if (rc) {
> +			netdev_warn(bp->dev,
> +				    "tx queue restart failed: rc=%d\n", rc);
> +			bnapi->tx_fault = 1;
> +			goto err_reset;
> +		}
> +	}
> +
> +	napi_enable(&bnapi->napi);

Here you first start the queue then enable NAPI...

> +	bnxt_db_nq_arm(bp, &cpr->cp_db, cpr->cp_raw_cons);
> +
>  	for (i = 0; i <= BNXT_VNIC_NTUPLE; i++) {
>  		vnic = &bp->vnic_info[i];
>  

> @@ -15716,17 +15820,25 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
>  	/* Make sure NAPI sees that the VNIC is disabled */
>  	synchronize_net();
>  	rxr = &bp->rx_ring[idx];
> -	cancel_work_sync(&rxr->bnapi->cp_ring.dim.work);
> +	bnapi = rxr->bnapi;
> +	cpr = &bnapi->cp_ring;
> +	cancel_work_sync(&cpr->dim.work);
>  	bnxt_hwrm_rx_ring_free(bp, rxr, false);
>  	bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
>  	page_pool_disable_direct_recycling(rxr->page_pool);
>  	if (bnxt_separate_head_pool())
>  		page_pool_disable_direct_recycling(rxr->head_pool);
>  
> +	if (bp->flags & BNXT_FLAG_SHARED_RINGS)
> +		bnxt_tx_queue_stop(bp, idx);
> +
> +	napi_disable(&bnapi->napi);

... but here you do the opposite, and require extra synchronization 
in bnxt_tx_queue_stop() to set your magic flag, sync the NAPI etc.
Why can't the start and stop paths be the mirror image?

