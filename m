Return-Path: <netdev+bounces-141327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE789BA7A2
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 20:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE325B2114F
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 19:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB91E175D37;
	Sun,  3 Nov 2024 19:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5N++baQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79247082D
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 19:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730661757; cv=none; b=tBLB4ry4cKCrwRWs8+k9K+luIExInNWXxwaWvHi9vg0KdX7pOBPnBly+kexjtJRpT0z6qKrJUZFkjCEu2r71IXXzqyM2AqB41tudgIGiKRV2FPGaitZNBVXxPlsGOxLxMiqw8VeaHRD3t36BibI1oX8TxgCfBW1uaGpjMbFabJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730661757; c=relaxed/simple;
	bh=X2oGbW7z2IVt+xkofxL6wEiDr2GWQz2yVQWZKAyO7nA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BnZSx3cDK++N2dMGTjkAP1VwedmyUYeSKy0cJXy4sn2+xjFjLnhX3ps04Ev6GmsY07FbAFAflC9xQ5c2bjY6hYBHOWKQ2PNLR71pB+CXBu2I+sp1nQ7oINNy/bAkrkjaTqrMqf68bbK0E1u+NTm6KsWKsAVbaqG7KiNtsEtHYlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5N++baQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F13C4CECD;
	Sun,  3 Nov 2024 19:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730661756;
	bh=X2oGbW7z2IVt+xkofxL6wEiDr2GWQz2yVQWZKAyO7nA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g5N++baQZmFGjxoB+wbe2j99BF1RKP+AcHgtkT4qEpKjCsv+kh9+kxHyW/DOv8c7h
	 98bl+tnQ+zxUf/hX9abHUpnKgMr4UwGVPaSvgD2Md0E5pVOr32UgXiWVJTj6fY91x8
	 JjzBk4vy7uvjKGR++jRxwjGEo5Z4FbnNFDofCyrwdZAPd1f817B5UgsFIYT22Z2TzS
	 gGfyW3c8O4ta/V+wZgeUvkNdoIiFQC1mxzO0nEn8gmwfEGbYHslSXQzhNcrk+IWakm
	 iWc1NHqLh/QtKwHBZ7aTEyo45iCdT1wXEgn4/vlD2lO55dZ4K294f/QhMhjTa00Uf2
	 vInl7NHwtDKmA==
Date: Sun, 3 Nov 2024 11:22:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Michael Chan
 <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>, "Richard
 Cochran" <richardcochran@gmail.com>
Subject: Re: [PATCH net-next v4 1/2] bnxt_en: cache only 24 bits of hw
 counter
Message-ID: <20241103112234.1b057a75@kernel.org>
In-Reply-To: <20241029205453.2290688-1-vadfed@meta.com>
References: <20241029205453.2290688-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Oct 2024 13:54:52 -0700 Vadim Fedorenko wrote:
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> index fa514be87650..820c7e83e586 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> @@ -106,7 +106,7 @@ static void bnxt_ptp_get_current_time(struct bnxt *bp)
>  	if (!ptp)
>  		return;
>  	spin_lock_irqsave(&ptp->ptp_lock, flags);
> -	WRITE_ONCE(ptp->old_time, ptp->current_time);
> +	WRITE_ONCE(ptp->old_time, (u32)(ptp->current_time >> BNXT_HI_TIMER_SHIFT));

the casts to u32 seem unnecessary since write to u32 will truncate
the value, anyway, and they make the lines go over 80 columns

>  	bnxt_refclk_read(bp, NULL, &ptp->current_time);
>  	spin_unlock_irqrestore(&ptp->ptp_lock, flags);
>  }
> @@ -174,7 +174,7 @@ void bnxt_ptp_update_current_time(struct bnxt *bp)
>  	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
>  
>  	bnxt_refclk_read(ptp->bp, NULL, &ptp->current_time);
> -	WRITE_ONCE(ptp->old_time, ptp->current_time);
> +	WRITE_ONCE(ptp->old_time, (u32)(ptp->current_time >> BNXT_HI_TIMER_SHIFT));
>  }
>  
>  static int bnxt_ptp_adjphc(struct bnxt_ptp_cfg *ptp, s64 delta)
> @@ -813,7 +813,7 @@ int bnxt_get_rx_ts_p5(struct bnxt *bp, u64 *ts, u32 pkt_ts)
>  	if (!ptp)
>  		return -ENODEV;
>  
> -	BNXT_READ_TIME64(ptp, time, ptp->old_time);
> +	time = (u64)(READ_ONCE(ptp->old_time) << BNXT_HI_TIMER_SHIFT);

And this cast looks misplaced, I presume you want the shift to operate
on 64b. The way this is written the shift will be truncated to 32b,
and then we will promote, with top 32b being all 0.
-- 
pw-bot: cr

