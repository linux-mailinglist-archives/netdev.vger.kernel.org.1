Return-Path: <netdev+bounces-99902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7A28D6F16
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 11:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AB5A288628
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 09:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED6514E2C5;
	Sat,  1 Jun 2024 09:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tTQ2s5dF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574B2111AD;
	Sat,  1 Jun 2024 09:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717232927; cv=none; b=BTzfoW22w3/H8AeGT6CV3mStkpukLZSPkaTyeaJlQtTYx82A1FSyd31kwVmSgWWB0LUQlaUTNjRNPT5S6teHnf38Liu4JwNAzEIEAjcqrlWp09coJbpi41CAsetMdXGq7kYI4kVVaGi9IRG39zkIEojnkFRVRTNvxUUwjpGBcDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717232927; c=relaxed/simple;
	bh=h6AQp5HLvjkO9wvYFVJXTPoumQQtZPBpKKF3YIzdJKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBg3Zv5gLxCOjg0vB3AuTBNhlqQnC7jptUb1wUdrO2Mvuh4ddoxqez90LsHAKlF7nlH9xjSVGQqpxZWMLh4VufmLQEeml0WWkYbkO4pCpfkbvCcnFeuVp0N03CvAXaLRi8THBqHm5UNGmogF4SnourEov2HvxKySz0XhP1mLSr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tTQ2s5dF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74123C116B1;
	Sat,  1 Jun 2024 09:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717232927;
	bh=h6AQp5HLvjkO9wvYFVJXTPoumQQtZPBpKKF3YIzdJKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tTQ2s5dFr/GugcK3CbwhywDOpEVAtHJNGU9YAnPAUzWTAFiRVj3ZiC9Pzr1zszFCD
	 WnVldec/W9TDLZX+1ZtNVEmiOTgx1Qnjl1OLQCjcIuFprUzcJO7p8uhpfMdZ3hjFAX
	 Hx6RW/VBRHdYXp1oFxcKCEakd6RuY4vYYUzg57jQc3o9EXom/bJe/UZVHtEgUC+1ZF
	 2svOXpBiDvjHUKNpq2EgY+wRtaEKC3KOa4vbgEK33oy/ajbmF1UntJzhbSZ9Mw18Yi
	 Nhz584MG7oMj2v7BPxOymUda20jbqFC/89SUUta4eqyb2R/dXeVbT6Egx9bWFDokO+
	 qHgILGYk5S1LQ==
Date: Sat, 1 Jun 2024 10:08:42 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Mina Almasry <almasrymina@google.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH iwl-next 12/12] idpf: use libeth Rx buffer management for
 payload buffer
Message-ID: <20240601090842.GZ491852@kernel.org>
References: <20240528134846.148890-1-aleksander.lobakin@intel.com>
 <20240528134846.148890-13-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528134846.148890-13-aleksander.lobakin@intel.com>

+ Dan Carpenter

On Tue, May 28, 2024 at 03:48:46PM +0200, Alexander Lobakin wrote:
> idpf uses Page Pool for data buffers with hardcoded buffer lengths of
> 4k for "classic" buffers and 2k for "short" ones. This is not flexible
> and does not ensure optimal memory usage. Why would you need 4k buffers
> when the MTU is 1500?
> Use libeth for the data buffers and don't hardcode any buffer sizes. Let
> them be calculated from the MTU for "classics" and then divide the
> truesize by 2 for "short" ones. The memory usage is now greatly reduced
> and 2 buffer queues starts make sense: on frames <= 1024, you'll recycle
> (and resync) a page only after 4 HW writes rather than two.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

...

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c

...

Hi Alexander,

The code above the hunk below, starting at line 3321, is:

		if (unlikely(!hdr_len && !skb)) {
			hdr_len = idpf_rx_hsplit_wa(hdr, rx_buf, pkt_len);
			pkt_len -= hdr_len;
			u64_stats_update_begin(&rxq->stats_sync);
			u64_stats_inc(&rxq->q_stats.hsplit_buf_ovf);
			u64_stats_update_end(&rxq->stats_sync);
		}
		if (libeth_rx_sync_for_cpu(hdr, hdr_len)) {
			skb = idpf_rx_build_skb(hdr, hdr_len);
			if (!skb)
				break;
			u64_stats_update_begin(&rxq->stats_sync);
			u64_stats_inc(&rxq->q_stats.hsplit_pkts);
			u64_stats_update_end(&rxq->stats_sync);
		}

> @@ -3413,24 +3340,24 @@ static int idpf_rx_splitq_clean(struct idpf_rx_queue *rxq, int budget)
>  		hdr->page = NULL;
>  
>  payload:
> -		if (pkt_len) {
> -			idpf_rx_sync_for_cpu(rx_buf, pkt_len);
> -			if (skb)
> -				idpf_rx_add_frag(rx_buf, skb, pkt_len);
> -			else
> -				skb = idpf_rx_construct_skb(rxq, rx_buf,
> -							    pkt_len);
> -		} else {
> -			idpf_rx_put_page(rx_buf);
> -		}
> +		if (!libeth_rx_sync_for_cpu(rx_buf, pkt_len))
> +			goto skip_data;
> +
> +		if (skb)
> +			idpf_rx_add_frag(rx_buf, skb, pkt_len);
> +		else
> +			skb = idpf_rx_build_skb(rx_buf, pkt_len);
>  
>  		/* exit if we failed to retrieve a buffer */
>  		if (!skb)
>  			break;
>  
> -		idpf_rx_post_buf_refill(refillq, buf_id);
> +skip_data:
> +		rx_buf->page = NULL;
>  
> +		idpf_rx_post_buf_refill(refillq, buf_id);
>  		IDPF_RX_BUMP_NTC(rxq, ntc);
> +
>  		/* skip if it is non EOP desc */
>  		if (!idpf_rx_splitq_is_eop(rx_desc))
>  			continue;

The code following this hunk, ending at line 3372, looks like this:

		/* pad skb if needed (to make valid ethernet frame) */
		if (eth_skb_pad(skb)) {
			skb = NULL;
			continue;
		}
		/* probably a little skewed due to removing CRC */
		total_rx_bytes += skb->len;

Smatch warns that:
.../idpf_txrx.c:3372 idpf_rx_splitq_clean() error: we previously assumed 'skb' could be null (see line 3321)

I think, but am not sure, this is because it thinks skb might
be NULL at the point where "goto skip_data;" is now called above.

Could you look into this?

...

