Return-Path: <netdev+bounces-214510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B57FFB29F6E
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 12:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50E221960549
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 10:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A7A29B205;
	Mon, 18 Aug 2025 10:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bCoaOhbQ"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E2B258EE7
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 10:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514010; cv=none; b=V/mejWOxwgwmNKkK547Asg0OVvKgqfu+qGUeBdwSP2mCHC/DInjbJ85MkIPdaoYiOaro4+IinwwRIOJTRAqawHUH9t6I55eKOQ0Lo4wyfbQPb0x7af+rD0XAtM365n8ttk2ptCPa52c6eDbe6o7nARqqRpvt9rmTT13X25gQzd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514010; c=relaxed/simple;
	bh=3BxcpB0fi1YyTJ0Sn+csxHq2U6qGPZ8M/XQnMsJOnG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uc8YjSVeuQUHNyb4GvahjYSbcaro2uUNwKQ79lN+Vi1QyPIM4pSYzRoeiUe01LbHm9+oqKQZR93tOMsq+o1AYRHw0ZDjXqaFqbMygLKMtOMi7nHx21LwQhqfqDlm78xAl/B7cHJ3bepHyZimhTUro9is5K7feC2eSnfXS4g1sWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bCoaOhbQ; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <aab9c257-fe34-46ac-b8b6-ffce99344491@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755514004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lRWSb7LVYHNyrrMMHfGdXwwpX38Oa6kjy03ZEqG9OvA=;
	b=bCoaOhbQS3fwYIiNtrVwtORpLlvRaiwTPYaLQjwN/O9ySIYIiwsIc0C5m/nOxjN6Y97o1M
	U5tGKFWXhoO4XwDd9B1QytteVbkMtQpCb0j6sYsNNo6Rz+soxvSg95tr8L+hKwLnx/zKOd
	w8LjKgm17VE68GpvUm1rHGAYJvqCeU4=
Date: Mon, 18 Aug 2025 11:46:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ptp: ocp: Fix PCI delay estimation
To: Antoine Gagniere <antoine@gagniere.dev>, jonathan.lemon@gmail.com
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
References: <20250817222933.21102-1-antoine.ref@gagniere.dev>
 <20250817222933.21102-1-antoine@gagniere.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250817222933.21102-1-antoine@gagniere.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 17/08/2025 23:29, Antoine Gagniere wrote:
> Since linux 6.12, a sign error causes the initial value of ts_window_adjust, (used in gettimex64) to be impossibly high, causing consumers like chrony to reject readings from PTP_SYS_OFFSET_EXTENDED.
> 
> This patch fixes ts_window_adjust's inital value and the sign-ness of various format flags
> 
> Context
> -------
> 
> The value stored in the read-write attribute ts_window_adjust is a number of nanoseconds subtracted to the post_ts timestamp of the reading in gettimex64, used notably in the ioctl PTP_SYS_OFFSET_EXTENDED, to compensate for PCI delay.
> Its initial value is set by estimating PCI delay.
> 
> Bug
> ---
> 
> The PCI delay estimation starts with the value U64_MAX and makes 3 measurements, taking the minimum value.
> However because the delay was stored in a s64, U64_MAX was interpreted as -1, which compared as smaller than any positive values measured.
> Then, that delay is divided by ~10 and placed in ts_window_adjust, which is a u32.
> So ts_window_adjust ends up with (u32)(((s64)U64_MAX >> 5) * 3) inside, which is 4294967293
> 
> Symptom
> -------
> 
> The consequence was that the post_ts of gettimex64, returned by PTP_SYS_OFFSET_EXTENDED, was substracted 4.29 seconds.
> As a consequence chrony rejected all readings from the PHC
> 
> Difficulty to diagnose
> ----------------------
> 
> Using cat to read the attribute value showed -3 because the format flags %d was used instead of %u, resulting in a re-interpret cast.
> 
> Fixes
> -----
> 
> 1. Using U32_MAX as initial value for PCI delays: no one is expecting an ioread to take more than 4 s
>     This will correctly compare as bigger that actual PCI delay measurements.
> 2. Fixing the sign of various format flags
> 
> Signed-off-by: Antoine Gagniere <antoine@gagniere.dev>
> ---
>   drivers/ptp/ptp_ocp.c | 32 +++++++++++++++++---------------
>   1 file changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index b651087f426f..153827722a63 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -1558,7 +1558,8 @@ ptp_ocp_watchdog(struct timer_list *t)
>   static void
>   ptp_ocp_estimate_pci_timing(struct ptp_ocp *bp)
>   {
> -	ktime_t start, end, delay = U64_MAX;
> +	ktime_t start, end;
> +	s64 delay_ns = U32_MAX; /* 4.29 seconds is high enough */
>   	u32 ctrl;
>   	int i;
>   
> @@ -1568,15 +1569,16 @@ ptp_ocp_estimate_pci_timing(struct ptp_ocp *bp)
>   
>   		iowrite32(ctrl, &bp->reg->ctrl);
>   
> -		start = ktime_get_raw_ns();
> +		start = ktime_get_raw();
>   
>   		ctrl = ioread32(&bp->reg->ctrl);
>   
> -		end = ktime_get_raw_ns();
> +		end = ktime_get_raw();
>   
> -		delay = min(delay, end - start);
> +		delay_ns = min(delay_ns, ktime_to_ns(end - start));
>   	}
> -	bp->ts_window_adjust = (delay >> 5) * 3;
> +	delay_ns = max(0, delay_ns);

I don't believe we can get a negative value from
ktime_to_ns(end - start), and that means that delay_ns will always be
positive and there is no need for the last max().

Apart from that the patch LGTM,
Thanks

> +	bp->ts_window_adjust = (delay_ns >> 5) * 3;
>   }
>   

