Return-Path: <netdev+bounces-128970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C01697CA6A
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 15:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E1381C22A6E
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 13:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7397719F480;
	Thu, 19 Sep 2024 13:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsTGrcZ7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD0D19EEDC;
	Thu, 19 Sep 2024 13:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726753697; cv=none; b=sfEeWFCE5Q14d6ibst4wVnHe9ciDjB2TPISt0qN7ddmLxWefUlhc0Mz4mr3FsTd4NKePyAL/GgpO5shGXgWiiTOs/HxY1Ca/vxHC5WubLY/BGNhvOJS/aiOqEFafxq5zUJHlD3iV3BEmDECF/ttUPGwqWtUQE0i4iF9gH1sr0nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726753697; c=relaxed/simple;
	bh=9JhpbbSt9wyEglHxHBmVPwbNU0+uE6JrfEsiH4+dEpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7V93VeZdI2rmq3LK3UYvTujyWOhE68EEwqlSnPUS0ASKM9LEtw4Qh9hE0N1immuc5Ezhf803NR2BozjQMICtOjjFBpWpml3yCJCP6sZTFdALnnqg45uM0FY6pm3zZZEB1aqMtyvP1+3DasQviRWZKw0ZKjC/zEr26DI6HwtsEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsTGrcZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71560C4CED2;
	Thu, 19 Sep 2024 13:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726753696;
	bh=9JhpbbSt9wyEglHxHBmVPwbNU0+uE6JrfEsiH4+dEpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AsTGrcZ7P6je+RajAymJs21FHPpynXnpCai86M+TyxTzgUuSn2Wt1AB84Ddg0oeg2
	 WDeljpW4TjHriG6gdWXrtI33JzC7DTqY2FApBl6Y6Lmp/sVvNeNG9RfR0ZkM4m+idu
	 bqQq0Uw/c12KVxd9Lf2iSELdLI067YFWoUd+1lHHf42CR1w8soXtZwYuyHHLVtdmoO
	 nJRMWsBCK5egZu1SvwGwg10YkjeYGY8hpQ0ioxHqKLi2blEUfPdb4p4TuUF8TWn3Ho
	 scXpFb8l5L/oOWF92eS5EQdtOY5Ksg5wQuSA/wSBrmwT0NPbxAblPGvdWmvGmTM77R
	 cpoDs1n6V/dhg==
Date: Thu, 19 Sep 2024 14:48:12 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Abhijit Ayarekar <aayarekar@marvell.com>,
	Satananda Burla <sburla@marvell.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH net v2] octeon_ep: Add SKB allocation failures handling
 in __octep_oq_process_rx()
Message-ID: <20240919134812.GB1571683@kernel.org>
References: <20240916060212.12393-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916060212.12393-1-amishin@t-argos.ru>

On Mon, Sep 16, 2024 at 09:02:12AM +0300, Aleksandr Mishin wrote:
> build_skb() returns NULL in case of a memory allocation failure so handle
> it inside __octep_oq_process_rx() to avoid NULL pointer dereference.
> 
> __octep_oq_process_rx() is called during NAPI polling by the driver. If
> skb allocation fails, keep on pulling packets out of the Rx DMA queue: we
> shouldn't break the polling immediately and thus falsely indicate to the
> octep_napi_poll() that the Rx pressure is going down. As there is no
> associated skb in this case, don't process the packets and don't push them
> up the network stack - they are skipped.
> 
> The common code with skb and some index manipulations is extracted to make
> the fix more readable and avoid code duplication. Also helper function is
> implemented to unmmap/flush all the fragment buffers used by the dropped
> packet. 'alloc_failures' counter is incremented to mark the skb allocation
> error in driver statistics.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 37d79d059606 ("octeon_ep: add Tx/Rx processing and interrupt support")
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
> A similar situation is present in the __octep_vf_oq_process_rx() of the
> Octeon VF driver. First we want to try the fix on __octep_oq_process_rx().
> 
> There are some doubts about increasing the 'rx_bytes'. On the one hand,
> the data has not been processed, therefore, the counter does not need to
> be increased. On the other hand, this counter is used to estimate the
> bandwidth at the card's input.
> In octeon_droq_fast_process_packet() from the Liquidio driver in
> 'droq->stats.bytes_received += total_len' everything that was received
> from the device is considered.
> /* Output Queue statistics. Each output queue has four stats fields. */
> struct octep_oq_stats {
> 	/* Number of packets received from the Device. */
> 	u64 packets;
> 	/* Number of bytes received from the Device. */
> 	u64 bytes;
> 	/* Number of times failed to allocate buffers. */
> 	u64 alloc_failures;
> };
> 
> Compile tested only.

Hi Veerasenareddy, Sathesh, and the team at Marvell,

This change looks correct to me, but I am wondering if
it could be exercised in order increase confidence in
it's run-time behaviour.

> 
> v2: 
>   - Implement helper instead of adding multiple checks for '!skb' and
>     remove 'rx_bytes' increasing in case of packet dropping as suggested
>     by Paolo
>     (https://lore.kernel.org/all/ba514498-3706-413b-a09f-f577861eef28@redhat.com/)
> v1: https://lore.kernel.org/all/20240906063907.9591-1-amishin@t-argos.ru/
> 
>  .../net/ethernet/marvell/octeon_ep/octep_rx.c | 80 +++++++++++++++----
>  1 file changed, 64 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
> index 4746a6b258f0..6b665263b9be 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
> @@ -336,6 +336,51 @@ static int octep_oq_check_hw_for_pkts(struct octep_device *oct,
>  	return new_pkts;
>  }
>  
> +/**
> + * octep_oq_drop_rx() - Free the resources associated with a packet.
> + *
> + * @oq: Octeon Rx queue data structure.
> + * @buff_info: Current packet buffer info.
> + * @read_idx: Current packet index in the ring.
> + * @desc_used: Current packet descriptor number.
> + *
> + */
> +static void octep_oq_drop_rx(struct octep_oq *oq,
> +			     struct octep_rx_buffer *buff_info,
> +			     u32 *read_idx, u32 *desc_used)
> +{
> +	dma_unmap_page(oq->dev, oq->desc_ring[*read_idx].buffer_ptr,
> +		       PAGE_SIZE, DMA_FROM_DEVICE);
> +	buff_info->page = NULL;
> +	(*read_idx)++;
> +	(*desc_used)++;
> +	if (*read_idx == oq->max_count)
> +		*read_idx = 0;

Hi Aleksandr,

Maybe this is taking things to far, but I notice that
the above patter appears several times in this patch.
And I am wondering if it makes sense to have a helper for it.

...

