Return-Path: <netdev+bounces-182665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E830A89900
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 438423AEA05
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 09:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A0028A1C7;
	Tue, 15 Apr 2025 09:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h5hpauwE"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2238424CEE4
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 09:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744711113; cv=none; b=YCGX87ToWBt94O/5diNTsoQOwYUCtsEu09Cr6WrOVPfC+X7bvFcJCqQ+kqbwQnzN6sMlLA6XEU1Jr5JqActqN84HmMAaAoWBRkUVeY6qlWzi6BWgCkmiJe57oxaaEyQpUqG4jazS7rn7B+uGSFciYHBVn4UHzjnfvSgAIt63eg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744711113; c=relaxed/simple;
	bh=t522ZdOrbY2ZzovrulLMA5ZAKzP04a7a16qPCLeS7bI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TXbUBIkQE5kVwygqOmWXh7Fg5YXt8jDFe0C8CUOnJrLUVuuK5JRdgGBxF9Og5IT8v0NTfKKYFIyC7cqc4TNLwSSdJ79iAUQdLoDDM+BQ+N/oltlj3dQpoZlnQSR+T8oME93R4JXQYvMehSvoPXgPxNlbwyfdiHk13e6Hux6ubxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h5hpauwE; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e369b3ac-c1ba-4188-bd12-391a9932ce6e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744711107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ijSP6cH4W0DMqPROu5BuHryT4DrUURvg7wkNbGI6o1w=;
	b=h5hpauwE8T3zEjK60PAzXal0LfDdgFyoIg4akb0JW2WFVIsC/1s6PHVnXhYFjXLpJy+FmC
	3pU7uLzbyUMjrGk8NknSjo0y/klhf0Mq6SkcOT1U1+YLwwskI2Hzo1gM7uXvBPwnHpckrG
	eYtOFGVnE+WOlP0mpbFcaoeLgade9Ds=
Date: Tue, 15 Apr 2025 10:58:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] ptp: ocp: fix NULL deref in __handle_s for irig/dcf
To: Sagi Maimon <maimon.sagi@gmail.com>, jonathan.lemon@gmail.com,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20250415064638.130453-1-maimon.sagi@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250415064638.130453-1-maimon.sagi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 15/04/2025 07:46, Sagi Maimon wrote:
> SMA store/get operations via sysfs can call __handle_signal_outputs
> or __handle_signal_inputs while irig and dcf pointers remain
> uninitialized. This leads to a NULL pointer dereference in
> __handle_s. Add NULL checks for irig and dcf to prevent crashes.

Ok, looks like I misread the patch previously. IRIG and DCF registers
are mapped unconditionally for OCP TimeCard. The functions you are
trying to fix are HW-specific functions which you decided to reuse for
your hardware. If your hardware doesn't support this function, you have
to implement your own HW-specific callbacks used in ocp_adva_sma_op
structure. I have to take back my Rb tag, and for this patch it's
definitely NAck.

> 
> Fixes: b286f4e87e32 ("serial: core: Move tty and serdev to be children of serial core port device")
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
> ---
> Addressed comments from Paolo Abeni:
>   - https://www.spinics.net/lists/netdev/msg1082406.html
> Changes since v1:
>   - Expanded commit message to clarify the NULL dereference scenario.
> ---
>   drivers/ptp/ptp_ocp.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 7945c6be1f7c..4e4a6f465b01 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -2434,15 +2434,19 @@ ptp_ocp_dcf_in(struct ptp_ocp *bp, bool enable)
>   static void
>   __handle_signal_outputs(struct ptp_ocp *bp, u32 val)
>   {
> -	ptp_ocp_irig_out(bp, val & 0x00100010);
> -	ptp_ocp_dcf_out(bp, val & 0x00200020);
> +	if (bp->irig_out)
> +		ptp_ocp_irig_out(bp, val & 0x00100010);
> +	if (bp->dcf_out)
> +		ptp_ocp_dcf_out(bp, val & 0x00200020);
>   }
>   
>   static void
>   __handle_signal_inputs(struct ptp_ocp *bp, u32 val)
>   {
> -	ptp_ocp_irig_in(bp, val & 0x00100010);
> -	ptp_ocp_dcf_in(bp, val & 0x00200020);
> +	if (bp->irig_out)
> +		ptp_ocp_irig_in(bp, val & 0x00100010);
> +	if (bp->dcf_out)
> +		ptp_ocp_dcf_in(bp, val & 0x00200020);
>   }
>   
>   static u32


