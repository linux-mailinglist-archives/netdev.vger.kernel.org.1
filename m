Return-Path: <netdev+bounces-209681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F417B105AB
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 11:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 463277AF94F
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 09:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CFB259C84;
	Thu, 24 Jul 2025 09:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csas9LGY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AB42594BE
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 09:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753348805; cv=none; b=DfULY8aO6AOCBVolNhh/KUNSUUsStaHzkNcOLlLeM/ngEyo4SJqpbNCJ6TRyRAfHvGojw088/R/70vsuFC0rO5W/GIc57XgEJySfRr/xM8vS7J/sPn3sx4umz8N3CfEqoiNZTr/xFwbiK1cHID/Q1I+1QWSgGVzhMK4vOnlvVpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753348805; c=relaxed/simple;
	bh=gRFHoDdViZAhEfGEzYU/dSV6M0YfSmmTUyLmjOCqTkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/M7roNyzT85GeIMt0r7lBa59R0lrSSv1/RQJiZ1EjUjfisq+TfqR6bbwvSpcG/jwtFstRcqqXxs+P3fTwpQzOeJZ4ufJGuDfNsaZ8h8PaSgh+bBEEXayOb10qF8te5f2ofSfgLzmfickuWJtQsJ7GhCY3F0+0uclTUtTcB+4WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csas9LGY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F229C4CEED;
	Thu, 24 Jul 2025 09:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753348805;
	bh=gRFHoDdViZAhEfGEzYU/dSV6M0YfSmmTUyLmjOCqTkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=csas9LGY3gRo4CflNztwworSXqvM8gHWVOt7FYpn4krG0uzPcST4ldUOXK9WiSfU+
	 Bl/gD///R2Xr1E+leO3FVoA/cmY7hrZsRWRGuf4zppDeRI2yzuSDciBKM9QeJU5YXF
	 3lUoU30S9zsyrSCJdbGjvAlBVyOAIIj7XClzYuzCSu33qjjIPQHa+hQPQ9CiGfH0hq
	 2RrLpttG9Y2Rr+AI6yRTXkj1QPGmmplS32ugXf96GFce1Bi01SIHjGkU0nlKqhI+od
	 8ZNTjLOEoHZBU0hByVSAZ2XGWWAbxEsN7uEsj8rRIeg8Qxm2R1sT1jlamSiJ26Gchc
	 V1v7jSkIUff/g==
Date: Thu, 24 Jul 2025 10:20:01 +0100
From: Simon Horman <horms@kernel.org>
To: Joshua Hay <joshua.a.hay@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Luigi Rizzo <lrizzo@google.com>, Brian Vazquez <brianvv@google.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH net v2 4/6] idpf: replace flow
 scheduling buffer ring with buffer pool
Message-ID: <20250724092001.GI1150792@horms.kernel.org>
References: <20250718002150.2724409-1-joshua.a.hay@intel.com>
 <20250718002150.2724409-5-joshua.a.hay@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718002150.2724409-5-joshua.a.hay@intel.com>

On Thu, Jul 17, 2025 at 05:21:48PM -0700, Joshua Hay wrote:

...

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c

...

> @@ -1959,10 +1966,29 @@ static bool idpf_tx_clean_buf_ring(struct idpf_tx_queue *txq, u16 compl_tag,
>  	};
>  	u16 ntc, orig_idx = idx;
>  
> +	tx_buf = &txq->tx_buf[buf_id];
> +	if (tx_buf->type == LIBETH_SQE_SKB) {
> +		if (skb_shinfo(tx_buf->skb)->tx_flags & SKBTX_IN_PROGRESS)
> +			idpf_tx_read_tstamp(txq, tx_buf->skb);
> +
> +		libeth_tx_complete(tx_buf, &cp);
> +		idpf_post_buf_refill(txq->refillq, buf_id);
> +	}
> +
> +	while (idpf_tx_buf_next(tx_buf) != IDPF_TXBUF_NULL) {
> +		u16 buf_id = idpf_tx_buf_next(tx_buf);
> +
> +		tx_buf = &txq->tx_buf[buf_id];
> +		libeth_tx_complete(tx_buf, &cp);
> +		idpf_post_buf_refill(txq->refillq, buf_id);
> +	}
> +
> +	return true;

This is not a full review.
And I guess this is an artifact of the development of this patch-set.
But the code in this function below this line appears to be unreachable.

Flagged by Smatch.

> +
>  	tx_buf = &txq->tx_buf[idx];
>  
>  	if (unlikely(tx_buf->type <= LIBETH_SQE_CTX ||
> -		     idpf_tx_buf_compl_tag(tx_buf) != compl_tag))
> +		     idpf_tx_buf_compl_tag(tx_buf) != buf_id))
>  		return false;
>  
>  	if (tx_buf->type == LIBETH_SQE_SKB) {

...

