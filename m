Return-Path: <netdev+bounces-187018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90554AA47B3
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 11:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E1D69A8368
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 09:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D382356D9;
	Wed, 30 Apr 2025 09:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fXiVsn/S"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400F623184F
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 09:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746006869; cv=none; b=CvAO1GdfkdXtwFBcsmsAt+JSVuyIrzOkyAlBu1JpPs2EJphtVo78amhG0LdKiNn9LS9N9JiTa3lkr4HaWVYbSyd+GZJQsWJS/YsHxDToO2wgGglIt3z24GNKBuW9UjgwAjvxfEmAe0p5P0gJp3Akn3TiDNllOGKCgvXzW+wBggw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746006869; c=relaxed/simple;
	bh=OPZigiWpxwHv1lnOkpeezwZwtsRjjBDFCG5NyXPV4cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hsd3Muu0gGqQIG6NSEFcwAVyidJ3sQaXZu0GR4qTyW1gn9jP5IfL4i2epsdvcHV2F5TapAIQHtjJi6RmPp1qhaY1C6UHp2bomopK78SYxvd3qYglzcxSbUq56Yo8bmkHY8x6EeaxcjszYck2tV8WhsgEuPbik2A3FNHWJWzmQcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fXiVsn/S; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2d86bf48-6588-4051-8eb8-30bd4e1a34ca@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746006864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QbLQyfbFYW96SBXE2wDxy7CIZhwc9mKxQpduRfQsUX4=;
	b=fXiVsn/SnD01eZr6ljJuAh/mBiFOY+JikmiV1F9soSKz418wlLMGa6KUBIkhCF952LU+yZ
	RXj477ysmHZd4Fc9jb+rXKolte8iCJHTk1DfqIMQvvGGPfmn4irweA//UKh1dM9taHSMnN
	LXslZ6zPp5r21G7PndrEJ34zMWxdbUA=
Date: Wed, 30 Apr 2025 10:54:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] ptp: ocp: Fix NULL dereference in Adva board SMA sysfs
 operations
To: Sagi Maimon <maimon.sagi@gmail.com>, jonathan.lemon@gmail.com,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Sagi Maimon <sagi.maimon@adtran.com>
References: <20250429073320.33277-1-maimon.sagi@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250429073320.33277-1-maimon.sagi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 29/04/2025 08:33, Sagi Maimon wrote:
> From: Sagi Maimon <sagi.maimon@adtran.com>
> 
> On Adva boards, SMA sysfs store/get operations can call
> __handle_signal_outputs() or __handle_signal_inputs() while the `irig`
> and `dcf` pointers are uninitialized, leading to a NULL pointer
> dereference in __handle_signal() and causing a kernel crash. Adva boards
> don't use `irig` or `dcf` functionality, so add Adva-specific callbacks
> `ptp_ocp_sma_adva_set_outputs()` and `ptp_ocp_sma_adva_set_inputs()` that
> avoid invoking `irig` or `dcf` input/output routines.
> 
> Fixes: ef61f5528fca ("ptp: ocp: add Adva timecard support")
> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
> ---
> Addressed comments from Vadim Fedorenko:
>   - https://www.spinics.net/lists/kernel/msg5659845.html
> Changes since v1:
>   - Remove unused `irig` and `dcf` code.
> ---
> ---
>   drivers/ptp/ptp_ocp.c | 52 +++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 50 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index faf6e027f89a..2ccdca4f6960 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -2578,12 +2578,60 @@ static const struct ocp_sma_op ocp_fb_sma_op = {
>   	.set_output	= ptp_ocp_sma_fb_set_output,
>   };
>   
> +static int
> +ptp_ocp_sma_adva_set_output(struct ptp_ocp *bp, int sma_nr, u32 val)
> +{
> +	u32 reg, mask, shift;
> +	unsigned long flags;
> +	u32 __iomem *gpio;
> +
> +	gpio = sma_nr > 2 ? &bp->sma_map1->gpio2 : &bp->sma_map2->gpio2;
> +	shift = sma_nr & 1 ? 0 : 16;
> +
> +	mask = 0xffff << (16 - shift);
> +
> +	spin_lock_irqsave(&bp->lock, flags);
> +
> +	reg = ioread32(gpio);
> +	reg = (reg & mask) | (val << shift);
> +
> +	iowrite32(reg, gpio);
> +
> +	spin_unlock_irqrestore(&bp->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int
> +ptp_ocp_sma_adva_set_inputs(struct ptp_ocp *bp, int sma_nr, u32 val)
> +{
> +	u32 reg, mask, shift;
> +	unsigned long flags;
> +	u32 __iomem *gpio;
> +
> +	gpio = sma_nr > 2 ? &bp->sma_map2->gpio1 : &bp->sma_map1->gpio1;
> +	shift = sma_nr & 1 ? 0 : 16;
> +
> +	mask = 0xffff << (16 - shift);
> +
> +	spin_lock_irqsave(&bp->lock, flags);
> +
> +	reg = ioread32(gpio);
> +	reg = (reg & mask) | (val << shift);
> +
> +	iowrite32(reg, gpio);
> +
> +	spin_unlock_irqrestore(&bp->lock, flags);
> +
> +	return 0;
> +}
> +
>   static const struct ocp_sma_op ocp_adva_sma_op = {
>   	.tbl		= { ptp_ocp_adva_sma_in, ptp_ocp_adva_sma_out },
>   	.init		= ptp_ocp_sma_fb_init,
>   	.get		= ptp_ocp_sma_fb_get,
> -	.set_inputs	= ptp_ocp_sma_fb_set_inputs,
> -	.set_output	= ptp_ocp_sma_fb_set_output,
> +	.set_inputs	= ptp_ocp_sma_adva_set_inputs,
> +	.set_output	= ptp_ocp_sma_adva_set_output,
>   };
>   
>   static int

LGTM,
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

