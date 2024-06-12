Return-Path: <netdev+bounces-102975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24934905C4D
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 21:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 856C7B21271
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 19:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6283A83CC9;
	Wed, 12 Jun 2024 19:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nPFgOPET"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD90381C4
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 19:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718221769; cv=none; b=T/4qHj5s4KYG2Pki5Gjw3gXV2dwNVWOGv8F0udByEhin2vMqWlzOSGcuiZ8aQdnHvrq1a4tOghaVYCTQfsZ+bqFVN1Ogg8A4UvVJY9qeeftmlpx2O2XBaMdQCZiEsOwDuo2HnTXumMZotOdj9B8TYI892E20zom5MmjRiaT5mDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718221769; c=relaxed/simple;
	bh=vdcTll95HYqQ4A5Lb6dhGfn/fHRvNXW4EaLsLqfCBuw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BhlVX7u27Ra2EOWSo81qWSMpRAJeQ5EojaswZSyRsmqee1PflfVuIcA8wPjVY7HMA234o/zIc82sdnt7PtEe1rcpJ3DDJZsBvanuoo/wYfkYlE6KNPHGirraatc7Sn2ZK0RNUrllsk0Jsf8LRcfNWZa1TA26YUXjD2VmkJlptok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nPFgOPET; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718221767; x=1749757767;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=vdcTll95HYqQ4A5Lb6dhGfn/fHRvNXW4EaLsLqfCBuw=;
  b=nPFgOPETGhEN03m+gFzCB94B6smjQMcYNsMtZeWY3v/qV6Kksp60rlfi
   zdTNxUua9J//8r23kS8ujfx/mGMMqW2JC/7r/lCTTTFnzlNbmjEF/LdE+
   ubxtcPeMwkrKvtiiaTMcnFNbMk+au1tMoI1ZUQ9+7uaVFkm/6KrJ9pkFd
   z3+qACpAknNrbzK2btFCXlcRmn3vlZi9vEqJyv2U7QFm+plyP/N2b9hRN
   4Ro8o2RPS0iO+RMXTAhI+BtHwvFosr/r0eR/abuqaVA304Ejx0V9/gTfe
   w4dkQC4nQvCCy8sx0t9d5SJaTi1hQ4Ng5ogJuVCW5FvH11R3415zr9LIl
   A==;
X-CSE-ConnectionGUID: bWicDxTZTuaR8Eq4aCOkug==
X-CSE-MsgGUID: FmSGEHrSTCicIGVfnBC/zQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="14730590"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="14730590"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 12:49:22 -0700
X-CSE-ConnectionGUID: wEqhUlUjS8ycowH9dLa9MA==
X-CSE-MsgGUID: i1X0OC1qRymk+HYeu8D1nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="70694536"
Received: from unknown (HELO vcostago-mobl3) ([10.124.222.220])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 12:49:22 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Kurt Kanzenbach <kurt@linutronix.de>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, Kurt Kanzenbach
 <kurt@linutronix.de>
Subject: Re: [PATCH iwl-next] igc: Get rid of spurious interrupts
In-Reply-To: <20240611-igc_irq-v1-1-49763284cb57@linutronix.de>
References: <20240611-igc_irq-v1-1-49763284cb57@linutronix.de>
Date: Wed, 12 Jun 2024 12:49:21 -0700
Message-ID: <87sexi2b7i.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kurt Kanzenbach <kurt@linutronix.de> writes:

> When running the igc with XDP/ZC in busy polling mode with deferral of hard
> interrupts, interrupts still happen from time to time. That is caused by
> the igc task watchdog which triggers Rx interrupts periodically.
>
> That mechanism has been introduced to overcome skb/memory allocation
> failures [1]. So the Rx clean functions stop processing the Rx ring in case
> of such failure. The task watchdog triggers Rx interrupts periodically in
> the hope that memory became available in the mean time.
>
> The current behavior is undesirable for real time applications, because the
> driver induced Rx interrupts trigger also the softirq processing. However,
> all real time packets should be processed by the application which uses the
> busy polling method.
>
> Therefore, only trigger the Rx interrupts in case of real allocation
> failures. Introduce a new flag for signaling that condition.
>
> [1] - https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=3be507547e6177e5c808544bd6a2efa2c7f1d436
>
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

>  drivers/net/ethernet/intel/igc/igc.h      |  1 +
>  drivers/net/ethernet/intel/igc/igc_main.c | 24 ++++++++++++++++++++----
>  2 files changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> index 8b14c029eda1..7bfe5030e2c0 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -682,6 +682,7 @@ enum igc_ring_flags_t {
>  	IGC_RING_FLAG_TX_DETECT_HANG,
>  	IGC_RING_FLAG_AF_XDP_ZC,
>  	IGC_RING_FLAG_TX_HWTSTAMP,
> +	IGC_RING_FLAG_RX_ALLOC_FAILED,
>  };
>  
>  #define ring_uses_large_buffer(ring) \
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 305e05294a26..e666739dfac7 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -2192,6 +2192,7 @@ static bool igc_alloc_mapped_page(struct igc_ring *rx_ring,
>  	page = dev_alloc_pages(igc_rx_pg_order(rx_ring));
>  	if (unlikely(!page)) {
>  		rx_ring->rx_stats.alloc_failed++;
> +		set_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags);
>  		return false;
>  	}
>  
> @@ -2208,6 +2209,7 @@ static bool igc_alloc_mapped_page(struct igc_ring *rx_ring,
>  		__free_page(page);
>  
>  		rx_ring->rx_stats.alloc_failed++;
> +		set_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags);
>  		return false;
>  	}
>  
> @@ -2659,6 +2661,7 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
>  		if (!skb) {
>  			rx_ring->rx_stats.alloc_failed++;
>  			rx_buffer->pagecnt_bias++;
> +			set_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags);
>  			break;
>  		}
>  
> @@ -2739,6 +2742,7 @@ static void igc_dispatch_skb_zc(struct igc_q_vector *q_vector,
>  	skb = igc_construct_skb_zc(ring, xdp);
>  	if (!skb) {
>  		ring->rx_stats.alloc_failed++;
> +		set_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &ring->flags);
>  		return;
>  	}
>  
> @@ -5811,11 +5815,23 @@ static void igc_watchdog_task(struct work_struct *work)
>  	if (adapter->flags & IGC_FLAG_HAS_MSIX) {
>  		u32 eics = 0;
>  
> -		for (i = 0; i < adapter->num_q_vectors; i++)
> -			eics |= adapter->q_vector[i]->eims_value;
> -		wr32(IGC_EICS, eics);
> +		for (i = 0; i < adapter->num_q_vectors; i++) {
> +			struct igc_ring *rx_ring = adapter->rx_ring[i];
> +
> +			if (test_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags)) {

Minor and optional: I guess you can replace test_bit() -> clear_bit()
with __test_and_clear_bit() here and below.

In any case:

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

> +				eics |= adapter->q_vector[i]->eims_value;
> +				clear_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags);
> +			}
> +		}
> +		if (eics)
> +			wr32(IGC_EICS, eics);
>  	} else {
> -		wr32(IGC_ICS, IGC_ICS_RXDMT0);
> +		struct igc_ring *rx_ring = adapter->rx_ring[0];
> +
> +		if (test_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags)) {
> +			clear_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags);
> +			wr32(IGC_ICS, IGC_ICS_RXDMT0);
> +		}
>  	}
>  
>  	igc_ptp_tx_hang(adapter);
>
> ---
> base-commit: bb678f01804ccaa861b012b2b9426d69673d8a84
> change-id: 20240611-igc_irq-ccc1c8bc6890
>
> Best regards,
> -- 
> Kurt Kanzenbach <kurt@linutronix.de>
>

-- 
Vinicius

