Return-Path: <netdev+bounces-246053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C61EDCDDCD6
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 14:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83E99301787D
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 13:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F84A325715;
	Thu, 25 Dec 2025 12:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAqkD1jL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD71324B2E
	for <netdev@vger.kernel.org>; Thu, 25 Dec 2025 12:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766667153; cv=none; b=rxxJk7Vufhxi3VBNELSvmEM+O7MniZtbmF5a40vXDZ4jEO93KUMOJbtjGT+pHTWSbGfZFYlf57eu6WKbSgRJZ/oH1wCkC837BnWdPHIxbIj37jhgmp6BejJ7G3FxxgNE6LUpKPMgKK9KYYqcf8PsJ33kO8KWlzMLD1ajPSO6Go4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766667153; c=relaxed/simple;
	bh=WhdAQyAUH73sGEGEOZ2qkRT1ubsQeFhp0O18Q/juqZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=soRgyhK40qi8zacrfWwDhGhD3pQGqcb4ybOZIHeCnp0Vqnnw9lHxZmrWrg1wry+D0zWDOpXMxEAdBkLj0MFxMaCZX8AUx0dEzWS1ctVw1rdHLtjAFMWLRW961h9ML+jisHASHQPJg/CO9kpfx81hpBdnokJPU7qnYzpR6we6Zlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAqkD1jL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541EEC4CEF1;
	Thu, 25 Dec 2025 12:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766667153;
	bh=WhdAQyAUH73sGEGEOZ2qkRT1ubsQeFhp0O18Q/juqZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PAqkD1jLZcgWCigS3PUS0BqlJ4ywnZ7LjcGyiKhERqGJrdKyUMCJx0aTDS5cwJEJY
	 GxOxYzOqgXbiHRZb6hXW+iaKFerrT1K46iw+H9J/QtrUUW1cfB6GigYSmPaynTsm90
	 BUHYaV4YgTuxBgnVbjseggoHBpyIhGsYTu7FpsvGDvFt5QF3JG6P7rIgMQXngZqnNj
	 o5rezGSueKZoZXQ42dWiZwVTsW0Fl1QWA4fodjfV7g040H6gslX4Ain4sfg/TPg27C
	 PEEzE5EygfXyTdK4+2Oq9RsnHz0zgXTX/AkygyDByHqPw+ssiiLTSsk6Ay12Ufj+tl
	 74P7W22UGlyQw==
Date: Thu, 25 Dec 2025 14:52:29 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
	Srijit Bose <srijit.bose@broadcom.com>,
	Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH net] bnxt_en: Fix potential data corruption with HW
 GRO/LRO
Message-ID: <20251225125229.GL11869@unreal>
References: <20251224191116.3526999-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251224191116.3526999-1-michael.chan@broadcom.com>

On Wed, Dec 24, 2025 at 11:11:16AM -0800, Michael Chan wrote:
> From: Srijit Bose <srijit.bose@broadcom.com>
> 
> Fix the max number of bits passed to find_first_zero_bit() in
> bnxt_alloc_agg_idx().  We were incorrectly passing the number of
> long words.  find_first_zero_bit() may fail to find a zero bit and
> cause a wrong ID to be used.  If the wrong ID is already in use, this
> can cause data corruption.  Sometimes an error like this can also be
> seen:
> 
> bnxt_en 0000:83:00.0 enp131s0np0: TPA end agg_buf 2 != expected agg_bufs 1
> 
> Fix it by passing the correct number of bits MAX_TPA_P5.  Add a sanity
> BUG_ON() check if find_first_zero_bit() fails.  It should never happen.

Things that should never occur are flagged with WARN_ON(), not BUG_ON().
Using BUG_ON() would unnecessarily crash the system just because something
unexpected happened in the networking driver.

Thanks

> 
> Fixes: ec4d8e7cf024 ("bnxt_en: Add TPA ID mapping logic for 57500 chips.")
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Signed-off-by: Srijit Bose <srijit.bose@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index d17d0ea89c36..6704cbbc1b24 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -1482,9 +1482,10 @@ static u16 bnxt_alloc_agg_idx(struct bnxt_rx_ring_info *rxr, u16 agg_id)
>  	struct bnxt_tpa_idx_map *map = rxr->rx_tpa_idx_map;
>  	u16 idx = agg_id & MAX_TPA_P5_MASK;
>  
> -	if (test_bit(idx, map->agg_idx_bmap))
> -		idx = find_first_zero_bit(map->agg_idx_bmap,
> -					  BNXT_AGG_IDX_BMAP_SIZE);
> +	if (test_bit(idx, map->agg_idx_bmap)) {
> +		idx = find_first_zero_bit(map->agg_idx_bmap, MAX_TPA_P5);
> +		BUG_ON(idx >= MAX_TPA_P5);
> +	}
>  	__set_bit(idx, map->agg_idx_bmap);
>  	map->agg_id_tbl[agg_id] = idx;
>  	return idx;
> -- 
> 2.51.0
> 
> 

